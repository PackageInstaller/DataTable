return {
	Play928041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 928041001
		arg_1_1.duration_ = 6.73

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play928041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L16"

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
				local var_4_5 = arg_1_1.bgs_.L16

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
					if iter_4_0 ~= "L16" then
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

			local var_4_24 = 0.133333333333333
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_145", "se_story_145_amb_dream", "")
			end

			local var_4_28 = 0
			local var_4_29 = 0.3

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_34 = 0.4
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "music"

				arg_1_1:AudioAction(var_4_36, var_4_37, "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_4_38 = ""
				local var_4_39 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

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

			local var_4_40 = 1.73333333333333
			local var_4_41 = 0.7

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
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

				local var_4_43 = arg_1_1:GetWordFromCfg(928041001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_45 = 28
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
	Play928041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 928041002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play928041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.9

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

				local var_12_2 = arg_9_1:GetWordFromCfg(928041002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 36
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
	Play928041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 928041003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play928041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.625

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(928041003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 25
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_8 and arg_13_1.time_ < var_16_0 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play928041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 928041004
		arg_17_1.duration_ = 8.17

		local var_17_0 = {
			zh = 7.533,
			ja = 8.166
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play928041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1085ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_17_1.stage_.transform)

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

			local var_20_5 = arg_17_1.actors_["1085ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1085ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0, -1.01, -5.83)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1085ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["1085ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1085ui_story == nil then
				arg_17_1.var_.characterEffect1085ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect1085ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1085ui_story then
				arg_17_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_20_20 = 0
			local var_20_21 = 0.625

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_22 = arg_17_1:FormatText(StoryNameCfg[328].name)

				arg_17_1.leftNameTxt_.text = var_20_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_23 = arg_17_1:GetWordFromCfg(928041004)
				local var_20_24 = arg_17_1:FormatText(var_20_23.content)

				arg_17_1.text_.text = var_20_24

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_25 = 25
				local var_20_26 = utf8.len(var_20_24)
				local var_20_27 = var_20_25 <= 0 and var_20_21 or var_20_21 * (var_20_26 / var_20_25)

				if var_20_27 > 0 and var_20_21 < var_20_27 then
					arg_17_1.talkMaxDuration = var_20_27

					if var_20_27 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_20
					end
				end

				arg_17_1.text_.text = var_20_24
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041004", "story_v_side_old_928041.awb") ~= 0 then
					local var_20_28 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041004", "story_v_side_old_928041.awb") / 1000

					if var_20_28 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_20
					end

					if var_20_23.prefab_name ~= "" and arg_17_1.actors_[var_20_23.prefab_name] ~= nil then
						local var_20_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_23.prefab_name].transform, "story_v_side_old_928041", "928041004", "story_v_side_old_928041.awb")

						arg_17_1:RecordAudio("928041004", var_20_29)
						arg_17_1:RecordAudio("928041004", var_20_29)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041004", "story_v_side_old_928041.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041004", "story_v_side_old_928041.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_30 = math.max(var_20_21, arg_17_1.talkMaxDuration)

			if var_20_20 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_30 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_20) / var_20_30

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_20 + var_20_30 and arg_17_1.time_ < var_20_20 + var_20_30 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play928041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 928041005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play928041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1085ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1085ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1085ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, 100, 0)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["1085ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1085ui_story == nil then
				arg_21_1.var_.characterEffect1085ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect1085ui_story and not isNil(var_24_9) then
					local var_24_13 = Mathf.Lerp(0, 0.5, var_24_12)

					arg_21_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1085ui_story.fillRatio = var_24_13
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1085ui_story then
				local var_24_14 = 0.5

				arg_21_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1085ui_story.fillRatio = var_24_14
			end

			local var_24_15 = 0
			local var_24_16 = 1.125

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_17 = arg_21_1:GetWordFromCfg(928041005)
				local var_24_18 = arg_21_1:FormatText(var_24_17.content)

				arg_21_1.text_.text = var_24_18

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_19 = 45
				local var_24_20 = utf8.len(var_24_18)
				local var_24_21 = var_24_19 <= 0 and var_24_16 or var_24_16 * (var_24_20 / var_24_19)

				if var_24_21 > 0 and var_24_16 < var_24_21 then
					arg_21_1.talkMaxDuration = var_24_21

					if var_24_21 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_21 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_18
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_22 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_22 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_22

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_22 and arg_21_1.time_ < var_24_15 + var_24_22 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play928041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 928041006
		arg_25_1.duration_ = 7.2

		local var_25_0 = {
			zh = 5.066,
			ja = 7.2
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play928041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.625

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[1375].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(928041006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 25
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041006", "story_v_side_old_928041.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041006", "story_v_side_old_928041.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_side_old_928041", "928041006", "story_v_side_old_928041.awb")

						arg_25_1:RecordAudio("928041006", var_28_9)
						arg_25_1:RecordAudio("928041006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041006", "story_v_side_old_928041.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041006", "story_v_side_old_928041.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play928041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 928041007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play928041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.975

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(928041007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 39
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play928041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 928041008
		arg_33_1.duration_ = 7.63

		local var_33_0 = {
			zh = 5.833,
			ja = 7.633
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play928041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.75

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[1160].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(928041008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 30
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041008", "story_v_side_old_928041.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041008", "story_v_side_old_928041.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_side_old_928041", "928041008", "story_v_side_old_928041.awb")

						arg_33_1:RecordAudio("928041008", var_36_9)
						arg_33_1:RecordAudio("928041008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041008", "story_v_side_old_928041.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041008", "story_v_side_old_928041.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play928041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 928041009
		arg_37_1.duration_ = 7

		local var_37_0 = {
			zh = 7,
			ja = 5.6
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play928041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.875

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[1375].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(928041009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 35
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041009", "story_v_side_old_928041.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041009", "story_v_side_old_928041.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_side_old_928041", "928041009", "story_v_side_old_928041.awb")

						arg_37_1:RecordAudio("928041009", var_40_9)
						arg_37_1:RecordAudio("928041009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041009", "story_v_side_old_928041.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041009", "story_v_side_old_928041.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play928041010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 928041010
		arg_41_1.duration_ = 1.77

		local var_41_0 = {
			zh = 1.766,
			ja = 1.5
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play928041011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.175

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[1160].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(928041010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041010", "story_v_side_old_928041.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041010", "story_v_side_old_928041.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_side_old_928041", "928041010", "story_v_side_old_928041.awb")

						arg_41_1:RecordAudio("928041010", var_44_9)
						arg_41_1:RecordAudio("928041010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041010", "story_v_side_old_928041.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041010", "story_v_side_old_928041.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play928041011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 928041011
		arg_45_1.duration_ = 6.5

		local var_45_0 = {
			zh = 6.233,
			ja = 6.5
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play928041012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.75

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[1375].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(928041011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041011", "story_v_side_old_928041.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041011", "story_v_side_old_928041.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_side_old_928041", "928041011", "story_v_side_old_928041.awb")

						arg_45_1:RecordAudio("928041011", var_48_9)
						arg_45_1:RecordAudio("928041011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041011", "story_v_side_old_928041.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041011", "story_v_side_old_928041.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play928041012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 928041012
		arg_49_1.duration_ = 5.03

		local var_49_0 = {
			zh = 3.233,
			ja = 5.033
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play928041013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.35

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[1160].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(928041012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041012", "story_v_side_old_928041.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041012", "story_v_side_old_928041.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_side_old_928041", "928041012", "story_v_side_old_928041.awb")

						arg_49_1:RecordAudio("928041012", var_52_9)
						arg_49_1:RecordAudio("928041012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041012", "story_v_side_old_928041.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041012", "story_v_side_old_928041.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play928041013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 928041013
		arg_53_1.duration_ = 12.4

		local var_53_0 = {
			zh = 8.2,
			ja = 12.4
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play928041014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.825

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[1160].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(928041013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041013", "story_v_side_old_928041.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041013", "story_v_side_old_928041.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_side_old_928041", "928041013", "story_v_side_old_928041.awb")

						arg_53_1:RecordAudio("928041013", var_56_9)
						arg_53_1:RecordAudio("928041013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041013", "story_v_side_old_928041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041013", "story_v_side_old_928041.awb")
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
	Play928041014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 928041014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play928041015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.975

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(928041014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 39
				local var_60_5 = utf8.len(var_60_3)
				local var_60_6 = var_60_4 <= 0 and var_60_1 or var_60_1 * (var_60_5 / var_60_4)

				if var_60_6 > 0 and var_60_1 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_7 and arg_57_1.time_ < var_60_0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play928041015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 928041015
		arg_61_1.duration_ = 7.87

		local var_61_0 = {
			zh = 6.39933333333333,
			ja = 7.86633333333333
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play928041016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1085ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1085ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, -1.01, -5.83)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1085ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["1085ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1085ui_story == nil then
				arg_61_1.var_.characterEffect1085ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect1085ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1085ui_story then
				arg_61_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_64_15 = 0.034000001847744

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			local var_64_16 = 0.832666664818923

			if arg_61_1.time_ >= var_64_15 + var_64_16 and arg_61_1.time_ < var_64_15 + var_64_16 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_17 = 0.633333333333333
			local var_64_18 = 0.525

			if var_64_17 < arg_61_1.time_ and arg_61_1.time_ <= var_64_17 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_19 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_19:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_20 = arg_61_1:FormatText(StoryNameCfg[328].name)

				arg_61_1.leftNameTxt_.text = var_64_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_21 = arg_61_1:GetWordFromCfg(928041015)
				local var_64_22 = arg_61_1:FormatText(var_64_21.content)

				arg_61_1.text_.text = var_64_22

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_23 = 21
				local var_64_24 = utf8.len(var_64_22)
				local var_64_25 = var_64_23 <= 0 and var_64_18 or var_64_18 * (var_64_24 / var_64_23)

				if var_64_25 > 0 and var_64_18 < var_64_25 then
					arg_61_1.talkMaxDuration = var_64_25
					var_64_17 = var_64_17 + 0.3

					if var_64_25 + var_64_17 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_25 + var_64_17
					end
				end

				arg_61_1.text_.text = var_64_22
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041015", "story_v_side_old_928041.awb") ~= 0 then
					local var_64_26 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041015", "story_v_side_old_928041.awb") / 1000

					if var_64_26 + var_64_17 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_26 + var_64_17
					end

					if var_64_21.prefab_name ~= "" and arg_61_1.actors_[var_64_21.prefab_name] ~= nil then
						local var_64_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_21.prefab_name].transform, "story_v_side_old_928041", "928041015", "story_v_side_old_928041.awb")

						arg_61_1:RecordAudio("928041015", var_64_27)
						arg_61_1:RecordAudio("928041015", var_64_27)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041015", "story_v_side_old_928041.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041015", "story_v_side_old_928041.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_28 = var_64_17 + 0.3
			local var_64_29 = math.max(var_64_18, arg_61_1.talkMaxDuration)

			if var_64_28 <= arg_61_1.time_ and arg_61_1.time_ < var_64_28 + var_64_29 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_28) / var_64_29

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_28 + var_64_29 and arg_61_1.time_ < var_64_28 + var_64_29 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play928041016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 928041016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play928041017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1085ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1085ui_story == nil then
				arg_67_1.var_.characterEffect1085ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1085ui_story and not isNil(var_70_0) then
					local var_70_4 = Mathf.Lerp(0, 0.5, var_70_3)

					arg_67_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1085ui_story.fillRatio = var_70_4
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1085ui_story then
				local var_70_5 = 0.5

				arg_67_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1085ui_story.fillRatio = var_70_5
			end

			local var_70_6 = 0
			local var_70_7 = 0.8

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_8 = arg_67_1:FormatText(StoryNameCfg[7].name)

				arg_67_1.leftNameTxt_.text = var_70_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_9 = arg_67_1:GetWordFromCfg(928041016)
				local var_70_10 = arg_67_1:FormatText(var_70_9.content)

				arg_67_1.text_.text = var_70_10

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 32
				local var_70_12 = utf8.len(var_70_10)
				local var_70_13 = var_70_11 <= 0 and var_70_7 or var_70_7 * (var_70_12 / var_70_11)

				if var_70_13 > 0 and var_70_7 < var_70_13 then
					arg_67_1.talkMaxDuration = var_70_13

					if var_70_13 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_6
					end
				end

				arg_67_1.text_.text = var_70_10
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_14 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_14 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_14

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_14 and arg_67_1.time_ < var_70_6 + var_70_14 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play928041017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 928041017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play928041018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.75

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

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:GetWordFromCfg(928041017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 30
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
	Play928041018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 928041018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play928041019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1085ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1085ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(0, 100, 0)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1085ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, 100, 0)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = 0.133333333333333
			local var_78_10 = 1

			if var_78_9 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 then
				local var_78_11 = "play"
				local var_78_12 = "effect"

				arg_75_1:AudioAction(var_78_11, var_78_12, "se_story_145", "se_story_145_foley_bag", "")
			end

			local var_78_13 = 0
			local var_78_14 = 0.925

			if var_78_13 < arg_75_1.time_ and arg_75_1.time_ <= var_78_13 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_15 = arg_75_1:GetWordFromCfg(928041018)
				local var_78_16 = arg_75_1:FormatText(var_78_15.content)

				arg_75_1.text_.text = var_78_16

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_17 = 37
				local var_78_18 = utf8.len(var_78_16)
				local var_78_19 = var_78_17 <= 0 and var_78_14 or var_78_14 * (var_78_18 / var_78_17)

				if var_78_19 > 0 and var_78_14 < var_78_19 then
					arg_75_1.talkMaxDuration = var_78_19

					if var_78_19 + var_78_13 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_19 + var_78_13
					end
				end

				arg_75_1.text_.text = var_78_16
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_20 = math.max(var_78_14, arg_75_1.talkMaxDuration)

			if var_78_13 <= arg_75_1.time_ and arg_75_1.time_ < var_78_13 + var_78_20 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_13) / var_78_20

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_13 + var_78_20 and arg_75_1.time_ < var_78_13 + var_78_20 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play928041019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 928041019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play928041020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 1.125

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_2 = arg_79_1:GetWordFromCfg(928041019)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 45
				local var_82_5 = utf8.len(var_82_3)
				local var_82_6 = var_82_4 <= 0 and var_82_1 or var_82_1 * (var_82_5 / var_82_4)

				if var_82_6 > 0 and var_82_1 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_7 and arg_79_1.time_ < var_82_0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play928041020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 928041020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play928041021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.775

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[7].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(928041020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 31
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_8 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_8 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_8

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_8 and arg_83_1.time_ < var_86_0 + var_86_8 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play928041021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 928041021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play928041022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.525

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[7].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:GetWordFromCfg(928041021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 21
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_8 and arg_87_1.time_ < var_90_0 + var_90_8 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play928041022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 928041022
		arg_91_1.duration_ = 2.7

		local var_91_0 = {
			zh = 2.7,
			ja = 2.366
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play928041023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1085ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1085ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, -1.01, -5.83)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1085ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = arg_91_1.actors_["1085ui_story"]
			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect1085ui_story == nil then
				arg_91_1.var_.characterEffect1085ui_story = var_94_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_11 = 0.200000002980232

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_11 and not isNil(var_94_9) then
				local var_94_12 = (arg_91_1.time_ - var_94_10) / var_94_11

				if arg_91_1.var_.characterEffect1085ui_story and not isNil(var_94_9) then
					arg_91_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_10 + var_94_11 and arg_91_1.time_ < var_94_10 + var_94_11 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect1085ui_story then
				arg_91_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_94_13 = 0

			if var_94_13 < arg_91_1.time_ and arg_91_1.time_ <= var_94_13 + arg_94_0 then
				arg_91_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_94_14 = 0

			if var_94_14 < arg_91_1.time_ and arg_91_1.time_ <= var_94_14 + arg_94_0 then
				arg_91_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_94_15 = 0
			local var_94_16 = 0.2

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_17 = arg_91_1:FormatText(StoryNameCfg[328].name)

				arg_91_1.leftNameTxt_.text = var_94_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_18 = arg_91_1:GetWordFromCfg(928041022)
				local var_94_19 = arg_91_1:FormatText(var_94_18.content)

				arg_91_1.text_.text = var_94_19

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_20 = 8
				local var_94_21 = utf8.len(var_94_19)
				local var_94_22 = var_94_20 <= 0 and var_94_16 or var_94_16 * (var_94_21 / var_94_20)

				if var_94_22 > 0 and var_94_16 < var_94_22 then
					arg_91_1.talkMaxDuration = var_94_22

					if var_94_22 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_22 + var_94_15
					end
				end

				arg_91_1.text_.text = var_94_19
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041022", "story_v_side_old_928041.awb") ~= 0 then
					local var_94_23 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041022", "story_v_side_old_928041.awb") / 1000

					if var_94_23 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_23 + var_94_15
					end

					if var_94_18.prefab_name ~= "" and arg_91_1.actors_[var_94_18.prefab_name] ~= nil then
						local var_94_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_18.prefab_name].transform, "story_v_side_old_928041", "928041022", "story_v_side_old_928041.awb")

						arg_91_1:RecordAudio("928041022", var_94_24)
						arg_91_1:RecordAudio("928041022", var_94_24)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041022", "story_v_side_old_928041.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041022", "story_v_side_old_928041.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_25 = math.max(var_94_16, arg_91_1.talkMaxDuration)

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_25 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_15) / var_94_25

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_15 + var_94_25 and arg_91_1.time_ < var_94_15 + var_94_25 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play928041023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 928041023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play928041024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1085ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1085ui_story == nil then
				arg_95_1.var_.characterEffect1085ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1085ui_story and not isNil(var_98_0) then
					local var_98_4 = Mathf.Lerp(0, 0.5, var_98_3)

					arg_95_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1085ui_story.fillRatio = var_98_4
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1085ui_story then
				local var_98_5 = 0.5

				arg_95_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1085ui_story.fillRatio = var_98_5
			end

			local var_98_6 = 0
			local var_98_7 = 0.775

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_8 = arg_95_1:FormatText(StoryNameCfg[7].name)

				arg_95_1.leftNameTxt_.text = var_98_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_9 = arg_95_1:GetWordFromCfg(928041023)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 31
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_7 or var_98_7 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_7 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_14 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_14 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_14

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_14 and arg_95_1.time_ < var_98_6 + var_98_14 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play928041024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 928041024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play928041025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.425

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[7].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_3 = arg_99_1:GetWordFromCfg(928041024)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 17
				local var_102_6 = utf8.len(var_102_4)
				local var_102_7 = var_102_5 <= 0 and var_102_1 or var_102_1 * (var_102_6 / var_102_5)

				if var_102_7 > 0 and var_102_1 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_8 and arg_99_1.time_ < var_102_0 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play928041025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 928041025
		arg_103_1.duration_ = 6.63

		local var_103_0 = {
			zh = 5.73333333333333,
			ja = 6.63333333333333
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play928041026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 1.43333333333333

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				local var_106_1 = manager.ui.mainCamera.transform.localPosition
				local var_106_2 = Vector3.New(0, 0, 10) + Vector3.New(var_106_1.x, var_106_1.y, 0)
				local var_106_3 = arg_103_1.bgs_.L16

				var_106_3.transform.localPosition = var_106_2
				var_106_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_4 = var_106_3:GetComponent("SpriteRenderer")

				if var_106_4 and var_106_4.sprite then
					local var_106_5 = (var_106_3.transform.localPosition - var_106_1).z
					local var_106_6 = manager.ui.mainCameraCom_
					local var_106_7 = 2 * var_106_5 * Mathf.Tan(var_106_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_106_8 = var_106_7 * var_106_6.aspect
					local var_106_9 = var_106_4.sprite.bounds.size.x
					local var_106_10 = var_106_4.sprite.bounds.size.y
					local var_106_11 = var_106_8 / var_106_9
					local var_106_12 = var_106_7 / var_106_10
					local var_106_13 = var_106_12 < var_106_11 and var_106_11 or var_106_12

					var_106_3.transform.localScale = Vector3.New(var_106_13, var_106_13, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "L16" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_14 = 0

			if var_106_14 < arg_103_1.time_ and arg_103_1.time_ <= var_106_14 + arg_106_0 then
				arg_103_1.allBtn_.enabled = false
			end

			local var_106_15 = 0.3

			if arg_103_1.time_ >= var_106_14 + var_106_15 and arg_103_1.time_ < var_106_14 + var_106_15 + arg_106_0 then
				arg_103_1.allBtn_.enabled = true
			end

			local var_106_16 = 0

			if var_106_16 < arg_103_1.time_ and arg_103_1.time_ <= var_106_16 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_17 = 1.43333333333333

			if var_106_16 <= arg_103_1.time_ and arg_103_1.time_ < var_106_16 + var_106_17 then
				local var_106_18 = (arg_103_1.time_ - var_106_16) / var_106_17
				local var_106_19 = Color.New(0, 0, 0)

				var_106_19.a = Mathf.Lerp(0, 1, var_106_18)
				arg_103_1.mask_.color = var_106_19
			end

			if arg_103_1.time_ >= var_106_16 + var_106_17 and arg_103_1.time_ < var_106_16 + var_106_17 + arg_106_0 then
				local var_106_20 = Color.New(0, 0, 0)

				var_106_20.a = 1
				arg_103_1.mask_.color = var_106_20
			end

			local var_106_21 = 1.43333333333333

			if var_106_21 < arg_103_1.time_ and arg_103_1.time_ <= var_106_21 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_22 = 2

			if var_106_21 <= arg_103_1.time_ and arg_103_1.time_ < var_106_21 + var_106_22 then
				local var_106_23 = (arg_103_1.time_ - var_106_21) / var_106_22
				local var_106_24 = Color.New(0, 0, 0)

				var_106_24.a = Mathf.Lerp(1, 0, var_106_23)
				arg_103_1.mask_.color = var_106_24
			end

			if arg_103_1.time_ >= var_106_21 + var_106_22 and arg_103_1.time_ < var_106_21 + var_106_22 + arg_106_0 then
				local var_106_25 = Color.New(0, 0, 0)
				local var_106_26 = 0

				arg_103_1.mask_.enabled = false
				var_106_25.a = var_106_26
				arg_103_1.mask_.color = var_106_25
			end

			local var_106_27 = arg_103_1.actors_["1085ui_story"].transform
			local var_106_28 = 1.43333333333333

			if var_106_28 < arg_103_1.time_ and arg_103_1.time_ <= var_106_28 + arg_106_0 then
				arg_103_1.var_.moveOldPos1085ui_story = var_106_27.localPosition
			end

			local var_106_29 = 0.001

			if var_106_28 <= arg_103_1.time_ and arg_103_1.time_ < var_106_28 + var_106_29 then
				local var_106_30 = (arg_103_1.time_ - var_106_28) / var_106_29
				local var_106_31 = Vector3.New(0, 100, 0)

				var_106_27.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1085ui_story, var_106_31, var_106_30)

				local var_106_32 = manager.ui.mainCamera.transform.position - var_106_27.position

				var_106_27.forward = Vector3.New(var_106_32.x, var_106_32.y, var_106_32.z)

				local var_106_33 = var_106_27.localEulerAngles

				var_106_33.z = 0
				var_106_33.x = 0
				var_106_27.localEulerAngles = var_106_33
			end

			if arg_103_1.time_ >= var_106_28 + var_106_29 and arg_103_1.time_ < var_106_28 + var_106_29 + arg_106_0 then
				var_106_27.localPosition = Vector3.New(0, 100, 0)

				local var_106_34 = manager.ui.mainCamera.transform.position - var_106_27.position

				var_106_27.forward = Vector3.New(var_106_34.x, var_106_34.y, var_106_34.z)

				local var_106_35 = var_106_27.localEulerAngles

				var_106_35.z = 0
				var_106_35.x = 0
				var_106_27.localEulerAngles = var_106_35
			end

			local var_106_36 = arg_103_1.actors_["1085ui_story"].transform
			local var_106_37 = 3.1

			if var_106_37 < arg_103_1.time_ and arg_103_1.time_ <= var_106_37 + arg_106_0 then
				arg_103_1.var_.moveOldPos1085ui_story = var_106_36.localPosition
			end

			local var_106_38 = 0.001

			if var_106_37 <= arg_103_1.time_ and arg_103_1.time_ < var_106_37 + var_106_38 then
				local var_106_39 = (arg_103_1.time_ - var_106_37) / var_106_38
				local var_106_40 = Vector3.New(0, -1.01, -5.83)

				var_106_36.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1085ui_story, var_106_40, var_106_39)

				local var_106_41 = manager.ui.mainCamera.transform.position - var_106_36.position

				var_106_36.forward = Vector3.New(var_106_41.x, var_106_41.y, var_106_41.z)

				local var_106_42 = var_106_36.localEulerAngles

				var_106_42.z = 0
				var_106_42.x = 0
				var_106_36.localEulerAngles = var_106_42
			end

			if arg_103_1.time_ >= var_106_37 + var_106_38 and arg_103_1.time_ < var_106_37 + var_106_38 + arg_106_0 then
				var_106_36.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_106_43 = manager.ui.mainCamera.transform.position - var_106_36.position

				var_106_36.forward = Vector3.New(var_106_43.x, var_106_43.y, var_106_43.z)

				local var_106_44 = var_106_36.localEulerAngles

				var_106_44.z = 0
				var_106_44.x = 0
				var_106_36.localEulerAngles = var_106_44
			end

			local var_106_45 = arg_103_1.actors_["1085ui_story"]
			local var_106_46 = 3.1

			if var_106_46 < arg_103_1.time_ and arg_103_1.time_ <= var_106_46 + arg_106_0 and not isNil(var_106_45) and arg_103_1.var_.characterEffect1085ui_story == nil then
				arg_103_1.var_.characterEffect1085ui_story = var_106_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_47 = 0.200000002980232

			if var_106_46 <= arg_103_1.time_ and arg_103_1.time_ < var_106_46 + var_106_47 and not isNil(var_106_45) then
				local var_106_48 = (arg_103_1.time_ - var_106_46) / var_106_47

				if arg_103_1.var_.characterEffect1085ui_story and not isNil(var_106_45) then
					arg_103_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_46 + var_106_47 and arg_103_1.time_ < var_106_46 + var_106_47 + arg_106_0 and not isNil(var_106_45) and arg_103_1.var_.characterEffect1085ui_story then
				arg_103_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_106_49 = 3.1

			if var_106_49 < arg_103_1.time_ and arg_103_1.time_ <= var_106_49 + arg_106_0 then
				arg_103_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_106_50 = 3.1

			if var_106_50 < arg_103_1.time_ and arg_103_1.time_ <= var_106_50 + arg_106_0 then
				arg_103_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_51 = 3.33333333333333
			local var_106_52 = 0.275

			if var_106_51 < arg_103_1.time_ and arg_103_1.time_ <= var_106_51 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_53 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_53:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_54 = arg_103_1:FormatText(StoryNameCfg[328].name)

				arg_103_1.leftNameTxt_.text = var_106_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_55 = arg_103_1:GetWordFromCfg(928041025)
				local var_106_56 = arg_103_1:FormatText(var_106_55.content)

				arg_103_1.text_.text = var_106_56

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_57 = 11
				local var_106_58 = utf8.len(var_106_56)
				local var_106_59 = var_106_57 <= 0 and var_106_52 or var_106_52 * (var_106_58 / var_106_57)

				if var_106_59 > 0 and var_106_52 < var_106_59 then
					arg_103_1.talkMaxDuration = var_106_59
					var_106_51 = var_106_51 + 0.3

					if var_106_59 + var_106_51 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_59 + var_106_51
					end
				end

				arg_103_1.text_.text = var_106_56
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041025", "story_v_side_old_928041.awb") ~= 0 then
					local var_106_60 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041025", "story_v_side_old_928041.awb") / 1000

					if var_106_60 + var_106_51 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_60 + var_106_51
					end

					if var_106_55.prefab_name ~= "" and arg_103_1.actors_[var_106_55.prefab_name] ~= nil then
						local var_106_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_55.prefab_name].transform, "story_v_side_old_928041", "928041025", "story_v_side_old_928041.awb")

						arg_103_1:RecordAudio("928041025", var_106_61)
						arg_103_1:RecordAudio("928041025", var_106_61)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041025", "story_v_side_old_928041.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041025", "story_v_side_old_928041.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_62 = var_106_51 + 0.3
			local var_106_63 = math.max(var_106_52, arg_103_1.talkMaxDuration)

			if var_106_62 <= arg_103_1.time_ and arg_103_1.time_ < var_106_62 + var_106_63 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_62) / var_106_63

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_62 + var_106_63 and arg_103_1.time_ < var_106_62 + var_106_63 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play928041026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 928041026
		arg_109_1.duration_ = 10.33

		local var_109_0 = {
			zh = 6.933,
			ja = 10.333
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play928041027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1085ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1085ui_story == nil then
				arg_109_1.var_.characterEffect1085ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1085ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1085ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1085ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1085ui_story.fillRatio = var_112_5
			end

			local var_112_6 = 0
			local var_112_7 = 0.8

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[1160].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_9 = arg_109_1:GetWordFromCfg(928041026)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 32
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

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041026", "story_v_side_old_928041.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041026", "story_v_side_old_928041.awb") / 1000

					if var_112_14 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_6
					end

					if var_112_9.prefab_name ~= "" and arg_109_1.actors_[var_112_9.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_9.prefab_name].transform, "story_v_side_old_928041", "928041026", "story_v_side_old_928041.awb")

						arg_109_1:RecordAudio("928041026", var_112_15)
						arg_109_1:RecordAudio("928041026", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041026", "story_v_side_old_928041.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041026", "story_v_side_old_928041.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_16 and arg_109_1.time_ < var_112_6 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play928041027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 928041027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play928041028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.725

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:GetWordFromCfg(928041027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 29
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_8 and arg_113_1.time_ < var_116_0 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play928041028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 928041028
		arg_117_1.duration_ = 7.8

		local var_117_0 = {
			zh = 6.566,
			ja = 7.8
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play928041029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.525

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[1160].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:GetWordFromCfg(928041028)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 21
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041028", "story_v_side_old_928041.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041028", "story_v_side_old_928041.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_side_old_928041", "928041028", "story_v_side_old_928041.awb")

						arg_117_1:RecordAudio("928041028", var_120_9)
						arg_117_1:RecordAudio("928041028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041028", "story_v_side_old_928041.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041028", "story_v_side_old_928041.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play928041029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 928041029
		arg_121_1.duration_ = 7.47

		local var_121_0 = {
			zh = 6.5,
			ja = 7.466
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play928041030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.775

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[1160].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(928041029)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 31
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041029", "story_v_side_old_928041.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041029", "story_v_side_old_928041.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_side_old_928041", "928041029", "story_v_side_old_928041.awb")

						arg_121_1:RecordAudio("928041029", var_124_9)
						arg_121_1:RecordAudio("928041029", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041029", "story_v_side_old_928041.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041029", "story_v_side_old_928041.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_10 and arg_121_1.time_ < var_124_0 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play928041030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 928041030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play928041031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1085ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1085ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, 100, 0)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1085ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, 100, 0)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = 0
			local var_128_10 = 0.775

			if var_128_9 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_11 = arg_125_1:FormatText(StoryNameCfg[7].name)

				arg_125_1.leftNameTxt_.text = var_128_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_12 = arg_125_1:GetWordFromCfg(928041030)
				local var_128_13 = arg_125_1:FormatText(var_128_12.content)

				arg_125_1.text_.text = var_128_13

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_14 = 31
				local var_128_15 = utf8.len(var_128_13)
				local var_128_16 = var_128_14 <= 0 and var_128_10 or var_128_10 * (var_128_15 / var_128_14)

				if var_128_16 > 0 and var_128_10 < var_128_16 then
					arg_125_1.talkMaxDuration = var_128_16

					if var_128_16 + var_128_9 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_16 + var_128_9
					end
				end

				arg_125_1.text_.text = var_128_13
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_17 = math.max(var_128_10, arg_125_1.talkMaxDuration)

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_17 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_9) / var_128_17

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_9 + var_128_17 and arg_125_1.time_ < var_128_9 + var_128_17 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play928041031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 928041031
		arg_129_1.duration_ = 6.3

		local var_129_0 = {
			zh = 3.7,
			ja = 6.3
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
				arg_129_0:Play928041032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.45

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[1160].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(928041031)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 18
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041031", "story_v_side_old_928041.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041031", "story_v_side_old_928041.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_side_old_928041", "928041031", "story_v_side_old_928041.awb")

						arg_129_1:RecordAudio("928041031", var_132_9)
						arg_129_1:RecordAudio("928041031", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041031", "story_v_side_old_928041.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041031", "story_v_side_old_928041.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_10 and arg_129_1.time_ < var_132_0 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play928041032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 928041032
		arg_133_1.duration_ = 10.27

		local var_133_0 = {
			zh = 6.766,
			ja = 10.266
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play928041033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.85

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[1375].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:GetWordFromCfg(928041032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041032", "story_v_side_old_928041.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041032", "story_v_side_old_928041.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_side_old_928041", "928041032", "story_v_side_old_928041.awb")

						arg_133_1:RecordAudio("928041032", var_136_9)
						arg_133_1:RecordAudio("928041032", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041032", "story_v_side_old_928041.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041032", "story_v_side_old_928041.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play928041033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 928041033
		arg_137_1.duration_ = 10.03

		local var_137_0 = {
			zh = 6.766,
			ja = 10.033
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play928041034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.75

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[1375].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(928041033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 30
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041033", "story_v_side_old_928041.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041033", "story_v_side_old_928041.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_side_old_928041", "928041033", "story_v_side_old_928041.awb")

						arg_137_1:RecordAudio("928041033", var_140_9)
						arg_137_1:RecordAudio("928041033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041033", "story_v_side_old_928041.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041033", "story_v_side_old_928041.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_10 and arg_137_1.time_ < var_140_0 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play928041034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 928041034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play928041035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1085ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1085ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(0, 100, 0)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1085ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, 100, 0)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = 0
			local var_144_10 = 0.7

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_11 = arg_141_1:GetWordFromCfg(928041034)
				local var_144_12 = arg_141_1:FormatText(var_144_11.content)

				arg_141_1.text_.text = var_144_12

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_13 = 28
				local var_144_14 = utf8.len(var_144_12)
				local var_144_15 = var_144_13 <= 0 and var_144_10 or var_144_10 * (var_144_14 / var_144_13)

				if var_144_15 > 0 and var_144_10 < var_144_15 then
					arg_141_1.talkMaxDuration = var_144_15

					if var_144_15 + var_144_9 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_15 + var_144_9
					end
				end

				arg_141_1.text_.text = var_144_12
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_10, arg_141_1.talkMaxDuration)

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_9) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_9 + var_144_16 and arg_141_1.time_ < var_144_9 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play928041035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 928041035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play928041036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.6

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[7].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(928041035)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 24
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_8 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_8 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_8

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_8 and arg_145_1.time_ < var_148_0 + var_148_8 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play928041036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 928041036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play928041037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 1.075

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(928041036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 43
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play928041037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 928041037
		arg_153_1.duration_ = 1.67

		local var_153_0 = {
			zh = 1.666,
			ja = 1.4
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play928041038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.175

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[1160].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(928041037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 7
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041037", "story_v_side_old_928041.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041037", "story_v_side_old_928041.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_side_old_928041", "928041037", "story_v_side_old_928041.awb")

						arg_153_1:RecordAudio("928041037", var_156_9)
						arg_153_1:RecordAudio("928041037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041037", "story_v_side_old_928041.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041037", "story_v_side_old_928041.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play928041038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 928041038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play928041039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.775

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[7].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:GetWordFromCfg(928041038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 31
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_8 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_8 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_8

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_8 and arg_157_1.time_ < var_160_0 + var_160_8 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play928041039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 928041039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play928041040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.75

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:GetWordFromCfg(928041039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 30
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_8 and arg_161_1.time_ < var_164_0 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play928041040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 928041040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play928041041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.525

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[7].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:GetWordFromCfg(928041040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 21
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_8 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_8 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_8

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_8 and arg_165_1.time_ < var_168_0 + var_168_8 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play928041041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 928041041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play928041042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.9

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

				local var_172_2 = arg_169_1:GetWordFromCfg(928041041)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 36
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
	Play928041042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 928041042
		arg_173_1.duration_ = 1.23

		local var_173_0 = {
			zh = 1.233,
			ja = 1.2
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play928041043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.1

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[1160].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:GetWordFromCfg(928041042)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 4
				local var_176_6 = utf8.len(var_176_4)
				local var_176_7 = var_176_5 <= 0 and var_176_1 or var_176_1 * (var_176_6 / var_176_5)

				if var_176_7 > 0 and var_176_1 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041042", "story_v_side_old_928041.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041042", "story_v_side_old_928041.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_side_old_928041", "928041042", "story_v_side_old_928041.awb")

						arg_173_1:RecordAudio("928041042", var_176_9)
						arg_173_1:RecordAudio("928041042", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041042", "story_v_side_old_928041.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041042", "story_v_side_old_928041.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_10 and arg_173_1.time_ < var_176_0 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play928041043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 928041043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play928041044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.825

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[7].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_3 = arg_177_1:GetWordFromCfg(928041043)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 33
				local var_180_6 = utf8.len(var_180_4)
				local var_180_7 = var_180_5 <= 0 and var_180_1 or var_180_1 * (var_180_6 / var_180_5)

				if var_180_7 > 0 and var_180_1 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_8 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_8 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_8

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_8 and arg_177_1.time_ < var_180_0 + var_180_8 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play928041044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 928041044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play928041045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 1.05

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:GetWordFromCfg(928041044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 42
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_8 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_8 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_8

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_8 and arg_181_1.time_ < var_184_0 + var_184_8 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play928041045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 928041045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play928041046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 1.325

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[7].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(928041045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 53
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play928041046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 928041046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play928041047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 1.15

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[7].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(928041046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 46
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_8 and arg_189_1.time_ < var_192_0 + var_192_8 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play928041047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 928041047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play928041048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.85

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:GetWordFromCfg(928041047)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 34
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_8 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_8 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_8

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_8 and arg_193_1.time_ < var_196_0 + var_196_8 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play928041048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 928041048
		arg_197_1.duration_ = 5.17

		local var_197_0 = {
			zh = 4.066,
			ja = 5.166
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play928041049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1085ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1085ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0, -1.01, -5.83)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1085ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["1085ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1085ui_story == nil then
				arg_197_1.var_.characterEffect1085ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect1085ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1085ui_story then
				arg_197_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_200_13 = 0

			if var_200_13 < arg_197_1.time_ and arg_197_1.time_ <= var_200_13 + arg_200_0 then
				arg_197_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_200_14 = 0

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_200_15 = 0
			local var_200_16 = 0.5

			if var_200_15 < arg_197_1.time_ and arg_197_1.time_ <= var_200_15 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_17 = arg_197_1:FormatText(StoryNameCfg[328].name)

				arg_197_1.leftNameTxt_.text = var_200_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_18 = arg_197_1:GetWordFromCfg(928041048)
				local var_200_19 = arg_197_1:FormatText(var_200_18.content)

				arg_197_1.text_.text = var_200_19

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_20 = 20
				local var_200_21 = utf8.len(var_200_19)
				local var_200_22 = var_200_20 <= 0 and var_200_16 or var_200_16 * (var_200_21 / var_200_20)

				if var_200_22 > 0 and var_200_16 < var_200_22 then
					arg_197_1.talkMaxDuration = var_200_22

					if var_200_22 + var_200_15 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_22 + var_200_15
					end
				end

				arg_197_1.text_.text = var_200_19
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041048", "story_v_side_old_928041.awb") ~= 0 then
					local var_200_23 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041048", "story_v_side_old_928041.awb") / 1000

					if var_200_23 + var_200_15 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_23 + var_200_15
					end

					if var_200_18.prefab_name ~= "" and arg_197_1.actors_[var_200_18.prefab_name] ~= nil then
						local var_200_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_18.prefab_name].transform, "story_v_side_old_928041", "928041048", "story_v_side_old_928041.awb")

						arg_197_1:RecordAudio("928041048", var_200_24)
						arg_197_1:RecordAudio("928041048", var_200_24)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041048", "story_v_side_old_928041.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041048", "story_v_side_old_928041.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_25 = math.max(var_200_16, arg_197_1.talkMaxDuration)

			if var_200_15 <= arg_197_1.time_ and arg_197_1.time_ < var_200_15 + var_200_25 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_15) / var_200_25

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_15 + var_200_25 and arg_197_1.time_ < var_200_15 + var_200_25 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play928041049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 928041049
		arg_201_1.duration_ = 7.33

		local var_201_0 = {
			zh = 4.3,
			ja = 7.333
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play928041050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1085ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1085ui_story == nil then
				arg_201_1.var_.characterEffect1085ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1085ui_story and not isNil(var_204_0) then
					local var_204_4 = Mathf.Lerp(0, 0.5, var_204_3)

					arg_201_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1085ui_story.fillRatio = var_204_4
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1085ui_story then
				local var_204_5 = 0.5

				arg_201_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1085ui_story.fillRatio = var_204_5
			end

			local var_204_6 = 0
			local var_204_7 = 0.6

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_8 = arg_201_1:FormatText(StoryNameCfg[1160].name)

				arg_201_1.leftNameTxt_.text = var_204_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_9 = arg_201_1:GetWordFromCfg(928041049)
				local var_204_10 = arg_201_1:FormatText(var_204_9.content)

				arg_201_1.text_.text = var_204_10

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 24
				local var_204_12 = utf8.len(var_204_10)
				local var_204_13 = var_204_11 <= 0 and var_204_7 or var_204_7 * (var_204_12 / var_204_11)

				if var_204_13 > 0 and var_204_7 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_10
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041049", "story_v_side_old_928041.awb") ~= 0 then
					local var_204_14 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041049", "story_v_side_old_928041.awb") / 1000

					if var_204_14 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_6
					end

					if var_204_9.prefab_name ~= "" and arg_201_1.actors_[var_204_9.prefab_name] ~= nil then
						local var_204_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_9.prefab_name].transform, "story_v_side_old_928041", "928041049", "story_v_side_old_928041.awb")

						arg_201_1:RecordAudio("928041049", var_204_15)
						arg_201_1:RecordAudio("928041049", var_204_15)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041049", "story_v_side_old_928041.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041049", "story_v_side_old_928041.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_16 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_16 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_16

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_16 and arg_201_1.time_ < var_204_6 + var_204_16 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play928041050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 928041050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play928041051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1085ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1085ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(0, 100, 0)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1085ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, 100, 0)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = 0
			local var_208_10 = 0.525

			if var_208_9 < arg_205_1.time_ and arg_205_1.time_ <= var_208_9 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_11 = arg_205_1:FormatText(StoryNameCfg[7].name)

				arg_205_1.leftNameTxt_.text = var_208_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_12 = arg_205_1:GetWordFromCfg(928041050)
				local var_208_13 = arg_205_1:FormatText(var_208_12.content)

				arg_205_1.text_.text = var_208_13

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_14 = 21
				local var_208_15 = utf8.len(var_208_13)
				local var_208_16 = var_208_14 <= 0 and var_208_10 or var_208_10 * (var_208_15 / var_208_14)

				if var_208_16 > 0 and var_208_10 < var_208_16 then
					arg_205_1.talkMaxDuration = var_208_16

					if var_208_16 + var_208_9 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_16 + var_208_9
					end
				end

				arg_205_1.text_.text = var_208_13
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_17 = math.max(var_208_10, arg_205_1.talkMaxDuration)

			if var_208_9 <= arg_205_1.time_ and arg_205_1.time_ < var_208_9 + var_208_17 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_9) / var_208_17

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_9 + var_208_17 and arg_205_1.time_ < var_208_9 + var_208_17 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play928041051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 928041051
		arg_209_1.duration_ = 5.47

		local var_209_0 = {
			zh = 4.533,
			ja = 5.466
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play928041052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.475

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[1160].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(928041051)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 19
				local var_212_6 = utf8.len(var_212_4)
				local var_212_7 = var_212_5 <= 0 and var_212_1 or var_212_1 * (var_212_6 / var_212_5)

				if var_212_7 > 0 and var_212_1 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041051", "story_v_side_old_928041.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041051", "story_v_side_old_928041.awb") / 1000

					if var_212_8 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_0
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_side_old_928041", "928041051", "story_v_side_old_928041.awb")

						arg_209_1:RecordAudio("928041051", var_212_9)
						arg_209_1:RecordAudio("928041051", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041051", "story_v_side_old_928041.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041051", "story_v_side_old_928041.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_10 and arg_209_1.time_ < var_212_0 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play928041052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 928041052
		arg_213_1.duration_ = 10.23

		local var_213_0 = {
			zh = 4.7,
			ja = 10.233
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play928041053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.525

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[1160].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(928041052)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 21
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041052", "story_v_side_old_928041.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041052", "story_v_side_old_928041.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_side_old_928041", "928041052", "story_v_side_old_928041.awb")

						arg_213_1:RecordAudio("928041052", var_216_9)
						arg_213_1:RecordAudio("928041052", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041052", "story_v_side_old_928041.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041052", "story_v_side_old_928041.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_10 and arg_213_1.time_ < var_216_0 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play928041053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 928041053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play928041054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.125

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(928041053)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 5
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
	Play928041054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 928041054
		arg_221_1.duration_ = 16.57

		local var_221_0 = {
			zh = 10.833,
			ja = 16.566
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play928041055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1085ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1085ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0, 100, 0)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1085ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, 100, 0)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = 0
			local var_224_10 = 1.275

			if var_224_9 < arg_221_1.time_ and arg_221_1.time_ <= var_224_9 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_11 = arg_221_1:FormatText(StoryNameCfg[1375].name)

				arg_221_1.leftNameTxt_.text = var_224_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_12 = arg_221_1:GetWordFromCfg(928041054)
				local var_224_13 = arg_221_1:FormatText(var_224_12.content)

				arg_221_1.text_.text = var_224_13

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_14 = 51
				local var_224_15 = utf8.len(var_224_13)
				local var_224_16 = var_224_14 <= 0 and var_224_10 or var_224_10 * (var_224_15 / var_224_14)

				if var_224_16 > 0 and var_224_10 < var_224_16 then
					arg_221_1.talkMaxDuration = var_224_16

					if var_224_16 + var_224_9 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_16 + var_224_9
					end
				end

				arg_221_1.text_.text = var_224_13
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041054", "story_v_side_old_928041.awb") ~= 0 then
					local var_224_17 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041054", "story_v_side_old_928041.awb") / 1000

					if var_224_17 + var_224_9 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_17 + var_224_9
					end

					if var_224_12.prefab_name ~= "" and arg_221_1.actors_[var_224_12.prefab_name] ~= nil then
						local var_224_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_12.prefab_name].transform, "story_v_side_old_928041", "928041054", "story_v_side_old_928041.awb")

						arg_221_1:RecordAudio("928041054", var_224_18)
						arg_221_1:RecordAudio("928041054", var_224_18)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041054", "story_v_side_old_928041.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041054", "story_v_side_old_928041.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_19 = math.max(var_224_10, arg_221_1.talkMaxDuration)

			if var_224_9 <= arg_221_1.time_ and arg_221_1.time_ < var_224_9 + var_224_19 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_9) / var_224_19

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_9 + var_224_19 and arg_221_1.time_ < var_224_9 + var_224_19 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play928041055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 928041055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play928041056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 1.3

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(928041055)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 52
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_8 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_8 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_8

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_8 and arg_225_1.time_ < var_228_0 + var_228_8 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play928041056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 928041056
		arg_229_1.duration_ = 5.03

		local var_229_0 = {
			zh = 3.8,
			ja = 5.033
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play928041057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.525

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[1375].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(928041056)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 21
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041056", "story_v_side_old_928041.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041056", "story_v_side_old_928041.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_side_old_928041", "928041056", "story_v_side_old_928041.awb")

						arg_229_1:RecordAudio("928041056", var_232_9)
						arg_229_1:RecordAudio("928041056", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041056", "story_v_side_old_928041.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041056", "story_v_side_old_928041.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_10 and arg_229_1.time_ < var_232_0 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play928041057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 928041057
		arg_233_1.duration_ = 8.47

		local var_233_0 = {
			zh = 6.266,
			ja = 8.466
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play928041058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.825

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[1375].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:GetWordFromCfg(928041057)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 33
				local var_236_6 = utf8.len(var_236_4)
				local var_236_7 = var_236_5 <= 0 and var_236_1 or var_236_1 * (var_236_6 / var_236_5)

				if var_236_7 > 0 and var_236_1 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041057", "story_v_side_old_928041.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041057", "story_v_side_old_928041.awb") / 1000

					if var_236_8 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_0
					end

					if var_236_3.prefab_name ~= "" and arg_233_1.actors_[var_236_3.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_3.prefab_name].transform, "story_v_side_old_928041", "928041057", "story_v_side_old_928041.awb")

						arg_233_1:RecordAudio("928041057", var_236_9)
						arg_233_1:RecordAudio("928041057", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041057", "story_v_side_old_928041.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041057", "story_v_side_old_928041.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_10 and arg_233_1.time_ < var_236_0 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play928041058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 928041058
		arg_237_1.duration_ = 8.27

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play928041059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = "ST69"

			if arg_237_1.bgs_[var_240_0] == nil then
				local var_240_1 = Object.Instantiate(arg_237_1.paintGo_)

				var_240_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_240_0)
				var_240_1.name = var_240_0
				var_240_1.transform.parent = arg_237_1.stage_.transform
				var_240_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.bgs_[var_240_0] = var_240_1
			end

			local var_240_2 = 1.4

			if var_240_2 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				local var_240_3 = manager.ui.mainCamera.transform.localPosition
				local var_240_4 = Vector3.New(0, 0, 10) + Vector3.New(var_240_3.x, var_240_3.y, 0)
				local var_240_5 = arg_237_1.bgs_.ST69

				var_240_5.transform.localPosition = var_240_4
				var_240_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_240_6 = var_240_5:GetComponent("SpriteRenderer")

				if var_240_6 and var_240_6.sprite then
					local var_240_7 = (var_240_5.transform.localPosition - var_240_3).z
					local var_240_8 = manager.ui.mainCameraCom_
					local var_240_9 = 2 * var_240_7 * Mathf.Tan(var_240_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_240_10 = var_240_9 * var_240_8.aspect
					local var_240_11 = var_240_6.sprite.bounds.size.x
					local var_240_12 = var_240_6.sprite.bounds.size.y
					local var_240_13 = var_240_10 / var_240_11
					local var_240_14 = var_240_9 / var_240_12
					local var_240_15 = var_240_14 < var_240_13 and var_240_13 or var_240_14

					var_240_5.transform.localScale = Vector3.New(var_240_15, var_240_15, 0)
				end

				for iter_240_0, iter_240_1 in pairs(arg_237_1.bgs_) do
					if iter_240_0 ~= "ST69" then
						iter_240_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_240_16 = 0

			if var_240_16 < arg_237_1.time_ and arg_237_1.time_ <= var_240_16 + arg_240_0 then
				arg_237_1.allBtn_.enabled = false
			end

			local var_240_17 = 0.3

			if arg_237_1.time_ >= var_240_16 + var_240_17 and arg_237_1.time_ < var_240_16 + var_240_17 + arg_240_0 then
				arg_237_1.allBtn_.enabled = true
			end

			local var_240_18 = 0

			if var_240_18 < arg_237_1.time_ and arg_237_1.time_ <= var_240_18 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = true

				arg_237_1:SetGaussion(false)
			end

			local var_240_19 = 1.4

			if var_240_18 <= arg_237_1.time_ and arg_237_1.time_ < var_240_18 + var_240_19 then
				local var_240_20 = (arg_237_1.time_ - var_240_18) / var_240_19
				local var_240_21 = Color.New(0, 0, 0)

				var_240_21.a = Mathf.Lerp(0, 1, var_240_20)
				arg_237_1.mask_.color = var_240_21
			end

			if arg_237_1.time_ >= var_240_18 + var_240_19 and arg_237_1.time_ < var_240_18 + var_240_19 + arg_240_0 then
				local var_240_22 = Color.New(0, 0, 0)

				var_240_22.a = 1
				arg_237_1.mask_.color = var_240_22
			end

			local var_240_23 = 1.4

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 then
				arg_237_1.mask_.enabled = true
				arg_237_1.mask_.raycastTarget = true

				arg_237_1:SetGaussion(false)
			end

			local var_240_24 = 1.9

			if var_240_23 <= arg_237_1.time_ and arg_237_1.time_ < var_240_23 + var_240_24 then
				local var_240_25 = (arg_237_1.time_ - var_240_23) / var_240_24
				local var_240_26 = Color.New(0, 0, 0)

				var_240_26.a = Mathf.Lerp(1, 0, var_240_25)
				arg_237_1.mask_.color = var_240_26
			end

			if arg_237_1.time_ >= var_240_23 + var_240_24 and arg_237_1.time_ < var_240_23 + var_240_24 + arg_240_0 then
				local var_240_27 = Color.New(0, 0, 0)
				local var_240_28 = 0

				arg_237_1.mask_.enabled = false
				var_240_27.a = var_240_28
				arg_237_1.mask_.color = var_240_27
			end

			local var_240_29 = 0.133333333333333
			local var_240_30 = 1

			if var_240_29 < arg_237_1.time_ and arg_237_1.time_ <= var_240_29 + arg_240_0 then
				local var_240_31 = "stop"
				local var_240_32 = "effect"

				arg_237_1:AudioAction(var_240_31, var_240_32, "se_story_145", "se_story_145_amb_dream", "")
			end

			local var_240_33 = 1
			local var_240_34 = 1

			if var_240_33 < arg_237_1.time_ and arg_237_1.time_ <= var_240_33 + arg_240_0 then
				local var_240_35 = "play"
				local var_240_36 = "effect"

				arg_237_1:AudioAction(var_240_35, var_240_36, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_237_1.frameCnt_ <= 1 then
				arg_237_1.dialog_:SetActive(false)
			end

			local var_240_37 = 3.26666666666667
			local var_240_38 = 0.85

			if var_240_37 < arg_237_1.time_ and arg_237_1.time_ <= var_240_37 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				arg_237_1.dialog_:SetActive(true)

				arg_237_1.dialogCg_.alpha = 0

				local var_240_39 = LeanTween.value(arg_237_1.dialog_, 0, 1, 0.3)

				var_240_39:setOnUpdate(LuaHelper.FloatAction(function(arg_241_0)
					arg_237_1.dialogCg_.alpha = arg_241_0
				end))
				var_240_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_237_1.dialog_)
					var_240_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_237_1.duration_ = arg_237_1.duration_ + 0.3

				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_40 = arg_237_1:GetWordFromCfg(928041058)
				local var_240_41 = arg_237_1:FormatText(var_240_40.content)

				arg_237_1.text_.text = var_240_41

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_42 = 34
				local var_240_43 = utf8.len(var_240_41)
				local var_240_44 = var_240_42 <= 0 and var_240_38 or var_240_38 * (var_240_43 / var_240_42)

				if var_240_44 > 0 and var_240_38 < var_240_44 then
					arg_237_1.talkMaxDuration = var_240_44
					var_240_37 = var_240_37 + 0.3

					if var_240_44 + var_240_37 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_44 + var_240_37
					end
				end

				arg_237_1.text_.text = var_240_41
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_45 = var_240_37 + 0.3
			local var_240_46 = math.max(var_240_38, arg_237_1.talkMaxDuration)

			if var_240_45 <= arg_237_1.time_ and arg_237_1.time_ < var_240_45 + var_240_46 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_45) / var_240_46

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_45 + var_240_46 and arg_237_1.time_ < var_240_45 + var_240_46 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play928041059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 928041059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play928041060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.55

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[7].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:GetWordFromCfg(928041059)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 22
				local var_246_6 = utf8.len(var_246_4)
				local var_246_7 = var_246_5 <= 0 and var_246_1 or var_246_1 * (var_246_6 / var_246_5)

				if var_246_7 > 0 and var_246_1 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_8 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_8 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_8

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_8 and arg_243_1.time_ < var_246_0 + var_246_8 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play928041060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 928041060
		arg_247_1.duration_ = 3.3

		local var_247_0 = {
			zh = 2.433,
			ja = 3.3
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play928041061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 0.3

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[1377].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:GetWordFromCfg(928041060)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 12
				local var_250_6 = utf8.len(var_250_4)
				local var_250_7 = var_250_5 <= 0 and var_250_1 or var_250_1 * (var_250_6 / var_250_5)

				if var_250_7 > 0 and var_250_1 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041060", "story_v_side_old_928041.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041060", "story_v_side_old_928041.awb") / 1000

					if var_250_8 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_0
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_side_old_928041", "928041060", "story_v_side_old_928041.awb")

						arg_247_1:RecordAudio("928041060", var_250_9)
						arg_247_1:RecordAudio("928041060", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041060", "story_v_side_old_928041.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041060", "story_v_side_old_928041.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_10 and arg_247_1.time_ < var_250_0 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play928041061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 928041061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play928041062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.775

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[7].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:GetWordFromCfg(928041061)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 31
				local var_254_6 = utf8.len(var_254_4)
				local var_254_7 = var_254_5 <= 0 and var_254_1 or var_254_1 * (var_254_6 / var_254_5)

				if var_254_7 > 0 and var_254_1 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_8 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_8 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_8

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_8 and arg_251_1.time_ < var_254_0 + var_254_8 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play928041062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 928041062
		arg_255_1.duration_ = 9.13

		local var_255_0 = {
			zh = 8.666,
			ja = 9.133
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play928041063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.9

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[1377].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:GetWordFromCfg(928041062)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 37
				local var_258_6 = utf8.len(var_258_4)
				local var_258_7 = var_258_5 <= 0 and var_258_1 or var_258_1 * (var_258_6 / var_258_5)

				if var_258_7 > 0 and var_258_1 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041062", "story_v_side_old_928041.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041062", "story_v_side_old_928041.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_side_old_928041", "928041062", "story_v_side_old_928041.awb")

						arg_255_1:RecordAudio("928041062", var_258_9)
						arg_255_1:RecordAudio("928041062", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041062", "story_v_side_old_928041.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041062", "story_v_side_old_928041.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_10 and arg_255_1.time_ < var_258_0 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play928041063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 928041063
		arg_259_1.duration_ = 5.4

		local var_259_0 = {
			zh = 5.1,
			ja = 5.4
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play928041064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 0.65

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_2 = arg_259_1:FormatText(StoryNameCfg[1377].name)

				arg_259_1.leftNameTxt_.text = var_262_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_3 = arg_259_1:GetWordFromCfg(928041063)
				local var_262_4 = arg_259_1:FormatText(var_262_3.content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 26
				local var_262_6 = utf8.len(var_262_4)
				local var_262_7 = var_262_5 <= 0 and var_262_1 or var_262_1 * (var_262_6 / var_262_5)

				if var_262_7 > 0 and var_262_1 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041063", "story_v_side_old_928041.awb") ~= 0 then
					local var_262_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041063", "story_v_side_old_928041.awb") / 1000

					if var_262_8 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_0
					end

					if var_262_3.prefab_name ~= "" and arg_259_1.actors_[var_262_3.prefab_name] ~= nil then
						local var_262_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_3.prefab_name].transform, "story_v_side_old_928041", "928041063", "story_v_side_old_928041.awb")

						arg_259_1:RecordAudio("928041063", var_262_9)
						arg_259_1:RecordAudio("928041063", var_262_9)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041063", "story_v_side_old_928041.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041063", "story_v_side_old_928041.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_10 and arg_259_1.time_ < var_262_0 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play928041064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 928041064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play928041065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 0.4

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_2 = arg_263_1:FormatText(StoryNameCfg[7].name)

				arg_263_1.leftNameTxt_.text = var_266_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_3 = arg_263_1:GetWordFromCfg(928041064)
				local var_266_4 = arg_263_1:FormatText(var_266_3.content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 16
				local var_266_6 = utf8.len(var_266_4)
				local var_266_7 = var_266_5 <= 0 and var_266_1 or var_266_1 * (var_266_6 / var_266_5)

				if var_266_7 > 0 and var_266_1 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_4
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_8 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_8 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_8

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_8 and arg_263_1.time_ < var_266_0 + var_266_8 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play928041065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 928041065
		arg_267_1.duration_ = 5.37

		local var_267_0 = {
			zh = 4.333,
			ja = 5.366
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
				arg_267_0:Play928041066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.575

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[1377].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_3 = arg_267_1:GetWordFromCfg(928041065)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 23
				local var_270_6 = utf8.len(var_270_4)
				local var_270_7 = var_270_5 <= 0 and var_270_1 or var_270_1 * (var_270_6 / var_270_5)

				if var_270_7 > 0 and var_270_1 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041065", "story_v_side_old_928041.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041065", "story_v_side_old_928041.awb") / 1000

					if var_270_8 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_0
					end

					if var_270_3.prefab_name ~= "" and arg_267_1.actors_[var_270_3.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_3.prefab_name].transform, "story_v_side_old_928041", "928041065", "story_v_side_old_928041.awb")

						arg_267_1:RecordAudio("928041065", var_270_9)
						arg_267_1:RecordAudio("928041065", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041065", "story_v_side_old_928041.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041065", "story_v_side_old_928041.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_10 and arg_267_1.time_ < var_270_0 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play928041066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 928041066
		arg_271_1.duration_ = 5.07

		local var_271_0 = {
			zh = 3.966,
			ja = 5.066
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play928041067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 0.6

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_2 = arg_271_1:FormatText(StoryNameCfg[1377].name)

				arg_271_1.leftNameTxt_.text = var_274_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_3 = arg_271_1:GetWordFromCfg(928041066)
				local var_274_4 = arg_271_1:FormatText(var_274_3.content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 24
				local var_274_6 = utf8.len(var_274_4)
				local var_274_7 = var_274_5 <= 0 and var_274_1 or var_274_1 * (var_274_6 / var_274_5)

				if var_274_7 > 0 and var_274_1 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_4
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041066", "story_v_side_old_928041.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041066", "story_v_side_old_928041.awb") / 1000

					if var_274_8 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_0
					end

					if var_274_3.prefab_name ~= "" and arg_271_1.actors_[var_274_3.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_3.prefab_name].transform, "story_v_side_old_928041", "928041066", "story_v_side_old_928041.awb")

						arg_271_1:RecordAudio("928041066", var_274_9)
						arg_271_1:RecordAudio("928041066", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041066", "story_v_side_old_928041.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041066", "story_v_side_old_928041.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_10 and arg_271_1.time_ < var_274_0 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play928041067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 928041067
		arg_275_1.duration_ = 6.87

		local var_275_0 = {
			zh = 4,
			ja = 6.866
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play928041068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 0.575

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_2 = arg_275_1:FormatText(StoryNameCfg[1377].name)

				arg_275_1.leftNameTxt_.text = var_278_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:GetWordFromCfg(928041067)
				local var_278_4 = arg_275_1:FormatText(var_278_3.content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 23
				local var_278_6 = utf8.len(var_278_4)
				local var_278_7 = var_278_5 <= 0 and var_278_1 or var_278_1 * (var_278_6 / var_278_5)

				if var_278_7 > 0 and var_278_1 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041067", "story_v_side_old_928041.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041067", "story_v_side_old_928041.awb") / 1000

					if var_278_8 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_0
					end

					if var_278_3.prefab_name ~= "" and arg_275_1.actors_[var_278_3.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_3.prefab_name].transform, "story_v_side_old_928041", "928041067", "story_v_side_old_928041.awb")

						arg_275_1:RecordAudio("928041067", var_278_9)
						arg_275_1:RecordAudio("928041067", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041067", "story_v_side_old_928041.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041067", "story_v_side_old_928041.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_10 and arg_275_1.time_ < var_278_0 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play928041068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 928041068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play928041069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0
			local var_282_1 = 0.35

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_2 = arg_279_1:FormatText(StoryNameCfg[7].name)

				arg_279_1.leftNameTxt_.text = var_282_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_3 = arg_279_1:GetWordFromCfg(928041068)
				local var_282_4 = arg_279_1:FormatText(var_282_3.content)

				arg_279_1.text_.text = var_282_4

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 14
				local var_282_6 = utf8.len(var_282_4)
				local var_282_7 = var_282_5 <= 0 and var_282_1 or var_282_1 * (var_282_6 / var_282_5)

				if var_282_7 > 0 and var_282_1 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_0
					end
				end

				arg_279_1.text_.text = var_282_4
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_8 = math.max(var_282_1, arg_279_1.talkMaxDuration)

			if var_282_0 <= arg_279_1.time_ and arg_279_1.time_ < var_282_0 + var_282_8 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_0) / var_282_8

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_0 + var_282_8 and arg_279_1.time_ < var_282_0 + var_282_8 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play928041069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 928041069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play928041070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 0.3

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				local var_286_2 = "play"
				local var_286_3 = "music"

				arg_283_1:AudioAction(var_286_2, var_286_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_286_4 = ""
				local var_286_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_286_5 ~= "" then
					if arg_283_1.bgmTxt_.text ~= var_286_5 and arg_283_1.bgmTxt_.text ~= "" then
						if arg_283_1.bgmTxt2_.text ~= "" then
							arg_283_1.bgmTxt_.text = arg_283_1.bgmTxt2_.text
						end

						arg_283_1.bgmTxt2_.text = var_286_5

						arg_283_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_283_1.bgmTxt_.text = var_286_5
						arg_283_1.bgmTxt2_.text = var_286_5
					end

					if arg_283_1.bgmTimer then
						arg_283_1.bgmTimer:Stop()

						arg_283_1.bgmTimer = nil
					end

					if arg_283_1.settingData.show_music_name == 1 then
						arg_283_1.musicController:SetSelectedState("show")
						arg_283_1.musicAnimator_:Play("open", 0, 0)

						if arg_283_1.settingData.music_time ~= 0 then
							arg_283_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_283_1.settingData.music_time), function()
								if arg_283_1 == nil or isNil(arg_283_1.bgmTxt_) then
									return
								end

								arg_283_1.musicController:SetSelectedState("hide")
								arg_283_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_286_6 = 0
			local var_286_7 = 0.5

			if var_286_6 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_8 = arg_283_1:FormatText(StoryNameCfg[7].name)

				arg_283_1.leftNameTxt_.text = var_286_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_9 = arg_283_1:GetWordFromCfg(928041069)
				local var_286_10 = arg_283_1:FormatText(var_286_9.content)

				arg_283_1.text_.text = var_286_10

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 20
				local var_286_12 = utf8.len(var_286_10)
				local var_286_13 = var_286_11 <= 0 and var_286_7 or var_286_7 * (var_286_12 / var_286_11)

				if var_286_13 > 0 and var_286_7 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_10
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_14 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_14 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_14

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_14 and arg_283_1.time_ < var_286_6 + var_286_14 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play928041070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 928041070
		arg_288_1.duration_ = 8.07

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play928041071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = "X205_a"

			if arg_288_1.bgs_[var_291_0] == nil then
				local var_291_1 = Object.Instantiate(arg_288_1.paintGo_)

				var_291_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_291_0)
				var_291_1.name = var_291_0
				var_291_1.transform.parent = arg_288_1.stage_.transform
				var_291_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_288_1.bgs_[var_291_0] = var_291_1
			end

			local var_291_2 = 1.3

			if var_291_2 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				local var_291_3 = manager.ui.mainCamera.transform.localPosition
				local var_291_4 = Vector3.New(0, 0, 10) + Vector3.New(var_291_3.x, var_291_3.y, 0)
				local var_291_5 = arg_288_1.bgs_.X205_a

				var_291_5.transform.localPosition = var_291_4
				var_291_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_291_6 = var_291_5:GetComponent("SpriteRenderer")

				if var_291_6 and var_291_6.sprite then
					local var_291_7 = (var_291_5.transform.localPosition - var_291_3).z
					local var_291_8 = manager.ui.mainCameraCom_
					local var_291_9 = 2 * var_291_7 * Mathf.Tan(var_291_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_291_10 = var_291_9 * var_291_8.aspect
					local var_291_11 = var_291_6.sprite.bounds.size.x
					local var_291_12 = var_291_6.sprite.bounds.size.y
					local var_291_13 = var_291_10 / var_291_11
					local var_291_14 = var_291_9 / var_291_12
					local var_291_15 = var_291_14 < var_291_13 and var_291_13 or var_291_14

					var_291_5.transform.localScale = Vector3.New(var_291_15, var_291_15, 0)
				end

				for iter_291_0, iter_291_1 in pairs(arg_288_1.bgs_) do
					if iter_291_0 ~= "X205_a" then
						iter_291_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_291_16 = 0

			if var_291_16 < arg_288_1.time_ and arg_288_1.time_ <= var_291_16 + arg_291_0 then
				arg_288_1.allBtn_.enabled = false
			end

			local var_291_17 = 0.3

			if arg_288_1.time_ >= var_291_16 + var_291_17 and arg_288_1.time_ < var_291_16 + var_291_17 + arg_291_0 then
				arg_288_1.allBtn_.enabled = true
			end

			local var_291_18 = 0

			if var_291_18 < arg_288_1.time_ and arg_288_1.time_ <= var_291_18 + arg_291_0 then
				arg_288_1.mask_.enabled = true
				arg_288_1.mask_.raycastTarget = true

				arg_288_1:SetGaussion(false)
			end

			local var_291_19 = 1.3

			if var_291_18 <= arg_288_1.time_ and arg_288_1.time_ < var_291_18 + var_291_19 then
				local var_291_20 = (arg_288_1.time_ - var_291_18) / var_291_19
				local var_291_21 = Color.New(0, 0, 0)

				var_291_21.a = Mathf.Lerp(0, 1, var_291_20)
				arg_288_1.mask_.color = var_291_21
			end

			if arg_288_1.time_ >= var_291_18 + var_291_19 and arg_288_1.time_ < var_291_18 + var_291_19 + arg_291_0 then
				local var_291_22 = Color.New(0, 0, 0)

				var_291_22.a = 1
				arg_288_1.mask_.color = var_291_22
			end

			local var_291_23 = 1.3

			if var_291_23 < arg_288_1.time_ and arg_288_1.time_ <= var_291_23 + arg_291_0 then
				arg_288_1.mask_.enabled = true
				arg_288_1.mask_.raycastTarget = true

				arg_288_1:SetGaussion(false)
			end

			local var_291_24 = 2

			if var_291_23 <= arg_288_1.time_ and arg_288_1.time_ < var_291_23 + var_291_24 then
				local var_291_25 = (arg_288_1.time_ - var_291_23) / var_291_24
				local var_291_26 = Color.New(0, 0, 0)

				var_291_26.a = Mathf.Lerp(1, 0, var_291_25)
				arg_288_1.mask_.color = var_291_26
			end

			if arg_288_1.time_ >= var_291_23 + var_291_24 and arg_288_1.time_ < var_291_23 + var_291_24 + arg_291_0 then
				local var_291_27 = Color.New(0, 0, 0)
				local var_291_28 = 0

				arg_288_1.mask_.enabled = false
				var_291_27.a = var_291_28
				arg_288_1.mask_.color = var_291_27
			end

			local var_291_29 = 0.133333333333333
			local var_291_30 = 1

			if var_291_29 < arg_288_1.time_ and arg_288_1.time_ <= var_291_29 + arg_291_0 then
				local var_291_31 = "stop"
				local var_291_32 = "effect"

				arg_288_1:AudioAction(var_291_31, var_291_32, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_291_33 = 0.933333333333333
			local var_291_34 = 1

			if var_291_33 < arg_288_1.time_ and arg_288_1.time_ <= var_291_33 + arg_291_0 then
				local var_291_35 = "play"
				local var_291_36 = "effect"

				arg_288_1:AudioAction(var_291_35, var_291_36, "se_story_145", "se_story_145_amb_theater", "")
			end

			local var_291_37 = 0.133333333333333
			local var_291_38 = 0.3

			if var_291_37 < arg_288_1.time_ and arg_288_1.time_ <= var_291_37 + arg_291_0 then
				local var_291_39 = "play"
				local var_291_40 = "music"

				arg_288_1:AudioAction(var_291_39, var_291_40, "ui_battle", "ui_battle_stopbgm", "")

				local var_291_41 = ""
				local var_291_42 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_291_42 ~= "" then
					if arg_288_1.bgmTxt_.text ~= var_291_42 and arg_288_1.bgmTxt_.text ~= "" then
						if arg_288_1.bgmTxt2_.text ~= "" then
							arg_288_1.bgmTxt_.text = arg_288_1.bgmTxt2_.text
						end

						arg_288_1.bgmTxt2_.text = var_291_42

						arg_288_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_288_1.bgmTxt_.text = var_291_42
						arg_288_1.bgmTxt2_.text = var_291_42
					end

					if arg_288_1.bgmTimer then
						arg_288_1.bgmTimer:Stop()

						arg_288_1.bgmTimer = nil
					end

					if arg_288_1.settingData.show_music_name == 1 then
						arg_288_1.musicController:SetSelectedState("show")
						arg_288_1.musicAnimator_:Play("open", 0, 0)

						if arg_288_1.settingData.music_time ~= 0 then
							arg_288_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_288_1.settingData.music_time), function()
								if arg_288_1 == nil or isNil(arg_288_1.bgmTxt_) then
									return
								end

								arg_288_1.musicController:SetSelectedState("hide")
								arg_288_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_291_43 = 0.933333333333333
			local var_291_44 = 1

			if var_291_43 < arg_288_1.time_ and arg_288_1.time_ <= var_291_43 + arg_291_0 then
				local var_291_45 = "play"
				local var_291_46 = "music"

				arg_288_1:AudioAction(var_291_45, var_291_46, "bgm_activity_4_5_scene_108502_room", "bgm_activity_4_5_scene_108502_room", "bgm_activity_4_5_scene_108502_room.awb")

				local var_291_47 = ""
				local var_291_48 = manager.audio:GetAudioName("bgm_activity_4_5_scene_108502_room", "bgm_activity_4_5_scene_108502_room")

				if var_291_48 ~= "" then
					if arg_288_1.bgmTxt_.text ~= var_291_48 and arg_288_1.bgmTxt_.text ~= "" then
						if arg_288_1.bgmTxt2_.text ~= "" then
							arg_288_1.bgmTxt_.text = arg_288_1.bgmTxt2_.text
						end

						arg_288_1.bgmTxt2_.text = var_291_48

						arg_288_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_288_1.bgmTxt_.text = var_291_48
						arg_288_1.bgmTxt2_.text = var_291_48
					end

					if arg_288_1.bgmTimer then
						arg_288_1.bgmTimer:Stop()

						arg_288_1.bgmTimer = nil
					end

					if arg_288_1.settingData.show_music_name == 1 then
						arg_288_1.musicController:SetSelectedState("show")
						arg_288_1.musicAnimator_:Play("open", 0, 0)

						if arg_288_1.settingData.music_time ~= 0 then
							arg_288_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_288_1.settingData.music_time), function()
								if arg_288_1 == nil or isNil(arg_288_1.bgmTxt_) then
									return
								end

								arg_288_1.musicController:SetSelectedState("hide")
								arg_288_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_288_1.frameCnt_ <= 1 then
				arg_288_1.dialog_:SetActive(false)
			end

			local var_291_49 = 3.06666666666667
			local var_291_50 = 0.6

			if var_291_49 < arg_288_1.time_ and arg_288_1.time_ <= var_291_49 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0

				arg_288_1.dialog_:SetActive(true)

				arg_288_1.dialogCg_.alpha = 0

				local var_291_51 = LeanTween.value(arg_288_1.dialog_, 0, 1, 0.3)

				var_291_51:setOnUpdate(LuaHelper.FloatAction(function(arg_294_0)
					arg_288_1.dialogCg_.alpha = arg_294_0
				end))
				var_291_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_288_1.dialog_)
					var_291_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_288_1.duration_ = arg_288_1.duration_ + 0.3

				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_52 = arg_288_1:FormatText(StoryNameCfg[7].name)

				arg_288_1.leftNameTxt_.text = var_291_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_53 = arg_288_1:GetWordFromCfg(928041070)
				local var_291_54 = arg_288_1:FormatText(var_291_53.content)

				arg_288_1.text_.text = var_291_54

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_55 = 24
				local var_291_56 = utf8.len(var_291_54)
				local var_291_57 = var_291_55 <= 0 and var_291_50 or var_291_50 * (var_291_56 / var_291_55)

				if var_291_57 > 0 and var_291_50 < var_291_57 then
					arg_288_1.talkMaxDuration = var_291_57
					var_291_49 = var_291_49 + 0.3

					if var_291_57 + var_291_49 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_57 + var_291_49
					end
				end

				arg_288_1.text_.text = var_291_54
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_58 = var_291_49 + 0.3
			local var_291_59 = math.max(var_291_50, arg_288_1.talkMaxDuration)

			if var_291_58 <= arg_288_1.time_ and arg_288_1.time_ < var_291_58 + var_291_59 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_58) / var_291_59

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_58 + var_291_59 and arg_288_1.time_ < var_291_58 + var_291_59 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play928041071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 928041071
		arg_296_1.duration_ = 8.37

		local var_296_0 = {
			zh = 8.366,
			ja = 7.433
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play928041072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0
			local var_299_1 = 0.85

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_2 = arg_296_1:FormatText(StoryNameCfg[1160].name)

				arg_296_1.leftNameTxt_.text = var_299_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_3 = arg_296_1:GetWordFromCfg(928041071)
				local var_299_4 = arg_296_1:FormatText(var_299_3.content)

				arg_296_1.text_.text = var_299_4

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 34
				local var_299_6 = utf8.len(var_299_4)
				local var_299_7 = var_299_5 <= 0 and var_299_1 or var_299_1 * (var_299_6 / var_299_5)

				if var_299_7 > 0 and var_299_1 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_0
					end
				end

				arg_296_1.text_.text = var_299_4
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041071", "story_v_side_old_928041.awb") ~= 0 then
					local var_299_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041071", "story_v_side_old_928041.awb") / 1000

					if var_299_8 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_8 + var_299_0
					end

					if var_299_3.prefab_name ~= "" and arg_296_1.actors_[var_299_3.prefab_name] ~= nil then
						local var_299_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_3.prefab_name].transform, "story_v_side_old_928041", "928041071", "story_v_side_old_928041.awb")

						arg_296_1:RecordAudio("928041071", var_299_9)
						arg_296_1:RecordAudio("928041071", var_299_9)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041071", "story_v_side_old_928041.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041071", "story_v_side_old_928041.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_10 = math.max(var_299_1, arg_296_1.talkMaxDuration)

			if var_299_0 <= arg_296_1.time_ and arg_296_1.time_ < var_299_0 + var_299_10 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_0) / var_299_10

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_0 + var_299_10 and arg_296_1.time_ < var_299_0 + var_299_10 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play928041072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 928041072
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play928041073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 0.8

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_2 = arg_300_1:GetWordFromCfg(928041072)
				local var_303_3 = arg_300_1:FormatText(var_303_2.content)

				arg_300_1.text_.text = var_303_3

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 32
				local var_303_5 = utf8.len(var_303_3)
				local var_303_6 = var_303_4 <= 0 and var_303_1 or var_303_1 * (var_303_5 / var_303_4)

				if var_303_6 > 0 and var_303_1 < var_303_6 then
					arg_300_1.talkMaxDuration = var_303_6

					if var_303_6 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_3
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_7 and arg_300_1.time_ < var_303_0 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play928041073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 928041073
		arg_304_1.duration_ = 13.17

		local var_304_0 = {
			zh = 10.2,
			ja = 13.166
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play928041074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 0.85

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_2 = arg_304_1:FormatText(StoryNameCfg[1160].name)

				arg_304_1.leftNameTxt_.text = var_307_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_3 = arg_304_1:GetWordFromCfg(928041073)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 33
				local var_307_6 = utf8.len(var_307_4)
				local var_307_7 = var_307_5 <= 0 and var_307_1 or var_307_1 * (var_307_6 / var_307_5)

				if var_307_7 > 0 and var_307_1 < var_307_7 then
					arg_304_1.talkMaxDuration = var_307_7

					if var_307_7 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_4
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041073", "story_v_side_old_928041.awb") ~= 0 then
					local var_307_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041073", "story_v_side_old_928041.awb") / 1000

					if var_307_8 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_8 + var_307_0
					end

					if var_307_3.prefab_name ~= "" and arg_304_1.actors_[var_307_3.prefab_name] ~= nil then
						local var_307_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_3.prefab_name].transform, "story_v_side_old_928041", "928041073", "story_v_side_old_928041.awb")

						arg_304_1:RecordAudio("928041073", var_307_9)
						arg_304_1:RecordAudio("928041073", var_307_9)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041073", "story_v_side_old_928041.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041073", "story_v_side_old_928041.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_10 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_10 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_10

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_10 and arg_304_1.time_ < var_307_0 + var_307_10 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play928041074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 928041074
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play928041075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0
			local var_311_1 = 0.5

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_2 = arg_308_1:FormatText(StoryNameCfg[7].name)

				arg_308_1.leftNameTxt_.text = var_311_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_3 = arg_308_1:GetWordFromCfg(928041074)
				local var_311_4 = arg_308_1:FormatText(var_311_3.content)

				arg_308_1.text_.text = var_311_4

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_5 = 20
				local var_311_6 = utf8.len(var_311_4)
				local var_311_7 = var_311_5 <= 0 and var_311_1 or var_311_1 * (var_311_6 / var_311_5)

				if var_311_7 > 0 and var_311_1 < var_311_7 then
					arg_308_1.talkMaxDuration = var_311_7

					if var_311_7 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_7 + var_311_0
					end
				end

				arg_308_1.text_.text = var_311_4
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_8 = math.max(var_311_1, arg_308_1.talkMaxDuration)

			if var_311_0 <= arg_308_1.time_ and arg_308_1.time_ < var_311_0 + var_311_8 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_0) / var_311_8

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_0 + var_311_8 and arg_308_1.time_ < var_311_0 + var_311_8 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play928041075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 928041075
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play928041076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0
			local var_315_1 = 0.475

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_2 = arg_312_1:FormatText(StoryNameCfg[7].name)

				arg_312_1.leftNameTxt_.text = var_315_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_3 = arg_312_1:GetWordFromCfg(928041075)
				local var_315_4 = arg_312_1:FormatText(var_315_3.content)

				arg_312_1.text_.text = var_315_4

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_5 = 19
				local var_315_6 = utf8.len(var_315_4)
				local var_315_7 = var_315_5 <= 0 and var_315_1 or var_315_1 * (var_315_6 / var_315_5)

				if var_315_7 > 0 and var_315_1 < var_315_7 then
					arg_312_1.talkMaxDuration = var_315_7

					if var_315_7 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_7 + var_315_0
					end
				end

				arg_312_1.text_.text = var_315_4
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_8 = math.max(var_315_1, arg_312_1.talkMaxDuration)

			if var_315_0 <= arg_312_1.time_ and arg_312_1.time_ < var_315_0 + var_315_8 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_0) / var_315_8

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_0 + var_315_8 and arg_312_1.time_ < var_315_0 + var_315_8 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play928041076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 928041076
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play928041077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.825

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_2 = arg_316_1:GetWordFromCfg(928041076)
				local var_319_3 = arg_316_1:FormatText(var_319_2.content)

				arg_316_1.text_.text = var_319_3

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 33
				local var_319_5 = utf8.len(var_319_3)
				local var_319_6 = var_319_4 <= 0 and var_319_1 or var_319_1 * (var_319_5 / var_319_4)

				if var_319_6 > 0 and var_319_1 < var_319_6 then
					arg_316_1.talkMaxDuration = var_319_6

					if var_319_6 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_6 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_3
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_7 and arg_316_1.time_ < var_319_0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play928041077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 928041077
		arg_320_1.duration_ = 12.73

		local var_320_0 = {
			zh = 6.933,
			ja = 12.733
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play928041078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 0.5

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_2 = arg_320_1:FormatText(StoryNameCfg[1160].name)

				arg_320_1.leftNameTxt_.text = var_323_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_3 = arg_320_1:GetWordFromCfg(928041077)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 20
				local var_323_6 = utf8.len(var_323_4)
				local var_323_7 = var_323_5 <= 0 and var_323_1 or var_323_1 * (var_323_6 / var_323_5)

				if var_323_7 > 0 and var_323_1 < var_323_7 then
					arg_320_1.talkMaxDuration = var_323_7

					if var_323_7 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041077", "story_v_side_old_928041.awb") ~= 0 then
					local var_323_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041077", "story_v_side_old_928041.awb") / 1000

					if var_323_8 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_8 + var_323_0
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_side_old_928041", "928041077", "story_v_side_old_928041.awb")

						arg_320_1:RecordAudio("928041077", var_323_9)
						arg_320_1:RecordAudio("928041077", var_323_9)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041077", "story_v_side_old_928041.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041077", "story_v_side_old_928041.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_10 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_10 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_10

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_10 and arg_320_1.time_ < var_323_0 + var_323_10 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play928041078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 928041078
		arg_324_1.duration_ = 7.83

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play928041079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = "X205_c"

			if arg_324_1.bgs_[var_327_0] == nil then
				local var_327_1 = Object.Instantiate(arg_324_1.paintGo_)

				var_327_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_327_0)
				var_327_1.name = var_327_0
				var_327_1.transform.parent = arg_324_1.stage_.transform
				var_327_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_324_1.bgs_[var_327_0] = var_327_1
			end

			local var_327_2 = 1.5

			if var_327_2 < arg_324_1.time_ and arg_324_1.time_ <= var_327_2 + arg_327_0 then
				local var_327_3 = manager.ui.mainCamera.transform.localPosition
				local var_327_4 = Vector3.New(0, 0, 10) + Vector3.New(var_327_3.x, var_327_3.y, 0)
				local var_327_5 = arg_324_1.bgs_.X205_c

				var_327_5.transform.localPosition = var_327_4
				var_327_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_327_6 = var_327_5:GetComponent("SpriteRenderer")

				if var_327_6 and var_327_6.sprite then
					local var_327_7 = (var_327_5.transform.localPosition - var_327_3).z
					local var_327_8 = manager.ui.mainCameraCom_
					local var_327_9 = 2 * var_327_7 * Mathf.Tan(var_327_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_327_10 = var_327_9 * var_327_8.aspect
					local var_327_11 = var_327_6.sprite.bounds.size.x
					local var_327_12 = var_327_6.sprite.bounds.size.y
					local var_327_13 = var_327_10 / var_327_11
					local var_327_14 = var_327_9 / var_327_12
					local var_327_15 = var_327_14 < var_327_13 and var_327_13 or var_327_14

					var_327_5.transform.localScale = Vector3.New(var_327_15, var_327_15, 0)
				end

				for iter_327_0, iter_327_1 in pairs(arg_324_1.bgs_) do
					if iter_327_0 ~= "X205_c" then
						iter_327_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_327_16 = 0

			if var_327_16 < arg_324_1.time_ and arg_324_1.time_ <= var_327_16 + arg_327_0 then
				arg_324_1.allBtn_.enabled = false
			end

			local var_327_17 = 0.3

			if arg_324_1.time_ >= var_327_16 + var_327_17 and arg_324_1.time_ < var_327_16 + var_327_17 + arg_327_0 then
				arg_324_1.allBtn_.enabled = true
			end

			local var_327_18 = 0

			if var_327_18 < arg_324_1.time_ and arg_324_1.time_ <= var_327_18 + arg_327_0 then
				arg_324_1.mask_.enabled = true
				arg_324_1.mask_.raycastTarget = true

				arg_324_1:SetGaussion(false)
			end

			local var_327_19 = 1.5

			if var_327_18 <= arg_324_1.time_ and arg_324_1.time_ < var_327_18 + var_327_19 then
				local var_327_20 = (arg_324_1.time_ - var_327_18) / var_327_19
				local var_327_21 = Color.New(0, 0, 0)

				var_327_21.a = Mathf.Lerp(0, 1, var_327_20)
				arg_324_1.mask_.color = var_327_21
			end

			if arg_324_1.time_ >= var_327_18 + var_327_19 and arg_324_1.time_ < var_327_18 + var_327_19 + arg_327_0 then
				local var_327_22 = Color.New(0, 0, 0)

				var_327_22.a = 1
				arg_324_1.mask_.color = var_327_22
			end

			local var_327_23 = 1.5

			if var_327_23 < arg_324_1.time_ and arg_324_1.time_ <= var_327_23 + arg_327_0 then
				arg_324_1.mask_.enabled = true
				arg_324_1.mask_.raycastTarget = true

				arg_324_1:SetGaussion(false)
			end

			local var_327_24 = 1.53333333333333

			if var_327_23 <= arg_324_1.time_ and arg_324_1.time_ < var_327_23 + var_327_24 then
				local var_327_25 = (arg_324_1.time_ - var_327_23) / var_327_24
				local var_327_26 = Color.New(0, 0, 0)

				var_327_26.a = Mathf.Lerp(1, 0, var_327_25)
				arg_324_1.mask_.color = var_327_26
			end

			if arg_324_1.time_ >= var_327_23 + var_327_24 and arg_324_1.time_ < var_327_23 + var_327_24 + arg_327_0 then
				local var_327_27 = Color.New(0, 0, 0)
				local var_327_28 = 0

				arg_324_1.mask_.enabled = false
				var_327_27.a = var_327_28
				arg_324_1.mask_.color = var_327_27
			end

			local var_327_29 = 0.1
			local var_327_30 = 1

			if var_327_29 < arg_324_1.time_ and arg_324_1.time_ <= var_327_29 + arg_327_0 then
				local var_327_31 = "stop"
				local var_327_32 = "effect"

				arg_324_1:AudioAction(var_327_31, var_327_32, "se_story_145", "se_story_145_amb_theater", "")
			end

			local var_327_33 = 1.1
			local var_327_34 = 1

			if var_327_33 < arg_324_1.time_ and arg_324_1.time_ <= var_327_33 + arg_327_0 then
				local var_327_35 = "play"
				local var_327_36 = "effect"

				arg_324_1:AudioAction(var_327_35, var_327_36, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_324_1.frameCnt_ <= 1 then
				arg_324_1.dialog_:SetActive(false)
			end

			local var_327_37 = 2.83333333333333
			local var_327_38 = 1.125

			if var_327_37 < arg_324_1.time_ and arg_324_1.time_ <= var_327_37 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0

				arg_324_1.dialog_:SetActive(true)

				arg_324_1.dialogCg_.alpha = 0

				local var_327_39 = LeanTween.value(arg_324_1.dialog_, 0, 1, 0.3)

				var_327_39:setOnUpdate(LuaHelper.FloatAction(function(arg_328_0)
					arg_324_1.dialogCg_.alpha = arg_328_0
				end))
				var_327_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_324_1.dialog_)
					var_327_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_324_1.duration_ = arg_324_1.duration_ + 0.3

				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_40 = arg_324_1:GetWordFromCfg(928041078)
				local var_327_41 = arg_324_1:FormatText(var_327_40.content)

				arg_324_1.text_.text = var_327_41

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_42 = 45
				local var_327_43 = utf8.len(var_327_41)
				local var_327_44 = var_327_42 <= 0 and var_327_38 or var_327_38 * (var_327_43 / var_327_42)

				if var_327_44 > 0 and var_327_38 < var_327_44 then
					arg_324_1.talkMaxDuration = var_327_44
					var_327_37 = var_327_37 + 0.3

					if var_327_44 + var_327_37 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_44 + var_327_37
					end
				end

				arg_324_1.text_.text = var_327_41
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_45 = var_327_37 + 0.3
			local var_327_46 = math.max(var_327_38, arg_324_1.talkMaxDuration)

			if var_327_45 <= arg_324_1.time_ and arg_324_1.time_ < var_327_45 + var_327_46 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_45) / var_327_46

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_45 + var_327_46 and arg_324_1.time_ < var_327_45 + var_327_46 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play928041079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 928041079
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play928041080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.3

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_2 = arg_330_1:FormatText(StoryNameCfg[7].name)

				arg_330_1.leftNameTxt_.text = var_333_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_3 = arg_330_1:GetWordFromCfg(928041079)
				local var_333_4 = arg_330_1:FormatText(var_333_3.content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 12
				local var_333_6 = utf8.len(var_333_4)
				local var_333_7 = var_333_5 <= 0 and var_333_1 or var_333_1 * (var_333_6 / var_333_5)

				if var_333_7 > 0 and var_333_1 < var_333_7 then
					arg_330_1.talkMaxDuration = var_333_7

					if var_333_7 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_4
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_8 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_8 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_8

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_8 and arg_330_1.time_ < var_333_0 + var_333_8 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play928041080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 928041080
		arg_334_1.duration_ = 7.8

		local var_334_0 = {
			zh = 6.4,
			ja = 7.8
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play928041081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = "108502ui_story"

			if arg_334_1.actors_[var_337_0] == nil then
				local var_337_1 = Asset.Load("Char/" .. "108502ui_story")

				if not isNil(var_337_1) then
					local var_337_2 = Object.Instantiate(Asset.Load("Char/" .. "108502ui_story"), arg_334_1.stage_.transform)

					var_337_2.name = var_337_0
					var_337_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_334_1.actors_[var_337_0] = var_337_2

					local var_337_3 = var_337_2:GetComponentInChildren(typeof(CharacterEffect))

					var_337_3.enabled = true

					local var_337_4 = GameObjectTools.GetOrAddComponent(var_337_2, typeof(DynamicBoneHelper))

					if var_337_4 then
						var_337_4:EnableDynamicBone(false)
					end

					arg_334_1:ShowWeapon(var_337_3.transform, false)

					arg_334_1.var_[var_337_0 .. "Animator"] = var_337_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_334_1.var_[var_337_0 .. "Animator"].applyRootMotion = true
					arg_334_1.var_[var_337_0 .. "LipSync"] = var_337_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_337_5 = arg_334_1.actors_["108502ui_story"].transform
			local var_337_6 = 0

			if var_337_6 < arg_334_1.time_ and arg_334_1.time_ <= var_337_6 + arg_337_0 then
				arg_334_1.var_.moveOldPos108502ui_story = var_337_5.localPosition
			end

			local var_337_7 = 0.001

			if var_337_6 <= arg_334_1.time_ and arg_334_1.time_ < var_337_6 + var_337_7 then
				local var_337_8 = (arg_334_1.time_ - var_337_6) / var_337_7
				local var_337_9 = Vector3.New(0, -1.01, -5.83)

				var_337_5.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos108502ui_story, var_337_9, var_337_8)

				local var_337_10 = manager.ui.mainCamera.transform.position - var_337_5.position

				var_337_5.forward = Vector3.New(var_337_10.x, var_337_10.y, var_337_10.z)

				local var_337_11 = var_337_5.localEulerAngles

				var_337_11.z = 0
				var_337_11.x = 0
				var_337_5.localEulerAngles = var_337_11
			end

			if arg_334_1.time_ >= var_337_6 + var_337_7 and arg_334_1.time_ < var_337_6 + var_337_7 + arg_337_0 then
				var_337_5.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_337_12 = manager.ui.mainCamera.transform.position - var_337_5.position

				var_337_5.forward = Vector3.New(var_337_12.x, var_337_12.y, var_337_12.z)

				local var_337_13 = var_337_5.localEulerAngles

				var_337_13.z = 0
				var_337_13.x = 0
				var_337_5.localEulerAngles = var_337_13
			end

			local var_337_14 = arg_334_1.actors_["108502ui_story"]
			local var_337_15 = 0

			if var_337_15 < arg_334_1.time_ and arg_334_1.time_ <= var_337_15 + arg_337_0 and not isNil(var_337_14) and arg_334_1.var_.characterEffect108502ui_story == nil then
				arg_334_1.var_.characterEffect108502ui_story = var_337_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_16 = 0.200000002980232

			if var_337_15 <= arg_334_1.time_ and arg_334_1.time_ < var_337_15 + var_337_16 and not isNil(var_337_14) then
				local var_337_17 = (arg_334_1.time_ - var_337_15) / var_337_16

				if arg_334_1.var_.characterEffect108502ui_story and not isNil(var_337_14) then
					arg_334_1.var_.characterEffect108502ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= var_337_15 + var_337_16 and arg_334_1.time_ < var_337_15 + var_337_16 + arg_337_0 and not isNil(var_337_14) and arg_334_1.var_.characterEffect108502ui_story then
				arg_334_1.var_.characterEffect108502ui_story.fillFlat = false
			end

			local var_337_18 = 0

			if var_337_18 < arg_334_1.time_ and arg_334_1.time_ <= var_337_18 + arg_337_0 then
				arg_334_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/story108502/story108502action/108502action3_1")
			end

			local var_337_19 = 0

			if var_337_19 < arg_334_1.time_ and arg_334_1.time_ <= var_337_19 + arg_337_0 then
				arg_334_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_337_20 = arg_334_1.actors_["1085ui_story"].transform
			local var_337_21 = 0

			if var_337_21 < arg_334_1.time_ and arg_334_1.time_ <= var_337_21 + arg_337_0 then
				arg_334_1.var_.moveOldPos1085ui_story = var_337_20.localPosition
			end

			local var_337_22 = 0.001

			if var_337_21 <= arg_334_1.time_ and arg_334_1.time_ < var_337_21 + var_337_22 then
				local var_337_23 = (arg_334_1.time_ - var_337_21) / var_337_22
				local var_337_24 = Vector3.New(0, 100, 0)

				var_337_20.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1085ui_story, var_337_24, var_337_23)

				local var_337_25 = manager.ui.mainCamera.transform.position - var_337_20.position

				var_337_20.forward = Vector3.New(var_337_25.x, var_337_25.y, var_337_25.z)

				local var_337_26 = var_337_20.localEulerAngles

				var_337_26.z = 0
				var_337_26.x = 0
				var_337_20.localEulerAngles = var_337_26
			end

			if arg_334_1.time_ >= var_337_21 + var_337_22 and arg_334_1.time_ < var_337_21 + var_337_22 + arg_337_0 then
				var_337_20.localPosition = Vector3.New(0, 100, 0)

				local var_337_27 = manager.ui.mainCamera.transform.position - var_337_20.position

				var_337_20.forward = Vector3.New(var_337_27.x, var_337_27.y, var_337_27.z)

				local var_337_28 = var_337_20.localEulerAngles

				var_337_28.z = 0
				var_337_28.x = 0
				var_337_20.localEulerAngles = var_337_28
			end

			local var_337_29 = 0
			local var_337_30 = 0.45

			if var_337_29 < arg_334_1.time_ and arg_334_1.time_ <= var_337_29 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_31 = arg_334_1:FormatText(StoryNameCfg[328].name)

				arg_334_1.leftNameTxt_.text = var_337_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_32 = arg_334_1:GetWordFromCfg(928041080)
				local var_337_33 = arg_334_1:FormatText(var_337_32.content)

				arg_334_1.text_.text = var_337_33

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_34 = 18
				local var_337_35 = utf8.len(var_337_33)
				local var_337_36 = var_337_34 <= 0 and var_337_30 or var_337_30 * (var_337_35 / var_337_34)

				if var_337_36 > 0 and var_337_30 < var_337_36 then
					arg_334_1.talkMaxDuration = var_337_36

					if var_337_36 + var_337_29 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_36 + var_337_29
					end
				end

				arg_334_1.text_.text = var_337_33
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041080", "story_v_side_old_928041.awb") ~= 0 then
					local var_337_37 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041080", "story_v_side_old_928041.awb") / 1000

					if var_337_37 + var_337_29 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_37 + var_337_29
					end

					if var_337_32.prefab_name ~= "" and arg_334_1.actors_[var_337_32.prefab_name] ~= nil then
						local var_337_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_32.prefab_name].transform, "story_v_side_old_928041", "928041080", "story_v_side_old_928041.awb")

						arg_334_1:RecordAudio("928041080", var_337_38)
						arg_334_1:RecordAudio("928041080", var_337_38)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041080", "story_v_side_old_928041.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041080", "story_v_side_old_928041.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_39 = math.max(var_337_30, arg_334_1.talkMaxDuration)

			if var_337_29 <= arg_334_1.time_ and arg_334_1.time_ < var_337_29 + var_337_39 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_29) / var_337_39

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_29 + var_337_39 and arg_334_1.time_ < var_337_29 + var_337_39 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108502ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play928041081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 928041081
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play928041082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["108502ui_story"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect108502ui_story == nil then
				arg_338_1.var_.characterEffect108502ui_story = var_341_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.characterEffect108502ui_story and not isNil(var_341_0) then
					local var_341_4 = Mathf.Lerp(0, 0.5, var_341_3)

					arg_338_1.var_.characterEffect108502ui_story.fillFlat = true
					arg_338_1.var_.characterEffect108502ui_story.fillRatio = var_341_4
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect108502ui_story then
				local var_341_5 = 0.5

				arg_338_1.var_.characterEffect108502ui_story.fillFlat = true
				arg_338_1.var_.characterEffect108502ui_story.fillRatio = var_341_5
			end

			local var_341_6 = 0
			local var_341_7 = 0.375

			if var_341_6 < arg_338_1.time_ and arg_338_1.time_ <= var_341_6 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_8 = arg_338_1:FormatText(StoryNameCfg[7].name)

				arg_338_1.leftNameTxt_.text = var_341_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_9 = arg_338_1:GetWordFromCfg(928041081)
				local var_341_10 = arg_338_1:FormatText(var_341_9.content)

				arg_338_1.text_.text = var_341_10

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_11 = 15
				local var_341_12 = utf8.len(var_341_10)
				local var_341_13 = var_341_11 <= 0 and var_341_7 or var_341_7 * (var_341_12 / var_341_11)

				if var_341_13 > 0 and var_341_7 < var_341_13 then
					arg_338_1.talkMaxDuration = var_341_13

					if var_341_13 + var_341_6 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_13 + var_341_6
					end
				end

				arg_338_1.text_.text = var_341_10
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_14 = math.max(var_341_7, arg_338_1.talkMaxDuration)

			if var_341_6 <= arg_338_1.time_ and arg_338_1.time_ < var_341_6 + var_341_14 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_6) / var_341_14

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_6 + var_341_14 and arg_338_1.time_ < var_341_6 + var_341_14 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play928041082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 928041082
		arg_342_1.duration_ = 5.07

		local var_342_0 = {
			zh = 5.066,
			ja = 4.9
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play928041083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["108502ui_story"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect108502ui_story == nil then
				arg_342_1.var_.characterEffect108502ui_story = var_345_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.characterEffect108502ui_story and not isNil(var_345_0) then
					arg_342_1.var_.characterEffect108502ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect108502ui_story then
				arg_342_1.var_.characterEffect108502ui_story.fillFlat = false
			end

			local var_345_4 = 0
			local var_345_5 = 0.5

			if var_345_4 < arg_342_1.time_ and arg_342_1.time_ <= var_345_4 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_6 = arg_342_1:FormatText(StoryNameCfg[328].name)

				arg_342_1.leftNameTxt_.text = var_345_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_7 = arg_342_1:GetWordFromCfg(928041082)
				local var_345_8 = arg_342_1:FormatText(var_345_7.content)

				arg_342_1.text_.text = var_345_8

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_9 = 20
				local var_345_10 = utf8.len(var_345_8)
				local var_345_11 = var_345_9 <= 0 and var_345_5 or var_345_5 * (var_345_10 / var_345_9)

				if var_345_11 > 0 and var_345_5 < var_345_11 then
					arg_342_1.talkMaxDuration = var_345_11

					if var_345_11 + var_345_4 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_11 + var_345_4
					end
				end

				arg_342_1.text_.text = var_345_8
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041082", "story_v_side_old_928041.awb") ~= 0 then
					local var_345_12 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041082", "story_v_side_old_928041.awb") / 1000

					if var_345_12 + var_345_4 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_12 + var_345_4
					end

					if var_345_7.prefab_name ~= "" and arg_342_1.actors_[var_345_7.prefab_name] ~= nil then
						local var_345_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_7.prefab_name].transform, "story_v_side_old_928041", "928041082", "story_v_side_old_928041.awb")

						arg_342_1:RecordAudio("928041082", var_345_13)
						arg_342_1:RecordAudio("928041082", var_345_13)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041082", "story_v_side_old_928041.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041082", "story_v_side_old_928041.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_14 = math.max(var_345_5, arg_342_1.talkMaxDuration)

			if var_345_4 <= arg_342_1.time_ and arg_342_1.time_ < var_345_4 + var_345_14 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_4) / var_345_14

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_4 + var_345_14 and arg_342_1.time_ < var_345_4 + var_345_14 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play928041083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 928041083
		arg_346_1.duration_ = 15.47

		local var_346_0 = {
			zh = 7.7,
			ja = 15.466
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play928041084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/story108502/story108502action/108502action3_2")
			end

			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_349_2 = 0
			local var_349_3 = 0.8

			if var_349_2 < arg_346_1.time_ and arg_346_1.time_ <= var_349_2 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_4 = arg_346_1:FormatText(StoryNameCfg[328].name)

				arg_346_1.leftNameTxt_.text = var_349_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_5 = arg_346_1:GetWordFromCfg(928041083)
				local var_349_6 = arg_346_1:FormatText(var_349_5.content)

				arg_346_1.text_.text = var_349_6

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_7 = 32
				local var_349_8 = utf8.len(var_349_6)
				local var_349_9 = var_349_7 <= 0 and var_349_3 or var_349_3 * (var_349_8 / var_349_7)

				if var_349_9 > 0 and var_349_3 < var_349_9 then
					arg_346_1.talkMaxDuration = var_349_9

					if var_349_9 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_9 + var_349_2
					end
				end

				arg_346_1.text_.text = var_349_6
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041083", "story_v_side_old_928041.awb") ~= 0 then
					local var_349_10 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041083", "story_v_side_old_928041.awb") / 1000

					if var_349_10 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_10 + var_349_2
					end

					if var_349_5.prefab_name ~= "" and arg_346_1.actors_[var_349_5.prefab_name] ~= nil then
						local var_349_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_5.prefab_name].transform, "story_v_side_old_928041", "928041083", "story_v_side_old_928041.awb")

						arg_346_1:RecordAudio("928041083", var_349_11)
						arg_346_1:RecordAudio("928041083", var_349_11)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041083", "story_v_side_old_928041.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041083", "story_v_side_old_928041.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_12 = math.max(var_349_3, arg_346_1.talkMaxDuration)

			if var_349_2 <= arg_346_1.time_ and arg_346_1.time_ < var_349_2 + var_349_12 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_2) / var_349_12

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_2 + var_349_12 and arg_346_1.time_ < var_349_2 + var_349_12 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play928041084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 928041084
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play928041085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["108502ui_story"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect108502ui_story == nil then
				arg_350_1.var_.characterEffect108502ui_story = var_353_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.characterEffect108502ui_story and not isNil(var_353_0) then
					local var_353_4 = Mathf.Lerp(0, 0.5, var_353_3)

					arg_350_1.var_.characterEffect108502ui_story.fillFlat = true
					arg_350_1.var_.characterEffect108502ui_story.fillRatio = var_353_4
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect108502ui_story then
				local var_353_5 = 0.5

				arg_350_1.var_.characterEffect108502ui_story.fillFlat = true
				arg_350_1.var_.characterEffect108502ui_story.fillRatio = var_353_5
			end

			local var_353_6 = 0
			local var_353_7 = 0.75

			if var_353_6 < arg_350_1.time_ and arg_350_1.time_ <= var_353_6 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_8 = arg_350_1:GetWordFromCfg(928041084)
				local var_353_9 = arg_350_1:FormatText(var_353_8.content)

				arg_350_1.text_.text = var_353_9

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_10 = 30
				local var_353_11 = utf8.len(var_353_9)
				local var_353_12 = var_353_10 <= 0 and var_353_7 or var_353_7 * (var_353_11 / var_353_10)

				if var_353_12 > 0 and var_353_7 < var_353_12 then
					arg_350_1.talkMaxDuration = var_353_12

					if var_353_12 + var_353_6 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_12 + var_353_6
					end
				end

				arg_350_1.text_.text = var_353_9
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_13 = math.max(var_353_7, arg_350_1.talkMaxDuration)

			if var_353_6 <= arg_350_1.time_ and arg_350_1.time_ < var_353_6 + var_353_13 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_6) / var_353_13

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_6 + var_353_13 and arg_350_1.time_ < var_353_6 + var_353_13 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play928041085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 928041085
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play928041086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0
			local var_357_1 = 0.675

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_2 = arg_354_1:FormatText(StoryNameCfg[7].name)

				arg_354_1.leftNameTxt_.text = var_357_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_3 = arg_354_1:GetWordFromCfg(928041085)
				local var_357_4 = arg_354_1:FormatText(var_357_3.content)

				arg_354_1.text_.text = var_357_4

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 27
				local var_357_6 = utf8.len(var_357_4)
				local var_357_7 = var_357_5 <= 0 and var_357_1 or var_357_1 * (var_357_6 / var_357_5)

				if var_357_7 > 0 and var_357_1 < var_357_7 then
					arg_354_1.talkMaxDuration = var_357_7

					if var_357_7 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_7 + var_357_0
					end
				end

				arg_354_1.text_.text = var_357_4
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_8 = math.max(var_357_1, arg_354_1.talkMaxDuration)

			if var_357_0 <= arg_354_1.time_ and arg_354_1.time_ < var_357_0 + var_357_8 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_0) / var_357_8

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_0 + var_357_8 and arg_354_1.time_ < var_357_0 + var_357_8 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play928041086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 928041086
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play928041087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 0.875

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_2 = arg_358_1:FormatText(StoryNameCfg[7].name)

				arg_358_1.leftNameTxt_.text = var_361_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:GetWordFromCfg(928041086)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 35
				local var_361_6 = utf8.len(var_361_4)
				local var_361_7 = var_361_5 <= 0 and var_361_1 or var_361_1 * (var_361_6 / var_361_5)

				if var_361_7 > 0 and var_361_1 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_0
					end
				end

				arg_358_1.text_.text = var_361_4
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_8 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_8 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_8

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_8 and arg_358_1.time_ < var_361_0 + var_361_8 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play928041087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 928041087
		arg_362_1.duration_ = 12.17

		local var_362_0 = {
			zh = 7.333,
			ja = 12.166
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play928041088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["108502ui_story"]
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect108502ui_story == nil then
				arg_362_1.var_.characterEffect108502ui_story = var_365_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_2 = 0.200000002980232

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 and not isNil(var_365_0) then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2

				if arg_362_1.var_.characterEffect108502ui_story and not isNil(var_365_0) then
					arg_362_1.var_.characterEffect108502ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect108502ui_story then
				arg_362_1.var_.characterEffect108502ui_story.fillFlat = false
			end

			local var_365_4 = 0

			if var_365_4 < arg_362_1.time_ and arg_362_1.time_ <= var_365_4 + arg_365_0 then
				arg_362_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/story108502/story108502action/108502action9_1")
			end

			local var_365_5 = 0

			if var_365_5 < arg_362_1.time_ and arg_362_1.time_ <= var_365_5 + arg_365_0 then
				arg_362_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_365_6 = 0

			if var_365_6 < arg_362_1.time_ and arg_362_1.time_ <= var_365_6 + arg_365_0 then
				arg_362_1.allBtn_.enabled = false
			end

			local var_365_7 = 1.4

			if arg_362_1.time_ >= var_365_6 + var_365_7 and arg_362_1.time_ < var_365_6 + var_365_7 + arg_365_0 then
				arg_362_1.allBtn_.enabled = true
			end

			local var_365_8 = 0
			local var_365_9 = 0.7

			if var_365_8 < arg_362_1.time_ and arg_362_1.time_ <= var_365_8 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_10 = arg_362_1:FormatText(StoryNameCfg[328].name)

				arg_362_1.leftNameTxt_.text = var_365_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_11 = arg_362_1:GetWordFromCfg(928041087)
				local var_365_12 = arg_362_1:FormatText(var_365_11.content)

				arg_362_1.text_.text = var_365_12

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_13 = 28
				local var_365_14 = utf8.len(var_365_12)
				local var_365_15 = var_365_13 <= 0 and var_365_9 or var_365_9 * (var_365_14 / var_365_13)

				if var_365_15 > 0 and var_365_9 < var_365_15 then
					arg_362_1.talkMaxDuration = var_365_15

					if var_365_15 + var_365_8 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_15 + var_365_8
					end
				end

				arg_362_1.text_.text = var_365_12
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041087", "story_v_side_old_928041.awb") ~= 0 then
					local var_365_16 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041087", "story_v_side_old_928041.awb") / 1000

					if var_365_16 + var_365_8 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_16 + var_365_8
					end

					if var_365_11.prefab_name ~= "" and arg_362_1.actors_[var_365_11.prefab_name] ~= nil then
						local var_365_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_11.prefab_name].transform, "story_v_side_old_928041", "928041087", "story_v_side_old_928041.awb")

						arg_362_1:RecordAudio("928041087", var_365_17)
						arg_362_1:RecordAudio("928041087", var_365_17)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041087", "story_v_side_old_928041.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041087", "story_v_side_old_928041.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_18 = math.max(var_365_9, arg_362_1.talkMaxDuration)

			if var_365_8 <= arg_362_1.time_ and arg_362_1.time_ < var_365_8 + var_365_18 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_8) / var_365_18

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_8 + var_365_18 and arg_362_1.time_ < var_365_8 + var_365_18 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play928041088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 928041088
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play928041089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["108502ui_story"]
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect108502ui_story == nil then
				arg_366_1.var_.characterEffect108502ui_story = var_369_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.200000002980232

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 and not isNil(var_369_0) then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2

				if arg_366_1.var_.characterEffect108502ui_story and not isNil(var_369_0) then
					local var_369_4 = Mathf.Lerp(0, 0.5, var_369_3)

					arg_366_1.var_.characterEffect108502ui_story.fillFlat = true
					arg_366_1.var_.characterEffect108502ui_story.fillRatio = var_369_4
				end
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect108502ui_story then
				local var_369_5 = 0.5

				arg_366_1.var_.characterEffect108502ui_story.fillFlat = true
				arg_366_1.var_.characterEffect108502ui_story.fillRatio = var_369_5
			end

			local var_369_6 = 0
			local var_369_7 = 0.9

			if var_369_6 < arg_366_1.time_ and arg_366_1.time_ <= var_369_6 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_8 = arg_366_1:FormatText(StoryNameCfg[7].name)

				arg_366_1.leftNameTxt_.text = var_369_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_9 = arg_366_1:GetWordFromCfg(928041088)
				local var_369_10 = arg_366_1:FormatText(var_369_9.content)

				arg_366_1.text_.text = var_369_10

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_11 = 36
				local var_369_12 = utf8.len(var_369_10)
				local var_369_13 = var_369_11 <= 0 and var_369_7 or var_369_7 * (var_369_12 / var_369_11)

				if var_369_13 > 0 and var_369_7 < var_369_13 then
					arg_366_1.talkMaxDuration = var_369_13

					if var_369_13 + var_369_6 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_13 + var_369_6
					end
				end

				arg_366_1.text_.text = var_369_10
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_14 = math.max(var_369_7, arg_366_1.talkMaxDuration)

			if var_369_6 <= arg_366_1.time_ and arg_366_1.time_ < var_369_6 + var_369_14 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_6) / var_369_14

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_6 + var_369_14 and arg_366_1.time_ < var_369_6 + var_369_14 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play928041089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 928041089
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play928041090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0
			local var_373_1 = 0.625

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_2 = arg_370_1:FormatText(StoryNameCfg[7].name)

				arg_370_1.leftNameTxt_.text = var_373_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_3 = arg_370_1:GetWordFromCfg(928041089)
				local var_373_4 = arg_370_1:FormatText(var_373_3.content)

				arg_370_1.text_.text = var_373_4

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 25
				local var_373_6 = utf8.len(var_373_4)
				local var_373_7 = var_373_5 <= 0 and var_373_1 or var_373_1 * (var_373_6 / var_373_5)

				if var_373_7 > 0 and var_373_1 < var_373_7 then
					arg_370_1.talkMaxDuration = var_373_7

					if var_373_7 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_7 + var_373_0
					end
				end

				arg_370_1.text_.text = var_373_4
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_8 = math.max(var_373_1, arg_370_1.talkMaxDuration)

			if var_373_0 <= arg_370_1.time_ and arg_370_1.time_ < var_373_0 + var_373_8 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_0) / var_373_8

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_0 + var_373_8 and arg_370_1.time_ < var_373_0 + var_373_8 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play928041090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 928041090
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play928041091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["108502ui_story"].transform
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 then
				arg_374_1.var_.moveOldPos108502ui_story = var_377_0.localPosition
			end

			local var_377_2 = 0.001

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2
				local var_377_4 = Vector3.New(0, 100, 0)

				var_377_0.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos108502ui_story, var_377_4, var_377_3)

				local var_377_5 = manager.ui.mainCamera.transform.position - var_377_0.position

				var_377_0.forward = Vector3.New(var_377_5.x, var_377_5.y, var_377_5.z)

				local var_377_6 = var_377_0.localEulerAngles

				var_377_6.z = 0
				var_377_6.x = 0
				var_377_0.localEulerAngles = var_377_6
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 then
				var_377_0.localPosition = Vector3.New(0, 100, 0)

				local var_377_7 = manager.ui.mainCamera.transform.position - var_377_0.position

				var_377_0.forward = Vector3.New(var_377_7.x, var_377_7.y, var_377_7.z)

				local var_377_8 = var_377_0.localEulerAngles

				var_377_8.z = 0
				var_377_8.x = 0
				var_377_0.localEulerAngles = var_377_8
			end

			local var_377_9 = 0
			local var_377_10 = 0.8

			if var_377_9 < arg_374_1.time_ and arg_374_1.time_ <= var_377_9 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0

				arg_374_1.dialog_:SetActive(true)

				arg_374_1.dialogCg_.alpha = 0

				local var_377_11 = LeanTween.value(arg_374_1.dialog_, 0, 1, 0.3)

				var_377_11:setOnUpdate(LuaHelper.FloatAction(function(arg_378_0)
					arg_374_1.dialogCg_.alpha = arg_378_0
				end))
				var_377_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_374_1.dialog_)
					var_377_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_374_1.duration_ = arg_374_1.duration_ + 0.3

				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_12 = arg_374_1:GetWordFromCfg(928041090)
				local var_377_13 = arg_374_1:FormatText(var_377_12.content)

				arg_374_1.text_.text = var_377_13

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_14 = 32
				local var_377_15 = utf8.len(var_377_13)
				local var_377_16 = var_377_14 <= 0 and var_377_10 or var_377_10 * (var_377_15 / var_377_14)

				if var_377_16 > 0 and var_377_10 < var_377_16 then
					arg_374_1.talkMaxDuration = var_377_16
					var_377_9 = var_377_9 + 0.3

					if var_377_16 + var_377_9 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_16 + var_377_9
					end
				end

				arg_374_1.text_.text = var_377_13
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_17 = var_377_9 + 0.3
			local var_377_18 = math.max(var_377_10, arg_374_1.talkMaxDuration)

			if var_377_17 <= arg_374_1.time_ and arg_374_1.time_ < var_377_17 + var_377_18 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_17) / var_377_18

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_17 + var_377_18 and arg_374_1.time_ < var_377_17 + var_377_18 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108502ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play928041091 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 928041091
		arg_380_1.duration_ = 8.33

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play928041092(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = "X205_d"

			if arg_380_1.bgs_[var_383_0] == nil then
				local var_383_1 = Object.Instantiate(arg_380_1.paintGo_)

				var_383_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_383_0)
				var_383_1.name = var_383_0
				var_383_1.transform.parent = arg_380_1.stage_.transform
				var_383_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_380_1.bgs_[var_383_0] = var_383_1
			end

			local var_383_2 = 1.2

			if var_383_2 < arg_380_1.time_ and arg_380_1.time_ <= var_383_2 + arg_383_0 then
				local var_383_3 = manager.ui.mainCamera.transform.localPosition
				local var_383_4 = Vector3.New(0, 0, 10) + Vector3.New(var_383_3.x, var_383_3.y, 0)
				local var_383_5 = arg_380_1.bgs_.X205_d

				var_383_5.transform.localPosition = var_383_4
				var_383_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_383_6 = var_383_5:GetComponent("SpriteRenderer")

				if var_383_6 and var_383_6.sprite then
					local var_383_7 = (var_383_5.transform.localPosition - var_383_3).z
					local var_383_8 = manager.ui.mainCameraCom_
					local var_383_9 = 2 * var_383_7 * Mathf.Tan(var_383_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_383_10 = var_383_9 * var_383_8.aspect
					local var_383_11 = var_383_6.sprite.bounds.size.x
					local var_383_12 = var_383_6.sprite.bounds.size.y
					local var_383_13 = var_383_10 / var_383_11
					local var_383_14 = var_383_9 / var_383_12
					local var_383_15 = var_383_14 < var_383_13 and var_383_13 or var_383_14

					var_383_5.transform.localScale = Vector3.New(var_383_15, var_383_15, 0)
				end

				for iter_383_0, iter_383_1 in pairs(arg_380_1.bgs_) do
					if iter_383_0 ~= "X205_d" then
						iter_383_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_383_16 = 0

			if var_383_16 < arg_380_1.time_ and arg_380_1.time_ <= var_383_16 + arg_383_0 then
				arg_380_1.allBtn_.enabled = false
			end

			local var_383_17 = 0.3

			if arg_380_1.time_ >= var_383_16 + var_383_17 and arg_380_1.time_ < var_383_16 + var_383_17 + arg_383_0 then
				arg_380_1.allBtn_.enabled = true
			end

			local var_383_18 = 0

			if var_383_18 < arg_380_1.time_ and arg_380_1.time_ <= var_383_18 + arg_383_0 then
				arg_380_1.mask_.enabled = true
				arg_380_1.mask_.raycastTarget = true

				arg_380_1:SetGaussion(false)
			end

			local var_383_19 = 1.2

			if var_383_18 <= arg_380_1.time_ and arg_380_1.time_ < var_383_18 + var_383_19 then
				local var_383_20 = (arg_380_1.time_ - var_383_18) / var_383_19
				local var_383_21 = Color.New(0, 0, 0)

				var_383_21.a = Mathf.Lerp(0, 1, var_383_20)
				arg_380_1.mask_.color = var_383_21
			end

			if arg_380_1.time_ >= var_383_18 + var_383_19 and arg_380_1.time_ < var_383_18 + var_383_19 + arg_383_0 then
				local var_383_22 = Color.New(0, 0, 0)

				var_383_22.a = 1
				arg_380_1.mask_.color = var_383_22
			end

			local var_383_23 = 1.2

			if var_383_23 < arg_380_1.time_ and arg_380_1.time_ <= var_383_23 + arg_383_0 then
				arg_380_1.mask_.enabled = true
				arg_380_1.mask_.raycastTarget = true

				arg_380_1:SetGaussion(false)
			end

			local var_383_24 = 2.13333333333333

			if var_383_23 <= arg_380_1.time_ and arg_380_1.time_ < var_383_23 + var_383_24 then
				local var_383_25 = (arg_380_1.time_ - var_383_23) / var_383_24
				local var_383_26 = Color.New(0, 0, 0)

				var_383_26.a = Mathf.Lerp(1, 0, var_383_25)
				arg_380_1.mask_.color = var_383_26
			end

			if arg_380_1.time_ >= var_383_23 + var_383_24 and arg_380_1.time_ < var_383_23 + var_383_24 + arg_383_0 then
				local var_383_27 = Color.New(0, 0, 0)
				local var_383_28 = 0

				arg_380_1.mask_.enabled = false
				var_383_27.a = var_383_28
				arg_380_1.mask_.color = var_383_27
			end

			local var_383_29 = 1.2

			if var_383_29 < arg_380_1.time_ and arg_380_1.time_ <= var_383_29 + arg_383_0 then
				arg_380_1.allBtn_.enabled = false
			end

			local var_383_30 = 1.83333333333333

			if arg_380_1.time_ >= var_383_29 + var_383_30 and arg_380_1.time_ < var_383_29 + var_383_30 + arg_383_0 then
				arg_380_1.allBtn_.enabled = true
			end

			local var_383_31 = 0.866666666666667
			local var_383_32 = 1

			if var_383_31 < arg_380_1.time_ and arg_380_1.time_ <= var_383_31 + arg_383_0 then
				local var_383_33 = "play"
				local var_383_34 = "effect"

				arg_380_1:AudioAction(var_383_33, var_383_34, "se_story_145", "se_story_145_amb_theater", "")
			end

			local var_383_35 = 1.2
			local var_383_36 = 1

			if var_383_35 < arg_380_1.time_ and arg_380_1.time_ <= var_383_35 + arg_383_0 then
				local var_383_37 = "play"
				local var_383_38 = "effect"

				arg_380_1:AudioAction(var_383_37, var_383_38, "se_story_145", "se_story_145_bell", "")
			end

			if arg_380_1.frameCnt_ <= 1 then
				arg_380_1.dialog_:SetActive(false)
			end

			local var_383_39 = 3.33333333333333
			local var_383_40 = 0.225

			if var_383_39 < arg_380_1.time_ and arg_380_1.time_ <= var_383_39 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0

				arg_380_1.dialog_:SetActive(true)

				arg_380_1.dialogCg_.alpha = 0

				local var_383_41 = LeanTween.value(arg_380_1.dialog_, 0, 1, 0.3)

				var_383_41:setOnUpdate(LuaHelper.FloatAction(function(arg_384_0)
					arg_380_1.dialogCg_.alpha = arg_384_0
				end))
				var_383_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_380_1.dialog_)
					var_383_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_380_1.duration_ = arg_380_1.duration_ + 0.3

				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_42 = arg_380_1:GetWordFromCfg(928041091)
				local var_383_43 = arg_380_1:FormatText(var_383_42.content)

				arg_380_1.text_.text = var_383_43

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_44 = 9
				local var_383_45 = utf8.len(var_383_43)
				local var_383_46 = var_383_44 <= 0 and var_383_40 or var_383_40 * (var_383_45 / var_383_44)

				if var_383_46 > 0 and var_383_40 < var_383_46 then
					arg_380_1.talkMaxDuration = var_383_46
					var_383_39 = var_383_39 + 0.3

					if var_383_46 + var_383_39 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_46 + var_383_39
					end
				end

				arg_380_1.text_.text = var_383_43
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_47 = var_383_39 + 0.3
			local var_383_48 = math.max(var_383_40, arg_380_1.talkMaxDuration)

			if var_383_47 <= arg_380_1.time_ and arg_380_1.time_ < var_383_47 + var_383_48 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_47) / var_383_48

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_47 + var_383_48 and arg_380_1.time_ < var_383_47 + var_383_48 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play928041092 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 928041092
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play928041093(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0
			local var_389_1 = 1

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				local var_389_2 = "stop"
				local var_389_3 = "effect"

				arg_386_1:AudioAction(var_389_2, var_389_3, "se_story_145", "se_story_145_amb_theater", "")
			end

			local var_389_4 = 0
			local var_389_5 = 0.825

			if var_389_4 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_6 = arg_386_1:GetWordFromCfg(928041092)
				local var_389_7 = arg_386_1:FormatText(var_389_6.content)

				arg_386_1.text_.text = var_389_7

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_8 = 33
				local var_389_9 = utf8.len(var_389_7)
				local var_389_10 = var_389_8 <= 0 and var_389_5 or var_389_5 * (var_389_9 / var_389_8)

				if var_389_10 > 0 and var_389_5 < var_389_10 then
					arg_386_1.talkMaxDuration = var_389_10

					if var_389_10 + var_389_4 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_10 + var_389_4
					end
				end

				arg_386_1.text_.text = var_389_7
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_11 = math.max(var_389_5, arg_386_1.talkMaxDuration)

			if var_389_4 <= arg_386_1.time_ and arg_386_1.time_ < var_389_4 + var_389_11 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_4) / var_389_11

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_4 + var_389_11 and arg_386_1.time_ < var_389_4 + var_389_11 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play928041093 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 928041093
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play928041094(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 1.4

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_2 = arg_390_1:GetWordFromCfg(928041093)
				local var_393_3 = arg_390_1:FormatText(var_393_2.content)

				arg_390_1.text_.text = var_393_3

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_4 = 56
				local var_393_5 = utf8.len(var_393_3)
				local var_393_6 = var_393_4 <= 0 and var_393_1 or var_393_1 * (var_393_5 / var_393_4)

				if var_393_6 > 0 and var_393_1 < var_393_6 then
					arg_390_1.talkMaxDuration = var_393_6

					if var_393_6 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_6 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_3
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_7 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_7 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_7

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_7 and arg_390_1.time_ < var_393_0 + var_393_7 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play928041094 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 928041094
		arg_394_1.duration_ = 5.67

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play928041095(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = manager.ui.mainCamera.transform
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 then
				local var_397_2 = arg_394_1.var_.effect4645
				local var_397_3
				local var_397_4 = var_397_0

				if not var_397_2 then
					var_397_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng01_in_keep"), var_397_4)
					var_397_2.name = "4645"
					arg_394_1.var_.effect4645 = var_397_2
				else
					var_397_2.transform:SetParent(var_397_4)
				end

				var_397_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_397_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_397_5 = manager.ui.mainCameraCom_
				local var_397_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_397_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_397_7 = var_397_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_397_8 = 15
				local var_397_9 = 2 * var_397_8 * Mathf.Tan(var_397_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_397_5.aspect
				local var_397_10 = 1
				local var_397_11 = 1.7777777777777777

				if var_397_11 < var_397_5.aspect then
					var_397_10 = var_397_9 / (2 * var_397_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_397_11)
				end

				for iter_397_0, iter_397_1 in ipairs(var_397_7) do
					local var_397_12 = iter_397_1.transform.localScale

					iter_397_1.transform.localScale = Vector3.New(var_397_12.x / var_397_6 * var_397_10, var_397_12.y / var_397_6, var_397_12.z)
				end
			end

			local var_397_13 = 0

			if var_397_13 < arg_394_1.time_ and arg_394_1.time_ <= var_397_13 + arg_397_0 then
				arg_394_1.allBtn_.enabled = false
			end

			local var_397_14 = 1.29166666666667

			if arg_394_1.time_ >= var_397_13 + var_397_14 and arg_394_1.time_ < var_397_13 + var_397_14 + arg_397_0 then
				arg_394_1.allBtn_.enabled = true
			end

			if arg_394_1.frameCnt_ <= 1 then
				arg_394_1.dialog_:SetActive(false)
			end

			local var_397_15 = 0.666666666666667
			local var_397_16 = 0.625

			if var_397_15 < arg_394_1.time_ and arg_394_1.time_ <= var_397_15 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0

				arg_394_1.dialog_:SetActive(true)

				arg_394_1.dialogCg_.alpha = 0

				local var_397_17 = LeanTween.value(arg_394_1.dialog_, 0, 1, 0.3)

				var_397_17:setOnUpdate(LuaHelper.FloatAction(function(arg_398_0)
					arg_394_1.dialogCg_.alpha = arg_398_0
				end))
				var_397_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_394_1.dialog_)
					var_397_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_394_1.duration_ = arg_394_1.duration_ + 0.3

				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_18 = arg_394_1:GetWordFromCfg(928041094)
				local var_397_19 = arg_394_1:FormatText(var_397_18.content)

				arg_394_1.text_.text = var_397_19

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_20 = 25
				local var_397_21 = utf8.len(var_397_19)
				local var_397_22 = var_397_20 <= 0 and var_397_16 or var_397_16 * (var_397_21 / var_397_20)

				if var_397_22 > 0 and var_397_16 < var_397_22 then
					arg_394_1.talkMaxDuration = var_397_22
					var_397_15 = var_397_15 + 0.3

					if var_397_22 + var_397_15 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_22 + var_397_15
					end
				end

				arg_394_1.text_.text = var_397_19
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_23 = var_397_15 + 0.3
			local var_397_24 = math.max(var_397_16, arg_394_1.talkMaxDuration)

			if var_397_23 <= arg_394_1.time_ and arg_394_1.time_ < var_397_23 + var_397_24 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_23) / var_397_24

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_23 + var_397_24 and arg_394_1.time_ < var_397_23 + var_397_24 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play928041095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 928041095
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play928041096(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 1

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				local var_403_2 = "stop"
				local var_403_3 = "effect"

				arg_400_1:AudioAction(var_403_2, var_403_3, "se_story_145", "se_story_145_bell", "")
			end

			local var_403_4 = 0
			local var_403_5 = 0.225

			if var_403_4 < arg_400_1.time_ and arg_400_1.time_ <= var_403_4 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_6 = arg_400_1:FormatText(StoryNameCfg[7].name)

				arg_400_1.leftNameTxt_.text = var_403_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_7 = arg_400_1:GetWordFromCfg(928041095)
				local var_403_8 = arg_400_1:FormatText(var_403_7.content)

				arg_400_1.text_.text = var_403_8

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_9 = 9
				local var_403_10 = utf8.len(var_403_8)
				local var_403_11 = var_403_9 <= 0 and var_403_5 or var_403_5 * (var_403_10 / var_403_9)

				if var_403_11 > 0 and var_403_5 < var_403_11 then
					arg_400_1.talkMaxDuration = var_403_11

					if var_403_11 + var_403_4 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_11 + var_403_4
					end
				end

				arg_400_1.text_.text = var_403_8
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_12 = math.max(var_403_5, arg_400_1.talkMaxDuration)

			if var_403_4 <= arg_400_1.time_ and arg_400_1.time_ < var_403_4 + var_403_12 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_4) / var_403_12

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_4 + var_403_12 and arg_400_1.time_ < var_403_4 + var_403_12 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play928041096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 928041096
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play928041097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0
			local var_407_1 = 1.1

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_2 = arg_404_1:GetWordFromCfg(928041096)
				local var_407_3 = arg_404_1:FormatText(var_407_2.content)

				arg_404_1.text_.text = var_407_3

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 44
				local var_407_5 = utf8.len(var_407_3)
				local var_407_6 = var_407_4 <= 0 and var_407_1 or var_407_1 * (var_407_5 / var_407_4)

				if var_407_6 > 0 and var_407_1 < var_407_6 then
					arg_404_1.talkMaxDuration = var_407_6

					if var_407_6 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_6 + var_407_0
					end
				end

				arg_404_1.text_.text = var_407_3
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_1, arg_404_1.talkMaxDuration)

			if var_407_0 <= arg_404_1.time_ and arg_404_1.time_ < var_407_0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_0 + var_407_7 and arg_404_1.time_ < var_407_0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play928041097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 928041097
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play928041098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 1.1

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_2 = arg_408_1:GetWordFromCfg(928041097)
				local var_411_3 = arg_408_1:FormatText(var_411_2.content)

				arg_408_1.text_.text = var_411_3

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 44
				local var_411_5 = utf8.len(var_411_3)
				local var_411_6 = var_411_4 <= 0 and var_411_1 or var_411_1 * (var_411_5 / var_411_4)

				if var_411_6 > 0 and var_411_1 < var_411_6 then
					arg_408_1.talkMaxDuration = var_411_6

					if var_411_6 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_6 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_3
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_7 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_7 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_7

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_7 and arg_408_1.time_ < var_411_0 + var_411_7 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play928041098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 928041098
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play928041099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 0.15

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_2 = arg_412_1:FormatText(StoryNameCfg[7].name)

				arg_412_1.leftNameTxt_.text = var_415_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_3 = arg_412_1:GetWordFromCfg(928041098)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_5 = 6
				local var_415_6 = utf8.len(var_415_4)
				local var_415_7 = var_415_5 <= 0 and var_415_1 or var_415_1 * (var_415_6 / var_415_5)

				if var_415_7 > 0 and var_415_1 < var_415_7 then
					arg_412_1.talkMaxDuration = var_415_7

					if var_415_7 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_0
					end
				end

				arg_412_1.text_.text = var_415_4
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_8 = math.max(var_415_1, arg_412_1.talkMaxDuration)

			if var_415_0 <= arg_412_1.time_ and arg_412_1.time_ < var_415_0 + var_415_8 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_0) / var_415_8

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_0 + var_415_8 and arg_412_1.time_ < var_415_0 + var_415_8 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play928041099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 928041099
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play928041100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.375

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, false)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_2 = arg_416_1:GetWordFromCfg(928041099)
				local var_419_3 = arg_416_1:FormatText(var_419_2.content)

				arg_416_1.text_.text = var_419_3

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 15
				local var_419_5 = utf8.len(var_419_3)
				local var_419_6 = var_419_4 <= 0 and var_419_1 or var_419_1 * (var_419_5 / var_419_4)

				if var_419_6 > 0 and var_419_1 < var_419_6 then
					arg_416_1.talkMaxDuration = var_419_6

					if var_419_6 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_6 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_3
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_7 and arg_416_1.time_ < var_419_0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play928041100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 928041100
		arg_420_1.duration_ = 15.31

		local var_420_0 = {
			zh = 12.7413333333333,
			ja = 15.3083333333333
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play928041101(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0

			if var_423_0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_0 + arg_423_0 then
				arg_420_1.allBtn_.enabled = false
			end

			local var_423_1 = 0.3

			if arg_420_1.time_ >= var_423_0 + var_423_1 and arg_420_1.time_ < var_423_0 + var_423_1 + arg_423_0 then
				arg_420_1.allBtn_.enabled = true
			end

			local var_423_2 = 0

			if var_423_2 < arg_420_1.time_ and arg_420_1.time_ <= var_423_2 + arg_423_0 then
				arg_420_1.mask_.enabled = true
				arg_420_1.mask_.raycastTarget = true

				arg_420_1:SetGaussion(false)
			end

			local var_423_3 = 2

			if var_423_2 <= arg_420_1.time_ and arg_420_1.time_ < var_423_2 + var_423_3 then
				local var_423_4 = (arg_420_1.time_ - var_423_2) / var_423_3
				local var_423_5 = Color.New(0, 0, 0)

				var_423_5.a = Mathf.Lerp(0, 1, var_423_4)
				arg_420_1.mask_.color = var_423_5
			end

			if arg_420_1.time_ >= var_423_2 + var_423_3 and arg_420_1.time_ < var_423_2 + var_423_3 + arg_423_0 then
				local var_423_6 = Color.New(0, 0, 0)

				var_423_6.a = 1
				arg_420_1.mask_.color = var_423_6
			end

			local var_423_7 = 2

			if var_423_7 < arg_420_1.time_ and arg_420_1.time_ <= var_423_7 + arg_423_0 then
				arg_420_1.mask_.enabled = true
				arg_420_1.mask_.raycastTarget = true

				arg_420_1:SetGaussion(false)
			end

			local var_423_8 = 2

			if var_423_7 <= arg_420_1.time_ and arg_420_1.time_ < var_423_7 + var_423_8 then
				local var_423_9 = (arg_420_1.time_ - var_423_7) / var_423_8
				local var_423_10 = Color.New(0, 0, 0)

				var_423_10.a = Mathf.Lerp(1, 0, var_423_9)
				arg_420_1.mask_.color = var_423_10
			end

			if arg_420_1.time_ >= var_423_7 + var_423_8 and arg_420_1.time_ < var_423_7 + var_423_8 + arg_423_0 then
				local var_423_11 = Color.New(0, 0, 0)
				local var_423_12 = 0

				arg_420_1.mask_.enabled = false
				var_423_11.a = var_423_12
				arg_420_1.mask_.color = var_423_11
			end

			local var_423_13 = arg_420_1.actors_["108502ui_story"].transform
			local var_423_14 = 4

			if var_423_14 < arg_420_1.time_ and arg_420_1.time_ <= var_423_14 + arg_423_0 then
				arg_420_1.var_.moveOldPos108502ui_story = var_423_13.localPosition
			end

			local var_423_15 = 0.001

			if var_423_14 <= arg_420_1.time_ and arg_420_1.time_ < var_423_14 + var_423_15 then
				local var_423_16 = (arg_420_1.time_ - var_423_14) / var_423_15
				local var_423_17 = Vector3.New(0, -1.01, -5.83)

				var_423_13.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos108502ui_story, var_423_17, var_423_16)

				local var_423_18 = manager.ui.mainCamera.transform.position - var_423_13.position

				var_423_13.forward = Vector3.New(var_423_18.x, var_423_18.y, var_423_18.z)

				local var_423_19 = var_423_13.localEulerAngles

				var_423_19.z = 0
				var_423_19.x = 0
				var_423_13.localEulerAngles = var_423_19
			end

			if arg_420_1.time_ >= var_423_14 + var_423_15 and arg_420_1.time_ < var_423_14 + var_423_15 + arg_423_0 then
				var_423_13.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_423_20 = manager.ui.mainCamera.transform.position - var_423_13.position

				var_423_13.forward = Vector3.New(var_423_20.x, var_423_20.y, var_423_20.z)

				local var_423_21 = var_423_13.localEulerAngles

				var_423_21.z = 0
				var_423_21.x = 0
				var_423_13.localEulerAngles = var_423_21
			end

			local var_423_22 = arg_420_1.actors_["108502ui_story"]
			local var_423_23 = 4

			if var_423_23 < arg_420_1.time_ and arg_420_1.time_ <= var_423_23 + arg_423_0 and not isNil(var_423_22) and arg_420_1.var_.characterEffect108502ui_story == nil then
				arg_420_1.var_.characterEffect108502ui_story = var_423_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_24 = 0.200000002980232

			if var_423_23 <= arg_420_1.time_ and arg_420_1.time_ < var_423_23 + var_423_24 and not isNil(var_423_22) then
				local var_423_25 = (arg_420_1.time_ - var_423_23) / var_423_24

				if arg_420_1.var_.characterEffect108502ui_story and not isNil(var_423_22) then
					arg_420_1.var_.characterEffect108502ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= var_423_23 + var_423_24 and arg_420_1.time_ < var_423_23 + var_423_24 + arg_423_0 and not isNil(var_423_22) and arg_420_1.var_.characterEffect108502ui_story then
				arg_420_1.var_.characterEffect108502ui_story.fillFlat = false
			end

			local var_423_26 = 4

			if var_423_26 < arg_420_1.time_ and arg_420_1.time_ <= var_423_26 + arg_423_0 then
				arg_420_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/story108502/story108502action/108502action1_1")
			end

			local var_423_27 = 4

			if var_423_27 < arg_420_1.time_ and arg_420_1.time_ <= var_423_27 + arg_423_0 then
				arg_420_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_423_28 = manager.ui.mainCamera.transform
			local var_423_29 = 2

			if var_423_29 < arg_420_1.time_ and arg_420_1.time_ <= var_423_29 + arg_423_0 then
				local var_423_30 = arg_420_1.var_.effect4645

				if var_423_30 then
					Object.Destroy(var_423_30)

					arg_420_1.var_.effect4645 = nil
				end
			end

			local var_423_31 = 2

			if var_423_31 < arg_420_1.time_ and arg_420_1.time_ <= var_423_31 + arg_423_0 then
				arg_420_1:CreatePrefabSceneGo("Levels/X205f1", Vector3.New(0, 0, 1.59), Vector3.New(0, 0, 0))
			end

			local var_423_32 = arg_420_1.bgs_.X205_d.transform
			local var_423_33 = 2

			if var_423_33 < arg_420_1.time_ and arg_420_1.time_ <= var_423_33 + arg_423_0 then
				arg_420_1.var_.moveOldPosX205_d = var_423_32.localPosition
			end

			local var_423_34 = 0.001

			if var_423_33 <= arg_420_1.time_ and arg_420_1.time_ < var_423_33 + var_423_34 then
				local var_423_35 = (arg_420_1.time_ - var_423_33) / var_423_34
				local var_423_36 = Vector3.New(-39.63, 1, 10)

				var_423_32.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPosX205_d, var_423_36, var_423_35)
			end

			if arg_420_1.time_ >= var_423_33 + var_423_34 and arg_420_1.time_ < var_423_33 + var_423_34 + arg_423_0 then
				var_423_32.localPosition = Vector3.New(-39.63, 1, 10)
			end

			local var_423_37 = manager.ui.mainCamera.transform
			local var_423_38 = manager.ui.mainCameraCom_
			local var_423_39 = 2
			local var_423_40 = Vector3.New(0, 1, -10)
			local var_423_41 = Quaternion.Euler(0, 0, 0)
			local var_423_42 = 25

			if var_423_39 < arg_420_1.time_ and arg_420_1.time_ <= var_423_39 + arg_423_0 then
				arg_420_1.var_.cameraOldPos = var_423_37.localPosition
				arg_420_1.var_.cameraOldRot = var_423_37.localRotation
				arg_420_1.var_.cameraOldFov = var_423_38.fieldOfView
			end

			local var_423_43 = 0.0166666666666667

			if var_423_39 <= arg_420_1.time_ and arg_420_1.time_ < var_423_39 + var_423_43 then
				local var_423_44 = (arg_420_1.time_ - var_423_39) / var_423_43

				var_423_37.localPosition = Vector3.Lerp(arg_420_1.var_.cameraOldPos, var_423_40, var_423_44)
				var_423_37.localRotation = Quaternion.Slerp(arg_420_1.var_.cameraOldRot, var_423_41, var_423_44)
				var_423_38.fieldOfView = Mathf.Lerp(arg_420_1.var_.cameraOldFov, var_423_42, var_423_44)
			end

			if arg_420_1.time_ >= var_423_39 + var_423_43 and arg_420_1.time_ < var_423_39 + var_423_43 + arg_423_0 then
				var_423_37.localPosition = var_423_40
				var_423_37.localRotation = var_423_41
				var_423_38.fieldOfView = var_423_42
			end

			local var_423_45 = manager.ui.mainCamera.transform
			local var_423_46 = manager.ui.mainCameraCom_
			local var_423_47 = 4.20000000298023
			local var_423_48 = Vector3.New(0, 1.15, -9.92)
			local var_423_49 = Quaternion.Euler(0.18, 0, 0)
			local var_423_50 = 13.3

			if var_423_47 < arg_420_1.time_ and arg_420_1.time_ <= var_423_47 + arg_423_0 then
				arg_420_1.var_.cameraOldPos = var_423_45.localPosition
				arg_420_1.var_.cameraOldRot = var_423_45.localRotation
				arg_420_1.var_.cameraOldFov = var_423_46.fieldOfView
			end

			local var_423_51 = 1.79999999701977

			if var_423_47 <= arg_420_1.time_ and arg_420_1.time_ < var_423_47 + var_423_51 then
				local var_423_52 = (arg_420_1.time_ - var_423_47) / var_423_51

				var_423_45.localPosition = Vector3.Lerp(arg_420_1.var_.cameraOldPos, var_423_48, var_423_52)
				var_423_45.localRotation = Quaternion.Slerp(arg_420_1.var_.cameraOldRot, var_423_49, var_423_52)
				var_423_46.fieldOfView = Mathf.Lerp(arg_420_1.var_.cameraOldFov, var_423_50, var_423_52)
			end

			if arg_420_1.time_ >= var_423_47 + var_423_51 and arg_420_1.time_ < var_423_47 + var_423_51 + arg_423_0 then
				var_423_45.localPosition = var_423_48
				var_423_45.localRotation = var_423_49
				var_423_46.fieldOfView = var_423_50
			end

			local var_423_53 = 3.56666666666667

			if var_423_53 < arg_420_1.time_ and arg_420_1.time_ <= var_423_53 + arg_423_0 then
				arg_420_1.allBtn_.enabled = false
			end

			local var_423_54 = 3.00833333333333

			if arg_420_1.time_ >= var_423_53 + var_423_54 and arg_420_1.time_ < var_423_53 + var_423_54 + arg_423_0 then
				arg_420_1.allBtn_.enabled = true
			end

			if arg_420_1.frameCnt_ <= 1 then
				arg_420_1.dialog_:SetActive(false)
			end

			local var_423_55 = 5.70833333333333
			local var_423_56 = 0.575

			if var_423_55 < arg_420_1.time_ and arg_420_1.time_ <= var_423_55 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0

				arg_420_1.dialog_:SetActive(true)

				arg_420_1.dialogCg_.alpha = 0

				local var_423_57 = LeanTween.value(arg_420_1.dialog_, 0, 1, 0.3)

				var_423_57:setOnUpdate(LuaHelper.FloatAction(function(arg_424_0)
					arg_420_1.dialogCg_.alpha = arg_424_0
				end))
				var_423_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_420_1.dialog_)
					var_423_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_420_1.duration_ = arg_420_1.duration_ + 0.3

				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_58 = arg_420_1:FormatText(StoryNameCfg[328].name)

				arg_420_1.leftNameTxt_.text = var_423_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_59 = arg_420_1:GetWordFromCfg(928041100)
				local var_423_60 = arg_420_1:FormatText(var_423_59.content)

				arg_420_1.text_.text = var_423_60

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_61 = 23
				local var_423_62 = utf8.len(var_423_60)
				local var_423_63 = var_423_61 <= 0 and var_423_56 or var_423_56 * (var_423_62 / var_423_61)

				if var_423_63 > 0 and var_423_56 < var_423_63 then
					arg_420_1.talkMaxDuration = var_423_63
					var_423_55 = var_423_55 + 0.3

					if var_423_63 + var_423_55 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_63 + var_423_55
					end
				end

				arg_420_1.text_.text = var_423_60
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041100", "story_v_side_old_928041.awb") ~= 0 then
					local var_423_64 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041100", "story_v_side_old_928041.awb") / 1000

					if var_423_64 + var_423_55 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_64 + var_423_55
					end

					if var_423_59.prefab_name ~= "" and arg_420_1.actors_[var_423_59.prefab_name] ~= nil then
						local var_423_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_59.prefab_name].transform, "story_v_side_old_928041", "928041100", "story_v_side_old_928041.awb")

						arg_420_1:RecordAudio("928041100", var_423_65)
						arg_420_1:RecordAudio("928041100", var_423_65)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041100", "story_v_side_old_928041.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041100", "story_v_side_old_928041.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_66 = var_423_55 + 0.3
			local var_423_67 = math.max(var_423_56, arg_420_1.talkMaxDuration)

			if var_423_66 <= arg_420_1.time_ and arg_420_1.time_ < var_423_66 + var_423_67 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_66) / var_423_67

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_66 + var_423_67 and arg_420_1.time_ < var_423_66 + var_423_67 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108502ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "X205_d",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play928041101 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 928041101
		arg_426_1.duration_ = 16.47

		local var_426_0 = {
			zh = 13.366,
			ja = 16.466
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play928041102(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0

			if var_429_0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/story108502/story108502action/108502action5_1")
			end

			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.allBtn_.enabled = false
			end

			local var_429_2 = 1.86666666666667

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 then
				arg_426_1.allBtn_.enabled = true
			end

			local var_429_3 = 0
			local var_429_4 = 1.1

			if var_429_3 < arg_426_1.time_ and arg_426_1.time_ <= var_429_3 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_5 = arg_426_1:FormatText(StoryNameCfg[328].name)

				arg_426_1.leftNameTxt_.text = var_429_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_6 = arg_426_1:GetWordFromCfg(928041101)
				local var_429_7 = arg_426_1:FormatText(var_429_6.content)

				arg_426_1.text_.text = var_429_7

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_8 = 44
				local var_429_9 = utf8.len(var_429_7)
				local var_429_10 = var_429_8 <= 0 and var_429_4 or var_429_4 * (var_429_9 / var_429_8)

				if var_429_10 > 0 and var_429_4 < var_429_10 then
					arg_426_1.talkMaxDuration = var_429_10

					if var_429_10 + var_429_3 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_10 + var_429_3
					end
				end

				arg_426_1.text_.text = var_429_7
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041101", "story_v_side_old_928041.awb") ~= 0 then
					local var_429_11 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041101", "story_v_side_old_928041.awb") / 1000

					if var_429_11 + var_429_3 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_11 + var_429_3
					end

					if var_429_6.prefab_name ~= "" and arg_426_1.actors_[var_429_6.prefab_name] ~= nil then
						local var_429_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_6.prefab_name].transform, "story_v_side_old_928041", "928041101", "story_v_side_old_928041.awb")

						arg_426_1:RecordAudio("928041101", var_429_12)
						arg_426_1:RecordAudio("928041101", var_429_12)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041101", "story_v_side_old_928041.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041101", "story_v_side_old_928041.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_13 = math.max(var_429_4, arg_426_1.talkMaxDuration)

			if var_429_3 <= arg_426_1.time_ and arg_426_1.time_ < var_429_3 + var_429_13 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_3) / var_429_13

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_3 + var_429_13 and arg_426_1.time_ < var_429_3 + var_429_13 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play928041102 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 928041102
		arg_430_1.duration_ = 12.53

		local var_430_0 = {
			zh = 10.566,
			ja = 12.533
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play928041103(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = manager.ui.mainCamera.transform
			local var_433_1 = manager.ui.mainCameraCom_
			local var_433_2 = 0
			local var_433_3 = Vector3.New(1.37, 1.22, -8.46)
			local var_433_4 = Quaternion.Euler(1.06, -25.88, 0)
			local var_433_5 = 15.9

			if var_433_2 < arg_430_1.time_ and arg_430_1.time_ <= var_433_2 + arg_433_0 then
				arg_430_1.var_.cameraOldPos = var_433_0.localPosition
				arg_430_1.var_.cameraOldRot = var_433_0.localRotation
				arg_430_1.var_.cameraOldFov = var_433_1.fieldOfView
			end

			local var_433_6 = 0.0166666666666667

			if var_433_2 <= arg_430_1.time_ and arg_430_1.time_ < var_433_2 + var_433_6 then
				local var_433_7 = (arg_430_1.time_ - var_433_2) / var_433_6

				var_433_0.localPosition = Vector3.Lerp(arg_430_1.var_.cameraOldPos, var_433_3, var_433_7)
				var_433_0.localRotation = Quaternion.Slerp(arg_430_1.var_.cameraOldRot, var_433_4, var_433_7)
				var_433_1.fieldOfView = Mathf.Lerp(arg_430_1.var_.cameraOldFov, var_433_5, var_433_7)
			end

			if arg_430_1.time_ >= var_433_2 + var_433_6 and arg_430_1.time_ < var_433_2 + var_433_6 + arg_433_0 then
				var_433_0.localPosition = var_433_3
				var_433_0.localRotation = var_433_4
				var_433_1.fieldOfView = var_433_5
			end

			local var_433_8 = 0

			if var_433_8 < arg_430_1.time_ and arg_430_1.time_ <= var_433_8 + arg_433_0 then
				arg_430_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/story108502/story108502actionlink/108502action459")
			end

			local var_433_9 = 0

			if var_433_9 < arg_430_1.time_ and arg_430_1.time_ <= var_433_9 + arg_433_0 then
				arg_430_1.allBtn_.enabled = false
			end

			local var_433_10 = 2.43333333333333

			if arg_430_1.time_ >= var_433_9 + var_433_10 and arg_430_1.time_ < var_433_9 + var_433_10 + arg_433_0 then
				arg_430_1.allBtn_.enabled = true
			end

			local var_433_11 = 0
			local var_433_12 = 0.9

			if var_433_11 < arg_430_1.time_ and arg_430_1.time_ <= var_433_11 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_13 = arg_430_1:FormatText(StoryNameCfg[328].name)

				arg_430_1.leftNameTxt_.text = var_433_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_14 = arg_430_1:GetWordFromCfg(928041102)
				local var_433_15 = arg_430_1:FormatText(var_433_14.content)

				arg_430_1.text_.text = var_433_15

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_16 = 36
				local var_433_17 = utf8.len(var_433_15)
				local var_433_18 = var_433_16 <= 0 and var_433_12 or var_433_12 * (var_433_17 / var_433_16)

				if var_433_18 > 0 and var_433_12 < var_433_18 then
					arg_430_1.talkMaxDuration = var_433_18

					if var_433_18 + var_433_11 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_18 + var_433_11
					end
				end

				arg_430_1.text_.text = var_433_15
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041102", "story_v_side_old_928041.awb") ~= 0 then
					local var_433_19 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041102", "story_v_side_old_928041.awb") / 1000

					if var_433_19 + var_433_11 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_19 + var_433_11
					end

					if var_433_14.prefab_name ~= "" and arg_430_1.actors_[var_433_14.prefab_name] ~= nil then
						local var_433_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_14.prefab_name].transform, "story_v_side_old_928041", "928041102", "story_v_side_old_928041.awb")

						arg_430_1:RecordAudio("928041102", var_433_20)
						arg_430_1:RecordAudio("928041102", var_433_20)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041102", "story_v_side_old_928041.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041102", "story_v_side_old_928041.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_21 = math.max(var_433_12, arg_430_1.talkMaxDuration)

			if var_433_11 <= arg_430_1.time_ and arg_430_1.time_ < var_433_11 + var_433_21 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_11) / var_433_21

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_11 + var_433_21 and arg_430_1.time_ < var_433_11 + var_433_21 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play928041103 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 928041103
		arg_434_1.duration_ = 18.83

		local var_434_0 = {
			zh = 16.1,
			ja = 18.833
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play928041104(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_437_1 = manager.ui.mainCamera.transform
			local var_437_2 = manager.ui.mainCameraCom_
			local var_437_3 = 0
			local var_437_4 = Vector3.New(-0.02, 1.19, -6.74)
			local var_437_5 = Quaternion.Euler(-0.68, 0, 0)
			local var_437_6 = 15.6

			if var_437_3 < arg_434_1.time_ and arg_434_1.time_ <= var_437_3 + arg_437_0 then
				arg_434_1.var_.cameraOldPos = var_437_1.localPosition
				arg_434_1.var_.cameraOldRot = var_437_1.localRotation
				arg_434_1.var_.cameraOldFov = var_437_2.fieldOfView
			end

			local var_437_7 = 0.0166666666666667

			if var_437_3 <= arg_434_1.time_ and arg_434_1.time_ < var_437_3 + var_437_7 then
				local var_437_8 = (arg_434_1.time_ - var_437_3) / var_437_7

				var_437_1.localPosition = Vector3.Lerp(arg_434_1.var_.cameraOldPos, var_437_4, var_437_8)
				var_437_1.localRotation = Quaternion.Slerp(arg_434_1.var_.cameraOldRot, var_437_5, var_437_8)
				var_437_2.fieldOfView = Mathf.Lerp(arg_434_1.var_.cameraOldFov, var_437_6, var_437_8)
			end

			if arg_434_1.time_ >= var_437_3 + var_437_7 and arg_434_1.time_ < var_437_3 + var_437_7 + arg_437_0 then
				var_437_1.localPosition = var_437_4
				var_437_1.localRotation = var_437_5
				var_437_2.fieldOfView = var_437_6
			end

			local var_437_9 = 0

			if var_437_9 < arg_434_1.time_ and arg_434_1.time_ <= var_437_9 + arg_437_0 then
				arg_434_1.allBtn_.enabled = false
			end

			local var_437_10 = 2.2

			if arg_434_1.time_ >= var_437_9 + var_437_10 and arg_434_1.time_ < var_437_9 + var_437_10 + arg_437_0 then
				arg_434_1.allBtn_.enabled = true
			end

			local var_437_11 = 0
			local var_437_12 = 1.475

			if var_437_11 < arg_434_1.time_ and arg_434_1.time_ <= var_437_11 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_13 = arg_434_1:FormatText(StoryNameCfg[328].name)

				arg_434_1.leftNameTxt_.text = var_437_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_14 = arg_434_1:GetWordFromCfg(928041103)
				local var_437_15 = arg_434_1:FormatText(var_437_14.content)

				arg_434_1.text_.text = var_437_15

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_16 = 59
				local var_437_17 = utf8.len(var_437_15)
				local var_437_18 = var_437_16 <= 0 and var_437_12 or var_437_12 * (var_437_17 / var_437_16)

				if var_437_18 > 0 and var_437_12 < var_437_18 then
					arg_434_1.talkMaxDuration = var_437_18

					if var_437_18 + var_437_11 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_18 + var_437_11
					end
				end

				arg_434_1.text_.text = var_437_15
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041103", "story_v_side_old_928041.awb") ~= 0 then
					local var_437_19 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041103", "story_v_side_old_928041.awb") / 1000

					if var_437_19 + var_437_11 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_19 + var_437_11
					end

					if var_437_14.prefab_name ~= "" and arg_434_1.actors_[var_437_14.prefab_name] ~= nil then
						local var_437_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_14.prefab_name].transform, "story_v_side_old_928041", "928041103", "story_v_side_old_928041.awb")

						arg_434_1:RecordAudio("928041103", var_437_20)
						arg_434_1:RecordAudio("928041103", var_437_20)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041103", "story_v_side_old_928041.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041103", "story_v_side_old_928041.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_21 = math.max(var_437_12, arg_434_1.talkMaxDuration)

			if var_437_11 <= arg_434_1.time_ and arg_434_1.time_ < var_437_11 + var_437_21 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_11) / var_437_21

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_11 + var_437_21 and arg_434_1.time_ < var_437_11 + var_437_21 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play928041104 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 928041104
		arg_438_1.duration_ = 16.93

		local var_438_0 = {
			zh = 14.266,
			ja = 16.933
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play928041105(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = manager.ui.mainCamera.transform
			local var_441_1 = manager.ui.mainCameraCom_
			local var_441_2 = 0
			local var_441_3 = Vector3.New(0, 1.15, -9.92)
			local var_441_4 = Quaternion.Euler(0.18, 0, 0)
			local var_441_5 = 13.3

			if var_441_2 < arg_438_1.time_ and arg_438_1.time_ <= var_441_2 + arg_441_0 then
				arg_438_1.var_.cameraOldPos = var_441_0.localPosition
				arg_438_1.var_.cameraOldRot = var_441_0.localRotation
				arg_438_1.var_.cameraOldFov = var_441_1.fieldOfView
			end

			local var_441_6 = 2

			if var_441_2 <= arg_438_1.time_ and arg_438_1.time_ < var_441_2 + var_441_6 then
				local var_441_7 = (arg_438_1.time_ - var_441_2) / var_441_6

				var_441_0.localPosition = Vector3.Lerp(arg_438_1.var_.cameraOldPos, var_441_3, var_441_7)
				var_441_0.localRotation = Quaternion.Slerp(arg_438_1.var_.cameraOldRot, var_441_4, var_441_7)
				var_441_1.fieldOfView = Mathf.Lerp(arg_438_1.var_.cameraOldFov, var_441_5, var_441_7)
			end

			if arg_438_1.time_ >= var_441_2 + var_441_6 and arg_438_1.time_ < var_441_2 + var_441_6 + arg_441_0 then
				var_441_0.localPosition = var_441_3
				var_441_0.localRotation = var_441_4
				var_441_1.fieldOfView = var_441_5
			end

			local var_441_8 = 0

			if var_441_8 < arg_438_1.time_ and arg_438_1.time_ <= var_441_8 + arg_441_0 then
				arg_438_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/story108502/story108502action/108502action9_2")
			end

			local var_441_9 = 0
			local var_441_10 = 0.875

			if var_441_9 < arg_438_1.time_ and arg_438_1.time_ <= var_441_9 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_11 = arg_438_1:FormatText(StoryNameCfg[328].name)

				arg_438_1.leftNameTxt_.text = var_441_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_12 = arg_438_1:GetWordFromCfg(928041104)
				local var_441_13 = arg_438_1:FormatText(var_441_12.content)

				arg_438_1.text_.text = var_441_13

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_14 = 35
				local var_441_15 = utf8.len(var_441_13)
				local var_441_16 = var_441_14 <= 0 and var_441_10 or var_441_10 * (var_441_15 / var_441_14)

				if var_441_16 > 0 and var_441_10 < var_441_16 then
					arg_438_1.talkMaxDuration = var_441_16

					if var_441_16 + var_441_9 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_16 + var_441_9
					end
				end

				arg_438_1.text_.text = var_441_13
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041104", "story_v_side_old_928041.awb") ~= 0 then
					local var_441_17 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041104", "story_v_side_old_928041.awb") / 1000

					if var_441_17 + var_441_9 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_17 + var_441_9
					end

					if var_441_12.prefab_name ~= "" and arg_438_1.actors_[var_441_12.prefab_name] ~= nil then
						local var_441_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_12.prefab_name].transform, "story_v_side_old_928041", "928041104", "story_v_side_old_928041.awb")

						arg_438_1:RecordAudio("928041104", var_441_18)
						arg_438_1:RecordAudio("928041104", var_441_18)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041104", "story_v_side_old_928041.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041104", "story_v_side_old_928041.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_19 = math.max(var_441_10, arg_438_1.talkMaxDuration)

			if var_441_9 <= arg_438_1.time_ and arg_438_1.time_ < var_441_9 + var_441_19 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_9) / var_441_19

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_9 + var_441_19 and arg_438_1.time_ < var_441_9 + var_441_19 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play928041105 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 928041105
		arg_442_1.duration_ = 9.17

		local var_442_0 = {
			zh = 6.3,
			ja = 9.166
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play928041106(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0

			if var_445_0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/story108502/story108502action/108502action11_1")
			end

			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				arg_442_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_445_2 = manager.ui.mainCamera.transform
			local var_445_3 = manager.ui.mainCameraCom_
			local var_445_4 = 0
			local var_445_5 = Vector3.New(0.71, 1.28, -10.21)
			local var_445_6 = Quaternion.Euler(0.94, -12.28, 0)
			local var_445_7 = 13.3

			if var_445_4 < arg_442_1.time_ and arg_442_1.time_ <= var_445_4 + arg_445_0 then
				arg_442_1.var_.cameraOldPos = var_445_2.localPosition
				arg_442_1.var_.cameraOldRot = var_445_2.localRotation
				arg_442_1.var_.cameraOldFov = var_445_3.fieldOfView
			end

			local var_445_8 = 2.66666666666667

			if var_445_4 <= arg_442_1.time_ and arg_442_1.time_ < var_445_4 + var_445_8 then
				local var_445_9 = (arg_442_1.time_ - var_445_4) / var_445_8

				var_445_2.localPosition = Vector3.Lerp(arg_442_1.var_.cameraOldPos, var_445_5, var_445_9)
				var_445_2.localRotation = Quaternion.Slerp(arg_442_1.var_.cameraOldRot, var_445_6, var_445_9)
				var_445_3.fieldOfView = Mathf.Lerp(arg_442_1.var_.cameraOldFov, var_445_7, var_445_9)
			end

			if arg_442_1.time_ >= var_445_4 + var_445_8 and arg_442_1.time_ < var_445_4 + var_445_8 + arg_445_0 then
				var_445_2.localPosition = var_445_5
				var_445_2.localRotation = var_445_6
				var_445_3.fieldOfView = var_445_7
			end

			local var_445_10 = 0

			if var_445_10 < arg_442_1.time_ and arg_442_1.time_ <= var_445_10 + arg_445_0 then
				arg_442_1.allBtn_.enabled = false
			end

			local var_445_11 = 2.86666666666667

			if arg_442_1.time_ >= var_445_10 + var_445_11 and arg_442_1.time_ < var_445_10 + var_445_11 + arg_445_0 then
				arg_442_1.allBtn_.enabled = true
			end

			local var_445_12 = 0
			local var_445_13 = 0.5

			if var_445_12 < arg_442_1.time_ and arg_442_1.time_ <= var_445_12 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_14 = arg_442_1:FormatText(StoryNameCfg[328].name)

				arg_442_1.leftNameTxt_.text = var_445_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_15 = arg_442_1:GetWordFromCfg(928041105)
				local var_445_16 = arg_442_1:FormatText(var_445_15.content)

				arg_442_1.text_.text = var_445_16

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_17 = 20
				local var_445_18 = utf8.len(var_445_16)
				local var_445_19 = var_445_17 <= 0 and var_445_13 or var_445_13 * (var_445_18 / var_445_17)

				if var_445_19 > 0 and var_445_13 < var_445_19 then
					arg_442_1.talkMaxDuration = var_445_19

					if var_445_19 + var_445_12 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_19 + var_445_12
					end
				end

				arg_442_1.text_.text = var_445_16
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041105", "story_v_side_old_928041.awb") ~= 0 then
					local var_445_20 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041105", "story_v_side_old_928041.awb") / 1000

					if var_445_20 + var_445_12 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_20 + var_445_12
					end

					if var_445_15.prefab_name ~= "" and arg_442_1.actors_[var_445_15.prefab_name] ~= nil then
						local var_445_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_15.prefab_name].transform, "story_v_side_old_928041", "928041105", "story_v_side_old_928041.awb")

						arg_442_1:RecordAudio("928041105", var_445_21)
						arg_442_1:RecordAudio("928041105", var_445_21)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041105", "story_v_side_old_928041.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041105", "story_v_side_old_928041.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_22 = math.max(var_445_13, arg_442_1.talkMaxDuration)

			if var_445_12 <= arg_442_1.time_ and arg_442_1.time_ < var_445_12 + var_445_22 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_12) / var_445_22

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_12 + var_445_22 and arg_442_1.time_ < var_445_12 + var_445_22 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play928041106 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 928041106
		arg_446_1.duration_ = 6.37

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play928041107(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = "1080ui_story"

			if arg_446_1.actors_[var_449_0] == nil then
				local var_449_1 = Asset.Load("Char/" .. "1080ui_story")

				if not isNil(var_449_1) then
					local var_449_2 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_446_1.stage_.transform)

					var_449_2.name = var_449_0
					var_449_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_446_1.actors_[var_449_0] = var_449_2

					local var_449_3 = var_449_2:GetComponentInChildren(typeof(CharacterEffect))

					var_449_3.enabled = true

					local var_449_4 = GameObjectTools.GetOrAddComponent(var_449_2, typeof(DynamicBoneHelper))

					if var_449_4 then
						var_449_4:EnableDynamicBone(false)
					end

					arg_446_1:ShowWeapon(var_449_3.transform, false)

					arg_446_1.var_[var_449_0 .. "Animator"] = var_449_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_446_1.var_[var_449_0 .. "Animator"].applyRootMotion = true
					arg_446_1.var_[var_449_0 .. "LipSync"] = var_449_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_449_5 = arg_446_1.actors_["1080ui_story"]
			local var_449_6 = 0

			if var_449_6 < arg_446_1.time_ and arg_446_1.time_ <= var_449_6 + arg_449_0 and not isNil(var_449_5) and arg_446_1.var_.characterEffect1080ui_story == nil then
				arg_446_1.var_.characterEffect1080ui_story = var_449_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_7 = 0.200000002980232

			if var_449_6 <= arg_446_1.time_ and arg_446_1.time_ < var_449_6 + var_449_7 and not isNil(var_449_5) then
				local var_449_8 = (arg_446_1.time_ - var_449_6) / var_449_7

				if arg_446_1.var_.characterEffect1080ui_story and not isNil(var_449_5) then
					local var_449_9 = Mathf.Lerp(0, 0.5, var_449_8)

					arg_446_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_446_1.var_.characterEffect1080ui_story.fillRatio = var_449_9
				end
			end

			if arg_446_1.time_ >= var_449_6 + var_449_7 and arg_446_1.time_ < var_449_6 + var_449_7 + arg_449_0 and not isNil(var_449_5) and arg_446_1.var_.characterEffect1080ui_story then
				local var_449_10 = 0.5

				arg_446_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_446_1.var_.characterEffect1080ui_story.fillRatio = var_449_10
			end

			local var_449_11 = manager.ui.mainCamera.transform
			local var_449_12 = manager.ui.mainCameraCom_
			local var_449_13 = 0
			local var_449_14 = Vector3.New(0, 1, -10)
			local var_449_15 = Quaternion.Euler(0, 0, 0)
			local var_449_16 = 25

			if var_449_13 < arg_446_1.time_ and arg_446_1.time_ <= var_449_13 + arg_449_0 then
				arg_446_1.var_.cameraOldPos = var_449_11.localPosition
				arg_446_1.var_.cameraOldRot = var_449_11.localRotation
				arg_446_1.var_.cameraOldFov = var_449_12.fieldOfView
			end

			local var_449_17 = 0.0166666666666667

			if var_449_13 <= arg_446_1.time_ and arg_446_1.time_ < var_449_13 + var_449_17 then
				local var_449_18 = (arg_446_1.time_ - var_449_13) / var_449_17

				var_449_11.localPosition = Vector3.Lerp(arg_446_1.var_.cameraOldPos, var_449_14, var_449_18)
				var_449_11.localRotation = Quaternion.Slerp(arg_446_1.var_.cameraOldRot, var_449_15, var_449_18)
				var_449_12.fieldOfView = Mathf.Lerp(arg_446_1.var_.cameraOldFov, var_449_16, var_449_18)
			end

			if arg_446_1.time_ >= var_449_13 + var_449_17 and arg_446_1.time_ < var_449_13 + var_449_17 + arg_449_0 then
				var_449_11.localPosition = var_449_14
				var_449_11.localRotation = var_449_15
				var_449_12.fieldOfView = var_449_16
			end

			local var_449_19 = arg_446_1.actors_["108502ui_story"].transform
			local var_449_20 = 0

			if var_449_20 < arg_446_1.time_ and arg_446_1.time_ <= var_449_20 + arg_449_0 then
				arg_446_1.var_.moveOldPos108502ui_story = var_449_19.localPosition
			end

			local var_449_21 = 0.001

			if var_449_20 <= arg_446_1.time_ and arg_446_1.time_ < var_449_20 + var_449_21 then
				local var_449_22 = (arg_446_1.time_ - var_449_20) / var_449_21
				local var_449_23 = Vector3.New(0, 100, 0)

				var_449_19.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos108502ui_story, var_449_23, var_449_22)

				local var_449_24 = manager.ui.mainCamera.transform.position - var_449_19.position

				var_449_19.forward = Vector3.New(var_449_24.x, var_449_24.y, var_449_24.z)

				local var_449_25 = var_449_19.localEulerAngles

				var_449_25.z = 0
				var_449_25.x = 0
				var_449_19.localEulerAngles = var_449_25
			end

			if arg_446_1.time_ >= var_449_20 + var_449_21 and arg_446_1.time_ < var_449_20 + var_449_21 + arg_449_0 then
				var_449_19.localPosition = Vector3.New(0, 100, 0)

				local var_449_26 = manager.ui.mainCamera.transform.position - var_449_19.position

				var_449_19.forward = Vector3.New(var_449_26.x, var_449_26.y, var_449_26.z)

				local var_449_27 = var_449_19.localEulerAngles

				var_449_27.z = 0
				var_449_27.x = 0
				var_449_19.localEulerAngles = var_449_27
			end

			local var_449_28 = manager.ui.mainCamera.transform
			local var_449_29 = 0

			if var_449_29 < arg_446_1.time_ and arg_446_1.time_ <= var_449_29 + arg_449_0 then
				local var_449_30 = arg_446_1.var_.effectyugy
				local var_449_31
				local var_449_32 = var_449_28

				if not var_449_30 then
					var_449_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_449_32)
					var_449_30.name = "yugy"
					arg_446_1.var_.effectyugy = var_449_30
				else
					var_449_30.transform:SetParent(var_449_32)
				end

				var_449_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_449_30.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_449_33 = manager.ui.mainCameraCom_
				local var_449_34 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_449_33.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_449_35 = var_449_30.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_449_36 = 15
				local var_449_37 = 2 * var_449_36 * Mathf.Tan(var_449_33.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_449_33.aspect
				local var_449_38 = 1
				local var_449_39 = 1.7777777777777777

				if var_449_39 < var_449_33.aspect then
					var_449_38 = var_449_37 / (2 * var_449_36 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_449_39)
				end

				for iter_449_0, iter_449_1 in ipairs(var_449_35) do
					local var_449_40 = iter_449_1.transform.localScale

					iter_449_1.transform.localScale = Vector3.New(var_449_40.x / var_449_34 * var_449_38, var_449_40.y / var_449_34, var_449_40.z)
				end
			end

			local var_449_41 = manager.ui.mainCamera.transform
			local var_449_42 = 2.10066666851441

			if var_449_42 < arg_446_1.time_ and arg_446_1.time_ <= var_449_42 + arg_449_0 then
				local var_449_43 = arg_446_1.var_.effectyugy

				if var_449_43 then
					Object.Destroy(var_449_43)

					arg_446_1.var_.effectyugy = nil
				end
			end

			local var_449_44 = manager.ui.mainCamera.transform
			local var_449_45 = 0

			if var_449_45 < arg_446_1.time_ and arg_446_1.time_ <= var_449_45 + arg_449_0 then
				local var_449_46 = arg_446_1.var_.effectdds
				local var_449_47
				local var_449_48 = var_449_44

				if not var_449_46 then
					var_449_46 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), var_449_48)
					var_449_46.name = "dds"
					arg_446_1.var_.effectdds = var_449_46
				else
					var_449_46.transform:SetParent(var_449_48)
				end

				var_449_46.transform.localPosition = Vector3.New(0, 0, 0)
				var_449_46.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_449_49 = manager.ui.mainCameraCom_
				local var_449_50 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_449_49.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_449_51 = var_449_46.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_449_52 = 15
				local var_449_53 = 2 * var_449_52 * Mathf.Tan(var_449_49.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_449_49.aspect
				local var_449_54 = 1
				local var_449_55 = 1.7777777777777777

				if var_449_55 < var_449_49.aspect then
					var_449_54 = var_449_53 / (2 * var_449_52 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_449_55)
				end

				for iter_449_2, iter_449_3 in ipairs(var_449_51) do
					local var_449_56 = iter_449_3.transform.localScale

					iter_449_3.transform.localScale = Vector3.New(var_449_56.x / var_449_50 * var_449_54, var_449_56.y / var_449_50, var_449_56.z)
				end
			end

			local var_449_57 = 0

			if var_449_57 < arg_446_1.time_ and arg_446_1.time_ <= var_449_57 + arg_449_0 then
				arg_446_1.allBtn_.enabled = false
			end

			local var_449_58 = 1.46666666666667

			if arg_446_1.time_ >= var_449_57 + var_449_58 and arg_446_1.time_ < var_449_57 + var_449_58 + arg_449_0 then
				arg_446_1.allBtn_.enabled = true
			end

			local var_449_59 = 0.034000001847744
			local var_449_60 = 1

			if var_449_59 < arg_446_1.time_ and arg_446_1.time_ <= var_449_59 + arg_449_0 then
				local var_449_61 = "play"
				local var_449_62 = "effect"

				arg_446_1:AudioAction(var_449_61, var_449_62, "se_story_145", "se_story_145_magic_whoosh01", "")
			end

			local var_449_63 = 0

			if var_449_63 < arg_446_1.time_ and arg_446_1.time_ <= var_449_63 + arg_449_0 then
				arg_446_1.mask_.enabled = true
				arg_446_1.mask_.raycastTarget = true

				arg_446_1:SetGaussion(false)
			end

			local var_449_64 = 0.433333333333333

			if var_449_63 <= arg_446_1.time_ and arg_446_1.time_ < var_449_63 + var_449_64 then
				local var_449_65 = (arg_446_1.time_ - var_449_63) / var_449_64
				local var_449_66 = Color.New(1, 1, 1)

				var_449_66.a = Mathf.Lerp(1, 0, var_449_65)
				arg_446_1.mask_.color = var_449_66
			end

			if arg_446_1.time_ >= var_449_63 + var_449_64 and arg_446_1.time_ < var_449_63 + var_449_64 + arg_449_0 then
				local var_449_67 = Color.New(1, 1, 1)
				local var_449_68 = 0

				arg_446_1.mask_.enabled = false
				var_449_67.a = var_449_68
				arg_446_1.mask_.color = var_449_67
			end

			if arg_446_1.frameCnt_ <= 1 then
				arg_446_1.dialog_:SetActive(false)
			end

			local var_449_69 = 1.36666666666667
			local var_449_70 = 1.125

			if var_449_69 < arg_446_1.time_ and arg_446_1.time_ <= var_449_69 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0

				arg_446_1.dialog_:SetActive(true)

				arg_446_1.dialogCg_.alpha = 0

				local var_449_71 = LeanTween.value(arg_446_1.dialog_, 0, 1, 0.3)

				var_449_71:setOnUpdate(LuaHelper.FloatAction(function(arg_450_0)
					arg_446_1.dialogCg_.alpha = arg_450_0
				end))
				var_449_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_446_1.dialog_)
					var_449_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_446_1.duration_ = arg_446_1.duration_ + 0.3

				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_72 = arg_446_1:GetWordFromCfg(928041106)
				local var_449_73 = arg_446_1:FormatText(var_449_72.content)

				arg_446_1.text_.text = var_449_73

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_74 = 45
				local var_449_75 = utf8.len(var_449_73)
				local var_449_76 = var_449_74 <= 0 and var_449_70 or var_449_70 * (var_449_75 / var_449_74)

				if var_449_76 > 0 and var_449_70 < var_449_76 then
					arg_446_1.talkMaxDuration = var_449_76
					var_449_69 = var_449_69 + 0.3

					if var_449_76 + var_449_69 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_76 + var_449_69
					end
				end

				arg_446_1.text_.text = var_449_73
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_77 = var_449_69 + 0.3
			local var_449_78 = math.max(var_449_70, arg_446_1.talkMaxDuration)

			if var_449_77 <= arg_446_1.time_ and arg_446_1.time_ < var_449_77 + var_449_78 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_77) / var_449_78

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_77 + var_449_78 and arg_446_1.time_ < var_449_77 + var_449_78 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108502ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play928041107 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 928041107
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play928041108(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0.566666666666667
			local var_455_1 = 1

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				local var_455_2 = "play"
				local var_455_3 = "effect"

				arg_452_1:AudioAction(var_455_2, var_455_3, "se_story_side_1084", "se_story_1084_applause", "")
			end

			local var_455_4 = 0
			local var_455_5 = 0.85

			if var_455_4 < arg_452_1.time_ and arg_452_1.time_ <= var_455_4 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_6 = arg_452_1:GetWordFromCfg(928041107)
				local var_455_7 = arg_452_1:FormatText(var_455_6.content)

				arg_452_1.text_.text = var_455_7

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_8 = 34
				local var_455_9 = utf8.len(var_455_7)
				local var_455_10 = var_455_8 <= 0 and var_455_5 or var_455_5 * (var_455_9 / var_455_8)

				if var_455_10 > 0 and var_455_5 < var_455_10 then
					arg_452_1.talkMaxDuration = var_455_10

					if var_455_10 + var_455_4 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_10 + var_455_4
					end
				end

				arg_452_1.text_.text = var_455_7
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_11 = math.max(var_455_5, arg_452_1.talkMaxDuration)

			if var_455_4 <= arg_452_1.time_ and arg_452_1.time_ < var_455_4 + var_455_11 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_4) / var_455_11

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_4 + var_455_11 and arg_452_1.time_ < var_455_4 + var_455_11 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play928041108 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 928041108
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play928041109(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0
			local var_459_1 = 0.3

			if var_459_0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				local var_459_2 = "play"
				local var_459_3 = "music"

				arg_456_1:AudioAction(var_459_2, var_459_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_459_4 = ""
				local var_459_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_459_5 ~= "" then
					if arg_456_1.bgmTxt_.text ~= var_459_5 and arg_456_1.bgmTxt_.text ~= "" then
						if arg_456_1.bgmTxt2_.text ~= "" then
							arg_456_1.bgmTxt_.text = arg_456_1.bgmTxt2_.text
						end

						arg_456_1.bgmTxt2_.text = var_459_5

						arg_456_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_456_1.bgmTxt_.text = var_459_5
						arg_456_1.bgmTxt2_.text = var_459_5
					end

					if arg_456_1.bgmTimer then
						arg_456_1.bgmTimer:Stop()

						arg_456_1.bgmTimer = nil
					end

					if arg_456_1.settingData.show_music_name == 1 then
						arg_456_1.musicController:SetSelectedState("show")
						arg_456_1.musicAnimator_:Play("open", 0, 0)

						if arg_456_1.settingData.music_time ~= 0 then
							arg_456_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_456_1.settingData.music_time), function()
								if arg_456_1 == nil or isNil(arg_456_1.bgmTxt_) then
									return
								end

								arg_456_1.musicController:SetSelectedState("hide")
								arg_456_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_459_6 = 0
			local var_459_7 = 0.625

			if var_459_6 < arg_456_1.time_ and arg_456_1.time_ <= var_459_6 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_8 = arg_456_1:GetWordFromCfg(928041108)
				local var_459_9 = arg_456_1:FormatText(var_459_8.content)

				arg_456_1.text_.text = var_459_9

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_10 = 25
				local var_459_11 = utf8.len(var_459_9)
				local var_459_12 = var_459_10 <= 0 and var_459_7 or var_459_7 * (var_459_11 / var_459_10)

				if var_459_12 > 0 and var_459_7 < var_459_12 then
					arg_456_1.talkMaxDuration = var_459_12

					if var_459_12 + var_459_6 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_12 + var_459_6
					end
				end

				arg_456_1.text_.text = var_459_9
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_13 = math.max(var_459_7, arg_456_1.talkMaxDuration)

			if var_459_6 <= arg_456_1.time_ and arg_456_1.time_ < var_459_6 + var_459_13 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_6) / var_459_13

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_6 + var_459_13 and arg_456_1.time_ < var_459_6 + var_459_13 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play928041109 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 928041109
		arg_461_1.duration_ = 7.27

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play928041110(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = "ST0514"

			if arg_461_1.bgs_[var_464_0] == nil then
				local var_464_1 = Object.Instantiate(arg_461_1.paintGo_)

				var_464_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_464_0)
				var_464_1.name = var_464_0
				var_464_1.transform.parent = arg_461_1.stage_.transform
				var_464_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_461_1.bgs_[var_464_0] = var_464_1
			end

			local var_464_2 = 1

			if var_464_2 < arg_461_1.time_ and arg_461_1.time_ <= var_464_2 + arg_464_0 then
				local var_464_3 = manager.ui.mainCamera.transform.localPosition
				local var_464_4 = Vector3.New(0, 0, 10) + Vector3.New(var_464_3.x, var_464_3.y, 0)
				local var_464_5 = arg_461_1.bgs_.ST0514

				var_464_5.transform.localPosition = var_464_4
				var_464_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_464_6 = var_464_5:GetComponent("SpriteRenderer")

				if var_464_6 and var_464_6.sprite then
					local var_464_7 = (var_464_5.transform.localPosition - var_464_3).z
					local var_464_8 = manager.ui.mainCameraCom_
					local var_464_9 = 2 * var_464_7 * Mathf.Tan(var_464_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_464_10 = var_464_9 * var_464_8.aspect
					local var_464_11 = var_464_6.sprite.bounds.size.x
					local var_464_12 = var_464_6.sprite.bounds.size.y
					local var_464_13 = var_464_10 / var_464_11
					local var_464_14 = var_464_9 / var_464_12
					local var_464_15 = var_464_14 < var_464_13 and var_464_13 or var_464_14

					var_464_5.transform.localScale = Vector3.New(var_464_15, var_464_15, 0)
				end

				for iter_464_0, iter_464_1 in pairs(arg_461_1.bgs_) do
					if iter_464_0 ~= "ST0514" then
						iter_464_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_464_16 = 0

			if var_464_16 < arg_461_1.time_ and arg_461_1.time_ <= var_464_16 + arg_464_0 then
				arg_461_1.allBtn_.enabled = false
			end

			local var_464_17 = 0.3

			if arg_461_1.time_ >= var_464_16 + var_464_17 and arg_461_1.time_ < var_464_16 + var_464_17 + arg_464_0 then
				arg_461_1.allBtn_.enabled = true
			end

			local var_464_18 = 0

			if var_464_18 < arg_461_1.time_ and arg_461_1.time_ <= var_464_18 + arg_464_0 then
				arg_461_1.mask_.enabled = true
				arg_461_1.mask_.raycastTarget = true

				arg_461_1:SetGaussion(false)
			end

			local var_464_19 = 1

			if var_464_18 <= arg_461_1.time_ and arg_461_1.time_ < var_464_18 + var_464_19 then
				local var_464_20 = (arg_461_1.time_ - var_464_18) / var_464_19
				local var_464_21 = Color.New(0, 0, 0)

				var_464_21.a = Mathf.Lerp(0, 1, var_464_20)
				arg_461_1.mask_.color = var_464_21
			end

			if arg_461_1.time_ >= var_464_18 + var_464_19 and arg_461_1.time_ < var_464_18 + var_464_19 + arg_464_0 then
				local var_464_22 = Color.New(0, 0, 0)

				var_464_22.a = 1
				arg_461_1.mask_.color = var_464_22
			end

			local var_464_23 = 1

			if var_464_23 < arg_461_1.time_ and arg_461_1.time_ <= var_464_23 + arg_464_0 then
				arg_461_1.mask_.enabled = true
				arg_461_1.mask_.raycastTarget = true

				arg_461_1:SetGaussion(false)
			end

			local var_464_24 = 1.26666666666667

			if var_464_23 <= arg_461_1.time_ and arg_461_1.time_ < var_464_23 + var_464_24 then
				local var_464_25 = (arg_461_1.time_ - var_464_23) / var_464_24
				local var_464_26 = Color.New(0, 0, 0)

				var_464_26.a = Mathf.Lerp(1, 0, var_464_25)
				arg_461_1.mask_.color = var_464_26
			end

			if arg_461_1.time_ >= var_464_23 + var_464_24 and arg_461_1.time_ < var_464_23 + var_464_24 + arg_464_0 then
				local var_464_27 = Color.New(0, 0, 0)
				local var_464_28 = 0

				arg_461_1.mask_.enabled = false
				var_464_27.a = var_464_28
				arg_461_1.mask_.color = var_464_27
			end

			local var_464_29 = arg_461_1.actors_["1080ui_story"].transform
			local var_464_30 = 1

			if var_464_30 < arg_461_1.time_ and arg_461_1.time_ <= var_464_30 + arg_464_0 then
				arg_461_1.var_.moveOldPos1080ui_story = var_464_29.localPosition
			end

			local var_464_31 = 0.001

			if var_464_30 <= arg_461_1.time_ and arg_461_1.time_ < var_464_30 + var_464_31 then
				local var_464_32 = (arg_461_1.time_ - var_464_30) / var_464_31
				local var_464_33 = Vector3.New(0, 100, 0)

				var_464_29.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1080ui_story, var_464_33, var_464_32)

				local var_464_34 = manager.ui.mainCamera.transform.position - var_464_29.position

				var_464_29.forward = Vector3.New(var_464_34.x, var_464_34.y, var_464_34.z)

				local var_464_35 = var_464_29.localEulerAngles

				var_464_35.z = 0
				var_464_35.x = 0
				var_464_29.localEulerAngles = var_464_35
			end

			if arg_461_1.time_ >= var_464_30 + var_464_31 and arg_461_1.time_ < var_464_30 + var_464_31 + arg_464_0 then
				var_464_29.localPosition = Vector3.New(0, 100, 0)

				local var_464_36 = manager.ui.mainCamera.transform.position - var_464_29.position

				var_464_29.forward = Vector3.New(var_464_36.x, var_464_36.y, var_464_36.z)

				local var_464_37 = var_464_29.localEulerAngles

				var_464_37.z = 0
				var_464_37.x = 0
				var_464_29.localEulerAngles = var_464_37
			end

			local var_464_38 = manager.ui.mainCamera.transform
			local var_464_39 = 1

			if var_464_39 < arg_461_1.time_ and arg_461_1.time_ <= var_464_39 + arg_464_0 then
				local var_464_40 = arg_461_1.var_.effectdds

				if var_464_40 then
					Object.Destroy(var_464_40)

					arg_461_1.var_.effectdds = nil
				end
			end

			local var_464_41 = 0.034000001847744
			local var_464_42 = 1

			if var_464_41 < arg_461_1.time_ and arg_461_1.time_ <= var_464_41 + arg_464_0 then
				local var_464_43 = "stop"
				local var_464_44 = "effect"

				arg_461_1:AudioAction(var_464_43, var_464_44, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_464_45 = 0.766666666666667
			local var_464_46 = 1

			if var_464_45 < arg_461_1.time_ and arg_461_1.time_ <= var_464_45 + arg_464_0 then
				local var_464_47 = "play"
				local var_464_48 = "effect"

				arg_461_1:AudioAction(var_464_47, var_464_48, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_464_49 = 0.766666666666667
			local var_464_50 = 1

			if var_464_49 < arg_461_1.time_ and arg_461_1.time_ <= var_464_49 + arg_464_0 then
				local var_464_51 = "play"
				local var_464_52 = "effect"

				arg_461_1:AudioAction(var_464_51, var_464_52, "se_story_145", "se_story_145_wind02", "")
			end

			local var_464_53 = 2.33333333333333
			local var_464_54 = 1

			if var_464_53 < arg_461_1.time_ and arg_461_1.time_ <= var_464_53 + arg_464_0 then
				local var_464_55 = "play"
				local var_464_56 = "effect"

				arg_461_1:AudioAction(var_464_55, var_464_56, "se_story_122_02", "se_story_122_02_footstep", "")
			end

			local var_464_57 = 1

			if var_464_57 < arg_461_1.time_ and arg_461_1.time_ <= var_464_57 + arg_464_0 then
				arg_461_1:DestroyPrefabSceneGo()
			end

			local var_464_58 = 1

			if var_464_58 < arg_461_1.time_ and arg_461_1.time_ <= var_464_58 + arg_464_0 then
				arg_461_1:CreatePrefabSceneGo("Levels/X205f2", Vector3.New(0, 0, 1.59), Vector3.New(0, 0, 0))
			end

			if arg_461_1.frameCnt_ <= 1 then
				arg_461_1.dialog_:SetActive(false)
			end

			local var_464_59 = 2.26666666666667
			local var_464_60 = 0.55

			if var_464_59 < arg_461_1.time_ and arg_461_1.time_ <= var_464_59 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0

				arg_461_1.dialog_:SetActive(true)

				arg_461_1.dialogCg_.alpha = 0

				local var_464_61 = LeanTween.value(arg_461_1.dialog_, 0, 1, 0.3)

				var_464_61:setOnUpdate(LuaHelper.FloatAction(function(arg_465_0)
					arg_461_1.dialogCg_.alpha = arg_465_0
				end))
				var_464_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_461_1.dialog_)
					var_464_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_461_1.duration_ = arg_461_1.duration_ + 0.3

				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_62 = arg_461_1:GetWordFromCfg(928041109)
				local var_464_63 = arg_461_1:FormatText(var_464_62.content)

				arg_461_1.text_.text = var_464_63

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_64 = 22
				local var_464_65 = utf8.len(var_464_63)
				local var_464_66 = var_464_64 <= 0 and var_464_60 or var_464_60 * (var_464_65 / var_464_64)

				if var_464_66 > 0 and var_464_60 < var_464_66 then
					arg_461_1.talkMaxDuration = var_464_66
					var_464_59 = var_464_59 + 0.3

					if var_464_66 + var_464_59 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_66 + var_464_59
					end
				end

				arg_461_1.text_.text = var_464_63
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_67 = var_464_59 + 0.3
			local var_464_68 = math.max(var_464_60, arg_461_1.talkMaxDuration)

			if var_464_67 <= arg_461_1.time_ and arg_461_1.time_ < var_464_67 + var_464_68 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_67) / var_464_68

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_67 + var_464_68 and arg_461_1.time_ < var_464_67 + var_464_68 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play928041110 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 928041110
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play928041111(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0
			local var_470_1 = 0.45

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_2 = arg_467_1:FormatText(StoryNameCfg[7].name)

				arg_467_1.leftNameTxt_.text = var_470_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_3 = arg_467_1:GetWordFromCfg(928041110)
				local var_470_4 = arg_467_1:FormatText(var_470_3.content)

				arg_467_1.text_.text = var_470_4

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_5 = 18
				local var_470_6 = utf8.len(var_470_4)
				local var_470_7 = var_470_5 <= 0 and var_470_1 or var_470_1 * (var_470_6 / var_470_5)

				if var_470_7 > 0 and var_470_1 < var_470_7 then
					arg_467_1.talkMaxDuration = var_470_7

					if var_470_7 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_7 + var_470_0
					end
				end

				arg_467_1.text_.text = var_470_4
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_8 = math.max(var_470_1, arg_467_1.talkMaxDuration)

			if var_470_0 <= arg_467_1.time_ and arg_467_1.time_ < var_470_0 + var_470_8 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_0) / var_470_8

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_0 + var_470_8 and arg_467_1.time_ < var_470_0 + var_470_8 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play928041111 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 928041111
		arg_471_1.duration_ = 7.83

		local var_471_0 = {
			zh = 6.83333333333333,
			ja = 7.83333333333333
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play928041112(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = arg_471_1.actors_["108502ui_story"].transform
			local var_474_1 = 0

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 then
				arg_471_1.var_.moveOldPos108502ui_story = var_474_0.localPosition
			end

			local var_474_2 = 0.001

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_2 then
				local var_474_3 = (arg_471_1.time_ - var_474_1) / var_474_2
				local var_474_4 = Vector3.New(0, -1.01, -5.83)

				var_474_0.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos108502ui_story, var_474_4, var_474_3)

				local var_474_5 = manager.ui.mainCamera.transform.position - var_474_0.position

				var_474_0.forward = Vector3.New(var_474_5.x, var_474_5.y, var_474_5.z)

				local var_474_6 = var_474_0.localEulerAngles

				var_474_6.z = 0
				var_474_6.x = 0
				var_474_0.localEulerAngles = var_474_6
			end

			if arg_471_1.time_ >= var_474_1 + var_474_2 and arg_471_1.time_ < var_474_1 + var_474_2 + arg_474_0 then
				var_474_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_474_7 = manager.ui.mainCamera.transform.position - var_474_0.position

				var_474_0.forward = Vector3.New(var_474_7.x, var_474_7.y, var_474_7.z)

				local var_474_8 = var_474_0.localEulerAngles

				var_474_8.z = 0
				var_474_8.x = 0
				var_474_0.localEulerAngles = var_474_8
			end

			local var_474_9 = arg_471_1.actors_["108502ui_story"]
			local var_474_10 = 0

			if var_474_10 < arg_471_1.time_ and arg_471_1.time_ <= var_474_10 + arg_474_0 and not isNil(var_474_9) and arg_471_1.var_.characterEffect108502ui_story == nil then
				arg_471_1.var_.characterEffect108502ui_story = var_474_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_11 = 0.200000002980232

			if var_474_10 <= arg_471_1.time_ and arg_471_1.time_ < var_474_10 + var_474_11 and not isNil(var_474_9) then
				local var_474_12 = (arg_471_1.time_ - var_474_10) / var_474_11

				if arg_471_1.var_.characterEffect108502ui_story and not isNil(var_474_9) then
					arg_471_1.var_.characterEffect108502ui_story.fillFlat = false
				end
			end

			if arg_471_1.time_ >= var_474_10 + var_474_11 and arg_471_1.time_ < var_474_10 + var_474_11 + arg_474_0 and not isNil(var_474_9) and arg_471_1.var_.characterEffect108502ui_story then
				arg_471_1.var_.characterEffect108502ui_story.fillFlat = false
			end

			local var_474_13 = 0

			if var_474_13 < arg_471_1.time_ and arg_471_1.time_ <= var_474_13 + arg_474_0 then
				arg_471_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/story108502/story108502action/108502action7_1")
			end

			local var_474_14 = 0

			if var_474_14 < arg_471_1.time_ and arg_471_1.time_ <= var_474_14 + arg_474_0 then
				arg_471_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_474_15 = 0
			local var_474_16 = 0.3

			if var_474_15 < arg_471_1.time_ and arg_471_1.time_ <= var_474_15 + arg_474_0 then
				local var_474_17 = "play"
				local var_474_18 = "music"

				arg_471_1:AudioAction(var_474_17, var_474_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_474_19 = ""
				local var_474_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_474_20 ~= "" then
					if arg_471_1.bgmTxt_.text ~= var_474_20 and arg_471_1.bgmTxt_.text ~= "" then
						if arg_471_1.bgmTxt2_.text ~= "" then
							arg_471_1.bgmTxt_.text = arg_471_1.bgmTxt2_.text
						end

						arg_471_1.bgmTxt2_.text = var_474_20

						arg_471_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_471_1.bgmTxt_.text = var_474_20
						arg_471_1.bgmTxt2_.text = var_474_20
					end

					if arg_471_1.bgmTimer then
						arg_471_1.bgmTimer:Stop()

						arg_471_1.bgmTimer = nil
					end

					if arg_471_1.settingData.show_music_name == 1 then
						arg_471_1.musicController:SetSelectedState("show")
						arg_471_1.musicAnimator_:Play("open", 0, 0)

						if arg_471_1.settingData.music_time ~= 0 then
							arg_471_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_471_1.settingData.music_time), function()
								if arg_471_1 == nil or isNil(arg_471_1.bgmTxt_) then
									return
								end

								arg_471_1.musicController:SetSelectedState("hide")
								arg_471_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_474_21 = 0.433333333333333
			local var_474_22 = 1

			if var_474_21 < arg_471_1.time_ and arg_471_1.time_ <= var_474_21 + arg_474_0 then
				local var_474_23 = "play"
				local var_474_24 = "music"

				arg_471_1:AudioAction(var_474_23, var_474_24, "bgm_activity_4_5_scene_108502_story", "bgm_activity_4_5_scene_108502_story", "bgm_activity_4_5_scene_108502_story.awb")

				local var_474_25 = ""
				local var_474_26 = manager.audio:GetAudioName("bgm_activity_4_5_scene_108502_story", "bgm_activity_4_5_scene_108502_story")

				if var_474_26 ~= "" then
					if arg_471_1.bgmTxt_.text ~= var_474_26 and arg_471_1.bgmTxt_.text ~= "" then
						if arg_471_1.bgmTxt2_.text ~= "" then
							arg_471_1.bgmTxt_.text = arg_471_1.bgmTxt2_.text
						end

						arg_471_1.bgmTxt2_.text = var_474_26

						arg_471_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_471_1.bgmTxt_.text = var_474_26
						arg_471_1.bgmTxt2_.text = var_474_26
					end

					if arg_471_1.bgmTimer then
						arg_471_1.bgmTimer:Stop()

						arg_471_1.bgmTimer = nil
					end

					if arg_471_1.settingData.show_music_name == 1 then
						arg_471_1.musicController:SetSelectedState("show")
						arg_471_1.musicAnimator_:Play("open", 0, 0)

						if arg_471_1.settingData.music_time ~= 0 then
							arg_471_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_471_1.settingData.music_time), function()
								if arg_471_1 == nil or isNil(arg_471_1.bgmTxt_) then
									return
								end

								arg_471_1.musicController:SetSelectedState("hide")
								arg_471_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_471_1.frameCnt_ <= 1 then
				arg_471_1.dialog_:SetActive(false)
			end

			local var_474_27 = 0.333333333333333
			local var_474_28 = 0.425

			if var_474_27 < arg_471_1.time_ and arg_471_1.time_ <= var_474_27 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0

				arg_471_1.dialog_:SetActive(true)

				arg_471_1.dialogCg_.alpha = 0

				local var_474_29 = LeanTween.value(arg_471_1.dialog_, 0, 1, 0.3)

				var_474_29:setOnUpdate(LuaHelper.FloatAction(function(arg_477_0)
					arg_471_1.dialogCg_.alpha = arg_477_0
				end))
				var_474_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_471_1.dialog_)
					var_474_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_471_1.duration_ = arg_471_1.duration_ + 0.3

				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_30 = arg_471_1:FormatText(StoryNameCfg[328].name)

				arg_471_1.leftNameTxt_.text = var_474_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_31 = arg_471_1:GetWordFromCfg(928041111)
				local var_474_32 = arg_471_1:FormatText(var_474_31.content)

				arg_471_1.text_.text = var_474_32

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_33 = 17
				local var_474_34 = utf8.len(var_474_32)
				local var_474_35 = var_474_33 <= 0 and var_474_28 or var_474_28 * (var_474_34 / var_474_33)

				if var_474_35 > 0 and var_474_28 < var_474_35 then
					arg_471_1.talkMaxDuration = var_474_35
					var_474_27 = var_474_27 + 0.3

					if var_474_35 + var_474_27 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_35 + var_474_27
					end
				end

				arg_471_1.text_.text = var_474_32
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041111", "story_v_side_old_928041.awb") ~= 0 then
					local var_474_36 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041111", "story_v_side_old_928041.awb") / 1000

					if var_474_36 + var_474_27 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_36 + var_474_27
					end

					if var_474_31.prefab_name ~= "" and arg_471_1.actors_[var_474_31.prefab_name] ~= nil then
						local var_474_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_31.prefab_name].transform, "story_v_side_old_928041", "928041111", "story_v_side_old_928041.awb")

						arg_471_1:RecordAudio("928041111", var_474_37)
						arg_471_1:RecordAudio("928041111", var_474_37)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041111", "story_v_side_old_928041.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041111", "story_v_side_old_928041.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_38 = var_474_27 + 0.3
			local var_474_39 = math.max(var_474_28, arg_471_1.talkMaxDuration)

			if var_474_38 <= arg_471_1.time_ and arg_471_1.time_ < var_474_38 + var_474_39 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_38) / var_474_39

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_38 + var_474_39 and arg_471_1.time_ < var_474_38 + var_474_39 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108502ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play928041112 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 928041112
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play928041113(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["108502ui_story"]
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.characterEffect108502ui_story == nil then
				arg_479_1.var_.characterEffect108502ui_story = var_482_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_2 = 0.200000002980232

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_2 and not isNil(var_482_0) then
				local var_482_3 = (arg_479_1.time_ - var_482_1) / var_482_2

				if arg_479_1.var_.characterEffect108502ui_story and not isNil(var_482_0) then
					local var_482_4 = Mathf.Lerp(0, 0.5, var_482_3)

					arg_479_1.var_.characterEffect108502ui_story.fillFlat = true
					arg_479_1.var_.characterEffect108502ui_story.fillRatio = var_482_4
				end
			end

			if arg_479_1.time_ >= var_482_1 + var_482_2 and arg_479_1.time_ < var_482_1 + var_482_2 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.characterEffect108502ui_story then
				local var_482_5 = 0.5

				arg_479_1.var_.characterEffect108502ui_story.fillFlat = true
				arg_479_1.var_.characterEffect108502ui_story.fillRatio = var_482_5
			end

			local var_482_6 = 0
			local var_482_7 = 0.65

			if var_482_6 < arg_479_1.time_ and arg_479_1.time_ <= var_482_6 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_8 = arg_479_1:FormatText(StoryNameCfg[7].name)

				arg_479_1.leftNameTxt_.text = var_482_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_9 = arg_479_1:GetWordFromCfg(928041112)
				local var_482_10 = arg_479_1:FormatText(var_482_9.content)

				arg_479_1.text_.text = var_482_10

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_11 = 26
				local var_482_12 = utf8.len(var_482_10)
				local var_482_13 = var_482_11 <= 0 and var_482_7 or var_482_7 * (var_482_12 / var_482_11)

				if var_482_13 > 0 and var_482_7 < var_482_13 then
					arg_479_1.talkMaxDuration = var_482_13

					if var_482_13 + var_482_6 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_13 + var_482_6
					end
				end

				arg_479_1.text_.text = var_482_10
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_14 = math.max(var_482_7, arg_479_1.talkMaxDuration)

			if var_482_6 <= arg_479_1.time_ and arg_479_1.time_ < var_482_6 + var_482_14 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_6) / var_482_14

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_6 + var_482_14 and arg_479_1.time_ < var_482_6 + var_482_14 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play928041113 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 928041113
		arg_483_1.duration_ = 9.43

		local var_483_0 = {
			zh = 7.3,
			ja = 9.433
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play928041114(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = arg_483_1.actors_["108502ui_story"]
			local var_486_1 = 0

			if var_486_1 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 and not isNil(var_486_0) and arg_483_1.var_.characterEffect108502ui_story == nil then
				arg_483_1.var_.characterEffect108502ui_story = var_486_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_2 = 0.200000002980232

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_2 and not isNil(var_486_0) then
				local var_486_3 = (arg_483_1.time_ - var_486_1) / var_486_2

				if arg_483_1.var_.characterEffect108502ui_story and not isNil(var_486_0) then
					arg_483_1.var_.characterEffect108502ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= var_486_1 + var_486_2 and arg_483_1.time_ < var_486_1 + var_486_2 + arg_486_0 and not isNil(var_486_0) and arg_483_1.var_.characterEffect108502ui_story then
				arg_483_1.var_.characterEffect108502ui_story.fillFlat = false
			end

			local var_486_4 = 0
			local var_486_5 = 0.675

			if var_486_4 < arg_483_1.time_ and arg_483_1.time_ <= var_486_4 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_6 = arg_483_1:FormatText(StoryNameCfg[328].name)

				arg_483_1.leftNameTxt_.text = var_486_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_7 = arg_483_1:GetWordFromCfg(928041113)
				local var_486_8 = arg_483_1:FormatText(var_486_7.content)

				arg_483_1.text_.text = var_486_8

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_9 = 27
				local var_486_10 = utf8.len(var_486_8)
				local var_486_11 = var_486_9 <= 0 and var_486_5 or var_486_5 * (var_486_10 / var_486_9)

				if var_486_11 > 0 and var_486_5 < var_486_11 then
					arg_483_1.talkMaxDuration = var_486_11

					if var_486_11 + var_486_4 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_11 + var_486_4
					end
				end

				arg_483_1.text_.text = var_486_8
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041113", "story_v_side_old_928041.awb") ~= 0 then
					local var_486_12 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041113", "story_v_side_old_928041.awb") / 1000

					if var_486_12 + var_486_4 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_12 + var_486_4
					end

					if var_486_7.prefab_name ~= "" and arg_483_1.actors_[var_486_7.prefab_name] ~= nil then
						local var_486_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_7.prefab_name].transform, "story_v_side_old_928041", "928041113", "story_v_side_old_928041.awb")

						arg_483_1:RecordAudio("928041113", var_486_13)
						arg_483_1:RecordAudio("928041113", var_486_13)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041113", "story_v_side_old_928041.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041113", "story_v_side_old_928041.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_14 = math.max(var_486_5, arg_483_1.talkMaxDuration)

			if var_486_4 <= arg_483_1.time_ and arg_483_1.time_ < var_486_4 + var_486_14 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_4) / var_486_14

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_4 + var_486_14 and arg_483_1.time_ < var_486_4 + var_486_14 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play928041114 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 928041114
		arg_487_1.duration_ = 15.33

		local var_487_0 = {
			zh = 8.2,
			ja = 15.333
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play928041115(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/story108502/story108502actionlink/108502action479")
			end

			local var_490_1 = 0

			if var_490_1 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_490_2 = 0
			local var_490_3 = 0.85

			if var_490_2 < arg_487_1.time_ and arg_487_1.time_ <= var_490_2 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_4 = arg_487_1:FormatText(StoryNameCfg[328].name)

				arg_487_1.leftNameTxt_.text = var_490_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_5 = arg_487_1:GetWordFromCfg(928041114)
				local var_490_6 = arg_487_1:FormatText(var_490_5.content)

				arg_487_1.text_.text = var_490_6

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_7 = 34
				local var_490_8 = utf8.len(var_490_6)
				local var_490_9 = var_490_7 <= 0 and var_490_3 or var_490_3 * (var_490_8 / var_490_7)

				if var_490_9 > 0 and var_490_3 < var_490_9 then
					arg_487_1.talkMaxDuration = var_490_9

					if var_490_9 + var_490_2 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_9 + var_490_2
					end
				end

				arg_487_1.text_.text = var_490_6
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041114", "story_v_side_old_928041.awb") ~= 0 then
					local var_490_10 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041114", "story_v_side_old_928041.awb") / 1000

					if var_490_10 + var_490_2 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_10 + var_490_2
					end

					if var_490_5.prefab_name ~= "" and arg_487_1.actors_[var_490_5.prefab_name] ~= nil then
						local var_490_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_5.prefab_name].transform, "story_v_side_old_928041", "928041114", "story_v_side_old_928041.awb")

						arg_487_1:RecordAudio("928041114", var_490_11)
						arg_487_1:RecordAudio("928041114", var_490_11)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041114", "story_v_side_old_928041.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041114", "story_v_side_old_928041.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_12 = math.max(var_490_3, arg_487_1.talkMaxDuration)

			if var_490_2 <= arg_487_1.time_ and arg_487_1.time_ < var_490_2 + var_490_12 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_2) / var_490_12

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_2 + var_490_12 and arg_487_1.time_ < var_490_2 + var_490_12 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play928041115 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 928041115
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play928041116(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["108502ui_story"]
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.characterEffect108502ui_story == nil then
				arg_491_1.var_.characterEffect108502ui_story = var_494_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_2 = 0.200000002980232

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_2 and not isNil(var_494_0) then
				local var_494_3 = (arg_491_1.time_ - var_494_1) / var_494_2

				if arg_491_1.var_.characterEffect108502ui_story and not isNil(var_494_0) then
					local var_494_4 = Mathf.Lerp(0, 0.5, var_494_3)

					arg_491_1.var_.characterEffect108502ui_story.fillFlat = true
					arg_491_1.var_.characterEffect108502ui_story.fillRatio = var_494_4
				end
			end

			if arg_491_1.time_ >= var_494_1 + var_494_2 and arg_491_1.time_ < var_494_1 + var_494_2 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.characterEffect108502ui_story then
				local var_494_5 = 0.5

				arg_491_1.var_.characterEffect108502ui_story.fillFlat = true
				arg_491_1.var_.characterEffect108502ui_story.fillRatio = var_494_5
			end

			local var_494_6 = 0
			local var_494_7 = 0.65

			if var_494_6 < arg_491_1.time_ and arg_491_1.time_ <= var_494_6 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_8 = arg_491_1:FormatText(StoryNameCfg[7].name)

				arg_491_1.leftNameTxt_.text = var_494_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, true)
				arg_491_1.iconController_:SetSelectedState("hero")

				arg_491_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_491_1.callingController_:SetSelectedState("normal")

				arg_491_1.keyicon_.color = Color.New(1, 1, 1)
				arg_491_1.icon_.color = Color.New(1, 1, 1)

				local var_494_9 = arg_491_1:GetWordFromCfg(928041115)
				local var_494_10 = arg_491_1:FormatText(var_494_9.content)

				arg_491_1.text_.text = var_494_10

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_11 = 26
				local var_494_12 = utf8.len(var_494_10)
				local var_494_13 = var_494_11 <= 0 and var_494_7 or var_494_7 * (var_494_12 / var_494_11)

				if var_494_13 > 0 and var_494_7 < var_494_13 then
					arg_491_1.talkMaxDuration = var_494_13

					if var_494_13 + var_494_6 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_13 + var_494_6
					end
				end

				arg_491_1.text_.text = var_494_10
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_14 = math.max(var_494_7, arg_491_1.talkMaxDuration)

			if var_494_6 <= arg_491_1.time_ and arg_491_1.time_ < var_494_6 + var_494_14 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_6) / var_494_14

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_6 + var_494_14 and arg_491_1.time_ < var_494_6 + var_494_14 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play928041116 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 928041116
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play928041117(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = arg_495_1.actors_["108502ui_story"].transform
			local var_498_1 = 0

			if var_498_1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 then
				arg_495_1.var_.moveOldPos108502ui_story = var_498_0.localPosition
			end

			local var_498_2 = 0.001

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_2 then
				local var_498_3 = (arg_495_1.time_ - var_498_1) / var_498_2
				local var_498_4 = Vector3.New(0, 100, 0)

				var_498_0.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos108502ui_story, var_498_4, var_498_3)

				local var_498_5 = manager.ui.mainCamera.transform.position - var_498_0.position

				var_498_0.forward = Vector3.New(var_498_5.x, var_498_5.y, var_498_5.z)

				local var_498_6 = var_498_0.localEulerAngles

				var_498_6.z = 0
				var_498_6.x = 0
				var_498_0.localEulerAngles = var_498_6
			end

			if arg_495_1.time_ >= var_498_1 + var_498_2 and arg_495_1.time_ < var_498_1 + var_498_2 + arg_498_0 then
				var_498_0.localPosition = Vector3.New(0, 100, 0)

				local var_498_7 = manager.ui.mainCamera.transform.position - var_498_0.position

				var_498_0.forward = Vector3.New(var_498_7.x, var_498_7.y, var_498_7.z)

				local var_498_8 = var_498_0.localEulerAngles

				var_498_8.z = 0
				var_498_8.x = 0
				var_498_0.localEulerAngles = var_498_8
			end

			local var_498_9 = 0
			local var_498_10 = 1.125

			if var_498_9 < arg_495_1.time_ and arg_495_1.time_ <= var_498_9 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_11 = arg_495_1:GetWordFromCfg(928041116)
				local var_498_12 = arg_495_1:FormatText(var_498_11.content)

				arg_495_1.text_.text = var_498_12

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_13 = 45
				local var_498_14 = utf8.len(var_498_12)
				local var_498_15 = var_498_13 <= 0 and var_498_10 or var_498_10 * (var_498_14 / var_498_13)

				if var_498_15 > 0 and var_498_10 < var_498_15 then
					arg_495_1.talkMaxDuration = var_498_15

					if var_498_15 + var_498_9 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_15 + var_498_9
					end
				end

				arg_495_1.text_.text = var_498_12
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_16 = math.max(var_498_10, arg_495_1.talkMaxDuration)

			if var_498_9 <= arg_495_1.time_ and arg_495_1.time_ < var_498_9 + var_498_16 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_9) / var_498_16

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_9 + var_498_16 and arg_495_1.time_ < var_498_9 + var_498_16 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108502ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play928041117 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 928041117
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play928041118(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0
			local var_502_1 = 1.075

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_2 = arg_499_1:GetWordFromCfg(928041117)
				local var_502_3 = arg_499_1:FormatText(var_502_2.content)

				arg_499_1.text_.text = var_502_3

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 43
				local var_502_5 = utf8.len(var_502_3)
				local var_502_6 = var_502_4 <= 0 and var_502_1 or var_502_1 * (var_502_5 / var_502_4)

				if var_502_6 > 0 and var_502_1 < var_502_6 then
					arg_499_1.talkMaxDuration = var_502_6

					if var_502_6 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_6 + var_502_0
					end
				end

				arg_499_1.text_.text = var_502_3
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_1, arg_499_1.talkMaxDuration)

			if var_502_0 <= arg_499_1.time_ and arg_499_1.time_ < var_502_0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_0 + var_502_7 and arg_499_1.time_ < var_502_0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play928041118 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 928041118
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play928041119(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0
			local var_506_1 = 0.675

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_2 = arg_503_1:FormatText(StoryNameCfg[7].name)

				arg_503_1.leftNameTxt_.text = var_506_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_3 = arg_503_1:GetWordFromCfg(928041118)
				local var_506_4 = arg_503_1:FormatText(var_506_3.content)

				arg_503_1.text_.text = var_506_4

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 27
				local var_506_6 = utf8.len(var_506_4)
				local var_506_7 = var_506_5 <= 0 and var_506_1 or var_506_1 * (var_506_6 / var_506_5)

				if var_506_7 > 0 and var_506_1 < var_506_7 then
					arg_503_1.talkMaxDuration = var_506_7

					if var_506_7 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_7 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_4
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_8 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_8 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_8

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_8 and arg_503_1.time_ < var_506_0 + var_506_8 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play928041119 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 928041119
		arg_507_1.duration_ = 13.3

		local var_507_0 = {
			zh = 9.433,
			ja = 13.3
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play928041120(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = arg_507_1.actors_["108502ui_story"].transform
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.var_.moveOldPos108502ui_story = var_510_0.localPosition
			end

			local var_510_2 = 0.001

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / var_510_2
				local var_510_4 = Vector3.New(0, -1.01, -5.83)

				var_510_0.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos108502ui_story, var_510_4, var_510_3)

				local var_510_5 = manager.ui.mainCamera.transform.position - var_510_0.position

				var_510_0.forward = Vector3.New(var_510_5.x, var_510_5.y, var_510_5.z)

				local var_510_6 = var_510_0.localEulerAngles

				var_510_6.z = 0
				var_510_6.x = 0
				var_510_0.localEulerAngles = var_510_6
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 then
				var_510_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_510_7 = manager.ui.mainCamera.transform.position - var_510_0.position

				var_510_0.forward = Vector3.New(var_510_7.x, var_510_7.y, var_510_7.z)

				local var_510_8 = var_510_0.localEulerAngles

				var_510_8.z = 0
				var_510_8.x = 0
				var_510_0.localEulerAngles = var_510_8
			end

			local var_510_9 = arg_507_1.actors_["108502ui_story"]
			local var_510_10 = 0

			if var_510_10 < arg_507_1.time_ and arg_507_1.time_ <= var_510_10 + arg_510_0 and not isNil(var_510_9) and arg_507_1.var_.characterEffect108502ui_story == nil then
				arg_507_1.var_.characterEffect108502ui_story = var_510_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_11 = 0.200000002980232

			if var_510_10 <= arg_507_1.time_ and arg_507_1.time_ < var_510_10 + var_510_11 and not isNil(var_510_9) then
				local var_510_12 = (arg_507_1.time_ - var_510_10) / var_510_11

				if arg_507_1.var_.characterEffect108502ui_story and not isNil(var_510_9) then
					arg_507_1.var_.characterEffect108502ui_story.fillFlat = false
				end
			end

			if arg_507_1.time_ >= var_510_10 + var_510_11 and arg_507_1.time_ < var_510_10 + var_510_11 + arg_510_0 and not isNil(var_510_9) and arg_507_1.var_.characterEffect108502ui_story then
				arg_507_1.var_.characterEffect108502ui_story.fillFlat = false
			end

			local var_510_13 = 0

			if var_510_13 < arg_507_1.time_ and arg_507_1.time_ <= var_510_13 + arg_510_0 then
				arg_507_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/story108502/story108502action/108502action9_2")
			end

			local var_510_14 = 0

			if var_510_14 < arg_507_1.time_ and arg_507_1.time_ <= var_510_14 + arg_510_0 then
				arg_507_1:PlayTimeline("108502ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_510_15 = 0
			local var_510_16 = 0.9

			if var_510_15 < arg_507_1.time_ and arg_507_1.time_ <= var_510_15 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_17 = arg_507_1:FormatText(StoryNameCfg[328].name)

				arg_507_1.leftNameTxt_.text = var_510_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_18 = arg_507_1:GetWordFromCfg(928041119)
				local var_510_19 = arg_507_1:FormatText(var_510_18.content)

				arg_507_1.text_.text = var_510_19

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_20 = 36
				local var_510_21 = utf8.len(var_510_19)
				local var_510_22 = var_510_20 <= 0 and var_510_16 or var_510_16 * (var_510_21 / var_510_20)

				if var_510_22 > 0 and var_510_16 < var_510_22 then
					arg_507_1.talkMaxDuration = var_510_22

					if var_510_22 + var_510_15 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_22 + var_510_15
					end
				end

				arg_507_1.text_.text = var_510_19
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041119", "story_v_side_old_928041.awb") ~= 0 then
					local var_510_23 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041119", "story_v_side_old_928041.awb") / 1000

					if var_510_23 + var_510_15 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_23 + var_510_15
					end

					if var_510_18.prefab_name ~= "" and arg_507_1.actors_[var_510_18.prefab_name] ~= nil then
						local var_510_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_18.prefab_name].transform, "story_v_side_old_928041", "928041119", "story_v_side_old_928041.awb")

						arg_507_1:RecordAudio("928041119", var_510_24)
						arg_507_1:RecordAudio("928041119", var_510_24)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041119", "story_v_side_old_928041.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041119", "story_v_side_old_928041.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_25 = math.max(var_510_16, arg_507_1.talkMaxDuration)

			if var_510_15 <= arg_507_1.time_ and arg_507_1.time_ < var_510_15 + var_510_25 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_15) / var_510_25

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_15 + var_510_25 and arg_507_1.time_ < var_510_15 + var_510_25 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108502ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play928041120 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 928041120
		arg_511_1.duration_ = 10.13

		local var_511_0 = {
			zh = 7.8,
			ja = 10.133
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play928041121(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0
			local var_514_1 = 0.6

			if var_514_0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_2 = arg_511_1:FormatText(StoryNameCfg[328].name)

				arg_511_1.leftNameTxt_.text = var_514_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_3 = arg_511_1:GetWordFromCfg(928041120)
				local var_514_4 = arg_511_1:FormatText(var_514_3.content)

				arg_511_1.text_.text = var_514_4

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 27
				local var_514_6 = utf8.len(var_514_4)
				local var_514_7 = var_514_5 <= 0 and var_514_1 or var_514_1 * (var_514_6 / var_514_5)

				if var_514_7 > 0 and var_514_1 < var_514_7 then
					arg_511_1.talkMaxDuration = var_514_7

					if var_514_7 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_7 + var_514_0
					end
				end

				arg_511_1.text_.text = var_514_4
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041120", "story_v_side_old_928041.awb") ~= 0 then
					local var_514_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041120", "story_v_side_old_928041.awb") / 1000

					if var_514_8 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_8 + var_514_0
					end

					if var_514_3.prefab_name ~= "" and arg_511_1.actors_[var_514_3.prefab_name] ~= nil then
						local var_514_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_3.prefab_name].transform, "story_v_side_old_928041", "928041120", "story_v_side_old_928041.awb")

						arg_511_1:RecordAudio("928041120", var_514_9)
						arg_511_1:RecordAudio("928041120", var_514_9)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041120", "story_v_side_old_928041.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041120", "story_v_side_old_928041.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_10 = math.max(var_514_1, arg_511_1.talkMaxDuration)

			if var_514_0 <= arg_511_1.time_ and arg_511_1.time_ < var_514_0 + var_514_10 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_0) / var_514_10

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_0 + var_514_10 and arg_511_1.time_ < var_514_0 + var_514_10 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play928041121 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 928041121
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play928041122(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["108502ui_story"]
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.characterEffect108502ui_story == nil then
				arg_515_1.var_.characterEffect108502ui_story = var_518_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_2 = 0.200000002980232

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 and not isNil(var_518_0) then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2

				if arg_515_1.var_.characterEffect108502ui_story and not isNil(var_518_0) then
					local var_518_4 = Mathf.Lerp(0, 0.5, var_518_3)

					arg_515_1.var_.characterEffect108502ui_story.fillFlat = true
					arg_515_1.var_.characterEffect108502ui_story.fillRatio = var_518_4
				end
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.characterEffect108502ui_story then
				local var_518_5 = 0.5

				arg_515_1.var_.characterEffect108502ui_story.fillFlat = true
				arg_515_1.var_.characterEffect108502ui_story.fillRatio = var_518_5
			end

			local var_518_6 = 0
			local var_518_7 = 1.15

			if var_518_6 < arg_515_1.time_ and arg_515_1.time_ <= var_518_6 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_8 = arg_515_1:FormatText(StoryNameCfg[7].name)

				arg_515_1.leftNameTxt_.text = var_518_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_9 = arg_515_1:GetWordFromCfg(928041121)
				local var_518_10 = arg_515_1:FormatText(var_518_9.content)

				arg_515_1.text_.text = var_518_10

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_11 = 46
				local var_518_12 = utf8.len(var_518_10)
				local var_518_13 = var_518_11 <= 0 and var_518_7 or var_518_7 * (var_518_12 / var_518_11)

				if var_518_13 > 0 and var_518_7 < var_518_13 then
					arg_515_1.talkMaxDuration = var_518_13

					if var_518_13 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_13 + var_518_6
					end
				end

				arg_515_1.text_.text = var_518_10
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_14 = math.max(var_518_7, arg_515_1.talkMaxDuration)

			if var_518_6 <= arg_515_1.time_ and arg_515_1.time_ < var_518_6 + var_518_14 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_6) / var_518_14

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_6 + var_518_14 and arg_515_1.time_ < var_518_6 + var_518_14 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play928041122 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 928041122
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play928041123(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["108502ui_story"].transform
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 then
				arg_519_1.var_.moveOldPos108502ui_story = var_522_0.localPosition
			end

			local var_522_2 = 0.001

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2
				local var_522_4 = Vector3.New(0, 100, 0)

				var_522_0.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos108502ui_story, var_522_4, var_522_3)

				local var_522_5 = manager.ui.mainCamera.transform.position - var_522_0.position

				var_522_0.forward = Vector3.New(var_522_5.x, var_522_5.y, var_522_5.z)

				local var_522_6 = var_522_0.localEulerAngles

				var_522_6.z = 0
				var_522_6.x = 0
				var_522_0.localEulerAngles = var_522_6
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 then
				var_522_0.localPosition = Vector3.New(0, 100, 0)

				local var_522_7 = manager.ui.mainCamera.transform.position - var_522_0.position

				var_522_0.forward = Vector3.New(var_522_7.x, var_522_7.y, var_522_7.z)

				local var_522_8 = var_522_0.localEulerAngles

				var_522_8.z = 0
				var_522_8.x = 0
				var_522_0.localEulerAngles = var_522_8
			end

			local var_522_9 = 0
			local var_522_10 = 1.1

			if var_522_9 < arg_519_1.time_ and arg_519_1.time_ <= var_522_9 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, false)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_11 = arg_519_1:GetWordFromCfg(928041122)
				local var_522_12 = arg_519_1:FormatText(var_522_11.content)

				arg_519_1.text_.text = var_522_12

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_13 = 44
				local var_522_14 = utf8.len(var_522_12)
				local var_522_15 = var_522_13 <= 0 and var_522_10 or var_522_10 * (var_522_14 / var_522_13)

				if var_522_15 > 0 and var_522_10 < var_522_15 then
					arg_519_1.talkMaxDuration = var_522_15

					if var_522_15 + var_522_9 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_15 + var_522_9
					end
				end

				arg_519_1.text_.text = var_522_12
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_16 = math.max(var_522_10, arg_519_1.talkMaxDuration)

			if var_522_9 <= arg_519_1.time_ and arg_519_1.time_ < var_522_9 + var_522_16 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_9) / var_522_16

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_9 + var_522_16 and arg_519_1.time_ < var_522_9 + var_522_16 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108502ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play928041123 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 928041123
		arg_523_1.duration_ = 8.87

		local var_523_0 = {
			zh = 7.866666666666,
			ja = 8.866666666666
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play928041124(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = "SP92801"

			if arg_523_1.bgs_[var_526_0] == nil then
				local var_526_1 = Object.Instantiate(arg_523_1.paintGo_)

				var_526_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_526_0)
				var_526_1.name = var_526_0
				var_526_1.transform.parent = arg_523_1.stage_.transform
				var_526_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_523_1.bgs_[var_526_0] = var_526_1
			end

			local var_526_2 = 1.98333333333333

			if var_526_2 < arg_523_1.time_ and arg_523_1.time_ <= var_526_2 + arg_526_0 then
				local var_526_3 = manager.ui.mainCamera.transform.localPosition
				local var_526_4 = Vector3.New(0, 0, 10) + Vector3.New(var_526_3.x, var_526_3.y, 0)
				local var_526_5 = arg_523_1.bgs_.SP92801

				var_526_5.transform.localPosition = var_526_4
				var_526_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_526_6 = var_526_5:GetComponent("SpriteRenderer")

				if var_526_6 and var_526_6.sprite then
					local var_526_7 = (var_526_5.transform.localPosition - var_526_3).z
					local var_526_8 = manager.ui.mainCameraCom_
					local var_526_9 = 2 * var_526_7 * Mathf.Tan(var_526_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_526_10 = var_526_9 * var_526_8.aspect
					local var_526_11 = var_526_6.sprite.bounds.size.x
					local var_526_12 = var_526_6.sprite.bounds.size.y
					local var_526_13 = var_526_10 / var_526_11
					local var_526_14 = var_526_9 / var_526_12
					local var_526_15 = var_526_14 < var_526_13 and var_526_13 or var_526_14

					var_526_5.transform.localScale = Vector3.New(var_526_15, var_526_15, 0)
				end

				for iter_526_0, iter_526_1 in pairs(arg_523_1.bgs_) do
					if iter_526_0 ~= "SP92801" then
						iter_526_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_526_16 = 0

			if var_526_16 < arg_523_1.time_ and arg_523_1.time_ <= var_526_16 + arg_526_0 then
				arg_523_1.allBtn_.enabled = false
			end

			local var_526_17 = 0.3

			if arg_523_1.time_ >= var_526_16 + var_526_17 and arg_523_1.time_ < var_526_16 + var_526_17 + arg_526_0 then
				arg_523_1.allBtn_.enabled = true
			end

			local var_526_18 = 0

			if var_526_18 < arg_523_1.time_ and arg_523_1.time_ <= var_526_18 + arg_526_0 then
				arg_523_1.mask_.enabled = true
				arg_523_1.mask_.raycastTarget = true

				arg_523_1:SetGaussion(false)
			end

			local var_526_19 = 2

			if var_526_18 <= arg_523_1.time_ and arg_523_1.time_ < var_526_18 + var_526_19 then
				local var_526_20 = (arg_523_1.time_ - var_526_18) / var_526_19
				local var_526_21 = Color.New(0, 0, 0)

				var_526_21.a = Mathf.Lerp(0, 1, var_526_20)
				arg_523_1.mask_.color = var_526_21
			end

			if arg_523_1.time_ >= var_526_18 + var_526_19 and arg_523_1.time_ < var_526_18 + var_526_19 + arg_526_0 then
				local var_526_22 = Color.New(0, 0, 0)

				var_526_22.a = 1
				arg_523_1.mask_.color = var_526_22
			end

			local var_526_23 = 2

			if var_526_23 < arg_523_1.time_ and arg_523_1.time_ <= var_526_23 + arg_526_0 then
				arg_523_1.mask_.enabled = true
				arg_523_1.mask_.raycastTarget = true

				arg_523_1:SetGaussion(false)
			end

			local var_526_24 = 2

			if var_526_23 <= arg_523_1.time_ and arg_523_1.time_ < var_526_23 + var_526_24 then
				local var_526_25 = (arg_523_1.time_ - var_526_23) / var_526_24
				local var_526_26 = Color.New(0, 0, 0)

				var_526_26.a = Mathf.Lerp(1, 0, var_526_25)
				arg_523_1.mask_.color = var_526_26
			end

			if arg_523_1.time_ >= var_526_23 + var_526_24 and arg_523_1.time_ < var_526_23 + var_526_24 + arg_526_0 then
				local var_526_27 = Color.New(0, 0, 0)
				local var_526_28 = 0

				arg_523_1.mask_.enabled = false
				var_526_27.a = var_526_28
				arg_523_1.mask_.color = var_526_27
			end

			local var_526_29 = arg_523_1.actors_["108502ui_story"]
			local var_526_30 = 2

			if var_526_30 < arg_523_1.time_ and arg_523_1.time_ <= var_526_30 + arg_526_0 and not isNil(var_526_29) and arg_523_1.var_.characterEffect108502ui_story == nil then
				arg_523_1.var_.characterEffect108502ui_story = var_526_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_31 = 0.200000002980232

			if var_526_30 <= arg_523_1.time_ and arg_523_1.time_ < var_526_30 + var_526_31 and not isNil(var_526_29) then
				local var_526_32 = (arg_523_1.time_ - var_526_30) / var_526_31

				if arg_523_1.var_.characterEffect108502ui_story and not isNil(var_526_29) then
					arg_523_1.var_.characterEffect108502ui_story.fillFlat = false
				end
			end

			if arg_523_1.time_ >= var_526_30 + var_526_31 and arg_523_1.time_ < var_526_30 + var_526_31 + arg_526_0 and not isNil(var_526_29) and arg_523_1.var_.characterEffect108502ui_story then
				arg_523_1.var_.characterEffect108502ui_story.fillFlat = false
			end

			local var_526_33 = arg_523_1.bgs_.SP92801.transform
			local var_526_34 = 2

			if var_526_34 < arg_523_1.time_ and arg_523_1.time_ <= var_526_34 + arg_526_0 then
				arg_523_1.var_.moveOldPosSP92801 = var_526_33.localPosition
			end

			local var_526_35 = 0.001

			if var_526_34 <= arg_523_1.time_ and arg_523_1.time_ < var_526_34 + var_526_35 then
				local var_526_36 = (arg_523_1.time_ - var_526_34) / var_526_35
				local var_526_37 = Vector3.New(0, 1, 10)

				var_526_33.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPosSP92801, var_526_37, var_526_36)
			end

			if arg_523_1.time_ >= var_526_34 + var_526_35 and arg_523_1.time_ < var_526_34 + var_526_35 + arg_526_0 then
				var_526_33.localPosition = Vector3.New(0, 1, 10)
			end

			local var_526_38 = arg_523_1.bgs_.SP92801.transform
			local var_526_39 = 2.01666666666667

			if var_526_39 < arg_523_1.time_ and arg_523_1.time_ <= var_526_39 + arg_526_0 then
				arg_523_1.var_.moveOldPosSP92801 = var_526_38.localPosition
			end

			local var_526_40 = 3.15

			if var_526_39 <= arg_523_1.time_ and arg_523_1.time_ < var_526_39 + var_526_40 then
				local var_526_41 = (arg_523_1.time_ - var_526_39) / var_526_40
				local var_526_42 = Vector3.New(0, 1, 7)

				var_526_38.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPosSP92801, var_526_42, var_526_41)
			end

			if arg_523_1.time_ >= var_526_39 + var_526_40 and arg_523_1.time_ < var_526_39 + var_526_40 + arg_526_0 then
				var_526_38.localPosition = Vector3.New(0, 1, 7)
			end

			local var_526_43 = 2

			if var_526_43 < arg_523_1.time_ and arg_523_1.time_ <= var_526_43 + arg_526_0 then
				arg_523_1.allBtn_.enabled = false
			end

			local var_526_44 = 3.066666666666

			if arg_523_1.time_ >= var_526_43 + var_526_44 and arg_523_1.time_ < var_526_43 + var_526_44 + arg_526_0 then
				arg_523_1.allBtn_.enabled = true
			end

			if arg_523_1.frameCnt_ <= 1 then
				arg_523_1.dialog_:SetActive(false)
			end

			local var_526_45 = 4.766666666666
			local var_526_46 = 0.3

			if var_526_45 < arg_523_1.time_ and arg_523_1.time_ <= var_526_45 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0

				arg_523_1.dialog_:SetActive(true)

				arg_523_1.dialogCg_.alpha = 0

				local var_526_47 = LeanTween.value(arg_523_1.dialog_, 0, 1, 0.3)

				var_526_47:setOnUpdate(LuaHelper.FloatAction(function(arg_527_0)
					arg_523_1.dialogCg_.alpha = arg_527_0
				end))
				var_526_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_523_1.dialog_)
					var_526_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_523_1.duration_ = arg_523_1.duration_ + 0.3

				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_48 = arg_523_1:FormatText(StoryNameCfg[328].name)

				arg_523_1.leftNameTxt_.text = var_526_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_49 = arg_523_1:GetWordFromCfg(928041123)
				local var_526_50 = arg_523_1:FormatText(var_526_49.content)

				arg_523_1.text_.text = var_526_50

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_51 = 12
				local var_526_52 = utf8.len(var_526_50)
				local var_526_53 = var_526_51 <= 0 and var_526_46 or var_526_46 * (var_526_52 / var_526_51)

				if var_526_53 > 0 and var_526_46 < var_526_53 then
					arg_523_1.talkMaxDuration = var_526_53
					var_526_45 = var_526_45 + 0.3

					if var_526_53 + var_526_45 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_53 + var_526_45
					end
				end

				arg_523_1.text_.text = var_526_50
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041123", "story_v_side_old_928041.awb") ~= 0 then
					local var_526_54 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041123", "story_v_side_old_928041.awb") / 1000

					if var_526_54 + var_526_45 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_54 + var_526_45
					end

					if var_526_49.prefab_name ~= "" and arg_523_1.actors_[var_526_49.prefab_name] ~= nil then
						local var_526_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_49.prefab_name].transform, "story_v_side_old_928041", "928041123", "story_v_side_old_928041.awb")

						arg_523_1:RecordAudio("928041123", var_526_55)
						arg_523_1:RecordAudio("928041123", var_526_55)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041123", "story_v_side_old_928041.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041123", "story_v_side_old_928041.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_56 = var_526_45 + 0.3
			local var_526_57 = math.max(var_526_46, arg_523_1.talkMaxDuration)

			if var_526_56 <= arg_523_1.time_ and arg_523_1.time_ < var_526_56 + var_526_57 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_56) / var_526_57

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_56 + var_526_57 and arg_523_1.time_ < var_526_56 + var_526_57 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SP92801",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SP92801",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.15,
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0.701,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 7),
					easeType = LeanTweenType.easeInOutQuart
				}
			}
		}

		arg_523_1:InitPlayNodeList()
	end,
	Play928041124 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 928041124
		arg_529_1.duration_ = 18.5

		local var_529_0 = {
			zh = 11.266,
			ja = 18.5
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play928041125(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 0
			local var_532_1 = 1

			if var_532_0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				local var_532_2 = arg_529_1:FormatText(StoryNameCfg[328].name)

				arg_529_1.leftNameTxt_.text = var_532_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_3 = arg_529_1:GetWordFromCfg(928041124)
				local var_532_4 = arg_529_1:FormatText(var_532_3.content)

				arg_529_1.text_.text = var_532_4

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_5 = 40
				local var_532_6 = utf8.len(var_532_4)
				local var_532_7 = var_532_5 <= 0 and var_532_1 or var_532_1 * (var_532_6 / var_532_5)

				if var_532_7 > 0 and var_532_1 < var_532_7 then
					arg_529_1.talkMaxDuration = var_532_7

					if var_532_7 + var_532_0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_7 + var_532_0
					end
				end

				arg_529_1.text_.text = var_532_4
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041124", "story_v_side_old_928041.awb") ~= 0 then
					local var_532_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041124", "story_v_side_old_928041.awb") / 1000

					if var_532_8 + var_532_0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_8 + var_532_0
					end

					if var_532_3.prefab_name ~= "" and arg_529_1.actors_[var_532_3.prefab_name] ~= nil then
						local var_532_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_3.prefab_name].transform, "story_v_side_old_928041", "928041124", "story_v_side_old_928041.awb")

						arg_529_1:RecordAudio("928041124", var_532_9)
						arg_529_1:RecordAudio("928041124", var_532_9)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041124", "story_v_side_old_928041.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041124", "story_v_side_old_928041.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_10 = math.max(var_532_1, arg_529_1.talkMaxDuration)

			if var_532_0 <= arg_529_1.time_ and arg_529_1.time_ < var_532_0 + var_532_10 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_0) / var_532_10

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_0 + var_532_10 and arg_529_1.time_ < var_532_0 + var_532_10 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play928041125 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 928041125
		arg_533_1.duration_ = 8

		local var_533_0 = {
			zh = 8,
			ja = 7.133
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play928041126(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0
			local var_536_1 = 0.725

			if var_536_0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_2 = arg_533_1:FormatText(StoryNameCfg[328].name)

				arg_533_1.leftNameTxt_.text = var_536_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_3 = arg_533_1:GetWordFromCfg(928041125)
				local var_536_4 = arg_533_1:FormatText(var_536_3.content)

				arg_533_1.text_.text = var_536_4

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_5 = 29
				local var_536_6 = utf8.len(var_536_4)
				local var_536_7 = var_536_5 <= 0 and var_536_1 or var_536_1 * (var_536_6 / var_536_5)

				if var_536_7 > 0 and var_536_1 < var_536_7 then
					arg_533_1.talkMaxDuration = var_536_7

					if var_536_7 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_7 + var_536_0
					end
				end

				arg_533_1.text_.text = var_536_4
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041125", "story_v_side_old_928041.awb") ~= 0 then
					local var_536_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041125", "story_v_side_old_928041.awb") / 1000

					if var_536_8 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_8 + var_536_0
					end

					if var_536_3.prefab_name ~= "" and arg_533_1.actors_[var_536_3.prefab_name] ~= nil then
						local var_536_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_3.prefab_name].transform, "story_v_side_old_928041", "928041125", "story_v_side_old_928041.awb")

						arg_533_1:RecordAudio("928041125", var_536_9)
						arg_533_1:RecordAudio("928041125", var_536_9)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041125", "story_v_side_old_928041.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041125", "story_v_side_old_928041.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_10 = math.max(var_536_1, arg_533_1.talkMaxDuration)

			if var_536_0 <= arg_533_1.time_ and arg_533_1.time_ < var_536_0 + var_536_10 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_0) / var_536_10

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_0 + var_536_10 and arg_533_1.time_ < var_536_0 + var_536_10 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play928041126 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 928041126
		arg_537_1.duration_ = 16.93

		local var_537_0 = {
			zh = 9,
			ja = 16.933
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play928041127(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = arg_537_1.bgs_.SP92801.transform
			local var_540_1 = 0

			if var_540_1 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 then
				arg_537_1.var_.moveOldPosSP92801 = var_540_0.localPosition
			end

			local var_540_2 = 1.1

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_2 then
				local var_540_3 = (arg_537_1.time_ - var_540_1) / var_540_2
				local var_540_4 = Vector3.New(0, 0.99, 6.39)

				var_540_0.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPosSP92801, var_540_4, var_540_3)
			end

			if arg_537_1.time_ >= var_540_1 + var_540_2 and arg_537_1.time_ < var_540_1 + var_540_2 + arg_540_0 then
				var_540_0.localPosition = Vector3.New(0, 0.99, 6.39)
			end

			local var_540_5 = 0

			if var_540_5 < arg_537_1.time_ and arg_537_1.time_ <= var_540_5 + arg_540_0 then
				arg_537_1.allBtn_.enabled = false
			end

			local var_540_6 = 1.2

			if arg_537_1.time_ >= var_540_5 + var_540_6 and arg_537_1.time_ < var_540_5 + var_540_6 + arg_540_0 then
				arg_537_1.allBtn_.enabled = true
			end

			local var_540_7 = 0
			local var_540_8 = 0.9

			if var_540_7 < arg_537_1.time_ and arg_537_1.time_ <= var_540_7 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_9 = arg_537_1:FormatText(StoryNameCfg[328].name)

				arg_537_1.leftNameTxt_.text = var_540_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_10 = arg_537_1:GetWordFromCfg(928041126)
				local var_540_11 = arg_537_1:FormatText(var_540_10.content)

				arg_537_1.text_.text = var_540_11

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_12 = 36
				local var_540_13 = utf8.len(var_540_11)
				local var_540_14 = var_540_12 <= 0 and var_540_8 or var_540_8 * (var_540_13 / var_540_12)

				if var_540_14 > 0 and var_540_8 < var_540_14 then
					arg_537_1.talkMaxDuration = var_540_14

					if var_540_14 + var_540_7 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_14 + var_540_7
					end
				end

				arg_537_1.text_.text = var_540_11
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041126", "story_v_side_old_928041.awb") ~= 0 then
					local var_540_15 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041126", "story_v_side_old_928041.awb") / 1000

					if var_540_15 + var_540_7 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_15 + var_540_7
					end

					if var_540_10.prefab_name ~= "" and arg_537_1.actors_[var_540_10.prefab_name] ~= nil then
						local var_540_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_10.prefab_name].transform, "story_v_side_old_928041", "928041126", "story_v_side_old_928041.awb")

						arg_537_1:RecordAudio("928041126", var_540_16)
						arg_537_1:RecordAudio("928041126", var_540_16)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041126", "story_v_side_old_928041.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041126", "story_v_side_old_928041.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_17 = math.max(var_540_8, arg_537_1.talkMaxDuration)

			if var_540_7 <= arg_537_1.time_ and arg_537_1.time_ < var_540_7 + var_540_17 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_7) / var_540_17

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_7 + var_540_17 and arg_537_1.time_ < var_540_7 + var_540_17 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP92801",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0.701,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 7),
					endPos = Vector3.New(0, 0.99, 6.39),
					easeType = LeanTweenType.easeInSine
				}
			}
		}

		arg_537_1:InitPlayNodeList()
	end,
	Play928041127 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 928041127
		arg_541_1.duration_ = 15.67

		local var_541_0 = {
			zh = 10,
			ja = 15.666
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play928041128(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0
			local var_544_1 = 0.975

			if var_544_0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_2 = arg_541_1:FormatText(StoryNameCfg[328].name)

				arg_541_1.leftNameTxt_.text = var_544_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_3 = arg_541_1:GetWordFromCfg(928041127)
				local var_544_4 = arg_541_1:FormatText(var_544_3.content)

				arg_541_1.text_.text = var_544_4

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 39
				local var_544_6 = utf8.len(var_544_4)
				local var_544_7 = var_544_5 <= 0 and var_544_1 or var_544_1 * (var_544_6 / var_544_5)

				if var_544_7 > 0 and var_544_1 < var_544_7 then
					arg_541_1.talkMaxDuration = var_544_7

					if var_544_7 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_0
					end
				end

				arg_541_1.text_.text = var_544_4
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041127", "story_v_side_old_928041.awb") ~= 0 then
					local var_544_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041127", "story_v_side_old_928041.awb") / 1000

					if var_544_8 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_8 + var_544_0
					end

					if var_544_3.prefab_name ~= "" and arg_541_1.actors_[var_544_3.prefab_name] ~= nil then
						local var_544_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_3.prefab_name].transform, "story_v_side_old_928041", "928041127", "story_v_side_old_928041.awb")

						arg_541_1:RecordAudio("928041127", var_544_9)
						arg_541_1:RecordAudio("928041127", var_544_9)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041127", "story_v_side_old_928041.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041127", "story_v_side_old_928041.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_10 = math.max(var_544_1, arg_541_1.talkMaxDuration)

			if var_544_0 <= arg_541_1.time_ and arg_541_1.time_ < var_544_0 + var_544_10 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_0) / var_544_10

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_0 + var_544_10 and arg_541_1.time_ < var_544_0 + var_544_10 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play928041128 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 928041128
		arg_545_1.duration_ = 1

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"

			SetActive(arg_545_1.choicesGo_, true)

			for iter_546_0, iter_546_1 in ipairs(arg_545_1.choices_) do
				local var_546_0 = iter_546_0 <= 2

				SetActive(iter_546_1.go, var_546_0)
			end

			arg_545_1.choices_[1].txt.text = arg_545_1:FormatText(StoryChoiceCfg[1440].name)
			arg_545_1.choices_[2].txt.text = arg_545_1:FormatText(StoryChoiceCfg[1441].name)
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play928041129(arg_545_1)
			end

			if arg_547_0 == 2 then
				arg_545_0:Play928041129(arg_545_1)
			end

			arg_545_1:RecordChoiceLog(928041128, 1440, 1441)
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = arg_545_1.actors_["1080ui_story"]
			local var_548_1 = 0

			if var_548_1 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.characterEffect1080ui_story == nil then
				arg_545_1.var_.characterEffect1080ui_story = var_548_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_2 = 0.200000002980232

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_2 and not isNil(var_548_0) then
				local var_548_3 = (arg_545_1.time_ - var_548_1) / var_548_2

				if arg_545_1.var_.characterEffect1080ui_story and not isNil(var_548_0) then
					local var_548_4 = Mathf.Lerp(0, 0.5, var_548_3)

					arg_545_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_545_1.var_.characterEffect1080ui_story.fillRatio = var_548_4
				end
			end

			if arg_545_1.time_ >= var_548_1 + var_548_2 and arg_545_1.time_ < var_548_1 + var_548_2 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.characterEffect1080ui_story then
				local var_548_5 = 0.5

				arg_545_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_545_1.var_.characterEffect1080ui_story.fillRatio = var_548_5
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play928041129 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 928041129
		arg_549_1.duration_ = 3.63

		local var_549_0 = {
			zh = 2.8,
			ja = 3.633
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play928041130(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = arg_549_1.actors_["1080ui_story"]
			local var_552_1 = 0

			if var_552_1 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 and not isNil(var_552_0) and arg_549_1.var_.characterEffect1080ui_story == nil then
				arg_549_1.var_.characterEffect1080ui_story = var_552_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_2 = 0.200000002980232

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_2 and not isNil(var_552_0) then
				local var_552_3 = (arg_549_1.time_ - var_552_1) / var_552_2

				if arg_549_1.var_.characterEffect1080ui_story and not isNil(var_552_0) then
					arg_549_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_549_1.time_ >= var_552_1 + var_552_2 and arg_549_1.time_ < var_552_1 + var_552_2 + arg_552_0 and not isNil(var_552_0) and arg_549_1.var_.characterEffect1080ui_story then
				arg_549_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_552_4 = 0
			local var_552_5 = 0.125

			if var_552_4 < arg_549_1.time_ and arg_549_1.time_ <= var_552_4 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_6 = arg_549_1:FormatText(StoryNameCfg[328].name)

				arg_549_1.leftNameTxt_.text = var_552_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_7 = arg_549_1:GetWordFromCfg(928041129)
				local var_552_8 = arg_549_1:FormatText(var_552_7.content)

				arg_549_1.text_.text = var_552_8

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_9 = 5
				local var_552_10 = utf8.len(var_552_8)
				local var_552_11 = var_552_9 <= 0 and var_552_5 or var_552_5 * (var_552_10 / var_552_9)

				if var_552_11 > 0 and var_552_5 < var_552_11 then
					arg_549_1.talkMaxDuration = var_552_11

					if var_552_11 + var_552_4 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_11 + var_552_4
					end
				end

				arg_549_1.text_.text = var_552_8
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041129", "story_v_side_old_928041.awb") ~= 0 then
					local var_552_12 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041129", "story_v_side_old_928041.awb") / 1000

					if var_552_12 + var_552_4 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_12 + var_552_4
					end

					if var_552_7.prefab_name ~= "" and arg_549_1.actors_[var_552_7.prefab_name] ~= nil then
						local var_552_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_7.prefab_name].transform, "story_v_side_old_928041", "928041129", "story_v_side_old_928041.awb")

						arg_549_1:RecordAudio("928041129", var_552_13)
						arg_549_1:RecordAudio("928041129", var_552_13)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041129", "story_v_side_old_928041.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041129", "story_v_side_old_928041.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_14 = math.max(var_552_5, arg_549_1.talkMaxDuration)

			if var_552_4 <= arg_549_1.time_ and arg_549_1.time_ < var_552_4 + var_552_14 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_4) / var_552_14

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_4 + var_552_14 and arg_549_1.time_ < var_552_4 + var_552_14 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play928041130 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 928041130
		arg_553_1.duration_ = 6.17

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play928041131(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0

			if var_556_0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_0 + arg_556_0 then
				arg_553_1.mask_.enabled = true
				arg_553_1.mask_.raycastTarget = true

				arg_553_1:SetGaussion(false)
			end

			local var_556_1 = 0.4

			if var_556_0 <= arg_553_1.time_ and arg_553_1.time_ < var_556_0 + var_556_1 then
				local var_556_2 = (arg_553_1.time_ - var_556_0) / var_556_1
				local var_556_3 = Color.New(1, 1, 1)

				var_556_3.a = Mathf.Lerp(1, 0, var_556_2)
				arg_553_1.mask_.color = var_556_3
			end

			if arg_553_1.time_ >= var_556_0 + var_556_1 and arg_553_1.time_ < var_556_0 + var_556_1 + arg_556_0 then
				local var_556_4 = Color.New(1, 1, 1)
				local var_556_5 = 0

				arg_553_1.mask_.enabled = false
				var_556_4.a = var_556_5
				arg_553_1.mask_.color = var_556_4
			end

			local var_556_6 = 0

			if var_556_6 < arg_553_1.time_ and arg_553_1.time_ <= var_556_6 + arg_556_0 then
				arg_553_1.allBtn_.enabled = false
			end

			local var_556_7 = 1.46666666666667

			if arg_553_1.time_ >= var_556_6 + var_556_7 and arg_553_1.time_ < var_556_6 + var_556_7 + arg_556_0 then
				arg_553_1.allBtn_.enabled = true
			end

			local var_556_8 = arg_553_1.bgs_.SP92801.transform
			local var_556_9 = 0

			if var_556_9 < arg_553_1.time_ and arg_553_1.time_ <= var_556_9 + arg_556_0 then
				arg_553_1.var_.moveOldPosSP92801 = var_556_8.localPosition
			end

			local var_556_10 = 1.9

			if var_556_9 <= arg_553_1.time_ and arg_553_1.time_ < var_556_9 + var_556_10 then
				local var_556_11 = (arg_553_1.time_ - var_556_9) / var_556_10
				local var_556_12 = Vector3.New(-2.21, 1.62, 5.68)

				var_556_8.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPosSP92801, var_556_12, var_556_11)
			end

			if arg_553_1.time_ >= var_556_9 + var_556_10 and arg_553_1.time_ < var_556_9 + var_556_10 + arg_556_0 then
				var_556_8.localPosition = Vector3.New(-2.21, 1.62, 5.68)
			end

			if arg_553_1.frameCnt_ <= 1 then
				arg_553_1.dialog_:SetActive(false)
			end

			local var_556_13 = 1.16666666666667
			local var_556_14 = 0.55

			if var_556_13 < arg_553_1.time_ and arg_553_1.time_ <= var_556_13 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0

				arg_553_1.dialog_:SetActive(true)

				arg_553_1.dialogCg_.alpha = 0

				local var_556_15 = LeanTween.value(arg_553_1.dialog_, 0, 1, 0.3)

				var_556_15:setOnUpdate(LuaHelper.FloatAction(function(arg_557_0)
					arg_553_1.dialogCg_.alpha = arg_557_0
				end))
				var_556_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_553_1.dialog_)
					var_556_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_553_1.duration_ = arg_553_1.duration_ + 0.3

				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_16 = arg_553_1:FormatText(StoryNameCfg[7].name)

				arg_553_1.leftNameTxt_.text = var_556_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_17 = arg_553_1:GetWordFromCfg(928041130)
				local var_556_18 = arg_553_1:FormatText(var_556_17.content)

				arg_553_1.text_.text = var_556_18

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_19 = 22
				local var_556_20 = utf8.len(var_556_18)
				local var_556_21 = var_556_19 <= 0 and var_556_14 or var_556_14 * (var_556_20 / var_556_19)

				if var_556_21 > 0 and var_556_14 < var_556_21 then
					arg_553_1.talkMaxDuration = var_556_21
					var_556_13 = var_556_13 + 0.3

					if var_556_21 + var_556_13 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_21 + var_556_13
					end
				end

				arg_553_1.text_.text = var_556_18
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_22 = var_556_13 + 0.3
			local var_556_23 = math.max(var_556_14, arg_553_1.talkMaxDuration)

			if var_556_22 <= arg_553_1.time_ and arg_553_1.time_ < var_556_22 + var_556_23 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_22) / var_556_23

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_22 + var_556_23 and arg_553_1.time_ < var_556_22 + var_556_23 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP92801",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.9,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0.701,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-1.43, 0.95, 3.12),
					endPos = Vector3.New(-2.21, 1.62, 5.68),
					easeType = LeanTweenType.easeInOutQuart
				}
			}
		}

		arg_553_1:InitPlayNodeList()
	end,
	Play928041131 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 928041131
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play928041132(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0
			local var_562_1 = 0.475

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
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_3 = arg_559_1:GetWordFromCfg(928041131)
				local var_562_4 = arg_559_1:FormatText(var_562_3.content)

				arg_559_1.text_.text = var_562_4

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_5 = 19
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
	Play928041132 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 928041132
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play928041133(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = arg_563_1.bgs_.SP92801.transform
			local var_566_1 = 0

			if var_566_1 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 then
				arg_563_1.var_.moveOldPosSP92801 = var_566_0.localPosition
			end

			local var_566_2 = 1.933333333332

			if var_566_1 <= arg_563_1.time_ and arg_563_1.time_ < var_566_1 + var_566_2 then
				local var_566_3 = (arg_563_1.time_ - var_566_1) / var_566_2
				local var_566_4 = Vector3.New(-0.41, 1.33, 5.18)

				var_566_0.localPosition = Vector3.Lerp(arg_563_1.var_.moveOldPosSP92801, var_566_4, var_566_3)
			end

			if arg_563_1.time_ >= var_566_1 + var_566_2 and arg_563_1.time_ < var_566_1 + var_566_2 + arg_566_0 then
				var_566_0.localPosition = Vector3.New(-0.41, 1.33, 5.18)
			end

			local var_566_5 = 0

			if var_566_5 < arg_563_1.time_ and arg_563_1.time_ <= var_566_5 + arg_566_0 then
				arg_563_1.allBtn_.enabled = false
			end

			local var_566_6 = 1.93333333333333

			if arg_563_1.time_ >= var_566_5 + var_566_6 and arg_563_1.time_ < var_566_5 + var_566_6 + arg_566_0 then
				arg_563_1.allBtn_.enabled = true
			end

			local var_566_7 = 0
			local var_566_8 = 0.8

			if var_566_7 < arg_563_1.time_ and arg_563_1.time_ <= var_566_7 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_9 = arg_563_1:FormatText(StoryNameCfg[7].name)

				arg_563_1.leftNameTxt_.text = var_566_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_10 = arg_563_1:GetWordFromCfg(928041132)
				local var_566_11 = arg_563_1:FormatText(var_566_10.content)

				arg_563_1.text_.text = var_566_11

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_12 = 32
				local var_566_13 = utf8.len(var_566_11)
				local var_566_14 = var_566_12 <= 0 and var_566_8 or var_566_8 * (var_566_13 / var_566_12)

				if var_566_14 > 0 and var_566_8 < var_566_14 then
					arg_563_1.talkMaxDuration = var_566_14

					if var_566_14 + var_566_7 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_14 + var_566_7
					end
				end

				arg_563_1.text_.text = var_566_11
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)
				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_15 = math.max(var_566_8, arg_563_1.talkMaxDuration)

			if var_566_7 <= arg_563_1.time_ and arg_563_1.time_ < var_566_7 + var_566_15 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_7) / var_566_15

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_7 + var_566_15 and arg_563_1.time_ < var_566_7 + var_566_15 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP92801",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.933333333332,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0.701,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-2.21, 1.62, 5.68),
					endPos = Vector3.New(-0.41, 1.33, 5.18),
					easeType = LeanTweenType.easeInOutQuart
				}
			}
		}

		arg_563_1:InitPlayNodeList()
	end,
	Play928041133 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 928041133
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play928041134(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0
			local var_570_1 = 0.7

			if var_570_0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_2 = arg_567_1:FormatText(StoryNameCfg[7].name)

				arg_567_1.leftNameTxt_.text = var_570_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_3 = arg_567_1:GetWordFromCfg(928041133)
				local var_570_4 = arg_567_1:FormatText(var_570_3.content)

				arg_567_1.text_.text = var_570_4

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 28
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
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_8 = math.max(var_570_1, arg_567_1.talkMaxDuration)

			if var_570_0 <= arg_567_1.time_ and arg_567_1.time_ < var_570_0 + var_570_8 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_0) / var_570_8

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_0 + var_570_8 and arg_567_1.time_ < var_570_0 + var_570_8 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play928041134 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 928041134
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play928041135(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0
			local var_574_1 = 0.975

			if var_574_0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_2 = arg_571_1:FormatText(StoryNameCfg[7].name)

				arg_571_1.leftNameTxt_.text = var_574_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_3 = arg_571_1:GetWordFromCfg(928041134)
				local var_574_4 = arg_571_1:FormatText(var_574_3.content)

				arg_571_1.text_.text = var_574_4

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_5 = 39
				local var_574_6 = utf8.len(var_574_4)
				local var_574_7 = var_574_5 <= 0 and var_574_1 or var_574_1 * (var_574_6 / var_574_5)

				if var_574_7 > 0 and var_574_1 < var_574_7 then
					arg_571_1.talkMaxDuration = var_574_7

					if var_574_7 + var_574_0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_7 + var_574_0
					end
				end

				arg_571_1.text_.text = var_574_4
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_8 = math.max(var_574_1, arg_571_1.talkMaxDuration)

			if var_574_0 <= arg_571_1.time_ and arg_571_1.time_ < var_574_0 + var_574_8 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_0) / var_574_8

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_0 + var_574_8 and arg_571_1.time_ < var_574_0 + var_574_8 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play928041135 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 928041135
		arg_575_1.duration_ = 5.52

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play928041136(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = arg_575_1.bgs_.SP92801.transform
			local var_578_1 = 0

			if var_578_1 < arg_575_1.time_ and arg_575_1.time_ <= var_578_1 + arg_578_0 then
				arg_575_1.var_.moveOldPosSP92801 = var_578_0.localPosition
			end

			local var_578_2 = 2.23333333333333

			if var_578_1 <= arg_575_1.time_ and arg_575_1.time_ < var_578_1 + var_578_2 then
				local var_578_3 = (arg_575_1.time_ - var_578_1) / var_578_2
				local var_578_4 = Vector3.New(-1.58, 0.58, 4.64)

				var_578_0.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPosSP92801, var_578_4, var_578_3)
			end

			if arg_575_1.time_ >= var_578_1 + var_578_2 and arg_575_1.time_ < var_578_1 + var_578_2 + arg_578_0 then
				var_578_0.localPosition = Vector3.New(-1.58, 0.58, 4.64)
			end

			local var_578_5 = 0

			if var_578_5 < arg_575_1.time_ and arg_575_1.time_ <= var_578_5 + arg_578_0 then
				arg_575_1.allBtn_.enabled = false
			end

			local var_578_6 = 2.06666666666667

			if arg_575_1.time_ >= var_578_5 + var_578_6 and arg_575_1.time_ < var_578_5 + var_578_6 + arg_578_0 then
				arg_575_1.allBtn_.enabled = true
			end

			if arg_575_1.frameCnt_ <= 1 then
				arg_575_1.dialog_:SetActive(false)
			end

			local var_578_7 = 0.525
			local var_578_8 = 0.475

			if var_578_7 < arg_575_1.time_ and arg_575_1.time_ <= var_578_7 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0

				arg_575_1.dialog_:SetActive(true)

				arg_575_1.dialogCg_.alpha = 0

				local var_578_9 = LeanTween.value(arg_575_1.dialog_, 0, 1, 0.3)

				var_578_9:setOnUpdate(LuaHelper.FloatAction(function(arg_579_0)
					arg_575_1.dialogCg_.alpha = arg_579_0
				end))
				var_578_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_575_1.dialog_)
					var_578_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_575_1.duration_ = arg_575_1.duration_ + 0.3

				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_10 = arg_575_1:FormatText(StoryNameCfg[7].name)

				arg_575_1.leftNameTxt_.text = var_578_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_11 = arg_575_1:GetWordFromCfg(928041135)
				local var_578_12 = arg_575_1:FormatText(var_578_11.content)

				arg_575_1.text_.text = var_578_12

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_13 = 19
				local var_578_14 = utf8.len(var_578_12)
				local var_578_15 = var_578_13 <= 0 and var_578_8 or var_578_8 * (var_578_14 / var_578_13)

				if var_578_15 > 0 and var_578_8 < var_578_15 then
					arg_575_1.talkMaxDuration = var_578_15
					var_578_7 = var_578_7 + 0.3

					if var_578_15 + var_578_7 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_15 + var_578_7
					end
				end

				arg_575_1.text_.text = var_578_12
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_16 = var_578_7 + 0.3
			local var_578_17 = math.max(var_578_8, arg_575_1.talkMaxDuration)

			if var_578_16 <= arg_575_1.time_ and arg_575_1.time_ < var_578_16 + var_578_17 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_16) / var_578_17

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_16 + var_578_17 and arg_575_1.time_ < var_578_16 + var_578_17 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP92801",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.23333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0.701,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-0.41, 1.33, 5.18),
					endPos = Vector3.New(-1.58, 0.58, 4.64),
					easeType = LeanTweenType.easeInOutQuart
				}
			}
		}

		arg_575_1:InitPlayNodeList()
	end,
	Play928041136 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 928041136
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play928041137(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = 0
			local var_584_1 = 0.725

			if var_584_0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_0 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, false)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_2 = arg_581_1:GetWordFromCfg(928041136)
				local var_584_3 = arg_581_1:FormatText(var_584_2.content)

				arg_581_1.text_.text = var_584_3

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_4 = 29
				local var_584_5 = utf8.len(var_584_3)
				local var_584_6 = var_584_4 <= 0 and var_584_1 or var_584_1 * (var_584_5 / var_584_4)

				if var_584_6 > 0 and var_584_1 < var_584_6 then
					arg_581_1.talkMaxDuration = var_584_6

					if var_584_6 + var_584_0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_6 + var_584_0
					end
				end

				arg_581_1.text_.text = var_584_3
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_7 = math.max(var_584_1, arg_581_1.talkMaxDuration)

			if var_584_0 <= arg_581_1.time_ and arg_581_1.time_ < var_584_0 + var_584_7 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_0) / var_584_7

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_0 + var_584_7 and arg_581_1.time_ < var_584_0 + var_584_7 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play928041137 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 928041137
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play928041138(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0
			local var_588_1 = 0.95

			if var_588_0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, false)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_2 = arg_585_1:GetWordFromCfg(928041137)
				local var_588_3 = arg_585_1:FormatText(var_588_2.content)

				arg_585_1.text_.text = var_588_3

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_4 = 38
				local var_588_5 = utf8.len(var_588_3)
				local var_588_6 = var_588_4 <= 0 and var_588_1 or var_588_1 * (var_588_5 / var_588_4)

				if var_588_6 > 0 and var_588_1 < var_588_6 then
					arg_585_1.talkMaxDuration = var_588_6

					if var_588_6 + var_588_0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_6 + var_588_0
					end
				end

				arg_585_1.text_.text = var_588_3
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_7 = math.max(var_588_1, arg_585_1.talkMaxDuration)

			if var_588_0 <= arg_585_1.time_ and arg_585_1.time_ < var_588_0 + var_588_7 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_0) / var_588_7

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_0 + var_588_7 and arg_585_1.time_ < var_588_0 + var_588_7 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play928041138 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 928041138
		arg_589_1.duration_ = 15.63

		local var_589_0 = {
			zh = 11.2,
			ja = 15.633
		}
		local var_589_1 = manager.audio:GetLocalizationFlag()

		if var_589_0[var_589_1] ~= nil then
			arg_589_1.duration_ = var_589_0[var_589_1]
		end

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play928041139(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = arg_589_1.actors_["1080ui_story"]
			local var_592_1 = 0

			if var_592_1 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 and not isNil(var_592_0) and arg_589_1.var_.characterEffect1080ui_story == nil then
				arg_589_1.var_.characterEffect1080ui_story = var_592_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_2 = 0.200000002980232

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_2 and not isNil(var_592_0) then
				local var_592_3 = (arg_589_1.time_ - var_592_1) / var_592_2

				if arg_589_1.var_.characterEffect1080ui_story and not isNil(var_592_0) then
					arg_589_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_589_1.time_ >= var_592_1 + var_592_2 and arg_589_1.time_ < var_592_1 + var_592_2 + arg_592_0 and not isNil(var_592_0) and arg_589_1.var_.characterEffect1080ui_story then
				arg_589_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_592_4 = 0
			local var_592_5 = 0.95

			if var_592_4 < arg_589_1.time_ and arg_589_1.time_ <= var_592_4 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				local var_592_6 = arg_589_1:FormatText(StoryNameCfg[328].name)

				arg_589_1.leftNameTxt_.text = var_592_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_7 = arg_589_1:GetWordFromCfg(928041138)
				local var_592_8 = arg_589_1:FormatText(var_592_7.content)

				arg_589_1.text_.text = var_592_8

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_9 = 38
				local var_592_10 = utf8.len(var_592_8)
				local var_592_11 = var_592_9 <= 0 and var_592_5 or var_592_5 * (var_592_10 / var_592_9)

				if var_592_11 > 0 and var_592_5 < var_592_11 then
					arg_589_1.talkMaxDuration = var_592_11

					if var_592_11 + var_592_4 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_11 + var_592_4
					end
				end

				arg_589_1.text_.text = var_592_8
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041138", "story_v_side_old_928041.awb") ~= 0 then
					local var_592_12 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041138", "story_v_side_old_928041.awb") / 1000

					if var_592_12 + var_592_4 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_12 + var_592_4
					end

					if var_592_7.prefab_name ~= "" and arg_589_1.actors_[var_592_7.prefab_name] ~= nil then
						local var_592_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_7.prefab_name].transform, "story_v_side_old_928041", "928041138", "story_v_side_old_928041.awb")

						arg_589_1:RecordAudio("928041138", var_592_13)
						arg_589_1:RecordAudio("928041138", var_592_13)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041138", "story_v_side_old_928041.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041138", "story_v_side_old_928041.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_14 = math.max(var_592_5, arg_589_1.talkMaxDuration)

			if var_592_4 <= arg_589_1.time_ and arg_589_1.time_ < var_592_4 + var_592_14 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_4) / var_592_14

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_4 + var_592_14 and arg_589_1.time_ < var_592_4 + var_592_14 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play928041139 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 928041139
		arg_593_1.duration_ = 16.27

		local var_593_0 = {
			zh = 12.433,
			ja = 16.266
		}
		local var_593_1 = manager.audio:GetLocalizationFlag()

		if var_593_0[var_593_1] ~= nil then
			arg_593_1.duration_ = var_593_0[var_593_1]
		end

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play928041140(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0
			local var_596_1 = 1

			if var_596_0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_2 = arg_593_1:FormatText(StoryNameCfg[328].name)

				arg_593_1.leftNameTxt_.text = var_596_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_3 = arg_593_1:GetWordFromCfg(928041139)
				local var_596_4 = arg_593_1:FormatText(var_596_3.content)

				arg_593_1.text_.text = var_596_4

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_5 = 40
				local var_596_6 = utf8.len(var_596_4)
				local var_596_7 = var_596_5 <= 0 and var_596_1 or var_596_1 * (var_596_6 / var_596_5)

				if var_596_7 > 0 and var_596_1 < var_596_7 then
					arg_593_1.talkMaxDuration = var_596_7

					if var_596_7 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_7 + var_596_0
					end
				end

				arg_593_1.text_.text = var_596_4
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041139", "story_v_side_old_928041.awb") ~= 0 then
					local var_596_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041139", "story_v_side_old_928041.awb") / 1000

					if var_596_8 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_8 + var_596_0
					end

					if var_596_3.prefab_name ~= "" and arg_593_1.actors_[var_596_3.prefab_name] ~= nil then
						local var_596_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_3.prefab_name].transform, "story_v_side_old_928041", "928041139", "story_v_side_old_928041.awb")

						arg_593_1:RecordAudio("928041139", var_596_9)
						arg_593_1:RecordAudio("928041139", var_596_9)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041139", "story_v_side_old_928041.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041139", "story_v_side_old_928041.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_10 = math.max(var_596_1, arg_593_1.talkMaxDuration)

			if var_596_0 <= arg_593_1.time_ and arg_593_1.time_ < var_596_0 + var_596_10 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_0) / var_596_10

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_0 + var_596_10 and arg_593_1.time_ < var_596_0 + var_596_10 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play928041140 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 928041140
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play928041141(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = arg_597_1.actors_["1080ui_story"]
			local var_600_1 = 0

			if var_600_1 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 and not isNil(var_600_0) and arg_597_1.var_.characterEffect1080ui_story == nil then
				arg_597_1.var_.characterEffect1080ui_story = var_600_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_2 = 0.200000002980232

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_2 and not isNil(var_600_0) then
				local var_600_3 = (arg_597_1.time_ - var_600_1) / var_600_2

				if arg_597_1.var_.characterEffect1080ui_story and not isNil(var_600_0) then
					local var_600_4 = Mathf.Lerp(0, 0.5, var_600_3)

					arg_597_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_597_1.var_.characterEffect1080ui_story.fillRatio = var_600_4
				end
			end

			if arg_597_1.time_ >= var_600_1 + var_600_2 and arg_597_1.time_ < var_600_1 + var_600_2 + arg_600_0 and not isNil(var_600_0) and arg_597_1.var_.characterEffect1080ui_story then
				local var_600_5 = 0.5

				arg_597_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_597_1.var_.characterEffect1080ui_story.fillRatio = var_600_5
			end

			local var_600_6 = manager.ui.mainCamera.transform
			local var_600_7 = 0

			if var_600_7 < arg_597_1.time_ and arg_597_1.time_ <= var_600_7 + arg_600_0 then
				local var_600_8 = arg_597_1.var_.effect32err
				local var_600_9
				local var_600_10 = var_600_6

				if not var_600_8 then
					var_600_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_piaosan1"), var_600_10)
					var_600_8.name = "32err"
					arg_597_1.var_.effect32err = var_600_8
				else
					var_600_8.transform:SetParent(var_600_10)
				end

				var_600_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_600_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_600_11 = manager.ui.mainCameraCom_
				local var_600_12 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_600_11.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_600_13 = var_600_8.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_600_14 = 15
				local var_600_15 = 2 * var_600_14 * Mathf.Tan(var_600_11.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_600_11.aspect
				local var_600_16 = 1
				local var_600_17 = 1.7777777777777777

				if var_600_17 < var_600_11.aspect then
					var_600_16 = var_600_15 / (2 * var_600_14 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_600_17)
				end

				for iter_600_0, iter_600_1 in ipairs(var_600_13) do
					local var_600_18 = iter_600_1.transform.localScale

					iter_600_1.transform.localScale = Vector3.New(var_600_18.x / var_600_12 * var_600_16, var_600_18.y / var_600_12, var_600_18.z)
				end
			end

			local var_600_19 = arg_597_1.bgs_.SP92801.transform
			local var_600_20 = 0

			if var_600_20 < arg_597_1.time_ and arg_597_1.time_ <= var_600_20 + arg_600_0 then
				arg_597_1.var_.moveOldPosSP92801 = var_600_19.localPosition
			end

			local var_600_21 = 2.6

			if var_600_20 <= arg_597_1.time_ and arg_597_1.time_ < var_600_20 + var_600_21 then
				local var_600_22 = (arg_597_1.time_ - var_600_20) / var_600_21
				local var_600_23 = Vector3.New(-1.41, 0.1, 2.76)

				var_600_19.localPosition = Vector3.Lerp(arg_597_1.var_.moveOldPosSP92801, var_600_23, var_600_22)
			end

			if arg_597_1.time_ >= var_600_20 + var_600_21 and arg_597_1.time_ < var_600_20 + var_600_21 + arg_600_0 then
				var_600_19.localPosition = Vector3.New(-1.41, 0.1, 2.76)
			end

			local var_600_24 = 0

			if var_600_24 < arg_597_1.time_ and arg_597_1.time_ <= var_600_24 + arg_600_0 then
				arg_597_1.allBtn_.enabled = false
			end

			local var_600_25 = 2.33333333333333

			if arg_597_1.time_ >= var_600_24 + var_600_25 and arg_597_1.time_ < var_600_24 + var_600_25 + arg_600_0 then
				arg_597_1.allBtn_.enabled = true
			end

			local var_600_26 = 0
			local var_600_27 = 0.75

			if var_600_26 < arg_597_1.time_ and arg_597_1.time_ <= var_600_26 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, false)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_28 = arg_597_1:GetWordFromCfg(928041140)
				local var_600_29 = arg_597_1:FormatText(var_600_28.content)

				arg_597_1.text_.text = var_600_29

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_30 = 30
				local var_600_31 = utf8.len(var_600_29)
				local var_600_32 = var_600_30 <= 0 and var_600_27 or var_600_27 * (var_600_31 / var_600_30)

				if var_600_32 > 0 and var_600_27 < var_600_32 then
					arg_597_1.talkMaxDuration = var_600_32

					if var_600_32 + var_600_26 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_32 + var_600_26
					end
				end

				arg_597_1.text_.text = var_600_29
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_33 = math.max(var_600_27, arg_597_1.talkMaxDuration)

			if var_600_26 <= arg_597_1.time_ and arg_597_1.time_ < var_600_26 + var_600_33 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_26) / var_600_33

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_26 + var_600_33 and arg_597_1.time_ < var_600_26 + var_600_33 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP92801",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.6,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0.701,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-1.58, 0.58, 4.64),
					endPos = Vector3.New(-1.41, 0.1, 2.76),
					easeType = LeanTweenType.easeOutSine
				}
			}
		}

		arg_597_1:InitPlayNodeList()
	end,
	Play928041141 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 928041141
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play928041142(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = 0
			local var_604_1 = 0.85

			if var_604_0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_0 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, false)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_2 = arg_601_1:GetWordFromCfg(928041141)
				local var_604_3 = arg_601_1:FormatText(var_604_2.content)

				arg_601_1.text_.text = var_604_3

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_4 = 34
				local var_604_5 = utf8.len(var_604_3)
				local var_604_6 = var_604_4 <= 0 and var_604_1 or var_604_1 * (var_604_5 / var_604_4)

				if var_604_6 > 0 and var_604_1 < var_604_6 then
					arg_601_1.talkMaxDuration = var_604_6

					if var_604_6 + var_604_0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_6 + var_604_0
					end
				end

				arg_601_1.text_.text = var_604_3
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_7 = math.max(var_604_1, arg_601_1.talkMaxDuration)

			if var_604_0 <= arg_601_1.time_ and arg_601_1.time_ < var_604_0 + var_604_7 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_0) / var_604_7

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_0 + var_604_7 and arg_601_1.time_ < var_604_0 + var_604_7 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play928041142 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 928041142
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play928041143(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0
			local var_608_1 = 0.675

			if var_608_0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, false)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_2 = arg_605_1:GetWordFromCfg(928041142)
				local var_608_3 = arg_605_1:FormatText(var_608_2.content)

				arg_605_1.text_.text = var_608_3

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_4 = 27
				local var_608_5 = utf8.len(var_608_3)
				local var_608_6 = var_608_4 <= 0 and var_608_1 or var_608_1 * (var_608_5 / var_608_4)

				if var_608_6 > 0 and var_608_1 < var_608_6 then
					arg_605_1.talkMaxDuration = var_608_6

					if var_608_6 + var_608_0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_6 + var_608_0
					end
				end

				arg_605_1.text_.text = var_608_3
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_7 = math.max(var_608_1, arg_605_1.talkMaxDuration)

			if var_608_0 <= arg_605_1.time_ and arg_605_1.time_ < var_608_0 + var_608_7 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_0) / var_608_7

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_0 + var_608_7 and arg_605_1.time_ < var_608_0 + var_608_7 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play928041143 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 928041143
		arg_609_1.duration_ = 7.4

		local var_609_0 = {
			zh = 4.3,
			ja = 7.4
		}
		local var_609_1 = manager.audio:GetLocalizationFlag()

		if var_609_0[var_609_1] ~= nil then
			arg_609_1.duration_ = var_609_0[var_609_1]
		end

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play928041144(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = arg_609_1.actors_["1080ui_story"]
			local var_612_1 = 0

			if var_612_1 < arg_609_1.time_ and arg_609_1.time_ <= var_612_1 + arg_612_0 and not isNil(var_612_0) and arg_609_1.var_.characterEffect1080ui_story == nil then
				arg_609_1.var_.characterEffect1080ui_story = var_612_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_2 = 0.200000002980232

			if var_612_1 <= arg_609_1.time_ and arg_609_1.time_ < var_612_1 + var_612_2 and not isNil(var_612_0) then
				local var_612_3 = (arg_609_1.time_ - var_612_1) / var_612_2

				if arg_609_1.var_.characterEffect1080ui_story and not isNil(var_612_0) then
					arg_609_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_609_1.time_ >= var_612_1 + var_612_2 and arg_609_1.time_ < var_612_1 + var_612_2 + arg_612_0 and not isNil(var_612_0) and arg_609_1.var_.characterEffect1080ui_story then
				arg_609_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_612_4 = 0
			local var_612_5 = 0.275

			if var_612_4 < arg_609_1.time_ and arg_609_1.time_ <= var_612_4 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				local var_612_6 = arg_609_1:FormatText(StoryNameCfg[328].name)

				arg_609_1.leftNameTxt_.text = var_612_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_7 = arg_609_1:GetWordFromCfg(928041143)
				local var_612_8 = arg_609_1:FormatText(var_612_7.content)

				arg_609_1.text_.text = var_612_8

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_9 = 11
				local var_612_10 = utf8.len(var_612_8)
				local var_612_11 = var_612_9 <= 0 and var_612_5 or var_612_5 * (var_612_10 / var_612_9)

				if var_612_11 > 0 and var_612_5 < var_612_11 then
					arg_609_1.talkMaxDuration = var_612_11

					if var_612_11 + var_612_4 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_11 + var_612_4
					end
				end

				arg_609_1.text_.text = var_612_8
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041143", "story_v_side_old_928041.awb") ~= 0 then
					local var_612_12 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041143", "story_v_side_old_928041.awb") / 1000

					if var_612_12 + var_612_4 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_12 + var_612_4
					end

					if var_612_7.prefab_name ~= "" and arg_609_1.actors_[var_612_7.prefab_name] ~= nil then
						local var_612_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_7.prefab_name].transform, "story_v_side_old_928041", "928041143", "story_v_side_old_928041.awb")

						arg_609_1:RecordAudio("928041143", var_612_13)
						arg_609_1:RecordAudio("928041143", var_612_13)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041143", "story_v_side_old_928041.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041143", "story_v_side_old_928041.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_14 = math.max(var_612_5, arg_609_1.talkMaxDuration)

			if var_612_4 <= arg_609_1.time_ and arg_609_1.time_ < var_612_4 + var_612_14 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_4) / var_612_14

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_4 + var_612_14 and arg_609_1.time_ < var_612_4 + var_612_14 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play928041144 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 928041144
		arg_613_1.duration_ = 32.3

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play928041145(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 4.43333333333333

			if var_616_0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_0 + arg_616_0 then
				SetActive(arg_613_1.dialog_, false)
				SetActive(arg_613_1.allBtn_.gameObject, false)
				arg_613_1.hideBtnsController_:SetSelectedIndex(1)
				arg_613_1:PlayOnlyBgm()

				arg_613_1.marker = "231"

				manager.video:Play("SofdecAsset/story/story_9280501.usm", function(arg_617_0)
					arg_613_1.time_ = var_616_0 + 21.0233333335569

					if arg_613_1.state_ == "pause" then
						arg_613_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_618_0)
					if arg_618_0 then
						arg_613_1.state_ = "pause"
					else
						arg_613_1.state_ = "playing"
					end
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_616_1 = 21.0333333333333

			if var_616_0 <= arg_613_1.time_ and arg_613_1.time_ < var_616_0 + var_616_1 then
				-- block empty
			end

			if arg_613_1.time_ >= var_616_0 + var_616_1 and arg_613_1.time_ < var_616_0 + var_616_1 + arg_616_0 then
				arg_613_1.marker = ""
			end

			local var_616_2 = 25.4666666666667

			if var_616_2 < arg_613_1.time_ and arg_613_1.time_ <= var_616_2 + arg_616_0 then
				SetActive(arg_613_1.dialog_, true)
				SetActive(arg_613_1.allBtn_.gameObject, true)
				arg_613_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_613_1.isInLoopVideo = false
			end

			local var_616_3 = 0.550000000000001

			if var_616_2 <= arg_613_1.time_ and arg_613_1.time_ < var_616_2 + var_616_3 then
				-- block empty
			end

			if arg_613_1.time_ >= var_616_2 + var_616_3 and arg_613_1.time_ < var_616_2 + var_616_3 + arg_616_0 then
				arg_613_1.marker = ""
			end

			local var_616_4 = manager.ui.mainCamera.transform
			local var_616_5 = 0

			if var_616_5 < arg_613_1.time_ and arg_613_1.time_ <= var_616_5 + arg_616_0 then
				local var_616_6 = arg_613_1.var_.effect2234
				local var_616_7
				local var_616_8 = var_616_4

				if not var_616_6 then
					var_616_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), var_616_8)
					var_616_6.name = "2234"
					arg_613_1.var_.effect2234 = var_616_6
				else
					var_616_6.transform:SetParent(var_616_8)
				end

				var_616_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_616_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_616_9 = manager.ui.mainCameraCom_
				local var_616_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_616_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_616_11 = var_616_6.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_616_12 = 15
				local var_616_13 = 2 * var_616_12 * Mathf.Tan(var_616_9.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_616_9.aspect
				local var_616_14 = 1
				local var_616_15 = 1.7777777777777777

				if var_616_15 < var_616_9.aspect then
					var_616_14 = var_616_13 / (2 * var_616_12 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_616_15)
				end

				for iter_616_0, iter_616_1 in ipairs(var_616_11) do
					local var_616_16 = iter_616_1.transform.localScale

					iter_616_1.transform.localScale = Vector3.New(var_616_16.x / var_616_10 * var_616_14, var_616_16.y / var_616_10, var_616_16.z)
				end
			end

			local var_616_17 = manager.ui.mainCamera.transform
			local var_616_18 = 1.2

			if var_616_18 < arg_613_1.time_ and arg_613_1.time_ <= var_616_18 + arg_616_0 then
				local var_616_19 = arg_613_1.var_.effectfgdgf
				local var_616_20
				local var_616_21 = var_616_17

				if not var_616_19 then
					var_616_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_616_21)
					var_616_19.name = "fgdgf"
					arg_613_1.var_.effectfgdgf = var_616_19
				else
					var_616_19.transform:SetParent(var_616_21)
				end

				var_616_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_616_19.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_616_22 = manager.ui.mainCameraCom_
				local var_616_23 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_616_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_616_24 = var_616_19.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_616_25 = 15
				local var_616_26 = 2 * var_616_25 * Mathf.Tan(var_616_22.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_616_22.aspect
				local var_616_27 = 1
				local var_616_28 = 1.7777777777777777

				if var_616_28 < var_616_22.aspect then
					var_616_27 = var_616_26 / (2 * var_616_25 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_616_28)
				end

				for iter_616_2, iter_616_3 in ipairs(var_616_24) do
					local var_616_29 = iter_616_3.transform.localScale

					iter_616_3.transform.localScale = Vector3.New(var_616_29.x / var_616_23 * var_616_27, var_616_29.y / var_616_23, var_616_29.z)
				end
			end

			local var_616_30 = manager.ui.mainCamera.transform
			local var_616_31 = 1.7

			if var_616_31 < arg_613_1.time_ and arg_613_1.time_ <= var_616_31 + arg_616_0 then
				local var_616_32 = arg_613_1.var_.effectfgdgf

				if var_616_32 then
					Object.Destroy(var_616_32)

					arg_613_1.var_.effectfgdgf = nil
				end
			end

			local var_616_33 = manager.ui.mainCamera.transform
			local var_616_34 = 1.2

			if var_616_34 < arg_613_1.time_ and arg_613_1.time_ <= var_616_34 + arg_616_0 then
				local var_616_35 = arg_613_1.var_.effect2234

				if var_616_35 then
					Object.Destroy(var_616_35)

					arg_613_1.var_.effect2234 = nil
				end
			end

			local var_616_36 = "STwhite"

			if arg_613_1.bgs_[var_616_36] == nil then
				local var_616_37 = Object.Instantiate(arg_613_1.paintGo_)

				var_616_37:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_616_36)
				var_616_37.name = var_616_36
				var_616_37.transform.parent = arg_613_1.stage_.transform
				var_616_37.transform.localPosition = Vector3.New(0, 100, 0)
				arg_613_1.bgs_[var_616_36] = var_616_37
			end

			local var_616_38 = 1.4

			if var_616_38 < arg_613_1.time_ and arg_613_1.time_ <= var_616_38 + arg_616_0 then
				local var_616_39 = manager.ui.mainCamera.transform.localPosition
				local var_616_40 = Vector3.New(0, 0, 10) + Vector3.New(var_616_39.x, var_616_39.y, 0)
				local var_616_41 = arg_613_1.bgs_.STwhite

				var_616_41.transform.localPosition = var_616_40
				var_616_41.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_616_42 = var_616_41:GetComponent("SpriteRenderer")

				if var_616_42 and var_616_42.sprite then
					local var_616_43 = (var_616_41.transform.localPosition - var_616_39).z
					local var_616_44 = manager.ui.mainCameraCom_
					local var_616_45 = 2 * var_616_43 * Mathf.Tan(var_616_44.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_616_46 = var_616_45 * var_616_44.aspect
					local var_616_47 = var_616_42.sprite.bounds.size.x
					local var_616_48 = var_616_42.sprite.bounds.size.y
					local var_616_49 = var_616_46 / var_616_47
					local var_616_50 = var_616_45 / var_616_48
					local var_616_51 = var_616_50 < var_616_49 and var_616_49 or var_616_50

					var_616_41.transform.localScale = Vector3.New(var_616_51, var_616_51, 0)
				end

				for iter_616_4, iter_616_5 in pairs(arg_613_1.bgs_) do
					if iter_616_4 ~= "STwhite" then
						iter_616_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_616_52 = "STblack"

			if arg_613_1.bgs_[var_616_52] == nil then
				local var_616_53 = Object.Instantiate(arg_613_1.paintGo_)

				var_616_53:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_616_52)
				var_616_53.name = var_616_52
				var_616_53.transform.parent = arg_613_1.stage_.transform
				var_616_53.transform.localPosition = Vector3.New(0, 100, 0)
				arg_613_1.bgs_[var_616_52] = var_616_53
			end

			local var_616_54 = 4.43333333333333

			if var_616_54 < arg_613_1.time_ and arg_613_1.time_ <= var_616_54 + arg_616_0 then
				local var_616_55 = manager.ui.mainCamera.transform.localPosition
				local var_616_56 = Vector3.New(0, 0, 10) + Vector3.New(var_616_55.x, var_616_55.y, 0)
				local var_616_57 = arg_613_1.bgs_.STblack

				var_616_57.transform.localPosition = var_616_56
				var_616_57.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_616_58 = var_616_57:GetComponent("SpriteRenderer")

				if var_616_58 and var_616_58.sprite then
					local var_616_59 = (var_616_57.transform.localPosition - var_616_55).z
					local var_616_60 = manager.ui.mainCameraCom_
					local var_616_61 = 2 * var_616_59 * Mathf.Tan(var_616_60.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_616_62 = var_616_61 * var_616_60.aspect
					local var_616_63 = var_616_58.sprite.bounds.size.x
					local var_616_64 = var_616_58.sprite.bounds.size.y
					local var_616_65 = var_616_62 / var_616_63
					local var_616_66 = var_616_61 / var_616_64
					local var_616_67 = var_616_66 < var_616_65 and var_616_65 or var_616_66

					var_616_57.transform.localScale = Vector3.New(var_616_67, var_616_67, 0)
				end

				for iter_616_6, iter_616_7 in pairs(arg_613_1.bgs_) do
					if iter_616_6 ~= "STblack" then
						iter_616_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_616_68 = 1.26666666666667

			if var_616_68 < arg_613_1.time_ and arg_613_1.time_ <= var_616_68 + arg_616_0 then
				arg_613_1.allBtn_.enabled = false
			end

			local var_616_69 = 1.93333333333333

			if arg_613_1.time_ >= var_616_68 + var_616_69 and arg_613_1.time_ < var_616_68 + var_616_69 + arg_616_0 then
				arg_613_1.allBtn_.enabled = true
			end

			local var_616_70 = 4.2
			local var_616_71 = 1

			if var_616_70 < arg_613_1.time_ and arg_613_1.time_ <= var_616_70 + arg_616_0 then
				local var_616_72 = "play"
				local var_616_73 = "music"

				arg_613_1:AudioAction(var_616_72, var_616_73, "bgm_activity_4_5_scene_108502_story", "bgm_activity_4_5_scene_108502_story", "bgm_activity_4_5_scene_108502_story.awb")

				local var_616_74 = ""
				local var_616_75 = manager.audio:GetAudioName("bgm_activity_4_5_scene_108502_story", "bgm_activity_4_5_scene_108502_story")

				if var_616_75 ~= "" then
					if arg_613_1.bgmTxt_.text ~= var_616_75 and arg_613_1.bgmTxt_.text ~= "" then
						if arg_613_1.bgmTxt2_.text ~= "" then
							arg_613_1.bgmTxt_.text = arg_613_1.bgmTxt2_.text
						end

						arg_613_1.bgmTxt2_.text = var_616_75

						arg_613_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_613_1.bgmTxt_.text = var_616_75
						arg_613_1.bgmTxt2_.text = var_616_75
					end

					if arg_613_1.bgmTimer then
						arg_613_1.bgmTimer:Stop()

						arg_613_1.bgmTimer = nil
					end

					if arg_613_1.settingData.show_music_name == 1 then
						arg_613_1.musicController:SetSelectedState("show")
						arg_613_1.musicAnimator_:Play("open", 0, 0)

						if arg_613_1.settingData.music_time ~= 0 then
							arg_613_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_613_1.settingData.music_time), function()
								if arg_613_1 == nil or isNil(arg_613_1.bgmTxt_) then
									return
								end

								arg_613_1.musicController:SetSelectedState("hide")
								arg_613_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_616_76 = 26.5666666666667

			if var_616_76 < arg_613_1.time_ and arg_613_1.time_ <= var_616_76 + arg_616_0 then
				arg_613_1.allBtn_.enabled = false
			end

			local var_616_77 = 5.73333333333333

			if arg_613_1.time_ >= var_616_76 + var_616_77 and arg_613_1.time_ < var_616_76 + var_616_77 + arg_616_0 then
				arg_613_1.allBtn_.enabled = true
			end

			local var_616_78 = 1.43333333333333

			if var_616_78 < arg_613_1.time_ and arg_613_1.time_ <= var_616_78 + arg_616_0 then
				arg_613_1.fswbg_:SetActive(true)
				arg_613_1.dialog_:SetActive(false)

				arg_613_1.fswtw_.percent = 0

				local var_616_79 = arg_613_1:GetWordFromCfg(928041144)
				local var_616_80 = arg_613_1:FormatText(var_616_79.content)

				arg_613_1.fswt_.text = var_616_80

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.fswt_)

				arg_613_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_613_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_613_1.fswtw_:SetDirty()

				arg_613_1.typewritterCharCountI18N = 0

				SetActive(arg_613_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_613_1:ShowNextGo(false)
			end

			local var_616_81 = 25.4666666666667

			if var_616_81 < arg_613_1.time_ and arg_613_1.time_ <= var_616_81 + arg_616_0 then
				arg_613_1.fswbg_:SetActive(false)
				arg_613_1.dialog_:SetActive(false)
				SetActive(arg_613_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_613_1:ShowNextGo(false)
			end

			local var_616_82 = 27.3166666666667

			if var_616_82 < arg_613_1.time_ and arg_613_1.time_ <= var_616_82 + arg_616_0 then
				arg_613_1.fswbg_:SetActive(true)
				arg_613_1.dialog_:SetActive(false)

				arg_613_1.fswtw_.percent = 0

				local var_616_83 = arg_613_1:GetWordFromCfg(928041144)
				local var_616_84 = arg_613_1:FormatText(var_616_83.content)

				arg_613_1.fswt_.text = var_616_84

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.fswt_)

				arg_613_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_613_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_613_1.fswtw_:SetDirty()

				arg_613_1.typewritterCharCountI18N = 0

				SetActive(arg_613_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_613_1:ShowNextGo(false)
			end

			local var_616_85 = 27.3333333333333

			if var_616_85 < arg_613_1.time_ and arg_613_1.time_ <= var_616_85 + arg_616_0 then
				arg_613_1.var_.oldValueTypewriter = arg_613_1.fswtw_.percent

				SetActive(arg_613_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_613_1:ShowNextGo(false)
			end

			local var_616_86 = 28
			local var_616_87 = 1.86666666666667
			local var_616_88 = arg_613_1:GetWordFromCfg(928041144)
			local var_616_89 = arg_613_1:FormatText(var_616_88.content)
			local var_616_90, var_616_91 = arg_613_1:GetPercentByPara(var_616_89, 1)

			if var_616_85 < arg_613_1.time_ and arg_613_1.time_ <= var_616_85 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0

				local var_616_92 = var_616_86 <= 0 and var_616_87 or var_616_87 * ((var_616_91 - arg_613_1.typewritterCharCountI18N) / var_616_86)

				if var_616_92 > 0 and var_616_87 < var_616_92 then
					arg_613_1.talkMaxDuration = var_616_92

					if var_616_92 + var_616_85 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_92 + var_616_85
					end
				end
			end

			local var_616_93 = 1.86666666666667
			local var_616_94 = math.max(var_616_93, arg_613_1.talkMaxDuration)

			if var_616_85 <= arg_613_1.time_ and arg_613_1.time_ < var_616_85 + var_616_94 then
				local var_616_95 = (arg_613_1.time_ - var_616_85) / var_616_94

				arg_613_1.fswtw_.percent = Mathf.Lerp(arg_613_1.var_.oldValueTypewriter, var_616_90, var_616_95)
				arg_613_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_613_1.fswtw_:SetDirty()
			end

			if arg_613_1.time_ >= var_616_85 + var_616_94 and arg_613_1.time_ < var_616_85 + var_616_94 + arg_616_0 then
				arg_613_1.fswtw_.percent = var_616_90

				arg_613_1.fswtw_:SetDirty()
				arg_613_1:ShowNextGo(true)

				arg_613_1.typewritterCharCountI18N = var_616_91
			end

			local var_616_96 = 26.5666666666667

			if var_616_96 < arg_613_1.time_ and arg_613_1.time_ <= var_616_96 + arg_616_0 then
				local var_616_97 = arg_613_1.fswbg_.transform:Find("textbox/adapt/content") or arg_613_1.fswbg_.transform:Find("textbox/content")
				local var_616_98 = arg_613_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_616_99 = var_616_97:GetComponent("Text")
				local var_616_100 = var_616_97:GetComponent("RectTransform")

				var_616_99.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_616_100.offsetMin = Vector2.New(0, 0)
				var_616_100.offsetMax = Vector2.New(0, 0)
			end

			local var_616_101 = manager.ui.mainCamera.transform
			local var_616_102 = 0

			if var_616_102 < arg_613_1.time_ and arg_613_1.time_ <= var_616_102 + arg_616_0 then
				local var_616_103 = arg_613_1.var_.effect32err

				if var_616_103 then
					Object.Destroy(var_616_103)

					arg_613_1.var_.effect32err = nil
				end
			end

			local var_616_104 = 0

			if var_616_104 < arg_613_1.time_ and arg_613_1.time_ <= var_616_104 + arg_616_0 then
				arg_613_1.allBtn_.enabled = false
			end

			local var_616_105 = 6.16666666666666

			if arg_613_1.time_ >= var_616_104 + var_616_105 and arg_613_1.time_ < var_616_104 + var_616_105 + arg_616_0 then
				arg_613_1.allBtn_.enabled = true
			end

			local var_616_106 = 1.16666666666667
			local var_616_107 = 1

			if var_616_106 < arg_613_1.time_ and arg_613_1.time_ <= var_616_106 + arg_616_0 then
				local var_616_108 = "play"
				local var_616_109 = "effect"

				arg_613_1:AudioAction(var_616_108, var_616_109, "se_story_145", "se_story_145_magic_whoosh02", "")
			end

			local var_616_110 = 2.2

			if var_616_110 < arg_613_1.time_ and arg_613_1.time_ <= var_616_110 + arg_616_0 then
				arg_613_1.mask_.enabled = true
				arg_613_1.mask_.raycastTarget = true

				arg_613_1:SetGaussion(false)
			end

			local var_616_111 = 2.23333333333333

			if var_616_110 <= arg_613_1.time_ and arg_613_1.time_ < var_616_110 + var_616_111 then
				local var_616_112 = (arg_613_1.time_ - var_616_110) / var_616_111
				local var_616_113 = Color.New(0, 0, 0)

				var_616_113.a = Mathf.Lerp(0, 1, var_616_112)
				arg_613_1.mask_.color = var_616_113
			end

			if arg_613_1.time_ >= var_616_110 + var_616_111 and arg_613_1.time_ < var_616_110 + var_616_111 + arg_616_0 then
				local var_616_114 = Color.New(0, 0, 0)

				var_616_114.a = 1
				arg_613_1.mask_.color = var_616_114
			end

			local var_616_115 = 4.43333333333333

			if var_616_115 < arg_613_1.time_ and arg_613_1.time_ <= var_616_115 + arg_616_0 then
				arg_613_1.mask_.enabled = true
				arg_613_1.mask_.raycastTarget = true

				arg_613_1:SetGaussion(false)
			end

			local var_616_116 = 1

			if var_616_115 <= arg_613_1.time_ and arg_613_1.time_ < var_616_115 + var_616_116 then
				local var_616_117 = (arg_613_1.time_ - var_616_115) / var_616_116
				local var_616_118 = Color.New(0, 0, 0)

				var_616_118.a = Mathf.Lerp(1, 0, var_616_117)
				arg_613_1.mask_.color = var_616_118
			end

			if arg_613_1.time_ >= var_616_115 + var_616_116 and arg_613_1.time_ < var_616_115 + var_616_116 + arg_616_0 then
				local var_616_119 = Color.New(0, 0, 0)
				local var_616_120 = 0

				arg_613_1.mask_.enabled = false
				var_616_119.a = var_616_120
				arg_613_1.mask_.color = var_616_119
			end

			local var_616_121 = 0
			local var_616_122 = 1

			if var_616_121 < arg_613_1.time_ and arg_613_1.time_ <= var_616_121 + arg_616_0 then
				local var_616_123 = "stop"
				local var_616_124 = "effect"

				arg_613_1:AudioAction(var_616_123, var_616_124, "se_story_side_1084", "se_story_1084_applause", "")
			end

			local var_616_125 = 0
			local var_616_126 = 1

			if var_616_125 < arg_613_1.time_ and arg_613_1.time_ <= var_616_125 + arg_616_0 then
				local var_616_127 = "stop"
				local var_616_128 = "effect"

				arg_613_1:AudioAction(var_616_127, var_616_128, "se_story_145", "se_story_145_bell", "")
			end

			local var_616_129 = 0
			local var_616_130 = 1

			if var_616_129 < arg_613_1.time_ and arg_613_1.time_ <= var_616_129 + arg_616_0 then
				local var_616_131 = "stop"
				local var_616_132 = "effect"

				arg_613_1:AudioAction(var_616_131, var_616_132, "se_story_145", "se_story_145_foley_bag", "")
			end

			local var_616_133 = 0
			local var_616_134 = 1

			if var_616_133 < arg_613_1.time_ and arg_613_1.time_ <= var_616_133 + arg_616_0 then
				local var_616_135 = "stop"
				local var_616_136 = "effect"

				arg_613_1:AudioAction(var_616_135, var_616_136, "se_story_145", "se_story_145_magic_whoosh01", "")
			end

			local var_616_137 = 0
			local var_616_138 = 1

			if var_616_137 < arg_613_1.time_ and arg_613_1.time_ <= var_616_137 + arg_616_0 then
				local var_616_139 = "stop"
				local var_616_140 = "effect"

				arg_613_1:AudioAction(var_616_139, var_616_140, "se_story_122_02", "se_story_122_02_footstep", "")
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play928041145 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 928041145
		arg_620_1.duration_ = 3.13

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"

			SetActive(arg_620_1.choicesGo_, true)

			for iter_621_0, iter_621_1 in ipairs(arg_620_1.choices_) do
				local var_621_0 = iter_621_0 <= 1

				SetActive(iter_621_1.go, var_621_0)
			end

			arg_620_1.choices_[1].txt.text = arg_620_1:FormatText(StoryChoiceCfg[1442].name)
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play928041146(arg_620_1)
			end

			arg_620_1:RecordChoiceLog(928041145, 1442)
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 1.06666666666667

			if var_623_0 < arg_620_1.time_ and arg_620_1.time_ <= var_623_0 + arg_623_0 then
				local var_623_1 = manager.ui.mainCamera.transform.localPosition
				local var_623_2 = Vector3.New(0, 0, 10) + Vector3.New(var_623_1.x, var_623_1.y, 0)
				local var_623_3 = arg_620_1.bgs_.STblack

				var_623_3.transform.localPosition = var_623_2
				var_623_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_623_4 = var_623_3:GetComponent("SpriteRenderer")

				if var_623_4 and var_623_4.sprite then
					local var_623_5 = (var_623_3.transform.localPosition - var_623_1).z
					local var_623_6 = manager.ui.mainCameraCom_
					local var_623_7 = 2 * var_623_5 * Mathf.Tan(var_623_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_623_8 = var_623_7 * var_623_6.aspect
					local var_623_9 = var_623_4.sprite.bounds.size.x
					local var_623_10 = var_623_4.sprite.bounds.size.y
					local var_623_11 = var_623_8 / var_623_9
					local var_623_12 = var_623_7 / var_623_10
					local var_623_13 = var_623_12 < var_623_11 and var_623_11 or var_623_12

					var_623_3.transform.localScale = Vector3.New(var_623_13, var_623_13, 0)
				end

				for iter_623_0, iter_623_1 in pairs(arg_620_1.bgs_) do
					if iter_623_0 ~= "STblack" then
						iter_623_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_623_14 = 0

			if var_623_14 < arg_620_1.time_ and arg_620_1.time_ <= var_623_14 + arg_623_0 then
				arg_620_1.allBtn_.enabled = false
			end

			local var_623_15 = 0.3

			if arg_620_1.time_ >= var_623_14 + var_623_15 and arg_620_1.time_ < var_623_14 + var_623_15 + arg_623_0 then
				arg_620_1.allBtn_.enabled = true
			end

			local var_623_16 = 0

			if var_623_16 < arg_620_1.time_ and arg_620_1.time_ <= var_623_16 + arg_623_0 then
				arg_620_1.mask_.enabled = true
				arg_620_1.mask_.raycastTarget = true

				arg_620_1:SetGaussion(false)
			end

			local var_623_17 = 1.06666666666667

			if var_623_16 <= arg_620_1.time_ and arg_620_1.time_ < var_623_16 + var_623_17 then
				local var_623_18 = (arg_620_1.time_ - var_623_16) / var_623_17
				local var_623_19 = Color.New(0, 0, 0)

				var_623_19.a = Mathf.Lerp(0, 1, var_623_18)
				arg_620_1.mask_.color = var_623_19
			end

			if arg_620_1.time_ >= var_623_16 + var_623_17 and arg_620_1.time_ < var_623_16 + var_623_17 + arg_623_0 then
				local var_623_20 = Color.New(0, 0, 0)

				var_623_20.a = 1
				arg_620_1.mask_.color = var_623_20
			end

			local var_623_21 = 1.06666666666667

			if var_623_21 < arg_620_1.time_ and arg_620_1.time_ <= var_623_21 + arg_623_0 then
				arg_620_1.mask_.enabled = true
				arg_620_1.mask_.raycastTarget = true

				arg_620_1:SetGaussion(false)
			end

			local var_623_22 = 1.06666666666667

			if var_623_21 <= arg_620_1.time_ and arg_620_1.time_ < var_623_21 + var_623_22 then
				local var_623_23 = (arg_620_1.time_ - var_623_21) / var_623_22
				local var_623_24 = Color.New(0, 0, 0)

				var_623_24.a = Mathf.Lerp(1, 0, var_623_23)
				arg_620_1.mask_.color = var_623_24
			end

			if arg_620_1.time_ >= var_623_21 + var_623_22 and arg_620_1.time_ < var_623_21 + var_623_22 + arg_623_0 then
				local var_623_25 = Color.New(0, 0, 0)
				local var_623_26 = 0

				arg_620_1.mask_.enabled = false
				var_623_25.a = var_623_26
				arg_620_1.mask_.color = var_623_25
			end

			local var_623_27 = 1.06666666666667

			if var_623_27 < arg_620_1.time_ and arg_620_1.time_ <= var_623_27 + arg_623_0 then
				arg_620_1.fswbg_:SetActive(false)
				arg_620_1.dialog_:SetActive(false)
				SetActive(arg_620_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_620_1:ShowNextGo(false)
			end

			local var_623_28 = 1.08333333333333

			if var_623_28 < arg_620_1.time_ and arg_620_1.time_ <= var_623_28 + arg_623_0 then
				arg_620_1.fswbg_:SetActive(false)
				arg_620_1.dialog_:SetActive(false)
				SetActive(arg_620_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_620_1:ShowNextGo(false)
			end

			local var_623_29 = 0.1
			local var_623_30 = 0.3

			if var_623_29 < arg_620_1.time_ and arg_620_1.time_ <= var_623_29 + arg_623_0 then
				local var_623_31 = "play"
				local var_623_32 = "music"

				arg_620_1:AudioAction(var_623_31, var_623_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_623_33 = ""
				local var_623_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_623_34 ~= "" then
					if arg_620_1.bgmTxt_.text ~= var_623_34 and arg_620_1.bgmTxt_.text ~= "" then
						if arg_620_1.bgmTxt2_.text ~= "" then
							arg_620_1.bgmTxt_.text = arg_620_1.bgmTxt2_.text
						end

						arg_620_1.bgmTxt2_.text = var_623_34

						arg_620_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_620_1.bgmTxt_.text = var_623_34
						arg_620_1.bgmTxt2_.text = var_623_34
					end

					if arg_620_1.bgmTimer then
						arg_620_1.bgmTimer:Stop()

						arg_620_1.bgmTimer = nil
					end

					if arg_620_1.settingData.show_music_name == 1 then
						arg_620_1.musicController:SetSelectedState("show")
						arg_620_1.musicAnimator_:Play("open", 0, 0)

						if arg_620_1.settingData.music_time ~= 0 then
							arg_620_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_620_1.settingData.music_time), function()
								if arg_620_1 == nil or isNil(arg_620_1.bgmTxt_) then
									return
								end

								arg_620_1.musicController:SetSelectedState("hide")
								arg_620_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play928041146 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 928041146
		arg_625_1.duration_ = 9.13

		local var_625_0 = {
			zh = 8.433333333332,
			ja = 9.13333333333333
		}
		local var_625_1 = manager.audio:GetLocalizationFlag()

		if var_625_0[var_625_1] ~= nil then
			arg_625_1.duration_ = var_625_0[var_625_1]
		end

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play928041147(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = "ST2201"

			if arg_625_1.bgs_[var_628_0] == nil then
				local var_628_1 = Object.Instantiate(arg_625_1.paintGo_)

				var_628_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_628_0)
				var_628_1.name = var_628_0
				var_628_1.transform.parent = arg_625_1.stage_.transform
				var_628_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_625_1.bgs_[var_628_0] = var_628_1
			end

			local var_628_2 = 2.03333333333333

			if var_628_2 < arg_625_1.time_ and arg_625_1.time_ <= var_628_2 + arg_628_0 then
				local var_628_3 = manager.ui.mainCamera.transform.localPosition
				local var_628_4 = Vector3.New(0, 0, 10) + Vector3.New(var_628_3.x, var_628_3.y, 0)
				local var_628_5 = arg_625_1.bgs_.ST2201

				var_628_5.transform.localPosition = var_628_4
				var_628_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_628_6 = var_628_5:GetComponent("SpriteRenderer")

				if var_628_6 and var_628_6.sprite then
					local var_628_7 = (var_628_5.transform.localPosition - var_628_3).z
					local var_628_8 = manager.ui.mainCameraCom_
					local var_628_9 = 2 * var_628_7 * Mathf.Tan(var_628_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_628_10 = var_628_9 * var_628_8.aspect
					local var_628_11 = var_628_6.sprite.bounds.size.x
					local var_628_12 = var_628_6.sprite.bounds.size.y
					local var_628_13 = var_628_10 / var_628_11
					local var_628_14 = var_628_9 / var_628_12
					local var_628_15 = var_628_14 < var_628_13 and var_628_13 or var_628_14

					var_628_5.transform.localScale = Vector3.New(var_628_15, var_628_15, 0)
				end

				for iter_628_0, iter_628_1 in pairs(arg_625_1.bgs_) do
					if iter_628_0 ~= "ST2201" then
						iter_628_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_628_16 = 0

			if var_628_16 < arg_625_1.time_ and arg_625_1.time_ <= var_628_16 + arg_628_0 then
				arg_625_1.mask_.enabled = true
				arg_625_1.mask_.raycastTarget = true

				arg_625_1:SetGaussion(false)
			end

			local var_628_17 = 2.06733333518108

			if var_628_16 <= arg_625_1.time_ and arg_625_1.time_ < var_628_16 + var_628_17 then
				local var_628_18 = (arg_625_1.time_ - var_628_16) / var_628_17
				local var_628_19 = Color.New(0, 0, 0)

				var_628_19.a = Mathf.Lerp(0, 1, var_628_18)
				arg_625_1.mask_.color = var_628_19
			end

			if arg_625_1.time_ >= var_628_16 + var_628_17 and arg_625_1.time_ < var_628_16 + var_628_17 + arg_628_0 then
				local var_628_20 = Color.New(0, 0, 0)

				var_628_20.a = 1
				arg_625_1.mask_.color = var_628_20
			end

			local var_628_21 = 2.06733333518108

			if var_628_21 < arg_625_1.time_ and arg_625_1.time_ <= var_628_21 + arg_628_0 then
				arg_625_1.mask_.enabled = true
				arg_625_1.mask_.raycastTarget = true

				arg_625_1:SetGaussion(false)
			end

			local var_628_22 = 1.26666666666667

			if var_628_21 <= arg_625_1.time_ and arg_625_1.time_ < var_628_21 + var_628_22 then
				local var_628_23 = (arg_625_1.time_ - var_628_21) / var_628_22
				local var_628_24 = Color.New(0, 0, 0)

				var_628_24.a = Mathf.Lerp(1, 0, var_628_23)
				arg_625_1.mask_.color = var_628_24
			end

			if arg_625_1.time_ >= var_628_21 + var_628_22 and arg_625_1.time_ < var_628_21 + var_628_22 + arg_628_0 then
				local var_628_25 = Color.New(0, 0, 0)
				local var_628_26 = 0

				arg_625_1.mask_.enabled = false
				var_628_25.a = var_628_26
				arg_625_1.mask_.color = var_628_25
			end

			local var_628_27 = 4.3

			if var_628_27 < arg_625_1.time_ and arg_625_1.time_ <= var_628_27 + arg_628_0 then
				arg_625_1.allBtn_.enabled = false
			end

			local var_628_28 = 0.3

			if arg_625_1.time_ >= var_628_27 + var_628_28 and arg_625_1.time_ < var_628_27 + var_628_28 + arg_628_0 then
				arg_625_1.allBtn_.enabled = true
			end

			local var_628_29 = arg_625_1.actors_.ST2201
			local var_628_30 = 2.03333333333333

			if var_628_30 < arg_625_1.time_ and arg_625_1.time_ <= var_628_30 + arg_628_0 then
				local var_628_31 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_628_31 then
					var_628_31.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_628_31.radialBlurScale = 0
					var_628_31.radialBlurGradient = 1
					var_628_31.radialBlurIntensity = 1

					if var_628_29 then
						var_628_31.radialBlurTarget = var_628_29.transform
					end
				end
			end

			local var_628_32 = 0.200000002980232

			if var_628_30 <= arg_625_1.time_ and arg_625_1.time_ < var_628_30 + var_628_32 then
				local var_628_33 = (arg_625_1.time_ - var_628_30) / var_628_32
				local var_628_34 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_628_34 then
					var_628_34.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_628_34.radialBlurScale = Mathf.Lerp(0, 0.819, var_628_33)
					var_628_34.radialBlurGradient = Mathf.Lerp(1, 1, var_628_33)
					var_628_34.radialBlurIntensity = Mathf.Lerp(1, 1, var_628_33)
				end
			end

			if arg_625_1.time_ >= var_628_30 + var_628_32 and arg_625_1.time_ < var_628_30 + var_628_32 + arg_628_0 then
				local var_628_35 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_628_35 then
					var_628_35.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_628_35.radialBlurScale = 0.819
					var_628_35.radialBlurGradient = 1
					var_628_35.radialBlurIntensity = 1
				end
			end

			local var_628_36 = arg_625_1.actors_.ST2201
			local var_628_37 = 4.9

			if var_628_37 < arg_625_1.time_ and arg_625_1.time_ <= var_628_37 + arg_628_0 then
				local var_628_38 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_628_38 then
					var_628_38.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_628_38.radialBlurScale = 0.836
					var_628_38.radialBlurGradient = 1
					var_628_38.radialBlurIntensity = 1

					if var_628_36 then
						var_628_38.radialBlurTarget = var_628_36.transform
					end
				end
			end

			local var_628_39 = 1.6

			if var_628_37 <= arg_625_1.time_ and arg_625_1.time_ < var_628_37 + var_628_39 then
				local var_628_40 = (arg_625_1.time_ - var_628_37) / var_628_39
				local var_628_41 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_628_41 then
					var_628_41.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_628_41.radialBlurScale = Mathf.Lerp(0.836, 0, var_628_40)
					var_628_41.radialBlurGradient = Mathf.Lerp(1, 1, var_628_40)
					var_628_41.radialBlurIntensity = Mathf.Lerp(1, 1, var_628_40)
				end
			end

			if arg_625_1.time_ >= var_628_37 + var_628_39 and arg_625_1.time_ < var_628_37 + var_628_39 + arg_628_0 then
				local var_628_42 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_628_42 then
					var_628_42.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_628_42.radialBlurScale = 0
					var_628_42.radialBlurGradient = 1
					var_628_42.radialBlurIntensity = 1
				end
			end

			local var_628_43 = manager.ui.mainCamera.transform
			local var_628_44 = 2.03333333333333

			if var_628_44 < arg_625_1.time_ and arg_625_1.time_ <= var_628_44 + arg_628_0 then
				local var_628_45 = arg_625_1.var_.effectwewe
				local var_628_46
				local var_628_47 = var_628_43

				if not var_628_45 then
					var_628_45 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapblink"), var_628_47)
					var_628_45.name = "wewe"
					arg_625_1.var_.effectwewe = var_628_45
				else
					var_628_45.transform:SetParent(var_628_47)
				end

				var_628_45.transform.localPosition = Vector3.New(0, 0, 0)
				var_628_45.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_628_48 = manager.ui.mainCameraCom_
				local var_628_49 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_628_48.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_628_50 = var_628_45.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_628_51 = 15
				local var_628_52 = 2 * var_628_51 * Mathf.Tan(var_628_48.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_628_48.aspect
				local var_628_53 = 1
				local var_628_54 = 1.7777777777777777

				if var_628_54 < var_628_48.aspect then
					var_628_53 = var_628_52 / (2 * var_628_51 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_628_54)
				end

				for iter_628_2, iter_628_3 in ipairs(var_628_50) do
					local var_628_55 = iter_628_3.transform.localScale

					iter_628_3.transform.localScale = Vector3.New(var_628_55.x / var_628_49 * var_628_53, var_628_55.y / var_628_49, var_628_55.z)
				end
			end

			local var_628_56 = manager.ui.mainCamera.transform
			local var_628_57 = 5.23333333333333

			if var_628_57 < arg_625_1.time_ and arg_625_1.time_ <= var_628_57 + arg_628_0 then
				local var_628_58 = arg_625_1.var_.effectwewe

				if var_628_58 then
					Object.Destroy(var_628_58)

					arg_625_1.var_.effectwewe = nil
				end
			end

			local var_628_59 = "1066ui_story"

			if arg_625_1.actors_[var_628_59] == nil then
				local var_628_60 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_628_60) then
					local var_628_61 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_625_1.stage_.transform)

					var_628_61.name = var_628_59
					var_628_61.transform.localPosition = Vector3.New(0, 100, 0)
					arg_625_1.actors_[var_628_59] = var_628_61

					local var_628_62 = var_628_61:GetComponentInChildren(typeof(CharacterEffect))

					var_628_62.enabled = true

					local var_628_63 = GameObjectTools.GetOrAddComponent(var_628_61, typeof(DynamicBoneHelper))

					if var_628_63 then
						var_628_63:EnableDynamicBone(false)
					end

					arg_625_1:ShowWeapon(var_628_62.transform, false)

					arg_625_1.var_[var_628_59 .. "Animator"] = var_628_62.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_625_1.var_[var_628_59 .. "Animator"].applyRootMotion = true
					arg_625_1.var_[var_628_59 .. "LipSync"] = var_628_62.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_628_64 = arg_625_1.actors_["1066ui_story"]
			local var_628_65 = 2.06733333518108

			if var_628_65 < arg_625_1.time_ and arg_625_1.time_ <= var_628_65 + arg_628_0 and not isNil(var_628_64) and arg_625_1.var_.characterEffect1066ui_story == nil then
				arg_625_1.var_.characterEffect1066ui_story = var_628_64:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_66 = 0.200000002980232

			if var_628_65 <= arg_625_1.time_ and arg_625_1.time_ < var_628_65 + var_628_66 and not isNil(var_628_64) then
				local var_628_67 = (arg_625_1.time_ - var_628_65) / var_628_66

				if arg_625_1.var_.characterEffect1066ui_story and not isNil(var_628_64) then
					arg_625_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_625_1.time_ >= var_628_65 + var_628_66 and arg_625_1.time_ < var_628_65 + var_628_66 + arg_628_0 and not isNil(var_628_64) and arg_625_1.var_.characterEffect1066ui_story then
				arg_625_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_628_68 = 2.06733333518108

			if var_628_68 < arg_625_1.time_ and arg_625_1.time_ <= var_628_68 + arg_628_0 then
				arg_625_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			local var_628_69 = 2.06733333518108

			if var_628_69 < arg_625_1.time_ and arg_625_1.time_ <= var_628_69 + arg_628_0 then
				arg_625_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_628_70 = 3.33400000184774

			if var_628_70 < arg_625_1.time_ and arg_625_1.time_ <= var_628_70 + arg_628_0 then
				arg_625_1.allBtn_.enabled = false
			end

			local var_628_71 = 3.56599999815226

			if arg_625_1.time_ >= var_628_70 + var_628_71 and arg_625_1.time_ < var_628_70 + var_628_71 + arg_628_0 then
				arg_625_1.allBtn_.enabled = true
			end

			local var_628_72 = arg_625_1.actors_["1066ui_story"].transform
			local var_628_73 = 2.06733333518108

			if var_628_73 < arg_625_1.time_ and arg_625_1.time_ <= var_628_73 + arg_628_0 then
				arg_625_1.var_.moveOldPos1066ui_story = var_628_72.localPosition
			end

			local var_628_74 = 0.001

			if var_628_73 <= arg_625_1.time_ and arg_625_1.time_ < var_628_73 + var_628_74 then
				local var_628_75 = (arg_625_1.time_ - var_628_73) / var_628_74
				local var_628_76 = Vector3.New(0, 100, 0)

				var_628_72.localPosition = Vector3.Lerp(arg_625_1.var_.moveOldPos1066ui_story, var_628_76, var_628_75)

				local var_628_77 = manager.ui.mainCamera.transform.position - var_628_72.position

				var_628_72.forward = Vector3.New(var_628_77.x, var_628_77.y, var_628_77.z)

				local var_628_78 = var_628_72.localEulerAngles

				var_628_78.z = 0
				var_628_78.x = 0
				var_628_72.localEulerAngles = var_628_78
			end

			if arg_625_1.time_ >= var_628_73 + var_628_74 and arg_625_1.time_ < var_628_73 + var_628_74 + arg_628_0 then
				var_628_72.localPosition = Vector3.New(0, 100, 0)

				local var_628_79 = manager.ui.mainCamera.transform.position - var_628_72.position

				var_628_72.forward = Vector3.New(var_628_79.x, var_628_79.y, var_628_79.z)

				local var_628_80 = var_628_72.localEulerAngles

				var_628_80.z = 0
				var_628_80.x = 0
				var_628_72.localEulerAngles = var_628_80
			end

			local var_628_81 = 0.133333333333333
			local var_628_82 = 1

			if var_628_81 < arg_625_1.time_ and arg_625_1.time_ <= var_628_81 + arg_628_0 then
				local var_628_83 = "stop"
				local var_628_84 = "effect"

				arg_625_1:AudioAction(var_628_83, var_628_84, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_628_85 = 0.133333333333333
			local var_628_86 = 1

			if var_628_85 < arg_625_1.time_ and arg_625_1.time_ <= var_628_85 + arg_628_0 then
				local var_628_87 = "stop"
				local var_628_88 = "effect"

				arg_625_1:AudioAction(var_628_87, var_628_88, "se_story_145", "se_story_145_wind02", "")
			end

			local var_628_89 = 1.86666666666667
			local var_628_90 = 1

			if var_628_89 < arg_625_1.time_ and arg_625_1.time_ <= var_628_89 + arg_628_0 then
				local var_628_91 = "play"
				local var_628_92 = "effect"

				arg_625_1:AudioAction(var_628_91, var_628_92, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_628_93 = 0
			local var_628_94 = 1

			if var_628_93 < arg_625_1.time_ and arg_625_1.time_ <= var_628_93 + arg_628_0 then
				local var_628_95 = "play"
				local var_628_96 = "effect"

				arg_625_1:AudioAction(var_628_95, var_628_96, "se_story_140", "se_story_140_riser", "")
			end

			if arg_625_1.frameCnt_ <= 1 then
				arg_625_1.dialog_:SetActive(false)
			end

			local var_628_97 = 2.83333333333333
			local var_628_98 = 0.65

			if var_628_97 < arg_625_1.time_ and arg_625_1.time_ <= var_628_97 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0

				arg_625_1.dialog_:SetActive(true)

				arg_625_1.dialogCg_.alpha = 0

				local var_628_99 = LeanTween.value(arg_625_1.dialog_, 0, 1, 0.3)

				var_628_99:setOnUpdate(LuaHelper.FloatAction(function(arg_629_0)
					arg_625_1.dialogCg_.alpha = arg_629_0
				end))
				var_628_99:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_625_1.dialog_)
					var_628_99:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_625_1.duration_ = arg_625_1.duration_ + 0.3

				SetActive(arg_625_1.leftNameGo_, true)

				local var_628_100 = arg_625_1:FormatText(StoryNameCfg[36].name)

				arg_625_1.leftNameTxt_.text = var_628_100

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_101 = arg_625_1:GetWordFromCfg(928041146)
				local var_628_102 = arg_625_1:FormatText(var_628_101.content)

				arg_625_1.text_.text = var_628_102

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_103 = 16
				local var_628_104 = utf8.len(var_628_102)
				local var_628_105 = var_628_103 <= 0 and var_628_98 or var_628_98 * (var_628_104 / var_628_103)

				if var_628_105 > 0 and var_628_98 < var_628_105 then
					arg_625_1.talkMaxDuration = var_628_105
					var_628_97 = var_628_97 + 0.3

					if var_628_105 + var_628_97 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_105 + var_628_97
					end
				end

				arg_625_1.text_.text = var_628_102
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041146", "story_v_side_old_928041.awb") ~= 0 then
					local var_628_106 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041146", "story_v_side_old_928041.awb") / 1000

					if var_628_106 + var_628_97 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_106 + var_628_97
					end

					if var_628_101.prefab_name ~= "" and arg_625_1.actors_[var_628_101.prefab_name] ~= nil then
						local var_628_107 = LuaForUtil.PlayVoiceWithCriLipsync(arg_625_1.actors_[var_628_101.prefab_name].transform, "story_v_side_old_928041", "928041146", "story_v_side_old_928041.awb")

						arg_625_1:RecordAudio("928041146", var_628_107)
						arg_625_1:RecordAudio("928041146", var_628_107)
					else
						arg_625_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041146", "story_v_side_old_928041.awb")
					end

					arg_625_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041146", "story_v_side_old_928041.awb")
				end

				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_108 = var_628_97 + 0.3
			local var_628_109 = math.max(var_628_98, arg_625_1.talkMaxDuration)

			if var_628_108 <= arg_625_1.time_ and arg_625_1.time_ < var_628_108 + var_628_109 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_108) / var_628_109

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_108 + var_628_109 and arg_625_1.time_ < var_628_108 + var_628_109 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.06733333518108,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_625_1:InitPlayNodeList()
	end,
	Play928041147 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 928041147
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play928041148(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = arg_631_1.actors_["1066ui_story"]
			local var_634_1 = 0

			if var_634_1 < arg_631_1.time_ and arg_631_1.time_ <= var_634_1 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect1066ui_story == nil then
				arg_631_1.var_.characterEffect1066ui_story = var_634_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_2 = 0.200000002980232

			if var_634_1 <= arg_631_1.time_ and arg_631_1.time_ < var_634_1 + var_634_2 and not isNil(var_634_0) then
				local var_634_3 = (arg_631_1.time_ - var_634_1) / var_634_2

				if arg_631_1.var_.characterEffect1066ui_story and not isNil(var_634_0) then
					local var_634_4 = Mathf.Lerp(0, 0.5, var_634_3)

					arg_631_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_631_1.var_.characterEffect1066ui_story.fillRatio = var_634_4
				end
			end

			if arg_631_1.time_ >= var_634_1 + var_634_2 and arg_631_1.time_ < var_634_1 + var_634_2 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect1066ui_story then
				local var_634_5 = 0.5

				arg_631_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_631_1.var_.characterEffect1066ui_story.fillRatio = var_634_5
			end

			local var_634_6 = 0
			local var_634_7 = 0.65

			if var_634_6 < arg_631_1.time_ and arg_631_1.time_ <= var_634_6 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, false)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_8 = arg_631_1:GetWordFromCfg(928041147)
				local var_634_9 = arg_631_1:FormatText(var_634_8.content)

				arg_631_1.text_.text = var_634_9

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_10 = 26
				local var_634_11 = utf8.len(var_634_9)
				local var_634_12 = var_634_10 <= 0 and var_634_7 or var_634_7 * (var_634_11 / var_634_10)

				if var_634_12 > 0 and var_634_7 < var_634_12 then
					arg_631_1.talkMaxDuration = var_634_12

					if var_634_12 + var_634_6 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_12 + var_634_6
					end
				end

				arg_631_1.text_.text = var_634_9
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_13 = math.max(var_634_7, arg_631_1.talkMaxDuration)

			if var_634_6 <= arg_631_1.time_ and arg_631_1.time_ < var_634_6 + var_634_13 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_6) / var_634_13

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_6 + var_634_13 and arg_631_1.time_ < var_634_6 + var_634_13 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play928041148 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 928041148
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play928041149(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = 0
			local var_638_1 = 0.3

			if var_638_0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_0 + arg_638_0 then
				local var_638_2 = "play"
				local var_638_3 = "music"

				arg_635_1:AudioAction(var_638_2, var_638_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_638_4 = ""
				local var_638_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_638_5 ~= "" then
					if arg_635_1.bgmTxt_.text ~= var_638_5 and arg_635_1.bgmTxt_.text ~= "" then
						if arg_635_1.bgmTxt2_.text ~= "" then
							arg_635_1.bgmTxt_.text = arg_635_1.bgmTxt2_.text
						end

						arg_635_1.bgmTxt2_.text = var_638_5

						arg_635_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_635_1.bgmTxt_.text = var_638_5
						arg_635_1.bgmTxt2_.text = var_638_5
					end

					if arg_635_1.bgmTimer then
						arg_635_1.bgmTimer:Stop()

						arg_635_1.bgmTimer = nil
					end

					if arg_635_1.settingData.show_music_name == 1 then
						arg_635_1.musicController:SetSelectedState("show")
						arg_635_1.musicAnimator_:Play("open", 0, 0)

						if arg_635_1.settingData.music_time ~= 0 then
							arg_635_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_635_1.settingData.music_time), function()
								if arg_635_1 == nil or isNil(arg_635_1.bgmTxt_) then
									return
								end

								arg_635_1.musicController:SetSelectedState("hide")
								arg_635_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_638_6 = 0.375
			local var_638_7 = 1

			if var_638_6 < arg_635_1.time_ and arg_635_1.time_ <= var_638_6 + arg_638_0 then
				local var_638_8 = "play"
				local var_638_9 = "music"

				arg_635_1:AudioAction(var_638_8, var_638_9, "bgm_story_quiet_1", "bgm_story_quiet_1", "bgm_story_quiet_1.awb")

				local var_638_10 = ""
				local var_638_11 = manager.audio:GetAudioName("bgm_story_quiet_1", "bgm_story_quiet_1")

				if var_638_11 ~= "" then
					if arg_635_1.bgmTxt_.text ~= var_638_11 and arg_635_1.bgmTxt_.text ~= "" then
						if arg_635_1.bgmTxt2_.text ~= "" then
							arg_635_1.bgmTxt_.text = arg_635_1.bgmTxt2_.text
						end

						arg_635_1.bgmTxt2_.text = var_638_11

						arg_635_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_635_1.bgmTxt_.text = var_638_11
						arg_635_1.bgmTxt2_.text = var_638_11
					end

					if arg_635_1.bgmTimer then
						arg_635_1.bgmTimer:Stop()

						arg_635_1.bgmTimer = nil
					end

					if arg_635_1.settingData.show_music_name == 1 then
						arg_635_1.musicController:SetSelectedState("show")
						arg_635_1.musicAnimator_:Play("open", 0, 0)

						if arg_635_1.settingData.music_time ~= 0 then
							arg_635_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_635_1.settingData.music_time), function()
								if arg_635_1 == nil or isNil(arg_635_1.bgmTxt_) then
									return
								end

								arg_635_1.musicController:SetSelectedState("hide")
								arg_635_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_638_12 = 0
			local var_638_13 = 0.375

			if var_638_12 < arg_635_1.time_ and arg_635_1.time_ <= var_638_12 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				local var_638_14 = arg_635_1:FormatText(StoryNameCfg[7].name)

				arg_635_1.leftNameTxt_.text = var_638_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, true)
				arg_635_1.iconController_:SetSelectedState("hero")

				arg_635_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_635_1.callingController_:SetSelectedState("normal")

				arg_635_1.keyicon_.color = Color.New(1, 1, 1)
				arg_635_1.icon_.color = Color.New(1, 1, 1)

				local var_638_15 = arg_635_1:GetWordFromCfg(928041148)
				local var_638_16 = arg_635_1:FormatText(var_638_15.content)

				arg_635_1.text_.text = var_638_16

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_17 = 15
				local var_638_18 = utf8.len(var_638_16)
				local var_638_19 = var_638_17 <= 0 and var_638_13 or var_638_13 * (var_638_18 / var_638_17)

				if var_638_19 > 0 and var_638_13 < var_638_19 then
					arg_635_1.talkMaxDuration = var_638_19

					if var_638_19 + var_638_12 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_19 + var_638_12
					end
				end

				arg_635_1.text_.text = var_638_16
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_20 = math.max(var_638_13, arg_635_1.talkMaxDuration)

			if var_638_12 <= arg_635_1.time_ and arg_635_1.time_ < var_638_12 + var_638_20 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_12) / var_638_20

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_12 + var_638_20 and arg_635_1.time_ < var_638_12 + var_638_20 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play928041149 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 928041149
		arg_641_1.duration_ = 4.63

		local var_641_0 = {
			zh = 4.3,
			ja = 4.633
		}
		local var_641_1 = manager.audio:GetLocalizationFlag()

		if var_641_0[var_641_1] ~= nil then
			arg_641_1.duration_ = var_641_0[var_641_1]
		end

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play928041150(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = arg_641_1.actors_["1066ui_story"]
			local var_644_1 = 0

			if var_644_1 < arg_641_1.time_ and arg_641_1.time_ <= var_644_1 + arg_644_0 and not isNil(var_644_0) and arg_641_1.var_.characterEffect1066ui_story == nil then
				arg_641_1.var_.characterEffect1066ui_story = var_644_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_2 = 0.200000002980232

			if var_644_1 <= arg_641_1.time_ and arg_641_1.time_ < var_644_1 + var_644_2 and not isNil(var_644_0) then
				local var_644_3 = (arg_641_1.time_ - var_644_1) / var_644_2

				if arg_641_1.var_.characterEffect1066ui_story and not isNil(var_644_0) then
					arg_641_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_641_1.time_ >= var_644_1 + var_644_2 and arg_641_1.time_ < var_644_1 + var_644_2 + arg_644_0 and not isNil(var_644_0) and arg_641_1.var_.characterEffect1066ui_story then
				arg_641_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_644_4 = 0

			if var_644_4 < arg_641_1.time_ and arg_641_1.time_ <= var_644_4 + arg_644_0 then
				arg_641_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action6_1")
			end

			local var_644_5 = 0

			if var_644_5 < arg_641_1.time_ and arg_641_1.time_ <= var_644_5 + arg_644_0 then
				arg_641_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_644_6 = arg_641_1.actors_["1066ui_story"].transform
			local var_644_7 = 0

			if var_644_7 < arg_641_1.time_ and arg_641_1.time_ <= var_644_7 + arg_644_0 then
				arg_641_1.var_.moveOldPos1066ui_story = var_644_6.localPosition
			end

			local var_644_8 = 0.001

			if var_644_7 <= arg_641_1.time_ and arg_641_1.time_ < var_644_7 + var_644_8 then
				local var_644_9 = (arg_641_1.time_ - var_644_7) / var_644_8
				local var_644_10 = Vector3.New(0, -0.77, -6.1)

				var_644_6.localPosition = Vector3.Lerp(arg_641_1.var_.moveOldPos1066ui_story, var_644_10, var_644_9)

				local var_644_11 = manager.ui.mainCamera.transform.position - var_644_6.position

				var_644_6.forward = Vector3.New(var_644_11.x, var_644_11.y, var_644_11.z)

				local var_644_12 = var_644_6.localEulerAngles

				var_644_12.z = 0
				var_644_12.x = 0
				var_644_6.localEulerAngles = var_644_12
			end

			if arg_641_1.time_ >= var_644_7 + var_644_8 and arg_641_1.time_ < var_644_7 + var_644_8 + arg_644_0 then
				var_644_6.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_644_13 = manager.ui.mainCamera.transform.position - var_644_6.position

				var_644_6.forward = Vector3.New(var_644_13.x, var_644_13.y, var_644_13.z)

				local var_644_14 = var_644_6.localEulerAngles

				var_644_14.z = 0
				var_644_14.x = 0
				var_644_6.localEulerAngles = var_644_14
			end

			local var_644_15 = 0
			local var_644_16 = 0.475

			if var_644_15 < arg_641_1.time_ and arg_641_1.time_ <= var_644_15 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				local var_644_17 = arg_641_1:FormatText(StoryNameCfg[32].name)

				arg_641_1.leftNameTxt_.text = var_644_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_18 = arg_641_1:GetWordFromCfg(928041149)
				local var_644_19 = arg_641_1:FormatText(var_644_18.content)

				arg_641_1.text_.text = var_644_19

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_20 = 19
				local var_644_21 = utf8.len(var_644_19)
				local var_644_22 = var_644_20 <= 0 and var_644_16 or var_644_16 * (var_644_21 / var_644_20)

				if var_644_22 > 0 and var_644_16 < var_644_22 then
					arg_641_1.talkMaxDuration = var_644_22

					if var_644_22 + var_644_15 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_22 + var_644_15
					end
				end

				arg_641_1.text_.text = var_644_19
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041149", "story_v_side_old_928041.awb") ~= 0 then
					local var_644_23 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041149", "story_v_side_old_928041.awb") / 1000

					if var_644_23 + var_644_15 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_23 + var_644_15
					end

					if var_644_18.prefab_name ~= "" and arg_641_1.actors_[var_644_18.prefab_name] ~= nil then
						local var_644_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_18.prefab_name].transform, "story_v_side_old_928041", "928041149", "story_v_side_old_928041.awb")

						arg_641_1:RecordAudio("928041149", var_644_24)
						arg_641_1:RecordAudio("928041149", var_644_24)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041149", "story_v_side_old_928041.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041149", "story_v_side_old_928041.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_25 = math.max(var_644_16, arg_641_1.talkMaxDuration)

			if var_644_15 <= arg_641_1.time_ and arg_641_1.time_ < var_644_15 + var_644_25 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_15) / var_644_25

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_15 + var_644_25 and arg_641_1.time_ < var_644_15 + var_644_25 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {
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

		arg_641_1:InitPlayNodeList()
	end,
	Play928041150 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 928041150
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play928041151(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = arg_645_1.actors_["1066ui_story"]
			local var_648_1 = 0

			if var_648_1 < arg_645_1.time_ and arg_645_1.time_ <= var_648_1 + arg_648_0 and not isNil(var_648_0) and arg_645_1.var_.characterEffect1066ui_story == nil then
				arg_645_1.var_.characterEffect1066ui_story = var_648_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_648_2 = 0.200000002980232

			if var_648_1 <= arg_645_1.time_ and arg_645_1.time_ < var_648_1 + var_648_2 and not isNil(var_648_0) then
				local var_648_3 = (arg_645_1.time_ - var_648_1) / var_648_2

				if arg_645_1.var_.characterEffect1066ui_story and not isNil(var_648_0) then
					local var_648_4 = Mathf.Lerp(0, 0.5, var_648_3)

					arg_645_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_645_1.var_.characterEffect1066ui_story.fillRatio = var_648_4
				end
			end

			if arg_645_1.time_ >= var_648_1 + var_648_2 and arg_645_1.time_ < var_648_1 + var_648_2 + arg_648_0 and not isNil(var_648_0) and arg_645_1.var_.characterEffect1066ui_story then
				local var_648_5 = 0.5

				arg_645_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_645_1.var_.characterEffect1066ui_story.fillRatio = var_648_5
			end

			local var_648_6 = 0
			local var_648_7 = 0.4

			if var_648_6 < arg_645_1.time_ and arg_645_1.time_ <= var_648_6 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, false)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_8 = arg_645_1:GetWordFromCfg(928041150)
				local var_648_9 = arg_645_1:FormatText(var_648_8.content)

				arg_645_1.text_.text = var_648_9

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_10 = 16
				local var_648_11 = utf8.len(var_648_9)
				local var_648_12 = var_648_10 <= 0 and var_648_7 or var_648_7 * (var_648_11 / var_648_10)

				if var_648_12 > 0 and var_648_7 < var_648_12 then
					arg_645_1.talkMaxDuration = var_648_12

					if var_648_12 + var_648_6 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_12 + var_648_6
					end
				end

				arg_645_1.text_.text = var_648_9
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_13 = math.max(var_648_7, arg_645_1.talkMaxDuration)

			if var_648_6 <= arg_645_1.time_ and arg_645_1.time_ < var_648_6 + var_648_13 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_6) / var_648_13

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_6 + var_648_13 and arg_645_1.time_ < var_648_6 + var_648_13 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play928041151 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 928041151
		arg_649_1.duration_ = 6.67

		local var_649_0 = {
			zh = 5.933,
			ja = 6.666
		}
		local var_649_1 = manager.audio:GetLocalizationFlag()

		if var_649_0[var_649_1] ~= nil then
			arg_649_1.duration_ = var_649_0[var_649_1]
		end

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play928041152(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = arg_649_1.actors_["1066ui_story"]
			local var_652_1 = 0

			if var_652_1 < arg_649_1.time_ and arg_649_1.time_ <= var_652_1 + arg_652_0 and not isNil(var_652_0) and arg_649_1.var_.characterEffect1066ui_story == nil then
				arg_649_1.var_.characterEffect1066ui_story = var_652_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_652_2 = 0.200000002980232

			if var_652_1 <= arg_649_1.time_ and arg_649_1.time_ < var_652_1 + var_652_2 and not isNil(var_652_0) then
				local var_652_3 = (arg_649_1.time_ - var_652_1) / var_652_2

				if arg_649_1.var_.characterEffect1066ui_story and not isNil(var_652_0) then
					arg_649_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_649_1.time_ >= var_652_1 + var_652_2 and arg_649_1.time_ < var_652_1 + var_652_2 + arg_652_0 and not isNil(var_652_0) and arg_649_1.var_.characterEffect1066ui_story then
				arg_649_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_652_4 = 0

			if var_652_4 < arg_649_1.time_ and arg_649_1.time_ <= var_652_4 + arg_652_0 then
				arg_649_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action463")
			end

			local var_652_5 = 0

			if var_652_5 < arg_649_1.time_ and arg_649_1.time_ <= var_652_5 + arg_652_0 then
				arg_649_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_652_6 = 0
			local var_652_7 = 0.6

			if var_652_6 < arg_649_1.time_ and arg_649_1.time_ <= var_652_6 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				local var_652_8 = arg_649_1:FormatText(StoryNameCfg[32].name)

				arg_649_1.leftNameTxt_.text = var_652_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_9 = arg_649_1:GetWordFromCfg(928041151)
				local var_652_10 = arg_649_1:FormatText(var_652_9.content)

				arg_649_1.text_.text = var_652_10

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_11 = 24
				local var_652_12 = utf8.len(var_652_10)
				local var_652_13 = var_652_11 <= 0 and var_652_7 or var_652_7 * (var_652_12 / var_652_11)

				if var_652_13 > 0 and var_652_7 < var_652_13 then
					arg_649_1.talkMaxDuration = var_652_13

					if var_652_13 + var_652_6 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_13 + var_652_6
					end
				end

				arg_649_1.text_.text = var_652_10
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041151", "story_v_side_old_928041.awb") ~= 0 then
					local var_652_14 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041151", "story_v_side_old_928041.awb") / 1000

					if var_652_14 + var_652_6 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_14 + var_652_6
					end

					if var_652_9.prefab_name ~= "" and arg_649_1.actors_[var_652_9.prefab_name] ~= nil then
						local var_652_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_9.prefab_name].transform, "story_v_side_old_928041", "928041151", "story_v_side_old_928041.awb")

						arg_649_1:RecordAudio("928041151", var_652_15)
						arg_649_1:RecordAudio("928041151", var_652_15)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041151", "story_v_side_old_928041.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041151", "story_v_side_old_928041.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_16 = math.max(var_652_7, arg_649_1.talkMaxDuration)

			if var_652_6 <= arg_649_1.time_ and arg_649_1.time_ < var_652_6 + var_652_16 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_6) / var_652_16

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_6 + var_652_16 and arg_649_1.time_ < var_652_6 + var_652_16 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play928041152 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 928041152
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play928041153(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = arg_653_1.actors_["1066ui_story"]
			local var_656_1 = 0

			if var_656_1 < arg_653_1.time_ and arg_653_1.time_ <= var_656_1 + arg_656_0 and not isNil(var_656_0) and arg_653_1.var_.characterEffect1066ui_story == nil then
				arg_653_1.var_.characterEffect1066ui_story = var_656_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_2 = 0.200000002980232

			if var_656_1 <= arg_653_1.time_ and arg_653_1.time_ < var_656_1 + var_656_2 and not isNil(var_656_0) then
				local var_656_3 = (arg_653_1.time_ - var_656_1) / var_656_2

				if arg_653_1.var_.characterEffect1066ui_story and not isNil(var_656_0) then
					local var_656_4 = Mathf.Lerp(0, 0.5, var_656_3)

					arg_653_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_653_1.var_.characterEffect1066ui_story.fillRatio = var_656_4
				end
			end

			if arg_653_1.time_ >= var_656_1 + var_656_2 and arg_653_1.time_ < var_656_1 + var_656_2 + arg_656_0 and not isNil(var_656_0) and arg_653_1.var_.characterEffect1066ui_story then
				local var_656_5 = 0.5

				arg_653_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_653_1.var_.characterEffect1066ui_story.fillRatio = var_656_5
			end

			local var_656_6 = 0
			local var_656_7 = 0.2

			if var_656_6 < arg_653_1.time_ and arg_653_1.time_ <= var_656_6 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				local var_656_8 = arg_653_1:FormatText(StoryNameCfg[7].name)

				arg_653_1.leftNameTxt_.text = var_656_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, true)
				arg_653_1.iconController_:SetSelectedState("hero")

				arg_653_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_653_1.callingController_:SetSelectedState("normal")

				arg_653_1.keyicon_.color = Color.New(1, 1, 1)
				arg_653_1.icon_.color = Color.New(1, 1, 1)

				local var_656_9 = arg_653_1:GetWordFromCfg(928041152)
				local var_656_10 = arg_653_1:FormatText(var_656_9.content)

				arg_653_1.text_.text = var_656_10

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_11 = 8
				local var_656_12 = utf8.len(var_656_10)
				local var_656_13 = var_656_11 <= 0 and var_656_7 or var_656_7 * (var_656_12 / var_656_11)

				if var_656_13 > 0 and var_656_7 < var_656_13 then
					arg_653_1.talkMaxDuration = var_656_13

					if var_656_13 + var_656_6 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_13 + var_656_6
					end
				end

				arg_653_1.text_.text = var_656_10
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_14 = math.max(var_656_7, arg_653_1.talkMaxDuration)

			if var_656_6 <= arg_653_1.time_ and arg_653_1.time_ < var_656_6 + var_656_14 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_6) / var_656_14

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_6 + var_656_14 and arg_653_1.time_ < var_656_6 + var_656_14 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play928041153 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 928041153
		arg_657_1.duration_ = 2.7

		local var_657_0 = {
			zh = 2.7,
			ja = 1.999999999999
		}
		local var_657_1 = manager.audio:GetLocalizationFlag()

		if var_657_0[var_657_1] ~= nil then
			arg_657_1.duration_ = var_657_0[var_657_1]
		end

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play928041154(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = arg_657_1.actors_["1085ui_story"]
			local var_660_1 = 0

			if var_660_1 < arg_657_1.time_ and arg_657_1.time_ <= var_660_1 + arg_660_0 and not isNil(var_660_0) and arg_657_1.var_.characterEffect1085ui_story == nil then
				arg_657_1.var_.characterEffect1085ui_story = var_660_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_2 = 0.566666666666667

			if var_660_1 <= arg_657_1.time_ and arg_657_1.time_ < var_660_1 + var_660_2 and not isNil(var_660_0) then
				local var_660_3 = (arg_657_1.time_ - var_660_1) / var_660_2

				if arg_657_1.var_.characterEffect1085ui_story and not isNil(var_660_0) then
					arg_657_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_657_1.time_ >= var_660_1 + var_660_2 and arg_657_1.time_ < var_660_1 + var_660_2 + arg_660_0 and not isNil(var_660_0) and arg_657_1.var_.characterEffect1085ui_story then
				arg_657_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_660_4 = 0

			if var_660_4 < arg_657_1.time_ and arg_657_1.time_ <= var_660_4 + arg_660_0 then
				arg_657_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_1")
			end

			local var_660_5 = 0

			if var_660_5 < arg_657_1.time_ and arg_657_1.time_ <= var_660_5 + arg_660_0 then
				arg_657_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_660_6 = arg_657_1.actors_["1085ui_story"].transform
			local var_660_7 = 0

			if var_660_7 < arg_657_1.time_ and arg_657_1.time_ <= var_660_7 + arg_660_0 then
				arg_657_1.var_.moveOldPos1085ui_story = var_660_6.localPosition
			end

			local var_660_8 = 0.001

			if var_660_7 <= arg_657_1.time_ and arg_657_1.time_ < var_660_7 + var_660_8 then
				local var_660_9 = (arg_657_1.time_ - var_660_7) / var_660_8
				local var_660_10 = Vector3.New(0, -1.01, -5.83)

				var_660_6.localPosition = Vector3.Lerp(arg_657_1.var_.moveOldPos1085ui_story, var_660_10, var_660_9)

				local var_660_11 = manager.ui.mainCamera.transform.position - var_660_6.position

				var_660_6.forward = Vector3.New(var_660_11.x, var_660_11.y, var_660_11.z)

				local var_660_12 = var_660_6.localEulerAngles

				var_660_12.z = 0
				var_660_12.x = 0
				var_660_6.localEulerAngles = var_660_12
			end

			if arg_657_1.time_ >= var_660_7 + var_660_8 and arg_657_1.time_ < var_660_7 + var_660_8 + arg_660_0 then
				var_660_6.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_660_13 = manager.ui.mainCamera.transform.position - var_660_6.position

				var_660_6.forward = Vector3.New(var_660_13.x, var_660_13.y, var_660_13.z)

				local var_660_14 = var_660_6.localEulerAngles

				var_660_14.z = 0
				var_660_14.x = 0
				var_660_6.localEulerAngles = var_660_14
			end

			local var_660_15 = arg_657_1.actors_["1066ui_story"].transform
			local var_660_16 = 0

			if var_660_16 < arg_657_1.time_ and arg_657_1.time_ <= var_660_16 + arg_660_0 then
				arg_657_1.var_.moveOldPos1066ui_story = var_660_15.localPosition
			end

			local var_660_17 = 0.001

			if var_660_16 <= arg_657_1.time_ and arg_657_1.time_ < var_660_16 + var_660_17 then
				local var_660_18 = (arg_657_1.time_ - var_660_16) / var_660_17
				local var_660_19 = Vector3.New(0, 100, 0)

				var_660_15.localPosition = Vector3.Lerp(arg_657_1.var_.moveOldPos1066ui_story, var_660_19, var_660_18)

				local var_660_20 = manager.ui.mainCamera.transform.position - var_660_15.position

				var_660_15.forward = Vector3.New(var_660_20.x, var_660_20.y, var_660_20.z)

				local var_660_21 = var_660_15.localEulerAngles

				var_660_21.z = 0
				var_660_21.x = 0
				var_660_15.localEulerAngles = var_660_21
			end

			if arg_657_1.time_ >= var_660_16 + var_660_17 and arg_657_1.time_ < var_660_16 + var_660_17 + arg_660_0 then
				var_660_15.localPosition = Vector3.New(0, 100, 0)

				local var_660_22 = manager.ui.mainCamera.transform.position - var_660_15.position

				var_660_15.forward = Vector3.New(var_660_22.x, var_660_22.y, var_660_22.z)

				local var_660_23 = var_660_15.localEulerAngles

				var_660_23.z = 0
				var_660_23.x = 0
				var_660_15.localEulerAngles = var_660_23
			end

			local var_660_24 = 0
			local var_660_25 = 0.075

			if var_660_24 < arg_657_1.time_ and arg_657_1.time_ <= var_660_24 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				local var_660_26 = arg_657_1:FormatText(StoryNameCfg[328].name)

				arg_657_1.leftNameTxt_.text = var_660_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_27 = arg_657_1:GetWordFromCfg(928041153)
				local var_660_28 = arg_657_1:FormatText(var_660_27.content)

				arg_657_1.text_.text = var_660_28

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_29 = 3
				local var_660_30 = utf8.len(var_660_28)
				local var_660_31 = var_660_29 <= 0 and var_660_25 or var_660_25 * (var_660_30 / var_660_29)

				if var_660_31 > 0 and var_660_25 < var_660_31 then
					arg_657_1.talkMaxDuration = var_660_31

					if var_660_31 + var_660_24 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_31 + var_660_24
					end
				end

				arg_657_1.text_.text = var_660_28
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041153", "story_v_side_old_928041.awb") ~= 0 then
					local var_660_32 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041153", "story_v_side_old_928041.awb") / 1000

					if var_660_32 + var_660_24 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_32 + var_660_24
					end

					if var_660_27.prefab_name ~= "" and arg_657_1.actors_[var_660_27.prefab_name] ~= nil then
						local var_660_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_27.prefab_name].transform, "story_v_side_old_928041", "928041153", "story_v_side_old_928041.awb")

						arg_657_1:RecordAudio("928041153", var_660_33)
						arg_657_1:RecordAudio("928041153", var_660_33)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041153", "story_v_side_old_928041.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041153", "story_v_side_old_928041.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_34 = math.max(var_660_25, arg_657_1.talkMaxDuration)

			if var_660_24 <= arg_657_1.time_ and arg_657_1.time_ < var_660_24 + var_660_34 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_24) / var_660_34

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_24 + var_660_34 and arg_657_1.time_ < var_660_24 + var_660_34 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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

		arg_657_1:InitPlayNodeList()
	end,
	Play928041154 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 928041154
		arg_661_1.duration_ = 5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play928041155(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = arg_661_1.actors_["1085ui_story"]
			local var_664_1 = 0

			if var_664_1 < arg_661_1.time_ and arg_661_1.time_ <= var_664_1 + arg_664_0 and not isNil(var_664_0) and arg_661_1.var_.characterEffect1085ui_story == nil then
				arg_661_1.var_.characterEffect1085ui_story = var_664_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_2 = 0.200000002980232

			if var_664_1 <= arg_661_1.time_ and arg_661_1.time_ < var_664_1 + var_664_2 and not isNil(var_664_0) then
				local var_664_3 = (arg_661_1.time_ - var_664_1) / var_664_2

				if arg_661_1.var_.characterEffect1085ui_story and not isNil(var_664_0) then
					local var_664_4 = Mathf.Lerp(0, 0.5, var_664_3)

					arg_661_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_661_1.var_.characterEffect1085ui_story.fillRatio = var_664_4
				end
			end

			if arg_661_1.time_ >= var_664_1 + var_664_2 and arg_661_1.time_ < var_664_1 + var_664_2 + arg_664_0 and not isNil(var_664_0) and arg_661_1.var_.characterEffect1085ui_story then
				local var_664_5 = 0.5

				arg_661_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_661_1.var_.characterEffect1085ui_story.fillRatio = var_664_5
			end

			local var_664_6 = 0
			local var_664_7 = 0.125

			if var_664_6 < arg_661_1.time_ and arg_661_1.time_ <= var_664_6 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				local var_664_8 = arg_661_1:FormatText(StoryNameCfg[7].name)

				arg_661_1.leftNameTxt_.text = var_664_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, true)
				arg_661_1.iconController_:SetSelectedState("hero")

				arg_661_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_661_1.callingController_:SetSelectedState("normal")

				arg_661_1.keyicon_.color = Color.New(1, 1, 1)
				arg_661_1.icon_.color = Color.New(1, 1, 1)

				local var_664_9 = arg_661_1:GetWordFromCfg(928041154)
				local var_664_10 = arg_661_1:FormatText(var_664_9.content)

				arg_661_1.text_.text = var_664_10

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_11 = 5
				local var_664_12 = utf8.len(var_664_10)
				local var_664_13 = var_664_11 <= 0 and var_664_7 or var_664_7 * (var_664_12 / var_664_11)

				if var_664_13 > 0 and var_664_7 < var_664_13 then
					arg_661_1.talkMaxDuration = var_664_13

					if var_664_13 + var_664_6 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_13 + var_664_6
					end
				end

				arg_661_1.text_.text = var_664_10
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_14 = math.max(var_664_7, arg_661_1.talkMaxDuration)

			if var_664_6 <= arg_661_1.time_ and arg_661_1.time_ < var_664_6 + var_664_14 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_6) / var_664_14

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_6 + var_664_14 and arg_661_1.time_ < var_664_6 + var_664_14 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play928041155 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 928041155
		arg_665_1.duration_ = 5.73

		local var_665_0 = {
			zh = 3.533,
			ja = 5.733
		}
		local var_665_1 = manager.audio:GetLocalizationFlag()

		if var_665_0[var_665_1] ~= nil then
			arg_665_1.duration_ = var_665_0[var_665_1]
		end

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play928041156(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = arg_665_1.actors_["1085ui_story"]
			local var_668_1 = 0

			if var_668_1 < arg_665_1.time_ and arg_665_1.time_ <= var_668_1 + arg_668_0 and not isNil(var_668_0) and arg_665_1.var_.characterEffect1085ui_story == nil then
				arg_665_1.var_.characterEffect1085ui_story = var_668_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_668_2 = 0.200000002980232

			if var_668_1 <= arg_665_1.time_ and arg_665_1.time_ < var_668_1 + var_668_2 and not isNil(var_668_0) then
				local var_668_3 = (arg_665_1.time_ - var_668_1) / var_668_2

				if arg_665_1.var_.characterEffect1085ui_story and not isNil(var_668_0) then
					arg_665_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_665_1.time_ >= var_668_1 + var_668_2 and arg_665_1.time_ < var_668_1 + var_668_2 + arg_668_0 and not isNil(var_668_0) and arg_665_1.var_.characterEffect1085ui_story then
				arg_665_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_668_4 = 0

			if var_668_4 < arg_665_1.time_ and arg_665_1.time_ <= var_668_4 + arg_668_0 then
				arg_665_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_2")
			end

			local var_668_5 = 0

			if var_668_5 < arg_665_1.time_ and arg_665_1.time_ <= var_668_5 + arg_668_0 then
				arg_665_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_668_6 = 0
			local var_668_7 = 0.35

			if var_668_6 < arg_665_1.time_ and arg_665_1.time_ <= var_668_6 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				local var_668_8 = arg_665_1:FormatText(StoryNameCfg[328].name)

				arg_665_1.leftNameTxt_.text = var_668_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_9 = arg_665_1:GetWordFromCfg(928041155)
				local var_668_10 = arg_665_1:FormatText(var_668_9.content)

				arg_665_1.text_.text = var_668_10

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_11 = 14
				local var_668_12 = utf8.len(var_668_10)
				local var_668_13 = var_668_11 <= 0 and var_668_7 or var_668_7 * (var_668_12 / var_668_11)

				if var_668_13 > 0 and var_668_7 < var_668_13 then
					arg_665_1.talkMaxDuration = var_668_13

					if var_668_13 + var_668_6 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_13 + var_668_6
					end
				end

				arg_665_1.text_.text = var_668_10
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041155", "story_v_side_old_928041.awb") ~= 0 then
					local var_668_14 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041155", "story_v_side_old_928041.awb") / 1000

					if var_668_14 + var_668_6 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_14 + var_668_6
					end

					if var_668_9.prefab_name ~= "" and arg_665_1.actors_[var_668_9.prefab_name] ~= nil then
						local var_668_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_665_1.actors_[var_668_9.prefab_name].transform, "story_v_side_old_928041", "928041155", "story_v_side_old_928041.awb")

						arg_665_1:RecordAudio("928041155", var_668_15)
						arg_665_1:RecordAudio("928041155", var_668_15)
					else
						arg_665_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041155", "story_v_side_old_928041.awb")
					end

					arg_665_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041155", "story_v_side_old_928041.awb")
				end

				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_16 = math.max(var_668_7, arg_665_1.talkMaxDuration)

			if var_668_6 <= arg_665_1.time_ and arg_665_1.time_ < var_668_6 + var_668_16 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_6) / var_668_16

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_6 + var_668_16 and arg_665_1.time_ < var_668_6 + var_668_16 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play928041156 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 928041156
		arg_669_1.duration_ = 5

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play928041157(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = arg_669_1.actors_["1085ui_story"].transform
			local var_672_1 = 0

			if var_672_1 < arg_669_1.time_ and arg_669_1.time_ <= var_672_1 + arg_672_0 then
				arg_669_1.var_.moveOldPos1085ui_story = var_672_0.localPosition
			end

			local var_672_2 = 0.001

			if var_672_1 <= arg_669_1.time_ and arg_669_1.time_ < var_672_1 + var_672_2 then
				local var_672_3 = (arg_669_1.time_ - var_672_1) / var_672_2
				local var_672_4 = Vector3.New(0, 100, 0)

				var_672_0.localPosition = Vector3.Lerp(arg_669_1.var_.moveOldPos1085ui_story, var_672_4, var_672_3)

				local var_672_5 = manager.ui.mainCamera.transform.position - var_672_0.position

				var_672_0.forward = Vector3.New(var_672_5.x, var_672_5.y, var_672_5.z)

				local var_672_6 = var_672_0.localEulerAngles

				var_672_6.z = 0
				var_672_6.x = 0
				var_672_0.localEulerAngles = var_672_6
			end

			if arg_669_1.time_ >= var_672_1 + var_672_2 and arg_669_1.time_ < var_672_1 + var_672_2 + arg_672_0 then
				var_672_0.localPosition = Vector3.New(0, 100, 0)

				local var_672_7 = manager.ui.mainCamera.transform.position - var_672_0.position

				var_672_0.forward = Vector3.New(var_672_7.x, var_672_7.y, var_672_7.z)

				local var_672_8 = var_672_0.localEulerAngles

				var_672_8.z = 0
				var_672_8.x = 0
				var_672_0.localEulerAngles = var_672_8
			end

			local var_672_9 = arg_669_1.actors_["1085ui_story"]
			local var_672_10 = 0

			if var_672_10 < arg_669_1.time_ and arg_669_1.time_ <= var_672_10 + arg_672_0 and not isNil(var_672_9) and arg_669_1.var_.characterEffect1085ui_story == nil then
				arg_669_1.var_.characterEffect1085ui_story = var_672_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_672_11 = 0.200000002980232

			if var_672_10 <= arg_669_1.time_ and arg_669_1.time_ < var_672_10 + var_672_11 and not isNil(var_672_9) then
				local var_672_12 = (arg_669_1.time_ - var_672_10) / var_672_11

				if arg_669_1.var_.characterEffect1085ui_story and not isNil(var_672_9) then
					local var_672_13 = Mathf.Lerp(0, 0.5, var_672_12)

					arg_669_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_669_1.var_.characterEffect1085ui_story.fillRatio = var_672_13
				end
			end

			if arg_669_1.time_ >= var_672_10 + var_672_11 and arg_669_1.time_ < var_672_10 + var_672_11 + arg_672_0 and not isNil(var_672_9) and arg_669_1.var_.characterEffect1085ui_story then
				local var_672_14 = 0.5

				arg_669_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_669_1.var_.characterEffect1085ui_story.fillRatio = var_672_14
			end

			local var_672_15 = 0
			local var_672_16 = 0.625

			if var_672_15 < arg_669_1.time_ and arg_669_1.time_ <= var_672_15 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, false)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_17 = arg_669_1:GetWordFromCfg(928041156)
				local var_672_18 = arg_669_1:FormatText(var_672_17.content)

				arg_669_1.text_.text = var_672_18

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_19 = 25
				local var_672_20 = utf8.len(var_672_18)
				local var_672_21 = var_672_19 <= 0 and var_672_16 or var_672_16 * (var_672_20 / var_672_19)

				if var_672_21 > 0 and var_672_16 < var_672_21 then
					arg_669_1.talkMaxDuration = var_672_21

					if var_672_21 + var_672_15 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_21 + var_672_15
					end
				end

				arg_669_1.text_.text = var_672_18
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)
				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_22 = math.max(var_672_16, arg_669_1.talkMaxDuration)

			if var_672_15 <= arg_669_1.time_ and arg_669_1.time_ < var_672_15 + var_672_22 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_15) / var_672_22

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_15 + var_672_22 and arg_669_1.time_ < var_672_15 + var_672_22 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_669_1:InitPlayNodeList()
	end,
	Play928041157 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 928041157
		arg_673_1.duration_ = 4.17

		local var_673_0 = {
			zh = 2.533,
			ja = 4.166
		}
		local var_673_1 = manager.audio:GetLocalizationFlag()

		if var_673_0[var_673_1] ~= nil then
			arg_673_1.duration_ = var_673_0[var_673_1]
		end

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play928041158(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			local var_676_0 = "1033ui_story"

			if arg_673_1.actors_[var_676_0] == nil then
				local var_676_1 = Asset.Load("Char/" .. "1033ui_story")

				if not isNil(var_676_1) then
					local var_676_2 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_673_1.stage_.transform)

					var_676_2.name = var_676_0
					var_676_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_673_1.actors_[var_676_0] = var_676_2

					local var_676_3 = var_676_2:GetComponentInChildren(typeof(CharacterEffect))

					var_676_3.enabled = true

					local var_676_4 = GameObjectTools.GetOrAddComponent(var_676_2, typeof(DynamicBoneHelper))

					if var_676_4 then
						var_676_4:EnableDynamicBone(false)
					end

					arg_673_1:ShowWeapon(var_676_3.transform, false)

					arg_673_1.var_[var_676_0 .. "Animator"] = var_676_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_673_1.var_[var_676_0 .. "Animator"].applyRootMotion = true
					arg_673_1.var_[var_676_0 .. "LipSync"] = var_676_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_676_5 = arg_673_1.actors_["1033ui_story"].transform
			local var_676_6 = 0

			if var_676_6 < arg_673_1.time_ and arg_673_1.time_ <= var_676_6 + arg_676_0 then
				arg_673_1.var_.moveOldPos1033ui_story = var_676_5.localPosition
			end

			local var_676_7 = 0.001

			if var_676_6 <= arg_673_1.time_ and arg_673_1.time_ < var_676_6 + var_676_7 then
				local var_676_8 = (arg_673_1.time_ - var_676_6) / var_676_7
				local var_676_9 = Vector3.New(0, -1.01, -6.13)

				var_676_5.localPosition = Vector3.Lerp(arg_673_1.var_.moveOldPos1033ui_story, var_676_9, var_676_8)

				local var_676_10 = manager.ui.mainCamera.transform.position - var_676_5.position

				var_676_5.forward = Vector3.New(var_676_10.x, var_676_10.y, var_676_10.z)

				local var_676_11 = var_676_5.localEulerAngles

				var_676_11.z = 0
				var_676_11.x = 0
				var_676_5.localEulerAngles = var_676_11
			end

			if arg_673_1.time_ >= var_676_6 + var_676_7 and arg_673_1.time_ < var_676_6 + var_676_7 + arg_676_0 then
				var_676_5.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_676_12 = manager.ui.mainCamera.transform.position - var_676_5.position

				var_676_5.forward = Vector3.New(var_676_12.x, var_676_12.y, var_676_12.z)

				local var_676_13 = var_676_5.localEulerAngles

				var_676_13.z = 0
				var_676_13.x = 0
				var_676_5.localEulerAngles = var_676_13
			end

			local var_676_14 = arg_673_1.actors_["1033ui_story"]
			local var_676_15 = 0

			if var_676_15 < arg_673_1.time_ and arg_673_1.time_ <= var_676_15 + arg_676_0 and not isNil(var_676_14) and arg_673_1.var_.characterEffect1033ui_story == nil then
				arg_673_1.var_.characterEffect1033ui_story = var_676_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_16 = 0.200000002980232

			if var_676_15 <= arg_673_1.time_ and arg_673_1.time_ < var_676_15 + var_676_16 and not isNil(var_676_14) then
				local var_676_17 = (arg_673_1.time_ - var_676_15) / var_676_16

				if arg_673_1.var_.characterEffect1033ui_story and not isNil(var_676_14) then
					arg_673_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_673_1.time_ >= var_676_15 + var_676_16 and arg_673_1.time_ < var_676_15 + var_676_16 + arg_676_0 and not isNil(var_676_14) and arg_673_1.var_.characterEffect1033ui_story then
				arg_673_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_676_18 = 0

			if var_676_18 < arg_673_1.time_ and arg_673_1.time_ <= var_676_18 + arg_676_0 then
				arg_673_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_1")
			end

			local var_676_19 = 0

			if var_676_19 < arg_673_1.time_ and arg_673_1.time_ <= var_676_19 + arg_676_0 then
				arg_673_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_676_20 = 0
			local var_676_21 = 0.35

			if var_676_20 < arg_673_1.time_ and arg_673_1.time_ <= var_676_20 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				local var_676_22 = arg_673_1:FormatText(StoryNameCfg[236].name)

				arg_673_1.leftNameTxt_.text = var_676_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_23 = arg_673_1:GetWordFromCfg(928041157)
				local var_676_24 = arg_673_1:FormatText(var_676_23.content)

				arg_673_1.text_.text = var_676_24

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_25 = 14
				local var_676_26 = utf8.len(var_676_24)
				local var_676_27 = var_676_25 <= 0 and var_676_21 or var_676_21 * (var_676_26 / var_676_25)

				if var_676_27 > 0 and var_676_21 < var_676_27 then
					arg_673_1.talkMaxDuration = var_676_27

					if var_676_27 + var_676_20 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_27 + var_676_20
					end
				end

				arg_673_1.text_.text = var_676_24
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041157", "story_v_side_old_928041.awb") ~= 0 then
					local var_676_28 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041157", "story_v_side_old_928041.awb") / 1000

					if var_676_28 + var_676_20 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_28 + var_676_20
					end

					if var_676_23.prefab_name ~= "" and arg_673_1.actors_[var_676_23.prefab_name] ~= nil then
						local var_676_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_673_1.actors_[var_676_23.prefab_name].transform, "story_v_side_old_928041", "928041157", "story_v_side_old_928041.awb")

						arg_673_1:RecordAudio("928041157", var_676_29)
						arg_673_1:RecordAudio("928041157", var_676_29)
					else
						arg_673_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041157", "story_v_side_old_928041.awb")
					end

					arg_673_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041157", "story_v_side_old_928041.awb")
				end

				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_30 = math.max(var_676_21, arg_673_1.talkMaxDuration)

			if var_676_20 <= arg_673_1.time_ and arg_673_1.time_ < var_676_20 + var_676_30 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_20) / var_676_30

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_20 + var_676_30 and arg_673_1.time_ < var_676_20 + var_676_30 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_673_1:InitPlayNodeList()
	end,
	Play928041158 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 928041158
		arg_677_1.duration_ = 5

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play928041159(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = arg_677_1.actors_["1033ui_story"]
			local var_680_1 = 0

			if var_680_1 < arg_677_1.time_ and arg_677_1.time_ <= var_680_1 + arg_680_0 and not isNil(var_680_0) and arg_677_1.var_.characterEffect1033ui_story == nil then
				arg_677_1.var_.characterEffect1033ui_story = var_680_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_2 = 0.200000002980232

			if var_680_1 <= arg_677_1.time_ and arg_677_1.time_ < var_680_1 + var_680_2 and not isNil(var_680_0) then
				local var_680_3 = (arg_677_1.time_ - var_680_1) / var_680_2

				if arg_677_1.var_.characterEffect1033ui_story and not isNil(var_680_0) then
					local var_680_4 = Mathf.Lerp(0, 0.5, var_680_3)

					arg_677_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_677_1.var_.characterEffect1033ui_story.fillRatio = var_680_4
				end
			end

			if arg_677_1.time_ >= var_680_1 + var_680_2 and arg_677_1.time_ < var_680_1 + var_680_2 + arg_680_0 and not isNil(var_680_0) and arg_677_1.var_.characterEffect1033ui_story then
				local var_680_5 = 0.5

				arg_677_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_677_1.var_.characterEffect1033ui_story.fillRatio = var_680_5
			end

			local var_680_6 = 0
			local var_680_7 = 0.3

			if var_680_6 < arg_677_1.time_ and arg_677_1.time_ <= var_680_6 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				local var_680_8 = arg_677_1:FormatText(StoryNameCfg[7].name)

				arg_677_1.leftNameTxt_.text = var_680_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, true)
				arg_677_1.iconController_:SetSelectedState("hero")

				arg_677_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_677_1.callingController_:SetSelectedState("normal")

				arg_677_1.keyicon_.color = Color.New(1, 1, 1)
				arg_677_1.icon_.color = Color.New(1, 1, 1)

				local var_680_9 = arg_677_1:GetWordFromCfg(928041158)
				local var_680_10 = arg_677_1:FormatText(var_680_9.content)

				arg_677_1.text_.text = var_680_10

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_11 = 12
				local var_680_12 = utf8.len(var_680_10)
				local var_680_13 = var_680_11 <= 0 and var_680_7 or var_680_7 * (var_680_12 / var_680_11)

				if var_680_13 > 0 and var_680_7 < var_680_13 then
					arg_677_1.talkMaxDuration = var_680_13

					if var_680_13 + var_680_6 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_13 + var_680_6
					end
				end

				arg_677_1.text_.text = var_680_10
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)
				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_14 = math.max(var_680_7, arg_677_1.talkMaxDuration)

			if var_680_6 <= arg_677_1.time_ and arg_677_1.time_ < var_680_6 + var_680_14 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_6) / var_680_14

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_6 + var_680_14 and arg_677_1.time_ < var_680_6 + var_680_14 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	Play928041159 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 928041159
		arg_681_1.duration_ = 6.57

		local var_681_0 = {
			zh = 4.8,
			ja = 6.566
		}
		local var_681_1 = manager.audio:GetLocalizationFlag()

		if var_681_0[var_681_1] ~= nil then
			arg_681_1.duration_ = var_681_0[var_681_1]
		end

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play928041160(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			local var_684_0 = arg_681_1.actors_["1033ui_story"]
			local var_684_1 = 0

			if var_684_1 < arg_681_1.time_ and arg_681_1.time_ <= var_684_1 + arg_684_0 and not isNil(var_684_0) and arg_681_1.var_.characterEffect1033ui_story == nil then
				arg_681_1.var_.characterEffect1033ui_story = var_684_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_684_2 = 0.200000002980232

			if var_684_1 <= arg_681_1.time_ and arg_681_1.time_ < var_684_1 + var_684_2 and not isNil(var_684_0) then
				local var_684_3 = (arg_681_1.time_ - var_684_1) / var_684_2

				if arg_681_1.var_.characterEffect1033ui_story and not isNil(var_684_0) then
					arg_681_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_681_1.time_ >= var_684_1 + var_684_2 and arg_681_1.time_ < var_684_1 + var_684_2 + arg_684_0 and not isNil(var_684_0) and arg_681_1.var_.characterEffect1033ui_story then
				arg_681_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_684_4 = 0
			local var_684_5 = 0.575

			if var_684_4 < arg_681_1.time_ and arg_681_1.time_ <= var_684_4 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, true)

				local var_684_6 = arg_681_1:FormatText(StoryNameCfg[236].name)

				arg_681_1.leftNameTxt_.text = var_684_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_681_1.leftNameTxt_.transform)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1.leftNameTxt_.text)
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_7 = arg_681_1:GetWordFromCfg(928041159)
				local var_684_8 = arg_681_1:FormatText(var_684_7.content)

				arg_681_1.text_.text = var_684_8

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_9 = 23
				local var_684_10 = utf8.len(var_684_8)
				local var_684_11 = var_684_9 <= 0 and var_684_5 or var_684_5 * (var_684_10 / var_684_9)

				if var_684_11 > 0 and var_684_5 < var_684_11 then
					arg_681_1.talkMaxDuration = var_684_11

					if var_684_11 + var_684_4 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_11 + var_684_4
					end
				end

				arg_681_1.text_.text = var_684_8
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041159", "story_v_side_old_928041.awb") ~= 0 then
					local var_684_12 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041159", "story_v_side_old_928041.awb") / 1000

					if var_684_12 + var_684_4 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_12 + var_684_4
					end

					if var_684_7.prefab_name ~= "" and arg_681_1.actors_[var_684_7.prefab_name] ~= nil then
						local var_684_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_681_1.actors_[var_684_7.prefab_name].transform, "story_v_side_old_928041", "928041159", "story_v_side_old_928041.awb")

						arg_681_1:RecordAudio("928041159", var_684_13)
						arg_681_1:RecordAudio("928041159", var_684_13)
					else
						arg_681_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041159", "story_v_side_old_928041.awb")
					end

					arg_681_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041159", "story_v_side_old_928041.awb")
				end

				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_14 = math.max(var_684_5, arg_681_1.talkMaxDuration)

			if var_684_4 <= arg_681_1.time_ and arg_681_1.time_ < var_684_4 + var_684_14 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_4) / var_684_14

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_4 + var_684_14 and arg_681_1.time_ < var_684_4 + var_684_14 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {}

		arg_681_1:InitPlayNodeList()
	end,
	Play928041160 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 928041160
		arg_685_1.duration_ = 9.5

		local var_685_0 = {
			zh = 8.4,
			ja = 9.5
		}
		local var_685_1 = manager.audio:GetLocalizationFlag()

		if var_685_0[var_685_1] ~= nil then
			arg_685_1.duration_ = var_685_0[var_685_1]
		end

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play928041161(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = arg_685_1.actors_["1033ui_story"].transform
			local var_688_1 = 0

			if var_688_1 < arg_685_1.time_ and arg_685_1.time_ <= var_688_1 + arg_688_0 then
				arg_685_1.var_.moveOldPos1033ui_story = var_688_0.localPosition
			end

			local var_688_2 = 0.001

			if var_688_1 <= arg_685_1.time_ and arg_685_1.time_ < var_688_1 + var_688_2 then
				local var_688_3 = (arg_685_1.time_ - var_688_1) / var_688_2
				local var_688_4 = Vector3.New(0, 100, 0)

				var_688_0.localPosition = Vector3.Lerp(arg_685_1.var_.moveOldPos1033ui_story, var_688_4, var_688_3)

				local var_688_5 = manager.ui.mainCamera.transform.position - var_688_0.position

				var_688_0.forward = Vector3.New(var_688_5.x, var_688_5.y, var_688_5.z)

				local var_688_6 = var_688_0.localEulerAngles

				var_688_6.z = 0
				var_688_6.x = 0
				var_688_0.localEulerAngles = var_688_6
			end

			if arg_685_1.time_ >= var_688_1 + var_688_2 and arg_685_1.time_ < var_688_1 + var_688_2 + arg_688_0 then
				var_688_0.localPosition = Vector3.New(0, 100, 0)

				local var_688_7 = manager.ui.mainCamera.transform.position - var_688_0.position

				var_688_0.forward = Vector3.New(var_688_7.x, var_688_7.y, var_688_7.z)

				local var_688_8 = var_688_0.localEulerAngles

				var_688_8.z = 0
				var_688_8.x = 0
				var_688_0.localEulerAngles = var_688_8
			end

			local var_688_9 = arg_685_1.actors_["1066ui_story"].transform
			local var_688_10 = 0

			if var_688_10 < arg_685_1.time_ and arg_685_1.time_ <= var_688_10 + arg_688_0 then
				arg_685_1.var_.moveOldPos1066ui_story = var_688_9.localPosition
			end

			local var_688_11 = 0.001

			if var_688_10 <= arg_685_1.time_ and arg_685_1.time_ < var_688_10 + var_688_11 then
				local var_688_12 = (arg_685_1.time_ - var_688_10) / var_688_11
				local var_688_13 = Vector3.New(0, -0.77, -6.1)

				var_688_9.localPosition = Vector3.Lerp(arg_685_1.var_.moveOldPos1066ui_story, var_688_13, var_688_12)

				local var_688_14 = manager.ui.mainCamera.transform.position - var_688_9.position

				var_688_9.forward = Vector3.New(var_688_14.x, var_688_14.y, var_688_14.z)

				local var_688_15 = var_688_9.localEulerAngles

				var_688_15.z = 0
				var_688_15.x = 0
				var_688_9.localEulerAngles = var_688_15
			end

			if arg_685_1.time_ >= var_688_10 + var_688_11 and arg_685_1.time_ < var_688_10 + var_688_11 + arg_688_0 then
				var_688_9.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_688_16 = manager.ui.mainCamera.transform.position - var_688_9.position

				var_688_9.forward = Vector3.New(var_688_16.x, var_688_16.y, var_688_16.z)

				local var_688_17 = var_688_9.localEulerAngles

				var_688_17.z = 0
				var_688_17.x = 0
				var_688_9.localEulerAngles = var_688_17
			end

			local var_688_18 = arg_685_1.actors_["1066ui_story"]
			local var_688_19 = 0

			if var_688_19 < arg_685_1.time_ and arg_685_1.time_ <= var_688_19 + arg_688_0 and not isNil(var_688_18) and arg_685_1.var_.characterEffect1066ui_story == nil then
				arg_685_1.var_.characterEffect1066ui_story = var_688_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_688_20 = 0.200000002980232

			if var_688_19 <= arg_685_1.time_ and arg_685_1.time_ < var_688_19 + var_688_20 and not isNil(var_688_18) then
				local var_688_21 = (arg_685_1.time_ - var_688_19) / var_688_20

				if arg_685_1.var_.characterEffect1066ui_story and not isNil(var_688_18) then
					arg_685_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_685_1.time_ >= var_688_19 + var_688_20 and arg_685_1.time_ < var_688_19 + var_688_20 + arg_688_0 and not isNil(var_688_18) and arg_685_1.var_.characterEffect1066ui_story then
				arg_685_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_688_22 = arg_685_1.actors_["1033ui_story"]
			local var_688_23 = 0

			if var_688_23 < arg_685_1.time_ and arg_685_1.time_ <= var_688_23 + arg_688_0 and not isNil(var_688_22) and arg_685_1.var_.characterEffect1033ui_story == nil then
				arg_685_1.var_.characterEffect1033ui_story = var_688_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_688_24 = 0.200000002980232

			if var_688_23 <= arg_685_1.time_ and arg_685_1.time_ < var_688_23 + var_688_24 and not isNil(var_688_22) then
				local var_688_25 = (arg_685_1.time_ - var_688_23) / var_688_24

				if arg_685_1.var_.characterEffect1033ui_story and not isNil(var_688_22) then
					local var_688_26 = Mathf.Lerp(0, 0.5, var_688_25)

					arg_685_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_685_1.var_.characterEffect1033ui_story.fillRatio = var_688_26
				end
			end

			if arg_685_1.time_ >= var_688_23 + var_688_24 and arg_685_1.time_ < var_688_23 + var_688_24 + arg_688_0 and not isNil(var_688_22) and arg_685_1.var_.characterEffect1033ui_story then
				local var_688_27 = 0.5

				arg_685_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_685_1.var_.characterEffect1033ui_story.fillRatio = var_688_27
			end

			local var_688_28 = 0

			if var_688_28 < arg_685_1.time_ and arg_685_1.time_ <= var_688_28 + arg_688_0 then
				arg_685_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action434")
			end

			local var_688_29 = 0

			if var_688_29 < arg_685_1.time_ and arg_685_1.time_ <= var_688_29 + arg_688_0 then
				arg_685_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_688_30 = 0
			local var_688_31 = 1.1

			if var_688_30 < arg_685_1.time_ and arg_685_1.time_ <= var_688_30 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				local var_688_32 = arg_685_1:FormatText(StoryNameCfg[32].name)

				arg_685_1.leftNameTxt_.text = var_688_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, false)
				arg_685_1.callingController_:SetSelectedState("normal")

				local var_688_33 = arg_685_1:GetWordFromCfg(928041160)
				local var_688_34 = arg_685_1:FormatText(var_688_33.content)

				arg_685_1.text_.text = var_688_34

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_35 = 44
				local var_688_36 = utf8.len(var_688_34)
				local var_688_37 = var_688_35 <= 0 and var_688_31 or var_688_31 * (var_688_36 / var_688_35)

				if var_688_37 > 0 and var_688_31 < var_688_37 then
					arg_685_1.talkMaxDuration = var_688_37

					if var_688_37 + var_688_30 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_37 + var_688_30
					end
				end

				arg_685_1.text_.text = var_688_34
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041160", "story_v_side_old_928041.awb") ~= 0 then
					local var_688_38 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041160", "story_v_side_old_928041.awb") / 1000

					if var_688_38 + var_688_30 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_38 + var_688_30
					end

					if var_688_33.prefab_name ~= "" and arg_685_1.actors_[var_688_33.prefab_name] ~= nil then
						local var_688_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_685_1.actors_[var_688_33.prefab_name].transform, "story_v_side_old_928041", "928041160", "story_v_side_old_928041.awb")

						arg_685_1:RecordAudio("928041160", var_688_39)
						arg_685_1:RecordAudio("928041160", var_688_39)
					else
						arg_685_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041160", "story_v_side_old_928041.awb")
					end

					arg_685_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041160", "story_v_side_old_928041.awb")
				end

				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_40 = math.max(var_688_31, arg_685_1.talkMaxDuration)

			if var_688_30 <= arg_685_1.time_ and arg_685_1.time_ < var_688_30 + var_688_40 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - var_688_30) / var_688_40

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= var_688_30 + var_688_40 and arg_685_1.time_ < var_688_30 + var_688_40 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
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

		arg_685_1:InitPlayNodeList()
	end,
	Play928041161 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 928041161
		arg_689_1.duration_ = 4.53

		local var_689_0 = {
			zh = 3.5,
			ja = 4.533
		}
		local var_689_1 = manager.audio:GetLocalizationFlag()

		if var_689_0[var_689_1] ~= nil then
			arg_689_1.duration_ = var_689_0[var_689_1]
		end

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play928041162(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			local var_692_0 = arg_689_1.actors_["1085ui_story"]
			local var_692_1 = 0

			if var_692_1 < arg_689_1.time_ and arg_689_1.time_ <= var_692_1 + arg_692_0 and not isNil(var_692_0) and arg_689_1.var_.characterEffect1085ui_story == nil then
				arg_689_1.var_.characterEffect1085ui_story = var_692_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_692_2 = 0.200000002980232

			if var_692_1 <= arg_689_1.time_ and arg_689_1.time_ < var_692_1 + var_692_2 and not isNil(var_692_0) then
				local var_692_3 = (arg_689_1.time_ - var_692_1) / var_692_2

				if arg_689_1.var_.characterEffect1085ui_story and not isNil(var_692_0) then
					arg_689_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_689_1.time_ >= var_692_1 + var_692_2 and arg_689_1.time_ < var_692_1 + var_692_2 + arg_692_0 and not isNil(var_692_0) and arg_689_1.var_.characterEffect1085ui_story then
				arg_689_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_692_4 = arg_689_1.actors_["1066ui_story"]
			local var_692_5 = 0

			if var_692_5 < arg_689_1.time_ and arg_689_1.time_ <= var_692_5 + arg_692_0 and not isNil(var_692_4) and arg_689_1.var_.characterEffect1066ui_story == nil then
				arg_689_1.var_.characterEffect1066ui_story = var_692_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_692_6 = 0.200000002980232

			if var_692_5 <= arg_689_1.time_ and arg_689_1.time_ < var_692_5 + var_692_6 and not isNil(var_692_4) then
				local var_692_7 = (arg_689_1.time_ - var_692_5) / var_692_6

				if arg_689_1.var_.characterEffect1066ui_story and not isNil(var_692_4) then
					local var_692_8 = Mathf.Lerp(0, 0.5, var_692_7)

					arg_689_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_689_1.var_.characterEffect1066ui_story.fillRatio = var_692_8
				end
			end

			if arg_689_1.time_ >= var_692_5 + var_692_6 and arg_689_1.time_ < var_692_5 + var_692_6 + arg_692_0 and not isNil(var_692_4) and arg_689_1.var_.characterEffect1066ui_story then
				local var_692_9 = 0.5

				arg_689_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_689_1.var_.characterEffect1066ui_story.fillRatio = var_692_9
			end

			local var_692_10 = 0
			local var_692_11 = 0.275

			if var_692_10 < arg_689_1.time_ and arg_689_1.time_ <= var_692_10 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				local var_692_12 = arg_689_1:FormatText(StoryNameCfg[328].name)

				arg_689_1.leftNameTxt_.text = var_692_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, true)
				arg_689_1.iconController_:SetSelectedState("hero")

				arg_689_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1085")

				arg_689_1.callingController_:SetSelectedState("normal")

				arg_689_1.keyicon_.color = Color.New(1, 1, 1)
				arg_689_1.icon_.color = Color.New(1, 1, 1)

				local var_692_13 = arg_689_1:GetWordFromCfg(928041161)
				local var_692_14 = arg_689_1:FormatText(var_692_13.content)

				arg_689_1.text_.text = var_692_14

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_15 = 11
				local var_692_16 = utf8.len(var_692_14)
				local var_692_17 = var_692_15 <= 0 and var_692_11 or var_692_11 * (var_692_16 / var_692_15)

				if var_692_17 > 0 and var_692_11 < var_692_17 then
					arg_689_1.talkMaxDuration = var_692_17

					if var_692_17 + var_692_10 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_17 + var_692_10
					end
				end

				arg_689_1.text_.text = var_692_14
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041161", "story_v_side_old_928041.awb") ~= 0 then
					local var_692_18 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041161", "story_v_side_old_928041.awb") / 1000

					if var_692_18 + var_692_10 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_18 + var_692_10
					end

					if var_692_13.prefab_name ~= "" and arg_689_1.actors_[var_692_13.prefab_name] ~= nil then
						local var_692_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_689_1.actors_[var_692_13.prefab_name].transform, "story_v_side_old_928041", "928041161", "story_v_side_old_928041.awb")

						arg_689_1:RecordAudio("928041161", var_692_19)
						arg_689_1:RecordAudio("928041161", var_692_19)
					else
						arg_689_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041161", "story_v_side_old_928041.awb")
					end

					arg_689_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041161", "story_v_side_old_928041.awb")
				end

				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_20 = math.max(var_692_11, arg_689_1.talkMaxDuration)

			if var_692_10 <= arg_689_1.time_ and arg_689_1.time_ < var_692_10 + var_692_20 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_10) / var_692_20

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_10 + var_692_20 and arg_689_1.time_ < var_692_10 + var_692_20 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play928041162 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 928041162
		arg_693_1.duration_ = 5.5

		local var_693_0 = {
			zh = 3.666,
			ja = 5.5
		}
		local var_693_1 = manager.audio:GetLocalizationFlag()

		if var_693_0[var_693_1] ~= nil then
			arg_693_1.duration_ = var_693_0[var_693_1]
		end

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play928041163(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			local var_696_0 = arg_693_1.actors_["1066ui_story"]
			local var_696_1 = 0

			if var_696_1 < arg_693_1.time_ and arg_693_1.time_ <= var_696_1 + arg_696_0 and not isNil(var_696_0) and arg_693_1.var_.characterEffect1066ui_story == nil then
				arg_693_1.var_.characterEffect1066ui_story = var_696_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_696_2 = 0.200000002980232

			if var_696_1 <= arg_693_1.time_ and arg_693_1.time_ < var_696_1 + var_696_2 and not isNil(var_696_0) then
				local var_696_3 = (arg_693_1.time_ - var_696_1) / var_696_2

				if arg_693_1.var_.characterEffect1066ui_story and not isNil(var_696_0) then
					arg_693_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_693_1.time_ >= var_696_1 + var_696_2 and arg_693_1.time_ < var_696_1 + var_696_2 + arg_696_0 and not isNil(var_696_0) and arg_693_1.var_.characterEffect1066ui_story then
				arg_693_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_696_4 = arg_693_1.actors_["1085ui_story"]
			local var_696_5 = 0

			if var_696_5 < arg_693_1.time_ and arg_693_1.time_ <= var_696_5 + arg_696_0 and not isNil(var_696_4) and arg_693_1.var_.characterEffect1085ui_story == nil then
				arg_693_1.var_.characterEffect1085ui_story = var_696_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_696_6 = 0.200000002980232

			if var_696_5 <= arg_693_1.time_ and arg_693_1.time_ < var_696_5 + var_696_6 and not isNil(var_696_4) then
				local var_696_7 = (arg_693_1.time_ - var_696_5) / var_696_6

				if arg_693_1.var_.characterEffect1085ui_story and not isNil(var_696_4) then
					local var_696_8 = Mathf.Lerp(0, 0.5, var_696_7)

					arg_693_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_693_1.var_.characterEffect1085ui_story.fillRatio = var_696_8
				end
			end

			if arg_693_1.time_ >= var_696_5 + var_696_6 and arg_693_1.time_ < var_696_5 + var_696_6 + arg_696_0 and not isNil(var_696_4) and arg_693_1.var_.characterEffect1085ui_story then
				local var_696_9 = 0.5

				arg_693_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_693_1.var_.characterEffect1085ui_story.fillRatio = var_696_9
			end

			local var_696_10 = 0

			if var_696_10 < arg_693_1.time_ and arg_693_1.time_ <= var_696_10 + arg_696_0 then
				arg_693_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_2")
			end

			local var_696_11 = 0

			if var_696_11 < arg_693_1.time_ and arg_693_1.time_ <= var_696_11 + arg_696_0 then
				arg_693_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_696_12 = 0
			local var_696_13 = 0.4

			if var_696_12 < arg_693_1.time_ and arg_693_1.time_ <= var_696_12 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, true)

				local var_696_14 = arg_693_1:FormatText(StoryNameCfg[32].name)

				arg_693_1.leftNameTxt_.text = var_696_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_693_1.leftNameTxt_.transform)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1.leftNameTxt_.text)
				SetActive(arg_693_1.iconTrs_.gameObject, false)
				arg_693_1.callingController_:SetSelectedState("normal")

				local var_696_15 = arg_693_1:GetWordFromCfg(928041162)
				local var_696_16 = arg_693_1:FormatText(var_696_15.content)

				arg_693_1.text_.text = var_696_16

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_17 = 16
				local var_696_18 = utf8.len(var_696_16)
				local var_696_19 = var_696_17 <= 0 and var_696_13 or var_696_13 * (var_696_18 / var_696_17)

				if var_696_19 > 0 and var_696_13 < var_696_19 then
					arg_693_1.talkMaxDuration = var_696_19

					if var_696_19 + var_696_12 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_19 + var_696_12
					end
				end

				arg_693_1.text_.text = var_696_16
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041162", "story_v_side_old_928041.awb") ~= 0 then
					local var_696_20 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041162", "story_v_side_old_928041.awb") / 1000

					if var_696_20 + var_696_12 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_20 + var_696_12
					end

					if var_696_15.prefab_name ~= "" and arg_693_1.actors_[var_696_15.prefab_name] ~= nil then
						local var_696_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_693_1.actors_[var_696_15.prefab_name].transform, "story_v_side_old_928041", "928041162", "story_v_side_old_928041.awb")

						arg_693_1:RecordAudio("928041162", var_696_21)
						arg_693_1:RecordAudio("928041162", var_696_21)
					else
						arg_693_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041162", "story_v_side_old_928041.awb")
					end

					arg_693_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041162", "story_v_side_old_928041.awb")
				end

				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_22 = math.max(var_696_13, arg_693_1.talkMaxDuration)

			if var_696_12 <= arg_693_1.time_ and arg_693_1.time_ < var_696_12 + var_696_22 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - var_696_12) / var_696_22

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= var_696_12 + var_696_22 and arg_693_1.time_ < var_696_12 + var_696_22 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {}

		arg_693_1:InitPlayNodeList()
	end,
	Play928041163 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 928041163
		arg_697_1.duration_ = 5

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play928041164(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			local var_700_0 = arg_697_1.actors_["1066ui_story"].transform
			local var_700_1 = 0

			if var_700_1 < arg_697_1.time_ and arg_697_1.time_ <= var_700_1 + arg_700_0 then
				arg_697_1.var_.moveOldPos1066ui_story = var_700_0.localPosition
			end

			local var_700_2 = 0.001

			if var_700_1 <= arg_697_1.time_ and arg_697_1.time_ < var_700_1 + var_700_2 then
				local var_700_3 = (arg_697_1.time_ - var_700_1) / var_700_2
				local var_700_4 = Vector3.New(0, 100, 0)

				var_700_0.localPosition = Vector3.Lerp(arg_697_1.var_.moveOldPos1066ui_story, var_700_4, var_700_3)

				local var_700_5 = manager.ui.mainCamera.transform.position - var_700_0.position

				var_700_0.forward = Vector3.New(var_700_5.x, var_700_5.y, var_700_5.z)

				local var_700_6 = var_700_0.localEulerAngles

				var_700_6.z = 0
				var_700_6.x = 0
				var_700_0.localEulerAngles = var_700_6
			end

			if arg_697_1.time_ >= var_700_1 + var_700_2 and arg_697_1.time_ < var_700_1 + var_700_2 + arg_700_0 then
				var_700_0.localPosition = Vector3.New(0, 100, 0)

				local var_700_7 = manager.ui.mainCamera.transform.position - var_700_0.position

				var_700_0.forward = Vector3.New(var_700_7.x, var_700_7.y, var_700_7.z)

				local var_700_8 = var_700_0.localEulerAngles

				var_700_8.z = 0
				var_700_8.x = 0
				var_700_0.localEulerAngles = var_700_8
			end

			local var_700_9 = arg_697_1.actors_["1066ui_story"]
			local var_700_10 = 0

			if var_700_10 < arg_697_1.time_ and arg_697_1.time_ <= var_700_10 + arg_700_0 and not isNil(var_700_9) and arg_697_1.var_.characterEffect1066ui_story == nil then
				arg_697_1.var_.characterEffect1066ui_story = var_700_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_700_11 = 0.200000002980232

			if var_700_10 <= arg_697_1.time_ and arg_697_1.time_ < var_700_10 + var_700_11 and not isNil(var_700_9) then
				local var_700_12 = (arg_697_1.time_ - var_700_10) / var_700_11

				if arg_697_1.var_.characterEffect1066ui_story and not isNil(var_700_9) then
					local var_700_13 = Mathf.Lerp(0, 0.5, var_700_12)

					arg_697_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_697_1.var_.characterEffect1066ui_story.fillRatio = var_700_13
				end
			end

			if arg_697_1.time_ >= var_700_10 + var_700_11 and arg_697_1.time_ < var_700_10 + var_700_11 + arg_700_0 and not isNil(var_700_9) and arg_697_1.var_.characterEffect1066ui_story then
				local var_700_14 = 0.5

				arg_697_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_697_1.var_.characterEffect1066ui_story.fillRatio = var_700_14
			end

			local var_700_15 = 0
			local var_700_16 = 0.825

			if var_700_15 < arg_697_1.time_ and arg_697_1.time_ <= var_700_15 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, false)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_697_1.iconTrs_.gameObject, false)
				arg_697_1.callingController_:SetSelectedState("normal")

				local var_700_17 = arg_697_1:GetWordFromCfg(928041163)
				local var_700_18 = arg_697_1:FormatText(var_700_17.content)

				arg_697_1.text_.text = var_700_18

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_19 = 33
				local var_700_20 = utf8.len(var_700_18)
				local var_700_21 = var_700_19 <= 0 and var_700_16 or var_700_16 * (var_700_20 / var_700_19)

				if var_700_21 > 0 and var_700_16 < var_700_21 then
					arg_697_1.talkMaxDuration = var_700_21

					if var_700_21 + var_700_15 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_21 + var_700_15
					end
				end

				arg_697_1.text_.text = var_700_18
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)
				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_22 = math.max(var_700_16, arg_697_1.talkMaxDuration)

			if var_700_15 <= arg_697_1.time_ and arg_697_1.time_ < var_700_15 + var_700_22 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - var_700_15) / var_700_22

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= var_700_15 + var_700_22 and arg_697_1.time_ < var_700_15 + var_700_22 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {
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

		arg_697_1:InitPlayNodeList()
	end,
	Play928041164 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 928041164
		arg_701_1.duration_ = 5

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play928041165(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			local var_704_0 = 0
			local var_704_1 = 0.925

			if var_704_0 < arg_701_1.time_ and arg_701_1.time_ <= var_704_0 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, false)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_701_1.iconTrs_.gameObject, false)
				arg_701_1.callingController_:SetSelectedState("normal")

				local var_704_2 = arg_701_1:GetWordFromCfg(928041164)
				local var_704_3 = arg_701_1:FormatText(var_704_2.content)

				arg_701_1.text_.text = var_704_3

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_4 = 37
				local var_704_5 = utf8.len(var_704_3)
				local var_704_6 = var_704_4 <= 0 and var_704_1 or var_704_1 * (var_704_5 / var_704_4)

				if var_704_6 > 0 and var_704_1 < var_704_6 then
					arg_701_1.talkMaxDuration = var_704_6

					if var_704_6 + var_704_0 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_6 + var_704_0
					end
				end

				arg_701_1.text_.text = var_704_3
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)
				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_7 = math.max(var_704_1, arg_701_1.talkMaxDuration)

			if var_704_0 <= arg_701_1.time_ and arg_701_1.time_ < var_704_0 + var_704_7 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - var_704_0) / var_704_7

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= var_704_0 + var_704_7 and arg_701_1.time_ < var_704_0 + var_704_7 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {}

		arg_701_1:InitPlayNodeList()
	end,
	Play928041165 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 928041165
		arg_705_1.duration_ = 5

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play928041166(arg_705_1)
			end
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			local var_708_0 = 0
			local var_708_1 = 0.175

			if var_708_0 < arg_705_1.time_ and arg_705_1.time_ <= var_708_0 + arg_708_0 then
				arg_705_1.talkMaxDuration = 0
				arg_705_1.dialogCg_.alpha = 1

				arg_705_1.dialog_:SetActive(true)
				SetActive(arg_705_1.leftNameGo_, true)

				local var_708_2 = arg_705_1:FormatText(StoryNameCfg[7].name)

				arg_705_1.leftNameTxt_.text = var_708_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_705_1.leftNameTxt_.transform)

				arg_705_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_705_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_705_1:RecordName(arg_705_1.leftNameTxt_.text)
				SetActive(arg_705_1.iconTrs_.gameObject, true)
				arg_705_1.iconController_:SetSelectedState("hero")

				arg_705_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_705_1.callingController_:SetSelectedState("normal")

				arg_705_1.keyicon_.color = Color.New(1, 1, 1)
				arg_705_1.icon_.color = Color.New(1, 1, 1)

				local var_708_3 = arg_705_1:GetWordFromCfg(928041165)
				local var_708_4 = arg_705_1:FormatText(var_708_3.content)

				arg_705_1.text_.text = var_708_4

				LuaForUtil.ClearLinePrefixSymbol(arg_705_1.text_)

				local var_708_5 = 7
				local var_708_6 = utf8.len(var_708_4)
				local var_708_7 = var_708_5 <= 0 and var_708_1 or var_708_1 * (var_708_6 / var_708_5)

				if var_708_7 > 0 and var_708_1 < var_708_7 then
					arg_705_1.talkMaxDuration = var_708_7

					if var_708_7 + var_708_0 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_7 + var_708_0
					end
				end

				arg_705_1.text_.text = var_708_4
				arg_705_1.typewritter.percent = 0

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(false)
				arg_705_1:RecordContent(arg_705_1.text_.text)
			end

			local var_708_8 = math.max(var_708_1, arg_705_1.talkMaxDuration)

			if var_708_0 <= arg_705_1.time_ and arg_705_1.time_ < var_708_0 + var_708_8 then
				arg_705_1.typewritter.percent = (arg_705_1.time_ - var_708_0) / var_708_8

				arg_705_1.typewritter:SetDirty()
			end

			if arg_705_1.time_ >= var_708_0 + var_708_8 and arg_705_1.time_ < var_708_0 + var_708_8 + arg_708_0 then
				arg_705_1.typewritter.percent = 1

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(true)
			end
		end

		arg_705_1.nodeConfigList_ = {}

		arg_705_1:InitPlayNodeList()
	end,
	Play928041166 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 928041166
		arg_709_1.duration_ = 2.33

		local var_709_0 = {
			zh = 2.066,
			ja = 2.333
		}
		local var_709_1 = manager.audio:GetLocalizationFlag()

		if var_709_0[var_709_1] ~= nil then
			arg_709_1.duration_ = var_709_0[var_709_1]
		end

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play928041167(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			local var_712_0 = arg_709_1.actors_["1066ui_story"].transform
			local var_712_1 = 0

			if var_712_1 < arg_709_1.time_ and arg_709_1.time_ <= var_712_1 + arg_712_0 then
				arg_709_1.var_.moveOldPos1066ui_story = var_712_0.localPosition
			end

			local var_712_2 = 0.001

			if var_712_1 <= arg_709_1.time_ and arg_709_1.time_ < var_712_1 + var_712_2 then
				local var_712_3 = (arg_709_1.time_ - var_712_1) / var_712_2
				local var_712_4 = Vector3.New(0, -0.77, -6.1)

				var_712_0.localPosition = Vector3.Lerp(arg_709_1.var_.moveOldPos1066ui_story, var_712_4, var_712_3)

				local var_712_5 = manager.ui.mainCamera.transform.position - var_712_0.position

				var_712_0.forward = Vector3.New(var_712_5.x, var_712_5.y, var_712_5.z)

				local var_712_6 = var_712_0.localEulerAngles

				var_712_6.z = 0
				var_712_6.x = 0
				var_712_0.localEulerAngles = var_712_6
			end

			if arg_709_1.time_ >= var_712_1 + var_712_2 and arg_709_1.time_ < var_712_1 + var_712_2 + arg_712_0 then
				var_712_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_712_7 = manager.ui.mainCamera.transform.position - var_712_0.position

				var_712_0.forward = Vector3.New(var_712_7.x, var_712_7.y, var_712_7.z)

				local var_712_8 = var_712_0.localEulerAngles

				var_712_8.z = 0
				var_712_8.x = 0
				var_712_0.localEulerAngles = var_712_8
			end

			local var_712_9 = arg_709_1.actors_["1066ui_story"]
			local var_712_10 = 0

			if var_712_10 < arg_709_1.time_ and arg_709_1.time_ <= var_712_10 + arg_712_0 and not isNil(var_712_9) and arg_709_1.var_.characterEffect1066ui_story == nil then
				arg_709_1.var_.characterEffect1066ui_story = var_712_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_712_11 = 0.200000002980232

			if var_712_10 <= arg_709_1.time_ and arg_709_1.time_ < var_712_10 + var_712_11 and not isNil(var_712_9) then
				local var_712_12 = (arg_709_1.time_ - var_712_10) / var_712_11

				if arg_709_1.var_.characterEffect1066ui_story and not isNil(var_712_9) then
					arg_709_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_709_1.time_ >= var_712_10 + var_712_11 and arg_709_1.time_ < var_712_10 + var_712_11 + arg_712_0 and not isNil(var_712_9) and arg_709_1.var_.characterEffect1066ui_story then
				arg_709_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_712_13 = 0

			if var_712_13 < arg_709_1.time_ and arg_709_1.time_ <= var_712_13 + arg_712_0 then
				arg_709_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			local var_712_14 = 0

			if var_712_14 < arg_709_1.time_ and arg_709_1.time_ <= var_712_14 + arg_712_0 then
				arg_709_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_712_15 = 0
			local var_712_16 = 0.15

			if var_712_15 < arg_709_1.time_ and arg_709_1.time_ <= var_712_15 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, true)

				local var_712_17 = arg_709_1:FormatText(StoryNameCfg[32].name)

				arg_709_1.leftNameTxt_.text = var_712_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_709_1.leftNameTxt_.transform)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1.leftNameTxt_.text)
				SetActive(arg_709_1.iconTrs_.gameObject, false)
				arg_709_1.callingController_:SetSelectedState("normal")

				local var_712_18 = arg_709_1:GetWordFromCfg(928041166)
				local var_712_19 = arg_709_1:FormatText(var_712_18.content)

				arg_709_1.text_.text = var_712_19

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_20 = 6
				local var_712_21 = utf8.len(var_712_19)
				local var_712_22 = var_712_20 <= 0 and var_712_16 or var_712_16 * (var_712_21 / var_712_20)

				if var_712_22 > 0 and var_712_16 < var_712_22 then
					arg_709_1.talkMaxDuration = var_712_22

					if var_712_22 + var_712_15 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_22 + var_712_15
					end
				end

				arg_709_1.text_.text = var_712_19
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041166", "story_v_side_old_928041.awb") ~= 0 then
					local var_712_23 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041166", "story_v_side_old_928041.awb") / 1000

					if var_712_23 + var_712_15 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_23 + var_712_15
					end

					if var_712_18.prefab_name ~= "" and arg_709_1.actors_[var_712_18.prefab_name] ~= nil then
						local var_712_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_709_1.actors_[var_712_18.prefab_name].transform, "story_v_side_old_928041", "928041166", "story_v_side_old_928041.awb")

						arg_709_1:RecordAudio("928041166", var_712_24)
						arg_709_1:RecordAudio("928041166", var_712_24)
					else
						arg_709_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041166", "story_v_side_old_928041.awb")
					end

					arg_709_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041166", "story_v_side_old_928041.awb")
				end

				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_25 = math.max(var_712_16, arg_709_1.talkMaxDuration)

			if var_712_15 <= arg_709_1.time_ and arg_709_1.time_ < var_712_15 + var_712_25 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - var_712_15) / var_712_25

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= var_712_15 + var_712_25 and arg_709_1.time_ < var_712_15 + var_712_25 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {
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

		arg_709_1:InitPlayNodeList()
	end,
	Play928041167 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 928041167
		arg_713_1.duration_ = 5

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play928041168(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = arg_713_1.actors_["1066ui_story"]
			local var_716_1 = 0

			if var_716_1 < arg_713_1.time_ and arg_713_1.time_ <= var_716_1 + arg_716_0 and not isNil(var_716_0) and arg_713_1.var_.characterEffect1066ui_story == nil then
				arg_713_1.var_.characterEffect1066ui_story = var_716_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_716_2 = 0.200000002980232

			if var_716_1 <= arg_713_1.time_ and arg_713_1.time_ < var_716_1 + var_716_2 and not isNil(var_716_0) then
				local var_716_3 = (arg_713_1.time_ - var_716_1) / var_716_2

				if arg_713_1.var_.characterEffect1066ui_story and not isNil(var_716_0) then
					local var_716_4 = Mathf.Lerp(0, 0.5, var_716_3)

					arg_713_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_713_1.var_.characterEffect1066ui_story.fillRatio = var_716_4
				end
			end

			if arg_713_1.time_ >= var_716_1 + var_716_2 and arg_713_1.time_ < var_716_1 + var_716_2 + arg_716_0 and not isNil(var_716_0) and arg_713_1.var_.characterEffect1066ui_story then
				local var_716_5 = 0.5

				arg_713_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_713_1.var_.characterEffect1066ui_story.fillRatio = var_716_5
			end

			local var_716_6 = 0
			local var_716_7 = 1.05

			if var_716_6 < arg_713_1.time_ and arg_713_1.time_ <= var_716_6 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				local var_716_8 = arg_713_1:FormatText(StoryNameCfg[7].name)

				arg_713_1.leftNameTxt_.text = var_716_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, true)
				arg_713_1.iconController_:SetSelectedState("hero")

				arg_713_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_713_1.callingController_:SetSelectedState("normal")

				arg_713_1.keyicon_.color = Color.New(1, 1, 1)
				arg_713_1.icon_.color = Color.New(1, 1, 1)

				local var_716_9 = arg_713_1:GetWordFromCfg(928041167)
				local var_716_10 = arg_713_1:FormatText(var_716_9.content)

				arg_713_1.text_.text = var_716_10

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_11 = 42
				local var_716_12 = utf8.len(var_716_10)
				local var_716_13 = var_716_11 <= 0 and var_716_7 or var_716_7 * (var_716_12 / var_716_11)

				if var_716_13 > 0 and var_716_7 < var_716_13 then
					arg_713_1.talkMaxDuration = var_716_13

					if var_716_13 + var_716_6 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_13 + var_716_6
					end
				end

				arg_713_1.text_.text = var_716_10
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)
				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_14 = math.max(var_716_7, arg_713_1.talkMaxDuration)

			if var_716_6 <= arg_713_1.time_ and arg_713_1.time_ < var_716_6 + var_716_14 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - var_716_6) / var_716_14

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= var_716_6 + var_716_14 and arg_713_1.time_ < var_716_6 + var_716_14 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {}

		arg_713_1:InitPlayNodeList()
	end,
	Play928041168 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 928041168
		arg_717_1.duration_ = 10.4

		local var_717_0 = {
			zh = 6.7,
			ja = 10.4
		}
		local var_717_1 = manager.audio:GetLocalizationFlag()

		if var_717_0[var_717_1] ~= nil then
			arg_717_1.duration_ = var_717_0[var_717_1]
		end

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play928041169(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			local var_720_0 = arg_717_1.actors_["1066ui_story"]
			local var_720_1 = 0

			if var_720_1 < arg_717_1.time_ and arg_717_1.time_ <= var_720_1 + arg_720_0 and not isNil(var_720_0) and arg_717_1.var_.characterEffect1066ui_story == nil then
				arg_717_1.var_.characterEffect1066ui_story = var_720_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_720_2 = 0.200000002980232

			if var_720_1 <= arg_717_1.time_ and arg_717_1.time_ < var_720_1 + var_720_2 and not isNil(var_720_0) then
				local var_720_3 = (arg_717_1.time_ - var_720_1) / var_720_2

				if arg_717_1.var_.characterEffect1066ui_story and not isNil(var_720_0) then
					arg_717_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_717_1.time_ >= var_720_1 + var_720_2 and arg_717_1.time_ < var_720_1 + var_720_2 + arg_720_0 and not isNil(var_720_0) and arg_717_1.var_.characterEffect1066ui_story then
				arg_717_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_720_4 = 0
			local var_720_5 = 0.625

			if var_720_4 < arg_717_1.time_ and arg_717_1.time_ <= var_720_4 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, true)

				local var_720_6 = arg_717_1:FormatText(StoryNameCfg[32].name)

				arg_717_1.leftNameTxt_.text = var_720_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, false)
				arg_717_1.callingController_:SetSelectedState("normal")

				local var_720_7 = arg_717_1:GetWordFromCfg(928041168)
				local var_720_8 = arg_717_1:FormatText(var_720_7.content)

				arg_717_1.text_.text = var_720_8

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_9 = 25
				local var_720_10 = utf8.len(var_720_8)
				local var_720_11 = var_720_9 <= 0 and var_720_5 or var_720_5 * (var_720_10 / var_720_9)

				if var_720_11 > 0 and var_720_5 < var_720_11 then
					arg_717_1.talkMaxDuration = var_720_11

					if var_720_11 + var_720_4 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_11 + var_720_4
					end
				end

				arg_717_1.text_.text = var_720_8
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041168", "story_v_side_old_928041.awb") ~= 0 then
					local var_720_12 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041168", "story_v_side_old_928041.awb") / 1000

					if var_720_12 + var_720_4 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_12 + var_720_4
					end

					if var_720_7.prefab_name ~= "" and arg_717_1.actors_[var_720_7.prefab_name] ~= nil then
						local var_720_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_717_1.actors_[var_720_7.prefab_name].transform, "story_v_side_old_928041", "928041168", "story_v_side_old_928041.awb")

						arg_717_1:RecordAudio("928041168", var_720_13)
						arg_717_1:RecordAudio("928041168", var_720_13)
					else
						arg_717_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041168", "story_v_side_old_928041.awb")
					end

					arg_717_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041168", "story_v_side_old_928041.awb")
				end

				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_14 = math.max(var_720_5, arg_717_1.talkMaxDuration)

			if var_720_4 <= arg_717_1.time_ and arg_717_1.time_ < var_720_4 + var_720_14 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - var_720_4) / var_720_14

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= var_720_4 + var_720_14 and arg_717_1.time_ < var_720_4 + var_720_14 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play928041169 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 928041169
		arg_721_1.duration_ = 10.13

		local var_721_0 = {
			zh = 6.4,
			ja = 10.133
		}
		local var_721_1 = manager.audio:GetLocalizationFlag()

		if var_721_0[var_721_1] ~= nil then
			arg_721_1.duration_ = var_721_0[var_721_1]
		end

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
		end

		function arg_721_1.playNext_(arg_723_0)
			if arg_723_0 == 1 then
				arg_721_0:Play928041170(arg_721_1)
			end
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			local var_724_0 = 0

			if var_724_0 < arg_721_1.time_ and arg_721_1.time_ <= var_724_0 + arg_724_0 then
				arg_721_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action8_1")
			end

			local var_724_1 = 0

			if var_724_1 < arg_721_1.time_ and arg_721_1.time_ <= var_724_1 + arg_724_0 then
				arg_721_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_724_2 = 0
			local var_724_3 = 0.575

			if var_724_2 < arg_721_1.time_ and arg_721_1.time_ <= var_724_2 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, true)

				local var_724_4 = arg_721_1:FormatText(StoryNameCfg[32].name)

				arg_721_1.leftNameTxt_.text = var_724_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_721_1.leftNameTxt_.transform)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1.leftNameTxt_.text)
				SetActive(arg_721_1.iconTrs_.gameObject, false)
				arg_721_1.callingController_:SetSelectedState("normal")

				local var_724_5 = arg_721_1:GetWordFromCfg(928041169)
				local var_724_6 = arg_721_1:FormatText(var_724_5.content)

				arg_721_1.text_.text = var_724_6

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_7 = 23
				local var_724_8 = utf8.len(var_724_6)
				local var_724_9 = var_724_7 <= 0 and var_724_3 or var_724_3 * (var_724_8 / var_724_7)

				if var_724_9 > 0 and var_724_3 < var_724_9 then
					arg_721_1.talkMaxDuration = var_724_9

					if var_724_9 + var_724_2 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_9 + var_724_2
					end
				end

				arg_721_1.text_.text = var_724_6
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041169", "story_v_side_old_928041.awb") ~= 0 then
					local var_724_10 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041169", "story_v_side_old_928041.awb") / 1000

					if var_724_10 + var_724_2 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_10 + var_724_2
					end

					if var_724_5.prefab_name ~= "" and arg_721_1.actors_[var_724_5.prefab_name] ~= nil then
						local var_724_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_721_1.actors_[var_724_5.prefab_name].transform, "story_v_side_old_928041", "928041169", "story_v_side_old_928041.awb")

						arg_721_1:RecordAudio("928041169", var_724_11)
						arg_721_1:RecordAudio("928041169", var_724_11)
					else
						arg_721_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041169", "story_v_side_old_928041.awb")
					end

					arg_721_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041169", "story_v_side_old_928041.awb")
				end

				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_12 = math.max(var_724_3, arg_721_1.talkMaxDuration)

			if var_724_2 <= arg_721_1.time_ and arg_721_1.time_ < var_724_2 + var_724_12 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - var_724_2) / var_724_12

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= var_724_2 + var_724_12 and arg_721_1.time_ < var_724_2 + var_724_12 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {}

		arg_721_1:InitPlayNodeList()
	end,
	Play928041170 = function(arg_725_0, arg_725_1)
		arg_725_1.time_ = 0
		arg_725_1.frameCnt_ = 0
		arg_725_1.state_ = "playing"
		arg_725_1.curTalkId_ = 928041170
		arg_725_1.duration_ = 7.67

		SetActive(arg_725_1.tipsGo_, false)

		function arg_725_1.onSingleLineFinish_()
			arg_725_1.onSingleLineUpdate_ = nil
			arg_725_1.onSingleLineFinish_ = nil
			arg_725_1.state_ = "waiting"
		end

		function arg_725_1.playNext_(arg_727_0)
			if arg_727_0 == 1 then
				arg_725_0:Play928041171(arg_725_1)
			end
		end

		function arg_725_1.onSingleLineUpdate_(arg_728_0)
			local var_728_0 = "B13a"

			if arg_725_1.bgs_[var_728_0] == nil then
				local var_728_1 = Object.Instantiate(arg_725_1.paintGo_)

				var_728_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_728_0)
				var_728_1.name = var_728_0
				var_728_1.transform.parent = arg_725_1.stage_.transform
				var_728_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_725_1.bgs_[var_728_0] = var_728_1
			end

			local var_728_2 = 1.2

			if var_728_2 < arg_725_1.time_ and arg_725_1.time_ <= var_728_2 + arg_728_0 then
				local var_728_3 = manager.ui.mainCamera.transform.localPosition
				local var_728_4 = Vector3.New(0, 0, 10) + Vector3.New(var_728_3.x, var_728_3.y, 0)
				local var_728_5 = arg_725_1.bgs_.B13a

				var_728_5.transform.localPosition = var_728_4
				var_728_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_728_6 = var_728_5:GetComponent("SpriteRenderer")

				if var_728_6 and var_728_6.sprite then
					local var_728_7 = (var_728_5.transform.localPosition - var_728_3).z
					local var_728_8 = manager.ui.mainCameraCom_
					local var_728_9 = 2 * var_728_7 * Mathf.Tan(var_728_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_728_10 = var_728_9 * var_728_8.aspect
					local var_728_11 = var_728_6.sprite.bounds.size.x
					local var_728_12 = var_728_6.sprite.bounds.size.y
					local var_728_13 = var_728_10 / var_728_11
					local var_728_14 = var_728_9 / var_728_12
					local var_728_15 = var_728_14 < var_728_13 and var_728_13 or var_728_14

					var_728_5.transform.localScale = Vector3.New(var_728_15, var_728_15, 0)
				end

				for iter_728_0, iter_728_1 in pairs(arg_725_1.bgs_) do
					if iter_728_0 ~= "B13a" then
						iter_728_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_728_16 = 0

			if var_728_16 < arg_725_1.time_ and arg_725_1.time_ <= var_728_16 + arg_728_0 then
				arg_725_1.allBtn_.enabled = false
			end

			local var_728_17 = 0.3

			if arg_725_1.time_ >= var_728_16 + var_728_17 and arg_725_1.time_ < var_728_16 + var_728_17 + arg_728_0 then
				arg_725_1.allBtn_.enabled = true
			end

			local var_728_18 = 0

			if var_728_18 < arg_725_1.time_ and arg_725_1.time_ <= var_728_18 + arg_728_0 then
				arg_725_1.mask_.enabled = true
				arg_725_1.mask_.raycastTarget = true

				arg_725_1:SetGaussion(false)
			end

			local var_728_19 = 1.2

			if var_728_18 <= arg_725_1.time_ and arg_725_1.time_ < var_728_18 + var_728_19 then
				local var_728_20 = (arg_725_1.time_ - var_728_18) / var_728_19
				local var_728_21 = Color.New(0, 0, 0)

				var_728_21.a = Mathf.Lerp(0, 1, var_728_20)
				arg_725_1.mask_.color = var_728_21
			end

			if arg_725_1.time_ >= var_728_18 + var_728_19 and arg_725_1.time_ < var_728_18 + var_728_19 + arg_728_0 then
				local var_728_22 = Color.New(0, 0, 0)

				var_728_22.a = 1
				arg_725_1.mask_.color = var_728_22
			end

			local var_728_23 = 1.2

			if var_728_23 < arg_725_1.time_ and arg_725_1.time_ <= var_728_23 + arg_728_0 then
				arg_725_1.mask_.enabled = true
				arg_725_1.mask_.raycastTarget = true

				arg_725_1:SetGaussion(false)
			end

			local var_728_24 = 1.63333333333333

			if var_728_23 <= arg_725_1.time_ and arg_725_1.time_ < var_728_23 + var_728_24 then
				local var_728_25 = (arg_725_1.time_ - var_728_23) / var_728_24
				local var_728_26 = Color.New(0, 0, 0)

				var_728_26.a = Mathf.Lerp(1, 0, var_728_25)
				arg_725_1.mask_.color = var_728_26
			end

			if arg_725_1.time_ >= var_728_23 + var_728_24 and arg_725_1.time_ < var_728_23 + var_728_24 + arg_728_0 then
				local var_728_27 = Color.New(0, 0, 0)
				local var_728_28 = 0

				arg_725_1.mask_.enabled = false
				var_728_27.a = var_728_28
				arg_725_1.mask_.color = var_728_27
			end

			local var_728_29 = arg_725_1.actors_["1066ui_story"].transform
			local var_728_30 = 1.2

			if var_728_30 < arg_725_1.time_ and arg_725_1.time_ <= var_728_30 + arg_728_0 then
				arg_725_1.var_.moveOldPos1066ui_story = var_728_29.localPosition
			end

			local var_728_31 = 0.001

			if var_728_30 <= arg_725_1.time_ and arg_725_1.time_ < var_728_30 + var_728_31 then
				local var_728_32 = (arg_725_1.time_ - var_728_30) / var_728_31
				local var_728_33 = Vector3.New(0, 100, 0)

				var_728_29.localPosition = Vector3.Lerp(arg_725_1.var_.moveOldPos1066ui_story, var_728_33, var_728_32)

				local var_728_34 = manager.ui.mainCamera.transform.position - var_728_29.position

				var_728_29.forward = Vector3.New(var_728_34.x, var_728_34.y, var_728_34.z)

				local var_728_35 = var_728_29.localEulerAngles

				var_728_35.z = 0
				var_728_35.x = 0
				var_728_29.localEulerAngles = var_728_35
			end

			if arg_725_1.time_ >= var_728_30 + var_728_31 and arg_725_1.time_ < var_728_30 + var_728_31 + arg_728_0 then
				var_728_29.localPosition = Vector3.New(0, 100, 0)

				local var_728_36 = manager.ui.mainCamera.transform.position - var_728_29.position

				var_728_29.forward = Vector3.New(var_728_36.x, var_728_36.y, var_728_36.z)

				local var_728_37 = var_728_29.localEulerAngles

				var_728_37.z = 0
				var_728_37.x = 0
				var_728_29.localEulerAngles = var_728_37
			end

			local var_728_38 = arg_725_1.actors_["1066ui_story"]
			local var_728_39 = 1.2

			if var_728_39 < arg_725_1.time_ and arg_725_1.time_ <= var_728_39 + arg_728_0 and not isNil(var_728_38) and arg_725_1.var_.characterEffect1066ui_story == nil then
				arg_725_1.var_.characterEffect1066ui_story = var_728_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_728_40 = 0.200000002980232

			if var_728_39 <= arg_725_1.time_ and arg_725_1.time_ < var_728_39 + var_728_40 and not isNil(var_728_38) then
				local var_728_41 = (arg_725_1.time_ - var_728_39) / var_728_40

				if arg_725_1.var_.characterEffect1066ui_story and not isNil(var_728_38) then
					local var_728_42 = Mathf.Lerp(0, 0.5, var_728_41)

					arg_725_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_725_1.var_.characterEffect1066ui_story.fillRatio = var_728_42
				end
			end

			if arg_725_1.time_ >= var_728_39 + var_728_40 and arg_725_1.time_ < var_728_39 + var_728_40 + arg_728_0 and not isNil(var_728_38) and arg_725_1.var_.characterEffect1066ui_story then
				local var_728_43 = 0.5

				arg_725_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_725_1.var_.characterEffect1066ui_story.fillRatio = var_728_43
			end

			local var_728_44 = 0.1
			local var_728_45 = 1

			if var_728_44 < arg_725_1.time_ and arg_725_1.time_ <= var_728_44 + arg_728_0 then
				local var_728_46 = "stop"
				local var_728_47 = "effect"

				arg_725_1:AudioAction(var_728_46, var_728_47, "se_story_140", "se_story_140_amb_lab", "")
			end

			local var_728_48 = 1
			local var_728_49 = 1

			if var_728_48 < arg_725_1.time_ and arg_725_1.time_ <= var_728_48 + arg_728_0 then
				local var_728_50 = "play"
				local var_728_51 = "effect"

				arg_725_1:AudioAction(var_728_50, var_728_51, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_728_52 = 1.916
			local var_728_53 = 1

			if var_728_52 < arg_725_1.time_ and arg_725_1.time_ <= var_728_52 + arg_728_0 then
				local var_728_54 = "play"
				local var_728_55 = "effect"

				arg_725_1:AudioAction(var_728_54, var_728_55, "se_story_143", "se_story_143_foley_cloth01", "")
			end

			if arg_725_1.frameCnt_ <= 1 then
				arg_725_1.dialog_:SetActive(false)
			end

			local var_728_56 = 2.66666666666667
			local var_728_57 = 0.775

			if var_728_56 < arg_725_1.time_ and arg_725_1.time_ <= var_728_56 + arg_728_0 then
				arg_725_1.talkMaxDuration = 0

				arg_725_1.dialog_:SetActive(true)

				arg_725_1.dialogCg_.alpha = 0

				local var_728_58 = LeanTween.value(arg_725_1.dialog_, 0, 1, 0.3)

				var_728_58:setOnUpdate(LuaHelper.FloatAction(function(arg_729_0)
					arg_725_1.dialogCg_.alpha = arg_729_0
				end))
				var_728_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_725_1.dialog_)
					var_728_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_725_1.duration_ = arg_725_1.duration_ + 0.3

				SetActive(arg_725_1.leftNameGo_, false)

				arg_725_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_725_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_725_1:RecordName(arg_725_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_725_1.iconTrs_.gameObject, false)
				arg_725_1.callingController_:SetSelectedState("normal")

				local var_728_59 = arg_725_1:GetWordFromCfg(928041170)
				local var_728_60 = arg_725_1:FormatText(var_728_59.content)

				arg_725_1.text_.text = var_728_60

				LuaForUtil.ClearLinePrefixSymbol(arg_725_1.text_)

				local var_728_61 = 31
				local var_728_62 = utf8.len(var_728_60)
				local var_728_63 = var_728_61 <= 0 and var_728_57 or var_728_57 * (var_728_62 / var_728_61)

				if var_728_63 > 0 and var_728_57 < var_728_63 then
					arg_725_1.talkMaxDuration = var_728_63
					var_728_56 = var_728_56 + 0.3

					if var_728_63 + var_728_56 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_63 + var_728_56
					end
				end

				arg_725_1.text_.text = var_728_60
				arg_725_1.typewritter.percent = 0

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(false)
				arg_725_1:RecordContent(arg_725_1.text_.text)
			end

			local var_728_64 = var_728_56 + 0.3
			local var_728_65 = math.max(var_728_57, arg_725_1.talkMaxDuration)

			if var_728_64 <= arg_725_1.time_ and arg_725_1.time_ < var_728_64 + var_728_65 then
				arg_725_1.typewritter.percent = (arg_725_1.time_ - var_728_64) / var_728_65

				arg_725_1.typewritter:SetDirty()
			end

			if arg_725_1.time_ >= var_728_64 + var_728_65 and arg_725_1.time_ < var_728_64 + var_728_65 + arg_728_0 then
				arg_725_1.typewritter.percent = 1

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(true)
			end
		end

		arg_725_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "",
				frequency = 6,
				className = "StoryShakeNode",
				duration = 0.533333333333334,
				startTime = 2.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(10, 0.1, 0.1)
			}
		}

		arg_725_1:InitPlayNodeList()
	end,
	Play928041171 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 928041171
		arg_731_1.duration_ = 5

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play928041172(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			local var_734_0 = 0
			local var_734_1 = 0.1

			if var_734_0 < arg_731_1.time_ and arg_731_1.time_ <= var_734_0 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, true)

				local var_734_2 = arg_731_1:FormatText(StoryNameCfg[7].name)

				arg_731_1.leftNameTxt_.text = var_734_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, true)
				arg_731_1.iconController_:SetSelectedState("hero")

				arg_731_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_731_1.callingController_:SetSelectedState("normal")

				arg_731_1.keyicon_.color = Color.New(1, 1, 1)
				arg_731_1.icon_.color = Color.New(1, 1, 1)

				local var_734_3 = arg_731_1:GetWordFromCfg(928041171)
				local var_734_4 = arg_731_1:FormatText(var_734_3.content)

				arg_731_1.text_.text = var_734_4

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_5 = 4
				local var_734_6 = utf8.len(var_734_4)
				local var_734_7 = var_734_5 <= 0 and var_734_1 or var_734_1 * (var_734_6 / var_734_5)

				if var_734_7 > 0 and var_734_1 < var_734_7 then
					arg_731_1.talkMaxDuration = var_734_7

					if var_734_7 + var_734_0 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_7 + var_734_0
					end
				end

				arg_731_1.text_.text = var_734_4
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)
				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_8 = math.max(var_734_1, arg_731_1.talkMaxDuration)

			if var_734_0 <= arg_731_1.time_ and arg_731_1.time_ < var_734_0 + var_734_8 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_0) / var_734_8

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_0 + var_734_8 and arg_731_1.time_ < var_734_0 + var_734_8 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {}

		arg_731_1:InitPlayNodeList()
	end,
	Play928041172 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 928041172
		arg_735_1.duration_ = 5

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
		end

		function arg_735_1.playNext_(arg_737_0)
			if arg_737_0 == 1 then
				arg_735_0:Play928041173(arg_735_1)
			end
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			local var_738_0 = 0
			local var_738_1 = 0.625

			if var_738_0 < arg_735_1.time_ and arg_735_1.time_ <= var_738_0 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0
				arg_735_1.dialogCg_.alpha = 1

				arg_735_1.dialog_:SetActive(true)
				SetActive(arg_735_1.leftNameGo_, false)

				arg_735_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_735_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_735_1:RecordName(arg_735_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_735_1.iconTrs_.gameObject, false)
				arg_735_1.callingController_:SetSelectedState("normal")

				local var_738_2 = arg_735_1:GetWordFromCfg(928041172)
				local var_738_3 = arg_735_1:FormatText(var_738_2.content)

				arg_735_1.text_.text = var_738_3

				LuaForUtil.ClearLinePrefixSymbol(arg_735_1.text_)

				local var_738_4 = 25
				local var_738_5 = utf8.len(var_738_3)
				local var_738_6 = var_738_4 <= 0 and var_738_1 or var_738_1 * (var_738_5 / var_738_4)

				if var_738_6 > 0 and var_738_1 < var_738_6 then
					arg_735_1.talkMaxDuration = var_738_6

					if var_738_6 + var_738_0 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_6 + var_738_0
					end
				end

				arg_735_1.text_.text = var_738_3
				arg_735_1.typewritter.percent = 0

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(false)
				arg_735_1:RecordContent(arg_735_1.text_.text)
			end

			local var_738_7 = math.max(var_738_1, arg_735_1.talkMaxDuration)

			if var_738_0 <= arg_735_1.time_ and arg_735_1.time_ < var_738_0 + var_738_7 then
				arg_735_1.typewritter.percent = (arg_735_1.time_ - var_738_0) / var_738_7

				arg_735_1.typewritter:SetDirty()
			end

			if arg_735_1.time_ >= var_738_0 + var_738_7 and arg_735_1.time_ < var_738_0 + var_738_7 + arg_738_0 then
				arg_735_1.typewritter.percent = 1

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(true)
			end
		end

		arg_735_1.nodeConfigList_ = {}

		arg_735_1:InitPlayNodeList()
	end,
	Play928041173 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 928041173
		arg_739_1.duration_ = 5

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
		end

		function arg_739_1.playNext_(arg_741_0)
			if arg_741_0 == 1 then
				arg_739_0:Play928041174(arg_739_1)
			end
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			local var_742_0 = 0.323783000931144
			local var_742_1 = 1

			if var_742_0 < arg_739_1.time_ and arg_739_1.time_ <= var_742_0 + arg_742_0 then
				local var_742_2 = "play"
				local var_742_3 = "effect"

				arg_739_1:AudioAction(var_742_2, var_742_3, "se_story_145", "se_story_145_foley_cloth", "")
			end

			local var_742_4 = 0
			local var_742_5 = 0.75

			if var_742_4 < arg_739_1.time_ and arg_739_1.time_ <= var_742_4 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0
				arg_739_1.dialogCg_.alpha = 1

				arg_739_1.dialog_:SetActive(true)
				SetActive(arg_739_1.leftNameGo_, false)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_739_1.iconTrs_.gameObject, false)
				arg_739_1.callingController_:SetSelectedState("normal")

				local var_742_6 = arg_739_1:GetWordFromCfg(928041173)
				local var_742_7 = arg_739_1:FormatText(var_742_6.content)

				arg_739_1.text_.text = var_742_7

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_8 = 30
				local var_742_9 = utf8.len(var_742_7)
				local var_742_10 = var_742_8 <= 0 and var_742_5 or var_742_5 * (var_742_9 / var_742_8)

				if var_742_10 > 0 and var_742_5 < var_742_10 then
					arg_739_1.talkMaxDuration = var_742_10

					if var_742_10 + var_742_4 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_10 + var_742_4
					end
				end

				arg_739_1.text_.text = var_742_7
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)
				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_11 = math.max(var_742_5, arg_739_1.talkMaxDuration)

			if var_742_4 <= arg_739_1.time_ and arg_739_1.time_ < var_742_4 + var_742_11 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - var_742_4) / var_742_11

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= var_742_4 + var_742_11 and arg_739_1.time_ < var_742_4 + var_742_11 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end

		arg_739_1.nodeConfigList_ = {}

		arg_739_1:InitPlayNodeList()
	end,
	Play928041174 = function(arg_743_0, arg_743_1)
		arg_743_1.time_ = 0
		arg_743_1.frameCnt_ = 0
		arg_743_1.state_ = "playing"
		arg_743_1.curTalkId_ = 928041174
		arg_743_1.duration_ = 9.17

		local var_743_0 = {
			zh = 9.166,
			ja = 8.5
		}
		local var_743_1 = manager.audio:GetLocalizationFlag()

		if var_743_0[var_743_1] ~= nil then
			arg_743_1.duration_ = var_743_0[var_743_1]
		end

		SetActive(arg_743_1.tipsGo_, false)

		function arg_743_1.onSingleLineFinish_()
			arg_743_1.onSingleLineUpdate_ = nil
			arg_743_1.onSingleLineFinish_ = nil
			arg_743_1.state_ = "waiting"
		end

		function arg_743_1.playNext_(arg_745_0)
			if arg_745_0 == 1 then
				arg_743_0:Play928041175(arg_743_1)
			end
		end

		function arg_743_1.onSingleLineUpdate_(arg_746_0)
			local var_746_0 = arg_743_1.actors_["1085ui_story"].transform
			local var_746_1 = 0

			if var_746_1 < arg_743_1.time_ and arg_743_1.time_ <= var_746_1 + arg_746_0 then
				arg_743_1.var_.moveOldPos1085ui_story = var_746_0.localPosition
			end

			local var_746_2 = 0.001

			if var_746_1 <= arg_743_1.time_ and arg_743_1.time_ < var_746_1 + var_746_2 then
				local var_746_3 = (arg_743_1.time_ - var_746_1) / var_746_2
				local var_746_4 = Vector3.New(0, -1.01, -5.83)

				var_746_0.localPosition = Vector3.Lerp(arg_743_1.var_.moveOldPos1085ui_story, var_746_4, var_746_3)

				local var_746_5 = manager.ui.mainCamera.transform.position - var_746_0.position

				var_746_0.forward = Vector3.New(var_746_5.x, var_746_5.y, var_746_5.z)

				local var_746_6 = var_746_0.localEulerAngles

				var_746_6.z = 0
				var_746_6.x = 0
				var_746_0.localEulerAngles = var_746_6
			end

			if arg_743_1.time_ >= var_746_1 + var_746_2 and arg_743_1.time_ < var_746_1 + var_746_2 + arg_746_0 then
				var_746_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_746_7 = manager.ui.mainCamera.transform.position - var_746_0.position

				var_746_0.forward = Vector3.New(var_746_7.x, var_746_7.y, var_746_7.z)

				local var_746_8 = var_746_0.localEulerAngles

				var_746_8.z = 0
				var_746_8.x = 0
				var_746_0.localEulerAngles = var_746_8
			end

			local var_746_9 = arg_743_1.actors_["1085ui_story"]
			local var_746_10 = 0

			if var_746_10 < arg_743_1.time_ and arg_743_1.time_ <= var_746_10 + arg_746_0 and not isNil(var_746_9) and arg_743_1.var_.characterEffect1085ui_story == nil then
				arg_743_1.var_.characterEffect1085ui_story = var_746_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_746_11 = 0.200000002980232

			if var_746_10 <= arg_743_1.time_ and arg_743_1.time_ < var_746_10 + var_746_11 and not isNil(var_746_9) then
				local var_746_12 = (arg_743_1.time_ - var_746_10) / var_746_11

				if arg_743_1.var_.characterEffect1085ui_story and not isNil(var_746_9) then
					arg_743_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_743_1.time_ >= var_746_10 + var_746_11 and arg_743_1.time_ < var_746_10 + var_746_11 + arg_746_0 and not isNil(var_746_9) and arg_743_1.var_.characterEffect1085ui_story then
				arg_743_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_746_13 = 0

			if var_746_13 < arg_743_1.time_ and arg_743_1.time_ <= var_746_13 + arg_746_0 then
				arg_743_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action9_1")
			end

			local var_746_14 = 0

			if var_746_14 < arg_743_1.time_ and arg_743_1.time_ <= var_746_14 + arg_746_0 then
				arg_743_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_746_15 = 0
			local var_746_16 = 0.725

			if var_746_15 < arg_743_1.time_ and arg_743_1.time_ <= var_746_15 + arg_746_0 then
				arg_743_1.talkMaxDuration = 0
				arg_743_1.dialogCg_.alpha = 1

				arg_743_1.dialog_:SetActive(true)
				SetActive(arg_743_1.leftNameGo_, true)

				local var_746_17 = arg_743_1:FormatText(StoryNameCfg[328].name)

				arg_743_1.leftNameTxt_.text = var_746_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_743_1.leftNameTxt_.transform)

				arg_743_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_743_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_743_1:RecordName(arg_743_1.leftNameTxt_.text)
				SetActive(arg_743_1.iconTrs_.gameObject, false)
				arg_743_1.callingController_:SetSelectedState("normal")

				local var_746_18 = arg_743_1:GetWordFromCfg(928041174)
				local var_746_19 = arg_743_1:FormatText(var_746_18.content)

				arg_743_1.text_.text = var_746_19

				LuaForUtil.ClearLinePrefixSymbol(arg_743_1.text_)

				local var_746_20 = 29
				local var_746_21 = utf8.len(var_746_19)
				local var_746_22 = var_746_20 <= 0 and var_746_16 or var_746_16 * (var_746_21 / var_746_20)

				if var_746_22 > 0 and var_746_16 < var_746_22 then
					arg_743_1.talkMaxDuration = var_746_22

					if var_746_22 + var_746_15 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_22 + var_746_15
					end
				end

				arg_743_1.text_.text = var_746_19
				arg_743_1.typewritter.percent = 0

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041174", "story_v_side_old_928041.awb") ~= 0 then
					local var_746_23 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041174", "story_v_side_old_928041.awb") / 1000

					if var_746_23 + var_746_15 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_23 + var_746_15
					end

					if var_746_18.prefab_name ~= "" and arg_743_1.actors_[var_746_18.prefab_name] ~= nil then
						local var_746_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_743_1.actors_[var_746_18.prefab_name].transform, "story_v_side_old_928041", "928041174", "story_v_side_old_928041.awb")

						arg_743_1:RecordAudio("928041174", var_746_24)
						arg_743_1:RecordAudio("928041174", var_746_24)
					else
						arg_743_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041174", "story_v_side_old_928041.awb")
					end

					arg_743_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041174", "story_v_side_old_928041.awb")
				end

				arg_743_1:RecordContent(arg_743_1.text_.text)
			end

			local var_746_25 = math.max(var_746_16, arg_743_1.talkMaxDuration)

			if var_746_15 <= arg_743_1.time_ and arg_743_1.time_ < var_746_15 + var_746_25 then
				arg_743_1.typewritter.percent = (arg_743_1.time_ - var_746_15) / var_746_25

				arg_743_1.typewritter:SetDirty()
			end

			if arg_743_1.time_ >= var_746_15 + var_746_25 and arg_743_1.time_ < var_746_15 + var_746_25 + arg_746_0 then
				arg_743_1.typewritter.percent = 1

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(true)
			end
		end

		arg_743_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_743_1:InitPlayNodeList()
	end,
	Play928041175 = function(arg_747_0, arg_747_1)
		arg_747_1.time_ = 0
		arg_747_1.frameCnt_ = 0
		arg_747_1.state_ = "playing"
		arg_747_1.curTalkId_ = 928041175
		arg_747_1.duration_ = 12.37

		local var_747_0 = {
			zh = 9.1,
			ja = 12.366
		}
		local var_747_1 = manager.audio:GetLocalizationFlag()

		if var_747_0[var_747_1] ~= nil then
			arg_747_1.duration_ = var_747_0[var_747_1]
		end

		SetActive(arg_747_1.tipsGo_, false)

		function arg_747_1.onSingleLineFinish_()
			arg_747_1.onSingleLineUpdate_ = nil
			arg_747_1.onSingleLineFinish_ = nil
			arg_747_1.state_ = "waiting"
		end

		function arg_747_1.playNext_(arg_749_0)
			if arg_749_0 == 1 then
				arg_747_0:Play928041176(arg_747_1)
			end
		end

		function arg_747_1.onSingleLineUpdate_(arg_750_0)
			local var_750_0 = 0
			local var_750_1 = 0.9

			if var_750_0 < arg_747_1.time_ and arg_747_1.time_ <= var_750_0 + arg_750_0 then
				arg_747_1.talkMaxDuration = 0
				arg_747_1.dialogCg_.alpha = 1

				arg_747_1.dialog_:SetActive(true)
				SetActive(arg_747_1.leftNameGo_, true)

				local var_750_2 = arg_747_1:FormatText(StoryNameCfg[328].name)

				arg_747_1.leftNameTxt_.text = var_750_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_747_1.leftNameTxt_.transform)

				arg_747_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_747_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_747_1:RecordName(arg_747_1.leftNameTxt_.text)
				SetActive(arg_747_1.iconTrs_.gameObject, false)
				arg_747_1.callingController_:SetSelectedState("normal")

				local var_750_3 = arg_747_1:GetWordFromCfg(928041175)
				local var_750_4 = arg_747_1:FormatText(var_750_3.content)

				arg_747_1.text_.text = var_750_4

				LuaForUtil.ClearLinePrefixSymbol(arg_747_1.text_)

				local var_750_5 = 36
				local var_750_6 = utf8.len(var_750_4)
				local var_750_7 = var_750_5 <= 0 and var_750_1 or var_750_1 * (var_750_6 / var_750_5)

				if var_750_7 > 0 and var_750_1 < var_750_7 then
					arg_747_1.talkMaxDuration = var_750_7

					if var_750_7 + var_750_0 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_7 + var_750_0
					end
				end

				arg_747_1.text_.text = var_750_4
				arg_747_1.typewritter.percent = 0

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041175", "story_v_side_old_928041.awb") ~= 0 then
					local var_750_8 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041175", "story_v_side_old_928041.awb") / 1000

					if var_750_8 + var_750_0 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_8 + var_750_0
					end

					if var_750_3.prefab_name ~= "" and arg_747_1.actors_[var_750_3.prefab_name] ~= nil then
						local var_750_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_747_1.actors_[var_750_3.prefab_name].transform, "story_v_side_old_928041", "928041175", "story_v_side_old_928041.awb")

						arg_747_1:RecordAudio("928041175", var_750_9)
						arg_747_1:RecordAudio("928041175", var_750_9)
					else
						arg_747_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041175", "story_v_side_old_928041.awb")
					end

					arg_747_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041175", "story_v_side_old_928041.awb")
				end

				arg_747_1:RecordContent(arg_747_1.text_.text)
			end

			local var_750_10 = math.max(var_750_1, arg_747_1.talkMaxDuration)

			if var_750_0 <= arg_747_1.time_ and arg_747_1.time_ < var_750_0 + var_750_10 then
				arg_747_1.typewritter.percent = (arg_747_1.time_ - var_750_0) / var_750_10

				arg_747_1.typewritter:SetDirty()
			end

			if arg_747_1.time_ >= var_750_0 + var_750_10 and arg_747_1.time_ < var_750_0 + var_750_10 + arg_750_0 then
				arg_747_1.typewritter.percent = 1

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(true)
			end
		end

		arg_747_1.nodeConfigList_ = {}

		arg_747_1:InitPlayNodeList()
	end,
	Play928041176 = function(arg_751_0, arg_751_1)
		arg_751_1.time_ = 0
		arg_751_1.frameCnt_ = 0
		arg_751_1.state_ = "playing"
		arg_751_1.curTalkId_ = 928041176
		arg_751_1.duration_ = 5

		SetActive(arg_751_1.tipsGo_, false)

		function arg_751_1.onSingleLineFinish_()
			arg_751_1.onSingleLineUpdate_ = nil
			arg_751_1.onSingleLineFinish_ = nil
			arg_751_1.state_ = "waiting"
		end

		function arg_751_1.playNext_(arg_753_0)
			if arg_753_0 == 1 then
				arg_751_0:Play928041177(arg_751_1)
			end
		end

		function arg_751_1.onSingleLineUpdate_(arg_754_0)
			local var_754_0 = arg_751_1.actors_["1085ui_story"].transform
			local var_754_1 = 0

			if var_754_1 < arg_751_1.time_ and arg_751_1.time_ <= var_754_1 + arg_754_0 then
				arg_751_1.var_.moveOldPos1085ui_story = var_754_0.localPosition
			end

			local var_754_2 = 0.001

			if var_754_1 <= arg_751_1.time_ and arg_751_1.time_ < var_754_1 + var_754_2 then
				local var_754_3 = (arg_751_1.time_ - var_754_1) / var_754_2
				local var_754_4 = Vector3.New(0, 100, 0)

				var_754_0.localPosition = Vector3.Lerp(arg_751_1.var_.moveOldPos1085ui_story, var_754_4, var_754_3)

				local var_754_5 = manager.ui.mainCamera.transform.position - var_754_0.position

				var_754_0.forward = Vector3.New(var_754_5.x, var_754_5.y, var_754_5.z)

				local var_754_6 = var_754_0.localEulerAngles

				var_754_6.z = 0
				var_754_6.x = 0
				var_754_0.localEulerAngles = var_754_6
			end

			if arg_751_1.time_ >= var_754_1 + var_754_2 and arg_751_1.time_ < var_754_1 + var_754_2 + arg_754_0 then
				var_754_0.localPosition = Vector3.New(0, 100, 0)

				local var_754_7 = manager.ui.mainCamera.transform.position - var_754_0.position

				var_754_0.forward = Vector3.New(var_754_7.x, var_754_7.y, var_754_7.z)

				local var_754_8 = var_754_0.localEulerAngles

				var_754_8.z = 0
				var_754_8.x = 0
				var_754_0.localEulerAngles = var_754_8
			end

			local var_754_9 = arg_751_1.actors_["1085ui_story"]
			local var_754_10 = 0

			if var_754_10 < arg_751_1.time_ and arg_751_1.time_ <= var_754_10 + arg_754_0 and not isNil(var_754_9) and arg_751_1.var_.characterEffect1085ui_story == nil then
				arg_751_1.var_.characterEffect1085ui_story = var_754_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_754_11 = 0.200000002980232

			if var_754_10 <= arg_751_1.time_ and arg_751_1.time_ < var_754_10 + var_754_11 and not isNil(var_754_9) then
				local var_754_12 = (arg_751_1.time_ - var_754_10) / var_754_11

				if arg_751_1.var_.characterEffect1085ui_story and not isNil(var_754_9) then
					local var_754_13 = Mathf.Lerp(0, 0.5, var_754_12)

					arg_751_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_751_1.var_.characterEffect1085ui_story.fillRatio = var_754_13
				end
			end

			if arg_751_1.time_ >= var_754_10 + var_754_11 and arg_751_1.time_ < var_754_10 + var_754_11 + arg_754_0 and not isNil(var_754_9) and arg_751_1.var_.characterEffect1085ui_story then
				local var_754_14 = 0.5

				arg_751_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_751_1.var_.characterEffect1085ui_story.fillRatio = var_754_14
			end

			local var_754_15 = 0
			local var_754_16 = 0.975

			if var_754_15 < arg_751_1.time_ and arg_751_1.time_ <= var_754_15 + arg_754_0 then
				arg_751_1.talkMaxDuration = 0
				arg_751_1.dialogCg_.alpha = 1

				arg_751_1.dialog_:SetActive(true)
				SetActive(arg_751_1.leftNameGo_, false)

				arg_751_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_751_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_751_1:RecordName(arg_751_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_751_1.iconTrs_.gameObject, false)
				arg_751_1.callingController_:SetSelectedState("normal")

				local var_754_17 = arg_751_1:GetWordFromCfg(928041176)
				local var_754_18 = arg_751_1:FormatText(var_754_17.content)

				arg_751_1.text_.text = var_754_18

				LuaForUtil.ClearLinePrefixSymbol(arg_751_1.text_)

				local var_754_19 = 39
				local var_754_20 = utf8.len(var_754_18)
				local var_754_21 = var_754_19 <= 0 and var_754_16 or var_754_16 * (var_754_20 / var_754_19)

				if var_754_21 > 0 and var_754_16 < var_754_21 then
					arg_751_1.talkMaxDuration = var_754_21

					if var_754_21 + var_754_15 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_21 + var_754_15
					end
				end

				arg_751_1.text_.text = var_754_18
				arg_751_1.typewritter.percent = 0

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(false)
				arg_751_1:RecordContent(arg_751_1.text_.text)
			end

			local var_754_22 = math.max(var_754_16, arg_751_1.talkMaxDuration)

			if var_754_15 <= arg_751_1.time_ and arg_751_1.time_ < var_754_15 + var_754_22 then
				arg_751_1.typewritter.percent = (arg_751_1.time_ - var_754_15) / var_754_22

				arg_751_1.typewritter:SetDirty()
			end

			if arg_751_1.time_ >= var_754_15 + var_754_22 and arg_751_1.time_ < var_754_15 + var_754_22 + arg_754_0 then
				arg_751_1.typewritter.percent = 1

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(true)
			end
		end

		arg_751_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_751_1:InitPlayNodeList()
	end,
	Play928041177 = function(arg_755_0, arg_755_1)
		arg_755_1.time_ = 0
		arg_755_1.frameCnt_ = 0
		arg_755_1.state_ = "playing"
		arg_755_1.curTalkId_ = 928041177
		arg_755_1.duration_ = 5

		SetActive(arg_755_1.tipsGo_, false)

		function arg_755_1.onSingleLineFinish_()
			arg_755_1.onSingleLineUpdate_ = nil
			arg_755_1.onSingleLineFinish_ = nil
			arg_755_1.state_ = "waiting"
		end

		function arg_755_1.playNext_(arg_757_0)
			if arg_757_0 == 1 then
				arg_755_0:Play928041178(arg_755_1)
			end
		end

		function arg_755_1.onSingleLineUpdate_(arg_758_0)
			local var_758_0 = 0
			local var_758_1 = 0.075

			if var_758_0 < arg_755_1.time_ and arg_755_1.time_ <= var_758_0 + arg_758_0 then
				arg_755_1.talkMaxDuration = 0
				arg_755_1.dialogCg_.alpha = 1

				arg_755_1.dialog_:SetActive(true)
				SetActive(arg_755_1.leftNameGo_, true)

				local var_758_2 = arg_755_1:FormatText(StoryNameCfg[7].name)

				arg_755_1.leftNameTxt_.text = var_758_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_755_1.leftNameTxt_.transform)

				arg_755_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_755_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_755_1:RecordName(arg_755_1.leftNameTxt_.text)
				SetActive(arg_755_1.iconTrs_.gameObject, true)
				arg_755_1.iconController_:SetSelectedState("hero")

				arg_755_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_755_1.callingController_:SetSelectedState("normal")

				arg_755_1.keyicon_.color = Color.New(1, 1, 1)
				arg_755_1.icon_.color = Color.New(1, 1, 1)

				local var_758_3 = arg_755_1:GetWordFromCfg(928041177)
				local var_758_4 = arg_755_1:FormatText(var_758_3.content)

				arg_755_1.text_.text = var_758_4

				LuaForUtil.ClearLinePrefixSymbol(arg_755_1.text_)

				local var_758_5 = 3
				local var_758_6 = utf8.len(var_758_4)
				local var_758_7 = var_758_5 <= 0 and var_758_1 or var_758_1 * (var_758_6 / var_758_5)

				if var_758_7 > 0 and var_758_1 < var_758_7 then
					arg_755_1.talkMaxDuration = var_758_7

					if var_758_7 + var_758_0 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_7 + var_758_0
					end
				end

				arg_755_1.text_.text = var_758_4
				arg_755_1.typewritter.percent = 0

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(false)
				arg_755_1:RecordContent(arg_755_1.text_.text)
			end

			local var_758_8 = math.max(var_758_1, arg_755_1.talkMaxDuration)

			if var_758_0 <= arg_755_1.time_ and arg_755_1.time_ < var_758_0 + var_758_8 then
				arg_755_1.typewritter.percent = (arg_755_1.time_ - var_758_0) / var_758_8

				arg_755_1.typewritter:SetDirty()
			end

			if arg_755_1.time_ >= var_758_0 + var_758_8 and arg_755_1.time_ < var_758_0 + var_758_8 + arg_758_0 then
				arg_755_1.typewritter.percent = 1

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(true)
			end
		end

		arg_755_1.nodeConfigList_ = {}

		arg_755_1:InitPlayNodeList()
	end,
	Play928041178 = function(arg_759_0, arg_759_1)
		arg_759_1.time_ = 0
		arg_759_1.frameCnt_ = 0
		arg_759_1.state_ = "playing"
		arg_759_1.curTalkId_ = 928041178
		arg_759_1.duration_ = 2.53

		local var_759_0 = {
			zh = 2.233,
			ja = 2.533
		}
		local var_759_1 = manager.audio:GetLocalizationFlag()

		if var_759_0[var_759_1] ~= nil then
			arg_759_1.duration_ = var_759_0[var_759_1]
		end

		SetActive(arg_759_1.tipsGo_, false)

		function arg_759_1.onSingleLineFinish_()
			arg_759_1.onSingleLineUpdate_ = nil
			arg_759_1.onSingleLineFinish_ = nil
			arg_759_1.state_ = "waiting"
		end

		function arg_759_1.playNext_(arg_761_0)
			if arg_761_0 == 1 then
				arg_759_0:Play928041179(arg_759_1)
			end
		end

		function arg_759_1.onSingleLineUpdate_(arg_762_0)
			local var_762_0 = arg_759_1.actors_["1085ui_story"].transform
			local var_762_1 = 0

			if var_762_1 < arg_759_1.time_ and arg_759_1.time_ <= var_762_1 + arg_762_0 then
				arg_759_1.var_.moveOldPos1085ui_story = var_762_0.localPosition
			end

			local var_762_2 = 0.001

			if var_762_1 <= arg_759_1.time_ and arg_759_1.time_ < var_762_1 + var_762_2 then
				local var_762_3 = (arg_759_1.time_ - var_762_1) / var_762_2
				local var_762_4 = Vector3.New(0, -1.01, -5.83)

				var_762_0.localPosition = Vector3.Lerp(arg_759_1.var_.moveOldPos1085ui_story, var_762_4, var_762_3)

				local var_762_5 = manager.ui.mainCamera.transform.position - var_762_0.position

				var_762_0.forward = Vector3.New(var_762_5.x, var_762_5.y, var_762_5.z)

				local var_762_6 = var_762_0.localEulerAngles

				var_762_6.z = 0
				var_762_6.x = 0
				var_762_0.localEulerAngles = var_762_6
			end

			if arg_759_1.time_ >= var_762_1 + var_762_2 and arg_759_1.time_ < var_762_1 + var_762_2 + arg_762_0 then
				var_762_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_762_7 = manager.ui.mainCamera.transform.position - var_762_0.position

				var_762_0.forward = Vector3.New(var_762_7.x, var_762_7.y, var_762_7.z)

				local var_762_8 = var_762_0.localEulerAngles

				var_762_8.z = 0
				var_762_8.x = 0
				var_762_0.localEulerAngles = var_762_8
			end

			local var_762_9 = arg_759_1.actors_["1085ui_story"]
			local var_762_10 = 0

			if var_762_10 < arg_759_1.time_ and arg_759_1.time_ <= var_762_10 + arg_762_0 and not isNil(var_762_9) and arg_759_1.var_.characterEffect1085ui_story == nil then
				arg_759_1.var_.characterEffect1085ui_story = var_762_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_762_11 = 0.200000002980232

			if var_762_10 <= arg_759_1.time_ and arg_759_1.time_ < var_762_10 + var_762_11 and not isNil(var_762_9) then
				local var_762_12 = (arg_759_1.time_ - var_762_10) / var_762_11

				if arg_759_1.var_.characterEffect1085ui_story and not isNil(var_762_9) then
					arg_759_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_759_1.time_ >= var_762_10 + var_762_11 and arg_759_1.time_ < var_762_10 + var_762_11 + arg_762_0 and not isNil(var_762_9) and arg_759_1.var_.characterEffect1085ui_story then
				arg_759_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_762_13 = 0

			if var_762_13 < arg_759_1.time_ and arg_759_1.time_ <= var_762_13 + arg_762_0 then
				arg_759_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action496")
			end

			local var_762_14 = 0

			if var_762_14 < arg_759_1.time_ and arg_759_1.time_ <= var_762_14 + arg_762_0 then
				arg_759_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_762_15 = 0
			local var_762_16 = 0.125

			if var_762_15 < arg_759_1.time_ and arg_759_1.time_ <= var_762_15 + arg_762_0 then
				arg_759_1.talkMaxDuration = 0
				arg_759_1.dialogCg_.alpha = 1

				arg_759_1.dialog_:SetActive(true)
				SetActive(arg_759_1.leftNameGo_, true)

				local var_762_17 = arg_759_1:FormatText(StoryNameCfg[328].name)

				arg_759_1.leftNameTxt_.text = var_762_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_759_1.leftNameTxt_.transform)

				arg_759_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_759_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_759_1:RecordName(arg_759_1.leftNameTxt_.text)
				SetActive(arg_759_1.iconTrs_.gameObject, false)
				arg_759_1.callingController_:SetSelectedState("normal")

				local var_762_18 = arg_759_1:GetWordFromCfg(928041178)
				local var_762_19 = arg_759_1:FormatText(var_762_18.content)

				arg_759_1.text_.text = var_762_19

				LuaForUtil.ClearLinePrefixSymbol(arg_759_1.text_)

				local var_762_20 = 5
				local var_762_21 = utf8.len(var_762_19)
				local var_762_22 = var_762_20 <= 0 and var_762_16 or var_762_16 * (var_762_21 / var_762_20)

				if var_762_22 > 0 and var_762_16 < var_762_22 then
					arg_759_1.talkMaxDuration = var_762_22

					if var_762_22 + var_762_15 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_22 + var_762_15
					end
				end

				arg_759_1.text_.text = var_762_19
				arg_759_1.typewritter.percent = 0

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_928041", "928041178", "story_v_side_old_928041.awb") ~= 0 then
					local var_762_23 = manager.audio:GetVoiceLength("story_v_side_old_928041", "928041178", "story_v_side_old_928041.awb") / 1000

					if var_762_23 + var_762_15 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_23 + var_762_15
					end

					if var_762_18.prefab_name ~= "" and arg_759_1.actors_[var_762_18.prefab_name] ~= nil then
						local var_762_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_759_1.actors_[var_762_18.prefab_name].transform, "story_v_side_old_928041", "928041178", "story_v_side_old_928041.awb")

						arg_759_1:RecordAudio("928041178", var_762_24)
						arg_759_1:RecordAudio("928041178", var_762_24)
					else
						arg_759_1:AudioAction("play", "voice", "story_v_side_old_928041", "928041178", "story_v_side_old_928041.awb")
					end

					arg_759_1:RecordHistoryTalkVoice("story_v_side_old_928041", "928041178", "story_v_side_old_928041.awb")
				end

				arg_759_1:RecordContent(arg_759_1.text_.text)
			end

			local var_762_25 = math.max(var_762_16, arg_759_1.talkMaxDuration)

			if var_762_15 <= arg_759_1.time_ and arg_759_1.time_ < var_762_15 + var_762_25 then
				arg_759_1.typewritter.percent = (arg_759_1.time_ - var_762_15) / var_762_25

				arg_759_1.typewritter:SetDirty()
			end

			if arg_759_1.time_ >= var_762_15 + var_762_25 and arg_759_1.time_ < var_762_15 + var_762_25 + arg_762_0 then
				arg_759_1.typewritter.percent = 1

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(true)
			end
		end

		arg_759_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play928041179 = function(arg_763_0, arg_763_1)
		arg_763_1.time_ = 0
		arg_763_1.frameCnt_ = 0
		arg_763_1.state_ = "playing"
		arg_763_1.curTalkId_ = 928041179
		arg_763_1.duration_ = 5

		SetActive(arg_763_1.tipsGo_, false)

		function arg_763_1.onSingleLineFinish_()
			arg_763_1.onSingleLineUpdate_ = nil
			arg_763_1.onSingleLineFinish_ = nil
			arg_763_1.state_ = "waiting"
		end

		function arg_763_1.playNext_(arg_765_0)
			if arg_765_0 == 1 then
				arg_763_0:Play928041180(arg_763_1)
			end
		end

		function arg_763_1.onSingleLineUpdate_(arg_766_0)
			local var_766_0 = arg_763_1.actors_["1085ui_story"].transform
			local var_766_1 = 0

			if var_766_1 < arg_763_1.time_ and arg_763_1.time_ <= var_766_1 + arg_766_0 then
				arg_763_1.var_.moveOldPos1085ui_story = var_766_0.localPosition
			end

			local var_766_2 = 0.001

			if var_766_1 <= arg_763_1.time_ and arg_763_1.time_ < var_766_1 + var_766_2 then
				local var_766_3 = (arg_763_1.time_ - var_766_1) / var_766_2
				local var_766_4 = Vector3.New(0, 100, 0)

				var_766_0.localPosition = Vector3.Lerp(arg_763_1.var_.moveOldPos1085ui_story, var_766_4, var_766_3)

				local var_766_5 = manager.ui.mainCamera.transform.position - var_766_0.position

				var_766_0.forward = Vector3.New(var_766_5.x, var_766_5.y, var_766_5.z)

				local var_766_6 = var_766_0.localEulerAngles

				var_766_6.z = 0
				var_766_6.x = 0
				var_766_0.localEulerAngles = var_766_6
			end

			if arg_763_1.time_ >= var_766_1 + var_766_2 and arg_763_1.time_ < var_766_1 + var_766_2 + arg_766_0 then
				var_766_0.localPosition = Vector3.New(0, 100, 0)

				local var_766_7 = manager.ui.mainCamera.transform.position - var_766_0.position

				var_766_0.forward = Vector3.New(var_766_7.x, var_766_7.y, var_766_7.z)

				local var_766_8 = var_766_0.localEulerAngles

				var_766_8.z = 0
				var_766_8.x = 0
				var_766_0.localEulerAngles = var_766_8
			end

			local var_766_9 = arg_763_1.actors_["1085ui_story"]
			local var_766_10 = 0

			if var_766_10 < arg_763_1.time_ and arg_763_1.time_ <= var_766_10 + arg_766_0 and not isNil(var_766_9) and arg_763_1.var_.characterEffect1085ui_story == nil then
				arg_763_1.var_.characterEffect1085ui_story = var_766_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_766_11 = 0.200000002980232

			if var_766_10 <= arg_763_1.time_ and arg_763_1.time_ < var_766_10 + var_766_11 and not isNil(var_766_9) then
				local var_766_12 = (arg_763_1.time_ - var_766_10) / var_766_11

				if arg_763_1.var_.characterEffect1085ui_story and not isNil(var_766_9) then
					local var_766_13 = Mathf.Lerp(0, 0.5, var_766_12)

					arg_763_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_763_1.var_.characterEffect1085ui_story.fillRatio = var_766_13
				end
			end

			if arg_763_1.time_ >= var_766_10 + var_766_11 and arg_763_1.time_ < var_766_10 + var_766_11 + arg_766_0 and not isNil(var_766_9) and arg_763_1.var_.characterEffect1085ui_story then
				local var_766_14 = 0.5

				arg_763_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_763_1.var_.characterEffect1085ui_story.fillRatio = var_766_14
			end

			local var_766_15 = 0
			local var_766_16 = 0.75

			if var_766_15 < arg_763_1.time_ and arg_763_1.time_ <= var_766_15 + arg_766_0 then
				arg_763_1.talkMaxDuration = 0
				arg_763_1.dialogCg_.alpha = 1

				arg_763_1.dialog_:SetActive(true)
				SetActive(arg_763_1.leftNameGo_, false)

				arg_763_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_763_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_763_1:RecordName(arg_763_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_763_1.iconTrs_.gameObject, false)
				arg_763_1.callingController_:SetSelectedState("normal")

				local var_766_17 = arg_763_1:GetWordFromCfg(928041179)
				local var_766_18 = arg_763_1:FormatText(var_766_17.content)

				arg_763_1.text_.text = var_766_18

				LuaForUtil.ClearLinePrefixSymbol(arg_763_1.text_)

				local var_766_19 = 30
				local var_766_20 = utf8.len(var_766_18)
				local var_766_21 = var_766_19 <= 0 and var_766_16 or var_766_16 * (var_766_20 / var_766_19)

				if var_766_21 > 0 and var_766_16 < var_766_21 then
					arg_763_1.talkMaxDuration = var_766_21

					if var_766_21 + var_766_15 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_21 + var_766_15
					end
				end

				arg_763_1.text_.text = var_766_18
				arg_763_1.typewritter.percent = 0

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(false)
				arg_763_1:RecordContent(arg_763_1.text_.text)
			end

			local var_766_22 = math.max(var_766_16, arg_763_1.talkMaxDuration)

			if var_766_15 <= arg_763_1.time_ and arg_763_1.time_ < var_766_15 + var_766_22 then
				arg_763_1.typewritter.percent = (arg_763_1.time_ - var_766_15) / var_766_22

				arg_763_1.typewritter:SetDirty()
			end

			if arg_763_1.time_ >= var_766_15 + var_766_22 and arg_763_1.time_ < var_766_15 + var_766_22 + arg_766_0 then
				arg_763_1.typewritter.percent = 1

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(true)
			end
		end

		arg_763_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_763_1:InitPlayNodeList()
	end,
	Play928041180 = function(arg_767_0, arg_767_1)
		arg_767_1.time_ = 0
		arg_767_1.frameCnt_ = 0
		arg_767_1.state_ = "playing"
		arg_767_1.curTalkId_ = 928041180
		arg_767_1.duration_ = 5

		SetActive(arg_767_1.tipsGo_, false)

		function arg_767_1.onSingleLineFinish_()
			arg_767_1.onSingleLineUpdate_ = nil
			arg_767_1.onSingleLineFinish_ = nil
			arg_767_1.state_ = "waiting"
		end

		function arg_767_1.playNext_(arg_769_0)
			if arg_769_0 == 1 then
				arg_767_0:Play928041181(arg_767_1)
			end
		end

		function arg_767_1.onSingleLineUpdate_(arg_770_0)
			local var_770_0 = 0.133333333333333
			local var_770_1 = 1

			if var_770_0 < arg_767_1.time_ and arg_767_1.time_ <= var_770_0 + arg_770_0 then
				local var_770_2 = "play"
				local var_770_3 = "effect"

				arg_767_1:AudioAction(var_770_2, var_770_3, "se_story_side_1033", "se_story_side_1033_footstep", "")
			end

			local var_770_4 = 0
			local var_770_5 = 0.6

			if var_770_4 < arg_767_1.time_ and arg_767_1.time_ <= var_770_4 + arg_770_0 then
				arg_767_1.talkMaxDuration = 0
				arg_767_1.dialogCg_.alpha = 1

				arg_767_1.dialog_:SetActive(true)
				SetActive(arg_767_1.leftNameGo_, false)

				arg_767_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_767_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_767_1:RecordName(arg_767_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_767_1.iconTrs_.gameObject, false)
				arg_767_1.callingController_:SetSelectedState("normal")

				local var_770_6 = arg_767_1:GetWordFromCfg(928041180)
				local var_770_7 = arg_767_1:FormatText(var_770_6.content)

				arg_767_1.text_.text = var_770_7

				LuaForUtil.ClearLinePrefixSymbol(arg_767_1.text_)

				local var_770_8 = 24
				local var_770_9 = utf8.len(var_770_7)
				local var_770_10 = var_770_8 <= 0 and var_770_5 or var_770_5 * (var_770_9 / var_770_8)

				if var_770_10 > 0 and var_770_5 < var_770_10 then
					arg_767_1.talkMaxDuration = var_770_10

					if var_770_10 + var_770_4 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_10 + var_770_4
					end
				end

				arg_767_1.text_.text = var_770_7
				arg_767_1.typewritter.percent = 0

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(false)
				arg_767_1:RecordContent(arg_767_1.text_.text)
			end

			local var_770_11 = math.max(var_770_5, arg_767_1.talkMaxDuration)

			if var_770_4 <= arg_767_1.time_ and arg_767_1.time_ < var_770_4 + var_770_11 then
				arg_767_1.typewritter.percent = (arg_767_1.time_ - var_770_4) / var_770_11

				arg_767_1.typewritter:SetDirty()
			end

			if arg_767_1.time_ >= var_770_4 + var_770_11 and arg_767_1.time_ < var_770_4 + var_770_11 + arg_770_0 then
				arg_767_1.typewritter.percent = 1

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(true)
			end
		end

		arg_767_1.nodeConfigList_ = {}

		arg_767_1:InitPlayNodeList()
	end,
	Play928041181 = function(arg_771_0, arg_771_1)
		arg_771_1.time_ = 0
		arg_771_1.frameCnt_ = 0
		arg_771_1.state_ = "playing"
		arg_771_1.curTalkId_ = 928041181
		arg_771_1.duration_ = 5

		SetActive(arg_771_1.tipsGo_, false)

		function arg_771_1.onSingleLineFinish_()
			arg_771_1.onSingleLineUpdate_ = nil
			arg_771_1.onSingleLineFinish_ = nil
			arg_771_1.state_ = "waiting"
			arg_771_1.auto_ = false
		end

		function arg_771_1.playNext_(arg_773_0)
			arg_771_1.onStoryFinished_()
		end

		function arg_771_1.onSingleLineUpdate_(arg_774_0)
			local var_774_0 = 0
			local var_774_1 = 0.575

			if var_774_0 < arg_771_1.time_ and arg_771_1.time_ <= var_774_0 + arg_774_0 then
				arg_771_1.talkMaxDuration = 0
				arg_771_1.dialogCg_.alpha = 1

				arg_771_1.dialog_:SetActive(true)
				SetActive(arg_771_1.leftNameGo_, false)

				arg_771_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_771_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_771_1:RecordName(arg_771_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_771_1.iconTrs_.gameObject, false)
				arg_771_1.callingController_:SetSelectedState("normal")

				local var_774_2 = arg_771_1:GetWordFromCfg(928041181)
				local var_774_3 = arg_771_1:FormatText(var_774_2.content)

				arg_771_1.text_.text = var_774_3

				LuaForUtil.ClearLinePrefixSymbol(arg_771_1.text_)

				local var_774_4 = 23
				local var_774_5 = utf8.len(var_774_3)
				local var_774_6 = var_774_4 <= 0 and var_774_1 or var_774_1 * (var_774_5 / var_774_4)

				if var_774_6 > 0 and var_774_1 < var_774_6 then
					arg_771_1.talkMaxDuration = var_774_6

					if var_774_6 + var_774_0 > arg_771_1.duration_ then
						arg_771_1.duration_ = var_774_6 + var_774_0
					end
				end

				arg_771_1.text_.text = var_774_3
				arg_771_1.typewritter.percent = 0

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(false)
				arg_771_1:RecordContent(arg_771_1.text_.text)
			end

			local var_774_7 = math.max(var_774_1, arg_771_1.talkMaxDuration)

			if var_774_0 <= arg_771_1.time_ and arg_771_1.time_ < var_774_0 + var_774_7 then
				arg_771_1.typewritter.percent = (arg_771_1.time_ - var_774_0) / var_774_7

				arg_771_1.typewritter:SetDirty()
			end

			if arg_771_1.time_ >= var_774_0 + var_774_7 and arg_771_1.time_ < var_774_0 + var_774_7 + arg_774_0 then
				arg_771_1.typewritter.percent = 1

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(true)
			end
		end

		arg_771_1.nodeConfigList_ = {}

		arg_771_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L16",
		"TextureConfig/Background/ST69",
		"TextureConfig/Background/X205_a",
		"TextureConfig/Background/X205_c",
		"TextureConfig/Background/X205_d",
		"TextureConfig/Background/ST0514",
		"TextureConfig/Background/SP92801",
		"SofdecAsset/story/story_9280501.usm",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST2201",
		"TextureConfig/Background/B13a"
	},
	voices = {
		"story_v_side_old_928041.awb"
	},
	skipMarkers = {
		928041144
	}
}
