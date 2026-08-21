return {
	Play317321001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317321001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317321002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "K09f"

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
				local var_4_5 = arg_1_1.bgs_.K09f

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
					if iter_4_0 ~= "K09f" then
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
			local var_4_23 = 0.6

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
			local var_4_29 = 0.8

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

				local var_4_31 = arg_1_1:GetWordFromCfg(317321001)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 32
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
	Play317321002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 317321002
		arg_8_1.duration_ = 7

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play317321003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "K11g"

			if arg_8_1.bgs_[var_11_0] == nil then
				local var_11_1 = Object.Instantiate(arg_8_1.paintGo_)

				var_11_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_11_0)
				var_11_1.name = var_11_0
				var_11_1.transform.parent = arg_8_1.stage_.transform
				var_11_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.bgs_[var_11_0] = var_11_1
			end

			local var_11_2 = 0

			if var_11_2 < arg_8_1.time_ and arg_8_1.time_ <= var_11_2 + arg_11_0 then
				local var_11_3 = manager.ui.mainCamera.transform.localPosition
				local var_11_4 = Vector3.New(0, 0, 10) + Vector3.New(var_11_3.x, var_11_3.y, 0)
				local var_11_5 = arg_8_1.bgs_.K11g

				var_11_5.transform.localPosition = var_11_4
				var_11_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_11_6 = var_11_5:GetComponent("SpriteRenderer")

				if var_11_6 and var_11_6.sprite then
					local var_11_7 = (var_11_5.transform.localPosition - var_11_3).z
					local var_11_8 = manager.ui.mainCameraCom_
					local var_11_9 = 2 * var_11_7 * Mathf.Tan(var_11_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_11_10 = var_11_9 * var_11_8.aspect
					local var_11_11 = var_11_6.sprite.bounds.size.x
					local var_11_12 = var_11_6.sprite.bounds.size.y
					local var_11_13 = var_11_10 / var_11_11
					local var_11_14 = var_11_9 / var_11_12
					local var_11_15 = var_11_14 < var_11_13 and var_11_13 or var_11_14

					var_11_5.transform.localScale = Vector3.New(var_11_15, var_11_15, 0)
				end

				for iter_11_0, iter_11_1 in pairs(arg_8_1.bgs_) do
					if iter_11_0 ~= "K11g" then
						iter_11_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_17 = 2

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_17 then
				local var_11_18 = (arg_8_1.time_ - var_11_16) / var_11_17
				local var_11_19 = Color.New(0, 0, 0)

				var_11_19.a = Mathf.Lerp(1, 0, var_11_18)
				arg_8_1.mask_.color = var_11_19
			end

			if arg_8_1.time_ >= var_11_16 + var_11_17 and arg_8_1.time_ < var_11_16 + var_11_17 + arg_11_0 then
				local var_11_20 = Color.New(0, 0, 0)
				local var_11_21 = 0

				arg_8_1.mask_.enabled = false
				var_11_20.a = var_11_21
				arg_8_1.mask_.color = var_11_20
			end

			local var_11_22 = 0
			local var_11_23 = 0.6

			if var_11_22 < arg_8_1.time_ and arg_8_1.time_ <= var_11_22 + arg_11_0 then
				local var_11_24 = "play"
				local var_11_25 = "music"

				arg_8_1:AudioAction(var_11_24, var_11_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_11_26 = ""
				local var_11_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_11_27 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_27 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_27

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_27
						arg_8_1.bgmTxt2_.text = var_11_27
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

			local var_11_28 = 0.733333333333333
			local var_11_29 = 1

			if var_11_28 < arg_8_1.time_ and arg_8_1.time_ <= var_11_28 + arg_11_0 then
				local var_11_30 = "play"
				local var_11_31 = "music"

				arg_8_1:AudioAction(var_11_30, var_11_31, "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden.awb")

				local var_11_32 = ""
				local var_11_33 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden")

				if var_11_33 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_33 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_33

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_33
						arg_8_1.bgmTxt2_.text = var_11_33
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

			if arg_8_1.frameCnt_ <= 1 then
				arg_8_1.dialog_:SetActive(false)
			end

			local var_11_34 = 2
			local var_11_35 = 0.775

			if var_11_34 < arg_8_1.time_ and arg_8_1.time_ <= var_11_34 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0

				arg_8_1.dialog_:SetActive(true)

				arg_8_1.dialogCg_.alpha = 0

				local var_11_36 = LeanTween.value(arg_8_1.dialog_, 0, 1, 0.3)

				var_11_36:setOnUpdate(LuaHelper.FloatAction(function(arg_14_0)
					arg_8_1.dialogCg_.alpha = arg_14_0
				end))
				var_11_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_8_1.dialog_)
					var_11_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_8_1.duration_ = arg_8_1.duration_ + 0.3

				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_37 = arg_8_1:GetWordFromCfg(317321002)
				local var_11_38 = arg_8_1:FormatText(var_11_37.content)

				arg_8_1.text_.text = var_11_38

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_39 = 31
				local var_11_40 = utf8.len(var_11_38)
				local var_11_41 = var_11_39 <= 0 and var_11_35 or var_11_35 * (var_11_40 / var_11_39)

				if var_11_41 > 0 and var_11_35 < var_11_41 then
					arg_8_1.talkMaxDuration = var_11_41
					var_11_34 = var_11_34 + 0.3

					if var_11_41 + var_11_34 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_41 + var_11_34
					end
				end

				arg_8_1.text_.text = var_11_38
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_42 = var_11_34 + 0.3
			local var_11_43 = math.max(var_11_35, arg_8_1.talkMaxDuration)

			if var_11_42 <= arg_8_1.time_ and arg_8_1.time_ < var_11_42 + var_11_43 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_42) / var_11_43

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_42 + var_11_43 and arg_8_1.time_ < var_11_42 + var_11_43 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play317321003 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 317321003
		arg_16_1.duration_ = 4.37

		local var_16_0 = {
			zh = 2.733,
			ja = 4.366
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
				arg_16_0:Play317321004(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1093ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["1093ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos1093ui_story = var_19_5.localPosition
			end

			local var_19_7 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7
				local var_19_9 = Vector3.New(-0.7, -1.11, -5.88)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1093ui_story, var_19_9, var_19_8)

				local var_19_10 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_10.x, var_19_10.y, var_19_10.z)

				local var_19_11 = var_19_5.localEulerAngles

				var_19_11.z = 0
				var_19_11.x = 0
				var_19_5.localEulerAngles = var_19_11
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_19_12 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_12.x, var_19_12.y, var_19_12.z)

				local var_19_13 = var_19_5.localEulerAngles

				var_19_13.z = 0
				var_19_13.x = 0
				var_19_5.localEulerAngles = var_19_13
			end

			local var_19_14 = arg_16_1.actors_["1093ui_story"]
			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect1093ui_story == nil then
				arg_16_1.var_.characterEffect1093ui_story = var_19_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_16 = 0.200000002980232

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_16 and not isNil(var_19_14) then
				local var_19_17 = (arg_16_1.time_ - var_19_15) / var_19_16

				if arg_16_1.var_.characterEffect1093ui_story and not isNil(var_19_14) then
					arg_16_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_15 + var_19_16 and arg_16_1.time_ < var_19_15 + var_19_16 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect1093ui_story then
				arg_16_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_19_18 = 0

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			local var_19_19 = 0

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_19_20 = 0
			local var_19_21 = 0.275

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_22 = arg_16_1:FormatText(StoryNameCfg[73].name)

				arg_16_1.leftNameTxt_.text = var_19_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_23 = arg_16_1:GetWordFromCfg(317321003)
				local var_19_24 = arg_16_1:FormatText(var_19_23.content)

				arg_16_1.text_.text = var_19_24

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_25 = 11
				local var_19_26 = utf8.len(var_19_24)
				local var_19_27 = var_19_25 <= 0 and var_19_21 or var_19_21 * (var_19_26 / var_19_25)

				if var_19_27 > 0 and var_19_21 < var_19_27 then
					arg_16_1.talkMaxDuration = var_19_27

					if var_19_27 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_27 + var_19_20
					end
				end

				arg_16_1.text_.text = var_19_24
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321003", "story_v_out_317321.awb") ~= 0 then
					local var_19_28 = manager.audio:GetVoiceLength("story_v_out_317321", "317321003", "story_v_out_317321.awb") / 1000

					if var_19_28 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_20
					end

					if var_19_23.prefab_name ~= "" and arg_16_1.actors_[var_19_23.prefab_name] ~= nil then
						local var_19_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_23.prefab_name].transform, "story_v_out_317321", "317321003", "story_v_out_317321.awb")

						arg_16_1:RecordAudio("317321003", var_19_29)
						arg_16_1:RecordAudio("317321003", var_19_29)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_317321", "317321003", "story_v_out_317321.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_317321", "317321003", "story_v_out_317321.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_30 = math.max(var_19_21, arg_16_1.talkMaxDuration)

			if var_19_20 <= arg_16_1.time_ and arg_16_1.time_ < var_19_20 + var_19_30 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_20) / var_19_30

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_20 + var_19_30 and arg_16_1.time_ < var_19_20 + var_19_30 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play317321004 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 317321004
		arg_20_1.duration_ = 5.67

		local var_20_0 = {
			zh = 1.999999999999,
			ja = 5.666
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play317321005(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1058ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "1058ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_20_1.stage_.transform)

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

			local var_23_5 = arg_20_1.actors_["1058ui_story"].transform
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.var_.moveOldPos1058ui_story = var_23_5.localPosition
			end

			local var_23_7 = 0.001

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7
				local var_23_9 = Vector3.New(0.7, -0.95, -5.88)

				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1058ui_story, var_23_9, var_23_8)

				local var_23_10 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_10.x, var_23_10.y, var_23_10.z)

				local var_23_11 = var_23_5.localEulerAngles

				var_23_11.z = 0
				var_23_11.x = 0
				var_23_5.localEulerAngles = var_23_11
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(0.7, -0.95, -5.88)

				local var_23_12 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_12.x, var_23_12.y, var_23_12.z)

				local var_23_13 = var_23_5.localEulerAngles

				var_23_13.z = 0
				var_23_13.x = 0
				var_23_5.localEulerAngles = var_23_13
			end

			local var_23_14 = arg_20_1.actors_["1058ui_story"]
			local var_23_15 = 0

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect1058ui_story == nil then
				arg_20_1.var_.characterEffect1058ui_story = var_23_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_16 = 0.200000002980232

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_16 and not isNil(var_23_14) then
				local var_23_17 = (arg_20_1.time_ - var_23_15) / var_23_16

				if arg_20_1.var_.characterEffect1058ui_story and not isNil(var_23_14) then
					arg_20_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_15 + var_23_16 and arg_20_1.time_ < var_23_15 + var_23_16 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect1058ui_story then
				arg_20_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_23_18 = 0

			if var_23_18 < arg_20_1.time_ and arg_20_1.time_ <= var_23_18 + arg_23_0 then
				arg_20_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_1")
			end

			local var_23_19 = 0

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_23_20 = arg_20_1.actors_["1093ui_story"]
			local var_23_21 = 0

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 and not isNil(var_23_20) and arg_20_1.var_.characterEffect1093ui_story == nil then
				arg_20_1.var_.characterEffect1093ui_story = var_23_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_22 = 0.200000002980232

			if var_23_21 <= arg_20_1.time_ and arg_20_1.time_ < var_23_21 + var_23_22 and not isNil(var_23_20) then
				local var_23_23 = (arg_20_1.time_ - var_23_21) / var_23_22

				if arg_20_1.var_.characterEffect1093ui_story and not isNil(var_23_20) then
					local var_23_24 = Mathf.Lerp(0, 0.5, var_23_23)

					arg_20_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1093ui_story.fillRatio = var_23_24
				end
			end

			if arg_20_1.time_ >= var_23_21 + var_23_22 and arg_20_1.time_ < var_23_21 + var_23_22 + arg_23_0 and not isNil(var_23_20) and arg_20_1.var_.characterEffect1093ui_story then
				local var_23_25 = 0.5

				arg_20_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1093ui_story.fillRatio = var_23_25
			end

			local var_23_26 = 0
			local var_23_27 = 0.15

			if var_23_26 < arg_20_1.time_ and arg_20_1.time_ <= var_23_26 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_28 = arg_20_1:FormatText(StoryNameCfg[92].name)

				arg_20_1.leftNameTxt_.text = var_23_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_29 = arg_20_1:GetWordFromCfg(317321004)
				local var_23_30 = arg_20_1:FormatText(var_23_29.content)

				arg_20_1.text_.text = var_23_30

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_31 = 6
				local var_23_32 = utf8.len(var_23_30)
				local var_23_33 = var_23_31 <= 0 and var_23_27 or var_23_27 * (var_23_32 / var_23_31)

				if var_23_33 > 0 and var_23_27 < var_23_33 then
					arg_20_1.talkMaxDuration = var_23_33

					if var_23_33 + var_23_26 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_33 + var_23_26
					end
				end

				arg_20_1.text_.text = var_23_30
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321004", "story_v_out_317321.awb") ~= 0 then
					local var_23_34 = manager.audio:GetVoiceLength("story_v_out_317321", "317321004", "story_v_out_317321.awb") / 1000

					if var_23_34 + var_23_26 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_34 + var_23_26
					end

					if var_23_29.prefab_name ~= "" and arg_20_1.actors_[var_23_29.prefab_name] ~= nil then
						local var_23_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_29.prefab_name].transform, "story_v_out_317321", "317321004", "story_v_out_317321.awb")

						arg_20_1:RecordAudio("317321004", var_23_35)
						arg_20_1:RecordAudio("317321004", var_23_35)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_317321", "317321004", "story_v_out_317321.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_317321", "317321004", "story_v_out_317321.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_36 = math.max(var_23_27, arg_20_1.talkMaxDuration)

			if var_23_26 <= arg_20_1.time_ and arg_20_1.time_ < var_23_26 + var_23_36 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_26) / var_23_36

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_26 + var_23_36 and arg_20_1.time_ < var_23_26 + var_23_36 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play317321005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 317321005
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play317321006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1058ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1058ui_story == nil then
				arg_24_1.var_.characterEffect1058ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1058ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1058ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1058ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1058ui_story.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 0.85

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

				local var_27_8 = arg_24_1:GetWordFromCfg(317321005)
				local var_27_9 = arg_24_1:FormatText(var_27_8.content)

				arg_24_1.text_.text = var_27_9

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_10 = 34
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
	Play317321006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 317321006
		arg_28_1.duration_ = 5.17

		local var_28_0 = {
			zh = 5.166,
			ja = 4.7
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
				arg_28_0:Play317321007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1058ui_story"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos1058ui_story = var_31_0.localPosition
			end

			local var_31_2 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2
				local var_31_4 = Vector3.New(0.7, -0.95, -5.88)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1058ui_story, var_31_4, var_31_3)

				local var_31_5 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_5.x, var_31_5.y, var_31_5.z)

				local var_31_6 = var_31_0.localEulerAngles

				var_31_6.z = 0
				var_31_6.x = 0
				var_31_0.localEulerAngles = var_31_6
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0.7, -0.95, -5.88)

				local var_31_7 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_7.x, var_31_7.y, var_31_7.z)

				local var_31_8 = var_31_0.localEulerAngles

				var_31_8.z = 0
				var_31_8.x = 0
				var_31_0.localEulerAngles = var_31_8
			end

			local var_31_9 = arg_28_1.actors_["1058ui_story"]
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1058ui_story == nil then
				arg_28_1.var_.characterEffect1058ui_story = var_31_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_11 = 0.200000002980232

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 and not isNil(var_31_9) then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11

				if arg_28_1.var_.characterEffect1058ui_story and not isNil(var_31_9) then
					arg_28_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 and not isNil(var_31_9) and arg_28_1.var_.characterEffect1058ui_story then
				arg_28_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_31_13 = 0

			if var_31_13 < arg_28_1.time_ and arg_28_1.time_ <= var_31_13 + arg_31_0 then
				arg_28_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_2")
			end

			local var_31_14 = 0

			if var_31_14 < arg_28_1.time_ and arg_28_1.time_ <= var_31_14 + arg_31_0 then
				arg_28_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_31_15 = 0
			local var_31_16 = 0.625

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_17 = arg_28_1:FormatText(StoryNameCfg[92].name)

				arg_28_1.leftNameTxt_.text = var_31_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_18 = arg_28_1:GetWordFromCfg(317321006)
				local var_31_19 = arg_28_1:FormatText(var_31_18.content)

				arg_28_1.text_.text = var_31_19

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_20 = 25
				local var_31_21 = utf8.len(var_31_19)
				local var_31_22 = var_31_20 <= 0 and var_31_16 or var_31_16 * (var_31_21 / var_31_20)

				if var_31_22 > 0 and var_31_16 < var_31_22 then
					arg_28_1.talkMaxDuration = var_31_22

					if var_31_22 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_22 + var_31_15
					end
				end

				arg_28_1.text_.text = var_31_19
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321006", "story_v_out_317321.awb") ~= 0 then
					local var_31_23 = manager.audio:GetVoiceLength("story_v_out_317321", "317321006", "story_v_out_317321.awb") / 1000

					if var_31_23 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_23 + var_31_15
					end

					if var_31_18.prefab_name ~= "" and arg_28_1.actors_[var_31_18.prefab_name] ~= nil then
						local var_31_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_18.prefab_name].transform, "story_v_out_317321", "317321006", "story_v_out_317321.awb")

						arg_28_1:RecordAudio("317321006", var_31_24)
						arg_28_1:RecordAudio("317321006", var_31_24)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_317321", "317321006", "story_v_out_317321.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_317321", "317321006", "story_v_out_317321.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_25 = math.max(var_31_16, arg_28_1.talkMaxDuration)

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_25 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_15) / var_31_25

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_15 + var_31_25 and arg_28_1.time_ < var_31_15 + var_31_25 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
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
	Play317321007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 317321007
		arg_32_1.duration_ = 6.43

		local var_32_0 = {
			zh = 6.3,
			ja = 6.433
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
				arg_32_0:Play317321008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "1199ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "1199ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_32_1.stage_.transform)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

					var_35_3.enabled = true

					local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

					if var_35_4 then
						var_35_4:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_3.transform, false)

					arg_32_1.var_[var_35_0 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_0 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_0 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_5 = arg_32_1.actors_["1199ui_story"].transform
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.var_.moveOldPos1199ui_story = var_35_5.localPosition
			end

			local var_35_7 = 0.001

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_7 then
				local var_35_8 = (arg_32_1.time_ - var_35_6) / var_35_7
				local var_35_9 = Vector3.New(0, -1.08, -5.9)

				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1199ui_story, var_35_9, var_35_8)

				local var_35_10 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_10.x, var_35_10.y, var_35_10.z)

				local var_35_11 = var_35_5.localEulerAngles

				var_35_11.z = 0
				var_35_11.x = 0
				var_35_5.localEulerAngles = var_35_11
			end

			if arg_32_1.time_ >= var_35_6 + var_35_7 and arg_32_1.time_ < var_35_6 + var_35_7 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_35_12 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_12.x, var_35_12.y, var_35_12.z)

				local var_35_13 = var_35_5.localEulerAngles

				var_35_13.z = 0
				var_35_13.x = 0
				var_35_5.localEulerAngles = var_35_13
			end

			local var_35_14 = arg_32_1.actors_["1199ui_story"]
			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect1199ui_story == nil then
				arg_32_1.var_.characterEffect1199ui_story = var_35_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_16 = 0.200000002980232

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_16 and not isNil(var_35_14) then
				local var_35_17 = (arg_32_1.time_ - var_35_15) / var_35_16

				if arg_32_1.var_.characterEffect1199ui_story and not isNil(var_35_14) then
					arg_32_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_15 + var_35_16 and arg_32_1.time_ < var_35_15 + var_35_16 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect1199ui_story then
				arg_32_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			local var_35_18 = 0

			if var_35_18 < arg_32_1.time_ and arg_32_1.time_ <= var_35_18 + arg_35_0 then
				arg_32_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_1")
			end

			local var_35_19 = 0

			if var_35_19 < arg_32_1.time_ and arg_32_1.time_ <= var_35_19 + arg_35_0 then
				arg_32_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_35_20 = arg_32_1.actors_["1093ui_story"].transform
			local var_35_21 = 0

			if var_35_21 < arg_32_1.time_ and arg_32_1.time_ <= var_35_21 + arg_35_0 then
				arg_32_1.var_.moveOldPos1093ui_story = var_35_20.localPosition
			end

			local var_35_22 = 0.001

			if var_35_21 <= arg_32_1.time_ and arg_32_1.time_ < var_35_21 + var_35_22 then
				local var_35_23 = (arg_32_1.time_ - var_35_21) / var_35_22
				local var_35_24 = Vector3.New(0, 100, 0)

				var_35_20.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1093ui_story, var_35_24, var_35_23)

				local var_35_25 = manager.ui.mainCamera.transform.position - var_35_20.position

				var_35_20.forward = Vector3.New(var_35_25.x, var_35_25.y, var_35_25.z)

				local var_35_26 = var_35_20.localEulerAngles

				var_35_26.z = 0
				var_35_26.x = 0
				var_35_20.localEulerAngles = var_35_26
			end

			if arg_32_1.time_ >= var_35_21 + var_35_22 and arg_32_1.time_ < var_35_21 + var_35_22 + arg_35_0 then
				var_35_20.localPosition = Vector3.New(0, 100, 0)

				local var_35_27 = manager.ui.mainCamera.transform.position - var_35_20.position

				var_35_20.forward = Vector3.New(var_35_27.x, var_35_27.y, var_35_27.z)

				local var_35_28 = var_35_20.localEulerAngles

				var_35_28.z = 0
				var_35_28.x = 0
				var_35_20.localEulerAngles = var_35_28
			end

			local var_35_29 = arg_32_1.actors_["1093ui_story"]
			local var_35_30 = 0

			if var_35_30 < arg_32_1.time_ and arg_32_1.time_ <= var_35_30 + arg_35_0 and not isNil(var_35_29) and arg_32_1.var_.characterEffect1093ui_story == nil then
				arg_32_1.var_.characterEffect1093ui_story = var_35_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_31 = 0.200000002980232

			if var_35_30 <= arg_32_1.time_ and arg_32_1.time_ < var_35_30 + var_35_31 and not isNil(var_35_29) then
				local var_35_32 = (arg_32_1.time_ - var_35_30) / var_35_31

				if arg_32_1.var_.characterEffect1093ui_story and not isNil(var_35_29) then
					local var_35_33 = Mathf.Lerp(0, 0.5, var_35_32)

					arg_32_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1093ui_story.fillRatio = var_35_33
				end
			end

			if arg_32_1.time_ >= var_35_30 + var_35_31 and arg_32_1.time_ < var_35_30 + var_35_31 + arg_35_0 and not isNil(var_35_29) and arg_32_1.var_.characterEffect1093ui_story then
				local var_35_34 = 0.5

				arg_32_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1093ui_story.fillRatio = var_35_34
			end

			local var_35_35 = arg_32_1.actors_["1058ui_story"].transform
			local var_35_36 = 0

			if var_35_36 < arg_32_1.time_ and arg_32_1.time_ <= var_35_36 + arg_35_0 then
				arg_32_1.var_.moveOldPos1058ui_story = var_35_35.localPosition
			end

			local var_35_37 = 0.001

			if var_35_36 <= arg_32_1.time_ and arg_32_1.time_ < var_35_36 + var_35_37 then
				local var_35_38 = (arg_32_1.time_ - var_35_36) / var_35_37
				local var_35_39 = Vector3.New(0, 100, 0)

				var_35_35.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1058ui_story, var_35_39, var_35_38)

				local var_35_40 = manager.ui.mainCamera.transform.position - var_35_35.position

				var_35_35.forward = Vector3.New(var_35_40.x, var_35_40.y, var_35_40.z)

				local var_35_41 = var_35_35.localEulerAngles

				var_35_41.z = 0
				var_35_41.x = 0
				var_35_35.localEulerAngles = var_35_41
			end

			if arg_32_1.time_ >= var_35_36 + var_35_37 and arg_32_1.time_ < var_35_36 + var_35_37 + arg_35_0 then
				var_35_35.localPosition = Vector3.New(0, 100, 0)

				local var_35_42 = manager.ui.mainCamera.transform.position - var_35_35.position

				var_35_35.forward = Vector3.New(var_35_42.x, var_35_42.y, var_35_42.z)

				local var_35_43 = var_35_35.localEulerAngles

				var_35_43.z = 0
				var_35_43.x = 0
				var_35_35.localEulerAngles = var_35_43
			end

			local var_35_44 = arg_32_1.actors_["1058ui_story"]
			local var_35_45 = 0

			if var_35_45 < arg_32_1.time_ and arg_32_1.time_ <= var_35_45 + arg_35_0 and not isNil(var_35_44) and arg_32_1.var_.characterEffect1058ui_story == nil then
				arg_32_1.var_.characterEffect1058ui_story = var_35_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_46 = 0.200000002980232

			if var_35_45 <= arg_32_1.time_ and arg_32_1.time_ < var_35_45 + var_35_46 and not isNil(var_35_44) then
				local var_35_47 = (arg_32_1.time_ - var_35_45) / var_35_46

				if arg_32_1.var_.characterEffect1058ui_story and not isNil(var_35_44) then
					local var_35_48 = Mathf.Lerp(0, 0.5, var_35_47)

					arg_32_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1058ui_story.fillRatio = var_35_48
				end
			end

			if arg_32_1.time_ >= var_35_45 + var_35_46 and arg_32_1.time_ < var_35_45 + var_35_46 + arg_35_0 and not isNil(var_35_44) and arg_32_1.var_.characterEffect1058ui_story then
				local var_35_49 = 0.5

				arg_32_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1058ui_story.fillRatio = var_35_49
			end

			local var_35_50 = 0
			local var_35_51 = 0.775

			if var_35_50 < arg_32_1.time_ and arg_32_1.time_ <= var_35_50 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_52 = arg_32_1:FormatText(StoryNameCfg[84].name)

				arg_32_1.leftNameTxt_.text = var_35_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_53 = arg_32_1:GetWordFromCfg(317321007)
				local var_35_54 = arg_32_1:FormatText(var_35_53.content)

				arg_32_1.text_.text = var_35_54

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_55 = 31
				local var_35_56 = utf8.len(var_35_54)
				local var_35_57 = var_35_55 <= 0 and var_35_51 or var_35_51 * (var_35_56 / var_35_55)

				if var_35_57 > 0 and var_35_51 < var_35_57 then
					arg_32_1.talkMaxDuration = var_35_57

					if var_35_57 + var_35_50 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_57 + var_35_50
					end
				end

				arg_32_1.text_.text = var_35_54
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321007", "story_v_out_317321.awb") ~= 0 then
					local var_35_58 = manager.audio:GetVoiceLength("story_v_out_317321", "317321007", "story_v_out_317321.awb") / 1000

					if var_35_58 + var_35_50 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_58 + var_35_50
					end

					if var_35_53.prefab_name ~= "" and arg_32_1.actors_[var_35_53.prefab_name] ~= nil then
						local var_35_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_53.prefab_name].transform, "story_v_out_317321", "317321007", "story_v_out_317321.awb")

						arg_32_1:RecordAudio("317321007", var_35_59)
						arg_32_1:RecordAudio("317321007", var_35_59)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_317321", "317321007", "story_v_out_317321.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_317321", "317321007", "story_v_out_317321.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_60 = math.max(var_35_51, arg_32_1.talkMaxDuration)

			if var_35_50 <= arg_32_1.time_ and arg_32_1.time_ < var_35_50 + var_35_60 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_50) / var_35_60

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_50 + var_35_60 and arg_32_1.time_ < var_35_50 + var_35_60 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play317321008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 317321008
		arg_36_1.duration_ = 8.07

		local var_36_0 = {
			zh = 5.466,
			ja = 8.066
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
				arg_36_0:Play317321009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1199ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1199ui_story = var_39_0.localPosition
			end

			local var_39_2 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2
				local var_39_4 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1199ui_story, var_39_4, var_39_3)

				local var_39_5 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_5.x, var_39_5.y, var_39_5.z)

				local var_39_6 = var_39_0.localEulerAngles

				var_39_6.z = 0
				var_39_6.x = 0
				var_39_0.localEulerAngles = var_39_6
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, 100, 0)

				local var_39_7 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_7.x, var_39_7.y, var_39_7.z)

				local var_39_8 = var_39_0.localEulerAngles

				var_39_8.z = 0
				var_39_8.x = 0
				var_39_0.localEulerAngles = var_39_8
			end

			local var_39_9 = arg_36_1.actors_["1199ui_story"]
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.characterEffect1199ui_story == nil then
				arg_36_1.var_.characterEffect1199ui_story = var_39_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_11 = 0.200000002980232

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 and not isNil(var_39_9) then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11

				if arg_36_1.var_.characterEffect1199ui_story and not isNil(var_39_9) then
					local var_39_13 = Mathf.Lerp(0, 0.5, var_39_12)

					arg_36_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1199ui_story.fillRatio = var_39_13
				end
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.characterEffect1199ui_story then
				local var_39_14 = 0.5

				arg_36_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1199ui_story.fillRatio = var_39_14
			end

			local var_39_15 = arg_36_1.actors_["1093ui_story"].transform
			local var_39_16 = 0

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.var_.moveOldPos1093ui_story = var_39_15.localPosition
			end

			local var_39_17 = 0.001

			if var_39_16 <= arg_36_1.time_ and arg_36_1.time_ < var_39_16 + var_39_17 then
				local var_39_18 = (arg_36_1.time_ - var_39_16) / var_39_17
				local var_39_19 = Vector3.New(0, -1.11, -5.88)

				var_39_15.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1093ui_story, var_39_19, var_39_18)

				local var_39_20 = manager.ui.mainCamera.transform.position - var_39_15.position

				var_39_15.forward = Vector3.New(var_39_20.x, var_39_20.y, var_39_20.z)

				local var_39_21 = var_39_15.localEulerAngles

				var_39_21.z = 0
				var_39_21.x = 0
				var_39_15.localEulerAngles = var_39_21
			end

			if arg_36_1.time_ >= var_39_16 + var_39_17 and arg_36_1.time_ < var_39_16 + var_39_17 + arg_39_0 then
				var_39_15.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_39_22 = manager.ui.mainCamera.transform.position - var_39_15.position

				var_39_15.forward = Vector3.New(var_39_22.x, var_39_22.y, var_39_22.z)

				local var_39_23 = var_39_15.localEulerAngles

				var_39_23.z = 0
				var_39_23.x = 0
				var_39_15.localEulerAngles = var_39_23
			end

			local var_39_24 = arg_36_1.actors_["1093ui_story"]
			local var_39_25 = 0

			if var_39_25 < arg_36_1.time_ and arg_36_1.time_ <= var_39_25 + arg_39_0 and not isNil(var_39_24) and arg_36_1.var_.characterEffect1093ui_story == nil then
				arg_36_1.var_.characterEffect1093ui_story = var_39_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_26 = 0.200000002980232

			if var_39_25 <= arg_36_1.time_ and arg_36_1.time_ < var_39_25 + var_39_26 and not isNil(var_39_24) then
				local var_39_27 = (arg_36_1.time_ - var_39_25) / var_39_26

				if arg_36_1.var_.characterEffect1093ui_story and not isNil(var_39_24) then
					arg_36_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_25 + var_39_26 and arg_36_1.time_ < var_39_25 + var_39_26 + arg_39_0 and not isNil(var_39_24) and arg_36_1.var_.characterEffect1093ui_story then
				arg_36_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_39_28 = 0

			if var_39_28 < arg_36_1.time_ and arg_36_1.time_ <= var_39_28 + arg_39_0 then
				arg_36_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_39_29 = 0

			if var_39_29 < arg_36_1.time_ and arg_36_1.time_ <= var_39_29 + arg_39_0 then
				arg_36_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_39_30 = 0
			local var_39_31 = 0.6

			if var_39_30 < arg_36_1.time_ and arg_36_1.time_ <= var_39_30 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_32 = arg_36_1:FormatText(StoryNameCfg[73].name)

				arg_36_1.leftNameTxt_.text = var_39_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_33 = arg_36_1:GetWordFromCfg(317321008)
				local var_39_34 = arg_36_1:FormatText(var_39_33.content)

				arg_36_1.text_.text = var_39_34

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_35 = 24
				local var_39_36 = utf8.len(var_39_34)
				local var_39_37 = var_39_35 <= 0 and var_39_31 or var_39_31 * (var_39_36 / var_39_35)

				if var_39_37 > 0 and var_39_31 < var_39_37 then
					arg_36_1.talkMaxDuration = var_39_37

					if var_39_37 + var_39_30 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_37 + var_39_30
					end
				end

				arg_36_1.text_.text = var_39_34
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321008", "story_v_out_317321.awb") ~= 0 then
					local var_39_38 = manager.audio:GetVoiceLength("story_v_out_317321", "317321008", "story_v_out_317321.awb") / 1000

					if var_39_38 + var_39_30 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_38 + var_39_30
					end

					if var_39_33.prefab_name ~= "" and arg_36_1.actors_[var_39_33.prefab_name] ~= nil then
						local var_39_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_33.prefab_name].transform, "story_v_out_317321", "317321008", "story_v_out_317321.awb")

						arg_36_1:RecordAudio("317321008", var_39_39)
						arg_36_1:RecordAudio("317321008", var_39_39)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_317321", "317321008", "story_v_out_317321.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_317321", "317321008", "story_v_out_317321.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_40 = math.max(var_39_31, arg_36_1.talkMaxDuration)

			if var_39_30 <= arg_36_1.time_ and arg_36_1.time_ < var_39_30 + var_39_40 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_30) / var_39_40

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_30 + var_39_40 and arg_36_1.time_ < var_39_30 + var_39_40 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play317321009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 317321009
		arg_40_1.duration_ = 9.77

		local var_40_0 = {
			zh = 5.633,
			ja = 9.766
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
				arg_40_0:Play317321010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1093ui_story"].transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.moveOldPos1093ui_story = var_43_0.localPosition
			end

			local var_43_2 = 0.001

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2
				local var_43_4 = Vector3.New(0, 100, 0)

				var_43_0.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1093ui_story, var_43_4, var_43_3)

				local var_43_5 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_5.x, var_43_5.y, var_43_5.z)

				local var_43_6 = var_43_0.localEulerAngles

				var_43_6.z = 0
				var_43_6.x = 0
				var_43_0.localEulerAngles = var_43_6
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = Vector3.New(0, 100, 0)

				local var_43_7 = manager.ui.mainCamera.transform.position - var_43_0.position

				var_43_0.forward = Vector3.New(var_43_7.x, var_43_7.y, var_43_7.z)

				local var_43_8 = var_43_0.localEulerAngles

				var_43_8.z = 0
				var_43_8.x = 0
				var_43_0.localEulerAngles = var_43_8
			end

			local var_43_9 = arg_40_1.actors_["1093ui_story"]
			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect1093ui_story == nil then
				arg_40_1.var_.characterEffect1093ui_story = var_43_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_11 = 0.200000002980232

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_11 and not isNil(var_43_9) then
				local var_43_12 = (arg_40_1.time_ - var_43_10) / var_43_11

				if arg_40_1.var_.characterEffect1093ui_story and not isNil(var_43_9) then
					local var_43_13 = Mathf.Lerp(0, 0.5, var_43_12)

					arg_40_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1093ui_story.fillRatio = var_43_13
				end
			end

			if arg_40_1.time_ >= var_43_10 + var_43_11 and arg_40_1.time_ < var_43_10 + var_43_11 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect1093ui_story then
				local var_43_14 = 0.5

				arg_40_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1093ui_story.fillRatio = var_43_14
			end

			local var_43_15 = 0
			local var_43_16 = 0.35

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_17 = arg_40_1:FormatText(StoryNameCfg[570].name)

				arg_40_1.leftNameTxt_.text = var_43_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4039")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_18 = arg_40_1:GetWordFromCfg(317321009)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 14
				local var_43_21 = utf8.len(var_43_19)
				local var_43_22 = var_43_20 <= 0 and var_43_16 or var_43_16 * (var_43_21 / var_43_20)

				if var_43_22 > 0 and var_43_16 < var_43_22 then
					arg_40_1.talkMaxDuration = var_43_22

					if var_43_22 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_22 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_19
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321009", "story_v_out_317321.awb") ~= 0 then
					local var_43_23 = manager.audio:GetVoiceLength("story_v_out_317321", "317321009", "story_v_out_317321.awb") / 1000

					if var_43_23 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_23 + var_43_15
					end

					if var_43_18.prefab_name ~= "" and arg_40_1.actors_[var_43_18.prefab_name] ~= nil then
						local var_43_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_18.prefab_name].transform, "story_v_out_317321", "317321009", "story_v_out_317321.awb")

						arg_40_1:RecordAudio("317321009", var_43_24)
						arg_40_1:RecordAudio("317321009", var_43_24)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_317321", "317321009", "story_v_out_317321.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_317321", "317321009", "story_v_out_317321.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_25 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_25 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_25

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_25 and arg_40_1.time_ < var_43_15 + var_43_25 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play317321010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 317321010
		arg_44_1.duration_ = 9

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play317321011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "YA0207"

			if arg_44_1.bgs_[var_47_0] == nil then
				local var_47_1 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_47_0)
				var_47_1.name = var_47_0
				var_47_1.transform.parent = arg_44_1.stage_.transform
				var_47_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_[var_47_0] = var_47_1
			end

			local var_47_2 = 2

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				local var_47_3 = manager.ui.mainCamera.transform.localPosition
				local var_47_4 = Vector3.New(0, 0, 10) + Vector3.New(var_47_3.x, var_47_3.y, 0)
				local var_47_5 = arg_44_1.bgs_.YA0207

				var_47_5.transform.localPosition = var_47_4
				var_47_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_6 = var_47_5:GetComponent("SpriteRenderer")

				if var_47_6 and var_47_6.sprite then
					local var_47_7 = (var_47_5.transform.localPosition - var_47_3).z
					local var_47_8 = manager.ui.mainCameraCom_
					local var_47_9 = 2 * var_47_7 * Mathf.Tan(var_47_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_47_10 = var_47_9 * var_47_8.aspect
					local var_47_11 = var_47_6.sprite.bounds.size.x
					local var_47_12 = var_47_6.sprite.bounds.size.y
					local var_47_13 = var_47_10 / var_47_11
					local var_47_14 = var_47_9 / var_47_12
					local var_47_15 = var_47_14 < var_47_13 and var_47_13 or var_47_14

					var_47_5.transform.localScale = Vector3.New(var_47_15, var_47_15, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "YA0207" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_17 = 2

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_17 then
				local var_47_18 = (arg_44_1.time_ - var_47_16) / var_47_17
				local var_47_19 = Color.New(0, 0, 0)

				var_47_19.a = Mathf.Lerp(0, 1, var_47_18)
				arg_44_1.mask_.color = var_47_19
			end

			if arg_44_1.time_ >= var_47_16 + var_47_17 and arg_44_1.time_ < var_47_16 + var_47_17 + arg_47_0 then
				local var_47_20 = Color.New(0, 0, 0)

				var_47_20.a = 1
				arg_44_1.mask_.color = var_47_20
			end

			local var_47_21 = 2

			if var_47_21 < arg_44_1.time_ and arg_44_1.time_ <= var_47_21 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_22 = 2

			if var_47_21 <= arg_44_1.time_ and arg_44_1.time_ < var_47_21 + var_47_22 then
				local var_47_23 = (arg_44_1.time_ - var_47_21) / var_47_22
				local var_47_24 = Color.New(0, 0, 0)

				var_47_24.a = Mathf.Lerp(1, 0, var_47_23)
				arg_44_1.mask_.color = var_47_24
			end

			if arg_44_1.time_ >= var_47_21 + var_47_22 and arg_44_1.time_ < var_47_21 + var_47_22 + arg_47_0 then
				local var_47_25 = Color.New(0, 0, 0)
				local var_47_26 = 0

				arg_44_1.mask_.enabled = false
				var_47_25.a = var_47_26
				arg_44_1.mask_.color = var_47_25
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_27 = 4
			local var_47_28 = 1.1

			if var_47_27 < arg_44_1.time_ and arg_44_1.time_ <= var_47_27 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_29 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_29:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_30 = arg_44_1:GetWordFromCfg(317321010)
				local var_47_31 = arg_44_1:FormatText(var_47_30.content)

				arg_44_1.text_.text = var_47_31

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_32 = 44
				local var_47_33 = utf8.len(var_47_31)
				local var_47_34 = var_47_32 <= 0 and var_47_28 or var_47_28 * (var_47_33 / var_47_32)

				if var_47_34 > 0 and var_47_28 < var_47_34 then
					arg_44_1.talkMaxDuration = var_47_34
					var_47_27 = var_47_27 + 0.3

					if var_47_34 + var_47_27 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_34 + var_47_27
					end
				end

				arg_44_1.text_.text = var_47_31
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_35 = var_47_27 + 0.3
			local var_47_36 = math.max(var_47_28, arg_44_1.talkMaxDuration)

			if var_47_35 <= arg_44_1.time_ and arg_44_1.time_ < var_47_35 + var_47_36 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_35) / var_47_36

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_35 + var_47_36 and arg_44_1.time_ < var_47_35 + var_47_36 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play317321011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 317321011
		arg_50_1.duration_ = 4.23

		local var_50_0 = {
			zh = 2,
			ja = 4.233
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play317321012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 0.125

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_2 = arg_50_1:FormatText(StoryNameCfg[73].name)

				arg_50_1.leftNameTxt_.text = var_53_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_3 = arg_50_1:GetWordFromCfg(317321011)
				local var_53_4 = arg_50_1:FormatText(var_53_3.content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 5
				local var_53_6 = utf8.len(var_53_4)
				local var_53_7 = var_53_5 <= 0 and var_53_1 or var_53_1 * (var_53_6 / var_53_5)

				if var_53_7 > 0 and var_53_1 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321011", "story_v_out_317321.awb") ~= 0 then
					local var_53_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321011", "story_v_out_317321.awb") / 1000

					if var_53_8 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_8 + var_53_0
					end

					if var_53_3.prefab_name ~= "" and arg_50_1.actors_[var_53_3.prefab_name] ~= nil then
						local var_53_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_3.prefab_name].transform, "story_v_out_317321", "317321011", "story_v_out_317321.awb")

						arg_50_1:RecordAudio("317321011", var_53_9)
						arg_50_1:RecordAudio("317321011", var_53_9)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_317321", "317321011", "story_v_out_317321.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_317321", "317321011", "story_v_out_317321.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_10 and arg_50_1.time_ < var_53_0 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play317321012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 317321012
		arg_54_1.duration_ = 8.53

		local var_54_0 = {
			zh = 4.9,
			ja = 8.533
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play317321013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 0.525

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_2 = arg_54_1:FormatText(StoryNameCfg[92].name)

				arg_54_1.leftNameTxt_.text = var_57_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1058")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_3 = arg_54_1:GetWordFromCfg(317321012)
				local var_57_4 = arg_54_1:FormatText(var_57_3.content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 21
				local var_57_6 = utf8.len(var_57_4)
				local var_57_7 = var_57_5 <= 0 and var_57_1 or var_57_1 * (var_57_6 / var_57_5)

				if var_57_7 > 0 and var_57_1 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_4
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321012", "story_v_out_317321.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321012", "story_v_out_317321.awb") / 1000

					if var_57_8 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_0
					end

					if var_57_3.prefab_name ~= "" and arg_54_1.actors_[var_57_3.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_3.prefab_name].transform, "story_v_out_317321", "317321012", "story_v_out_317321.awb")

						arg_54_1:RecordAudio("317321012", var_57_9)
						arg_54_1:RecordAudio("317321012", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_317321", "317321012", "story_v_out_317321.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_317321", "317321012", "story_v_out_317321.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_10 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_10 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_10

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_10 and arg_54_1.time_ < var_57_0 + var_57_10 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play317321013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 317321013
		arg_58_1.duration_ = 15.2

		local var_58_0 = {
			zh = 15.2,
			ja = 10.1
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
				arg_58_0:Play317321014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 1.2

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[570].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4039")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:GetWordFromCfg(317321013)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 48
				local var_61_6 = utf8.len(var_61_4)
				local var_61_7 = var_61_5 <= 0 and var_61_1 or var_61_1 * (var_61_6 / var_61_5)

				if var_61_7 > 0 and var_61_1 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321013", "story_v_out_317321.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321013", "story_v_out_317321.awb") / 1000

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_317321", "317321013", "story_v_out_317321.awb")

						arg_58_1:RecordAudio("317321013", var_61_9)
						arg_58_1:RecordAudio("317321013", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_317321", "317321013", "story_v_out_317321.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_317321", "317321013", "story_v_out_317321.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_10 and arg_58_1.time_ < var_61_0 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play317321014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 317321014
		arg_62_1.duration_ = 7.77

		local var_62_0 = {
			zh = 5.1,
			ja = 7.766
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play317321015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 0.375

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_2 = arg_62_1:FormatText(StoryNameCfg[570].name)

				arg_62_1.leftNameTxt_.text = var_65_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4039")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_3 = arg_62_1:GetWordFromCfg(317321014)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 15
				local var_65_6 = utf8.len(var_65_4)
				local var_65_7 = var_65_5 <= 0 and var_65_1 or var_65_1 * (var_65_6 / var_65_5)

				if var_65_7 > 0 and var_65_1 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321014", "story_v_out_317321.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321014", "story_v_out_317321.awb") / 1000

					if var_65_8 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_0
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_317321", "317321014", "story_v_out_317321.awb")

						arg_62_1:RecordAudio("317321014", var_65_9)
						arg_62_1:RecordAudio("317321014", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_317321", "317321014", "story_v_out_317321.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_317321", "317321014", "story_v_out_317321.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_10 and arg_62_1.time_ < var_65_0 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play317321015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 317321015
		arg_66_1.duration_ = 2.6

		local var_66_0 = {
			zh = 0.999999999999,
			ja = 2.6
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play317321016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.075

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[84].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_3 = arg_66_1:GetWordFromCfg(317321015)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 3
				local var_69_6 = utf8.len(var_69_4)
				local var_69_7 = var_69_5 <= 0 and var_69_1 or var_69_1 * (var_69_6 / var_69_5)

				if var_69_7 > 0 and var_69_1 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321015", "story_v_out_317321.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321015", "story_v_out_317321.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_317321", "317321015", "story_v_out_317321.awb")

						arg_66_1:RecordAudio("317321015", var_69_9)
						arg_66_1:RecordAudio("317321015", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_317321", "317321015", "story_v_out_317321.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_317321", "317321015", "story_v_out_317321.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_10 and arg_66_1.time_ < var_69_0 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play317321016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 317321016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play317321017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.875

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_2 = arg_70_1:GetWordFromCfg(317321016)
				local var_73_3 = arg_70_1:FormatText(var_73_2.content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 35
				local var_73_5 = utf8.len(var_73_3)
				local var_73_6 = var_73_4 <= 0 and var_73_1 or var_73_1 * (var_73_5 / var_73_4)

				if var_73_6 > 0 and var_73_1 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_7 and arg_70_1.time_ < var_73_0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play317321017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 317321017
		arg_74_1.duration_ = 7.63

		local var_74_0 = {
			zh = 3.9,
			ja = 7.633
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
				arg_74_0:Play317321018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.5

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[84].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(317321017)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 20
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321017", "story_v_out_317321.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321017", "story_v_out_317321.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_317321", "317321017", "story_v_out_317321.awb")

						arg_74_1:RecordAudio("317321017", var_77_9)
						arg_74_1:RecordAudio("317321017", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_317321", "317321017", "story_v_out_317321.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_317321", "317321017", "story_v_out_317321.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play317321018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 317321018
		arg_78_1.duration_ = 11

		local var_78_0 = {
			zh = 7.833,
			ja = 11
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play317321019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.65

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[570].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4039")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_3 = arg_78_1:GetWordFromCfg(317321018)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 26
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321018", "story_v_out_317321.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321018", "story_v_out_317321.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_317321", "317321018", "story_v_out_317321.awb")

						arg_78_1:RecordAudio("317321018", var_81_9)
						arg_78_1:RecordAudio("317321018", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_317321", "317321018", "story_v_out_317321.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_317321", "317321018", "story_v_out_317321.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play317321019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 317321019
		arg_82_1.duration_ = 7.33

		local var_82_0 = {
			zh = 7.333,
			ja = 6.833
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play317321020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.825

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[84].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:GetWordFromCfg(317321019)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321019", "story_v_out_317321.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321019", "story_v_out_317321.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_317321", "317321019", "story_v_out_317321.awb")

						arg_82_1:RecordAudio("317321019", var_85_9)
						arg_82_1:RecordAudio("317321019", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_317321", "317321019", "story_v_out_317321.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_317321", "317321019", "story_v_out_317321.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play317321020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 317321020
		arg_86_1.duration_ = 9.07

		local var_86_0 = {
			zh = 6.466,
			ja = 9.066
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
				arg_86_0:Play317321021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 0.725

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[84].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_3 = arg_86_1:GetWordFromCfg(317321020)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 29
				local var_89_6 = utf8.len(var_89_4)
				local var_89_7 = var_89_5 <= 0 and var_89_1 or var_89_1 * (var_89_6 / var_89_5)

				if var_89_7 > 0 and var_89_1 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321020", "story_v_out_317321.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321020", "story_v_out_317321.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_317321", "317321020", "story_v_out_317321.awb")

						arg_86_1:RecordAudio("317321020", var_89_9)
						arg_86_1:RecordAudio("317321020", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_317321", "317321020", "story_v_out_317321.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_317321", "317321020", "story_v_out_317321.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_10 and arg_86_1.time_ < var_89_0 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play317321021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 317321021
		arg_90_1.duration_ = 2.2

		local var_90_0 = {
			zh = 1.6,
			ja = 2.2
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play317321022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.1

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[570].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4039")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:GetWordFromCfg(317321021)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 4
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321021", "story_v_out_317321.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321021", "story_v_out_317321.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_317321", "317321021", "story_v_out_317321.awb")

						arg_90_1:RecordAudio("317321021", var_93_9)
						arg_90_1:RecordAudio("317321021", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_317321", "317321021", "story_v_out_317321.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_317321", "317321021", "story_v_out_317321.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_10 and arg_90_1.time_ < var_93_0 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play317321022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 317321022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play317321023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 1.175

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

				local var_97_2 = arg_94_1:GetWordFromCfg(317321022)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 47
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
	Play317321023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 317321023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play317321024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 1.05

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_2 = arg_98_1:GetWordFromCfg(317321023)
				local var_101_3 = arg_98_1:FormatText(var_101_2.content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 42
				local var_101_5 = utf8.len(var_101_3)
				local var_101_6 = var_101_4 <= 0 and var_101_1 or var_101_1 * (var_101_5 / var_101_4)

				if var_101_6 > 0 and var_101_1 < var_101_6 then
					arg_98_1.talkMaxDuration = var_101_6

					if var_101_6 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_7 and arg_98_1.time_ < var_101_0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play317321024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 317321024
		arg_102_1.duration_ = 7.9

		local var_102_0 = {
			zh = 5.133,
			ja = 7.9
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
				arg_102_0:Play317321025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.425

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_2 = arg_102_1:FormatText(StoryNameCfg[570].name)

				arg_102_1.leftNameTxt_.text = var_105_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4039")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_3 = arg_102_1:GetWordFromCfg(317321024)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 17
				local var_105_6 = utf8.len(var_105_4)
				local var_105_7 = var_105_5 <= 0 and var_105_1 or var_105_1 * (var_105_6 / var_105_5)

				if var_105_7 > 0 and var_105_1 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321024", "story_v_out_317321.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321024", "story_v_out_317321.awb") / 1000

					if var_105_8 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_0
					end

					if var_105_3.prefab_name ~= "" and arg_102_1.actors_[var_105_3.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_3.prefab_name].transform, "story_v_out_317321", "317321024", "story_v_out_317321.awb")

						arg_102_1:RecordAudio("317321024", var_105_9)
						arg_102_1:RecordAudio("317321024", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_317321", "317321024", "story_v_out_317321.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_317321", "317321024", "story_v_out_317321.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_10 and arg_102_1.time_ < var_105_0 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play317321025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 317321025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play317321026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.6

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				local var_109_2 = "play"
				local var_109_3 = "effect"

				arg_106_1:AudioAction(var_109_2, var_109_3, "se_story_127", "se_story_127_lens", "")
			end

			local var_109_4 = 0
			local var_109_5 = 0.65

			if var_109_4 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_6 = arg_106_1:GetWordFromCfg(317321025)
				local var_109_7 = arg_106_1:FormatText(var_109_6.content)

				arg_106_1.text_.text = var_109_7

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_8 = 26
				local var_109_9 = utf8.len(var_109_7)
				local var_109_10 = var_109_8 <= 0 and var_109_5 or var_109_5 * (var_109_9 / var_109_8)

				if var_109_10 > 0 and var_109_5 < var_109_10 then
					arg_106_1.talkMaxDuration = var_109_10

					if var_109_10 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_7
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_11 = math.max(var_109_5, arg_106_1.talkMaxDuration)

			if var_109_4 <= arg_106_1.time_ and arg_106_1.time_ < var_109_4 + var_109_11 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_4) / var_109_11

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_4 + var_109_11 and arg_106_1.time_ < var_109_4 + var_109_11 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play317321026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 317321026
		arg_110_1.duration_ = 9

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play317321027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 2

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				local var_113_1 = manager.ui.mainCamera.transform.localPosition
				local var_113_2 = Vector3.New(0, 0, 10) + Vector3.New(var_113_1.x, var_113_1.y, 0)
				local var_113_3 = arg_110_1.bgs_.K11g

				var_113_3.transform.localPosition = var_113_2
				var_113_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_4 = var_113_3:GetComponent("SpriteRenderer")

				if var_113_4 and var_113_4.sprite then
					local var_113_5 = (var_113_3.transform.localPosition - var_113_1).z
					local var_113_6 = manager.ui.mainCameraCom_
					local var_113_7 = 2 * var_113_5 * Mathf.Tan(var_113_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_113_8 = var_113_7 * var_113_6.aspect
					local var_113_9 = var_113_4.sprite.bounds.size.x
					local var_113_10 = var_113_4.sprite.bounds.size.y
					local var_113_11 = var_113_8 / var_113_9
					local var_113_12 = var_113_7 / var_113_10
					local var_113_13 = var_113_12 < var_113_11 and var_113_11 or var_113_12

					var_113_3.transform.localScale = Vector3.New(var_113_13, var_113_13, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "K11g" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_14 = 0

			if var_113_14 < arg_110_1.time_ and arg_110_1.time_ <= var_113_14 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_15 = 2

			if var_113_14 <= arg_110_1.time_ and arg_110_1.time_ < var_113_14 + var_113_15 then
				local var_113_16 = (arg_110_1.time_ - var_113_14) / var_113_15
				local var_113_17 = Color.New(0, 0, 0)

				var_113_17.a = Mathf.Lerp(0, 1, var_113_16)
				arg_110_1.mask_.color = var_113_17
			end

			if arg_110_1.time_ >= var_113_14 + var_113_15 and arg_110_1.time_ < var_113_14 + var_113_15 + arg_113_0 then
				local var_113_18 = Color.New(0, 0, 0)

				var_113_18.a = 1
				arg_110_1.mask_.color = var_113_18
			end

			local var_113_19 = 2

			if var_113_19 < arg_110_1.time_ and arg_110_1.time_ <= var_113_19 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_20 = 2

			if var_113_19 <= arg_110_1.time_ and arg_110_1.time_ < var_113_19 + var_113_20 then
				local var_113_21 = (arg_110_1.time_ - var_113_19) / var_113_20
				local var_113_22 = Color.New(0, 0, 0)

				var_113_22.a = Mathf.Lerp(1, 0, var_113_21)
				arg_110_1.mask_.color = var_113_22
			end

			if arg_110_1.time_ >= var_113_19 + var_113_20 and arg_110_1.time_ < var_113_19 + var_113_20 + arg_113_0 then
				local var_113_23 = Color.New(0, 0, 0)
				local var_113_24 = 0

				arg_110_1.mask_.enabled = false
				var_113_23.a = var_113_24
				arg_110_1.mask_.color = var_113_23
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_25 = 4
			local var_113_26 = 1.15

			if var_113_25 < arg_110_1.time_ and arg_110_1.time_ <= var_113_25 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_27 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_27:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_28 = arg_110_1:GetWordFromCfg(317321026)
				local var_113_29 = arg_110_1:FormatText(var_113_28.content)

				arg_110_1.text_.text = var_113_29

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_30 = 46
				local var_113_31 = utf8.len(var_113_29)
				local var_113_32 = var_113_30 <= 0 and var_113_26 or var_113_26 * (var_113_31 / var_113_30)

				if var_113_32 > 0 and var_113_26 < var_113_32 then
					arg_110_1.talkMaxDuration = var_113_32
					var_113_25 = var_113_25 + 0.3

					if var_113_32 + var_113_25 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_32 + var_113_25
					end
				end

				arg_110_1.text_.text = var_113_29
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_33 = var_113_25 + 0.3
			local var_113_34 = math.max(var_113_26, arg_110_1.talkMaxDuration)

			if var_113_33 <= arg_110_1.time_ and arg_110_1.time_ < var_113_33 + var_113_34 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_33) / var_113_34

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_33 + var_113_34 and arg_110_1.time_ < var_113_33 + var_113_34 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play317321027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 317321027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play317321028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.75

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_2 = arg_116_1:GetWordFromCfg(317321027)
				local var_119_3 = arg_116_1:FormatText(var_119_2.content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 30
				local var_119_5 = utf8.len(var_119_3)
				local var_119_6 = var_119_4 <= 0 and var_119_1 or var_119_1 * (var_119_5 / var_119_4)

				if var_119_6 > 0 and var_119_1 < var_119_6 then
					arg_116_1.talkMaxDuration = var_119_6

					if var_119_6 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_6 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_7 and arg_116_1.time_ < var_119_0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play317321028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 317321028
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play317321029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.325

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

				local var_123_2 = arg_120_1:GetWordFromCfg(317321028)
				local var_123_3 = arg_120_1:FormatText(var_123_2.content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 13
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
	Play317321029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 317321029
		arg_124_1.duration_ = 8.9

		local var_124_0 = {
			zh = 5.433,
			ja = 8.9
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play317321030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = "10053ui_story"

			if arg_124_1.actors_[var_127_0] == nil then
				local var_127_1 = Asset.Load("Char/" .. "10053ui_story")

				if not isNil(var_127_1) then
					local var_127_2 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_124_1.stage_.transform)

					var_127_2.name = var_127_0
					var_127_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_124_1.actors_[var_127_0] = var_127_2

					local var_127_3 = var_127_2:GetComponentInChildren(typeof(CharacterEffect))

					var_127_3.enabled = true

					local var_127_4 = GameObjectTools.GetOrAddComponent(var_127_2, typeof(DynamicBoneHelper))

					if var_127_4 then
						var_127_4:EnableDynamicBone(false)
					end

					arg_124_1:ShowWeapon(var_127_3.transform, false)

					arg_124_1.var_[var_127_0 .. "Animator"] = var_127_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_124_1.var_[var_127_0 .. "Animator"].applyRootMotion = true
					arg_124_1.var_[var_127_0 .. "LipSync"] = var_127_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_127_5 = arg_124_1.actors_["10053ui_story"].transform
			local var_127_6 = 0

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.var_.moveOldPos10053ui_story = var_127_5.localPosition
			end

			local var_127_7 = 0.001

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_7 then
				local var_127_8 = (arg_124_1.time_ - var_127_6) / var_127_7
				local var_127_9 = Vector3.New(0, -1.12, -5.99)

				var_127_5.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10053ui_story, var_127_9, var_127_8)

				local var_127_10 = manager.ui.mainCamera.transform.position - var_127_5.position

				var_127_5.forward = Vector3.New(var_127_10.x, var_127_10.y, var_127_10.z)

				local var_127_11 = var_127_5.localEulerAngles

				var_127_11.z = 0
				var_127_11.x = 0
				var_127_5.localEulerAngles = var_127_11
			end

			if arg_124_1.time_ >= var_127_6 + var_127_7 and arg_124_1.time_ < var_127_6 + var_127_7 + arg_127_0 then
				var_127_5.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_127_12 = manager.ui.mainCamera.transform.position - var_127_5.position

				var_127_5.forward = Vector3.New(var_127_12.x, var_127_12.y, var_127_12.z)

				local var_127_13 = var_127_5.localEulerAngles

				var_127_13.z = 0
				var_127_13.x = 0
				var_127_5.localEulerAngles = var_127_13
			end

			local var_127_14 = arg_124_1.actors_["10053ui_story"]
			local var_127_15 = 0

			if var_127_15 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 and not isNil(var_127_14) and arg_124_1.var_.characterEffect10053ui_story == nil then
				arg_124_1.var_.characterEffect10053ui_story = var_127_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_16 = 0.200000002980232

			if var_127_15 <= arg_124_1.time_ and arg_124_1.time_ < var_127_15 + var_127_16 and not isNil(var_127_14) then
				local var_127_17 = (arg_124_1.time_ - var_127_15) / var_127_16

				if arg_124_1.var_.characterEffect10053ui_story and not isNil(var_127_14) then
					arg_124_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_15 + var_127_16 and arg_124_1.time_ < var_127_15 + var_127_16 + arg_127_0 and not isNil(var_127_14) and arg_124_1.var_.characterEffect10053ui_story then
				arg_124_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_127_18 = 0

			if var_127_18 < arg_124_1.time_ and arg_124_1.time_ <= var_127_18 + arg_127_0 then
				arg_124_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_127_19 = 0

			if var_127_19 < arg_124_1.time_ and arg_124_1.time_ <= var_127_19 + arg_127_0 then
				arg_124_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_127_20 = 0
			local var_127_21 = 0.375

			if var_127_20 < arg_124_1.time_ and arg_124_1.time_ <= var_127_20 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_22 = arg_124_1:FormatText(StoryNameCfg[477].name)

				arg_124_1.leftNameTxt_.text = var_127_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_23 = arg_124_1:GetWordFromCfg(317321029)
				local var_127_24 = arg_124_1:FormatText(var_127_23.content)

				arg_124_1.text_.text = var_127_24

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_25 = 15
				local var_127_26 = utf8.len(var_127_24)
				local var_127_27 = var_127_25 <= 0 and var_127_21 or var_127_21 * (var_127_26 / var_127_25)

				if var_127_27 > 0 and var_127_21 < var_127_27 then
					arg_124_1.talkMaxDuration = var_127_27

					if var_127_27 + var_127_20 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_27 + var_127_20
					end
				end

				arg_124_1.text_.text = var_127_24
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321029", "story_v_out_317321.awb") ~= 0 then
					local var_127_28 = manager.audio:GetVoiceLength("story_v_out_317321", "317321029", "story_v_out_317321.awb") / 1000

					if var_127_28 + var_127_20 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_28 + var_127_20
					end

					if var_127_23.prefab_name ~= "" and arg_124_1.actors_[var_127_23.prefab_name] ~= nil then
						local var_127_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_23.prefab_name].transform, "story_v_out_317321", "317321029", "story_v_out_317321.awb")

						arg_124_1:RecordAudio("317321029", var_127_29)
						arg_124_1:RecordAudio("317321029", var_127_29)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_317321", "317321029", "story_v_out_317321.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_317321", "317321029", "story_v_out_317321.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_30 = math.max(var_127_21, arg_124_1.talkMaxDuration)

			if var_127_20 <= arg_124_1.time_ and arg_124_1.time_ < var_127_20 + var_127_30 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_20) / var_127_30

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_20 + var_127_30 and arg_124_1.time_ < var_127_20 + var_127_30 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play317321030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 317321030
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play317321031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["10053ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos10053ui_story = var_131_0.localPosition
			end

			local var_131_2 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2
				local var_131_4 = Vector3.New(0, 100, 0)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10053ui_story, var_131_4, var_131_3)

				local var_131_5 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_5.x, var_131_5.y, var_131_5.z)

				local var_131_6 = var_131_0.localEulerAngles

				var_131_6.z = 0
				var_131_6.x = 0
				var_131_0.localEulerAngles = var_131_6
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, 100, 0)

				local var_131_7 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_7.x, var_131_7.y, var_131_7.z)

				local var_131_8 = var_131_0.localEulerAngles

				var_131_8.z = 0
				var_131_8.x = 0
				var_131_0.localEulerAngles = var_131_8
			end

			local var_131_9 = arg_128_1.actors_["10053ui_story"]
			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect10053ui_story == nil then
				arg_128_1.var_.characterEffect10053ui_story = var_131_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_11 = 0.200000002980232

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_11 and not isNil(var_131_9) then
				local var_131_12 = (arg_128_1.time_ - var_131_10) / var_131_11

				if arg_128_1.var_.characterEffect10053ui_story and not isNil(var_131_9) then
					local var_131_13 = Mathf.Lerp(0, 0.5, var_131_12)

					arg_128_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_128_1.var_.characterEffect10053ui_story.fillRatio = var_131_13
				end
			end

			if arg_128_1.time_ >= var_131_10 + var_131_11 and arg_128_1.time_ < var_131_10 + var_131_11 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect10053ui_story then
				local var_131_14 = 0.5

				arg_128_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_128_1.var_.characterEffect10053ui_story.fillRatio = var_131_14
			end

			local var_131_15 = 0
			local var_131_16 = 1.075

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_17 = arg_128_1:GetWordFromCfg(317321030)
				local var_131_18 = arg_128_1:FormatText(var_131_17.content)

				arg_128_1.text_.text = var_131_18

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_19 = 43
				local var_131_20 = utf8.len(var_131_18)
				local var_131_21 = var_131_19 <= 0 and var_131_16 or var_131_16 * (var_131_20 / var_131_19)

				if var_131_21 > 0 and var_131_16 < var_131_21 then
					arg_128_1.talkMaxDuration = var_131_21

					if var_131_21 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_21 + var_131_15
					end
				end

				arg_128_1.text_.text = var_131_18
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_22 = math.max(var_131_16, arg_128_1.talkMaxDuration)

			if var_131_15 <= arg_128_1.time_ and arg_128_1.time_ < var_131_15 + var_131_22 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_15) / var_131_22

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_15 + var_131_22 and arg_128_1.time_ < var_131_15 + var_131_22 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play317321031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 317321031
		arg_132_1.duration_ = 7.93

		local var_132_0 = {
			zh = 5.466,
			ja = 7.933
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play317321032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = "1015ui_story"

			if arg_132_1.actors_[var_135_0] == nil then
				local var_135_1 = Asset.Load("Char/" .. "1015ui_story")

				if not isNil(var_135_1) then
					local var_135_2 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_132_1.stage_.transform)

					var_135_2.name = var_135_0
					var_135_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_132_1.actors_[var_135_0] = var_135_2

					local var_135_3 = var_135_2:GetComponentInChildren(typeof(CharacterEffect))

					var_135_3.enabled = true

					local var_135_4 = GameObjectTools.GetOrAddComponent(var_135_2, typeof(DynamicBoneHelper))

					if var_135_4 then
						var_135_4:EnableDynamicBone(false)
					end

					arg_132_1:ShowWeapon(var_135_3.transform, false)

					arg_132_1.var_[var_135_0 .. "Animator"] = var_135_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_132_1.var_[var_135_0 .. "Animator"].applyRootMotion = true
					arg_132_1.var_[var_135_0 .. "LipSync"] = var_135_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_135_5 = arg_132_1.actors_["1015ui_story"].transform
			local var_135_6 = 0

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.var_.moveOldPos1015ui_story = var_135_5.localPosition
			end

			local var_135_7 = 0.001

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_7 then
				local var_135_8 = (arg_132_1.time_ - var_135_6) / var_135_7
				local var_135_9 = Vector3.New(-0.7, -1.15, -6.2)

				var_135_5.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1015ui_story, var_135_9, var_135_8)

				local var_135_10 = manager.ui.mainCamera.transform.position - var_135_5.position

				var_135_5.forward = Vector3.New(var_135_10.x, var_135_10.y, var_135_10.z)

				local var_135_11 = var_135_5.localEulerAngles

				var_135_11.z = 0
				var_135_11.x = 0
				var_135_5.localEulerAngles = var_135_11
			end

			if arg_132_1.time_ >= var_135_6 + var_135_7 and arg_132_1.time_ < var_135_6 + var_135_7 + arg_135_0 then
				var_135_5.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_135_12 = manager.ui.mainCamera.transform.position - var_135_5.position

				var_135_5.forward = Vector3.New(var_135_12.x, var_135_12.y, var_135_12.z)

				local var_135_13 = var_135_5.localEulerAngles

				var_135_13.z = 0
				var_135_13.x = 0
				var_135_5.localEulerAngles = var_135_13
			end

			local var_135_14 = arg_132_1.actors_["1015ui_story"]
			local var_135_15 = 0

			if var_135_15 < arg_132_1.time_ and arg_132_1.time_ <= var_135_15 + arg_135_0 and not isNil(var_135_14) and arg_132_1.var_.characterEffect1015ui_story == nil then
				arg_132_1.var_.characterEffect1015ui_story = var_135_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_16 = 0.200000002980232

			if var_135_15 <= arg_132_1.time_ and arg_132_1.time_ < var_135_15 + var_135_16 and not isNil(var_135_14) then
				local var_135_17 = (arg_132_1.time_ - var_135_15) / var_135_16

				if arg_132_1.var_.characterEffect1015ui_story and not isNil(var_135_14) then
					arg_132_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_15 + var_135_16 and arg_132_1.time_ < var_135_15 + var_135_16 + arg_135_0 and not isNil(var_135_14) and arg_132_1.var_.characterEffect1015ui_story then
				arg_132_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_135_18 = 0

			if var_135_18 < arg_132_1.time_ and arg_132_1.time_ <= var_135_18 + arg_135_0 then
				arg_132_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_135_19 = 0

			if var_135_19 < arg_132_1.time_ and arg_132_1.time_ <= var_135_19 + arg_135_0 then
				arg_132_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_135_20 = arg_132_1.actors_["10053ui_story"].transform
			local var_135_21 = 0

			if var_135_21 < arg_132_1.time_ and arg_132_1.time_ <= var_135_21 + arg_135_0 then
				arg_132_1.var_.moveOldPos10053ui_story = var_135_20.localPosition
			end

			local var_135_22 = 0.001

			if var_135_21 <= arg_132_1.time_ and arg_132_1.time_ < var_135_21 + var_135_22 then
				local var_135_23 = (arg_132_1.time_ - var_135_21) / var_135_22
				local var_135_24 = Vector3.New(0.7, -1.12, -5.99)

				var_135_20.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10053ui_story, var_135_24, var_135_23)

				local var_135_25 = manager.ui.mainCamera.transform.position - var_135_20.position

				var_135_20.forward = Vector3.New(var_135_25.x, var_135_25.y, var_135_25.z)

				local var_135_26 = var_135_20.localEulerAngles

				var_135_26.z = 0
				var_135_26.x = 0
				var_135_20.localEulerAngles = var_135_26
			end

			if arg_132_1.time_ >= var_135_21 + var_135_22 and arg_132_1.time_ < var_135_21 + var_135_22 + arg_135_0 then
				var_135_20.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_135_27 = manager.ui.mainCamera.transform.position - var_135_20.position

				var_135_20.forward = Vector3.New(var_135_27.x, var_135_27.y, var_135_27.z)

				local var_135_28 = var_135_20.localEulerAngles

				var_135_28.z = 0
				var_135_28.x = 0
				var_135_20.localEulerAngles = var_135_28
			end

			local var_135_29 = arg_132_1.actors_["10053ui_story"]
			local var_135_30 = 0

			if var_135_30 < arg_132_1.time_ and arg_132_1.time_ <= var_135_30 + arg_135_0 and not isNil(var_135_29) and arg_132_1.var_.characterEffect10053ui_story == nil then
				arg_132_1.var_.characterEffect10053ui_story = var_135_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_31 = 0.200000002980232

			if var_135_30 <= arg_132_1.time_ and arg_132_1.time_ < var_135_30 + var_135_31 and not isNil(var_135_29) then
				local var_135_32 = (arg_132_1.time_ - var_135_30) / var_135_31

				if arg_132_1.var_.characterEffect10053ui_story and not isNil(var_135_29) then
					local var_135_33 = Mathf.Lerp(0, 0.5, var_135_32)

					arg_132_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_132_1.var_.characterEffect10053ui_story.fillRatio = var_135_33
				end
			end

			if arg_132_1.time_ >= var_135_30 + var_135_31 and arg_132_1.time_ < var_135_30 + var_135_31 + arg_135_0 and not isNil(var_135_29) and arg_132_1.var_.characterEffect10053ui_story then
				local var_135_34 = 0.5

				arg_132_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_132_1.var_.characterEffect10053ui_story.fillRatio = var_135_34
			end

			local var_135_35 = 0
			local var_135_36 = 0.575

			if var_135_35 < arg_132_1.time_ and arg_132_1.time_ <= var_135_35 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_37 = arg_132_1:FormatText(StoryNameCfg[479].name)

				arg_132_1.leftNameTxt_.text = var_135_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_38 = arg_132_1:GetWordFromCfg(317321031)
				local var_135_39 = arg_132_1:FormatText(var_135_38.content)

				arg_132_1.text_.text = var_135_39

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_40 = 23
				local var_135_41 = utf8.len(var_135_39)
				local var_135_42 = var_135_40 <= 0 and var_135_36 or var_135_36 * (var_135_41 / var_135_40)

				if var_135_42 > 0 and var_135_36 < var_135_42 then
					arg_132_1.talkMaxDuration = var_135_42

					if var_135_42 + var_135_35 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_42 + var_135_35
					end
				end

				arg_132_1.text_.text = var_135_39
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321031", "story_v_out_317321.awb") ~= 0 then
					local var_135_43 = manager.audio:GetVoiceLength("story_v_out_317321", "317321031", "story_v_out_317321.awb") / 1000

					if var_135_43 + var_135_35 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_43 + var_135_35
					end

					if var_135_38.prefab_name ~= "" and arg_132_1.actors_[var_135_38.prefab_name] ~= nil then
						local var_135_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_38.prefab_name].transform, "story_v_out_317321", "317321031", "story_v_out_317321.awb")

						arg_132_1:RecordAudio("317321031", var_135_44)
						arg_132_1:RecordAudio("317321031", var_135_44)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_317321", "317321031", "story_v_out_317321.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_317321", "317321031", "story_v_out_317321.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_45 = math.max(var_135_36, arg_132_1.talkMaxDuration)

			if var_135_35 <= arg_132_1.time_ and arg_132_1.time_ < var_135_35 + var_135_45 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_35) / var_135_45

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_35 + var_135_45 and arg_132_1.time_ < var_135_35 + var_135_45 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play317321032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 317321032
		arg_136_1.duration_ = 10.67

		local var_136_0 = {
			zh = 8,
			ja = 10.666
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play317321033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10053ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos10053ui_story = var_139_0.localPosition
			end

			local var_139_2 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2
				local var_139_4 = Vector3.New(0.7, -1.12, -5.99)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10053ui_story, var_139_4, var_139_3)

				local var_139_5 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_5.x, var_139_5.y, var_139_5.z)

				local var_139_6 = var_139_0.localEulerAngles

				var_139_6.z = 0
				var_139_6.x = 0
				var_139_0.localEulerAngles = var_139_6
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_139_7 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_7.x, var_139_7.y, var_139_7.z)

				local var_139_8 = var_139_0.localEulerAngles

				var_139_8.z = 0
				var_139_8.x = 0
				var_139_0.localEulerAngles = var_139_8
			end

			local var_139_9 = arg_136_1.actors_["10053ui_story"]
			local var_139_10 = 0

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect10053ui_story == nil then
				arg_136_1.var_.characterEffect10053ui_story = var_139_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_11 = 0.200000002980232

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_11 and not isNil(var_139_9) then
				local var_139_12 = (arg_136_1.time_ - var_139_10) / var_139_11

				if arg_136_1.var_.characterEffect10053ui_story and not isNil(var_139_9) then
					arg_136_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_10 + var_139_11 and arg_136_1.time_ < var_139_10 + var_139_11 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect10053ui_story then
				arg_136_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_139_13 = 0

			if var_139_13 < arg_136_1.time_ and arg_136_1.time_ <= var_139_13 + arg_139_0 then
				arg_136_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action8_1")
			end

			local var_139_14 = 0

			if var_139_14 < arg_136_1.time_ and arg_136_1.time_ <= var_139_14 + arg_139_0 then
				arg_136_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_139_15 = arg_136_1.actors_["1015ui_story"]
			local var_139_16 = 0

			if var_139_16 < arg_136_1.time_ and arg_136_1.time_ <= var_139_16 + arg_139_0 and not isNil(var_139_15) and arg_136_1.var_.characterEffect1015ui_story == nil then
				arg_136_1.var_.characterEffect1015ui_story = var_139_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_17 = 0.200000002980232

			if var_139_16 <= arg_136_1.time_ and arg_136_1.time_ < var_139_16 + var_139_17 and not isNil(var_139_15) then
				local var_139_18 = (arg_136_1.time_ - var_139_16) / var_139_17

				if arg_136_1.var_.characterEffect1015ui_story and not isNil(var_139_15) then
					local var_139_19 = Mathf.Lerp(0, 0.5, var_139_18)

					arg_136_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1015ui_story.fillRatio = var_139_19
				end
			end

			if arg_136_1.time_ >= var_139_16 + var_139_17 and arg_136_1.time_ < var_139_16 + var_139_17 + arg_139_0 and not isNil(var_139_15) and arg_136_1.var_.characterEffect1015ui_story then
				local var_139_20 = 0.5

				arg_136_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1015ui_story.fillRatio = var_139_20
			end

			local var_139_21 = 0
			local var_139_22 = 0.85

			if var_139_21 < arg_136_1.time_ and arg_136_1.time_ <= var_139_21 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_23 = arg_136_1:FormatText(StoryNameCfg[477].name)

				arg_136_1.leftNameTxt_.text = var_139_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_24 = arg_136_1:GetWordFromCfg(317321032)
				local var_139_25 = arg_136_1:FormatText(var_139_24.content)

				arg_136_1.text_.text = var_139_25

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_26 = 34
				local var_139_27 = utf8.len(var_139_25)
				local var_139_28 = var_139_26 <= 0 and var_139_22 or var_139_22 * (var_139_27 / var_139_26)

				if var_139_28 > 0 and var_139_22 < var_139_28 then
					arg_136_1.talkMaxDuration = var_139_28

					if var_139_28 + var_139_21 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_28 + var_139_21
					end
				end

				arg_136_1.text_.text = var_139_25
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321032", "story_v_out_317321.awb") ~= 0 then
					local var_139_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321032", "story_v_out_317321.awb") / 1000

					if var_139_29 + var_139_21 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_29 + var_139_21
					end

					if var_139_24.prefab_name ~= "" and arg_136_1.actors_[var_139_24.prefab_name] ~= nil then
						local var_139_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_24.prefab_name].transform, "story_v_out_317321", "317321032", "story_v_out_317321.awb")

						arg_136_1:RecordAudio("317321032", var_139_30)
						arg_136_1:RecordAudio("317321032", var_139_30)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_317321", "317321032", "story_v_out_317321.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_317321", "317321032", "story_v_out_317321.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_31 = math.max(var_139_22, arg_136_1.talkMaxDuration)

			if var_139_21 <= arg_136_1.time_ and arg_136_1.time_ < var_139_21 + var_139_31 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_21) / var_139_31

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_21 + var_139_31 and arg_136_1.time_ < var_139_21 + var_139_31 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play317321033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 317321033
		arg_140_1.duration_ = 11.63

		local var_140_0 = {
			zh = 6.733,
			ja = 11.633
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play317321034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 0.7

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[477].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_3 = arg_140_1:GetWordFromCfg(317321033)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321033", "story_v_out_317321.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321033", "story_v_out_317321.awb") / 1000

					if var_143_8 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_0
					end

					if var_143_3.prefab_name ~= "" and arg_140_1.actors_[var_143_3.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_3.prefab_name].transform, "story_v_out_317321", "317321033", "story_v_out_317321.awb")

						arg_140_1:RecordAudio("317321033", var_143_9)
						arg_140_1:RecordAudio("317321033", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_317321", "317321033", "story_v_out_317321.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_317321", "317321033", "story_v_out_317321.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_10 and arg_140_1.time_ < var_143_0 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play317321034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 317321034
		arg_144_1.duration_ = 16.5

		local var_144_0 = {
			zh = 16.5,
			ja = 11.233
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play317321035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["10053ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect10053ui_story == nil then
				arg_144_1.var_.characterEffect10053ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect10053ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect10053ui_story then
				arg_144_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_147_4 = 0
			local var_147_5 = 1.375

			if var_147_4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_6 = arg_144_1:FormatText(StoryNameCfg[477].name)

				arg_144_1.leftNameTxt_.text = var_147_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_7 = arg_144_1:GetWordFromCfg(317321034)
				local var_147_8 = arg_144_1:FormatText(var_147_7.content)

				arg_144_1.text_.text = var_147_8

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 55
				local var_147_10 = utf8.len(var_147_8)
				local var_147_11 = var_147_9 <= 0 and var_147_5 or var_147_5 * (var_147_10 / var_147_9)

				if var_147_11 > 0 and var_147_5 < var_147_11 then
					arg_144_1.talkMaxDuration = var_147_11

					if var_147_11 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_11 + var_147_4
					end
				end

				arg_144_1.text_.text = var_147_8
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321034", "story_v_out_317321.awb") ~= 0 then
					local var_147_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321034", "story_v_out_317321.awb") / 1000

					if var_147_12 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_4
					end

					if var_147_7.prefab_name ~= "" and arg_144_1.actors_[var_147_7.prefab_name] ~= nil then
						local var_147_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_7.prefab_name].transform, "story_v_out_317321", "317321034", "story_v_out_317321.awb")

						arg_144_1:RecordAudio("317321034", var_147_13)
						arg_144_1:RecordAudio("317321034", var_147_13)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_317321", "317321034", "story_v_out_317321.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_317321", "317321034", "story_v_out_317321.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_14 = math.max(var_147_5, arg_144_1.talkMaxDuration)

			if var_147_4 <= arg_144_1.time_ and arg_144_1.time_ < var_147_4 + var_147_14 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_4) / var_147_14

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_4 + var_147_14 and arg_144_1.time_ < var_147_4 + var_147_14 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play317321035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 317321035
		arg_148_1.duration_ = 6.47

		local var_148_0 = {
			zh = 6.466,
			ja = 4.666
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play317321036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1015ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1015ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1015ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = arg_148_1.actors_["1015ui_story"]
			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect1015ui_story == nil then
				arg_148_1.var_.characterEffect1015ui_story = var_151_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_11 = 0.200000002980232

			if var_151_10 <= arg_148_1.time_ and arg_148_1.time_ < var_151_10 + var_151_11 and not isNil(var_151_9) then
				local var_151_12 = (arg_148_1.time_ - var_151_10) / var_151_11

				if arg_148_1.var_.characterEffect1015ui_story and not isNil(var_151_9) then
					arg_148_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_10 + var_151_11 and arg_148_1.time_ < var_151_10 + var_151_11 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect1015ui_story then
				arg_148_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_151_13 = 0

			if var_151_13 < arg_148_1.time_ and arg_148_1.time_ <= var_151_13 + arg_151_0 then
				arg_148_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_151_14 = 0

			if var_151_14 < arg_148_1.time_ and arg_148_1.time_ <= var_151_14 + arg_151_0 then
				arg_148_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_151_15 = arg_148_1.actors_["10053ui_story"]
			local var_151_16 = 0

			if var_151_16 < arg_148_1.time_ and arg_148_1.time_ <= var_151_16 + arg_151_0 and not isNil(var_151_15) and arg_148_1.var_.characterEffect10053ui_story == nil then
				arg_148_1.var_.characterEffect10053ui_story = var_151_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_17 = 0.200000002980232

			if var_151_16 <= arg_148_1.time_ and arg_148_1.time_ < var_151_16 + var_151_17 and not isNil(var_151_15) then
				local var_151_18 = (arg_148_1.time_ - var_151_16) / var_151_17

				if arg_148_1.var_.characterEffect10053ui_story and not isNil(var_151_15) then
					local var_151_19 = Mathf.Lerp(0, 0.5, var_151_18)

					arg_148_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10053ui_story.fillRatio = var_151_19
				end
			end

			if arg_148_1.time_ >= var_151_16 + var_151_17 and arg_148_1.time_ < var_151_16 + var_151_17 + arg_151_0 and not isNil(var_151_15) and arg_148_1.var_.characterEffect10053ui_story then
				local var_151_20 = 0.5

				arg_148_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10053ui_story.fillRatio = var_151_20
			end

			local var_151_21 = 0
			local var_151_22 = 0.725

			if var_151_21 < arg_148_1.time_ and arg_148_1.time_ <= var_151_21 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_23 = arg_148_1:FormatText(StoryNameCfg[479].name)

				arg_148_1.leftNameTxt_.text = var_151_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_24 = arg_148_1:GetWordFromCfg(317321035)
				local var_151_25 = arg_148_1:FormatText(var_151_24.content)

				arg_148_1.text_.text = var_151_25

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_26 = 29
				local var_151_27 = utf8.len(var_151_25)
				local var_151_28 = var_151_26 <= 0 and var_151_22 or var_151_22 * (var_151_27 / var_151_26)

				if var_151_28 > 0 and var_151_22 < var_151_28 then
					arg_148_1.talkMaxDuration = var_151_28

					if var_151_28 + var_151_21 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_28 + var_151_21
					end
				end

				arg_148_1.text_.text = var_151_25
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321035", "story_v_out_317321.awb") ~= 0 then
					local var_151_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321035", "story_v_out_317321.awb") / 1000

					if var_151_29 + var_151_21 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_29 + var_151_21
					end

					if var_151_24.prefab_name ~= "" and arg_148_1.actors_[var_151_24.prefab_name] ~= nil then
						local var_151_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_24.prefab_name].transform, "story_v_out_317321", "317321035", "story_v_out_317321.awb")

						arg_148_1:RecordAudio("317321035", var_151_30)
						arg_148_1:RecordAudio("317321035", var_151_30)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_317321", "317321035", "story_v_out_317321.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_317321", "317321035", "story_v_out_317321.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_31 = math.max(var_151_22, arg_148_1.talkMaxDuration)

			if var_151_21 <= arg_148_1.time_ and arg_148_1.time_ < var_151_21 + var_151_31 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_21) / var_151_31

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_21 + var_151_31 and arg_148_1.time_ < var_151_21 + var_151_31 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317321036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 317321036
		arg_152_1.duration_ = 5.57

		local var_152_0 = {
			zh = 2.5,
			ja = 5.566
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
				arg_152_0:Play317321037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["10053ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos10053ui_story = var_155_0.localPosition
			end

			local var_155_2 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2
				local var_155_4 = Vector3.New(0.7, -1.12, -5.99)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10053ui_story, var_155_4, var_155_3)

				local var_155_5 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_5.x, var_155_5.y, var_155_5.z)

				local var_155_6 = var_155_0.localEulerAngles

				var_155_6.z = 0
				var_155_6.x = 0
				var_155_0.localEulerAngles = var_155_6
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_155_7 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_7.x, var_155_7.y, var_155_7.z)

				local var_155_8 = var_155_0.localEulerAngles

				var_155_8.z = 0
				var_155_8.x = 0
				var_155_0.localEulerAngles = var_155_8
			end

			local var_155_9 = arg_152_1.actors_["10053ui_story"]
			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect10053ui_story == nil then
				arg_152_1.var_.characterEffect10053ui_story = var_155_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_11 = 0.200000002980232

			if var_155_10 <= arg_152_1.time_ and arg_152_1.time_ < var_155_10 + var_155_11 and not isNil(var_155_9) then
				local var_155_12 = (arg_152_1.time_ - var_155_10) / var_155_11

				if arg_152_1.var_.characterEffect10053ui_story and not isNil(var_155_9) then
					arg_152_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_10 + var_155_11 and arg_152_1.time_ < var_155_10 + var_155_11 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect10053ui_story then
				arg_152_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_155_13 = 0

			if var_155_13 < arg_152_1.time_ and arg_152_1.time_ <= var_155_13 + arg_155_0 then
				arg_152_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action8_2")
			end

			local var_155_14 = 0

			if var_155_14 < arg_152_1.time_ and arg_152_1.time_ <= var_155_14 + arg_155_0 then
				arg_152_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_155_15 = arg_152_1.actors_["1015ui_story"]
			local var_155_16 = 0

			if var_155_16 < arg_152_1.time_ and arg_152_1.time_ <= var_155_16 + arg_155_0 and not isNil(var_155_15) and arg_152_1.var_.characterEffect1015ui_story == nil then
				arg_152_1.var_.characterEffect1015ui_story = var_155_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_17 = 0.200000002980232

			if var_155_16 <= arg_152_1.time_ and arg_152_1.time_ < var_155_16 + var_155_17 and not isNil(var_155_15) then
				local var_155_18 = (arg_152_1.time_ - var_155_16) / var_155_17

				if arg_152_1.var_.characterEffect1015ui_story and not isNil(var_155_15) then
					local var_155_19 = Mathf.Lerp(0, 0.5, var_155_18)

					arg_152_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1015ui_story.fillRatio = var_155_19
				end
			end

			if arg_152_1.time_ >= var_155_16 + var_155_17 and arg_152_1.time_ < var_155_16 + var_155_17 + arg_155_0 and not isNil(var_155_15) and arg_152_1.var_.characterEffect1015ui_story then
				local var_155_20 = 0.5

				arg_152_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1015ui_story.fillRatio = var_155_20
			end

			local var_155_21 = 0
			local var_155_22 = 0.275

			if var_155_21 < arg_152_1.time_ and arg_152_1.time_ <= var_155_21 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_23 = arg_152_1:FormatText(StoryNameCfg[477].name)

				arg_152_1.leftNameTxt_.text = var_155_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_24 = arg_152_1:GetWordFromCfg(317321036)
				local var_155_25 = arg_152_1:FormatText(var_155_24.content)

				arg_152_1.text_.text = var_155_25

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_26 = 11
				local var_155_27 = utf8.len(var_155_25)
				local var_155_28 = var_155_26 <= 0 and var_155_22 or var_155_22 * (var_155_27 / var_155_26)

				if var_155_28 > 0 and var_155_22 < var_155_28 then
					arg_152_1.talkMaxDuration = var_155_28

					if var_155_28 + var_155_21 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_28 + var_155_21
					end
				end

				arg_152_1.text_.text = var_155_25
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321036", "story_v_out_317321.awb") ~= 0 then
					local var_155_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321036", "story_v_out_317321.awb") / 1000

					if var_155_29 + var_155_21 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_29 + var_155_21
					end

					if var_155_24.prefab_name ~= "" and arg_152_1.actors_[var_155_24.prefab_name] ~= nil then
						local var_155_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_24.prefab_name].transform, "story_v_out_317321", "317321036", "story_v_out_317321.awb")

						arg_152_1:RecordAudio("317321036", var_155_30)
						arg_152_1:RecordAudio("317321036", var_155_30)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_317321", "317321036", "story_v_out_317321.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_317321", "317321036", "story_v_out_317321.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_31 = math.max(var_155_22, arg_152_1.talkMaxDuration)

			if var_155_21 <= arg_152_1.time_ and arg_152_1.time_ < var_155_21 + var_155_31 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_21) / var_155_31

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_21 + var_155_31 and arg_152_1.time_ < var_155_21 + var_155_31 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play317321037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 317321037
		arg_156_1.duration_ = 6.3

		local var_156_0 = {
			zh = 5.3,
			ja = 6.3
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
				arg_156_0:Play317321038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1015ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos1015ui_story = var_159_0.localPosition
			end

			local var_159_2 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2
				local var_159_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1015ui_story, var_159_4, var_159_3)

				local var_159_5 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_5.x, var_159_5.y, var_159_5.z)

				local var_159_6 = var_159_0.localEulerAngles

				var_159_6.z = 0
				var_159_6.x = 0
				var_159_0.localEulerAngles = var_159_6
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_159_7 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_7.x, var_159_7.y, var_159_7.z)

				local var_159_8 = var_159_0.localEulerAngles

				var_159_8.z = 0
				var_159_8.x = 0
				var_159_0.localEulerAngles = var_159_8
			end

			local var_159_9 = arg_156_1.actors_["1015ui_story"]
			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1015ui_story == nil then
				arg_156_1.var_.characterEffect1015ui_story = var_159_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_11 = 0.200000002980232

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 and not isNil(var_159_9) then
				local var_159_12 = (arg_156_1.time_ - var_159_10) / var_159_11

				if arg_156_1.var_.characterEffect1015ui_story and not isNil(var_159_9) then
					arg_156_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1015ui_story then
				arg_156_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_159_13 = 0

			if var_159_13 < arg_156_1.time_ and arg_156_1.time_ <= var_159_13 + arg_159_0 then
				arg_156_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_159_14 = 0

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_159_15 = arg_156_1.actors_["10053ui_story"]
			local var_159_16 = 0

			if var_159_16 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 and not isNil(var_159_15) and arg_156_1.var_.characterEffect10053ui_story == nil then
				arg_156_1.var_.characterEffect10053ui_story = var_159_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_17 = 0.200000002980232

			if var_159_16 <= arg_156_1.time_ and arg_156_1.time_ < var_159_16 + var_159_17 and not isNil(var_159_15) then
				local var_159_18 = (arg_156_1.time_ - var_159_16) / var_159_17

				if arg_156_1.var_.characterEffect10053ui_story and not isNil(var_159_15) then
					local var_159_19 = Mathf.Lerp(0, 0.5, var_159_18)

					arg_156_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_156_1.var_.characterEffect10053ui_story.fillRatio = var_159_19
				end
			end

			if arg_156_1.time_ >= var_159_16 + var_159_17 and arg_156_1.time_ < var_159_16 + var_159_17 + arg_159_0 and not isNil(var_159_15) and arg_156_1.var_.characterEffect10053ui_story then
				local var_159_20 = 0.5

				arg_156_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_156_1.var_.characterEffect10053ui_story.fillRatio = var_159_20
			end

			local var_159_21 = 0
			local var_159_22 = 0.6

			if var_159_21 < arg_156_1.time_ and arg_156_1.time_ <= var_159_21 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_23 = arg_156_1:FormatText(StoryNameCfg[479].name)

				arg_156_1.leftNameTxt_.text = var_159_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_24 = arg_156_1:GetWordFromCfg(317321037)
				local var_159_25 = arg_156_1:FormatText(var_159_24.content)

				arg_156_1.text_.text = var_159_25

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_26 = 24
				local var_159_27 = utf8.len(var_159_25)
				local var_159_28 = var_159_26 <= 0 and var_159_22 or var_159_22 * (var_159_27 / var_159_26)

				if var_159_28 > 0 and var_159_22 < var_159_28 then
					arg_156_1.talkMaxDuration = var_159_28

					if var_159_28 + var_159_21 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_28 + var_159_21
					end
				end

				arg_156_1.text_.text = var_159_25
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321037", "story_v_out_317321.awb") ~= 0 then
					local var_159_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321037", "story_v_out_317321.awb") / 1000

					if var_159_29 + var_159_21 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_29 + var_159_21
					end

					if var_159_24.prefab_name ~= "" and arg_156_1.actors_[var_159_24.prefab_name] ~= nil then
						local var_159_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_24.prefab_name].transform, "story_v_out_317321", "317321037", "story_v_out_317321.awb")

						arg_156_1:RecordAudio("317321037", var_159_30)
						arg_156_1:RecordAudio("317321037", var_159_30)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_317321", "317321037", "story_v_out_317321.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_317321", "317321037", "story_v_out_317321.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_31 = math.max(var_159_22, arg_156_1.talkMaxDuration)

			if var_159_21 <= arg_156_1.time_ and arg_156_1.time_ < var_159_21 + var_159_31 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_21) / var_159_31

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_21 + var_159_31 and arg_156_1.time_ < var_159_21 + var_159_31 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play317321038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 317321038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play317321039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1015ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1015ui_story == nil then
				arg_160_1.var_.characterEffect1015ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1015ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1015ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1015ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1015ui_story.fillRatio = var_163_5
			end

			local var_163_6 = 0
			local var_163_7 = 0.675

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_8 = arg_160_1:GetWordFromCfg(317321038)
				local var_163_9 = arg_160_1:FormatText(var_163_8.content)

				arg_160_1.text_.text = var_163_9

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_10 = 27
				local var_163_11 = utf8.len(var_163_9)
				local var_163_12 = var_163_10 <= 0 and var_163_7 or var_163_7 * (var_163_11 / var_163_10)

				if var_163_12 > 0 and var_163_7 < var_163_12 then
					arg_160_1.talkMaxDuration = var_163_12

					if var_163_12 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_12 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_9
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_13 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_13 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_13

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_13 and arg_160_1.time_ < var_163_6 + var_163_13 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play317321039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 317321039
		arg_164_1.duration_ = 19.7

		local var_164_0 = {
			zh = 19.7,
			ja = 17.233
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play317321040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["10053ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos10053ui_story = var_167_0.localPosition
			end

			local var_167_2 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2
				local var_167_4 = Vector3.New(0.7, -1.12, -5.99)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10053ui_story, var_167_4, var_167_3)

				local var_167_5 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_5.x, var_167_5.y, var_167_5.z)

				local var_167_6 = var_167_0.localEulerAngles

				var_167_6.z = 0
				var_167_6.x = 0
				var_167_0.localEulerAngles = var_167_6
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_167_7 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_7.x, var_167_7.y, var_167_7.z)

				local var_167_8 = var_167_0.localEulerAngles

				var_167_8.z = 0
				var_167_8.x = 0
				var_167_0.localEulerAngles = var_167_8
			end

			local var_167_9 = arg_164_1.actors_["10053ui_story"]
			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect10053ui_story == nil then
				arg_164_1.var_.characterEffect10053ui_story = var_167_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_11 = 0.200000002980232

			if var_167_10 <= arg_164_1.time_ and arg_164_1.time_ < var_167_10 + var_167_11 and not isNil(var_167_9) then
				local var_167_12 = (arg_164_1.time_ - var_167_10) / var_167_11

				if arg_164_1.var_.characterEffect10053ui_story and not isNil(var_167_9) then
					arg_164_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_10 + var_167_11 and arg_164_1.time_ < var_167_10 + var_167_11 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect10053ui_story then
				arg_164_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_167_13 = 0

			if var_167_13 < arg_164_1.time_ and arg_164_1.time_ <= var_167_13 + arg_167_0 then
				arg_164_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_167_14 = 0
			local var_167_15 = 1.35

			if var_167_14 < arg_164_1.time_ and arg_164_1.time_ <= var_167_14 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_16 = arg_164_1:FormatText(StoryNameCfg[477].name)

				arg_164_1.leftNameTxt_.text = var_167_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_17 = arg_164_1:GetWordFromCfg(317321039)
				local var_167_18 = arg_164_1:FormatText(var_167_17.content)

				arg_164_1.text_.text = var_167_18

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_19 = 54
				local var_167_20 = utf8.len(var_167_18)
				local var_167_21 = var_167_19 <= 0 and var_167_15 or var_167_15 * (var_167_20 / var_167_19)

				if var_167_21 > 0 and var_167_15 < var_167_21 then
					arg_164_1.talkMaxDuration = var_167_21

					if var_167_21 + var_167_14 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_21 + var_167_14
					end
				end

				arg_164_1.text_.text = var_167_18
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321039", "story_v_out_317321.awb") ~= 0 then
					local var_167_22 = manager.audio:GetVoiceLength("story_v_out_317321", "317321039", "story_v_out_317321.awb") / 1000

					if var_167_22 + var_167_14 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_22 + var_167_14
					end

					if var_167_17.prefab_name ~= "" and arg_164_1.actors_[var_167_17.prefab_name] ~= nil then
						local var_167_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_17.prefab_name].transform, "story_v_out_317321", "317321039", "story_v_out_317321.awb")

						arg_164_1:RecordAudio("317321039", var_167_23)
						arg_164_1:RecordAudio("317321039", var_167_23)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_317321", "317321039", "story_v_out_317321.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_317321", "317321039", "story_v_out_317321.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_24 = math.max(var_167_15, arg_164_1.talkMaxDuration)

			if var_167_14 <= arg_164_1.time_ and arg_164_1.time_ < var_167_14 + var_167_24 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_14) / var_167_24

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_14 + var_167_24 and arg_164_1.time_ < var_167_14 + var_167_24 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play317321040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 317321040
		arg_168_1.duration_ = 2

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play317321041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1015ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos1015ui_story = var_171_0.localPosition
			end

			local var_171_2 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2
				local var_171_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1015ui_story, var_171_4, var_171_3)

				local var_171_5 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_5.x, var_171_5.y, var_171_5.z)

				local var_171_6 = var_171_0.localEulerAngles

				var_171_6.z = 0
				var_171_6.x = 0
				var_171_0.localEulerAngles = var_171_6
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_171_7 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_7.x, var_171_7.y, var_171_7.z)

				local var_171_8 = var_171_0.localEulerAngles

				var_171_8.z = 0
				var_171_8.x = 0
				var_171_0.localEulerAngles = var_171_8
			end

			local var_171_9 = arg_168_1.actors_["1015ui_story"]
			local var_171_10 = 0

			if var_171_10 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect1015ui_story == nil then
				arg_168_1.var_.characterEffect1015ui_story = var_171_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_11 = 0.200000002980232

			if var_171_10 <= arg_168_1.time_ and arg_168_1.time_ < var_171_10 + var_171_11 and not isNil(var_171_9) then
				local var_171_12 = (arg_168_1.time_ - var_171_10) / var_171_11

				if arg_168_1.var_.characterEffect1015ui_story and not isNil(var_171_9) then
					arg_168_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_10 + var_171_11 and arg_168_1.time_ < var_171_10 + var_171_11 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect1015ui_story then
				arg_168_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_171_13 = 0

			if var_171_13 < arg_168_1.time_ and arg_168_1.time_ <= var_171_13 + arg_171_0 then
				arg_168_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_171_14 = arg_168_1.actors_["10053ui_story"]
			local var_171_15 = 0

			if var_171_15 < arg_168_1.time_ and arg_168_1.time_ <= var_171_15 + arg_171_0 and not isNil(var_171_14) and arg_168_1.var_.characterEffect10053ui_story == nil then
				arg_168_1.var_.characterEffect10053ui_story = var_171_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_16 = 0.200000002980232

			if var_171_15 <= arg_168_1.time_ and arg_168_1.time_ < var_171_15 + var_171_16 and not isNil(var_171_14) then
				local var_171_17 = (arg_168_1.time_ - var_171_15) / var_171_16

				if arg_168_1.var_.characterEffect10053ui_story and not isNil(var_171_14) then
					local var_171_18 = Mathf.Lerp(0, 0.5, var_171_17)

					arg_168_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_168_1.var_.characterEffect10053ui_story.fillRatio = var_171_18
				end
			end

			if arg_168_1.time_ >= var_171_15 + var_171_16 and arg_168_1.time_ < var_171_15 + var_171_16 + arg_171_0 and not isNil(var_171_14) and arg_168_1.var_.characterEffect10053ui_story then
				local var_171_19 = 0.5

				arg_168_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_168_1.var_.characterEffect10053ui_story.fillRatio = var_171_19
			end

			local var_171_20 = 0
			local var_171_21 = 0.1

			if var_171_20 < arg_168_1.time_ and arg_168_1.time_ <= var_171_20 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_22 = arg_168_1:FormatText(StoryNameCfg[479].name)

				arg_168_1.leftNameTxt_.text = var_171_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_23 = arg_168_1:GetWordFromCfg(317321040)
				local var_171_24 = arg_168_1:FormatText(var_171_23.content)

				arg_168_1.text_.text = var_171_24

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_25 = 4
				local var_171_26 = utf8.len(var_171_24)
				local var_171_27 = var_171_25 <= 0 and var_171_21 or var_171_21 * (var_171_26 / var_171_25)

				if var_171_27 > 0 and var_171_21 < var_171_27 then
					arg_168_1.talkMaxDuration = var_171_27

					if var_171_27 + var_171_20 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_27 + var_171_20
					end
				end

				arg_168_1.text_.text = var_171_24
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321040", "story_v_out_317321.awb") ~= 0 then
					local var_171_28 = manager.audio:GetVoiceLength("story_v_out_317321", "317321040", "story_v_out_317321.awb") / 1000

					if var_171_28 + var_171_20 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_28 + var_171_20
					end

					if var_171_23.prefab_name ~= "" and arg_168_1.actors_[var_171_23.prefab_name] ~= nil then
						local var_171_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_23.prefab_name].transform, "story_v_out_317321", "317321040", "story_v_out_317321.awb")

						arg_168_1:RecordAudio("317321040", var_171_29)
						arg_168_1:RecordAudio("317321040", var_171_29)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_317321", "317321040", "story_v_out_317321.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_317321", "317321040", "story_v_out_317321.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_30 = math.max(var_171_21, arg_168_1.talkMaxDuration)

			if var_171_20 <= arg_168_1.time_ and arg_168_1.time_ < var_171_20 + var_171_30 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_20) / var_171_30

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_20 + var_171_30 and arg_168_1.time_ < var_171_20 + var_171_30 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317321041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 317321041
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play317321042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1015ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1015ui_story == nil then
				arg_172_1.var_.characterEffect1015ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1015ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1015ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1015ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1015ui_story.fillRatio = var_175_5
			end

			local var_175_6 = 0
			local var_175_7 = 0.525

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_8 = arg_172_1:GetWordFromCfg(317321041)
				local var_175_9 = arg_172_1:FormatText(var_175_8.content)

				arg_172_1.text_.text = var_175_9

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_10 = 21
				local var_175_11 = utf8.len(var_175_9)
				local var_175_12 = var_175_10 <= 0 and var_175_7 or var_175_7 * (var_175_11 / var_175_10)

				if var_175_12 > 0 and var_175_7 < var_175_12 then
					arg_172_1.talkMaxDuration = var_175_12

					if var_175_12 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_12 + var_175_6
					end
				end

				arg_172_1.text_.text = var_175_9
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_13 = math.max(var_175_7, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_13 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_6) / var_175_13

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_13 and arg_172_1.time_ < var_175_6 + var_175_13 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play317321042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 317321042
		arg_176_1.duration_ = 17

		local var_176_0 = {
			zh = 8.5,
			ja = 17
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
				arg_176_0:Play317321043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1015ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1015ui_story == nil then
				arg_176_1.var_.characterEffect1015ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1015ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1015ui_story then
				arg_176_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_179_4 = 0
			local var_179_5 = 0.8

			if var_179_4 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_6 = arg_176_1:FormatText(StoryNameCfg[479].name)

				arg_176_1.leftNameTxt_.text = var_179_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_7 = arg_176_1:GetWordFromCfg(317321042)
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

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321042", "story_v_out_317321.awb") ~= 0 then
					local var_179_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321042", "story_v_out_317321.awb") / 1000

					if var_179_12 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_12 + var_179_4
					end

					if var_179_7.prefab_name ~= "" and arg_176_1.actors_[var_179_7.prefab_name] ~= nil then
						local var_179_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_7.prefab_name].transform, "story_v_out_317321", "317321042", "story_v_out_317321.awb")

						arg_176_1:RecordAudio("317321042", var_179_13)
						arg_176_1:RecordAudio("317321042", var_179_13)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_317321", "317321042", "story_v_out_317321.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_317321", "317321042", "story_v_out_317321.awb")
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
	Play317321043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 317321043
		arg_180_1.duration_ = 9.5

		local var_180_0 = {
			zh = 6.633,
			ja = 9.5
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
				arg_180_0:Play317321044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0
			local var_183_1 = 0.875

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_2 = arg_180_1:FormatText(StoryNameCfg[479].name)

				arg_180_1.leftNameTxt_.text = var_183_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_3 = arg_180_1:GetWordFromCfg(317321043)
				local var_183_4 = arg_180_1:FormatText(var_183_3.content)

				arg_180_1.text_.text = var_183_4

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 35
				local var_183_6 = utf8.len(var_183_4)
				local var_183_7 = var_183_5 <= 0 and var_183_1 or var_183_1 * (var_183_6 / var_183_5)

				if var_183_7 > 0 and var_183_1 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_0
					end
				end

				arg_180_1.text_.text = var_183_4
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321043", "story_v_out_317321.awb") ~= 0 then
					local var_183_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321043", "story_v_out_317321.awb") / 1000

					if var_183_8 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_0
					end

					if var_183_3.prefab_name ~= "" and arg_180_1.actors_[var_183_3.prefab_name] ~= nil then
						local var_183_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_3.prefab_name].transform, "story_v_out_317321", "317321043", "story_v_out_317321.awb")

						arg_180_1:RecordAudio("317321043", var_183_9)
						arg_180_1:RecordAudio("317321043", var_183_9)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_317321", "317321043", "story_v_out_317321.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_317321", "317321043", "story_v_out_317321.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_10 = math.max(var_183_1, arg_180_1.talkMaxDuration)

			if var_183_0 <= arg_180_1.time_ and arg_180_1.time_ < var_183_0 + var_183_10 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_0) / var_183_10

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_0 + var_183_10 and arg_180_1.time_ < var_183_0 + var_183_10 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play317321044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 317321044
		arg_184_1.duration_ = 10.37

		local var_184_0 = {
			zh = 7.6,
			ja = 10.366
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play317321045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0
			local var_187_1 = 0.925

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_2 = arg_184_1:FormatText(StoryNameCfg[479].name)

				arg_184_1.leftNameTxt_.text = var_187_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_3 = arg_184_1:GetWordFromCfg(317321044)
				local var_187_4 = arg_184_1:FormatText(var_187_3.content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 37
				local var_187_6 = utf8.len(var_187_4)
				local var_187_7 = var_187_5 <= 0 and var_187_1 or var_187_1 * (var_187_6 / var_187_5)

				if var_187_7 > 0 and var_187_1 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_0
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321044", "story_v_out_317321.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321044", "story_v_out_317321.awb") / 1000

					if var_187_8 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_0
					end

					if var_187_3.prefab_name ~= "" and arg_184_1.actors_[var_187_3.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_3.prefab_name].transform, "story_v_out_317321", "317321044", "story_v_out_317321.awb")

						arg_184_1:RecordAudio("317321044", var_187_9)
						arg_184_1:RecordAudio("317321044", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_317321", "317321044", "story_v_out_317321.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_317321", "317321044", "story_v_out_317321.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_1, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_0) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_10 and arg_184_1.time_ < var_187_0 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play317321045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 317321045
		arg_188_1.duration_ = 10.3

		local var_188_0 = {
			zh = 9.5,
			ja = 10.3
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
				arg_188_0:Play317321046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10053ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos10053ui_story = var_191_0.localPosition
			end

			local var_191_2 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2
				local var_191_4 = Vector3.New(0.7, -1.12, -5.99)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10053ui_story, var_191_4, var_191_3)

				local var_191_5 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_5.x, var_191_5.y, var_191_5.z)

				local var_191_6 = var_191_0.localEulerAngles

				var_191_6.z = 0
				var_191_6.x = 0
				var_191_0.localEulerAngles = var_191_6
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_191_7 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_7.x, var_191_7.y, var_191_7.z)

				local var_191_8 = var_191_0.localEulerAngles

				var_191_8.z = 0
				var_191_8.x = 0
				var_191_0.localEulerAngles = var_191_8
			end

			local var_191_9 = arg_188_1.actors_["10053ui_story"]
			local var_191_10 = 0

			if var_191_10 < arg_188_1.time_ and arg_188_1.time_ <= var_191_10 + arg_191_0 and not isNil(var_191_9) and arg_188_1.var_.characterEffect10053ui_story == nil then
				arg_188_1.var_.characterEffect10053ui_story = var_191_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_11 = 0.200000002980232

			if var_191_10 <= arg_188_1.time_ and arg_188_1.time_ < var_191_10 + var_191_11 and not isNil(var_191_9) then
				local var_191_12 = (arg_188_1.time_ - var_191_10) / var_191_11

				if arg_188_1.var_.characterEffect10053ui_story and not isNil(var_191_9) then
					arg_188_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_10 + var_191_11 and arg_188_1.time_ < var_191_10 + var_191_11 + arg_191_0 and not isNil(var_191_9) and arg_188_1.var_.characterEffect10053ui_story then
				arg_188_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_191_13 = 0

			if var_191_13 < arg_188_1.time_ and arg_188_1.time_ <= var_191_13 + arg_191_0 then
				arg_188_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action12_1")
			end

			local var_191_14 = 0

			if var_191_14 < arg_188_1.time_ and arg_188_1.time_ <= var_191_14 + arg_191_0 then
				arg_188_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_191_15 = arg_188_1.actors_["1015ui_story"]
			local var_191_16 = 0

			if var_191_16 < arg_188_1.time_ and arg_188_1.time_ <= var_191_16 + arg_191_0 and not isNil(var_191_15) and arg_188_1.var_.characterEffect1015ui_story == nil then
				arg_188_1.var_.characterEffect1015ui_story = var_191_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_17 = 0.200000002980232

			if var_191_16 <= arg_188_1.time_ and arg_188_1.time_ < var_191_16 + var_191_17 and not isNil(var_191_15) then
				local var_191_18 = (arg_188_1.time_ - var_191_16) / var_191_17

				if arg_188_1.var_.characterEffect1015ui_story and not isNil(var_191_15) then
					local var_191_19 = Mathf.Lerp(0, 0.5, var_191_18)

					arg_188_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1015ui_story.fillRatio = var_191_19
				end
			end

			if arg_188_1.time_ >= var_191_16 + var_191_17 and arg_188_1.time_ < var_191_16 + var_191_17 + arg_191_0 and not isNil(var_191_15) and arg_188_1.var_.characterEffect1015ui_story then
				local var_191_20 = 0.5

				arg_188_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1015ui_story.fillRatio = var_191_20
			end

			local var_191_21 = 0
			local var_191_22 = 0.675

			if var_191_21 < arg_188_1.time_ and arg_188_1.time_ <= var_191_21 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_23 = arg_188_1:FormatText(StoryNameCfg[477].name)

				arg_188_1.leftNameTxt_.text = var_191_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_24 = arg_188_1:GetWordFromCfg(317321045)
				local var_191_25 = arg_188_1:FormatText(var_191_24.content)

				arg_188_1.text_.text = var_191_25

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_26 = 27
				local var_191_27 = utf8.len(var_191_25)
				local var_191_28 = var_191_26 <= 0 and var_191_22 or var_191_22 * (var_191_27 / var_191_26)

				if var_191_28 > 0 and var_191_22 < var_191_28 then
					arg_188_1.talkMaxDuration = var_191_28

					if var_191_28 + var_191_21 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_28 + var_191_21
					end
				end

				arg_188_1.text_.text = var_191_25
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321045", "story_v_out_317321.awb") ~= 0 then
					local var_191_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321045", "story_v_out_317321.awb") / 1000

					if var_191_29 + var_191_21 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_29 + var_191_21
					end

					if var_191_24.prefab_name ~= "" and arg_188_1.actors_[var_191_24.prefab_name] ~= nil then
						local var_191_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_24.prefab_name].transform, "story_v_out_317321", "317321045", "story_v_out_317321.awb")

						arg_188_1:RecordAudio("317321045", var_191_30)
						arg_188_1:RecordAudio("317321045", var_191_30)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_317321", "317321045", "story_v_out_317321.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_317321", "317321045", "story_v_out_317321.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_31 = math.max(var_191_22, arg_188_1.talkMaxDuration)

			if var_191_21 <= arg_188_1.time_ and arg_188_1.time_ < var_191_21 + var_191_31 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_21) / var_191_31

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_21 + var_191_31 and arg_188_1.time_ < var_191_21 + var_191_31 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play317321046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 317321046
		arg_192_1.duration_ = 9.93

		local var_192_0 = {
			zh = 8.3,
			ja = 9.933
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play317321047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1015ui_story"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos1015ui_story = var_195_0.localPosition
			end

			local var_195_2 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2
				local var_195_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1015ui_story, var_195_4, var_195_3)

				local var_195_5 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_5.x, var_195_5.y, var_195_5.z)

				local var_195_6 = var_195_0.localEulerAngles

				var_195_6.z = 0
				var_195_6.x = 0
				var_195_0.localEulerAngles = var_195_6
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_195_7 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_7.x, var_195_7.y, var_195_7.z)

				local var_195_8 = var_195_0.localEulerAngles

				var_195_8.z = 0
				var_195_8.x = 0
				var_195_0.localEulerAngles = var_195_8
			end

			local var_195_9 = arg_192_1.actors_["1015ui_story"]
			local var_195_10 = 0

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 and not isNil(var_195_9) and arg_192_1.var_.characterEffect1015ui_story == nil then
				arg_192_1.var_.characterEffect1015ui_story = var_195_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_11 = 0.200000002980232

			if var_195_10 <= arg_192_1.time_ and arg_192_1.time_ < var_195_10 + var_195_11 and not isNil(var_195_9) then
				local var_195_12 = (arg_192_1.time_ - var_195_10) / var_195_11

				if arg_192_1.var_.characterEffect1015ui_story and not isNil(var_195_9) then
					arg_192_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_10 + var_195_11 and arg_192_1.time_ < var_195_10 + var_195_11 + arg_195_0 and not isNil(var_195_9) and arg_192_1.var_.characterEffect1015ui_story then
				arg_192_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_195_13 = 0

			if var_195_13 < arg_192_1.time_ and arg_192_1.time_ <= var_195_13 + arg_195_0 then
				arg_192_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_195_14 = 0

			if var_195_14 < arg_192_1.time_ and arg_192_1.time_ <= var_195_14 + arg_195_0 then
				arg_192_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_195_15 = arg_192_1.actors_["10053ui_story"]
			local var_195_16 = 0

			if var_195_16 < arg_192_1.time_ and arg_192_1.time_ <= var_195_16 + arg_195_0 and not isNil(var_195_15) and arg_192_1.var_.characterEffect10053ui_story == nil then
				arg_192_1.var_.characterEffect10053ui_story = var_195_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_17 = 0.200000002980232

			if var_195_16 <= arg_192_1.time_ and arg_192_1.time_ < var_195_16 + var_195_17 and not isNil(var_195_15) then
				local var_195_18 = (arg_192_1.time_ - var_195_16) / var_195_17

				if arg_192_1.var_.characterEffect10053ui_story and not isNil(var_195_15) then
					local var_195_19 = Mathf.Lerp(0, 0.5, var_195_18)

					arg_192_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_192_1.var_.characterEffect10053ui_story.fillRatio = var_195_19
				end
			end

			if arg_192_1.time_ >= var_195_16 + var_195_17 and arg_192_1.time_ < var_195_16 + var_195_17 + arg_195_0 and not isNil(var_195_15) and arg_192_1.var_.characterEffect10053ui_story then
				local var_195_20 = 0.5

				arg_192_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_192_1.var_.characterEffect10053ui_story.fillRatio = var_195_20
			end

			local var_195_21 = 0
			local var_195_22 = 1

			if var_195_21 < arg_192_1.time_ and arg_192_1.time_ <= var_195_21 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_23 = arg_192_1:FormatText(StoryNameCfg[479].name)

				arg_192_1.leftNameTxt_.text = var_195_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_24 = arg_192_1:GetWordFromCfg(317321046)
				local var_195_25 = arg_192_1:FormatText(var_195_24.content)

				arg_192_1.text_.text = var_195_25

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_26 = 40
				local var_195_27 = utf8.len(var_195_25)
				local var_195_28 = var_195_26 <= 0 and var_195_22 or var_195_22 * (var_195_27 / var_195_26)

				if var_195_28 > 0 and var_195_22 < var_195_28 then
					arg_192_1.talkMaxDuration = var_195_28

					if var_195_28 + var_195_21 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_28 + var_195_21
					end
				end

				arg_192_1.text_.text = var_195_25
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321046", "story_v_out_317321.awb") ~= 0 then
					local var_195_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321046", "story_v_out_317321.awb") / 1000

					if var_195_29 + var_195_21 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_29 + var_195_21
					end

					if var_195_24.prefab_name ~= "" and arg_192_1.actors_[var_195_24.prefab_name] ~= nil then
						local var_195_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_24.prefab_name].transform, "story_v_out_317321", "317321046", "story_v_out_317321.awb")

						arg_192_1:RecordAudio("317321046", var_195_30)
						arg_192_1:RecordAudio("317321046", var_195_30)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_317321", "317321046", "story_v_out_317321.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_317321", "317321046", "story_v_out_317321.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_31 = math.max(var_195_22, arg_192_1.talkMaxDuration)

			if var_195_21 <= arg_192_1.time_ and arg_192_1.time_ < var_195_21 + var_195_31 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_21) / var_195_31

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_21 + var_195_31 and arg_192_1.time_ < var_195_21 + var_195_31 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play317321047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 317321047
		arg_196_1.duration_ = 11.87

		local var_196_0 = {
			zh = 11.866,
			ja = 11.066
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play317321048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10053ui_story"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos10053ui_story = var_199_0.localPosition
			end

			local var_199_2 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2
				local var_199_4 = Vector3.New(0.7, -1.12, -5.99)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10053ui_story, var_199_4, var_199_3)

				local var_199_5 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_5.x, var_199_5.y, var_199_5.z)

				local var_199_6 = var_199_0.localEulerAngles

				var_199_6.z = 0
				var_199_6.x = 0
				var_199_0.localEulerAngles = var_199_6
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_199_7 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_7.x, var_199_7.y, var_199_7.z)

				local var_199_8 = var_199_0.localEulerAngles

				var_199_8.z = 0
				var_199_8.x = 0
				var_199_0.localEulerAngles = var_199_8
			end

			local var_199_9 = arg_196_1.actors_["10053ui_story"]
			local var_199_10 = 0

			if var_199_10 < arg_196_1.time_ and arg_196_1.time_ <= var_199_10 + arg_199_0 and not isNil(var_199_9) and arg_196_1.var_.characterEffect10053ui_story == nil then
				arg_196_1.var_.characterEffect10053ui_story = var_199_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_11 = 0.200000002980232

			if var_199_10 <= arg_196_1.time_ and arg_196_1.time_ < var_199_10 + var_199_11 and not isNil(var_199_9) then
				local var_199_12 = (arg_196_1.time_ - var_199_10) / var_199_11

				if arg_196_1.var_.characterEffect10053ui_story and not isNil(var_199_9) then
					arg_196_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_10 + var_199_11 and arg_196_1.time_ < var_199_10 + var_199_11 + arg_199_0 and not isNil(var_199_9) and arg_196_1.var_.characterEffect10053ui_story then
				arg_196_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_199_13 = 0

			if var_199_13 < arg_196_1.time_ and arg_196_1.time_ <= var_199_13 + arg_199_0 then
				arg_196_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_199_14 = arg_196_1.actors_["1015ui_story"]
			local var_199_15 = 0

			if var_199_15 < arg_196_1.time_ and arg_196_1.time_ <= var_199_15 + arg_199_0 and not isNil(var_199_14) and arg_196_1.var_.characterEffect1015ui_story == nil then
				arg_196_1.var_.characterEffect1015ui_story = var_199_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_16 = 0.200000002980232

			if var_199_15 <= arg_196_1.time_ and arg_196_1.time_ < var_199_15 + var_199_16 and not isNil(var_199_14) then
				local var_199_17 = (arg_196_1.time_ - var_199_15) / var_199_16

				if arg_196_1.var_.characterEffect1015ui_story and not isNil(var_199_14) then
					local var_199_18 = Mathf.Lerp(0, 0.5, var_199_17)

					arg_196_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1015ui_story.fillRatio = var_199_18
				end
			end

			if arg_196_1.time_ >= var_199_15 + var_199_16 and arg_196_1.time_ < var_199_15 + var_199_16 + arg_199_0 and not isNil(var_199_14) and arg_196_1.var_.characterEffect1015ui_story then
				local var_199_19 = 0.5

				arg_196_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1015ui_story.fillRatio = var_199_19
			end

			local var_199_20 = 0
			local var_199_21 = 1

			if var_199_20 < arg_196_1.time_ and arg_196_1.time_ <= var_199_20 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_22 = arg_196_1:FormatText(StoryNameCfg[477].name)

				arg_196_1.leftNameTxt_.text = var_199_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_23 = arg_196_1:GetWordFromCfg(317321047)
				local var_199_24 = arg_196_1:FormatText(var_199_23.content)

				arg_196_1.text_.text = var_199_24

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_25 = 40
				local var_199_26 = utf8.len(var_199_24)
				local var_199_27 = var_199_25 <= 0 and var_199_21 or var_199_21 * (var_199_26 / var_199_25)

				if var_199_27 > 0 and var_199_21 < var_199_27 then
					arg_196_1.talkMaxDuration = var_199_27

					if var_199_27 + var_199_20 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_27 + var_199_20
					end
				end

				arg_196_1.text_.text = var_199_24
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321047", "story_v_out_317321.awb") ~= 0 then
					local var_199_28 = manager.audio:GetVoiceLength("story_v_out_317321", "317321047", "story_v_out_317321.awb") / 1000

					if var_199_28 + var_199_20 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_28 + var_199_20
					end

					if var_199_23.prefab_name ~= "" and arg_196_1.actors_[var_199_23.prefab_name] ~= nil then
						local var_199_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_23.prefab_name].transform, "story_v_out_317321", "317321047", "story_v_out_317321.awb")

						arg_196_1:RecordAudio("317321047", var_199_29)
						arg_196_1:RecordAudio("317321047", var_199_29)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_317321", "317321047", "story_v_out_317321.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_317321", "317321047", "story_v_out_317321.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_30 = math.max(var_199_21, arg_196_1.talkMaxDuration)

			if var_199_20 <= arg_196_1.time_ and arg_196_1.time_ < var_199_20 + var_199_30 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_20) / var_199_30

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_20 + var_199_30 and arg_196_1.time_ < var_199_20 + var_199_30 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play317321048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 317321048
		arg_200_1.duration_ = 3.77

		local var_200_0 = {
			zh = 1.999999999999,
			ja = 3.766
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play317321049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1015ui_story"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos1015ui_story = var_203_0.localPosition
			end

			local var_203_2 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2
				local var_203_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1015ui_story, var_203_4, var_203_3)

				local var_203_5 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_5.x, var_203_5.y, var_203_5.z)

				local var_203_6 = var_203_0.localEulerAngles

				var_203_6.z = 0
				var_203_6.x = 0
				var_203_0.localEulerAngles = var_203_6
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_203_7 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_7.x, var_203_7.y, var_203_7.z)

				local var_203_8 = var_203_0.localEulerAngles

				var_203_8.z = 0
				var_203_8.x = 0
				var_203_0.localEulerAngles = var_203_8
			end

			local var_203_9 = arg_200_1.actors_["1015ui_story"]
			local var_203_10 = 0

			if var_203_10 < arg_200_1.time_ and arg_200_1.time_ <= var_203_10 + arg_203_0 and not isNil(var_203_9) and arg_200_1.var_.characterEffect1015ui_story == nil then
				arg_200_1.var_.characterEffect1015ui_story = var_203_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_11 = 0.200000002980232

			if var_203_10 <= arg_200_1.time_ and arg_200_1.time_ < var_203_10 + var_203_11 and not isNil(var_203_9) then
				local var_203_12 = (arg_200_1.time_ - var_203_10) / var_203_11

				if arg_200_1.var_.characterEffect1015ui_story and not isNil(var_203_9) then
					arg_200_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_10 + var_203_11 and arg_200_1.time_ < var_203_10 + var_203_11 + arg_203_0 and not isNil(var_203_9) and arg_200_1.var_.characterEffect1015ui_story then
				arg_200_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_203_13 = 0

			if var_203_13 < arg_200_1.time_ and arg_200_1.time_ <= var_203_13 + arg_203_0 then
				arg_200_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_203_14 = arg_200_1.actors_["10053ui_story"]
			local var_203_15 = 0

			if var_203_15 < arg_200_1.time_ and arg_200_1.time_ <= var_203_15 + arg_203_0 and not isNil(var_203_14) and arg_200_1.var_.characterEffect10053ui_story == nil then
				arg_200_1.var_.characterEffect10053ui_story = var_203_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_16 = 0.200000002980232

			if var_203_15 <= arg_200_1.time_ and arg_200_1.time_ < var_203_15 + var_203_16 and not isNil(var_203_14) then
				local var_203_17 = (arg_200_1.time_ - var_203_15) / var_203_16

				if arg_200_1.var_.characterEffect10053ui_story and not isNil(var_203_14) then
					local var_203_18 = Mathf.Lerp(0, 0.5, var_203_17)

					arg_200_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_200_1.var_.characterEffect10053ui_story.fillRatio = var_203_18
				end
			end

			if arg_200_1.time_ >= var_203_15 + var_203_16 and arg_200_1.time_ < var_203_15 + var_203_16 + arg_203_0 and not isNil(var_203_14) and arg_200_1.var_.characterEffect10053ui_story then
				local var_203_19 = 0.5

				arg_200_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_200_1.var_.characterEffect10053ui_story.fillRatio = var_203_19
			end

			local var_203_20 = 0
			local var_203_21 = 0.1

			if var_203_20 < arg_200_1.time_ and arg_200_1.time_ <= var_203_20 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_22 = arg_200_1:FormatText(StoryNameCfg[479].name)

				arg_200_1.leftNameTxt_.text = var_203_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_23 = arg_200_1:GetWordFromCfg(317321048)
				local var_203_24 = arg_200_1:FormatText(var_203_23.content)

				arg_200_1.text_.text = var_203_24

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_25 = 4
				local var_203_26 = utf8.len(var_203_24)
				local var_203_27 = var_203_25 <= 0 and var_203_21 or var_203_21 * (var_203_26 / var_203_25)

				if var_203_27 > 0 and var_203_21 < var_203_27 then
					arg_200_1.talkMaxDuration = var_203_27

					if var_203_27 + var_203_20 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_27 + var_203_20
					end
				end

				arg_200_1.text_.text = var_203_24
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321048", "story_v_out_317321.awb") ~= 0 then
					local var_203_28 = manager.audio:GetVoiceLength("story_v_out_317321", "317321048", "story_v_out_317321.awb") / 1000

					if var_203_28 + var_203_20 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_28 + var_203_20
					end

					if var_203_23.prefab_name ~= "" and arg_200_1.actors_[var_203_23.prefab_name] ~= nil then
						local var_203_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_23.prefab_name].transform, "story_v_out_317321", "317321048", "story_v_out_317321.awb")

						arg_200_1:RecordAudio("317321048", var_203_29)
						arg_200_1:RecordAudio("317321048", var_203_29)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_317321", "317321048", "story_v_out_317321.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_317321", "317321048", "story_v_out_317321.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_30 = math.max(var_203_21, arg_200_1.talkMaxDuration)

			if var_203_20 <= arg_200_1.time_ and arg_200_1.time_ < var_203_20 + var_203_30 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_20) / var_203_30

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_20 + var_203_30 and arg_200_1.time_ < var_203_20 + var_203_30 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play317321049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 317321049
		arg_204_1.duration_ = 13.53

		local var_204_0 = {
			zh = 11.633,
			ja = 13.533
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play317321050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["10053ui_story"].transform
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.var_.moveOldPos10053ui_story = var_207_0.localPosition
			end

			local var_207_2 = 0.001

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2
				local var_207_4 = Vector3.New(0.7, -1.12, -5.99)

				var_207_0.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10053ui_story, var_207_4, var_207_3)

				local var_207_5 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_5.x, var_207_5.y, var_207_5.z)

				local var_207_6 = var_207_0.localEulerAngles

				var_207_6.z = 0
				var_207_6.x = 0
				var_207_0.localEulerAngles = var_207_6
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 then
				var_207_0.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_207_7 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_7.x, var_207_7.y, var_207_7.z)

				local var_207_8 = var_207_0.localEulerAngles

				var_207_8.z = 0
				var_207_8.x = 0
				var_207_0.localEulerAngles = var_207_8
			end

			local var_207_9 = arg_204_1.actors_["10053ui_story"]
			local var_207_10 = 0

			if var_207_10 < arg_204_1.time_ and arg_204_1.time_ <= var_207_10 + arg_207_0 and not isNil(var_207_9) and arg_204_1.var_.characterEffect10053ui_story == nil then
				arg_204_1.var_.characterEffect10053ui_story = var_207_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_11 = 0.200000002980232

			if var_207_10 <= arg_204_1.time_ and arg_204_1.time_ < var_207_10 + var_207_11 and not isNil(var_207_9) then
				local var_207_12 = (arg_204_1.time_ - var_207_10) / var_207_11

				if arg_204_1.var_.characterEffect10053ui_story and not isNil(var_207_9) then
					arg_204_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_10 + var_207_11 and arg_204_1.time_ < var_207_10 + var_207_11 + arg_207_0 and not isNil(var_207_9) and arg_204_1.var_.characterEffect10053ui_story then
				arg_204_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_207_13 = 0

			if var_207_13 < arg_204_1.time_ and arg_204_1.time_ <= var_207_13 + arg_207_0 then
				arg_204_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action12_2")
			end

			local var_207_14 = 0

			if var_207_14 < arg_204_1.time_ and arg_204_1.time_ <= var_207_14 + arg_207_0 then
				arg_204_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_207_15 = arg_204_1.actors_["1015ui_story"]
			local var_207_16 = 0

			if var_207_16 < arg_204_1.time_ and arg_204_1.time_ <= var_207_16 + arg_207_0 and not isNil(var_207_15) and arg_204_1.var_.characterEffect1015ui_story == nil then
				arg_204_1.var_.characterEffect1015ui_story = var_207_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_17 = 0.200000002980232

			if var_207_16 <= arg_204_1.time_ and arg_204_1.time_ < var_207_16 + var_207_17 and not isNil(var_207_15) then
				local var_207_18 = (arg_204_1.time_ - var_207_16) / var_207_17

				if arg_204_1.var_.characterEffect1015ui_story and not isNil(var_207_15) then
					local var_207_19 = Mathf.Lerp(0, 0.5, var_207_18)

					arg_204_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1015ui_story.fillRatio = var_207_19
				end
			end

			if arg_204_1.time_ >= var_207_16 + var_207_17 and arg_204_1.time_ < var_207_16 + var_207_17 + arg_207_0 and not isNil(var_207_15) and arg_204_1.var_.characterEffect1015ui_story then
				local var_207_20 = 0.5

				arg_204_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1015ui_story.fillRatio = var_207_20
			end

			local var_207_21 = 0
			local var_207_22 = 1.125

			if var_207_21 < arg_204_1.time_ and arg_204_1.time_ <= var_207_21 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_23 = arg_204_1:FormatText(StoryNameCfg[477].name)

				arg_204_1.leftNameTxt_.text = var_207_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_24 = arg_204_1:GetWordFromCfg(317321049)
				local var_207_25 = arg_204_1:FormatText(var_207_24.content)

				arg_204_1.text_.text = var_207_25

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_26 = 45
				local var_207_27 = utf8.len(var_207_25)
				local var_207_28 = var_207_26 <= 0 and var_207_22 or var_207_22 * (var_207_27 / var_207_26)

				if var_207_28 > 0 and var_207_22 < var_207_28 then
					arg_204_1.talkMaxDuration = var_207_28

					if var_207_28 + var_207_21 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_28 + var_207_21
					end
				end

				arg_204_1.text_.text = var_207_25
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321049", "story_v_out_317321.awb") ~= 0 then
					local var_207_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321049", "story_v_out_317321.awb") / 1000

					if var_207_29 + var_207_21 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_29 + var_207_21
					end

					if var_207_24.prefab_name ~= "" and arg_204_1.actors_[var_207_24.prefab_name] ~= nil then
						local var_207_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_24.prefab_name].transform, "story_v_out_317321", "317321049", "story_v_out_317321.awb")

						arg_204_1:RecordAudio("317321049", var_207_30)
						arg_204_1:RecordAudio("317321049", var_207_30)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_317321", "317321049", "story_v_out_317321.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_317321", "317321049", "story_v_out_317321.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_31 = math.max(var_207_22, arg_204_1.talkMaxDuration)

			if var_207_21 <= arg_204_1.time_ and arg_204_1.time_ < var_207_21 + var_207_31 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_21) / var_207_31

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_21 + var_207_31 and arg_204_1.time_ < var_207_21 + var_207_31 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play317321050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 317321050
		arg_208_1.duration_ = 9.33

		local var_208_0 = {
			zh = 9.333,
			ja = 8.2
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
				arg_208_0:Play317321051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 0.975

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_2 = arg_208_1:FormatText(StoryNameCfg[477].name)

				arg_208_1.leftNameTxt_.text = var_211_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_3 = arg_208_1:GetWordFromCfg(317321050)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321050", "story_v_out_317321.awb") ~= 0 then
					local var_211_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321050", "story_v_out_317321.awb") / 1000

					if var_211_8 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_0
					end

					if var_211_3.prefab_name ~= "" and arg_208_1.actors_[var_211_3.prefab_name] ~= nil then
						local var_211_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_3.prefab_name].transform, "story_v_out_317321", "317321050", "story_v_out_317321.awb")

						arg_208_1:RecordAudio("317321050", var_211_9)
						arg_208_1:RecordAudio("317321050", var_211_9)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_317321", "317321050", "story_v_out_317321.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_317321", "317321050", "story_v_out_317321.awb")
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
	Play317321051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 317321051
		arg_212_1.duration_ = 8.67

		local var_212_0 = {
			zh = 8.666,
			ja = 8.366
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play317321052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 0.825

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_2 = arg_212_1:FormatText(StoryNameCfg[477].name)

				arg_212_1.leftNameTxt_.text = var_215_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_3 = arg_212_1:GetWordFromCfg(317321051)
				local var_215_4 = arg_212_1:FormatText(var_215_3.content)

				arg_212_1.text_.text = var_215_4

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321051", "story_v_out_317321.awb") ~= 0 then
					local var_215_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321051", "story_v_out_317321.awb") / 1000

					if var_215_8 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_0
					end

					if var_215_3.prefab_name ~= "" and arg_212_1.actors_[var_215_3.prefab_name] ~= nil then
						local var_215_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_3.prefab_name].transform, "story_v_out_317321", "317321051", "story_v_out_317321.awb")

						arg_212_1:RecordAudio("317321051", var_215_9)
						arg_212_1:RecordAudio("317321051", var_215_9)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_317321", "317321051", "story_v_out_317321.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_317321", "317321051", "story_v_out_317321.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_10 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_10 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_10

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_10 and arg_212_1.time_ < var_215_0 + var_215_10 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play317321052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 317321052
		arg_216_1.duration_ = 8.97

		local var_216_0 = {
			zh = 6.766,
			ja = 8.966
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
				arg_216_0:Play317321053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1015ui_story"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos1015ui_story = var_219_0.localPosition
			end

			local var_219_2 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2
				local var_219_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1015ui_story, var_219_4, var_219_3)

				local var_219_5 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_5.x, var_219_5.y, var_219_5.z)

				local var_219_6 = var_219_0.localEulerAngles

				var_219_6.z = 0
				var_219_6.x = 0
				var_219_0.localEulerAngles = var_219_6
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_219_7 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_7.x, var_219_7.y, var_219_7.z)

				local var_219_8 = var_219_0.localEulerAngles

				var_219_8.z = 0
				var_219_8.x = 0
				var_219_0.localEulerAngles = var_219_8
			end

			local var_219_9 = arg_216_1.actors_["1015ui_story"]
			local var_219_10 = 0

			if var_219_10 < arg_216_1.time_ and arg_216_1.time_ <= var_219_10 + arg_219_0 and not isNil(var_219_9) and arg_216_1.var_.characterEffect1015ui_story == nil then
				arg_216_1.var_.characterEffect1015ui_story = var_219_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_11 = 0.200000002980232

			if var_219_10 <= arg_216_1.time_ and arg_216_1.time_ < var_219_10 + var_219_11 and not isNil(var_219_9) then
				local var_219_12 = (arg_216_1.time_ - var_219_10) / var_219_11

				if arg_216_1.var_.characterEffect1015ui_story and not isNil(var_219_9) then
					arg_216_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_10 + var_219_11 and arg_216_1.time_ < var_219_10 + var_219_11 + arg_219_0 and not isNil(var_219_9) and arg_216_1.var_.characterEffect1015ui_story then
				arg_216_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_219_13 = 0

			if var_219_13 < arg_216_1.time_ and arg_216_1.time_ <= var_219_13 + arg_219_0 then
				arg_216_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_219_14 = 0

			if var_219_14 < arg_216_1.time_ and arg_216_1.time_ <= var_219_14 + arg_219_0 then
				arg_216_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_219_15 = arg_216_1.actors_["10053ui_story"]
			local var_219_16 = 0

			if var_219_16 < arg_216_1.time_ and arg_216_1.time_ <= var_219_16 + arg_219_0 and not isNil(var_219_15) and arg_216_1.var_.characterEffect10053ui_story == nil then
				arg_216_1.var_.characterEffect10053ui_story = var_219_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_17 = 0.200000002980232

			if var_219_16 <= arg_216_1.time_ and arg_216_1.time_ < var_219_16 + var_219_17 and not isNil(var_219_15) then
				local var_219_18 = (arg_216_1.time_ - var_219_16) / var_219_17

				if arg_216_1.var_.characterEffect10053ui_story and not isNil(var_219_15) then
					local var_219_19 = Mathf.Lerp(0, 0.5, var_219_18)

					arg_216_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10053ui_story.fillRatio = var_219_19
				end
			end

			if arg_216_1.time_ >= var_219_16 + var_219_17 and arg_216_1.time_ < var_219_16 + var_219_17 + arg_219_0 and not isNil(var_219_15) and arg_216_1.var_.characterEffect10053ui_story then
				local var_219_20 = 0.5

				arg_216_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10053ui_story.fillRatio = var_219_20
			end

			local var_219_21 = 0
			local var_219_22 = 0.6

			if var_219_21 < arg_216_1.time_ and arg_216_1.time_ <= var_219_21 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_23 = arg_216_1:FormatText(StoryNameCfg[479].name)

				arg_216_1.leftNameTxt_.text = var_219_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_24 = arg_216_1:GetWordFromCfg(317321052)
				local var_219_25 = arg_216_1:FormatText(var_219_24.content)

				arg_216_1.text_.text = var_219_25

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_26 = 24
				local var_219_27 = utf8.len(var_219_25)
				local var_219_28 = var_219_26 <= 0 and var_219_22 or var_219_22 * (var_219_27 / var_219_26)

				if var_219_28 > 0 and var_219_22 < var_219_28 then
					arg_216_1.talkMaxDuration = var_219_28

					if var_219_28 + var_219_21 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_28 + var_219_21
					end
				end

				arg_216_1.text_.text = var_219_25
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321052", "story_v_out_317321.awb") ~= 0 then
					local var_219_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321052", "story_v_out_317321.awb") / 1000

					if var_219_29 + var_219_21 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_29 + var_219_21
					end

					if var_219_24.prefab_name ~= "" and arg_216_1.actors_[var_219_24.prefab_name] ~= nil then
						local var_219_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_24.prefab_name].transform, "story_v_out_317321", "317321052", "story_v_out_317321.awb")

						arg_216_1:RecordAudio("317321052", var_219_30)
						arg_216_1:RecordAudio("317321052", var_219_30)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_317321", "317321052", "story_v_out_317321.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_317321", "317321052", "story_v_out_317321.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_31 = math.max(var_219_22, arg_216_1.talkMaxDuration)

			if var_219_21 <= arg_216_1.time_ and arg_216_1.time_ < var_219_21 + var_219_31 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_21) / var_219_31

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_21 + var_219_31 and arg_216_1.time_ < var_219_21 + var_219_31 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317321053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 317321053
		arg_220_1.duration_ = 3.5

		local var_220_0 = {
			zh = 3.5,
			ja = 1.733
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
				arg_220_0:Play317321054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0
			local var_223_1 = 0.275

			if var_223_0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_2 = arg_220_1:FormatText(StoryNameCfg[479].name)

				arg_220_1.leftNameTxt_.text = var_223_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_3 = arg_220_1:GetWordFromCfg(317321053)
				local var_223_4 = arg_220_1:FormatText(var_223_3.content)

				arg_220_1.text_.text = var_223_4

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_5 = 11
				local var_223_6 = utf8.len(var_223_4)
				local var_223_7 = var_223_5 <= 0 and var_223_1 or var_223_1 * (var_223_6 / var_223_5)

				if var_223_7 > 0 and var_223_1 < var_223_7 then
					arg_220_1.talkMaxDuration = var_223_7

					if var_223_7 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_7 + var_223_0
					end
				end

				arg_220_1.text_.text = var_223_4
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321053", "story_v_out_317321.awb") ~= 0 then
					local var_223_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321053", "story_v_out_317321.awb") / 1000

					if var_223_8 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_8 + var_223_0
					end

					if var_223_3.prefab_name ~= "" and arg_220_1.actors_[var_223_3.prefab_name] ~= nil then
						local var_223_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_3.prefab_name].transform, "story_v_out_317321", "317321053", "story_v_out_317321.awb")

						arg_220_1:RecordAudio("317321053", var_223_9)
						arg_220_1:RecordAudio("317321053", var_223_9)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_317321", "317321053", "story_v_out_317321.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_317321", "317321053", "story_v_out_317321.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_10 = math.max(var_223_1, arg_220_1.talkMaxDuration)

			if var_223_0 <= arg_220_1.time_ and arg_220_1.time_ < var_223_0 + var_223_10 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_0) / var_223_10

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_0 + var_223_10 and arg_220_1.time_ < var_223_0 + var_223_10 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play317321054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 317321054
		arg_224_1.duration_ = 6.83

		local var_224_0 = {
			zh = 2.866,
			ja = 6.833
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play317321055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["10053ui_story"].transform
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.var_.moveOldPos10053ui_story = var_227_0.localPosition
			end

			local var_227_2 = 0.001

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2
				local var_227_4 = Vector3.New(0.7, -1.12, -5.99)

				var_227_0.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10053ui_story, var_227_4, var_227_3)

				local var_227_5 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_5.x, var_227_5.y, var_227_5.z)

				local var_227_6 = var_227_0.localEulerAngles

				var_227_6.z = 0
				var_227_6.x = 0
				var_227_0.localEulerAngles = var_227_6
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 then
				var_227_0.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_227_7 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_7.x, var_227_7.y, var_227_7.z)

				local var_227_8 = var_227_0.localEulerAngles

				var_227_8.z = 0
				var_227_8.x = 0
				var_227_0.localEulerAngles = var_227_8
			end

			local var_227_9 = arg_224_1.actors_["10053ui_story"]
			local var_227_10 = 0

			if var_227_10 < arg_224_1.time_ and arg_224_1.time_ <= var_227_10 + arg_227_0 and not isNil(var_227_9) and arg_224_1.var_.characterEffect10053ui_story == nil then
				arg_224_1.var_.characterEffect10053ui_story = var_227_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_11 = 0.200000002980232

			if var_227_10 <= arg_224_1.time_ and arg_224_1.time_ < var_227_10 + var_227_11 and not isNil(var_227_9) then
				local var_227_12 = (arg_224_1.time_ - var_227_10) / var_227_11

				if arg_224_1.var_.characterEffect10053ui_story and not isNil(var_227_9) then
					arg_224_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_10 + var_227_11 and arg_224_1.time_ < var_227_10 + var_227_11 + arg_227_0 and not isNil(var_227_9) and arg_224_1.var_.characterEffect10053ui_story then
				arg_224_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_227_13 = 0

			if var_227_13 < arg_224_1.time_ and arg_224_1.time_ <= var_227_13 + arg_227_0 then
				arg_224_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_227_14 = arg_224_1.actors_["1015ui_story"]
			local var_227_15 = 0

			if var_227_15 < arg_224_1.time_ and arg_224_1.time_ <= var_227_15 + arg_227_0 and not isNil(var_227_14) and arg_224_1.var_.characterEffect1015ui_story == nil then
				arg_224_1.var_.characterEffect1015ui_story = var_227_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_16 = 0.200000002980232

			if var_227_15 <= arg_224_1.time_ and arg_224_1.time_ < var_227_15 + var_227_16 and not isNil(var_227_14) then
				local var_227_17 = (arg_224_1.time_ - var_227_15) / var_227_16

				if arg_224_1.var_.characterEffect1015ui_story and not isNil(var_227_14) then
					local var_227_18 = Mathf.Lerp(0, 0.5, var_227_17)

					arg_224_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1015ui_story.fillRatio = var_227_18
				end
			end

			if arg_224_1.time_ >= var_227_15 + var_227_16 and arg_224_1.time_ < var_227_15 + var_227_16 + arg_227_0 and not isNil(var_227_14) and arg_224_1.var_.characterEffect1015ui_story then
				local var_227_19 = 0.5

				arg_224_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1015ui_story.fillRatio = var_227_19
			end

			local var_227_20 = 0
			local var_227_21 = 0.325

			if var_227_20 < arg_224_1.time_ and arg_224_1.time_ <= var_227_20 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_22 = arg_224_1:FormatText(StoryNameCfg[477].name)

				arg_224_1.leftNameTxt_.text = var_227_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_23 = arg_224_1:GetWordFromCfg(317321054)
				local var_227_24 = arg_224_1:FormatText(var_227_23.content)

				arg_224_1.text_.text = var_227_24

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_25 = 13
				local var_227_26 = utf8.len(var_227_24)
				local var_227_27 = var_227_25 <= 0 and var_227_21 or var_227_21 * (var_227_26 / var_227_25)

				if var_227_27 > 0 and var_227_21 < var_227_27 then
					arg_224_1.talkMaxDuration = var_227_27

					if var_227_27 + var_227_20 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_27 + var_227_20
					end
				end

				arg_224_1.text_.text = var_227_24
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321054", "story_v_out_317321.awb") ~= 0 then
					local var_227_28 = manager.audio:GetVoiceLength("story_v_out_317321", "317321054", "story_v_out_317321.awb") / 1000

					if var_227_28 + var_227_20 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_28 + var_227_20
					end

					if var_227_23.prefab_name ~= "" and arg_224_1.actors_[var_227_23.prefab_name] ~= nil then
						local var_227_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_23.prefab_name].transform, "story_v_out_317321", "317321054", "story_v_out_317321.awb")

						arg_224_1:RecordAudio("317321054", var_227_29)
						arg_224_1:RecordAudio("317321054", var_227_29)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_317321", "317321054", "story_v_out_317321.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_317321", "317321054", "story_v_out_317321.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_30 = math.max(var_227_21, arg_224_1.talkMaxDuration)

			if var_227_20 <= arg_224_1.time_ and arg_224_1.time_ < var_227_20 + var_227_30 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_20) / var_227_30

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_20 + var_227_30 and arg_224_1.time_ < var_227_20 + var_227_30 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play317321055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 317321055
		arg_228_1.duration_ = 15.13

		local var_228_0 = {
			zh = 12.733,
			ja = 15.133
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
				arg_228_0:Play317321056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1015ui_story"].transform
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.var_.moveOldPos1015ui_story = var_231_0.localPosition
			end

			local var_231_2 = 0.001

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2
				local var_231_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_231_0.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1015ui_story, var_231_4, var_231_3)

				local var_231_5 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_5.x, var_231_5.y, var_231_5.z)

				local var_231_6 = var_231_0.localEulerAngles

				var_231_6.z = 0
				var_231_6.x = 0
				var_231_0.localEulerAngles = var_231_6
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 then
				var_231_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_231_7 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_7.x, var_231_7.y, var_231_7.z)

				local var_231_8 = var_231_0.localEulerAngles

				var_231_8.z = 0
				var_231_8.x = 0
				var_231_0.localEulerAngles = var_231_8
			end

			local var_231_9 = arg_228_1.actors_["1015ui_story"]
			local var_231_10 = 0

			if var_231_10 < arg_228_1.time_ and arg_228_1.time_ <= var_231_10 + arg_231_0 and not isNil(var_231_9) and arg_228_1.var_.characterEffect1015ui_story == nil then
				arg_228_1.var_.characterEffect1015ui_story = var_231_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_11 = 0.200000002980232

			if var_231_10 <= arg_228_1.time_ and arg_228_1.time_ < var_231_10 + var_231_11 and not isNil(var_231_9) then
				local var_231_12 = (arg_228_1.time_ - var_231_10) / var_231_11

				if arg_228_1.var_.characterEffect1015ui_story and not isNil(var_231_9) then
					arg_228_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_10 + var_231_11 and arg_228_1.time_ < var_231_10 + var_231_11 + arg_231_0 and not isNil(var_231_9) and arg_228_1.var_.characterEffect1015ui_story then
				arg_228_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_231_13 = 0

			if var_231_13 < arg_228_1.time_ and arg_228_1.time_ <= var_231_13 + arg_231_0 then
				arg_228_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_1")
			end

			local var_231_14 = 0

			if var_231_14 < arg_228_1.time_ and arg_228_1.time_ <= var_231_14 + arg_231_0 then
				arg_228_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_231_15 = arg_228_1.actors_["10053ui_story"]
			local var_231_16 = 0

			if var_231_16 < arg_228_1.time_ and arg_228_1.time_ <= var_231_16 + arg_231_0 and not isNil(var_231_15) and arg_228_1.var_.characterEffect10053ui_story == nil then
				arg_228_1.var_.characterEffect10053ui_story = var_231_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_17 = 0.200000002980232

			if var_231_16 <= arg_228_1.time_ and arg_228_1.time_ < var_231_16 + var_231_17 and not isNil(var_231_15) then
				local var_231_18 = (arg_228_1.time_ - var_231_16) / var_231_17

				if arg_228_1.var_.characterEffect10053ui_story and not isNil(var_231_15) then
					local var_231_19 = Mathf.Lerp(0, 0.5, var_231_18)

					arg_228_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_228_1.var_.characterEffect10053ui_story.fillRatio = var_231_19
				end
			end

			if arg_228_1.time_ >= var_231_16 + var_231_17 and arg_228_1.time_ < var_231_16 + var_231_17 + arg_231_0 and not isNil(var_231_15) and arg_228_1.var_.characterEffect10053ui_story then
				local var_231_20 = 0.5

				arg_228_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_228_1.var_.characterEffect10053ui_story.fillRatio = var_231_20
			end

			local var_231_21 = 0
			local var_231_22 = 1.375

			if var_231_21 < arg_228_1.time_ and arg_228_1.time_ <= var_231_21 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_23 = arg_228_1:FormatText(StoryNameCfg[479].name)

				arg_228_1.leftNameTxt_.text = var_231_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_24 = arg_228_1:GetWordFromCfg(317321055)
				local var_231_25 = arg_228_1:FormatText(var_231_24.content)

				arg_228_1.text_.text = var_231_25

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_26 = 55
				local var_231_27 = utf8.len(var_231_25)
				local var_231_28 = var_231_26 <= 0 and var_231_22 or var_231_22 * (var_231_27 / var_231_26)

				if var_231_28 > 0 and var_231_22 < var_231_28 then
					arg_228_1.talkMaxDuration = var_231_28

					if var_231_28 + var_231_21 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_28 + var_231_21
					end
				end

				arg_228_1.text_.text = var_231_25
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321055", "story_v_out_317321.awb") ~= 0 then
					local var_231_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321055", "story_v_out_317321.awb") / 1000

					if var_231_29 + var_231_21 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_29 + var_231_21
					end

					if var_231_24.prefab_name ~= "" and arg_228_1.actors_[var_231_24.prefab_name] ~= nil then
						local var_231_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_24.prefab_name].transform, "story_v_out_317321", "317321055", "story_v_out_317321.awb")

						arg_228_1:RecordAudio("317321055", var_231_30)
						arg_228_1:RecordAudio("317321055", var_231_30)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_317321", "317321055", "story_v_out_317321.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_317321", "317321055", "story_v_out_317321.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_31 = math.max(var_231_22, arg_228_1.talkMaxDuration)

			if var_231_21 <= arg_228_1.time_ and arg_228_1.time_ < var_231_21 + var_231_31 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_21) / var_231_31

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_21 + var_231_31 and arg_228_1.time_ < var_231_21 + var_231_31 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play317321056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 317321056
		arg_232_1.duration_ = 17.37

		local var_232_0 = {
			zh = 12.466,
			ja = 17.366
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play317321057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["10053ui_story"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos10053ui_story = var_235_0.localPosition
			end

			local var_235_2 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2
				local var_235_4 = Vector3.New(0.7, -1.12, -5.99)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10053ui_story, var_235_4, var_235_3)

				local var_235_5 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_5.x, var_235_5.y, var_235_5.z)

				local var_235_6 = var_235_0.localEulerAngles

				var_235_6.z = 0
				var_235_6.x = 0
				var_235_0.localEulerAngles = var_235_6
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_235_7 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_7.x, var_235_7.y, var_235_7.z)

				local var_235_8 = var_235_0.localEulerAngles

				var_235_8.z = 0
				var_235_8.x = 0
				var_235_0.localEulerAngles = var_235_8
			end

			local var_235_9 = arg_232_1.actors_["10053ui_story"]
			local var_235_10 = 0

			if var_235_10 < arg_232_1.time_ and arg_232_1.time_ <= var_235_10 + arg_235_0 and not isNil(var_235_9) and arg_232_1.var_.characterEffect10053ui_story == nil then
				arg_232_1.var_.characterEffect10053ui_story = var_235_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_11 = 0.200000002980232

			if var_235_10 <= arg_232_1.time_ and arg_232_1.time_ < var_235_10 + var_235_11 and not isNil(var_235_9) then
				local var_235_12 = (arg_232_1.time_ - var_235_10) / var_235_11

				if arg_232_1.var_.characterEffect10053ui_story and not isNil(var_235_9) then
					arg_232_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_10 + var_235_11 and arg_232_1.time_ < var_235_10 + var_235_11 + arg_235_0 and not isNil(var_235_9) and arg_232_1.var_.characterEffect10053ui_story then
				arg_232_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_235_13 = 0

			if var_235_13 < arg_232_1.time_ and arg_232_1.time_ <= var_235_13 + arg_235_0 then
				arg_232_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_235_14 = arg_232_1.actors_["1015ui_story"]
			local var_235_15 = 0

			if var_235_15 < arg_232_1.time_ and arg_232_1.time_ <= var_235_15 + arg_235_0 and not isNil(var_235_14) and arg_232_1.var_.characterEffect1015ui_story == nil then
				arg_232_1.var_.characterEffect1015ui_story = var_235_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_16 = 0.200000002980232

			if var_235_15 <= arg_232_1.time_ and arg_232_1.time_ < var_235_15 + var_235_16 and not isNil(var_235_14) then
				local var_235_17 = (arg_232_1.time_ - var_235_15) / var_235_16

				if arg_232_1.var_.characterEffect1015ui_story and not isNil(var_235_14) then
					local var_235_18 = Mathf.Lerp(0, 0.5, var_235_17)

					arg_232_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1015ui_story.fillRatio = var_235_18
				end
			end

			if arg_232_1.time_ >= var_235_15 + var_235_16 and arg_232_1.time_ < var_235_15 + var_235_16 + arg_235_0 and not isNil(var_235_14) and arg_232_1.var_.characterEffect1015ui_story then
				local var_235_19 = 0.5

				arg_232_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1015ui_story.fillRatio = var_235_19
			end

			local var_235_20 = 0
			local var_235_21 = 0.925

			if var_235_20 < arg_232_1.time_ and arg_232_1.time_ <= var_235_20 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_22 = arg_232_1:FormatText(StoryNameCfg[477].name)

				arg_232_1.leftNameTxt_.text = var_235_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_23 = arg_232_1:GetWordFromCfg(317321056)
				local var_235_24 = arg_232_1:FormatText(var_235_23.content)

				arg_232_1.text_.text = var_235_24

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_25 = 37
				local var_235_26 = utf8.len(var_235_24)
				local var_235_27 = var_235_25 <= 0 and var_235_21 or var_235_21 * (var_235_26 / var_235_25)

				if var_235_27 > 0 and var_235_21 < var_235_27 then
					arg_232_1.talkMaxDuration = var_235_27

					if var_235_27 + var_235_20 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_27 + var_235_20
					end
				end

				arg_232_1.text_.text = var_235_24
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321056", "story_v_out_317321.awb") ~= 0 then
					local var_235_28 = manager.audio:GetVoiceLength("story_v_out_317321", "317321056", "story_v_out_317321.awb") / 1000

					if var_235_28 + var_235_20 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_28 + var_235_20
					end

					if var_235_23.prefab_name ~= "" and arg_232_1.actors_[var_235_23.prefab_name] ~= nil then
						local var_235_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_23.prefab_name].transform, "story_v_out_317321", "317321056", "story_v_out_317321.awb")

						arg_232_1:RecordAudio("317321056", var_235_29)
						arg_232_1:RecordAudio("317321056", var_235_29)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_317321", "317321056", "story_v_out_317321.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_317321", "317321056", "story_v_out_317321.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_30 = math.max(var_235_21, arg_232_1.talkMaxDuration)

			if var_235_20 <= arg_232_1.time_ and arg_232_1.time_ < var_235_20 + var_235_30 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_20) / var_235_30

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_20 + var_235_30 and arg_232_1.time_ < var_235_20 + var_235_30 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play317321057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 317321057
		arg_236_1.duration_ = 4.57

		local var_236_0 = {
			zh = 2.266,
			ja = 4.566
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
				arg_236_0:Play317321058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 0.275

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_2 = arg_236_1:FormatText(StoryNameCfg[477].name)

				arg_236_1.leftNameTxt_.text = var_239_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_3 = arg_236_1:GetWordFromCfg(317321057)
				local var_239_4 = arg_236_1:FormatText(var_239_3.content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 11
				local var_239_6 = utf8.len(var_239_4)
				local var_239_7 = var_239_5 <= 0 and var_239_1 or var_239_1 * (var_239_6 / var_239_5)

				if var_239_7 > 0 and var_239_1 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321057", "story_v_out_317321.awb") ~= 0 then
					local var_239_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321057", "story_v_out_317321.awb") / 1000

					if var_239_8 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_8 + var_239_0
					end

					if var_239_3.prefab_name ~= "" and arg_236_1.actors_[var_239_3.prefab_name] ~= nil then
						local var_239_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_3.prefab_name].transform, "story_v_out_317321", "317321057", "story_v_out_317321.awb")

						arg_236_1:RecordAudio("317321057", var_239_9)
						arg_236_1:RecordAudio("317321057", var_239_9)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_317321", "317321057", "story_v_out_317321.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_317321", "317321057", "story_v_out_317321.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_10 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_10 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_10

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_10 and arg_236_1.time_ < var_239_0 + var_239_10 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play317321058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 317321058
		arg_240_1.duration_ = 10.23

		local var_240_0 = {
			zh = 5.433,
			ja = 10.233
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play317321059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1015ui_story"].transform
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.var_.moveOldPos1015ui_story = var_243_0.localPosition
			end

			local var_243_2 = 0.001

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2
				local var_243_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_243_0.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1015ui_story, var_243_4, var_243_3)

				local var_243_5 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_5.x, var_243_5.y, var_243_5.z)

				local var_243_6 = var_243_0.localEulerAngles

				var_243_6.z = 0
				var_243_6.x = 0
				var_243_0.localEulerAngles = var_243_6
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 then
				var_243_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_243_7 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_7.x, var_243_7.y, var_243_7.z)

				local var_243_8 = var_243_0.localEulerAngles

				var_243_8.z = 0
				var_243_8.x = 0
				var_243_0.localEulerAngles = var_243_8
			end

			local var_243_9 = arg_240_1.actors_["1015ui_story"]
			local var_243_10 = 0

			if var_243_10 < arg_240_1.time_ and arg_240_1.time_ <= var_243_10 + arg_243_0 and not isNil(var_243_9) and arg_240_1.var_.characterEffect1015ui_story == nil then
				arg_240_1.var_.characterEffect1015ui_story = var_243_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_11 = 0.200000002980232

			if var_243_10 <= arg_240_1.time_ and arg_240_1.time_ < var_243_10 + var_243_11 and not isNil(var_243_9) then
				local var_243_12 = (arg_240_1.time_ - var_243_10) / var_243_11

				if arg_240_1.var_.characterEffect1015ui_story and not isNil(var_243_9) then
					arg_240_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_10 + var_243_11 and arg_240_1.time_ < var_243_10 + var_243_11 + arg_243_0 and not isNil(var_243_9) and arg_240_1.var_.characterEffect1015ui_story then
				arg_240_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_243_13 = 0

			if var_243_13 < arg_240_1.time_ and arg_240_1.time_ <= var_243_13 + arg_243_0 then
				arg_240_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015actionlink/1015action452")
			end

			local var_243_14 = 0

			if var_243_14 < arg_240_1.time_ and arg_240_1.time_ <= var_243_14 + arg_243_0 then
				arg_240_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_243_15 = arg_240_1.actors_["10053ui_story"]
			local var_243_16 = 0

			if var_243_16 < arg_240_1.time_ and arg_240_1.time_ <= var_243_16 + arg_243_0 and not isNil(var_243_15) and arg_240_1.var_.characterEffect10053ui_story == nil then
				arg_240_1.var_.characterEffect10053ui_story = var_243_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_17 = 0.200000002980232

			if var_243_16 <= arg_240_1.time_ and arg_240_1.time_ < var_243_16 + var_243_17 and not isNil(var_243_15) then
				local var_243_18 = (arg_240_1.time_ - var_243_16) / var_243_17

				if arg_240_1.var_.characterEffect10053ui_story and not isNil(var_243_15) then
					local var_243_19 = Mathf.Lerp(0, 0.5, var_243_18)

					arg_240_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_240_1.var_.characterEffect10053ui_story.fillRatio = var_243_19
				end
			end

			if arg_240_1.time_ >= var_243_16 + var_243_17 and arg_240_1.time_ < var_243_16 + var_243_17 + arg_243_0 and not isNil(var_243_15) and arg_240_1.var_.characterEffect10053ui_story then
				local var_243_20 = 0.5

				arg_240_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_240_1.var_.characterEffect10053ui_story.fillRatio = var_243_20
			end

			local var_243_21 = 0
			local var_243_22 = 0.6

			if var_243_21 < arg_240_1.time_ and arg_240_1.time_ <= var_243_21 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_23 = arg_240_1:FormatText(StoryNameCfg[479].name)

				arg_240_1.leftNameTxt_.text = var_243_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_24 = arg_240_1:GetWordFromCfg(317321058)
				local var_243_25 = arg_240_1:FormatText(var_243_24.content)

				arg_240_1.text_.text = var_243_25

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_26 = 24
				local var_243_27 = utf8.len(var_243_25)
				local var_243_28 = var_243_26 <= 0 and var_243_22 or var_243_22 * (var_243_27 / var_243_26)

				if var_243_28 > 0 and var_243_22 < var_243_28 then
					arg_240_1.talkMaxDuration = var_243_28

					if var_243_28 + var_243_21 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_28 + var_243_21
					end
				end

				arg_240_1.text_.text = var_243_25
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321058", "story_v_out_317321.awb") ~= 0 then
					local var_243_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321058", "story_v_out_317321.awb") / 1000

					if var_243_29 + var_243_21 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_29 + var_243_21
					end

					if var_243_24.prefab_name ~= "" and arg_240_1.actors_[var_243_24.prefab_name] ~= nil then
						local var_243_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_24.prefab_name].transform, "story_v_out_317321", "317321058", "story_v_out_317321.awb")

						arg_240_1:RecordAudio("317321058", var_243_30)
						arg_240_1:RecordAudio("317321058", var_243_30)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_317321", "317321058", "story_v_out_317321.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_317321", "317321058", "story_v_out_317321.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_31 = math.max(var_243_22, arg_240_1.talkMaxDuration)

			if var_243_21 <= arg_240_1.time_ and arg_240_1.time_ < var_243_21 + var_243_31 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_21) / var_243_31

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_21 + var_243_31 and arg_240_1.time_ < var_243_21 + var_243_31 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play317321059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 317321059
		arg_244_1.duration_ = 18.67

		local var_244_0 = {
			zh = 14.2,
			ja = 18.666
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play317321060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 1.5

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_2 = arg_244_1:FormatText(StoryNameCfg[479].name)

				arg_244_1.leftNameTxt_.text = var_247_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_3 = arg_244_1:GetWordFromCfg(317321059)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 60
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

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321059", "story_v_out_317321.awb") ~= 0 then
					local var_247_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321059", "story_v_out_317321.awb") / 1000

					if var_247_8 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_0
					end

					if var_247_3.prefab_name ~= "" and arg_244_1.actors_[var_247_3.prefab_name] ~= nil then
						local var_247_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_3.prefab_name].transform, "story_v_out_317321", "317321059", "story_v_out_317321.awb")

						arg_244_1:RecordAudio("317321059", var_247_9)
						arg_244_1:RecordAudio("317321059", var_247_9)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_317321", "317321059", "story_v_out_317321.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_317321", "317321059", "story_v_out_317321.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_10 and arg_244_1.time_ < var_247_0 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play317321060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 317321060
		arg_248_1.duration_ = 12.6

		local var_248_0 = {
			zh = 10.6,
			ja = 12.6
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
				arg_248_0:Play317321061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 1.125

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[479].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_3 = arg_248_1:GetWordFromCfg(317321060)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 45
				local var_251_6 = utf8.len(var_251_4)
				local var_251_7 = var_251_5 <= 0 and var_251_1 or var_251_1 * (var_251_6 / var_251_5)

				if var_251_7 > 0 and var_251_1 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_4
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321060", "story_v_out_317321.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321060", "story_v_out_317321.awb") / 1000

					if var_251_8 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_0
					end

					if var_251_3.prefab_name ~= "" and arg_248_1.actors_[var_251_3.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_3.prefab_name].transform, "story_v_out_317321", "317321060", "story_v_out_317321.awb")

						arg_248_1:RecordAudio("317321060", var_251_9)
						arg_248_1:RecordAudio("317321060", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_317321", "317321060", "story_v_out_317321.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_317321", "317321060", "story_v_out_317321.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_10 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_10 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_10

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_10 and arg_248_1.time_ < var_251_0 + var_251_10 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play317321061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 317321061
		arg_252_1.duration_ = 4

		local var_252_0 = {
			zh = 4,
			ja = 1.999999999999
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
				arg_252_0:Play317321062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10053ui_story"].transform
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.var_.moveOldPos10053ui_story = var_255_0.localPosition
			end

			local var_255_2 = 0.001

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2
				local var_255_4 = Vector3.New(0.7, -1.12, -5.99)

				var_255_0.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10053ui_story, var_255_4, var_255_3)

				local var_255_5 = manager.ui.mainCamera.transform.position - var_255_0.position

				var_255_0.forward = Vector3.New(var_255_5.x, var_255_5.y, var_255_5.z)

				local var_255_6 = var_255_0.localEulerAngles

				var_255_6.z = 0
				var_255_6.x = 0
				var_255_0.localEulerAngles = var_255_6
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 then
				var_255_0.localPosition = Vector3.New(0.7, -1.12, -5.99)

				local var_255_7 = manager.ui.mainCamera.transform.position - var_255_0.position

				var_255_0.forward = Vector3.New(var_255_7.x, var_255_7.y, var_255_7.z)

				local var_255_8 = var_255_0.localEulerAngles

				var_255_8.z = 0
				var_255_8.x = 0
				var_255_0.localEulerAngles = var_255_8
			end

			local var_255_9 = arg_252_1.actors_["10053ui_story"]
			local var_255_10 = 0

			if var_255_10 < arg_252_1.time_ and arg_252_1.time_ <= var_255_10 + arg_255_0 and not isNil(var_255_9) and arg_252_1.var_.characterEffect10053ui_story == nil then
				arg_252_1.var_.characterEffect10053ui_story = var_255_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_11 = 0.200000002980232

			if var_255_10 <= arg_252_1.time_ and arg_252_1.time_ < var_255_10 + var_255_11 and not isNil(var_255_9) then
				local var_255_12 = (arg_252_1.time_ - var_255_10) / var_255_11

				if arg_252_1.var_.characterEffect10053ui_story and not isNil(var_255_9) then
					arg_252_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_10 + var_255_11 and arg_252_1.time_ < var_255_10 + var_255_11 + arg_255_0 and not isNil(var_255_9) and arg_252_1.var_.characterEffect10053ui_story then
				arg_252_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_255_13 = 0

			if var_255_13 < arg_252_1.time_ and arg_252_1.time_ <= var_255_13 + arg_255_0 then
				arg_252_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_255_14 = arg_252_1.actors_["1015ui_story"]
			local var_255_15 = 0

			if var_255_15 < arg_252_1.time_ and arg_252_1.time_ <= var_255_15 + arg_255_0 and not isNil(var_255_14) and arg_252_1.var_.characterEffect1015ui_story == nil then
				arg_252_1.var_.characterEffect1015ui_story = var_255_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_16 = 0.200000002980232

			if var_255_15 <= arg_252_1.time_ and arg_252_1.time_ < var_255_15 + var_255_16 and not isNil(var_255_14) then
				local var_255_17 = (arg_252_1.time_ - var_255_15) / var_255_16

				if arg_252_1.var_.characterEffect1015ui_story and not isNil(var_255_14) then
					local var_255_18 = Mathf.Lerp(0, 0.5, var_255_17)

					arg_252_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1015ui_story.fillRatio = var_255_18
				end
			end

			if arg_252_1.time_ >= var_255_15 + var_255_16 and arg_252_1.time_ < var_255_15 + var_255_16 + arg_255_0 and not isNil(var_255_14) and arg_252_1.var_.characterEffect1015ui_story then
				local var_255_19 = 0.5

				arg_252_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1015ui_story.fillRatio = var_255_19
			end

			local var_255_20 = 0
			local var_255_21 = 0.2

			if var_255_20 < arg_252_1.time_ and arg_252_1.time_ <= var_255_20 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_22 = arg_252_1:FormatText(StoryNameCfg[477].name)

				arg_252_1.leftNameTxt_.text = var_255_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_23 = arg_252_1:GetWordFromCfg(317321061)
				local var_255_24 = arg_252_1:FormatText(var_255_23.content)

				arg_252_1.text_.text = var_255_24

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_25 = 8
				local var_255_26 = utf8.len(var_255_24)
				local var_255_27 = var_255_25 <= 0 and var_255_21 or var_255_21 * (var_255_26 / var_255_25)

				if var_255_27 > 0 and var_255_21 < var_255_27 then
					arg_252_1.talkMaxDuration = var_255_27

					if var_255_27 + var_255_20 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_27 + var_255_20
					end
				end

				arg_252_1.text_.text = var_255_24
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321061", "story_v_out_317321.awb") ~= 0 then
					local var_255_28 = manager.audio:GetVoiceLength("story_v_out_317321", "317321061", "story_v_out_317321.awb") / 1000

					if var_255_28 + var_255_20 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_28 + var_255_20
					end

					if var_255_23.prefab_name ~= "" and arg_252_1.actors_[var_255_23.prefab_name] ~= nil then
						local var_255_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_23.prefab_name].transform, "story_v_out_317321", "317321061", "story_v_out_317321.awb")

						arg_252_1:RecordAudio("317321061", var_255_29)
						arg_252_1:RecordAudio("317321061", var_255_29)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_317321", "317321061", "story_v_out_317321.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_317321", "317321061", "story_v_out_317321.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_30 = math.max(var_255_21, arg_252_1.talkMaxDuration)

			if var_255_20 <= arg_252_1.time_ and arg_252_1.time_ < var_255_20 + var_255_30 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_20) / var_255_30

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_20 + var_255_30 and arg_252_1.time_ < var_255_20 + var_255_30 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play317321062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 317321062
		arg_256_1.duration_ = 10.23

		local var_256_0 = {
			zh = 9.966,
			ja = 10.233
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play317321063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 1.05

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_2 = arg_256_1:FormatText(StoryNameCfg[477].name)

				arg_256_1.leftNameTxt_.text = var_259_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_3 = arg_256_1:GetWordFromCfg(317321062)
				local var_259_4 = arg_256_1:FormatText(var_259_3.content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 42
				local var_259_6 = utf8.len(var_259_4)
				local var_259_7 = var_259_5 <= 0 and var_259_1 or var_259_1 * (var_259_6 / var_259_5)

				if var_259_7 > 0 and var_259_1 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321062", "story_v_out_317321.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321062", "story_v_out_317321.awb") / 1000

					if var_259_8 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_0
					end

					if var_259_3.prefab_name ~= "" and arg_256_1.actors_[var_259_3.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_3.prefab_name].transform, "story_v_out_317321", "317321062", "story_v_out_317321.awb")

						arg_256_1:RecordAudio("317321062", var_259_9)
						arg_256_1:RecordAudio("317321062", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_317321", "317321062", "story_v_out_317321.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_317321", "317321062", "story_v_out_317321.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_10 and arg_256_1.time_ < var_259_0 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play317321063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 317321063
		arg_260_1.duration_ = 9.97

		local var_260_0 = {
			zh = 7.5,
			ja = 9.966
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play317321064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 0.775

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_2 = arg_260_1:FormatText(StoryNameCfg[477].name)

				arg_260_1.leftNameTxt_.text = var_263_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_3 = arg_260_1:GetWordFromCfg(317321063)
				local var_263_4 = arg_260_1:FormatText(var_263_3.content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 31
				local var_263_6 = utf8.len(var_263_4)
				local var_263_7 = var_263_5 <= 0 and var_263_1 or var_263_1 * (var_263_6 / var_263_5)

				if var_263_7 > 0 and var_263_1 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_0
					end
				end

				arg_260_1.text_.text = var_263_4
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321063", "story_v_out_317321.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321063", "story_v_out_317321.awb") / 1000

					if var_263_8 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_0
					end

					if var_263_3.prefab_name ~= "" and arg_260_1.actors_[var_263_3.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_3.prefab_name].transform, "story_v_out_317321", "317321063", "story_v_out_317321.awb")

						arg_260_1:RecordAudio("317321063", var_263_9)
						arg_260_1:RecordAudio("317321063", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_317321", "317321063", "story_v_out_317321.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_317321", "317321063", "story_v_out_317321.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_1, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_0) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_10 and arg_260_1.time_ < var_263_0 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play317321064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 317321064
		arg_264_1.duration_ = 8.47

		local var_264_0 = {
			zh = 7.233,
			ja = 8.466
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play317321065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0
			local var_267_1 = 0.5

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_2 = arg_264_1:FormatText(StoryNameCfg[477].name)

				arg_264_1.leftNameTxt_.text = var_267_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_3 = arg_264_1:GetWordFromCfg(317321064)
				local var_267_4 = arg_264_1:FormatText(var_267_3.content)

				arg_264_1.text_.text = var_267_4

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 20
				local var_267_6 = utf8.len(var_267_4)
				local var_267_7 = var_267_5 <= 0 and var_267_1 or var_267_1 * (var_267_6 / var_267_5)

				if var_267_7 > 0 and var_267_1 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_0
					end
				end

				arg_264_1.text_.text = var_267_4
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321064", "story_v_out_317321.awb") ~= 0 then
					local var_267_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321064", "story_v_out_317321.awb") / 1000

					if var_267_8 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_8 + var_267_0
					end

					if var_267_3.prefab_name ~= "" and arg_264_1.actors_[var_267_3.prefab_name] ~= nil then
						local var_267_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_3.prefab_name].transform, "story_v_out_317321", "317321064", "story_v_out_317321.awb")

						arg_264_1:RecordAudio("317321064", var_267_9)
						arg_264_1:RecordAudio("317321064", var_267_9)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_317321", "317321064", "story_v_out_317321.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_317321", "317321064", "story_v_out_317321.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_10 = math.max(var_267_1, arg_264_1.talkMaxDuration)

			if var_267_0 <= arg_264_1.time_ and arg_264_1.time_ < var_267_0 + var_267_10 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_0) / var_267_10

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_0 + var_267_10 and arg_264_1.time_ < var_267_0 + var_267_10 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play317321065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 317321065
		arg_268_1.duration_ = 7

		local var_268_0 = {
			zh = 7,
			ja = 2.666
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play317321066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["1015ui_story"].transform
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.var_.moveOldPos1015ui_story = var_271_0.localPosition
			end

			local var_271_2 = 0.001

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2
				local var_271_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_271_0.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1015ui_story, var_271_4, var_271_3)

				local var_271_5 = manager.ui.mainCamera.transform.position - var_271_0.position

				var_271_0.forward = Vector3.New(var_271_5.x, var_271_5.y, var_271_5.z)

				local var_271_6 = var_271_0.localEulerAngles

				var_271_6.z = 0
				var_271_6.x = 0
				var_271_0.localEulerAngles = var_271_6
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 then
				var_271_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_271_7 = manager.ui.mainCamera.transform.position - var_271_0.position

				var_271_0.forward = Vector3.New(var_271_7.x, var_271_7.y, var_271_7.z)

				local var_271_8 = var_271_0.localEulerAngles

				var_271_8.z = 0
				var_271_8.x = 0
				var_271_0.localEulerAngles = var_271_8
			end

			local var_271_9 = arg_268_1.actors_["1015ui_story"]
			local var_271_10 = 0

			if var_271_10 < arg_268_1.time_ and arg_268_1.time_ <= var_271_10 + arg_271_0 and not isNil(var_271_9) and arg_268_1.var_.characterEffect1015ui_story == nil then
				arg_268_1.var_.characterEffect1015ui_story = var_271_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_11 = 0.200000002980232

			if var_271_10 <= arg_268_1.time_ and arg_268_1.time_ < var_271_10 + var_271_11 and not isNil(var_271_9) then
				local var_271_12 = (arg_268_1.time_ - var_271_10) / var_271_11

				if arg_268_1.var_.characterEffect1015ui_story and not isNil(var_271_9) then
					arg_268_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= var_271_10 + var_271_11 and arg_268_1.time_ < var_271_10 + var_271_11 + arg_271_0 and not isNil(var_271_9) and arg_268_1.var_.characterEffect1015ui_story then
				arg_268_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_271_13 = 0

			if var_271_13 < arg_268_1.time_ and arg_268_1.time_ <= var_271_13 + arg_271_0 then
				arg_268_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			local var_271_14 = 0

			if var_271_14 < arg_268_1.time_ and arg_268_1.time_ <= var_271_14 + arg_271_0 then
				arg_268_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_271_15 = 0
			local var_271_16 = 0.65

			if var_271_15 < arg_268_1.time_ and arg_268_1.time_ <= var_271_15 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_17 = arg_268_1:FormatText(StoryNameCfg[479].name)

				arg_268_1.leftNameTxt_.text = var_271_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_18 = arg_268_1:GetWordFromCfg(317321065)
				local var_271_19 = arg_268_1:FormatText(var_271_18.content)

				arg_268_1.text_.text = var_271_19

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_20 = 26
				local var_271_21 = utf8.len(var_271_19)
				local var_271_22 = var_271_20 <= 0 and var_271_16 or var_271_16 * (var_271_21 / var_271_20)

				if var_271_22 > 0 and var_271_16 < var_271_22 then
					arg_268_1.talkMaxDuration = var_271_22

					if var_271_22 + var_271_15 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_22 + var_271_15
					end
				end

				arg_268_1.text_.text = var_271_19
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321065", "story_v_out_317321.awb") ~= 0 then
					local var_271_23 = manager.audio:GetVoiceLength("story_v_out_317321", "317321065", "story_v_out_317321.awb") / 1000

					if var_271_23 + var_271_15 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_23 + var_271_15
					end

					if var_271_18.prefab_name ~= "" and arg_268_1.actors_[var_271_18.prefab_name] ~= nil then
						local var_271_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_18.prefab_name].transform, "story_v_out_317321", "317321065", "story_v_out_317321.awb")

						arg_268_1:RecordAudio("317321065", var_271_24)
						arg_268_1:RecordAudio("317321065", var_271_24)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_317321", "317321065", "story_v_out_317321.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_317321", "317321065", "story_v_out_317321.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_25 = math.max(var_271_16, arg_268_1.talkMaxDuration)

			if var_271_15 <= arg_268_1.time_ and arg_268_1.time_ < var_271_15 + var_271_25 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_15) / var_271_25

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_15 + var_271_25 and arg_268_1.time_ < var_271_15 + var_271_25 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play317321066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 317321066
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play317321067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["1015ui_story"].transform
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.var_.moveOldPos1015ui_story = var_275_0.localPosition
			end

			local var_275_2 = 0.001

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2
				local var_275_4 = Vector3.New(0, 100, 0)

				var_275_0.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1015ui_story, var_275_4, var_275_3)

				local var_275_5 = manager.ui.mainCamera.transform.position - var_275_0.position

				var_275_0.forward = Vector3.New(var_275_5.x, var_275_5.y, var_275_5.z)

				local var_275_6 = var_275_0.localEulerAngles

				var_275_6.z = 0
				var_275_6.x = 0
				var_275_0.localEulerAngles = var_275_6
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 then
				var_275_0.localPosition = Vector3.New(0, 100, 0)

				local var_275_7 = manager.ui.mainCamera.transform.position - var_275_0.position

				var_275_0.forward = Vector3.New(var_275_7.x, var_275_7.y, var_275_7.z)

				local var_275_8 = var_275_0.localEulerAngles

				var_275_8.z = 0
				var_275_8.x = 0
				var_275_0.localEulerAngles = var_275_8
			end

			local var_275_9 = arg_272_1.actors_["10053ui_story"].transform
			local var_275_10 = 0

			if var_275_10 < arg_272_1.time_ and arg_272_1.time_ <= var_275_10 + arg_275_0 then
				arg_272_1.var_.moveOldPos10053ui_story = var_275_9.localPosition
			end

			local var_275_11 = 0.001

			if var_275_10 <= arg_272_1.time_ and arg_272_1.time_ < var_275_10 + var_275_11 then
				local var_275_12 = (arg_272_1.time_ - var_275_10) / var_275_11
				local var_275_13 = Vector3.New(0, 100, 0)

				var_275_9.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos10053ui_story, var_275_13, var_275_12)

				local var_275_14 = manager.ui.mainCamera.transform.position - var_275_9.position

				var_275_9.forward = Vector3.New(var_275_14.x, var_275_14.y, var_275_14.z)

				local var_275_15 = var_275_9.localEulerAngles

				var_275_15.z = 0
				var_275_15.x = 0
				var_275_9.localEulerAngles = var_275_15
			end

			if arg_272_1.time_ >= var_275_10 + var_275_11 and arg_272_1.time_ < var_275_10 + var_275_11 + arg_275_0 then
				var_275_9.localPosition = Vector3.New(0, 100, 0)

				local var_275_16 = manager.ui.mainCamera.transform.position - var_275_9.position

				var_275_9.forward = Vector3.New(var_275_16.x, var_275_16.y, var_275_16.z)

				local var_275_17 = var_275_9.localEulerAngles

				var_275_17.z = 0
				var_275_17.x = 0
				var_275_9.localEulerAngles = var_275_17
			end

			local var_275_18 = 0
			local var_275_19 = 1.05

			if var_275_18 < arg_272_1.time_ and arg_272_1.time_ <= var_275_18 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, false)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_20 = arg_272_1:GetWordFromCfg(317321066)
				local var_275_21 = arg_272_1:FormatText(var_275_20.content)

				arg_272_1.text_.text = var_275_21

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_22 = 42
				local var_275_23 = utf8.len(var_275_21)
				local var_275_24 = var_275_22 <= 0 and var_275_19 or var_275_19 * (var_275_23 / var_275_22)

				if var_275_24 > 0 and var_275_19 < var_275_24 then
					arg_272_1.talkMaxDuration = var_275_24

					if var_275_24 + var_275_18 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_24 + var_275_18
					end
				end

				arg_272_1.text_.text = var_275_21
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_25 = math.max(var_275_19, arg_272_1.talkMaxDuration)

			if var_275_18 <= arg_272_1.time_ and arg_272_1.time_ < var_275_18 + var_275_25 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_18) / var_275_25

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_18 + var_275_25 and arg_272_1.time_ < var_275_18 + var_275_25 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play317321067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 317321067
		arg_276_1.duration_ = 7.83

		local var_276_0 = {
			zh = 7.833,
			ja = 7.266
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play317321068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["10053ui_story"].transform
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.var_.moveOldPos10053ui_story = var_279_0.localPosition
			end

			local var_279_2 = 0.001

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2
				local var_279_4 = Vector3.New(0, -1.12, -5.99)

				var_279_0.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10053ui_story, var_279_4, var_279_3)

				local var_279_5 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_5.x, var_279_5.y, var_279_5.z)

				local var_279_6 = var_279_0.localEulerAngles

				var_279_6.z = 0
				var_279_6.x = 0
				var_279_0.localEulerAngles = var_279_6
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 then
				var_279_0.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_279_7 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_7.x, var_279_7.y, var_279_7.z)

				local var_279_8 = var_279_0.localEulerAngles

				var_279_8.z = 0
				var_279_8.x = 0
				var_279_0.localEulerAngles = var_279_8
			end

			local var_279_9 = arg_276_1.actors_["10053ui_story"]
			local var_279_10 = 0

			if var_279_10 < arg_276_1.time_ and arg_276_1.time_ <= var_279_10 + arg_279_0 and not isNil(var_279_9) and arg_276_1.var_.characterEffect10053ui_story == nil then
				arg_276_1.var_.characterEffect10053ui_story = var_279_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_11 = 0.200000002980232

			if var_279_10 <= arg_276_1.time_ and arg_276_1.time_ < var_279_10 + var_279_11 and not isNil(var_279_9) then
				local var_279_12 = (arg_276_1.time_ - var_279_10) / var_279_11

				if arg_276_1.var_.characterEffect10053ui_story and not isNil(var_279_9) then
					arg_276_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= var_279_10 + var_279_11 and arg_276_1.time_ < var_279_10 + var_279_11 + arg_279_0 and not isNil(var_279_9) and arg_276_1.var_.characterEffect10053ui_story then
				arg_276_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_279_13 = 0

			if var_279_13 < arg_276_1.time_ and arg_276_1.time_ <= var_279_13 + arg_279_0 then
				arg_276_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action19_1")
			end

			local var_279_14 = 0

			if var_279_14 < arg_276_1.time_ and arg_276_1.time_ <= var_279_14 + arg_279_0 then
				arg_276_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_279_15 = 0
			local var_279_16 = 0.525

			if var_279_15 < arg_276_1.time_ and arg_276_1.time_ <= var_279_15 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_17 = arg_276_1:FormatText(StoryNameCfg[477].name)

				arg_276_1.leftNameTxt_.text = var_279_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_18 = arg_276_1:GetWordFromCfg(317321067)
				local var_279_19 = arg_276_1:FormatText(var_279_18.content)

				arg_276_1.text_.text = var_279_19

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_20 = 21
				local var_279_21 = utf8.len(var_279_19)
				local var_279_22 = var_279_20 <= 0 and var_279_16 or var_279_16 * (var_279_21 / var_279_20)

				if var_279_22 > 0 and var_279_16 < var_279_22 then
					arg_276_1.talkMaxDuration = var_279_22

					if var_279_22 + var_279_15 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_22 + var_279_15
					end
				end

				arg_276_1.text_.text = var_279_19
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321067", "story_v_out_317321.awb") ~= 0 then
					local var_279_23 = manager.audio:GetVoiceLength("story_v_out_317321", "317321067", "story_v_out_317321.awb") / 1000

					if var_279_23 + var_279_15 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_23 + var_279_15
					end

					if var_279_18.prefab_name ~= "" and arg_276_1.actors_[var_279_18.prefab_name] ~= nil then
						local var_279_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_18.prefab_name].transform, "story_v_out_317321", "317321067", "story_v_out_317321.awb")

						arg_276_1:RecordAudio("317321067", var_279_24)
						arg_276_1:RecordAudio("317321067", var_279_24)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_317321", "317321067", "story_v_out_317321.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_317321", "317321067", "story_v_out_317321.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_25 = math.max(var_279_16, arg_276_1.talkMaxDuration)

			if var_279_15 <= arg_276_1.time_ and arg_276_1.time_ < var_279_15 + var_279_25 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_15) / var_279_25

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_15 + var_279_25 and arg_276_1.time_ < var_279_15 + var_279_25 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play317321068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 317321068
		arg_280_1.duration_ = 6.13

		local var_280_0 = {
			zh = 3.8,
			ja = 6.133
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play317321069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["10053ui_story"].transform
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.var_.moveOldPos10053ui_story = var_283_0.localPosition
			end

			local var_283_2 = 0.001

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2
				local var_283_4 = Vector3.New(0, 100, 0)

				var_283_0.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10053ui_story, var_283_4, var_283_3)

				local var_283_5 = manager.ui.mainCamera.transform.position - var_283_0.position

				var_283_0.forward = Vector3.New(var_283_5.x, var_283_5.y, var_283_5.z)

				local var_283_6 = var_283_0.localEulerAngles

				var_283_6.z = 0
				var_283_6.x = 0
				var_283_0.localEulerAngles = var_283_6
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 then
				var_283_0.localPosition = Vector3.New(0, 100, 0)

				local var_283_7 = manager.ui.mainCamera.transform.position - var_283_0.position

				var_283_0.forward = Vector3.New(var_283_7.x, var_283_7.y, var_283_7.z)

				local var_283_8 = var_283_0.localEulerAngles

				var_283_8.z = 0
				var_283_8.x = 0
				var_283_0.localEulerAngles = var_283_8
			end

			local var_283_9 = arg_280_1.actors_["10053ui_story"]
			local var_283_10 = 0

			if var_283_10 < arg_280_1.time_ and arg_280_1.time_ <= var_283_10 + arg_283_0 and not isNil(var_283_9) and arg_280_1.var_.characterEffect10053ui_story == nil then
				arg_280_1.var_.characterEffect10053ui_story = var_283_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_11 = 0.200000002980232

			if var_283_10 <= arg_280_1.time_ and arg_280_1.time_ < var_283_10 + var_283_11 and not isNil(var_283_9) then
				local var_283_12 = (arg_280_1.time_ - var_283_10) / var_283_11

				if arg_280_1.var_.characterEffect10053ui_story and not isNil(var_283_9) then
					local var_283_13 = Mathf.Lerp(0, 0.5, var_283_12)

					arg_280_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_280_1.var_.characterEffect10053ui_story.fillRatio = var_283_13
				end
			end

			if arg_280_1.time_ >= var_283_10 + var_283_11 and arg_280_1.time_ < var_283_10 + var_283_11 + arg_283_0 and not isNil(var_283_9) and arg_280_1.var_.characterEffect10053ui_story then
				local var_283_14 = 0.5

				arg_280_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_280_1.var_.characterEffect10053ui_story.fillRatio = var_283_14
			end

			local var_283_15 = arg_280_1.actors_["1015ui_story"].transform
			local var_283_16 = 0

			if var_283_16 < arg_280_1.time_ and arg_280_1.time_ <= var_283_16 + arg_283_0 then
				arg_280_1.var_.moveOldPos1015ui_story = var_283_15.localPosition
			end

			local var_283_17 = 0.001

			if var_283_16 <= arg_280_1.time_ and arg_280_1.time_ < var_283_16 + var_283_17 then
				local var_283_18 = (arg_280_1.time_ - var_283_16) / var_283_17
				local var_283_19 = Vector3.New(0, -1.15, -6.2)

				var_283_15.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1015ui_story, var_283_19, var_283_18)

				local var_283_20 = manager.ui.mainCamera.transform.position - var_283_15.position

				var_283_15.forward = Vector3.New(var_283_20.x, var_283_20.y, var_283_20.z)

				local var_283_21 = var_283_15.localEulerAngles

				var_283_21.z = 0
				var_283_21.x = 0
				var_283_15.localEulerAngles = var_283_21
			end

			if arg_280_1.time_ >= var_283_16 + var_283_17 and arg_280_1.time_ < var_283_16 + var_283_17 + arg_283_0 then
				var_283_15.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_283_22 = manager.ui.mainCamera.transform.position - var_283_15.position

				var_283_15.forward = Vector3.New(var_283_22.x, var_283_22.y, var_283_22.z)

				local var_283_23 = var_283_15.localEulerAngles

				var_283_23.z = 0
				var_283_23.x = 0
				var_283_15.localEulerAngles = var_283_23
			end

			local var_283_24 = arg_280_1.actors_["1015ui_story"]
			local var_283_25 = 0

			if var_283_25 < arg_280_1.time_ and arg_280_1.time_ <= var_283_25 + arg_283_0 and not isNil(var_283_24) and arg_280_1.var_.characterEffect1015ui_story == nil then
				arg_280_1.var_.characterEffect1015ui_story = var_283_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_26 = 0.200000002980232

			if var_283_25 <= arg_280_1.time_ and arg_280_1.time_ < var_283_25 + var_283_26 and not isNil(var_283_24) then
				local var_283_27 = (arg_280_1.time_ - var_283_25) / var_283_26

				if arg_280_1.var_.characterEffect1015ui_story and not isNil(var_283_24) then
					arg_280_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= var_283_25 + var_283_26 and arg_280_1.time_ < var_283_25 + var_283_26 + arg_283_0 and not isNil(var_283_24) and arg_280_1.var_.characterEffect1015ui_story then
				arg_280_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_283_28 = 0

			if var_283_28 < arg_280_1.time_ and arg_280_1.time_ <= var_283_28 + arg_283_0 then
				arg_280_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_283_29 = 0

			if var_283_29 < arg_280_1.time_ and arg_280_1.time_ <= var_283_29 + arg_283_0 then
				arg_280_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_283_30 = 0
			local var_283_31 = 0.2

			if var_283_30 < arg_280_1.time_ and arg_280_1.time_ <= var_283_30 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_32 = arg_280_1:FormatText(StoryNameCfg[479].name)

				arg_280_1.leftNameTxt_.text = var_283_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_33 = arg_280_1:GetWordFromCfg(317321068)
				local var_283_34 = arg_280_1:FormatText(var_283_33.content)

				arg_280_1.text_.text = var_283_34

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_35 = 8
				local var_283_36 = utf8.len(var_283_34)
				local var_283_37 = var_283_35 <= 0 and var_283_31 or var_283_31 * (var_283_36 / var_283_35)

				if var_283_37 > 0 and var_283_31 < var_283_37 then
					arg_280_1.talkMaxDuration = var_283_37

					if var_283_37 + var_283_30 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_37 + var_283_30
					end
				end

				arg_280_1.text_.text = var_283_34
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321068", "story_v_out_317321.awb") ~= 0 then
					local var_283_38 = manager.audio:GetVoiceLength("story_v_out_317321", "317321068", "story_v_out_317321.awb") / 1000

					if var_283_38 + var_283_30 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_38 + var_283_30
					end

					if var_283_33.prefab_name ~= "" and arg_280_1.actors_[var_283_33.prefab_name] ~= nil then
						local var_283_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_33.prefab_name].transform, "story_v_out_317321", "317321068", "story_v_out_317321.awb")

						arg_280_1:RecordAudio("317321068", var_283_39)
						arg_280_1:RecordAudio("317321068", var_283_39)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_317321", "317321068", "story_v_out_317321.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_317321", "317321068", "story_v_out_317321.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_40 = math.max(var_283_31, arg_280_1.talkMaxDuration)

			if var_283_30 <= arg_280_1.time_ and arg_280_1.time_ < var_283_30 + var_283_40 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_30) / var_283_40

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_30 + var_283_40 and arg_280_1.time_ < var_283_30 + var_283_40 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play317321069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 317321069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play317321070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0
			local var_287_1 = 0.6

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				local var_287_2 = "play"
				local var_287_3 = "effect"

				arg_284_1:AudioAction(var_287_2, var_287_3, "se_story_127", "se_story_127_stone", "")
			end

			local var_287_4 = arg_284_1.actors_["1015ui_story"].transform
			local var_287_5 = 0

			if var_287_5 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1.var_.moveOldPos1015ui_story = var_287_4.localPosition
			end

			local var_287_6 = 0.001

			if var_287_5 <= arg_284_1.time_ and arg_284_1.time_ < var_287_5 + var_287_6 then
				local var_287_7 = (arg_284_1.time_ - var_287_5) / var_287_6
				local var_287_8 = Vector3.New(0, 100, 0)

				var_287_4.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1015ui_story, var_287_8, var_287_7)

				local var_287_9 = manager.ui.mainCamera.transform.position - var_287_4.position

				var_287_4.forward = Vector3.New(var_287_9.x, var_287_9.y, var_287_9.z)

				local var_287_10 = var_287_4.localEulerAngles

				var_287_10.z = 0
				var_287_10.x = 0
				var_287_4.localEulerAngles = var_287_10
			end

			if arg_284_1.time_ >= var_287_5 + var_287_6 and arg_284_1.time_ < var_287_5 + var_287_6 + arg_287_0 then
				var_287_4.localPosition = Vector3.New(0, 100, 0)

				local var_287_11 = manager.ui.mainCamera.transform.position - var_287_4.position

				var_287_4.forward = Vector3.New(var_287_11.x, var_287_11.y, var_287_11.z)

				local var_287_12 = var_287_4.localEulerAngles

				var_287_12.z = 0
				var_287_12.x = 0
				var_287_4.localEulerAngles = var_287_12
			end

			local var_287_13 = manager.ui.mainCamera.transform
			local var_287_14 = 0

			if var_287_14 < arg_284_1.time_ and arg_284_1.time_ <= var_287_14 + arg_287_0 then
				arg_284_1.var_.shakeOldPos = var_287_13.localPosition
			end

			local var_287_15 = 1

			if var_287_14 <= arg_284_1.time_ and arg_284_1.time_ < var_287_14 + var_287_15 then
				local var_287_16 = (arg_284_1.time_ - var_287_14) / 0.066
				local var_287_17, var_287_18 = math.modf(var_287_16)

				var_287_13.localPosition = Vector3.New(var_287_18 * 0.13, var_287_18 * 0.13, var_287_18 * 0.13) + arg_284_1.var_.shakeOldPos
			end

			if arg_284_1.time_ >= var_287_14 + var_287_15 and arg_284_1.time_ < var_287_14 + var_287_15 + arg_287_0 then
				var_287_13.localPosition = arg_284_1.var_.shakeOldPos
			end

			local var_287_19 = 0
			local var_287_20 = 1.925

			if var_287_19 < arg_284_1.time_ and arg_284_1.time_ <= var_287_19 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_21 = arg_284_1:GetWordFromCfg(317321069)
				local var_287_22 = arg_284_1:FormatText(var_287_21.content)

				arg_284_1.text_.text = var_287_22

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_23 = 77
				local var_287_24 = utf8.len(var_287_22)
				local var_287_25 = var_287_23 <= 0 and var_287_20 or var_287_20 * (var_287_24 / var_287_23)

				if var_287_25 > 0 and var_287_20 < var_287_25 then
					arg_284_1.talkMaxDuration = var_287_25

					if var_287_25 + var_287_19 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_25 + var_287_19
					end
				end

				arg_284_1.text_.text = var_287_22
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_26 = math.max(var_287_20, arg_284_1.talkMaxDuration)

			if var_287_19 <= arg_284_1.time_ and arg_284_1.time_ < var_287_19 + var_287_26 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_19) / var_287_26

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_19 + var_287_26 and arg_284_1.time_ < var_287_19 + var_287_26 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play317321070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 317321070
		arg_288_1.duration_ = 3.3

		local var_288_0 = {
			zh = 3.3,
			ja = 3.2
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play317321071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1015ui_story"].transform
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.var_.moveOldPos1015ui_story = var_291_0.localPosition
			end

			local var_291_2 = 0.001

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2
				local var_291_4 = Vector3.New(0, -1.15, -6.2)

				var_291_0.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1015ui_story, var_291_4, var_291_3)

				local var_291_5 = manager.ui.mainCamera.transform.position - var_291_0.position

				var_291_0.forward = Vector3.New(var_291_5.x, var_291_5.y, var_291_5.z)

				local var_291_6 = var_291_0.localEulerAngles

				var_291_6.z = 0
				var_291_6.x = 0
				var_291_0.localEulerAngles = var_291_6
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 then
				var_291_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_291_7 = manager.ui.mainCamera.transform.position - var_291_0.position

				var_291_0.forward = Vector3.New(var_291_7.x, var_291_7.y, var_291_7.z)

				local var_291_8 = var_291_0.localEulerAngles

				var_291_8.z = 0
				var_291_8.x = 0
				var_291_0.localEulerAngles = var_291_8
			end

			local var_291_9 = arg_288_1.actors_["1015ui_story"]
			local var_291_10 = 0

			if var_291_10 < arg_288_1.time_ and arg_288_1.time_ <= var_291_10 + arg_291_0 and not isNil(var_291_9) and arg_288_1.var_.characterEffect1015ui_story == nil then
				arg_288_1.var_.characterEffect1015ui_story = var_291_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_11 = 0.200000002980232

			if var_291_10 <= arg_288_1.time_ and arg_288_1.time_ < var_291_10 + var_291_11 and not isNil(var_291_9) then
				local var_291_12 = (arg_288_1.time_ - var_291_10) / var_291_11

				if arg_288_1.var_.characterEffect1015ui_story and not isNil(var_291_9) then
					arg_288_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_10 + var_291_11 and arg_288_1.time_ < var_291_10 + var_291_11 + arg_291_0 and not isNil(var_291_9) and arg_288_1.var_.characterEffect1015ui_story then
				arg_288_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_291_13 = 0

			if var_291_13 < arg_288_1.time_ and arg_288_1.time_ <= var_291_13 + arg_291_0 then
				arg_288_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_291_14 = 0

			if var_291_14 < arg_288_1.time_ and arg_288_1.time_ <= var_291_14 + arg_291_0 then
				arg_288_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_291_15 = 0
			local var_291_16 = 0.325

			if var_291_15 < arg_288_1.time_ and arg_288_1.time_ <= var_291_15 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_17 = arg_288_1:FormatText(StoryNameCfg[479].name)

				arg_288_1.leftNameTxt_.text = var_291_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_18 = arg_288_1:GetWordFromCfg(317321070)
				local var_291_19 = arg_288_1:FormatText(var_291_18.content)

				arg_288_1.text_.text = var_291_19

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_20 = 13
				local var_291_21 = utf8.len(var_291_19)
				local var_291_22 = var_291_20 <= 0 and var_291_16 or var_291_16 * (var_291_21 / var_291_20)

				if var_291_22 > 0 and var_291_16 < var_291_22 then
					arg_288_1.talkMaxDuration = var_291_22

					if var_291_22 + var_291_15 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_22 + var_291_15
					end
				end

				arg_288_1.text_.text = var_291_19
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321070", "story_v_out_317321.awb") ~= 0 then
					local var_291_23 = manager.audio:GetVoiceLength("story_v_out_317321", "317321070", "story_v_out_317321.awb") / 1000

					if var_291_23 + var_291_15 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_23 + var_291_15
					end

					if var_291_18.prefab_name ~= "" and arg_288_1.actors_[var_291_18.prefab_name] ~= nil then
						local var_291_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_18.prefab_name].transform, "story_v_out_317321", "317321070", "story_v_out_317321.awb")

						arg_288_1:RecordAudio("317321070", var_291_24)
						arg_288_1:RecordAudio("317321070", var_291_24)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_317321", "317321070", "story_v_out_317321.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_317321", "317321070", "story_v_out_317321.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_25 = math.max(var_291_16, arg_288_1.talkMaxDuration)

			if var_291_15 <= arg_288_1.time_ and arg_288_1.time_ < var_291_15 + var_291_25 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_15) / var_291_25

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_15 + var_291_25 and arg_288_1.time_ < var_291_15 + var_291_25 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play317321071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 317321071
		arg_292_1.duration_ = 4.97

		local var_292_0 = {
			zh = 2.6,
			ja = 4.966
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play317321072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0
			local var_295_1 = 0.225

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_2 = arg_292_1:FormatText(StoryNameCfg[479].name)

				arg_292_1.leftNameTxt_.text = var_295_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_3 = arg_292_1:GetWordFromCfg(317321071)
				local var_295_4 = arg_292_1:FormatText(var_295_3.content)

				arg_292_1.text_.text = var_295_4

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 9
				local var_295_6 = utf8.len(var_295_4)
				local var_295_7 = var_295_5 <= 0 and var_295_1 or var_295_1 * (var_295_6 / var_295_5)

				if var_295_7 > 0 and var_295_1 < var_295_7 then
					arg_292_1.talkMaxDuration = var_295_7

					if var_295_7 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_7 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_4
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321071", "story_v_out_317321.awb") ~= 0 then
					local var_295_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321071", "story_v_out_317321.awb") / 1000

					if var_295_8 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_8 + var_295_0
					end

					if var_295_3.prefab_name ~= "" and arg_292_1.actors_[var_295_3.prefab_name] ~= nil then
						local var_295_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_3.prefab_name].transform, "story_v_out_317321", "317321071", "story_v_out_317321.awb")

						arg_292_1:RecordAudio("317321071", var_295_9)
						arg_292_1:RecordAudio("317321071", var_295_9)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_317321", "317321071", "story_v_out_317321.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_317321", "317321071", "story_v_out_317321.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_10 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_10 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_10

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_10 and arg_292_1.time_ < var_295_0 + var_295_10 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play317321072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 317321072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play317321073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["1015ui_story"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect1015ui_story == nil then
				arg_296_1.var_.characterEffect1015ui_story = var_299_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.characterEffect1015ui_story and not isNil(var_299_0) then
					local var_299_4 = Mathf.Lerp(0, 0.5, var_299_3)

					arg_296_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1015ui_story.fillRatio = var_299_4
				end
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect1015ui_story then
				local var_299_5 = 0.5

				arg_296_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1015ui_story.fillRatio = var_299_5
			end

			local var_299_6 = 0
			local var_299_7 = 0.725

			if var_299_6 < arg_296_1.time_ and arg_296_1.time_ <= var_299_6 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_8 = arg_296_1:GetWordFromCfg(317321072)
				local var_299_9 = arg_296_1:FormatText(var_299_8.content)

				arg_296_1.text_.text = var_299_9

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_10 = 29
				local var_299_11 = utf8.len(var_299_9)
				local var_299_12 = var_299_10 <= 0 and var_299_7 or var_299_7 * (var_299_11 / var_299_10)

				if var_299_12 > 0 and var_299_7 < var_299_12 then
					arg_296_1.talkMaxDuration = var_299_12

					if var_299_12 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_12 + var_299_6
					end
				end

				arg_296_1.text_.text = var_299_9
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_13 = math.max(var_299_7, arg_296_1.talkMaxDuration)

			if var_299_6 <= arg_296_1.time_ and arg_296_1.time_ < var_299_6 + var_299_13 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_6) / var_299_13

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_6 + var_299_13 and arg_296_1.time_ < var_299_6 + var_299_13 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play317321073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 317321073
		arg_300_1.duration_ = 8.07

		local var_300_0 = {
			zh = 8.066,
			ja = 6.1
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play317321074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["1015ui_story"].transform
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.var_.moveOldPos1015ui_story = var_303_0.localPosition
			end

			local var_303_2 = 0.001

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2
				local var_303_4 = Vector3.New(0, -1.15, -6.2)

				var_303_0.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1015ui_story, var_303_4, var_303_3)

				local var_303_5 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_5.x, var_303_5.y, var_303_5.z)

				local var_303_6 = var_303_0.localEulerAngles

				var_303_6.z = 0
				var_303_6.x = 0
				var_303_0.localEulerAngles = var_303_6
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 then
				var_303_0.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_303_7 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_7.x, var_303_7.y, var_303_7.z)

				local var_303_8 = var_303_0.localEulerAngles

				var_303_8.z = 0
				var_303_8.x = 0
				var_303_0.localEulerAngles = var_303_8
			end

			local var_303_9 = arg_300_1.actors_["1015ui_story"]
			local var_303_10 = 0

			if var_303_10 < arg_300_1.time_ and arg_300_1.time_ <= var_303_10 + arg_303_0 and not isNil(var_303_9) and arg_300_1.var_.characterEffect1015ui_story == nil then
				arg_300_1.var_.characterEffect1015ui_story = var_303_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_11 = 0.200000002980232

			if var_303_10 <= arg_300_1.time_ and arg_300_1.time_ < var_303_10 + var_303_11 and not isNil(var_303_9) then
				local var_303_12 = (arg_300_1.time_ - var_303_10) / var_303_11

				if arg_300_1.var_.characterEffect1015ui_story and not isNil(var_303_9) then
					arg_300_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_10 + var_303_11 and arg_300_1.time_ < var_303_10 + var_303_11 + arg_303_0 and not isNil(var_303_9) and arg_300_1.var_.characterEffect1015ui_story then
				arg_300_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_303_13 = 0

			if var_303_13 < arg_300_1.time_ and arg_300_1.time_ <= var_303_13 + arg_303_0 then
				arg_300_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_303_14 = 0
			local var_303_15 = 0.5

			if var_303_14 < arg_300_1.time_ and arg_300_1.time_ <= var_303_14 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_16 = arg_300_1:FormatText(StoryNameCfg[479].name)

				arg_300_1.leftNameTxt_.text = var_303_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_17 = arg_300_1:GetWordFromCfg(317321073)
				local var_303_18 = arg_300_1:FormatText(var_303_17.content)

				arg_300_1.text_.text = var_303_18

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_19 = 20
				local var_303_20 = utf8.len(var_303_18)
				local var_303_21 = var_303_19 <= 0 and var_303_15 or var_303_15 * (var_303_20 / var_303_19)

				if var_303_21 > 0 and var_303_15 < var_303_21 then
					arg_300_1.talkMaxDuration = var_303_21

					if var_303_21 + var_303_14 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_21 + var_303_14
					end
				end

				arg_300_1.text_.text = var_303_18
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321073", "story_v_out_317321.awb") ~= 0 then
					local var_303_22 = manager.audio:GetVoiceLength("story_v_out_317321", "317321073", "story_v_out_317321.awb") / 1000

					if var_303_22 + var_303_14 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_22 + var_303_14
					end

					if var_303_17.prefab_name ~= "" and arg_300_1.actors_[var_303_17.prefab_name] ~= nil then
						local var_303_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_17.prefab_name].transform, "story_v_out_317321", "317321073", "story_v_out_317321.awb")

						arg_300_1:RecordAudio("317321073", var_303_23)
						arg_300_1:RecordAudio("317321073", var_303_23)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_317321", "317321073", "story_v_out_317321.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_317321", "317321073", "story_v_out_317321.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_24 = math.max(var_303_15, arg_300_1.talkMaxDuration)

			if var_303_14 <= arg_300_1.time_ and arg_300_1.time_ < var_303_14 + var_303_24 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_14) / var_303_24

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_14 + var_303_24 and arg_300_1.time_ < var_303_14 + var_303_24 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play317321074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 317321074
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play317321075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1015ui_story"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1015ui_story == nil then
				arg_304_1.var_.characterEffect1015ui_story = var_307_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.characterEffect1015ui_story and not isNil(var_307_0) then
					local var_307_4 = Mathf.Lerp(0, 0.5, var_307_3)

					arg_304_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1015ui_story.fillRatio = var_307_4
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1015ui_story then
				local var_307_5 = 0.5

				arg_304_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1015ui_story.fillRatio = var_307_5
			end

			local var_307_6 = 0
			local var_307_7 = 0.525

			if var_307_6 < arg_304_1.time_ and arg_304_1.time_ <= var_307_6 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_8 = arg_304_1:GetWordFromCfg(317321074)
				local var_307_9 = arg_304_1:FormatText(var_307_8.content)

				arg_304_1.text_.text = var_307_9

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_10 = 21
				local var_307_11 = utf8.len(var_307_9)
				local var_307_12 = var_307_10 <= 0 and var_307_7 or var_307_7 * (var_307_11 / var_307_10)

				if var_307_12 > 0 and var_307_7 < var_307_12 then
					arg_304_1.talkMaxDuration = var_307_12

					if var_307_12 + var_307_6 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_12 + var_307_6
					end
				end

				arg_304_1.text_.text = var_307_9
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_13 = math.max(var_307_7, arg_304_1.talkMaxDuration)

			if var_307_6 <= arg_304_1.time_ and arg_304_1.time_ < var_307_6 + var_307_13 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_6) / var_307_13

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_6 + var_307_13 and arg_304_1.time_ < var_307_6 + var_307_13 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play317321075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 317321075
		arg_308_1.duration_ = 4.23

		local var_308_0 = {
			zh = 4.233,
			ja = 0.999999999999
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play317321076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1015ui_story"].transform
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.var_.moveOldPos1015ui_story = var_311_0.localPosition
			end

			local var_311_2 = 0.001

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2
				local var_311_4 = Vector3.New(0, 100, 0)

				var_311_0.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1015ui_story, var_311_4, var_311_3)

				local var_311_5 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_5.x, var_311_5.y, var_311_5.z)

				local var_311_6 = var_311_0.localEulerAngles

				var_311_6.z = 0
				var_311_6.x = 0
				var_311_0.localEulerAngles = var_311_6
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 then
				var_311_0.localPosition = Vector3.New(0, 100, 0)

				local var_311_7 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_7.x, var_311_7.y, var_311_7.z)

				local var_311_8 = var_311_0.localEulerAngles

				var_311_8.z = 0
				var_311_8.x = 0
				var_311_0.localEulerAngles = var_311_8
			end

			local var_311_9 = arg_308_1.actors_["1015ui_story"]
			local var_311_10 = 0

			if var_311_10 < arg_308_1.time_ and arg_308_1.time_ <= var_311_10 + arg_311_0 and not isNil(var_311_9) and arg_308_1.var_.characterEffect1015ui_story == nil then
				arg_308_1.var_.characterEffect1015ui_story = var_311_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_11 = 0.200000002980232

			if var_311_10 <= arg_308_1.time_ and arg_308_1.time_ < var_311_10 + var_311_11 and not isNil(var_311_9) then
				local var_311_12 = (arg_308_1.time_ - var_311_10) / var_311_11

				if arg_308_1.var_.characterEffect1015ui_story and not isNil(var_311_9) then
					local var_311_13 = Mathf.Lerp(0, 0.5, var_311_12)

					arg_308_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1015ui_story.fillRatio = var_311_13
				end
			end

			if arg_308_1.time_ >= var_311_10 + var_311_11 and arg_308_1.time_ < var_311_10 + var_311_11 + arg_311_0 and not isNil(var_311_9) and arg_308_1.var_.characterEffect1015ui_story then
				local var_311_14 = 0.5

				arg_308_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1015ui_story.fillRatio = var_311_14
			end

			local var_311_15 = arg_308_1.actors_["10053ui_story"].transform
			local var_311_16 = 0

			if var_311_16 < arg_308_1.time_ and arg_308_1.time_ <= var_311_16 + arg_311_0 then
				arg_308_1.var_.moveOldPos10053ui_story = var_311_15.localPosition
			end

			local var_311_17 = 0.001

			if var_311_16 <= arg_308_1.time_ and arg_308_1.time_ < var_311_16 + var_311_17 then
				local var_311_18 = (arg_308_1.time_ - var_311_16) / var_311_17
				local var_311_19 = Vector3.New(0, -1.12, -5.99)

				var_311_15.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10053ui_story, var_311_19, var_311_18)

				local var_311_20 = manager.ui.mainCamera.transform.position - var_311_15.position

				var_311_15.forward = Vector3.New(var_311_20.x, var_311_20.y, var_311_20.z)

				local var_311_21 = var_311_15.localEulerAngles

				var_311_21.z = 0
				var_311_21.x = 0
				var_311_15.localEulerAngles = var_311_21
			end

			if arg_308_1.time_ >= var_311_16 + var_311_17 and arg_308_1.time_ < var_311_16 + var_311_17 + arg_311_0 then
				var_311_15.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_311_22 = manager.ui.mainCamera.transform.position - var_311_15.position

				var_311_15.forward = Vector3.New(var_311_22.x, var_311_22.y, var_311_22.z)

				local var_311_23 = var_311_15.localEulerAngles

				var_311_23.z = 0
				var_311_23.x = 0
				var_311_15.localEulerAngles = var_311_23
			end

			local var_311_24 = arg_308_1.actors_["10053ui_story"]
			local var_311_25 = 0

			if var_311_25 < arg_308_1.time_ and arg_308_1.time_ <= var_311_25 + arg_311_0 and not isNil(var_311_24) and arg_308_1.var_.characterEffect10053ui_story == nil then
				arg_308_1.var_.characterEffect10053ui_story = var_311_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_26 = 0.200000002980232

			if var_311_25 <= arg_308_1.time_ and arg_308_1.time_ < var_311_25 + var_311_26 and not isNil(var_311_24) then
				local var_311_27 = (arg_308_1.time_ - var_311_25) / var_311_26

				if arg_308_1.var_.characterEffect10053ui_story and not isNil(var_311_24) then
					arg_308_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= var_311_25 + var_311_26 and arg_308_1.time_ < var_311_25 + var_311_26 + arg_311_0 and not isNil(var_311_24) and arg_308_1.var_.characterEffect10053ui_story then
				arg_308_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_311_28 = 0

			if var_311_28 < arg_308_1.time_ and arg_308_1.time_ <= var_311_28 + arg_311_0 then
				arg_308_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_311_29 = 0

			if var_311_29 < arg_308_1.time_ and arg_308_1.time_ <= var_311_29 + arg_311_0 then
				arg_308_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_311_30 = 0
			local var_311_31 = 0.1

			if var_311_30 < arg_308_1.time_ and arg_308_1.time_ <= var_311_30 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_32 = arg_308_1:FormatText(StoryNameCfg[477].name)

				arg_308_1.leftNameTxt_.text = var_311_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_33 = arg_308_1:GetWordFromCfg(317321075)
				local var_311_34 = arg_308_1:FormatText(var_311_33.content)

				arg_308_1.text_.text = var_311_34

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_35 = 4
				local var_311_36 = utf8.len(var_311_34)
				local var_311_37 = var_311_35 <= 0 and var_311_31 or var_311_31 * (var_311_36 / var_311_35)

				if var_311_37 > 0 and var_311_31 < var_311_37 then
					arg_308_1.talkMaxDuration = var_311_37

					if var_311_37 + var_311_30 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_37 + var_311_30
					end
				end

				arg_308_1.text_.text = var_311_34
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321075", "story_v_out_317321.awb") ~= 0 then
					local var_311_38 = manager.audio:GetVoiceLength("story_v_out_317321", "317321075", "story_v_out_317321.awb") / 1000

					if var_311_38 + var_311_30 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_38 + var_311_30
					end

					if var_311_33.prefab_name ~= "" and arg_308_1.actors_[var_311_33.prefab_name] ~= nil then
						local var_311_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_33.prefab_name].transform, "story_v_out_317321", "317321075", "story_v_out_317321.awb")

						arg_308_1:RecordAudio("317321075", var_311_39)
						arg_308_1:RecordAudio("317321075", var_311_39)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_317321", "317321075", "story_v_out_317321.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_317321", "317321075", "story_v_out_317321.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_40 = math.max(var_311_31, arg_308_1.talkMaxDuration)

			if var_311_30 <= arg_308_1.time_ and arg_308_1.time_ < var_311_30 + var_311_40 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_30) / var_311_40

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_30 + var_311_40 and arg_308_1.time_ < var_311_30 + var_311_40 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play317321076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 317321076
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play317321077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["10053ui_story"].transform
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.var_.moveOldPos10053ui_story = var_315_0.localPosition
			end

			local var_315_2 = 0.001

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2
				local var_315_4 = Vector3.New(0, 100, 0)

				var_315_0.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10053ui_story, var_315_4, var_315_3)

				local var_315_5 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_5.x, var_315_5.y, var_315_5.z)

				local var_315_6 = var_315_0.localEulerAngles

				var_315_6.z = 0
				var_315_6.x = 0
				var_315_0.localEulerAngles = var_315_6
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 then
				var_315_0.localPosition = Vector3.New(0, 100, 0)

				local var_315_7 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_7.x, var_315_7.y, var_315_7.z)

				local var_315_8 = var_315_0.localEulerAngles

				var_315_8.z = 0
				var_315_8.x = 0
				var_315_0.localEulerAngles = var_315_8
			end

			local var_315_9 = arg_312_1.actors_["10053ui_story"]
			local var_315_10 = 0

			if var_315_10 < arg_312_1.time_ and arg_312_1.time_ <= var_315_10 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect10053ui_story == nil then
				arg_312_1.var_.characterEffect10053ui_story = var_315_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_11 = 0.200000002980232

			if var_315_10 <= arg_312_1.time_ and arg_312_1.time_ < var_315_10 + var_315_11 and not isNil(var_315_9) then
				local var_315_12 = (arg_312_1.time_ - var_315_10) / var_315_11

				if arg_312_1.var_.characterEffect10053ui_story and not isNil(var_315_9) then
					local var_315_13 = Mathf.Lerp(0, 0.5, var_315_12)

					arg_312_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_312_1.var_.characterEffect10053ui_story.fillRatio = var_315_13
				end
			end

			if arg_312_1.time_ >= var_315_10 + var_315_11 and arg_312_1.time_ < var_315_10 + var_315_11 + arg_315_0 and not isNil(var_315_9) and arg_312_1.var_.characterEffect10053ui_story then
				local var_315_14 = 0.5

				arg_312_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_312_1.var_.characterEffect10053ui_story.fillRatio = var_315_14
			end

			local var_315_15 = 0
			local var_315_16 = 1.625

			if var_315_15 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_17 = arg_312_1:GetWordFromCfg(317321076)
				local var_315_18 = arg_312_1:FormatText(var_315_17.content)

				arg_312_1.text_.text = var_315_18

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_19 = 65
				local var_315_20 = utf8.len(var_315_18)
				local var_315_21 = var_315_19 <= 0 and var_315_16 or var_315_16 * (var_315_20 / var_315_19)

				if var_315_21 > 0 and var_315_16 < var_315_21 then
					arg_312_1.talkMaxDuration = var_315_21

					if var_315_21 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_21 + var_315_15
					end
				end

				arg_312_1.text_.text = var_315_18
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_22 = math.max(var_315_16, arg_312_1.talkMaxDuration)

			if var_315_15 <= arg_312_1.time_ and arg_312_1.time_ < var_315_15 + var_315_22 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_15) / var_315_22

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_15 + var_315_22 and arg_312_1.time_ < var_315_15 + var_315_22 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play317321077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 317321077
		arg_316_1.duration_ = 7

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play317321078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = "S0012"

			if arg_316_1.bgs_[var_319_0] == nil then
				local var_319_1 = Object.Instantiate(arg_316_1.paintGo_)

				var_319_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_319_0)
				var_319_1.name = var_319_0
				var_319_1.transform.parent = arg_316_1.stage_.transform
				var_319_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_316_1.bgs_[var_319_0] = var_319_1
			end

			local var_319_2 = 0

			if var_319_2 < arg_316_1.time_ and arg_316_1.time_ <= var_319_2 + arg_319_0 then
				local var_319_3 = manager.ui.mainCamera.transform.localPosition
				local var_319_4 = Vector3.New(0, 0, 10) + Vector3.New(var_319_3.x, var_319_3.y, 0)
				local var_319_5 = arg_316_1.bgs_.S0012

				var_319_5.transform.localPosition = var_319_4
				var_319_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_319_6 = var_319_5:GetComponent("SpriteRenderer")

				if var_319_6 and var_319_6.sprite then
					local var_319_7 = (var_319_5.transform.localPosition - var_319_3).z
					local var_319_8 = manager.ui.mainCameraCom_
					local var_319_9 = 2 * var_319_7 * Mathf.Tan(var_319_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_319_10 = var_319_9 * var_319_8.aspect
					local var_319_11 = var_319_6.sprite.bounds.size.x
					local var_319_12 = var_319_6.sprite.bounds.size.y
					local var_319_13 = var_319_10 / var_319_11
					local var_319_14 = var_319_9 / var_319_12
					local var_319_15 = var_319_14 < var_319_13 and var_319_13 or var_319_14

					var_319_5.transform.localScale = Vector3.New(var_319_15, var_319_15, 0)
				end

				for iter_319_0, iter_319_1 in pairs(arg_316_1.bgs_) do
					if iter_319_0 ~= "S0012" then
						iter_319_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_319_16 = 0

			if var_319_16 < arg_316_1.time_ and arg_316_1.time_ <= var_319_16 + arg_319_0 then
				arg_316_1.mask_.enabled = true
				arg_316_1.mask_.raycastTarget = true

				arg_316_1:SetGaussion(false)
			end

			local var_319_17 = 2

			if var_319_16 <= arg_316_1.time_ and arg_316_1.time_ < var_319_16 + var_319_17 then
				local var_319_18 = (arg_316_1.time_ - var_319_16) / var_319_17
				local var_319_19 = Color.New(0, 0, 0)

				var_319_19.a = Mathf.Lerp(1, 0, var_319_18)
				arg_316_1.mask_.color = var_319_19
			end

			if arg_316_1.time_ >= var_319_16 + var_319_17 and arg_316_1.time_ < var_319_16 + var_319_17 + arg_319_0 then
				local var_319_20 = Color.New(0, 0, 0)
				local var_319_21 = 0

				arg_316_1.mask_.enabled = false
				var_319_20.a = var_319_21
				arg_316_1.mask_.color = var_319_20
			end

			if arg_316_1.frameCnt_ <= 1 then
				arg_316_1.dialog_:SetActive(false)
			end

			local var_319_22 = 2
			local var_319_23 = 0.9

			if var_319_22 < arg_316_1.time_ and arg_316_1.time_ <= var_319_22 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0

				arg_316_1.dialog_:SetActive(true)

				arg_316_1.dialogCg_.alpha = 0

				local var_319_24 = LeanTween.value(arg_316_1.dialog_, 0, 1, 0.3)

				var_319_24:setOnUpdate(LuaHelper.FloatAction(function(arg_320_0)
					arg_316_1.dialogCg_.alpha = arg_320_0
				end))
				var_319_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_316_1.dialog_)
					var_319_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_316_1.duration_ = arg_316_1.duration_ + 0.3

				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_25 = arg_316_1:GetWordFromCfg(317321077)
				local var_319_26 = arg_316_1:FormatText(var_319_25.content)

				arg_316_1.text_.text = var_319_26

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_27 = 36
				local var_319_28 = utf8.len(var_319_26)
				local var_319_29 = var_319_27 <= 0 and var_319_23 or var_319_23 * (var_319_28 / var_319_27)

				if var_319_29 > 0 and var_319_23 < var_319_29 then
					arg_316_1.talkMaxDuration = var_319_29
					var_319_22 = var_319_22 + 0.3

					if var_319_29 + var_319_22 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_29 + var_319_22
					end
				end

				arg_316_1.text_.text = var_319_26
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_30 = var_319_22 + 0.3
			local var_319_31 = math.max(var_319_23, arg_316_1.talkMaxDuration)

			if var_319_30 <= arg_316_1.time_ and arg_316_1.time_ < var_319_30 + var_319_31 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_30) / var_319_31

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_30 + var_319_31 and arg_316_1.time_ < var_319_30 + var_319_31 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play317321078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 317321078
		arg_322_1.duration_ = 4.8

		local var_322_0 = {
			zh = 4.8,
			ja = 3.533
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play317321079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 0.6

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_2 = arg_322_1:FormatText(StoryNameCfg[479].name)

				arg_322_1.leftNameTxt_.text = var_325_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_3 = arg_322_1:GetWordFromCfg(317321078)
				local var_325_4 = arg_322_1:FormatText(var_325_3.content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 24
				local var_325_6 = utf8.len(var_325_4)
				local var_325_7 = var_325_5 <= 0 and var_325_1 or var_325_1 * (var_325_6 / var_325_5)

				if var_325_7 > 0 and var_325_1 < var_325_7 then
					arg_322_1.talkMaxDuration = var_325_7

					if var_325_7 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_7 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_4
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321078", "story_v_out_317321.awb") ~= 0 then
					local var_325_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321078", "story_v_out_317321.awb") / 1000

					if var_325_8 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_8 + var_325_0
					end

					if var_325_3.prefab_name ~= "" and arg_322_1.actors_[var_325_3.prefab_name] ~= nil then
						local var_325_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_3.prefab_name].transform, "story_v_out_317321", "317321078", "story_v_out_317321.awb")

						arg_322_1:RecordAudio("317321078", var_325_9)
						arg_322_1:RecordAudio("317321078", var_325_9)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_317321", "317321078", "story_v_out_317321.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_317321", "317321078", "story_v_out_317321.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_10 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_10

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_10 and arg_322_1.time_ < var_325_0 + var_325_10 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play317321079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 317321079
		arg_326_1.duration_ = 2.47

		local var_326_0 = {
			zh = 1.7,
			ja = 2.466
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play317321080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.2

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[479].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_3 = arg_326_1:GetWordFromCfg(317321079)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 8
				local var_329_6 = utf8.len(var_329_4)
				local var_329_7 = var_329_5 <= 0 and var_329_1 or var_329_1 * (var_329_6 / var_329_5)

				if var_329_7 > 0 and var_329_1 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321079", "story_v_out_317321.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321079", "story_v_out_317321.awb") / 1000

					if var_329_8 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_0
					end

					if var_329_3.prefab_name ~= "" and arg_326_1.actors_[var_329_3.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_3.prefab_name].transform, "story_v_out_317321", "317321079", "story_v_out_317321.awb")

						arg_326_1:RecordAudio("317321079", var_329_9)
						arg_326_1:RecordAudio("317321079", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_317321", "317321079", "story_v_out_317321.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_317321", "317321079", "story_v_out_317321.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_10 and arg_326_1.time_ < var_329_0 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play317321080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 317321080
		arg_330_1.duration_ = 8.3

		local var_330_0 = {
			zh = 6.5,
			ja = 8.3
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play317321081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.6

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_2 = arg_330_1:FormatText(StoryNameCfg[479].name)

				arg_330_1.leftNameTxt_.text = var_333_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_3 = arg_330_1:GetWordFromCfg(317321080)
				local var_333_4 = arg_330_1:FormatText(var_333_3.content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321080", "story_v_out_317321.awb") ~= 0 then
					local var_333_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321080", "story_v_out_317321.awb") / 1000

					if var_333_8 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_8 + var_333_0
					end

					if var_333_3.prefab_name ~= "" and arg_330_1.actors_[var_333_3.prefab_name] ~= nil then
						local var_333_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_3.prefab_name].transform, "story_v_out_317321", "317321080", "story_v_out_317321.awb")

						arg_330_1:RecordAudio("317321080", var_333_9)
						arg_330_1:RecordAudio("317321080", var_333_9)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_317321", "317321080", "story_v_out_317321.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_317321", "317321080", "story_v_out_317321.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_10 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_10

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_10 and arg_330_1.time_ < var_333_0 + var_333_10 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play317321081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 317321081
		arg_334_1.duration_ = 11.23

		local var_334_0 = {
			zh = 11.233,
			ja = 11.066
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
				arg_334_0:Play317321082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 1.075

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_2 = arg_334_1:FormatText(StoryNameCfg[479].name)

				arg_334_1.leftNameTxt_.text = var_337_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:GetWordFromCfg(317321081)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 43
				local var_337_6 = utf8.len(var_337_4)
				local var_337_7 = var_337_5 <= 0 and var_337_1 or var_337_1 * (var_337_6 / var_337_5)

				if var_337_7 > 0 and var_337_1 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7

					if var_337_7 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321081", "story_v_out_317321.awb") ~= 0 then
					local var_337_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321081", "story_v_out_317321.awb") / 1000

					if var_337_8 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_8 + var_337_0
					end

					if var_337_3.prefab_name ~= "" and arg_334_1.actors_[var_337_3.prefab_name] ~= nil then
						local var_337_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_3.prefab_name].transform, "story_v_out_317321", "317321081", "story_v_out_317321.awb")

						arg_334_1:RecordAudio("317321081", var_337_9)
						arg_334_1:RecordAudio("317321081", var_337_9)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_317321", "317321081", "story_v_out_317321.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_317321", "317321081", "story_v_out_317321.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_10 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_10 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_10

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_10 and arg_334_1.time_ < var_337_0 + var_337_10 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play317321082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 317321082
		arg_338_1.duration_ = 9.43

		local var_338_0 = {
			zh = 6.533,
			ja = 9.433
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play317321083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0
			local var_341_1 = 0.6

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				local var_341_2 = "play"
				local var_341_3 = "music"

				arg_338_1:AudioAction(var_341_2, var_341_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_341_4 = ""
				local var_341_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_341_5 ~= "" then
					if arg_338_1.bgmTxt_.text ~= var_341_5 and arg_338_1.bgmTxt_.text ~= "" then
						if arg_338_1.bgmTxt2_.text ~= "" then
							arg_338_1.bgmTxt_.text = arg_338_1.bgmTxt2_.text
						end

						arg_338_1.bgmTxt2_.text = var_341_5

						arg_338_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_338_1.bgmTxt_.text = var_341_5
						arg_338_1.bgmTxt2_.text = var_341_5
					end

					if arg_338_1.bgmTimer then
						arg_338_1.bgmTimer:Stop()

						arg_338_1.bgmTimer = nil
					end

					if arg_338_1.settingData.show_music_name == 1 then
						arg_338_1.musicController:SetSelectedState("show")
						arg_338_1.musicAnimator_:Play("open", 0, 0)

						if arg_338_1.settingData.music_time ~= 0 then
							arg_338_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_338_1.settingData.music_time), function()
								if arg_338_1 == nil or isNil(arg_338_1.bgmTxt_) then
									return
								end

								arg_338_1.musicController:SetSelectedState("hide")
								arg_338_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_341_6 = 0
			local var_341_7 = 0.5

			if var_341_6 < arg_338_1.time_ and arg_338_1.time_ <= var_341_6 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_8 = arg_338_1:FormatText(StoryNameCfg[479].name)

				arg_338_1.leftNameTxt_.text = var_341_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_9 = arg_338_1:GetWordFromCfg(317321082)
				local var_341_10 = arg_338_1:FormatText(var_341_9.content)

				arg_338_1.text_.text = var_341_10

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_11 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321082", "story_v_out_317321.awb") ~= 0 then
					local var_341_14 = manager.audio:GetVoiceLength("story_v_out_317321", "317321082", "story_v_out_317321.awb") / 1000

					if var_341_14 + var_341_6 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_14 + var_341_6
					end

					if var_341_9.prefab_name ~= "" and arg_338_1.actors_[var_341_9.prefab_name] ~= nil then
						local var_341_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_9.prefab_name].transform, "story_v_out_317321", "317321082", "story_v_out_317321.awb")

						arg_338_1:RecordAudio("317321082", var_341_15)
						arg_338_1:RecordAudio("317321082", var_341_15)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_317321", "317321082", "story_v_out_317321.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_317321", "317321082", "story_v_out_317321.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_16 = math.max(var_341_7, arg_338_1.talkMaxDuration)

			if var_341_6 <= arg_338_1.time_ and arg_338_1.time_ < var_341_6 + var_341_16 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_6) / var_341_16

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_6 + var_341_16 and arg_338_1.time_ < var_341_6 + var_341_16 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play317321083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 317321083
		arg_343_1.duration_ = 7

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play317321084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = "ST12"

			if arg_343_1.bgs_[var_346_0] == nil then
				local var_346_1 = Object.Instantiate(arg_343_1.paintGo_)

				var_346_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_346_0)
				var_346_1.name = var_346_0
				var_346_1.transform.parent = arg_343_1.stage_.transform
				var_346_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.bgs_[var_346_0] = var_346_1
			end

			local var_346_2 = 0

			if var_346_2 < arg_343_1.time_ and arg_343_1.time_ <= var_346_2 + arg_346_0 then
				local var_346_3 = manager.ui.mainCamera.transform.localPosition
				local var_346_4 = Vector3.New(0, 0, 10) + Vector3.New(var_346_3.x, var_346_3.y, 0)
				local var_346_5 = arg_343_1.bgs_.ST12

				var_346_5.transform.localPosition = var_346_4
				var_346_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_346_6 = var_346_5:GetComponent("SpriteRenderer")

				if var_346_6 and var_346_6.sprite then
					local var_346_7 = (var_346_5.transform.localPosition - var_346_3).z
					local var_346_8 = manager.ui.mainCameraCom_
					local var_346_9 = 2 * var_346_7 * Mathf.Tan(var_346_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_346_10 = var_346_9 * var_346_8.aspect
					local var_346_11 = var_346_6.sprite.bounds.size.x
					local var_346_12 = var_346_6.sprite.bounds.size.y
					local var_346_13 = var_346_10 / var_346_11
					local var_346_14 = var_346_9 / var_346_12
					local var_346_15 = var_346_14 < var_346_13 and var_346_13 or var_346_14

					var_346_5.transform.localScale = Vector3.New(var_346_15, var_346_15, 0)
				end

				for iter_346_0, iter_346_1 in pairs(arg_343_1.bgs_) do
					if iter_346_0 ~= "ST12" then
						iter_346_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_346_16 = 0

			if var_346_16 < arg_343_1.time_ and arg_343_1.time_ <= var_346_16 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_17 = 2

			if var_346_16 <= arg_343_1.time_ and arg_343_1.time_ < var_346_16 + var_346_17 then
				local var_346_18 = (arg_343_1.time_ - var_346_16) / var_346_17
				local var_346_19 = Color.New(0, 0, 0)

				var_346_19.a = Mathf.Lerp(1, 0, var_346_18)
				arg_343_1.mask_.color = var_346_19
			end

			if arg_343_1.time_ >= var_346_16 + var_346_17 and arg_343_1.time_ < var_346_16 + var_346_17 + arg_346_0 then
				local var_346_20 = Color.New(0, 0, 0)
				local var_346_21 = 0

				arg_343_1.mask_.enabled = false
				var_346_20.a = var_346_21
				arg_343_1.mask_.color = var_346_20
			end

			local var_346_22 = 0
			local var_346_23 = 0.6

			if var_346_22 < arg_343_1.time_ and arg_343_1.time_ <= var_346_22 + arg_346_0 then
				local var_346_24 = "play"
				local var_346_25 = "music"

				arg_343_1:AudioAction(var_346_24, var_346_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_346_26 = ""
				local var_346_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_346_27 ~= "" then
					if arg_343_1.bgmTxt_.text ~= var_346_27 and arg_343_1.bgmTxt_.text ~= "" then
						if arg_343_1.bgmTxt2_.text ~= "" then
							arg_343_1.bgmTxt_.text = arg_343_1.bgmTxt2_.text
						end

						arg_343_1.bgmTxt2_.text = var_346_27

						arg_343_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_343_1.bgmTxt_.text = var_346_27
						arg_343_1.bgmTxt2_.text = var_346_27
					end

					if arg_343_1.bgmTimer then
						arg_343_1.bgmTimer:Stop()

						arg_343_1.bgmTimer = nil
					end

					if arg_343_1.settingData.show_music_name == 1 then
						arg_343_1.musicController:SetSelectedState("show")
						arg_343_1.musicAnimator_:Play("open", 0, 0)

						if arg_343_1.settingData.music_time ~= 0 then
							arg_343_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_343_1.settingData.music_time), function()
								if arg_343_1 == nil or isNil(arg_343_1.bgmTxt_) then
									return
								end

								arg_343_1.musicController:SetSelectedState("hide")
								arg_343_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_346_28 = 0.733333333333333
			local var_346_29 = 1

			if var_346_28 < arg_343_1.time_ and arg_343_1.time_ <= var_346_28 + arg_346_0 then
				local var_346_30 = "play"
				local var_346_31 = "music"

				arg_343_1:AudioAction(var_346_30, var_346_31, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_346_32 = ""
				local var_346_33 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_346_33 ~= "" then
					if arg_343_1.bgmTxt_.text ~= var_346_33 and arg_343_1.bgmTxt_.text ~= "" then
						if arg_343_1.bgmTxt2_.text ~= "" then
							arg_343_1.bgmTxt_.text = arg_343_1.bgmTxt2_.text
						end

						arg_343_1.bgmTxt2_.text = var_346_33

						arg_343_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_343_1.bgmTxt_.text = var_346_33
						arg_343_1.bgmTxt2_.text = var_346_33
					end

					if arg_343_1.bgmTimer then
						arg_343_1.bgmTimer:Stop()

						arg_343_1.bgmTimer = nil
					end

					if arg_343_1.settingData.show_music_name == 1 then
						arg_343_1.musicController:SetSelectedState("show")
						arg_343_1.musicAnimator_:Play("open", 0, 0)

						if arg_343_1.settingData.music_time ~= 0 then
							arg_343_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_343_1.settingData.music_time), function()
								if arg_343_1 == nil or isNil(arg_343_1.bgmTxt_) then
									return
								end

								arg_343_1.musicController:SetSelectedState("hide")
								arg_343_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_343_1.frameCnt_ <= 1 then
				arg_343_1.dialog_:SetActive(false)
			end

			local var_346_34 = 2
			local var_346_35 = 1.125

			if var_346_34 < arg_343_1.time_ and arg_343_1.time_ <= var_346_34 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				arg_343_1.dialog_:SetActive(true)

				arg_343_1.dialogCg_.alpha = 0

				local var_346_36 = LeanTween.value(arg_343_1.dialog_, 0, 1, 0.3)

				var_346_36:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_343_1.dialogCg_.alpha = arg_349_0
				end))
				var_346_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_343_1.dialog_)
					var_346_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_343_1.duration_ = arg_343_1.duration_ + 0.3

				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_37 = arg_343_1:GetWordFromCfg(317321083)
				local var_346_38 = arg_343_1:FormatText(var_346_37.content)

				arg_343_1.text_.text = var_346_38

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_39 = 45
				local var_346_40 = utf8.len(var_346_38)
				local var_346_41 = var_346_39 <= 0 and var_346_35 or var_346_35 * (var_346_40 / var_346_39)

				if var_346_41 > 0 and var_346_35 < var_346_41 then
					arg_343_1.talkMaxDuration = var_346_41
					var_346_34 = var_346_34 + 0.3

					if var_346_41 + var_346_34 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_41 + var_346_34
					end
				end

				arg_343_1.text_.text = var_346_38
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_42 = var_346_34 + 0.3
			local var_346_43 = math.max(var_346_35, arg_343_1.talkMaxDuration)

			if var_346_42 <= arg_343_1.time_ and arg_343_1.time_ < var_346_42 + var_346_43 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_42) / var_346_43

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_42 + var_346_43 and arg_343_1.time_ < var_346_42 + var_346_43 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play317321084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 317321084
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play317321085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0
			local var_354_1 = 1.2

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_2 = arg_351_1:GetWordFromCfg(317321084)
				local var_354_3 = arg_351_1:FormatText(var_354_2.content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 48
				local var_354_5 = utf8.len(var_354_3)
				local var_354_6 = var_354_4 <= 0 and var_354_1 or var_354_1 * (var_354_5 / var_354_4)

				if var_354_6 > 0 and var_354_1 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6

					if var_354_6 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_7 and arg_351_1.time_ < var_354_0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play317321085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 317321085
		arg_355_1.duration_ = 6.13

		local var_355_0 = {
			zh = 6.133,
			ja = 4.166
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play317321086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = "1029ui_story"

			if arg_355_1.actors_[var_358_0] == nil then
				local var_358_1 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_358_1) then
					local var_358_2 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_355_1.stage_.transform)

					var_358_2.name = var_358_0
					var_358_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_355_1.actors_[var_358_0] = var_358_2

					local var_358_3 = var_358_2:GetComponentInChildren(typeof(CharacterEffect))

					var_358_3.enabled = true

					local var_358_4 = GameObjectTools.GetOrAddComponent(var_358_2, typeof(DynamicBoneHelper))

					if var_358_4 then
						var_358_4:EnableDynamicBone(false)
					end

					arg_355_1:ShowWeapon(var_358_3.transform, false)

					arg_355_1.var_[var_358_0 .. "Animator"] = var_358_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_355_1.var_[var_358_0 .. "Animator"].applyRootMotion = true
					arg_355_1.var_[var_358_0 .. "LipSync"] = var_358_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_358_5 = arg_355_1.actors_["1029ui_story"].transform
			local var_358_6 = 0

			if var_358_6 < arg_355_1.time_ and arg_355_1.time_ <= var_358_6 + arg_358_0 then
				arg_355_1.var_.moveOldPos1029ui_story = var_358_5.localPosition
			end

			local var_358_7 = 0.001

			if var_358_6 <= arg_355_1.time_ and arg_355_1.time_ < var_358_6 + var_358_7 then
				local var_358_8 = (arg_355_1.time_ - var_358_6) / var_358_7
				local var_358_9 = Vector3.New(0, -1.09, -6.2)

				var_358_5.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1029ui_story, var_358_9, var_358_8)

				local var_358_10 = manager.ui.mainCamera.transform.position - var_358_5.position

				var_358_5.forward = Vector3.New(var_358_10.x, var_358_10.y, var_358_10.z)

				local var_358_11 = var_358_5.localEulerAngles

				var_358_11.z = 0
				var_358_11.x = 0
				var_358_5.localEulerAngles = var_358_11
			end

			if arg_355_1.time_ >= var_358_6 + var_358_7 and arg_355_1.time_ < var_358_6 + var_358_7 + arg_358_0 then
				var_358_5.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_358_12 = manager.ui.mainCamera.transform.position - var_358_5.position

				var_358_5.forward = Vector3.New(var_358_12.x, var_358_12.y, var_358_12.z)

				local var_358_13 = var_358_5.localEulerAngles

				var_358_13.z = 0
				var_358_13.x = 0
				var_358_5.localEulerAngles = var_358_13
			end

			local var_358_14 = arg_355_1.actors_["1029ui_story"]
			local var_358_15 = 0

			if var_358_15 < arg_355_1.time_ and arg_355_1.time_ <= var_358_15 + arg_358_0 and not isNil(var_358_14) and arg_355_1.var_.characterEffect1029ui_story == nil then
				arg_355_1.var_.characterEffect1029ui_story = var_358_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_16 = 0.200000002980232

			if var_358_15 <= arg_355_1.time_ and arg_355_1.time_ < var_358_15 + var_358_16 and not isNil(var_358_14) then
				local var_358_17 = (arg_355_1.time_ - var_358_15) / var_358_16

				if arg_355_1.var_.characterEffect1029ui_story and not isNil(var_358_14) then
					arg_355_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_15 + var_358_16 and arg_355_1.time_ < var_358_15 + var_358_16 + arg_358_0 and not isNil(var_358_14) and arg_355_1.var_.characterEffect1029ui_story then
				arg_355_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_358_18 = 0

			if var_358_18 < arg_355_1.time_ and arg_355_1.time_ <= var_358_18 + arg_358_0 then
				arg_355_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_358_19 = 0

			if var_358_19 < arg_355_1.time_ and arg_355_1.time_ <= var_358_19 + arg_358_0 then
				arg_355_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_358_20 = 0
			local var_358_21 = 0.45

			if var_358_20 < arg_355_1.time_ and arg_355_1.time_ <= var_358_20 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_22 = arg_355_1:FormatText(StoryNameCfg[319].name)

				arg_355_1.leftNameTxt_.text = var_358_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_23 = arg_355_1:GetWordFromCfg(317321085)
				local var_358_24 = arg_355_1:FormatText(var_358_23.content)

				arg_355_1.text_.text = var_358_24

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_25 = 18
				local var_358_26 = utf8.len(var_358_24)
				local var_358_27 = var_358_25 <= 0 and var_358_21 or var_358_21 * (var_358_26 / var_358_25)

				if var_358_27 > 0 and var_358_21 < var_358_27 then
					arg_355_1.talkMaxDuration = var_358_27

					if var_358_27 + var_358_20 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_27 + var_358_20
					end
				end

				arg_355_1.text_.text = var_358_24
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321085", "story_v_out_317321.awb") ~= 0 then
					local var_358_28 = manager.audio:GetVoiceLength("story_v_out_317321", "317321085", "story_v_out_317321.awb") / 1000

					if var_358_28 + var_358_20 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_28 + var_358_20
					end

					if var_358_23.prefab_name ~= "" and arg_355_1.actors_[var_358_23.prefab_name] ~= nil then
						local var_358_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_23.prefab_name].transform, "story_v_out_317321", "317321085", "story_v_out_317321.awb")

						arg_355_1:RecordAudio("317321085", var_358_29)
						arg_355_1:RecordAudio("317321085", var_358_29)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_317321", "317321085", "story_v_out_317321.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_317321", "317321085", "story_v_out_317321.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_30 = math.max(var_358_21, arg_355_1.talkMaxDuration)

			if var_358_20 <= arg_355_1.time_ and arg_355_1.time_ < var_358_20 + var_358_30 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_20) / var_358_30

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_20 + var_358_30 and arg_355_1.time_ < var_358_20 + var_358_30 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
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

		arg_355_1:InitPlayNodeList()
	end,
	Play317321086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 317321086
		arg_359_1.duration_ = 7.2

		local var_359_0 = {
			zh = 3.1,
			ja = 7.2
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play317321087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_362_1 = 0
			local var_362_2 = 0.375

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_3 = arg_359_1:FormatText(StoryNameCfg[319].name)

				arg_359_1.leftNameTxt_.text = var_362_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_4 = arg_359_1:GetWordFromCfg(317321086)
				local var_362_5 = arg_359_1:FormatText(var_362_4.content)

				arg_359_1.text_.text = var_362_5

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_6 = 15
				local var_362_7 = utf8.len(var_362_5)
				local var_362_8 = var_362_6 <= 0 and var_362_2 or var_362_2 * (var_362_7 / var_362_6)

				if var_362_8 > 0 and var_362_2 < var_362_8 then
					arg_359_1.talkMaxDuration = var_362_8

					if var_362_8 + var_362_1 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_1
					end
				end

				arg_359_1.text_.text = var_362_5
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321086", "story_v_out_317321.awb") ~= 0 then
					local var_362_9 = manager.audio:GetVoiceLength("story_v_out_317321", "317321086", "story_v_out_317321.awb") / 1000

					if var_362_9 + var_362_1 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_9 + var_362_1
					end

					if var_362_4.prefab_name ~= "" and arg_359_1.actors_[var_362_4.prefab_name] ~= nil then
						local var_362_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_4.prefab_name].transform, "story_v_out_317321", "317321086", "story_v_out_317321.awb")

						arg_359_1:RecordAudio("317321086", var_362_10)
						arg_359_1:RecordAudio("317321086", var_362_10)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_317321", "317321086", "story_v_out_317321.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_317321", "317321086", "story_v_out_317321.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_11 = math.max(var_362_2, arg_359_1.talkMaxDuration)

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_11 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_1) / var_362_11

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_1 + var_362_11 and arg_359_1.time_ < var_362_1 + var_362_11 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play317321087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 317321087
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play317321088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1029ui_story"].transform
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.var_.moveOldPos1029ui_story = var_366_0.localPosition
			end

			local var_366_2 = 0.001

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2
				local var_366_4 = Vector3.New(0, 100, 0)

				var_366_0.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1029ui_story, var_366_4, var_366_3)

				local var_366_5 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_5.x, var_366_5.y, var_366_5.z)

				local var_366_6 = var_366_0.localEulerAngles

				var_366_6.z = 0
				var_366_6.x = 0
				var_366_0.localEulerAngles = var_366_6
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 then
				var_366_0.localPosition = Vector3.New(0, 100, 0)

				local var_366_7 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_7.x, var_366_7.y, var_366_7.z)

				local var_366_8 = var_366_0.localEulerAngles

				var_366_8.z = 0
				var_366_8.x = 0
				var_366_0.localEulerAngles = var_366_8
			end

			local var_366_9 = 0
			local var_366_10 = 0.95

			if var_366_9 < arg_363_1.time_ and arg_363_1.time_ <= var_366_9 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_11 = arg_363_1:GetWordFromCfg(317321087)
				local var_366_12 = arg_363_1:FormatText(var_366_11.content)

				arg_363_1.text_.text = var_366_12

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_13 = 38
				local var_366_14 = utf8.len(var_366_12)
				local var_366_15 = var_366_13 <= 0 and var_366_10 or var_366_10 * (var_366_14 / var_366_13)

				if var_366_15 > 0 and var_366_10 < var_366_15 then
					arg_363_1.talkMaxDuration = var_366_15

					if var_366_15 + var_366_9 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_15 + var_366_9
					end
				end

				arg_363_1.text_.text = var_366_12
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_16 = math.max(var_366_10, arg_363_1.talkMaxDuration)

			if var_366_9 <= arg_363_1.time_ and arg_363_1.time_ < var_366_9 + var_366_16 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_9) / var_366_16

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_9 + var_366_16 and arg_363_1.time_ < var_366_9 + var_366_16 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
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

		arg_363_1:InitPlayNodeList()
	end,
	Play317321088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 317321088
		arg_367_1.duration_ = 6.13

		local var_367_0 = {
			zh = 3.7,
			ja = 6.133
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play317321089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = "1019ui_story"

			if arg_367_1.actors_[var_370_0] == nil then
				local var_370_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_370_1) then
					local var_370_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_367_1.stage_.transform)

					var_370_2.name = var_370_0
					var_370_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_367_1.actors_[var_370_0] = var_370_2

					local var_370_3 = var_370_2:GetComponentInChildren(typeof(CharacterEffect))

					var_370_3.enabled = true

					local var_370_4 = GameObjectTools.GetOrAddComponent(var_370_2, typeof(DynamicBoneHelper))

					if var_370_4 then
						var_370_4:EnableDynamicBone(false)
					end

					arg_367_1:ShowWeapon(var_370_3.transform, false)

					arg_367_1.var_[var_370_0 .. "Animator"] = var_370_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_367_1.var_[var_370_0 .. "Animator"].applyRootMotion = true
					arg_367_1.var_[var_370_0 .. "LipSync"] = var_370_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_370_5 = arg_367_1.actors_["1019ui_story"].transform
			local var_370_6 = 0

			if var_370_6 < arg_367_1.time_ and arg_367_1.time_ <= var_370_6 + arg_370_0 then
				arg_367_1.var_.moveOldPos1019ui_story = var_370_5.localPosition
			end

			local var_370_7 = 0.001

			if var_370_6 <= arg_367_1.time_ and arg_367_1.time_ < var_370_6 + var_370_7 then
				local var_370_8 = (arg_367_1.time_ - var_370_6) / var_370_7
				local var_370_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_370_5.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1019ui_story, var_370_9, var_370_8)

				local var_370_10 = manager.ui.mainCamera.transform.position - var_370_5.position

				var_370_5.forward = Vector3.New(var_370_10.x, var_370_10.y, var_370_10.z)

				local var_370_11 = var_370_5.localEulerAngles

				var_370_11.z = 0
				var_370_11.x = 0
				var_370_5.localEulerAngles = var_370_11
			end

			if arg_367_1.time_ >= var_370_6 + var_370_7 and arg_367_1.time_ < var_370_6 + var_370_7 + arg_370_0 then
				var_370_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_370_12 = manager.ui.mainCamera.transform.position - var_370_5.position

				var_370_5.forward = Vector3.New(var_370_12.x, var_370_12.y, var_370_12.z)

				local var_370_13 = var_370_5.localEulerAngles

				var_370_13.z = 0
				var_370_13.x = 0
				var_370_5.localEulerAngles = var_370_13
			end

			local var_370_14 = arg_367_1.actors_["1019ui_story"]
			local var_370_15 = 0

			if var_370_15 < arg_367_1.time_ and arg_367_1.time_ <= var_370_15 + arg_370_0 and not isNil(var_370_14) and arg_367_1.var_.characterEffect1019ui_story == nil then
				arg_367_1.var_.characterEffect1019ui_story = var_370_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_16 = 0.200000002980232

			if var_370_15 <= arg_367_1.time_ and arg_367_1.time_ < var_370_15 + var_370_16 and not isNil(var_370_14) then
				local var_370_17 = (arg_367_1.time_ - var_370_15) / var_370_16

				if arg_367_1.var_.characterEffect1019ui_story and not isNil(var_370_14) then
					arg_367_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= var_370_15 + var_370_16 and arg_367_1.time_ < var_370_15 + var_370_16 + arg_370_0 and not isNil(var_370_14) and arg_367_1.var_.characterEffect1019ui_story then
				arg_367_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_370_18 = 0

			if var_370_18 < arg_367_1.time_ and arg_367_1.time_ <= var_370_18 + arg_370_0 then
				arg_367_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_370_19 = 0

			if var_370_19 < arg_367_1.time_ and arg_367_1.time_ <= var_370_19 + arg_370_0 then
				arg_367_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_370_20 = 0
			local var_370_21 = 0.525

			if var_370_20 < arg_367_1.time_ and arg_367_1.time_ <= var_370_20 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_22 = arg_367_1:FormatText(StoryNameCfg[13].name)

				arg_367_1.leftNameTxt_.text = var_370_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_23 = arg_367_1:GetWordFromCfg(317321088)
				local var_370_24 = arg_367_1:FormatText(var_370_23.content)

				arg_367_1.text_.text = var_370_24

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_25 = 21
				local var_370_26 = utf8.len(var_370_24)
				local var_370_27 = var_370_25 <= 0 and var_370_21 or var_370_21 * (var_370_26 / var_370_25)

				if var_370_27 > 0 and var_370_21 < var_370_27 then
					arg_367_1.talkMaxDuration = var_370_27

					if var_370_27 + var_370_20 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_27 + var_370_20
					end
				end

				arg_367_1.text_.text = var_370_24
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321088", "story_v_out_317321.awb") ~= 0 then
					local var_370_28 = manager.audio:GetVoiceLength("story_v_out_317321", "317321088", "story_v_out_317321.awb") / 1000

					if var_370_28 + var_370_20 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_28 + var_370_20
					end

					if var_370_23.prefab_name ~= "" and arg_367_1.actors_[var_370_23.prefab_name] ~= nil then
						local var_370_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_23.prefab_name].transform, "story_v_out_317321", "317321088", "story_v_out_317321.awb")

						arg_367_1:RecordAudio("317321088", var_370_29)
						arg_367_1:RecordAudio("317321088", var_370_29)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_317321", "317321088", "story_v_out_317321.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_317321", "317321088", "story_v_out_317321.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_30 = math.max(var_370_21, arg_367_1.talkMaxDuration)

			if var_370_20 <= arg_367_1.time_ and arg_367_1.time_ < var_370_20 + var_370_30 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_20) / var_370_30

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_20 + var_370_30 and arg_367_1.time_ < var_370_20 + var_370_30 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play317321089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 317321089
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play317321090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1019ui_story"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos1019ui_story = var_374_0.localPosition
			end

			local var_374_2 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2
				local var_374_4 = Vector3.New(0, 100, 0)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1019ui_story, var_374_4, var_374_3)

				local var_374_5 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_5.x, var_374_5.y, var_374_5.z)

				local var_374_6 = var_374_0.localEulerAngles

				var_374_6.z = 0
				var_374_6.x = 0
				var_374_0.localEulerAngles = var_374_6
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(0, 100, 0)

				local var_374_7 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_7.x, var_374_7.y, var_374_7.z)

				local var_374_8 = var_374_0.localEulerAngles

				var_374_8.z = 0
				var_374_8.x = 0
				var_374_0.localEulerAngles = var_374_8
			end

			local var_374_9 = 0
			local var_374_10 = 0.825

			if var_374_9 < arg_371_1.time_ and arg_371_1.time_ <= var_374_9 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_11 = arg_371_1:GetWordFromCfg(317321089)
				local var_374_12 = arg_371_1:FormatText(var_374_11.content)

				arg_371_1.text_.text = var_374_12

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_13 = 33
				local var_374_14 = utf8.len(var_374_12)
				local var_374_15 = var_374_13 <= 0 and var_374_10 or var_374_10 * (var_374_14 / var_374_13)

				if var_374_15 > 0 and var_374_10 < var_374_15 then
					arg_371_1.talkMaxDuration = var_374_15

					if var_374_15 + var_374_9 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_15 + var_374_9
					end
				end

				arg_371_1.text_.text = var_374_12
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_16 = math.max(var_374_10, arg_371_1.talkMaxDuration)

			if var_374_9 <= arg_371_1.time_ and arg_371_1.time_ < var_374_9 + var_374_16 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_9) / var_374_16

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_9 + var_374_16 and arg_371_1.time_ < var_374_9 + var_374_16 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play317321090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 317321090
		arg_375_1.duration_ = 6.4

		local var_375_0 = {
			zh = 6.4,
			ja = 5.633
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play317321091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1019ui_story"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos1019ui_story = var_378_0.localPosition
			end

			local var_378_2 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2
				local var_378_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1019ui_story, var_378_4, var_378_3)

				local var_378_5 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_5.x, var_378_5.y, var_378_5.z)

				local var_378_6 = var_378_0.localEulerAngles

				var_378_6.z = 0
				var_378_6.x = 0
				var_378_0.localEulerAngles = var_378_6
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_378_7 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_7.x, var_378_7.y, var_378_7.z)

				local var_378_8 = var_378_0.localEulerAngles

				var_378_8.z = 0
				var_378_8.x = 0
				var_378_0.localEulerAngles = var_378_8
			end

			local var_378_9 = arg_375_1.actors_["1019ui_story"]
			local var_378_10 = 0

			if var_378_10 < arg_375_1.time_ and arg_375_1.time_ <= var_378_10 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect1019ui_story == nil then
				arg_375_1.var_.characterEffect1019ui_story = var_378_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_11 = 0.200000002980232

			if var_378_10 <= arg_375_1.time_ and arg_375_1.time_ < var_378_10 + var_378_11 and not isNil(var_378_9) then
				local var_378_12 = (arg_375_1.time_ - var_378_10) / var_378_11

				if arg_375_1.var_.characterEffect1019ui_story and not isNil(var_378_9) then
					arg_375_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= var_378_10 + var_378_11 and arg_375_1.time_ < var_378_10 + var_378_11 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect1019ui_story then
				arg_375_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_378_13 = 0

			if var_378_13 < arg_375_1.time_ and arg_375_1.time_ <= var_378_13 + arg_378_0 then
				arg_375_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_378_14 = 0

			if var_378_14 < arg_375_1.time_ and arg_375_1.time_ <= var_378_14 + arg_378_0 then
				arg_375_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_378_15 = arg_375_1.actors_["1029ui_story"].transform
			local var_378_16 = 0

			if var_378_16 < arg_375_1.time_ and arg_375_1.time_ <= var_378_16 + arg_378_0 then
				arg_375_1.var_.moveOldPos1029ui_story = var_378_15.localPosition
			end

			local var_378_17 = 0.001

			if var_378_16 <= arg_375_1.time_ and arg_375_1.time_ < var_378_16 + var_378_17 then
				local var_378_18 = (arg_375_1.time_ - var_378_16) / var_378_17
				local var_378_19 = Vector3.New(0.7, -1.09, -6.2)

				var_378_15.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1029ui_story, var_378_19, var_378_18)

				local var_378_20 = manager.ui.mainCamera.transform.position - var_378_15.position

				var_378_15.forward = Vector3.New(var_378_20.x, var_378_20.y, var_378_20.z)

				local var_378_21 = var_378_15.localEulerAngles

				var_378_21.z = 0
				var_378_21.x = 0
				var_378_15.localEulerAngles = var_378_21
			end

			if arg_375_1.time_ >= var_378_16 + var_378_17 and arg_375_1.time_ < var_378_16 + var_378_17 + arg_378_0 then
				var_378_15.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_378_22 = manager.ui.mainCamera.transform.position - var_378_15.position

				var_378_15.forward = Vector3.New(var_378_22.x, var_378_22.y, var_378_22.z)

				local var_378_23 = var_378_15.localEulerAngles

				var_378_23.z = 0
				var_378_23.x = 0
				var_378_15.localEulerAngles = var_378_23
			end

			local var_378_24 = arg_375_1.actors_["1029ui_story"]
			local var_378_25 = 0

			if var_378_25 < arg_375_1.time_ and arg_375_1.time_ <= var_378_25 + arg_378_0 and not isNil(var_378_24) and arg_375_1.var_.characterEffect1029ui_story == nil then
				arg_375_1.var_.characterEffect1029ui_story = var_378_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_26 = 0.200000002980232

			if var_378_25 <= arg_375_1.time_ and arg_375_1.time_ < var_378_25 + var_378_26 and not isNil(var_378_24) then
				local var_378_27 = (arg_375_1.time_ - var_378_25) / var_378_26

				if arg_375_1.var_.characterEffect1029ui_story and not isNil(var_378_24) then
					local var_378_28 = Mathf.Lerp(0, 0.5, var_378_27)

					arg_375_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1029ui_story.fillRatio = var_378_28
				end
			end

			if arg_375_1.time_ >= var_378_25 + var_378_26 and arg_375_1.time_ < var_378_25 + var_378_26 + arg_378_0 and not isNil(var_378_24) and arg_375_1.var_.characterEffect1029ui_story then
				local var_378_29 = 0.5

				arg_375_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1029ui_story.fillRatio = var_378_29
			end

			local var_378_30 = 0
			local var_378_31 = 0.625

			if var_378_30 < arg_375_1.time_ and arg_375_1.time_ <= var_378_30 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_32 = arg_375_1:FormatText(StoryNameCfg[13].name)

				arg_375_1.leftNameTxt_.text = var_378_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_33 = arg_375_1:GetWordFromCfg(317321090)
				local var_378_34 = arg_375_1:FormatText(var_378_33.content)

				arg_375_1.text_.text = var_378_34

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_35 = 25
				local var_378_36 = utf8.len(var_378_34)
				local var_378_37 = var_378_35 <= 0 and var_378_31 or var_378_31 * (var_378_36 / var_378_35)

				if var_378_37 > 0 and var_378_31 < var_378_37 then
					arg_375_1.talkMaxDuration = var_378_37

					if var_378_37 + var_378_30 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_37 + var_378_30
					end
				end

				arg_375_1.text_.text = var_378_34
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321090", "story_v_out_317321.awb") ~= 0 then
					local var_378_38 = manager.audio:GetVoiceLength("story_v_out_317321", "317321090", "story_v_out_317321.awb") / 1000

					if var_378_38 + var_378_30 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_38 + var_378_30
					end

					if var_378_33.prefab_name ~= "" and arg_375_1.actors_[var_378_33.prefab_name] ~= nil then
						local var_378_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_33.prefab_name].transform, "story_v_out_317321", "317321090", "story_v_out_317321.awb")

						arg_375_1:RecordAudio("317321090", var_378_39)
						arg_375_1:RecordAudio("317321090", var_378_39)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_317321", "317321090", "story_v_out_317321.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_317321", "317321090", "story_v_out_317321.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_40 = math.max(var_378_31, arg_375_1.talkMaxDuration)

			if var_378_30 <= arg_375_1.time_ and arg_375_1.time_ < var_378_30 + var_378_40 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_30) / var_378_40

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_30 + var_378_40 and arg_375_1.time_ < var_378_30 + var_378_40 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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

		arg_375_1:InitPlayNodeList()
	end,
	Play317321091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 317321091
		arg_379_1.duration_ = 8.27

		local var_379_0 = {
			zh = 3.066,
			ja = 8.266
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play317321092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1029ui_story"].transform
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.var_.moveOldPos1029ui_story = var_382_0.localPosition
			end

			local var_382_2 = 0.001

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2
				local var_382_4 = Vector3.New(0.7, -1.09, -6.2)

				var_382_0.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1029ui_story, var_382_4, var_382_3)

				local var_382_5 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_5.x, var_382_5.y, var_382_5.z)

				local var_382_6 = var_382_0.localEulerAngles

				var_382_6.z = 0
				var_382_6.x = 0
				var_382_0.localEulerAngles = var_382_6
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 then
				var_382_0.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_382_7 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_7.x, var_382_7.y, var_382_7.z)

				local var_382_8 = var_382_0.localEulerAngles

				var_382_8.z = 0
				var_382_8.x = 0
				var_382_0.localEulerAngles = var_382_8
			end

			local var_382_9 = arg_379_1.actors_["1029ui_story"]
			local var_382_10 = 0

			if var_382_10 < arg_379_1.time_ and arg_379_1.time_ <= var_382_10 + arg_382_0 and not isNil(var_382_9) and arg_379_1.var_.characterEffect1029ui_story == nil then
				arg_379_1.var_.characterEffect1029ui_story = var_382_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_11 = 0.200000002980232

			if var_382_10 <= arg_379_1.time_ and arg_379_1.time_ < var_382_10 + var_382_11 and not isNil(var_382_9) then
				local var_382_12 = (arg_379_1.time_ - var_382_10) / var_382_11

				if arg_379_1.var_.characterEffect1029ui_story and not isNil(var_382_9) then
					arg_379_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_10 + var_382_11 and arg_379_1.time_ < var_382_10 + var_382_11 + arg_382_0 and not isNil(var_382_9) and arg_379_1.var_.characterEffect1029ui_story then
				arg_379_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_382_13 = 0

			if var_382_13 < arg_379_1.time_ and arg_379_1.time_ <= var_382_13 + arg_382_0 then
				arg_379_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_382_14 = 0

			if var_382_14 < arg_379_1.time_ and arg_379_1.time_ <= var_382_14 + arg_382_0 then
				arg_379_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_382_15 = arg_379_1.actors_["1019ui_story"]
			local var_382_16 = 0

			if var_382_16 < arg_379_1.time_ and arg_379_1.time_ <= var_382_16 + arg_382_0 and not isNil(var_382_15) and arg_379_1.var_.characterEffect1019ui_story == nil then
				arg_379_1.var_.characterEffect1019ui_story = var_382_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_17 = 0.200000002980232

			if var_382_16 <= arg_379_1.time_ and arg_379_1.time_ < var_382_16 + var_382_17 and not isNil(var_382_15) then
				local var_382_18 = (arg_379_1.time_ - var_382_16) / var_382_17

				if arg_379_1.var_.characterEffect1019ui_story and not isNil(var_382_15) then
					local var_382_19 = Mathf.Lerp(0, 0.5, var_382_18)

					arg_379_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1019ui_story.fillRatio = var_382_19
				end
			end

			if arg_379_1.time_ >= var_382_16 + var_382_17 and arg_379_1.time_ < var_382_16 + var_382_17 + arg_382_0 and not isNil(var_382_15) and arg_379_1.var_.characterEffect1019ui_story then
				local var_382_20 = 0.5

				arg_379_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1019ui_story.fillRatio = var_382_20
			end

			local var_382_21 = 0
			local var_382_22 = 0.375

			if var_382_21 < arg_379_1.time_ and arg_379_1.time_ <= var_382_21 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_23 = arg_379_1:FormatText(StoryNameCfg[319].name)

				arg_379_1.leftNameTxt_.text = var_382_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_24 = arg_379_1:GetWordFromCfg(317321091)
				local var_382_25 = arg_379_1:FormatText(var_382_24.content)

				arg_379_1.text_.text = var_382_25

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_26 = 15
				local var_382_27 = utf8.len(var_382_25)
				local var_382_28 = var_382_26 <= 0 and var_382_22 or var_382_22 * (var_382_27 / var_382_26)

				if var_382_28 > 0 and var_382_22 < var_382_28 then
					arg_379_1.talkMaxDuration = var_382_28

					if var_382_28 + var_382_21 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_28 + var_382_21
					end
				end

				arg_379_1.text_.text = var_382_25
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321091", "story_v_out_317321.awb") ~= 0 then
					local var_382_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321091", "story_v_out_317321.awb") / 1000

					if var_382_29 + var_382_21 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_29 + var_382_21
					end

					if var_382_24.prefab_name ~= "" and arg_379_1.actors_[var_382_24.prefab_name] ~= nil then
						local var_382_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_24.prefab_name].transform, "story_v_out_317321", "317321091", "story_v_out_317321.awb")

						arg_379_1:RecordAudio("317321091", var_382_30)
						arg_379_1:RecordAudio("317321091", var_382_30)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_317321", "317321091", "story_v_out_317321.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_317321", "317321091", "story_v_out_317321.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_31 = math.max(var_382_22, arg_379_1.talkMaxDuration)

			if var_382_21 <= arg_379_1.time_ and arg_379_1.time_ < var_382_21 + var_382_31 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_21) / var_382_31

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_21 + var_382_31 and arg_379_1.time_ < var_382_21 + var_382_31 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
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

		arg_379_1:InitPlayNodeList()
	end,
	Play317321092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 317321092
		arg_383_1.duration_ = 1.83

		local var_383_0 = {
			zh = 1.833,
			ja = 1.433
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play317321093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1029ui_story"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1029ui_story == nil then
				arg_383_1.var_.characterEffect1029ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.characterEffect1029ui_story and not isNil(var_386_0) then
					local var_386_4 = Mathf.Lerp(0, 0.5, var_386_3)

					arg_383_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1029ui_story.fillRatio = var_386_4
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1029ui_story then
				local var_386_5 = 0.5

				arg_383_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1029ui_story.fillRatio = var_386_5
			end

			local var_386_6 = arg_383_1.actors_["1019ui_story"]
			local var_386_7 = 0

			if var_386_7 < arg_383_1.time_ and arg_383_1.time_ <= var_386_7 + arg_386_0 and not isNil(var_386_6) and arg_383_1.var_.characterEffect1019ui_story == nil then
				arg_383_1.var_.characterEffect1019ui_story = var_386_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_8 = 0.200000002980232

			if var_386_7 <= arg_383_1.time_ and arg_383_1.time_ < var_386_7 + var_386_8 and not isNil(var_386_6) then
				local var_386_9 = (arg_383_1.time_ - var_386_7) / var_386_8

				if arg_383_1.var_.characterEffect1019ui_story and not isNil(var_386_6) then
					arg_383_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= var_386_7 + var_386_8 and arg_383_1.time_ < var_386_7 + var_386_8 + arg_386_0 and not isNil(var_386_6) and arg_383_1.var_.characterEffect1019ui_story then
				arg_383_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_386_10 = 0
			local var_386_11 = 0.15

			if var_386_10 < arg_383_1.time_ and arg_383_1.time_ <= var_386_10 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_12 = arg_383_1:FormatText(StoryNameCfg[13].name)

				arg_383_1.leftNameTxt_.text = var_386_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_13 = arg_383_1:GetWordFromCfg(317321092)
				local var_386_14 = arg_383_1:FormatText(var_386_13.content)

				arg_383_1.text_.text = var_386_14

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_15 = 6
				local var_386_16 = utf8.len(var_386_14)
				local var_386_17 = var_386_15 <= 0 and var_386_11 or var_386_11 * (var_386_16 / var_386_15)

				if var_386_17 > 0 and var_386_11 < var_386_17 then
					arg_383_1.talkMaxDuration = var_386_17

					if var_386_17 + var_386_10 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_17 + var_386_10
					end
				end

				arg_383_1.text_.text = var_386_14
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321092", "story_v_out_317321.awb") ~= 0 then
					local var_386_18 = manager.audio:GetVoiceLength("story_v_out_317321", "317321092", "story_v_out_317321.awb") / 1000

					if var_386_18 + var_386_10 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_18 + var_386_10
					end

					if var_386_13.prefab_name ~= "" and arg_383_1.actors_[var_386_13.prefab_name] ~= nil then
						local var_386_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_13.prefab_name].transform, "story_v_out_317321", "317321092", "story_v_out_317321.awb")

						arg_383_1:RecordAudio("317321092", var_386_19)
						arg_383_1:RecordAudio("317321092", var_386_19)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_317321", "317321092", "story_v_out_317321.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_317321", "317321092", "story_v_out_317321.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_20 = math.max(var_386_11, arg_383_1.talkMaxDuration)

			if var_386_10 <= arg_383_1.time_ and arg_383_1.time_ < var_386_10 + var_386_20 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_10) / var_386_20

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_10 + var_386_20 and arg_383_1.time_ < var_386_10 + var_386_20 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play317321093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 317321093
		arg_387_1.duration_ = 10.53

		local var_387_0 = {
			zh = 7.866,
			ja = 10.533
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play317321094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1019ui_story"].transform
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.var_.moveOldPos1019ui_story = var_390_0.localPosition
			end

			local var_390_2 = 0.001

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2
				local var_390_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_390_0.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1019ui_story, var_390_4, var_390_3)

				local var_390_5 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_5.x, var_390_5.y, var_390_5.z)

				local var_390_6 = var_390_0.localEulerAngles

				var_390_6.z = 0
				var_390_6.x = 0
				var_390_0.localEulerAngles = var_390_6
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 then
				var_390_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_390_7 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_7.x, var_390_7.y, var_390_7.z)

				local var_390_8 = var_390_0.localEulerAngles

				var_390_8.z = 0
				var_390_8.x = 0
				var_390_0.localEulerAngles = var_390_8
			end

			local var_390_9 = arg_387_1.actors_["1019ui_story"]
			local var_390_10 = 0

			if var_390_10 < arg_387_1.time_ and arg_387_1.time_ <= var_390_10 + arg_390_0 and not isNil(var_390_9) and arg_387_1.var_.characterEffect1019ui_story == nil then
				arg_387_1.var_.characterEffect1019ui_story = var_390_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_11 = 0.200000002980232

			if var_390_10 <= arg_387_1.time_ and arg_387_1.time_ < var_390_10 + var_390_11 and not isNil(var_390_9) then
				local var_390_12 = (arg_387_1.time_ - var_390_10) / var_390_11

				if arg_387_1.var_.characterEffect1019ui_story and not isNil(var_390_9) then
					arg_387_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= var_390_10 + var_390_11 and arg_387_1.time_ < var_390_10 + var_390_11 + arg_390_0 and not isNil(var_390_9) and arg_387_1.var_.characterEffect1019ui_story then
				arg_387_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_390_13 = 0

			if var_390_13 < arg_387_1.time_ and arg_387_1.time_ <= var_390_13 + arg_390_0 then
				arg_387_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_390_14 = 0

			if var_390_14 < arg_387_1.time_ and arg_387_1.time_ <= var_390_14 + arg_390_0 then
				arg_387_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_390_15 = 0
			local var_390_16 = 0.9

			if var_390_15 < arg_387_1.time_ and arg_387_1.time_ <= var_390_15 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_17 = arg_387_1:FormatText(StoryNameCfg[13].name)

				arg_387_1.leftNameTxt_.text = var_390_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_18 = arg_387_1:GetWordFromCfg(317321093)
				local var_390_19 = arg_387_1:FormatText(var_390_18.content)

				arg_387_1.text_.text = var_390_19

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_20 = 36
				local var_390_21 = utf8.len(var_390_19)
				local var_390_22 = var_390_20 <= 0 and var_390_16 or var_390_16 * (var_390_21 / var_390_20)

				if var_390_22 > 0 and var_390_16 < var_390_22 then
					arg_387_1.talkMaxDuration = var_390_22

					if var_390_22 + var_390_15 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_22 + var_390_15
					end
				end

				arg_387_1.text_.text = var_390_19
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321093", "story_v_out_317321.awb") ~= 0 then
					local var_390_23 = manager.audio:GetVoiceLength("story_v_out_317321", "317321093", "story_v_out_317321.awb") / 1000

					if var_390_23 + var_390_15 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_23 + var_390_15
					end

					if var_390_18.prefab_name ~= "" and arg_387_1.actors_[var_390_18.prefab_name] ~= nil then
						local var_390_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_18.prefab_name].transform, "story_v_out_317321", "317321093", "story_v_out_317321.awb")

						arg_387_1:RecordAudio("317321093", var_390_24)
						arg_387_1:RecordAudio("317321093", var_390_24)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_317321", "317321093", "story_v_out_317321.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_317321", "317321093", "story_v_out_317321.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_25 = math.max(var_390_16, arg_387_1.talkMaxDuration)

			if var_390_15 <= arg_387_1.time_ and arg_387_1.time_ < var_390_15 + var_390_25 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_15) / var_390_25

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_15 + var_390_25 and arg_387_1.time_ < var_390_15 + var_390_25 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play317321094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 317321094
		arg_391_1.duration_ = 6.87

		local var_391_0 = {
			zh = 6.666,
			ja = 6.866
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play317321095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1029ui_story"].transform
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.var_.moveOldPos1029ui_story = var_394_0.localPosition
			end

			local var_394_2 = 0.001

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2
				local var_394_4 = Vector3.New(0.7, -1.09, -6.2)

				var_394_0.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1029ui_story, var_394_4, var_394_3)

				local var_394_5 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_5.x, var_394_5.y, var_394_5.z)

				local var_394_6 = var_394_0.localEulerAngles

				var_394_6.z = 0
				var_394_6.x = 0
				var_394_0.localEulerAngles = var_394_6
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 then
				var_394_0.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_394_7 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_7.x, var_394_7.y, var_394_7.z)

				local var_394_8 = var_394_0.localEulerAngles

				var_394_8.z = 0
				var_394_8.x = 0
				var_394_0.localEulerAngles = var_394_8
			end

			local var_394_9 = arg_391_1.actors_["1029ui_story"]
			local var_394_10 = 0

			if var_394_10 < arg_391_1.time_ and arg_391_1.time_ <= var_394_10 + arg_394_0 and not isNil(var_394_9) and arg_391_1.var_.characterEffect1029ui_story == nil then
				arg_391_1.var_.characterEffect1029ui_story = var_394_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_11 = 0.200000002980232

			if var_394_10 <= arg_391_1.time_ and arg_391_1.time_ < var_394_10 + var_394_11 and not isNil(var_394_9) then
				local var_394_12 = (arg_391_1.time_ - var_394_10) / var_394_11

				if arg_391_1.var_.characterEffect1029ui_story and not isNil(var_394_9) then
					arg_391_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= var_394_10 + var_394_11 and arg_391_1.time_ < var_394_10 + var_394_11 + arg_394_0 and not isNil(var_394_9) and arg_391_1.var_.characterEffect1029ui_story then
				arg_391_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_394_13 = 0

			if var_394_13 < arg_391_1.time_ and arg_391_1.time_ <= var_394_13 + arg_394_0 then
				arg_391_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_394_14 = 0

			if var_394_14 < arg_391_1.time_ and arg_391_1.time_ <= var_394_14 + arg_394_0 then
				arg_391_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_394_15 = arg_391_1.actors_["1019ui_story"]
			local var_394_16 = 0

			if var_394_16 < arg_391_1.time_ and arg_391_1.time_ <= var_394_16 + arg_394_0 and not isNil(var_394_15) and arg_391_1.var_.characterEffect1019ui_story == nil then
				arg_391_1.var_.characterEffect1019ui_story = var_394_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_17 = 0.200000002980232

			if var_394_16 <= arg_391_1.time_ and arg_391_1.time_ < var_394_16 + var_394_17 and not isNil(var_394_15) then
				local var_394_18 = (arg_391_1.time_ - var_394_16) / var_394_17

				if arg_391_1.var_.characterEffect1019ui_story and not isNil(var_394_15) then
					local var_394_19 = Mathf.Lerp(0, 0.5, var_394_18)

					arg_391_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1019ui_story.fillRatio = var_394_19
				end
			end

			if arg_391_1.time_ >= var_394_16 + var_394_17 and arg_391_1.time_ < var_394_16 + var_394_17 + arg_394_0 and not isNil(var_394_15) and arg_391_1.var_.characterEffect1019ui_story then
				local var_394_20 = 0.5

				arg_391_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1019ui_story.fillRatio = var_394_20
			end

			local var_394_21 = 0
			local var_394_22 = 0.775

			if var_394_21 < arg_391_1.time_ and arg_391_1.time_ <= var_394_21 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_23 = arg_391_1:FormatText(StoryNameCfg[319].name)

				arg_391_1.leftNameTxt_.text = var_394_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_24 = arg_391_1:GetWordFromCfg(317321094)
				local var_394_25 = arg_391_1:FormatText(var_394_24.content)

				arg_391_1.text_.text = var_394_25

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_26 = 31
				local var_394_27 = utf8.len(var_394_25)
				local var_394_28 = var_394_26 <= 0 and var_394_22 or var_394_22 * (var_394_27 / var_394_26)

				if var_394_28 > 0 and var_394_22 < var_394_28 then
					arg_391_1.talkMaxDuration = var_394_28

					if var_394_28 + var_394_21 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_28 + var_394_21
					end
				end

				arg_391_1.text_.text = var_394_25
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321094", "story_v_out_317321.awb") ~= 0 then
					local var_394_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321094", "story_v_out_317321.awb") / 1000

					if var_394_29 + var_394_21 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_29 + var_394_21
					end

					if var_394_24.prefab_name ~= "" and arg_391_1.actors_[var_394_24.prefab_name] ~= nil then
						local var_394_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_24.prefab_name].transform, "story_v_out_317321", "317321094", "story_v_out_317321.awb")

						arg_391_1:RecordAudio("317321094", var_394_30)
						arg_391_1:RecordAudio("317321094", var_394_30)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_317321", "317321094", "story_v_out_317321.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_317321", "317321094", "story_v_out_317321.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_31 = math.max(var_394_22, arg_391_1.talkMaxDuration)

			if var_394_21 <= arg_391_1.time_ and arg_391_1.time_ < var_394_21 + var_394_31 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_21) / var_394_31

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_21 + var_394_31 and arg_391_1.time_ < var_394_21 + var_394_31 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
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

		arg_391_1:InitPlayNodeList()
	end,
	Play317321095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 317321095
		arg_395_1.duration_ = 6.4

		local var_395_0 = {
			zh = 4.1,
			ja = 6.4
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play317321096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0
			local var_398_1 = 0.35

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_2 = arg_395_1:FormatText(StoryNameCfg[319].name)

				arg_395_1.leftNameTxt_.text = var_398_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_3 = arg_395_1:GetWordFromCfg(317321095)
				local var_398_4 = arg_395_1:FormatText(var_398_3.content)

				arg_395_1.text_.text = var_398_4

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_5 = 15
				local var_398_6 = utf8.len(var_398_4)
				local var_398_7 = var_398_5 <= 0 and var_398_1 or var_398_1 * (var_398_6 / var_398_5)

				if var_398_7 > 0 and var_398_1 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_0
					end
				end

				arg_395_1.text_.text = var_398_4
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321095", "story_v_out_317321.awb") ~= 0 then
					local var_398_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321095", "story_v_out_317321.awb") / 1000

					if var_398_8 + var_398_0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_8 + var_398_0
					end

					if var_398_3.prefab_name ~= "" and arg_395_1.actors_[var_398_3.prefab_name] ~= nil then
						local var_398_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_3.prefab_name].transform, "story_v_out_317321", "317321095", "story_v_out_317321.awb")

						arg_395_1:RecordAudio("317321095", var_398_9)
						arg_395_1:RecordAudio("317321095", var_398_9)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_317321", "317321095", "story_v_out_317321.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_317321", "317321095", "story_v_out_317321.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_10 = math.max(var_398_1, arg_395_1.talkMaxDuration)

			if var_398_0 <= arg_395_1.time_ and arg_395_1.time_ < var_398_0 + var_398_10 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_0) / var_398_10

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_0 + var_398_10 and arg_395_1.time_ < var_398_0 + var_398_10 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play317321096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 317321096
		arg_399_1.duration_ = 2

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play317321097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1019ui_story"].transform
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.var_.moveOldPos1019ui_story = var_402_0.localPosition
			end

			local var_402_2 = 0.001

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2
				local var_402_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_402_0.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1019ui_story, var_402_4, var_402_3)

				local var_402_5 = manager.ui.mainCamera.transform.position - var_402_0.position

				var_402_0.forward = Vector3.New(var_402_5.x, var_402_5.y, var_402_5.z)

				local var_402_6 = var_402_0.localEulerAngles

				var_402_6.z = 0
				var_402_6.x = 0
				var_402_0.localEulerAngles = var_402_6
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 then
				var_402_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_402_7 = manager.ui.mainCamera.transform.position - var_402_0.position

				var_402_0.forward = Vector3.New(var_402_7.x, var_402_7.y, var_402_7.z)

				local var_402_8 = var_402_0.localEulerAngles

				var_402_8.z = 0
				var_402_8.x = 0
				var_402_0.localEulerAngles = var_402_8
			end

			local var_402_9 = arg_399_1.actors_["1019ui_story"]
			local var_402_10 = 0

			if var_402_10 < arg_399_1.time_ and arg_399_1.time_ <= var_402_10 + arg_402_0 and not isNil(var_402_9) and arg_399_1.var_.characterEffect1019ui_story == nil then
				arg_399_1.var_.characterEffect1019ui_story = var_402_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_11 = 0.200000002980232

			if var_402_10 <= arg_399_1.time_ and arg_399_1.time_ < var_402_10 + var_402_11 and not isNil(var_402_9) then
				local var_402_12 = (arg_399_1.time_ - var_402_10) / var_402_11

				if arg_399_1.var_.characterEffect1019ui_story and not isNil(var_402_9) then
					arg_399_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= var_402_10 + var_402_11 and arg_399_1.time_ < var_402_10 + var_402_11 + arg_402_0 and not isNil(var_402_9) and arg_399_1.var_.characterEffect1019ui_story then
				arg_399_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_402_13 = 0

			if var_402_13 < arg_399_1.time_ and arg_399_1.time_ <= var_402_13 + arg_402_0 then
				arg_399_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_402_14 = 0

			if var_402_14 < arg_399_1.time_ and arg_399_1.time_ <= var_402_14 + arg_402_0 then
				arg_399_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_402_15 = 0
			local var_402_16 = 0.075

			if var_402_15 < arg_399_1.time_ and arg_399_1.time_ <= var_402_15 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_17 = arg_399_1:FormatText(StoryNameCfg[13].name)

				arg_399_1.leftNameTxt_.text = var_402_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_18 = arg_399_1:GetWordFromCfg(317321096)
				local var_402_19 = arg_399_1:FormatText(var_402_18.content)

				arg_399_1.text_.text = var_402_19

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_20 = 3
				local var_402_21 = utf8.len(var_402_19)
				local var_402_22 = var_402_20 <= 0 and var_402_16 or var_402_16 * (var_402_21 / var_402_20)

				if var_402_22 > 0 and var_402_16 < var_402_22 then
					arg_399_1.talkMaxDuration = var_402_22

					if var_402_22 + var_402_15 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_22 + var_402_15
					end
				end

				arg_399_1.text_.text = var_402_19
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321096", "story_v_out_317321.awb") ~= 0 then
					local var_402_23 = manager.audio:GetVoiceLength("story_v_out_317321", "317321096", "story_v_out_317321.awb") / 1000

					if var_402_23 + var_402_15 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_23 + var_402_15
					end

					if var_402_18.prefab_name ~= "" and arg_399_1.actors_[var_402_18.prefab_name] ~= nil then
						local var_402_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_18.prefab_name].transform, "story_v_out_317321", "317321096", "story_v_out_317321.awb")

						arg_399_1:RecordAudio("317321096", var_402_24)
						arg_399_1:RecordAudio("317321096", var_402_24)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_317321", "317321096", "story_v_out_317321.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_317321", "317321096", "story_v_out_317321.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_25 = math.max(var_402_16, arg_399_1.talkMaxDuration)

			if var_402_15 <= arg_399_1.time_ and arg_399_1.time_ < var_402_15 + var_402_25 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_15) / var_402_25

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_15 + var_402_25 and arg_399_1.time_ < var_402_15 + var_402_25 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play317321097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 317321097
		arg_403_1.duration_ = 6.17

		local var_403_0 = {
			zh = 4.233,
			ja = 6.166
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play317321098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["1029ui_story"].transform
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1.var_.moveOldPos1029ui_story = var_406_0.localPosition
			end

			local var_406_2 = 0.001

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2
				local var_406_4 = Vector3.New(0.7, -1.09, -6.2)

				var_406_0.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1029ui_story, var_406_4, var_406_3)

				local var_406_5 = manager.ui.mainCamera.transform.position - var_406_0.position

				var_406_0.forward = Vector3.New(var_406_5.x, var_406_5.y, var_406_5.z)

				local var_406_6 = var_406_0.localEulerAngles

				var_406_6.z = 0
				var_406_6.x = 0
				var_406_0.localEulerAngles = var_406_6
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 then
				var_406_0.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_406_7 = manager.ui.mainCamera.transform.position - var_406_0.position

				var_406_0.forward = Vector3.New(var_406_7.x, var_406_7.y, var_406_7.z)

				local var_406_8 = var_406_0.localEulerAngles

				var_406_8.z = 0
				var_406_8.x = 0
				var_406_0.localEulerAngles = var_406_8
			end

			local var_406_9 = arg_403_1.actors_["1029ui_story"]
			local var_406_10 = 0

			if var_406_10 < arg_403_1.time_ and arg_403_1.time_ <= var_406_10 + arg_406_0 and not isNil(var_406_9) and arg_403_1.var_.characterEffect1029ui_story == nil then
				arg_403_1.var_.characterEffect1029ui_story = var_406_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_11 = 0.200000002980232

			if var_406_10 <= arg_403_1.time_ and arg_403_1.time_ < var_406_10 + var_406_11 and not isNil(var_406_9) then
				local var_406_12 = (arg_403_1.time_ - var_406_10) / var_406_11

				if arg_403_1.var_.characterEffect1029ui_story and not isNil(var_406_9) then
					arg_403_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= var_406_10 + var_406_11 and arg_403_1.time_ < var_406_10 + var_406_11 + arg_406_0 and not isNil(var_406_9) and arg_403_1.var_.characterEffect1029ui_story then
				arg_403_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_406_13 = 0

			if var_406_13 < arg_403_1.time_ and arg_403_1.time_ <= var_406_13 + arg_406_0 then
				arg_403_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action447")
			end

			local var_406_14 = 0

			if var_406_14 < arg_403_1.time_ and arg_403_1.time_ <= var_406_14 + arg_406_0 then
				arg_403_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_406_15 = arg_403_1.actors_["1019ui_story"]
			local var_406_16 = 0

			if var_406_16 < arg_403_1.time_ and arg_403_1.time_ <= var_406_16 + arg_406_0 and not isNil(var_406_15) and arg_403_1.var_.characterEffect1019ui_story == nil then
				arg_403_1.var_.characterEffect1019ui_story = var_406_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_17 = 0.200000002980232

			if var_406_16 <= arg_403_1.time_ and arg_403_1.time_ < var_406_16 + var_406_17 and not isNil(var_406_15) then
				local var_406_18 = (arg_403_1.time_ - var_406_16) / var_406_17

				if arg_403_1.var_.characterEffect1019ui_story and not isNil(var_406_15) then
					local var_406_19 = Mathf.Lerp(0, 0.5, var_406_18)

					arg_403_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1019ui_story.fillRatio = var_406_19
				end
			end

			if arg_403_1.time_ >= var_406_16 + var_406_17 and arg_403_1.time_ < var_406_16 + var_406_17 + arg_406_0 and not isNil(var_406_15) and arg_403_1.var_.characterEffect1019ui_story then
				local var_406_20 = 0.5

				arg_403_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1019ui_story.fillRatio = var_406_20
			end

			local var_406_21 = 0
			local var_406_22 = 0.275

			if var_406_21 < arg_403_1.time_ and arg_403_1.time_ <= var_406_21 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_23 = arg_403_1:FormatText(StoryNameCfg[319].name)

				arg_403_1.leftNameTxt_.text = var_406_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_24 = arg_403_1:GetWordFromCfg(317321097)
				local var_406_25 = arg_403_1:FormatText(var_406_24.content)

				arg_403_1.text_.text = var_406_25

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_26 = 11
				local var_406_27 = utf8.len(var_406_25)
				local var_406_28 = var_406_26 <= 0 and var_406_22 or var_406_22 * (var_406_27 / var_406_26)

				if var_406_28 > 0 and var_406_22 < var_406_28 then
					arg_403_1.talkMaxDuration = var_406_28

					if var_406_28 + var_406_21 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_28 + var_406_21
					end
				end

				arg_403_1.text_.text = var_406_25
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321097", "story_v_out_317321.awb") ~= 0 then
					local var_406_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321097", "story_v_out_317321.awb") / 1000

					if var_406_29 + var_406_21 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_29 + var_406_21
					end

					if var_406_24.prefab_name ~= "" and arg_403_1.actors_[var_406_24.prefab_name] ~= nil then
						local var_406_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_24.prefab_name].transform, "story_v_out_317321", "317321097", "story_v_out_317321.awb")

						arg_403_1:RecordAudio("317321097", var_406_30)
						arg_403_1:RecordAudio("317321097", var_406_30)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_317321", "317321097", "story_v_out_317321.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_317321", "317321097", "story_v_out_317321.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_31 = math.max(var_406_22, arg_403_1.talkMaxDuration)

			if var_406_21 <= arg_403_1.time_ and arg_403_1.time_ < var_406_21 + var_406_31 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_21) / var_406_31

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_21 + var_406_31 and arg_403_1.time_ < var_406_21 + var_406_31 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
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

		arg_403_1:InitPlayNodeList()
	end,
	Play317321098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 317321098
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play317321099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1029ui_story"]
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1029ui_story == nil then
				arg_407_1.var_.characterEffect1029ui_story = var_410_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.200000002980232

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 and not isNil(var_410_0) then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2

				if arg_407_1.var_.characterEffect1029ui_story and not isNil(var_410_0) then
					local var_410_4 = Mathf.Lerp(0, 0.5, var_410_3)

					arg_407_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1029ui_story.fillRatio = var_410_4
				end
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1029ui_story then
				local var_410_5 = 0.5

				arg_407_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1029ui_story.fillRatio = var_410_5
			end

			local var_410_6 = 0
			local var_410_7 = 1

			if var_410_6 < arg_407_1.time_ and arg_407_1.time_ <= var_410_6 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_8 = arg_407_1:GetWordFromCfg(317321098)
				local var_410_9 = arg_407_1:FormatText(var_410_8.content)

				arg_407_1.text_.text = var_410_9

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_10 = 40
				local var_410_11 = utf8.len(var_410_9)
				local var_410_12 = var_410_10 <= 0 and var_410_7 or var_410_7 * (var_410_11 / var_410_10)

				if var_410_12 > 0 and var_410_7 < var_410_12 then
					arg_407_1.talkMaxDuration = var_410_12

					if var_410_12 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_12 + var_410_6
					end
				end

				arg_407_1.text_.text = var_410_9
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_13 = math.max(var_410_7, arg_407_1.talkMaxDuration)

			if var_410_6 <= arg_407_1.time_ and arg_407_1.time_ < var_410_6 + var_410_13 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_6) / var_410_13

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_6 + var_410_13 and arg_407_1.time_ < var_410_6 + var_410_13 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play317321099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 317321099
		arg_411_1.duration_ = 11

		local var_411_0 = {
			zh = 8.633,
			ja = 11
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play317321100(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1029ui_story"].transform
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.var_.moveOldPos1029ui_story = var_414_0.localPosition
			end

			local var_414_2 = 0.001

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2
				local var_414_4 = Vector3.New(0.7, -1.09, -6.2)

				var_414_0.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1029ui_story, var_414_4, var_414_3)

				local var_414_5 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_5.x, var_414_5.y, var_414_5.z)

				local var_414_6 = var_414_0.localEulerAngles

				var_414_6.z = 0
				var_414_6.x = 0
				var_414_0.localEulerAngles = var_414_6
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 then
				var_414_0.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_414_7 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_7.x, var_414_7.y, var_414_7.z)

				local var_414_8 = var_414_0.localEulerAngles

				var_414_8.z = 0
				var_414_8.x = 0
				var_414_0.localEulerAngles = var_414_8
			end

			local var_414_9 = arg_411_1.actors_["1029ui_story"]
			local var_414_10 = 0

			if var_414_10 < arg_411_1.time_ and arg_411_1.time_ <= var_414_10 + arg_414_0 and not isNil(var_414_9) and arg_411_1.var_.characterEffect1029ui_story == nil then
				arg_411_1.var_.characterEffect1029ui_story = var_414_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_11 = 0.200000002980232

			if var_414_10 <= arg_411_1.time_ and arg_411_1.time_ < var_414_10 + var_414_11 and not isNil(var_414_9) then
				local var_414_12 = (arg_411_1.time_ - var_414_10) / var_414_11

				if arg_411_1.var_.characterEffect1029ui_story and not isNil(var_414_9) then
					arg_411_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= var_414_10 + var_414_11 and arg_411_1.time_ < var_414_10 + var_414_11 + arg_414_0 and not isNil(var_414_9) and arg_411_1.var_.characterEffect1029ui_story then
				arg_411_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_414_13 = 0

			if var_414_13 < arg_411_1.time_ and arg_411_1.time_ <= var_414_13 + arg_414_0 then
				arg_411_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action7_2")
			end

			local var_414_14 = 0

			if var_414_14 < arg_411_1.time_ and arg_411_1.time_ <= var_414_14 + arg_414_0 then
				arg_411_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_414_15 = 0
			local var_414_16 = 1.15

			if var_414_15 < arg_411_1.time_ and arg_411_1.time_ <= var_414_15 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_17 = arg_411_1:FormatText(StoryNameCfg[319].name)

				arg_411_1.leftNameTxt_.text = var_414_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_18 = arg_411_1:GetWordFromCfg(317321099)
				local var_414_19 = arg_411_1:FormatText(var_414_18.content)

				arg_411_1.text_.text = var_414_19

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_20 = 46
				local var_414_21 = utf8.len(var_414_19)
				local var_414_22 = var_414_20 <= 0 and var_414_16 or var_414_16 * (var_414_21 / var_414_20)

				if var_414_22 > 0 and var_414_16 < var_414_22 then
					arg_411_1.talkMaxDuration = var_414_22

					if var_414_22 + var_414_15 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_22 + var_414_15
					end
				end

				arg_411_1.text_.text = var_414_19
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321099", "story_v_out_317321.awb") ~= 0 then
					local var_414_23 = manager.audio:GetVoiceLength("story_v_out_317321", "317321099", "story_v_out_317321.awb") / 1000

					if var_414_23 + var_414_15 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_23 + var_414_15
					end

					if var_414_18.prefab_name ~= "" and arg_411_1.actors_[var_414_18.prefab_name] ~= nil then
						local var_414_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_18.prefab_name].transform, "story_v_out_317321", "317321099", "story_v_out_317321.awb")

						arg_411_1:RecordAudio("317321099", var_414_24)
						arg_411_1:RecordAudio("317321099", var_414_24)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_317321", "317321099", "story_v_out_317321.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_317321", "317321099", "story_v_out_317321.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_25 = math.max(var_414_16, arg_411_1.talkMaxDuration)

			if var_414_15 <= arg_411_1.time_ and arg_411_1.time_ < var_414_15 + var_414_25 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_15) / var_414_25

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_15 + var_414_25 and arg_411_1.time_ < var_414_15 + var_414_25 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
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

		arg_411_1:InitPlayNodeList()
	end,
	Play317321100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 317321100
		arg_415_1.duration_ = 9.9

		local var_415_0 = {
			zh = 5.6,
			ja = 9.9
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play317321101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0
			local var_418_1 = 0.725

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_2 = arg_415_1:FormatText(StoryNameCfg[319].name)

				arg_415_1.leftNameTxt_.text = var_418_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_3 = arg_415_1:GetWordFromCfg(317321100)
				local var_418_4 = arg_415_1:FormatText(var_418_3.content)

				arg_415_1.text_.text = var_418_4

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 29
				local var_418_6 = utf8.len(var_418_4)
				local var_418_7 = var_418_5 <= 0 and var_418_1 or var_418_1 * (var_418_6 / var_418_5)

				if var_418_7 > 0 and var_418_1 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_0
					end
				end

				arg_415_1.text_.text = var_418_4
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321100", "story_v_out_317321.awb") ~= 0 then
					local var_418_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321100", "story_v_out_317321.awb") / 1000

					if var_418_8 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_8 + var_418_0
					end

					if var_418_3.prefab_name ~= "" and arg_415_1.actors_[var_418_3.prefab_name] ~= nil then
						local var_418_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_3.prefab_name].transform, "story_v_out_317321", "317321100", "story_v_out_317321.awb")

						arg_415_1:RecordAudio("317321100", var_418_9)
						arg_415_1:RecordAudio("317321100", var_418_9)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_317321", "317321100", "story_v_out_317321.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_317321", "317321100", "story_v_out_317321.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_10 = math.max(var_418_1, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_10 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_0) / var_418_10

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_10 and arg_415_1.time_ < var_418_0 + var_418_10 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play317321101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 317321101
		arg_419_1.duration_ = 6.2

		local var_419_0 = {
			zh = 1.999999999999,
			ja = 6.2
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play317321102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["1019ui_story"].transform
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.var_.moveOldPos1019ui_story = var_422_0.localPosition
			end

			local var_422_2 = 0.001

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2
				local var_422_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_422_0.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1019ui_story, var_422_4, var_422_3)

				local var_422_5 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_5.x, var_422_5.y, var_422_5.z)

				local var_422_6 = var_422_0.localEulerAngles

				var_422_6.z = 0
				var_422_6.x = 0
				var_422_0.localEulerAngles = var_422_6
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 then
				var_422_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_422_7 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_7.x, var_422_7.y, var_422_7.z)

				local var_422_8 = var_422_0.localEulerAngles

				var_422_8.z = 0
				var_422_8.x = 0
				var_422_0.localEulerAngles = var_422_8
			end

			local var_422_9 = arg_419_1.actors_["1019ui_story"]
			local var_422_10 = 0

			if var_422_10 < arg_419_1.time_ and arg_419_1.time_ <= var_422_10 + arg_422_0 and not isNil(var_422_9) and arg_419_1.var_.characterEffect1019ui_story == nil then
				arg_419_1.var_.characterEffect1019ui_story = var_422_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_11 = 0.200000002980232

			if var_422_10 <= arg_419_1.time_ and arg_419_1.time_ < var_422_10 + var_422_11 and not isNil(var_422_9) then
				local var_422_12 = (arg_419_1.time_ - var_422_10) / var_422_11

				if arg_419_1.var_.characterEffect1019ui_story and not isNil(var_422_9) then
					arg_419_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= var_422_10 + var_422_11 and arg_419_1.time_ < var_422_10 + var_422_11 + arg_422_0 and not isNil(var_422_9) and arg_419_1.var_.characterEffect1019ui_story then
				arg_419_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_422_13 = 0

			if var_422_13 < arg_419_1.time_ and arg_419_1.time_ <= var_422_13 + arg_422_0 then
				arg_419_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			local var_422_14 = 0

			if var_422_14 < arg_419_1.time_ and arg_419_1.time_ <= var_422_14 + arg_422_0 then
				arg_419_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_422_15 = arg_419_1.actors_["1029ui_story"]
			local var_422_16 = 0

			if var_422_16 < arg_419_1.time_ and arg_419_1.time_ <= var_422_16 + arg_422_0 and not isNil(var_422_15) and arg_419_1.var_.characterEffect1029ui_story == nil then
				arg_419_1.var_.characterEffect1029ui_story = var_422_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_17 = 0.200000002980232

			if var_422_16 <= arg_419_1.time_ and arg_419_1.time_ < var_422_16 + var_422_17 and not isNil(var_422_15) then
				local var_422_18 = (arg_419_1.time_ - var_422_16) / var_422_17

				if arg_419_1.var_.characterEffect1029ui_story and not isNil(var_422_15) then
					local var_422_19 = Mathf.Lerp(0, 0.5, var_422_18)

					arg_419_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_419_1.var_.characterEffect1029ui_story.fillRatio = var_422_19
				end
			end

			if arg_419_1.time_ >= var_422_16 + var_422_17 and arg_419_1.time_ < var_422_16 + var_422_17 + arg_422_0 and not isNil(var_422_15) and arg_419_1.var_.characterEffect1029ui_story then
				local var_422_20 = 0.5

				arg_419_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_419_1.var_.characterEffect1029ui_story.fillRatio = var_422_20
			end

			local var_422_21 = 0
			local var_422_22 = 0.125

			if var_422_21 < arg_419_1.time_ and arg_419_1.time_ <= var_422_21 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_23 = arg_419_1:FormatText(StoryNameCfg[13].name)

				arg_419_1.leftNameTxt_.text = var_422_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_24 = arg_419_1:GetWordFromCfg(317321101)
				local var_422_25 = arg_419_1:FormatText(var_422_24.content)

				arg_419_1.text_.text = var_422_25

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_26 = 5
				local var_422_27 = utf8.len(var_422_25)
				local var_422_28 = var_422_26 <= 0 and var_422_22 or var_422_22 * (var_422_27 / var_422_26)

				if var_422_28 > 0 and var_422_22 < var_422_28 then
					arg_419_1.talkMaxDuration = var_422_28

					if var_422_28 + var_422_21 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_28 + var_422_21
					end
				end

				arg_419_1.text_.text = var_422_25
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321101", "story_v_out_317321.awb") ~= 0 then
					local var_422_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321101", "story_v_out_317321.awb") / 1000

					if var_422_29 + var_422_21 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_29 + var_422_21
					end

					if var_422_24.prefab_name ~= "" and arg_419_1.actors_[var_422_24.prefab_name] ~= nil then
						local var_422_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_24.prefab_name].transform, "story_v_out_317321", "317321101", "story_v_out_317321.awb")

						arg_419_1:RecordAudio("317321101", var_422_30)
						arg_419_1:RecordAudio("317321101", var_422_30)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_317321", "317321101", "story_v_out_317321.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_317321", "317321101", "story_v_out_317321.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_31 = math.max(var_422_22, arg_419_1.talkMaxDuration)

			if var_422_21 <= arg_419_1.time_ and arg_419_1.time_ < var_422_21 + var_422_31 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_21) / var_422_31

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_21 + var_422_31 and arg_419_1.time_ < var_422_21 + var_422_31 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play317321102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 317321102
		arg_423_1.duration_ = 9.7

		local var_423_0 = {
			zh = 3.7,
			ja = 9.7
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play317321103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1029ui_story"].transform
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.var_.moveOldPos1029ui_story = var_426_0.localPosition
			end

			local var_426_2 = 0.001

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2
				local var_426_4 = Vector3.New(0.7, -1.09, -6.2)

				var_426_0.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1029ui_story, var_426_4, var_426_3)

				local var_426_5 = manager.ui.mainCamera.transform.position - var_426_0.position

				var_426_0.forward = Vector3.New(var_426_5.x, var_426_5.y, var_426_5.z)

				local var_426_6 = var_426_0.localEulerAngles

				var_426_6.z = 0
				var_426_6.x = 0
				var_426_0.localEulerAngles = var_426_6
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 then
				var_426_0.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_426_7 = manager.ui.mainCamera.transform.position - var_426_0.position

				var_426_0.forward = Vector3.New(var_426_7.x, var_426_7.y, var_426_7.z)

				local var_426_8 = var_426_0.localEulerAngles

				var_426_8.z = 0
				var_426_8.x = 0
				var_426_0.localEulerAngles = var_426_8
			end

			local var_426_9 = arg_423_1.actors_["1029ui_story"]
			local var_426_10 = 0

			if var_426_10 < arg_423_1.time_ and arg_423_1.time_ <= var_426_10 + arg_426_0 and not isNil(var_426_9) and arg_423_1.var_.characterEffect1029ui_story == nil then
				arg_423_1.var_.characterEffect1029ui_story = var_426_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_11 = 0.200000002980232

			if var_426_10 <= arg_423_1.time_ and arg_423_1.time_ < var_426_10 + var_426_11 and not isNil(var_426_9) then
				local var_426_12 = (arg_423_1.time_ - var_426_10) / var_426_11

				if arg_423_1.var_.characterEffect1029ui_story and not isNil(var_426_9) then
					arg_423_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= var_426_10 + var_426_11 and arg_423_1.time_ < var_426_10 + var_426_11 + arg_426_0 and not isNil(var_426_9) and arg_423_1.var_.characterEffect1029ui_story then
				arg_423_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_426_13 = 0

			if var_426_13 < arg_423_1.time_ and arg_423_1.time_ <= var_426_13 + arg_426_0 then
				arg_423_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_426_14 = 0

			if var_426_14 < arg_423_1.time_ and arg_423_1.time_ <= var_426_14 + arg_426_0 then
				arg_423_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_426_15 = arg_423_1.actors_["1019ui_story"]
			local var_426_16 = 0

			if var_426_16 < arg_423_1.time_ and arg_423_1.time_ <= var_426_16 + arg_426_0 and not isNil(var_426_15) and arg_423_1.var_.characterEffect1019ui_story == nil then
				arg_423_1.var_.characterEffect1019ui_story = var_426_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_17 = 0.200000002980232

			if var_426_16 <= arg_423_1.time_ and arg_423_1.time_ < var_426_16 + var_426_17 and not isNil(var_426_15) then
				local var_426_18 = (arg_423_1.time_ - var_426_16) / var_426_17

				if arg_423_1.var_.characterEffect1019ui_story and not isNil(var_426_15) then
					local var_426_19 = Mathf.Lerp(0, 0.5, var_426_18)

					arg_423_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1019ui_story.fillRatio = var_426_19
				end
			end

			if arg_423_1.time_ >= var_426_16 + var_426_17 and arg_423_1.time_ < var_426_16 + var_426_17 + arg_426_0 and not isNil(var_426_15) and arg_423_1.var_.characterEffect1019ui_story then
				local var_426_20 = 0.5

				arg_423_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1019ui_story.fillRatio = var_426_20
			end

			local var_426_21 = 0
			local var_426_22 = 0.475

			if var_426_21 < arg_423_1.time_ and arg_423_1.time_ <= var_426_21 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_23 = arg_423_1:FormatText(StoryNameCfg[319].name)

				arg_423_1.leftNameTxt_.text = var_426_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_24 = arg_423_1:GetWordFromCfg(317321102)
				local var_426_25 = arg_423_1:FormatText(var_426_24.content)

				arg_423_1.text_.text = var_426_25

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_26 = 19
				local var_426_27 = utf8.len(var_426_25)
				local var_426_28 = var_426_26 <= 0 and var_426_22 or var_426_22 * (var_426_27 / var_426_26)

				if var_426_28 > 0 and var_426_22 < var_426_28 then
					arg_423_1.talkMaxDuration = var_426_28

					if var_426_28 + var_426_21 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_28 + var_426_21
					end
				end

				arg_423_1.text_.text = var_426_25
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321102", "story_v_out_317321.awb") ~= 0 then
					local var_426_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321102", "story_v_out_317321.awb") / 1000

					if var_426_29 + var_426_21 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_29 + var_426_21
					end

					if var_426_24.prefab_name ~= "" and arg_423_1.actors_[var_426_24.prefab_name] ~= nil then
						local var_426_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_24.prefab_name].transform, "story_v_out_317321", "317321102", "story_v_out_317321.awb")

						arg_423_1:RecordAudio("317321102", var_426_30)
						arg_423_1:RecordAudio("317321102", var_426_30)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_317321", "317321102", "story_v_out_317321.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_317321", "317321102", "story_v_out_317321.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_31 = math.max(var_426_22, arg_423_1.talkMaxDuration)

			if var_426_21 <= arg_423_1.time_ and arg_423_1.time_ < var_426_21 + var_426_31 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_21) / var_426_31

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_21 + var_426_31 and arg_423_1.time_ < var_426_21 + var_426_31 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
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

		arg_423_1:InitPlayNodeList()
	end,
	Play317321103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 317321103
		arg_427_1.duration_ = 2

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play317321104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["1019ui_story"].transform
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.var_.moveOldPos1019ui_story = var_430_0.localPosition
			end

			local var_430_2 = 0.001

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2
				local var_430_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_430_0.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1019ui_story, var_430_4, var_430_3)

				local var_430_5 = manager.ui.mainCamera.transform.position - var_430_0.position

				var_430_0.forward = Vector3.New(var_430_5.x, var_430_5.y, var_430_5.z)

				local var_430_6 = var_430_0.localEulerAngles

				var_430_6.z = 0
				var_430_6.x = 0
				var_430_0.localEulerAngles = var_430_6
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 then
				var_430_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_430_7 = manager.ui.mainCamera.transform.position - var_430_0.position

				var_430_0.forward = Vector3.New(var_430_7.x, var_430_7.y, var_430_7.z)

				local var_430_8 = var_430_0.localEulerAngles

				var_430_8.z = 0
				var_430_8.x = 0
				var_430_0.localEulerAngles = var_430_8
			end

			local var_430_9 = arg_427_1.actors_["1019ui_story"]
			local var_430_10 = 0

			if var_430_10 < arg_427_1.time_ and arg_427_1.time_ <= var_430_10 + arg_430_0 and not isNil(var_430_9) and arg_427_1.var_.characterEffect1019ui_story == nil then
				arg_427_1.var_.characterEffect1019ui_story = var_430_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_11 = 0.200000002980232

			if var_430_10 <= arg_427_1.time_ and arg_427_1.time_ < var_430_10 + var_430_11 and not isNil(var_430_9) then
				local var_430_12 = (arg_427_1.time_ - var_430_10) / var_430_11

				if arg_427_1.var_.characterEffect1019ui_story and not isNil(var_430_9) then
					arg_427_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_10 + var_430_11 and arg_427_1.time_ < var_430_10 + var_430_11 + arg_430_0 and not isNil(var_430_9) and arg_427_1.var_.characterEffect1019ui_story then
				arg_427_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_430_13 = 0

			if var_430_13 < arg_427_1.time_ and arg_427_1.time_ <= var_430_13 + arg_430_0 then
				arg_427_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_430_14 = 0

			if var_430_14 < arg_427_1.time_ and arg_427_1.time_ <= var_430_14 + arg_430_0 then
				arg_427_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_430_15 = arg_427_1.actors_["1029ui_story"]
			local var_430_16 = 0

			if var_430_16 < arg_427_1.time_ and arg_427_1.time_ <= var_430_16 + arg_430_0 and not isNil(var_430_15) and arg_427_1.var_.characterEffect1029ui_story == nil then
				arg_427_1.var_.characterEffect1029ui_story = var_430_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_17 = 0.200000002980232

			if var_430_16 <= arg_427_1.time_ and arg_427_1.time_ < var_430_16 + var_430_17 and not isNil(var_430_15) then
				local var_430_18 = (arg_427_1.time_ - var_430_16) / var_430_17

				if arg_427_1.var_.characterEffect1029ui_story and not isNil(var_430_15) then
					local var_430_19 = Mathf.Lerp(0, 0.5, var_430_18)

					arg_427_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1029ui_story.fillRatio = var_430_19
				end
			end

			if arg_427_1.time_ >= var_430_16 + var_430_17 and arg_427_1.time_ < var_430_16 + var_430_17 + arg_430_0 and not isNil(var_430_15) and arg_427_1.var_.characterEffect1029ui_story then
				local var_430_20 = 0.5

				arg_427_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1029ui_story.fillRatio = var_430_20
			end

			local var_430_21 = 0
			local var_430_22 = 0.1

			if var_430_21 < arg_427_1.time_ and arg_427_1.time_ <= var_430_21 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_23 = arg_427_1:FormatText(StoryNameCfg[13].name)

				arg_427_1.leftNameTxt_.text = var_430_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_24 = arg_427_1:GetWordFromCfg(317321103)
				local var_430_25 = arg_427_1:FormatText(var_430_24.content)

				arg_427_1.text_.text = var_430_25

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_26 = 4
				local var_430_27 = utf8.len(var_430_25)
				local var_430_28 = var_430_26 <= 0 and var_430_22 or var_430_22 * (var_430_27 / var_430_26)

				if var_430_28 > 0 and var_430_22 < var_430_28 then
					arg_427_1.talkMaxDuration = var_430_28

					if var_430_28 + var_430_21 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_28 + var_430_21
					end
				end

				arg_427_1.text_.text = var_430_25
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321103", "story_v_out_317321.awb") ~= 0 then
					local var_430_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321103", "story_v_out_317321.awb") / 1000

					if var_430_29 + var_430_21 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_29 + var_430_21
					end

					if var_430_24.prefab_name ~= "" and arg_427_1.actors_[var_430_24.prefab_name] ~= nil then
						local var_430_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_24.prefab_name].transform, "story_v_out_317321", "317321103", "story_v_out_317321.awb")

						arg_427_1:RecordAudio("317321103", var_430_30)
						arg_427_1:RecordAudio("317321103", var_430_30)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_317321", "317321103", "story_v_out_317321.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_317321", "317321103", "story_v_out_317321.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_31 = math.max(var_430_22, arg_427_1.talkMaxDuration)

			if var_430_21 <= arg_427_1.time_ and arg_427_1.time_ < var_430_21 + var_430_31 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_21) / var_430_31

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_21 + var_430_31 and arg_427_1.time_ < var_430_21 + var_430_31 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play317321104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 317321104
		arg_431_1.duration_ = 4.83

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play317321105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1029ui_story"].transform
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.var_.moveOldPos1029ui_story = var_434_0.localPosition
			end

			local var_434_2 = 0.001

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2
				local var_434_4 = Vector3.New(0.7, -1.09, -6.2)

				var_434_0.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1029ui_story, var_434_4, var_434_3)

				local var_434_5 = manager.ui.mainCamera.transform.position - var_434_0.position

				var_434_0.forward = Vector3.New(var_434_5.x, var_434_5.y, var_434_5.z)

				local var_434_6 = var_434_0.localEulerAngles

				var_434_6.z = 0
				var_434_6.x = 0
				var_434_0.localEulerAngles = var_434_6
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 then
				var_434_0.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_434_7 = manager.ui.mainCamera.transform.position - var_434_0.position

				var_434_0.forward = Vector3.New(var_434_7.x, var_434_7.y, var_434_7.z)

				local var_434_8 = var_434_0.localEulerAngles

				var_434_8.z = 0
				var_434_8.x = 0
				var_434_0.localEulerAngles = var_434_8
			end

			local var_434_9 = arg_431_1.actors_["1029ui_story"]
			local var_434_10 = 0

			if var_434_10 < arg_431_1.time_ and arg_431_1.time_ <= var_434_10 + arg_434_0 and not isNil(var_434_9) and arg_431_1.var_.characterEffect1029ui_story == nil then
				arg_431_1.var_.characterEffect1029ui_story = var_434_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_11 = 0.200000002980232

			if var_434_10 <= arg_431_1.time_ and arg_431_1.time_ < var_434_10 + var_434_11 and not isNil(var_434_9) then
				local var_434_12 = (arg_431_1.time_ - var_434_10) / var_434_11

				if arg_431_1.var_.characterEffect1029ui_story and not isNil(var_434_9) then
					arg_431_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= var_434_10 + var_434_11 and arg_431_1.time_ < var_434_10 + var_434_11 + arg_434_0 and not isNil(var_434_9) and arg_431_1.var_.characterEffect1029ui_story then
				arg_431_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_434_13 = 0

			if var_434_13 < arg_431_1.time_ and arg_431_1.time_ <= var_434_13 + arg_434_0 then
				arg_431_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action6_1")
			end

			local var_434_14 = 0

			if var_434_14 < arg_431_1.time_ and arg_431_1.time_ <= var_434_14 + arg_434_0 then
				arg_431_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_434_15 = arg_431_1.actors_["1019ui_story"]
			local var_434_16 = 0

			if var_434_16 < arg_431_1.time_ and arg_431_1.time_ <= var_434_16 + arg_434_0 and not isNil(var_434_15) and arg_431_1.var_.characterEffect1019ui_story == nil then
				arg_431_1.var_.characterEffect1019ui_story = var_434_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_17 = 0.200000002980232

			if var_434_16 <= arg_431_1.time_ and arg_431_1.time_ < var_434_16 + var_434_17 and not isNil(var_434_15) then
				local var_434_18 = (arg_431_1.time_ - var_434_16) / var_434_17

				if arg_431_1.var_.characterEffect1019ui_story and not isNil(var_434_15) then
					local var_434_19 = Mathf.Lerp(0, 0.5, var_434_18)

					arg_431_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1019ui_story.fillRatio = var_434_19
				end
			end

			if arg_431_1.time_ >= var_434_16 + var_434_17 and arg_431_1.time_ < var_434_16 + var_434_17 + arg_434_0 and not isNil(var_434_15) and arg_431_1.var_.characterEffect1019ui_story then
				local var_434_20 = 0.5

				arg_431_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1019ui_story.fillRatio = var_434_20
			end

			local var_434_21 = 0
			local var_434_22 = 0.55

			if var_434_21 < arg_431_1.time_ and arg_431_1.time_ <= var_434_21 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_23 = arg_431_1:FormatText(StoryNameCfg[319].name)

				arg_431_1.leftNameTxt_.text = var_434_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_24 = arg_431_1:GetWordFromCfg(317321104)
				local var_434_25 = arg_431_1:FormatText(var_434_24.content)

				arg_431_1.text_.text = var_434_25

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_26 = 22
				local var_434_27 = utf8.len(var_434_25)
				local var_434_28 = var_434_26 <= 0 and var_434_22 or var_434_22 * (var_434_27 / var_434_26)

				if var_434_28 > 0 and var_434_22 < var_434_28 then
					arg_431_1.talkMaxDuration = var_434_28

					if var_434_28 + var_434_21 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_28 + var_434_21
					end
				end

				arg_431_1.text_.text = var_434_25
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321104", "story_v_out_317321.awb") ~= 0 then
					local var_434_29 = manager.audio:GetVoiceLength("story_v_out_317321", "317321104", "story_v_out_317321.awb") / 1000

					if var_434_29 + var_434_21 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_29 + var_434_21
					end

					if var_434_24.prefab_name ~= "" and arg_431_1.actors_[var_434_24.prefab_name] ~= nil then
						local var_434_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_24.prefab_name].transform, "story_v_out_317321", "317321104", "story_v_out_317321.awb")

						arg_431_1:RecordAudio("317321104", var_434_30)
						arg_431_1:RecordAudio("317321104", var_434_30)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_317321", "317321104", "story_v_out_317321.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_317321", "317321104", "story_v_out_317321.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_31 = math.max(var_434_22, arg_431_1.talkMaxDuration)

			if var_434_21 <= arg_431_1.time_ and arg_431_1.time_ < var_434_21 + var_434_31 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_21) / var_434_31

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_21 + var_434_31 and arg_431_1.time_ < var_434_21 + var_434_31 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
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

		arg_431_1:InitPlayNodeList()
	end,
	Play317321105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 317321105
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play317321106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1019ui_story"].transform
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.var_.moveOldPos1019ui_story = var_438_0.localPosition
			end

			local var_438_2 = 0.001

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2
				local var_438_4 = Vector3.New(0, 100, 0)

				var_438_0.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1019ui_story, var_438_4, var_438_3)

				local var_438_5 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_5.x, var_438_5.y, var_438_5.z)

				local var_438_6 = var_438_0.localEulerAngles

				var_438_6.z = 0
				var_438_6.x = 0
				var_438_0.localEulerAngles = var_438_6
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 then
				var_438_0.localPosition = Vector3.New(0, 100, 0)

				local var_438_7 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_7.x, var_438_7.y, var_438_7.z)

				local var_438_8 = var_438_0.localEulerAngles

				var_438_8.z = 0
				var_438_8.x = 0
				var_438_0.localEulerAngles = var_438_8
			end

			local var_438_9 = arg_435_1.actors_["1029ui_story"].transform
			local var_438_10 = 0

			if var_438_10 < arg_435_1.time_ and arg_435_1.time_ <= var_438_10 + arg_438_0 then
				arg_435_1.var_.moveOldPos1029ui_story = var_438_9.localPosition
			end

			local var_438_11 = 0.001

			if var_438_10 <= arg_435_1.time_ and arg_435_1.time_ < var_438_10 + var_438_11 then
				local var_438_12 = (arg_435_1.time_ - var_438_10) / var_438_11
				local var_438_13 = Vector3.New(0, 100, 0)

				var_438_9.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1029ui_story, var_438_13, var_438_12)

				local var_438_14 = manager.ui.mainCamera.transform.position - var_438_9.position

				var_438_9.forward = Vector3.New(var_438_14.x, var_438_14.y, var_438_14.z)

				local var_438_15 = var_438_9.localEulerAngles

				var_438_15.z = 0
				var_438_15.x = 0
				var_438_9.localEulerAngles = var_438_15
			end

			if arg_435_1.time_ >= var_438_10 + var_438_11 and arg_435_1.time_ < var_438_10 + var_438_11 + arg_438_0 then
				var_438_9.localPosition = Vector3.New(0, 100, 0)

				local var_438_16 = manager.ui.mainCamera.transform.position - var_438_9.position

				var_438_9.forward = Vector3.New(var_438_16.x, var_438_16.y, var_438_16.z)

				local var_438_17 = var_438_9.localEulerAngles

				var_438_17.z = 0
				var_438_17.x = 0
				var_438_9.localEulerAngles = var_438_17
			end

			local var_438_18 = 0
			local var_438_19 = 0.925

			if var_438_18 < arg_435_1.time_ and arg_435_1.time_ <= var_438_18 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_20 = arg_435_1:GetWordFromCfg(317321105)
				local var_438_21 = arg_435_1:FormatText(var_438_20.content)

				arg_435_1.text_.text = var_438_21

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_22 = 37
				local var_438_23 = utf8.len(var_438_21)
				local var_438_24 = var_438_22 <= 0 and var_438_19 or var_438_19 * (var_438_23 / var_438_22)

				if var_438_24 > 0 and var_438_19 < var_438_24 then
					arg_435_1.talkMaxDuration = var_438_24

					if var_438_24 + var_438_18 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_24 + var_438_18
					end
				end

				arg_435_1.text_.text = var_438_21
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_25 = math.max(var_438_19, arg_435_1.talkMaxDuration)

			if var_438_18 <= arg_435_1.time_ and arg_435_1.time_ < var_438_18 + var_438_25 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_18) / var_438_25

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_18 + var_438_25 and arg_435_1.time_ < var_438_18 + var_438_25 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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

		arg_435_1:InitPlayNodeList()
	end,
	Play317321106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 317321106
		arg_439_1.duration_ = 6.87

		local var_439_0 = {
			zh = 4.3,
			ja = 6.866
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play317321107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 0.475

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_2 = arg_439_1:FormatText(StoryNameCfg[319].name)

				arg_439_1.leftNameTxt_.text = var_442_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_3 = arg_439_1:GetWordFromCfg(317321106)
				local var_442_4 = arg_439_1:FormatText(var_442_3.content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 17
				local var_442_6 = utf8.len(var_442_4)
				local var_442_7 = var_442_5 <= 0 and var_442_1 or var_442_1 * (var_442_6 / var_442_5)

				if var_442_7 > 0 and var_442_1 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_4
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321106", "story_v_out_317321.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321106", "story_v_out_317321.awb") / 1000

					if var_442_8 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_0
					end

					if var_442_3.prefab_name ~= "" and arg_439_1.actors_[var_442_3.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_3.prefab_name].transform, "story_v_out_317321", "317321106", "story_v_out_317321.awb")

						arg_439_1:RecordAudio("317321106", var_442_9)
						arg_439_1:RecordAudio("317321106", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_317321", "317321106", "story_v_out_317321.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_317321", "317321106", "story_v_out_317321.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_10 and arg_439_1.time_ < var_442_0 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play317321107 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 317321107
		arg_443_1.duration_ = 4.67

		local var_443_0 = {
			zh = 1.999999999999,
			ja = 4.666
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play317321108(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["1019ui_story"].transform
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.var_.moveOldPos1019ui_story = var_446_0.localPosition
			end

			local var_446_2 = 0.001

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2
				local var_446_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_446_0.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1019ui_story, var_446_4, var_446_3)

				local var_446_5 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_5.x, var_446_5.y, var_446_5.z)

				local var_446_6 = var_446_0.localEulerAngles

				var_446_6.z = 0
				var_446_6.x = 0
				var_446_0.localEulerAngles = var_446_6
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 then
				var_446_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_446_7 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_7.x, var_446_7.y, var_446_7.z)

				local var_446_8 = var_446_0.localEulerAngles

				var_446_8.z = 0
				var_446_8.x = 0
				var_446_0.localEulerAngles = var_446_8
			end

			local var_446_9 = arg_443_1.actors_["1019ui_story"]
			local var_446_10 = 0

			if var_446_10 < arg_443_1.time_ and arg_443_1.time_ <= var_446_10 + arg_446_0 and not isNil(var_446_9) and arg_443_1.var_.characterEffect1019ui_story == nil then
				arg_443_1.var_.characterEffect1019ui_story = var_446_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_11 = 0.200000002980232

			if var_446_10 <= arg_443_1.time_ and arg_443_1.time_ < var_446_10 + var_446_11 and not isNil(var_446_9) then
				local var_446_12 = (arg_443_1.time_ - var_446_10) / var_446_11

				if arg_443_1.var_.characterEffect1019ui_story and not isNil(var_446_9) then
					arg_443_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= var_446_10 + var_446_11 and arg_443_1.time_ < var_446_10 + var_446_11 + arg_446_0 and not isNil(var_446_9) and arg_443_1.var_.characterEffect1019ui_story then
				arg_443_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_446_13 = 0

			if var_446_13 < arg_443_1.time_ and arg_443_1.time_ <= var_446_13 + arg_446_0 then
				arg_443_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_446_14 = 0

			if var_446_14 < arg_443_1.time_ and arg_443_1.time_ <= var_446_14 + arg_446_0 then
				arg_443_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_446_15 = 0
			local var_446_16 = 0.2

			if var_446_15 < arg_443_1.time_ and arg_443_1.time_ <= var_446_15 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_17 = arg_443_1:FormatText(StoryNameCfg[13].name)

				arg_443_1.leftNameTxt_.text = var_446_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_18 = arg_443_1:GetWordFromCfg(317321107)
				local var_446_19 = arg_443_1:FormatText(var_446_18.content)

				arg_443_1.text_.text = var_446_19

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_20 = 8
				local var_446_21 = utf8.len(var_446_19)
				local var_446_22 = var_446_20 <= 0 and var_446_16 or var_446_16 * (var_446_21 / var_446_20)

				if var_446_22 > 0 and var_446_16 < var_446_22 then
					arg_443_1.talkMaxDuration = var_446_22

					if var_446_22 + var_446_15 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_22 + var_446_15
					end
				end

				arg_443_1.text_.text = var_446_19
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321107", "story_v_out_317321.awb") ~= 0 then
					local var_446_23 = manager.audio:GetVoiceLength("story_v_out_317321", "317321107", "story_v_out_317321.awb") / 1000

					if var_446_23 + var_446_15 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_23 + var_446_15
					end

					if var_446_18.prefab_name ~= "" and arg_443_1.actors_[var_446_18.prefab_name] ~= nil then
						local var_446_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_18.prefab_name].transform, "story_v_out_317321", "317321107", "story_v_out_317321.awb")

						arg_443_1:RecordAudio("317321107", var_446_24)
						arg_443_1:RecordAudio("317321107", var_446_24)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_317321", "317321107", "story_v_out_317321.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_317321", "317321107", "story_v_out_317321.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_25 = math.max(var_446_16, arg_443_1.talkMaxDuration)

			if var_446_15 <= arg_443_1.time_ and arg_443_1.time_ < var_446_15 + var_446_25 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_15) / var_446_25

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_15 + var_446_25 and arg_443_1.time_ < var_446_15 + var_446_25 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play317321108 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 317321108
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play317321109(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["1019ui_story"].transform
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.var_.moveOldPos1019ui_story = var_450_0.localPosition
			end

			local var_450_2 = 0.001

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_2 then
				local var_450_3 = (arg_447_1.time_ - var_450_1) / var_450_2
				local var_450_4 = Vector3.New(0, 100, 0)

				var_450_0.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1019ui_story, var_450_4, var_450_3)

				local var_450_5 = manager.ui.mainCamera.transform.position - var_450_0.position

				var_450_0.forward = Vector3.New(var_450_5.x, var_450_5.y, var_450_5.z)

				local var_450_6 = var_450_0.localEulerAngles

				var_450_6.z = 0
				var_450_6.x = 0
				var_450_0.localEulerAngles = var_450_6
			end

			if arg_447_1.time_ >= var_450_1 + var_450_2 and arg_447_1.time_ < var_450_1 + var_450_2 + arg_450_0 then
				var_450_0.localPosition = Vector3.New(0, 100, 0)

				local var_450_7 = manager.ui.mainCamera.transform.position - var_450_0.position

				var_450_0.forward = Vector3.New(var_450_7.x, var_450_7.y, var_450_7.z)

				local var_450_8 = var_450_0.localEulerAngles

				var_450_8.z = 0
				var_450_8.x = 0
				var_450_0.localEulerAngles = var_450_8
			end

			local var_450_9 = 0
			local var_450_10 = 0.6

			if var_450_9 < arg_447_1.time_ and arg_447_1.time_ <= var_450_9 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_11 = arg_447_1:GetWordFromCfg(317321108)
				local var_450_12 = arg_447_1:FormatText(var_450_11.content)

				arg_447_1.text_.text = var_450_12

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_13 = 24
				local var_450_14 = utf8.len(var_450_12)
				local var_450_15 = var_450_13 <= 0 and var_450_10 or var_450_10 * (var_450_14 / var_450_13)

				if var_450_15 > 0 and var_450_10 < var_450_15 then
					arg_447_1.talkMaxDuration = var_450_15

					if var_450_15 + var_450_9 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_15 + var_450_9
					end
				end

				arg_447_1.text_.text = var_450_12
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_16 = math.max(var_450_10, arg_447_1.talkMaxDuration)

			if var_450_9 <= arg_447_1.time_ and arg_447_1.time_ < var_450_9 + var_450_16 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_9) / var_450_16

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_9 + var_450_16 and arg_447_1.time_ < var_450_9 + var_450_16 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play317321109 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 317321109
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play317321110(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0
			local var_454_1 = 1.075

			if var_454_0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_2 = arg_451_1:GetWordFromCfg(317321109)
				local var_454_3 = arg_451_1:FormatText(var_454_2.content)

				arg_451_1.text_.text = var_454_3

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_4 = 43
				local var_454_5 = utf8.len(var_454_3)
				local var_454_6 = var_454_4 <= 0 and var_454_1 or var_454_1 * (var_454_5 / var_454_4)

				if var_454_6 > 0 and var_454_1 < var_454_6 then
					arg_451_1.talkMaxDuration = var_454_6

					if var_454_6 + var_454_0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_6 + var_454_0
					end
				end

				arg_451_1.text_.text = var_454_3
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_7 = math.max(var_454_1, arg_451_1.talkMaxDuration)

			if var_454_0 <= arg_451_1.time_ and arg_451_1.time_ < var_454_0 + var_454_7 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_0) / var_454_7

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_0 + var_454_7 and arg_451_1.time_ < var_454_0 + var_454_7 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play317321110 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 317321110
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play317321111(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0
			local var_458_1 = 0.475

			if var_458_0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_2 = arg_455_1:GetWordFromCfg(317321110)
				local var_458_3 = arg_455_1:FormatText(var_458_2.content)

				arg_455_1.text_.text = var_458_3

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_4 = 19
				local var_458_5 = utf8.len(var_458_3)
				local var_458_6 = var_458_4 <= 0 and var_458_1 or var_458_1 * (var_458_5 / var_458_4)

				if var_458_6 > 0 and var_458_1 < var_458_6 then
					arg_455_1.talkMaxDuration = var_458_6

					if var_458_6 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_6 + var_458_0
					end
				end

				arg_455_1.text_.text = var_458_3
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_7 = math.max(var_458_1, arg_455_1.talkMaxDuration)

			if var_458_0 <= arg_455_1.time_ and arg_455_1.time_ < var_458_0 + var_458_7 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_0) / var_458_7

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_0 + var_458_7 and arg_455_1.time_ < var_458_0 + var_458_7 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play317321111 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 317321111
		arg_459_1.duration_ = 3.03

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play317321112(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.fswbg_:SetActive(true)
				arg_459_1.dialog_:SetActive(false)

				arg_459_1.fswtw_.percent = 0

				local var_462_1 = arg_459_1:GetWordFromCfg(317321111)
				local var_462_2 = arg_459_1:FormatText(var_462_1.content)

				arg_459_1.fswt_.text = var_462_2

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.fswt_)

				arg_459_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_459_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_459_1.fswtw_:SetDirty()

				arg_459_1.typewritterCharCountI18N = 0

				SetActive(arg_459_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_459_1:ShowNextGo(false)
			end

			local var_462_3 = 0.033

			if var_462_3 < arg_459_1.time_ and arg_459_1.time_ <= var_462_3 + arg_462_0 then
				arg_459_1.var_.oldValueTypewriter = arg_459_1.fswtw_.percent

				SetActive(arg_459_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_459_1:ShowNextGo(false)
			end

			local var_462_4 = 13
			local var_462_5 = 3
			local var_462_6 = arg_459_1:GetWordFromCfg(317321111)
			local var_462_7 = arg_459_1:FormatText(var_462_6.content)
			local var_462_8, var_462_9 = arg_459_1:GetPercentByPara(var_462_7, 1)

			if var_462_3 < arg_459_1.time_ and arg_459_1.time_ <= var_462_3 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0

				local var_462_10 = var_462_4 <= 0 and var_462_5 or var_462_5 * ((var_462_9 - arg_459_1.typewritterCharCountI18N) / var_462_4)

				if var_462_10 > 0 and var_462_5 < var_462_10 then
					arg_459_1.talkMaxDuration = var_462_10

					if var_462_10 + var_462_3 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_10 + var_462_3
					end
				end
			end

			local var_462_11 = 3
			local var_462_12 = math.max(var_462_11, arg_459_1.talkMaxDuration)

			if var_462_3 <= arg_459_1.time_ and arg_459_1.time_ < var_462_3 + var_462_12 then
				local var_462_13 = (arg_459_1.time_ - var_462_3) / var_462_12

				arg_459_1.fswtw_.percent = Mathf.Lerp(arg_459_1.var_.oldValueTypewriter, var_462_8, var_462_13)
				arg_459_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_459_1.fswtw_:SetDirty()
			end

			if arg_459_1.time_ >= var_462_3 + var_462_12 and arg_459_1.time_ < var_462_3 + var_462_12 + arg_462_0 then
				arg_459_1.fswtw_.percent = var_462_8

				arg_459_1.fswtw_:SetDirty()
				arg_459_1:ShowNextGo(true)

				arg_459_1.typewritterCharCountI18N = var_462_9
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play317321112 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 317321112
		arg_463_1.duration_ = 3

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play317321113(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.var_.oldValueTypewriter = arg_463_1.fswtw_.percent

				SetActive(arg_463_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_463_1:ShowNextGo(false)
			end

			local var_466_1 = 41
			local var_466_2 = 3
			local var_466_3 = arg_463_1:GetWordFromCfg(317321111)
			local var_466_4 = arg_463_1:FormatText(var_466_3.content)
			local var_466_5, var_466_6 = arg_463_1:GetPercentByPara(var_466_4, 2)

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0

				local var_466_7 = var_466_1 <= 0 and var_466_2 or var_466_2 * ((var_466_6 - arg_463_1.typewritterCharCountI18N) / var_466_1)

				if var_466_7 > 0 and var_466_2 < var_466_7 then
					arg_463_1.talkMaxDuration = var_466_7

					if var_466_7 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_0
					end
				end
			end

			local var_466_8 = 3
			local var_466_9 = math.max(var_466_8, arg_463_1.talkMaxDuration)

			if var_466_0 <= arg_463_1.time_ and arg_463_1.time_ < var_466_0 + var_466_9 then
				local var_466_10 = (arg_463_1.time_ - var_466_0) / var_466_9

				arg_463_1.fswtw_.percent = Mathf.Lerp(arg_463_1.var_.oldValueTypewriter, var_466_5, var_466_10)
				arg_463_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_463_1.fswtw_:SetDirty()
			end

			if arg_463_1.time_ >= var_466_0 + var_466_9 and arg_463_1.time_ < var_466_0 + var_466_9 + arg_466_0 then
				arg_463_1.fswtw_.percent = var_466_5

				arg_463_1.fswtw_:SetDirty()
				arg_463_1:ShowNextGo(true)

				arg_463_1.typewritterCharCountI18N = var_466_6
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play317321113 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 317321113
		arg_467_1.duration_ = 3

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play317321114(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				arg_467_1.var_.oldValueTypewriter = arg_467_1.fswtw_.percent

				SetActive(arg_467_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_467_1:ShowNextGo(false)
			end

			local var_470_1 = 20
			local var_470_2 = 3
			local var_470_3 = arg_467_1:GetWordFromCfg(317321111)
			local var_470_4 = arg_467_1:FormatText(var_470_3.content)
			local var_470_5, var_470_6 = arg_467_1:GetPercentByPara(var_470_4, 3)

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0

				local var_470_7 = var_470_1 <= 0 and var_470_2 or var_470_2 * ((var_470_6 - arg_467_1.typewritterCharCountI18N) / var_470_1)

				if var_470_7 > 0 and var_470_2 < var_470_7 then
					arg_467_1.talkMaxDuration = var_470_7

					if var_470_7 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_7 + var_470_0
					end
				end
			end

			local var_470_8 = 3
			local var_470_9 = math.max(var_470_8, arg_467_1.talkMaxDuration)

			if var_470_0 <= arg_467_1.time_ and arg_467_1.time_ < var_470_0 + var_470_9 then
				local var_470_10 = (arg_467_1.time_ - var_470_0) / var_470_9

				arg_467_1.fswtw_.percent = Mathf.Lerp(arg_467_1.var_.oldValueTypewriter, var_470_5, var_470_10)
				arg_467_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_467_1.fswtw_:SetDirty()
			end

			if arg_467_1.time_ >= var_470_0 + var_470_9 and arg_467_1.time_ < var_470_0 + var_470_9 + arg_470_0 then
				arg_467_1.fswtw_.percent = var_470_5

				arg_467_1.fswtw_:SetDirty()
				arg_467_1:ShowNextGo(true)

				arg_467_1.typewritterCharCountI18N = var_470_6
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play317321114 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 317321114
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play317321115(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0

			if var_474_0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_0 + arg_474_0 then
				arg_471_1.fswbg_:SetActive(false)
				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_471_1:ShowNextGo(false)
			end

			local var_474_1 = 0
			local var_474_2 = 1

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_3 = arg_471_1:GetWordFromCfg(317321114)
				local var_474_4 = arg_471_1:FormatText(var_474_3.content)

				arg_471_1.text_.text = var_474_4

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_5 = 40
				local var_474_6 = utf8.len(var_474_4)
				local var_474_7 = var_474_5 <= 0 and var_474_2 or var_474_2 * (var_474_6 / var_474_5)

				if var_474_7 > 0 and var_474_2 < var_474_7 then
					arg_471_1.talkMaxDuration = var_474_7

					if var_474_7 + var_474_1 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_7 + var_474_1
					end
				end

				arg_471_1.text_.text = var_474_4
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_8 = math.max(var_474_2, arg_471_1.talkMaxDuration)

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_8 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_1) / var_474_8

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_1 + var_474_8 and arg_471_1.time_ < var_474_1 + var_474_8 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play317321115 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 317321115
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play317321116(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0
			local var_478_1 = 1.35

			if var_478_0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, false)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_2 = arg_475_1:GetWordFromCfg(317321115)
				local var_478_3 = arg_475_1:FormatText(var_478_2.content)

				arg_475_1.text_.text = var_478_3

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_4 = 54
				local var_478_5 = utf8.len(var_478_3)
				local var_478_6 = var_478_4 <= 0 and var_478_1 or var_478_1 * (var_478_5 / var_478_4)

				if var_478_6 > 0 and var_478_1 < var_478_6 then
					arg_475_1.talkMaxDuration = var_478_6

					if var_478_6 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_6 + var_478_0
					end
				end

				arg_475_1.text_.text = var_478_3
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_7 = math.max(var_478_1, arg_475_1.talkMaxDuration)

			if var_478_0 <= arg_475_1.time_ and arg_475_1.time_ < var_478_0 + var_478_7 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_0) / var_478_7

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_0 + var_478_7 and arg_475_1.time_ < var_478_0 + var_478_7 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play317321116 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 317321116
		arg_479_1.duration_ = 3.87

		local var_479_0 = {
			zh = 3.866,
			ja = 3.233
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play317321117(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["1019ui_story"].transform
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 then
				arg_479_1.var_.moveOldPos1019ui_story = var_482_0.localPosition
			end

			local var_482_2 = 0.001

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_2 then
				local var_482_3 = (arg_479_1.time_ - var_482_1) / var_482_2
				local var_482_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_482_0.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos1019ui_story, var_482_4, var_482_3)

				local var_482_5 = manager.ui.mainCamera.transform.position - var_482_0.position

				var_482_0.forward = Vector3.New(var_482_5.x, var_482_5.y, var_482_5.z)

				local var_482_6 = var_482_0.localEulerAngles

				var_482_6.z = 0
				var_482_6.x = 0
				var_482_0.localEulerAngles = var_482_6
			end

			if arg_479_1.time_ >= var_482_1 + var_482_2 and arg_479_1.time_ < var_482_1 + var_482_2 + arg_482_0 then
				var_482_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_482_7 = manager.ui.mainCamera.transform.position - var_482_0.position

				var_482_0.forward = Vector3.New(var_482_7.x, var_482_7.y, var_482_7.z)

				local var_482_8 = var_482_0.localEulerAngles

				var_482_8.z = 0
				var_482_8.x = 0
				var_482_0.localEulerAngles = var_482_8
			end

			local var_482_9 = arg_479_1.actors_["1019ui_story"]
			local var_482_10 = 0

			if var_482_10 < arg_479_1.time_ and arg_479_1.time_ <= var_482_10 + arg_482_0 and not isNil(var_482_9) and arg_479_1.var_.characterEffect1019ui_story == nil then
				arg_479_1.var_.characterEffect1019ui_story = var_482_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_11 = 0.200000002980232

			if var_482_10 <= arg_479_1.time_ and arg_479_1.time_ < var_482_10 + var_482_11 and not isNil(var_482_9) then
				local var_482_12 = (arg_479_1.time_ - var_482_10) / var_482_11

				if arg_479_1.var_.characterEffect1019ui_story and not isNil(var_482_9) then
					arg_479_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_479_1.time_ >= var_482_10 + var_482_11 and arg_479_1.time_ < var_482_10 + var_482_11 + arg_482_0 and not isNil(var_482_9) and arg_479_1.var_.characterEffect1019ui_story then
				arg_479_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_482_13 = 0

			if var_482_13 < arg_479_1.time_ and arg_479_1.time_ <= var_482_13 + arg_482_0 then
				arg_479_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_482_14 = 0

			if var_482_14 < arg_479_1.time_ and arg_479_1.time_ <= var_482_14 + arg_482_0 then
				arg_479_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_482_15 = 0
			local var_482_16 = 0.4

			if var_482_15 < arg_479_1.time_ and arg_479_1.time_ <= var_482_15 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_17 = arg_479_1:FormatText(StoryNameCfg[13].name)

				arg_479_1.leftNameTxt_.text = var_482_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_18 = arg_479_1:GetWordFromCfg(317321116)
				local var_482_19 = arg_479_1:FormatText(var_482_18.content)

				arg_479_1.text_.text = var_482_19

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_20 = 16
				local var_482_21 = utf8.len(var_482_19)
				local var_482_22 = var_482_20 <= 0 and var_482_16 or var_482_16 * (var_482_21 / var_482_20)

				if var_482_22 > 0 and var_482_16 < var_482_22 then
					arg_479_1.talkMaxDuration = var_482_22

					if var_482_22 + var_482_15 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_22 + var_482_15
					end
				end

				arg_479_1.text_.text = var_482_19
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321116", "story_v_out_317321.awb") ~= 0 then
					local var_482_23 = manager.audio:GetVoiceLength("story_v_out_317321", "317321116", "story_v_out_317321.awb") / 1000

					if var_482_23 + var_482_15 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_23 + var_482_15
					end

					if var_482_18.prefab_name ~= "" and arg_479_1.actors_[var_482_18.prefab_name] ~= nil then
						local var_482_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_18.prefab_name].transform, "story_v_out_317321", "317321116", "story_v_out_317321.awb")

						arg_479_1:RecordAudio("317321116", var_482_24)
						arg_479_1:RecordAudio("317321116", var_482_24)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_317321", "317321116", "story_v_out_317321.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_317321", "317321116", "story_v_out_317321.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_25 = math.max(var_482_16, arg_479_1.talkMaxDuration)

			if var_482_15 <= arg_479_1.time_ and arg_479_1.time_ < var_482_15 + var_482_25 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_15) / var_482_25

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_15 + var_482_25 and arg_479_1.time_ < var_482_15 + var_482_25 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play317321117 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 317321117
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play317321118(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = arg_483_1.actors_["1019ui_story"].transform
			local var_486_1 = 0

			if var_486_1 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 then
				arg_483_1.var_.moveOldPos1019ui_story = var_486_0.localPosition
			end

			local var_486_2 = 0.001

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_2 then
				local var_486_3 = (arg_483_1.time_ - var_486_1) / var_486_2
				local var_486_4 = Vector3.New(0, 100, 0)

				var_486_0.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos1019ui_story, var_486_4, var_486_3)

				local var_486_5 = manager.ui.mainCamera.transform.position - var_486_0.position

				var_486_0.forward = Vector3.New(var_486_5.x, var_486_5.y, var_486_5.z)

				local var_486_6 = var_486_0.localEulerAngles

				var_486_6.z = 0
				var_486_6.x = 0
				var_486_0.localEulerAngles = var_486_6
			end

			if arg_483_1.time_ >= var_486_1 + var_486_2 and arg_483_1.time_ < var_486_1 + var_486_2 + arg_486_0 then
				var_486_0.localPosition = Vector3.New(0, 100, 0)

				local var_486_7 = manager.ui.mainCamera.transform.position - var_486_0.position

				var_486_0.forward = Vector3.New(var_486_7.x, var_486_7.y, var_486_7.z)

				local var_486_8 = var_486_0.localEulerAngles

				var_486_8.z = 0
				var_486_8.x = 0
				var_486_0.localEulerAngles = var_486_8
			end

			local var_486_9 = 0
			local var_486_10 = 0.6

			if var_486_9 < arg_483_1.time_ and arg_483_1.time_ <= var_486_9 + arg_486_0 then
				local var_486_11 = "play"
				local var_486_12 = "effect"

				arg_483_1:AudioAction(var_486_11, var_486_12, "se_story_127", "se_story_127_message", "")
			end

			local var_486_13 = 0
			local var_486_14 = 1.425

			if var_486_13 < arg_483_1.time_ and arg_483_1.time_ <= var_486_13 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_15 = arg_483_1:GetWordFromCfg(317321117)
				local var_486_16 = arg_483_1:FormatText(var_486_15.content)

				arg_483_1.text_.text = var_486_16

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_17 = 57
				local var_486_18 = utf8.len(var_486_16)
				local var_486_19 = var_486_17 <= 0 and var_486_14 or var_486_14 * (var_486_18 / var_486_17)

				if var_486_19 > 0 and var_486_14 < var_486_19 then
					arg_483_1.talkMaxDuration = var_486_19

					if var_486_19 + var_486_13 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_19 + var_486_13
					end
				end

				arg_483_1.text_.text = var_486_16
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_20 = math.max(var_486_14, arg_483_1.talkMaxDuration)

			if var_486_13 <= arg_483_1.time_ and arg_483_1.time_ < var_486_13 + var_486_20 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_13) / var_486_20

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_13 + var_486_20 and arg_483_1.time_ < var_486_13 + var_486_20 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_483_1:InitPlayNodeList()
	end,
	Play317321118 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 317321118
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play317321119(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0
			local var_490_1 = 0.5

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_2 = arg_487_1:GetWordFromCfg(317321118)
				local var_490_3 = arg_487_1:FormatText(var_490_2.content)

				arg_487_1.text_.text = var_490_3

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_4 = 20
				local var_490_5 = utf8.len(var_490_3)
				local var_490_6 = var_490_4 <= 0 and var_490_1 or var_490_1 * (var_490_5 / var_490_4)

				if var_490_6 > 0 and var_490_1 < var_490_6 then
					arg_487_1.talkMaxDuration = var_490_6

					if var_490_6 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_6 + var_490_0
					end
				end

				arg_487_1.text_.text = var_490_3
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_1, arg_487_1.talkMaxDuration)

			if var_490_0 <= arg_487_1.time_ and arg_487_1.time_ < var_490_0 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_0) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_0 + var_490_7 and arg_487_1.time_ < var_490_0 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play317321119 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 317321119
		arg_491_1.duration_ = 5.88

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
			arg_491_1.auto_ = false
		end

		function arg_491_1.playNext_(arg_493_0)
			arg_491_1.onStoryFinished_()
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = "STblack"

			if arg_491_1.bgs_[var_494_0] == nil then
				local var_494_1 = Object.Instantiate(arg_491_1.paintGo_)

				var_494_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_494_0)
				var_494_1.name = var_494_0
				var_494_1.transform.parent = arg_491_1.stage_.transform
				var_494_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_491_1.bgs_[var_494_0] = var_494_1
			end

			local var_494_2 = 2

			if var_494_2 < arg_491_1.time_ and arg_491_1.time_ <= var_494_2 + arg_494_0 then
				local var_494_3 = manager.ui.mainCamera.transform.localPosition
				local var_494_4 = Vector3.New(0, 0, 10) + Vector3.New(var_494_3.x, var_494_3.y, 0)
				local var_494_5 = arg_491_1.bgs_.STblack

				var_494_5.transform.localPosition = var_494_4
				var_494_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_494_6 = var_494_5:GetComponent("SpriteRenderer")

				if var_494_6 and var_494_6.sprite then
					local var_494_7 = (var_494_5.transform.localPosition - var_494_3).z
					local var_494_8 = manager.ui.mainCameraCom_
					local var_494_9 = 2 * var_494_7 * Mathf.Tan(var_494_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_494_10 = var_494_9 * var_494_8.aspect
					local var_494_11 = var_494_6.sprite.bounds.size.x
					local var_494_12 = var_494_6.sprite.bounds.size.y
					local var_494_13 = var_494_10 / var_494_11
					local var_494_14 = var_494_9 / var_494_12
					local var_494_15 = var_494_14 < var_494_13 and var_494_13 or var_494_14

					var_494_5.transform.localScale = Vector3.New(var_494_15, var_494_15, 0)
				end

				for iter_494_0, iter_494_1 in pairs(arg_491_1.bgs_) do
					if iter_494_0 ~= "STblack" then
						iter_494_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_494_16 = 0

			if var_494_16 < arg_491_1.time_ and arg_491_1.time_ <= var_494_16 + arg_494_0 then
				arg_491_1.mask_.enabled = true
				arg_491_1.mask_.raycastTarget = true

				arg_491_1:SetGaussion(false)
			end

			local var_494_17 = 2

			if var_494_16 <= arg_491_1.time_ and arg_491_1.time_ < var_494_16 + var_494_17 then
				local var_494_18 = (arg_491_1.time_ - var_494_16) / var_494_17
				local var_494_19 = Color.New(0, 0, 0)

				var_494_19.a = Mathf.Lerp(0, 1, var_494_18)
				arg_491_1.mask_.color = var_494_19
			end

			if arg_491_1.time_ >= var_494_16 + var_494_17 and arg_491_1.time_ < var_494_16 + var_494_17 + arg_494_0 then
				local var_494_20 = Color.New(0, 0, 0)

				var_494_20.a = 1
				arg_491_1.mask_.color = var_494_20
			end

			local var_494_21 = 2

			if var_494_21 < arg_491_1.time_ and arg_491_1.time_ <= var_494_21 + arg_494_0 then
				arg_491_1.mask_.enabled = true
				arg_491_1.mask_.raycastTarget = true

				arg_491_1:SetGaussion(false)
			end

			local var_494_22 = 2

			if var_494_21 <= arg_491_1.time_ and arg_491_1.time_ < var_494_21 + var_494_22 then
				local var_494_23 = (arg_491_1.time_ - var_494_21) / var_494_22
				local var_494_24 = Color.New(0, 0, 0)

				var_494_24.a = Mathf.Lerp(1, 0, var_494_23)
				arg_491_1.mask_.color = var_494_24
			end

			if arg_491_1.time_ >= var_494_21 + var_494_22 and arg_491_1.time_ < var_494_21 + var_494_22 + arg_494_0 then
				local var_494_25 = Color.New(0, 0, 0)
				local var_494_26 = 0

				arg_491_1.mask_.enabled = false
				var_494_25.a = var_494_26
				arg_491_1.mask_.color = var_494_25
			end

			local var_494_27 = 4

			if var_494_27 < arg_491_1.time_ and arg_491_1.time_ <= var_494_27 + arg_494_0 then
				arg_491_1.fswbg_:SetActive(true)
				arg_491_1.dialog_:SetActive(false)

				arg_491_1.fswtw_.percent = 0

				local var_494_28 = arg_491_1:GetWordFromCfg(317321119)
				local var_494_29 = arg_491_1:FormatText(var_494_28.content)

				arg_491_1.fswt_.text = var_494_29

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.fswt_)

				arg_491_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_491_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_491_1.fswtw_:SetDirty()

				arg_491_1.typewritterCharCountI18N = 0

				SetActive(arg_491_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_491_1:ShowNextGo(false)
			end

			local var_494_30 = 4.01666666666667

			if var_494_30 < arg_491_1.time_ and arg_491_1.time_ <= var_494_30 + arg_494_0 then
				arg_491_1.var_.oldValueTypewriter = arg_491_1.fswtw_.percent

				SetActive(arg_491_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_491_1:ShowNextGo(false)
			end

			local var_494_31 = 28
			local var_494_32 = 1.86666666666667
			local var_494_33 = arg_491_1:GetWordFromCfg(317321119)
			local var_494_34 = arg_491_1:FormatText(var_494_33.content)
			local var_494_35, var_494_36 = arg_491_1:GetPercentByPara(var_494_34, 1)

			if var_494_30 < arg_491_1.time_ and arg_491_1.time_ <= var_494_30 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0

				local var_494_37 = var_494_31 <= 0 and var_494_32 or var_494_32 * ((var_494_36 - arg_491_1.typewritterCharCountI18N) / var_494_31)

				if var_494_37 > 0 and var_494_32 < var_494_37 then
					arg_491_1.talkMaxDuration = var_494_37

					if var_494_37 + var_494_30 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_37 + var_494_30
					end
				end
			end

			local var_494_38 = 1.86666666666667
			local var_494_39 = math.max(var_494_38, arg_491_1.talkMaxDuration)

			if var_494_30 <= arg_491_1.time_ and arg_491_1.time_ < var_494_30 + var_494_39 then
				local var_494_40 = (arg_491_1.time_ - var_494_30) / var_494_39

				arg_491_1.fswtw_.percent = Mathf.Lerp(arg_491_1.var_.oldValueTypewriter, var_494_35, var_494_40)
				arg_491_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_491_1.fswtw_:SetDirty()
			end

			if arg_491_1.time_ >= var_494_30 + var_494_39 and arg_491_1.time_ < var_494_30 + var_494_39 + arg_494_0 then
				arg_491_1.fswtw_.percent = var_494_35

				arg_491_1.fswtw_:SetDirty()
				arg_491_1:ShowNextGo(true)

				arg_491_1.typewritterCharCountI18N = var_494_36
			end

			local var_494_41 = 4

			if var_494_41 < arg_491_1.time_ and arg_491_1.time_ <= var_494_41 + arg_494_0 then
				local var_494_42 = arg_491_1.fswbg_.transform:Find("textbox/adapt/content") or arg_491_1.fswbg_.transform:Find("textbox/content")
				local var_494_43 = arg_491_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_494_44 = var_494_42:GetComponent("Text")
				local var_494_45 = var_494_42:GetComponent("RectTransform")

				var_494_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_494_45.offsetMin = Vector2.New(0, 0)
				var_494_45.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K09f",
		"TextureConfig/Background/K11g",
		"TextureConfig/Background/YA0207",
		"TextureConfig/Background/S0012",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_317321.awb"
	}
}
