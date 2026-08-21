return {
	Play116132001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116132001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116132002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B13c"

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
				local var_4_5 = arg_1_1.bgs_.B13c

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
					if iter_4_0 ~= "B13c" then
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

			local var_4_22 = 0
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_28 = 2
			local var_4_29 = 1.5

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 2.2
			local var_4_35 = 0.733333333333333

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "music"

				arg_1_1:AudioAction(var_4_36, var_4_37, "bgm_activity_1_6_story_intense", "OG", "bgm_activity_1_6_story_intense.awb")

				local var_4_38 = ""
				local var_4_39 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "OG")

				if var_4_39 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_39 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_39

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_39
						arg_1_1.bgmTxt2_.text = var_4_39
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

			local var_4_40 = 2
			local var_4_41 = 1.075

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_43 = arg_1_1:GetWordFromCfg(116132001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_45 = 43
				local var_4_46 = utf8.len(var_4_44)
				local var_4_47 = var_4_45 <= 0 and var_4_41 or var_4_41 * (var_4_46 / var_4_45)

				if var_4_47 > 0 and var_4_41 < var_4_47 then
					arg_1_1.talkMaxDuration = var_4_47
					var_4_40 = var_4_40 + 0.3

					if var_4_47 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_44
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_48 = var_4_40 + 0.3
			local var_4_49 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_48) / var_4_49

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116132002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 116132002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play116132003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0
			local var_13_1 = 0.325

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_2 = arg_10_1:FormatText(StoryNameCfg[7].name)

				arg_10_1.leftNameTxt_.text = var_13_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, true)
				arg_10_1.iconController_:SetSelectedState("hero")

				arg_10_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_10_1.callingController_:SetSelectedState("normal")

				arg_10_1.keyicon_.color = Color.New(1, 1, 1)
				arg_10_1.icon_.color = Color.New(1, 1, 1)

				local var_13_3 = arg_10_1:GetWordFromCfg(116132002)
				local var_13_4 = arg_10_1:FormatText(var_13_3.content)

				arg_10_1.text_.text = var_13_4

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_5 = 13
				local var_13_6 = utf8.len(var_13_4)
				local var_13_7 = var_13_5 <= 0 and var_13_1 or var_13_1 * (var_13_6 / var_13_5)

				if var_13_7 > 0 and var_13_1 < var_13_7 then
					arg_10_1.talkMaxDuration = var_13_7

					if var_13_7 + var_13_0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_7 + var_13_0
					end
				end

				arg_10_1.text_.text = var_13_4
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_8 = math.max(var_13_1, arg_10_1.talkMaxDuration)

			if var_13_0 <= arg_10_1.time_ and arg_10_1.time_ < var_13_0 + var_13_8 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_0) / var_13_8

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_0 + var_13_8 and arg_10_1.time_ < var_13_0 + var_13_8 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play116132003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 116132003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play116132004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0
			local var_17_1 = 1.275

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_2 = arg_14_1:GetWordFromCfg(116132003)
				local var_17_3 = arg_14_1:FormatText(var_17_2.content)

				arg_14_1.text_.text = var_17_3

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_4 = 51
				local var_17_5 = utf8.len(var_17_3)
				local var_17_6 = var_17_4 <= 0 and var_17_1 or var_17_1 * (var_17_5 / var_17_4)

				if var_17_6 > 0 and var_17_1 < var_17_6 then
					arg_14_1.talkMaxDuration = var_17_6

					if var_17_6 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_6 + var_17_0
					end
				end

				arg_14_1.text_.text = var_17_3
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_7 = math.max(var_17_1, arg_14_1.talkMaxDuration)

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_7 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_0) / var_17_7

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_0 + var_17_7 and arg_14_1.time_ < var_17_0 + var_17_7 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play116132004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 116132004
		arg_18_1.duration_ = 2.57

		local var_18_0 = {
			zh = 1.999999999999,
			ja = 2.566
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
				arg_18_0:Play116132005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = "10025ui_story"

			if arg_18_1.actors_[var_21_0] == nil then
				local var_21_1 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_21_1) then
					local var_21_2 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_18_1.stage_.transform)

					var_21_2.name = var_21_0
					var_21_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_18_1.actors_[var_21_0] = var_21_2

					local var_21_3 = var_21_2:GetComponentInChildren(typeof(CharacterEffect))

					var_21_3.enabled = true

					local var_21_4 = GameObjectTools.GetOrAddComponent(var_21_2, typeof(DynamicBoneHelper))

					if var_21_4 then
						var_21_4:EnableDynamicBone(false)
					end

					arg_18_1:ShowWeapon(var_21_3.transform, false)

					arg_18_1.var_[var_21_0 .. "Animator"] = var_21_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_18_1.var_[var_21_0 .. "Animator"].applyRootMotion = true
					arg_18_1.var_[var_21_0 .. "LipSync"] = var_21_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_21_5 = arg_18_1.actors_["10025ui_story"].transform
			local var_21_6 = 0

			if var_21_6 < arg_18_1.time_ and arg_18_1.time_ <= var_21_6 + arg_21_0 then
				arg_18_1.var_.moveOldPos10025ui_story = var_21_5.localPosition
			end

			local var_21_7 = 0.001

			if var_21_6 <= arg_18_1.time_ and arg_18_1.time_ < var_21_6 + var_21_7 then
				local var_21_8 = (arg_18_1.time_ - var_21_6) / var_21_7
				local var_21_9 = Vector3.New(0, -1.1, -5.9)

				var_21_5.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10025ui_story, var_21_9, var_21_8)

				local var_21_10 = manager.ui.mainCamera.transform.position - var_21_5.position

				var_21_5.forward = Vector3.New(var_21_10.x, var_21_10.y, var_21_10.z)

				local var_21_11 = var_21_5.localEulerAngles

				var_21_11.z = 0
				var_21_11.x = 0
				var_21_5.localEulerAngles = var_21_11
			end

			if arg_18_1.time_ >= var_21_6 + var_21_7 and arg_18_1.time_ < var_21_6 + var_21_7 + arg_21_0 then
				var_21_5.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_21_12 = manager.ui.mainCamera.transform.position - var_21_5.position

				var_21_5.forward = Vector3.New(var_21_12.x, var_21_12.y, var_21_12.z)

				local var_21_13 = var_21_5.localEulerAngles

				var_21_13.z = 0
				var_21_13.x = 0
				var_21_5.localEulerAngles = var_21_13
			end

			local var_21_14 = arg_18_1.actors_["10025ui_story"]
			local var_21_15 = 0

			if var_21_15 < arg_18_1.time_ and arg_18_1.time_ <= var_21_15 + arg_21_0 and not isNil(var_21_14) and arg_18_1.var_.characterEffect10025ui_story == nil then
				arg_18_1.var_.characterEffect10025ui_story = var_21_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_16 = 0.2

			if var_21_15 <= arg_18_1.time_ and arg_18_1.time_ < var_21_15 + var_21_16 and not isNil(var_21_14) then
				local var_21_17 = (arg_18_1.time_ - var_21_15) / var_21_16

				if arg_18_1.var_.characterEffect10025ui_story and not isNil(var_21_14) then
					arg_18_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= var_21_15 + var_21_16 and arg_18_1.time_ < var_21_15 + var_21_16 + arg_21_0 and not isNil(var_21_14) and arg_18_1.var_.characterEffect10025ui_story then
				arg_18_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_21_18 = 0

			if var_21_18 < arg_18_1.time_ and arg_18_1.time_ <= var_21_18 + arg_21_0 then
				arg_18_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action7_1")
			end

			local var_21_19 = 0

			if var_21_19 < arg_18_1.time_ and arg_18_1.time_ <= var_21_19 + arg_21_0 then
				arg_18_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_21_20 = 0
			local var_21_21 = 0.15

			if var_21_20 < arg_18_1.time_ and arg_18_1.time_ <= var_21_20 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_22 = arg_18_1:FormatText(StoryNameCfg[328].name)

				arg_18_1.leftNameTxt_.text = var_21_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_23 = arg_18_1:GetWordFromCfg(116132004)
				local var_21_24 = arg_18_1:FormatText(var_21_23.content)

				arg_18_1.text_.text = var_21_24

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_25 = 6
				local var_21_26 = utf8.len(var_21_24)
				local var_21_27 = var_21_25 <= 0 and var_21_21 or var_21_21 * (var_21_26 / var_21_25)

				if var_21_27 > 0 and var_21_21 < var_21_27 then
					arg_18_1.talkMaxDuration = var_21_27

					if var_21_27 + var_21_20 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_27 + var_21_20
					end
				end

				arg_18_1.text_.text = var_21_24
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116132", "116132004", "story_v_out_116132.awb") ~= 0 then
					local var_21_28 = manager.audio:GetVoiceLength("story_v_out_116132", "116132004", "story_v_out_116132.awb") / 1000

					if var_21_28 + var_21_20 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_28 + var_21_20
					end

					if var_21_23.prefab_name ~= "" and arg_18_1.actors_[var_21_23.prefab_name] ~= nil then
						local var_21_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_23.prefab_name].transform, "story_v_out_116132", "116132004", "story_v_out_116132.awb")

						arg_18_1:RecordAudio("116132004", var_21_29)
						arg_18_1:RecordAudio("116132004", var_21_29)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_116132", "116132004", "story_v_out_116132.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_116132", "116132004", "story_v_out_116132.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_30 = math.max(var_21_21, arg_18_1.talkMaxDuration)

			if var_21_20 <= arg_18_1.time_ and arg_18_1.time_ < var_21_20 + var_21_30 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_20) / var_21_30

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_20 + var_21_30 and arg_18_1.time_ < var_21_20 + var_21_30 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play116132005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 116132005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play116132006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["10025ui_story"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect10025ui_story == nil then
				arg_22_1.var_.characterEffect10025ui_story = var_25_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_2 = 0.2

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.characterEffect10025ui_story and not isNil(var_25_0) then
					local var_25_4 = Mathf.Lerp(0, 0.5, var_25_3)

					arg_22_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_22_1.var_.characterEffect10025ui_story.fillRatio = var_25_4
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect10025ui_story then
				local var_25_5 = 0.5

				arg_22_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_22_1.var_.characterEffect10025ui_story.fillRatio = var_25_5
			end

			local var_25_6 = 0
			local var_25_7 = 0.35

			if var_25_6 < arg_22_1.time_ and arg_22_1.time_ <= var_25_6 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_8 = arg_22_1:FormatText(StoryNameCfg[7].name)

				arg_22_1.leftNameTxt_.text = var_25_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_9 = arg_22_1:GetWordFromCfg(116132005)
				local var_25_10 = arg_22_1:FormatText(var_25_9.content)

				arg_22_1.text_.text = var_25_10

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_11 = 14
				local var_25_12 = utf8.len(var_25_10)
				local var_25_13 = var_25_11 <= 0 and var_25_7 or var_25_7 * (var_25_12 / var_25_11)

				if var_25_13 > 0 and var_25_7 < var_25_13 then
					arg_22_1.talkMaxDuration = var_25_13

					if var_25_13 + var_25_6 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_13 + var_25_6
					end
				end

				arg_22_1.text_.text = var_25_10
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_14 = math.max(var_25_7, arg_22_1.talkMaxDuration)

			if var_25_6 <= arg_22_1.time_ and arg_22_1.time_ < var_25_6 + var_25_14 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_6) / var_25_14

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_6 + var_25_14 and arg_22_1.time_ < var_25_6 + var_25_14 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play116132006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 116132006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play116132007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["10025ui_story"].transform
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.var_.moveOldPos10025ui_story = var_29_0.localPosition
			end

			local var_29_2 = 0.001

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2
				local var_29_4 = Vector3.New(0, 100, 0)

				var_29_0.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos10025ui_story, var_29_4, var_29_3)

				local var_29_5 = manager.ui.mainCamera.transform.position - var_29_0.position

				var_29_0.forward = Vector3.New(var_29_5.x, var_29_5.y, var_29_5.z)

				local var_29_6 = var_29_0.localEulerAngles

				var_29_6.z = 0
				var_29_6.x = 0
				var_29_0.localEulerAngles = var_29_6
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 then
				var_29_0.localPosition = Vector3.New(0, 100, 0)

				local var_29_7 = manager.ui.mainCamera.transform.position - var_29_0.position

				var_29_0.forward = Vector3.New(var_29_7.x, var_29_7.y, var_29_7.z)

				local var_29_8 = var_29_0.localEulerAngles

				var_29_8.z = 0
				var_29_8.x = 0
				var_29_0.localEulerAngles = var_29_8
			end

			local var_29_9 = 0
			local var_29_10 = 0.75

			if var_29_9 < arg_26_1.time_ and arg_26_1.time_ <= var_29_9 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_11 = arg_26_1:GetWordFromCfg(116132006)
				local var_29_12 = arg_26_1:FormatText(var_29_11.content)

				arg_26_1.text_.text = var_29_12

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_13 = 30
				local var_29_14 = utf8.len(var_29_12)
				local var_29_15 = var_29_13 <= 0 and var_29_10 or var_29_10 * (var_29_14 / var_29_13)

				if var_29_15 > 0 and var_29_10 < var_29_15 then
					arg_26_1.talkMaxDuration = var_29_15

					if var_29_15 + var_29_9 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_15 + var_29_9
					end
				end

				arg_26_1.text_.text = var_29_12
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_16 = math.max(var_29_10, arg_26_1.talkMaxDuration)

			if var_29_9 <= arg_26_1.time_ and arg_26_1.time_ < var_29_9 + var_29_16 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_9) / var_29_16

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_9 + var_29_16 and arg_26_1.time_ < var_29_9 + var_29_16 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play116132007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 116132007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play116132008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 0.35

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

				local var_33_2 = arg_30_1:GetWordFromCfg(116132007)
				local var_33_3 = arg_30_1:FormatText(var_33_2.content)

				arg_30_1.text_.text = var_33_3

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 14
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
	Play116132008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 116132008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play116132009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0
			local var_37_1 = 0.15

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_2 = arg_34_1:FormatText(StoryNameCfg[7].name)

				arg_34_1.leftNameTxt_.text = var_37_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_3 = arg_34_1:GetWordFromCfg(116132008)
				local var_37_4 = arg_34_1:FormatText(var_37_3.content)

				arg_34_1.text_.text = var_37_4

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_5 = 7
				local var_37_6 = utf8.len(var_37_4)
				local var_37_7 = var_37_5 <= 0 and var_37_1 or var_37_1 * (var_37_6 / var_37_5)

				if var_37_7 > 0 and var_37_1 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_0
					end
				end

				arg_34_1.text_.text = var_37_4
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_8 = math.max(var_37_1, arg_34_1.talkMaxDuration)

			if var_37_0 <= arg_34_1.time_ and arg_34_1.time_ < var_37_0 + var_37_8 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_0) / var_37_8

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_0 + var_37_8 and arg_34_1.time_ < var_37_0 + var_37_8 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play116132009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 116132009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play116132010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 0.5

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_2 = arg_38_1:GetWordFromCfg(116132009)
				local var_41_3 = arg_38_1:FormatText(var_41_2.content)

				arg_38_1.text_.text = var_41_3

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 20
				local var_41_5 = utf8.len(var_41_3)
				local var_41_6 = var_41_4 <= 0 and var_41_1 or var_41_1 * (var_41_5 / var_41_4)

				if var_41_6 > 0 and var_41_1 < var_41_6 then
					arg_38_1.talkMaxDuration = var_41_6

					if var_41_6 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_6 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_3
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_7 and arg_38_1.time_ < var_41_0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play116132010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 116132010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play116132011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0
			local var_45_1 = 0.275

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_2 = arg_42_1:FormatText(StoryNameCfg[7].name)

				arg_42_1.leftNameTxt_.text = var_45_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_3 = arg_42_1:GetWordFromCfg(116132010)
				local var_45_4 = arg_42_1:FormatText(var_45_3.content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 11
				local var_45_6 = utf8.len(var_45_4)
				local var_45_7 = var_45_5 <= 0 and var_45_1 or var_45_1 * (var_45_6 / var_45_5)

				if var_45_7 > 0 and var_45_1 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_0
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_8 = math.max(var_45_1, arg_42_1.talkMaxDuration)

			if var_45_0 <= arg_42_1.time_ and arg_42_1.time_ < var_45_0 + var_45_8 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_0) / var_45_8

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_0 + var_45_8 and arg_42_1.time_ < var_45_0 + var_45_8 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play116132011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 116132011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play116132012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 0.875

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_2 = arg_46_1:GetWordFromCfg(116132011)
				local var_49_3 = arg_46_1:FormatText(var_49_2.content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 35
				local var_49_5 = utf8.len(var_49_3)
				local var_49_6 = var_49_4 <= 0 and var_49_1 or var_49_1 * (var_49_5 / var_49_4)

				if var_49_6 > 0 and var_49_1 < var_49_6 then
					arg_46_1.talkMaxDuration = var_49_6

					if var_49_6 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_6 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_7 and arg_46_1.time_ < var_49_0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play116132012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 116132012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play116132013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 0.65

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_2 = arg_50_1:GetWordFromCfg(116132012)
				local var_53_3 = arg_50_1:FormatText(var_53_2.content)

				arg_50_1.text_.text = var_53_3

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 26
				local var_53_5 = utf8.len(var_53_3)
				local var_53_6 = var_53_4 <= 0 and var_53_1 or var_53_1 * (var_53_5 / var_53_4)

				if var_53_6 > 0 and var_53_1 < var_53_6 then
					arg_50_1.talkMaxDuration = var_53_6

					if var_53_6 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_6 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_3
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_7 and arg_50_1.time_ < var_53_0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play116132013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 116132013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play116132014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 1.125

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_2 = arg_54_1:GetWordFromCfg(116132013)
				local var_57_3 = arg_54_1:FormatText(var_57_2.content)

				arg_54_1.text_.text = var_57_3

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 45
				local var_57_5 = utf8.len(var_57_3)
				local var_57_6 = var_57_4 <= 0 and var_57_1 or var_57_1 * (var_57_5 / var_57_4)

				if var_57_6 > 0 and var_57_1 < var_57_6 then
					arg_54_1.talkMaxDuration = var_57_6

					if var_57_6 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_6 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_3
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_7 and arg_54_1.time_ < var_57_0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play116132014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 116132014
		arg_58_1.duration_ = 6.5

		local var_58_0 = {
			zh = 3.5,
			ja = 6.5
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play116132015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["10025ui_story"].transform
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.var_.moveOldPos10025ui_story = var_61_0.localPosition
			end

			local var_61_2 = 0.001

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2
				local var_61_4 = Vector3.New(0, -1.1, -5.9)

				var_61_0.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10025ui_story, var_61_4, var_61_3)

				local var_61_5 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_5.x, var_61_5.y, var_61_5.z)

				local var_61_6 = var_61_0.localEulerAngles

				var_61_6.z = 0
				var_61_6.x = 0
				var_61_0.localEulerAngles = var_61_6
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 then
				var_61_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_61_7 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_7.x, var_61_7.y, var_61_7.z)

				local var_61_8 = var_61_0.localEulerAngles

				var_61_8.z = 0
				var_61_8.x = 0
				var_61_0.localEulerAngles = var_61_8
			end

			local var_61_9 = arg_58_1.actors_["10025ui_story"]
			local var_61_10 = 0

			if var_61_10 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 and not isNil(var_61_9) and arg_58_1.var_.characterEffect10025ui_story == nil then
				arg_58_1.var_.characterEffect10025ui_story = var_61_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_11 = 0.2

			if var_61_10 <= arg_58_1.time_ and arg_58_1.time_ < var_61_10 + var_61_11 and not isNil(var_61_9) then
				local var_61_12 = (arg_58_1.time_ - var_61_10) / var_61_11

				if arg_58_1.var_.characterEffect10025ui_story and not isNil(var_61_9) then
					arg_58_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_10 + var_61_11 and arg_58_1.time_ < var_61_10 + var_61_11 + arg_61_0 and not isNil(var_61_9) and arg_58_1.var_.characterEffect10025ui_story then
				arg_58_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_61_13 = 0

			if var_61_13 < arg_58_1.time_ and arg_58_1.time_ <= var_61_13 + arg_61_0 then
				arg_58_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_61_14 = 0

			if var_61_14 < arg_58_1.time_ and arg_58_1.time_ <= var_61_14 + arg_61_0 then
				arg_58_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_61_15 = 0
			local var_61_16 = 0.175

			if var_61_15 < arg_58_1.time_ and arg_58_1.time_ <= var_61_15 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_17 = arg_58_1:FormatText(StoryNameCfg[328].name)

				arg_58_1.leftNameTxt_.text = var_61_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_18 = arg_58_1:GetWordFromCfg(116132014)
				local var_61_19 = arg_58_1:FormatText(var_61_18.content)

				arg_58_1.text_.text = var_61_19

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_20 = 7
				local var_61_21 = utf8.len(var_61_19)
				local var_61_22 = var_61_20 <= 0 and var_61_16 or var_61_16 * (var_61_21 / var_61_20)

				if var_61_22 > 0 and var_61_16 < var_61_22 then
					arg_58_1.talkMaxDuration = var_61_22

					if var_61_22 + var_61_15 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_22 + var_61_15
					end
				end

				arg_58_1.text_.text = var_61_19
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116132", "116132014", "story_v_out_116132.awb") ~= 0 then
					local var_61_23 = manager.audio:GetVoiceLength("story_v_out_116132", "116132014", "story_v_out_116132.awb") / 1000

					if var_61_23 + var_61_15 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_23 + var_61_15
					end

					if var_61_18.prefab_name ~= "" and arg_58_1.actors_[var_61_18.prefab_name] ~= nil then
						local var_61_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_18.prefab_name].transform, "story_v_out_116132", "116132014", "story_v_out_116132.awb")

						arg_58_1:RecordAudio("116132014", var_61_24)
						arg_58_1:RecordAudio("116132014", var_61_24)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_116132", "116132014", "story_v_out_116132.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_116132", "116132014", "story_v_out_116132.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_25 = math.max(var_61_16, arg_58_1.talkMaxDuration)

			if var_61_15 <= arg_58_1.time_ and arg_58_1.time_ < var_61_15 + var_61_25 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_15) / var_61_25

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_15 + var_61_25 and arg_58_1.time_ < var_61_15 + var_61_25 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play116132015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 116132015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play116132016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["10025ui_story"].transform
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.var_.moveOldPos10025ui_story = var_65_0.localPosition
			end

			local var_65_2 = 0.001

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2
				local var_65_4 = Vector3.New(0, 100, 0)

				var_65_0.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10025ui_story, var_65_4, var_65_3)

				local var_65_5 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_5.x, var_65_5.y, var_65_5.z)

				local var_65_6 = var_65_0.localEulerAngles

				var_65_6.z = 0
				var_65_6.x = 0
				var_65_0.localEulerAngles = var_65_6
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 then
				var_65_0.localPosition = Vector3.New(0, 100, 0)

				local var_65_7 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_7.x, var_65_7.y, var_65_7.z)

				local var_65_8 = var_65_0.localEulerAngles

				var_65_8.z = 0
				var_65_8.x = 0
				var_65_0.localEulerAngles = var_65_8
			end

			local var_65_9 = 0
			local var_65_10 = 0.925

			if var_65_9 < arg_62_1.time_ and arg_62_1.time_ <= var_65_9 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_11 = arg_62_1:GetWordFromCfg(116132015)
				local var_65_12 = arg_62_1:FormatText(var_65_11.content)

				arg_62_1.text_.text = var_65_12

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_13 = 37
				local var_65_14 = utf8.len(var_65_12)
				local var_65_15 = var_65_13 <= 0 and var_65_10 or var_65_10 * (var_65_14 / var_65_13)

				if var_65_15 > 0 and var_65_10 < var_65_15 then
					arg_62_1.talkMaxDuration = var_65_15

					if var_65_15 + var_65_9 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_15 + var_65_9
					end
				end

				arg_62_1.text_.text = var_65_12
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_10, arg_62_1.talkMaxDuration)

			if var_65_9 <= arg_62_1.time_ and arg_62_1.time_ < var_65_9 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_9) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_9 + var_65_16 and arg_62_1.time_ < var_65_9 + var_65_16 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play116132016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 116132016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play116132017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10025ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos10025ui_story = var_69_0.localPosition
			end

			local var_69_2 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2
				local var_69_4 = Vector3.New(0, 100, 0)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10025ui_story, var_69_4, var_69_3)

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
			local var_69_10 = 0.125

			if var_69_9 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_11 = arg_66_1:FormatText(StoryNameCfg[7].name)

				arg_66_1.leftNameTxt_.text = var_69_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_12 = arg_66_1:GetWordFromCfg(116132016)
				local var_69_13 = arg_66_1:FormatText(var_69_12.content)

				arg_66_1.text_.text = var_69_13

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_14 = 5
				local var_69_15 = utf8.len(var_69_13)
				local var_69_16 = var_69_14 <= 0 and var_69_10 or var_69_10 * (var_69_15 / var_69_14)

				if var_69_16 > 0 and var_69_10 < var_69_16 then
					arg_66_1.talkMaxDuration = var_69_16

					if var_69_16 + var_69_9 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_16 + var_69_9
					end
				end

				arg_66_1.text_.text = var_69_13
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_17 = math.max(var_69_10, arg_66_1.talkMaxDuration)

			if var_69_9 <= arg_66_1.time_ and arg_66_1.time_ < var_69_9 + var_69_17 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_9) / var_69_17

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_9 + var_69_17 and arg_66_1.time_ < var_69_9 + var_69_17 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
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
	Play116132017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 116132017
		arg_70_1.duration_ = 9.9

		local var_70_0 = {
			zh = 7.133,
			ja = 9.9
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play116132018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = "1019ui_story"

			if arg_70_1.actors_[var_73_0] == nil then
				local var_73_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_73_1) then
					local var_73_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_70_1.stage_.transform)

					var_73_2.name = var_73_0
					var_73_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_70_1.actors_[var_73_0] = var_73_2

					local var_73_3 = var_73_2:GetComponentInChildren(typeof(CharacterEffect))

					var_73_3.enabled = true

					local var_73_4 = GameObjectTools.GetOrAddComponent(var_73_2, typeof(DynamicBoneHelper))

					if var_73_4 then
						var_73_4:EnableDynamicBone(false)
					end

					arg_70_1:ShowWeapon(var_73_3.transform, false)

					arg_70_1.var_[var_73_0 .. "Animator"] = var_73_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_70_1.var_[var_73_0 .. "Animator"].applyRootMotion = true
					arg_70_1.var_[var_73_0 .. "LipSync"] = var_73_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_73_5 = arg_70_1.actors_["1019ui_story"].transform
			local var_73_6 = 0

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.var_.moveOldPos1019ui_story = var_73_5.localPosition
			end

			local var_73_7 = 0.001

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_7 then
				local var_73_8 = (arg_70_1.time_ - var_73_6) / var_73_7
				local var_73_9 = Vector3.New(-0.7, -1.08, -5.9)

				var_73_5.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1019ui_story, var_73_9, var_73_8)

				local var_73_10 = manager.ui.mainCamera.transform.position - var_73_5.position

				var_73_5.forward = Vector3.New(var_73_10.x, var_73_10.y, var_73_10.z)

				local var_73_11 = var_73_5.localEulerAngles

				var_73_11.z = 0
				var_73_11.x = 0
				var_73_5.localEulerAngles = var_73_11
			end

			if arg_70_1.time_ >= var_73_6 + var_73_7 and arg_70_1.time_ < var_73_6 + var_73_7 + arg_73_0 then
				var_73_5.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_73_12 = manager.ui.mainCamera.transform.position - var_73_5.position

				var_73_5.forward = Vector3.New(var_73_12.x, var_73_12.y, var_73_12.z)

				local var_73_13 = var_73_5.localEulerAngles

				var_73_13.z = 0
				var_73_13.x = 0
				var_73_5.localEulerAngles = var_73_13
			end

			local var_73_14 = arg_70_1.actors_["1019ui_story"]
			local var_73_15 = 0

			if var_73_15 < arg_70_1.time_ and arg_70_1.time_ <= var_73_15 + arg_73_0 and not isNil(var_73_14) and arg_70_1.var_.characterEffect1019ui_story == nil then
				arg_70_1.var_.characterEffect1019ui_story = var_73_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_16 = 0.2

			if var_73_15 <= arg_70_1.time_ and arg_70_1.time_ < var_73_15 + var_73_16 and not isNil(var_73_14) then
				local var_73_17 = (arg_70_1.time_ - var_73_15) / var_73_16

				if arg_70_1.var_.characterEffect1019ui_story and not isNil(var_73_14) then
					arg_70_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_15 + var_73_16 and arg_70_1.time_ < var_73_15 + var_73_16 + arg_73_0 and not isNil(var_73_14) and arg_70_1.var_.characterEffect1019ui_story then
				arg_70_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_73_18 = 0

			if var_73_18 < arg_70_1.time_ and arg_70_1.time_ <= var_73_18 + arg_73_0 then
				arg_70_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_73_19 = 0

			if var_73_19 < arg_70_1.time_ and arg_70_1.time_ <= var_73_19 + arg_73_0 then
				arg_70_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_73_20 = 0
			local var_73_21 = 0.775

			if var_73_20 < arg_70_1.time_ and arg_70_1.time_ <= var_73_20 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_22 = arg_70_1:FormatText(StoryNameCfg[13].name)

				arg_70_1.leftNameTxt_.text = var_73_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_23 = arg_70_1:GetWordFromCfg(116132017)
				local var_73_24 = arg_70_1:FormatText(var_73_23.content)

				arg_70_1.text_.text = var_73_24

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_25 = 31
				local var_73_26 = utf8.len(var_73_24)
				local var_73_27 = var_73_25 <= 0 and var_73_21 or var_73_21 * (var_73_26 / var_73_25)

				if var_73_27 > 0 and var_73_21 < var_73_27 then
					arg_70_1.talkMaxDuration = var_73_27

					if var_73_27 + var_73_20 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_27 + var_73_20
					end
				end

				arg_70_1.text_.text = var_73_24
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116132", "116132017", "story_v_out_116132.awb") ~= 0 then
					local var_73_28 = manager.audio:GetVoiceLength("story_v_out_116132", "116132017", "story_v_out_116132.awb") / 1000

					if var_73_28 + var_73_20 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_28 + var_73_20
					end

					if var_73_23.prefab_name ~= "" and arg_70_1.actors_[var_73_23.prefab_name] ~= nil then
						local var_73_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_23.prefab_name].transform, "story_v_out_116132", "116132017", "story_v_out_116132.awb")

						arg_70_1:RecordAudio("116132017", var_73_29)
						arg_70_1:RecordAudio("116132017", var_73_29)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_116132", "116132017", "story_v_out_116132.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_116132", "116132017", "story_v_out_116132.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_30 = math.max(var_73_21, arg_70_1.talkMaxDuration)

			if var_73_20 <= arg_70_1.time_ and arg_70_1.time_ < var_73_20 + var_73_30 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_20) / var_73_30

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_20 + var_73_30 and arg_70_1.time_ < var_73_20 + var_73_30 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
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

		arg_70_1:InitPlayNodeList()
	end,
	Play116132018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 116132018
		arg_74_1.duration_ = 7.3

		local var_74_0 = {
			zh = 4.7,
			ja = 7.3
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
				arg_74_0:Play116132019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["10025ui_story"].transform
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.var_.moveOldPos10025ui_story = var_77_0.localPosition
			end

			local var_77_2 = 0.001

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2
				local var_77_4 = Vector3.New(0.7, -1.1, -5.9)

				var_77_0.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos10025ui_story, var_77_4, var_77_3)

				local var_77_5 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_5.x, var_77_5.y, var_77_5.z)

				local var_77_6 = var_77_0.localEulerAngles

				var_77_6.z = 0
				var_77_6.x = 0
				var_77_0.localEulerAngles = var_77_6
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 then
				var_77_0.localPosition = Vector3.New(0.7, -1.1, -5.9)

				local var_77_7 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_7.x, var_77_7.y, var_77_7.z)

				local var_77_8 = var_77_0.localEulerAngles

				var_77_8.z = 0
				var_77_8.x = 0
				var_77_0.localEulerAngles = var_77_8
			end

			local var_77_9 = arg_74_1.actors_["10025ui_story"]
			local var_77_10 = 0

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 and not isNil(var_77_9) and arg_74_1.var_.characterEffect10025ui_story == nil then
				arg_74_1.var_.characterEffect10025ui_story = var_77_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_11 = 0.2

			if var_77_10 <= arg_74_1.time_ and arg_74_1.time_ < var_77_10 + var_77_11 and not isNil(var_77_9) then
				local var_77_12 = (arg_74_1.time_ - var_77_10) / var_77_11

				if arg_74_1.var_.characterEffect10025ui_story and not isNil(var_77_9) then
					arg_74_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_10 + var_77_11 and arg_74_1.time_ < var_77_10 + var_77_11 + arg_77_0 and not isNil(var_77_9) and arg_74_1.var_.characterEffect10025ui_story then
				arg_74_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_77_13 = 0

			if var_77_13 < arg_74_1.time_ and arg_74_1.time_ <= var_77_13 + arg_77_0 then
				arg_74_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action7_1")
			end

			local var_77_14 = 0

			if var_77_14 < arg_74_1.time_ and arg_74_1.time_ <= var_77_14 + arg_77_0 then
				arg_74_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_77_15 = arg_74_1.actors_["1019ui_story"]
			local var_77_16 = 0

			if var_77_16 < arg_74_1.time_ and arg_74_1.time_ <= var_77_16 + arg_77_0 and not isNil(var_77_15) and arg_74_1.var_.characterEffect1019ui_story == nil then
				arg_74_1.var_.characterEffect1019ui_story = var_77_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_17 = 0.2

			if var_77_16 <= arg_74_1.time_ and arg_74_1.time_ < var_77_16 + var_77_17 and not isNil(var_77_15) then
				local var_77_18 = (arg_74_1.time_ - var_77_16) / var_77_17

				if arg_74_1.var_.characterEffect1019ui_story and not isNil(var_77_15) then
					local var_77_19 = Mathf.Lerp(0, 0.5, var_77_18)

					arg_74_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1019ui_story.fillRatio = var_77_19
				end
			end

			if arg_74_1.time_ >= var_77_16 + var_77_17 and arg_74_1.time_ < var_77_16 + var_77_17 + arg_77_0 and not isNil(var_77_15) and arg_74_1.var_.characterEffect1019ui_story then
				local var_77_20 = 0.5

				arg_74_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1019ui_story.fillRatio = var_77_20
			end

			local var_77_21 = 0
			local var_77_22 = 0.275

			if var_77_21 < arg_74_1.time_ and arg_74_1.time_ <= var_77_21 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_23 = arg_74_1:FormatText(StoryNameCfg[328].name)

				arg_74_1.leftNameTxt_.text = var_77_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_24 = arg_74_1:GetWordFromCfg(116132018)
				local var_77_25 = arg_74_1:FormatText(var_77_24.content)

				arg_74_1.text_.text = var_77_25

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_26 = 11
				local var_77_27 = utf8.len(var_77_25)
				local var_77_28 = var_77_26 <= 0 and var_77_22 or var_77_22 * (var_77_27 / var_77_26)

				if var_77_28 > 0 and var_77_22 < var_77_28 then
					arg_74_1.talkMaxDuration = var_77_28

					if var_77_28 + var_77_21 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_28 + var_77_21
					end
				end

				arg_74_1.text_.text = var_77_25
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116132", "116132018", "story_v_out_116132.awb") ~= 0 then
					local var_77_29 = manager.audio:GetVoiceLength("story_v_out_116132", "116132018", "story_v_out_116132.awb") / 1000

					if var_77_29 + var_77_21 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_29 + var_77_21
					end

					if var_77_24.prefab_name ~= "" and arg_74_1.actors_[var_77_24.prefab_name] ~= nil then
						local var_77_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_24.prefab_name].transform, "story_v_out_116132", "116132018", "story_v_out_116132.awb")

						arg_74_1:RecordAudio("116132018", var_77_30)
						arg_74_1:RecordAudio("116132018", var_77_30)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_116132", "116132018", "story_v_out_116132.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_116132", "116132018", "story_v_out_116132.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_31 = math.max(var_77_22, arg_74_1.talkMaxDuration)

			if var_77_21 <= arg_74_1.time_ and arg_74_1.time_ < var_77_21 + var_77_31 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_21) / var_77_31

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_21 + var_77_31 and arg_74_1.time_ < var_77_21 + var_77_31 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play116132019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 116132019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play116132020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1019ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos1019ui_story = var_81_0.localPosition
			end

			local var_81_2 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2
				local var_81_4 = Vector3.New(0, 100, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1019ui_story, var_81_4, var_81_3)

				local var_81_5 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_5.x, var_81_5.y, var_81_5.z)

				local var_81_6 = var_81_0.localEulerAngles

				var_81_6.z = 0
				var_81_6.x = 0
				var_81_0.localEulerAngles = var_81_6
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, 100, 0)

				local var_81_7 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_7.x, var_81_7.y, var_81_7.z)

				local var_81_8 = var_81_0.localEulerAngles

				var_81_8.z = 0
				var_81_8.x = 0
				var_81_0.localEulerAngles = var_81_8
			end

			local var_81_9 = arg_78_1.actors_["10025ui_story"].transform
			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1.var_.moveOldPos10025ui_story = var_81_9.localPosition
			end

			local var_81_11 = 0.001

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_11 then
				local var_81_12 = (arg_78_1.time_ - var_81_10) / var_81_11
				local var_81_13 = Vector3.New(0, 100, 0)

				var_81_9.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10025ui_story, var_81_13, var_81_12)

				local var_81_14 = manager.ui.mainCamera.transform.position - var_81_9.position

				var_81_9.forward = Vector3.New(var_81_14.x, var_81_14.y, var_81_14.z)

				local var_81_15 = var_81_9.localEulerAngles

				var_81_15.z = 0
				var_81_15.x = 0
				var_81_9.localEulerAngles = var_81_15
			end

			if arg_78_1.time_ >= var_81_10 + var_81_11 and arg_78_1.time_ < var_81_10 + var_81_11 + arg_81_0 then
				var_81_9.localPosition = Vector3.New(0, 100, 0)

				local var_81_16 = manager.ui.mainCamera.transform.position - var_81_9.position

				var_81_9.forward = Vector3.New(var_81_16.x, var_81_16.y, var_81_16.z)

				local var_81_17 = var_81_9.localEulerAngles

				var_81_17.z = 0
				var_81_17.x = 0
				var_81_9.localEulerAngles = var_81_17
			end

			local var_81_18 = 0
			local var_81_19 = 1

			if var_81_18 < arg_78_1.time_ and arg_78_1.time_ <= var_81_18 + arg_81_0 then
				local var_81_20 = "play"
				local var_81_21 = "effect"

				arg_78_1:AudioAction(var_81_20, var_81_21, "se_story_16", "se_story_16_door03", "")
			end

			local var_81_22 = 0
			local var_81_23 = 1

			if var_81_22 < arg_78_1.time_ and arg_78_1.time_ <= var_81_22 + arg_81_0 then
				local var_81_24 = "play"
				local var_81_25 = "effect"

				arg_78_1:AudioAction(var_81_24, var_81_25, "se_story_16", "se_story_16_wind02", "")
			end

			local var_81_26 = 0
			local var_81_27 = 0.575

			if var_81_26 < arg_78_1.time_ and arg_78_1.time_ <= var_81_26 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_28 = arg_78_1:GetWordFromCfg(116132019)
				local var_81_29 = arg_78_1:FormatText(var_81_28.content)

				arg_78_1.text_.text = var_81_29

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_30 = 23
				local var_81_31 = utf8.len(var_81_29)
				local var_81_32 = var_81_30 <= 0 and var_81_27 or var_81_27 * (var_81_31 / var_81_30)

				if var_81_32 > 0 and var_81_27 < var_81_32 then
					arg_78_1.talkMaxDuration = var_81_32

					if var_81_32 + var_81_26 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_32 + var_81_26
					end
				end

				arg_78_1.text_.text = var_81_29
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_33 = math.max(var_81_27, arg_78_1.talkMaxDuration)

			if var_81_26 <= arg_78_1.time_ and arg_78_1.time_ < var_81_26 + var_81_33 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_26) / var_81_33

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_26 + var_81_33 and arg_78_1.time_ < var_81_26 + var_81_33 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play116132020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 116132020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play116132021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.75

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

				local var_85_2 = arg_82_1:GetWordFromCfg(116132020)
				local var_85_3 = arg_82_1:FormatText(var_85_2.content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 30
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
	Play116132021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 116132021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play116132022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 1.275

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

				local var_89_2 = arg_86_1:GetWordFromCfg(116132021)
				local var_89_3 = arg_86_1:FormatText(var_89_2.content)

				arg_86_1.text_.text = var_89_3

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 51
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
	Play116132022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 116132022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play116132023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.375

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

				local var_93_2 = arg_90_1:GetWordFromCfg(116132022)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 15
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
	Play116132023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 116132023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play116132024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.9

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

				local var_97_2 = arg_94_1:GetWordFromCfg(116132023)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 36
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
	Play116132024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 116132024
		arg_98_1.duration_ = 7

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
			arg_98_1.auto_ = false
		end

		function arg_98_1.playNext_(arg_100_0)
			arg_98_1.onStoryFinished_()
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_1 = 2

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_1 then
				local var_101_2 = (arg_98_1.time_ - var_101_0) / var_101_1
				local var_101_3 = Color.New(1, 1, 1)

				var_101_3.a = Mathf.Lerp(1, 0, var_101_2)
				arg_98_1.mask_.color = var_101_3
			end

			if arg_98_1.time_ >= var_101_0 + var_101_1 and arg_98_1.time_ < var_101_0 + var_101_1 + arg_101_0 then
				local var_101_4 = Color.New(1, 1, 1)
				local var_101_5 = 0

				arg_98_1.mask_.enabled = false
				var_101_4.a = var_101_5
				arg_98_1.mask_.color = var_101_4
			end

			local var_101_6 = 0
			local var_101_7 = 1

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				local var_101_8 = "play"
				local var_101_9 = "effect"

				arg_98_1:AudioAction(var_101_8, var_101_9, "se_story_16", "se_story_16_attack02", "")
			end

			local var_101_10 = "STwhite"

			if arg_98_1.bgs_[var_101_10] == nil then
				local var_101_11 = Object.Instantiate(arg_98_1.paintGo_)

				var_101_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_101_10)
				var_101_11.name = var_101_10
				var_101_11.transform.parent = arg_98_1.stage_.transform
				var_101_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.bgs_[var_101_10] = var_101_11
			end

			local var_101_12 = 0

			if var_101_12 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 then
				local var_101_13 = manager.ui.mainCamera.transform.localPosition
				local var_101_14 = Vector3.New(0, 0, 10) + Vector3.New(var_101_13.x, var_101_13.y, 0)
				local var_101_15 = arg_98_1.bgs_.STwhite

				var_101_15.transform.localPosition = var_101_14
				var_101_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_16 = var_101_15:GetComponent("SpriteRenderer")

				if var_101_16 and var_101_16.sprite then
					local var_101_17 = (var_101_15.transform.localPosition - var_101_13).z
					local var_101_18 = manager.ui.mainCameraCom_
					local var_101_19 = 2 * var_101_17 * Mathf.Tan(var_101_18.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_101_20 = var_101_19 * var_101_18.aspect
					local var_101_21 = var_101_16.sprite.bounds.size.x
					local var_101_22 = var_101_16.sprite.bounds.size.y
					local var_101_23 = var_101_20 / var_101_21
					local var_101_24 = var_101_19 / var_101_22
					local var_101_25 = var_101_24 < var_101_23 and var_101_23 or var_101_24

					var_101_15.transform.localScale = Vector3.New(var_101_25, var_101_25, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "STwhite" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_101_26 = arg_98_1.bgs_.STwhite.transform
			local var_101_27 = 0

			if var_101_27 < arg_98_1.time_ and arg_98_1.time_ <= var_101_27 + arg_101_0 then
				arg_98_1.var_.moveOldPosSTwhite = var_101_26.localPosition
				var_101_26.localScale = Vector3.New(12, 12, 12)
			end

			local var_101_28 = 0.001

			if var_101_27 <= arg_98_1.time_ and arg_98_1.time_ < var_101_27 + var_101_28 then
				local var_101_29 = (arg_98_1.time_ - var_101_27) / var_101_28
				local var_101_30 = Vector3.New(0, 0, 0)

				var_101_26.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPosSTwhite, var_101_30, var_101_29)
			end

			if arg_98_1.time_ >= var_101_27 + var_101_28 and arg_98_1.time_ < var_101_27 + var_101_28 + arg_101_0 then
				var_101_26.localPosition = Vector3.New(0, 0, 0)
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_31 = 2
			local var_101_32 = 0.425

			if var_101_31 < arg_98_1.time_ and arg_98_1.time_ <= var_101_31 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_33 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_33:setOnUpdate(LuaHelper.FloatAction(function(arg_102_0)
					arg_98_1.dialogCg_.alpha = arg_102_0
				end))
				var_101_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_34 = arg_98_1:GetWordFromCfg(116132024)
				local var_101_35 = arg_98_1:FormatText(var_101_34.content)

				arg_98_1.text_.text = var_101_35

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_36 = 17
				local var_101_37 = utf8.len(var_101_35)
				local var_101_38 = var_101_36 <= 0 and var_101_32 or var_101_32 * (var_101_37 / var_101_36)

				if var_101_38 > 0 and var_101_32 < var_101_38 then
					arg_98_1.talkMaxDuration = var_101_38
					var_101_31 = var_101_31 + 0.3

					if var_101_38 + var_101_31 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_38 + var_101_31
					end
				end

				arg_98_1.text_.text = var_101_35
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_39 = var_101_31 + 0.3
			local var_101_40 = math.max(var_101_32, arg_98_1.talkMaxDuration)

			if var_101_39 <= arg_98_1.time_ and arg_98_1.time_ < var_101_39 + var_101_40 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_39) / var_101_40

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_39 + var_101_40 and arg_98_1.time_ < var_101_39 + var_101_40 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13c",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_116132.awb"
	}
}
