return {
	Play111092001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111092001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111092002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D06a"

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
				local var_4_5 = arg_1_1.bgs_.D06a

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
					if iter_4_0 ~= "D06a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.D06a
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueD06a = var_4_18.color.a
					arg_1_1.var_.alphaMatValueD06a = var_4_18
				end

				arg_1_1.var_.alphaOldValueD06a = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueD06a, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueD06a then
					local var_4_22 = arg_1_1.var_.alphaMatValueD06a.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueD06a.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueD06a then
				local var_4_23 = arg_1_1.var_.alphaMatValueD06a
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_26 = 2

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_27 = 0
			local var_4_28 = 1

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				local var_4_29 = "play"
				local var_4_30 = "music"

				arg_1_1:AudioAction(var_4_29, var_4_30, "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story.awb")

				local var_4_31 = ""
				local var_4_32 = manager.audio:GetAudioName("bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story")

				if var_4_32 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_32 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_32

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_32
						arg_1_1.bgmTxt2_.text = var_4_32
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

			local var_4_33 = 2
			local var_4_34 = 0.45

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_35 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_35:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_36 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_37 = arg_1_1:GetWordFromCfg(111092001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 18
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_34 or var_4_34 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_34 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_33 = var_4_33 + 0.3

					if var_4_41 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_33 + 0.3
			local var_4_43 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111092002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111092002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play111092003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.075

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

				local var_11_2 = arg_8_1:GetWordFromCfg(111092002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 43
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
	Play111092003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111092003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play111092004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.05

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

				local var_15_2 = arg_12_1:GetWordFromCfg(111092003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 42
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
	Play111092004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111092004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play111092005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.425

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[7].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(111092004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 18
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_8 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_8 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_8

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_8 and arg_16_1.time_ < var_19_0 + var_19_8 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play111092005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 111092005
		arg_20_1.duration_ = 2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play111092006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1094ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "1094ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_20_1.stage_.transform)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

					var_23_3.enabled = true

					local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

					if var_23_4 then
						var_23_4:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_3.transform, false)

					arg_20_1.var_[var_23_0 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_0 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_0 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_5 = arg_20_1.actors_["1094ui_story"].transform
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.var_.moveOldPos1094ui_story = var_23_5.localPosition
			end

			local var_23_7 = 0.001

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7
				local var_23_9 = Vector3.New(0, -0.84, -6.1)

				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1094ui_story, var_23_9, var_23_8)

				local var_23_10 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_10.x, var_23_10.y, var_23_10.z)

				local var_23_11 = var_23_5.localEulerAngles

				var_23_11.z = 0
				var_23_11.x = 0
				var_23_5.localEulerAngles = var_23_11
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_23_12 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_12.x, var_23_12.y, var_23_12.z)

				local var_23_13 = var_23_5.localEulerAngles

				var_23_13.z = 0
				var_23_13.x = 0
				var_23_5.localEulerAngles = var_23_13
			end

			local var_23_14 = 0

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_23_15 = 0

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_23_16 = arg_20_1.actors_["1094ui_story"]
			local var_23_17 = 0

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 and not isNil(var_23_16) and arg_20_1.var_.characterEffect1094ui_story == nil then
				arg_20_1.var_.characterEffect1094ui_story = var_23_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_18 = 0.2

			if var_23_17 <= arg_20_1.time_ and arg_20_1.time_ < var_23_17 + var_23_18 and not isNil(var_23_16) then
				local var_23_19 = (arg_20_1.time_ - var_23_17) / var_23_18

				if arg_20_1.var_.characterEffect1094ui_story and not isNil(var_23_16) then
					arg_20_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_17 + var_23_18 and arg_20_1.time_ < var_23_17 + var_23_18 + arg_23_0 and not isNil(var_23_16) and arg_20_1.var_.characterEffect1094ui_story then
				arg_20_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_23_20 = 0
			local var_23_21 = 0.05

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_22 = arg_20_1:FormatText(StoryNameCfg[181].name)

				arg_20_1.leftNameTxt_.text = var_23_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_23 = arg_20_1:GetWordFromCfg(111092005)
				local var_23_24 = arg_20_1:FormatText(var_23_23.content)

				arg_20_1.text_.text = var_23_24

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_25 = 2
				local var_23_26 = utf8.len(var_23_24)
				local var_23_27 = var_23_25 <= 0 and var_23_21 or var_23_21 * (var_23_26 / var_23_25)

				if var_23_27 > 0 and var_23_21 < var_23_27 then
					arg_20_1.talkMaxDuration = var_23_27

					if var_23_27 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_27 + var_23_20
					end
				end

				arg_20_1.text_.text = var_23_24
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092005", "story_v_out_111092.awb") ~= 0 then
					local var_23_28 = manager.audio:GetVoiceLength("story_v_out_111092", "111092005", "story_v_out_111092.awb") / 1000

					if var_23_28 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_28 + var_23_20
					end

					if var_23_23.prefab_name ~= "" and arg_20_1.actors_[var_23_23.prefab_name] ~= nil then
						local var_23_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_23.prefab_name].transform, "story_v_out_111092", "111092005", "story_v_out_111092.awb")

						arg_20_1:RecordAudio("111092005", var_23_29)
						arg_20_1:RecordAudio("111092005", var_23_29)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_111092", "111092005", "story_v_out_111092.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_111092", "111092005", "story_v_out_111092.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_30 = math.max(var_23_21, arg_20_1.talkMaxDuration)

			if var_23_20 <= arg_20_1.time_ and arg_20_1.time_ < var_23_20 + var_23_30 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_20) / var_23_30

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_20 + var_23_30 and arg_20_1.time_ < var_23_20 + var_23_30 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play111092006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 111092006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play111092007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1094ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1094ui_story == nil then
				arg_24_1.var_.characterEffect1094ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1094ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1094ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1094ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1094ui_story.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 0.6

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_8 = arg_24_1:GetWordFromCfg(111092006)
				local var_27_9 = arg_24_1:FormatText(var_27_8.content)

				arg_24_1.text_.text = var_27_9

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_10 = 24
				local var_27_11 = utf8.len(var_27_9)
				local var_27_12 = var_27_10 <= 0 and var_27_7 or var_27_7 * (var_27_11 / var_27_10)

				if var_27_12 > 0 and var_27_7 < var_27_12 then
					arg_24_1.talkMaxDuration = var_27_12

					if var_27_12 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_9
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_13 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_13 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_13

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_13 and arg_24_1.time_ < var_27_6 + var_27_13 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play111092007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 111092007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play111092008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.4

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[7].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(111092007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 16
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_8 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_8 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_8

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_8 and arg_28_1.time_ < var_31_0 + var_31_8 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play111092008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 111092008
		arg_32_1.duration_ = 2.3

		local var_32_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.3,
			en = 1.999999999999
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
				arg_32_0:Play111092009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_35_1 = arg_32_1.actors_["1094ui_story"]
			local var_35_2 = 0

			if var_35_2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1094ui_story == nil then
				arg_32_1.var_.characterEffect1094ui_story = var_35_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.2

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_3 and not isNil(var_35_1) then
				local var_35_4 = (arg_32_1.time_ - var_35_2) / var_35_3

				if arg_32_1.var_.characterEffect1094ui_story and not isNil(var_35_1) then
					arg_32_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_2 + var_35_3 and arg_32_1.time_ < var_35_2 + var_35_3 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1094ui_story then
				arg_32_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_35_5 = 0
			local var_35_6 = 0.075

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_7 = arg_32_1:FormatText(StoryNameCfg[181].name)

				arg_32_1.leftNameTxt_.text = var_35_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_8 = arg_32_1:GetWordFromCfg(111092008)
				local var_35_9 = arg_32_1:FormatText(var_35_8.content)

				arg_32_1.text_.text = var_35_9

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_10 = 3
				local var_35_11 = utf8.len(var_35_9)
				local var_35_12 = var_35_10 <= 0 and var_35_6 or var_35_6 * (var_35_11 / var_35_10)

				if var_35_12 > 0 and var_35_6 < var_35_12 then
					arg_32_1.talkMaxDuration = var_35_12

					if var_35_12 + var_35_5 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_5
					end
				end

				arg_32_1.text_.text = var_35_9
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092008", "story_v_out_111092.awb") ~= 0 then
					local var_35_13 = manager.audio:GetVoiceLength("story_v_out_111092", "111092008", "story_v_out_111092.awb") / 1000

					if var_35_13 + var_35_5 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_5
					end

					if var_35_8.prefab_name ~= "" and arg_32_1.actors_[var_35_8.prefab_name] ~= nil then
						local var_35_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_8.prefab_name].transform, "story_v_out_111092", "111092008", "story_v_out_111092.awb")

						arg_32_1:RecordAudio("111092008", var_35_14)
						arg_32_1:RecordAudio("111092008", var_35_14)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_111092", "111092008", "story_v_out_111092.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_111092", "111092008", "story_v_out_111092.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_15 = math.max(var_35_6, arg_32_1.talkMaxDuration)

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_15 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_5) / var_35_15

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_5 + var_35_15 and arg_32_1.time_ < var_35_5 + var_35_15 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play111092009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111092009
		arg_36_1.duration_ = 4.57

		local var_36_0 = {
			ja = 4.566,
			ko = 2.866,
			zh = 3.8,
			en = 3.166
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
				arg_36_0:Play111092010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action435")
			end

			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_39_2 = arg_36_1.actors_["1094ui_story"]
			local var_39_3 = 0

			if var_39_3 < arg_36_1.time_ and arg_36_1.time_ <= var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1094ui_story == nil then
				arg_36_1.var_.characterEffect1094ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_4 = 0.2

			if var_39_3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_3 + var_39_4 and not isNil(var_39_2) then
				local var_39_5 = (arg_36_1.time_ - var_39_3) / var_39_4

				if arg_36_1.var_.characterEffect1094ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_3 + var_39_4 and arg_36_1.time_ < var_39_3 + var_39_4 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1094ui_story then
				arg_36_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_39_6 = 0
			local var_39_7 = 0.225

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[181].name)

				arg_36_1.leftNameTxt_.text = var_39_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_9 = arg_36_1:GetWordFromCfg(111092009)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 9
				local var_39_12 = utf8.len(var_39_10)
				local var_39_13 = var_39_11 <= 0 and var_39_7 or var_39_7 * (var_39_12 / var_39_11)

				if var_39_13 > 0 and var_39_7 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092009", "story_v_out_111092.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_out_111092", "111092009", "story_v_out_111092.awb") / 1000

					if var_39_14 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_6
					end

					if var_39_9.prefab_name ~= "" and arg_36_1.actors_[var_39_9.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_9.prefab_name].transform, "story_v_out_111092", "111092009", "story_v_out_111092.awb")

						arg_36_1:RecordAudio("111092009", var_39_15)
						arg_36_1:RecordAudio("111092009", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_111092", "111092009", "story_v_out_111092.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_111092", "111092009", "story_v_out_111092.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_16 and arg_36_1.time_ < var_39_6 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play111092010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111092010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play111092011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1094ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1094ui_story == nil then
				arg_40_1.var_.characterEffect1094ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1094ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1094ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1094ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1094ui_story.fillRatio = var_43_5
			end

			local var_43_6 = 0
			local var_43_7 = 0.225

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_9 = arg_40_1:GetWordFromCfg(111092010)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 9
				local var_43_12 = utf8.len(var_43_10)
				local var_43_13 = var_43_11 <= 0 and var_43_7 or var_43_7 * (var_43_12 / var_43_11)

				if var_43_13 > 0 and var_43_7 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_14 and arg_40_1.time_ < var_43_6 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play111092011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 111092011
		arg_44_1.duration_ = 13.33

		local var_44_0 = {
			ja = 10.366,
			ko = 10.066,
			zh = 13.333,
			en = 10.7
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
				arg_44_0:Play111092012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_47_1 = arg_44_1.actors_["1094ui_story"]
			local var_47_2 = 0

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1094ui_story == nil then
				arg_44_1.var_.characterEffect1094ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.2

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_3 and not isNil(var_47_1) then
				local var_47_4 = (arg_44_1.time_ - var_47_2) / var_47_3

				if arg_44_1.var_.characterEffect1094ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_2 + var_47_3 and arg_44_1.time_ < var_47_2 + var_47_3 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1094ui_story then
				arg_44_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_47_5 = 0
			local var_47_6 = 1.05

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_7 = arg_44_1:FormatText(StoryNameCfg[181].name)

				arg_44_1.leftNameTxt_.text = var_47_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_8 = arg_44_1:GetWordFromCfg(111092011)
				local var_47_9 = arg_44_1:FormatText(var_47_8.content)

				arg_44_1.text_.text = var_47_9

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_10 = 42
				local var_47_11 = utf8.len(var_47_9)
				local var_47_12 = var_47_10 <= 0 and var_47_6 or var_47_6 * (var_47_11 / var_47_10)

				if var_47_12 > 0 and var_47_6 < var_47_12 then
					arg_44_1.talkMaxDuration = var_47_12

					if var_47_12 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_5
					end
				end

				arg_44_1.text_.text = var_47_9
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092011", "story_v_out_111092.awb") ~= 0 then
					local var_47_13 = manager.audio:GetVoiceLength("story_v_out_111092", "111092011", "story_v_out_111092.awb") / 1000

					if var_47_13 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_5
					end

					if var_47_8.prefab_name ~= "" and arg_44_1.actors_[var_47_8.prefab_name] ~= nil then
						local var_47_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_8.prefab_name].transform, "story_v_out_111092", "111092011", "story_v_out_111092.awb")

						arg_44_1:RecordAudio("111092011", var_47_14)
						arg_44_1:RecordAudio("111092011", var_47_14)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_111092", "111092011", "story_v_out_111092.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_111092", "111092011", "story_v_out_111092.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_15 = math.max(var_47_6, arg_44_1.talkMaxDuration)

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_15 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_5) / var_47_15

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_5 + var_47_15 and arg_44_1.time_ < var_47_5 + var_47_15 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play111092012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 111092012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play111092013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1094ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1094ui_story == nil then
				arg_48_1.var_.characterEffect1094ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1094ui_story and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1094ui_story.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1094ui_story then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1094ui_story.fillRatio = var_51_5
			end

			local var_51_6 = 0
			local var_51_7 = 0.275

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_8 = arg_48_1:FormatText(StoryNameCfg[181].name)

				arg_48_1.leftNameTxt_.text = var_51_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_9 = arg_48_1:GetWordFromCfg(111092012)
				local var_51_10 = arg_48_1:FormatText(var_51_9.content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 11
				local var_51_12 = utf8.len(var_51_10)
				local var_51_13 = var_51_11 <= 0 and var_51_7 or var_51_7 * (var_51_12 / var_51_11)

				if var_51_13 > 0 and var_51_7 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_10
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_14 and arg_48_1.time_ < var_51_6 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play111092013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 111092013
		arg_52_1.duration_ = 8.9

		local var_52_0 = {
			ja = 5.5,
			ko = 6.333,
			zh = 8.9,
			en = 8.3
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
				arg_52_0:Play111092014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_55_1 = arg_52_1.actors_["1094ui_story"]
			local var_55_2 = 0

			if var_55_2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1094ui_story == nil then
				arg_52_1.var_.characterEffect1094ui_story = var_55_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.2

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_3 and not isNil(var_55_1) then
				local var_55_4 = (arg_52_1.time_ - var_55_2) / var_55_3

				if arg_52_1.var_.characterEffect1094ui_story and not isNil(var_55_1) then
					arg_52_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_2 + var_55_3 and arg_52_1.time_ < var_55_2 + var_55_3 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1094ui_story then
				arg_52_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_55_5 = 0
			local var_55_6 = 0.725

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_7 = arg_52_1:FormatText(StoryNameCfg[181].name)

				arg_52_1.leftNameTxt_.text = var_55_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_8 = arg_52_1:GetWordFromCfg(111092013)
				local var_55_9 = arg_52_1:FormatText(var_55_8.content)

				arg_52_1.text_.text = var_55_9

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_10 = 29
				local var_55_11 = utf8.len(var_55_9)
				local var_55_12 = var_55_10 <= 0 and var_55_6 or var_55_6 * (var_55_11 / var_55_10)

				if var_55_12 > 0 and var_55_6 < var_55_12 then
					arg_52_1.talkMaxDuration = var_55_12

					if var_55_12 + var_55_5 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_12 + var_55_5
					end
				end

				arg_52_1.text_.text = var_55_9
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092013", "story_v_out_111092.awb") ~= 0 then
					local var_55_13 = manager.audio:GetVoiceLength("story_v_out_111092", "111092013", "story_v_out_111092.awb") / 1000

					if var_55_13 + var_55_5 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_5
					end

					if var_55_8.prefab_name ~= "" and arg_52_1.actors_[var_55_8.prefab_name] ~= nil then
						local var_55_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_8.prefab_name].transform, "story_v_out_111092", "111092013", "story_v_out_111092.awb")

						arg_52_1:RecordAudio("111092013", var_55_14)
						arg_52_1:RecordAudio("111092013", var_55_14)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_111092", "111092013", "story_v_out_111092.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_111092", "111092013", "story_v_out_111092.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_15 = math.max(var_55_6, arg_52_1.talkMaxDuration)

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_15 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_5) / var_55_15

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_5 + var_55_15 and arg_52_1.time_ < var_55_5 + var_55_15 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play111092014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 111092014
		arg_56_1.duration_ = 9.73

		local var_56_0 = {
			ja = 3.033,
			ko = 7.8,
			zh = 8.1,
			en = 9.733
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
				arg_56_0:Play111092015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_59_1 = arg_56_1.actors_["1094ui_story"]
			local var_59_2 = 0

			if var_59_2 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1094ui_story == nil then
				arg_56_1.var_.characterEffect1094ui_story = var_59_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_3 = 0.2

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_3 and not isNil(var_59_1) then
				local var_59_4 = (arg_56_1.time_ - var_59_2) / var_59_3

				if arg_56_1.var_.characterEffect1094ui_story and not isNil(var_59_1) then
					arg_56_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_2 + var_59_3 and arg_56_1.time_ < var_59_2 + var_59_3 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1094ui_story then
				arg_56_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_59_5 = 0
			local var_59_6 = 0.65

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_7 = arg_56_1:FormatText(StoryNameCfg[181].name)

				arg_56_1.leftNameTxt_.text = var_59_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_8 = arg_56_1:GetWordFromCfg(111092014)
				local var_59_9 = arg_56_1:FormatText(var_59_8.content)

				arg_56_1.text_.text = var_59_9

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_10 = 26
				local var_59_11 = utf8.len(var_59_9)
				local var_59_12 = var_59_10 <= 0 and var_59_6 or var_59_6 * (var_59_11 / var_59_10)

				if var_59_12 > 0 and var_59_6 < var_59_12 then
					arg_56_1.talkMaxDuration = var_59_12

					if var_59_12 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_12 + var_59_5
					end
				end

				arg_56_1.text_.text = var_59_9
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092014", "story_v_out_111092.awb") ~= 0 then
					local var_59_13 = manager.audio:GetVoiceLength("story_v_out_111092", "111092014", "story_v_out_111092.awb") / 1000

					if var_59_13 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_5
					end

					if var_59_8.prefab_name ~= "" and arg_56_1.actors_[var_59_8.prefab_name] ~= nil then
						local var_59_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_8.prefab_name].transform, "story_v_out_111092", "111092014", "story_v_out_111092.awb")

						arg_56_1:RecordAudio("111092014", var_59_14)
						arg_56_1:RecordAudio("111092014", var_59_14)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_111092", "111092014", "story_v_out_111092.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_111092", "111092014", "story_v_out_111092.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_15 = math.max(var_59_6, arg_56_1.talkMaxDuration)

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_15 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_5) / var_59_15

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_5 + var_59_15 and arg_56_1.time_ < var_59_5 + var_59_15 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play111092015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 111092015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play111092016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1094ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1094ui_story == nil then
				arg_60_1.var_.characterEffect1094ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.2

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1094ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1094ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1094ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1094ui_story.fillRatio = var_63_5
			end

			local var_63_6 = 0
			local var_63_7 = 0.2

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_8 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_9 = arg_60_1:GetWordFromCfg(111092015)
				local var_63_10 = arg_60_1:FormatText(var_63_9.content)

				arg_60_1.text_.text = var_63_10

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 8
				local var_63_12 = utf8.len(var_63_10)
				local var_63_13 = var_63_11 <= 0 and var_63_7 or var_63_7 * (var_63_12 / var_63_11)

				if var_63_13 > 0 and var_63_7 < var_63_13 then
					arg_60_1.talkMaxDuration = var_63_13

					if var_63_13 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_13 + var_63_6
					end
				end

				arg_60_1.text_.text = var_63_10
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_14 and arg_60_1.time_ < var_63_6 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play111092016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 111092016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play111092017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.725

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_2 = arg_64_1:GetWordFromCfg(111092016)
				local var_67_3 = arg_64_1:FormatText(var_67_2.content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 29
				local var_67_5 = utf8.len(var_67_3)
				local var_67_6 = var_67_4 <= 0 and var_67_1 or var_67_1 * (var_67_5 / var_67_4)

				if var_67_6 > 0 and var_67_1 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_7 and arg_64_1.time_ < var_67_0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play111092017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 111092017
		arg_68_1.duration_ = 3.47

		local var_68_0 = {
			ja = 3.466,
			ko = 2.1,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_68_0:Play111092018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action453")
			end

			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_71_2 = arg_68_1.actors_["1094ui_story"]
			local var_71_3 = 0

			if var_71_3 < arg_68_1.time_ and arg_68_1.time_ <= var_71_3 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1094ui_story == nil then
				arg_68_1.var_.characterEffect1094ui_story = var_71_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_4 = 0.2

			if var_71_3 <= arg_68_1.time_ and arg_68_1.time_ < var_71_3 + var_71_4 and not isNil(var_71_2) then
				local var_71_5 = (arg_68_1.time_ - var_71_3) / var_71_4

				if arg_68_1.var_.characterEffect1094ui_story and not isNil(var_71_2) then
					arg_68_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_3 + var_71_4 and arg_68_1.time_ < var_71_3 + var_71_4 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1094ui_story then
				arg_68_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_71_6 = 0
			local var_71_7 = 0.15

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_8 = arg_68_1:FormatText(StoryNameCfg[181].name)

				arg_68_1.leftNameTxt_.text = var_71_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_9 = arg_68_1:GetWordFromCfg(111092017)
				local var_71_10 = arg_68_1:FormatText(var_71_9.content)

				arg_68_1.text_.text = var_71_10

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 6
				local var_71_12 = utf8.len(var_71_10)
				local var_71_13 = var_71_11 <= 0 and var_71_7 or var_71_7 * (var_71_12 / var_71_11)

				if var_71_13 > 0 and var_71_7 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_10
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092017", "story_v_out_111092.awb") ~= 0 then
					local var_71_14 = manager.audio:GetVoiceLength("story_v_out_111092", "111092017", "story_v_out_111092.awb") / 1000

					if var_71_14 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_6
					end

					if var_71_9.prefab_name ~= "" and arg_68_1.actors_[var_71_9.prefab_name] ~= nil then
						local var_71_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_9.prefab_name].transform, "story_v_out_111092", "111092017", "story_v_out_111092.awb")

						arg_68_1:RecordAudio("111092017", var_71_15)
						arg_68_1:RecordAudio("111092017", var_71_15)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_111092", "111092017", "story_v_out_111092.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_111092", "111092017", "story_v_out_111092.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_16 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_16 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_16

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_16 and arg_68_1.time_ < var_71_6 + var_71_16 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play111092018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 111092018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play111092019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = "1019ui_story"

			if arg_72_1.actors_[var_75_0] == nil then
				local var_75_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_75_1) then
					local var_75_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_72_1.stage_.transform)

					var_75_2.name = var_75_0
					var_75_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_72_1.actors_[var_75_0] = var_75_2

					local var_75_3 = var_75_2:GetComponentInChildren(typeof(CharacterEffect))

					var_75_3.enabled = true

					local var_75_4 = GameObjectTools.GetOrAddComponent(var_75_2, typeof(DynamicBoneHelper))

					if var_75_4 then
						var_75_4:EnableDynamicBone(false)
					end

					arg_72_1:ShowWeapon(var_75_3.transform, false)

					arg_72_1.var_[var_75_0 .. "Animator"] = var_75_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_72_1.var_[var_75_0 .. "Animator"].applyRootMotion = true
					arg_72_1.var_[var_75_0 .. "LipSync"] = var_75_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_75_5 = arg_72_1.actors_["1019ui_story"].transform
			local var_75_6 = 0

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.var_.moveOldPos1019ui_story = var_75_5.localPosition
			end

			local var_75_7 = 0.001

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_7 then
				local var_75_8 = (arg_72_1.time_ - var_75_6) / var_75_7
				local var_75_9 = Vector3.New(0, 100, 0)

				var_75_5.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1019ui_story, var_75_9, var_75_8)

				local var_75_10 = manager.ui.mainCamera.transform.position - var_75_5.position

				var_75_5.forward = Vector3.New(var_75_10.x, var_75_10.y, var_75_10.z)

				local var_75_11 = var_75_5.localEulerAngles

				var_75_11.z = 0
				var_75_11.x = 0
				var_75_5.localEulerAngles = var_75_11
			end

			if arg_72_1.time_ >= var_75_6 + var_75_7 and arg_72_1.time_ < var_75_6 + var_75_7 + arg_75_0 then
				var_75_5.localPosition = Vector3.New(0, 100, 0)

				local var_75_12 = manager.ui.mainCamera.transform.position - var_75_5.position

				var_75_5.forward = Vector3.New(var_75_12.x, var_75_12.y, var_75_12.z)

				local var_75_13 = var_75_5.localEulerAngles

				var_75_13.z = 0
				var_75_13.x = 0
				var_75_5.localEulerAngles = var_75_13
			end

			local var_75_14 = 0

			if var_75_14 < arg_72_1.time_ and arg_72_1.time_ <= var_75_14 + arg_75_0 then
				arg_72_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_75_15 = arg_72_1.actors_["1094ui_story"]
			local var_75_16 = 0

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 and not isNil(var_75_15) and arg_72_1.var_.characterEffect1094ui_story == nil then
				arg_72_1.var_.characterEffect1094ui_story = var_75_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_17 = 0.2

			if var_75_16 <= arg_72_1.time_ and arg_72_1.time_ < var_75_16 + var_75_17 and not isNil(var_75_15) then
				local var_75_18 = (arg_72_1.time_ - var_75_16) / var_75_17

				if arg_72_1.var_.characterEffect1094ui_story and not isNil(var_75_15) then
					local var_75_19 = Mathf.Lerp(0, 0.5, var_75_18)

					arg_72_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1094ui_story.fillRatio = var_75_19
				end
			end

			if arg_72_1.time_ >= var_75_16 + var_75_17 and arg_72_1.time_ < var_75_16 + var_75_17 + arg_75_0 and not isNil(var_75_15) and arg_72_1.var_.characterEffect1094ui_story then
				local var_75_20 = 0.5

				arg_72_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1094ui_story.fillRatio = var_75_20
			end

			local var_75_21 = 0
			local var_75_22 = 0.3

			if var_75_21 < arg_72_1.time_ and arg_72_1.time_ <= var_75_21 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_23 = arg_72_1:FormatText(StoryNameCfg[7].name)

				arg_72_1.leftNameTxt_.text = var_75_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_24 = arg_72_1:GetWordFromCfg(111092018)
				local var_75_25 = arg_72_1:FormatText(var_75_24.content)

				arg_72_1.text_.text = var_75_25

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_26 = 12
				local var_75_27 = utf8.len(var_75_25)
				local var_75_28 = var_75_26 <= 0 and var_75_22 or var_75_22 * (var_75_27 / var_75_26)

				if var_75_28 > 0 and var_75_22 < var_75_28 then
					arg_72_1.talkMaxDuration = var_75_28

					if var_75_28 + var_75_21 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_28 + var_75_21
					end
				end

				arg_72_1.text_.text = var_75_25
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_29 = math.max(var_75_22, arg_72_1.talkMaxDuration)

			if var_75_21 <= arg_72_1.time_ and arg_72_1.time_ < var_75_21 + var_75_29 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_21) / var_75_29

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_21 + var_75_29 and arg_72_1.time_ < var_75_21 + var_75_29 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play111092019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 111092019
		arg_76_1.duration_ = 9

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play111092020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = "ST10"

			if arg_76_1.bgs_[var_79_0] == nil then
				local var_79_1 = Object.Instantiate(arg_76_1.paintGo_)

				var_79_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_79_0)
				var_79_1.name = var_79_0
				var_79_1.transform.parent = arg_76_1.stage_.transform
				var_79_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.bgs_[var_79_0] = var_79_1
			end

			local var_79_2 = 2

			if var_79_2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				local var_79_3 = manager.ui.mainCamera.transform.localPosition
				local var_79_4 = Vector3.New(0, 0, 10) + Vector3.New(var_79_3.x, var_79_3.y, 0)
				local var_79_5 = arg_76_1.bgs_.ST10

				var_79_5.transform.localPosition = var_79_4
				var_79_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_6 = var_79_5:GetComponent("SpriteRenderer")

				if var_79_6 and var_79_6.sprite then
					local var_79_7 = (var_79_5.transform.localPosition - var_79_3).z
					local var_79_8 = manager.ui.mainCameraCom_
					local var_79_9 = 2 * var_79_7 * Mathf.Tan(var_79_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_79_10 = var_79_9 * var_79_8.aspect
					local var_79_11 = var_79_6.sprite.bounds.size.x
					local var_79_12 = var_79_6.sprite.bounds.size.y
					local var_79_13 = var_79_10 / var_79_11
					local var_79_14 = var_79_9 / var_79_12
					local var_79_15 = var_79_14 < var_79_13 and var_79_13 or var_79_14

					var_79_5.transform.localScale = Vector3.New(var_79_15, var_79_15, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "ST10" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_79_16 = arg_76_1.actors_["1094ui_story"].transform
			local var_79_17 = 0

			if var_79_17 < arg_76_1.time_ and arg_76_1.time_ <= var_79_17 + arg_79_0 then
				arg_76_1.var_.moveOldPos1094ui_story = var_79_16.localPosition
			end

			local var_79_18 = 0.001

			if var_79_17 <= arg_76_1.time_ and arg_76_1.time_ < var_79_17 + var_79_18 then
				local var_79_19 = (arg_76_1.time_ - var_79_17) / var_79_18
				local var_79_20 = Vector3.New(0, 100, 0)

				var_79_16.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1094ui_story, var_79_20, var_79_19)

				local var_79_21 = manager.ui.mainCamera.transform.position - var_79_16.position

				var_79_16.forward = Vector3.New(var_79_21.x, var_79_21.y, var_79_21.z)

				local var_79_22 = var_79_16.localEulerAngles

				var_79_22.z = 0
				var_79_22.x = 0
				var_79_16.localEulerAngles = var_79_22
			end

			if arg_76_1.time_ >= var_79_17 + var_79_18 and arg_76_1.time_ < var_79_17 + var_79_18 + arg_79_0 then
				var_79_16.localPosition = Vector3.New(0, 100, 0)

				local var_79_23 = manager.ui.mainCamera.transform.position - var_79_16.position

				var_79_16.forward = Vector3.New(var_79_23.x, var_79_23.y, var_79_23.z)

				local var_79_24 = var_79_16.localEulerAngles

				var_79_24.z = 0
				var_79_24.x = 0
				var_79_16.localEulerAngles = var_79_24
			end

			local var_79_25 = arg_76_1.actors_["1019ui_story"].transform
			local var_79_26 = 3.5

			if var_79_26 < arg_76_1.time_ and arg_76_1.time_ <= var_79_26 + arg_79_0 then
				arg_76_1.var_.moveOldPos1019ui_story = var_79_25.localPosition
			end

			local var_79_27 = 0.001

			if var_79_26 <= arg_76_1.time_ and arg_76_1.time_ < var_79_26 + var_79_27 then
				local var_79_28 = (arg_76_1.time_ - var_79_26) / var_79_27
				local var_79_29 = Vector3.New(-0.2, -1.08, -5.9)

				var_79_25.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1019ui_story, var_79_29, var_79_28)

				local var_79_30 = manager.ui.mainCamera.transform.position - var_79_25.position

				var_79_25.forward = Vector3.New(var_79_30.x, var_79_30.y, var_79_30.z)

				local var_79_31 = var_79_25.localEulerAngles

				var_79_31.z = 0
				var_79_31.x = 0
				var_79_25.localEulerAngles = var_79_31
			end

			if arg_76_1.time_ >= var_79_26 + var_79_27 and arg_76_1.time_ < var_79_26 + var_79_27 + arg_79_0 then
				var_79_25.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_79_32 = manager.ui.mainCamera.transform.position - var_79_25.position

				var_79_25.forward = Vector3.New(var_79_32.x, var_79_32.y, var_79_32.z)

				local var_79_33 = var_79_25.localEulerAngles

				var_79_33.z = 0
				var_79_33.x = 0
				var_79_25.localEulerAngles = var_79_33
			end

			local var_79_34 = 3.5

			if var_79_34 < arg_76_1.time_ and arg_76_1.time_ <= var_79_34 + arg_79_0 then
				arg_76_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_79_35 = 3.5

			arg_76_1.isInRecall_ = false

			if var_79_35 < arg_76_1.time_ and arg_76_1.time_ <= var_79_35 + arg_79_0 then
				arg_76_1.screenFilterGo_:SetActive(true)

				arg_76_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_79_2, iter_79_3 in pairs(arg_76_1.actors_) do
					local var_79_36 = iter_79_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_79_4, iter_79_5 in ipairs(var_79_36) do
						if iter_79_5.color.r > 0.51 then
							iter_79_5.color = Color.New(1, 1, 1)
						else
							iter_79_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_79_37 = 0.2

			if var_79_35 <= arg_76_1.time_ and arg_76_1.time_ < var_79_35 + var_79_37 then
				local var_79_38 = (arg_76_1.time_ - var_79_35) / var_79_37

				arg_76_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_79_38)
			end

			if arg_76_1.time_ >= var_79_35 + var_79_37 and arg_76_1.time_ < var_79_35 + var_79_37 + arg_79_0 then
				arg_76_1.screenFilterEffect_.weight = 1
			end

			local var_79_39 = 0

			if var_79_39 < arg_76_1.time_ and arg_76_1.time_ <= var_79_39 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_40 = 2

			if var_79_39 <= arg_76_1.time_ and arg_76_1.time_ < var_79_39 + var_79_40 then
				local var_79_41 = (arg_76_1.time_ - var_79_39) / var_79_40
				local var_79_42 = Color.New(0, 0, 0)

				var_79_42.a = Mathf.Lerp(0, 1, var_79_41)
				arg_76_1.mask_.color = var_79_42
			end

			if arg_76_1.time_ >= var_79_39 + var_79_40 and arg_76_1.time_ < var_79_39 + var_79_40 + arg_79_0 then
				local var_79_43 = Color.New(0, 0, 0)

				var_79_43.a = 1
				arg_76_1.mask_.color = var_79_43
			end

			local var_79_44 = 2

			if var_79_44 < arg_76_1.time_ and arg_76_1.time_ <= var_79_44 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_45 = 2

			if var_79_44 <= arg_76_1.time_ and arg_76_1.time_ < var_79_44 + var_79_45 then
				local var_79_46 = (arg_76_1.time_ - var_79_44) / var_79_45
				local var_79_47 = Color.New(0, 0, 0)

				var_79_47.a = Mathf.Lerp(1, 0, var_79_46)
				arg_76_1.mask_.color = var_79_47
			end

			if arg_76_1.time_ >= var_79_44 + var_79_45 and arg_76_1.time_ < var_79_44 + var_79_45 + arg_79_0 then
				local var_79_48 = Color.New(0, 0, 0)
				local var_79_49 = 0

				arg_76_1.mask_.enabled = false
				var_79_48.a = var_79_49
				arg_76_1.mask_.color = var_79_48
			end

			local var_79_50 = 4

			arg_76_1.isInRecall_ = false

			if var_79_50 < arg_76_1.time_ and arg_76_1.time_ <= var_79_50 + arg_79_0 then
				arg_76_1.screenFilterGo_:SetActive(true)

				arg_76_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_79_6, iter_79_7 in pairs(arg_76_1.actors_) do
					local var_79_51 = iter_79_7:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_79_8, iter_79_9 in ipairs(var_79_51) do
						if iter_79_9.color.r > 0.51 then
							iter_79_9.color = Color.New(1, 1, 1)
						else
							iter_79_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_79_52 = 0.0166666666666667

			if var_79_50 <= arg_76_1.time_ and arg_76_1.time_ < var_79_50 + var_79_52 then
				local var_79_53 = (arg_76_1.time_ - var_79_50) / var_79_52

				arg_76_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_79_53)
			end

			if arg_76_1.time_ >= var_79_50 + var_79_52 and arg_76_1.time_ < var_79_50 + var_79_52 + arg_79_0 then
				arg_76_1.screenFilterEffect_.weight = 1
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_54 = 4
			local var_79_55 = 1.175

			if var_79_54 < arg_76_1.time_ and arg_76_1.time_ <= var_79_54 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_56 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_56:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_57 = arg_76_1:FormatText(StoryNameCfg[7].name)

				arg_76_1.leftNameTxt_.text = var_79_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_58 = arg_76_1:GetWordFromCfg(111092019)
				local var_79_59 = arg_76_1:FormatText(var_79_58.content)

				arg_76_1.text_.text = var_79_59

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_60 = 47
				local var_79_61 = utf8.len(var_79_59)
				local var_79_62 = var_79_60 <= 0 and var_79_55 or var_79_55 * (var_79_61 / var_79_60)

				if var_79_62 > 0 and var_79_55 < var_79_62 then
					arg_76_1.talkMaxDuration = var_79_62
					var_79_54 = var_79_54 + 0.3

					if var_79_62 + var_79_54 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_62 + var_79_54
					end
				end

				arg_76_1.text_.text = var_79_59
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_63 = var_79_54 + 0.3
			local var_79_64 = math.max(var_79_55, arg_76_1.talkMaxDuration)

			if var_79_63 <= arg_76_1.time_ and arg_76_1.time_ < var_79_63 + var_79_64 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_63) / var_79_64

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_63 + var_79_64 and arg_76_1.time_ < var_79_63 + var_79_64 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play111092020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 111092020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play111092021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.95

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[7].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:GetWordFromCfg(111092020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 38
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_8 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_8 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_8

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_8 and arg_82_1.time_ < var_85_0 + var_85_8 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play111092021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 111092021
		arg_86_1.duration_ = 10.6

		local var_86_0 = {
			ja = 10.6,
			ko = 8,
			zh = 8.9,
			en = 7.166
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
				arg_86_0:Play111092022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_89_2 = arg_86_1.actors_["1019ui_story"]
			local var_89_3 = 0

			if var_89_3 < arg_86_1.time_ and arg_86_1.time_ <= var_89_3 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect1019ui_story == nil then
				arg_86_1.var_.characterEffect1019ui_story = var_89_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_4 = 0.2

			if var_89_3 <= arg_86_1.time_ and arg_86_1.time_ < var_89_3 + var_89_4 and not isNil(var_89_2) then
				local var_89_5 = (arg_86_1.time_ - var_89_3) / var_89_4

				if arg_86_1.var_.characterEffect1019ui_story and not isNil(var_89_2) then
					arg_86_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_3 + var_89_4 and arg_86_1.time_ < var_89_3 + var_89_4 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect1019ui_story then
				arg_86_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_89_6 = 0
			local var_89_7 = 0.975

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_8 = arg_86_1:FormatText(StoryNameCfg[13].name)

				arg_86_1.leftNameTxt_.text = var_89_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_9 = arg_86_1:GetWordFromCfg(111092021)
				local var_89_10 = arg_86_1:FormatText(var_89_9.content)

				arg_86_1.text_.text = var_89_10

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 40
				local var_89_12 = utf8.len(var_89_10)
				local var_89_13 = var_89_11 <= 0 and var_89_7 or var_89_7 * (var_89_12 / var_89_11)

				if var_89_13 > 0 and var_89_7 < var_89_13 then
					arg_86_1.talkMaxDuration = var_89_13

					if var_89_13 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_13 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_10
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092021", "story_v_out_111092.awb") ~= 0 then
					local var_89_14 = manager.audio:GetVoiceLength("story_v_out_111092", "111092021", "story_v_out_111092.awb") / 1000

					if var_89_14 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_14 + var_89_6
					end

					if var_89_9.prefab_name ~= "" and arg_86_1.actors_[var_89_9.prefab_name] ~= nil then
						local var_89_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_9.prefab_name].transform, "story_v_out_111092", "111092021", "story_v_out_111092.awb")

						arg_86_1:RecordAudio("111092021", var_89_15)
						arg_86_1:RecordAudio("111092021", var_89_15)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_111092", "111092021", "story_v_out_111092.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_111092", "111092021", "story_v_out_111092.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_16 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_16 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_16

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_16 and arg_86_1.time_ < var_89_6 + var_89_16 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play111092022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 111092022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play111092023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1019ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1019ui_story == nil then
				arg_90_1.var_.characterEffect1019ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1019ui_story and not isNil(var_93_0) then
					local var_93_4 = Mathf.Lerp(0, 0.5, var_93_3)

					arg_90_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1019ui_story.fillRatio = var_93_4
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1019ui_story then
				local var_93_5 = 0.5

				arg_90_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1019ui_story.fillRatio = var_93_5
			end

			local var_93_6 = 0
			local var_93_7 = 1.1

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_8 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_9 = arg_90_1:GetWordFromCfg(111092022)
				local var_93_10 = arg_90_1:FormatText(var_93_9.content)

				arg_90_1.text_.text = var_93_10

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 44
				local var_93_12 = utf8.len(var_93_10)
				local var_93_13 = var_93_11 <= 0 and var_93_7 or var_93_7 * (var_93_12 / var_93_11)

				if var_93_13 > 0 and var_93_7 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_10
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_14 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_14 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_14

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_14 and arg_90_1.time_ < var_93_6 + var_93_14 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play111092023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 111092023
		arg_94_1.duration_ = 2

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play111092024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_97_1 = arg_94_1.actors_["1019ui_story"]
			local var_97_2 = 0

			if var_97_2 < arg_94_1.time_ and arg_94_1.time_ <= var_97_2 + arg_97_0 and not isNil(var_97_1) and arg_94_1.var_.characterEffect1019ui_story == nil then
				arg_94_1.var_.characterEffect1019ui_story = var_97_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_3 = 0.2

			if var_97_2 <= arg_94_1.time_ and arg_94_1.time_ < var_97_2 + var_97_3 and not isNil(var_97_1) then
				local var_97_4 = (arg_94_1.time_ - var_97_2) / var_97_3

				if arg_94_1.var_.characterEffect1019ui_story and not isNil(var_97_1) then
					arg_94_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_2 + var_97_3 and arg_94_1.time_ < var_97_2 + var_97_3 + arg_97_0 and not isNil(var_97_1) and arg_94_1.var_.characterEffect1019ui_story then
				arg_94_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_97_5 = 0
			local var_97_6 = 0.125

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_7 = arg_94_1:FormatText(StoryNameCfg[13].name)

				arg_94_1.leftNameTxt_.text = var_97_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_8 = arg_94_1:GetWordFromCfg(111092023)
				local var_97_9 = arg_94_1:FormatText(var_97_8.content)

				arg_94_1.text_.text = var_97_9

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_10 = 5
				local var_97_11 = utf8.len(var_97_9)
				local var_97_12 = var_97_10 <= 0 and var_97_6 or var_97_6 * (var_97_11 / var_97_10)

				if var_97_12 > 0 and var_97_6 < var_97_12 then
					arg_94_1.talkMaxDuration = var_97_12

					if var_97_12 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_12 + var_97_5
					end
				end

				arg_94_1.text_.text = var_97_9
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092023", "story_v_out_111092.awb") ~= 0 then
					local var_97_13 = manager.audio:GetVoiceLength("story_v_out_111092", "111092023", "story_v_out_111092.awb") / 1000

					if var_97_13 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_5
					end

					if var_97_8.prefab_name ~= "" and arg_94_1.actors_[var_97_8.prefab_name] ~= nil then
						local var_97_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_8.prefab_name].transform, "story_v_out_111092", "111092023", "story_v_out_111092.awb")

						arg_94_1:RecordAudio("111092023", var_97_14)
						arg_94_1:RecordAudio("111092023", var_97_14)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_111092", "111092023", "story_v_out_111092.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_111092", "111092023", "story_v_out_111092.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_15 = math.max(var_97_6, arg_94_1.talkMaxDuration)

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_15 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_5) / var_97_15

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_5 + var_97_15 and arg_94_1.time_ < var_97_5 + var_97_15 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play111092024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 111092024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play111092025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1019ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1019ui_story == nil then
				arg_98_1.var_.characterEffect1019ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.2

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1019ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1019ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1019ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1019ui_story.fillRatio = var_101_5
			end

			local var_101_6 = 0
			local var_101_7 = 0.85

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_8 = arg_98_1:FormatText(StoryNameCfg[7].name)

				arg_98_1.leftNameTxt_.text = var_101_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_9 = arg_98_1:GetWordFromCfg(111092024)
				local var_101_10 = arg_98_1:FormatText(var_101_9.content)

				arg_98_1.text_.text = var_101_10

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_11 = 34
				local var_101_12 = utf8.len(var_101_10)
				local var_101_13 = var_101_11 <= 0 and var_101_7 or var_101_7 * (var_101_12 / var_101_11)

				if var_101_13 > 0 and var_101_7 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_10
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_14 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_14 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_14

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_14 and arg_98_1.time_ < var_101_6 + var_101_14 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play111092025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 111092025
		arg_102_1.duration_ = 6.57

		local var_102_0 = {
			ja = 6.566,
			ko = 5.233,
			zh = 6.066,
			en = 4.733
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
				arg_102_0:Play111092026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_105_1 = arg_102_1.actors_["1019ui_story"]
			local var_105_2 = 0

			if var_105_2 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1019ui_story == nil then
				arg_102_1.var_.characterEffect1019ui_story = var_105_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_3 = 0.2

			if var_105_2 <= arg_102_1.time_ and arg_102_1.time_ < var_105_2 + var_105_3 and not isNil(var_105_1) then
				local var_105_4 = (arg_102_1.time_ - var_105_2) / var_105_3

				if arg_102_1.var_.characterEffect1019ui_story and not isNil(var_105_1) then
					arg_102_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_2 + var_105_3 and arg_102_1.time_ < var_105_2 + var_105_3 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1019ui_story then
				arg_102_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_105_5 = 0
			local var_105_6 = 0.55

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_7 = arg_102_1:FormatText(StoryNameCfg[13].name)

				arg_102_1.leftNameTxt_.text = var_105_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_8 = arg_102_1:GetWordFromCfg(111092025)
				local var_105_9 = arg_102_1:FormatText(var_105_8.content)

				arg_102_1.text_.text = var_105_9

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_10 = 22
				local var_105_11 = utf8.len(var_105_9)
				local var_105_12 = var_105_10 <= 0 and var_105_6 or var_105_6 * (var_105_11 / var_105_10)

				if var_105_12 > 0 and var_105_6 < var_105_12 then
					arg_102_1.talkMaxDuration = var_105_12

					if var_105_12 + var_105_5 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_12 + var_105_5
					end
				end

				arg_102_1.text_.text = var_105_9
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092025", "story_v_out_111092.awb") ~= 0 then
					local var_105_13 = manager.audio:GetVoiceLength("story_v_out_111092", "111092025", "story_v_out_111092.awb") / 1000

					if var_105_13 + var_105_5 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_5
					end

					if var_105_8.prefab_name ~= "" and arg_102_1.actors_[var_105_8.prefab_name] ~= nil then
						local var_105_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_8.prefab_name].transform, "story_v_out_111092", "111092025", "story_v_out_111092.awb")

						arg_102_1:RecordAudio("111092025", var_105_14)
						arg_102_1:RecordAudio("111092025", var_105_14)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_111092", "111092025", "story_v_out_111092.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_111092", "111092025", "story_v_out_111092.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_15 = math.max(var_105_6, arg_102_1.talkMaxDuration)

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_15 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_5) / var_105_15

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_5 + var_105_15 and arg_102_1.time_ < var_105_5 + var_105_15 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play111092026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 111092026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play111092027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1019ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1019ui_story == nil then
				arg_106_1.var_.characterEffect1019ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1019ui_story and not isNil(var_109_0) then
					local var_109_4 = Mathf.Lerp(0, 0.5, var_109_3)

					arg_106_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1019ui_story.fillRatio = var_109_4
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1019ui_story then
				local var_109_5 = 0.5

				arg_106_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1019ui_story.fillRatio = var_109_5
			end

			local var_109_6 = 0
			local var_109_7 = 1.325

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

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_9 = arg_106_1:GetWordFromCfg(111092026)
				local var_109_10 = arg_106_1:FormatText(var_109_9.content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 53
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
	Play111092027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 111092027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play111092028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_113_1 = arg_110_1.actors_["1094ui_story"].transform
			local var_113_2 = 0

			if var_113_2 < arg_110_1.time_ and arg_110_1.time_ <= var_113_2 + arg_113_0 then
				arg_110_1.var_.moveOldPos1094ui_story = var_113_1.localPosition
			end

			local var_113_3 = 0.001

			if var_113_2 <= arg_110_1.time_ and arg_110_1.time_ < var_113_2 + var_113_3 then
				local var_113_4 = (arg_110_1.time_ - var_113_2) / var_113_3
				local var_113_5 = Vector3.New(0, 100, 0)

				var_113_1.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1094ui_story, var_113_5, var_113_4)

				local var_113_6 = manager.ui.mainCamera.transform.position - var_113_1.position

				var_113_1.forward = Vector3.New(var_113_6.x, var_113_6.y, var_113_6.z)

				local var_113_7 = var_113_1.localEulerAngles

				var_113_7.z = 0
				var_113_7.x = 0
				var_113_1.localEulerAngles = var_113_7
			end

			if arg_110_1.time_ >= var_113_2 + var_113_3 and arg_110_1.time_ < var_113_2 + var_113_3 + arg_113_0 then
				var_113_1.localPosition = Vector3.New(0, 100, 0)

				local var_113_8 = manager.ui.mainCamera.transform.position - var_113_1.position

				var_113_1.forward = Vector3.New(var_113_8.x, var_113_8.y, var_113_8.z)

				local var_113_9 = var_113_1.localEulerAngles

				var_113_9.z = 0
				var_113_9.x = 0
				var_113_1.localEulerAngles = var_113_9
			end

			local var_113_10 = 0
			local var_113_11 = 0.525

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_12 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_13 = arg_110_1:GetWordFromCfg(111092027)
				local var_113_14 = arg_110_1:FormatText(var_113_13.content)

				arg_110_1.text_.text = var_113_14

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_15 = 21
				local var_113_16 = utf8.len(var_113_14)
				local var_113_17 = var_113_15 <= 0 and var_113_11 or var_113_11 * (var_113_16 / var_113_15)

				if var_113_17 > 0 and var_113_11 < var_113_17 then
					arg_110_1.talkMaxDuration = var_113_17

					if var_113_17 + var_113_10 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_17 + var_113_10
					end
				end

				arg_110_1.text_.text = var_113_14
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_18 = math.max(var_113_11, arg_110_1.talkMaxDuration)

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_18 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_10) / var_113_18

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_10 + var_113_18 and arg_110_1.time_ < var_113_10 + var_113_18 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play111092028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 111092028
		arg_114_1.duration_ = 8.5

		local var_114_0 = {
			ja = 8.49933333333333,
			ko = 6.43333333333333,
			zh = 7.53333333333333,
			en = 6.26633333333333
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
				arg_114_0:Play111092029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = "D05"

			if arg_114_1.bgs_[var_117_0] == nil then
				local var_117_1 = Object.Instantiate(arg_114_1.paintGo_)

				var_117_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_117_0)
				var_117_1.name = var_117_0
				var_117_1.transform.parent = arg_114_1.stage_.transform
				var_117_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.bgs_[var_117_0] = var_117_1
			end

			local var_117_2 = 2

			if var_117_2 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				local var_117_3 = manager.ui.mainCamera.transform.localPosition
				local var_117_4 = Vector3.New(0, 0, 10) + Vector3.New(var_117_3.x, var_117_3.y, 0)
				local var_117_5 = arg_114_1.bgs_.D05

				var_117_5.transform.localPosition = var_117_4
				var_117_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_6 = var_117_5:GetComponent("SpriteRenderer")

				if var_117_6 and var_117_6.sprite then
					local var_117_7 = (var_117_5.transform.localPosition - var_117_3).z
					local var_117_8 = manager.ui.mainCameraCom_
					local var_117_9 = 2 * var_117_7 * Mathf.Tan(var_117_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_117_10 = var_117_9 * var_117_8.aspect
					local var_117_11 = var_117_6.sprite.bounds.size.x
					local var_117_12 = var_117_6.sprite.bounds.size.y
					local var_117_13 = var_117_10 / var_117_11
					local var_117_14 = var_117_9 / var_117_12
					local var_117_15 = var_117_14 < var_117_13 and var_117_13 or var_117_14

					var_117_5.transform.localScale = Vector3.New(var_117_15, var_117_15, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "D05" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_16 = 0

			if var_117_16 < arg_114_1.time_ and arg_114_1.time_ <= var_117_16 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_17 = 2

			if var_117_16 <= arg_114_1.time_ and arg_114_1.time_ < var_117_16 + var_117_17 then
				local var_117_18 = (arg_114_1.time_ - var_117_16) / var_117_17
				local var_117_19 = Color.New(0, 0, 0)

				var_117_19.a = Mathf.Lerp(0, 1, var_117_18)
				arg_114_1.mask_.color = var_117_19
			end

			if arg_114_1.time_ >= var_117_16 + var_117_17 and arg_114_1.time_ < var_117_16 + var_117_17 + arg_117_0 then
				local var_117_20 = Color.New(0, 0, 0)

				var_117_20.a = 1
				arg_114_1.mask_.color = var_117_20
			end

			local var_117_21 = 2

			if var_117_21 < arg_114_1.time_ and arg_114_1.time_ <= var_117_21 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_22 = 2

			if var_117_21 <= arg_114_1.time_ and arg_114_1.time_ < var_117_21 + var_117_22 then
				local var_117_23 = (arg_114_1.time_ - var_117_21) / var_117_22
				local var_117_24 = Color.New(0, 0, 0)

				var_117_24.a = Mathf.Lerp(1, 0, var_117_23)
				arg_114_1.mask_.color = var_117_24
			end

			if arg_114_1.time_ >= var_117_21 + var_117_22 and arg_114_1.time_ < var_117_21 + var_117_22 + arg_117_0 then
				local var_117_25 = Color.New(0, 0, 0)
				local var_117_26 = 0

				arg_114_1.mask_.enabled = false
				var_117_25.a = var_117_26
				arg_114_1.mask_.color = var_117_25
			end

			local var_117_27 = arg_114_1.actors_["1019ui_story"].transform
			local var_117_28 = 2

			if var_117_28 < arg_114_1.time_ and arg_114_1.time_ <= var_117_28 + arg_117_0 then
				arg_114_1.var_.moveOldPos1019ui_story = var_117_27.localPosition
			end

			local var_117_29 = 0.001

			if var_117_28 <= arg_114_1.time_ and arg_114_1.time_ < var_117_28 + var_117_29 then
				local var_117_30 = (arg_114_1.time_ - var_117_28) / var_117_29
				local var_117_31 = Vector3.New(0, 100, 0)

				var_117_27.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1019ui_story, var_117_31, var_117_30)

				local var_117_32 = manager.ui.mainCamera.transform.position - var_117_27.position

				var_117_27.forward = Vector3.New(var_117_32.x, var_117_32.y, var_117_32.z)

				local var_117_33 = var_117_27.localEulerAngles

				var_117_33.z = 0
				var_117_33.x = 0
				var_117_27.localEulerAngles = var_117_33
			end

			if arg_114_1.time_ >= var_117_28 + var_117_29 and arg_114_1.time_ < var_117_28 + var_117_29 + arg_117_0 then
				var_117_27.localPosition = Vector3.New(0, 100, 0)

				local var_117_34 = manager.ui.mainCamera.transform.position - var_117_27.position

				var_117_27.forward = Vector3.New(var_117_34.x, var_117_34.y, var_117_34.z)

				local var_117_35 = var_117_27.localEulerAngles

				var_117_35.z = 0
				var_117_35.x = 0
				var_117_27.localEulerAngles = var_117_35
			end

			local var_117_36 = arg_114_1.actors_["1094ui_story"].transform
			local var_117_37 = 3.73333333333333

			if var_117_37 < arg_114_1.time_ and arg_114_1.time_ <= var_117_37 + arg_117_0 then
				arg_114_1.var_.moveOldPos1094ui_story = var_117_36.localPosition
			end

			local var_117_38 = 0.001

			if var_117_37 <= arg_114_1.time_ and arg_114_1.time_ < var_117_37 + var_117_38 then
				local var_117_39 = (arg_114_1.time_ - var_117_37) / var_117_38
				local var_117_40 = Vector3.New(0, -0.84, -6.1)

				var_117_36.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1094ui_story, var_117_40, var_117_39)

				local var_117_41 = manager.ui.mainCamera.transform.position - var_117_36.position

				var_117_36.forward = Vector3.New(var_117_41.x, var_117_41.y, var_117_41.z)

				local var_117_42 = var_117_36.localEulerAngles

				var_117_42.z = 0
				var_117_42.x = 0
				var_117_36.localEulerAngles = var_117_42
			end

			if arg_114_1.time_ >= var_117_37 + var_117_38 and arg_114_1.time_ < var_117_37 + var_117_38 + arg_117_0 then
				var_117_36.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_117_43 = manager.ui.mainCamera.transform.position - var_117_36.position

				var_117_36.forward = Vector3.New(var_117_43.x, var_117_43.y, var_117_43.z)

				local var_117_44 = var_117_36.localEulerAngles

				var_117_44.z = 0
				var_117_44.x = 0
				var_117_36.localEulerAngles = var_117_44
			end

			local var_117_45 = 3.73333333333333

			if var_117_45 < arg_114_1.time_ and arg_114_1.time_ <= var_117_45 + arg_117_0 then
				arg_114_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_117_46 = 2

			arg_114_1.isInRecall_ = false

			if var_117_46 < arg_114_1.time_ and arg_114_1.time_ <= var_117_46 + arg_117_0 then
				arg_114_1.screenFilterGo_:SetActive(false)

				for iter_117_2, iter_117_3 in pairs(arg_114_1.actors_) do
					local var_117_47 = iter_117_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_117_4, iter_117_5 in ipairs(var_117_47) do
						if iter_117_5.color.r > 0.51 then
							iter_117_5.color = Color.New(1, 1, 1)
						else
							iter_117_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_117_48 = 0.0166666666666667

			if var_117_46 <= arg_114_1.time_ and arg_114_1.time_ < var_117_46 + var_117_48 then
				local var_117_49 = (arg_114_1.time_ - var_117_46) / var_117_48

				arg_114_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_117_49)
			end

			if arg_114_1.time_ >= var_117_46 + var_117_48 and arg_114_1.time_ < var_117_46 + var_117_48 + arg_117_0 then
				arg_114_1.screenFilterEffect_.weight = 0
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_50 = 3.73333333333333
			local var_117_51 = 0.2

			if var_117_50 < arg_114_1.time_ and arg_114_1.time_ <= var_117_50 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_52 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_52:setOnUpdate(LuaHelper.FloatAction(function(arg_118_0)
					arg_114_1.dialogCg_.alpha = arg_118_0
				end))
				var_117_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_53 = arg_114_1:FormatText(StoryNameCfg[181].name)

				arg_114_1.leftNameTxt_.text = var_117_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_54 = arg_114_1:GetWordFromCfg(111092028)
				local var_117_55 = arg_114_1:FormatText(var_117_54.content)

				arg_114_1.text_.text = var_117_55

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_56 = 8
				local var_117_57 = utf8.len(var_117_55)
				local var_117_58 = var_117_56 <= 0 and var_117_51 or var_117_51 * (var_117_57 / var_117_56)

				if var_117_58 > 0 and var_117_51 < var_117_58 then
					arg_114_1.talkMaxDuration = var_117_58
					var_117_50 = var_117_50 + 0.3

					if var_117_58 + var_117_50 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_58 + var_117_50
					end
				end

				arg_114_1.text_.text = var_117_55
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092028", "story_v_out_111092.awb") ~= 0 then
					local var_117_59 = manager.audio:GetVoiceLength("story_v_out_111092", "111092028", "story_v_out_111092.awb") / 1000

					if var_117_59 + var_117_50 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_59 + var_117_50
					end

					if var_117_54.prefab_name ~= "" and arg_114_1.actors_[var_117_54.prefab_name] ~= nil then
						local var_117_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_54.prefab_name].transform, "story_v_out_111092", "111092028", "story_v_out_111092.awb")

						arg_114_1:RecordAudio("111092028", var_117_60)
						arg_114_1:RecordAudio("111092028", var_117_60)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_111092", "111092028", "story_v_out_111092.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_111092", "111092028", "story_v_out_111092.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_61 = var_117_50 + 0.3
			local var_117_62 = math.max(var_117_51, arg_114_1.talkMaxDuration)

			if var_117_61 <= arg_114_1.time_ and arg_114_1.time_ < var_117_61 + var_117_62 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_61) / var_117_62

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_61 + var_117_62 and arg_114_1.time_ < var_117_61 + var_117_62 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play111092029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 111092029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play111092030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.925

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_2 = arg_120_1:GetWordFromCfg(111092029)
				local var_123_3 = arg_120_1:FormatText(var_123_2.content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 37
				local var_123_5 = utf8.len(var_123_3)
				local var_123_6 = var_123_4 <= 0 and var_123_1 or var_123_1 * (var_123_5 / var_123_4)

				if var_123_6 > 0 and var_123_1 < var_123_6 then
					arg_120_1.talkMaxDuration = var_123_6

					if var_123_6 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_6 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_7 and arg_120_1.time_ < var_123_0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play111092030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 111092030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play111092031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 1

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				local var_127_2 = "play"
				local var_127_3 = "music"

				arg_124_1:AudioAction(var_127_2, var_127_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_127_4 = ""
				local var_127_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_127_5 ~= "" then
					if arg_124_1.bgmTxt_.text ~= var_127_5 and arg_124_1.bgmTxt_.text ~= "" then
						if arg_124_1.bgmTxt2_.text ~= "" then
							arg_124_1.bgmTxt_.text = arg_124_1.bgmTxt2_.text
						end

						arg_124_1.bgmTxt2_.text = var_127_5

						arg_124_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_124_1.bgmTxt_.text = var_127_5
						arg_124_1.bgmTxt2_.text = var_127_5
					end

					if arg_124_1.bgmTimer then
						arg_124_1.bgmTimer:Stop()

						arg_124_1.bgmTimer = nil
					end

					if arg_124_1.settingData.show_music_name == 1 then
						arg_124_1.musicController:SetSelectedState("show")
						arg_124_1.musicAnimator_:Play("open", 0, 0)

						if arg_124_1.settingData.music_time ~= 0 then
							arg_124_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_124_1.settingData.music_time), function()
								if arg_124_1 == nil or isNil(arg_124_1.bgmTxt_) then
									return
								end

								arg_124_1.musicController:SetSelectedState("hide")
								arg_124_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_127_6 = 0
			local var_127_7 = 1

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				local var_127_8 = "play"
				local var_127_9 = "effect"

				arg_124_1:AudioAction(var_127_8, var_127_9, "se_story", "se_story_communication", "")
			end

			local var_127_10 = 0
			local var_127_11 = 0.925

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_12 = arg_124_1:GetWordFromCfg(111092030)
				local var_127_13 = arg_124_1:FormatText(var_127_12.content)

				arg_124_1.text_.text = var_127_13

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_14 = 37
				local var_127_15 = utf8.len(var_127_13)
				local var_127_16 = var_127_14 <= 0 and var_127_11 or var_127_11 * (var_127_15 / var_127_14)

				if var_127_16 > 0 and var_127_11 < var_127_16 then
					arg_124_1.talkMaxDuration = var_127_16

					if var_127_16 + var_127_10 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_16 + var_127_10
					end
				end

				arg_124_1.text_.text = var_127_13
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_17 = math.max(var_127_11, arg_124_1.talkMaxDuration)

			if var_127_10 <= arg_124_1.time_ and arg_124_1.time_ < var_127_10 + var_127_17 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_10) / var_127_17

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_10 + var_127_17 and arg_124_1.time_ < var_127_10 + var_127_17 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play111092031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 111092031
		arg_129_1.duration_ = 5.8

		local var_129_0 = {
			ja = 5.8,
			ko = 4.666,
			zh = 3.9,
			en = 4
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play111092032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = manager.ui.mainCamera.transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.shakeOldPos = var_132_0.localPosition
			end

			local var_132_2 = 0.333333333333333

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / 0.066
				local var_132_4, var_132_5 = math.modf(var_132_3)

				var_132_0.localPosition = Vector3.New(var_132_5 * 0.13, var_132_5 * 0.13, var_132_5 * 0.13) + arg_129_1.var_.shakeOldPos
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = arg_129_1.var_.shakeOldPos
			end

			local var_132_6 = 0

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.allBtn_.enabled = false
			end

			local var_132_7 = 0.333333333333333

			if arg_129_1.time_ >= var_132_6 + var_132_7 and arg_129_1.time_ < var_132_6 + var_132_7 + arg_132_0 then
				arg_129_1.allBtn_.enabled = true
			end

			local var_132_8 = 0
			local var_132_9 = 1

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				local var_132_10 = "play"
				local var_132_11 = "music"

				arg_129_1:AudioAction(var_132_10, var_132_11, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_132_12 = ""
				local var_132_13 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_132_13 ~= "" then
					if arg_129_1.bgmTxt_.text ~= var_132_13 and arg_129_1.bgmTxt_.text ~= "" then
						if arg_129_1.bgmTxt2_.text ~= "" then
							arg_129_1.bgmTxt_.text = arg_129_1.bgmTxt2_.text
						end

						arg_129_1.bgmTxt2_.text = var_132_13

						arg_129_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_129_1.bgmTxt_.text = var_132_13
						arg_129_1.bgmTxt2_.text = var_132_13
					end

					if arg_129_1.bgmTimer then
						arg_129_1.bgmTimer:Stop()

						arg_129_1.bgmTimer = nil
					end

					if arg_129_1.settingData.show_music_name == 1 then
						arg_129_1.musicController:SetSelectedState("show")
						arg_129_1.musicAnimator_:Play("open", 0, 0)

						if arg_129_1.settingData.music_time ~= 0 then
							arg_129_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_129_1.settingData.music_time), function()
								if arg_129_1 == nil or isNil(arg_129_1.bgmTxt_) then
									return
								end

								arg_129_1.musicController:SetSelectedState("hide")
								arg_129_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_132_14 = 0
			local var_132_15 = 0.525

			if var_132_14 < arg_129_1.time_ and arg_129_1.time_ <= var_132_14 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_16 = arg_129_1:FormatText(StoryNameCfg[6].name)

				arg_129_1.leftNameTxt_.text = var_132_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_17 = arg_129_1:GetWordFromCfg(111092031)
				local var_132_18 = arg_129_1:FormatText(var_132_17.content)

				arg_129_1.text_.text = var_132_18

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_19 = 20
				local var_132_20 = utf8.len(var_132_18)
				local var_132_21 = var_132_19 <= 0 and var_132_15 or var_132_15 * (var_132_20 / var_132_19)

				if var_132_21 > 0 and var_132_15 < var_132_21 then
					arg_129_1.talkMaxDuration = var_132_21

					if var_132_21 + var_132_14 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_21 + var_132_14
					end
				end

				arg_129_1.text_.text = var_132_18
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092031", "story_v_out_111092.awb") ~= 0 then
					local var_132_22 = manager.audio:GetVoiceLength("story_v_out_111092", "111092031", "story_v_out_111092.awb") / 1000

					if var_132_22 + var_132_14 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_22 + var_132_14
					end

					if var_132_17.prefab_name ~= "" and arg_129_1.actors_[var_132_17.prefab_name] ~= nil then
						local var_132_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_17.prefab_name].transform, "story_v_out_111092", "111092031", "story_v_out_111092.awb")

						arg_129_1:RecordAudio("111092031", var_132_23)
						arg_129_1:RecordAudio("111092031", var_132_23)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_111092", "111092031", "story_v_out_111092.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_111092", "111092031", "story_v_out_111092.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_24 = math.max(var_132_15, arg_129_1.talkMaxDuration)

			if var_132_14 <= arg_129_1.time_ and arg_129_1.time_ < var_132_14 + var_132_24 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_14) / var_132_24

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_14 + var_132_24 and arg_129_1.time_ < var_132_14 + var_132_24 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play111092032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 111092032
		arg_134_1.duration_ = 3.7

		local var_134_0 = {
			ja = 3.7,
			ko = 3.3,
			zh = 3,
			en = 2.833
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play111092033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 0.325

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_2 = arg_134_1:FormatText(StoryNameCfg[6].name)

				arg_134_1.leftNameTxt_.text = var_137_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:GetWordFromCfg(111092032)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 13
				local var_137_6 = utf8.len(var_137_4)
				local var_137_7 = var_137_5 <= 0 and var_137_1 or var_137_1 * (var_137_6 / var_137_5)

				if var_137_7 > 0 and var_137_1 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111092", "111092032", "story_v_out_111092.awb") ~= 0 then
					local var_137_8 = manager.audio:GetVoiceLength("story_v_out_111092", "111092032", "story_v_out_111092.awb") / 1000

					if var_137_8 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_0
					end

					if var_137_3.prefab_name ~= "" and arg_134_1.actors_[var_137_3.prefab_name] ~= nil then
						local var_137_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_3.prefab_name].transform, "story_v_out_111092", "111092032", "story_v_out_111092.awb")

						arg_134_1:RecordAudio("111092032", var_137_9)
						arg_134_1:RecordAudio("111092032", var_137_9)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_111092", "111092032", "story_v_out_111092.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_111092", "111092032", "story_v_out_111092.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_10 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_10 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_10

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_10 and arg_134_1.time_ < var_137_0 + var_137_10 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play111092033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 111092033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
			arg_138_1.auto_ = false
		end

		function arg_138_1.playNext_(arg_140_0)
			arg_138_1.onStoryFinished_()
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1094ui_story"].transform
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.var_.moveOldPos1094ui_story = var_141_0.localPosition
			end

			local var_141_2 = 0.001

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2
				local var_141_4 = Vector3.New(0, 100, 0)

				var_141_0.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1094ui_story, var_141_4, var_141_3)

				local var_141_5 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_5.x, var_141_5.y, var_141_5.z)

				local var_141_6 = var_141_0.localEulerAngles

				var_141_6.z = 0
				var_141_6.x = 0
				var_141_0.localEulerAngles = var_141_6
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 then
				var_141_0.localPosition = Vector3.New(0, 100, 0)

				local var_141_7 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_7.x, var_141_7.y, var_141_7.z)

				local var_141_8 = var_141_0.localEulerAngles

				var_141_8.z = 0
				var_141_8.x = 0
				var_141_0.localEulerAngles = var_141_8
			end

			local var_141_9 = manager.ui.mainCamera.transform
			local var_141_10 = 0

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
				arg_138_1.var_.shakeOldPos = var_141_9.localPosition
			end

			local var_141_11 = 1

			if var_141_10 <= arg_138_1.time_ and arg_138_1.time_ < var_141_10 + var_141_11 then
				local var_141_12 = (arg_138_1.time_ - var_141_10) / 0.066
				local var_141_13, var_141_14 = math.modf(var_141_12)

				var_141_9.localPosition = Vector3.New(var_141_14 * 0.13, var_141_14 * 0.13, var_141_14 * 0.13) + arg_138_1.var_.shakeOldPos
			end

			if arg_138_1.time_ >= var_141_10 + var_141_11 and arg_138_1.time_ < var_141_10 + var_141_11 + arg_141_0 then
				var_141_9.localPosition = arg_138_1.var_.shakeOldPos
			end

			local var_141_15 = 0

			if var_141_15 < arg_138_1.time_ and arg_138_1.time_ <= var_141_15 + arg_141_0 then
				arg_138_1.allBtn_.enabled = false
			end

			local var_141_16 = 1

			if arg_138_1.time_ >= var_141_15 + var_141_16 and arg_138_1.time_ < var_141_15 + var_141_16 + arg_141_0 then
				arg_138_1.allBtn_.enabled = true
			end

			local var_141_17 = 0
			local var_141_18 = 1

			if var_141_17 < arg_138_1.time_ and arg_138_1.time_ <= var_141_17 + arg_141_0 then
				local var_141_19 = "play"
				local var_141_20 = "effect"

				arg_138_1:AudioAction(var_141_19, var_141_20, "se_story", "se_story_explosion", "")
			end

			local var_141_21 = 0
			local var_141_22 = 0.975

			if var_141_21 < arg_138_1.time_ and arg_138_1.time_ <= var_141_21 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_23 = arg_138_1:GetWordFromCfg(111092033)
				local var_141_24 = arg_138_1:FormatText(var_141_23.content)

				arg_138_1.text_.text = var_141_24

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_25 = 39
				local var_141_26 = utf8.len(var_141_24)
				local var_141_27 = var_141_25 <= 0 and var_141_22 or var_141_22 * (var_141_26 / var_141_25)

				if var_141_27 > 0 and var_141_22 < var_141_27 then
					arg_138_1.talkMaxDuration = var_141_27

					if var_141_27 + var_141_21 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_27 + var_141_21
					end
				end

				arg_138_1.text_.text = var_141_24
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_28 = math.max(var_141_22, arg_138_1.talkMaxDuration)

			if var_141_21 <= arg_138_1.time_ and arg_138_1.time_ < var_141_21 + var_141_28 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_21) / var_141_28

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_21 + var_141_28 and arg_138_1.time_ < var_141_21 + var_141_28 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D06a",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/D05"
	},
	voices = {
		"story_v_out_111092.awb"
	}
}
