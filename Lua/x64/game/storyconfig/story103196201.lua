return {
	Play319621001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319621001
		arg_1_1.duration_ = 6.83

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319621002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D999"

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
				local var_4_5 = arg_1_1.bgs_.D999

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
					if iter_4_0 ~= "D999" then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_30 = 1.83333333333333
			local var_4_31 = 0.575

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_32 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_32:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_33 = arg_1_1:GetWordFromCfg(319621001)
				local var_4_34 = arg_1_1:FormatText(var_4_33.content)

				arg_1_1.text_.text = var_4_34

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_35 = 23
				local var_4_36 = utf8.len(var_4_34)
				local var_4_37 = var_4_35 <= 0 and var_4_31 or var_4_31 * (var_4_36 / var_4_35)

				if var_4_37 > 0 and var_4_31 < var_4_37 then
					arg_1_1.talkMaxDuration = var_4_37
					var_4_30 = var_4_30 + 0.3

					if var_4_37 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_30
					end
				end

				arg_1_1.text_.text = var_4_34
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_38 = var_4_30 + 0.3
			local var_4_39 = math.max(var_4_31, arg_1_1.talkMaxDuration)

			if var_4_38 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_39 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_38) / var_4_39

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319621002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319621002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play319621003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.575

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(319621002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 23
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play319621003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 319621003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play319621004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.9

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(319621003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 36
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play319621004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 319621004
		arg_16_1.duration_ = 5.37

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play319621005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1084ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["1084ui_story"].transform
			local var_19_6 = 3.36666666666667

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_5.localPosition

				local var_19_7 = "1084ui_story"

				arg_16_1:ShowWeapon(arg_16_1.var_[var_19_7 .. "Animator"].transform, false)
			end

			local var_19_8 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_8 then
				local var_19_9 = (arg_16_1.time_ - var_19_6) / var_19_8
				local var_19_10 = Vector3.New(0, -0.97, -6)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, var_19_10, var_19_9)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_5.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_5.localEulerAngles = var_19_12
			end

			if arg_16_1.time_ >= var_19_6 + var_19_8 and arg_16_1.time_ < var_19_6 + var_19_8 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_19_13 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_13.x, var_19_13.y, var_19_13.z)

				local var_19_14 = var_19_5.localEulerAngles

				var_19_14.z = 0
				var_19_14.x = 0
				var_19_5.localEulerAngles = var_19_14
			end

			local var_19_15 = arg_16_1.actors_["1084ui_story"]
			local var_19_16 = 3.36666666666667

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 and not isNil(var_19_15) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_17 = 0.200000002980232

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_17 and not isNil(var_19_15) then
				local var_19_18 = (arg_16_1.time_ - var_19_16) / var_19_17

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_15) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 and not isNil(var_19_15) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_19_19 = 3.36666666666667

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_19_20 = 3.36666666666667

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_19_21 = 2

			if var_19_21 < arg_16_1.time_ and arg_16_1.time_ <= var_19_21 + arg_19_0 then
				local var_19_22 = manager.ui.mainCamera.transform.localPosition
				local var_19_23 = Vector3.New(0, 0, 10) + Vector3.New(var_19_22.x, var_19_22.y, 0)
				local var_19_24 = arg_16_1.bgs_.D999

				var_19_24.transform.localPosition = var_19_23
				var_19_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_25 = var_19_24:GetComponent("SpriteRenderer")

				if var_19_25 and var_19_25.sprite then
					local var_19_26 = (var_19_24.transform.localPosition - var_19_22).z
					local var_19_27 = manager.ui.mainCameraCom_
					local var_19_28 = 2 * var_19_26 * Mathf.Tan(var_19_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_19_29 = var_19_28 * var_19_27.aspect
					local var_19_30 = var_19_25.sprite.bounds.size.x
					local var_19_31 = var_19_25.sprite.bounds.size.y
					local var_19_32 = var_19_29 / var_19_30
					local var_19_33 = var_19_28 / var_19_31
					local var_19_34 = var_19_33 < var_19_32 and var_19_32 or var_19_33

					var_19_24.transform.localScale = Vector3.New(var_19_34, var_19_34, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "D999" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_35 = 0

			if var_19_35 < arg_16_1.time_ and arg_16_1.time_ <= var_19_35 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_36 = 2

			if var_19_35 <= arg_16_1.time_ and arg_16_1.time_ < var_19_35 + var_19_36 then
				local var_19_37 = (arg_16_1.time_ - var_19_35) / var_19_36
				local var_19_38 = Color.New(0, 0, 0)

				var_19_38.a = Mathf.Lerp(0, 1, var_19_37)
				arg_16_1.mask_.color = var_19_38
			end

			if arg_16_1.time_ >= var_19_35 + var_19_36 and arg_16_1.time_ < var_19_35 + var_19_36 + arg_19_0 then
				local var_19_39 = Color.New(0, 0, 0)

				var_19_39.a = 1
				arg_16_1.mask_.color = var_19_39
			end

			local var_19_40 = 2

			if var_19_40 < arg_16_1.time_ and arg_16_1.time_ <= var_19_40 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_41 = 2

			if var_19_40 <= arg_16_1.time_ and arg_16_1.time_ < var_19_40 + var_19_41 then
				local var_19_42 = (arg_16_1.time_ - var_19_40) / var_19_41
				local var_19_43 = Color.New(0, 0, 0)

				var_19_43.a = Mathf.Lerp(1, 0, var_19_42)
				arg_16_1.mask_.color = var_19_43
			end

			if arg_16_1.time_ >= var_19_40 + var_19_41 and arg_16_1.time_ < var_19_40 + var_19_41 + arg_19_0 then
				local var_19_44 = Color.New(0, 0, 0)
				local var_19_45 = 0

				arg_16_1.mask_.enabled = false
				var_19_44.a = var_19_45
				arg_16_1.mask_.color = var_19_44
			end

			local var_19_46 = 0
			local var_19_47 = 0.2

			if var_19_46 < arg_16_1.time_ and arg_16_1.time_ <= var_19_46 + arg_19_0 then
				local var_19_48 = "play"
				local var_19_49 = "music"

				arg_16_1:AudioAction(var_19_48, var_19_49, "ui_battle", "ui_battle_stopbgm", "")

				local var_19_50 = ""
				local var_19_51 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_19_51 ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_51 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_51

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_51
						arg_16_1.bgmTxt2_.text = var_19_51
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_19_52 = 0.233333333333333
			local var_19_53 = 1

			if var_19_52 < arg_16_1.time_ and arg_16_1.time_ <= var_19_52 + arg_19_0 then
				local var_19_54 = "play"
				local var_19_55 = "music"

				arg_16_1:AudioAction(var_19_54, var_19_55, "bgm_activity_3_0_story_special_tallina", "bgm_activity_3_0_story_special_tallina", "bgm_activity_3_0_story_special_tallina.awb")

				local var_19_56 = ""
				local var_19_57 = manager.audio:GetAudioName("bgm_activity_3_0_story_special_tallina", "bgm_activity_3_0_story_special_tallina")

				if var_19_57 ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_57 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_57

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_57
						arg_16_1.bgmTxt2_.text = var_19_57
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_58 = 3.46666666666667
			local var_19_59 = 0.1

			if var_19_58 < arg_16_1.time_ and arg_16_1.time_ <= var_19_58 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_60 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_60:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_16_1.dialogCg_.alpha = arg_22_0
				end))
				var_19_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_61 = arg_16_1:FormatText(StoryNameCfg[6].name)

				arg_16_1.leftNameTxt_.text = var_19_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_62 = arg_16_1:GetWordFromCfg(319621004)
				local var_19_63 = arg_16_1:FormatText(var_19_62.content)

				arg_16_1.text_.text = var_19_63

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_64 = 4
				local var_19_65 = utf8.len(var_19_63)
				local var_19_66 = var_19_64 <= 0 and var_19_59 or var_19_59 * (var_19_65 / var_19_64)

				if var_19_66 > 0 and var_19_59 < var_19_66 then
					arg_16_1.talkMaxDuration = var_19_66
					var_19_58 = var_19_58 + 0.3

					if var_19_66 + var_19_58 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_66 + var_19_58
					end
				end

				arg_16_1.text_.text = var_19_63
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319621", "319621004", "story_v_out_319621.awb") ~= 0 then
					local var_19_67 = manager.audio:GetVoiceLength("story_v_out_319621", "319621004", "story_v_out_319621.awb") / 1000

					if var_19_67 + var_19_58 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_67 + var_19_58
					end

					if var_19_62.prefab_name ~= "" and arg_16_1.actors_[var_19_62.prefab_name] ~= nil then
						local var_19_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_62.prefab_name].transform, "story_v_out_319621", "319621004", "story_v_out_319621.awb")

						arg_16_1:RecordAudio("319621004", var_19_68)
						arg_16_1:RecordAudio("319621004", var_19_68)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_319621", "319621004", "story_v_out_319621.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_319621", "319621004", "story_v_out_319621.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_69 = var_19_58 + 0.3
			local var_19_70 = math.max(var_19_59, arg_16_1.talkMaxDuration)

			if var_19_69 <= arg_16_1.time_ and arg_16_1.time_ < var_19_69 + var_19_70 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_69) / var_19_70

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_69 + var_19_70 and arg_16_1.time_ < var_19_69 + var_19_70 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play319621005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 319621005
		arg_24_1.duration_ = 3.4

		local var_24_0 = {
			zh = 2.633,
			ja = 3.4
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play319621006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "10050ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "10050ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "10050ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["10050ui_story"].transform
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.var_.moveOldPos10050ui_story = var_27_5.localPosition
			end

			local var_27_7 = 0.001

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7
				local var_27_9 = Vector3.New(0.7, -0.715, -6.15)

				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10050ui_story, var_27_9, var_27_8)

				local var_27_10 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_10.x, var_27_10.y, var_27_10.z)

				local var_27_11 = var_27_5.localEulerAngles

				var_27_11.z = 0
				var_27_11.x = 0
				var_27_5.localEulerAngles = var_27_11
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(0.7, -0.715, -6.15)

				local var_27_12 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_12.x, var_27_12.y, var_27_12.z)

				local var_27_13 = var_27_5.localEulerAngles

				var_27_13.z = 0
				var_27_13.x = 0
				var_27_5.localEulerAngles = var_27_13
			end

			local var_27_14 = arg_24_1.actors_["10050ui_story"]
			local var_27_15 = 0

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 and not isNil(var_27_14) and arg_24_1.var_.characterEffect10050ui_story == nil then
				arg_24_1.var_.characterEffect10050ui_story = var_27_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_16 = 0.200000002980232

			if var_27_15 <= arg_24_1.time_ and arg_24_1.time_ < var_27_15 + var_27_16 and not isNil(var_27_14) then
				local var_27_17 = (arg_24_1.time_ - var_27_15) / var_27_16

				if arg_24_1.var_.characterEffect10050ui_story and not isNil(var_27_14) then
					arg_24_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_15 + var_27_16 and arg_24_1.time_ < var_27_15 + var_27_16 + arg_27_0 and not isNil(var_27_14) and arg_24_1.var_.characterEffect10050ui_story then
				arg_24_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_27_18 = 0

			if var_27_18 < arg_24_1.time_ and arg_24_1.time_ <= var_27_18 + arg_27_0 then
				arg_24_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			local var_27_19 = 0

			if var_27_19 < arg_24_1.time_ and arg_24_1.time_ <= var_27_19 + arg_27_0 then
				arg_24_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_27_20 = arg_24_1.actors_["1084ui_story"].transform
			local var_27_21 = 0

			if var_27_21 < arg_24_1.time_ and arg_24_1.time_ <= var_27_21 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_20.localPosition
			end

			local var_27_22 = 0.001

			if var_27_21 <= arg_24_1.time_ and arg_24_1.time_ < var_27_21 + var_27_22 then
				local var_27_23 = (arg_24_1.time_ - var_27_21) / var_27_22
				local var_27_24 = Vector3.New(-0.7, -0.97, -6)

				var_27_20.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, var_27_24, var_27_23)

				local var_27_25 = manager.ui.mainCamera.transform.position - var_27_20.position

				var_27_20.forward = Vector3.New(var_27_25.x, var_27_25.y, var_27_25.z)

				local var_27_26 = var_27_20.localEulerAngles

				var_27_26.z = 0
				var_27_26.x = 0
				var_27_20.localEulerAngles = var_27_26
			end

			if arg_24_1.time_ >= var_27_21 + var_27_22 and arg_24_1.time_ < var_27_21 + var_27_22 + arg_27_0 then
				var_27_20.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_27_27 = manager.ui.mainCamera.transform.position - var_27_20.position

				var_27_20.forward = Vector3.New(var_27_27.x, var_27_27.y, var_27_27.z)

				local var_27_28 = var_27_20.localEulerAngles

				var_27_28.z = 0
				var_27_28.x = 0
				var_27_20.localEulerAngles = var_27_28
			end

			local var_27_29 = arg_24_1.actors_["1084ui_story"]
			local var_27_30 = 0

			if var_27_30 < arg_24_1.time_ and arg_24_1.time_ <= var_27_30 + arg_27_0 and not isNil(var_27_29) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_31 = 0.200000002980232

			if var_27_30 <= arg_24_1.time_ and arg_24_1.time_ < var_27_30 + var_27_31 and not isNil(var_27_29) then
				local var_27_32 = (arg_24_1.time_ - var_27_30) / var_27_31

				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_29) then
					local var_27_33 = Mathf.Lerp(0, 0.5, var_27_32)

					arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1084ui_story.fillRatio = var_27_33
				end
			end

			if arg_24_1.time_ >= var_27_30 + var_27_31 and arg_24_1.time_ < var_27_30 + var_27_31 + arg_27_0 and not isNil(var_27_29) and arg_24_1.var_.characterEffect1084ui_story then
				local var_27_34 = 0.5

				arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1084ui_story.fillRatio = var_27_34
			end

			local var_27_35 = 0
			local var_27_36 = 0.175

			if var_27_35 < arg_24_1.time_ and arg_24_1.time_ <= var_27_35 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_37 = arg_24_1:FormatText(StoryNameCfg[692].name)

				arg_24_1.leftNameTxt_.text = var_27_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_38 = arg_24_1:GetWordFromCfg(319621005)
				local var_27_39 = arg_24_1:FormatText(var_27_38.content)

				arg_24_1.text_.text = var_27_39

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_40 = 7
				local var_27_41 = utf8.len(var_27_39)
				local var_27_42 = var_27_40 <= 0 and var_27_36 or var_27_36 * (var_27_41 / var_27_40)

				if var_27_42 > 0 and var_27_36 < var_27_42 then
					arg_24_1.talkMaxDuration = var_27_42

					if var_27_42 + var_27_35 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_42 + var_27_35
					end
				end

				arg_24_1.text_.text = var_27_39
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319621", "319621005", "story_v_out_319621.awb") ~= 0 then
					local var_27_43 = manager.audio:GetVoiceLength("story_v_out_319621", "319621005", "story_v_out_319621.awb") / 1000

					if var_27_43 + var_27_35 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_43 + var_27_35
					end

					if var_27_38.prefab_name ~= "" and arg_24_1.actors_[var_27_38.prefab_name] ~= nil then
						local var_27_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_38.prefab_name].transform, "story_v_out_319621", "319621005", "story_v_out_319621.awb")

						arg_24_1:RecordAudio("319621005", var_27_44)
						arg_24_1:RecordAudio("319621005", var_27_44)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_319621", "319621005", "story_v_out_319621.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_319621", "319621005", "story_v_out_319621.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_45 = math.max(var_27_36, arg_24_1.talkMaxDuration)

			if var_27_35 <= arg_24_1.time_ and arg_24_1.time_ < var_27_35 + var_27_45 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_35) / var_27_45

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_35 + var_27_45 and arg_24_1.time_ < var_27_35 + var_27_45 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319621006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 319621006
		arg_28_1.duration_ = 3.93

		local var_28_0 = {
			zh = 3.933,
			ja = 3.6
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play319621007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10050ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10050ui_story == nil then
				arg_28_1.var_.characterEffect10050ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect10050ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10050ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10050ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10050ui_story.fillRatio = var_31_5
			end

			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_31_7 = 0

			if var_31_7 < arg_28_1.time_ and arg_28_1.time_ <= var_31_7 + arg_31_0 then
				arg_28_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_31_8 = arg_28_1.actors_["1084ui_story"]
			local var_31_9 = 0

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 and not isNil(var_31_8) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = var_31_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_10 = 0.200000002980232

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_10 and not isNil(var_31_8) then
				local var_31_11 = (arg_28_1.time_ - var_31_9) / var_31_10

				if arg_28_1.var_.characterEffect1084ui_story and not isNil(var_31_8) then
					arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_9 + var_31_10 and arg_28_1.time_ < var_31_9 + var_31_10 + arg_31_0 and not isNil(var_31_8) and arg_28_1.var_.characterEffect1084ui_story then
				arg_28_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_31_12 = 0
			local var_31_13 = 0.45

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_14 = arg_28_1:FormatText(StoryNameCfg[6].name)

				arg_28_1.leftNameTxt_.text = var_31_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_15 = arg_28_1:GetWordFromCfg(319621006)
				local var_31_16 = arg_28_1:FormatText(var_31_15.content)

				arg_28_1.text_.text = var_31_16

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 18
				local var_31_18 = utf8.len(var_31_16)
				local var_31_19 = var_31_17 <= 0 and var_31_13 or var_31_13 * (var_31_18 / var_31_17)

				if var_31_19 > 0 and var_31_13 < var_31_19 then
					arg_28_1.talkMaxDuration = var_31_19

					if var_31_19 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_19 + var_31_12
					end
				end

				arg_28_1.text_.text = var_31_16
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319621", "319621006", "story_v_out_319621.awb") ~= 0 then
					local var_31_20 = manager.audio:GetVoiceLength("story_v_out_319621", "319621006", "story_v_out_319621.awb") / 1000

					if var_31_20 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_20 + var_31_12
					end

					if var_31_15.prefab_name ~= "" and arg_28_1.actors_[var_31_15.prefab_name] ~= nil then
						local var_31_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_15.prefab_name].transform, "story_v_out_319621", "319621006", "story_v_out_319621.awb")

						arg_28_1:RecordAudio("319621006", var_31_21)
						arg_28_1:RecordAudio("319621006", var_31_21)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_319621", "319621006", "story_v_out_319621.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_319621", "319621006", "story_v_out_319621.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_22 = math.max(var_31_13, arg_28_1.talkMaxDuration)

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_22 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_12) / var_31_22

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_12 + var_31_22 and arg_28_1.time_ < var_31_12 + var_31_22 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play319621007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 319621007
		arg_32_1.duration_ = 7.73

		local var_32_0 = {
			zh = 7.733,
			ja = 6.566
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play319621008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1084ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1084ui_story == nil then
				arg_32_1.var_.characterEffect1084ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1084ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1084ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1084ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1084ui_story.fillRatio = var_35_5
			end

			local var_35_6 = arg_32_1.actors_["10050ui_story"]
			local var_35_7 = 0

			if var_35_7 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 and not isNil(var_35_6) and arg_32_1.var_.characterEffect10050ui_story == nil then
				arg_32_1.var_.characterEffect10050ui_story = var_35_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_8 = 0.200000002980232

			if var_35_7 <= arg_32_1.time_ and arg_32_1.time_ < var_35_7 + var_35_8 and not isNil(var_35_6) then
				local var_35_9 = (arg_32_1.time_ - var_35_7) / var_35_8

				if arg_32_1.var_.characterEffect10050ui_story and not isNil(var_35_6) then
					arg_32_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_7 + var_35_8 and arg_32_1.time_ < var_35_7 + var_35_8 + arg_35_0 and not isNil(var_35_6) and arg_32_1.var_.characterEffect10050ui_story then
				arg_32_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_35_10 = 0
			local var_35_11 = 0.8

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_12 = arg_32_1:FormatText(StoryNameCfg[692].name)

				arg_32_1.leftNameTxt_.text = var_35_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_13 = arg_32_1:GetWordFromCfg(319621007)
				local var_35_14 = arg_32_1:FormatText(var_35_13.content)

				arg_32_1.text_.text = var_35_14

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 32
				local var_35_16 = utf8.len(var_35_14)
				local var_35_17 = var_35_15 <= 0 and var_35_11 or var_35_11 * (var_35_16 / var_35_15)

				if var_35_17 > 0 and var_35_11 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_10
					end
				end

				arg_32_1.text_.text = var_35_14
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319621", "319621007", "story_v_out_319621.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_319621", "319621007", "story_v_out_319621.awb") / 1000

					if var_35_18 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_10
					end

					if var_35_13.prefab_name ~= "" and arg_32_1.actors_[var_35_13.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_13.prefab_name].transform, "story_v_out_319621", "319621007", "story_v_out_319621.awb")

						arg_32_1:RecordAudio("319621007", var_35_19)
						arg_32_1:RecordAudio("319621007", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_319621", "319621007", "story_v_out_319621.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_319621", "319621007", "story_v_out_319621.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_11, arg_32_1.talkMaxDuration)

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_10) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_10 + var_35_20 and arg_32_1.time_ < var_35_10 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play319621008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 319621008
		arg_36_1.duration_ = 10

		local var_36_0 = {
			zh = 7.533,
			ja = 10
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play319621009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1084ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1084ui_story = var_39_0.localPosition
			end

			local var_39_2 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2
				local var_39_4 = Vector3.New(-0.7, -0.97, -6)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1084ui_story, var_39_4, var_39_3)

				local var_39_5 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_5.x, var_39_5.y, var_39_5.z)

				local var_39_6 = var_39_0.localEulerAngles

				var_39_6.z = 0
				var_39_6.x = 0
				var_39_0.localEulerAngles = var_39_6
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_39_7 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_7.x, var_39_7.y, var_39_7.z)

				local var_39_8 = var_39_0.localEulerAngles

				var_39_8.z = 0
				var_39_8.x = 0
				var_39_0.localEulerAngles = var_39_8
			end

			local var_39_9 = arg_36_1.actors_["1084ui_story"]
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_11 = 0.200000002980232

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 and not isNil(var_39_9) then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11

				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_9) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_39_13 = 0

			if var_39_13 < arg_36_1.time_ and arg_36_1.time_ <= var_39_13 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action437")
			end

			local var_39_14 = 0

			if var_39_14 < arg_36_1.time_ and arg_36_1.time_ <= var_39_14 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_39_15 = arg_36_1.actors_["10050ui_story"]
			local var_39_16 = 0

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 and not isNil(var_39_15) and arg_36_1.var_.characterEffect10050ui_story == nil then
				arg_36_1.var_.characterEffect10050ui_story = var_39_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_17 = 0.200000002980232

			if var_39_16 <= arg_36_1.time_ and arg_36_1.time_ < var_39_16 + var_39_17 and not isNil(var_39_15) then
				local var_39_18 = (arg_36_1.time_ - var_39_16) / var_39_17

				if arg_36_1.var_.characterEffect10050ui_story and not isNil(var_39_15) then
					local var_39_19 = Mathf.Lerp(0, 0.5, var_39_18)

					arg_36_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10050ui_story.fillRatio = var_39_19
				end
			end

			if arg_36_1.time_ >= var_39_16 + var_39_17 and arg_36_1.time_ < var_39_16 + var_39_17 + arg_39_0 and not isNil(var_39_15) and arg_36_1.var_.characterEffect10050ui_story then
				local var_39_20 = 0.5

				arg_36_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10050ui_story.fillRatio = var_39_20
			end

			local var_39_21 = 0
			local var_39_22 = 0.825

			if var_39_21 < arg_36_1.time_ and arg_36_1.time_ <= var_39_21 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_23 = arg_36_1:FormatText(StoryNameCfg[6].name)

				arg_36_1.leftNameTxt_.text = var_39_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_24 = arg_36_1:GetWordFromCfg(319621008)
				local var_39_25 = arg_36_1:FormatText(var_39_24.content)

				arg_36_1.text_.text = var_39_25

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_26 = 33
				local var_39_27 = utf8.len(var_39_25)
				local var_39_28 = var_39_26 <= 0 and var_39_22 or var_39_22 * (var_39_27 / var_39_26)

				if var_39_28 > 0 and var_39_22 < var_39_28 then
					arg_36_1.talkMaxDuration = var_39_28

					if var_39_28 + var_39_21 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_28 + var_39_21
					end
				end

				arg_36_1.text_.text = var_39_25
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319621", "319621008", "story_v_out_319621.awb") ~= 0 then
					local var_39_29 = manager.audio:GetVoiceLength("story_v_out_319621", "319621008", "story_v_out_319621.awb") / 1000

					if var_39_29 + var_39_21 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_29 + var_39_21
					end

					if var_39_24.prefab_name ~= "" and arg_36_1.actors_[var_39_24.prefab_name] ~= nil then
						local var_39_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_24.prefab_name].transform, "story_v_out_319621", "319621008", "story_v_out_319621.awb")

						arg_36_1:RecordAudio("319621008", var_39_30)
						arg_36_1:RecordAudio("319621008", var_39_30)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_319621", "319621008", "story_v_out_319621.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_319621", "319621008", "story_v_out_319621.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_31 = math.max(var_39_22, arg_36_1.talkMaxDuration)

			if var_39_21 <= arg_36_1.time_ and arg_36_1.time_ < var_39_21 + var_39_31 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_21) / var_39_31

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_21 + var_39_31 and arg_36_1.time_ < var_39_21 + var_39_31 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play319621009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 319621009
		arg_40_1.duration_ = 4

		local var_40_0 = {
			zh = 4,
			ja = 2.533
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play319621010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10050ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos10050ui_story = var_43_0.localPosition
			end

			local var_43_2 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2
				local var_43_4 = Vector3.New(0.7, -0.715, -6.15)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10050ui_story, var_43_4, var_43_3)

				local var_43_5 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_5.x, var_43_5.y, var_43_5.z)

				local var_43_6 = var_43_0.localEulerAngles

				var_43_6.z = 0
				var_43_6.x = 0
				var_43_0.localEulerAngles = var_43_6
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0.7, -0.715, -6.15)

				local var_43_7 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_7.x, var_43_7.y, var_43_7.z)

				local var_43_8 = var_43_0.localEulerAngles

				var_43_8.z = 0
				var_43_8.x = 0
				var_43_0.localEulerAngles = var_43_8
			end

			local var_43_9 = arg_40_1.actors_["10050ui_story"]
			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect10050ui_story == nil then
				arg_40_1.var_.characterEffect10050ui_story = var_43_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_11 = 0.200000002980232

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_11 and not isNil(var_43_9) then
				local var_43_12 = (arg_40_1.time_ - var_43_10) / var_43_11

				if arg_40_1.var_.characterEffect10050ui_story and not isNil(var_43_9) then
					arg_40_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_10 + var_43_11 and arg_40_1.time_ < var_43_10 + var_43_11 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect10050ui_story then
				arg_40_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_43_13 = 0

			if var_43_13 < arg_40_1.time_ and arg_40_1.time_ <= var_43_13 + arg_43_0 then
				arg_40_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_2")
			end

			local var_43_14 = 0

			if var_43_14 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 then
				arg_40_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_43_15 = arg_40_1.actors_["1084ui_story"]
			local var_43_16 = 0

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 and not isNil(var_43_15) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_17 = 0.200000002980232

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_17 and not isNil(var_43_15) then
				local var_43_18 = (arg_40_1.time_ - var_43_16) / var_43_17

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_15) then
					local var_43_19 = Mathf.Lerp(0, 0.5, var_43_18)

					arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_19
				end
			end

			if arg_40_1.time_ >= var_43_16 + var_43_17 and arg_40_1.time_ < var_43_16 + var_43_17 + arg_43_0 and not isNil(var_43_15) and arg_40_1.var_.characterEffect1084ui_story then
				local var_43_20 = 0.5

				arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_20
			end

			local var_43_21 = 0
			local var_43_22 = 0.35

			if var_43_21 < arg_40_1.time_ and arg_40_1.time_ <= var_43_21 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_23 = arg_40_1:FormatText(StoryNameCfg[692].name)

				arg_40_1.leftNameTxt_.text = var_43_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_24 = arg_40_1:GetWordFromCfg(319621009)
				local var_43_25 = arg_40_1:FormatText(var_43_24.content)

				arg_40_1.text_.text = var_43_25

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_26 = 14
				local var_43_27 = utf8.len(var_43_25)
				local var_43_28 = var_43_26 <= 0 and var_43_22 or var_43_22 * (var_43_27 / var_43_26)

				if var_43_28 > 0 and var_43_22 < var_43_28 then
					arg_40_1.talkMaxDuration = var_43_28

					if var_43_28 + var_43_21 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_28 + var_43_21
					end
				end

				arg_40_1.text_.text = var_43_25
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319621", "319621009", "story_v_out_319621.awb") ~= 0 then
					local var_43_29 = manager.audio:GetVoiceLength("story_v_out_319621", "319621009", "story_v_out_319621.awb") / 1000

					if var_43_29 + var_43_21 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_29 + var_43_21
					end

					if var_43_24.prefab_name ~= "" and arg_40_1.actors_[var_43_24.prefab_name] ~= nil then
						local var_43_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_24.prefab_name].transform, "story_v_out_319621", "319621009", "story_v_out_319621.awb")

						arg_40_1:RecordAudio("319621009", var_43_30)
						arg_40_1:RecordAudio("319621009", var_43_30)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_319621", "319621009", "story_v_out_319621.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_319621", "319621009", "story_v_out_319621.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_31 = math.max(var_43_22, arg_40_1.talkMaxDuration)

			if var_43_21 <= arg_40_1.time_ and arg_40_1.time_ < var_43_21 + var_43_31 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_21) / var_43_31

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_21 + var_43_31 and arg_40_1.time_ < var_43_21 + var_43_31 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
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
	Play319621010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 319621010
		arg_44_1.duration_ = 5.17

		local var_44_0 = {
			zh = 5.066,
			ja = 5.166
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play319621011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10050ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10050ui_story == nil then
				arg_44_1.var_.characterEffect10050ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect10050ui_story and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_44_1.var_.characterEffect10050ui_story.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10050ui_story then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_44_1.var_.characterEffect10050ui_story.fillRatio = var_47_5
			end

			local var_47_6 = arg_44_1.actors_["1084ui_story"]
			local var_47_7 = 0

			if var_47_7 < arg_44_1.time_ and arg_44_1.time_ <= var_47_7 + arg_47_0 and not isNil(var_47_6) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_8 = 0.200000002980232

			if var_47_7 <= arg_44_1.time_ and arg_44_1.time_ < var_47_7 + var_47_8 and not isNil(var_47_6) then
				local var_47_9 = (arg_44_1.time_ - var_47_7) / var_47_8

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_6) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_7 + var_47_8 and arg_44_1.time_ < var_47_7 + var_47_8 + arg_47_0 and not isNil(var_47_6) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_47_12 = 0
			local var_47_13 = 0.525

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_14 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_15 = arg_44_1:GetWordFromCfg(319621010)
				local var_47_16 = arg_44_1:FormatText(var_47_15.content)

				arg_44_1.text_.text = var_47_16

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 21
				local var_47_18 = utf8.len(var_47_16)
				local var_47_19 = var_47_17 <= 0 and var_47_13 or var_47_13 * (var_47_18 / var_47_17)

				if var_47_19 > 0 and var_47_13 < var_47_19 then
					arg_44_1.talkMaxDuration = var_47_19

					if var_47_19 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_16
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319621", "319621010", "story_v_out_319621.awb") ~= 0 then
					local var_47_20 = manager.audio:GetVoiceLength("story_v_out_319621", "319621010", "story_v_out_319621.awb") / 1000

					if var_47_20 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_20 + var_47_12
					end

					if var_47_15.prefab_name ~= "" and arg_44_1.actors_[var_47_15.prefab_name] ~= nil then
						local var_47_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_15.prefab_name].transform, "story_v_out_319621", "319621010", "story_v_out_319621.awb")

						arg_44_1:RecordAudio("319621010", var_47_21)
						arg_44_1:RecordAudio("319621010", var_47_21)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_319621", "319621010", "story_v_out_319621.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_319621", "319621010", "story_v_out_319621.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_22 and arg_44_1.time_ < var_47_12 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play319621011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319621011
		arg_48_1.duration_ = 6.63

		local var_48_0 = {
			zh = 6.633,
			ja = 6.6
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play319621012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.8

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[6].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(319621011)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_319621", "319621011", "story_v_out_319621.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_319621", "319621011", "story_v_out_319621.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_319621", "319621011", "story_v_out_319621.awb")

						arg_48_1:RecordAudio("319621011", var_51_9)
						arg_48_1:RecordAudio("319621011", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_319621", "319621011", "story_v_out_319621.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_319621", "319621011", "story_v_out_319621.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play319621012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 319621012
		arg_52_1.duration_ = 3.87

		local var_52_0 = {
			zh = 3.866,
			ja = 3.833
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play319621013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1084ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1084ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_5
			end

			local var_55_6 = arg_52_1.actors_["10050ui_story"]
			local var_55_7 = 0

			if var_55_7 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 and not isNil(var_55_6) and arg_52_1.var_.characterEffect10050ui_story == nil then
				arg_52_1.var_.characterEffect10050ui_story = var_55_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_8 = 0.200000002980232

			if var_55_7 <= arg_52_1.time_ and arg_52_1.time_ < var_55_7 + var_55_8 and not isNil(var_55_6) then
				local var_55_9 = (arg_52_1.time_ - var_55_7) / var_55_8

				if arg_52_1.var_.characterEffect10050ui_story and not isNil(var_55_6) then
					arg_52_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_7 + var_55_8 and arg_52_1.time_ < var_55_7 + var_55_8 + arg_55_0 and not isNil(var_55_6) and arg_52_1.var_.characterEffect10050ui_story then
				arg_52_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_55_10 = 0
			local var_55_11 = 0.35

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_12 = arg_52_1:FormatText(StoryNameCfg[692].name)

				arg_52_1.leftNameTxt_.text = var_55_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_13 = arg_52_1:GetWordFromCfg(319621012)
				local var_55_14 = arg_52_1:FormatText(var_55_13.content)

				arg_52_1.text_.text = var_55_14

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_15 = 14
				local var_55_16 = utf8.len(var_55_14)
				local var_55_17 = var_55_15 <= 0 and var_55_11 or var_55_11 * (var_55_16 / var_55_15)

				if var_55_17 > 0 and var_55_11 < var_55_17 then
					arg_52_1.talkMaxDuration = var_55_17

					if var_55_17 + var_55_10 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_17 + var_55_10
					end
				end

				arg_52_1.text_.text = var_55_14
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319621", "319621012", "story_v_out_319621.awb") ~= 0 then
					local var_55_18 = manager.audio:GetVoiceLength("story_v_out_319621", "319621012", "story_v_out_319621.awb") / 1000

					if var_55_18 + var_55_10 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_18 + var_55_10
					end

					if var_55_13.prefab_name ~= "" and arg_52_1.actors_[var_55_13.prefab_name] ~= nil then
						local var_55_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_13.prefab_name].transform, "story_v_out_319621", "319621012", "story_v_out_319621.awb")

						arg_52_1:RecordAudio("319621012", var_55_19)
						arg_52_1:RecordAudio("319621012", var_55_19)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_319621", "319621012", "story_v_out_319621.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_319621", "319621012", "story_v_out_319621.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_20 = math.max(var_55_11, arg_52_1.talkMaxDuration)

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_20 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_10) / var_55_20

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_10 + var_55_20 and arg_52_1.time_ < var_55_10 + var_55_20 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play319621013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 319621013
		arg_56_1.duration_ = 12.63

		local var_56_0 = {
			zh = 7.3,
			ja = 12.633
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play319621014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1084ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(-0.7, -0.97, -6)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = arg_56_1.actors_["1084ui_story"]
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.200000002980232

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 and not isNil(var_59_9) then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11

				if arg_56_1.var_.characterEffect1084ui_story and not isNil(var_59_9) then
					arg_56_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1084ui_story then
				arg_56_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_59_13 = 0

			if var_59_13 < arg_56_1.time_ and arg_56_1.time_ <= var_59_13 + arg_59_0 then
				arg_56_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_59_14 = 0

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				arg_56_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_59_15 = arg_56_1.actors_["10050ui_story"]
			local var_59_16 = 0

			if var_59_16 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 and not isNil(var_59_15) and arg_56_1.var_.characterEffect10050ui_story == nil then
				arg_56_1.var_.characterEffect10050ui_story = var_59_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_17 = 0.200000002980232

			if var_59_16 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_17 and not isNil(var_59_15) then
				local var_59_18 = (arg_56_1.time_ - var_59_16) / var_59_17

				if arg_56_1.var_.characterEffect10050ui_story and not isNil(var_59_15) then
					local var_59_19 = Mathf.Lerp(0, 0.5, var_59_18)

					arg_56_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10050ui_story.fillRatio = var_59_19
				end
			end

			if arg_56_1.time_ >= var_59_16 + var_59_17 and arg_56_1.time_ < var_59_16 + var_59_17 + arg_59_0 and not isNil(var_59_15) and arg_56_1.var_.characterEffect10050ui_story then
				local var_59_20 = 0.5

				arg_56_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10050ui_story.fillRatio = var_59_20
			end

			local var_59_21 = 0
			local var_59_22 = 0.775

			if var_59_21 < arg_56_1.time_ and arg_56_1.time_ <= var_59_21 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_23 = arg_56_1:FormatText(StoryNameCfg[6].name)

				arg_56_1.leftNameTxt_.text = var_59_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_24 = arg_56_1:GetWordFromCfg(319621013)
				local var_59_25 = arg_56_1:FormatText(var_59_24.content)

				arg_56_1.text_.text = var_59_25

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_26 = 31
				local var_59_27 = utf8.len(var_59_25)
				local var_59_28 = var_59_26 <= 0 and var_59_22 or var_59_22 * (var_59_27 / var_59_26)

				if var_59_28 > 0 and var_59_22 < var_59_28 then
					arg_56_1.talkMaxDuration = var_59_28

					if var_59_28 + var_59_21 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_28 + var_59_21
					end
				end

				arg_56_1.text_.text = var_59_25
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319621", "319621013", "story_v_out_319621.awb") ~= 0 then
					local var_59_29 = manager.audio:GetVoiceLength("story_v_out_319621", "319621013", "story_v_out_319621.awb") / 1000

					if var_59_29 + var_59_21 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_29 + var_59_21
					end

					if var_59_24.prefab_name ~= "" and arg_56_1.actors_[var_59_24.prefab_name] ~= nil then
						local var_59_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_24.prefab_name].transform, "story_v_out_319621", "319621013", "story_v_out_319621.awb")

						arg_56_1:RecordAudio("319621013", var_59_30)
						arg_56_1:RecordAudio("319621013", var_59_30)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_319621", "319621013", "story_v_out_319621.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_319621", "319621013", "story_v_out_319621.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_31 = math.max(var_59_22, arg_56_1.talkMaxDuration)

			if var_59_21 <= arg_56_1.time_ and arg_56_1.time_ < var_59_21 + var_59_31 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_21) / var_59_31

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_21 + var_59_31 and arg_56_1.time_ < var_59_21 + var_59_31 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play319621014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 319621014
		arg_60_1.duration_ = 2.27

		local var_60_0 = {
			zh = 1.999999999999,
			ja = 2.266
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
				arg_60_0:Play319621015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10050ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos10050ui_story = var_63_0.localPosition
			end

			local var_63_2 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2
				local var_63_4 = Vector3.New(0.7, -0.715, -6.15)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10050ui_story, var_63_4, var_63_3)

				local var_63_5 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_5.x, var_63_5.y, var_63_5.z)

				local var_63_6 = var_63_0.localEulerAngles

				var_63_6.z = 0
				var_63_6.x = 0
				var_63_0.localEulerAngles = var_63_6
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0.7, -0.715, -6.15)

				local var_63_7 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_7.x, var_63_7.y, var_63_7.z)

				local var_63_8 = var_63_0.localEulerAngles

				var_63_8.z = 0
				var_63_8.x = 0
				var_63_0.localEulerAngles = var_63_8
			end

			local var_63_9 = arg_60_1.actors_["10050ui_story"]
			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect10050ui_story == nil then
				arg_60_1.var_.characterEffect10050ui_story = var_63_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_11 = 0.200000002980232

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_11 and not isNil(var_63_9) then
				local var_63_12 = (arg_60_1.time_ - var_63_10) / var_63_11

				if arg_60_1.var_.characterEffect10050ui_story and not isNil(var_63_9) then
					arg_60_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_10 + var_63_11 and arg_60_1.time_ < var_63_10 + var_63_11 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect10050ui_story then
				arg_60_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_63_13 = 0

			if var_63_13 < arg_60_1.time_ and arg_60_1.time_ <= var_63_13 + arg_63_0 then
				arg_60_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_63_14 = arg_60_1.actors_["1084ui_story"]
			local var_63_15 = 0

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 and not isNil(var_63_14) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = var_63_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_16 = 0.200000002980232

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_16 and not isNil(var_63_14) then
				local var_63_17 = (arg_60_1.time_ - var_63_15) / var_63_16

				if arg_60_1.var_.characterEffect1084ui_story and not isNil(var_63_14) then
					local var_63_18 = Mathf.Lerp(0, 0.5, var_63_17)

					arg_60_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1084ui_story.fillRatio = var_63_18
				end
			end

			if arg_60_1.time_ >= var_63_15 + var_63_16 and arg_60_1.time_ < var_63_15 + var_63_16 + arg_63_0 and not isNil(var_63_14) and arg_60_1.var_.characterEffect1084ui_story then
				local var_63_19 = 0.5

				arg_60_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1084ui_story.fillRatio = var_63_19
			end

			local var_63_20 = 0
			local var_63_21 = 0.1

			if var_63_20 < arg_60_1.time_ and arg_60_1.time_ <= var_63_20 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_22 = arg_60_1:FormatText(StoryNameCfg[692].name)

				arg_60_1.leftNameTxt_.text = var_63_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_23 = arg_60_1:GetWordFromCfg(319621014)
				local var_63_24 = arg_60_1:FormatText(var_63_23.content)

				arg_60_1.text_.text = var_63_24

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_25 = 4
				local var_63_26 = utf8.len(var_63_24)
				local var_63_27 = var_63_25 <= 0 and var_63_21 or var_63_21 * (var_63_26 / var_63_25)

				if var_63_27 > 0 and var_63_21 < var_63_27 then
					arg_60_1.talkMaxDuration = var_63_27

					if var_63_27 + var_63_20 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_27 + var_63_20
					end
				end

				arg_60_1.text_.text = var_63_24
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319621", "319621014", "story_v_out_319621.awb") ~= 0 then
					local var_63_28 = manager.audio:GetVoiceLength("story_v_out_319621", "319621014", "story_v_out_319621.awb") / 1000

					if var_63_28 + var_63_20 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_28 + var_63_20
					end

					if var_63_23.prefab_name ~= "" and arg_60_1.actors_[var_63_23.prefab_name] ~= nil then
						local var_63_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_23.prefab_name].transform, "story_v_out_319621", "319621014", "story_v_out_319621.awb")

						arg_60_1:RecordAudio("319621014", var_63_29)
						arg_60_1:RecordAudio("319621014", var_63_29)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_319621", "319621014", "story_v_out_319621.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_319621", "319621014", "story_v_out_319621.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_30 = math.max(var_63_21, arg_60_1.talkMaxDuration)

			if var_63_20 <= arg_60_1.time_ and arg_60_1.time_ < var_63_20 + var_63_30 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_20) / var_63_30

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_20 + var_63_30 and arg_60_1.time_ < var_63_20 + var_63_30 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
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
	Play319621015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 319621015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play319621016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10050ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10050ui_story == nil then
				arg_64_1.var_.characterEffect10050ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect10050ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10050ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10050ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10050ui_story.fillRatio = var_67_5
			end

			local var_67_6 = 0
			local var_67_7 = 0.875

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_8 = arg_64_1:GetWordFromCfg(319621015)
				local var_67_9 = arg_64_1:FormatText(var_67_8.content)

				arg_64_1.text_.text = var_67_9

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_10 = 35
				local var_67_11 = utf8.len(var_67_9)
				local var_67_12 = var_67_10 <= 0 and var_67_7 or var_67_7 * (var_67_11 / var_67_10)

				if var_67_12 > 0 and var_67_7 < var_67_12 then
					arg_64_1.talkMaxDuration = var_67_12

					if var_67_12 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_12 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_9
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_13 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_13 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_13

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_13 and arg_64_1.time_ < var_67_6 + var_67_13 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play319621016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 319621016
		arg_68_1.duration_ = 5.87

		local var_68_0 = {
			zh = 5.866,
			ja = 5.4
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
				arg_68_0:Play319621017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10050ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10050ui_story == nil then
				arg_68_1.var_.characterEffect10050ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect10050ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10050ui_story then
				arg_68_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_71_4 = 0

			if var_71_4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_1")
			end

			local var_71_5 = 0
			local var_71_6 = 0.475

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_7 = arg_68_1:FormatText(StoryNameCfg[692].name)

				arg_68_1.leftNameTxt_.text = var_71_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_8 = arg_68_1:GetWordFromCfg(319621016)
				local var_71_9 = arg_68_1:FormatText(var_71_8.content)

				arg_68_1.text_.text = var_71_9

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_10 = 19
				local var_71_11 = utf8.len(var_71_9)
				local var_71_12 = var_71_10 <= 0 and var_71_6 or var_71_6 * (var_71_11 / var_71_10)

				if var_71_12 > 0 and var_71_6 < var_71_12 then
					arg_68_1.talkMaxDuration = var_71_12

					if var_71_12 + var_71_5 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_12 + var_71_5
					end
				end

				arg_68_1.text_.text = var_71_9
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319621", "319621016", "story_v_out_319621.awb") ~= 0 then
					local var_71_13 = manager.audio:GetVoiceLength("story_v_out_319621", "319621016", "story_v_out_319621.awb") / 1000

					if var_71_13 + var_71_5 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_5
					end

					if var_71_8.prefab_name ~= "" and arg_68_1.actors_[var_71_8.prefab_name] ~= nil then
						local var_71_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_8.prefab_name].transform, "story_v_out_319621", "319621016", "story_v_out_319621.awb")

						arg_68_1:RecordAudio("319621016", var_71_14)
						arg_68_1:RecordAudio("319621016", var_71_14)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_319621", "319621016", "story_v_out_319621.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_319621", "319621016", "story_v_out_319621.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_15 = math.max(var_71_6, arg_68_1.talkMaxDuration)

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_15 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_5) / var_71_15

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_5 + var_71_15 and arg_68_1.time_ < var_71_5 + var_71_15 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play319621017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 319621017
		arg_72_1.duration_ = 6.73

		local var_72_0 = {
			zh = 4.7,
			ja = 6.733
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
				arg_72_0:Play319621018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.375

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[692].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:GetWordFromCfg(319621017)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 15
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319621", "319621017", "story_v_out_319621.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_319621", "319621017", "story_v_out_319621.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_319621", "319621017", "story_v_out_319621.awb")

						arg_72_1:RecordAudio("319621017", var_75_9)
						arg_72_1:RecordAudio("319621017", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_319621", "319621017", "story_v_out_319621.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_319621", "319621017", "story_v_out_319621.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_10 and arg_72_1.time_ < var_75_0 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play319621018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319621018
		arg_76_1.duration_ = 5.77

		local var_76_0 = {
			zh = 4.533,
			ja = 5.766
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play319621019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10050ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos10050ui_story = var_79_0.localPosition
			end

			local var_79_2 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2
				local var_79_4 = Vector3.New(0.7, -0.715, -6.15)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10050ui_story, var_79_4, var_79_3)

				local var_79_5 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_5.x, var_79_5.y, var_79_5.z)

				local var_79_6 = var_79_0.localEulerAngles

				var_79_6.z = 0
				var_79_6.x = 0
				var_79_0.localEulerAngles = var_79_6
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0.7, -0.715, -6.15)

				local var_79_7 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_7.x, var_79_7.y, var_79_7.z)

				local var_79_8 = var_79_0.localEulerAngles

				var_79_8.z = 0
				var_79_8.x = 0
				var_79_0.localEulerAngles = var_79_8
			end

			local var_79_9 = 0

			if var_79_9 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 then
				arg_76_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_2")
			end

			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_79_11 = 0
			local var_79_12 = 0.325

			if var_79_11 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_13 = arg_76_1:FormatText(StoryNameCfg[692].name)

				arg_76_1.leftNameTxt_.text = var_79_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_14 = arg_76_1:GetWordFromCfg(319621018)
				local var_79_15 = arg_76_1:FormatText(var_79_14.content)

				arg_76_1.text_.text = var_79_15

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_16 = 13
				local var_79_17 = utf8.len(var_79_15)
				local var_79_18 = var_79_16 <= 0 and var_79_12 or var_79_12 * (var_79_17 / var_79_16)

				if var_79_18 > 0 and var_79_12 < var_79_18 then
					arg_76_1.talkMaxDuration = var_79_18

					if var_79_18 + var_79_11 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_18 + var_79_11
					end
				end

				arg_76_1.text_.text = var_79_15
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319621", "319621018", "story_v_out_319621.awb") ~= 0 then
					local var_79_19 = manager.audio:GetVoiceLength("story_v_out_319621", "319621018", "story_v_out_319621.awb") / 1000

					if var_79_19 + var_79_11 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_19 + var_79_11
					end

					if var_79_14.prefab_name ~= "" and arg_76_1.actors_[var_79_14.prefab_name] ~= nil then
						local var_79_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_14.prefab_name].transform, "story_v_out_319621", "319621018", "story_v_out_319621.awb")

						arg_76_1:RecordAudio("319621018", var_79_20)
						arg_76_1:RecordAudio("319621018", var_79_20)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_319621", "319621018", "story_v_out_319621.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_319621", "319621018", "story_v_out_319621.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_21 = math.max(var_79_12, arg_76_1.talkMaxDuration)

			if var_79_11 <= arg_76_1.time_ and arg_76_1.time_ < var_79_11 + var_79_21 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_11) / var_79_21

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_11 + var_79_21 and arg_76_1.time_ < var_79_11 + var_79_21 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
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
	Play319621019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319621019
		arg_80_1.duration_ = 8.6

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play319621020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10050ui_story"].transform
			local var_83_1 = 2

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos10050ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(0, 100, 0)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10050ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, 100, 0)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = arg_80_1.actors_["1084ui_story"].transform
			local var_83_10 = 2

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.var_.moveOldPos1084ui_story = var_83_9.localPosition
			end

			local var_83_11 = 0.001

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_11 then
				local var_83_12 = (arg_80_1.time_ - var_83_10) / var_83_11
				local var_83_13 = Vector3.New(0, 100, 0)

				var_83_9.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1084ui_story, var_83_13, var_83_12)

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

			local var_83_18 = 0

			if var_83_18 < arg_80_1.time_ and arg_80_1.time_ <= var_83_18 + arg_83_0 then
				local var_83_19 = manager.ui.mainCamera.transform.localPosition
				local var_83_20 = Vector3.New(0, 0, 10) + Vector3.New(var_83_19.x, var_83_19.y, 0)
				local var_83_21 = arg_80_1.bgs_.D999

				var_83_21.transform.localPosition = var_83_20
				var_83_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_83_22 = var_83_21:GetComponent("SpriteRenderer")

				if var_83_22 and var_83_22.sprite then
					local var_83_23 = (var_83_21.transform.localPosition - var_83_19).z
					local var_83_24 = manager.ui.mainCameraCom_
					local var_83_25 = 2 * var_83_23 * Mathf.Tan(var_83_24.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_83_26 = var_83_25 * var_83_24.aspect
					local var_83_27 = var_83_22.sprite.bounds.size.x
					local var_83_28 = var_83_22.sprite.bounds.size.y
					local var_83_29 = var_83_26 / var_83_27
					local var_83_30 = var_83_25 / var_83_28
					local var_83_31 = var_83_30 < var_83_29 and var_83_29 or var_83_30

					var_83_21.transform.localScale = Vector3.New(var_83_31, var_83_31, 0)
				end

				for iter_83_0, iter_83_1 in pairs(arg_80_1.bgs_) do
					if iter_83_0 ~= "D999" then
						iter_83_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_83_32 = 2

			if var_83_32 < arg_80_1.time_ and arg_80_1.time_ <= var_83_32 + arg_83_0 then
				local var_83_33 = manager.ui.mainCamera.transform.localPosition
				local var_83_34 = Vector3.New(0, 0, 10) + Vector3.New(var_83_33.x, var_83_33.y, 0)
				local var_83_35 = arg_80_1.bgs_.D999

				var_83_35.transform.localPosition = var_83_34
				var_83_35.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_83_36 = var_83_35:GetComponent("SpriteRenderer")

				if var_83_36 and var_83_36.sprite then
					local var_83_37 = (var_83_35.transform.localPosition - var_83_33).z
					local var_83_38 = manager.ui.mainCameraCom_
					local var_83_39 = 2 * var_83_37 * Mathf.Tan(var_83_38.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_83_40 = var_83_39 * var_83_38.aspect
					local var_83_41 = var_83_36.sprite.bounds.size.x
					local var_83_42 = var_83_36.sprite.bounds.size.y
					local var_83_43 = var_83_40 / var_83_41
					local var_83_44 = var_83_39 / var_83_42
					local var_83_45 = var_83_44 < var_83_43 and var_83_43 or var_83_44

					var_83_35.transform.localScale = Vector3.New(var_83_45, var_83_45, 0)
				end

				for iter_83_2, iter_83_3 in pairs(arg_80_1.bgs_) do
					if iter_83_2 ~= "D999" then
						iter_83_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_83_46 = 0

			if var_83_46 < arg_80_1.time_ and arg_80_1.time_ <= var_83_46 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_47 = 2

			if var_83_46 <= arg_80_1.time_ and arg_80_1.time_ < var_83_46 + var_83_47 then
				local var_83_48 = (arg_80_1.time_ - var_83_46) / var_83_47
				local var_83_49 = Color.New(0, 0, 0)

				var_83_49.a = Mathf.Lerp(0, 1, var_83_48)
				arg_80_1.mask_.color = var_83_49
			end

			if arg_80_1.time_ >= var_83_46 + var_83_47 and arg_80_1.time_ < var_83_46 + var_83_47 + arg_83_0 then
				local var_83_50 = Color.New(0, 0, 0)

				var_83_50.a = 1
				arg_80_1.mask_.color = var_83_50
			end

			local var_83_51 = 2

			if var_83_51 < arg_80_1.time_ and arg_80_1.time_ <= var_83_51 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_52 = 2

			if var_83_51 <= arg_80_1.time_ and arg_80_1.time_ < var_83_51 + var_83_52 then
				local var_83_53 = (arg_80_1.time_ - var_83_51) / var_83_52
				local var_83_54 = Color.New(0, 0, 0)

				var_83_54.a = Mathf.Lerp(1, 0, var_83_53)
				arg_80_1.mask_.color = var_83_54
			end

			if arg_80_1.time_ >= var_83_51 + var_83_52 and arg_80_1.time_ < var_83_51 + var_83_52 + arg_83_0 then
				local var_83_55 = Color.New(0, 0, 0)
				local var_83_56 = 0

				arg_80_1.mask_.enabled = false
				var_83_55.a = var_83_56
				arg_80_1.mask_.color = var_83_55
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_57 = 3.6
			local var_83_58 = 0.925

			if var_83_57 < arg_80_1.time_ and arg_80_1.time_ <= var_83_57 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_59 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_59:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_60 = arg_80_1:GetWordFromCfg(319621019)
				local var_83_61 = arg_80_1:FormatText(var_83_60.content)

				arg_80_1.text_.text = var_83_61

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_62 = 37
				local var_83_63 = utf8.len(var_83_61)
				local var_83_64 = var_83_62 <= 0 and var_83_58 or var_83_58 * (var_83_63 / var_83_62)

				if var_83_64 > 0 and var_83_58 < var_83_64 then
					arg_80_1.talkMaxDuration = var_83_64
					var_83_57 = var_83_57 + 0.3

					if var_83_64 + var_83_57 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_64 + var_83_57
					end
				end

				arg_80_1.text_.text = var_83_61
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_65 = var_83_57 + 0.3
			local var_83_66 = math.max(var_83_58, arg_80_1.talkMaxDuration)

			if var_83_65 <= arg_80_1.time_ and arg_80_1.time_ < var_83_65 + var_83_66 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_65) / var_83_66

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_65 + var_83_66 and arg_80_1.time_ < var_83_65 + var_83_66 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play319621020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 319621020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play319621021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 1

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_2 = arg_86_1:GetWordFromCfg(319621020)
				local var_89_3 = arg_86_1:FormatText(var_89_2.content)

				arg_86_1.text_.text = var_89_3

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 40
				local var_89_5 = utf8.len(var_89_3)
				local var_89_6 = var_89_4 <= 0 and var_89_1 or var_89_1 * (var_89_5 / var_89_4)

				if var_89_6 > 0 and var_89_1 < var_89_6 then
					arg_86_1.talkMaxDuration = var_89_6

					if var_89_6 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_6 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_3
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_7 and arg_86_1.time_ < var_89_0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play319621021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 319621021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
			arg_90_1.auto_ = false
		end

		function arg_90_1.playNext_(arg_92_0)
			arg_90_1.onStoryFinished_()
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.625

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

				local var_93_2 = arg_90_1:GetWordFromCfg(319621021)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 25
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
	assets = {
		"TextureConfig/Background/D999"
	},
	voices = {
		"story_v_out_319621.awb"
	}
}
