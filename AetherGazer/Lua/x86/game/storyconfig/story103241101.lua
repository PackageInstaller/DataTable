return {
	Play324111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324111001
		arg_1_1.duration_ = 6.53

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324111002(arg_1_1)
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

			local var_4_32 = 1
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = 1.53333333333333
			local var_4_39 = 0.175

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_41

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

				local var_4_42 = arg_1_1:GetWordFromCfg(324111001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 7
				local var_4_45 = utf8.len(var_4_43)
				local var_4_46 = var_4_44 <= 0 and var_4_39 or var_4_39 * (var_4_45 / var_4_44)

				if var_4_46 > 0 and var_4_39 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_38 = var_4_38 + 0.3

					if var_4_46 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_43
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_38 + 0.3
			local var_4_48 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324111002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324111003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.75

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

				local var_11_2 = arg_8_1:GetWordFromCfg(324111002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 30
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
	Play324111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324111003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324111004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.325

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(324111003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 13
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_8 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_8 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_8

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_8 and arg_12_1.time_ < var_15_0 + var_15_8 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324111004
		arg_16_1.duration_ = 3.9

		local var_16_0 = {
			zh = 1.766,
			ja = 3.9
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "6148ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["6148ui_story"]
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect6148ui_story == nil then
				arg_16_1.var_.characterEffect6148ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.200000002980232

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect6148ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect6148ui_story then
				arg_16_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_19_9 = 0
			local var_19_10 = 0.15

			if var_19_9 < arg_16_1.time_ and arg_16_1.time_ <= var_19_9 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_11 = arg_16_1:FormatText(StoryNameCfg[1488].name)

				arg_16_1.leftNameTxt_.text = var_19_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_12 = arg_16_1:GetWordFromCfg(324111004)
				local var_19_13 = arg_16_1:FormatText(var_19_12.content)

				arg_16_1.text_.text = var_19_13

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_14 = 6
				local var_19_15 = utf8.len(var_19_13)
				local var_19_16 = var_19_14 <= 0 and var_19_10 or var_19_10 * (var_19_15 / var_19_14)

				if var_19_16 > 0 and var_19_10 < var_19_16 then
					arg_16_1.talkMaxDuration = var_19_16

					if var_19_16 + var_19_9 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_16 + var_19_9
					end
				end

				arg_16_1.text_.text = var_19_13
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111004", "story_v_out_324111.awb") ~= 0 then
					local var_19_17 = manager.audio:GetVoiceLength("story_v_out_324111", "324111004", "story_v_out_324111.awb") / 1000

					if var_19_17 + var_19_9 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_17 + var_19_9
					end

					if var_19_12.prefab_name ~= "" and arg_16_1.actors_[var_19_12.prefab_name] ~= nil then
						local var_19_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_12.prefab_name].transform, "story_v_out_324111", "324111004", "story_v_out_324111.awb")

						arg_16_1:RecordAudio("324111004", var_19_18)
						arg_16_1:RecordAudio("324111004", var_19_18)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324111", "324111004", "story_v_out_324111.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324111", "324111004", "story_v_out_324111.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_19 = math.max(var_19_10, arg_16_1.talkMaxDuration)

			if var_19_9 <= arg_16_1.time_ and arg_16_1.time_ < var_19_9 + var_19_19 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_9) / var_19_19

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_9 + var_19_19 and arg_16_1.time_ < var_19_9 + var_19_19 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play324111005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324111005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324111006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["6148ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect6148ui_story == nil then
				arg_20_1.var_.characterEffect6148ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect6148ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_20_1.var_.characterEffect6148ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect6148ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_20_1.var_.characterEffect6148ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 1.75

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_8 = arg_20_1:GetWordFromCfg(324111005)
				local var_23_9 = arg_20_1:FormatText(var_23_8.content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_10 = 70
				local var_23_11 = utf8.len(var_23_9)
				local var_23_12 = var_23_10 <= 0 and var_23_7 or var_23_7 * (var_23_11 / var_23_10)

				if var_23_12 > 0 and var_23_7 < var_23_12 then
					arg_20_1.talkMaxDuration = var_23_12

					if var_23_12 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_13 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_13 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_13

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_13 and arg_20_1.time_ < var_23_6 + var_23_13 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324111006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324111006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324111007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.25

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[7].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(324111006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 10
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_8 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_8 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_8

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_8 and arg_24_1.time_ < var_27_0 + var_27_8 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324111007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324111007
		arg_28_1.duration_ = 3.57

		local var_28_0 = {
			zh = 3.566,
			ja = 3.5
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
				arg_28_0:Play324111008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["6148ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos6148ui_story = var_31_0.localPosition

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end
			end

			local var_31_3 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_3 then
				local var_31_4 = (arg_28_1.time_ - var_31_1) / var_31_3
				local var_31_5 = Vector3.New(0, -0.985, -6)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos6148ui_story, var_31_5, var_31_4)

				local var_31_6 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_6.x, var_31_6.y, var_31_6.z)

				local var_31_7 = var_31_0.localEulerAngles

				var_31_7.z = 0
				var_31_7.x = 0
				var_31_0.localEulerAngles = var_31_7
			end

			if arg_28_1.time_ >= var_31_1 + var_31_3 and arg_28_1.time_ < var_31_1 + var_31_3 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_31_8 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_8.x, var_31_8.y, var_31_8.z)

				local var_31_9 = var_31_0.localEulerAngles

				var_31_9.z = 0
				var_31_9.x = 0
				var_31_0.localEulerAngles = var_31_9

				local var_31_10 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_10 then
					var_31_10:EnableDynamicBone(true)
				end
			end

			local var_31_11 = arg_28_1.actors_["6148ui_story"]
			local var_31_12 = 0

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.characterEffect6148ui_story == nil then
				arg_28_1.var_.characterEffect6148ui_story = var_31_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_13 = 0.200000002980232

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_13 and not isNil(var_31_11) then
				local var_31_14 = (arg_28_1.time_ - var_31_12) / var_31_13

				if arg_28_1.var_.characterEffect6148ui_story and not isNil(var_31_11) then
					arg_28_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_12 + var_31_13 and arg_28_1.time_ < var_31_12 + var_31_13 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.characterEffect6148ui_story then
				arg_28_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_31_15 = 0

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_31_16 = 0

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_31_17 = 0
			local var_31_18 = 0.2

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_19 = arg_28_1:FormatText(StoryNameCfg[1488].name)

				arg_28_1.leftNameTxt_.text = var_31_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_20 = arg_28_1:GetWordFromCfg(324111007)
				local var_31_21 = arg_28_1:FormatText(var_31_20.content)

				arg_28_1.text_.text = var_31_21

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_22 = 8
				local var_31_23 = utf8.len(var_31_21)
				local var_31_24 = var_31_22 <= 0 and var_31_18 or var_31_18 * (var_31_23 / var_31_22)

				if var_31_24 > 0 and var_31_18 < var_31_24 then
					arg_28_1.talkMaxDuration = var_31_24

					if var_31_24 + var_31_17 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_24 + var_31_17
					end
				end

				arg_28_1.text_.text = var_31_21
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111007", "story_v_out_324111.awb") ~= 0 then
					local var_31_25 = manager.audio:GetVoiceLength("story_v_out_324111", "324111007", "story_v_out_324111.awb") / 1000

					if var_31_25 + var_31_17 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_25 + var_31_17
					end

					if var_31_20.prefab_name ~= "" and arg_28_1.actors_[var_31_20.prefab_name] ~= nil then
						local var_31_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_20.prefab_name].transform, "story_v_out_324111", "324111007", "story_v_out_324111.awb")

						arg_28_1:RecordAudio("324111007", var_31_26)
						arg_28_1:RecordAudio("324111007", var_31_26)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324111", "324111007", "story_v_out_324111.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324111", "324111007", "story_v_out_324111.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_27 = math.max(var_31_18, arg_28_1.talkMaxDuration)

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_27 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_17) / var_31_27

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_17 + var_31_27 and arg_28_1.time_ < var_31_17 + var_31_27 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play324111008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324111008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play324111009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["6148ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect6148ui_story == nil then
				arg_32_1.var_.characterEffect6148ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect6148ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_32_1.var_.characterEffect6148ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect6148ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_32_1.var_.characterEffect6148ui_story.fillRatio = var_35_5
			end

			local var_35_6 = 0
			local var_35_7 = 0.775

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_8 = arg_32_1:FormatText(StoryNameCfg[7].name)

				arg_32_1.leftNameTxt_.text = var_35_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_9 = arg_32_1:GetWordFromCfg(324111008)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 31
				local var_35_12 = utf8.len(var_35_10)
				local var_35_13 = var_35_11 <= 0 and var_35_7 or var_35_7 * (var_35_12 / var_35_11)

				if var_35_13 > 0 and var_35_7 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_14 and arg_32_1.time_ < var_35_6 + var_35_14 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play324111009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324111009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play324111010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.925

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[7].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(324111009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 37
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_8 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_8 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_8

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_8 and arg_36_1.time_ < var_39_0 + var_39_8 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play324111010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324111010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play324111011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 1.45

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(324111010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 58
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_8 and arg_40_1.time_ < var_43_0 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play324111011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324111011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play324111012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["6148ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos6148ui_story = var_47_0.localPosition

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end
			end

			local var_47_3 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_3 then
				local var_47_4 = (arg_44_1.time_ - var_47_1) / var_47_3
				local var_47_5 = Vector3.New(0, 100, 0)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos6148ui_story, var_47_5, var_47_4)

				local var_47_6 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_6.x, var_47_6.y, var_47_6.z)

				local var_47_7 = var_47_0.localEulerAngles

				var_47_7.z = 0
				var_47_7.x = 0
				var_47_0.localEulerAngles = var_47_7
			end

			if arg_44_1.time_ >= var_47_1 + var_47_3 and arg_44_1.time_ < var_47_1 + var_47_3 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, 100, 0)

				local var_47_8 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_8.x, var_47_8.y, var_47_8.z)

				local var_47_9 = var_47_0.localEulerAngles

				var_47_9.z = 0
				var_47_9.x = 0
				var_47_0.localEulerAngles = var_47_9

				local var_47_10 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_10 then
					var_47_10:EnableDynamicBone(true)
				end
			end

			local var_47_11 = 0
			local var_47_12 = 0.85

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_13 = arg_44_1:GetWordFromCfg(324111011)
				local var_47_14 = arg_44_1:FormatText(var_47_13.content)

				arg_44_1.text_.text = var_47_14

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_15 = 34
				local var_47_16 = utf8.len(var_47_14)
				local var_47_17 = var_47_15 <= 0 and var_47_12 or var_47_12 * (var_47_16 / var_47_15)

				if var_47_17 > 0 and var_47_12 < var_47_17 then
					arg_44_1.talkMaxDuration = var_47_17

					if var_47_17 + var_47_11 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_17 + var_47_11
					end
				end

				arg_44_1.text_.text = var_47_14
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_18 = math.max(var_47_12, arg_44_1.talkMaxDuration)

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_18 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_11) / var_47_18

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_11 + var_47_18 and arg_44_1.time_ < var_47_11 + var_47_18 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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

		arg_44_1:InitPlayNodeList()
	end,
	Play324111012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324111012
		arg_48_1.duration_ = 4.83

		local var_48_0 = {
			zh = 4.133,
			ja = 4.833
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
				arg_48_0:Play324111013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = "1054ui_story"

			if arg_48_1.actors_[var_51_0] == nil then
				local var_51_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_51_1) then
					local var_51_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_48_1.stage_.transform)

					var_51_2.name = var_51_0
					var_51_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_48_1.actors_[var_51_0] = var_51_2

					local var_51_3 = var_51_2:GetComponentInChildren(typeof(CharacterEffect))

					var_51_3.enabled = true

					local var_51_4 = GameObjectTools.GetOrAddComponent(var_51_2, typeof(DynamicBoneHelper))

					if var_51_4 then
						var_51_4:EnableDynamicBone(false)
					end

					arg_48_1:ShowWeapon(var_51_3.transform, false)

					arg_48_1.var_[var_51_0 .. "Animator"] = var_51_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_48_1.var_[var_51_0 .. "Animator"].applyRootMotion = true
					arg_48_1.var_[var_51_0 .. "LipSync"] = var_51_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_51_5 = arg_48_1.actors_["1054ui_story"].transform
			local var_51_6 = 0

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.var_.moveOldPos1054ui_story = var_51_5.localPosition

				local var_51_7 = GameObjectTools.GetOrAddComponent(var_51_5.gameObject, typeof(DynamicBoneHelper))

				if var_51_7 then
					var_51_7:EnableDynamicBone(false)
				end
			end

			local var_51_8 = 0.001

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_8 then
				local var_51_9 = (arg_48_1.time_ - var_51_6) / var_51_8
				local var_51_10 = Vector3.New(0, -0.985, -6)

				var_51_5.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1054ui_story, var_51_10, var_51_9)

				local var_51_11 = manager.ui.mainCamera.transform.position - var_51_5.position

				var_51_5.forward = Vector3.New(var_51_11.x, var_51_11.y, var_51_11.z)

				local var_51_12 = var_51_5.localEulerAngles

				var_51_12.z = 0
				var_51_12.x = 0
				var_51_5.localEulerAngles = var_51_12
			end

			if arg_48_1.time_ >= var_51_6 + var_51_8 and arg_48_1.time_ < var_51_6 + var_51_8 + arg_51_0 then
				var_51_5.localPosition = Vector3.New(0, -0.985, -6)

				local var_51_13 = manager.ui.mainCamera.transform.position - var_51_5.position

				var_51_5.forward = Vector3.New(var_51_13.x, var_51_13.y, var_51_13.z)

				local var_51_14 = var_51_5.localEulerAngles

				var_51_14.z = 0
				var_51_14.x = 0
				var_51_5.localEulerAngles = var_51_14

				local var_51_15 = GameObjectTools.GetOrAddComponent(var_51_5.gameObject, typeof(DynamicBoneHelper))

				if var_51_15 then
					var_51_15:EnableDynamicBone(true)
				end
			end

			local var_51_16 = arg_48_1.actors_["1054ui_story"]
			local var_51_17 = 0

			if var_51_17 < arg_48_1.time_ and arg_48_1.time_ <= var_51_17 + arg_51_0 and not isNil(var_51_16) and arg_48_1.var_.characterEffect1054ui_story == nil then
				arg_48_1.var_.characterEffect1054ui_story = var_51_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_18 = 0.200000002980232

			if var_51_17 <= arg_48_1.time_ and arg_48_1.time_ < var_51_17 + var_51_18 and not isNil(var_51_16) then
				local var_51_19 = (arg_48_1.time_ - var_51_17) / var_51_18

				if arg_48_1.var_.characterEffect1054ui_story and not isNil(var_51_16) then
					arg_48_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_17 + var_51_18 and arg_48_1.time_ < var_51_17 + var_51_18 + arg_51_0 and not isNil(var_51_16) and arg_48_1.var_.characterEffect1054ui_story then
				arg_48_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_51_20 = 0

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_51_21 = 0

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 then
				arg_48_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_51_22 = 0
			local var_51_23 = 0.425

			if var_51_22 < arg_48_1.time_ and arg_48_1.time_ <= var_51_22 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_24 = arg_48_1:FormatText(StoryNameCfg[1487].name)

				arg_48_1.leftNameTxt_.text = var_51_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_25 = arg_48_1:GetWordFromCfg(324111012)
				local var_51_26 = arg_48_1:FormatText(var_51_25.content)

				arg_48_1.text_.text = var_51_26

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_27 = 17
				local var_51_28 = utf8.len(var_51_26)
				local var_51_29 = var_51_27 <= 0 and var_51_23 or var_51_23 * (var_51_28 / var_51_27)

				if var_51_29 > 0 and var_51_23 < var_51_29 then
					arg_48_1.talkMaxDuration = var_51_29

					if var_51_29 + var_51_22 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_29 + var_51_22
					end
				end

				arg_48_1.text_.text = var_51_26
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111012", "story_v_out_324111.awb") ~= 0 then
					local var_51_30 = manager.audio:GetVoiceLength("story_v_out_324111", "324111012", "story_v_out_324111.awb") / 1000

					if var_51_30 + var_51_22 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_30 + var_51_22
					end

					if var_51_25.prefab_name ~= "" and arg_48_1.actors_[var_51_25.prefab_name] ~= nil then
						local var_51_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_25.prefab_name].transform, "story_v_out_324111", "324111012", "story_v_out_324111.awb")

						arg_48_1:RecordAudio("324111012", var_51_31)
						arg_48_1:RecordAudio("324111012", var_51_31)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324111", "324111012", "story_v_out_324111.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324111", "324111012", "story_v_out_324111.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_32 = math.max(var_51_23, arg_48_1.talkMaxDuration)

			if var_51_22 <= arg_48_1.time_ and arg_48_1.time_ < var_51_22 + var_51_32 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_22) / var_51_32

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_22 + var_51_32 and arg_48_1.time_ < var_51_22 + var_51_32 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play324111013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324111013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play324111014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1054ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1054ui_story == nil then
				arg_52_1.var_.characterEffect1054ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1054ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1054ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1054ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1054ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0
			local var_55_7 = 0.6

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_9 = arg_52_1:GetWordFromCfg(324111013)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 24
				local var_55_12 = utf8.len(var_55_10)
				local var_55_13 = var_55_11 <= 0 and var_55_7 or var_55_7 * (var_55_12 / var_55_11)

				if var_55_13 > 0 and var_55_7 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_10
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_14 and arg_52_1.time_ < var_55_6 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324111014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324111014
		arg_56_1.duration_ = 13.57

		local var_56_0 = {
			zh = 10.8,
			ja = 13.566
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
				arg_56_0:Play324111015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1054ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1054ui_story == nil then
				arg_56_1.var_.characterEffect1054ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1054ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1054ui_story then
				arg_56_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_59_4 = 0

			if var_59_4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_59_6 = 0
			local var_59_7 = 0.85

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[1487].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_9 = arg_56_1:GetWordFromCfg(324111014)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 34
				local var_59_12 = utf8.len(var_59_10)
				local var_59_13 = var_59_11 <= 0 and var_59_7 or var_59_7 * (var_59_12 / var_59_11)

				if var_59_13 > 0 and var_59_7 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111014", "story_v_out_324111.awb") ~= 0 then
					local var_59_14 = manager.audio:GetVoiceLength("story_v_out_324111", "324111014", "story_v_out_324111.awb") / 1000

					if var_59_14 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_14 + var_59_6
					end

					if var_59_9.prefab_name ~= "" and arg_56_1.actors_[var_59_9.prefab_name] ~= nil then
						local var_59_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_9.prefab_name].transform, "story_v_out_324111", "324111014", "story_v_out_324111.awb")

						arg_56_1:RecordAudio("324111014", var_59_15)
						arg_56_1:RecordAudio("324111014", var_59_15)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_324111", "324111014", "story_v_out_324111.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_324111", "324111014", "story_v_out_324111.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_16 and arg_56_1.time_ < var_59_6 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play324111015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324111015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play324111016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1054ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1054ui_story == nil then
				arg_60_1.var_.characterEffect1054ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1054ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1054ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1054ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1054ui_story.fillRatio = var_63_5
			end

			local var_63_6 = 0
			local var_63_7 = 0.175

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

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_9 = arg_60_1:GetWordFromCfg(324111015)
				local var_63_10 = arg_60_1:FormatText(var_63_9.content)

				arg_60_1.text_.text = var_63_10

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 7
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
	Play324111016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324111016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play324111017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1054ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1054ui_story = var_67_0.localPosition

				local var_67_2 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(false)
				end
			end

			local var_67_3 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_3 then
				local var_67_4 = (arg_64_1.time_ - var_67_1) / var_67_3
				local var_67_5 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1054ui_story, var_67_5, var_67_4)

				local var_67_6 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_6.x, var_67_6.y, var_67_6.z)

				local var_67_7 = var_67_0.localEulerAngles

				var_67_7.z = 0
				var_67_7.x = 0
				var_67_0.localEulerAngles = var_67_7
			end

			if arg_64_1.time_ >= var_67_1 + var_67_3 and arg_64_1.time_ < var_67_1 + var_67_3 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_8 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_8.x, var_67_8.y, var_67_8.z)

				local var_67_9 = var_67_0.localEulerAngles

				var_67_9.z = 0
				var_67_9.x = 0
				var_67_0.localEulerAngles = var_67_9

				local var_67_10 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_10 then
					var_67_10:EnableDynamicBone(true)
				end
			end

			local var_67_11 = 0
			local var_67_12 = 1.175

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_13 = arg_64_1:GetWordFromCfg(324111016)
				local var_67_14 = arg_64_1:FormatText(var_67_13.content)

				arg_64_1.text_.text = var_67_14

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_15 = 47
				local var_67_16 = utf8.len(var_67_14)
				local var_67_17 = var_67_15 <= 0 and var_67_12 or var_67_12 * (var_67_16 / var_67_15)

				if var_67_17 > 0 and var_67_12 < var_67_17 then
					arg_64_1.talkMaxDuration = var_67_17

					if var_67_17 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_11
					end
				end

				arg_64_1.text_.text = var_67_14
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_18 = math.max(var_67_12, arg_64_1.talkMaxDuration)

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_18 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_11) / var_67_18

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_11 + var_67_18 and arg_64_1.time_ < var_67_11 + var_67_18 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play324111017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324111017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play324111018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.975

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(324111017)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 39
				local var_71_5 = utf8.len(var_71_3)
				local var_71_6 = var_71_4 <= 0 and var_71_1 or var_71_1 * (var_71_5 / var_71_4)

				if var_71_6 > 0 and var_71_1 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_7 and arg_68_1.time_ < var_71_0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play324111018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324111018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play324111019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.7

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[7].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:GetWordFromCfg(324111018)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 28
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
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_8 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_8 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_8

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_8 and arg_72_1.time_ < var_75_0 + var_75_8 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play324111019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324111019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play324111020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 1.175

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[7].name)

				arg_76_1.leftNameTxt_.text = var_79_2

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

				local var_79_3 = arg_76_1:GetWordFromCfg(324111019)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 47
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_8 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_8 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_8

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_8 and arg_76_1.time_ < var_79_0 + var_79_8 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play324111020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 324111020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play324111021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 1.225

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[7].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(324111020)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 49
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_8 and arg_80_1.time_ < var_83_0 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play324111021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 324111021
		arg_84_1.duration_ = 4.37

		local var_84_0 = {
			zh = 4.166,
			ja = 4.366
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play324111022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["6148ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos6148ui_story = var_87_0.localPosition

				local var_87_2 = GameObjectTools.GetOrAddComponent(var_87_0.gameObject, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(false)
				end
			end

			local var_87_3 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_3 then
				local var_87_4 = (arg_84_1.time_ - var_87_1) / var_87_3
				local var_87_5 = Vector3.New(0, -0.985, -6)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos6148ui_story, var_87_5, var_87_4)

				local var_87_6 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_6.x, var_87_6.y, var_87_6.z)

				local var_87_7 = var_87_0.localEulerAngles

				var_87_7.z = 0
				var_87_7.x = 0
				var_87_0.localEulerAngles = var_87_7
			end

			if arg_84_1.time_ >= var_87_1 + var_87_3 and arg_84_1.time_ < var_87_1 + var_87_3 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_87_8 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_8.x, var_87_8.y, var_87_8.z)

				local var_87_9 = var_87_0.localEulerAngles

				var_87_9.z = 0
				var_87_9.x = 0
				var_87_0.localEulerAngles = var_87_9

				local var_87_10 = GameObjectTools.GetOrAddComponent(var_87_0.gameObject, typeof(DynamicBoneHelper))

				if var_87_10 then
					var_87_10:EnableDynamicBone(true)
				end
			end

			local var_87_11 = arg_84_1.actors_["6148ui_story"]
			local var_87_12 = 0

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 and not isNil(var_87_11) and arg_84_1.var_.characterEffect6148ui_story == nil then
				arg_84_1.var_.characterEffect6148ui_story = var_87_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_13 = 0.200000002980232

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_13 and not isNil(var_87_11) then
				local var_87_14 = (arg_84_1.time_ - var_87_12) / var_87_13

				if arg_84_1.var_.characterEffect6148ui_story and not isNil(var_87_11) then
					arg_84_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_12 + var_87_13 and arg_84_1.time_ < var_87_12 + var_87_13 + arg_87_0 and not isNil(var_87_11) and arg_84_1.var_.characterEffect6148ui_story then
				arg_84_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_87_15 = 0

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_87_16 = 0
			local var_87_17 = 0.425

			if var_87_16 < arg_84_1.time_ and arg_84_1.time_ <= var_87_16 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_18 = arg_84_1:FormatText(StoryNameCfg[1488].name)

				arg_84_1.leftNameTxt_.text = var_87_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_19 = arg_84_1:GetWordFromCfg(324111021)
				local var_87_20 = arg_84_1:FormatText(var_87_19.content)

				arg_84_1.text_.text = var_87_20

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_21 = 17
				local var_87_22 = utf8.len(var_87_20)
				local var_87_23 = var_87_21 <= 0 and var_87_17 or var_87_17 * (var_87_22 / var_87_21)

				if var_87_23 > 0 and var_87_17 < var_87_23 then
					arg_84_1.talkMaxDuration = var_87_23

					if var_87_23 + var_87_16 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_16
					end
				end

				arg_84_1.text_.text = var_87_20
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111021", "story_v_out_324111.awb") ~= 0 then
					local var_87_24 = manager.audio:GetVoiceLength("story_v_out_324111", "324111021", "story_v_out_324111.awb") / 1000

					if var_87_24 + var_87_16 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_24 + var_87_16
					end

					if var_87_19.prefab_name ~= "" and arg_84_1.actors_[var_87_19.prefab_name] ~= nil then
						local var_87_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_19.prefab_name].transform, "story_v_out_324111", "324111021", "story_v_out_324111.awb")

						arg_84_1:RecordAudio("324111021", var_87_25)
						arg_84_1:RecordAudio("324111021", var_87_25)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_324111", "324111021", "story_v_out_324111.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_324111", "324111021", "story_v_out_324111.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_26 = math.max(var_87_17, arg_84_1.talkMaxDuration)

			if var_87_16 <= arg_84_1.time_ and arg_84_1.time_ < var_87_16 + var_87_26 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_16) / var_87_26

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_16 + var_87_26 and arg_84_1.time_ < var_87_16 + var_87_26 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play324111022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 324111022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play324111023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["6148ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect6148ui_story == nil then
				arg_88_1.var_.characterEffect6148ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect6148ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_88_1.var_.characterEffect6148ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect6148ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_88_1.var_.characterEffect6148ui_story.fillRatio = var_91_5
			end

			local var_91_6 = 0
			local var_91_7 = 1.075

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_8 = arg_88_1:FormatText(StoryNameCfg[7].name)

				arg_88_1.leftNameTxt_.text = var_91_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_9 = arg_88_1:GetWordFromCfg(324111022)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 43
				local var_91_12 = utf8.len(var_91_10)
				local var_91_13 = var_91_11 <= 0 and var_91_7 or var_91_7 * (var_91_12 / var_91_11)

				if var_91_13 > 0 and var_91_7 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_10
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_14 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_14 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_14

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_14 and arg_88_1.time_ < var_91_6 + var_91_14 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play324111023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 324111023
		arg_92_1.duration_ = 12.67

		local var_92_0 = {
			zh = 8.6,
			ja = 12.666
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play324111024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["6148ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos6148ui_story = var_95_0.localPosition

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end
			end

			local var_95_3 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_3 then
				local var_95_4 = (arg_92_1.time_ - var_95_1) / var_95_3
				local var_95_5 = Vector3.New(-0.7, -0.985, -6)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos6148ui_story, var_95_5, var_95_4)

				local var_95_6 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_6.x, var_95_6.y, var_95_6.z)

				local var_95_7 = var_95_0.localEulerAngles

				var_95_7.z = 0
				var_95_7.x = 0
				var_95_0.localEulerAngles = var_95_7
			end

			if arg_92_1.time_ >= var_95_1 + var_95_3 and arg_92_1.time_ < var_95_1 + var_95_3 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_95_8 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_8.x, var_95_8.y, var_95_8.z)

				local var_95_9 = var_95_0.localEulerAngles

				var_95_9.z = 0
				var_95_9.x = 0
				var_95_0.localEulerAngles = var_95_9

				local var_95_10 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_10 then
					var_95_10:EnableDynamicBone(true)
				end
			end

			local var_95_11 = arg_92_1.actors_["1054ui_story"].transform
			local var_95_12 = 0

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 then
				arg_92_1.var_.moveOldPos1054ui_story = var_95_11.localPosition

				local var_95_13 = GameObjectTools.GetOrAddComponent(var_95_11.gameObject, typeof(DynamicBoneHelper))

				if var_95_13 then
					var_95_13:EnableDynamicBone(false)
				end
			end

			local var_95_14 = 0.001

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_14 then
				local var_95_15 = (arg_92_1.time_ - var_95_12) / var_95_14
				local var_95_16 = Vector3.New(0.7, -0.985, -6)

				var_95_11.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1054ui_story, var_95_16, var_95_15)

				local var_95_17 = manager.ui.mainCamera.transform.position - var_95_11.position

				var_95_11.forward = Vector3.New(var_95_17.x, var_95_17.y, var_95_17.z)

				local var_95_18 = var_95_11.localEulerAngles

				var_95_18.z = 0
				var_95_18.x = 0
				var_95_11.localEulerAngles = var_95_18
			end

			if arg_92_1.time_ >= var_95_12 + var_95_14 and arg_92_1.time_ < var_95_12 + var_95_14 + arg_95_0 then
				var_95_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_95_19 = manager.ui.mainCamera.transform.position - var_95_11.position

				var_95_11.forward = Vector3.New(var_95_19.x, var_95_19.y, var_95_19.z)

				local var_95_20 = var_95_11.localEulerAngles

				var_95_20.z = 0
				var_95_20.x = 0
				var_95_11.localEulerAngles = var_95_20

				local var_95_21 = GameObjectTools.GetOrAddComponent(var_95_11.gameObject, typeof(DynamicBoneHelper))

				if var_95_21 then
					var_95_21:EnableDynamicBone(true)
				end
			end

			local var_95_22 = arg_92_1.actors_["1054ui_story"]
			local var_95_23 = 0

			if var_95_23 < arg_92_1.time_ and arg_92_1.time_ <= var_95_23 + arg_95_0 and not isNil(var_95_22) and arg_92_1.var_.characterEffect1054ui_story == nil then
				arg_92_1.var_.characterEffect1054ui_story = var_95_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_24 = 0.200000002980232

			if var_95_23 <= arg_92_1.time_ and arg_92_1.time_ < var_95_23 + var_95_24 and not isNil(var_95_22) then
				local var_95_25 = (arg_92_1.time_ - var_95_23) / var_95_24

				if arg_92_1.var_.characterEffect1054ui_story and not isNil(var_95_22) then
					arg_92_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_23 + var_95_24 and arg_92_1.time_ < var_95_23 + var_95_24 + arg_95_0 and not isNil(var_95_22) and arg_92_1.var_.characterEffect1054ui_story then
				arg_92_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_95_26 = 0

			if var_95_26 < arg_92_1.time_ and arg_92_1.time_ <= var_95_26 + arg_95_0 then
				arg_92_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action463")
			end

			local var_95_27 = 0

			if var_95_27 < arg_92_1.time_ and arg_92_1.time_ <= var_95_27 + arg_95_0 then
				arg_92_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_95_28 = 0
			local var_95_29 = 0.825

			if var_95_28 < arg_92_1.time_ and arg_92_1.time_ <= var_95_28 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_30 = arg_92_1:FormatText(StoryNameCfg[1487].name)

				arg_92_1.leftNameTxt_.text = var_95_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_31 = arg_92_1:GetWordFromCfg(324111023)
				local var_95_32 = arg_92_1:FormatText(var_95_31.content)

				arg_92_1.text_.text = var_95_32

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_33 = 33
				local var_95_34 = utf8.len(var_95_32)
				local var_95_35 = var_95_33 <= 0 and var_95_29 or var_95_29 * (var_95_34 / var_95_33)

				if var_95_35 > 0 and var_95_29 < var_95_35 then
					arg_92_1.talkMaxDuration = var_95_35

					if var_95_35 + var_95_28 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_35 + var_95_28
					end
				end

				arg_92_1.text_.text = var_95_32
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111023", "story_v_out_324111.awb") ~= 0 then
					local var_95_36 = manager.audio:GetVoiceLength("story_v_out_324111", "324111023", "story_v_out_324111.awb") / 1000

					if var_95_36 + var_95_28 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_36 + var_95_28
					end

					if var_95_31.prefab_name ~= "" and arg_92_1.actors_[var_95_31.prefab_name] ~= nil then
						local var_95_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_31.prefab_name].transform, "story_v_out_324111", "324111023", "story_v_out_324111.awb")

						arg_92_1:RecordAudio("324111023", var_95_37)
						arg_92_1:RecordAudio("324111023", var_95_37)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_324111", "324111023", "story_v_out_324111.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_324111", "324111023", "story_v_out_324111.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_38 = math.max(var_95_29, arg_92_1.talkMaxDuration)

			if var_95_28 <= arg_92_1.time_ and arg_92_1.time_ < var_95_28 + var_95_38 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_28) / var_95_38

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_28 + var_95_38 and arg_92_1.time_ < var_95_28 + var_95_38 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play324111024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 324111024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play324111025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1054ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1054ui_story == nil then
				arg_96_1.var_.characterEffect1054ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1054ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1054ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1054ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1054ui_story.fillRatio = var_99_5
			end

			local var_99_6 = 0
			local var_99_7 = 0.95

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[7].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_9 = arg_96_1:GetWordFromCfg(324111024)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 38
				local var_99_12 = utf8.len(var_99_10)
				local var_99_13 = var_99_11 <= 0 and var_99_7 or var_99_7 * (var_99_12 / var_99_11)

				if var_99_13 > 0 and var_99_7 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_14 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_14 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_14

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_14 and arg_96_1.time_ < var_99_6 + var_99_14 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play324111025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 324111025
		arg_100_1.duration_ = 2

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play324111026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1054ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1054ui_story == nil then
				arg_100_1.var_.characterEffect1054ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1054ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1054ui_story then
				arg_100_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_103_4 = 0

			if var_103_4 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_2")
			end

			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_103_6 = 0
			local var_103_7 = 0.075

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[1487].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_9 = arg_100_1:GetWordFromCfg(324111025)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 3
				local var_103_12 = utf8.len(var_103_10)
				local var_103_13 = var_103_11 <= 0 and var_103_7 or var_103_7 * (var_103_12 / var_103_11)

				if var_103_13 > 0 and var_103_7 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_10
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111025", "story_v_out_324111.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_324111", "324111025", "story_v_out_324111.awb") / 1000

					if var_103_14 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_6
					end

					if var_103_9.prefab_name ~= "" and arg_100_1.actors_[var_103_9.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_9.prefab_name].transform, "story_v_out_324111", "324111025", "story_v_out_324111.awb")

						arg_100_1:RecordAudio("324111025", var_103_15)
						arg_100_1:RecordAudio("324111025", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_324111", "324111025", "story_v_out_324111.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_324111", "324111025", "story_v_out_324111.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_16 and arg_100_1.time_ < var_103_6 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play324111026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 324111026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play324111027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1054ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1054ui_story = var_107_0.localPosition

				local var_107_2 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(false)
				end
			end

			local var_107_3 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_3 then
				local var_107_4 = (arg_104_1.time_ - var_107_1) / var_107_3
				local var_107_5 = Vector3.New(0, 100, 0)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1054ui_story, var_107_5, var_107_4)

				local var_107_6 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_6.x, var_107_6.y, var_107_6.z)

				local var_107_7 = var_107_0.localEulerAngles

				var_107_7.z = 0
				var_107_7.x = 0
				var_107_0.localEulerAngles = var_107_7
			end

			if arg_104_1.time_ >= var_107_1 + var_107_3 and arg_104_1.time_ < var_107_1 + var_107_3 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, 100, 0)

				local var_107_8 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_8.x, var_107_8.y, var_107_8.z)

				local var_107_9 = var_107_0.localEulerAngles

				var_107_9.z = 0
				var_107_9.x = 0
				var_107_0.localEulerAngles = var_107_9

				local var_107_10 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_10 then
					var_107_10:EnableDynamicBone(true)
				end
			end

			local var_107_11 = arg_104_1.actors_["6148ui_story"].transform
			local var_107_12 = 0

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 then
				arg_104_1.var_.moveOldPos6148ui_story = var_107_11.localPosition

				local var_107_13 = GameObjectTools.GetOrAddComponent(var_107_11.gameObject, typeof(DynamicBoneHelper))

				if var_107_13 then
					var_107_13:EnableDynamicBone(false)
				end
			end

			local var_107_14 = 0.001

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_14 then
				local var_107_15 = (arg_104_1.time_ - var_107_12) / var_107_14
				local var_107_16 = Vector3.New(0, 100, 0)

				var_107_11.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos6148ui_story, var_107_16, var_107_15)

				local var_107_17 = manager.ui.mainCamera.transform.position - var_107_11.position

				var_107_11.forward = Vector3.New(var_107_17.x, var_107_17.y, var_107_17.z)

				local var_107_18 = var_107_11.localEulerAngles

				var_107_18.z = 0
				var_107_18.x = 0
				var_107_11.localEulerAngles = var_107_18
			end

			if arg_104_1.time_ >= var_107_12 + var_107_14 and arg_104_1.time_ < var_107_12 + var_107_14 + arg_107_0 then
				var_107_11.localPosition = Vector3.New(0, 100, 0)

				local var_107_19 = manager.ui.mainCamera.transform.position - var_107_11.position

				var_107_11.forward = Vector3.New(var_107_19.x, var_107_19.y, var_107_19.z)

				local var_107_20 = var_107_11.localEulerAngles

				var_107_20.z = 0
				var_107_20.x = 0
				var_107_11.localEulerAngles = var_107_20

				local var_107_21 = GameObjectTools.GetOrAddComponent(var_107_11.gameObject, typeof(DynamicBoneHelper))

				if var_107_21 then
					var_107_21:EnableDynamicBone(true)
				end
			end

			local var_107_22 = arg_104_1.actors_["1054ui_story"]
			local var_107_23 = 0

			if var_107_23 < arg_104_1.time_ and arg_104_1.time_ <= var_107_23 + arg_107_0 and not isNil(var_107_22) and arg_104_1.var_.characterEffect1054ui_story == nil then
				arg_104_1.var_.characterEffect1054ui_story = var_107_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_24 = 0.200000002980232

			if var_107_23 <= arg_104_1.time_ and arg_104_1.time_ < var_107_23 + var_107_24 and not isNil(var_107_22) then
				local var_107_25 = (arg_104_1.time_ - var_107_23) / var_107_24

				if arg_104_1.var_.characterEffect1054ui_story and not isNil(var_107_22) then
					local var_107_26 = Mathf.Lerp(0, 0.5, var_107_25)

					arg_104_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1054ui_story.fillRatio = var_107_26
				end
			end

			if arg_104_1.time_ >= var_107_23 + var_107_24 and arg_104_1.time_ < var_107_23 + var_107_24 + arg_107_0 and not isNil(var_107_22) and arg_104_1.var_.characterEffect1054ui_story then
				local var_107_27 = 0.5

				arg_104_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1054ui_story.fillRatio = var_107_27
			end

			local var_107_28 = 0
			local var_107_29 = 1

			if var_107_28 < arg_104_1.time_ and arg_104_1.time_ <= var_107_28 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_30 = arg_104_1:GetWordFromCfg(324111026)
				local var_107_31 = arg_104_1:FormatText(var_107_30.content)

				arg_104_1.text_.text = var_107_31

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_32 = 40
				local var_107_33 = utf8.len(var_107_31)
				local var_107_34 = var_107_32 <= 0 and var_107_29 or var_107_29 * (var_107_33 / var_107_32)

				if var_107_34 > 0 and var_107_29 < var_107_34 then
					arg_104_1.talkMaxDuration = var_107_34

					if var_107_34 + var_107_28 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_34 + var_107_28
					end
				end

				arg_104_1.text_.text = var_107_31
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_35 = math.max(var_107_29, arg_104_1.talkMaxDuration)

			if var_107_28 <= arg_104_1.time_ and arg_104_1.time_ < var_107_28 + var_107_35 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_28) / var_107_35

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_28 + var_107_35 and arg_104_1.time_ < var_107_28 + var_107_35 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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

		arg_104_1:InitPlayNodeList()
	end,
	Play324111027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 324111027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play324111028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.375

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[7].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(324111027)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 15
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_8 and arg_108_1.time_ < var_111_0 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play324111028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 324111028
		arg_112_1.duration_ = 4.03

		local var_112_0 = {
			zh = 3.366,
			ja = 4.033
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play324111029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["6148ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos6148ui_story = var_115_0.localPosition

				local var_115_2 = GameObjectTools.GetOrAddComponent(var_115_0.gameObject, typeof(DynamicBoneHelper))

				if var_115_2 then
					var_115_2:EnableDynamicBone(false)
				end
			end

			local var_115_3 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_3 then
				local var_115_4 = (arg_112_1.time_ - var_115_1) / var_115_3
				local var_115_5 = Vector3.New(-0.7, -0.985, -6)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos6148ui_story, var_115_5, var_115_4)

				local var_115_6 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_6.x, var_115_6.y, var_115_6.z)

				local var_115_7 = var_115_0.localEulerAngles

				var_115_7.z = 0
				var_115_7.x = 0
				var_115_0.localEulerAngles = var_115_7
			end

			if arg_112_1.time_ >= var_115_1 + var_115_3 and arg_112_1.time_ < var_115_1 + var_115_3 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_115_8 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_8.x, var_115_8.y, var_115_8.z)

				local var_115_9 = var_115_0.localEulerAngles

				var_115_9.z = 0
				var_115_9.x = 0
				var_115_0.localEulerAngles = var_115_9

				local var_115_10 = GameObjectTools.GetOrAddComponent(var_115_0.gameObject, typeof(DynamicBoneHelper))

				if var_115_10 then
					var_115_10:EnableDynamicBone(true)
				end
			end

			local var_115_11 = arg_112_1.actors_["6148ui_story"]
			local var_115_12 = 0

			if var_115_12 < arg_112_1.time_ and arg_112_1.time_ <= var_115_12 + arg_115_0 and not isNil(var_115_11) and arg_112_1.var_.characterEffect6148ui_story == nil then
				arg_112_1.var_.characterEffect6148ui_story = var_115_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_13 = 0.200000002980232

			if var_115_12 <= arg_112_1.time_ and arg_112_1.time_ < var_115_12 + var_115_13 and not isNil(var_115_11) then
				local var_115_14 = (arg_112_1.time_ - var_115_12) / var_115_13

				if arg_112_1.var_.characterEffect6148ui_story and not isNil(var_115_11) then
					arg_112_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_12 + var_115_13 and arg_112_1.time_ < var_115_12 + var_115_13 + arg_115_0 and not isNil(var_115_11) and arg_112_1.var_.characterEffect6148ui_story then
				arg_112_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_115_15 = 0

			if var_115_15 < arg_112_1.time_ and arg_112_1.time_ <= var_115_15 + arg_115_0 then
				arg_112_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_115_16 = "1037ui_story"

			if arg_112_1.actors_[var_115_16] == nil then
				local var_115_17 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_115_17) then
					local var_115_18 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_112_1.stage_.transform)

					var_115_18.name = var_115_16
					var_115_18.transform.localPosition = Vector3.New(0, 100, 0)
					arg_112_1.actors_[var_115_16] = var_115_18

					local var_115_19 = var_115_18:GetComponentInChildren(typeof(CharacterEffect))

					var_115_19.enabled = true

					local var_115_20 = GameObjectTools.GetOrAddComponent(var_115_18, typeof(DynamicBoneHelper))

					if var_115_20 then
						var_115_20:EnableDynamicBone(false)
					end

					arg_112_1:ShowWeapon(var_115_19.transform, false)

					arg_112_1.var_[var_115_16 .. "Animator"] = var_115_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_112_1.var_[var_115_16 .. "Animator"].applyRootMotion = true
					arg_112_1.var_[var_115_16 .. "LipSync"] = var_115_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_115_21 = 0

			if var_115_21 < arg_112_1.time_ and arg_112_1.time_ <= var_115_21 + arg_115_0 then
				arg_112_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_115_22 = 0
			local var_115_23 = 0.4

			if var_115_22 < arg_112_1.time_ and arg_112_1.time_ <= var_115_22 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_24 = arg_112_1:FormatText(StoryNameCfg[1488].name)

				arg_112_1.leftNameTxt_.text = var_115_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_25 = arg_112_1:GetWordFromCfg(324111028)
				local var_115_26 = arg_112_1:FormatText(var_115_25.content)

				arg_112_1.text_.text = var_115_26

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_27 = 16
				local var_115_28 = utf8.len(var_115_26)
				local var_115_29 = var_115_27 <= 0 and var_115_23 or var_115_23 * (var_115_28 / var_115_27)

				if var_115_29 > 0 and var_115_23 < var_115_29 then
					arg_112_1.talkMaxDuration = var_115_29

					if var_115_29 + var_115_22 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_29 + var_115_22
					end
				end

				arg_112_1.text_.text = var_115_26
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111028", "story_v_out_324111.awb") ~= 0 then
					local var_115_30 = manager.audio:GetVoiceLength("story_v_out_324111", "324111028", "story_v_out_324111.awb") / 1000

					if var_115_30 + var_115_22 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_30 + var_115_22
					end

					if var_115_25.prefab_name ~= "" and arg_112_1.actors_[var_115_25.prefab_name] ~= nil then
						local var_115_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_25.prefab_name].transform, "story_v_out_324111", "324111028", "story_v_out_324111.awb")

						arg_112_1:RecordAudio("324111028", var_115_31)
						arg_112_1:RecordAudio("324111028", var_115_31)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_324111", "324111028", "story_v_out_324111.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_324111", "324111028", "story_v_out_324111.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_32 = math.max(var_115_23, arg_112_1.talkMaxDuration)

			if var_115_22 <= arg_112_1.time_ and arg_112_1.time_ < var_115_22 + var_115_32 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_22) / var_115_32

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_22 + var_115_32 and arg_112_1.time_ < var_115_22 + var_115_32 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play324111029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 324111029
		arg_116_1.duration_ = 8.83

		local var_116_0 = {
			zh = 8.733,
			ja = 8.833
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play324111030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1054ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1054ui_story = var_119_0.localPosition

				local var_119_2 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(false)
				end
			end

			local var_119_3 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_3 then
				local var_119_4 = (arg_116_1.time_ - var_119_1) / var_119_3
				local var_119_5 = Vector3.New(0.7, -0.985, -6)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1054ui_story, var_119_5, var_119_4)

				local var_119_6 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_6.x, var_119_6.y, var_119_6.z)

				local var_119_7 = var_119_0.localEulerAngles

				var_119_7.z = 0
				var_119_7.x = 0
				var_119_0.localEulerAngles = var_119_7
			end

			if arg_116_1.time_ >= var_119_1 + var_119_3 and arg_116_1.time_ < var_119_1 + var_119_3 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_119_8 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_8.x, var_119_8.y, var_119_8.z)

				local var_119_9 = var_119_0.localEulerAngles

				var_119_9.z = 0
				var_119_9.x = 0
				var_119_0.localEulerAngles = var_119_9

				local var_119_10 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_10 then
					var_119_10:EnableDynamicBone(true)
				end
			end

			local var_119_11 = arg_116_1.actors_["1054ui_story"]
			local var_119_12 = 0

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 and not isNil(var_119_11) and arg_116_1.var_.characterEffect1054ui_story == nil then
				arg_116_1.var_.characterEffect1054ui_story = var_119_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_13 = 0.200000002980232

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_13 and not isNil(var_119_11) then
				local var_119_14 = (arg_116_1.time_ - var_119_12) / var_119_13

				if arg_116_1.var_.characterEffect1054ui_story and not isNil(var_119_11) then
					arg_116_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_12 + var_119_13 and arg_116_1.time_ < var_119_12 + var_119_13 + arg_119_0 and not isNil(var_119_11) and arg_116_1.var_.characterEffect1054ui_story then
				arg_116_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_119_15 = arg_116_1.actors_["6148ui_story"]
			local var_119_16 = 0

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 and not isNil(var_119_15) and arg_116_1.var_.characterEffect6148ui_story == nil then
				arg_116_1.var_.characterEffect6148ui_story = var_119_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_17 = 0.200000002980232

			if var_119_16 <= arg_116_1.time_ and arg_116_1.time_ < var_119_16 + var_119_17 and not isNil(var_119_15) then
				local var_119_18 = (arg_116_1.time_ - var_119_16) / var_119_17

				if arg_116_1.var_.characterEffect6148ui_story and not isNil(var_119_15) then
					local var_119_19 = Mathf.Lerp(0, 0.5, var_119_18)

					arg_116_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_116_1.var_.characterEffect6148ui_story.fillRatio = var_119_19
				end
			end

			if arg_116_1.time_ >= var_119_16 + var_119_17 and arg_116_1.time_ < var_119_16 + var_119_17 + arg_119_0 and not isNil(var_119_15) and arg_116_1.var_.characterEffect6148ui_story then
				local var_119_20 = 0.5

				arg_116_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_116_1.var_.characterEffect6148ui_story.fillRatio = var_119_20
			end

			local var_119_21 = 0

			if var_119_21 < arg_116_1.time_ and arg_116_1.time_ <= var_119_21 + arg_119_0 then
				arg_116_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action7_1")
			end

			local var_119_22 = 0

			if var_119_22 < arg_116_1.time_ and arg_116_1.time_ <= var_119_22 + arg_119_0 then
				arg_116_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_119_23 = 0
			local var_119_24 = 0.7

			if var_119_23 < arg_116_1.time_ and arg_116_1.time_ <= var_119_23 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_25 = arg_116_1:FormatText(StoryNameCfg[1487].name)

				arg_116_1.leftNameTxt_.text = var_119_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_26 = arg_116_1:GetWordFromCfg(324111029)
				local var_119_27 = arg_116_1:FormatText(var_119_26.content)

				arg_116_1.text_.text = var_119_27

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_28 = 28
				local var_119_29 = utf8.len(var_119_27)
				local var_119_30 = var_119_28 <= 0 and var_119_24 or var_119_24 * (var_119_29 / var_119_28)

				if var_119_30 > 0 and var_119_24 < var_119_30 then
					arg_116_1.talkMaxDuration = var_119_30

					if var_119_30 + var_119_23 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_30 + var_119_23
					end
				end

				arg_116_1.text_.text = var_119_27
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111029", "story_v_out_324111.awb") ~= 0 then
					local var_119_31 = manager.audio:GetVoiceLength("story_v_out_324111", "324111029", "story_v_out_324111.awb") / 1000

					if var_119_31 + var_119_23 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_31 + var_119_23
					end

					if var_119_26.prefab_name ~= "" and arg_116_1.actors_[var_119_26.prefab_name] ~= nil then
						local var_119_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_26.prefab_name].transform, "story_v_out_324111", "324111029", "story_v_out_324111.awb")

						arg_116_1:RecordAudio("324111029", var_119_32)
						arg_116_1:RecordAudio("324111029", var_119_32)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_324111", "324111029", "story_v_out_324111.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_324111", "324111029", "story_v_out_324111.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_33 = math.max(var_119_24, arg_116_1.talkMaxDuration)

			if var_119_23 <= arg_116_1.time_ and arg_116_1.time_ < var_119_23 + var_119_33 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_23) / var_119_33

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_23 + var_119_33 and arg_116_1.time_ < var_119_23 + var_119_33 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play324111030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 324111030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play324111031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1054ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1054ui_story == nil then
				arg_120_1.var_.characterEffect1054ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1054ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1054ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1054ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1054ui_story.fillRatio = var_123_5
			end

			local var_123_6 = 0
			local var_123_7 = 0.35

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_8 = arg_120_1:FormatText(StoryNameCfg[7].name)

				arg_120_1.leftNameTxt_.text = var_123_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_9 = arg_120_1:GetWordFromCfg(324111030)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 14
				local var_123_12 = utf8.len(var_123_10)
				local var_123_13 = var_123_11 <= 0 and var_123_7 or var_123_7 * (var_123_12 / var_123_11)

				if var_123_13 > 0 and var_123_7 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_10
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_14 and arg_120_1.time_ < var_123_6 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play324111031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 324111031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play324111032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1054ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1054ui_story = var_127_0.localPosition

				local var_127_2 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(false)
				end
			end

			local var_127_3 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_3 then
				local var_127_4 = (arg_124_1.time_ - var_127_1) / var_127_3
				local var_127_5 = Vector3.New(0, 100, 0)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1054ui_story, var_127_5, var_127_4)

				local var_127_6 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_6.x, var_127_6.y, var_127_6.z)

				local var_127_7 = var_127_0.localEulerAngles

				var_127_7.z = 0
				var_127_7.x = 0
				var_127_0.localEulerAngles = var_127_7
			end

			if arg_124_1.time_ >= var_127_1 + var_127_3 and arg_124_1.time_ < var_127_1 + var_127_3 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, 100, 0)

				local var_127_8 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_8.x, var_127_8.y, var_127_8.z)

				local var_127_9 = var_127_0.localEulerAngles

				var_127_9.z = 0
				var_127_9.x = 0
				var_127_0.localEulerAngles = var_127_9

				local var_127_10 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_10 then
					var_127_10:EnableDynamicBone(true)
				end
			end

			local var_127_11 = arg_124_1.actors_["6148ui_story"].transform
			local var_127_12 = 0

			if var_127_12 < arg_124_1.time_ and arg_124_1.time_ <= var_127_12 + arg_127_0 then
				arg_124_1.var_.moveOldPos6148ui_story = var_127_11.localPosition

				local var_127_13 = GameObjectTools.GetOrAddComponent(var_127_11.gameObject, typeof(DynamicBoneHelper))

				if var_127_13 then
					var_127_13:EnableDynamicBone(false)
				end
			end

			local var_127_14 = 0.001

			if var_127_12 <= arg_124_1.time_ and arg_124_1.time_ < var_127_12 + var_127_14 then
				local var_127_15 = (arg_124_1.time_ - var_127_12) / var_127_14
				local var_127_16 = Vector3.New(0, 100, 0)

				var_127_11.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos6148ui_story, var_127_16, var_127_15)

				local var_127_17 = manager.ui.mainCamera.transform.position - var_127_11.position

				var_127_11.forward = Vector3.New(var_127_17.x, var_127_17.y, var_127_17.z)

				local var_127_18 = var_127_11.localEulerAngles

				var_127_18.z = 0
				var_127_18.x = 0
				var_127_11.localEulerAngles = var_127_18
			end

			if arg_124_1.time_ >= var_127_12 + var_127_14 and arg_124_1.time_ < var_127_12 + var_127_14 + arg_127_0 then
				var_127_11.localPosition = Vector3.New(0, 100, 0)

				local var_127_19 = manager.ui.mainCamera.transform.position - var_127_11.position

				var_127_11.forward = Vector3.New(var_127_19.x, var_127_19.y, var_127_19.z)

				local var_127_20 = var_127_11.localEulerAngles

				var_127_20.z = 0
				var_127_20.x = 0
				var_127_11.localEulerAngles = var_127_20

				local var_127_21 = GameObjectTools.GetOrAddComponent(var_127_11.gameObject, typeof(DynamicBoneHelper))

				if var_127_21 then
					var_127_21:EnableDynamicBone(true)
				end
			end

			local var_127_22 = 0
			local var_127_23 = 1.625

			if var_127_22 < arg_124_1.time_ and arg_124_1.time_ <= var_127_22 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_24 = arg_124_1:GetWordFromCfg(324111031)
				local var_127_25 = arg_124_1:FormatText(var_127_24.content)

				arg_124_1.text_.text = var_127_25

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_26 = 65
				local var_127_27 = utf8.len(var_127_25)
				local var_127_28 = var_127_26 <= 0 and var_127_23 or var_127_23 * (var_127_27 / var_127_26)

				if var_127_28 > 0 and var_127_23 < var_127_28 then
					arg_124_1.talkMaxDuration = var_127_28

					if var_127_28 + var_127_22 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_28 + var_127_22
					end
				end

				arg_124_1.text_.text = var_127_25
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_29 = math.max(var_127_23, arg_124_1.talkMaxDuration)

			if var_127_22 <= arg_124_1.time_ and arg_124_1.time_ < var_127_22 + var_127_29 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_22) / var_127_29

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_22 + var_127_29 and arg_124_1.time_ < var_127_22 + var_127_29 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
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

		arg_124_1:InitPlayNodeList()
	end,
	Play324111032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 324111032
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play324111033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.45

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[7].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:GetWordFromCfg(324111032)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 18
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_8 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_8 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_8

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_8 and arg_128_1.time_ < var_131_0 + var_131_8 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play324111033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324111033
		arg_132_1.duration_ = 4.93

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play324111034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1054ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos1054ui_story = var_135_0.localPosition

				local var_135_2 = GameObjectTools.GetOrAddComponent(var_135_0.gameObject, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(false)
				end
			end

			local var_135_3 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_3 then
				local var_135_4 = (arg_132_1.time_ - var_135_1) / var_135_3
				local var_135_5 = Vector3.New(0, -0.985, -6)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1054ui_story, var_135_5, var_135_4)

				local var_135_6 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_6.x, var_135_6.y, var_135_6.z)

				local var_135_7 = var_135_0.localEulerAngles

				var_135_7.z = 0
				var_135_7.x = 0
				var_135_0.localEulerAngles = var_135_7
			end

			if arg_132_1.time_ >= var_135_1 + var_135_3 and arg_132_1.time_ < var_135_1 + var_135_3 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_135_8 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_8.x, var_135_8.y, var_135_8.z)

				local var_135_9 = var_135_0.localEulerAngles

				var_135_9.z = 0
				var_135_9.x = 0
				var_135_0.localEulerAngles = var_135_9

				local var_135_10 = GameObjectTools.GetOrAddComponent(var_135_0.gameObject, typeof(DynamicBoneHelper))

				if var_135_10 then
					var_135_10:EnableDynamicBone(true)
				end
			end

			local var_135_11 = arg_132_1.actors_["1054ui_story"]
			local var_135_12 = 0

			if var_135_12 < arg_132_1.time_ and arg_132_1.time_ <= var_135_12 + arg_135_0 and not isNil(var_135_11) and arg_132_1.var_.characterEffect1054ui_story == nil then
				arg_132_1.var_.characterEffect1054ui_story = var_135_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_13 = 0.200000002980232

			if var_135_12 <= arg_132_1.time_ and arg_132_1.time_ < var_135_12 + var_135_13 and not isNil(var_135_11) then
				local var_135_14 = (arg_132_1.time_ - var_135_12) / var_135_13

				if arg_132_1.var_.characterEffect1054ui_story and not isNil(var_135_11) then
					arg_132_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_12 + var_135_13 and arg_132_1.time_ < var_135_12 + var_135_13 + arg_135_0 and not isNil(var_135_11) and arg_132_1.var_.characterEffect1054ui_story then
				arg_132_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_135_15 = 0

			if var_135_15 < arg_132_1.time_ and arg_132_1.time_ <= var_135_15 + arg_135_0 then
				arg_132_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action7_2")
			end

			local var_135_16 = 0

			if var_135_16 < arg_132_1.time_ and arg_132_1.time_ <= var_135_16 + arg_135_0 then
				arg_132_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_135_17 = 0
			local var_135_18 = 0.45

			if var_135_17 < arg_132_1.time_ and arg_132_1.time_ <= var_135_17 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_19 = arg_132_1:FormatText(StoryNameCfg[1487].name)

				arg_132_1.leftNameTxt_.text = var_135_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_20 = arg_132_1:GetWordFromCfg(324111033)
				local var_135_21 = arg_132_1:FormatText(var_135_20.content)

				arg_132_1.text_.text = var_135_21

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_22 = 18
				local var_135_23 = utf8.len(var_135_21)
				local var_135_24 = var_135_22 <= 0 and var_135_18 or var_135_18 * (var_135_23 / var_135_22)

				if var_135_24 > 0 and var_135_18 < var_135_24 then
					arg_132_1.talkMaxDuration = var_135_24

					if var_135_24 + var_135_17 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_24 + var_135_17
					end
				end

				arg_132_1.text_.text = var_135_21
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111033", "story_v_out_324111.awb") ~= 0 then
					local var_135_25 = manager.audio:GetVoiceLength("story_v_out_324111", "324111033", "story_v_out_324111.awb") / 1000

					if var_135_25 + var_135_17 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_25 + var_135_17
					end

					if var_135_20.prefab_name ~= "" and arg_132_1.actors_[var_135_20.prefab_name] ~= nil then
						local var_135_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_20.prefab_name].transform, "story_v_out_324111", "324111033", "story_v_out_324111.awb")

						arg_132_1:RecordAudio("324111033", var_135_26)
						arg_132_1:RecordAudio("324111033", var_135_26)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_324111", "324111033", "story_v_out_324111.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_324111", "324111033", "story_v_out_324111.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_27 = math.max(var_135_18, arg_132_1.talkMaxDuration)

			if var_135_17 <= arg_132_1.time_ and arg_132_1.time_ < var_135_17 + var_135_27 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_17) / var_135_27

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_17 + var_135_27 and arg_132_1.time_ < var_135_17 + var_135_27 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
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

		arg_132_1:InitPlayNodeList()
	end,
	Play324111034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324111034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play324111035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1054ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1054ui_story == nil then
				arg_136_1.var_.characterEffect1054ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1054ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1054ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1054ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1054ui_story.fillRatio = var_139_5
			end

			local var_139_6 = 0
			local var_139_7 = 1.025

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_8 = arg_136_1:FormatText(StoryNameCfg[7].name)

				arg_136_1.leftNameTxt_.text = var_139_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_9 = arg_136_1:GetWordFromCfg(324111034)
				local var_139_10 = arg_136_1:FormatText(var_139_9.content)

				arg_136_1.text_.text = var_139_10

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 41
				local var_139_12 = utf8.len(var_139_10)
				local var_139_13 = var_139_11 <= 0 and var_139_7 or var_139_7 * (var_139_12 / var_139_11)

				if var_139_13 > 0 and var_139_7 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_10
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_14 and arg_136_1.time_ < var_139_6 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play324111035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 324111035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play324111036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 1.5

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[7].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:GetWordFromCfg(324111035)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 60
				local var_143_6 = utf8.len(var_143_4)
				local var_143_7 = var_143_5 <= 0 and var_143_1 or var_143_1 * (var_143_6 / var_143_5)

				if var_143_7 > 0 and var_143_1 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_8 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_8 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_8

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_8 and arg_140_1.time_ < var_143_0 + var_143_8 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play324111036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 324111036
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play324111037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 1.375

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[7].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(324111036)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 55
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_8 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_8 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_8

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_8 and arg_144_1.time_ < var_147_0 + var_147_8 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play324111037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 324111037
		arg_148_1.duration_ = 2

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play324111038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1054ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1054ui_story = var_151_0.localPosition

				local var_151_2 = GameObjectTools.GetOrAddComponent(var_151_0.gameObject, typeof(DynamicBoneHelper))

				if var_151_2 then
					var_151_2:EnableDynamicBone(false)
				end
			end

			local var_151_3 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_3 then
				local var_151_4 = (arg_148_1.time_ - var_151_1) / var_151_3
				local var_151_5 = Vector3.New(-0.7, -0.985, -6)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1054ui_story, var_151_5, var_151_4)

				local var_151_6 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_6.x, var_151_6.y, var_151_6.z)

				local var_151_7 = var_151_0.localEulerAngles

				var_151_7.z = 0
				var_151_7.x = 0
				var_151_0.localEulerAngles = var_151_7
			end

			if arg_148_1.time_ >= var_151_1 + var_151_3 and arg_148_1.time_ < var_151_1 + var_151_3 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_151_8 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_8.x, var_151_8.y, var_151_8.z)

				local var_151_9 = var_151_0.localEulerAngles

				var_151_9.z = 0
				var_151_9.x = 0
				var_151_0.localEulerAngles = var_151_9

				local var_151_10 = GameObjectTools.GetOrAddComponent(var_151_0.gameObject, typeof(DynamicBoneHelper))

				if var_151_10 then
					var_151_10:EnableDynamicBone(true)
				end
			end

			local var_151_11 = arg_148_1.actors_["6148ui_story"].transform
			local var_151_12 = 0

			if var_151_12 < arg_148_1.time_ and arg_148_1.time_ <= var_151_12 + arg_151_0 then
				arg_148_1.var_.moveOldPos6148ui_story = var_151_11.localPosition

				local var_151_13 = GameObjectTools.GetOrAddComponent(var_151_11.gameObject, typeof(DynamicBoneHelper))

				if var_151_13 then
					var_151_13:EnableDynamicBone(false)
				end
			end

			local var_151_14 = 0.001

			if var_151_12 <= arg_148_1.time_ and arg_148_1.time_ < var_151_12 + var_151_14 then
				local var_151_15 = (arg_148_1.time_ - var_151_12) / var_151_14
				local var_151_16 = Vector3.New(0.7, -0.985, -6)

				var_151_11.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos6148ui_story, var_151_16, var_151_15)

				local var_151_17 = manager.ui.mainCamera.transform.position - var_151_11.position

				var_151_11.forward = Vector3.New(var_151_17.x, var_151_17.y, var_151_17.z)

				local var_151_18 = var_151_11.localEulerAngles

				var_151_18.z = 0
				var_151_18.x = 0
				var_151_11.localEulerAngles = var_151_18
			end

			if arg_148_1.time_ >= var_151_12 + var_151_14 and arg_148_1.time_ < var_151_12 + var_151_14 + arg_151_0 then
				var_151_11.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_151_19 = manager.ui.mainCamera.transform.position - var_151_11.position

				var_151_11.forward = Vector3.New(var_151_19.x, var_151_19.y, var_151_19.z)

				local var_151_20 = var_151_11.localEulerAngles

				var_151_20.z = 0
				var_151_20.x = 0
				var_151_11.localEulerAngles = var_151_20

				local var_151_21 = GameObjectTools.GetOrAddComponent(var_151_11.gameObject, typeof(DynamicBoneHelper))

				if var_151_21 then
					var_151_21:EnableDynamicBone(true)
				end
			end

			local var_151_22 = arg_148_1.actors_["6148ui_story"]
			local var_151_23 = 0

			if var_151_23 < arg_148_1.time_ and arg_148_1.time_ <= var_151_23 + arg_151_0 and not isNil(var_151_22) and arg_148_1.var_.characterEffect6148ui_story == nil then
				arg_148_1.var_.characterEffect6148ui_story = var_151_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_24 = 0.200000002980232

			if var_151_23 <= arg_148_1.time_ and arg_148_1.time_ < var_151_23 + var_151_24 and not isNil(var_151_22) then
				local var_151_25 = (arg_148_1.time_ - var_151_23) / var_151_24

				if arg_148_1.var_.characterEffect6148ui_story and not isNil(var_151_22) then
					arg_148_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_23 + var_151_24 and arg_148_1.time_ < var_151_23 + var_151_24 + arg_151_0 and not isNil(var_151_22) and arg_148_1.var_.characterEffect6148ui_story then
				arg_148_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_151_26 = 0

			if var_151_26 < arg_148_1.time_ and arg_148_1.time_ <= var_151_26 + arg_151_0 then
				arg_148_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_1")
			end

			local var_151_27 = 0

			if var_151_27 < arg_148_1.time_ and arg_148_1.time_ <= var_151_27 + arg_151_0 then
				arg_148_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_151_28 = 0
			local var_151_29 = 0.125

			if var_151_28 < arg_148_1.time_ and arg_148_1.time_ <= var_151_28 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_30 = arg_148_1:FormatText(StoryNameCfg[1488].name)

				arg_148_1.leftNameTxt_.text = var_151_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_31 = arg_148_1:GetWordFromCfg(324111037)
				local var_151_32 = arg_148_1:FormatText(var_151_31.content)

				arg_148_1.text_.text = var_151_32

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_33 = 5
				local var_151_34 = utf8.len(var_151_32)
				local var_151_35 = var_151_33 <= 0 and var_151_29 or var_151_29 * (var_151_34 / var_151_33)

				if var_151_35 > 0 and var_151_29 < var_151_35 then
					arg_148_1.talkMaxDuration = var_151_35

					if var_151_35 + var_151_28 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_35 + var_151_28
					end
				end

				arg_148_1.text_.text = var_151_32
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111037", "story_v_out_324111.awb") ~= 0 then
					local var_151_36 = manager.audio:GetVoiceLength("story_v_out_324111", "324111037", "story_v_out_324111.awb") / 1000

					if var_151_36 + var_151_28 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_36 + var_151_28
					end

					if var_151_31.prefab_name ~= "" and arg_148_1.actors_[var_151_31.prefab_name] ~= nil then
						local var_151_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_31.prefab_name].transform, "story_v_out_324111", "324111037", "story_v_out_324111.awb")

						arg_148_1:RecordAudio("324111037", var_151_37)
						arg_148_1:RecordAudio("324111037", var_151_37)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_324111", "324111037", "story_v_out_324111.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_324111", "324111037", "story_v_out_324111.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_38 = math.max(var_151_29, arg_148_1.talkMaxDuration)

			if var_151_28 <= arg_148_1.time_ and arg_148_1.time_ < var_151_28 + var_151_38 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_28) / var_151_38

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_28 + var_151_38 and arg_148_1.time_ < var_151_28 + var_151_38 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play324111038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 324111038
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play324111039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["6148ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect6148ui_story == nil then
				arg_152_1.var_.characterEffect6148ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect6148ui_story and not isNil(var_155_0) then
					local var_155_4 = Mathf.Lerp(0, 0.5, var_155_3)

					arg_152_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_152_1.var_.characterEffect6148ui_story.fillRatio = var_155_4
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect6148ui_story then
				local var_155_5 = 0.5

				arg_152_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_152_1.var_.characterEffect6148ui_story.fillRatio = var_155_5
			end

			local var_155_6 = 0
			local var_155_7 = 1.45

			if var_155_6 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_8 = arg_152_1:FormatText(StoryNameCfg[7].name)

				arg_152_1.leftNameTxt_.text = var_155_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_9 = arg_152_1:GetWordFromCfg(324111038)
				local var_155_10 = arg_152_1:FormatText(var_155_9.content)

				arg_152_1.text_.text = var_155_10

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_11 = 58
				local var_155_12 = utf8.len(var_155_10)
				local var_155_13 = var_155_11 <= 0 and var_155_7 or var_155_7 * (var_155_12 / var_155_11)

				if var_155_13 > 0 and var_155_7 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_10
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_14 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_14 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_14

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_14 and arg_152_1.time_ < var_155_6 + var_155_14 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play324111039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 324111039
		arg_156_1.duration_ = 3.63

		local var_156_0 = {
			zh = 3.633,
			ja = 3.5
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play324111040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1054ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1054ui_story == nil then
				arg_156_1.var_.characterEffect1054ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1054ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1054ui_story then
				arg_156_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_159_4 = 0

			if var_159_4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_159_5 = 0

			if var_159_5 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_159_6 = 0
			local var_159_7 = 0.3

			if var_159_6 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_8 = arg_156_1:FormatText(StoryNameCfg[1487].name)

				arg_156_1.leftNameTxt_.text = var_159_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_9 = arg_156_1:GetWordFromCfg(324111039)
				local var_159_10 = arg_156_1:FormatText(var_159_9.content)

				arg_156_1.text_.text = var_159_10

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111039", "story_v_out_324111.awb") ~= 0 then
					local var_159_14 = manager.audio:GetVoiceLength("story_v_out_324111", "324111039", "story_v_out_324111.awb") / 1000

					if var_159_14 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_14 + var_159_6
					end

					if var_159_9.prefab_name ~= "" and arg_156_1.actors_[var_159_9.prefab_name] ~= nil then
						local var_159_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_9.prefab_name].transform, "story_v_out_324111", "324111039", "story_v_out_324111.awb")

						arg_156_1:RecordAudio("324111039", var_159_15)
						arg_156_1:RecordAudio("324111039", var_159_15)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_324111", "324111039", "story_v_out_324111.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_324111", "324111039", "story_v_out_324111.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_16 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_16 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_16

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_16 and arg_156_1.time_ < var_159_6 + var_159_16 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play324111040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 324111040
		arg_160_1.duration_ = 3.7

		local var_160_0 = {
			zh = 3,
			ja = 3.7
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
				arg_160_0:Play324111041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["6148ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect6148ui_story == nil then
				arg_160_1.var_.characterEffect6148ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect6148ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect6148ui_story then
				arg_160_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_163_4 = arg_160_1.actors_["1054ui_story"]
			local var_163_5 = 0

			if var_163_5 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 and not isNil(var_163_4) and arg_160_1.var_.characterEffect1054ui_story == nil then
				arg_160_1.var_.characterEffect1054ui_story = var_163_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_6 = 0.200000002980232

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_6 and not isNil(var_163_4) then
				local var_163_7 = (arg_160_1.time_ - var_163_5) / var_163_6

				if arg_160_1.var_.characterEffect1054ui_story and not isNil(var_163_4) then
					local var_163_8 = Mathf.Lerp(0, 0.5, var_163_7)

					arg_160_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1054ui_story.fillRatio = var_163_8
				end
			end

			if arg_160_1.time_ >= var_163_5 + var_163_6 and arg_160_1.time_ < var_163_5 + var_163_6 + arg_163_0 and not isNil(var_163_4) and arg_160_1.var_.characterEffect1054ui_story then
				local var_163_9 = 0.5

				arg_160_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1054ui_story.fillRatio = var_163_9
			end

			local var_163_10 = 0

			if var_163_10 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				arg_160_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_2")
			end

			local var_163_11 = 0

			if var_163_11 < arg_160_1.time_ and arg_160_1.time_ <= var_163_11 + arg_163_0 then
				arg_160_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_163_12 = 0
			local var_163_13 = 0.375

			if var_163_12 < arg_160_1.time_ and arg_160_1.time_ <= var_163_12 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_14 = arg_160_1:FormatText(StoryNameCfg[1488].name)

				arg_160_1.leftNameTxt_.text = var_163_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_15 = arg_160_1:GetWordFromCfg(324111040)
				local var_163_16 = arg_160_1:FormatText(var_163_15.content)

				arg_160_1.text_.text = var_163_16

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_17 = 15
				local var_163_18 = utf8.len(var_163_16)
				local var_163_19 = var_163_17 <= 0 and var_163_13 or var_163_13 * (var_163_18 / var_163_17)

				if var_163_19 > 0 and var_163_13 < var_163_19 then
					arg_160_1.talkMaxDuration = var_163_19

					if var_163_19 + var_163_12 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_19 + var_163_12
					end
				end

				arg_160_1.text_.text = var_163_16
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111040", "story_v_out_324111.awb") ~= 0 then
					local var_163_20 = manager.audio:GetVoiceLength("story_v_out_324111", "324111040", "story_v_out_324111.awb") / 1000

					if var_163_20 + var_163_12 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_20 + var_163_12
					end

					if var_163_15.prefab_name ~= "" and arg_160_1.actors_[var_163_15.prefab_name] ~= nil then
						local var_163_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_15.prefab_name].transform, "story_v_out_324111", "324111040", "story_v_out_324111.awb")

						arg_160_1:RecordAudio("324111040", var_163_21)
						arg_160_1:RecordAudio("324111040", var_163_21)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_324111", "324111040", "story_v_out_324111.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_324111", "324111040", "story_v_out_324111.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_22 = math.max(var_163_13, arg_160_1.talkMaxDuration)

			if var_163_12 <= arg_160_1.time_ and arg_160_1.time_ < var_163_12 + var_163_22 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_12) / var_163_22

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_12 + var_163_22 and arg_160_1.time_ < var_163_12 + var_163_22 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play324111041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 324111041
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play324111042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["6148ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect6148ui_story == nil then
				arg_164_1.var_.characterEffect6148ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect6148ui_story and not isNil(var_167_0) then
					local var_167_4 = Mathf.Lerp(0, 0.5, var_167_3)

					arg_164_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_164_1.var_.characterEffect6148ui_story.fillRatio = var_167_4
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect6148ui_story then
				local var_167_5 = 0.5

				arg_164_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_164_1.var_.characterEffect6148ui_story.fillRatio = var_167_5
			end

			local var_167_6 = 0
			local var_167_7 = 0.55

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_8 = arg_164_1:FormatText(StoryNameCfg[7].name)

				arg_164_1.leftNameTxt_.text = var_167_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_9 = arg_164_1:GetWordFromCfg(324111041)
				local var_167_10 = arg_164_1:FormatText(var_167_9.content)

				arg_164_1.text_.text = var_167_10

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 22
				local var_167_12 = utf8.len(var_167_10)
				local var_167_13 = var_167_11 <= 0 and var_167_7 or var_167_7 * (var_167_12 / var_167_11)

				if var_167_13 > 0 and var_167_7 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_10
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_14 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_14 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_14

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_14 and arg_164_1.time_ < var_167_6 + var_167_14 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play324111042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 324111042
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play324111043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1054ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos1054ui_story = var_171_0.localPosition

				local var_171_2 = GameObjectTools.GetOrAddComponent(var_171_0.gameObject, typeof(DynamicBoneHelper))

				if var_171_2 then
					var_171_2:EnableDynamicBone(false)
				end
			end

			local var_171_3 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_3 then
				local var_171_4 = (arg_168_1.time_ - var_171_1) / var_171_3
				local var_171_5 = Vector3.New(0, 100, 0)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1054ui_story, var_171_5, var_171_4)

				local var_171_6 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_6.x, var_171_6.y, var_171_6.z)

				local var_171_7 = var_171_0.localEulerAngles

				var_171_7.z = 0
				var_171_7.x = 0
				var_171_0.localEulerAngles = var_171_7
			end

			if arg_168_1.time_ >= var_171_1 + var_171_3 and arg_168_1.time_ < var_171_1 + var_171_3 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(0, 100, 0)

				local var_171_8 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_8.x, var_171_8.y, var_171_8.z)

				local var_171_9 = var_171_0.localEulerAngles

				var_171_9.z = 0
				var_171_9.x = 0
				var_171_0.localEulerAngles = var_171_9

				local var_171_10 = GameObjectTools.GetOrAddComponent(var_171_0.gameObject, typeof(DynamicBoneHelper))

				if var_171_10 then
					var_171_10:EnableDynamicBone(true)
				end
			end

			local var_171_11 = arg_168_1.actors_["6148ui_story"].transform
			local var_171_12 = 0

			if var_171_12 < arg_168_1.time_ and arg_168_1.time_ <= var_171_12 + arg_171_0 then
				arg_168_1.var_.moveOldPos6148ui_story = var_171_11.localPosition

				local var_171_13 = GameObjectTools.GetOrAddComponent(var_171_11.gameObject, typeof(DynamicBoneHelper))

				if var_171_13 then
					var_171_13:EnableDynamicBone(false)
				end
			end

			local var_171_14 = 0.001

			if var_171_12 <= arg_168_1.time_ and arg_168_1.time_ < var_171_12 + var_171_14 then
				local var_171_15 = (arg_168_1.time_ - var_171_12) / var_171_14
				local var_171_16 = Vector3.New(0, 100, 0)

				var_171_11.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos6148ui_story, var_171_16, var_171_15)

				local var_171_17 = manager.ui.mainCamera.transform.position - var_171_11.position

				var_171_11.forward = Vector3.New(var_171_17.x, var_171_17.y, var_171_17.z)

				local var_171_18 = var_171_11.localEulerAngles

				var_171_18.z = 0
				var_171_18.x = 0
				var_171_11.localEulerAngles = var_171_18
			end

			if arg_168_1.time_ >= var_171_12 + var_171_14 and arg_168_1.time_ < var_171_12 + var_171_14 + arg_171_0 then
				var_171_11.localPosition = Vector3.New(0, 100, 0)

				local var_171_19 = manager.ui.mainCamera.transform.position - var_171_11.position

				var_171_11.forward = Vector3.New(var_171_19.x, var_171_19.y, var_171_19.z)

				local var_171_20 = var_171_11.localEulerAngles

				var_171_20.z = 0
				var_171_20.x = 0
				var_171_11.localEulerAngles = var_171_20

				local var_171_21 = GameObjectTools.GetOrAddComponent(var_171_11.gameObject, typeof(DynamicBoneHelper))

				if var_171_21 then
					var_171_21:EnableDynamicBone(true)
				end
			end

			local var_171_22 = 0.1
			local var_171_23 = 1

			if var_171_22 < arg_168_1.time_ and arg_168_1.time_ <= var_171_22 + arg_171_0 then
				local var_171_24 = "play"
				local var_171_25 = "effect"

				arg_168_1:AudioAction(var_171_24, var_171_25, "se_story_side_1039", "se_story_1039_knock", "")
			end

			local var_171_26 = 0
			local var_171_27 = 1.125

			if var_171_26 < arg_168_1.time_ and arg_168_1.time_ <= var_171_26 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_28 = arg_168_1:GetWordFromCfg(324111042)
				local var_171_29 = arg_168_1:FormatText(var_171_28.content)

				arg_168_1.text_.text = var_171_29

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_30 = 45
				local var_171_31 = utf8.len(var_171_29)
				local var_171_32 = var_171_30 <= 0 and var_171_27 or var_171_27 * (var_171_31 / var_171_30)

				if var_171_32 > 0 and var_171_27 < var_171_32 then
					arg_168_1.talkMaxDuration = var_171_32

					if var_171_32 + var_171_26 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_32 + var_171_26
					end
				end

				arg_168_1.text_.text = var_171_29
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_33 = math.max(var_171_27, arg_168_1.talkMaxDuration)

			if var_171_26 <= arg_168_1.time_ and arg_168_1.time_ < var_171_26 + var_171_33 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_26) / var_171_33

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_26 + var_171_33 and arg_168_1.time_ < var_171_26 + var_171_33 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
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

		arg_168_1:InitPlayNodeList()
	end,
	Play324111043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 324111043
		arg_172_1.duration_ = 7.73

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play324111044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = "J27g"

			if arg_172_1.bgs_[var_175_0] == nil then
				local var_175_1 = Object.Instantiate(arg_172_1.paintGo_)

				var_175_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_175_0)
				var_175_1.name = var_175_0
				var_175_1.transform.parent = arg_172_1.stage_.transform
				var_175_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_172_1.bgs_[var_175_0] = var_175_1
			end

			local var_175_2 = 1.06666666666667

			if var_175_2 < arg_172_1.time_ and arg_172_1.time_ <= var_175_2 + arg_175_0 then
				local var_175_3 = manager.ui.mainCamera.transform.localPosition
				local var_175_4 = Vector3.New(0, 0, 10) + Vector3.New(var_175_3.x, var_175_3.y, 0)
				local var_175_5 = arg_172_1.bgs_.J27g

				var_175_5.transform.localPosition = var_175_4
				var_175_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_175_6 = var_175_5:GetComponent("SpriteRenderer")

				if var_175_6 and var_175_6.sprite then
					local var_175_7 = (var_175_5.transform.localPosition - var_175_3).z
					local var_175_8 = manager.ui.mainCameraCom_
					local var_175_9 = 2 * var_175_7 * Mathf.Tan(var_175_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_175_10 = var_175_9 * var_175_8.aspect
					local var_175_11 = var_175_6.sprite.bounds.size.x
					local var_175_12 = var_175_6.sprite.bounds.size.y
					local var_175_13 = var_175_10 / var_175_11
					local var_175_14 = var_175_9 / var_175_12
					local var_175_15 = var_175_14 < var_175_13 and var_175_13 or var_175_14

					var_175_5.transform.localScale = Vector3.New(var_175_15, var_175_15, 0)
				end

				for iter_175_0, iter_175_1 in pairs(arg_172_1.bgs_) do
					if iter_175_0 ~= "J27g" then
						iter_175_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_175_16 = 0

			if var_175_16 < arg_172_1.time_ and arg_172_1.time_ <= var_175_16 + arg_175_0 then
				arg_172_1.allBtn_.enabled = false
			end

			local var_175_17 = 0.3

			if arg_172_1.time_ >= var_175_16 + var_175_17 and arg_172_1.time_ < var_175_16 + var_175_17 + arg_175_0 then
				arg_172_1.allBtn_.enabled = true
			end

			local var_175_18 = 0

			if var_175_18 < arg_172_1.time_ and arg_172_1.time_ <= var_175_18 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_19 = 1.06666666666667

			if var_175_18 <= arg_172_1.time_ and arg_172_1.time_ < var_175_18 + var_175_19 then
				local var_175_20 = (arg_172_1.time_ - var_175_18) / var_175_19
				local var_175_21 = Color.New(0, 0, 0)

				var_175_21.a = Mathf.Lerp(0, 1, var_175_20)
				arg_172_1.mask_.color = var_175_21
			end

			if arg_172_1.time_ >= var_175_18 + var_175_19 and arg_172_1.time_ < var_175_18 + var_175_19 + arg_175_0 then
				local var_175_22 = Color.New(0, 0, 0)

				var_175_22.a = 1
				arg_172_1.mask_.color = var_175_22
			end

			local var_175_23 = 1.06666666666667

			if var_175_23 < arg_172_1.time_ and arg_172_1.time_ <= var_175_23 + arg_175_0 then
				arg_172_1.mask_.enabled = true
				arg_172_1.mask_.raycastTarget = true

				arg_172_1:SetGaussion(false)
			end

			local var_175_24 = 1.66666666666667

			if var_175_23 <= arg_172_1.time_ and arg_172_1.time_ < var_175_23 + var_175_24 then
				local var_175_25 = (arg_172_1.time_ - var_175_23) / var_175_24
				local var_175_26 = Color.New(0, 0, 0)

				var_175_26.a = Mathf.Lerp(1, 0, var_175_25)
				arg_172_1.mask_.color = var_175_26
			end

			if arg_172_1.time_ >= var_175_23 + var_175_24 and arg_172_1.time_ < var_175_23 + var_175_24 + arg_175_0 then
				local var_175_27 = Color.New(0, 0, 0)
				local var_175_28 = 0

				arg_172_1.mask_.enabled = false
				var_175_27.a = var_175_28
				arg_172_1.mask_.color = var_175_27
			end

			local var_175_29 = 1.2
			local var_175_30 = 1

			if var_175_29 < arg_172_1.time_ and arg_172_1.time_ <= var_175_29 + arg_175_0 then
				local var_175_31 = "play"
				local var_175_32 = "effect"

				arg_172_1:AudioAction(var_175_31, var_175_32, "se_story_150", "se_story_150_huatian", "")
			end

			local var_175_33 = 0.1
			local var_175_34 = 1

			if var_175_33 < arg_172_1.time_ and arg_172_1.time_ <= var_175_33 + arg_175_0 then
				local var_175_35 = "stop"
				local var_175_36 = "effect"

				arg_172_1:AudioAction(var_175_35, var_175_36, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_175_37 = 0
			local var_175_38 = 1

			if var_175_37 < arg_172_1.time_ and arg_172_1.time_ <= var_175_37 + arg_175_0 then
				local var_175_39 = "play"
				local var_175_40 = "effect"

				arg_172_1:AudioAction(var_175_39, var_175_40, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_175_41 = 1
			local var_175_42 = 1

			if var_175_41 < arg_172_1.time_ and arg_172_1.time_ <= var_175_41 + arg_175_0 then
				local var_175_43 = "play"
				local var_175_44 = "music"

				arg_172_1:AudioAction(var_175_43, var_175_44, "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian.awb")

				local var_175_45 = ""
				local var_175_46 = manager.audio:GetAudioName("bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian")

				if var_175_46 ~= "" then
					if arg_172_1.bgmTxt_.text ~= var_175_46 and arg_172_1.bgmTxt_.text ~= "" then
						if arg_172_1.bgmTxt2_.text ~= "" then
							arg_172_1.bgmTxt_.text = arg_172_1.bgmTxt2_.text
						end

						arg_172_1.bgmTxt2_.text = var_175_46

						arg_172_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_172_1.bgmTxt_.text = var_175_46
						arg_172_1.bgmTxt2_.text = var_175_46
					end

					if arg_172_1.bgmTimer then
						arg_172_1.bgmTimer:Stop()

						arg_172_1.bgmTimer = nil
					end

					if arg_172_1.settingData.show_music_name == 1 then
						arg_172_1.musicController:SetSelectedState("show")
						arg_172_1.musicAnimator_:Play("open", 0, 0)

						if arg_172_1.settingData.music_time ~= 0 then
							arg_172_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_172_1.settingData.music_time), function()
								if arg_172_1 == nil or isNil(arg_172_1.bgmTxt_) then
									return
								end

								arg_172_1.musicController:SetSelectedState("hide")
								arg_172_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_172_1.frameCnt_ <= 1 then
				arg_172_1.dialog_:SetActive(false)
			end

			local var_175_47 = 2.73333333333333
			local var_175_48 = 0.925

			if var_175_47 < arg_172_1.time_ and arg_172_1.time_ <= var_175_47 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				arg_172_1.dialog_:SetActive(true)

				arg_172_1.dialogCg_.alpha = 0

				local var_175_49 = LeanTween.value(arg_172_1.dialog_, 0, 1, 0.3)

				var_175_49:setOnUpdate(LuaHelper.FloatAction(function(arg_177_0)
					arg_172_1.dialogCg_.alpha = arg_177_0
				end))
				var_175_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_172_1.dialog_)
					var_175_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_172_1.duration_ = arg_172_1.duration_ + 0.3

				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_50 = arg_172_1:GetWordFromCfg(324111043)
				local var_175_51 = arg_172_1:FormatText(var_175_50.content)

				arg_172_1.text_.text = var_175_51

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_52 = 37
				local var_175_53 = utf8.len(var_175_51)
				local var_175_54 = var_175_52 <= 0 and var_175_48 or var_175_48 * (var_175_53 / var_175_52)

				if var_175_54 > 0 and var_175_48 < var_175_54 then
					arg_172_1.talkMaxDuration = var_175_54
					var_175_47 = var_175_47 + 0.3

					if var_175_54 + var_175_47 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_54 + var_175_47
					end
				end

				arg_172_1.text_.text = var_175_51
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_55 = var_175_47 + 0.3
			local var_175_56 = math.max(var_175_48, arg_172_1.talkMaxDuration)

			if var_175_55 <= arg_172_1.time_ and arg_172_1.time_ < var_175_55 + var_175_56 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_55) / var_175_56

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_55 + var_175_56 and arg_172_1.time_ < var_175_55 + var_175_56 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play324111044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 324111044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play324111045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.525

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(324111044)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 21
				local var_182_5 = utf8.len(var_182_3)
				local var_182_6 = var_182_4 <= 0 and var_182_1 or var_182_1 * (var_182_5 / var_182_4)

				if var_182_6 > 0 and var_182_1 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_7 and arg_179_1.time_ < var_182_0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play324111045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 324111045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play324111046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.125

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[7].name)

				arg_183_1.leftNameTxt_.text = var_186_2

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

				local var_186_3 = arg_183_1:GetWordFromCfg(324111045)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 5
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_8 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_8 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_8

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_8 and arg_183_1.time_ < var_186_0 + var_186_8 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play324111046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 324111046
		arg_187_1.duration_ = 8.4

		local var_187_0 = {
			zh = 5.033,
			ja = 8.4
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play324111047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = "1070ui_story"

			if arg_187_1.actors_[var_190_0] == nil then
				local var_190_1 = Asset.Load("Char/" .. "1070ui_story")

				if not isNil(var_190_1) then
					local var_190_2 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_187_1.stage_.transform)

					var_190_2.name = var_190_0
					var_190_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_187_1.actors_[var_190_0] = var_190_2

					local var_190_3 = var_190_2:GetComponentInChildren(typeof(CharacterEffect))

					var_190_3.enabled = true

					local var_190_4 = GameObjectTools.GetOrAddComponent(var_190_2, typeof(DynamicBoneHelper))

					if var_190_4 then
						var_190_4:EnableDynamicBone(false)
					end

					arg_187_1:ShowWeapon(var_190_3.transform, false)

					arg_187_1.var_[var_190_0 .. "Animator"] = var_190_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_187_1.var_[var_190_0 .. "Animator"].applyRootMotion = true
					arg_187_1.var_[var_190_0 .. "LipSync"] = var_190_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_190_5 = arg_187_1.actors_["1070ui_story"].transform
			local var_190_6 = 0

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.var_.moveOldPos1070ui_story = var_190_5.localPosition
			end

			local var_190_7 = 0.001

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_7 then
				local var_190_8 = (arg_187_1.time_ - var_190_6) / var_190_7
				local var_190_9 = Vector3.New(0, -0.95, -6.05)

				var_190_5.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1070ui_story, var_190_9, var_190_8)

				local var_190_10 = manager.ui.mainCamera.transform.position - var_190_5.position

				var_190_5.forward = Vector3.New(var_190_10.x, var_190_10.y, var_190_10.z)

				local var_190_11 = var_190_5.localEulerAngles

				var_190_11.z = 0
				var_190_11.x = 0
				var_190_5.localEulerAngles = var_190_11
			end

			if arg_187_1.time_ >= var_190_6 + var_190_7 and arg_187_1.time_ < var_190_6 + var_190_7 + arg_190_0 then
				var_190_5.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_190_12 = manager.ui.mainCamera.transform.position - var_190_5.position

				var_190_5.forward = Vector3.New(var_190_12.x, var_190_12.y, var_190_12.z)

				local var_190_13 = var_190_5.localEulerAngles

				var_190_13.z = 0
				var_190_13.x = 0
				var_190_5.localEulerAngles = var_190_13
			end

			local var_190_14 = arg_187_1.actors_["1070ui_story"]
			local var_190_15 = 0

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 and not isNil(var_190_14) and arg_187_1.var_.characterEffect1070ui_story == nil then
				arg_187_1.var_.characterEffect1070ui_story = var_190_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_16 = 0.200000002980232

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_16 and not isNil(var_190_14) then
				local var_190_17 = (arg_187_1.time_ - var_190_15) / var_190_16

				if arg_187_1.var_.characterEffect1070ui_story and not isNil(var_190_14) then
					arg_187_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_15 + var_190_16 and arg_187_1.time_ < var_190_15 + var_190_16 + arg_190_0 and not isNil(var_190_14) and arg_187_1.var_.characterEffect1070ui_story then
				arg_187_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_190_18 = 0

			if var_190_18 < arg_187_1.time_ and arg_187_1.time_ <= var_190_18 + arg_190_0 then
				arg_187_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_190_19 = 0

			if var_190_19 < arg_187_1.time_ and arg_187_1.time_ <= var_190_19 + arg_190_0 then
				arg_187_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_190_20 = 0
			local var_190_21 = 0.6

			if var_190_20 < arg_187_1.time_ and arg_187_1.time_ <= var_190_20 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_22 = arg_187_1:FormatText(StoryNameCfg[318].name)

				arg_187_1.leftNameTxt_.text = var_190_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_23 = arg_187_1:GetWordFromCfg(324111046)
				local var_190_24 = arg_187_1:FormatText(var_190_23.content)

				arg_187_1.text_.text = var_190_24

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_25 = 24
				local var_190_26 = utf8.len(var_190_24)
				local var_190_27 = var_190_25 <= 0 and var_190_21 or var_190_21 * (var_190_26 / var_190_25)

				if var_190_27 > 0 and var_190_21 < var_190_27 then
					arg_187_1.talkMaxDuration = var_190_27

					if var_190_27 + var_190_20 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_27 + var_190_20
					end
				end

				arg_187_1.text_.text = var_190_24
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111046", "story_v_out_324111.awb") ~= 0 then
					local var_190_28 = manager.audio:GetVoiceLength("story_v_out_324111", "324111046", "story_v_out_324111.awb") / 1000

					if var_190_28 + var_190_20 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_28 + var_190_20
					end

					if var_190_23.prefab_name ~= "" and arg_187_1.actors_[var_190_23.prefab_name] ~= nil then
						local var_190_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_23.prefab_name].transform, "story_v_out_324111", "324111046", "story_v_out_324111.awb")

						arg_187_1:RecordAudio("324111046", var_190_29)
						arg_187_1:RecordAudio("324111046", var_190_29)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_324111", "324111046", "story_v_out_324111.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_324111", "324111046", "story_v_out_324111.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_30 = math.max(var_190_21, arg_187_1.talkMaxDuration)

			if var_190_20 <= arg_187_1.time_ and arg_187_1.time_ < var_190_20 + var_190_30 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_20) / var_190_30

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_20 + var_190_30 and arg_187_1.time_ < var_190_20 + var_190_30 + arg_190_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play324111047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 324111047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play324111048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1070ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1070ui_story == nil then
				arg_191_1.var_.characterEffect1070ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect1070ui_story and not isNil(var_194_0) then
					local var_194_4 = Mathf.Lerp(0, 0.5, var_194_3)

					arg_191_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1070ui_story.fillRatio = var_194_4
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1070ui_story then
				local var_194_5 = 0.5

				arg_191_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1070ui_story.fillRatio = var_194_5
			end

			local var_194_6 = 0
			local var_194_7 = 0.175

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

				local var_194_9 = arg_191_1:GetWordFromCfg(324111047)
				local var_194_10 = arg_191_1:FormatText(var_194_9.content)

				arg_191_1.text_.text = var_194_10

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 7
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
	Play324111048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 324111048
		arg_195_1.duration_ = 4.57

		local var_195_0 = {
			zh = 4.133,
			ja = 4.566
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play324111049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1054ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1054ui_story = var_198_0.localPosition

				local var_198_2 = GameObjectTools.GetOrAddComponent(var_198_0.gameObject, typeof(DynamicBoneHelper))

				if var_198_2 then
					var_198_2:EnableDynamicBone(false)
				end
			end

			local var_198_3 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_3 then
				local var_198_4 = (arg_195_1.time_ - var_198_1) / var_198_3
				local var_198_5 = Vector3.New(0.7, -0.985, -6)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1054ui_story, var_198_5, var_198_4)

				local var_198_6 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_6.x, var_198_6.y, var_198_6.z)

				local var_198_7 = var_198_0.localEulerAngles

				var_198_7.z = 0
				var_198_7.x = 0
				var_198_0.localEulerAngles = var_198_7
			end

			if arg_195_1.time_ >= var_198_1 + var_198_3 and arg_195_1.time_ < var_198_1 + var_198_3 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_198_8 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_8.x, var_198_8.y, var_198_8.z)

				local var_198_9 = var_198_0.localEulerAngles

				var_198_9.z = 0
				var_198_9.x = 0
				var_198_0.localEulerAngles = var_198_9

				local var_198_10 = GameObjectTools.GetOrAddComponent(var_198_0.gameObject, typeof(DynamicBoneHelper))

				if var_198_10 then
					var_198_10:EnableDynamicBone(true)
				end
			end

			local var_198_11 = arg_195_1.actors_["1070ui_story"].transform
			local var_198_12 = 0

			if var_198_12 < arg_195_1.time_ and arg_195_1.time_ <= var_198_12 + arg_198_0 then
				arg_195_1.var_.moveOldPos1070ui_story = var_198_11.localPosition
			end

			local var_198_13 = 0.001

			if var_198_12 <= arg_195_1.time_ and arg_195_1.time_ < var_198_12 + var_198_13 then
				local var_198_14 = (arg_195_1.time_ - var_198_12) / var_198_13
				local var_198_15 = Vector3.New(-0.7, -0.95, -6.05)

				var_198_11.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1070ui_story, var_198_15, var_198_14)

				local var_198_16 = manager.ui.mainCamera.transform.position - var_198_11.position

				var_198_11.forward = Vector3.New(var_198_16.x, var_198_16.y, var_198_16.z)

				local var_198_17 = var_198_11.localEulerAngles

				var_198_17.z = 0
				var_198_17.x = 0
				var_198_11.localEulerAngles = var_198_17
			end

			if arg_195_1.time_ >= var_198_12 + var_198_13 and arg_195_1.time_ < var_198_12 + var_198_13 + arg_198_0 then
				var_198_11.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_198_18 = manager.ui.mainCamera.transform.position - var_198_11.position

				var_198_11.forward = Vector3.New(var_198_18.x, var_198_18.y, var_198_18.z)

				local var_198_19 = var_198_11.localEulerAngles

				var_198_19.z = 0
				var_198_19.x = 0
				var_198_11.localEulerAngles = var_198_19
			end

			local var_198_20 = arg_195_1.actors_["1054ui_story"]
			local var_198_21 = 0

			if var_198_21 < arg_195_1.time_ and arg_195_1.time_ <= var_198_21 + arg_198_0 and not isNil(var_198_20) and arg_195_1.var_.characterEffect1054ui_story == nil then
				arg_195_1.var_.characterEffect1054ui_story = var_198_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_22 = 0.200000002980232

			if var_198_21 <= arg_195_1.time_ and arg_195_1.time_ < var_198_21 + var_198_22 and not isNil(var_198_20) then
				local var_198_23 = (arg_195_1.time_ - var_198_21) / var_198_22

				if arg_195_1.var_.characterEffect1054ui_story and not isNil(var_198_20) then
					arg_195_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_21 + var_198_22 and arg_195_1.time_ < var_198_21 + var_198_22 + arg_198_0 and not isNil(var_198_20) and arg_195_1.var_.characterEffect1054ui_story then
				arg_195_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_198_24 = 0

			if var_198_24 < arg_195_1.time_ and arg_195_1.time_ <= var_198_24 + arg_198_0 then
				arg_195_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_198_25 = 0

			if var_198_25 < arg_195_1.time_ and arg_195_1.time_ <= var_198_25 + arg_198_0 then
				arg_195_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_198_26 = 0
			local var_198_27 = 0.35

			if var_198_26 < arg_195_1.time_ and arg_195_1.time_ <= var_198_26 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_28 = arg_195_1:FormatText(StoryNameCfg[1487].name)

				arg_195_1.leftNameTxt_.text = var_198_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_29 = arg_195_1:GetWordFromCfg(324111048)
				local var_198_30 = arg_195_1:FormatText(var_198_29.content)

				arg_195_1.text_.text = var_198_30

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_31 = 14
				local var_198_32 = utf8.len(var_198_30)
				local var_198_33 = var_198_31 <= 0 and var_198_27 or var_198_27 * (var_198_32 / var_198_31)

				if var_198_33 > 0 and var_198_27 < var_198_33 then
					arg_195_1.talkMaxDuration = var_198_33

					if var_198_33 + var_198_26 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_33 + var_198_26
					end
				end

				arg_195_1.text_.text = var_198_30
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111048", "story_v_out_324111.awb") ~= 0 then
					local var_198_34 = manager.audio:GetVoiceLength("story_v_out_324111", "324111048", "story_v_out_324111.awb") / 1000

					if var_198_34 + var_198_26 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_34 + var_198_26
					end

					if var_198_29.prefab_name ~= "" and arg_195_1.actors_[var_198_29.prefab_name] ~= nil then
						local var_198_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_29.prefab_name].transform, "story_v_out_324111", "324111048", "story_v_out_324111.awb")

						arg_195_1:RecordAudio("324111048", var_198_35)
						arg_195_1:RecordAudio("324111048", var_198_35)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_324111", "324111048", "story_v_out_324111.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_324111", "324111048", "story_v_out_324111.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_36 = math.max(var_198_27, arg_195_1.talkMaxDuration)

			if var_198_26 <= arg_195_1.time_ and arg_195_1.time_ < var_198_26 + var_198_36 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_26) / var_198_36

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_26 + var_198_36 and arg_195_1.time_ < var_198_26 + var_198_36 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play324111049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 324111049
		arg_199_1.duration_ = 2.43

		local var_199_0 = {
			zh = 1.999999999999,
			ja = 2.433
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play324111050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1070ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1070ui_story == nil then
				arg_199_1.var_.characterEffect1070ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1070ui_story and not isNil(var_202_0) then
					arg_199_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1070ui_story then
				arg_199_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_202_4 = arg_199_1.actors_["1054ui_story"]
			local var_202_5 = 0

			if var_202_5 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.characterEffect1054ui_story == nil then
				arg_199_1.var_.characterEffect1054ui_story = var_202_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_6 = 0.200000002980232

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_6 and not isNil(var_202_4) then
				local var_202_7 = (arg_199_1.time_ - var_202_5) / var_202_6

				if arg_199_1.var_.characterEffect1054ui_story and not isNil(var_202_4) then
					local var_202_8 = Mathf.Lerp(0, 0.5, var_202_7)

					arg_199_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1054ui_story.fillRatio = var_202_8
				end
			end

			if arg_199_1.time_ >= var_202_5 + var_202_6 and arg_199_1.time_ < var_202_5 + var_202_6 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.characterEffect1054ui_story then
				local var_202_9 = 0.5

				arg_199_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1054ui_story.fillRatio = var_202_9
			end

			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 then
				arg_199_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_202_11 = 0

			if var_202_11 < arg_199_1.time_ and arg_199_1.time_ <= var_202_11 + arg_202_0 then
				arg_199_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_202_12 = 0
			local var_202_13 = 0.05

			if var_202_12 < arg_199_1.time_ and arg_199_1.time_ <= var_202_12 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_14 = arg_199_1:FormatText(StoryNameCfg[318].name)

				arg_199_1.leftNameTxt_.text = var_202_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_15 = arg_199_1:GetWordFromCfg(324111049)
				local var_202_16 = arg_199_1:FormatText(var_202_15.content)

				arg_199_1.text_.text = var_202_16

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_17 = 2
				local var_202_18 = utf8.len(var_202_16)
				local var_202_19 = var_202_17 <= 0 and var_202_13 or var_202_13 * (var_202_18 / var_202_17)

				if var_202_19 > 0 and var_202_13 < var_202_19 then
					arg_199_1.talkMaxDuration = var_202_19

					if var_202_19 + var_202_12 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_19 + var_202_12
					end
				end

				arg_199_1.text_.text = var_202_16
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111049", "story_v_out_324111.awb") ~= 0 then
					local var_202_20 = manager.audio:GetVoiceLength("story_v_out_324111", "324111049", "story_v_out_324111.awb") / 1000

					if var_202_20 + var_202_12 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_20 + var_202_12
					end

					if var_202_15.prefab_name ~= "" and arg_199_1.actors_[var_202_15.prefab_name] ~= nil then
						local var_202_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_15.prefab_name].transform, "story_v_out_324111", "324111049", "story_v_out_324111.awb")

						arg_199_1:RecordAudio("324111049", var_202_21)
						arg_199_1:RecordAudio("324111049", var_202_21)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_324111", "324111049", "story_v_out_324111.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_324111", "324111049", "story_v_out_324111.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_22 = math.max(var_202_13, arg_199_1.talkMaxDuration)

			if var_202_12 <= arg_199_1.time_ and arg_199_1.time_ < var_202_12 + var_202_22 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_12) / var_202_22

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_12 + var_202_22 and arg_199_1.time_ < var_202_12 + var_202_22 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play324111050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 324111050
		arg_203_1.duration_ = 7.33

		local var_203_0 = {
			zh = 5.866,
			ja = 7.333
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play324111051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["6148ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos6148ui_story = var_206_0.localPosition

				local var_206_2 = GameObjectTools.GetOrAddComponent(var_206_0.gameObject, typeof(DynamicBoneHelper))

				if var_206_2 then
					var_206_2:EnableDynamicBone(false)
				end
			end

			local var_206_3 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_3 then
				local var_206_4 = (arg_203_1.time_ - var_206_1) / var_206_3
				local var_206_5 = Vector3.New(0.7, -0.985, -6)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos6148ui_story, var_206_5, var_206_4)

				local var_206_6 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_6.x, var_206_6.y, var_206_6.z)

				local var_206_7 = var_206_0.localEulerAngles

				var_206_7.z = 0
				var_206_7.x = 0
				var_206_0.localEulerAngles = var_206_7
			end

			if arg_203_1.time_ >= var_206_1 + var_206_3 and arg_203_1.time_ < var_206_1 + var_206_3 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_206_8 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_8.x, var_206_8.y, var_206_8.z)

				local var_206_9 = var_206_0.localEulerAngles

				var_206_9.z = 0
				var_206_9.x = 0
				var_206_0.localEulerAngles = var_206_9

				local var_206_10 = GameObjectTools.GetOrAddComponent(var_206_0.gameObject, typeof(DynamicBoneHelper))

				if var_206_10 then
					var_206_10:EnableDynamicBone(true)
				end
			end

			local var_206_11 = arg_203_1.actors_["1054ui_story"].transform
			local var_206_12 = 0

			if var_206_12 < arg_203_1.time_ and arg_203_1.time_ <= var_206_12 + arg_206_0 then
				arg_203_1.var_.moveOldPos1054ui_story = var_206_11.localPosition

				local var_206_13 = GameObjectTools.GetOrAddComponent(var_206_11.gameObject, typeof(DynamicBoneHelper))

				if var_206_13 then
					var_206_13:EnableDynamicBone(false)
				end
			end

			local var_206_14 = 0.001

			if var_206_12 <= arg_203_1.time_ and arg_203_1.time_ < var_206_12 + var_206_14 then
				local var_206_15 = (arg_203_1.time_ - var_206_12) / var_206_14
				local var_206_16 = Vector3.New(0, 100, 0)

				var_206_11.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1054ui_story, var_206_16, var_206_15)

				local var_206_17 = manager.ui.mainCamera.transform.position - var_206_11.position

				var_206_11.forward = Vector3.New(var_206_17.x, var_206_17.y, var_206_17.z)

				local var_206_18 = var_206_11.localEulerAngles

				var_206_18.z = 0
				var_206_18.x = 0
				var_206_11.localEulerAngles = var_206_18
			end

			if arg_203_1.time_ >= var_206_12 + var_206_14 and arg_203_1.time_ < var_206_12 + var_206_14 + arg_206_0 then
				var_206_11.localPosition = Vector3.New(0, 100, 0)

				local var_206_19 = manager.ui.mainCamera.transform.position - var_206_11.position

				var_206_11.forward = Vector3.New(var_206_19.x, var_206_19.y, var_206_19.z)

				local var_206_20 = var_206_11.localEulerAngles

				var_206_20.z = 0
				var_206_20.x = 0
				var_206_11.localEulerAngles = var_206_20

				local var_206_21 = GameObjectTools.GetOrAddComponent(var_206_11.gameObject, typeof(DynamicBoneHelper))

				if var_206_21 then
					var_206_21:EnableDynamicBone(true)
				end
			end

			local var_206_22 = arg_203_1.actors_["6148ui_story"]
			local var_206_23 = 0

			if var_206_23 < arg_203_1.time_ and arg_203_1.time_ <= var_206_23 + arg_206_0 and not isNil(var_206_22) and arg_203_1.var_.characterEffect6148ui_story == nil then
				arg_203_1.var_.characterEffect6148ui_story = var_206_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_24 = 0.200000002980232

			if var_206_23 <= arg_203_1.time_ and arg_203_1.time_ < var_206_23 + var_206_24 and not isNil(var_206_22) then
				local var_206_25 = (arg_203_1.time_ - var_206_23) / var_206_24

				if arg_203_1.var_.characterEffect6148ui_story and not isNil(var_206_22) then
					arg_203_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_23 + var_206_24 and arg_203_1.time_ < var_206_23 + var_206_24 + arg_206_0 and not isNil(var_206_22) and arg_203_1.var_.characterEffect6148ui_story then
				arg_203_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_206_26 = arg_203_1.actors_["1070ui_story"]
			local var_206_27 = 0

			if var_206_27 < arg_203_1.time_ and arg_203_1.time_ <= var_206_27 + arg_206_0 and not isNil(var_206_26) and arg_203_1.var_.characterEffect1070ui_story == nil then
				arg_203_1.var_.characterEffect1070ui_story = var_206_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_28 = 0.200000002980232

			if var_206_27 <= arg_203_1.time_ and arg_203_1.time_ < var_206_27 + var_206_28 and not isNil(var_206_26) then
				local var_206_29 = (arg_203_1.time_ - var_206_27) / var_206_28

				if arg_203_1.var_.characterEffect1070ui_story and not isNil(var_206_26) then
					local var_206_30 = Mathf.Lerp(0, 0.5, var_206_29)

					arg_203_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1070ui_story.fillRatio = var_206_30
				end
			end

			if arg_203_1.time_ >= var_206_27 + var_206_28 and arg_203_1.time_ < var_206_27 + var_206_28 + arg_206_0 and not isNil(var_206_26) and arg_203_1.var_.characterEffect1070ui_story then
				local var_206_31 = 0.5

				arg_203_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1070ui_story.fillRatio = var_206_31
			end

			local var_206_32 = 0

			if var_206_32 < arg_203_1.time_ and arg_203_1.time_ <= var_206_32 + arg_206_0 then
				arg_203_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_206_33 = 0
			local var_206_34 = 0.825

			if var_206_33 < arg_203_1.time_ and arg_203_1.time_ <= var_206_33 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_35 = arg_203_1:FormatText(StoryNameCfg[1488].name)

				arg_203_1.leftNameTxt_.text = var_206_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_36 = arg_203_1:GetWordFromCfg(324111050)
				local var_206_37 = arg_203_1:FormatText(var_206_36.content)

				arg_203_1.text_.text = var_206_37

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_38 = 33
				local var_206_39 = utf8.len(var_206_37)
				local var_206_40 = var_206_38 <= 0 and var_206_34 or var_206_34 * (var_206_39 / var_206_38)

				if var_206_40 > 0 and var_206_34 < var_206_40 then
					arg_203_1.talkMaxDuration = var_206_40

					if var_206_40 + var_206_33 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_40 + var_206_33
					end
				end

				arg_203_1.text_.text = var_206_37
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111050", "story_v_out_324111.awb") ~= 0 then
					local var_206_41 = manager.audio:GetVoiceLength("story_v_out_324111", "324111050", "story_v_out_324111.awb") / 1000

					if var_206_41 + var_206_33 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_41 + var_206_33
					end

					if var_206_36.prefab_name ~= "" and arg_203_1.actors_[var_206_36.prefab_name] ~= nil then
						local var_206_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_36.prefab_name].transform, "story_v_out_324111", "324111050", "story_v_out_324111.awb")

						arg_203_1:RecordAudio("324111050", var_206_42)
						arg_203_1:RecordAudio("324111050", var_206_42)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_324111", "324111050", "story_v_out_324111.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_324111", "324111050", "story_v_out_324111.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_43 = math.max(var_206_34, arg_203_1.talkMaxDuration)

			if var_206_33 <= arg_203_1.time_ and arg_203_1.time_ < var_206_33 + var_206_43 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_33) / var_206_43

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_33 + var_206_43 and arg_203_1.time_ < var_206_33 + var_206_43 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play324111051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 324111051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play324111052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["6148ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect6148ui_story == nil then
				arg_207_1.var_.characterEffect6148ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect6148ui_story and not isNil(var_210_0) then
					local var_210_4 = Mathf.Lerp(0, 0.5, var_210_3)

					arg_207_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_207_1.var_.characterEffect6148ui_story.fillRatio = var_210_4
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect6148ui_story then
				local var_210_5 = 0.5

				arg_207_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_207_1.var_.characterEffect6148ui_story.fillRatio = var_210_5
			end

			local var_210_6 = 0
			local var_210_7 = 1.25

			if var_210_6 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_8 = arg_207_1:FormatText(StoryNameCfg[7].name)

				arg_207_1.leftNameTxt_.text = var_210_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_9 = arg_207_1:GetWordFromCfg(324111051)
				local var_210_10 = arg_207_1:FormatText(var_210_9.content)

				arg_207_1.text_.text = var_210_10

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 50
				local var_210_12 = utf8.len(var_210_10)
				local var_210_13 = var_210_11 <= 0 and var_210_7 or var_210_7 * (var_210_12 / var_210_11)

				if var_210_13 > 0 and var_210_7 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_10
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_14 and arg_207_1.time_ < var_210_6 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play324111052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 324111052
		arg_211_1.duration_ = 7.1

		local var_211_0 = {
			zh = 5.3,
			ja = 7.1
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play324111053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["6148ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect6148ui_story == nil then
				arg_211_1.var_.characterEffect6148ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect6148ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect6148ui_story then
				arg_211_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_214_4 = 0
			local var_214_5 = 0.65

			if var_214_4 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_6 = arg_211_1:FormatText(StoryNameCfg[1488].name)

				arg_211_1.leftNameTxt_.text = var_214_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_7 = arg_211_1:GetWordFromCfg(324111052)
				local var_214_8 = arg_211_1:FormatText(var_214_7.content)

				arg_211_1.text_.text = var_214_8

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 26
				local var_214_10 = utf8.len(var_214_8)
				local var_214_11 = var_214_9 <= 0 and var_214_5 or var_214_5 * (var_214_10 / var_214_9)

				if var_214_11 > 0 and var_214_5 < var_214_11 then
					arg_211_1.talkMaxDuration = var_214_11

					if var_214_11 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_8
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111052", "story_v_out_324111.awb") ~= 0 then
					local var_214_12 = manager.audio:GetVoiceLength("story_v_out_324111", "324111052", "story_v_out_324111.awb") / 1000

					if var_214_12 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_12 + var_214_4
					end

					if var_214_7.prefab_name ~= "" and arg_211_1.actors_[var_214_7.prefab_name] ~= nil then
						local var_214_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_7.prefab_name].transform, "story_v_out_324111", "324111052", "story_v_out_324111.awb")

						arg_211_1:RecordAudio("324111052", var_214_13)
						arg_211_1:RecordAudio("324111052", var_214_13)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_324111", "324111052", "story_v_out_324111.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_324111", "324111052", "story_v_out_324111.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_14 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_14 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_14

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_14 and arg_211_1.time_ < var_214_4 + var_214_14 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play324111053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 324111053
		arg_215_1.duration_ = 13.83

		local var_215_0 = {
			zh = 9.3,
			ja = 13.833
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play324111054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1070ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1070ui_story == nil then
				arg_215_1.var_.characterEffect1070ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect1070ui_story and not isNil(var_218_0) then
					arg_215_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1070ui_story then
				arg_215_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_218_4 = arg_215_1.actors_["6148ui_story"]
			local var_218_5 = 0

			if var_218_5 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect6148ui_story == nil then
				arg_215_1.var_.characterEffect6148ui_story = var_218_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_6 = 0.200000002980232

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_6 and not isNil(var_218_4) then
				local var_218_7 = (arg_215_1.time_ - var_218_5) / var_218_6

				if arg_215_1.var_.characterEffect6148ui_story and not isNil(var_218_4) then
					local var_218_8 = Mathf.Lerp(0, 0.5, var_218_7)

					arg_215_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_215_1.var_.characterEffect6148ui_story.fillRatio = var_218_8
				end
			end

			if arg_215_1.time_ >= var_218_5 + var_218_6 and arg_215_1.time_ < var_218_5 + var_218_6 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect6148ui_story then
				local var_218_9 = 0.5

				arg_215_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_215_1.var_.characterEffect6148ui_story.fillRatio = var_218_9
			end

			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 then
				arg_215_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_218_11 = 0

			if var_218_11 < arg_215_1.time_ and arg_215_1.time_ <= var_218_11 + arg_218_0 then
				arg_215_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_218_12 = 0
			local var_218_13 = 1.2

			if var_218_12 < arg_215_1.time_ and arg_215_1.time_ <= var_218_12 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_14 = arg_215_1:FormatText(StoryNameCfg[318].name)

				arg_215_1.leftNameTxt_.text = var_218_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_15 = arg_215_1:GetWordFromCfg(324111053)
				local var_218_16 = arg_215_1:FormatText(var_218_15.content)

				arg_215_1.text_.text = var_218_16

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_17 = 48
				local var_218_18 = utf8.len(var_218_16)
				local var_218_19 = var_218_17 <= 0 and var_218_13 or var_218_13 * (var_218_18 / var_218_17)

				if var_218_19 > 0 and var_218_13 < var_218_19 then
					arg_215_1.talkMaxDuration = var_218_19

					if var_218_19 + var_218_12 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_19 + var_218_12
					end
				end

				arg_215_1.text_.text = var_218_16
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111053", "story_v_out_324111.awb") ~= 0 then
					local var_218_20 = manager.audio:GetVoiceLength("story_v_out_324111", "324111053", "story_v_out_324111.awb") / 1000

					if var_218_20 + var_218_12 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_20 + var_218_12
					end

					if var_218_15.prefab_name ~= "" and arg_215_1.actors_[var_218_15.prefab_name] ~= nil then
						local var_218_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_15.prefab_name].transform, "story_v_out_324111", "324111053", "story_v_out_324111.awb")

						arg_215_1:RecordAudio("324111053", var_218_21)
						arg_215_1:RecordAudio("324111053", var_218_21)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_324111", "324111053", "story_v_out_324111.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_324111", "324111053", "story_v_out_324111.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_22 = math.max(var_218_13, arg_215_1.talkMaxDuration)

			if var_218_12 <= arg_215_1.time_ and arg_215_1.time_ < var_218_12 + var_218_22 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_12) / var_218_22

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_12 + var_218_22 and arg_215_1.time_ < var_218_12 + var_218_22 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play324111054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 324111054
		arg_219_1.duration_ = 9.47

		local var_219_0 = {
			zh = 6.833,
			ja = 9.466
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play324111055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["6148ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect6148ui_story == nil then
				arg_219_1.var_.characterEffect6148ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect6148ui_story and not isNil(var_222_0) then
					arg_219_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect6148ui_story then
				arg_219_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_222_4 = arg_219_1.actors_["1070ui_story"]
			local var_222_5 = 0

			if var_222_5 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect1070ui_story == nil then
				arg_219_1.var_.characterEffect1070ui_story = var_222_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_6 = 0.200000002980232

			if var_222_5 <= arg_219_1.time_ and arg_219_1.time_ < var_222_5 + var_222_6 and not isNil(var_222_4) then
				local var_222_7 = (arg_219_1.time_ - var_222_5) / var_222_6

				if arg_219_1.var_.characterEffect1070ui_story and not isNil(var_222_4) then
					local var_222_8 = Mathf.Lerp(0, 0.5, var_222_7)

					arg_219_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1070ui_story.fillRatio = var_222_8
				end
			end

			if arg_219_1.time_ >= var_222_5 + var_222_6 and arg_219_1.time_ < var_222_5 + var_222_6 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect1070ui_story then
				local var_222_9 = 0.5

				arg_219_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1070ui_story.fillRatio = var_222_9
			end

			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 then
				arg_219_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_222_11 = 0
			local var_222_12 = 0.825

			if var_222_11 < arg_219_1.time_ and arg_219_1.time_ <= var_222_11 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_13 = arg_219_1:FormatText(StoryNameCfg[1488].name)

				arg_219_1.leftNameTxt_.text = var_222_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_14 = arg_219_1:GetWordFromCfg(324111054)
				local var_222_15 = arg_219_1:FormatText(var_222_14.content)

				arg_219_1.text_.text = var_222_15

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_16 = 33
				local var_222_17 = utf8.len(var_222_15)
				local var_222_18 = var_222_16 <= 0 and var_222_12 or var_222_12 * (var_222_17 / var_222_16)

				if var_222_18 > 0 and var_222_12 < var_222_18 then
					arg_219_1.talkMaxDuration = var_222_18

					if var_222_18 + var_222_11 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_18 + var_222_11
					end
				end

				arg_219_1.text_.text = var_222_15
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111054", "story_v_out_324111.awb") ~= 0 then
					local var_222_19 = manager.audio:GetVoiceLength("story_v_out_324111", "324111054", "story_v_out_324111.awb") / 1000

					if var_222_19 + var_222_11 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_19 + var_222_11
					end

					if var_222_14.prefab_name ~= "" and arg_219_1.actors_[var_222_14.prefab_name] ~= nil then
						local var_222_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_14.prefab_name].transform, "story_v_out_324111", "324111054", "story_v_out_324111.awb")

						arg_219_1:RecordAudio("324111054", var_222_20)
						arg_219_1:RecordAudio("324111054", var_222_20)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_324111", "324111054", "story_v_out_324111.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_324111", "324111054", "story_v_out_324111.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_21 = math.max(var_222_12, arg_219_1.talkMaxDuration)

			if var_222_11 <= arg_219_1.time_ and arg_219_1.time_ < var_222_11 + var_222_21 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_11) / var_222_21

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_11 + var_222_21 and arg_219_1.time_ < var_222_11 + var_222_21 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play324111055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 324111055
		arg_223_1.duration_ = 9.33

		local var_223_0 = {
			zh = 5.866,
			ja = 9.333
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play324111056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.725

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[1488].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:GetWordFromCfg(324111055)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 29
				local var_226_6 = utf8.len(var_226_4)
				local var_226_7 = var_226_5 <= 0 and var_226_1 or var_226_1 * (var_226_6 / var_226_5)

				if var_226_7 > 0 and var_226_1 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111055", "story_v_out_324111.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_324111", "324111055", "story_v_out_324111.awb") / 1000

					if var_226_8 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_324111", "324111055", "story_v_out_324111.awb")

						arg_223_1:RecordAudio("324111055", var_226_9)
						arg_223_1:RecordAudio("324111055", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_324111", "324111055", "story_v_out_324111.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_324111", "324111055", "story_v_out_324111.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_10 and arg_223_1.time_ < var_226_0 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play324111056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 324111056
		arg_227_1.duration_ = 6.3

		local var_227_0 = {
			zh = 4.1,
			ja = 6.3
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play324111057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1070ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1070ui_story == nil then
				arg_227_1.var_.characterEffect1070ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect1070ui_story and not isNil(var_230_0) then
					arg_227_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1070ui_story then
				arg_227_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_230_4 = arg_227_1.actors_["6148ui_story"]
			local var_230_5 = 0

			if var_230_5 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 and not isNil(var_230_4) and arg_227_1.var_.characterEffect6148ui_story == nil then
				arg_227_1.var_.characterEffect6148ui_story = var_230_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_6 = 0.200000002980232

			if var_230_5 <= arg_227_1.time_ and arg_227_1.time_ < var_230_5 + var_230_6 and not isNil(var_230_4) then
				local var_230_7 = (arg_227_1.time_ - var_230_5) / var_230_6

				if arg_227_1.var_.characterEffect6148ui_story and not isNil(var_230_4) then
					local var_230_8 = Mathf.Lerp(0, 0.5, var_230_7)

					arg_227_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_227_1.var_.characterEffect6148ui_story.fillRatio = var_230_8
				end
			end

			if arg_227_1.time_ >= var_230_5 + var_230_6 and arg_227_1.time_ < var_230_5 + var_230_6 + arg_230_0 and not isNil(var_230_4) and arg_227_1.var_.characterEffect6148ui_story then
				local var_230_9 = 0.5

				arg_227_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_227_1.var_.characterEffect6148ui_story.fillRatio = var_230_9
			end

			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 then
				arg_227_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action464")
			end

			local var_230_11 = 0

			if var_230_11 < arg_227_1.time_ and arg_227_1.time_ <= var_230_11 + arg_230_0 then
				arg_227_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_230_12 = 0

			if var_230_12 < arg_227_1.time_ and arg_227_1.time_ <= var_230_12 + arg_230_0 then
				arg_227_1.allBtn_.enabled = false
			end

			local var_230_13 = 1.66666666666667

			if arg_227_1.time_ >= var_230_12 + var_230_13 and arg_227_1.time_ < var_230_12 + var_230_13 + arg_230_0 then
				arg_227_1.allBtn_.enabled = true
			end

			local var_230_14 = 2
			local var_230_15 = 1

			if var_230_14 < arg_227_1.time_ and arg_227_1.time_ <= var_230_14 + arg_230_0 then
				local var_230_16 = "play"
				local var_230_17 = "effect"

				arg_227_1:AudioAction(var_230_16, var_230_17, "se_story_148", "se_story_148_earthquake01", "")
			end

			local var_230_18 = 0
			local var_230_19 = 0.35

			if var_230_18 < arg_227_1.time_ and arg_227_1.time_ <= var_230_18 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_20 = arg_227_1:FormatText(StoryNameCfg[318].name)

				arg_227_1.leftNameTxt_.text = var_230_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_21 = arg_227_1:GetWordFromCfg(324111056)
				local var_230_22 = arg_227_1:FormatText(var_230_21.content)

				arg_227_1.text_.text = var_230_22

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_23 = 14
				local var_230_24 = utf8.len(var_230_22)
				local var_230_25 = var_230_23 <= 0 and var_230_19 or var_230_19 * (var_230_24 / var_230_23)

				if var_230_25 > 0 and var_230_19 < var_230_25 then
					arg_227_1.talkMaxDuration = var_230_25

					if var_230_25 + var_230_18 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_25 + var_230_18
					end
				end

				arg_227_1.text_.text = var_230_22
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111056", "story_v_out_324111.awb") ~= 0 then
					local var_230_26 = manager.audio:GetVoiceLength("story_v_out_324111", "324111056", "story_v_out_324111.awb") / 1000

					if var_230_26 + var_230_18 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_26 + var_230_18
					end

					if var_230_21.prefab_name ~= "" and arg_227_1.actors_[var_230_21.prefab_name] ~= nil then
						local var_230_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_21.prefab_name].transform, "story_v_out_324111", "324111056", "story_v_out_324111.awb")

						arg_227_1:RecordAudio("324111056", var_230_27)
						arg_227_1:RecordAudio("324111056", var_230_27)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_324111", "324111056", "story_v_out_324111.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_324111", "324111056", "story_v_out_324111.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_28 = math.max(var_230_19, arg_227_1.talkMaxDuration)

			if var_230_18 <= arg_227_1.time_ and arg_227_1.time_ < var_230_18 + var_230_28 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_18) / var_230_28

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_18 + var_230_28 and arg_227_1.time_ < var_230_18 + var_230_28 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 6,
				className = "StoryShakeNode",
				duration = 0.6,
				startTime = 0.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(10, 0.1, 0.1)
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play324111057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 324111057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play324111058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["6148ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos6148ui_story = var_234_0.localPosition

				local var_234_2 = GameObjectTools.GetOrAddComponent(var_234_0.gameObject, typeof(DynamicBoneHelper))

				if var_234_2 then
					var_234_2:EnableDynamicBone(false)
				end
			end

			local var_234_3 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_3 then
				local var_234_4 = (arg_231_1.time_ - var_234_1) / var_234_3
				local var_234_5 = Vector3.New(0, 100, 0)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos6148ui_story, var_234_5, var_234_4)

				local var_234_6 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_6.x, var_234_6.y, var_234_6.z)

				local var_234_7 = var_234_0.localEulerAngles

				var_234_7.z = 0
				var_234_7.x = 0
				var_234_0.localEulerAngles = var_234_7
			end

			if arg_231_1.time_ >= var_234_1 + var_234_3 and arg_231_1.time_ < var_234_1 + var_234_3 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0, 100, 0)

				local var_234_8 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_8.x, var_234_8.y, var_234_8.z)

				local var_234_9 = var_234_0.localEulerAngles

				var_234_9.z = 0
				var_234_9.x = 0
				var_234_0.localEulerAngles = var_234_9

				local var_234_10 = GameObjectTools.GetOrAddComponent(var_234_0.gameObject, typeof(DynamicBoneHelper))

				if var_234_10 then
					var_234_10:EnableDynamicBone(true)
				end
			end

			local var_234_11 = arg_231_1.actors_["1070ui_story"].transform
			local var_234_12 = 0

			if var_234_12 < arg_231_1.time_ and arg_231_1.time_ <= var_234_12 + arg_234_0 then
				arg_231_1.var_.moveOldPos1070ui_story = var_234_11.localPosition
			end

			local var_234_13 = 0.001

			if var_234_12 <= arg_231_1.time_ and arg_231_1.time_ < var_234_12 + var_234_13 then
				local var_234_14 = (arg_231_1.time_ - var_234_12) / var_234_13
				local var_234_15 = Vector3.New(0, 100, 0)

				var_234_11.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1070ui_story, var_234_15, var_234_14)

				local var_234_16 = manager.ui.mainCamera.transform.position - var_234_11.position

				var_234_11.forward = Vector3.New(var_234_16.x, var_234_16.y, var_234_16.z)

				local var_234_17 = var_234_11.localEulerAngles

				var_234_17.z = 0
				var_234_17.x = 0
				var_234_11.localEulerAngles = var_234_17
			end

			if arg_231_1.time_ >= var_234_12 + var_234_13 and arg_231_1.time_ < var_234_12 + var_234_13 + arg_234_0 then
				var_234_11.localPosition = Vector3.New(0, 100, 0)

				local var_234_18 = manager.ui.mainCamera.transform.position - var_234_11.position

				var_234_11.forward = Vector3.New(var_234_18.x, var_234_18.y, var_234_18.z)

				local var_234_19 = var_234_11.localEulerAngles

				var_234_19.z = 0
				var_234_19.x = 0
				var_234_11.localEulerAngles = var_234_19
			end

			local var_234_20 = arg_231_1.actors_["1070ui_story"]
			local var_234_21 = 0

			if var_234_21 < arg_231_1.time_ and arg_231_1.time_ <= var_234_21 + arg_234_0 and not isNil(var_234_20) and arg_231_1.var_.characterEffect1070ui_story == nil then
				arg_231_1.var_.characterEffect1070ui_story = var_234_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_22 = 0.200000002980232

			if var_234_21 <= arg_231_1.time_ and arg_231_1.time_ < var_234_21 + var_234_22 and not isNil(var_234_20) then
				local var_234_23 = (arg_231_1.time_ - var_234_21) / var_234_22

				if arg_231_1.var_.characterEffect1070ui_story and not isNil(var_234_20) then
					local var_234_24 = Mathf.Lerp(0, 0.5, var_234_23)

					arg_231_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1070ui_story.fillRatio = var_234_24
				end
			end

			if arg_231_1.time_ >= var_234_21 + var_234_22 and arg_231_1.time_ < var_234_21 + var_234_22 + arg_234_0 and not isNil(var_234_20) and arg_231_1.var_.characterEffect1070ui_story then
				local var_234_25 = 0.5

				arg_231_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1070ui_story.fillRatio = var_234_25
			end

			local var_234_26 = 0
			local var_234_27 = 1.05

			if var_234_26 < arg_231_1.time_ and arg_231_1.time_ <= var_234_26 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_28 = arg_231_1:GetWordFromCfg(324111057)
				local var_234_29 = arg_231_1:FormatText(var_234_28.content)

				arg_231_1.text_.text = var_234_29

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_30 = 42
				local var_234_31 = utf8.len(var_234_29)
				local var_234_32 = var_234_30 <= 0 and var_234_27 or var_234_27 * (var_234_31 / var_234_30)

				if var_234_32 > 0 and var_234_27 < var_234_32 then
					arg_231_1.talkMaxDuration = var_234_32

					if var_234_32 + var_234_26 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_32 + var_234_26
					end
				end

				arg_231_1.text_.text = var_234_29
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_33 = math.max(var_234_27, arg_231_1.talkMaxDuration)

			if var_234_26 <= arg_231_1.time_ and arg_231_1.time_ < var_234_26 + var_234_33 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_26) / var_234_33

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_26 + var_234_33 and arg_231_1.time_ < var_234_26 + var_234_33 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
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
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play324111058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 324111058
		arg_235_1.duration_ = 6.37

		local var_235_0 = {
			zh = 6.366,
			ja = 5.666
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play324111059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1054ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos1054ui_story = var_238_0.localPosition

				local var_238_2 = GameObjectTools.GetOrAddComponent(var_238_0.gameObject, typeof(DynamicBoneHelper))

				if var_238_2 then
					var_238_2:EnableDynamicBone(false)
				end
			end

			local var_238_3 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_3 then
				local var_238_4 = (arg_235_1.time_ - var_238_1) / var_238_3
				local var_238_5 = Vector3.New(0, -0.985, -6)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1054ui_story, var_238_5, var_238_4)

				local var_238_6 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_6.x, var_238_6.y, var_238_6.z)

				local var_238_7 = var_238_0.localEulerAngles

				var_238_7.z = 0
				var_238_7.x = 0
				var_238_0.localEulerAngles = var_238_7
			end

			if arg_235_1.time_ >= var_238_1 + var_238_3 and arg_235_1.time_ < var_238_1 + var_238_3 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_238_8 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_8.x, var_238_8.y, var_238_8.z)

				local var_238_9 = var_238_0.localEulerAngles

				var_238_9.z = 0
				var_238_9.x = 0
				var_238_0.localEulerAngles = var_238_9

				local var_238_10 = GameObjectTools.GetOrAddComponent(var_238_0.gameObject, typeof(DynamicBoneHelper))

				if var_238_10 then
					var_238_10:EnableDynamicBone(true)
				end
			end

			local var_238_11 = arg_235_1.actors_["1054ui_story"]
			local var_238_12 = 0

			if var_238_12 < arg_235_1.time_ and arg_235_1.time_ <= var_238_12 + arg_238_0 and not isNil(var_238_11) and arg_235_1.var_.characterEffect1054ui_story == nil then
				arg_235_1.var_.characterEffect1054ui_story = var_238_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_13 = 0.200000002980232

			if var_238_12 <= arg_235_1.time_ and arg_235_1.time_ < var_238_12 + var_238_13 and not isNil(var_238_11) then
				local var_238_14 = (arg_235_1.time_ - var_238_12) / var_238_13

				if arg_235_1.var_.characterEffect1054ui_story and not isNil(var_238_11) then
					arg_235_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_12 + var_238_13 and arg_235_1.time_ < var_238_12 + var_238_13 + arg_238_0 and not isNil(var_238_11) and arg_235_1.var_.characterEffect1054ui_story then
				arg_235_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_238_15 = 0

			if var_238_15 < arg_235_1.time_ and arg_235_1.time_ <= var_238_15 + arg_238_0 then
				arg_235_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_238_16 = 0

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 then
				arg_235_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_238_17 = 2
			local var_238_18 = 1

			if var_238_17 < arg_235_1.time_ and arg_235_1.time_ <= var_238_17 + arg_238_0 then
				local var_238_19 = "play"
				local var_238_20 = "effect"

				arg_235_1:AudioAction(var_238_19, var_238_20, "se_story_150", "se_story_150_earthquake_growl", "")
			end

			local var_238_21 = 0
			local var_238_22 = 0.55

			if var_238_21 < arg_235_1.time_ and arg_235_1.time_ <= var_238_21 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_23 = arg_235_1:FormatText(StoryNameCfg[1487].name)

				arg_235_1.leftNameTxt_.text = var_238_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_24 = arg_235_1:GetWordFromCfg(324111058)
				local var_238_25 = arg_235_1:FormatText(var_238_24.content)

				arg_235_1.text_.text = var_238_25

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_26 = 22
				local var_238_27 = utf8.len(var_238_25)
				local var_238_28 = var_238_26 <= 0 and var_238_22 or var_238_22 * (var_238_27 / var_238_26)

				if var_238_28 > 0 and var_238_22 < var_238_28 then
					arg_235_1.talkMaxDuration = var_238_28

					if var_238_28 + var_238_21 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_28 + var_238_21
					end
				end

				arg_235_1.text_.text = var_238_25
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111058", "story_v_out_324111.awb") ~= 0 then
					local var_238_29 = manager.audio:GetVoiceLength("story_v_out_324111", "324111058", "story_v_out_324111.awb") / 1000

					if var_238_29 + var_238_21 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_29 + var_238_21
					end

					if var_238_24.prefab_name ~= "" and arg_235_1.actors_[var_238_24.prefab_name] ~= nil then
						local var_238_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_24.prefab_name].transform, "story_v_out_324111", "324111058", "story_v_out_324111.awb")

						arg_235_1:RecordAudio("324111058", var_238_30)
						arg_235_1:RecordAudio("324111058", var_238_30)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_324111", "324111058", "story_v_out_324111.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_324111", "324111058", "story_v_out_324111.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_31 = math.max(var_238_22, arg_235_1.talkMaxDuration)

			if var_238_21 <= arg_235_1.time_ and arg_235_1.time_ < var_238_21 + var_238_31 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_21) / var_238_31

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_21 + var_238_31 and arg_235_1.time_ < var_238_21 + var_238_31 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
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

		arg_235_1:InitPlayNodeList()
	end,
	Play324111059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 324111059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play324111060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1054ui_story"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1054ui_story == nil then
				arg_239_1.var_.characterEffect1054ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.characterEffect1054ui_story and not isNil(var_242_0) then
					local var_242_4 = Mathf.Lerp(0, 0.5, var_242_3)

					arg_239_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1054ui_story.fillRatio = var_242_4
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1054ui_story then
				local var_242_5 = 0.5

				arg_239_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1054ui_story.fillRatio = var_242_5
			end

			local var_242_6 = 0
			local var_242_7 = 0.075

			if var_242_6 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_8 = arg_239_1:FormatText(StoryNameCfg[7].name)

				arg_239_1.leftNameTxt_.text = var_242_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_9 = arg_239_1:GetWordFromCfg(324111059)
				local var_242_10 = arg_239_1:FormatText(var_242_9.content)

				arg_239_1.text_.text = var_242_10

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_11 = 3
				local var_242_12 = utf8.len(var_242_10)
				local var_242_13 = var_242_11 <= 0 and var_242_7 or var_242_7 * (var_242_12 / var_242_11)

				if var_242_13 > 0 and var_242_7 < var_242_13 then
					arg_239_1.talkMaxDuration = var_242_13

					if var_242_13 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_13 + var_242_6
					end
				end

				arg_239_1.text_.text = var_242_10
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_14 = math.max(var_242_7, arg_239_1.talkMaxDuration)

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_14 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_6) / var_242_14

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_6 + var_242_14 and arg_239_1.time_ < var_242_6 + var_242_14 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play324111060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 324111060
		arg_243_1.duration_ = 5.9

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play324111061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1054ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos1054ui_story = var_246_0.localPosition

				local var_246_2 = GameObjectTools.GetOrAddComponent(var_246_0.gameObject, typeof(DynamicBoneHelper))

				if var_246_2 then
					var_246_2:EnableDynamicBone(false)
				end
			end

			local var_246_3 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_3 then
				local var_246_4 = (arg_243_1.time_ - var_246_1) / var_246_3
				local var_246_5 = Vector3.New(0, 100, 0)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1054ui_story, var_246_5, var_246_4)

				local var_246_6 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_6.x, var_246_6.y, var_246_6.z)

				local var_246_7 = var_246_0.localEulerAngles

				var_246_7.z = 0
				var_246_7.x = 0
				var_246_0.localEulerAngles = var_246_7
			end

			if arg_243_1.time_ >= var_246_1 + var_246_3 and arg_243_1.time_ < var_246_1 + var_246_3 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(0, 100, 0)

				local var_246_8 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_8.x, var_246_8.y, var_246_8.z)

				local var_246_9 = var_246_0.localEulerAngles

				var_246_9.z = 0
				var_246_9.x = 0
				var_246_0.localEulerAngles = var_246_9

				local var_246_10 = GameObjectTools.GetOrAddComponent(var_246_0.gameObject, typeof(DynamicBoneHelper))

				if var_246_10 then
					var_246_10:EnableDynamicBone(true)
				end
			end

			local var_246_11 = 0

			if var_246_11 < arg_243_1.time_ and arg_243_1.time_ <= var_246_11 + arg_246_0 then
				arg_243_1.allBtn_.enabled = false
			end

			local var_246_12 = 1.1

			if arg_243_1.time_ >= var_246_11 + var_246_12 and arg_243_1.time_ < var_246_11 + var_246_12 + arg_246_0 then
				arg_243_1.allBtn_.enabled = true
			end

			local var_246_13 = manager.ui.mainCamera.transform
			local var_246_14 = 0

			if var_246_14 < arg_243_1.time_ and arg_243_1.time_ <= var_246_14 + arg_246_0 then
				arg_243_1.var_.shakeOldPos = var_246_13.localPosition
			end

			local var_246_15 = 1.23333333333333

			if var_246_14 <= arg_243_1.time_ and arg_243_1.time_ < var_246_14 + var_246_15 then
				local var_246_16 = (arg_243_1.time_ - var_246_14) / 0.066
				local var_246_17, var_246_18 = math.modf(var_246_16)

				var_246_13.localPosition = Vector3.New(var_246_18 * 0.13, var_246_18 * 0.13, var_246_18 * 0.13) + arg_243_1.var_.shakeOldPos
			end

			if arg_243_1.time_ >= var_246_14 + var_246_15 and arg_243_1.time_ < var_246_14 + var_246_15 + arg_246_0 then
				var_246_13.localPosition = arg_243_1.var_.shakeOldPos
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_19 = 0.896666697226465
			local var_246_20 = 1.4

			if var_246_19 < arg_243_1.time_ and arg_243_1.time_ <= var_246_19 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_21 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_21:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_243_1.dialogCg_.alpha = arg_247_0
				end))
				var_246_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_22 = arg_243_1:GetWordFromCfg(324111060)
				local var_246_23 = arg_243_1:FormatText(var_246_22.content)

				arg_243_1.text_.text = var_246_23

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_24 = 56
				local var_246_25 = utf8.len(var_246_23)
				local var_246_26 = var_246_24 <= 0 and var_246_20 or var_246_20 * (var_246_25 / var_246_24)

				if var_246_26 > 0 and var_246_20 < var_246_26 then
					arg_243_1.talkMaxDuration = var_246_26
					var_246_19 = var_246_19 + 0.3

					if var_246_26 + var_246_19 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_26 + var_246_19
					end
				end

				arg_243_1.text_.text = var_246_23
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_27 = var_246_19 + 0.3
			local var_246_28 = math.max(var_246_20, arg_243_1.talkMaxDuration)

			if var_246_27 <= arg_243_1.time_ and arg_243_1.time_ < var_246_27 + var_246_28 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_27) / var_246_28

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_27 + var_246_28 and arg_243_1.time_ < var_246_27 + var_246_28 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play324111061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 324111061
		arg_249_1.duration_ = 3.63

		local var_249_0 = {
			zh = 3.633,
			ja = 3.4
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play324111062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1070ui_story"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos1070ui_story = var_252_0.localPosition
			end

			local var_252_2 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2
				local var_252_4 = Vector3.New(0, -0.95, -6.05)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1070ui_story, var_252_4, var_252_3)

				local var_252_5 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_5.x, var_252_5.y, var_252_5.z)

				local var_252_6 = var_252_0.localEulerAngles

				var_252_6.z = 0
				var_252_6.x = 0
				var_252_0.localEulerAngles = var_252_6
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_252_7 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_7.x, var_252_7.y, var_252_7.z)

				local var_252_8 = var_252_0.localEulerAngles

				var_252_8.z = 0
				var_252_8.x = 0
				var_252_0.localEulerAngles = var_252_8
			end

			local var_252_9 = arg_249_1.actors_["1070ui_story"]
			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect1070ui_story == nil then
				arg_249_1.var_.characterEffect1070ui_story = var_252_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_11 = 0.200000002980232

			if var_252_10 <= arg_249_1.time_ and arg_249_1.time_ < var_252_10 + var_252_11 and not isNil(var_252_9) then
				local var_252_12 = (arg_249_1.time_ - var_252_10) / var_252_11

				if arg_249_1.var_.characterEffect1070ui_story and not isNil(var_252_9) then
					arg_249_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_10 + var_252_11 and arg_249_1.time_ < var_252_10 + var_252_11 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect1070ui_story then
				arg_249_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_252_13 = 0

			if var_252_13 < arg_249_1.time_ and arg_249_1.time_ <= var_252_13 + arg_252_0 then
				arg_249_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action442")
			end

			local var_252_14 = 0

			if var_252_14 < arg_249_1.time_ and arg_249_1.time_ <= var_252_14 + arg_252_0 then
				arg_249_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_252_15 = 0
			local var_252_16 = 0.35

			if var_252_15 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_17 = arg_249_1:FormatText(StoryNameCfg[318].name)

				arg_249_1.leftNameTxt_.text = var_252_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_18 = arg_249_1:GetWordFromCfg(324111061)
				local var_252_19 = arg_249_1:FormatText(var_252_18.content)

				arg_249_1.text_.text = var_252_19

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_20 = 14
				local var_252_21 = utf8.len(var_252_19)
				local var_252_22 = var_252_20 <= 0 and var_252_16 or var_252_16 * (var_252_21 / var_252_20)

				if var_252_22 > 0 and var_252_16 < var_252_22 then
					arg_249_1.talkMaxDuration = var_252_22

					if var_252_22 + var_252_15 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_22 + var_252_15
					end
				end

				arg_249_1.text_.text = var_252_19
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111061", "story_v_out_324111.awb") ~= 0 then
					local var_252_23 = manager.audio:GetVoiceLength("story_v_out_324111", "324111061", "story_v_out_324111.awb") / 1000

					if var_252_23 + var_252_15 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_23 + var_252_15
					end

					if var_252_18.prefab_name ~= "" and arg_249_1.actors_[var_252_18.prefab_name] ~= nil then
						local var_252_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_18.prefab_name].transform, "story_v_out_324111", "324111061", "story_v_out_324111.awb")

						arg_249_1:RecordAudio("324111061", var_252_24)
						arg_249_1:RecordAudio("324111061", var_252_24)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_324111", "324111061", "story_v_out_324111.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_324111", "324111061", "story_v_out_324111.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_25 = math.max(var_252_16, arg_249_1.talkMaxDuration)

			if var_252_15 <= arg_249_1.time_ and arg_249_1.time_ < var_252_15 + var_252_25 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_15) / var_252_25

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_15 + var_252_25 and arg_249_1.time_ < var_252_15 + var_252_25 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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

		arg_249_1:InitPlayNodeList()
	end,
	Play324111062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 324111062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play324111063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1070ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1070ui_story == nil then
				arg_253_1.var_.characterEffect1070ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1070ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1070ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1070ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1070ui_story.fillRatio = var_256_5
			end

			local var_256_6 = 0
			local var_256_7 = 0.15

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_8 = arg_253_1:FormatText(StoryNameCfg[7].name)

				arg_253_1.leftNameTxt_.text = var_256_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_9 = arg_253_1:GetWordFromCfg(324111062)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 6
				local var_256_12 = utf8.len(var_256_10)
				local var_256_13 = var_256_11 <= 0 and var_256_7 or var_256_7 * (var_256_12 / var_256_11)

				if var_256_13 > 0 and var_256_7 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_10
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_14 and arg_253_1.time_ < var_256_6 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play324111063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 324111063
		arg_257_1.duration_ = 3.1

		local var_257_0 = {
			zh = 3.033,
			ja = 3.1
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play324111064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1070ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1070ui_story == nil then
				arg_257_1.var_.characterEffect1070ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect1070ui_story and not isNil(var_260_0) then
					arg_257_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1070ui_story then
				arg_257_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_260_4 = 0

			if var_260_4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_2")
			end

			local var_260_5 = 0

			if var_260_5 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 then
				arg_257_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_260_6 = 0
			local var_260_7 = 0.35

			if var_260_6 < arg_257_1.time_ and arg_257_1.time_ <= var_260_6 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_8 = arg_257_1:FormatText(StoryNameCfg[318].name)

				arg_257_1.leftNameTxt_.text = var_260_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_9 = arg_257_1:GetWordFromCfg(324111063)
				local var_260_10 = arg_257_1:FormatText(var_260_9.content)

				arg_257_1.text_.text = var_260_10

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_11 = 14
				local var_260_12 = utf8.len(var_260_10)
				local var_260_13 = var_260_11 <= 0 and var_260_7 or var_260_7 * (var_260_12 / var_260_11)

				if var_260_13 > 0 and var_260_7 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_6
					end
				end

				arg_257_1.text_.text = var_260_10
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111063", "story_v_out_324111.awb") ~= 0 then
					local var_260_14 = manager.audio:GetVoiceLength("story_v_out_324111", "324111063", "story_v_out_324111.awb") / 1000

					if var_260_14 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_14 + var_260_6
					end

					if var_260_9.prefab_name ~= "" and arg_257_1.actors_[var_260_9.prefab_name] ~= nil then
						local var_260_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_9.prefab_name].transform, "story_v_out_324111", "324111063", "story_v_out_324111.awb")

						arg_257_1:RecordAudio("324111063", var_260_15)
						arg_257_1:RecordAudio("324111063", var_260_15)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_324111", "324111063", "story_v_out_324111.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_324111", "324111063", "story_v_out_324111.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_16 = math.max(var_260_7, arg_257_1.talkMaxDuration)

			if var_260_6 <= arg_257_1.time_ and arg_257_1.time_ < var_260_6 + var_260_16 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_6) / var_260_16

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_6 + var_260_16 and arg_257_1.time_ < var_260_6 + var_260_16 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play324111064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 324111064
		arg_261_1.duration_ = 3.8

		local var_261_0 = {
			zh = 3.8,
			ja = 3.733
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play324111065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["6148ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos6148ui_story = var_264_0.localPosition

				local var_264_2 = GameObjectTools.GetOrAddComponent(var_264_0.gameObject, typeof(DynamicBoneHelper))

				if var_264_2 then
					var_264_2:EnableDynamicBone(false)
				end
			end

			local var_264_3 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_3 then
				local var_264_4 = (arg_261_1.time_ - var_264_1) / var_264_3
				local var_264_5 = Vector3.New(0.7, -0.985, -6)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos6148ui_story, var_264_5, var_264_4)

				local var_264_6 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_6.x, var_264_6.y, var_264_6.z)

				local var_264_7 = var_264_0.localEulerAngles

				var_264_7.z = 0
				var_264_7.x = 0
				var_264_0.localEulerAngles = var_264_7
			end

			if arg_261_1.time_ >= var_264_1 + var_264_3 and arg_261_1.time_ < var_264_1 + var_264_3 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_264_8 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_8.x, var_264_8.y, var_264_8.z)

				local var_264_9 = var_264_0.localEulerAngles

				var_264_9.z = 0
				var_264_9.x = 0
				var_264_0.localEulerAngles = var_264_9

				local var_264_10 = GameObjectTools.GetOrAddComponent(var_264_0.gameObject, typeof(DynamicBoneHelper))

				if var_264_10 then
					var_264_10:EnableDynamicBone(true)
				end
			end

			local var_264_11 = arg_261_1.actors_["1070ui_story"].transform
			local var_264_12 = 0

			if var_264_12 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 then
				arg_261_1.var_.moveOldPos1070ui_story = var_264_11.localPosition
			end

			local var_264_13 = 0.001

			if var_264_12 <= arg_261_1.time_ and arg_261_1.time_ < var_264_12 + var_264_13 then
				local var_264_14 = (arg_261_1.time_ - var_264_12) / var_264_13
				local var_264_15 = Vector3.New(-0.7, -0.95, -6.05)

				var_264_11.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1070ui_story, var_264_15, var_264_14)

				local var_264_16 = manager.ui.mainCamera.transform.position - var_264_11.position

				var_264_11.forward = Vector3.New(var_264_16.x, var_264_16.y, var_264_16.z)

				local var_264_17 = var_264_11.localEulerAngles

				var_264_17.z = 0
				var_264_17.x = 0
				var_264_11.localEulerAngles = var_264_17
			end

			if arg_261_1.time_ >= var_264_12 + var_264_13 and arg_261_1.time_ < var_264_12 + var_264_13 + arg_264_0 then
				var_264_11.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_264_18 = manager.ui.mainCamera.transform.position - var_264_11.position

				var_264_11.forward = Vector3.New(var_264_18.x, var_264_18.y, var_264_18.z)

				local var_264_19 = var_264_11.localEulerAngles

				var_264_19.z = 0
				var_264_19.x = 0
				var_264_11.localEulerAngles = var_264_19
			end

			local var_264_20 = arg_261_1.actors_["6148ui_story"]
			local var_264_21 = 0

			if var_264_21 < arg_261_1.time_ and arg_261_1.time_ <= var_264_21 + arg_264_0 and not isNil(var_264_20) and arg_261_1.var_.characterEffect6148ui_story == nil then
				arg_261_1.var_.characterEffect6148ui_story = var_264_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_22 = 0.200000002980232

			if var_264_21 <= arg_261_1.time_ and arg_261_1.time_ < var_264_21 + var_264_22 and not isNil(var_264_20) then
				local var_264_23 = (arg_261_1.time_ - var_264_21) / var_264_22

				if arg_261_1.var_.characterEffect6148ui_story and not isNil(var_264_20) then
					arg_261_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_21 + var_264_22 and arg_261_1.time_ < var_264_21 + var_264_22 + arg_264_0 and not isNil(var_264_20) and arg_261_1.var_.characterEffect6148ui_story then
				arg_261_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_264_24 = arg_261_1.actors_["1070ui_story"]
			local var_264_25 = 0

			if var_264_25 < arg_261_1.time_ and arg_261_1.time_ <= var_264_25 + arg_264_0 and not isNil(var_264_24) and arg_261_1.var_.characterEffect1070ui_story == nil then
				arg_261_1.var_.characterEffect1070ui_story = var_264_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_26 = 0.200000002980232

			if var_264_25 <= arg_261_1.time_ and arg_261_1.time_ < var_264_25 + var_264_26 and not isNil(var_264_24) then
				local var_264_27 = (arg_261_1.time_ - var_264_25) / var_264_26

				if arg_261_1.var_.characterEffect1070ui_story and not isNil(var_264_24) then
					local var_264_28 = Mathf.Lerp(0, 0.5, var_264_27)

					arg_261_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1070ui_story.fillRatio = var_264_28
				end
			end

			if arg_261_1.time_ >= var_264_25 + var_264_26 and arg_261_1.time_ < var_264_25 + var_264_26 + arg_264_0 and not isNil(var_264_24) and arg_261_1.var_.characterEffect1070ui_story then
				local var_264_29 = 0.5

				arg_261_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1070ui_story.fillRatio = var_264_29
			end

			local var_264_30 = 0

			if var_264_30 < arg_261_1.time_ and arg_261_1.time_ <= var_264_30 + arg_264_0 then
				arg_261_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			local var_264_31 = 0

			if var_264_31 < arg_261_1.time_ and arg_261_1.time_ <= var_264_31 + arg_264_0 then
				arg_261_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_264_32 = 0
			local var_264_33 = 0.45

			if var_264_32 < arg_261_1.time_ and arg_261_1.time_ <= var_264_32 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_34 = arg_261_1:FormatText(StoryNameCfg[1488].name)

				arg_261_1.leftNameTxt_.text = var_264_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_35 = arg_261_1:GetWordFromCfg(324111064)
				local var_264_36 = arg_261_1:FormatText(var_264_35.content)

				arg_261_1.text_.text = var_264_36

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_37 = 18
				local var_264_38 = utf8.len(var_264_36)
				local var_264_39 = var_264_37 <= 0 and var_264_33 or var_264_33 * (var_264_38 / var_264_37)

				if var_264_39 > 0 and var_264_33 < var_264_39 then
					arg_261_1.talkMaxDuration = var_264_39

					if var_264_39 + var_264_32 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_39 + var_264_32
					end
				end

				arg_261_1.text_.text = var_264_36
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111064", "story_v_out_324111.awb") ~= 0 then
					local var_264_40 = manager.audio:GetVoiceLength("story_v_out_324111", "324111064", "story_v_out_324111.awb") / 1000

					if var_264_40 + var_264_32 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_40 + var_264_32
					end

					if var_264_35.prefab_name ~= "" and arg_261_1.actors_[var_264_35.prefab_name] ~= nil then
						local var_264_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_35.prefab_name].transform, "story_v_out_324111", "324111064", "story_v_out_324111.awb")

						arg_261_1:RecordAudio("324111064", var_264_41)
						arg_261_1:RecordAudio("324111064", var_264_41)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_324111", "324111064", "story_v_out_324111.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_324111", "324111064", "story_v_out_324111.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_42 = math.max(var_264_33, arg_261_1.talkMaxDuration)

			if var_264_32 <= arg_261_1.time_ and arg_261_1.time_ < var_264_32 + var_264_42 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_32) / var_264_42

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_32 + var_264_42 and arg_261_1.time_ < var_264_32 + var_264_42 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play324111065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 324111065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play324111066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["6148ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect6148ui_story == nil then
				arg_265_1.var_.characterEffect6148ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect6148ui_story and not isNil(var_268_0) then
					local var_268_4 = Mathf.Lerp(0, 0.5, var_268_3)

					arg_265_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_265_1.var_.characterEffect6148ui_story.fillRatio = var_268_4
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect6148ui_story then
				local var_268_5 = 0.5

				arg_265_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_265_1.var_.characterEffect6148ui_story.fillRatio = var_268_5
			end

			local var_268_6 = 0
			local var_268_7 = 0.125

			if var_268_6 < arg_265_1.time_ and arg_265_1.time_ <= var_268_6 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_8 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_9 = arg_265_1:GetWordFromCfg(324111065)
				local var_268_10 = arg_265_1:FormatText(var_268_9.content)

				arg_265_1.text_.text = var_268_10

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_11 = 5
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
	Play324111066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 324111066
		arg_269_1.duration_ = 9.8

		local var_269_0 = {
			zh = 7.3,
			ja = 9.8
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play324111067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1054ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1054ui_story = var_272_0.localPosition

				local var_272_2 = GameObjectTools.GetOrAddComponent(var_272_0.gameObject, typeof(DynamicBoneHelper))

				if var_272_2 then
					var_272_2:EnableDynamicBone(false)
				end
			end

			local var_272_3 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_3 then
				local var_272_4 = (arg_269_1.time_ - var_272_1) / var_272_3
				local var_272_5 = Vector3.New(0.7, -0.985, -6)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1054ui_story, var_272_5, var_272_4)

				local var_272_6 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_6.x, var_272_6.y, var_272_6.z)

				local var_272_7 = var_272_0.localEulerAngles

				var_272_7.z = 0
				var_272_7.x = 0
				var_272_0.localEulerAngles = var_272_7
			end

			if arg_269_1.time_ >= var_272_1 + var_272_3 and arg_269_1.time_ < var_272_1 + var_272_3 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_272_8 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_8.x, var_272_8.y, var_272_8.z)

				local var_272_9 = var_272_0.localEulerAngles

				var_272_9.z = 0
				var_272_9.x = 0
				var_272_0.localEulerAngles = var_272_9

				local var_272_10 = GameObjectTools.GetOrAddComponent(var_272_0.gameObject, typeof(DynamicBoneHelper))

				if var_272_10 then
					var_272_10:EnableDynamicBone(true)
				end
			end

			local var_272_11 = arg_269_1.actors_["1054ui_story"]
			local var_272_12 = 0

			if var_272_12 < arg_269_1.time_ and arg_269_1.time_ <= var_272_12 + arg_272_0 and not isNil(var_272_11) and arg_269_1.var_.characterEffect1054ui_story == nil then
				arg_269_1.var_.characterEffect1054ui_story = var_272_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_13 = 0.200000002980232

			if var_272_12 <= arg_269_1.time_ and arg_269_1.time_ < var_272_12 + var_272_13 and not isNil(var_272_11) then
				local var_272_14 = (arg_269_1.time_ - var_272_12) / var_272_13

				if arg_269_1.var_.characterEffect1054ui_story and not isNil(var_272_11) then
					arg_269_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_12 + var_272_13 and arg_269_1.time_ < var_272_12 + var_272_13 + arg_272_0 and not isNil(var_272_11) and arg_269_1.var_.characterEffect1054ui_story then
				arg_269_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_272_15 = 0

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				arg_269_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_272_16 = 0

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 then
				arg_269_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_272_17 = arg_269_1.actors_["6148ui_story"].transform
			local var_272_18 = 0

			if var_272_18 < arg_269_1.time_ and arg_269_1.time_ <= var_272_18 + arg_272_0 then
				arg_269_1.var_.moveOldPos6148ui_story = var_272_17.localPosition

				local var_272_19 = GameObjectTools.GetOrAddComponent(var_272_17.gameObject, typeof(DynamicBoneHelper))

				if var_272_19 then
					var_272_19:EnableDynamicBone(false)
				end
			end

			local var_272_20 = 0.001

			if var_272_18 <= arg_269_1.time_ and arg_269_1.time_ < var_272_18 + var_272_20 then
				local var_272_21 = (arg_269_1.time_ - var_272_18) / var_272_20
				local var_272_22 = Vector3.New(0, 100, 0)

				var_272_17.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos6148ui_story, var_272_22, var_272_21)

				local var_272_23 = manager.ui.mainCamera.transform.position - var_272_17.position

				var_272_17.forward = Vector3.New(var_272_23.x, var_272_23.y, var_272_23.z)

				local var_272_24 = var_272_17.localEulerAngles

				var_272_24.z = 0
				var_272_24.x = 0
				var_272_17.localEulerAngles = var_272_24
			end

			if arg_269_1.time_ >= var_272_18 + var_272_20 and arg_269_1.time_ < var_272_18 + var_272_20 + arg_272_0 then
				var_272_17.localPosition = Vector3.New(0, 100, 0)

				local var_272_25 = manager.ui.mainCamera.transform.position - var_272_17.position

				var_272_17.forward = Vector3.New(var_272_25.x, var_272_25.y, var_272_25.z)

				local var_272_26 = var_272_17.localEulerAngles

				var_272_26.z = 0
				var_272_26.x = 0
				var_272_17.localEulerAngles = var_272_26

				local var_272_27 = GameObjectTools.GetOrAddComponent(var_272_17.gameObject, typeof(DynamicBoneHelper))

				if var_272_27 then
					var_272_27:EnableDynamicBone(true)
				end
			end

			local var_272_28 = 0
			local var_272_29 = 0.825

			if var_272_28 < arg_269_1.time_ and arg_269_1.time_ <= var_272_28 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_30 = arg_269_1:FormatText(StoryNameCfg[1487].name)

				arg_269_1.leftNameTxt_.text = var_272_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_31 = arg_269_1:GetWordFromCfg(324111066)
				local var_272_32 = arg_269_1:FormatText(var_272_31.content)

				arg_269_1.text_.text = var_272_32

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_33 = 33
				local var_272_34 = utf8.len(var_272_32)
				local var_272_35 = var_272_33 <= 0 and var_272_29 or var_272_29 * (var_272_34 / var_272_33)

				if var_272_35 > 0 and var_272_29 < var_272_35 then
					arg_269_1.talkMaxDuration = var_272_35

					if var_272_35 + var_272_28 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_35 + var_272_28
					end
				end

				arg_269_1.text_.text = var_272_32
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324111", "324111066", "story_v_out_324111.awb") ~= 0 then
					local var_272_36 = manager.audio:GetVoiceLength("story_v_out_324111", "324111066", "story_v_out_324111.awb") / 1000

					if var_272_36 + var_272_28 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_36 + var_272_28
					end

					if var_272_31.prefab_name ~= "" and arg_269_1.actors_[var_272_31.prefab_name] ~= nil then
						local var_272_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_31.prefab_name].transform, "story_v_out_324111", "324111066", "story_v_out_324111.awb")

						arg_269_1:RecordAudio("324111066", var_272_37)
						arg_269_1:RecordAudio("324111066", var_272_37)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_324111", "324111066", "story_v_out_324111.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_324111", "324111066", "story_v_out_324111.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_38 = math.max(var_272_29, arg_269_1.talkMaxDuration)

			if var_272_28 <= arg_269_1.time_ and arg_269_1.time_ < var_272_28 + var_272_38 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_28) / var_272_38

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_28 + var_272_38 and arg_269_1.time_ < var_272_28 + var_272_38 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
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

		arg_269_1:InitPlayNodeList()
	end,
	Play324111067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 324111067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play324111068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1054ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1054ui_story == nil then
				arg_273_1.var_.characterEffect1054ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1054ui_story and not isNil(var_276_0) then
					local var_276_4 = Mathf.Lerp(0, 0.5, var_276_3)

					arg_273_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1054ui_story.fillRatio = var_276_4
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1054ui_story then
				local var_276_5 = 0.5

				arg_273_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1054ui_story.fillRatio = var_276_5
			end

			local var_276_6 = 0
			local var_276_7 = 1.4

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_8 = arg_273_1:FormatText(StoryNameCfg[7].name)

				arg_273_1.leftNameTxt_.text = var_276_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_9 = arg_273_1:GetWordFromCfg(324111067)
				local var_276_10 = arg_273_1:FormatText(var_276_9.content)

				arg_273_1.text_.text = var_276_10

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 56
				local var_276_12 = utf8.len(var_276_10)
				local var_276_13 = var_276_11 <= 0 and var_276_7 or var_276_7 * (var_276_12 / var_276_11)

				if var_276_13 > 0 and var_276_7 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_10
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_14 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_14 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_14

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_14 and arg_273_1.time_ < var_276_6 + var_276_14 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play324111068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 324111068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play324111069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["6148ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos6148ui_story = var_280_0.localPosition

				local var_280_2 = GameObjectTools.GetOrAddComponent(var_280_0.gameObject, typeof(DynamicBoneHelper))

				if var_280_2 then
					var_280_2:EnableDynamicBone(false)
				end
			end

			local var_280_3 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_3 then
				local var_280_4 = (arg_277_1.time_ - var_280_1) / var_280_3
				local var_280_5 = Vector3.New(0, 100, 0)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos6148ui_story, var_280_5, var_280_4)

				local var_280_6 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_6.x, var_280_6.y, var_280_6.z)

				local var_280_7 = var_280_0.localEulerAngles

				var_280_7.z = 0
				var_280_7.x = 0
				var_280_0.localEulerAngles = var_280_7
			end

			if arg_277_1.time_ >= var_280_1 + var_280_3 and arg_277_1.time_ < var_280_1 + var_280_3 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0, 100, 0)

				local var_280_8 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_8.x, var_280_8.y, var_280_8.z)

				local var_280_9 = var_280_0.localEulerAngles

				var_280_9.z = 0
				var_280_9.x = 0
				var_280_0.localEulerAngles = var_280_9

				local var_280_10 = GameObjectTools.GetOrAddComponent(var_280_0.gameObject, typeof(DynamicBoneHelper))

				if var_280_10 then
					var_280_10:EnableDynamicBone(true)
				end
			end

			local var_280_11 = arg_277_1.actors_["1070ui_story"].transform
			local var_280_12 = 0

			if var_280_12 < arg_277_1.time_ and arg_277_1.time_ <= var_280_12 + arg_280_0 then
				arg_277_1.var_.moveOldPos1070ui_story = var_280_11.localPosition
			end

			local var_280_13 = 0.001

			if var_280_12 <= arg_277_1.time_ and arg_277_1.time_ < var_280_12 + var_280_13 then
				local var_280_14 = (arg_277_1.time_ - var_280_12) / var_280_13
				local var_280_15 = Vector3.New(0, 100, 0)

				var_280_11.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1070ui_story, var_280_15, var_280_14)

				local var_280_16 = manager.ui.mainCamera.transform.position - var_280_11.position

				var_280_11.forward = Vector3.New(var_280_16.x, var_280_16.y, var_280_16.z)

				local var_280_17 = var_280_11.localEulerAngles

				var_280_17.z = 0
				var_280_17.x = 0
				var_280_11.localEulerAngles = var_280_17
			end

			if arg_277_1.time_ >= var_280_12 + var_280_13 and arg_277_1.time_ < var_280_12 + var_280_13 + arg_280_0 then
				var_280_11.localPosition = Vector3.New(0, 100, 0)

				local var_280_18 = manager.ui.mainCamera.transform.position - var_280_11.position

				var_280_11.forward = Vector3.New(var_280_18.x, var_280_18.y, var_280_18.z)

				local var_280_19 = var_280_11.localEulerAngles

				var_280_19.z = 0
				var_280_19.x = 0
				var_280_11.localEulerAngles = var_280_19
			end

			local var_280_20 = arg_277_1.actors_["1054ui_story"].transform
			local var_280_21 = 0

			if var_280_21 < arg_277_1.time_ and arg_277_1.time_ <= var_280_21 + arg_280_0 then
				arg_277_1.var_.moveOldPos1054ui_story = var_280_20.localPosition

				local var_280_22 = GameObjectTools.GetOrAddComponent(var_280_20.gameObject, typeof(DynamicBoneHelper))

				if var_280_22 then
					var_280_22:EnableDynamicBone(false)
				end
			end

			local var_280_23 = 0.001

			if var_280_21 <= arg_277_1.time_ and arg_277_1.time_ < var_280_21 + var_280_23 then
				local var_280_24 = (arg_277_1.time_ - var_280_21) / var_280_23
				local var_280_25 = Vector3.New(0, 100, 0)

				var_280_20.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1054ui_story, var_280_25, var_280_24)

				local var_280_26 = manager.ui.mainCamera.transform.position - var_280_20.position

				var_280_20.forward = Vector3.New(var_280_26.x, var_280_26.y, var_280_26.z)

				local var_280_27 = var_280_20.localEulerAngles

				var_280_27.z = 0
				var_280_27.x = 0
				var_280_20.localEulerAngles = var_280_27
			end

			if arg_277_1.time_ >= var_280_21 + var_280_23 and arg_277_1.time_ < var_280_21 + var_280_23 + arg_280_0 then
				var_280_20.localPosition = Vector3.New(0, 100, 0)

				local var_280_28 = manager.ui.mainCamera.transform.position - var_280_20.position

				var_280_20.forward = Vector3.New(var_280_28.x, var_280_28.y, var_280_28.z)

				local var_280_29 = var_280_20.localEulerAngles

				var_280_29.z = 0
				var_280_29.x = 0
				var_280_20.localEulerAngles = var_280_29

				local var_280_30 = GameObjectTools.GetOrAddComponent(var_280_20.gameObject, typeof(DynamicBoneHelper))

				if var_280_30 then
					var_280_30:EnableDynamicBone(true)
				end
			end

			local var_280_31 = 0
			local var_280_32 = 1.175

			if var_280_31 < arg_277_1.time_ and arg_277_1.time_ <= var_280_31 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_33 = arg_277_1:GetWordFromCfg(324111068)
				local var_280_34 = arg_277_1:FormatText(var_280_33.content)

				arg_277_1.text_.text = var_280_34

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_35 = 47
				local var_280_36 = utf8.len(var_280_34)
				local var_280_37 = var_280_35 <= 0 and var_280_32 or var_280_32 * (var_280_36 / var_280_35)

				if var_280_37 > 0 and var_280_32 < var_280_37 then
					arg_277_1.talkMaxDuration = var_280_37

					if var_280_37 + var_280_31 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_37 + var_280_31
					end
				end

				arg_277_1.text_.text = var_280_34
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_38 = math.max(var_280_32, arg_277_1.talkMaxDuration)

			if var_280_31 <= arg_277_1.time_ and arg_277_1.time_ < var_280_31 + var_280_38 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_31) / var_280_38

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_31 + var_280_38 and arg_277_1.time_ < var_280_31 + var_280_38 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
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
				actorName = "1070ui_story",
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

		arg_277_1:InitPlayNodeList()
	end,
	Play324111069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 324111069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
			arg_281_1.auto_ = false
		end

		function arg_281_1.playNext_(arg_283_0)
			arg_281_1.onStoryFinished_()
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 1.175

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

				local var_284_2 = arg_281_1:GetWordFromCfg(324111069)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 47
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
	assets = {
		"TextureConfig/Background/ST2007",
		"TextureConfig/Background/J27g"
	},
	voices = {
		"story_v_out_324111.awb"
	}
}
