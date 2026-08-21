return {
	Play121012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121012001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play121012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J02f"

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
				local var_4_5 = arg_1_1.bgs_.J02f

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
					if iter_4_0 ~= "J02f" then
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

			local var_4_22 = 2
			local var_4_23 = 0.333333333333333

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_121_00", "se_story_121_00_slam", "")
			end

			local var_4_26 = 0
			local var_4_27 = 0.133333333333333

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "music"

				arg_1_1:AudioAction(var_4_28, var_4_29, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_30 = ""
				local var_4_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_31 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_31 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_31

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_31
						arg_1_1.bgmTxt2_.text = var_4_31
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

			local var_4_32 = 0.566666666666667
			local var_4_33 = 0.966666666666669

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

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

			local var_4_38 = manager.ui.mainCamera.transform
			local var_4_39 = 1

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_38.localPosition
			end

			local var_4_40 = 1

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / 0.066
				local var_4_42, var_4_43 = math.modf(var_4_41)

				var_4_38.localPosition = Vector3.New(var_4_43 * 0.13, var_4_43 * 0.13, var_4_43 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				var_4_38.localPosition = arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_44 = 2
			local var_4_45 = 0.05

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_46 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_46:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_47 = arg_1_1:GetWordFromCfg(121012001)
				local var_4_48 = arg_1_1:FormatText(var_4_47.content)

				arg_1_1.text_.text = var_4_48

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_49 = 2
				local var_4_50 = utf8.len(var_4_48)
				local var_4_51 = var_4_49 <= 0 and var_4_45 or var_4_45 * (var_4_50 / var_4_49)

				if var_4_51 > 0 and var_4_45 < var_4_51 then
					arg_1_1.talkMaxDuration = var_4_51
					var_4_44 = var_4_44 + 0.3

					if var_4_51 + var_4_44 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_51 + var_4_44
					end
				end

				arg_1_1.text_.text = var_4_48
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_52 = var_4_44 + 0.3
			local var_4_53 = math.max(var_4_45, arg_1_1.talkMaxDuration)

			if var_4_52 <= arg_1_1.time_ and arg_1_1.time_ < var_4_52 + var_4_53 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_52) / var_4_53

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_52 + var_4_53 and arg_1_1.time_ < var_4_52 + var_4_53 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play121012002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121012002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play121012003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.125

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

				local var_12_2 = arg_9_1:GetWordFromCfg(121012002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 45
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
	Play121012003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121012003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play121012004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.275

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

				local var_16_2 = arg_13_1:GetWordFromCfg(121012003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 51
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
	Play121012004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121012004
		arg_17_1.duration_ = 9.37

		local var_17_0 = {
			ja = 8.2,
			ko = 9.366,
			zh = 9.366
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
				arg_17_0:Play121012005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1029ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_17_1.stage_.transform)

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

			local var_20_5 = arg_17_1.actors_["1029ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1029ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(-0.7, -1.09, -6.2)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1029ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(-0.7, -1.09, -6.2)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["1029ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1029ui_story == nil then
				arg_17_1.var_.characterEffect1029ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect1029ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1029ui_story then
				arg_17_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_20 = "1076ui_story"

			if arg_17_1.actors_[var_20_20] == nil then
				local var_20_21 = Asset.Load("Char/" .. "1076ui_story")

				if not isNil(var_20_21) then
					local var_20_22 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_17_1.stage_.transform)

					var_20_22.name = var_20_20
					var_20_22.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_20] = var_20_22

					local var_20_23 = var_20_22:GetComponentInChildren(typeof(CharacterEffect))

					var_20_23.enabled = true

					local var_20_24 = GameObjectTools.GetOrAddComponent(var_20_22, typeof(DynamicBoneHelper))

					if var_20_24 then
						var_20_24:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_23.transform, false)

					arg_17_1.var_[var_20_20 .. "Animator"] = var_20_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_20 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_20 .. "LipSync"] = var_20_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_25 = arg_17_1.actors_["1076ui_story"].transform
			local var_20_26 = 0

			if var_20_26 < arg_17_1.time_ and arg_17_1.time_ <= var_20_26 + arg_20_0 then
				arg_17_1.var_.moveOldPos1076ui_story = var_20_25.localPosition
			end

			local var_20_27 = 0.001

			if var_20_26 <= arg_17_1.time_ and arg_17_1.time_ < var_20_26 + var_20_27 then
				local var_20_28 = (arg_17_1.time_ - var_20_26) / var_20_27
				local var_20_29 = Vector3.New(0.7, -1.06, -6.2)

				var_20_25.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1076ui_story, var_20_29, var_20_28)

				local var_20_30 = manager.ui.mainCamera.transform.position - var_20_25.position

				var_20_25.forward = Vector3.New(var_20_30.x, var_20_30.y, var_20_30.z)

				local var_20_31 = var_20_25.localEulerAngles

				var_20_31.z = 0
				var_20_31.x = 0
				var_20_25.localEulerAngles = var_20_31
			end

			if arg_17_1.time_ >= var_20_26 + var_20_27 and arg_17_1.time_ < var_20_26 + var_20_27 + arg_20_0 then
				var_20_25.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_20_32 = manager.ui.mainCamera.transform.position - var_20_25.position

				var_20_25.forward = Vector3.New(var_20_32.x, var_20_32.y, var_20_32.z)

				local var_20_33 = var_20_25.localEulerAngles

				var_20_33.z = 0
				var_20_33.x = 0
				var_20_25.localEulerAngles = var_20_33
			end

			local var_20_34 = arg_17_1.actors_["1076ui_story"]
			local var_20_35 = 0

			if var_20_35 < arg_17_1.time_ and arg_17_1.time_ <= var_20_35 + arg_20_0 and not isNil(var_20_34) and arg_17_1.var_.characterEffect1076ui_story == nil then
				arg_17_1.var_.characterEffect1076ui_story = var_20_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_36 = 0.200000002980232

			if var_20_35 <= arg_17_1.time_ and arg_17_1.time_ < var_20_35 + var_20_36 and not isNil(var_20_34) then
				local var_20_37 = (arg_17_1.time_ - var_20_35) / var_20_36

				if arg_17_1.var_.characterEffect1076ui_story and not isNil(var_20_34) then
					local var_20_38 = Mathf.Lerp(0, 0.5, var_20_37)

					arg_17_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1076ui_story.fillRatio = var_20_38
				end
			end

			if arg_17_1.time_ >= var_20_35 + var_20_36 and arg_17_1.time_ < var_20_35 + var_20_36 + arg_20_0 and not isNil(var_20_34) and arg_17_1.var_.characterEffect1076ui_story then
				local var_20_39 = 0.5

				arg_17_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1076ui_story.fillRatio = var_20_39
			end

			local var_20_40 = 0

			if var_20_40 < arg_17_1.time_ and arg_17_1.time_ <= var_20_40 + arg_20_0 then
				arg_17_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_20_41 = 0
			local var_20_42 = 0.775

			if var_20_41 < arg_17_1.time_ and arg_17_1.time_ <= var_20_41 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_43 = arg_17_1:FormatText(StoryNameCfg[319].name)

				arg_17_1.leftNameTxt_.text = var_20_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_44 = arg_17_1:GetWordFromCfg(121012004)
				local var_20_45 = arg_17_1:FormatText(var_20_44.content)

				arg_17_1.text_.text = var_20_45

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_46 = 30
				local var_20_47 = utf8.len(var_20_45)
				local var_20_48 = var_20_46 <= 0 and var_20_42 or var_20_42 * (var_20_47 / var_20_46)

				if var_20_48 > 0 and var_20_42 < var_20_48 then
					arg_17_1.talkMaxDuration = var_20_48

					if var_20_48 + var_20_41 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_48 + var_20_41
					end
				end

				arg_17_1.text_.text = var_20_45
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012004", "story_v_out_121012.awb") ~= 0 then
					local var_20_49 = manager.audio:GetVoiceLength("story_v_out_121012", "121012004", "story_v_out_121012.awb") / 1000

					if var_20_49 + var_20_41 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_49 + var_20_41
					end

					if var_20_44.prefab_name ~= "" and arg_17_1.actors_[var_20_44.prefab_name] ~= nil then
						local var_20_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_44.prefab_name].transform, "story_v_out_121012", "121012004", "story_v_out_121012.awb")

						arg_17_1:RecordAudio("121012004", var_20_50)
						arg_17_1:RecordAudio("121012004", var_20_50)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_121012", "121012004", "story_v_out_121012.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_121012", "121012004", "story_v_out_121012.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_51 = math.max(var_20_42, arg_17_1.talkMaxDuration)

			if var_20_41 <= arg_17_1.time_ and arg_17_1.time_ < var_20_41 + var_20_51 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_41) / var_20_51

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_41 + var_20_51 and arg_17_1.time_ < var_20_41 + var_20_51 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play121012005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 121012005
		arg_21_1.duration_ = 4.67

		local var_21_0 = {
			ja = 4.666,
			ko = 3.2,
			zh = 3.2
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play121012006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1076ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1076ui_story == nil then
				arg_21_1.var_.characterEffect1076ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1076ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1076ui_story then
				arg_21_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_24_4 = 0

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_5 = arg_21_1.actors_["1029ui_story"]
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1029ui_story == nil then
				arg_21_1.var_.characterEffect1029ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_7 = 0.200000002980232

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 and not isNil(var_24_5) then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7

				if arg_21_1.var_.characterEffect1029ui_story and not isNil(var_24_5) then
					local var_24_9 = Mathf.Lerp(0, 0.5, var_24_8)

					arg_21_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1029ui_story.fillRatio = var_24_9
				end
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1029ui_story then
				local var_24_10 = 0.5

				arg_21_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1029ui_story.fillRatio = var_24_10
			end

			local var_24_11 = 0

			if var_24_11 < arg_21_1.time_ and arg_21_1.time_ <= var_24_11 + arg_24_0 then
				arg_21_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_24_12 = 0
			local var_24_13 = 0.275

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_14 = arg_21_1:FormatText(StoryNameCfg[389].name)

				arg_21_1.leftNameTxt_.text = var_24_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_15 = arg_21_1:GetWordFromCfg(121012005)
				local var_24_16 = arg_21_1:FormatText(var_24_15.content)

				arg_21_1.text_.text = var_24_16

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_17 = 11
				local var_24_18 = utf8.len(var_24_16)
				local var_24_19 = var_24_17 <= 0 and var_24_13 or var_24_13 * (var_24_18 / var_24_17)

				if var_24_19 > 0 and var_24_13 < var_24_19 then
					arg_21_1.talkMaxDuration = var_24_19

					if var_24_19 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_12
					end
				end

				arg_21_1.text_.text = var_24_16
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012005", "story_v_out_121012.awb") ~= 0 then
					local var_24_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012005", "story_v_out_121012.awb") / 1000

					if var_24_20 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_20 + var_24_12
					end

					if var_24_15.prefab_name ~= "" and arg_21_1.actors_[var_24_15.prefab_name] ~= nil then
						local var_24_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_15.prefab_name].transform, "story_v_out_121012", "121012005", "story_v_out_121012.awb")

						arg_21_1:RecordAudio("121012005", var_24_21)
						arg_21_1:RecordAudio("121012005", var_24_21)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_121012", "121012005", "story_v_out_121012.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_121012", "121012005", "story_v_out_121012.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_22 = math.max(var_24_13, arg_21_1.talkMaxDuration)

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_22 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_12) / var_24_22

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_12 + var_24_22 and arg_21_1.time_ < var_24_12 + var_24_22 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play121012006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 121012006
		arg_25_1.duration_ = 2.7

		local var_25_0 = {
			ja = 2.7,
			ko = 2.533,
			zh = 2.533
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
				arg_25_0:Play121012007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1029ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1029ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(-0.7, -1.09, -6.2)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1029ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-0.7, -1.09, -6.2)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1029ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1029ui_story == nil then
				arg_25_1.var_.characterEffect1029ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1029ui_story and not isNil(var_28_9) then
					arg_25_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1029ui_story then
				arg_25_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_14 = arg_25_1.actors_["1076ui_story"]
			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1076ui_story == nil then
				arg_25_1.var_.characterEffect1076ui_story = var_28_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_16 = 0.200000002980232

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_16 and not isNil(var_28_14) then
				local var_28_17 = (arg_25_1.time_ - var_28_15) / var_28_16

				if arg_25_1.var_.characterEffect1076ui_story and not isNil(var_28_14) then
					local var_28_18 = Mathf.Lerp(0, 0.5, var_28_17)

					arg_25_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1076ui_story.fillRatio = var_28_18
				end
			end

			if arg_25_1.time_ >= var_28_15 + var_28_16 and arg_25_1.time_ < var_28_15 + var_28_16 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1076ui_story then
				local var_28_19 = 0.5

				arg_25_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1076ui_story.fillRatio = var_28_19
			end

			local var_28_20 = 0
			local var_28_21 = 0.175

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_22 = arg_25_1:FormatText(StoryNameCfg[319].name)

				arg_25_1.leftNameTxt_.text = var_28_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_23 = arg_25_1:GetWordFromCfg(121012006)
				local var_28_24 = arg_25_1:FormatText(var_28_23.content)

				arg_25_1.text_.text = var_28_24

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_25 = 7
				local var_28_26 = utf8.len(var_28_24)
				local var_28_27 = var_28_25 <= 0 and var_28_21 or var_28_21 * (var_28_26 / var_28_25)

				if var_28_27 > 0 and var_28_21 < var_28_27 then
					arg_25_1.talkMaxDuration = var_28_27

					if var_28_27 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_27 + var_28_20
					end
				end

				arg_25_1.text_.text = var_28_24
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012006", "story_v_out_121012.awb") ~= 0 then
					local var_28_28 = manager.audio:GetVoiceLength("story_v_out_121012", "121012006", "story_v_out_121012.awb") / 1000

					if var_28_28 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_20
					end

					if var_28_23.prefab_name ~= "" and arg_25_1.actors_[var_28_23.prefab_name] ~= nil then
						local var_28_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_23.prefab_name].transform, "story_v_out_121012", "121012006", "story_v_out_121012.awb")

						arg_25_1:RecordAudio("121012006", var_28_29)
						arg_25_1:RecordAudio("121012006", var_28_29)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_121012", "121012006", "story_v_out_121012.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_121012", "121012006", "story_v_out_121012.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_30 = math.max(var_28_21, arg_25_1.talkMaxDuration)

			if var_28_20 <= arg_25_1.time_ and arg_25_1.time_ < var_28_20 + var_28_30 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_20) / var_28_30

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_20 + var_28_30 and arg_25_1.time_ < var_28_20 + var_28_30 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
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
	Play121012007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 121012007
		arg_29_1.duration_ = 6.67

		local var_29_0 = {
			ja = 6.666,
			ko = 6.3,
			zh = 6.3
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play121012008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.725

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[319].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(121012007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 29
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012007", "story_v_out_121012.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_121012", "121012007", "story_v_out_121012.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_121012", "121012007", "story_v_out_121012.awb")

						arg_29_1:RecordAudio("121012007", var_32_9)
						arg_29_1:RecordAudio("121012007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_121012", "121012007", "story_v_out_121012.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_121012", "121012007", "story_v_out_121012.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play121012008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 121012008
		arg_33_1.duration_ = 9.1

		local var_33_0 = {
			ja = 7.9,
			ko = 9.1,
			zh = 9.1
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
				arg_33_0:Play121012009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1029ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1029ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(-0.7, -1.09, -6.2)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1029ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(-0.7, -1.09, -6.2)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1029ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1029ui_story == nil then
				arg_33_1.var_.characterEffect1029ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect1029ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1029ui_story then
				arg_33_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_15 = 0
			local var_36_16 = 0.75

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[319].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(121012008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 30
				local var_36_21 = utf8.len(var_36_19)
				local var_36_22 = var_36_20 <= 0 and var_36_16 or var_36_16 * (var_36_21 / var_36_20)

				if var_36_22 > 0 and var_36_16 < var_36_22 then
					arg_33_1.talkMaxDuration = var_36_22

					if var_36_22 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_15
					end
				end

				arg_33_1.text_.text = var_36_19
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012008", "story_v_out_121012.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_121012", "121012008", "story_v_out_121012.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_121012", "121012008", "story_v_out_121012.awb")

						arg_33_1:RecordAudio("121012008", var_36_24)
						arg_33_1:RecordAudio("121012008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_121012", "121012008", "story_v_out_121012.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_121012", "121012008", "story_v_out_121012.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_25 = math.max(var_36_16, arg_33_1.talkMaxDuration)

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_25 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_15) / var_36_25

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_15 + var_36_25 and arg_33_1.time_ < var_36_15 + var_36_25 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play121012009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 121012009
		arg_37_1.duration_ = 8.43

		local var_37_0 = {
			ja = 8.433,
			ko = 4.766,
			zh = 4.766
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
				arg_37_0:Play121012010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.55

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[319].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(121012009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012009", "story_v_out_121012.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_121012", "121012009", "story_v_out_121012.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_121012", "121012009", "story_v_out_121012.awb")

						arg_37_1:RecordAudio("121012009", var_40_9)
						arg_37_1:RecordAudio("121012009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_121012", "121012009", "story_v_out_121012.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_121012", "121012009", "story_v_out_121012.awb")
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
	Play121012010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 121012010
		arg_41_1.duration_ = 6.63

		local var_41_0 = {
			ja = 6.633,
			ko = 3.666,
			zh = 3.666
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
				arg_41_0:Play121012011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1076ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1076ui_story == nil then
				arg_41_1.var_.characterEffect1076ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1076ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1076ui_story then
				arg_41_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_6 = arg_41_1.actors_["1029ui_story"]
			local var_44_7 = 0

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1029ui_story == nil then
				arg_41_1.var_.characterEffect1029ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_8 = 0.200000002980232

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_8 and not isNil(var_44_6) then
				local var_44_9 = (arg_41_1.time_ - var_44_7) / var_44_8

				if arg_41_1.var_.characterEffect1029ui_story and not isNil(var_44_6) then
					local var_44_10 = Mathf.Lerp(0, 0.5, var_44_9)

					arg_41_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1029ui_story.fillRatio = var_44_10
				end
			end

			if arg_41_1.time_ >= var_44_7 + var_44_8 and arg_41_1.time_ < var_44_7 + var_44_8 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1029ui_story then
				local var_44_11 = 0.5

				arg_41_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1029ui_story.fillRatio = var_44_11
			end

			local var_44_12 = 0
			local var_44_13 = 0.425

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_14 = arg_41_1:FormatText(StoryNameCfg[389].name)

				arg_41_1.leftNameTxt_.text = var_44_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:GetWordFromCfg(121012010)
				local var_44_16 = arg_41_1:FormatText(var_44_15.content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 17
				local var_44_18 = utf8.len(var_44_16)
				local var_44_19 = var_44_17 <= 0 and var_44_13 or var_44_13 * (var_44_18 / var_44_17)

				if var_44_19 > 0 and var_44_13 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19

					if var_44_19 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_12
					end
				end

				arg_41_1.text_.text = var_44_16
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012010", "story_v_out_121012.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012010", "story_v_out_121012.awb") / 1000

					if var_44_20 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_12
					end

					if var_44_15.prefab_name ~= "" and arg_41_1.actors_[var_44_15.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_15.prefab_name].transform, "story_v_out_121012", "121012010", "story_v_out_121012.awb")

						arg_41_1:RecordAudio("121012010", var_44_21)
						arg_41_1:RecordAudio("121012010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_121012", "121012010", "story_v_out_121012.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_121012", "121012010", "story_v_out_121012.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_13, arg_41_1.talkMaxDuration)

			if var_44_12 <= arg_41_1.time_ and arg_41_1.time_ < var_44_12 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_12) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_12 + var_44_22 and arg_41_1.time_ < var_44_12 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play121012011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 121012011
		arg_45_1.duration_ = 4.6

		local var_45_0 = {
			ja = 4.6,
			ko = 4.066,
			zh = 4.066
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
				arg_45_0:Play121012012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1029ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1029ui_story == nil then
				arg_45_1.var_.characterEffect1029ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1029ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1029ui_story then
				arg_45_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_2")
			end

			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_6 = arg_45_1.actors_["1076ui_story"]
			local var_48_7 = 0

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1076ui_story == nil then
				arg_45_1.var_.characterEffect1076ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_8 = 0.200000002980232

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_8 and not isNil(var_48_6) then
				local var_48_9 = (arg_45_1.time_ - var_48_7) / var_48_8

				if arg_45_1.var_.characterEffect1076ui_story and not isNil(var_48_6) then
					local var_48_10 = Mathf.Lerp(0, 0.5, var_48_9)

					arg_45_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1076ui_story.fillRatio = var_48_10
				end
			end

			if arg_45_1.time_ >= var_48_7 + var_48_8 and arg_45_1.time_ < var_48_7 + var_48_8 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1076ui_story then
				local var_48_11 = 0.5

				arg_45_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1076ui_story.fillRatio = var_48_11
			end

			local var_48_12 = 0
			local var_48_13 = 0.5

			if var_48_12 < arg_45_1.time_ and arg_45_1.time_ <= var_48_12 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_14 = arg_45_1:FormatText(StoryNameCfg[319].name)

				arg_45_1.leftNameTxt_.text = var_48_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_15 = arg_45_1:GetWordFromCfg(121012011)
				local var_48_16 = arg_45_1:FormatText(var_48_15.content)

				arg_45_1.text_.text = var_48_16

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_17 = 20
				local var_48_18 = utf8.len(var_48_16)
				local var_48_19 = var_48_17 <= 0 and var_48_13 or var_48_13 * (var_48_18 / var_48_17)

				if var_48_19 > 0 and var_48_13 < var_48_19 then
					arg_45_1.talkMaxDuration = var_48_19

					if var_48_19 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_12
					end
				end

				arg_45_1.text_.text = var_48_16
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012011", "story_v_out_121012.awb") ~= 0 then
					local var_48_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012011", "story_v_out_121012.awb") / 1000

					if var_48_20 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_20 + var_48_12
					end

					if var_48_15.prefab_name ~= "" and arg_45_1.actors_[var_48_15.prefab_name] ~= nil then
						local var_48_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_15.prefab_name].transform, "story_v_out_121012", "121012011", "story_v_out_121012.awb")

						arg_45_1:RecordAudio("121012011", var_48_21)
						arg_45_1:RecordAudio("121012011", var_48_21)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_121012", "121012011", "story_v_out_121012.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_121012", "121012011", "story_v_out_121012.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_22 = math.max(var_48_13, arg_45_1.talkMaxDuration)

			if var_48_12 <= arg_45_1.time_ and arg_45_1.time_ < var_48_12 + var_48_22 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_12) / var_48_22

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_12 + var_48_22 and arg_45_1.time_ < var_48_12 + var_48_22 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play121012012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 121012012
		arg_49_1.duration_ = 7.93

		local var_49_0 = {
			ja = 7.933,
			ko = 7.133,
			zh = 7.133
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
				arg_49_0:Play121012013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.825

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[319].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(121012012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012012", "story_v_out_121012.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_121012", "121012012", "story_v_out_121012.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_121012", "121012012", "story_v_out_121012.awb")

						arg_49_1:RecordAudio("121012012", var_52_9)
						arg_49_1:RecordAudio("121012012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_121012", "121012012", "story_v_out_121012.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_121012", "121012012", "story_v_out_121012.awb")
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
	Play121012013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 121012013
		arg_53_1.duration_ = 8.4

		local var_53_0 = {
			ja = 8.4,
			ko = 6.633,
			zh = 6.633
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
				arg_53_0:Play121012014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.7

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[319].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(121012013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012013", "story_v_out_121012.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_121012", "121012013", "story_v_out_121012.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_121012", "121012013", "story_v_out_121012.awb")

						arg_53_1:RecordAudio("121012013", var_56_9)
						arg_53_1:RecordAudio("121012013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_121012", "121012013", "story_v_out_121012.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_121012", "121012013", "story_v_out_121012.awb")
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
	Play121012014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 121012014
		arg_57_1.duration_ = 3.27

		local var_57_0 = {
			ja = 3.1,
			ko = 3.266,
			zh = 3.266
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play121012015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1076ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1076ui_story == nil then
				arg_57_1.var_.characterEffect1076ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1076ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1076ui_story then
				arg_57_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_60_4 = 0

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_6 = arg_57_1.actors_["1029ui_story"]
			local var_60_7 = 0

			if var_60_7 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1029ui_story == nil then
				arg_57_1.var_.characterEffect1029ui_story = var_60_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_8 = 0.200000002980232

			if var_60_7 <= arg_57_1.time_ and arg_57_1.time_ < var_60_7 + var_60_8 and not isNil(var_60_6) then
				local var_60_9 = (arg_57_1.time_ - var_60_7) / var_60_8

				if arg_57_1.var_.characterEffect1029ui_story and not isNil(var_60_6) then
					local var_60_10 = Mathf.Lerp(0, 0.5, var_60_9)

					arg_57_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1029ui_story.fillRatio = var_60_10
				end
			end

			if arg_57_1.time_ >= var_60_7 + var_60_8 and arg_57_1.time_ < var_60_7 + var_60_8 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1029ui_story then
				local var_60_11 = 0.5

				arg_57_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1029ui_story.fillRatio = var_60_11
			end

			local var_60_12 = 0
			local var_60_13 = 0.35

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_14 = arg_57_1:FormatText(StoryNameCfg[389].name)

				arg_57_1.leftNameTxt_.text = var_60_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_15 = arg_57_1:GetWordFromCfg(121012014)
				local var_60_16 = arg_57_1:FormatText(var_60_15.content)

				arg_57_1.text_.text = var_60_16

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012014", "story_v_out_121012.awb") ~= 0 then
					local var_60_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012014", "story_v_out_121012.awb") / 1000

					if var_60_20 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_20 + var_60_12
					end

					if var_60_15.prefab_name ~= "" and arg_57_1.actors_[var_60_15.prefab_name] ~= nil then
						local var_60_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_15.prefab_name].transform, "story_v_out_121012", "121012014", "story_v_out_121012.awb")

						arg_57_1:RecordAudio("121012014", var_60_21)
						arg_57_1:RecordAudio("121012014", var_60_21)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_121012", "121012014", "story_v_out_121012.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_121012", "121012014", "story_v_out_121012.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_22 = math.max(var_60_13, arg_57_1.talkMaxDuration)

			if var_60_12 <= arg_57_1.time_ and arg_57_1.time_ < var_60_12 + var_60_22 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_12) / var_60_22

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_12 + var_60_22 and arg_57_1.time_ < var_60_12 + var_60_22 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play121012015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 121012015
		arg_61_1.duration_ = 9.43

		local var_61_0 = {
			ja = 9.433,
			ko = 5.8,
			zh = 5.8
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
				arg_61_0:Play121012016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_2 = 0
			local var_64_3 = 0.575

			if var_64_2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_4 = arg_61_1:FormatText(StoryNameCfg[389].name)

				arg_61_1.leftNameTxt_.text = var_64_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_5 = arg_61_1:GetWordFromCfg(121012015)
				local var_64_6 = arg_61_1:FormatText(var_64_5.content)

				arg_61_1.text_.text = var_64_6

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 23
				local var_64_8 = utf8.len(var_64_6)
				local var_64_9 = var_64_7 <= 0 and var_64_3 or var_64_3 * (var_64_8 / var_64_7)

				if var_64_9 > 0 and var_64_3 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_6
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012015", "story_v_out_121012.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_121012", "121012015", "story_v_out_121012.awb") / 1000

					if var_64_10 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_2
					end

					if var_64_5.prefab_name ~= "" and arg_61_1.actors_[var_64_5.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_5.prefab_name].transform, "story_v_out_121012", "121012015", "story_v_out_121012.awb")

						arg_61_1:RecordAudio("121012015", var_64_11)
						arg_61_1:RecordAudio("121012015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_121012", "121012015", "story_v_out_121012.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_121012", "121012015", "story_v_out_121012.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_12 and arg_61_1.time_ < var_64_2 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play121012016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 121012016
		arg_65_1.duration_ = 6.97

		local var_65_0 = {
			ja = 6.966,
			ko = 5.666,
			zh = 5.666
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play121012017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1029ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1029ui_story == nil then
				arg_65_1.var_.characterEffect1029ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1029ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1029ui_story then
				arg_65_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_68_4 = 0

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action5_1")
			end

			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_6 = arg_65_1.actors_["1076ui_story"]
			local var_68_7 = 0

			if var_68_7 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1076ui_story == nil then
				arg_65_1.var_.characterEffect1076ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.200000002980232

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_8 and not isNil(var_68_6) then
				local var_68_9 = (arg_65_1.time_ - var_68_7) / var_68_8

				if arg_65_1.var_.characterEffect1076ui_story and not isNil(var_68_6) then
					local var_68_10 = Mathf.Lerp(0, 0.5, var_68_9)

					arg_65_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1076ui_story.fillRatio = var_68_10
				end
			end

			if arg_65_1.time_ >= var_68_7 + var_68_8 and arg_65_1.time_ < var_68_7 + var_68_8 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1076ui_story then
				local var_68_11 = 0.5

				arg_65_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1076ui_story.fillRatio = var_68_11
			end

			local var_68_12 = 0
			local var_68_13 = 0.625

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_14 = arg_65_1:FormatText(StoryNameCfg[319].name)

				arg_65_1.leftNameTxt_.text = var_68_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:GetWordFromCfg(121012016)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 25
				local var_68_18 = utf8.len(var_68_16)
				local var_68_19 = var_68_17 <= 0 and var_68_13 or var_68_13 * (var_68_18 / var_68_17)

				if var_68_19 > 0 and var_68_13 < var_68_19 then
					arg_65_1.talkMaxDuration = var_68_19

					if var_68_19 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_16
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012016", "story_v_out_121012.awb") ~= 0 then
					local var_68_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012016", "story_v_out_121012.awb") / 1000

					if var_68_20 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_12
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_out_121012", "121012016", "story_v_out_121012.awb")

						arg_65_1:RecordAudio("121012016", var_68_21)
						arg_65_1:RecordAudio("121012016", var_68_21)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_121012", "121012016", "story_v_out_121012.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_121012", "121012016", "story_v_out_121012.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_22 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_12) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_12 + var_68_22 and arg_65_1.time_ < var_68_12 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play121012017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 121012017
		arg_69_1.duration_ = 2.73

		local var_69_0 = {
			ja = 2.733,
			ko = 1.333,
			zh = 1.333
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play121012018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.15

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[319].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(121012017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 6
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012017", "story_v_out_121012.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_121012", "121012017", "story_v_out_121012.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_121012", "121012017", "story_v_out_121012.awb")

						arg_69_1:RecordAudio("121012017", var_72_9)
						arg_69_1:RecordAudio("121012017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_121012", "121012017", "story_v_out_121012.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_121012", "121012017", "story_v_out_121012.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play121012018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 121012018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play121012019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1029ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1029ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, 100, 0)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1029ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, 100, 0)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["1029ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1029ui_story == nil then
				arg_73_1.var_.characterEffect1029ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect1029ui_story and not isNil(var_76_9) then
					local var_76_13 = Mathf.Lerp(0, 0.5, var_76_12)

					arg_73_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1029ui_story.fillRatio = var_76_13
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1029ui_story then
				local var_76_14 = 0.5

				arg_73_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1029ui_story.fillRatio = var_76_14
			end

			local var_76_15 = arg_73_1.actors_["1076ui_story"].transform
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.var_.moveOldPos1076ui_story = var_76_15.localPosition
			end

			local var_76_17 = 0.001

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17
				local var_76_19 = Vector3.New(0, 100, 0)

				var_76_15.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1076ui_story, var_76_19, var_76_18)

				local var_76_20 = manager.ui.mainCamera.transform.position - var_76_15.position

				var_76_15.forward = Vector3.New(var_76_20.x, var_76_20.y, var_76_20.z)

				local var_76_21 = var_76_15.localEulerAngles

				var_76_21.z = 0
				var_76_21.x = 0
				var_76_15.localEulerAngles = var_76_21
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 then
				var_76_15.localPosition = Vector3.New(0, 100, 0)

				local var_76_22 = manager.ui.mainCamera.transform.position - var_76_15.position

				var_76_15.forward = Vector3.New(var_76_22.x, var_76_22.y, var_76_22.z)

				local var_76_23 = var_76_15.localEulerAngles

				var_76_23.z = 0
				var_76_23.x = 0
				var_76_15.localEulerAngles = var_76_23
			end

			local var_76_24 = arg_73_1.actors_["1076ui_story"]
			local var_76_25 = 0

			if var_76_25 < arg_73_1.time_ and arg_73_1.time_ <= var_76_25 + arg_76_0 and not isNil(var_76_24) and arg_73_1.var_.characterEffect1076ui_story == nil then
				arg_73_1.var_.characterEffect1076ui_story = var_76_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_26 = 0.200000002980232

			if var_76_25 <= arg_73_1.time_ and arg_73_1.time_ < var_76_25 + var_76_26 and not isNil(var_76_24) then
				local var_76_27 = (arg_73_1.time_ - var_76_25) / var_76_26

				if arg_73_1.var_.characterEffect1076ui_story and not isNil(var_76_24) then
					local var_76_28 = Mathf.Lerp(0, 0.5, var_76_27)

					arg_73_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1076ui_story.fillRatio = var_76_28
				end
			end

			if arg_73_1.time_ >= var_76_25 + var_76_26 and arg_73_1.time_ < var_76_25 + var_76_26 + arg_76_0 and not isNil(var_76_24) and arg_73_1.var_.characterEffect1076ui_story then
				local var_76_29 = 0.5

				arg_73_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1076ui_story.fillRatio = var_76_29
			end

			local var_76_30 = 0
			local var_76_31 = 1

			if var_76_30 < arg_73_1.time_ and arg_73_1.time_ <= var_76_30 + arg_76_0 then
				local var_76_32 = "play"
				local var_76_33 = "effect"

				arg_73_1:AudioAction(var_76_32, var_76_33, "se_story_121_00", "se_story_121_00_dooropen_start", "")
			end

			local var_76_34 = 0
			local var_76_35 = 1.075

			if var_76_34 < arg_73_1.time_ and arg_73_1.time_ <= var_76_34 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_36 = arg_73_1:GetWordFromCfg(121012018)
				local var_76_37 = arg_73_1:FormatText(var_76_36.content)

				arg_73_1.text_.text = var_76_37

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_38 = 43
				local var_76_39 = utf8.len(var_76_37)
				local var_76_40 = var_76_38 <= 0 and var_76_35 or var_76_35 * (var_76_39 / var_76_38)

				if var_76_40 > 0 and var_76_35 < var_76_40 then
					arg_73_1.talkMaxDuration = var_76_40

					if var_76_40 + var_76_34 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_40 + var_76_34
					end
				end

				arg_73_1.text_.text = var_76_37
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_41 = math.max(var_76_35, arg_73_1.talkMaxDuration)

			if var_76_34 <= arg_73_1.time_ and arg_73_1.time_ < var_76_34 + var_76_41 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_34) / var_76_41

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_34 + var_76_41 and arg_73_1.time_ < var_76_34 + var_76_41 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play121012019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 121012019
		arg_77_1.duration_ = 7

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play121012020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = false

				arg_77_1:SetGaussion(false)
			end

			local var_80_1 = 2

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_1 then
				local var_80_2 = (arg_77_1.time_ - var_80_0) / var_80_1
				local var_80_3 = Color.New(1, 1, 1)

				var_80_3.a = Mathf.Lerp(1, 0, var_80_2)
				arg_77_1.mask_.color = var_80_3
			end

			if arg_77_1.time_ >= var_80_0 + var_80_1 and arg_77_1.time_ < var_80_0 + var_80_1 + arg_80_0 then
				local var_80_4 = Color.New(1, 1, 1)
				local var_80_5 = 0

				arg_77_1.mask_.enabled = false
				var_80_4.a = var_80_5
				arg_77_1.mask_.color = var_80_4
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_6 = 2
			local var_80_7 = 1.325

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_8 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_8:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_9 = arg_77_1:GetWordFromCfg(121012019)
				local var_80_10 = arg_77_1:FormatText(var_80_9.content)

				arg_77_1.text_.text = var_80_10

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 53
				local var_80_12 = utf8.len(var_80_10)
				local var_80_13 = var_80_11 <= 0 and var_80_7 or var_80_7 * (var_80_12 / var_80_11)

				if var_80_13 > 0 and var_80_7 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13
					var_80_6 = var_80_6 + 0.3

					if var_80_13 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_10
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = var_80_6 + 0.3
			local var_80_15 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_14 <= arg_77_1.time_ and arg_77_1.time_ < var_80_14 + var_80_15 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_14) / var_80_15

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_14 + var_80_15 and arg_77_1.time_ < var_80_14 + var_80_15 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play121012020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 121012020
		arg_83_1.duration_ = 6.23

		local var_83_0 = {
			ja = 6.233,
			ko = 5.033,
			zh = 5.033
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play121012021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1029ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1029ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(-0.7, -1.09, -6.2)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1029ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(-0.7, -1.09, -6.2)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = arg_83_1.actors_["1029ui_story"]
			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 and not isNil(var_86_9) and arg_83_1.var_.characterEffect1029ui_story == nil then
				arg_83_1.var_.characterEffect1029ui_story = var_86_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_11 = 0.200000002980232

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_11 and not isNil(var_86_9) then
				local var_86_12 = (arg_83_1.time_ - var_86_10) / var_86_11

				if arg_83_1.var_.characterEffect1029ui_story and not isNil(var_86_9) then
					arg_83_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_10 + var_86_11 and arg_83_1.time_ < var_86_10 + var_86_11 + arg_86_0 and not isNil(var_86_9) and arg_83_1.var_.characterEffect1029ui_story then
				arg_83_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_86_13 = 0

			if var_86_13 < arg_83_1.time_ and arg_83_1.time_ <= var_86_13 + arg_86_0 then
				arg_83_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_86_14 = 0

			if var_86_14 < arg_83_1.time_ and arg_83_1.time_ <= var_86_14 + arg_86_0 then
				arg_83_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_86_15 = arg_83_1.actors_["1076ui_story"].transform
			local var_86_16 = 0

			if var_86_16 < arg_83_1.time_ and arg_83_1.time_ <= var_86_16 + arg_86_0 then
				arg_83_1.var_.moveOldPos1076ui_story = var_86_15.localPosition
			end

			local var_86_17 = 0.001

			if var_86_16 <= arg_83_1.time_ and arg_83_1.time_ < var_86_16 + var_86_17 then
				local var_86_18 = (arg_83_1.time_ - var_86_16) / var_86_17
				local var_86_19 = Vector3.New(0.7, -1.06, -6.2)

				var_86_15.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1076ui_story, var_86_19, var_86_18)

				local var_86_20 = manager.ui.mainCamera.transform.position - var_86_15.position

				var_86_15.forward = Vector3.New(var_86_20.x, var_86_20.y, var_86_20.z)

				local var_86_21 = var_86_15.localEulerAngles

				var_86_21.z = 0
				var_86_21.x = 0
				var_86_15.localEulerAngles = var_86_21
			end

			if arg_83_1.time_ >= var_86_16 + var_86_17 and arg_83_1.time_ < var_86_16 + var_86_17 + arg_86_0 then
				var_86_15.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_86_22 = manager.ui.mainCamera.transform.position - var_86_15.position

				var_86_15.forward = Vector3.New(var_86_22.x, var_86_22.y, var_86_22.z)

				local var_86_23 = var_86_15.localEulerAngles

				var_86_23.z = 0
				var_86_23.x = 0
				var_86_15.localEulerAngles = var_86_23
			end

			local var_86_24 = arg_83_1.actors_["1076ui_story"]
			local var_86_25 = 0

			if var_86_25 < arg_83_1.time_ and arg_83_1.time_ <= var_86_25 + arg_86_0 and not isNil(var_86_24) and arg_83_1.var_.characterEffect1076ui_story == nil then
				arg_83_1.var_.characterEffect1076ui_story = var_86_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_26 = 0.200000002980232

			if var_86_25 <= arg_83_1.time_ and arg_83_1.time_ < var_86_25 + var_86_26 and not isNil(var_86_24) then
				local var_86_27 = (arg_83_1.time_ - var_86_25) / var_86_26

				if arg_83_1.var_.characterEffect1076ui_story and not isNil(var_86_24) then
					local var_86_28 = Mathf.Lerp(0, 0.5, var_86_27)

					arg_83_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1076ui_story.fillRatio = var_86_28
				end
			end

			if arg_83_1.time_ >= var_86_25 + var_86_26 and arg_83_1.time_ < var_86_25 + var_86_26 + arg_86_0 and not isNil(var_86_24) and arg_83_1.var_.characterEffect1076ui_story then
				local var_86_29 = 0.5

				arg_83_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1076ui_story.fillRatio = var_86_29
			end

			local var_86_30 = 0
			local var_86_31 = 0.6

			if var_86_30 < arg_83_1.time_ and arg_83_1.time_ <= var_86_30 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_32 = arg_83_1:FormatText(StoryNameCfg[319].name)

				arg_83_1.leftNameTxt_.text = var_86_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_33 = arg_83_1:GetWordFromCfg(121012020)
				local var_86_34 = arg_83_1:FormatText(var_86_33.content)

				arg_83_1.text_.text = var_86_34

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_35 = 24
				local var_86_36 = utf8.len(var_86_34)
				local var_86_37 = var_86_35 <= 0 and var_86_31 or var_86_31 * (var_86_36 / var_86_35)

				if var_86_37 > 0 and var_86_31 < var_86_37 then
					arg_83_1.talkMaxDuration = var_86_37

					if var_86_37 + var_86_30 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_37 + var_86_30
					end
				end

				arg_83_1.text_.text = var_86_34
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012020", "story_v_out_121012.awb") ~= 0 then
					local var_86_38 = manager.audio:GetVoiceLength("story_v_out_121012", "121012020", "story_v_out_121012.awb") / 1000

					if var_86_38 + var_86_30 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_38 + var_86_30
					end

					if var_86_33.prefab_name ~= "" and arg_83_1.actors_[var_86_33.prefab_name] ~= nil then
						local var_86_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_33.prefab_name].transform, "story_v_out_121012", "121012020", "story_v_out_121012.awb")

						arg_83_1:RecordAudio("121012020", var_86_39)
						arg_83_1:RecordAudio("121012020", var_86_39)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_121012", "121012020", "story_v_out_121012.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_121012", "121012020", "story_v_out_121012.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_40 = math.max(var_86_31, arg_83_1.talkMaxDuration)

			if var_86_30 <= arg_83_1.time_ and arg_83_1.time_ < var_86_30 + var_86_40 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_30) / var_86_40

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_30 + var_86_40 and arg_83_1.time_ < var_86_30 + var_86_40 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play121012021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 121012021
		arg_87_1.duration_ = 12.77

		local var_87_0 = {
			ja = 12.766,
			ko = 6.766,
			zh = 6.766
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play121012022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1076ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1076ui_story == nil then
				arg_87_1.var_.characterEffect1076ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect1076ui_story and not isNil(var_90_0) then
					arg_87_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1076ui_story then
				arg_87_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_90_4 = 0

			if var_90_4 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_90_5 = 0

			if var_90_5 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_90_6 = arg_87_1.actors_["1029ui_story"]
			local var_90_7 = 0

			if var_90_7 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect1029ui_story == nil then
				arg_87_1.var_.characterEffect1029ui_story = var_90_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_8 = 0.200000002980232

			if var_90_7 <= arg_87_1.time_ and arg_87_1.time_ < var_90_7 + var_90_8 and not isNil(var_90_6) then
				local var_90_9 = (arg_87_1.time_ - var_90_7) / var_90_8

				if arg_87_1.var_.characterEffect1029ui_story and not isNil(var_90_6) then
					local var_90_10 = Mathf.Lerp(0, 0.5, var_90_9)

					arg_87_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1029ui_story.fillRatio = var_90_10
				end
			end

			if arg_87_1.time_ >= var_90_7 + var_90_8 and arg_87_1.time_ < var_90_7 + var_90_8 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect1029ui_story then
				local var_90_11 = 0.5

				arg_87_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1029ui_story.fillRatio = var_90_11
			end

			local var_90_12 = 0
			local var_90_13 = 0.625

			if var_90_12 < arg_87_1.time_ and arg_87_1.time_ <= var_90_12 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_14 = arg_87_1:FormatText(StoryNameCfg[389].name)

				arg_87_1.leftNameTxt_.text = var_90_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_15 = arg_87_1:GetWordFromCfg(121012021)
				local var_90_16 = arg_87_1:FormatText(var_90_15.content)

				arg_87_1.text_.text = var_90_16

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_17 = 25
				local var_90_18 = utf8.len(var_90_16)
				local var_90_19 = var_90_17 <= 0 and var_90_13 or var_90_13 * (var_90_18 / var_90_17)

				if var_90_19 > 0 and var_90_13 < var_90_19 then
					arg_87_1.talkMaxDuration = var_90_19

					if var_90_19 + var_90_12 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_19 + var_90_12
					end
				end

				arg_87_1.text_.text = var_90_16
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012021", "story_v_out_121012.awb") ~= 0 then
					local var_90_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012021", "story_v_out_121012.awb") / 1000

					if var_90_20 + var_90_12 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_20 + var_90_12
					end

					if var_90_15.prefab_name ~= "" and arg_87_1.actors_[var_90_15.prefab_name] ~= nil then
						local var_90_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_15.prefab_name].transform, "story_v_out_121012", "121012021", "story_v_out_121012.awb")

						arg_87_1:RecordAudio("121012021", var_90_21)
						arg_87_1:RecordAudio("121012021", var_90_21)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_121012", "121012021", "story_v_out_121012.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_121012", "121012021", "story_v_out_121012.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_22 = math.max(var_90_13, arg_87_1.talkMaxDuration)

			if var_90_12 <= arg_87_1.time_ and arg_87_1.time_ < var_90_12 + var_90_22 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_12) / var_90_22

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_12 + var_90_22 and arg_87_1.time_ < var_90_12 + var_90_22 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play121012022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 121012022
		arg_91_1.duration_ = 4.7

		local var_91_0 = {
			ja = 4.7,
			ko = 3.9,
			zh = 3.9
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
				arg_91_0:Play121012023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1029ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1029ui_story == nil then
				arg_91_1.var_.characterEffect1029ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1029ui_story and not isNil(var_94_0) then
					arg_91_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1029ui_story then
				arg_91_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_94_4 = 0

			if var_94_4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_94_5 = 0

			if var_94_5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_94_6 = arg_91_1.actors_["1076ui_story"]
			local var_94_7 = 0

			if var_94_7 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 and not isNil(var_94_6) and arg_91_1.var_.characterEffect1076ui_story == nil then
				arg_91_1.var_.characterEffect1076ui_story = var_94_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_8 = 0.200000002980232

			if var_94_7 <= arg_91_1.time_ and arg_91_1.time_ < var_94_7 + var_94_8 and not isNil(var_94_6) then
				local var_94_9 = (arg_91_1.time_ - var_94_7) / var_94_8

				if arg_91_1.var_.characterEffect1076ui_story and not isNil(var_94_6) then
					local var_94_10 = Mathf.Lerp(0, 0.5, var_94_9)

					arg_91_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1076ui_story.fillRatio = var_94_10
				end
			end

			if arg_91_1.time_ >= var_94_7 + var_94_8 and arg_91_1.time_ < var_94_7 + var_94_8 + arg_94_0 and not isNil(var_94_6) and arg_91_1.var_.characterEffect1076ui_story then
				local var_94_11 = 0.5

				arg_91_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1076ui_story.fillRatio = var_94_11
			end

			local var_94_12 = 0
			local var_94_13 = 0.4

			if var_94_12 < arg_91_1.time_ and arg_91_1.time_ <= var_94_12 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_14 = arg_91_1:FormatText(StoryNameCfg[319].name)

				arg_91_1.leftNameTxt_.text = var_94_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_15 = arg_91_1:GetWordFromCfg(121012022)
				local var_94_16 = arg_91_1:FormatText(var_94_15.content)

				arg_91_1.text_.text = var_94_16

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_17 = 16
				local var_94_18 = utf8.len(var_94_16)
				local var_94_19 = var_94_17 <= 0 and var_94_13 or var_94_13 * (var_94_18 / var_94_17)

				if var_94_19 > 0 and var_94_13 < var_94_19 then
					arg_91_1.talkMaxDuration = var_94_19

					if var_94_19 + var_94_12 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_19 + var_94_12
					end
				end

				arg_91_1.text_.text = var_94_16
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012022", "story_v_out_121012.awb") ~= 0 then
					local var_94_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012022", "story_v_out_121012.awb") / 1000

					if var_94_20 + var_94_12 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_20 + var_94_12
					end

					if var_94_15.prefab_name ~= "" and arg_91_1.actors_[var_94_15.prefab_name] ~= nil then
						local var_94_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_15.prefab_name].transform, "story_v_out_121012", "121012022", "story_v_out_121012.awb")

						arg_91_1:RecordAudio("121012022", var_94_21)
						arg_91_1:RecordAudio("121012022", var_94_21)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_121012", "121012022", "story_v_out_121012.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_121012", "121012022", "story_v_out_121012.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_22 = math.max(var_94_13, arg_91_1.talkMaxDuration)

			if var_94_12 <= arg_91_1.time_ and arg_91_1.time_ < var_94_12 + var_94_22 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_12) / var_94_22

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_12 + var_94_22 and arg_91_1.time_ < var_94_12 + var_94_22 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play121012023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 121012023
		arg_95_1.duration_ = 11.93

		local var_95_0 = {
			ja = 11.933,
			ko = 8.866,
			zh = 8.866
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play121012024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1076ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1076ui_story == nil then
				arg_95_1.var_.characterEffect1076ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1076ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1076ui_story then
				arg_95_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_98_4 = 0

			if var_98_4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action4_1")
			end

			local var_98_5 = 0

			if var_98_5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_98_6 = arg_95_1.actors_["1029ui_story"]
			local var_98_7 = 0

			if var_98_7 < arg_95_1.time_ and arg_95_1.time_ <= var_98_7 + arg_98_0 and not isNil(var_98_6) and arg_95_1.var_.characterEffect1029ui_story == nil then
				arg_95_1.var_.characterEffect1029ui_story = var_98_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_8 = 0.200000002980232

			if var_98_7 <= arg_95_1.time_ and arg_95_1.time_ < var_98_7 + var_98_8 and not isNil(var_98_6) then
				local var_98_9 = (arg_95_1.time_ - var_98_7) / var_98_8

				if arg_95_1.var_.characterEffect1029ui_story and not isNil(var_98_6) then
					local var_98_10 = Mathf.Lerp(0, 0.5, var_98_9)

					arg_95_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1029ui_story.fillRatio = var_98_10
				end
			end

			if arg_95_1.time_ >= var_98_7 + var_98_8 and arg_95_1.time_ < var_98_7 + var_98_8 + arg_98_0 and not isNil(var_98_6) and arg_95_1.var_.characterEffect1029ui_story then
				local var_98_11 = 0.5

				arg_95_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1029ui_story.fillRatio = var_98_11
			end

			local var_98_12 = 0
			local var_98_13 = 0.9

			if var_98_12 < arg_95_1.time_ and arg_95_1.time_ <= var_98_12 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_14 = arg_95_1:FormatText(StoryNameCfg[389].name)

				arg_95_1.leftNameTxt_.text = var_98_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_15 = arg_95_1:GetWordFromCfg(121012023)
				local var_98_16 = arg_95_1:FormatText(var_98_15.content)

				arg_95_1.text_.text = var_98_16

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_17 = 36
				local var_98_18 = utf8.len(var_98_16)
				local var_98_19 = var_98_17 <= 0 and var_98_13 or var_98_13 * (var_98_18 / var_98_17)

				if var_98_19 > 0 and var_98_13 < var_98_19 then
					arg_95_1.talkMaxDuration = var_98_19

					if var_98_19 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_19 + var_98_12
					end
				end

				arg_95_1.text_.text = var_98_16
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012023", "story_v_out_121012.awb") ~= 0 then
					local var_98_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012023", "story_v_out_121012.awb") / 1000

					if var_98_20 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_20 + var_98_12
					end

					if var_98_15.prefab_name ~= "" and arg_95_1.actors_[var_98_15.prefab_name] ~= nil then
						local var_98_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_15.prefab_name].transform, "story_v_out_121012", "121012023", "story_v_out_121012.awb")

						arg_95_1:RecordAudio("121012023", var_98_21)
						arg_95_1:RecordAudio("121012023", var_98_21)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_121012", "121012023", "story_v_out_121012.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_121012", "121012023", "story_v_out_121012.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_22 = math.max(var_98_13, arg_95_1.talkMaxDuration)

			if var_98_12 <= arg_95_1.time_ and arg_95_1.time_ < var_98_12 + var_98_22 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_12) / var_98_22

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_12 + var_98_22 and arg_95_1.time_ < var_98_12 + var_98_22 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play121012024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 121012024
		arg_99_1.duration_ = 3.33

		local var_99_0 = {
			ja = 3.333,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play121012025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1029ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1029ui_story == nil then
				arg_99_1.var_.characterEffect1029ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect1029ui_story and not isNil(var_102_0) then
					arg_99_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1029ui_story then
				arg_99_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_102_4 = 0

			if var_102_4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_102_5 = 0

			if var_102_5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_6 = arg_99_1.actors_["1076ui_story"]
			local var_102_7 = 0

			if var_102_7 < arg_99_1.time_ and arg_99_1.time_ <= var_102_7 + arg_102_0 and not isNil(var_102_6) and arg_99_1.var_.characterEffect1076ui_story == nil then
				arg_99_1.var_.characterEffect1076ui_story = var_102_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_8 = 0.200000002980232

			if var_102_7 <= arg_99_1.time_ and arg_99_1.time_ < var_102_7 + var_102_8 and not isNil(var_102_6) then
				local var_102_9 = (arg_99_1.time_ - var_102_7) / var_102_8

				if arg_99_1.var_.characterEffect1076ui_story and not isNil(var_102_6) then
					local var_102_10 = Mathf.Lerp(0, 0.5, var_102_9)

					arg_99_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1076ui_story.fillRatio = var_102_10
				end
			end

			if arg_99_1.time_ >= var_102_7 + var_102_8 and arg_99_1.time_ < var_102_7 + var_102_8 + arg_102_0 and not isNil(var_102_6) and arg_99_1.var_.characterEffect1076ui_story then
				local var_102_11 = 0.5

				arg_99_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1076ui_story.fillRatio = var_102_11
			end

			local var_102_12 = 0

			if var_102_12 < arg_99_1.time_ and arg_99_1.time_ <= var_102_12 + arg_102_0 then
				arg_99_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action4_2")
			end

			local var_102_13 = 0
			local var_102_14 = 0.175

			if var_102_13 < arg_99_1.time_ and arg_99_1.time_ <= var_102_13 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_15 = arg_99_1:FormatText(StoryNameCfg[319].name)

				arg_99_1.leftNameTxt_.text = var_102_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_16 = arg_99_1:GetWordFromCfg(121012024)
				local var_102_17 = arg_99_1:FormatText(var_102_16.content)

				arg_99_1.text_.text = var_102_17

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_18 = 7
				local var_102_19 = utf8.len(var_102_17)
				local var_102_20 = var_102_18 <= 0 and var_102_14 or var_102_14 * (var_102_19 / var_102_18)

				if var_102_20 > 0 and var_102_14 < var_102_20 then
					arg_99_1.talkMaxDuration = var_102_20

					if var_102_20 + var_102_13 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_20 + var_102_13
					end
				end

				arg_99_1.text_.text = var_102_17
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012024", "story_v_out_121012.awb") ~= 0 then
					local var_102_21 = manager.audio:GetVoiceLength("story_v_out_121012", "121012024", "story_v_out_121012.awb") / 1000

					if var_102_21 + var_102_13 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_21 + var_102_13
					end

					if var_102_16.prefab_name ~= "" and arg_99_1.actors_[var_102_16.prefab_name] ~= nil then
						local var_102_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_16.prefab_name].transform, "story_v_out_121012", "121012024", "story_v_out_121012.awb")

						arg_99_1:RecordAudio("121012024", var_102_22)
						arg_99_1:RecordAudio("121012024", var_102_22)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_121012", "121012024", "story_v_out_121012.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_121012", "121012024", "story_v_out_121012.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_23 = math.max(var_102_14, arg_99_1.talkMaxDuration)

			if var_102_13 <= arg_99_1.time_ and arg_99_1.time_ < var_102_13 + var_102_23 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_13) / var_102_23

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_13 + var_102_23 and arg_99_1.time_ < var_102_13 + var_102_23 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play121012025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 121012025
		arg_103_1.duration_ = 15.2

		local var_103_0 = {
			ja = 15.2,
			ko = 7.9,
			zh = 7.9
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
				arg_103_0:Play121012026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_106_2 = 0
			local var_106_3 = 1.075

			if var_106_2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_4 = arg_103_1:FormatText(StoryNameCfg[319].name)

				arg_103_1.leftNameTxt_.text = var_106_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_5 = arg_103_1:GetWordFromCfg(121012025)
				local var_106_6 = arg_103_1:FormatText(var_106_5.content)

				arg_103_1.text_.text = var_106_6

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 43
				local var_106_8 = utf8.len(var_106_6)
				local var_106_9 = var_106_7 <= 0 and var_106_3 or var_106_3 * (var_106_8 / var_106_7)

				if var_106_9 > 0 and var_106_3 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_2
					end
				end

				arg_103_1.text_.text = var_106_6
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012025", "story_v_out_121012.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_out_121012", "121012025", "story_v_out_121012.awb") / 1000

					if var_106_10 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_2
					end

					if var_106_5.prefab_name ~= "" and arg_103_1.actors_[var_106_5.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_5.prefab_name].transform, "story_v_out_121012", "121012025", "story_v_out_121012.awb")

						arg_103_1:RecordAudio("121012025", var_106_11)
						arg_103_1:RecordAudio("121012025", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_121012", "121012025", "story_v_out_121012.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_121012", "121012025", "story_v_out_121012.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_12 = math.max(var_106_3, arg_103_1.talkMaxDuration)

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_12 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_2) / var_106_12

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_2 + var_106_12 and arg_103_1.time_ < var_106_2 + var_106_12 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play121012026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 121012026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play121012027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1029ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1029ui_story == nil then
				arg_107_1.var_.characterEffect1029ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect1029ui_story and not isNil(var_110_0) then
					local var_110_4 = Mathf.Lerp(0, 0.5, var_110_3)

					arg_107_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1029ui_story.fillRatio = var_110_4
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1029ui_story then
				local var_110_5 = 0.5

				arg_107_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1029ui_story.fillRatio = var_110_5
			end

			local var_110_6 = 0
			local var_110_7 = 1

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				local var_110_8 = "stop"
				local var_110_9 = "effect"

				arg_107_1:AudioAction(var_110_8, var_110_9, "se_story_121_00", "se_story_121_00_dooropen_start", "")
			end

			local var_110_10 = 0
			local var_110_11 = 1.075

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_12 = arg_107_1:GetWordFromCfg(121012026)
				local var_110_13 = arg_107_1:FormatText(var_110_12.content)

				arg_107_1.text_.text = var_110_13

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_14 = 43
				local var_110_15 = utf8.len(var_110_13)
				local var_110_16 = var_110_14 <= 0 and var_110_11 or var_110_11 * (var_110_15 / var_110_14)

				if var_110_16 > 0 and var_110_11 < var_110_16 then
					arg_107_1.talkMaxDuration = var_110_16

					if var_110_16 + var_110_10 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_16 + var_110_10
					end
				end

				arg_107_1.text_.text = var_110_13
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_17 = math.max(var_110_11, arg_107_1.talkMaxDuration)

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_17 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_10) / var_110_17

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_10 + var_110_17 and arg_107_1.time_ < var_110_10 + var_110_17 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play121012027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 121012027
		arg_111_1.duration_ = 8.6

		local var_111_0 = {
			ja = 8.233,
			ko = 8.6,
			zh = 8.6
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play121012028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1029ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1029ui_story == nil then
				arg_111_1.var_.characterEffect1029ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1029ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1029ui_story then
				arg_111_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_114_4 = 0

			if var_114_4 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_114_5 = 0

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_114_6 = 0
			local var_114_7 = 0.95

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_8 = arg_111_1:FormatText(StoryNameCfg[319].name)

				arg_111_1.leftNameTxt_.text = var_114_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_9 = arg_111_1:GetWordFromCfg(121012027)
				local var_114_10 = arg_111_1:FormatText(var_114_9.content)

				arg_111_1.text_.text = var_114_10

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 38
				local var_114_12 = utf8.len(var_114_10)
				local var_114_13 = var_114_11 <= 0 and var_114_7 or var_114_7 * (var_114_12 / var_114_11)

				if var_114_13 > 0 and var_114_7 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_10
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012027", "story_v_out_121012.awb") ~= 0 then
					local var_114_14 = manager.audio:GetVoiceLength("story_v_out_121012", "121012027", "story_v_out_121012.awb") / 1000

					if var_114_14 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_6
					end

					if var_114_9.prefab_name ~= "" and arg_111_1.actors_[var_114_9.prefab_name] ~= nil then
						local var_114_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_9.prefab_name].transform, "story_v_out_121012", "121012027", "story_v_out_121012.awb")

						arg_111_1:RecordAudio("121012027", var_114_15)
						arg_111_1:RecordAudio("121012027", var_114_15)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_121012", "121012027", "story_v_out_121012.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_121012", "121012027", "story_v_out_121012.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_16 and arg_111_1.time_ < var_114_6 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play121012028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 121012028
		arg_115_1.duration_ = 9.97

		local var_115_0 = {
			ja = 9.966,
			ko = 9.266,
			zh = 9.266
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play121012029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.95

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[319].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(121012028)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 38
				local var_118_6 = utf8.len(var_118_4)
				local var_118_7 = var_118_5 <= 0 and var_118_1 or var_118_1 * (var_118_6 / var_118_5)

				if var_118_7 > 0 and var_118_1 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012028", "story_v_out_121012.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_121012", "121012028", "story_v_out_121012.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_121012", "121012028", "story_v_out_121012.awb")

						arg_115_1:RecordAudio("121012028", var_118_9)
						arg_115_1:RecordAudio("121012028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_121012", "121012028", "story_v_out_121012.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_121012", "121012028", "story_v_out_121012.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_10 and arg_115_1.time_ < var_118_0 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play121012029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 121012029
		arg_119_1.duration_ = 6.17

		local var_119_0 = {
			ja = 6.166,
			ko = 2.4,
			zh = 2.4
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play121012030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1076ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1076ui_story == nil then
				arg_119_1.var_.characterEffect1076ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1076ui_story and not isNil(var_122_0) then
					arg_119_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1076ui_story then
				arg_119_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_122_4 = 0

			if var_122_4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_122_5 = arg_119_1.actors_["1029ui_story"]
			local var_122_6 = 0

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1029ui_story == nil then
				arg_119_1.var_.characterEffect1029ui_story = var_122_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_7 = 0.200000002980232

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_7 and not isNil(var_122_5) then
				local var_122_8 = (arg_119_1.time_ - var_122_6) / var_122_7

				if arg_119_1.var_.characterEffect1029ui_story and not isNil(var_122_5) then
					local var_122_9 = Mathf.Lerp(0, 0.5, var_122_8)

					arg_119_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1029ui_story.fillRatio = var_122_9
				end
			end

			if arg_119_1.time_ >= var_122_6 + var_122_7 and arg_119_1.time_ < var_122_6 + var_122_7 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1029ui_story then
				local var_122_10 = 0.5

				arg_119_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1029ui_story.fillRatio = var_122_10
			end

			local var_122_11 = 0
			local var_122_12 = 0.25

			if var_122_11 < arg_119_1.time_ and arg_119_1.time_ <= var_122_11 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_13 = arg_119_1:FormatText(StoryNameCfg[389].name)

				arg_119_1.leftNameTxt_.text = var_122_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_14 = arg_119_1:GetWordFromCfg(121012029)
				local var_122_15 = arg_119_1:FormatText(var_122_14.content)

				arg_119_1.text_.text = var_122_15

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_16 = 10
				local var_122_17 = utf8.len(var_122_15)
				local var_122_18 = var_122_16 <= 0 and var_122_12 or var_122_12 * (var_122_17 / var_122_16)

				if var_122_18 > 0 and var_122_12 < var_122_18 then
					arg_119_1.talkMaxDuration = var_122_18

					if var_122_18 + var_122_11 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_18 + var_122_11
					end
				end

				arg_119_1.text_.text = var_122_15
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012029", "story_v_out_121012.awb") ~= 0 then
					local var_122_19 = manager.audio:GetVoiceLength("story_v_out_121012", "121012029", "story_v_out_121012.awb") / 1000

					if var_122_19 + var_122_11 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_19 + var_122_11
					end

					if var_122_14.prefab_name ~= "" and arg_119_1.actors_[var_122_14.prefab_name] ~= nil then
						local var_122_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_14.prefab_name].transform, "story_v_out_121012", "121012029", "story_v_out_121012.awb")

						arg_119_1:RecordAudio("121012029", var_122_20)
						arg_119_1:RecordAudio("121012029", var_122_20)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_121012", "121012029", "story_v_out_121012.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_121012", "121012029", "story_v_out_121012.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_21 = math.max(var_122_12, arg_119_1.talkMaxDuration)

			if var_122_11 <= arg_119_1.time_ and arg_119_1.time_ < var_122_11 + var_122_21 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_11) / var_122_21

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_11 + var_122_21 and arg_119_1.time_ < var_122_11 + var_122_21 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play121012030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 121012030
		arg_123_1.duration_ = 9.73

		local var_123_0 = {
			ja = 9.733,
			ko = 4.233,
			zh = 4.233
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play121012031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1029ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1029ui_story == nil then
				arg_123_1.var_.characterEffect1029ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1029ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1029ui_story then
				arg_123_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_126_4 = 0

			if var_126_4 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_2")
			end

			local var_126_5 = 0

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_6 = arg_123_1.actors_["1076ui_story"]
			local var_126_7 = 0

			if var_126_7 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect1076ui_story == nil then
				arg_123_1.var_.characterEffect1076ui_story = var_126_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_8 = 0.200000002980232

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_8 and not isNil(var_126_6) then
				local var_126_9 = (arg_123_1.time_ - var_126_7) / var_126_8

				if arg_123_1.var_.characterEffect1076ui_story and not isNil(var_126_6) then
					local var_126_10 = Mathf.Lerp(0, 0.5, var_126_9)

					arg_123_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1076ui_story.fillRatio = var_126_10
				end
			end

			if arg_123_1.time_ >= var_126_7 + var_126_8 and arg_123_1.time_ < var_126_7 + var_126_8 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect1076ui_story then
				local var_126_11 = 0.5

				arg_123_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1076ui_story.fillRatio = var_126_11
			end

			local var_126_12 = 0
			local var_126_13 = 0.4

			if var_126_12 < arg_123_1.time_ and arg_123_1.time_ <= var_126_12 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_14 = arg_123_1:FormatText(StoryNameCfg[319].name)

				arg_123_1.leftNameTxt_.text = var_126_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_15 = arg_123_1:GetWordFromCfg(121012030)
				local var_126_16 = arg_123_1:FormatText(var_126_15.content)

				arg_123_1.text_.text = var_126_16

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_17 = 16
				local var_126_18 = utf8.len(var_126_16)
				local var_126_19 = var_126_17 <= 0 and var_126_13 or var_126_13 * (var_126_18 / var_126_17)

				if var_126_19 > 0 and var_126_13 < var_126_19 then
					arg_123_1.talkMaxDuration = var_126_19

					if var_126_19 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_19 + var_126_12
					end
				end

				arg_123_1.text_.text = var_126_16
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012030", "story_v_out_121012.awb") ~= 0 then
					local var_126_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012030", "story_v_out_121012.awb") / 1000

					if var_126_20 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_20 + var_126_12
					end

					if var_126_15.prefab_name ~= "" and arg_123_1.actors_[var_126_15.prefab_name] ~= nil then
						local var_126_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_15.prefab_name].transform, "story_v_out_121012", "121012030", "story_v_out_121012.awb")

						arg_123_1:RecordAudio("121012030", var_126_21)
						arg_123_1:RecordAudio("121012030", var_126_21)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_121012", "121012030", "story_v_out_121012.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_121012", "121012030", "story_v_out_121012.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_22 = math.max(var_126_13, arg_123_1.talkMaxDuration)

			if var_126_12 <= arg_123_1.time_ and arg_123_1.time_ < var_126_12 + var_126_22 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_12) / var_126_22

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_12 + var_126_22 and arg_123_1.time_ < var_126_12 + var_126_22 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play121012031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 121012031
		arg_127_1.duration_ = 7.8

		local var_127_0 = {
			ja = 7.8,
			ko = 5.4,
			zh = 5.4
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play121012032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.575

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[319].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(121012031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012031", "story_v_out_121012.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_121012", "121012031", "story_v_out_121012.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_121012", "121012031", "story_v_out_121012.awb")

						arg_127_1:RecordAudio("121012031", var_130_9)
						arg_127_1:RecordAudio("121012031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_121012", "121012031", "story_v_out_121012.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_121012", "121012031", "story_v_out_121012.awb")
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
	Play121012032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 121012032
		arg_131_1.duration_ = 6.93

		local var_131_0 = {
			ja = 6.933,
			ko = 4.333,
			zh = 4.333
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play121012033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1076ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1076ui_story == nil then
				arg_131_1.var_.characterEffect1076ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1076ui_story and not isNil(var_134_0) then
					arg_131_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1076ui_story then
				arg_131_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_134_4 = 0

			if var_134_4 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_134_5 = 0

			if var_134_5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_6 = arg_131_1.actors_["1029ui_story"]
			local var_134_7 = 0

			if var_134_7 < arg_131_1.time_ and arg_131_1.time_ <= var_134_7 + arg_134_0 and not isNil(var_134_6) and arg_131_1.var_.characterEffect1029ui_story == nil then
				arg_131_1.var_.characterEffect1029ui_story = var_134_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_8 = 0.200000002980232

			if var_134_7 <= arg_131_1.time_ and arg_131_1.time_ < var_134_7 + var_134_8 and not isNil(var_134_6) then
				local var_134_9 = (arg_131_1.time_ - var_134_7) / var_134_8

				if arg_131_1.var_.characterEffect1029ui_story and not isNil(var_134_6) then
					local var_134_10 = Mathf.Lerp(0, 0.5, var_134_9)

					arg_131_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1029ui_story.fillRatio = var_134_10
				end
			end

			if arg_131_1.time_ >= var_134_7 + var_134_8 and arg_131_1.time_ < var_134_7 + var_134_8 + arg_134_0 and not isNil(var_134_6) and arg_131_1.var_.characterEffect1029ui_story then
				local var_134_11 = 0.5

				arg_131_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1029ui_story.fillRatio = var_134_11
			end

			local var_134_12 = 0
			local var_134_13 = 0.45

			if var_134_12 < arg_131_1.time_ and arg_131_1.time_ <= var_134_12 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_14 = arg_131_1:FormatText(StoryNameCfg[389].name)

				arg_131_1.leftNameTxt_.text = var_134_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_15 = arg_131_1:GetWordFromCfg(121012032)
				local var_134_16 = arg_131_1:FormatText(var_134_15.content)

				arg_131_1.text_.text = var_134_16

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_17 = 18
				local var_134_18 = utf8.len(var_134_16)
				local var_134_19 = var_134_17 <= 0 and var_134_13 or var_134_13 * (var_134_18 / var_134_17)

				if var_134_19 > 0 and var_134_13 < var_134_19 then
					arg_131_1.talkMaxDuration = var_134_19

					if var_134_19 + var_134_12 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_19 + var_134_12
					end
				end

				arg_131_1.text_.text = var_134_16
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012032", "story_v_out_121012.awb") ~= 0 then
					local var_134_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012032", "story_v_out_121012.awb") / 1000

					if var_134_20 + var_134_12 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_20 + var_134_12
					end

					if var_134_15.prefab_name ~= "" and arg_131_1.actors_[var_134_15.prefab_name] ~= nil then
						local var_134_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_15.prefab_name].transform, "story_v_out_121012", "121012032", "story_v_out_121012.awb")

						arg_131_1:RecordAudio("121012032", var_134_21)
						arg_131_1:RecordAudio("121012032", var_134_21)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_121012", "121012032", "story_v_out_121012.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_121012", "121012032", "story_v_out_121012.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_22 = math.max(var_134_13, arg_131_1.talkMaxDuration)

			if var_134_12 <= arg_131_1.time_ and arg_131_1.time_ < var_134_12 + var_134_22 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_12) / var_134_22

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_12 + var_134_22 and arg_131_1.time_ < var_134_12 + var_134_22 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play121012033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 121012033
		arg_135_1.duration_ = 6.67

		local var_135_0 = {
			ja = 6.666,
			ko = 4.666,
			zh = 4.666
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play121012034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1029ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1029ui_story == nil then
				arg_135_1.var_.characterEffect1029ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1029ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1029ui_story then
				arg_135_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_138_4 = 0

			if var_138_4 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_138_5 = 0

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_6 = arg_135_1.actors_["1076ui_story"]
			local var_138_7 = 0

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect1076ui_story == nil then
				arg_135_1.var_.characterEffect1076ui_story = var_138_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_8 = 0.200000002980232

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_8 and not isNil(var_138_6) then
				local var_138_9 = (arg_135_1.time_ - var_138_7) / var_138_8

				if arg_135_1.var_.characterEffect1076ui_story and not isNil(var_138_6) then
					local var_138_10 = Mathf.Lerp(0, 0.5, var_138_9)

					arg_135_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1076ui_story.fillRatio = var_138_10
				end
			end

			if arg_135_1.time_ >= var_138_7 + var_138_8 and arg_135_1.time_ < var_138_7 + var_138_8 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect1076ui_story then
				local var_138_11 = 0.5

				arg_135_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1076ui_story.fillRatio = var_138_11
			end

			local var_138_12 = 0
			local var_138_13 = 0.5

			if var_138_12 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_14 = arg_135_1:FormatText(StoryNameCfg[319].name)

				arg_135_1.leftNameTxt_.text = var_138_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_15 = arg_135_1:GetWordFromCfg(121012033)
				local var_138_16 = arg_135_1:FormatText(var_138_15.content)

				arg_135_1.text_.text = var_138_16

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_17 = 20
				local var_138_18 = utf8.len(var_138_16)
				local var_138_19 = var_138_17 <= 0 and var_138_13 or var_138_13 * (var_138_18 / var_138_17)

				if var_138_19 > 0 and var_138_13 < var_138_19 then
					arg_135_1.talkMaxDuration = var_138_19

					if var_138_19 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_19 + var_138_12
					end
				end

				arg_135_1.text_.text = var_138_16
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012033", "story_v_out_121012.awb") ~= 0 then
					local var_138_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012033", "story_v_out_121012.awb") / 1000

					if var_138_20 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_20 + var_138_12
					end

					if var_138_15.prefab_name ~= "" and arg_135_1.actors_[var_138_15.prefab_name] ~= nil then
						local var_138_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_15.prefab_name].transform, "story_v_out_121012", "121012033", "story_v_out_121012.awb")

						arg_135_1:RecordAudio("121012033", var_138_21)
						arg_135_1:RecordAudio("121012033", var_138_21)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_121012", "121012033", "story_v_out_121012.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_121012", "121012033", "story_v_out_121012.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_22 = math.max(var_138_13, arg_135_1.talkMaxDuration)

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_22 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_12) / var_138_22

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_12 + var_138_22 and arg_135_1.time_ < var_138_12 + var_138_22 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play121012034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 121012034
		arg_139_1.duration_ = 3.23

		local var_139_0 = {
			ja = 3.233,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play121012035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1076ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1076ui_story == nil then
				arg_139_1.var_.characterEffect1076ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1076ui_story and not isNil(var_142_0) then
					arg_139_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1076ui_story then
				arg_139_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_142_4 = 0

			if var_142_4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_1")
			end

			local var_142_5 = 0

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_6 = arg_139_1.actors_["1029ui_story"]
			local var_142_7 = 0

			if var_142_7 < arg_139_1.time_ and arg_139_1.time_ <= var_142_7 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1029ui_story == nil then
				arg_139_1.var_.characterEffect1029ui_story = var_142_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_8 = 0.200000002980232

			if var_142_7 <= arg_139_1.time_ and arg_139_1.time_ < var_142_7 + var_142_8 and not isNil(var_142_6) then
				local var_142_9 = (arg_139_1.time_ - var_142_7) / var_142_8

				if arg_139_1.var_.characterEffect1029ui_story and not isNil(var_142_6) then
					local var_142_10 = Mathf.Lerp(0, 0.5, var_142_9)

					arg_139_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1029ui_story.fillRatio = var_142_10
				end
			end

			if arg_139_1.time_ >= var_142_7 + var_142_8 and arg_139_1.time_ < var_142_7 + var_142_8 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1029ui_story then
				local var_142_11 = 0.5

				arg_139_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1029ui_story.fillRatio = var_142_11
			end

			local var_142_12 = 0
			local var_142_13 = 0.2

			if var_142_12 < arg_139_1.time_ and arg_139_1.time_ <= var_142_12 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_14 = arg_139_1:FormatText(StoryNameCfg[389].name)

				arg_139_1.leftNameTxt_.text = var_142_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_15 = arg_139_1:GetWordFromCfg(121012034)
				local var_142_16 = arg_139_1:FormatText(var_142_15.content)

				arg_139_1.text_.text = var_142_16

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_17 = 8
				local var_142_18 = utf8.len(var_142_16)
				local var_142_19 = var_142_17 <= 0 and var_142_13 or var_142_13 * (var_142_18 / var_142_17)

				if var_142_19 > 0 and var_142_13 < var_142_19 then
					arg_139_1.talkMaxDuration = var_142_19

					if var_142_19 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_19 + var_142_12
					end
				end

				arg_139_1.text_.text = var_142_16
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012034", "story_v_out_121012.awb") ~= 0 then
					local var_142_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012034", "story_v_out_121012.awb") / 1000

					if var_142_20 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_20 + var_142_12
					end

					if var_142_15.prefab_name ~= "" and arg_139_1.actors_[var_142_15.prefab_name] ~= nil then
						local var_142_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_15.prefab_name].transform, "story_v_out_121012", "121012034", "story_v_out_121012.awb")

						arg_139_1:RecordAudio("121012034", var_142_21)
						arg_139_1:RecordAudio("121012034", var_142_21)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_121012", "121012034", "story_v_out_121012.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_121012", "121012034", "story_v_out_121012.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_22 = math.max(var_142_13, arg_139_1.talkMaxDuration)

			if var_142_12 <= arg_139_1.time_ and arg_139_1.time_ < var_142_12 + var_142_22 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_12) / var_142_22

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_12 + var_142_22 and arg_139_1.time_ < var_142_12 + var_142_22 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play121012035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 121012035
		arg_143_1.duration_ = 14.3

		local var_143_0 = {
			ja = 14.3,
			ko = 11.566,
			zh = 11.566
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play121012036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_146_1 = 0
			local var_146_2 = 1.125

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_3 = arg_143_1:FormatText(StoryNameCfg[389].name)

				arg_143_1.leftNameTxt_.text = var_146_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(121012035)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_6 = 45
				local var_146_7 = utf8.len(var_146_5)
				local var_146_8 = var_146_6 <= 0 and var_146_2 or var_146_2 * (var_146_7 / var_146_6)

				if var_146_8 > 0 and var_146_2 < var_146_8 then
					arg_143_1.talkMaxDuration = var_146_8

					if var_146_8 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012035", "story_v_out_121012.awb") ~= 0 then
					local var_146_9 = manager.audio:GetVoiceLength("story_v_out_121012", "121012035", "story_v_out_121012.awb") / 1000

					if var_146_9 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_1
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_out_121012", "121012035", "story_v_out_121012.awb")

						arg_143_1:RecordAudio("121012035", var_146_10)
						arg_143_1:RecordAudio("121012035", var_146_10)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_121012", "121012035", "story_v_out_121012.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_121012", "121012035", "story_v_out_121012.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_11 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_11 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_11

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_11 and arg_143_1.time_ < var_146_1 + var_146_11 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play121012036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 121012036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play121012037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1029ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1029ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0, 100, 0)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1029ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0, 100, 0)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["1029ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1029ui_story == nil then
				arg_147_1.var_.characterEffect1029ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect1029ui_story and not isNil(var_150_9) then
					local var_150_13 = Mathf.Lerp(0, 0.5, var_150_12)

					arg_147_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1029ui_story.fillRatio = var_150_13
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1029ui_story then
				local var_150_14 = 0.5

				arg_147_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1029ui_story.fillRatio = var_150_14
			end

			local var_150_15 = arg_147_1.actors_["1076ui_story"].transform
			local var_150_16 = 0

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.var_.moveOldPos1076ui_story = var_150_15.localPosition
			end

			local var_150_17 = 0.001

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_17 then
				local var_150_18 = (arg_147_1.time_ - var_150_16) / var_150_17
				local var_150_19 = Vector3.New(0, 100, 0)

				var_150_15.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1076ui_story, var_150_19, var_150_18)

				local var_150_20 = manager.ui.mainCamera.transform.position - var_150_15.position

				var_150_15.forward = Vector3.New(var_150_20.x, var_150_20.y, var_150_20.z)

				local var_150_21 = var_150_15.localEulerAngles

				var_150_21.z = 0
				var_150_21.x = 0
				var_150_15.localEulerAngles = var_150_21
			end

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 then
				var_150_15.localPosition = Vector3.New(0, 100, 0)

				local var_150_22 = manager.ui.mainCamera.transform.position - var_150_15.position

				var_150_15.forward = Vector3.New(var_150_22.x, var_150_22.y, var_150_22.z)

				local var_150_23 = var_150_15.localEulerAngles

				var_150_23.z = 0
				var_150_23.x = 0
				var_150_15.localEulerAngles = var_150_23
			end

			local var_150_24 = arg_147_1.actors_["1076ui_story"]
			local var_150_25 = 0

			if var_150_25 < arg_147_1.time_ and arg_147_1.time_ <= var_150_25 + arg_150_0 and not isNil(var_150_24) and arg_147_1.var_.characterEffect1076ui_story == nil then
				arg_147_1.var_.characterEffect1076ui_story = var_150_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_26 = 0.200000002980232

			if var_150_25 <= arg_147_1.time_ and arg_147_1.time_ < var_150_25 + var_150_26 and not isNil(var_150_24) then
				local var_150_27 = (arg_147_1.time_ - var_150_25) / var_150_26

				if arg_147_1.var_.characterEffect1076ui_story and not isNil(var_150_24) then
					local var_150_28 = Mathf.Lerp(0, 0.5, var_150_27)

					arg_147_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1076ui_story.fillRatio = var_150_28
				end
			end

			if arg_147_1.time_ >= var_150_25 + var_150_26 and arg_147_1.time_ < var_150_25 + var_150_26 + arg_150_0 and not isNil(var_150_24) and arg_147_1.var_.characterEffect1076ui_story then
				local var_150_29 = 0.5

				arg_147_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1076ui_story.fillRatio = var_150_29
			end

			local var_150_30 = 0
			local var_150_31 = 0.95

			if var_150_30 < arg_147_1.time_ and arg_147_1.time_ <= var_150_30 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_32 = arg_147_1:GetWordFromCfg(121012036)
				local var_150_33 = arg_147_1:FormatText(var_150_32.content)

				arg_147_1.text_.text = var_150_33

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_34 = 38
				local var_150_35 = utf8.len(var_150_33)
				local var_150_36 = var_150_34 <= 0 and var_150_31 or var_150_31 * (var_150_35 / var_150_34)

				if var_150_36 > 0 and var_150_31 < var_150_36 then
					arg_147_1.talkMaxDuration = var_150_36

					if var_150_36 + var_150_30 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_36 + var_150_30
					end
				end

				arg_147_1.text_.text = var_150_33
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_37 = math.max(var_150_31, arg_147_1.talkMaxDuration)

			if var_150_30 <= arg_147_1.time_ and arg_147_1.time_ < var_150_30 + var_150_37 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_30) / var_150_37

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_30 + var_150_37 and arg_147_1.time_ < var_150_30 + var_150_37 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play121012037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 121012037
		arg_151_1.duration_ = 10.3

		local var_151_0 = {
			ja = 10.3,
			ko = 7.3,
			zh = 7.3
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play121012038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1076ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos1076ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0.7, -1.06, -6.2)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1076ui_story, var_154_4, var_154_3)

				local var_154_5 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_5.x, var_154_5.y, var_154_5.z)

				local var_154_6 = var_154_0.localEulerAngles

				var_154_6.z = 0
				var_154_6.x = 0
				var_154_0.localEulerAngles = var_154_6
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_154_7 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_7.x, var_154_7.y, var_154_7.z)

				local var_154_8 = var_154_0.localEulerAngles

				var_154_8.z = 0
				var_154_8.x = 0
				var_154_0.localEulerAngles = var_154_8
			end

			local var_154_9 = arg_151_1.actors_["1076ui_story"]
			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect1076ui_story == nil then
				arg_151_1.var_.characterEffect1076ui_story = var_154_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_11 = 0.200000002980232

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_11 and not isNil(var_154_9) then
				local var_154_12 = (arg_151_1.time_ - var_154_10) / var_154_11

				if arg_151_1.var_.characterEffect1076ui_story and not isNil(var_154_9) then
					arg_151_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_10 + var_154_11 and arg_151_1.time_ < var_154_10 + var_154_11 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect1076ui_story then
				arg_151_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_154_13 = 0

			if var_154_13 < arg_151_1.time_ and arg_151_1.time_ <= var_154_13 + arg_154_0 then
				arg_151_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_154_14 = arg_151_1.actors_["1029ui_story"].transform
			local var_154_15 = 0

			if var_154_15 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 then
				arg_151_1.var_.moveOldPos1029ui_story = var_154_14.localPosition
			end

			local var_154_16 = 0.001

			if var_154_15 <= arg_151_1.time_ and arg_151_1.time_ < var_154_15 + var_154_16 then
				local var_154_17 = (arg_151_1.time_ - var_154_15) / var_154_16
				local var_154_18 = Vector3.New(-0.7, -1.09, -6.2)

				var_154_14.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1029ui_story, var_154_18, var_154_17)

				local var_154_19 = manager.ui.mainCamera.transform.position - var_154_14.position

				var_154_14.forward = Vector3.New(var_154_19.x, var_154_19.y, var_154_19.z)

				local var_154_20 = var_154_14.localEulerAngles

				var_154_20.z = 0
				var_154_20.x = 0
				var_154_14.localEulerAngles = var_154_20
			end

			if arg_151_1.time_ >= var_154_15 + var_154_16 and arg_151_1.time_ < var_154_15 + var_154_16 + arg_154_0 then
				var_154_14.localPosition = Vector3.New(-0.7, -1.09, -6.2)

				local var_154_21 = manager.ui.mainCamera.transform.position - var_154_14.position

				var_154_14.forward = Vector3.New(var_154_21.x, var_154_21.y, var_154_21.z)

				local var_154_22 = var_154_14.localEulerAngles

				var_154_22.z = 0
				var_154_22.x = 0
				var_154_14.localEulerAngles = var_154_22
			end

			local var_154_23 = 0
			local var_154_24 = 0.625

			if var_154_23 < arg_151_1.time_ and arg_151_1.time_ <= var_154_23 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_25 = arg_151_1:FormatText(StoryNameCfg[389].name)

				arg_151_1.leftNameTxt_.text = var_154_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_26 = arg_151_1:GetWordFromCfg(121012037)
				local var_154_27 = arg_151_1:FormatText(var_154_26.content)

				arg_151_1.text_.text = var_154_27

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_28 = 25
				local var_154_29 = utf8.len(var_154_27)
				local var_154_30 = var_154_28 <= 0 and var_154_24 or var_154_24 * (var_154_29 / var_154_28)

				if var_154_30 > 0 and var_154_24 < var_154_30 then
					arg_151_1.talkMaxDuration = var_154_30

					if var_154_30 + var_154_23 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_30 + var_154_23
					end
				end

				arg_151_1.text_.text = var_154_27
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012037", "story_v_out_121012.awb") ~= 0 then
					local var_154_31 = manager.audio:GetVoiceLength("story_v_out_121012", "121012037", "story_v_out_121012.awb") / 1000

					if var_154_31 + var_154_23 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_31 + var_154_23
					end

					if var_154_26.prefab_name ~= "" and arg_151_1.actors_[var_154_26.prefab_name] ~= nil then
						local var_154_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_26.prefab_name].transform, "story_v_out_121012", "121012037", "story_v_out_121012.awb")

						arg_151_1:RecordAudio("121012037", var_154_32)
						arg_151_1:RecordAudio("121012037", var_154_32)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_121012", "121012037", "story_v_out_121012.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_121012", "121012037", "story_v_out_121012.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_33 = math.max(var_154_24, arg_151_1.talkMaxDuration)

			if var_154_23 <= arg_151_1.time_ and arg_151_1.time_ < var_154_23 + var_154_33 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_23) / var_154_33

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_23 + var_154_33 and arg_151_1.time_ < var_154_23 + var_154_33 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play121012038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 121012038
		arg_155_1.duration_ = 11.73

		local var_155_0 = {
			ja = 11.366,
			ko = 11.733,
			zh = 11.733
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play121012039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_2")
			end

			local var_158_2 = 0
			local var_158_3 = 1.2

			if var_158_2 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_4 = arg_155_1:FormatText(StoryNameCfg[389].name)

				arg_155_1.leftNameTxt_.text = var_158_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_5 = arg_155_1:GetWordFromCfg(121012038)
				local var_158_6 = arg_155_1:FormatText(var_158_5.content)

				arg_155_1.text_.text = var_158_6

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 46
				local var_158_8 = utf8.len(var_158_6)
				local var_158_9 = var_158_7 <= 0 and var_158_3 or var_158_3 * (var_158_8 / var_158_7)

				if var_158_9 > 0 and var_158_3 < var_158_9 then
					arg_155_1.talkMaxDuration = var_158_9

					if var_158_9 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_6
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012038", "story_v_out_121012.awb") ~= 0 then
					local var_158_10 = manager.audio:GetVoiceLength("story_v_out_121012", "121012038", "story_v_out_121012.awb") / 1000

					if var_158_10 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_2
					end

					if var_158_5.prefab_name ~= "" and arg_155_1.actors_[var_158_5.prefab_name] ~= nil then
						local var_158_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_5.prefab_name].transform, "story_v_out_121012", "121012038", "story_v_out_121012.awb")

						arg_155_1:RecordAudio("121012038", var_158_11)
						arg_155_1:RecordAudio("121012038", var_158_11)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_121012", "121012038", "story_v_out_121012.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_121012", "121012038", "story_v_out_121012.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_12 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_12 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_12

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_12 and arg_155_1.time_ < var_158_2 + var_158_12 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play121012039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 121012039
		arg_159_1.duration_ = 10.57

		local var_159_0 = {
			ja = 10.566,
			ko = 5.8,
			zh = 5.8
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play121012040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1029ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1029ui_story == nil then
				arg_159_1.var_.characterEffect1029ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1029ui_story and not isNil(var_162_0) then
					arg_159_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1029ui_story then
				arg_159_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_162_4 = 0

			if var_162_4 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_162_5 = 0

			if var_162_5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_162_6 = arg_159_1.actors_["1076ui_story"]
			local var_162_7 = 0

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect1076ui_story == nil then
				arg_159_1.var_.characterEffect1076ui_story = var_162_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_8 = 0.200000002980232

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_8 and not isNil(var_162_6) then
				local var_162_9 = (arg_159_1.time_ - var_162_7) / var_162_8

				if arg_159_1.var_.characterEffect1076ui_story and not isNil(var_162_6) then
					local var_162_10 = Mathf.Lerp(0, 0.5, var_162_9)

					arg_159_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1076ui_story.fillRatio = var_162_10
				end
			end

			if arg_159_1.time_ >= var_162_7 + var_162_8 and arg_159_1.time_ < var_162_7 + var_162_8 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect1076ui_story then
				local var_162_11 = 0.5

				arg_159_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1076ui_story.fillRatio = var_162_11
			end

			local var_162_12 = 0
			local var_162_13 = 0.5

			if var_162_12 < arg_159_1.time_ and arg_159_1.time_ <= var_162_12 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_14 = arg_159_1:FormatText(StoryNameCfg[319].name)

				arg_159_1.leftNameTxt_.text = var_162_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_15 = arg_159_1:GetWordFromCfg(121012039)
				local var_162_16 = arg_159_1:FormatText(var_162_15.content)

				arg_159_1.text_.text = var_162_16

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_17 = 20
				local var_162_18 = utf8.len(var_162_16)
				local var_162_19 = var_162_17 <= 0 and var_162_13 or var_162_13 * (var_162_18 / var_162_17)

				if var_162_19 > 0 and var_162_13 < var_162_19 then
					arg_159_1.talkMaxDuration = var_162_19

					if var_162_19 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_19 + var_162_12
					end
				end

				arg_159_1.text_.text = var_162_16
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012039", "story_v_out_121012.awb") ~= 0 then
					local var_162_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012039", "story_v_out_121012.awb") / 1000

					if var_162_20 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_20 + var_162_12
					end

					if var_162_15.prefab_name ~= "" and arg_159_1.actors_[var_162_15.prefab_name] ~= nil then
						local var_162_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_15.prefab_name].transform, "story_v_out_121012", "121012039", "story_v_out_121012.awb")

						arg_159_1:RecordAudio("121012039", var_162_21)
						arg_159_1:RecordAudio("121012039", var_162_21)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_121012", "121012039", "story_v_out_121012.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_121012", "121012039", "story_v_out_121012.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_22 = math.max(var_162_13, arg_159_1.talkMaxDuration)

			if var_162_12 <= arg_159_1.time_ and arg_159_1.time_ < var_162_12 + var_162_22 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_12) / var_162_22

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_12 + var_162_22 and arg_159_1.time_ < var_162_12 + var_162_22 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play121012040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 121012040
		arg_163_1.duration_ = 5.4

		local var_163_0 = {
			ja = 5.4,
			ko = 2.133,
			zh = 2.133
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play121012041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1076ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1076ui_story == nil then
				arg_163_1.var_.characterEffect1076ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1076ui_story and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1076ui_story then
				arg_163_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_166_4 = 0

			if var_166_4 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_166_5 = 0

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_166_6 = arg_163_1.actors_["1029ui_story"]
			local var_166_7 = 0

			if var_166_7 < arg_163_1.time_ and arg_163_1.time_ <= var_166_7 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect1029ui_story == nil then
				arg_163_1.var_.characterEffect1029ui_story = var_166_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_8 = 0.200000002980232

			if var_166_7 <= arg_163_1.time_ and arg_163_1.time_ < var_166_7 + var_166_8 and not isNil(var_166_6) then
				local var_166_9 = (arg_163_1.time_ - var_166_7) / var_166_8

				if arg_163_1.var_.characterEffect1029ui_story and not isNil(var_166_6) then
					local var_166_10 = Mathf.Lerp(0, 0.5, var_166_9)

					arg_163_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1029ui_story.fillRatio = var_166_10
				end
			end

			if arg_163_1.time_ >= var_166_7 + var_166_8 and arg_163_1.time_ < var_166_7 + var_166_8 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect1029ui_story then
				local var_166_11 = 0.5

				arg_163_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1029ui_story.fillRatio = var_166_11
			end

			local var_166_12 = 0
			local var_166_13 = 0.25

			if var_166_12 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_14 = arg_163_1:FormatText(StoryNameCfg[389].name)

				arg_163_1.leftNameTxt_.text = var_166_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_15 = arg_163_1:GetWordFromCfg(121012040)
				local var_166_16 = arg_163_1:FormatText(var_166_15.content)

				arg_163_1.text_.text = var_166_16

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_17 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012040", "story_v_out_121012.awb") ~= 0 then
					local var_166_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012040", "story_v_out_121012.awb") / 1000

					if var_166_20 + var_166_12 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_20 + var_166_12
					end

					if var_166_15.prefab_name ~= "" and arg_163_1.actors_[var_166_15.prefab_name] ~= nil then
						local var_166_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_15.prefab_name].transform, "story_v_out_121012", "121012040", "story_v_out_121012.awb")

						arg_163_1:RecordAudio("121012040", var_166_21)
						arg_163_1:RecordAudio("121012040", var_166_21)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_121012", "121012040", "story_v_out_121012.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_121012", "121012040", "story_v_out_121012.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_22 = math.max(var_166_13, arg_163_1.talkMaxDuration)

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_22 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_12) / var_166_22

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_12 + var_166_22 and arg_163_1.time_ < var_166_12 + var_166_22 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play121012041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 121012041
		arg_167_1.duration_ = 9.6

		local var_167_0 = {
			ja = 9.6,
			ko = 6.566,
			zh = 6.566
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play121012042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1029ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1029ui_story == nil then
				arg_167_1.var_.characterEffect1029ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect1029ui_story and not isNil(var_170_0) then
					arg_167_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1029ui_story then
				arg_167_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_170_4 = 0

			if var_170_4 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action2_1")
			end

			local var_170_5 = 0

			if var_170_5 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_170_6 = arg_167_1.actors_["1076ui_story"]
			local var_170_7 = 0

			if var_170_7 < arg_167_1.time_ and arg_167_1.time_ <= var_170_7 + arg_170_0 and not isNil(var_170_6) and arg_167_1.var_.characterEffect1076ui_story == nil then
				arg_167_1.var_.characterEffect1076ui_story = var_170_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_8 = 0.200000002980232

			if var_170_7 <= arg_167_1.time_ and arg_167_1.time_ < var_170_7 + var_170_8 and not isNil(var_170_6) then
				local var_170_9 = (arg_167_1.time_ - var_170_7) / var_170_8

				if arg_167_1.var_.characterEffect1076ui_story and not isNil(var_170_6) then
					local var_170_10 = Mathf.Lerp(0, 0.5, var_170_9)

					arg_167_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1076ui_story.fillRatio = var_170_10
				end
			end

			if arg_167_1.time_ >= var_170_7 + var_170_8 and arg_167_1.time_ < var_170_7 + var_170_8 + arg_170_0 and not isNil(var_170_6) and arg_167_1.var_.characterEffect1076ui_story then
				local var_170_11 = 0.5

				arg_167_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1076ui_story.fillRatio = var_170_11
			end

			local var_170_12 = 0
			local var_170_13 = 0.675

			if var_170_12 < arg_167_1.time_ and arg_167_1.time_ <= var_170_12 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_14 = arg_167_1:FormatText(StoryNameCfg[319].name)

				arg_167_1.leftNameTxt_.text = var_170_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_15 = arg_167_1:GetWordFromCfg(121012041)
				local var_170_16 = arg_167_1:FormatText(var_170_15.content)

				arg_167_1.text_.text = var_170_16

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_17 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012041", "story_v_out_121012.awb") ~= 0 then
					local var_170_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012041", "story_v_out_121012.awb") / 1000

					if var_170_20 + var_170_12 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_20 + var_170_12
					end

					if var_170_15.prefab_name ~= "" and arg_167_1.actors_[var_170_15.prefab_name] ~= nil then
						local var_170_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_15.prefab_name].transform, "story_v_out_121012", "121012041", "story_v_out_121012.awb")

						arg_167_1:RecordAudio("121012041", var_170_21)
						arg_167_1:RecordAudio("121012041", var_170_21)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_121012", "121012041", "story_v_out_121012.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_121012", "121012041", "story_v_out_121012.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_22 = math.max(var_170_13, arg_167_1.talkMaxDuration)

			if var_170_12 <= arg_167_1.time_ and arg_167_1.time_ < var_170_12 + var_170_22 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_12) / var_170_22

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_12 + var_170_22 and arg_167_1.time_ < var_170_12 + var_170_22 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play121012042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 121012042
		arg_171_1.duration_ = 11.1

		local var_171_0 = {
			ja = 11.1,
			ko = 7.8,
			zh = 7.8
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play121012043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.975

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[319].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(121012042)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 39
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012042", "story_v_out_121012.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_121012", "121012042", "story_v_out_121012.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_121012", "121012042", "story_v_out_121012.awb")

						arg_171_1:RecordAudio("121012042", var_174_9)
						arg_171_1:RecordAudio("121012042", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_121012", "121012042", "story_v_out_121012.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_121012", "121012042", "story_v_out_121012.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play121012043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 121012043
		arg_175_1.duration_ = 13.13

		local var_175_0 = {
			ja = 13.133,
			ko = 9.966,
			zh = 9.966
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play121012044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 1.1

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[319].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:GetWordFromCfg(121012043)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012043", "story_v_out_121012.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_121012", "121012043", "story_v_out_121012.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_121012", "121012043", "story_v_out_121012.awb")

						arg_175_1:RecordAudio("121012043", var_178_9)
						arg_175_1:RecordAudio("121012043", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_121012", "121012043", "story_v_out_121012.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_121012", "121012043", "story_v_out_121012.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_10 and arg_175_1.time_ < var_178_0 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play121012044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 121012044
		arg_179_1.duration_ = 7.07

		local var_179_0 = {
			ja = 7.066,
			ko = 3.033,
			zh = 3.033
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play121012045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1076ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1076ui_story == nil then
				arg_179_1.var_.characterEffect1076ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect1076ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1076ui_story then
				arg_179_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_182_4 = 0

			if var_182_4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_182_5 = 0

			if var_182_5 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_182_6 = arg_179_1.actors_["1029ui_story"]
			local var_182_7 = 0

			if var_182_7 < arg_179_1.time_ and arg_179_1.time_ <= var_182_7 + arg_182_0 and not isNil(var_182_6) and arg_179_1.var_.characterEffect1029ui_story == nil then
				arg_179_1.var_.characterEffect1029ui_story = var_182_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_8 = 0.200000002980232

			if var_182_7 <= arg_179_1.time_ and arg_179_1.time_ < var_182_7 + var_182_8 and not isNil(var_182_6) then
				local var_182_9 = (arg_179_1.time_ - var_182_7) / var_182_8

				if arg_179_1.var_.characterEffect1029ui_story and not isNil(var_182_6) then
					local var_182_10 = Mathf.Lerp(0, 0.5, var_182_9)

					arg_179_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1029ui_story.fillRatio = var_182_10
				end
			end

			if arg_179_1.time_ >= var_182_7 + var_182_8 and arg_179_1.time_ < var_182_7 + var_182_8 + arg_182_0 and not isNil(var_182_6) and arg_179_1.var_.characterEffect1029ui_story then
				local var_182_11 = 0.5

				arg_179_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1029ui_story.fillRatio = var_182_11
			end

			local var_182_12 = 0
			local var_182_13 = 0.4

			if var_182_12 < arg_179_1.time_ and arg_179_1.time_ <= var_182_12 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_14 = arg_179_1:FormatText(StoryNameCfg[389].name)

				arg_179_1.leftNameTxt_.text = var_182_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_15 = arg_179_1:GetWordFromCfg(121012044)
				local var_182_16 = arg_179_1:FormatText(var_182_15.content)

				arg_179_1.text_.text = var_182_16

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_17 = 16
				local var_182_18 = utf8.len(var_182_16)
				local var_182_19 = var_182_17 <= 0 and var_182_13 or var_182_13 * (var_182_18 / var_182_17)

				if var_182_19 > 0 and var_182_13 < var_182_19 then
					arg_179_1.talkMaxDuration = var_182_19

					if var_182_19 + var_182_12 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_19 + var_182_12
					end
				end

				arg_179_1.text_.text = var_182_16
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012044", "story_v_out_121012.awb") ~= 0 then
					local var_182_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012044", "story_v_out_121012.awb") / 1000

					if var_182_20 + var_182_12 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_20 + var_182_12
					end

					if var_182_15.prefab_name ~= "" and arg_179_1.actors_[var_182_15.prefab_name] ~= nil then
						local var_182_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_15.prefab_name].transform, "story_v_out_121012", "121012044", "story_v_out_121012.awb")

						arg_179_1:RecordAudio("121012044", var_182_21)
						arg_179_1:RecordAudio("121012044", var_182_21)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_121012", "121012044", "story_v_out_121012.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_121012", "121012044", "story_v_out_121012.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_22 = math.max(var_182_13, arg_179_1.talkMaxDuration)

			if var_182_12 <= arg_179_1.time_ and arg_179_1.time_ < var_182_12 + var_182_22 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_12) / var_182_22

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_12 + var_182_22 and arg_179_1.time_ < var_182_12 + var_182_22 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play121012045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 121012045
		arg_183_1.duration_ = 15.83

		local var_183_0 = {
			ja = 15.833,
			ko = 10.466,
			zh = 10.466
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play121012046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1029ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1029ui_story == nil then
				arg_183_1.var_.characterEffect1029ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1029ui_story and not isNil(var_186_0) then
					arg_183_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1029ui_story then
				arg_183_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_186_4 = 0

			if var_186_4 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_186_5 = arg_183_1.actors_["1076ui_story"]
			local var_186_6 = 0

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.characterEffect1076ui_story == nil then
				arg_183_1.var_.characterEffect1076ui_story = var_186_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_7 = 0.200000002980232

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_7 and not isNil(var_186_5) then
				local var_186_8 = (arg_183_1.time_ - var_186_6) / var_186_7

				if arg_183_1.var_.characterEffect1076ui_story and not isNil(var_186_5) then
					local var_186_9 = Mathf.Lerp(0, 0.5, var_186_8)

					arg_183_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1076ui_story.fillRatio = var_186_9
				end
			end

			if arg_183_1.time_ >= var_186_6 + var_186_7 and arg_183_1.time_ < var_186_6 + var_186_7 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.characterEffect1076ui_story then
				local var_186_10 = 0.5

				arg_183_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1076ui_story.fillRatio = var_186_10
			end

			local var_186_11 = 0

			if var_186_11 < arg_183_1.time_ and arg_183_1.time_ <= var_186_11 + arg_186_0 then
				arg_183_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action424")
			end

			local var_186_12 = 0
			local var_186_13 = 1.075

			if var_186_12 < arg_183_1.time_ and arg_183_1.time_ <= var_186_12 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_14 = arg_183_1:FormatText(StoryNameCfg[319].name)

				arg_183_1.leftNameTxt_.text = var_186_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_15 = arg_183_1:GetWordFromCfg(121012045)
				local var_186_16 = arg_183_1:FormatText(var_186_15.content)

				arg_183_1.text_.text = var_186_16

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_17 = 43
				local var_186_18 = utf8.len(var_186_16)
				local var_186_19 = var_186_17 <= 0 and var_186_13 or var_186_13 * (var_186_18 / var_186_17)

				if var_186_19 > 0 and var_186_13 < var_186_19 then
					arg_183_1.talkMaxDuration = var_186_19

					if var_186_19 + var_186_12 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_19 + var_186_12
					end
				end

				arg_183_1.text_.text = var_186_16
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012045", "story_v_out_121012.awb") ~= 0 then
					local var_186_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012045", "story_v_out_121012.awb") / 1000

					if var_186_20 + var_186_12 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_20 + var_186_12
					end

					if var_186_15.prefab_name ~= "" and arg_183_1.actors_[var_186_15.prefab_name] ~= nil then
						local var_186_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_15.prefab_name].transform, "story_v_out_121012", "121012045", "story_v_out_121012.awb")

						arg_183_1:RecordAudio("121012045", var_186_21)
						arg_183_1:RecordAudio("121012045", var_186_21)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_121012", "121012045", "story_v_out_121012.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_121012", "121012045", "story_v_out_121012.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_22 = math.max(var_186_13, arg_183_1.talkMaxDuration)

			if var_186_12 <= arg_183_1.time_ and arg_183_1.time_ < var_186_12 + var_186_22 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_12) / var_186_22

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_12 + var_186_22 and arg_183_1.time_ < var_186_12 + var_186_22 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play121012046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 121012046
		arg_187_1.duration_ = 10.93

		local var_187_0 = {
			ja = 6.4,
			ko = 10.933,
			zh = 10.933
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
				arg_187_0:Play121012047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 1.45

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[319].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:GetWordFromCfg(121012046)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 58
				local var_190_6 = utf8.len(var_190_4)
				local var_190_7 = var_190_5 <= 0 and var_190_1 or var_190_1 * (var_190_6 / var_190_5)

				if var_190_7 > 0 and var_190_1 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012046", "story_v_out_121012.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_121012", "121012046", "story_v_out_121012.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_121012", "121012046", "story_v_out_121012.awb")

						arg_187_1:RecordAudio("121012046", var_190_9)
						arg_187_1:RecordAudio("121012046", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_121012", "121012046", "story_v_out_121012.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_121012", "121012046", "story_v_out_121012.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_10 and arg_187_1.time_ < var_190_0 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play121012047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 121012047
		arg_191_1.duration_ = 6.93

		local var_191_0 = {
			ja = 6.933,
			ko = 6.566,
			zh = 6.566
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play121012048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_1 = 0
			local var_194_2 = 0.85

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_3 = arg_191_1:FormatText(StoryNameCfg[319].name)

				arg_191_1.leftNameTxt_.text = var_194_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(121012047)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_6 = 34
				local var_194_7 = utf8.len(var_194_5)
				local var_194_8 = var_194_6 <= 0 and var_194_2 or var_194_2 * (var_194_7 / var_194_6)

				if var_194_8 > 0 and var_194_2 < var_194_8 then
					arg_191_1.talkMaxDuration = var_194_8

					if var_194_8 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012047", "story_v_out_121012.awb") ~= 0 then
					local var_194_9 = manager.audio:GetVoiceLength("story_v_out_121012", "121012047", "story_v_out_121012.awb") / 1000

					if var_194_9 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_1
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_out_121012", "121012047", "story_v_out_121012.awb")

						arg_191_1:RecordAudio("121012047", var_194_10)
						arg_191_1:RecordAudio("121012047", var_194_10)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_121012", "121012047", "story_v_out_121012.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_121012", "121012047", "story_v_out_121012.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_11 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_11 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_11

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_11 and arg_191_1.time_ < var_194_1 + var_194_11 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play121012048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 121012048
		arg_195_1.duration_ = 12.33

		local var_195_0 = {
			ja = 12.333,
			ko = 7.333,
			zh = 7.333
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
				arg_195_0:Play121012049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.75

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[319].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_3 = arg_195_1:GetWordFromCfg(121012048)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 30
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012048", "story_v_out_121012.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_121012", "121012048", "story_v_out_121012.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_121012", "121012048", "story_v_out_121012.awb")

						arg_195_1:RecordAudio("121012048", var_198_9)
						arg_195_1:RecordAudio("121012048", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_121012", "121012048", "story_v_out_121012.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_121012", "121012048", "story_v_out_121012.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_10 and arg_195_1.time_ < var_198_0 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play121012049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 121012049
		arg_199_1.duration_ = 14.53

		local var_199_0 = {
			ja = 14.533,
			ko = 9.166,
			zh = 9.166
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
				arg_199_0:Play121012050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1076ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1076ui_story == nil then
				arg_199_1.var_.characterEffect1076ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1076ui_story and not isNil(var_202_0) then
					arg_199_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1076ui_story then
				arg_199_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_202_4 = 0

			if var_202_4 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_202_5 = 0

			if var_202_5 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_202_6 = arg_199_1.actors_["1029ui_story"]
			local var_202_7 = 0

			if var_202_7 < arg_199_1.time_ and arg_199_1.time_ <= var_202_7 + arg_202_0 and not isNil(var_202_6) and arg_199_1.var_.characterEffect1029ui_story == nil then
				arg_199_1.var_.characterEffect1029ui_story = var_202_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_8 = 0.200000002980232

			if var_202_7 <= arg_199_1.time_ and arg_199_1.time_ < var_202_7 + var_202_8 and not isNil(var_202_6) then
				local var_202_9 = (arg_199_1.time_ - var_202_7) / var_202_8

				if arg_199_1.var_.characterEffect1029ui_story and not isNil(var_202_6) then
					local var_202_10 = Mathf.Lerp(0, 0.5, var_202_9)

					arg_199_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1029ui_story.fillRatio = var_202_10
				end
			end

			if arg_199_1.time_ >= var_202_7 + var_202_8 and arg_199_1.time_ < var_202_7 + var_202_8 + arg_202_0 and not isNil(var_202_6) and arg_199_1.var_.characterEffect1029ui_story then
				local var_202_11 = 0.5

				arg_199_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1029ui_story.fillRatio = var_202_11
			end

			local var_202_12 = 0
			local var_202_13 = 0.825

			if var_202_12 < arg_199_1.time_ and arg_199_1.time_ <= var_202_12 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_14 = arg_199_1:FormatText(StoryNameCfg[389].name)

				arg_199_1.leftNameTxt_.text = var_202_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_15 = arg_199_1:GetWordFromCfg(121012049)
				local var_202_16 = arg_199_1:FormatText(var_202_15.content)

				arg_199_1.text_.text = var_202_16

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_17 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012049", "story_v_out_121012.awb") ~= 0 then
					local var_202_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012049", "story_v_out_121012.awb") / 1000

					if var_202_20 + var_202_12 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_20 + var_202_12
					end

					if var_202_15.prefab_name ~= "" and arg_199_1.actors_[var_202_15.prefab_name] ~= nil then
						local var_202_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_15.prefab_name].transform, "story_v_out_121012", "121012049", "story_v_out_121012.awb")

						arg_199_1:RecordAudio("121012049", var_202_21)
						arg_199_1:RecordAudio("121012049", var_202_21)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_121012", "121012049", "story_v_out_121012.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_121012", "121012049", "story_v_out_121012.awb")
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
	Play121012050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 121012050
		arg_203_1.duration_ = 9.87

		local var_203_0 = {
			ja = 6.266,
			ko = 9.866,
			zh = 9.866
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
				arg_203_0:Play121012051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1029ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1029ui_story == nil then
				arg_203_1.var_.characterEffect1029ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1029ui_story and not isNil(var_206_0) then
					arg_203_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1029ui_story then
				arg_203_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_206_4 = 0

			if var_206_4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action447")
			end

			local var_206_5 = 0

			if var_206_5 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_6 = arg_203_1.actors_["1076ui_story"]
			local var_206_7 = 0

			if var_206_7 < arg_203_1.time_ and arg_203_1.time_ <= var_206_7 + arg_206_0 and not isNil(var_206_6) and arg_203_1.var_.characterEffect1076ui_story == nil then
				arg_203_1.var_.characterEffect1076ui_story = var_206_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_8 = 0.200000002980232

			if var_206_7 <= arg_203_1.time_ and arg_203_1.time_ < var_206_7 + var_206_8 and not isNil(var_206_6) then
				local var_206_9 = (arg_203_1.time_ - var_206_7) / var_206_8

				if arg_203_1.var_.characterEffect1076ui_story and not isNil(var_206_6) then
					local var_206_10 = Mathf.Lerp(0, 0.5, var_206_9)

					arg_203_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1076ui_story.fillRatio = var_206_10
				end
			end

			if arg_203_1.time_ >= var_206_7 + var_206_8 and arg_203_1.time_ < var_206_7 + var_206_8 + arg_206_0 and not isNil(var_206_6) and arg_203_1.var_.characterEffect1076ui_story then
				local var_206_11 = 0.5

				arg_203_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1076ui_story.fillRatio = var_206_11
			end

			local var_206_12 = 0
			local var_206_13 = 0.8

			if var_206_12 < arg_203_1.time_ and arg_203_1.time_ <= var_206_12 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_14 = arg_203_1:FormatText(StoryNameCfg[319].name)

				arg_203_1.leftNameTxt_.text = var_206_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_15 = arg_203_1:GetWordFromCfg(121012050)
				local var_206_16 = arg_203_1:FormatText(var_206_15.content)

				arg_203_1.text_.text = var_206_16

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_17 = 32
				local var_206_18 = utf8.len(var_206_16)
				local var_206_19 = var_206_17 <= 0 and var_206_13 or var_206_13 * (var_206_18 / var_206_17)

				if var_206_19 > 0 and var_206_13 < var_206_19 then
					arg_203_1.talkMaxDuration = var_206_19

					if var_206_19 + var_206_12 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_19 + var_206_12
					end
				end

				arg_203_1.text_.text = var_206_16
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012050", "story_v_out_121012.awb") ~= 0 then
					local var_206_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012050", "story_v_out_121012.awb") / 1000

					if var_206_20 + var_206_12 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_20 + var_206_12
					end

					if var_206_15.prefab_name ~= "" and arg_203_1.actors_[var_206_15.prefab_name] ~= nil then
						local var_206_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_15.prefab_name].transform, "story_v_out_121012", "121012050", "story_v_out_121012.awb")

						arg_203_1:RecordAudio("121012050", var_206_21)
						arg_203_1:RecordAudio("121012050", var_206_21)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_121012", "121012050", "story_v_out_121012.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_121012", "121012050", "story_v_out_121012.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_22 = math.max(var_206_13, arg_203_1.talkMaxDuration)

			if var_206_12 <= arg_203_1.time_ and arg_203_1.time_ < var_206_12 + var_206_22 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_12) / var_206_22

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_12 + var_206_22 and arg_203_1.time_ < var_206_12 + var_206_22 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play121012051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 121012051
		arg_207_1.duration_ = 7.97

		local var_207_0 = {
			ja = 7.966,
			ko = 3.1,
			zh = 3.1
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play121012052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action7_2")
			end

			local var_210_1 = 0
			local var_210_2 = 0.4

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_3 = arg_207_1:FormatText(StoryNameCfg[319].name)

				arg_207_1.leftNameTxt_.text = var_210_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_4 = arg_207_1:GetWordFromCfg(121012051)
				local var_210_5 = arg_207_1:FormatText(var_210_4.content)

				arg_207_1.text_.text = var_210_5

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_6 = 16
				local var_210_7 = utf8.len(var_210_5)
				local var_210_8 = var_210_6 <= 0 and var_210_2 or var_210_2 * (var_210_7 / var_210_6)

				if var_210_8 > 0 and var_210_2 < var_210_8 then
					arg_207_1.talkMaxDuration = var_210_8

					if var_210_8 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_5
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012051", "story_v_out_121012.awb") ~= 0 then
					local var_210_9 = manager.audio:GetVoiceLength("story_v_out_121012", "121012051", "story_v_out_121012.awb") / 1000

					if var_210_9 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_1
					end

					if var_210_4.prefab_name ~= "" and arg_207_1.actors_[var_210_4.prefab_name] ~= nil then
						local var_210_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_4.prefab_name].transform, "story_v_out_121012", "121012051", "story_v_out_121012.awb")

						arg_207_1:RecordAudio("121012051", var_210_10)
						arg_207_1:RecordAudio("121012051", var_210_10)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_121012", "121012051", "story_v_out_121012.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_121012", "121012051", "story_v_out_121012.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_11 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_11 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_11

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_11 and arg_207_1.time_ < var_210_1 + var_210_11 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play121012052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 121012052
		arg_211_1.duration_ = 2

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play121012053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1076ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1076ui_story == nil then
				arg_211_1.var_.characterEffect1076ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect1076ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1076ui_story then
				arg_211_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_214_4 = 0

			if var_214_4 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_214_5 = 0

			if var_214_5 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_214_6 = arg_211_1.actors_["1029ui_story"]
			local var_214_7 = 0

			if var_214_7 < arg_211_1.time_ and arg_211_1.time_ <= var_214_7 + arg_214_0 and not isNil(var_214_6) and arg_211_1.var_.characterEffect1029ui_story == nil then
				arg_211_1.var_.characterEffect1029ui_story = var_214_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_8 = 0.200000002980232

			if var_214_7 <= arg_211_1.time_ and arg_211_1.time_ < var_214_7 + var_214_8 and not isNil(var_214_6) then
				local var_214_9 = (arg_211_1.time_ - var_214_7) / var_214_8

				if arg_211_1.var_.characterEffect1029ui_story and not isNil(var_214_6) then
					local var_214_10 = Mathf.Lerp(0, 0.5, var_214_9)

					arg_211_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1029ui_story.fillRatio = var_214_10
				end
			end

			if arg_211_1.time_ >= var_214_7 + var_214_8 and arg_211_1.time_ < var_214_7 + var_214_8 + arg_214_0 and not isNil(var_214_6) and arg_211_1.var_.characterEffect1029ui_story then
				local var_214_11 = 0.5

				arg_211_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1029ui_story.fillRatio = var_214_11
			end

			local var_214_12 = 0
			local var_214_13 = 0.075

			if var_214_12 < arg_211_1.time_ and arg_211_1.time_ <= var_214_12 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_14 = arg_211_1:FormatText(StoryNameCfg[389].name)

				arg_211_1.leftNameTxt_.text = var_214_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_15 = arg_211_1:GetWordFromCfg(121012052)
				local var_214_16 = arg_211_1:FormatText(var_214_15.content)

				arg_211_1.text_.text = var_214_16

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_17 = 3
				local var_214_18 = utf8.len(var_214_16)
				local var_214_19 = var_214_17 <= 0 and var_214_13 or var_214_13 * (var_214_18 / var_214_17)

				if var_214_19 > 0 and var_214_13 < var_214_19 then
					arg_211_1.talkMaxDuration = var_214_19

					if var_214_19 + var_214_12 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_19 + var_214_12
					end
				end

				arg_211_1.text_.text = var_214_16
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012052", "story_v_out_121012.awb") ~= 0 then
					local var_214_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012052", "story_v_out_121012.awb") / 1000

					if var_214_20 + var_214_12 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_20 + var_214_12
					end

					if var_214_15.prefab_name ~= "" and arg_211_1.actors_[var_214_15.prefab_name] ~= nil then
						local var_214_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_15.prefab_name].transform, "story_v_out_121012", "121012052", "story_v_out_121012.awb")

						arg_211_1:RecordAudio("121012052", var_214_21)
						arg_211_1:RecordAudio("121012052", var_214_21)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_121012", "121012052", "story_v_out_121012.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_121012", "121012052", "story_v_out_121012.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_22 = math.max(var_214_13, arg_211_1.talkMaxDuration)

			if var_214_12 <= arg_211_1.time_ and arg_211_1.time_ < var_214_12 + var_214_22 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_12) / var_214_22

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_12 + var_214_22 and arg_211_1.time_ < var_214_12 + var_214_22 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play121012053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 121012053
		arg_215_1.duration_ = 2

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play121012054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1029ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1029ui_story == nil then
				arg_215_1.var_.characterEffect1029ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect1029ui_story and not isNil(var_218_0) then
					arg_215_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1029ui_story then
				arg_215_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_218_4 = 0

			if var_218_4 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_218_5 = 0

			if var_218_5 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_218_6 = arg_215_1.actors_["1076ui_story"]
			local var_218_7 = 0

			if var_218_7 < arg_215_1.time_ and arg_215_1.time_ <= var_218_7 + arg_218_0 and not isNil(var_218_6) and arg_215_1.var_.characterEffect1076ui_story == nil then
				arg_215_1.var_.characterEffect1076ui_story = var_218_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_8 = 0.200000002980232

			if var_218_7 <= arg_215_1.time_ and arg_215_1.time_ < var_218_7 + var_218_8 and not isNil(var_218_6) then
				local var_218_9 = (arg_215_1.time_ - var_218_7) / var_218_8

				if arg_215_1.var_.characterEffect1076ui_story and not isNil(var_218_6) then
					local var_218_10 = Mathf.Lerp(0, 0.5, var_218_9)

					arg_215_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1076ui_story.fillRatio = var_218_10
				end
			end

			if arg_215_1.time_ >= var_218_7 + var_218_8 and arg_215_1.time_ < var_218_7 + var_218_8 + arg_218_0 and not isNil(var_218_6) and arg_215_1.var_.characterEffect1076ui_story then
				local var_218_11 = 0.5

				arg_215_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1076ui_story.fillRatio = var_218_11
			end

			local var_218_12 = 0
			local var_218_13 = 0.05

			if var_218_12 < arg_215_1.time_ and arg_215_1.time_ <= var_218_12 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_14 = arg_215_1:FormatText(StoryNameCfg[319].name)

				arg_215_1.leftNameTxt_.text = var_218_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_15 = arg_215_1:GetWordFromCfg(121012053)
				local var_218_16 = arg_215_1:FormatText(var_218_15.content)

				arg_215_1.text_.text = var_218_16

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_17 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012053", "story_v_out_121012.awb") ~= 0 then
					local var_218_20 = manager.audio:GetVoiceLength("story_v_out_121012", "121012053", "story_v_out_121012.awb") / 1000

					if var_218_20 + var_218_12 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_20 + var_218_12
					end

					if var_218_15.prefab_name ~= "" and arg_215_1.actors_[var_218_15.prefab_name] ~= nil then
						local var_218_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_15.prefab_name].transform, "story_v_out_121012", "121012053", "story_v_out_121012.awb")

						arg_215_1:RecordAudio("121012053", var_218_21)
						arg_215_1:RecordAudio("121012053", var_218_21)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_121012", "121012053", "story_v_out_121012.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_121012", "121012053", "story_v_out_121012.awb")
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
	Play121012054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 121012054
		arg_219_1.duration_ = 7.7

		local var_219_0 = {
			ja = 7.7,
			ko = 4.233,
			zh = 4.233
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
				arg_219_0:Play121012055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.55

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[319].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:GetWordFromCfg(121012054)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 22
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012054", "story_v_out_121012.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_121012", "121012054", "story_v_out_121012.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_121012", "121012054", "story_v_out_121012.awb")

						arg_219_1:RecordAudio("121012054", var_222_9)
						arg_219_1:RecordAudio("121012054", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_121012", "121012054", "story_v_out_121012.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_121012", "121012054", "story_v_out_121012.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_10 and arg_219_1.time_ < var_222_0 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play121012055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 121012055
		arg_223_1.duration_ = 8.9

		local var_223_0 = {
			ja = 8.9,
			ko = 3.166,
			zh = 3.166
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
				arg_223_0:Play121012056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.3

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[319].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:GetWordFromCfg(121012055)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012055", "story_v_out_121012.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_121012", "121012055", "story_v_out_121012.awb") / 1000

					if var_226_8 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_121012", "121012055", "story_v_out_121012.awb")

						arg_223_1:RecordAudio("121012055", var_226_9)
						arg_223_1:RecordAudio("121012055", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_121012", "121012055", "story_v_out_121012.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_121012", "121012055", "story_v_out_121012.awb")
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
	Play121012056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 121012056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play121012057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1029ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos1029ui_story = var_230_0.localPosition
			end

			local var_230_2 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2
				local var_230_4 = Vector3.New(0, 100, 0)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1029ui_story, var_230_4, var_230_3)

				local var_230_5 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_5.x, var_230_5.y, var_230_5.z)

				local var_230_6 = var_230_0.localEulerAngles

				var_230_6.z = 0
				var_230_6.x = 0
				var_230_0.localEulerAngles = var_230_6
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(0, 100, 0)

				local var_230_7 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_7.x, var_230_7.y, var_230_7.z)

				local var_230_8 = var_230_0.localEulerAngles

				var_230_8.z = 0
				var_230_8.x = 0
				var_230_0.localEulerAngles = var_230_8
			end

			local var_230_9 = arg_227_1.actors_["1076ui_story"].transform
			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 then
				arg_227_1.var_.moveOldPos1076ui_story = var_230_9.localPosition
			end

			local var_230_11 = 0.001

			if var_230_10 <= arg_227_1.time_ and arg_227_1.time_ < var_230_10 + var_230_11 then
				local var_230_12 = (arg_227_1.time_ - var_230_10) / var_230_11
				local var_230_13 = Vector3.New(0, 100, 0)

				var_230_9.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1076ui_story, var_230_13, var_230_12)

				local var_230_14 = manager.ui.mainCamera.transform.position - var_230_9.position

				var_230_9.forward = Vector3.New(var_230_14.x, var_230_14.y, var_230_14.z)

				local var_230_15 = var_230_9.localEulerAngles

				var_230_15.z = 0
				var_230_15.x = 0
				var_230_9.localEulerAngles = var_230_15
			end

			if arg_227_1.time_ >= var_230_10 + var_230_11 and arg_227_1.time_ < var_230_10 + var_230_11 + arg_230_0 then
				var_230_9.localPosition = Vector3.New(0, 100, 0)

				local var_230_16 = manager.ui.mainCamera.transform.position - var_230_9.position

				var_230_9.forward = Vector3.New(var_230_16.x, var_230_16.y, var_230_16.z)

				local var_230_17 = var_230_9.localEulerAngles

				var_230_17.z = 0
				var_230_17.x = 0
				var_230_9.localEulerAngles = var_230_17
			end

			local var_230_18 = 0
			local var_230_19 = 0.633333333333333

			if var_230_18 < arg_227_1.time_ and arg_227_1.time_ <= var_230_18 + arg_230_0 then
				local var_230_20 = "play"
				local var_230_21 = "effect"

				arg_227_1:AudioAction(var_230_20, var_230_21, "", "", "")
			end

			local var_230_22 = 0
			local var_230_23 = 0.666666666666667

			if var_230_22 < arg_227_1.time_ and arg_227_1.time_ <= var_230_22 + arg_230_0 then
				local var_230_24 = "play"
				local var_230_25 = "effect"

				arg_227_1:AudioAction(var_230_24, var_230_25, "se_story_121_00", "se_story_121_00_draw", "")
			end

			local var_230_26 = 0
			local var_230_27 = 0.625

			if var_230_26 < arg_227_1.time_ and arg_227_1.time_ <= var_230_26 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_28 = arg_227_1:GetWordFromCfg(121012056)
				local var_230_29 = arg_227_1:FormatText(var_230_28.content)

				arg_227_1.text_.text = var_230_29

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_30 = 25
				local var_230_31 = utf8.len(var_230_29)
				local var_230_32 = var_230_30 <= 0 and var_230_27 or var_230_27 * (var_230_31 / var_230_30)

				if var_230_32 > 0 and var_230_27 < var_230_32 then
					arg_227_1.talkMaxDuration = var_230_32

					if var_230_32 + var_230_26 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_32 + var_230_26
					end
				end

				arg_227_1.text_.text = var_230_29
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_33 = math.max(var_230_27, arg_227_1.talkMaxDuration)

			if var_230_26 <= arg_227_1.time_ and arg_227_1.time_ < var_230_26 + var_230_33 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_26) / var_230_33

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_26 + var_230_33 and arg_227_1.time_ < var_230_26 + var_230_33 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play121012057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 121012057
		arg_231_1.duration_ = 2.13

		local var_231_0 = {
			ja = 2.133,
			ko = 0.999999999999,
			zh = 0.999999999999
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
			arg_231_1.auto_ = false
		end

		function arg_231_1.playNext_(arg_233_0)
			arg_231_1.onStoryFinished_()
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.075

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[319].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:GetWordFromCfg(121012057)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 3
				local var_234_6 = utf8.len(var_234_4)
				local var_234_7 = var_234_5 <= 0 and var_234_1 or var_234_1 * (var_234_6 / var_234_5)

				if var_234_7 > 0 and var_234_1 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121012", "121012057", "story_v_out_121012.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_121012", "121012057", "story_v_out_121012.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_121012", "121012057", "story_v_out_121012.awb")

						arg_231_1:RecordAudio("121012057", var_234_9)
						arg_231_1:RecordAudio("121012057", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_121012", "121012057", "story_v_out_121012.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_121012", "121012057", "story_v_out_121012.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_10 and arg_231_1.time_ < var_234_0 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J02f"
	},
	voices = {
		"story_v_out_121012.awb"
	}
}
