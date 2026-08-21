return {
	Play112091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112091001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST08"

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
				local var_4_5 = arg_1_1.bgs_.ST08

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
					if iter_4_0 ~= "ST08" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_28 = 2
			local var_4_29 = 0.55

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_31 = arg_1_1:GetWordFromCfg(112091001)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 22
				local var_4_34 = utf8.len(var_4_32)
				local var_4_35 = var_4_33 <= 0 and var_4_29 or var_4_29 * (var_4_34 / var_4_33)

				if var_4_35 > 0 and var_4_29 < var_4_35 then
					arg_1_1.talkMaxDuration = var_4_35
					var_4_28 = var_4_28 + 0.3

					if var_4_35 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_32
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_28 + 0.3
			local var_4_37 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play112091002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 112091002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play112091003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.166666666666667

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "music"

				arg_8_1:AudioAction(var_11_2, var_11_3, "bgm_activity_1_2_1_summer2_story_2_1", "bgm_activity_1_2_1_summer2_story_2_1", "bgm_activity_1_2_1_summer2_story_2_1.awb")

				local var_11_4 = ""

				if var_11_4 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_4 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_4

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_4
						arg_8_1.bgmTxt2_.text = var_11_4
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_5 = 0.166666666666667
			local var_11_6 = 0.166666666666667

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 then
				local var_11_7 = "play"
				local var_11_8 = "music"

				arg_8_1:AudioAction(var_11_7, var_11_8, "bgm_activity_1_2_1_summer2_story_2_1", "init", "bgm_activity_1_2_1_summer2_story_2_1.awb")

				local var_11_9 = ""
				local var_11_10 = MusicRecordCfg[56].musicName

				if var_11_10 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_10 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_10

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_10
						arg_8_1.bgmTxt2_.text = var_11_10
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_11 = 0
			local var_11_12 = 1.05

			if var_11_11 < arg_8_1.time_ and arg_8_1.time_ <= var_11_11 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_13 = arg_8_1:GetWordFromCfg(112091002)
				local var_11_14 = arg_8_1:FormatText(var_11_13.content)

				arg_8_1.text_.text = var_11_14

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_15 = 42
				local var_11_16 = utf8.len(var_11_14)
				local var_11_17 = var_11_15 <= 0 and var_11_12 or var_11_12 * (var_11_16 / var_11_15)

				if var_11_17 > 0 and var_11_12 < var_11_17 then
					arg_8_1.talkMaxDuration = var_11_17

					if var_11_17 + var_11_11 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_17 + var_11_11
					end
				end

				arg_8_1.text_.text = var_11_14
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_18 = math.max(var_11_12, arg_8_1.talkMaxDuration)

			if var_11_11 <= arg_8_1.time_ and arg_8_1.time_ < var_11_11 + var_11_18 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_11) / var_11_18

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_11 + var_11_18 and arg_8_1.time_ < var_11_11 + var_11_18 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play112091003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 112091003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play112091004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0
			local var_17_1 = 1.025

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

				local var_17_2 = arg_14_1:GetWordFromCfg(112091003)
				local var_17_3 = arg_14_1:FormatText(var_17_2.content)

				arg_14_1.text_.text = var_17_3

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_4 = 41
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
	Play112091004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 112091004
		arg_18_1.duration_ = 2.07

		local var_18_0 = {
			ja = 2.066,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_18_0:Play112091005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = "1084ui_story"

			if arg_18_1.actors_[var_21_0] == nil then
				local var_21_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_21_1) then
					local var_21_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_18_1.stage_.transform)

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

			local var_21_5 = arg_18_1.actors_["1084ui_story"].transform
			local var_21_6 = 0

			if var_21_6 < arg_18_1.time_ and arg_18_1.time_ <= var_21_6 + arg_21_0 then
				arg_18_1.var_.moveOldPos1084ui_story = var_21_5.localPosition
			end

			local var_21_7 = 0.001

			if var_21_6 <= arg_18_1.time_ and arg_18_1.time_ < var_21_6 + var_21_7 then
				local var_21_8 = (arg_18_1.time_ - var_21_6) / var_21_7
				local var_21_9 = Vector3.New(0, -0.97, -6)

				var_21_5.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1084ui_story, var_21_9, var_21_8)

				local var_21_10 = manager.ui.mainCamera.transform.position - var_21_5.position

				var_21_5.forward = Vector3.New(var_21_10.x, var_21_10.y, var_21_10.z)

				local var_21_11 = var_21_5.localEulerAngles

				var_21_11.z = 0
				var_21_11.x = 0
				var_21_5.localEulerAngles = var_21_11
			end

			if arg_18_1.time_ >= var_21_6 + var_21_7 and arg_18_1.time_ < var_21_6 + var_21_7 + arg_21_0 then
				var_21_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_21_12 = manager.ui.mainCamera.transform.position - var_21_5.position

				var_21_5.forward = Vector3.New(var_21_12.x, var_21_12.y, var_21_12.z)

				local var_21_13 = var_21_5.localEulerAngles

				var_21_13.z = 0
				var_21_13.x = 0
				var_21_5.localEulerAngles = var_21_13
			end

			local var_21_14 = 0

			if var_21_14 < arg_18_1.time_ and arg_18_1.time_ <= var_21_14 + arg_21_0 then
				arg_18_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_21_15 = 0

			if var_21_15 < arg_18_1.time_ and arg_18_1.time_ <= var_21_15 + arg_21_0 then
				arg_18_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_21_16 = arg_18_1.actors_["1084ui_story"]
			local var_21_17 = 0

			if var_21_17 < arg_18_1.time_ and arg_18_1.time_ <= var_21_17 + arg_21_0 and not isNil(var_21_16) and arg_18_1.var_.characterEffect1084ui_story == nil then
				arg_18_1.var_.characterEffect1084ui_story = var_21_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_18 = 0.2

			if var_21_17 <= arg_18_1.time_ and arg_18_1.time_ < var_21_17 + var_21_18 and not isNil(var_21_16) then
				local var_21_19 = (arg_18_1.time_ - var_21_17) / var_21_18

				if arg_18_1.var_.characterEffect1084ui_story and not isNil(var_21_16) then
					arg_18_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= var_21_17 + var_21_18 and arg_18_1.time_ < var_21_17 + var_21_18 + arg_21_0 and not isNil(var_21_16) and arg_18_1.var_.characterEffect1084ui_story then
				arg_18_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_21_20 = 0
			local var_21_21 = 0.1

			if var_21_20 < arg_18_1.time_ and arg_18_1.time_ <= var_21_20 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_22 = arg_18_1:FormatText(StoryNameCfg[6].name)

				arg_18_1.leftNameTxt_.text = var_21_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_23 = arg_18_1:GetWordFromCfg(112091004)
				local var_21_24 = arg_18_1:FormatText(var_21_23.content)

				arg_18_1.text_.text = var_21_24

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_25 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091004", "story_v_out_112091.awb") ~= 0 then
					local var_21_28 = manager.audio:GetVoiceLength("story_v_out_112091", "112091004", "story_v_out_112091.awb") / 1000

					if var_21_28 + var_21_20 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_28 + var_21_20
					end

					if var_21_23.prefab_name ~= "" and arg_18_1.actors_[var_21_23.prefab_name] ~= nil then
						local var_21_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_23.prefab_name].transform, "story_v_out_112091", "112091004", "story_v_out_112091.awb")

						arg_18_1:RecordAudio("112091004", var_21_29)
						arg_18_1:RecordAudio("112091004", var_21_29)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_112091", "112091004", "story_v_out_112091.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_112091", "112091004", "story_v_out_112091.awb")
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
				actorName = "1084ui_story",
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
	Play112091005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 112091005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play112091006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1084ui_story"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1084ui_story == nil then
				arg_22_1.var_.characterEffect1084ui_story = var_25_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_2 = 0.2

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.characterEffect1084ui_story and not isNil(var_25_0) then
					local var_25_4 = Mathf.Lerp(0, 0.5, var_25_3)

					arg_22_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_22_1.var_.characterEffect1084ui_story.fillRatio = var_25_4
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1084ui_story then
				local var_25_5 = 0.5

				arg_22_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_22_1.var_.characterEffect1084ui_story.fillRatio = var_25_5
			end

			local var_25_6 = 0
			local var_25_7 = 0.275

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

				local var_25_9 = arg_22_1:GetWordFromCfg(112091005)
				local var_25_10 = arg_22_1:FormatText(var_25_9.content)

				arg_22_1.text_.text = var_25_10

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_11 = 11
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
	Play112091006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 112091006
		arg_26_1.duration_ = 5.2

		local var_26_0 = {
			ja = 5.2,
			ko = 3.766,
			zh = 3.666,
			en = 2.9
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
				arg_26_0:Play112091007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_29_1 = arg_26_1.actors_["1084ui_story"]
			local var_29_2 = 0

			if var_29_2 < arg_26_1.time_ and arg_26_1.time_ <= var_29_2 + arg_29_0 and not isNil(var_29_1) and arg_26_1.var_.characterEffect1084ui_story == nil then
				arg_26_1.var_.characterEffect1084ui_story = var_29_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_3 = 0.2

			if var_29_2 <= arg_26_1.time_ and arg_26_1.time_ < var_29_2 + var_29_3 and not isNil(var_29_1) then
				local var_29_4 = (arg_26_1.time_ - var_29_2) / var_29_3

				if arg_26_1.var_.characterEffect1084ui_story and not isNil(var_29_1) then
					arg_26_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_2 + var_29_3 and arg_26_1.time_ < var_29_2 + var_29_3 + arg_29_0 and not isNil(var_29_1) and arg_26_1.var_.characterEffect1084ui_story then
				arg_26_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_29_5 = 0
			local var_29_6 = 0.3

			if var_29_5 < arg_26_1.time_ and arg_26_1.time_ <= var_29_5 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_7 = arg_26_1:FormatText(StoryNameCfg[6].name)

				arg_26_1.leftNameTxt_.text = var_29_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_8 = arg_26_1:GetWordFromCfg(112091006)
				local var_29_9 = arg_26_1:FormatText(var_29_8.content)

				arg_26_1.text_.text = var_29_9

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_10 = 12
				local var_29_11 = utf8.len(var_29_9)
				local var_29_12 = var_29_10 <= 0 and var_29_6 or var_29_6 * (var_29_11 / var_29_10)

				if var_29_12 > 0 and var_29_6 < var_29_12 then
					arg_26_1.talkMaxDuration = var_29_12

					if var_29_12 + var_29_5 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_12 + var_29_5
					end
				end

				arg_26_1.text_.text = var_29_9
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091006", "story_v_out_112091.awb") ~= 0 then
					local var_29_13 = manager.audio:GetVoiceLength("story_v_out_112091", "112091006", "story_v_out_112091.awb") / 1000

					if var_29_13 + var_29_5 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_13 + var_29_5
					end

					if var_29_8.prefab_name ~= "" and arg_26_1.actors_[var_29_8.prefab_name] ~= nil then
						local var_29_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_8.prefab_name].transform, "story_v_out_112091", "112091006", "story_v_out_112091.awb")

						arg_26_1:RecordAudio("112091006", var_29_14)
						arg_26_1:RecordAudio("112091006", var_29_14)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_112091", "112091006", "story_v_out_112091.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_112091", "112091006", "story_v_out_112091.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_15 = math.max(var_29_6, arg_26_1.talkMaxDuration)

			if var_29_5 <= arg_26_1.time_ and arg_26_1.time_ < var_29_5 + var_29_15 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_5) / var_29_15

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_5 + var_29_15 and arg_26_1.time_ < var_29_5 + var_29_15 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play112091007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 112091007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play112091008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1084ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect1084ui_story == nil then
				arg_30_1.var_.characterEffect1084ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.2

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect1084ui_story and not isNil(var_33_0) then
					local var_33_4 = Mathf.Lerp(0, 0.5, var_33_3)

					arg_30_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_30_1.var_.characterEffect1084ui_story.fillRatio = var_33_4
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect1084ui_story then
				local var_33_5 = 0.5

				arg_30_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_30_1.var_.characterEffect1084ui_story.fillRatio = var_33_5
			end

			local var_33_6 = 0
			local var_33_7 = 0.35

			if var_33_6 < arg_30_1.time_ and arg_30_1.time_ <= var_33_6 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_8 = arg_30_1:FormatText(StoryNameCfg[7].name)

				arg_30_1.leftNameTxt_.text = var_33_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_9 = arg_30_1:GetWordFromCfg(112091007)
				local var_33_10 = arg_30_1:FormatText(var_33_9.content)

				arg_30_1.text_.text = var_33_10

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_11 = 14
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
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_14 = math.max(var_33_7, arg_30_1.talkMaxDuration)

			if var_33_6 <= arg_30_1.time_ and arg_30_1.time_ < var_33_6 + var_33_14 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_6) / var_33_14

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_6 + var_33_14 and arg_30_1.time_ < var_33_6 + var_33_14 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play112091008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 112091008
		arg_34_1.duration_ = 3.6

		local var_34_0 = {
			ja = 3.6,
			ko = 3.1,
			zh = 2.833,
			en = 3.466
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
				arg_34_0:Play112091009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_37_2 = arg_34_1.actors_["1084ui_story"]
			local var_37_3 = 0

			if var_37_3 < arg_34_1.time_ and arg_34_1.time_ <= var_37_3 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.characterEffect1084ui_story == nil then
				arg_34_1.var_.characterEffect1084ui_story = var_37_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_4 = 0.2

			if var_37_3 <= arg_34_1.time_ and arg_34_1.time_ < var_37_3 + var_37_4 and not isNil(var_37_2) then
				local var_37_5 = (arg_34_1.time_ - var_37_3) / var_37_4

				if arg_34_1.var_.characterEffect1084ui_story and not isNil(var_37_2) then
					arg_34_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_3 + var_37_4 and arg_34_1.time_ < var_37_3 + var_37_4 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.characterEffect1084ui_story then
				arg_34_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_37_6 = 0
			local var_37_7 = 0.3

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_8 = arg_34_1:FormatText(StoryNameCfg[6].name)

				arg_34_1.leftNameTxt_.text = var_37_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_9 = arg_34_1:GetWordFromCfg(112091008)
				local var_37_10 = arg_34_1:FormatText(var_37_9.content)

				arg_34_1.text_.text = var_37_10

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_11 = 12
				local var_37_12 = utf8.len(var_37_10)
				local var_37_13 = var_37_11 <= 0 and var_37_7 or var_37_7 * (var_37_12 / var_37_11)

				if var_37_13 > 0 and var_37_7 < var_37_13 then
					arg_34_1.talkMaxDuration = var_37_13

					if var_37_13 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_13 + var_37_6
					end
				end

				arg_34_1.text_.text = var_37_10
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091008", "story_v_out_112091.awb") ~= 0 then
					local var_37_14 = manager.audio:GetVoiceLength("story_v_out_112091", "112091008", "story_v_out_112091.awb") / 1000

					if var_37_14 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_14 + var_37_6
					end

					if var_37_9.prefab_name ~= "" and arg_34_1.actors_[var_37_9.prefab_name] ~= nil then
						local var_37_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_9.prefab_name].transform, "story_v_out_112091", "112091008", "story_v_out_112091.awb")

						arg_34_1:RecordAudio("112091008", var_37_15)
						arg_34_1:RecordAudio("112091008", var_37_15)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_112091", "112091008", "story_v_out_112091.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_112091", "112091008", "story_v_out_112091.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_16 = math.max(var_37_7, arg_34_1.talkMaxDuration)

			if var_37_6 <= arg_34_1.time_ and arg_34_1.time_ < var_37_6 + var_37_16 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_6) / var_37_16

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_6 + var_37_16 and arg_34_1.time_ < var_37_6 + var_37_16 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play112091009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 112091009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play112091010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1084ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1084ui_story == nil then
				arg_38_1.var_.characterEffect1084ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.2

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect1084ui_story and not isNil(var_41_0) then
					local var_41_4 = Mathf.Lerp(0, 0.5, var_41_3)

					arg_38_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1084ui_story.fillRatio = var_41_4
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1084ui_story then
				local var_41_5 = 0.5

				arg_38_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1084ui_story.fillRatio = var_41_5
			end

			local var_41_6 = 0
			local var_41_7 = 0.075

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_8 = arg_38_1:FormatText(StoryNameCfg[7].name)

				arg_38_1.leftNameTxt_.text = var_41_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_9 = arg_38_1:GetWordFromCfg(112091009)
				local var_41_10 = arg_38_1:FormatText(var_41_9.content)

				arg_38_1.text_.text = var_41_10

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 3
				local var_41_12 = utf8.len(var_41_10)
				local var_41_13 = var_41_11 <= 0 and var_41_7 or var_41_7 * (var_41_12 / var_41_11)

				if var_41_13 > 0 and var_41_7 < var_41_13 then
					arg_38_1.talkMaxDuration = var_41_13

					if var_41_13 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_10
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_14 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_14 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_14

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_14 and arg_38_1.time_ < var_41_6 + var_41_14 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play112091010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 112091010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play112091011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1084ui_story"].transform
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.var_.moveOldPos1084ui_story = var_45_0.localPosition
			end

			local var_45_2 = 0.001

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2
				local var_45_4 = Vector3.New(0, 100, 0)

				var_45_0.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1084ui_story, var_45_4, var_45_3)

				local var_45_5 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_5.x, var_45_5.y, var_45_5.z)

				local var_45_6 = var_45_0.localEulerAngles

				var_45_6.z = 0
				var_45_6.x = 0
				var_45_0.localEulerAngles = var_45_6
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 then
				var_45_0.localPosition = Vector3.New(0, 100, 0)

				local var_45_7 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_7.x, var_45_7.y, var_45_7.z)

				local var_45_8 = var_45_0.localEulerAngles

				var_45_8.z = 0
				var_45_8.x = 0
				var_45_0.localEulerAngles = var_45_8
			end

			local var_45_9 = 0
			local var_45_10 = 1.55

			if var_45_9 < arg_42_1.time_ and arg_42_1.time_ <= var_45_9 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_11 = arg_42_1:GetWordFromCfg(112091010)
				local var_45_12 = arg_42_1:FormatText(var_45_11.content)

				arg_42_1.text_.text = var_45_12

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_13 = 62
				local var_45_14 = utf8.len(var_45_12)
				local var_45_15 = var_45_13 <= 0 and var_45_10 or var_45_10 * (var_45_14 / var_45_13)

				if var_45_15 > 0 and var_45_10 < var_45_15 then
					arg_42_1.talkMaxDuration = var_45_15

					if var_45_15 + var_45_9 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_15 + var_45_9
					end
				end

				arg_42_1.text_.text = var_45_12
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_16 = math.max(var_45_10, arg_42_1.talkMaxDuration)

			if var_45_9 <= arg_42_1.time_ and arg_42_1.time_ < var_45_9 + var_45_16 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_9) / var_45_16

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_9 + var_45_16 and arg_42_1.time_ < var_45_9 + var_45_16 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play112091011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 112091011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play112091012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 1

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				local var_49_2 = "play"
				local var_49_3 = "music"

				arg_46_1:AudioAction(var_49_2, var_49_3, "bgm_activity_1_2_1_summer2_story_2_1", "1_2", "bgm_activity_1_2_1_summer2_story_2_1.awb")

				local var_49_4 = ""

				if var_49_4 ~= "" then
					if arg_46_1.bgmTxt_.text ~= var_49_4 and arg_46_1.bgmTxt_.text ~= "" then
						if arg_46_1.bgmTxt2_.text ~= "" then
							arg_46_1.bgmTxt_.text = arg_46_1.bgmTxt2_.text
						end

						arg_46_1.bgmTxt2_.text = var_49_4

						arg_46_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_46_1.bgmTxt_.text = var_49_4
						arg_46_1.bgmTxt2_.text = var_49_4
					end

					if arg_46_1.bgmTimer then
						arg_46_1.bgmTimer:Stop()

						arg_46_1.bgmTimer = nil
					end

					if arg_46_1.settingData.show_music_name == 1 then
						arg_46_1.musicController:SetSelectedState("show")
						arg_46_1.musicAnimator_:Play("open", 0, 0)

						if arg_46_1.settingData.music_time ~= 0 then
							arg_46_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_46_1.settingData.music_time), function()
								if arg_46_1 == nil or isNil(arg_46_1.bgmTxt_) then
									return
								end

								arg_46_1.musicController:SetSelectedState("hide")
								arg_46_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_49_5 = 0
			local var_49_6 = 0.25

			if var_49_5 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_7 = arg_46_1:FormatText(StoryNameCfg[7].name)

				arg_46_1.leftNameTxt_.text = var_49_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_8 = arg_46_1:GetWordFromCfg(112091011)
				local var_49_9 = arg_46_1:FormatText(var_49_8.content)

				arg_46_1.text_.text = var_49_9

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_10 = 10
				local var_49_11 = utf8.len(var_49_9)
				local var_49_12 = var_49_10 <= 0 and var_49_6 or var_49_6 * (var_49_11 / var_49_10)

				if var_49_12 > 0 and var_49_6 < var_49_12 then
					arg_46_1.talkMaxDuration = var_49_12

					if var_49_12 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_12 + var_49_5
					end
				end

				arg_46_1.text_.text = var_49_9
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_13 = math.max(var_49_6, arg_46_1.talkMaxDuration)

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_13 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_5) / var_49_13

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_5 + var_49_13 and arg_46_1.time_ < var_49_5 + var_49_13 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play112091012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 112091012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play112091013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.425

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_2 = arg_51_1:GetWordFromCfg(112091012)
				local var_54_3 = arg_51_1:FormatText(var_54_2.content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 17
				local var_54_5 = utf8.len(var_54_3)
				local var_54_6 = var_54_4 <= 0 and var_54_1 or var_54_1 * (var_54_5 / var_54_4)

				if var_54_6 > 0 and var_54_1 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_7 and arg_51_1.time_ < var_54_0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play112091013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 112091013
		arg_55_1.duration_ = 5.7

		local var_55_0 = {
			ja = 4.4,
			ko = 3.8,
			zh = 4.5,
			en = 5.7
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play112091014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = "1019ui_story"

			if arg_55_1.actors_[var_58_0] == nil then
				local var_58_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_58_1) then
					local var_58_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_55_1.stage_.transform)

					var_58_2.name = var_58_0
					var_58_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_55_1.actors_[var_58_0] = var_58_2

					local var_58_3 = var_58_2:GetComponentInChildren(typeof(CharacterEffect))

					var_58_3.enabled = true

					local var_58_4 = GameObjectTools.GetOrAddComponent(var_58_2, typeof(DynamicBoneHelper))

					if var_58_4 then
						var_58_4:EnableDynamicBone(false)
					end

					arg_55_1:ShowWeapon(var_58_3.transform, false)

					arg_55_1.var_[var_58_0 .. "Animator"] = var_58_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_55_1.var_[var_58_0 .. "Animator"].applyRootMotion = true
					arg_55_1.var_[var_58_0 .. "LipSync"] = var_58_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_58_5 = arg_55_1.actors_["1019ui_story"].transform
			local var_58_6 = 0

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.var_.moveOldPos1019ui_story = var_58_5.localPosition
			end

			local var_58_7 = 0.001

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_7 then
				local var_58_8 = (arg_55_1.time_ - var_58_6) / var_58_7
				local var_58_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_58_5.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1019ui_story, var_58_9, var_58_8)

				local var_58_10 = manager.ui.mainCamera.transform.position - var_58_5.position

				var_58_5.forward = Vector3.New(var_58_10.x, var_58_10.y, var_58_10.z)

				local var_58_11 = var_58_5.localEulerAngles

				var_58_11.z = 0
				var_58_11.x = 0
				var_58_5.localEulerAngles = var_58_11
			end

			if arg_55_1.time_ >= var_58_6 + var_58_7 and arg_55_1.time_ < var_58_6 + var_58_7 + arg_58_0 then
				var_58_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_58_12 = manager.ui.mainCamera.transform.position - var_58_5.position

				var_58_5.forward = Vector3.New(var_58_12.x, var_58_12.y, var_58_12.z)

				local var_58_13 = var_58_5.localEulerAngles

				var_58_13.z = 0
				var_58_13.x = 0
				var_58_5.localEulerAngles = var_58_13
			end

			local var_58_14 = 0

			if var_58_14 < arg_55_1.time_ and arg_55_1.time_ <= var_58_14 + arg_58_0 then
				arg_55_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_58_15 = 0

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 then
				arg_55_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_58_16 = arg_55_1.actors_["1019ui_story"]
			local var_58_17 = 0

			if var_58_17 < arg_55_1.time_ and arg_55_1.time_ <= var_58_17 + arg_58_0 and not isNil(var_58_16) and arg_55_1.var_.characterEffect1019ui_story == nil then
				arg_55_1.var_.characterEffect1019ui_story = var_58_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_18 = 0.2

			if var_58_17 <= arg_55_1.time_ and arg_55_1.time_ < var_58_17 + var_58_18 and not isNil(var_58_16) then
				local var_58_19 = (arg_55_1.time_ - var_58_17) / var_58_18

				if arg_55_1.var_.characterEffect1019ui_story and not isNil(var_58_16) then
					arg_55_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_17 + var_58_18 and arg_55_1.time_ < var_58_17 + var_58_18 + arg_58_0 and not isNil(var_58_16) and arg_55_1.var_.characterEffect1019ui_story then
				arg_55_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_58_20 = 0
			local var_58_21 = 0.5

			if var_58_20 < arg_55_1.time_ and arg_55_1.time_ <= var_58_20 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_22 = arg_55_1:FormatText(StoryNameCfg[13].name)

				arg_55_1.leftNameTxt_.text = var_58_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_23 = arg_55_1:GetWordFromCfg(112091013)
				local var_58_24 = arg_55_1:FormatText(var_58_23.content)

				arg_55_1.text_.text = var_58_24

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_25 = 20
				local var_58_26 = utf8.len(var_58_24)
				local var_58_27 = var_58_25 <= 0 and var_58_21 or var_58_21 * (var_58_26 / var_58_25)

				if var_58_27 > 0 and var_58_21 < var_58_27 then
					arg_55_1.talkMaxDuration = var_58_27

					if var_58_27 + var_58_20 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_27 + var_58_20
					end
				end

				arg_55_1.text_.text = var_58_24
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091013", "story_v_out_112091.awb") ~= 0 then
					local var_58_28 = manager.audio:GetVoiceLength("story_v_out_112091", "112091013", "story_v_out_112091.awb") / 1000

					if var_58_28 + var_58_20 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_28 + var_58_20
					end

					if var_58_23.prefab_name ~= "" and arg_55_1.actors_[var_58_23.prefab_name] ~= nil then
						local var_58_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_23.prefab_name].transform, "story_v_out_112091", "112091013", "story_v_out_112091.awb")

						arg_55_1:RecordAudio("112091013", var_58_29)
						arg_55_1:RecordAudio("112091013", var_58_29)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_112091", "112091013", "story_v_out_112091.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_112091", "112091013", "story_v_out_112091.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_30 = math.max(var_58_21, arg_55_1.talkMaxDuration)

			if var_58_20 <= arg_55_1.time_ and arg_55_1.time_ < var_58_20 + var_58_30 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_20) / var_58_30

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_20 + var_58_30 and arg_55_1.time_ < var_58_20 + var_58_30 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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

		arg_55_1:InitPlayNodeList()
	end,
	Play112091014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 112091014
		arg_59_1.duration_ = 3.57

		local var_59_0 = {
			ja = 3.566,
			ko = 3.133,
			zh = 3.033,
			en = 3.066
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play112091015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1019ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1019ui_story == nil then
				arg_59_1.var_.characterEffect1019ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.2

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1019ui_story and not isNil(var_62_0) then
					local var_62_4 = Mathf.Lerp(0, 0.5, var_62_3)

					arg_59_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1019ui_story.fillRatio = var_62_4
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1019ui_story then
				local var_62_5 = 0.5

				arg_59_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1019ui_story.fillRatio = var_62_5
			end

			local var_62_6 = 0
			local var_62_7 = 0.225

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_8 = arg_59_1:FormatText(StoryNameCfg[8].name)

				arg_59_1.leftNameTxt_.text = var_62_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_9 = arg_59_1:GetWordFromCfg(112091014)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 9
				local var_62_12 = utf8.len(var_62_10)
				local var_62_13 = var_62_11 <= 0 and var_62_7 or var_62_7 * (var_62_12 / var_62_11)

				if var_62_13 > 0 and var_62_7 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091014", "story_v_out_112091.awb") ~= 0 then
					local var_62_14 = manager.audio:GetVoiceLength("story_v_out_112091", "112091014", "story_v_out_112091.awb") / 1000

					if var_62_14 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_6
					end

					if var_62_9.prefab_name ~= "" and arg_59_1.actors_[var_62_9.prefab_name] ~= nil then
						local var_62_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_9.prefab_name].transform, "story_v_out_112091", "112091014", "story_v_out_112091.awb")

						arg_59_1:RecordAudio("112091014", var_62_15)
						arg_59_1:RecordAudio("112091014", var_62_15)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_112091", "112091014", "story_v_out_112091.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_112091", "112091014", "story_v_out_112091.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_16 and arg_59_1.time_ < var_62_6 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play112091015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 112091015
		arg_63_1.duration_ = 11.53

		local var_63_0 = {
			ja = 11.533,
			ko = 9.766,
			zh = 9.266,
			en = 11
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play112091016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_66_1 = arg_63_1.actors_["1019ui_story"]
			local var_66_2 = 0

			if var_66_2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1019ui_story == nil then
				arg_63_1.var_.characterEffect1019ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_3 = 0.2

			if var_66_2 <= arg_63_1.time_ and arg_63_1.time_ < var_66_2 + var_66_3 and not isNil(var_66_1) then
				local var_66_4 = (arg_63_1.time_ - var_66_2) / var_66_3

				if arg_63_1.var_.characterEffect1019ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_2 + var_66_3 and arg_63_1.time_ < var_66_2 + var_66_3 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1019ui_story then
				arg_63_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_66_5 = 0

			if var_66_5 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_66_6 = 0
			local var_66_7 = 1.1

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_8 = arg_63_1:FormatText(StoryNameCfg[13].name)

				arg_63_1.leftNameTxt_.text = var_66_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_9 = arg_63_1:GetWordFromCfg(112091015)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 44
				local var_66_12 = utf8.len(var_66_10)
				local var_66_13 = var_66_11 <= 0 and var_66_7 or var_66_7 * (var_66_12 / var_66_11)

				if var_66_13 > 0 and var_66_7 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_10
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091015", "story_v_out_112091.awb") ~= 0 then
					local var_66_14 = manager.audio:GetVoiceLength("story_v_out_112091", "112091015", "story_v_out_112091.awb") / 1000

					if var_66_14 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_6
					end

					if var_66_9.prefab_name ~= "" and arg_63_1.actors_[var_66_9.prefab_name] ~= nil then
						local var_66_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_9.prefab_name].transform, "story_v_out_112091", "112091015", "story_v_out_112091.awb")

						arg_63_1:RecordAudio("112091015", var_66_15)
						arg_63_1:RecordAudio("112091015", var_66_15)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_112091", "112091015", "story_v_out_112091.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_112091", "112091015", "story_v_out_112091.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_16 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_16 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_16

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_16 and arg_63_1.time_ < var_66_6 + var_66_16 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play112091016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 112091016
		arg_67_1.duration_ = 1.93

		local var_67_0 = {
			ja = 1,
			ko = 1.366,
			zh = 1.933,
			en = 1.7
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play112091017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1019ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1019ui_story == nil then
				arg_67_1.var_.characterEffect1019ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1019ui_story and not isNil(var_70_0) then
					local var_70_4 = Mathf.Lerp(0, 0.5, var_70_3)

					arg_67_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1019ui_story.fillRatio = var_70_4
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1019ui_story then
				local var_70_5 = 0.5

				arg_67_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1019ui_story.fillRatio = var_70_5
			end

			local var_70_6 = 0
			local var_70_7 = 0.075

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_8 = arg_67_1:FormatText(StoryNameCfg[8].name)

				arg_67_1.leftNameTxt_.text = var_70_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_9 = arg_67_1:GetWordFromCfg(112091016)
				local var_70_10 = arg_67_1:FormatText(var_70_9.content)

				arg_67_1.text_.text = var_70_10

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091016", "story_v_out_112091.awb") ~= 0 then
					local var_70_14 = manager.audio:GetVoiceLength("story_v_out_112091", "112091016", "story_v_out_112091.awb") / 1000

					if var_70_14 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_6
					end

					if var_70_9.prefab_name ~= "" and arg_67_1.actors_[var_70_9.prefab_name] ~= nil then
						local var_70_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_9.prefab_name].transform, "story_v_out_112091", "112091016", "story_v_out_112091.awb")

						arg_67_1:RecordAudio("112091016", var_70_15)
						arg_67_1:RecordAudio("112091016", var_70_15)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_112091", "112091016", "story_v_out_112091.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_112091", "112091016", "story_v_out_112091.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_16 and arg_67_1.time_ < var_70_6 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play112091017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 112091017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play112091018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1019ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1019ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, 100, 0)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1019ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, 100, 0)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = 0
			local var_74_10 = 0.6

			if var_74_9 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_11 = arg_71_1:GetWordFromCfg(112091017)
				local var_74_12 = arg_71_1:FormatText(var_74_11.content)

				arg_71_1.text_.text = var_74_12

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_13 = 24
				local var_74_14 = utf8.len(var_74_12)
				local var_74_15 = var_74_13 <= 0 and var_74_10 or var_74_10 * (var_74_14 / var_74_13)

				if var_74_15 > 0 and var_74_10 < var_74_15 then
					arg_71_1.talkMaxDuration = var_74_15

					if var_74_15 + var_74_9 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_15 + var_74_9
					end
				end

				arg_71_1.text_.text = var_74_12
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_16 = math.max(var_74_10, arg_71_1.talkMaxDuration)

			if var_74_9 <= arg_71_1.time_ and arg_71_1.time_ < var_74_9 + var_74_16 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_9) / var_74_16

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_9 + var_74_16 and arg_71_1.time_ < var_74_9 + var_74_16 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play112091018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 112091018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play112091019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 1

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				local var_78_2 = "play"
				local var_78_3 = "music"

				arg_75_1:AudioAction(var_78_2, var_78_3, "bgm_activity_1_2_1_summer2_story_2_1", "2_3", "bgm_activity_1_2_1_summer2_story_2_1.awb")

				local var_78_4 = ""

				if var_78_4 ~= "" then
					if arg_75_1.bgmTxt_.text ~= var_78_4 and arg_75_1.bgmTxt_.text ~= "" then
						if arg_75_1.bgmTxt2_.text ~= "" then
							arg_75_1.bgmTxt_.text = arg_75_1.bgmTxt2_.text
						end

						arg_75_1.bgmTxt2_.text = var_78_4

						arg_75_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_75_1.bgmTxt_.text = var_78_4
						arg_75_1.bgmTxt2_.text = var_78_4
					end

					if arg_75_1.bgmTimer then
						arg_75_1.bgmTimer:Stop()

						arg_75_1.bgmTimer = nil
					end

					if arg_75_1.settingData.show_music_name == 1 then
						arg_75_1.musicController:SetSelectedState("show")
						arg_75_1.musicAnimator_:Play("open", 0, 0)

						if arg_75_1.settingData.music_time ~= 0 then
							arg_75_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_75_1.settingData.music_time), function()
								if arg_75_1 == nil or isNil(arg_75_1.bgmTxt_) then
									return
								end

								arg_75_1.musicController:SetSelectedState("hide")
								arg_75_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_78_5 = 0
			local var_78_6 = 0.9

			if var_78_5 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_7 = arg_75_1:GetWordFromCfg(112091018)
				local var_78_8 = arg_75_1:FormatText(var_78_7.content)

				arg_75_1.text_.text = var_78_8

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 36
				local var_78_10 = utf8.len(var_78_8)
				local var_78_11 = var_78_9 <= 0 and var_78_6 or var_78_6 * (var_78_10 / var_78_9)

				if var_78_11 > 0 and var_78_6 < var_78_11 then
					arg_75_1.talkMaxDuration = var_78_11

					if var_78_11 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_11 + var_78_5
					end
				end

				arg_75_1.text_.text = var_78_8
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_12 = math.max(var_78_6, arg_75_1.talkMaxDuration)

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_12 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_5) / var_78_12

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_5 + var_78_12 and arg_75_1.time_ < var_78_5 + var_78_12 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play112091019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 112091019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play112091020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.1

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

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(112091019)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 4
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
	Play112091020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 112091020
		arg_84_1.duration_ = 6.7

		local var_84_0 = {
			ja = 6.333,
			ko = 5.6,
			zh = 6.7,
			en = 5.833
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
				arg_84_0:Play112091021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = "1081ui_story"

			if arg_84_1.actors_[var_87_0] == nil then
				local var_87_1 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_87_1) then
					local var_87_2 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_84_1.stage_.transform)

					var_87_2.name = var_87_0
					var_87_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_84_1.actors_[var_87_0] = var_87_2

					local var_87_3 = var_87_2:GetComponentInChildren(typeof(CharacterEffect))

					var_87_3.enabled = true

					local var_87_4 = GameObjectTools.GetOrAddComponent(var_87_2, typeof(DynamicBoneHelper))

					if var_87_4 then
						var_87_4:EnableDynamicBone(false)
					end

					arg_84_1:ShowWeapon(var_87_3.transform, false)

					arg_84_1.var_[var_87_0 .. "Animator"] = var_87_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_84_1.var_[var_87_0 .. "Animator"].applyRootMotion = true
					arg_84_1.var_[var_87_0 .. "LipSync"] = var_87_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_87_5 = arg_84_1.actors_["1081ui_story"].transform
			local var_87_6 = 0

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.var_.moveOldPos1081ui_story = var_87_5.localPosition
			end

			local var_87_7 = 0.001

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_7 then
				local var_87_8 = (arg_84_1.time_ - var_87_6) / var_87_7
				local var_87_9 = Vector3.New(0, -0.92, -5.8)

				var_87_5.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1081ui_story, var_87_9, var_87_8)

				local var_87_10 = manager.ui.mainCamera.transform.position - var_87_5.position

				var_87_5.forward = Vector3.New(var_87_10.x, var_87_10.y, var_87_10.z)

				local var_87_11 = var_87_5.localEulerAngles

				var_87_11.z = 0
				var_87_11.x = 0
				var_87_5.localEulerAngles = var_87_11
			end

			if arg_84_1.time_ >= var_87_6 + var_87_7 and arg_84_1.time_ < var_87_6 + var_87_7 + arg_87_0 then
				var_87_5.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_87_12 = manager.ui.mainCamera.transform.position - var_87_5.position

				var_87_5.forward = Vector3.New(var_87_12.x, var_87_12.y, var_87_12.z)

				local var_87_13 = var_87_5.localEulerAngles

				var_87_13.z = 0
				var_87_13.x = 0
				var_87_5.localEulerAngles = var_87_13
			end

			local var_87_14 = 0

			if var_87_14 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			local var_87_15 = 0

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_87_16 = arg_84_1.actors_["1081ui_story"]
			local var_87_17 = 0

			if var_87_17 < arg_84_1.time_ and arg_84_1.time_ <= var_87_17 + arg_87_0 and not isNil(var_87_16) and arg_84_1.var_.characterEffect1081ui_story == nil then
				arg_84_1.var_.characterEffect1081ui_story = var_87_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_18 = 0.2

			if var_87_17 <= arg_84_1.time_ and arg_84_1.time_ < var_87_17 + var_87_18 and not isNil(var_87_16) then
				local var_87_19 = (arg_84_1.time_ - var_87_17) / var_87_18

				if arg_84_1.var_.characterEffect1081ui_story and not isNil(var_87_16) then
					arg_84_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_17 + var_87_18 and arg_84_1.time_ < var_87_17 + var_87_18 + arg_87_0 and not isNil(var_87_16) and arg_84_1.var_.characterEffect1081ui_story then
				arg_84_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_87_20 = 0
			local var_87_21 = 0.65

			if var_87_20 < arg_84_1.time_ and arg_84_1.time_ <= var_87_20 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_22 = arg_84_1:FormatText(StoryNameCfg[202].name)

				arg_84_1.leftNameTxt_.text = var_87_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_23 = arg_84_1:GetWordFromCfg(112091020)
				local var_87_24 = arg_84_1:FormatText(var_87_23.content)

				arg_84_1.text_.text = var_87_24

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_25 = 26
				local var_87_26 = utf8.len(var_87_24)
				local var_87_27 = var_87_25 <= 0 and var_87_21 or var_87_21 * (var_87_26 / var_87_25)

				if var_87_27 > 0 and var_87_21 < var_87_27 then
					arg_84_1.talkMaxDuration = var_87_27

					if var_87_27 + var_87_20 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_27 + var_87_20
					end
				end

				arg_84_1.text_.text = var_87_24
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091020", "story_v_out_112091.awb") ~= 0 then
					local var_87_28 = manager.audio:GetVoiceLength("story_v_out_112091", "112091020", "story_v_out_112091.awb") / 1000

					if var_87_28 + var_87_20 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_28 + var_87_20
					end

					if var_87_23.prefab_name ~= "" and arg_84_1.actors_[var_87_23.prefab_name] ~= nil then
						local var_87_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_23.prefab_name].transform, "story_v_out_112091", "112091020", "story_v_out_112091.awb")

						arg_84_1:RecordAudio("112091020", var_87_29)
						arg_84_1:RecordAudio("112091020", var_87_29)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_112091", "112091020", "story_v_out_112091.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_112091", "112091020", "story_v_out_112091.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_30 = math.max(var_87_21, arg_84_1.talkMaxDuration)

			if var_87_20 <= arg_84_1.time_ and arg_84_1.time_ < var_87_20 + var_87_30 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_20) / var_87_30

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_20 + var_87_30 and arg_84_1.time_ < var_87_20 + var_87_30 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play112091021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 112091021
		arg_88_1.duration_ = 6.9

		local var_88_0 = {
			ja = 6.9,
			ko = 6,
			zh = 5.166,
			en = 4.566
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play112091022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			local var_91_2 = 0
			local var_91_3 = 0.475

			if var_91_2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_4 = arg_88_1:FormatText(StoryNameCfg[202].name)

				arg_88_1.leftNameTxt_.text = var_91_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_5 = arg_88_1:GetWordFromCfg(112091021)
				local var_91_6 = arg_88_1:FormatText(var_91_5.content)

				arg_88_1.text_.text = var_91_6

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 19
				local var_91_8 = utf8.len(var_91_6)
				local var_91_9 = var_91_7 <= 0 and var_91_3 or var_91_3 * (var_91_8 / var_91_7)

				if var_91_9 > 0 and var_91_3 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_6
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091021", "story_v_out_112091.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_112091", "112091021", "story_v_out_112091.awb") / 1000

					if var_91_10 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_2
					end

					if var_91_5.prefab_name ~= "" and arg_88_1.actors_[var_91_5.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_5.prefab_name].transform, "story_v_out_112091", "112091021", "story_v_out_112091.awb")

						arg_88_1:RecordAudio("112091021", var_91_11)
						arg_88_1:RecordAudio("112091021", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_112091", "112091021", "story_v_out_112091.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_112091", "112091021", "story_v_out_112091.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_3, arg_88_1.talkMaxDuration)

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_2) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_2 + var_91_12 and arg_88_1.time_ < var_91_2 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play112091022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 112091022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play112091023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			local var_95_1 = arg_92_1.actors_["1081ui_story"]
			local var_95_2 = 0

			if var_95_2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1081ui_story == nil then
				arg_92_1.var_.characterEffect1081ui_story = var_95_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_3 = 0.2

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_3 and not isNil(var_95_1) then
				local var_95_4 = (arg_92_1.time_ - var_95_2) / var_95_3

				if arg_92_1.var_.characterEffect1081ui_story and not isNil(var_95_1) then
					local var_95_5 = Mathf.Lerp(0, 0.5, var_95_4)

					arg_92_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1081ui_story.fillRatio = var_95_5
				end
			end

			if arg_92_1.time_ >= var_95_2 + var_95_3 and arg_92_1.time_ < var_95_2 + var_95_3 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1081ui_story then
				local var_95_6 = 0.5

				arg_92_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1081ui_story.fillRatio = var_95_6
			end

			local var_95_7 = 0
			local var_95_8 = 0.525

			if var_95_7 < arg_92_1.time_ and arg_92_1.time_ <= var_95_7 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_9 = arg_92_1:FormatText(StoryNameCfg[7].name)

				arg_92_1.leftNameTxt_.text = var_95_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_10 = arg_92_1:GetWordFromCfg(112091022)
				local var_95_11 = arg_92_1:FormatText(var_95_10.content)

				arg_92_1.text_.text = var_95_11

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_12 = 21
				local var_95_13 = utf8.len(var_95_11)
				local var_95_14 = var_95_12 <= 0 and var_95_8 or var_95_8 * (var_95_13 / var_95_12)

				if var_95_14 > 0 and var_95_8 < var_95_14 then
					arg_92_1.talkMaxDuration = var_95_14

					if var_95_14 + var_95_7 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_7
					end
				end

				arg_92_1.text_.text = var_95_11
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_15 = math.max(var_95_8, arg_92_1.talkMaxDuration)

			if var_95_7 <= arg_92_1.time_ and arg_92_1.time_ < var_95_7 + var_95_15 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_7) / var_95_15

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_7 + var_95_15 and arg_92_1.time_ < var_95_7 + var_95_15 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play112091023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 112091023
		arg_96_1.duration_ = 6.33

		local var_96_0 = {
			ja = 6.333,
			ko = 3.2,
			zh = 3.366,
			en = 4.166
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play112091024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.35

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[8].name)

				arg_96_1.leftNameTxt_.text = var_99_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:GetWordFromCfg(112091023)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 14
				local var_99_6 = utf8.len(var_99_4)
				local var_99_7 = var_99_5 <= 0 and var_99_1 or var_99_1 * (var_99_6 / var_99_5)

				if var_99_7 > 0 and var_99_1 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091023", "story_v_out_112091.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_112091", "112091023", "story_v_out_112091.awb") / 1000

					if var_99_8 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_0
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_112091", "112091023", "story_v_out_112091.awb")

						arg_96_1:RecordAudio("112091023", var_99_9)
						arg_96_1:RecordAudio("112091023", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_112091", "112091023", "story_v_out_112091.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_112091", "112091023", "story_v_out_112091.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_10 and arg_96_1.time_ < var_99_0 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play112091024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 112091024
		arg_100_1.duration_ = 11.77

		local var_100_0 = {
			ja = 11.766,
			ko = 10.933,
			zh = 11.533,
			en = 11.4
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play112091025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_103_2 = arg_100_1.actors_["1081ui_story"]
			local var_103_3 = 0

			if var_103_3 < arg_100_1.time_ and arg_100_1.time_ <= var_103_3 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect1081ui_story == nil then
				arg_100_1.var_.characterEffect1081ui_story = var_103_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_4 = 0.2

			if var_103_3 <= arg_100_1.time_ and arg_100_1.time_ < var_103_3 + var_103_4 and not isNil(var_103_2) then
				local var_103_5 = (arg_100_1.time_ - var_103_3) / var_103_4

				if arg_100_1.var_.characterEffect1081ui_story and not isNil(var_103_2) then
					arg_100_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_3 + var_103_4 and arg_100_1.time_ < var_103_3 + var_103_4 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect1081ui_story then
				arg_100_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_103_6 = 0
			local var_103_7 = 1.225

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[202].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_9 = arg_100_1:GetWordFromCfg(112091024)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 49
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

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091024", "story_v_out_112091.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_112091", "112091024", "story_v_out_112091.awb") / 1000

					if var_103_14 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_6
					end

					if var_103_9.prefab_name ~= "" and arg_100_1.actors_[var_103_9.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_9.prefab_name].transform, "story_v_out_112091", "112091024", "story_v_out_112091.awb")

						arg_100_1:RecordAudio("112091024", var_103_15)
						arg_100_1:RecordAudio("112091024", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_112091", "112091024", "story_v_out_112091.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_112091", "112091024", "story_v_out_112091.awb")
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
	Play112091025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 112091025
		arg_104_1.duration_ = 4.23

		local var_104_0 = {
			ja = 2.4,
			ko = 4.233,
			zh = 3.7,
			en = 3.1
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play112091026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = "1148ui_story"

			if arg_104_1.actors_[var_107_0] == nil then
				local var_107_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_107_1) then
					local var_107_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_104_1.stage_.transform)

					var_107_2.name = var_107_0
					var_107_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_104_1.actors_[var_107_0] = var_107_2

					local var_107_3 = var_107_2:GetComponentInChildren(typeof(CharacterEffect))

					var_107_3.enabled = true

					local var_107_4 = GameObjectTools.GetOrAddComponent(var_107_2, typeof(DynamicBoneHelper))

					if var_107_4 then
						var_107_4:EnableDynamicBone(false)
					end

					arg_104_1:ShowWeapon(var_107_3.transform, false)

					arg_104_1.var_[var_107_0 .. "Animator"] = var_107_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_104_1.var_[var_107_0 .. "Animator"].applyRootMotion = true
					arg_104_1.var_[var_107_0 .. "LipSync"] = var_107_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_107_5 = arg_104_1.actors_["1148ui_story"]
			local var_107_6 = 0

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 and not isNil(var_107_5) and arg_104_1.var_.characterEffect1148ui_story == nil then
				arg_104_1.var_.characterEffect1148ui_story = var_107_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_7 = 0.2

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_7 and not isNil(var_107_5) then
				local var_107_8 = (arg_104_1.time_ - var_107_6) / var_107_7

				if arg_104_1.var_.characterEffect1148ui_story and not isNil(var_107_5) then
					local var_107_9 = Mathf.Lerp(0, 0.5, var_107_8)

					arg_104_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1148ui_story.fillRatio = var_107_9
				end
			end

			if arg_104_1.time_ >= var_107_6 + var_107_7 and arg_104_1.time_ < var_107_6 + var_107_7 + arg_107_0 and not isNil(var_107_5) and arg_104_1.var_.characterEffect1148ui_story then
				local var_107_10 = 0.5

				arg_104_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1148ui_story.fillRatio = var_107_10
			end

			local var_107_11 = 0
			local var_107_12 = 0.325

			if var_107_11 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_13 = arg_104_1:FormatText(StoryNameCfg[8].name)

				arg_104_1.leftNameTxt_.text = var_107_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_14 = arg_104_1:GetWordFromCfg(112091025)
				local var_107_15 = arg_104_1:FormatText(var_107_14.content)

				arg_104_1.text_.text = var_107_15

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_16 = 13
				local var_107_17 = utf8.len(var_107_15)
				local var_107_18 = var_107_16 <= 0 and var_107_12 or var_107_12 * (var_107_17 / var_107_16)

				if var_107_18 > 0 and var_107_12 < var_107_18 then
					arg_104_1.talkMaxDuration = var_107_18

					if var_107_18 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_18 + var_107_11
					end
				end

				arg_104_1.text_.text = var_107_15
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091025", "story_v_out_112091.awb") ~= 0 then
					local var_107_19 = manager.audio:GetVoiceLength("story_v_out_112091", "112091025", "story_v_out_112091.awb") / 1000

					if var_107_19 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_19 + var_107_11
					end

					if var_107_14.prefab_name ~= "" and arg_104_1.actors_[var_107_14.prefab_name] ~= nil then
						local var_107_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_14.prefab_name].transform, "story_v_out_112091", "112091025", "story_v_out_112091.awb")

						arg_104_1:RecordAudio("112091025", var_107_20)
						arg_104_1:RecordAudio("112091025", var_107_20)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_112091", "112091025", "story_v_out_112091.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_112091", "112091025", "story_v_out_112091.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_21 = math.max(var_107_12, arg_104_1.talkMaxDuration)

			if var_107_11 <= arg_104_1.time_ and arg_104_1.time_ < var_107_11 + var_107_21 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_11) / var_107_21

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_11 + var_107_21 and arg_104_1.time_ < var_107_11 + var_107_21 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play112091026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 112091026
		arg_108_1.duration_ = 9.7

		local var_108_0 = {
			ja = 6.733,
			ko = 6.833,
			zh = 7.2,
			en = 9.7
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play112091027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1081ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1081ui_story = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(0, 100, 0)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1081ui_story, var_111_4, var_111_3)

				local var_111_5 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_5.x, var_111_5.y, var_111_5.z)

				local var_111_6 = var_111_0.localEulerAngles

				var_111_6.z = 0
				var_111_6.x = 0
				var_111_0.localEulerAngles = var_111_6
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0, 100, 0)

				local var_111_7 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_7.x, var_111_7.y, var_111_7.z)

				local var_111_8 = var_111_0.localEulerAngles

				var_111_8.z = 0
				var_111_8.x = 0
				var_111_0.localEulerAngles = var_111_8
			end

			local var_111_9 = arg_108_1.actors_["1019ui_story"].transform
			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 then
				arg_108_1.var_.moveOldPos1019ui_story = var_111_9.localPosition
			end

			local var_111_11 = 0.001

			if var_111_10 <= arg_108_1.time_ and arg_108_1.time_ < var_111_10 + var_111_11 then
				local var_111_12 = (arg_108_1.time_ - var_111_10) / var_111_11
				local var_111_13 = Vector3.New(-0.2, -1.08, -5.9)

				var_111_9.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1019ui_story, var_111_13, var_111_12)

				local var_111_14 = manager.ui.mainCamera.transform.position - var_111_9.position

				var_111_9.forward = Vector3.New(var_111_14.x, var_111_14.y, var_111_14.z)

				local var_111_15 = var_111_9.localEulerAngles

				var_111_15.z = 0
				var_111_15.x = 0
				var_111_9.localEulerAngles = var_111_15
			end

			if arg_108_1.time_ >= var_111_10 + var_111_11 and arg_108_1.time_ < var_111_10 + var_111_11 + arg_111_0 then
				var_111_9.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_111_16 = manager.ui.mainCamera.transform.position - var_111_9.position

				var_111_9.forward = Vector3.New(var_111_16.x, var_111_16.y, var_111_16.z)

				local var_111_17 = var_111_9.localEulerAngles

				var_111_17.z = 0
				var_111_17.x = 0
				var_111_9.localEulerAngles = var_111_17
			end

			local var_111_18 = 0

			if var_111_18 < arg_108_1.time_ and arg_108_1.time_ <= var_111_18 + arg_111_0 then
				arg_108_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_111_19 = 0

			if var_111_19 < arg_108_1.time_ and arg_108_1.time_ <= var_111_19 + arg_111_0 then
				arg_108_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_111_20 = arg_108_1.actors_["1019ui_story"]
			local var_111_21 = 0

			if var_111_21 < arg_108_1.time_ and arg_108_1.time_ <= var_111_21 + arg_111_0 and not isNil(var_111_20) and arg_108_1.var_.characterEffect1019ui_story == nil then
				arg_108_1.var_.characterEffect1019ui_story = var_111_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_22 = 0.2

			if var_111_21 <= arg_108_1.time_ and arg_108_1.time_ < var_111_21 + var_111_22 and not isNil(var_111_20) then
				local var_111_23 = (arg_108_1.time_ - var_111_21) / var_111_22

				if arg_108_1.var_.characterEffect1019ui_story and not isNil(var_111_20) then
					arg_108_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_21 + var_111_22 and arg_108_1.time_ < var_111_21 + var_111_22 + arg_111_0 and not isNil(var_111_20) and arg_108_1.var_.characterEffect1019ui_story then
				arg_108_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_111_24 = 0
			local var_111_25 = 0.9

			if var_111_24 < arg_108_1.time_ and arg_108_1.time_ <= var_111_24 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_26 = arg_108_1:FormatText(StoryNameCfg[13].name)

				arg_108_1.leftNameTxt_.text = var_111_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_27 = arg_108_1:GetWordFromCfg(112091026)
				local var_111_28 = arg_108_1:FormatText(var_111_27.content)

				arg_108_1.text_.text = var_111_28

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_29 = 36
				local var_111_30 = utf8.len(var_111_28)
				local var_111_31 = var_111_29 <= 0 and var_111_25 or var_111_25 * (var_111_30 / var_111_29)

				if var_111_31 > 0 and var_111_25 < var_111_31 then
					arg_108_1.talkMaxDuration = var_111_31

					if var_111_31 + var_111_24 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_31 + var_111_24
					end
				end

				arg_108_1.text_.text = var_111_28
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091026", "story_v_out_112091.awb") ~= 0 then
					local var_111_32 = manager.audio:GetVoiceLength("story_v_out_112091", "112091026", "story_v_out_112091.awb") / 1000

					if var_111_32 + var_111_24 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_32 + var_111_24
					end

					if var_111_27.prefab_name ~= "" and arg_108_1.actors_[var_111_27.prefab_name] ~= nil then
						local var_111_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_27.prefab_name].transform, "story_v_out_112091", "112091026", "story_v_out_112091.awb")

						arg_108_1:RecordAudio("112091026", var_111_33)
						arg_108_1:RecordAudio("112091026", var_111_33)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_112091", "112091026", "story_v_out_112091.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_112091", "112091026", "story_v_out_112091.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_34 = math.max(var_111_25, arg_108_1.talkMaxDuration)

			if var_111_24 <= arg_108_1.time_ and arg_108_1.time_ < var_111_24 + var_111_34 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_24) / var_111_34

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_24 + var_111_34 and arg_108_1.time_ < var_111_24 + var_111_34 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play112091027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 112091027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play112091028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1019ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1019ui_story == nil then
				arg_112_1.var_.characterEffect1019ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1019ui_story and not isNil(var_115_0) then
					local var_115_4 = Mathf.Lerp(0, 0.5, var_115_3)

					arg_112_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1019ui_story.fillRatio = var_115_4
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1019ui_story then
				local var_115_5 = 0.5

				arg_112_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1019ui_story.fillRatio = var_115_5
			end

			local var_115_6 = 0
			local var_115_7 = 1

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_8 = arg_112_1:GetWordFromCfg(112091027)
				local var_115_9 = arg_112_1:FormatText(var_115_8.content)

				arg_112_1.text_.text = var_115_9

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_10 = 40
				local var_115_11 = utf8.len(var_115_9)
				local var_115_12 = var_115_10 <= 0 and var_115_7 or var_115_7 * (var_115_11 / var_115_10)

				if var_115_12 > 0 and var_115_7 < var_115_12 then
					arg_112_1.talkMaxDuration = var_115_12

					if var_115_12 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_12 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_9
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_13 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_13 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_13

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_13 and arg_112_1.time_ < var_115_6 + var_115_13 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play112091028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 112091028
		arg_116_1.duration_ = 8.23

		local var_116_0 = {
			ja = 8,
			ko = 6.5,
			zh = 8.233,
			en = 6.4
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
				arg_116_0:Play112091029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_119_2 = arg_116_1.actors_["1019ui_story"]
			local var_119_3 = 0

			if var_119_3 < arg_116_1.time_ and arg_116_1.time_ <= var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect1019ui_story == nil then
				arg_116_1.var_.characterEffect1019ui_story = var_119_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_4 = 0.2

			if var_119_3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_3 + var_119_4 and not isNil(var_119_2) then
				local var_119_5 = (arg_116_1.time_ - var_119_3) / var_119_4

				if arg_116_1.var_.characterEffect1019ui_story and not isNil(var_119_2) then
					arg_116_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_3 + var_119_4 and arg_116_1.time_ < var_119_3 + var_119_4 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect1019ui_story then
				arg_116_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_119_6 = 0
			local var_119_7 = 0.575

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_8 = arg_116_1:FormatText(StoryNameCfg[13].name)

				arg_116_1.leftNameTxt_.text = var_119_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_9 = arg_116_1:GetWordFromCfg(112091028)
				local var_119_10 = arg_116_1:FormatText(var_119_9.content)

				arg_116_1.text_.text = var_119_10

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 23
				local var_119_12 = utf8.len(var_119_10)
				local var_119_13 = var_119_11 <= 0 and var_119_7 or var_119_7 * (var_119_12 / var_119_11)

				if var_119_13 > 0 and var_119_7 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_10
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091028", "story_v_out_112091.awb") ~= 0 then
					local var_119_14 = manager.audio:GetVoiceLength("story_v_out_112091", "112091028", "story_v_out_112091.awb") / 1000

					if var_119_14 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_6
					end

					if var_119_9.prefab_name ~= "" and arg_116_1.actors_[var_119_9.prefab_name] ~= nil then
						local var_119_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_9.prefab_name].transform, "story_v_out_112091", "112091028", "story_v_out_112091.awb")

						arg_116_1:RecordAudio("112091028", var_119_15)
						arg_116_1:RecordAudio("112091028", var_119_15)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_112091", "112091028", "story_v_out_112091.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_112091", "112091028", "story_v_out_112091.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_16 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_16 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_16

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_16 and arg_116_1.time_ < var_119_6 + var_119_16 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play112091029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 112091029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play112091030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1019ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1019ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(0, 100, 0)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1019ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0, 100, 0)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = 0
			local var_123_10 = 0.85

			if var_123_9 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_11 = arg_120_1:GetWordFromCfg(112091029)
				local var_123_12 = arg_120_1:FormatText(var_123_11.content)

				arg_120_1.text_.text = var_123_12

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_13 = 34
				local var_123_14 = utf8.len(var_123_12)
				local var_123_15 = var_123_13 <= 0 and var_123_10 or var_123_10 * (var_123_14 / var_123_13)

				if var_123_15 > 0 and var_123_10 < var_123_15 then
					arg_120_1.talkMaxDuration = var_123_15

					if var_123_15 + var_123_9 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_15 + var_123_9
					end
				end

				arg_120_1.text_.text = var_123_12
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_16 = math.max(var_123_10, arg_120_1.talkMaxDuration)

			if var_123_9 <= arg_120_1.time_ and arg_120_1.time_ < var_123_9 + var_123_16 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_9) / var_123_16

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_9 + var_123_16 and arg_120_1.time_ < var_123_9 + var_123_16 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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

		arg_120_1:InitPlayNodeList()
	end,
	Play112091030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 112091030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play112091031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 1

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				local var_127_2 = "play"
				local var_127_3 = "music"

				arg_124_1:AudioAction(var_127_2, var_127_3, "bgm_activity_1_2_1_summer2_story_2_1", "3_4", "bgm_activity_1_2_1_summer2_story_2_1.awb")

				local var_127_4 = ""

				if var_127_4 ~= "" then
					if arg_124_1.bgmTxt_.text ~= var_127_4 and arg_124_1.bgmTxt_.text ~= "" then
						if arg_124_1.bgmTxt2_.text ~= "" then
							arg_124_1.bgmTxt_.text = arg_124_1.bgmTxt2_.text
						end

						arg_124_1.bgmTxt2_.text = var_127_4

						arg_124_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_124_1.bgmTxt_.text = var_127_4
						arg_124_1.bgmTxt2_.text = var_127_4
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

			local var_127_5 = 0
			local var_127_6 = 0.125

			if var_127_5 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_7 = arg_124_1:FormatText(StoryNameCfg[7].name)

				arg_124_1.leftNameTxt_.text = var_127_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_8 = arg_124_1:GetWordFromCfg(112091030)
				local var_127_9 = arg_124_1:FormatText(var_127_8.content)

				arg_124_1.text_.text = var_127_9

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_10 = 5
				local var_127_11 = utf8.len(var_127_9)
				local var_127_12 = var_127_10 <= 0 and var_127_6 or var_127_6 * (var_127_11 / var_127_10)

				if var_127_12 > 0 and var_127_6 < var_127_12 then
					arg_124_1.talkMaxDuration = var_127_12

					if var_127_12 + var_127_5 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_5
					end
				end

				arg_124_1.text_.text = var_127_9
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_13 = math.max(var_127_6, arg_124_1.talkMaxDuration)

			if var_127_5 <= arg_124_1.time_ and arg_124_1.time_ < var_127_5 + var_127_13 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_5) / var_127_13

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_5 + var_127_13 and arg_124_1.time_ < var_127_5 + var_127_13 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play112091031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 112091031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play112091032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.925

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(112091031)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 37
				local var_132_5 = utf8.len(var_132_3)
				local var_132_6 = var_132_4 <= 0 and var_132_1 or var_132_1 * (var_132_5 / var_132_4)

				if var_132_6 > 0 and var_132_1 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_7 and arg_129_1.time_ < var_132_0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play112091032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 112091032
		arg_133_1.duration_ = 4.8

		local var_133_0 = {
			ja = 4.8,
			ko = 3.633,
			zh = 3.333,
			en = 4.633
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
				arg_133_0:Play112091033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1019ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1019ui_story = var_136_0.localPosition
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1019ui_story, var_136_4, var_136_3)

				local var_136_5 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_5.x, var_136_5.y, var_136_5.z)

				local var_136_6 = var_136_0.localEulerAngles

				var_136_6.z = 0
				var_136_6.x = 0
				var_136_0.localEulerAngles = var_136_6
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_136_7 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_7.x, var_136_7.y, var_136_7.z)

				local var_136_8 = var_136_0.localEulerAngles

				var_136_8.z = 0
				var_136_8.x = 0
				var_136_0.localEulerAngles = var_136_8
			end

			local var_136_9 = 0

			if var_136_9 < arg_133_1.time_ and arg_133_1.time_ <= var_136_9 + arg_136_0 then
				arg_133_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_136_11 = arg_133_1.actors_["1019ui_story"]
			local var_136_12 = 0

			if var_136_12 < arg_133_1.time_ and arg_133_1.time_ <= var_136_12 + arg_136_0 and not isNil(var_136_11) and arg_133_1.var_.characterEffect1019ui_story == nil then
				arg_133_1.var_.characterEffect1019ui_story = var_136_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_13 = 0.2

			if var_136_12 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_13 and not isNil(var_136_11) then
				local var_136_14 = (arg_133_1.time_ - var_136_12) / var_136_13

				if arg_133_1.var_.characterEffect1019ui_story and not isNil(var_136_11) then
					arg_133_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_12 + var_136_13 and arg_133_1.time_ < var_136_12 + var_136_13 + arg_136_0 and not isNil(var_136_11) and arg_133_1.var_.characterEffect1019ui_story then
				arg_133_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_136_15 = 0
			local var_136_16 = 0.35

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_17 = arg_133_1:FormatText(StoryNameCfg[13].name)

				arg_133_1.leftNameTxt_.text = var_136_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_18 = arg_133_1:GetWordFromCfg(112091032)
				local var_136_19 = arg_133_1:FormatText(var_136_18.content)

				arg_133_1.text_.text = var_136_19

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_20 = 14
				local var_136_21 = utf8.len(var_136_19)
				local var_136_22 = var_136_20 <= 0 and var_136_16 or var_136_16 * (var_136_21 / var_136_20)

				if var_136_22 > 0 and var_136_16 < var_136_22 then
					arg_133_1.talkMaxDuration = var_136_22

					if var_136_22 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_22 + var_136_15
					end
				end

				arg_133_1.text_.text = var_136_19
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091032", "story_v_out_112091.awb") ~= 0 then
					local var_136_23 = manager.audio:GetVoiceLength("story_v_out_112091", "112091032", "story_v_out_112091.awb") / 1000

					if var_136_23 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_23 + var_136_15
					end

					if var_136_18.prefab_name ~= "" and arg_133_1.actors_[var_136_18.prefab_name] ~= nil then
						local var_136_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_18.prefab_name].transform, "story_v_out_112091", "112091032", "story_v_out_112091.awb")

						arg_133_1:RecordAudio("112091032", var_136_24)
						arg_133_1:RecordAudio("112091032", var_136_24)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_112091", "112091032", "story_v_out_112091.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_112091", "112091032", "story_v_out_112091.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_25 = math.max(var_136_16, arg_133_1.talkMaxDuration)

			if var_136_15 <= arg_133_1.time_ and arg_133_1.time_ < var_136_15 + var_136_25 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_15) / var_136_25

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_15 + var_136_25 and arg_133_1.time_ < var_136_15 + var_136_25 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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

		arg_133_1:InitPlayNodeList()
	end,
	Play112091033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 112091033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play112091034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1019ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1019ui_story == nil then
				arg_137_1.var_.characterEffect1019ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1019ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1019ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1019ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1019ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0
			local var_140_7 = 0.4

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_8 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_9 = arg_137_1:GetWordFromCfg(112091033)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 16
				local var_140_12 = utf8.len(var_140_10)
				local var_140_13 = var_140_11 <= 0 and var_140_7 or var_140_7 * (var_140_12 / var_140_11)

				if var_140_13 > 0 and var_140_7 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_10
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play112091034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 112091034
		arg_141_1.duration_ = 5.9

		local var_141_0 = {
			ja = 5.9,
			ko = 5.466,
			zh = 4.266,
			en = 5.433
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play112091035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_144_2 = arg_141_1.actors_["1019ui_story"]
			local var_144_3 = 0

			if var_144_3 < arg_141_1.time_ and arg_141_1.time_ <= var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1019ui_story == nil then
				arg_141_1.var_.characterEffect1019ui_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_4 = 0.2

			if var_144_3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_3 + var_144_4 and not isNil(var_144_2) then
				local var_144_5 = (arg_141_1.time_ - var_144_3) / var_144_4

				if arg_141_1.var_.characterEffect1019ui_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_3 + var_144_4 and arg_141_1.time_ < var_144_3 + var_144_4 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1019ui_story then
				arg_141_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_144_6 = 0
			local var_144_7 = 0.65

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_8 = arg_141_1:FormatText(StoryNameCfg[13].name)

				arg_141_1.leftNameTxt_.text = var_144_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_9 = arg_141_1:GetWordFromCfg(112091034)
				local var_144_10 = arg_141_1:FormatText(var_144_9.content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 26
				local var_144_12 = utf8.len(var_144_10)
				local var_144_13 = var_144_11 <= 0 and var_144_7 or var_144_7 * (var_144_12 / var_144_11)

				if var_144_13 > 0 and var_144_7 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_10
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091034", "story_v_out_112091.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_out_112091", "112091034", "story_v_out_112091.awb") / 1000

					if var_144_14 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_6
					end

					if var_144_9.prefab_name ~= "" and arg_141_1.actors_[var_144_9.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_9.prefab_name].transform, "story_v_out_112091", "112091034", "story_v_out_112091.awb")

						arg_141_1:RecordAudio("112091034", var_144_15)
						arg_141_1:RecordAudio("112091034", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_112091", "112091034", "story_v_out_112091.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_112091", "112091034", "story_v_out_112091.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_16 and arg_141_1.time_ < var_144_6 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play112091035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 112091035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play112091036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1019ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1019ui_story == nil then
				arg_145_1.var_.characterEffect1019ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect1019ui_story and not isNil(var_148_0) then
					local var_148_4 = Mathf.Lerp(0, 0.5, var_148_3)

					arg_145_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1019ui_story.fillRatio = var_148_4
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1019ui_story then
				local var_148_5 = 0.5

				arg_145_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1019ui_story.fillRatio = var_148_5
			end

			local var_148_6 = 0
			local var_148_7 = 0.975

			if var_148_6 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_8 = arg_145_1:GetWordFromCfg(112091035)
				local var_148_9 = arg_145_1:FormatText(var_148_8.content)

				arg_145_1.text_.text = var_148_9

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_10 = 39
				local var_148_11 = utf8.len(var_148_9)
				local var_148_12 = var_148_10 <= 0 and var_148_7 or var_148_7 * (var_148_11 / var_148_10)

				if var_148_12 > 0 and var_148_7 < var_148_12 then
					arg_145_1.talkMaxDuration = var_148_12

					if var_148_12 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_12 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_9
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_13 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_13 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_13

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_13 and arg_145_1.time_ < var_148_6 + var_148_13 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play112091036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 112091036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play112091037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.5

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

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(112091036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 20
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
	Play112091037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 112091037
		arg_153_1.duration_ = 8.63

		local var_153_0 = {
			ja = 6.333,
			ko = 7.466,
			zh = 7.366,
			en = 8.633
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
				arg_153_0:Play112091038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_156_1 = arg_153_1.actors_["1019ui_story"]
			local var_156_2 = 0

			if var_156_2 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1019ui_story == nil then
				arg_153_1.var_.characterEffect1019ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.2

			if var_156_2 <= arg_153_1.time_ and arg_153_1.time_ < var_156_2 + var_156_3 and not isNil(var_156_1) then
				local var_156_4 = (arg_153_1.time_ - var_156_2) / var_156_3

				if arg_153_1.var_.characterEffect1019ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_2 + var_156_3 and arg_153_1.time_ < var_156_2 + var_156_3 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1019ui_story then
				arg_153_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_156_5 = 0
			local var_156_6 = 0.85

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_7 = arg_153_1:FormatText(StoryNameCfg[13].name)

				arg_153_1.leftNameTxt_.text = var_156_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_8 = arg_153_1:GetWordFromCfg(112091037)
				local var_156_9 = arg_153_1:FormatText(var_156_8.content)

				arg_153_1.text_.text = var_156_9

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 34
				local var_156_11 = utf8.len(var_156_9)
				local var_156_12 = var_156_10 <= 0 and var_156_6 or var_156_6 * (var_156_11 / var_156_10)

				if var_156_12 > 0 and var_156_6 < var_156_12 then
					arg_153_1.talkMaxDuration = var_156_12

					if var_156_12 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_12 + var_156_5
					end
				end

				arg_153_1.text_.text = var_156_9
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091037", "story_v_out_112091.awb") ~= 0 then
					local var_156_13 = manager.audio:GetVoiceLength("story_v_out_112091", "112091037", "story_v_out_112091.awb") / 1000

					if var_156_13 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_5
					end

					if var_156_8.prefab_name ~= "" and arg_153_1.actors_[var_156_8.prefab_name] ~= nil then
						local var_156_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_8.prefab_name].transform, "story_v_out_112091", "112091037", "story_v_out_112091.awb")

						arg_153_1:RecordAudio("112091037", var_156_14)
						arg_153_1:RecordAudio("112091037", var_156_14)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_112091", "112091037", "story_v_out_112091.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_112091", "112091037", "story_v_out_112091.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_15 = math.max(var_156_6, arg_153_1.talkMaxDuration)

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_15 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_5) / var_156_15

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_5 + var_156_15 and arg_153_1.time_ < var_156_5 + var_156_15 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play112091038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 112091038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play112091039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1019ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1019ui_story == nil then
				arg_157_1.var_.characterEffect1019ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1019ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1019ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1019ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1019ui_story.fillRatio = var_160_5
			end

			local var_160_6 = 0
			local var_160_7 = 0.85

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

				local var_160_9 = arg_157_1:GetWordFromCfg(112091038)
				local var_160_10 = arg_157_1:FormatText(var_160_9.content)

				arg_157_1.text_.text = var_160_10

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_11 = 34
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
	Play112091039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 112091039
		arg_161_1.duration_ = 7.7

		local var_161_0 = {
			ja = 7.366,
			ko = 6.133,
			zh = 7.133,
			en = 7.7
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play112091040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action453")
			end

			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_164_2 = arg_161_1.actors_["1019ui_story"]
			local var_164_3 = 0

			if var_164_3 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.characterEffect1019ui_story == nil then
				arg_161_1.var_.characterEffect1019ui_story = var_164_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_4 = 0.2

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_4 and not isNil(var_164_2) then
				local var_164_5 = (arg_161_1.time_ - var_164_3) / var_164_4

				if arg_161_1.var_.characterEffect1019ui_story and not isNil(var_164_2) then
					arg_161_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_3 + var_164_4 and arg_161_1.time_ < var_164_3 + var_164_4 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.characterEffect1019ui_story then
				arg_161_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_164_6 = 0
			local var_164_7 = 0.475

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_8 = arg_161_1:FormatText(StoryNameCfg[13].name)

				arg_161_1.leftNameTxt_.text = var_164_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_9 = arg_161_1:GetWordFromCfg(112091039)
				local var_164_10 = arg_161_1:FormatText(var_164_9.content)

				arg_161_1.text_.text = var_164_10

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 19
				local var_164_12 = utf8.len(var_164_10)
				local var_164_13 = var_164_11 <= 0 and var_164_7 or var_164_7 * (var_164_12 / var_164_11)

				if var_164_13 > 0 and var_164_7 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_10
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091039", "story_v_out_112091.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_112091", "112091039", "story_v_out_112091.awb") / 1000

					if var_164_14 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_6
					end

					if var_164_9.prefab_name ~= "" and arg_161_1.actors_[var_164_9.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_9.prefab_name].transform, "story_v_out_112091", "112091039", "story_v_out_112091.awb")

						arg_161_1:RecordAudio("112091039", var_164_15)
						arg_161_1:RecordAudio("112091039", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_112091", "112091039", "story_v_out_112091.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_112091", "112091039", "story_v_out_112091.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_16 and arg_161_1.time_ < var_164_6 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play112091040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 112091040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play112091041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1019ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1019ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(0, 100, 0)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1019ui_story, var_168_4, var_168_3)

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
			local var_168_10 = 1.525

			if var_168_9 < arg_165_1.time_ and arg_165_1.time_ <= var_168_9 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_11 = arg_165_1:GetWordFromCfg(112091040)
				local var_168_12 = arg_165_1:FormatText(var_168_11.content)

				arg_165_1.text_.text = var_168_12

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 61
				local var_168_14 = utf8.len(var_168_12)
				local var_168_15 = var_168_13 <= 0 and var_168_10 or var_168_10 * (var_168_14 / var_168_13)

				if var_168_15 > 0 and var_168_10 < var_168_15 then
					arg_165_1.talkMaxDuration = var_168_15

					if var_168_15 + var_168_9 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_9
					end
				end

				arg_165_1.text_.text = var_168_12
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = math.max(var_168_10, arg_165_1.talkMaxDuration)

			if var_168_9 <= arg_165_1.time_ and arg_165_1.time_ < var_168_9 + var_168_16 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_9) / var_168_16

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_9 + var_168_16 and arg_165_1.time_ < var_168_9 + var_168_16 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play112091041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 112091041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play112091042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = manager.ui.mainCamera.transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.shakeOldPos = var_172_0.localPosition
			end

			local var_172_2 = 0.6

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / 0.066
				local var_172_4, var_172_5 = math.modf(var_172_3)

				var_172_0.localPosition = Vector3.New(var_172_5 * 0.13, var_172_5 * 0.13, var_172_5 * 0.13) + arg_169_1.var_.shakeOldPos
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = arg_169_1.var_.shakeOldPos
			end

			local var_172_6 = 0
			local var_172_7 = 1

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				local var_172_8 = "play"
				local var_172_9 = "music"

				arg_169_1:AudioAction(var_172_8, var_172_9, "bgm_activity_1_2_1_summer2_story_2_1", "4_5", "bgm_activity_1_2_1_summer2_story_2_1.awb")

				local var_172_10 = ""

				if var_172_10 ~= "" then
					if arg_169_1.bgmTxt_.text ~= var_172_10 and arg_169_1.bgmTxt_.text ~= "" then
						if arg_169_1.bgmTxt2_.text ~= "" then
							arg_169_1.bgmTxt_.text = arg_169_1.bgmTxt2_.text
						end

						arg_169_1.bgmTxt2_.text = var_172_10

						arg_169_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_169_1.bgmTxt_.text = var_172_10
						arg_169_1.bgmTxt2_.text = var_172_10
					end

					if arg_169_1.bgmTimer then
						arg_169_1.bgmTimer:Stop()

						arg_169_1.bgmTimer = nil
					end

					if arg_169_1.settingData.show_music_name == 1 then
						arg_169_1.musicController:SetSelectedState("show")
						arg_169_1.musicAnimator_:Play("open", 0, 0)

						if arg_169_1.settingData.music_time ~= 0 then
							arg_169_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_169_1.settingData.music_time), function()
								if arg_169_1 == nil or isNil(arg_169_1.bgmTxt_) then
									return
								end

								arg_169_1.musicController:SetSelectedState("hide")
								arg_169_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_172_11 = 0
			local var_172_12 = 0.325

			if var_172_11 < arg_169_1.time_ and arg_169_1.time_ <= var_172_11 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_13 = arg_169_1:FormatText(StoryNameCfg[7].name)

				arg_169_1.leftNameTxt_.text = var_172_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_14 = arg_169_1:GetWordFromCfg(112091041)
				local var_172_15 = arg_169_1:FormatText(var_172_14.content)

				arg_169_1.text_.text = var_172_15

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_16 = 13
				local var_172_17 = utf8.len(var_172_15)
				local var_172_18 = var_172_16 <= 0 and var_172_12 or var_172_12 * (var_172_17 / var_172_16)

				if var_172_18 > 0 and var_172_12 < var_172_18 then
					arg_169_1.talkMaxDuration = var_172_18

					if var_172_18 + var_172_11 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_18 + var_172_11
					end
				end

				arg_169_1.text_.text = var_172_15
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_19 = math.max(var_172_12, arg_169_1.talkMaxDuration)

			if var_172_11 <= arg_169_1.time_ and arg_169_1.time_ < var_172_11 + var_172_19 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_11) / var_172_19

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_11 + var_172_19 and arg_169_1.time_ < var_172_11 + var_172_19 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play112091042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 112091042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play112091043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.bgs_.ST08.transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPosST08 = var_177_0.localPosition
			end

			local var_177_2 = 2

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2
				local var_177_4 = Vector3.New(0, 1, 9.5)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPosST08, var_177_4, var_177_3)
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_177_5 = 0

			if var_177_5 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 then
				arg_174_1.allBtn_.enabled = false
			end

			local var_177_6 = 2

			if arg_174_1.time_ >= var_177_5 + var_177_6 and arg_174_1.time_ < var_177_5 + var_177_6 + arg_177_0 then
				arg_174_1.allBtn_.enabled = true
			end

			local var_177_7 = 0
			local var_177_8 = 0.6

			if var_177_7 < arg_174_1.time_ and arg_174_1.time_ <= var_177_7 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_9 = arg_174_1:GetWordFromCfg(112091042)
				local var_177_10 = arg_174_1:FormatText(var_177_9.content)

				arg_174_1.text_.text = var_177_10

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_11 = 24
				local var_177_12 = utf8.len(var_177_10)
				local var_177_13 = var_177_11 <= 0 and var_177_8 or var_177_8 * (var_177_12 / var_177_11)

				if var_177_13 > 0 and var_177_8 < var_177_13 then
					arg_174_1.talkMaxDuration = var_177_13

					if var_177_13 + var_177_7 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_13 + var_177_7
					end
				end

				arg_174_1.text_.text = var_177_10
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_14 = math.max(var_177_8, arg_174_1.talkMaxDuration)

			if var_177_7 <= arg_174_1.time_ and arg_174_1.time_ < var_177_7 + var_177_14 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_7) / var_177_14

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_7 + var_177_14 and arg_174_1.time_ < var_177_7 + var_177_14 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST08",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play112091043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 112091043
		arg_178_1.duration_ = 11.47

		local var_178_0 = {
			ja = 11.066,
			ko = 10.966,
			zh = 9.533,
			en = 11.466
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play112091044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1019ui_story"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos1019ui_story = var_181_0.localPosition
			end

			local var_181_2 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2
				local var_181_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1019ui_story, var_181_4, var_181_3)

				local var_181_5 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_5.x, var_181_5.y, var_181_5.z)

				local var_181_6 = var_181_0.localEulerAngles

				var_181_6.z = 0
				var_181_6.x = 0
				var_181_0.localEulerAngles = var_181_6
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_181_7 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_7.x, var_181_7.y, var_181_7.z)

				local var_181_8 = var_181_0.localEulerAngles

				var_181_8.z = 0
				var_181_8.x = 0
				var_181_0.localEulerAngles = var_181_8
			end

			local var_181_9 = 0

			if var_181_9 < arg_178_1.time_ and arg_178_1.time_ <= var_181_9 + arg_181_0 then
				arg_178_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_181_10 = 0

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 then
				arg_178_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_181_11 = arg_178_1.actors_["1019ui_story"]
			local var_181_12 = 0

			if var_181_12 < arg_178_1.time_ and arg_178_1.time_ <= var_181_12 + arg_181_0 and not isNil(var_181_11) and arg_178_1.var_.characterEffect1019ui_story == nil then
				arg_178_1.var_.characterEffect1019ui_story = var_181_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_13 = 0.2

			if var_181_12 <= arg_178_1.time_ and arg_178_1.time_ < var_181_12 + var_181_13 and not isNil(var_181_11) then
				local var_181_14 = (arg_178_1.time_ - var_181_12) / var_181_13

				if arg_178_1.var_.characterEffect1019ui_story and not isNil(var_181_11) then
					arg_178_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_12 + var_181_13 and arg_178_1.time_ < var_181_12 + var_181_13 + arg_181_0 and not isNil(var_181_11) and arg_178_1.var_.characterEffect1019ui_story then
				arg_178_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_181_15 = 0
			local var_181_16 = 0.875

			if var_181_15 < arg_178_1.time_ and arg_178_1.time_ <= var_181_15 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_17 = arg_178_1:FormatText(StoryNameCfg[13].name)

				arg_178_1.leftNameTxt_.text = var_181_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_18 = arg_178_1:GetWordFromCfg(112091043)
				local var_181_19 = arg_178_1:FormatText(var_181_18.content)

				arg_178_1.text_.text = var_181_19

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_20 = 35
				local var_181_21 = utf8.len(var_181_19)
				local var_181_22 = var_181_20 <= 0 and var_181_16 or var_181_16 * (var_181_21 / var_181_20)

				if var_181_22 > 0 and var_181_16 < var_181_22 then
					arg_178_1.talkMaxDuration = var_181_22

					if var_181_22 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_22 + var_181_15
					end
				end

				arg_178_1.text_.text = var_181_19
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091043", "story_v_out_112091.awb") ~= 0 then
					local var_181_23 = manager.audio:GetVoiceLength("story_v_out_112091", "112091043", "story_v_out_112091.awb") / 1000

					if var_181_23 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_23 + var_181_15
					end

					if var_181_18.prefab_name ~= "" and arg_178_1.actors_[var_181_18.prefab_name] ~= nil then
						local var_181_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_18.prefab_name].transform, "story_v_out_112091", "112091043", "story_v_out_112091.awb")

						arg_178_1:RecordAudio("112091043", var_181_24)
						arg_178_1:RecordAudio("112091043", var_181_24)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_112091", "112091043", "story_v_out_112091.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_112091", "112091043", "story_v_out_112091.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_25 = math.max(var_181_16, arg_178_1.talkMaxDuration)

			if var_181_15 <= arg_178_1.time_ and arg_178_1.time_ < var_181_15 + var_181_25 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_15) / var_181_25

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_15 + var_181_25 and arg_178_1.time_ < var_181_15 + var_181_25 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
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

		arg_178_1:InitPlayNodeList()
	end,
	Play112091044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 112091044
		arg_182_1.duration_ = 3.43

		local var_182_0 = {
			ja = 3.433,
			ko = 2.6,
			zh = 2.333,
			en = 2.833
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play112091045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_185_1 = 0
			local var_185_2 = 0.175

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_3 = arg_182_1:FormatText(StoryNameCfg[13].name)

				arg_182_1.leftNameTxt_.text = var_185_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_4 = arg_182_1:GetWordFromCfg(112091044)
				local var_185_5 = arg_182_1:FormatText(var_185_4.content)

				arg_182_1.text_.text = var_185_5

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_6 = 7
				local var_185_7 = utf8.len(var_185_5)
				local var_185_8 = var_185_6 <= 0 and var_185_2 or var_185_2 * (var_185_7 / var_185_6)

				if var_185_8 > 0 and var_185_2 < var_185_8 then
					arg_182_1.talkMaxDuration = var_185_8

					if var_185_8 + var_185_1 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_1
					end
				end

				arg_182_1.text_.text = var_185_5
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091044", "story_v_out_112091.awb") ~= 0 then
					local var_185_9 = manager.audio:GetVoiceLength("story_v_out_112091", "112091044", "story_v_out_112091.awb") / 1000

					if var_185_9 + var_185_1 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_1
					end

					if var_185_4.prefab_name ~= "" and arg_182_1.actors_[var_185_4.prefab_name] ~= nil then
						local var_185_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_4.prefab_name].transform, "story_v_out_112091", "112091044", "story_v_out_112091.awb")

						arg_182_1:RecordAudio("112091044", var_185_10)
						arg_182_1:RecordAudio("112091044", var_185_10)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_112091", "112091044", "story_v_out_112091.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_112091", "112091044", "story_v_out_112091.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_11 = math.max(var_185_2, arg_182_1.talkMaxDuration)

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_11 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_1) / var_185_11

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_1 + var_185_11 and arg_182_1.time_ < var_185_1 + var_185_11 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play112091045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 112091045
		arg_186_1.duration_ = 7

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play112091046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.bgs_.ST08
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				local var_189_2 = var_189_0:GetComponent("SpriteRenderer")

				if var_189_2 then
					arg_186_1.var_.alphaOldValueST08 = var_189_2.color.a
					arg_186_1.var_.alphaMatValueST08 = var_189_2
				end

				arg_186_1.var_.alphaOldValueST08 = 1
			end

			local var_189_3 = 2

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_3 then
				local var_189_4 = (arg_186_1.time_ - var_189_1) / var_189_3
				local var_189_5 = Mathf.Lerp(arg_186_1.var_.alphaOldValueST08, 0, var_189_4)

				if arg_186_1.var_.alphaMatValueST08 then
					local var_189_6 = arg_186_1.var_.alphaMatValueST08.color

					var_189_6.a = var_189_5
					arg_186_1.var_.alphaMatValueST08.color = var_189_6
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_3 and arg_186_1.time_ < var_189_1 + var_189_3 + arg_189_0 and arg_186_1.var_.alphaMatValueST08 then
				local var_189_7 = arg_186_1.var_.alphaMatValueST08
				local var_189_8 = var_189_7.color

				var_189_8.a = 0
				var_189_7.color = var_189_8
			end

			local var_189_9 = arg_186_1.actors_["1019ui_story"].transform
			local var_189_10 = 0

			if var_189_10 < arg_186_1.time_ and arg_186_1.time_ <= var_189_10 + arg_189_0 then
				arg_186_1.var_.moveOldPos1019ui_story = var_189_9.localPosition
			end

			local var_189_11 = 0.001

			if var_189_10 <= arg_186_1.time_ and arg_186_1.time_ < var_189_10 + var_189_11 then
				local var_189_12 = (arg_186_1.time_ - var_189_10) / var_189_11
				local var_189_13 = Vector3.New(0, 100, 0)

				var_189_9.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1019ui_story, var_189_13, var_189_12)

				local var_189_14 = manager.ui.mainCamera.transform.position - var_189_9.position

				var_189_9.forward = Vector3.New(var_189_14.x, var_189_14.y, var_189_14.z)

				local var_189_15 = var_189_9.localEulerAngles

				var_189_15.z = 0
				var_189_15.x = 0
				var_189_9.localEulerAngles = var_189_15
			end

			if arg_186_1.time_ >= var_189_10 + var_189_11 and arg_186_1.time_ < var_189_10 + var_189_11 + arg_189_0 then
				var_189_9.localPosition = Vector3.New(0, 100, 0)

				local var_189_16 = manager.ui.mainCamera.transform.position - var_189_9.position

				var_189_9.forward = Vector3.New(var_189_16.x, var_189_16.y, var_189_16.z)

				local var_189_17 = var_189_9.localEulerAngles

				var_189_17.z = 0
				var_189_17.x = 0
				var_189_9.localEulerAngles = var_189_17
			end

			if arg_186_1.frameCnt_ <= 1 then
				arg_186_1.dialog_:SetActive(false)
			end

			local var_189_18 = 2
			local var_189_19 = 1.05

			if var_189_18 < arg_186_1.time_ and arg_186_1.time_ <= var_189_18 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0

				arg_186_1.dialog_:SetActive(true)

				arg_186_1.dialogCg_.alpha = 0

				local var_189_20 = LeanTween.value(arg_186_1.dialog_, 0, 1, 0.3)

				var_189_20:setOnUpdate(LuaHelper.FloatAction(function(arg_190_0)
					arg_186_1.dialogCg_.alpha = arg_190_0
				end))
				var_189_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_186_1.dialog_)
					var_189_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_186_1.duration_ = arg_186_1.duration_ + 0.3

				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_21 = arg_186_1:GetWordFromCfg(112091045)
				local var_189_22 = arg_186_1:FormatText(var_189_21.content)

				arg_186_1.text_.text = var_189_22

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_23 = 42
				local var_189_24 = utf8.len(var_189_22)
				local var_189_25 = var_189_23 <= 0 and var_189_19 or var_189_19 * (var_189_24 / var_189_23)

				if var_189_25 > 0 and var_189_19 < var_189_25 then
					arg_186_1.talkMaxDuration = var_189_25
					var_189_18 = var_189_18 + 0.3

					if var_189_25 + var_189_18 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_25 + var_189_18
					end
				end

				arg_186_1.text_.text = var_189_22
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_26 = var_189_18 + 0.3
			local var_189_27 = math.max(var_189_19, arg_186_1.talkMaxDuration)

			if var_189_26 <= arg_186_1.time_ and arg_186_1.time_ < var_189_26 + var_189_27 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_26) / var_189_27

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_26 + var_189_27 and arg_186_1.time_ < var_189_26 + var_189_27 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
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

		arg_186_1:InitPlayNodeList()
	end,
	Play112091046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 112091046
		arg_192_1.duration_ = 7

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play112091047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = "SA0103"

			if arg_192_1.bgs_[var_195_0] == nil then
				local var_195_1 = Object.Instantiate(arg_192_1.paintGo_)

				var_195_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_195_0)
				var_195_1.name = var_195_0
				var_195_1.transform.parent = arg_192_1.stage_.transform
				var_195_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.bgs_[var_195_0] = var_195_1
			end

			local var_195_2 = 0

			if var_195_2 < arg_192_1.time_ and arg_192_1.time_ <= var_195_2 + arg_195_0 then
				local var_195_3 = manager.ui.mainCamera.transform.localPosition
				local var_195_4 = Vector3.New(0, 0, 10) + Vector3.New(var_195_3.x, var_195_3.y, 0)
				local var_195_5 = arg_192_1.bgs_.SA0103

				var_195_5.transform.localPosition = var_195_4
				var_195_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_195_6 = var_195_5:GetComponent("SpriteRenderer")

				if var_195_6 and var_195_6.sprite then
					local var_195_7 = (var_195_5.transform.localPosition - var_195_3).z
					local var_195_8 = manager.ui.mainCameraCom_
					local var_195_9 = 2 * var_195_7 * Mathf.Tan(var_195_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_195_10 = var_195_9 * var_195_8.aspect
					local var_195_11 = var_195_6.sprite.bounds.size.x
					local var_195_12 = var_195_6.sprite.bounds.size.y
					local var_195_13 = var_195_10 / var_195_11
					local var_195_14 = var_195_9 / var_195_12
					local var_195_15 = var_195_14 < var_195_13 and var_195_13 or var_195_14

					var_195_5.transform.localScale = Vector3.New(var_195_15, var_195_15, 0)
				end

				for iter_195_0, iter_195_1 in pairs(arg_192_1.bgs_) do
					if iter_195_0 ~= "SA0103" then
						iter_195_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_195_16 = 0

			if var_195_16 < arg_192_1.time_ and arg_192_1.time_ <= var_195_16 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_17 = 2

			if var_195_16 <= arg_192_1.time_ and arg_192_1.time_ < var_195_16 + var_195_17 then
				local var_195_18 = (arg_192_1.time_ - var_195_16) / var_195_17
				local var_195_19 = Color.New(0, 0, 0)

				var_195_19.a = Mathf.Lerp(1, 0, var_195_18)
				arg_192_1.mask_.color = var_195_19
			end

			if arg_192_1.time_ >= var_195_16 + var_195_17 and arg_192_1.time_ < var_195_16 + var_195_17 + arg_195_0 then
				local var_195_20 = Color.New(0, 0, 0)
				local var_195_21 = 0

				arg_192_1.mask_.enabled = false
				var_195_20.a = var_195_21
				arg_192_1.mask_.color = var_195_20
			end

			local var_195_22 = arg_192_1.bgs_.SA0103.transform
			local var_195_23 = 0

			if var_195_23 < arg_192_1.time_ and arg_192_1.time_ <= var_195_23 + arg_195_0 then
				arg_192_1.var_.moveOldPosSA0103 = var_195_22.localPosition
			end

			local var_195_24 = 0.1

			if var_195_23 <= arg_192_1.time_ and arg_192_1.time_ < var_195_23 + var_195_24 then
				local var_195_25 = (arg_192_1.time_ - var_195_23) / var_195_24
				local var_195_26 = Vector3.New(0, 1, 9.5)

				var_195_22.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPosSA0103, var_195_26, var_195_25)
			end

			if arg_192_1.time_ >= var_195_23 + var_195_24 and arg_192_1.time_ < var_195_23 + var_195_24 + arg_195_0 then
				var_195_22.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_195_27 = arg_192_1.bgs_.SA0103.transform
			local var_195_28 = 0.1

			if var_195_28 < arg_192_1.time_ and arg_192_1.time_ <= var_195_28 + arg_195_0 then
				arg_192_1.var_.moveOldPosSA0103 = var_195_27.localPosition
			end

			local var_195_29 = 2.825

			if var_195_28 <= arg_192_1.time_ and arg_192_1.time_ < var_195_28 + var_195_29 then
				local var_195_30 = (arg_192_1.time_ - var_195_28) / var_195_29
				local var_195_31 = Vector3.New(0, 1, 10)

				var_195_27.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPosSA0103, var_195_31, var_195_30)
			end

			if arg_192_1.time_ >= var_195_28 + var_195_29 and arg_192_1.time_ < var_195_28 + var_195_29 + arg_195_0 then
				var_195_27.localPosition = Vector3.New(0, 1, 10)
			end

			local var_195_32 = 0
			local var_195_33 = 1

			if var_195_32 < arg_192_1.time_ and arg_192_1.time_ <= var_195_32 + arg_195_0 then
				local var_195_34 = "play"
				local var_195_35 = "effect"

				arg_192_1:AudioAction(var_195_34, var_195_35, "se_story_activity_1_2_1", "se_story_activity_1_2_1_waves", "")
			end

			local var_195_36 = 0
			local var_195_37 = 1

			if var_195_36 < arg_192_1.time_ and arg_192_1.time_ <= var_195_36 + arg_195_0 then
				local var_195_38 = "play"
				local var_195_39 = "music"

				arg_192_1:AudioAction(var_195_38, var_195_39, "bgm_activity_1_2_1_summer2_story_2_1_wave", "bgm_activity_1_2_1_summer2_story_2_1_wave", "bgm_activity_1_2_1_summer2_story_2_1_wave.awb")

				local var_195_40 = ""
				local var_195_41 = manager.audio:GetAudioName("bgm_activity_1_2_1_summer2_story_2_1_wave", "bgm_activity_1_2_1_summer2_story_2_1_wave")

				if var_195_41 ~= "" then
					if arg_192_1.bgmTxt_.text ~= var_195_41 and arg_192_1.bgmTxt_.text ~= "" then
						if arg_192_1.bgmTxt2_.text ~= "" then
							arg_192_1.bgmTxt_.text = arg_192_1.bgmTxt2_.text
						end

						arg_192_1.bgmTxt2_.text = var_195_41

						arg_192_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_192_1.bgmTxt_.text = var_195_41
						arg_192_1.bgmTxt2_.text = var_195_41
					end

					if arg_192_1.bgmTimer then
						arg_192_1.bgmTimer:Stop()

						arg_192_1.bgmTimer = nil
					end

					if arg_192_1.settingData.show_music_name == 1 then
						arg_192_1.musicController:SetSelectedState("show")
						arg_192_1.musicAnimator_:Play("open", 0, 0)

						if arg_192_1.settingData.music_time ~= 0 then
							arg_192_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_192_1.settingData.music_time), function()
								if arg_192_1 == nil or isNil(arg_192_1.bgmTxt_) then
									return
								end

								arg_192_1.musicController:SetSelectedState("hide")
								arg_192_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_42 = 2
			local var_195_43 = 0.925

			if var_195_42 < arg_192_1.time_ and arg_192_1.time_ <= var_195_42 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_44 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_44:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_192_1.dialogCg_.alpha = arg_197_0
				end))
				var_195_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_45 = arg_192_1:GetWordFromCfg(112091046)
				local var_195_46 = arg_192_1:FormatText(var_195_45.content)

				arg_192_1.text_.text = var_195_46

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_47 = 37
				local var_195_48 = utf8.len(var_195_46)
				local var_195_49 = var_195_47 <= 0 and var_195_43 or var_195_43 * (var_195_48 / var_195_47)

				if var_195_49 > 0 and var_195_43 < var_195_49 then
					arg_192_1.talkMaxDuration = var_195_49
					var_195_42 = var_195_42 + 0.3

					if var_195_49 + var_195_42 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_49 + var_195_42
					end
				end

				arg_192_1.text_.text = var_195_46
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_50 = var_195_42 + 0.3
			local var_195_51 = math.max(var_195_43, arg_192_1.talkMaxDuration)

			if var_195_50 <= arg_192_1.time_ and arg_192_1.time_ < var_195_50 + var_195_51 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_50) / var_195_51

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_50 + var_195_51 and arg_192_1.time_ < var_195_50 + var_195_51 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SA0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SA0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.825,
				className = "StoryMoveNode",
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play112091047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 112091047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play112091048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.425

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_2 = arg_199_1:GetWordFromCfg(112091047)
				local var_202_3 = arg_199_1:FormatText(var_202_2.content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 17
				local var_202_5 = utf8.len(var_202_3)
				local var_202_6 = var_202_4 <= 0 and var_202_1 or var_202_1 * (var_202_5 / var_202_4)

				if var_202_6 > 0 and var_202_1 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_7 and arg_199_1.time_ < var_202_0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play112091048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 112091048
		arg_203_1.duration_ = 2.3

		local var_203_0 = {
			ja = 2.3,
			ko = 1.766,
			zh = 1.033,
			en = 2.133
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
				arg_203_0:Play112091049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.125

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[202].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:GetWordFromCfg(112091048)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 5
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_1 or var_206_1 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_1 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112091", "112091048", "story_v_out_112091.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_112091", "112091048", "story_v_out_112091.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_112091", "112091048", "story_v_out_112091.awb")

						arg_203_1:RecordAudio("112091048", var_206_9)
						arg_203_1:RecordAudio("112091048", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_112091", "112091048", "story_v_out_112091.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_112091", "112091048", "story_v_out_112091.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_10 and arg_203_1.time_ < var_206_0 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play112091049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 112091049
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play112091050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 1

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				local var_210_2 = "play"
				local var_210_3 = "effect"

				arg_207_1:AudioAction(var_210_2, var_210_3, "se_story_activity_1_2_1", "se_story_activity_1_2_1_accelerate", "")
			end

			local var_210_4 = 0
			local var_210_5 = 0.875

			if var_210_4 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_6 = arg_207_1:GetWordFromCfg(112091049)
				local var_210_7 = arg_207_1:FormatText(var_210_6.content)

				arg_207_1.text_.text = var_210_7

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_8 = 35
				local var_210_9 = utf8.len(var_210_7)
				local var_210_10 = var_210_8 <= 0 and var_210_5 or var_210_5 * (var_210_9 / var_210_8)

				if var_210_10 > 0 and var_210_5 < var_210_10 then
					arg_207_1.talkMaxDuration = var_210_10

					if var_210_10 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_7
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_11 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_11 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_11

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_11 and arg_207_1.time_ < var_210_4 + var_210_11 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play112091050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 112091050
		arg_211_1.duration_ = 7

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play112091051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.mask_.enabled = true
				arg_211_1.mask_.raycastTarget = false

				arg_211_1:SetGaussion(false)
			end

			local var_214_1 = 2

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_1 then
				local var_214_2 = (arg_211_1.time_ - var_214_0) / var_214_1
				local var_214_3 = Color.New(1, 1, 1)

				var_214_3.a = Mathf.Lerp(1, 0, var_214_2)
				arg_211_1.mask_.color = var_214_3
			end

			if arg_211_1.time_ >= var_214_0 + var_214_1 and arg_211_1.time_ < var_214_0 + var_214_1 + arg_214_0 then
				local var_214_4 = Color.New(1, 1, 1)
				local var_214_5 = 0

				arg_211_1.mask_.enabled = false
				var_214_4.a = var_214_5
				arg_211_1.mask_.color = var_214_4
			end

			local var_214_6 = 2
			local var_214_7 = 0.775

			if var_214_6 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_8 = arg_211_1:GetWordFromCfg(112091050)
				local var_214_9 = arg_211_1:FormatText(var_214_8.content)

				arg_211_1.text_.text = var_214_9

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_10 = 31
				local var_214_11 = utf8.len(var_214_9)
				local var_214_12 = var_214_10 <= 0 and var_214_7 or var_214_7 * (var_214_11 / var_214_10)

				if var_214_12 > 0 and var_214_7 < var_214_12 then
					arg_211_1.talkMaxDuration = var_214_12

					if var_214_12 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_12 + var_214_6
					end
				end

				arg_211_1.text_.text = var_214_9
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_13 = math.max(var_214_7, arg_211_1.talkMaxDuration)

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_13 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_6) / var_214_13

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_6 + var_214_13 and arg_211_1.time_ < var_214_6 + var_214_13 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play112091051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 112091051
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play112091052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 1.35

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(112091051)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 54
				local var_218_5 = utf8.len(var_218_3)
				local var_218_6 = var_218_4 <= 0 and var_218_1 or var_218_1 * (var_218_5 / var_218_4)

				if var_218_6 > 0 and var_218_1 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_7 and arg_215_1.time_ < var_218_0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play112091052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 112091052
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
			arg_219_1.auto_ = false
		end

		function arg_219_1.playNext_(arg_221_0)
			arg_219_1.onStoryFinished_()
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.55

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(112091052)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 22
				local var_222_5 = utf8.len(var_222_3)
				local var_222_6 = var_222_4 <= 0 and var_222_1 or var_222_1 * (var_222_5 / var_222_4)

				if var_222_6 > 0 and var_222_1 < var_222_6 then
					arg_219_1.talkMaxDuration = var_222_6

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_7 and arg_219_1.time_ < var_222_0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST08",
		"TextureConfig/Background/SA0103"
	},
	voices = {
		"story_v_out_112091.awb"
	}
}
