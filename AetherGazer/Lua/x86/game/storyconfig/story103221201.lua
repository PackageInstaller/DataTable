return {
	Play322121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322121001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L14f"

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
				local var_4_5 = arg_1_1.bgs_.L14f

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
					if iter_4_0 ~= "L14f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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

			local var_4_24 = 0.2
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_145", "se_story_145_amb_drone_haizhen", "")
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

			local var_4_34 = 0.500666666666667
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "music"

				arg_1_1:AudioAction(var_4_36, var_4_37, "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious.awb")

				local var_4_38 = ""
				local var_4_39 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious")

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

			local var_4_40 = 0.51
			local var_4_41 = 1

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				local var_4_42 = "play"
				local var_4_43 = "music"

				arg_1_1:AudioAction(var_4_42, var_4_43, "bgm_activity_4_5_story_serious", "init_battle", "bgm_activity_4_5_story_serious.awb")

				local var_4_44 = ""
				local var_4_45 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_battle")

				if var_4_45 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_45 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_45

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_45
						arg_1_1.bgmTxt2_.text = var_4_45
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

			local var_4_46 = 2
			local var_4_47 = 0.8

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_48 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_48:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_49 = arg_1_1:GetWordFromCfg(322121001)
				local var_4_50 = arg_1_1:FormatText(var_4_49.content)

				arg_1_1.text_.text = var_4_50

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_51 = 32
				local var_4_52 = utf8.len(var_4_50)
				local var_4_53 = var_4_51 <= 0 and var_4_47 or var_4_47 * (var_4_52 / var_4_51)

				if var_4_53 > 0 and var_4_47 < var_4_53 then
					arg_1_1.talkMaxDuration = var_4_53
					var_4_46 = var_4_46 + 0.3

					if var_4_53 + var_4_46 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_53 + var_4_46
					end
				end

				arg_1_1.text_.text = var_4_50
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_54 = var_4_46 + 0.3
			local var_4_55 = math.max(var_4_47, arg_1_1.talkMaxDuration)

			if var_4_54 <= arg_1_1.time_ and arg_1_1.time_ < var_4_54 + var_4_55 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_54) / var_4_55

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play322121002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 322121002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play322121003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0
			local var_13_1 = 1.05

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_2 = arg_10_1:GetWordFromCfg(322121002)
				local var_13_3 = arg_10_1:FormatText(var_13_2.content)

				arg_10_1.text_.text = var_13_3

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_4 = 42
				local var_13_5 = utf8.len(var_13_3)
				local var_13_6 = var_13_4 <= 0 and var_13_1 or var_13_1 * (var_13_5 / var_13_4)

				if var_13_6 > 0 and var_13_1 < var_13_6 then
					arg_10_1.talkMaxDuration = var_13_6

					if var_13_6 + var_13_0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_6 + var_13_0
					end
				end

				arg_10_1.text_.text = var_13_3
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_7 = math.max(var_13_1, arg_10_1.talkMaxDuration)

			if var_13_0 <= arg_10_1.time_ and arg_10_1.time_ < var_13_0 + var_13_7 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_0) / var_13_7

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_0 + var_13_7 and arg_10_1.time_ < var_13_0 + var_13_7 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play322121003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 322121003
		arg_14_1.duration_ = 6.2

		local var_14_0 = {
			zh = 4.066,
			ja = 6.2
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play322121004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = "6056ui_story"

			if arg_14_1.actors_[var_17_0] == nil then
				local var_17_1 = Asset.Load("Char/" .. "6056ui_story")

				if not isNil(var_17_1) then
					local var_17_2 = Object.Instantiate(Asset.Load("Char/" .. "6056ui_story"), arg_14_1.stage_.transform)

					var_17_2.name = var_17_0
					var_17_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_14_1.actors_[var_17_0] = var_17_2

					local var_17_3 = var_17_2:GetComponentInChildren(typeof(CharacterEffect))

					var_17_3.enabled = true

					local var_17_4 = GameObjectTools.GetOrAddComponent(var_17_2, typeof(DynamicBoneHelper))

					if var_17_4 then
						var_17_4:EnableDynamicBone(false)
					end

					arg_14_1:ShowWeapon(var_17_3.transform, false)

					arg_14_1.var_[var_17_0 .. "Animator"] = var_17_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_14_1.var_[var_17_0 .. "Animator"].applyRootMotion = true
					arg_14_1.var_[var_17_0 .. "LipSync"] = var_17_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_17_5 = arg_14_1.actors_["6056ui_story"]
			local var_17_6 = 0

			if var_17_6 < arg_14_1.time_ and arg_14_1.time_ <= var_17_6 + arg_17_0 then
				if arg_14_1.var_.characterEffect6056ui_story == nil then
					arg_14_1.var_.characterEffect6056ui_story = var_17_5:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_17_7 = arg_14_1.var_.characterEffect6056ui_story

				var_17_7.imageEffect:turnOff()

				var_17_7.interferenceEffect.enabled = true
				var_17_7.interferenceEffect.noise = 0
				var_17_7.interferenceEffect.simTimeScale = 1
				var_17_7.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_17_8 = arg_14_1.actors_["6056ui_story"]
			local var_17_9 = 0
			local var_17_10 = 3.5

			if var_17_9 < arg_14_1.time_ and arg_14_1.time_ <= var_17_9 + arg_17_0 then
				if arg_14_1.var_.characterEffect6056ui_story == nil then
					arg_14_1.var_.characterEffect6056ui_story = var_17_8:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_14_1.var_.characterEffect6056ui_story.imageEffect:turnOn(false)
			end

			local var_17_11 = arg_14_1.actors_["6056ui_story"].transform
			local var_17_12 = 0

			if var_17_12 < arg_14_1.time_ and arg_14_1.time_ <= var_17_12 + arg_17_0 then
				arg_14_1.var_.moveOldPos6056ui_story = var_17_11.localPosition
			end

			local var_17_13 = 0.001

			if var_17_12 <= arg_14_1.time_ and arg_14_1.time_ < var_17_12 + var_17_13 then
				local var_17_14 = (arg_14_1.time_ - var_17_12) / var_17_13
				local var_17_15 = Vector3.New(0.15, -1.16, -6.15)

				var_17_11.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos6056ui_story, var_17_15, var_17_14)

				local var_17_16 = manager.ui.mainCamera.transform.position - var_17_11.position

				var_17_11.forward = Vector3.New(var_17_16.x, var_17_16.y, var_17_16.z)

				local var_17_17 = var_17_11.localEulerAngles

				var_17_17.z = 0
				var_17_17.x = 0
				var_17_11.localEulerAngles = var_17_17
			end

			if arg_14_1.time_ >= var_17_12 + var_17_13 and arg_14_1.time_ < var_17_12 + var_17_13 + arg_17_0 then
				var_17_11.localPosition = Vector3.New(0.15, -1.16, -6.15)

				local var_17_18 = manager.ui.mainCamera.transform.position - var_17_11.position

				var_17_11.forward = Vector3.New(var_17_18.x, var_17_18.y, var_17_18.z)

				local var_17_19 = var_17_11.localEulerAngles

				var_17_19.z = 0
				var_17_19.x = 0
				var_17_11.localEulerAngles = var_17_19
			end

			local var_17_20 = arg_14_1.actors_["6056ui_story"]
			local var_17_21 = 0

			if var_17_21 < arg_14_1.time_ and arg_14_1.time_ <= var_17_21 + arg_17_0 and not isNil(var_17_20) and arg_14_1.var_.characterEffect6056ui_story == nil then
				arg_14_1.var_.characterEffect6056ui_story = var_17_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_22 = 0.200000002980232

			if var_17_21 <= arg_14_1.time_ and arg_14_1.time_ < var_17_21 + var_17_22 and not isNil(var_17_20) then
				local var_17_23 = (arg_14_1.time_ - var_17_21) / var_17_22

				if arg_14_1.var_.characterEffect6056ui_story and not isNil(var_17_20) then
					arg_14_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_14_1.time_ >= var_17_21 + var_17_22 and arg_14_1.time_ < var_17_21 + var_17_22 + arg_17_0 and not isNil(var_17_20) and arg_14_1.var_.characterEffect6056ui_story then
				arg_14_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_17_24 = 0

			if var_17_24 < arg_14_1.time_ and arg_14_1.time_ <= var_17_24 + arg_17_0 then
				arg_14_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action1_1")
			end

			local var_17_25 = 0

			if var_17_25 < arg_14_1.time_ and arg_14_1.time_ <= var_17_25 + arg_17_0 then
				arg_14_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_17_26 = 0
			local var_17_27 = 0.45

			if var_17_26 < arg_14_1.time_ and arg_14_1.time_ <= var_17_26 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_28 = arg_14_1:FormatText(StoryNameCfg[613].name)

				arg_14_1.leftNameTxt_.text = var_17_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_29 = arg_14_1:GetWordFromCfg(322121003)
				local var_17_30 = arg_14_1:FormatText(var_17_29.content)

				arg_14_1.text_.text = var_17_30

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_31 = 18
				local var_17_32 = utf8.len(var_17_30)
				local var_17_33 = var_17_31 <= 0 and var_17_27 or var_17_27 * (var_17_32 / var_17_31)

				if var_17_33 > 0 and var_17_27 < var_17_33 then
					arg_14_1.talkMaxDuration = var_17_33

					if var_17_33 + var_17_26 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_33 + var_17_26
					end
				end

				arg_14_1.text_.text = var_17_30
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121003", "story_v_out_322121.awb") ~= 0 then
					local var_17_34 = manager.audio:GetVoiceLength("story_v_out_322121", "322121003", "story_v_out_322121.awb") / 1000

					if var_17_34 + var_17_26 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_34 + var_17_26
					end

					if var_17_29.prefab_name ~= "" and arg_14_1.actors_[var_17_29.prefab_name] ~= nil then
						local var_17_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_29.prefab_name].transform, "story_v_out_322121", "322121003", "story_v_out_322121.awb")

						arg_14_1:RecordAudio("322121003", var_17_35)
						arg_14_1:RecordAudio("322121003", var_17_35)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_322121", "322121003", "story_v_out_322121.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_322121", "322121003", "story_v_out_322121.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_36 = math.max(var_17_27, arg_14_1.talkMaxDuration)

			if var_17_26 <= arg_14_1.time_ and arg_14_1.time_ < var_17_26 + var_17_36 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_26) / var_17_36

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_26 + var_17_36 and arg_14_1.time_ < var_17_26 + var_17_36 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play322121004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 322121004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play322121005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["6056ui_story"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.characterEffect6056ui_story == nil then
				arg_18_1.var_.characterEffect6056ui_story = var_21_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_2 = 0.200000002980232

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.characterEffect6056ui_story and not isNil(var_21_0) then
					local var_21_4 = Mathf.Lerp(0, 0.5, var_21_3)

					arg_18_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_18_1.var_.characterEffect6056ui_story.fillRatio = var_21_4
				end
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.characterEffect6056ui_story then
				local var_21_5 = 0.5

				arg_18_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_18_1.var_.characterEffect6056ui_story.fillRatio = var_21_5
			end

			local var_21_6 = 0
			local var_21_7 = 0.35

			if var_21_6 < arg_18_1.time_ and arg_18_1.time_ <= var_21_6 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_8 = arg_18_1:FormatText(StoryNameCfg[7].name)

				arg_18_1.leftNameTxt_.text = var_21_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_9 = arg_18_1:GetWordFromCfg(322121004)
				local var_21_10 = arg_18_1:FormatText(var_21_9.content)

				arg_18_1.text_.text = var_21_10

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_11 = 14
				local var_21_12 = utf8.len(var_21_10)
				local var_21_13 = var_21_11 <= 0 and var_21_7 or var_21_7 * (var_21_12 / var_21_11)

				if var_21_13 > 0 and var_21_7 < var_21_13 then
					arg_18_1.talkMaxDuration = var_21_13

					if var_21_13 + var_21_6 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_13 + var_21_6
					end
				end

				arg_18_1.text_.text = var_21_10
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_14 = math.max(var_21_7, arg_18_1.talkMaxDuration)

			if var_21_6 <= arg_18_1.time_ and arg_18_1.time_ < var_21_6 + var_21_14 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_6) / var_21_14

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_6 + var_21_14 and arg_18_1.time_ < var_21_6 + var_21_14 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play322121005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 322121005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play322121006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0
			local var_25_1 = 0.275

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_2 = arg_22_1:FormatText(StoryNameCfg[7].name)

				arg_22_1.leftNameTxt_.text = var_25_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_3 = arg_22_1:GetWordFromCfg(322121005)
				local var_25_4 = arg_22_1:FormatText(var_25_3.content)

				arg_22_1.text_.text = var_25_4

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_5 = 11
				local var_25_6 = utf8.len(var_25_4)
				local var_25_7 = var_25_5 <= 0 and var_25_1 or var_25_1 * (var_25_6 / var_25_5)

				if var_25_7 > 0 and var_25_1 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_0
					end
				end

				arg_22_1.text_.text = var_25_4
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_8 = math.max(var_25_1, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_8 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_0) / var_25_8

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_8 and arg_22_1.time_ < var_25_0 + var_25_8 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play322121006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 322121006
		arg_26_1.duration_ = 4.47

		local var_26_0 = {
			zh = 3.499999999999,
			ja = 4.466
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
				arg_26_0:Play322121007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["6056ui_story"].transform
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.var_.moveOldPos6056ui_story = var_29_0.localPosition
			end

			local var_29_2 = 0.001

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2
				local var_29_4 = Vector3.New(0.15, -1.16, -6.15)

				var_29_0.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos6056ui_story, var_29_4, var_29_3)

				local var_29_5 = manager.ui.mainCamera.transform.position - var_29_0.position

				var_29_0.forward = Vector3.New(var_29_5.x, var_29_5.y, var_29_5.z)

				local var_29_6 = var_29_0.localEulerAngles

				var_29_6.z = 0
				var_29_6.x = 0
				var_29_0.localEulerAngles = var_29_6
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 then
				var_29_0.localPosition = Vector3.New(0.15, -1.16, -6.15)

				local var_29_7 = manager.ui.mainCamera.transform.position - var_29_0.position

				var_29_0.forward = Vector3.New(var_29_7.x, var_29_7.y, var_29_7.z)

				local var_29_8 = var_29_0.localEulerAngles

				var_29_8.z = 0
				var_29_8.x = 0
				var_29_0.localEulerAngles = var_29_8
			end

			local var_29_9 = arg_26_1.actors_["6056ui_story"]
			local var_29_10 = 0

			if var_29_10 < arg_26_1.time_ and arg_26_1.time_ <= var_29_10 + arg_29_0 and not isNil(var_29_9) and arg_26_1.var_.characterEffect6056ui_story == nil then
				arg_26_1.var_.characterEffect6056ui_story = var_29_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_11 = 0.200000002980232

			if var_29_10 <= arg_26_1.time_ and arg_26_1.time_ < var_29_10 + var_29_11 and not isNil(var_29_9) then
				local var_29_12 = (arg_26_1.time_ - var_29_10) / var_29_11

				if arg_26_1.var_.characterEffect6056ui_story and not isNil(var_29_9) then
					arg_26_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_10 + var_29_11 and arg_26_1.time_ < var_29_10 + var_29_11 + arg_29_0 and not isNil(var_29_9) and arg_26_1.var_.characterEffect6056ui_story then
				arg_26_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_29_13 = 0

			if var_29_13 < arg_26_1.time_ and arg_26_1.time_ <= var_29_13 + arg_29_0 then
				arg_26_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action2_1")
			end

			local var_29_14 = arg_26_1.actors_["6056ui_story"]
			local var_29_15 = 0

			if var_29_15 < arg_26_1.time_ and arg_26_1.time_ <= var_29_15 + arg_29_0 then
				if arg_26_1.var_.characterEffect6056ui_story == nil then
					arg_26_1.var_.characterEffect6056ui_story = var_29_14:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_29_16 = arg_26_1.var_.characterEffect6056ui_story

				var_29_16.imageEffect:turnOff()

				var_29_16.interferenceEffect.enabled = true
				var_29_16.interferenceEffect.noise = 0
				var_29_16.interferenceEffect.simTimeScale = 1
				var_29_16.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_29_17 = arg_26_1.actors_["6056ui_story"]
			local var_29_18 = 0
			local var_29_19 = 3.5

			if var_29_18 < arg_26_1.time_ and arg_26_1.time_ <= var_29_18 + arg_29_0 then
				if arg_26_1.var_.characterEffect6056ui_story == nil then
					arg_26_1.var_.characterEffect6056ui_story = var_29_17:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_26_1.var_.characterEffect6056ui_story.imageEffect:turnOn(false)
			end

			local var_29_20 = 0
			local var_29_21 = 0.45

			if var_29_20 < arg_26_1.time_ and arg_26_1.time_ <= var_29_20 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_22 = arg_26_1:FormatText(StoryNameCfg[613].name)

				arg_26_1.leftNameTxt_.text = var_29_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_23 = arg_26_1:GetWordFromCfg(322121006)
				local var_29_24 = arg_26_1:FormatText(var_29_23.content)

				arg_26_1.text_.text = var_29_24

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_25 = 18
				local var_29_26 = utf8.len(var_29_24)
				local var_29_27 = var_29_25 <= 0 and var_29_21 or var_29_21 * (var_29_26 / var_29_25)

				if var_29_27 > 0 and var_29_21 < var_29_27 then
					arg_26_1.talkMaxDuration = var_29_27

					if var_29_27 + var_29_20 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_27 + var_29_20
					end
				end

				arg_26_1.text_.text = var_29_24
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121006", "story_v_out_322121.awb") ~= 0 then
					local var_29_28 = manager.audio:GetVoiceLength("story_v_out_322121", "322121006", "story_v_out_322121.awb") / 1000

					if var_29_28 + var_29_20 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_28 + var_29_20
					end

					if var_29_23.prefab_name ~= "" and arg_26_1.actors_[var_29_23.prefab_name] ~= nil then
						local var_29_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_23.prefab_name].transform, "story_v_out_322121", "322121006", "story_v_out_322121.awb")

						arg_26_1:RecordAudio("322121006", var_29_29)
						arg_26_1:RecordAudio("322121006", var_29_29)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_322121", "322121006", "story_v_out_322121.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_322121", "322121006", "story_v_out_322121.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_30 = math.max(var_29_21, arg_26_1.talkMaxDuration)

			if var_29_20 <= arg_26_1.time_ and arg_26_1.time_ < var_29_20 + var_29_30 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_20) / var_29_30

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_20 + var_29_30 and arg_26_1.time_ < var_29_20 + var_29_30 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play322121007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 322121007
		arg_30_1.duration_ = 13.7

		local var_30_0 = {
			zh = 8.466,
			ja = 13.7
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play322121008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["6056ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect6056ui_story == nil then
				arg_30_1.var_.characterEffect6056ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.200000002980232

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect6056ui_story and not isNil(var_33_0) then
					arg_30_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect6056ui_story then
				arg_30_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_33_4 = 0
			local var_33_5 = 0.975

			if var_33_4 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_6 = arg_30_1:FormatText(StoryNameCfg[613].name)

				arg_30_1.leftNameTxt_.text = var_33_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_7 = arg_30_1:GetWordFromCfg(322121007)
				local var_33_8 = arg_30_1:FormatText(var_33_7.content)

				arg_30_1.text_.text = var_33_8

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_9 = 39
				local var_33_10 = utf8.len(var_33_8)
				local var_33_11 = var_33_9 <= 0 and var_33_5 or var_33_5 * (var_33_10 / var_33_9)

				if var_33_11 > 0 and var_33_5 < var_33_11 then
					arg_30_1.talkMaxDuration = var_33_11

					if var_33_11 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_11 + var_33_4
					end
				end

				arg_30_1.text_.text = var_33_8
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121007", "story_v_out_322121.awb") ~= 0 then
					local var_33_12 = manager.audio:GetVoiceLength("story_v_out_322121", "322121007", "story_v_out_322121.awb") / 1000

					if var_33_12 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_12 + var_33_4
					end

					if var_33_7.prefab_name ~= "" and arg_30_1.actors_[var_33_7.prefab_name] ~= nil then
						local var_33_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_7.prefab_name].transform, "story_v_out_322121", "322121007", "story_v_out_322121.awb")

						arg_30_1:RecordAudio("322121007", var_33_13)
						arg_30_1:RecordAudio("322121007", var_33_13)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_322121", "322121007", "story_v_out_322121.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_322121", "322121007", "story_v_out_322121.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_14 = math.max(var_33_5, arg_30_1.talkMaxDuration)

			if var_33_4 <= arg_30_1.time_ and arg_30_1.time_ < var_33_4 + var_33_14 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_4) / var_33_14

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_4 + var_33_14 and arg_30_1.time_ < var_33_4 + var_33_14 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play322121008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 322121008
		arg_34_1.duration_ = 6.17

		local var_34_0 = {
			zh = 5.633,
			ja = 6.166
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
				arg_34_0:Play322121009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action2_2")
			end

			local var_37_1 = arg_34_1.actors_["6056ui_story"]
			local var_37_2 = 0

			if var_37_2 < arg_34_1.time_ and arg_34_1.time_ <= var_37_2 + arg_37_0 and not isNil(var_37_1) and arg_34_1.var_.characterEffect6056ui_story == nil then
				arg_34_1.var_.characterEffect6056ui_story = var_37_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_3 = 0.200000002980232

			if var_37_2 <= arg_34_1.time_ and arg_34_1.time_ < var_37_2 + var_37_3 and not isNil(var_37_1) then
				local var_37_4 = (arg_34_1.time_ - var_37_2) / var_37_3

				if arg_34_1.var_.characterEffect6056ui_story and not isNil(var_37_1) then
					arg_34_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_2 + var_37_3 and arg_34_1.time_ < var_37_2 + var_37_3 + arg_37_0 and not isNil(var_37_1) and arg_34_1.var_.characterEffect6056ui_story then
				arg_34_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_37_5 = 0
			local var_37_6 = 0.6

			if var_37_5 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_7 = arg_34_1:FormatText(StoryNameCfg[613].name)

				arg_34_1.leftNameTxt_.text = var_37_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_8 = arg_34_1:GetWordFromCfg(322121008)
				local var_37_9 = arg_34_1:FormatText(var_37_8.content)

				arg_34_1.text_.text = var_37_9

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_10 = 24
				local var_37_11 = utf8.len(var_37_9)
				local var_37_12 = var_37_10 <= 0 and var_37_6 or var_37_6 * (var_37_11 / var_37_10)

				if var_37_12 > 0 and var_37_6 < var_37_12 then
					arg_34_1.talkMaxDuration = var_37_12

					if var_37_12 + var_37_5 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_12 + var_37_5
					end
				end

				arg_34_1.text_.text = var_37_9
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121008", "story_v_out_322121.awb") ~= 0 then
					local var_37_13 = manager.audio:GetVoiceLength("story_v_out_322121", "322121008", "story_v_out_322121.awb") / 1000

					if var_37_13 + var_37_5 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_13 + var_37_5
					end

					if var_37_8.prefab_name ~= "" and arg_34_1.actors_[var_37_8.prefab_name] ~= nil then
						local var_37_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_8.prefab_name].transform, "story_v_out_322121", "322121008", "story_v_out_322121.awb")

						arg_34_1:RecordAudio("322121008", var_37_14)
						arg_34_1:RecordAudio("322121008", var_37_14)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_322121", "322121008", "story_v_out_322121.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_322121", "322121008", "story_v_out_322121.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_15 = math.max(var_37_6, arg_34_1.talkMaxDuration)

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_15 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_5) / var_37_15

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_5 + var_37_15 and arg_34_1.time_ < var_37_5 + var_37_15 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play322121009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 322121009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play322121010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["6056ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect6056ui_story == nil then
				arg_38_1.var_.characterEffect6056ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect6056ui_story and not isNil(var_41_0) then
					local var_41_4 = Mathf.Lerp(0, 0.5, var_41_3)

					arg_38_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_38_1.var_.characterEffect6056ui_story.fillRatio = var_41_4
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect6056ui_story then
				local var_41_5 = 0.5

				arg_38_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_38_1.var_.characterEffect6056ui_story.fillRatio = var_41_5
			end

			local var_41_6 = 0
			local var_41_7 = 0.75

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

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_9 = arg_38_1:GetWordFromCfg(322121009)
				local var_41_10 = arg_38_1:FormatText(var_41_9.content)

				arg_38_1.text_.text = var_41_10

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 30
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
	Play322121010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 322121010
		arg_42_1.duration_ = 4

		local var_42_0 = {
			zh = 4,
			ja = 3.499999999999
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play322121011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["6056ui_story"].transform
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.var_.moveOldPos6056ui_story = var_45_0.localPosition
			end

			local var_45_2 = 0.001

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2
				local var_45_4 = Vector3.New(0.15, -1.16, -6.15)

				var_45_0.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos6056ui_story, var_45_4, var_45_3)

				local var_45_5 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_5.x, var_45_5.y, var_45_5.z)

				local var_45_6 = var_45_0.localEulerAngles

				var_45_6.z = 0
				var_45_6.x = 0
				var_45_0.localEulerAngles = var_45_6
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 then
				var_45_0.localPosition = Vector3.New(0.15, -1.16, -6.15)

				local var_45_7 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_7.x, var_45_7.y, var_45_7.z)

				local var_45_8 = var_45_0.localEulerAngles

				var_45_8.z = 0
				var_45_8.x = 0
				var_45_0.localEulerAngles = var_45_8
			end

			local var_45_9 = arg_42_1.actors_["6056ui_story"]
			local var_45_10 = 0

			if var_45_10 < arg_42_1.time_ and arg_42_1.time_ <= var_45_10 + arg_45_0 and not isNil(var_45_9) and arg_42_1.var_.characterEffect6056ui_story == nil then
				arg_42_1.var_.characterEffect6056ui_story = var_45_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_11 = 0.200000002980232

			if var_45_10 <= arg_42_1.time_ and arg_42_1.time_ < var_45_10 + var_45_11 and not isNil(var_45_9) then
				local var_45_12 = (arg_42_1.time_ - var_45_10) / var_45_11

				if arg_42_1.var_.characterEffect6056ui_story and not isNil(var_45_9) then
					arg_42_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_10 + var_45_11 and arg_42_1.time_ < var_45_10 + var_45_11 + arg_45_0 and not isNil(var_45_9) and arg_42_1.var_.characterEffect6056ui_story then
				arg_42_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_45_13 = 0

			if var_45_13 < arg_42_1.time_ and arg_42_1.time_ <= var_45_13 + arg_45_0 then
				arg_42_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action1_1")
			end

			local var_45_14 = arg_42_1.actors_["6056ui_story"]
			local var_45_15 = 0

			if var_45_15 < arg_42_1.time_ and arg_42_1.time_ <= var_45_15 + arg_45_0 then
				if arg_42_1.var_.characterEffect6056ui_story == nil then
					arg_42_1.var_.characterEffect6056ui_story = var_45_14:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_45_16 = arg_42_1.var_.characterEffect6056ui_story

				var_45_16.imageEffect:turnOff()

				var_45_16.interferenceEffect.enabled = true
				var_45_16.interferenceEffect.noise = 0
				var_45_16.interferenceEffect.simTimeScale = 1
				var_45_16.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_45_17 = arg_42_1.actors_["6056ui_story"]
			local var_45_18 = 0
			local var_45_19 = 3.5

			if var_45_18 < arg_42_1.time_ and arg_42_1.time_ <= var_45_18 + arg_45_0 then
				if arg_42_1.var_.characterEffect6056ui_story == nil then
					arg_42_1.var_.characterEffect6056ui_story = var_45_17:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_42_1.var_.characterEffect6056ui_story.imageEffect:turnOn(false)
			end

			local var_45_20 = 0
			local var_45_21 = 0.3

			if var_45_20 < arg_42_1.time_ and arg_42_1.time_ <= var_45_20 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_22 = arg_42_1:FormatText(StoryNameCfg[613].name)

				arg_42_1.leftNameTxt_.text = var_45_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_23 = arg_42_1:GetWordFromCfg(322121010)
				local var_45_24 = arg_42_1:FormatText(var_45_23.content)

				arg_42_1.text_.text = var_45_24

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_25 = 12
				local var_45_26 = utf8.len(var_45_24)
				local var_45_27 = var_45_25 <= 0 and var_45_21 or var_45_21 * (var_45_26 / var_45_25)

				if var_45_27 > 0 and var_45_21 < var_45_27 then
					arg_42_1.talkMaxDuration = var_45_27

					if var_45_27 + var_45_20 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_27 + var_45_20
					end
				end

				arg_42_1.text_.text = var_45_24
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121010", "story_v_out_322121.awb") ~= 0 then
					local var_45_28 = manager.audio:GetVoiceLength("story_v_out_322121", "322121010", "story_v_out_322121.awb") / 1000

					if var_45_28 + var_45_20 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_28 + var_45_20
					end

					if var_45_23.prefab_name ~= "" and arg_42_1.actors_[var_45_23.prefab_name] ~= nil then
						local var_45_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_23.prefab_name].transform, "story_v_out_322121", "322121010", "story_v_out_322121.awb")

						arg_42_1:RecordAudio("322121010", var_45_29)
						arg_42_1:RecordAudio("322121010", var_45_29)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_322121", "322121010", "story_v_out_322121.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_322121", "322121010", "story_v_out_322121.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_30 = math.max(var_45_21, arg_42_1.talkMaxDuration)

			if var_45_20 <= arg_42_1.time_ and arg_42_1.time_ < var_45_20 + var_45_30 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_20) / var_45_30

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_20 + var_45_30 and arg_42_1.time_ < var_45_20 + var_45_30 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play322121011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 322121011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play322121012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["6056ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect6056ui_story == nil then
				arg_46_1.var_.characterEffect6056ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect6056ui_story and not isNil(var_49_0) then
					local var_49_4 = Mathf.Lerp(0, 0.5, var_49_3)

					arg_46_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_46_1.var_.characterEffect6056ui_story.fillRatio = var_49_4
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect6056ui_story then
				local var_49_5 = 0.5

				arg_46_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_46_1.var_.characterEffect6056ui_story.fillRatio = var_49_5
			end

			local var_49_6 = 0
			local var_49_7 = 0.375

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_8 = arg_46_1:FormatText(StoryNameCfg[7].name)

				arg_46_1.leftNameTxt_.text = var_49_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_9 = arg_46_1:GetWordFromCfg(322121011)
				local var_49_10 = arg_46_1:FormatText(var_49_9.content)

				arg_46_1.text_.text = var_49_10

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_11 = 15
				local var_49_12 = utf8.len(var_49_10)
				local var_49_13 = var_49_11 <= 0 and var_49_7 or var_49_7 * (var_49_12 / var_49_11)

				if var_49_13 > 0 and var_49_7 < var_49_13 then
					arg_46_1.talkMaxDuration = var_49_13

					if var_49_13 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_13 + var_49_6
					end
				end

				arg_46_1.text_.text = var_49_10
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_14 = math.max(var_49_7, arg_46_1.talkMaxDuration)

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_14 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_6) / var_49_14

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_6 + var_49_14 and arg_46_1.time_ < var_49_6 + var_49_14 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play322121012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 322121012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play322121013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 1.2

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_2 = arg_50_1:FormatText(StoryNameCfg[7].name)

				arg_50_1.leftNameTxt_.text = var_53_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_3 = arg_50_1:GetWordFromCfg(322121012)
				local var_53_4 = arg_50_1:FormatText(var_53_3.content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 48
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
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_8 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_8 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_8

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_8 and arg_50_1.time_ < var_53_0 + var_53_8 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play322121013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 322121013
		arg_54_1.duration_ = 5.17

		local var_54_0 = {
			zh = 4.633,
			ja = 5.166
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
				arg_54_0:Play322121014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["6056ui_story"].transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.moveOldPos6056ui_story = var_57_0.localPosition
			end

			local var_57_2 = 0.001

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2
				local var_57_4 = Vector3.New(0.15, -1.16, -6.15)

				var_57_0.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos6056ui_story, var_57_4, var_57_3)

				local var_57_5 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_5.x, var_57_5.y, var_57_5.z)

				local var_57_6 = var_57_0.localEulerAngles

				var_57_6.z = 0
				var_57_6.x = 0
				var_57_0.localEulerAngles = var_57_6
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 then
				var_57_0.localPosition = Vector3.New(0.15, -1.16, -6.15)

				local var_57_7 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_7.x, var_57_7.y, var_57_7.z)

				local var_57_8 = var_57_0.localEulerAngles

				var_57_8.z = 0
				var_57_8.x = 0
				var_57_0.localEulerAngles = var_57_8
			end

			local var_57_9 = arg_54_1.actors_["6056ui_story"]
			local var_57_10 = 0

			if var_57_10 < arg_54_1.time_ and arg_54_1.time_ <= var_57_10 + arg_57_0 and not isNil(var_57_9) and arg_54_1.var_.characterEffect6056ui_story == nil then
				arg_54_1.var_.characterEffect6056ui_story = var_57_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_11 = 0.200000002980232

			if var_57_10 <= arg_54_1.time_ and arg_54_1.time_ < var_57_10 + var_57_11 and not isNil(var_57_9) then
				local var_57_12 = (arg_54_1.time_ - var_57_10) / var_57_11

				if arg_54_1.var_.characterEffect6056ui_story and not isNil(var_57_9) then
					arg_54_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_10 + var_57_11 and arg_54_1.time_ < var_57_10 + var_57_11 + arg_57_0 and not isNil(var_57_9) and arg_54_1.var_.characterEffect6056ui_story then
				arg_54_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_57_13 = 0

			if var_57_13 < arg_54_1.time_ and arg_54_1.time_ <= var_57_13 + arg_57_0 then
				arg_54_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action1_1")
			end

			local var_57_14 = arg_54_1.actors_["6056ui_story"]
			local var_57_15 = 0

			if var_57_15 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 then
				if arg_54_1.var_.characterEffect6056ui_story == nil then
					arg_54_1.var_.characterEffect6056ui_story = var_57_14:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_57_16 = arg_54_1.var_.characterEffect6056ui_story

				var_57_16.imageEffect:turnOff()

				var_57_16.interferenceEffect.enabled = true
				var_57_16.interferenceEffect.noise = 0
				var_57_16.interferenceEffect.simTimeScale = 1
				var_57_16.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_57_17 = arg_54_1.actors_["6056ui_story"]
			local var_57_18 = 0
			local var_57_19 = 3.5

			if var_57_18 < arg_54_1.time_ and arg_54_1.time_ <= var_57_18 + arg_57_0 then
				if arg_54_1.var_.characterEffect6056ui_story == nil then
					arg_54_1.var_.characterEffect6056ui_story = var_57_17:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_54_1.var_.characterEffect6056ui_story.imageEffect:turnOn(false)
			end

			local var_57_20 = 0
			local var_57_21 = 0.425

			if var_57_20 < arg_54_1.time_ and arg_54_1.time_ <= var_57_20 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_22 = arg_54_1:FormatText(StoryNameCfg[613].name)

				arg_54_1.leftNameTxt_.text = var_57_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_23 = arg_54_1:GetWordFromCfg(322121013)
				local var_57_24 = arg_54_1:FormatText(var_57_23.content)

				arg_54_1.text_.text = var_57_24

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_25 = 17
				local var_57_26 = utf8.len(var_57_24)
				local var_57_27 = var_57_25 <= 0 and var_57_21 or var_57_21 * (var_57_26 / var_57_25)

				if var_57_27 > 0 and var_57_21 < var_57_27 then
					arg_54_1.talkMaxDuration = var_57_27

					if var_57_27 + var_57_20 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_27 + var_57_20
					end
				end

				arg_54_1.text_.text = var_57_24
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121013", "story_v_out_322121.awb") ~= 0 then
					local var_57_28 = manager.audio:GetVoiceLength("story_v_out_322121", "322121013", "story_v_out_322121.awb") / 1000

					if var_57_28 + var_57_20 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_28 + var_57_20
					end

					if var_57_23.prefab_name ~= "" and arg_54_1.actors_[var_57_23.prefab_name] ~= nil then
						local var_57_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_23.prefab_name].transform, "story_v_out_322121", "322121013", "story_v_out_322121.awb")

						arg_54_1:RecordAudio("322121013", var_57_29)
						arg_54_1:RecordAudio("322121013", var_57_29)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_322121", "322121013", "story_v_out_322121.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_322121", "322121013", "story_v_out_322121.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_30 = math.max(var_57_21, arg_54_1.talkMaxDuration)

			if var_57_20 <= arg_54_1.time_ and arg_54_1.time_ < var_57_20 + var_57_30 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_20) / var_57_30

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_20 + var_57_30 and arg_54_1.time_ < var_57_20 + var_57_30 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play322121014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 322121014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play322121015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["6056ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect6056ui_story == nil then
				arg_58_1.var_.characterEffect6056ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect6056ui_story and not isNil(var_61_0) then
					local var_61_4 = Mathf.Lerp(0, 0.5, var_61_3)

					arg_58_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_58_1.var_.characterEffect6056ui_story.fillRatio = var_61_4
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect6056ui_story then
				local var_61_5 = 0.5

				arg_58_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_58_1.var_.characterEffect6056ui_story.fillRatio = var_61_5
			end

			local var_61_6 = 0
			local var_61_7 = 0.125

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_8 = arg_58_1:FormatText(StoryNameCfg[7].name)

				arg_58_1.leftNameTxt_.text = var_61_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_9 = arg_58_1:GetWordFromCfg(322121014)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 5
				local var_61_12 = utf8.len(var_61_10)
				local var_61_13 = var_61_11 <= 0 and var_61_7 or var_61_7 * (var_61_12 / var_61_11)

				if var_61_13 > 0 and var_61_7 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_10
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_14 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_14 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_14

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_14 and arg_58_1.time_ < var_61_6 + var_61_14 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play322121015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 322121015
		arg_62_1.duration_ = 16.03

		local var_62_0 = {
			zh = 9,
			ja = 16.033
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
				arg_62_0:Play322121016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["6056ui_story"].transform
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.var_.moveOldPos6056ui_story = var_65_0.localPosition
			end

			local var_65_2 = 0.001

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2
				local var_65_4 = Vector3.New(0.15, -1.16, -6.15)

				var_65_0.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos6056ui_story, var_65_4, var_65_3)

				local var_65_5 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_5.x, var_65_5.y, var_65_5.z)

				local var_65_6 = var_65_0.localEulerAngles

				var_65_6.z = 0
				var_65_6.x = 0
				var_65_0.localEulerAngles = var_65_6
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 then
				var_65_0.localPosition = Vector3.New(0.15, -1.16, -6.15)

				local var_65_7 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_7.x, var_65_7.y, var_65_7.z)

				local var_65_8 = var_65_0.localEulerAngles

				var_65_8.z = 0
				var_65_8.x = 0
				var_65_0.localEulerAngles = var_65_8
			end

			local var_65_9 = arg_62_1.actors_["6056ui_story"]
			local var_65_10 = 0

			if var_65_10 < arg_62_1.time_ and arg_62_1.time_ <= var_65_10 + arg_65_0 and not isNil(var_65_9) and arg_62_1.var_.characterEffect6056ui_story == nil then
				arg_62_1.var_.characterEffect6056ui_story = var_65_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_11 = 0.200000002980232

			if var_65_10 <= arg_62_1.time_ and arg_62_1.time_ < var_65_10 + var_65_11 and not isNil(var_65_9) then
				local var_65_12 = (arg_62_1.time_ - var_65_10) / var_65_11

				if arg_62_1.var_.characterEffect6056ui_story and not isNil(var_65_9) then
					arg_62_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_10 + var_65_11 and arg_62_1.time_ < var_65_10 + var_65_11 + arg_65_0 and not isNil(var_65_9) and arg_62_1.var_.characterEffect6056ui_story then
				arg_62_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_65_13 = 0

			if var_65_13 < arg_62_1.time_ and arg_62_1.time_ <= var_65_13 + arg_65_0 then
				arg_62_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action3_1")
			end

			local var_65_14 = arg_62_1.actors_["6056ui_story"]
			local var_65_15 = 0

			if var_65_15 < arg_62_1.time_ and arg_62_1.time_ <= var_65_15 + arg_65_0 then
				if arg_62_1.var_.characterEffect6056ui_story == nil then
					arg_62_1.var_.characterEffect6056ui_story = var_65_14:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_65_16 = arg_62_1.var_.characterEffect6056ui_story

				var_65_16.imageEffect:turnOff()

				var_65_16.interferenceEffect.enabled = true
				var_65_16.interferenceEffect.noise = 0
				var_65_16.interferenceEffect.simTimeScale = 1
				var_65_16.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_65_17 = arg_62_1.actors_["6056ui_story"]
			local var_65_18 = 0
			local var_65_19 = 3.5

			if var_65_18 < arg_62_1.time_ and arg_62_1.time_ <= var_65_18 + arg_65_0 then
				if arg_62_1.var_.characterEffect6056ui_story == nil then
					arg_62_1.var_.characterEffect6056ui_story = var_65_17:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_62_1.var_.characterEffect6056ui_story.imageEffect:turnOn(false)
			end

			local var_65_20 = 0
			local var_65_21 = 1.275

			if var_65_20 < arg_62_1.time_ and arg_62_1.time_ <= var_65_20 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_22 = arg_62_1:FormatText(StoryNameCfg[613].name)

				arg_62_1.leftNameTxt_.text = var_65_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_23 = arg_62_1:GetWordFromCfg(322121015)
				local var_65_24 = arg_62_1:FormatText(var_65_23.content)

				arg_62_1.text_.text = var_65_24

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_25 = 51
				local var_65_26 = utf8.len(var_65_24)
				local var_65_27 = var_65_25 <= 0 and var_65_21 or var_65_21 * (var_65_26 / var_65_25)

				if var_65_27 > 0 and var_65_21 < var_65_27 then
					arg_62_1.talkMaxDuration = var_65_27

					if var_65_27 + var_65_20 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_27 + var_65_20
					end
				end

				arg_62_1.text_.text = var_65_24
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121015", "story_v_out_322121.awb") ~= 0 then
					local var_65_28 = manager.audio:GetVoiceLength("story_v_out_322121", "322121015", "story_v_out_322121.awb") / 1000

					if var_65_28 + var_65_20 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_28 + var_65_20
					end

					if var_65_23.prefab_name ~= "" and arg_62_1.actors_[var_65_23.prefab_name] ~= nil then
						local var_65_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_23.prefab_name].transform, "story_v_out_322121", "322121015", "story_v_out_322121.awb")

						arg_62_1:RecordAudio("322121015", var_65_29)
						arg_62_1:RecordAudio("322121015", var_65_29)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_322121", "322121015", "story_v_out_322121.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_322121", "322121015", "story_v_out_322121.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_30 = math.max(var_65_21, arg_62_1.talkMaxDuration)

			if var_65_20 <= arg_62_1.time_ and arg_62_1.time_ < var_65_20 + var_65_30 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_20) / var_65_30

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_20 + var_65_30 and arg_62_1.time_ < var_65_20 + var_65_30 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play322121016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 322121016
		arg_66_1.duration_ = 7.8

		local var_66_0 = {
			zh = 6.233,
			ja = 7.8
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
				arg_66_0:Play322121017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.75

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[613].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_3 = arg_66_1:GetWordFromCfg(322121016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121016", "story_v_out_322121.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_322121", "322121016", "story_v_out_322121.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_322121", "322121016", "story_v_out_322121.awb")

						arg_66_1:RecordAudio("322121016", var_69_9)
						arg_66_1:RecordAudio("322121016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_322121", "322121016", "story_v_out_322121.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_322121", "322121016", "story_v_out_322121.awb")
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
	Play322121017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 322121017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play322121018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["6056ui_story"].transform
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.moveOldPos6056ui_story = var_73_0.localPosition
			end

			local var_73_2 = 0.001

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2
				local var_73_4 = Vector3.New(0, 100, 0)

				var_73_0.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos6056ui_story, var_73_4, var_73_3)

				local var_73_5 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_5.x, var_73_5.y, var_73_5.z)

				local var_73_6 = var_73_0.localEulerAngles

				var_73_6.z = 0
				var_73_6.x = 0
				var_73_0.localEulerAngles = var_73_6
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 then
				var_73_0.localPosition = Vector3.New(0, 100, 0)

				local var_73_7 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_7.x, var_73_7.y, var_73_7.z)

				local var_73_8 = var_73_0.localEulerAngles

				var_73_8.z = 0
				var_73_8.x = 0
				var_73_0.localEulerAngles = var_73_8
			end

			local var_73_9 = 0
			local var_73_10 = 1.375

			if var_73_9 < arg_70_1.time_ and arg_70_1.time_ <= var_73_9 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_11 = arg_70_1:GetWordFromCfg(322121017)
				local var_73_12 = arg_70_1:FormatText(var_73_11.content)

				arg_70_1.text_.text = var_73_12

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_13 = 55
				local var_73_14 = utf8.len(var_73_12)
				local var_73_15 = var_73_13 <= 0 and var_73_10 or var_73_10 * (var_73_14 / var_73_13)

				if var_73_15 > 0 and var_73_10 < var_73_15 then
					arg_70_1.talkMaxDuration = var_73_15

					if var_73_15 + var_73_9 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_15 + var_73_9
					end
				end

				arg_70_1.text_.text = var_73_12
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_16 = math.max(var_73_10, arg_70_1.talkMaxDuration)

			if var_73_9 <= arg_70_1.time_ and arg_70_1.time_ < var_73_9 + var_73_16 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_9) / var_73_16

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_9 + var_73_16 and arg_70_1.time_ < var_73_9 + var_73_16 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play322121018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 322121018
		arg_74_1.duration_ = 8.37

		local var_74_0 = {
			zh = 6.4,
			ja = 8.366
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
				arg_74_0:Play322121019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = "10104ui_story"

			if arg_74_1.actors_[var_77_0] == nil then
				local var_77_1 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_77_1) then
					local var_77_2 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_74_1.stage_.transform)

					var_77_2.name = var_77_0
					var_77_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_74_1.actors_[var_77_0] = var_77_2

					local var_77_3 = var_77_2:GetComponentInChildren(typeof(CharacterEffect))

					var_77_3.enabled = true

					local var_77_4 = GameObjectTools.GetOrAddComponent(var_77_2, typeof(DynamicBoneHelper))

					if var_77_4 then
						var_77_4:EnableDynamicBone(false)
					end

					arg_74_1:ShowWeapon(var_77_3.transform, false)

					arg_74_1.var_[var_77_0 .. "Animator"] = var_77_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_74_1.var_[var_77_0 .. "Animator"].applyRootMotion = true
					arg_74_1.var_[var_77_0 .. "LipSync"] = var_77_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_77_5 = arg_74_1.actors_["10104ui_story"].transform
			local var_77_6 = 0

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				arg_74_1.var_.moveOldPos10104ui_story = var_77_5.localPosition
			end

			local var_77_7 = 0.001

			if var_77_6 <= arg_74_1.time_ and arg_74_1.time_ < var_77_6 + var_77_7 then
				local var_77_8 = (arg_74_1.time_ - var_77_6) / var_77_7
				local var_77_9 = Vector3.New(-0.88, -1.12, -5.99)

				var_77_5.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos10104ui_story, var_77_9, var_77_8)

				local var_77_10 = manager.ui.mainCamera.transform.position - var_77_5.position

				var_77_5.forward = Vector3.New(var_77_10.x, var_77_10.y, var_77_10.z)

				local var_77_11 = var_77_5.localEulerAngles

				var_77_11.z = 0
				var_77_11.x = 0
				var_77_5.localEulerAngles = var_77_11
			end

			if arg_74_1.time_ >= var_77_6 + var_77_7 and arg_74_1.time_ < var_77_6 + var_77_7 + arg_77_0 then
				var_77_5.localPosition = Vector3.New(-0.88, -1.12, -5.99)

				local var_77_12 = manager.ui.mainCamera.transform.position - var_77_5.position

				var_77_5.forward = Vector3.New(var_77_12.x, var_77_12.y, var_77_12.z)

				local var_77_13 = var_77_5.localEulerAngles

				var_77_13.z = 0
				var_77_13.x = 0
				var_77_5.localEulerAngles = var_77_13
			end

			local var_77_14 = arg_74_1.actors_["10104ui_story"]
			local var_77_15 = 0

			if var_77_15 < arg_74_1.time_ and arg_74_1.time_ <= var_77_15 + arg_77_0 and not isNil(var_77_14) and arg_74_1.var_.characterEffect10104ui_story == nil then
				arg_74_1.var_.characterEffect10104ui_story = var_77_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_16 = 0.200000002980232

			if var_77_15 <= arg_74_1.time_ and arg_74_1.time_ < var_77_15 + var_77_16 and not isNil(var_77_14) then
				local var_77_17 = (arg_74_1.time_ - var_77_15) / var_77_16

				if arg_74_1.var_.characterEffect10104ui_story and not isNil(var_77_14) then
					arg_74_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_15 + var_77_16 and arg_74_1.time_ < var_77_15 + var_77_16 + arg_77_0 and not isNil(var_77_14) and arg_74_1.var_.characterEffect10104ui_story then
				arg_74_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_77_18 = 0

			if var_77_18 < arg_74_1.time_ and arg_74_1.time_ <= var_77_18 + arg_77_0 then
				arg_74_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			local var_77_19 = 0

			if var_77_19 < arg_74_1.time_ and arg_74_1.time_ <= var_77_19 + arg_77_0 then
				arg_74_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_77_20 = 0
			local var_77_21 = 0.7

			if var_77_20 < arg_74_1.time_ and arg_74_1.time_ <= var_77_20 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_22 = arg_74_1:FormatText(StoryNameCfg[1030].name)

				arg_74_1.leftNameTxt_.text = var_77_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_23 = arg_74_1:GetWordFromCfg(322121018)
				local var_77_24 = arg_74_1:FormatText(var_77_23.content)

				arg_74_1.text_.text = var_77_24

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_25 = 28
				local var_77_26 = utf8.len(var_77_24)
				local var_77_27 = var_77_25 <= 0 and var_77_21 or var_77_21 * (var_77_26 / var_77_25)

				if var_77_27 > 0 and var_77_21 < var_77_27 then
					arg_74_1.talkMaxDuration = var_77_27

					if var_77_27 + var_77_20 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_27 + var_77_20
					end
				end

				arg_74_1.text_.text = var_77_24
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121018", "story_v_out_322121.awb") ~= 0 then
					local var_77_28 = manager.audio:GetVoiceLength("story_v_out_322121", "322121018", "story_v_out_322121.awb") / 1000

					if var_77_28 + var_77_20 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_28 + var_77_20
					end

					if var_77_23.prefab_name ~= "" and arg_74_1.actors_[var_77_23.prefab_name] ~= nil then
						local var_77_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_23.prefab_name].transform, "story_v_out_322121", "322121018", "story_v_out_322121.awb")

						arg_74_1:RecordAudio("322121018", var_77_29)
						arg_74_1:RecordAudio("322121018", var_77_29)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_322121", "322121018", "story_v_out_322121.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_322121", "322121018", "story_v_out_322121.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_30 = math.max(var_77_21, arg_74_1.talkMaxDuration)

			if var_77_20 <= arg_74_1.time_ and arg_74_1.time_ < var_77_20 + var_77_30 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_20) / var_77_30

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_20 + var_77_30 and arg_74_1.time_ < var_77_20 + var_77_30 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play322121019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 322121019
		arg_78_1.duration_ = 4.6

		local var_78_0 = {
			zh = 4.6,
			ja = 4.3
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
				arg_78_0:Play322121020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["6056ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos6056ui_story = var_81_0.localPosition
			end

			local var_81_2 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2
				local var_81_4 = Vector3.New(0.95, -1.16, -6.15)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos6056ui_story, var_81_4, var_81_3)

				local var_81_5 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_5.x, var_81_5.y, var_81_5.z)

				local var_81_6 = var_81_0.localEulerAngles

				var_81_6.z = 0
				var_81_6.x = 0
				var_81_0.localEulerAngles = var_81_6
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0.95, -1.16, -6.15)

				local var_81_7 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_7.x, var_81_7.y, var_81_7.z)

				local var_81_8 = var_81_0.localEulerAngles

				var_81_8.z = 0
				var_81_8.x = 0
				var_81_0.localEulerAngles = var_81_8
			end

			local var_81_9 = arg_78_1.actors_["6056ui_story"]
			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 and not isNil(var_81_9) and arg_78_1.var_.characterEffect6056ui_story == nil then
				arg_78_1.var_.characterEffect6056ui_story = var_81_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_11 = 0.200000002980232

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_11 and not isNil(var_81_9) then
				local var_81_12 = (arg_78_1.time_ - var_81_10) / var_81_11

				if arg_78_1.var_.characterEffect6056ui_story and not isNil(var_81_9) then
					arg_78_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_10 + var_81_11 and arg_78_1.time_ < var_81_10 + var_81_11 + arg_81_0 and not isNil(var_81_9) and arg_78_1.var_.characterEffect6056ui_story then
				arg_78_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_81_13 = arg_78_1.actors_["10104ui_story"]
			local var_81_14 = 0

			if var_81_14 < arg_78_1.time_ and arg_78_1.time_ <= var_81_14 + arg_81_0 and not isNil(var_81_13) and arg_78_1.var_.characterEffect10104ui_story == nil then
				arg_78_1.var_.characterEffect10104ui_story = var_81_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_15 = 0.200000002980232

			if var_81_14 <= arg_78_1.time_ and arg_78_1.time_ < var_81_14 + var_81_15 and not isNil(var_81_13) then
				local var_81_16 = (arg_78_1.time_ - var_81_14) / var_81_15

				if arg_78_1.var_.characterEffect10104ui_story and not isNil(var_81_13) then
					local var_81_17 = Mathf.Lerp(0, 0.5, var_81_16)

					arg_78_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10104ui_story.fillRatio = var_81_17
				end
			end

			if arg_78_1.time_ >= var_81_14 + var_81_15 and arg_78_1.time_ < var_81_14 + var_81_15 + arg_81_0 and not isNil(var_81_13) and arg_78_1.var_.characterEffect10104ui_story then
				local var_81_18 = 0.5

				arg_78_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10104ui_story.fillRatio = var_81_18
			end

			local var_81_19 = 0

			if var_81_19 < arg_78_1.time_ and arg_78_1.time_ <= var_81_19 + arg_81_0 then
				arg_78_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action4_1")
			end

			local var_81_20 = arg_78_1.actors_["6056ui_story"]
			local var_81_21 = 0

			if var_81_21 < arg_78_1.time_ and arg_78_1.time_ <= var_81_21 + arg_81_0 then
				if arg_78_1.var_.characterEffect6056ui_story == nil then
					arg_78_1.var_.characterEffect6056ui_story = var_81_20:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_81_22 = arg_78_1.var_.characterEffect6056ui_story

				var_81_22.imageEffect:turnOff()

				var_81_22.interferenceEffect.enabled = true
				var_81_22.interferenceEffect.noise = 0
				var_81_22.interferenceEffect.simTimeScale = 1
				var_81_22.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_81_23 = arg_78_1.actors_["6056ui_story"]
			local var_81_24 = 0
			local var_81_25 = 3.5

			if var_81_24 < arg_78_1.time_ and arg_78_1.time_ <= var_81_24 + arg_81_0 then
				if arg_78_1.var_.characterEffect6056ui_story == nil then
					arg_78_1.var_.characterEffect6056ui_story = var_81_23:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_78_1.var_.characterEffect6056ui_story.imageEffect:turnOn(false)
			end

			local var_81_26 = 0
			local var_81_27 = 0.45

			if var_81_26 < arg_78_1.time_ and arg_78_1.time_ <= var_81_26 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_28 = arg_78_1:FormatText(StoryNameCfg[613].name)

				arg_78_1.leftNameTxt_.text = var_81_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_29 = arg_78_1:GetWordFromCfg(322121019)
				local var_81_30 = arg_78_1:FormatText(var_81_29.content)

				arg_78_1.text_.text = var_81_30

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_31 = 18
				local var_81_32 = utf8.len(var_81_30)
				local var_81_33 = var_81_31 <= 0 and var_81_27 or var_81_27 * (var_81_32 / var_81_31)

				if var_81_33 > 0 and var_81_27 < var_81_33 then
					arg_78_1.talkMaxDuration = var_81_33

					if var_81_33 + var_81_26 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_33 + var_81_26
					end
				end

				arg_78_1.text_.text = var_81_30
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121019", "story_v_out_322121.awb") ~= 0 then
					local var_81_34 = manager.audio:GetVoiceLength("story_v_out_322121", "322121019", "story_v_out_322121.awb") / 1000

					if var_81_34 + var_81_26 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_34 + var_81_26
					end

					if var_81_29.prefab_name ~= "" and arg_78_1.actors_[var_81_29.prefab_name] ~= nil then
						local var_81_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_29.prefab_name].transform, "story_v_out_322121", "322121019", "story_v_out_322121.awb")

						arg_78_1:RecordAudio("322121019", var_81_35)
						arg_78_1:RecordAudio("322121019", var_81_35)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_322121", "322121019", "story_v_out_322121.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_322121", "322121019", "story_v_out_322121.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_36 = math.max(var_81_27, arg_78_1.talkMaxDuration)

			if var_81_26 <= arg_78_1.time_ and arg_78_1.time_ < var_81_26 + var_81_36 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_26) / var_81_36

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_26 + var_81_36 and arg_78_1.time_ < var_81_26 + var_81_36 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play322121020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 322121020
		arg_82_1.duration_ = 10.83

		local var_82_0 = {
			zh = 7.6,
			ja = 10.833
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
				arg_82_0:Play322121021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.9

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[613].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:GetWordFromCfg(322121020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121020", "story_v_out_322121.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_322121", "322121020", "story_v_out_322121.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_322121", "322121020", "story_v_out_322121.awb")

						arg_82_1:RecordAudio("322121020", var_85_9)
						arg_82_1:RecordAudio("322121020", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_322121", "322121020", "story_v_out_322121.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_322121", "322121020", "story_v_out_322121.awb")
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
	Play322121021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 322121021
		arg_86_1.duration_ = 7.13

		local var_86_0 = {
			zh = 6.333,
			ja = 7.133
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
				arg_86_0:Play322121022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = "L17f"

			if arg_86_1.bgs_[var_89_0] == nil then
				local var_89_1 = Object.Instantiate(arg_86_1.paintGo_)

				var_89_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_89_0)
				var_89_1.name = var_89_0
				var_89_1.transform.parent = arg_86_1.stage_.transform
				var_89_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.bgs_[var_89_0] = var_89_1
			end

			local var_89_2 = 2

			if var_89_2 < arg_86_1.time_ and arg_86_1.time_ <= var_89_2 + arg_89_0 then
				local var_89_3 = manager.ui.mainCamera.transform.localPosition
				local var_89_4 = Vector3.New(0, 0, 10) + Vector3.New(var_89_3.x, var_89_3.y, 0)
				local var_89_5 = arg_86_1.bgs_.L17f

				var_89_5.transform.localPosition = var_89_4
				var_89_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_89_6 = var_89_5:GetComponent("SpriteRenderer")

				if var_89_6 and var_89_6.sprite then
					local var_89_7 = (var_89_5.transform.localPosition - var_89_3).z
					local var_89_8 = manager.ui.mainCameraCom_
					local var_89_9 = 2 * var_89_7 * Mathf.Tan(var_89_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_89_10 = var_89_9 * var_89_8.aspect
					local var_89_11 = var_89_6.sprite.bounds.size.x
					local var_89_12 = var_89_6.sprite.bounds.size.y
					local var_89_13 = var_89_10 / var_89_11
					local var_89_14 = var_89_9 / var_89_12
					local var_89_15 = var_89_14 < var_89_13 and var_89_13 or var_89_14

					var_89_5.transform.localScale = Vector3.New(var_89_15, var_89_15, 0)
				end

				for iter_89_0, iter_89_1 in pairs(arg_86_1.bgs_) do
					if iter_89_0 ~= "L17f" then
						iter_89_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_89_16 = 4

			if var_89_16 < arg_86_1.time_ and arg_86_1.time_ <= var_89_16 + arg_89_0 then
				arg_86_1.allBtn_.enabled = false
			end

			local var_89_17 = 0.3

			if arg_86_1.time_ >= var_89_16 + var_89_17 and arg_86_1.time_ < var_89_16 + var_89_17 + arg_89_0 then
				arg_86_1.allBtn_.enabled = true
			end

			local var_89_18 = 0

			if var_89_18 < arg_86_1.time_ and arg_86_1.time_ <= var_89_18 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_19 = 2

			if var_89_18 <= arg_86_1.time_ and arg_86_1.time_ < var_89_18 + var_89_19 then
				local var_89_20 = (arg_86_1.time_ - var_89_18) / var_89_19
				local var_89_21 = Color.New(0, 0, 0)

				var_89_21.a = Mathf.Lerp(0, 1, var_89_20)
				arg_86_1.mask_.color = var_89_21
			end

			if arg_86_1.time_ >= var_89_18 + var_89_19 and arg_86_1.time_ < var_89_18 + var_89_19 + arg_89_0 then
				local var_89_22 = Color.New(0, 0, 0)

				var_89_22.a = 1
				arg_86_1.mask_.color = var_89_22
			end

			local var_89_23 = 2

			if var_89_23 < arg_86_1.time_ and arg_86_1.time_ <= var_89_23 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_24 = 2

			if var_89_23 <= arg_86_1.time_ and arg_86_1.time_ < var_89_23 + var_89_24 then
				local var_89_25 = (arg_86_1.time_ - var_89_23) / var_89_24
				local var_89_26 = Color.New(0, 0, 0)

				var_89_26.a = Mathf.Lerp(1, 0, var_89_25)
				arg_86_1.mask_.color = var_89_26
			end

			if arg_86_1.time_ >= var_89_23 + var_89_24 and arg_86_1.time_ < var_89_23 + var_89_24 + arg_89_0 then
				local var_89_27 = Color.New(0, 0, 0)
				local var_89_28 = 0

				arg_86_1.mask_.enabled = false
				var_89_27.a = var_89_28
				arg_86_1.mask_.color = var_89_27
			end

			local var_89_29 = arg_86_1.actors_["6056ui_story"].transform
			local var_89_30 = 1.96599999815226

			if var_89_30 < arg_86_1.time_ and arg_86_1.time_ <= var_89_30 + arg_89_0 then
				arg_86_1.var_.moveOldPos6056ui_story = var_89_29.localPosition
			end

			local var_89_31 = 0.001

			if var_89_30 <= arg_86_1.time_ and arg_86_1.time_ < var_89_30 + var_89_31 then
				local var_89_32 = (arg_86_1.time_ - var_89_30) / var_89_31
				local var_89_33 = Vector3.New(0, 100, 0)

				var_89_29.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos6056ui_story, var_89_33, var_89_32)

				local var_89_34 = manager.ui.mainCamera.transform.position - var_89_29.position

				var_89_29.forward = Vector3.New(var_89_34.x, var_89_34.y, var_89_34.z)

				local var_89_35 = var_89_29.localEulerAngles

				var_89_35.z = 0
				var_89_35.x = 0
				var_89_29.localEulerAngles = var_89_35
			end

			if arg_86_1.time_ >= var_89_30 + var_89_31 and arg_86_1.time_ < var_89_30 + var_89_31 + arg_89_0 then
				var_89_29.localPosition = Vector3.New(0, 100, 0)

				local var_89_36 = manager.ui.mainCamera.transform.position - var_89_29.position

				var_89_29.forward = Vector3.New(var_89_36.x, var_89_36.y, var_89_36.z)

				local var_89_37 = var_89_29.localEulerAngles

				var_89_37.z = 0
				var_89_37.x = 0
				var_89_29.localEulerAngles = var_89_37
			end

			local var_89_38 = arg_86_1.actors_["10104ui_story"].transform
			local var_89_39 = 1.96599999815226

			if var_89_39 < arg_86_1.time_ and arg_86_1.time_ <= var_89_39 + arg_89_0 then
				arg_86_1.var_.moveOldPos10104ui_story = var_89_38.localPosition
			end

			local var_89_40 = 0.001

			if var_89_39 <= arg_86_1.time_ and arg_86_1.time_ < var_89_39 + var_89_40 then
				local var_89_41 = (arg_86_1.time_ - var_89_39) / var_89_40
				local var_89_42 = Vector3.New(0, 100, 0)

				var_89_38.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10104ui_story, var_89_42, var_89_41)

				local var_89_43 = manager.ui.mainCamera.transform.position - var_89_38.position

				var_89_38.forward = Vector3.New(var_89_43.x, var_89_43.y, var_89_43.z)

				local var_89_44 = var_89_38.localEulerAngles

				var_89_44.z = 0
				var_89_44.x = 0
				var_89_38.localEulerAngles = var_89_44
			end

			if arg_86_1.time_ >= var_89_39 + var_89_40 and arg_86_1.time_ < var_89_39 + var_89_40 + arg_89_0 then
				var_89_38.localPosition = Vector3.New(0, 100, 0)

				local var_89_45 = manager.ui.mainCamera.transform.position - var_89_38.position

				var_89_38.forward = Vector3.New(var_89_45.x, var_89_45.y, var_89_45.z)

				local var_89_46 = var_89_38.localEulerAngles

				var_89_46.z = 0
				var_89_46.x = 0
				var_89_38.localEulerAngles = var_89_46
			end

			local var_89_47 = "10103ui_story"

			if arg_86_1.actors_[var_89_47] == nil then
				local var_89_48 = Asset.Load("Char/" .. "10103ui_story")

				if not isNil(var_89_48) then
					local var_89_49 = Object.Instantiate(Asset.Load("Char/" .. "10103ui_story"), arg_86_1.stage_.transform)

					var_89_49.name = var_89_47
					var_89_49.transform.localPosition = Vector3.New(0, 100, 0)
					arg_86_1.actors_[var_89_47] = var_89_49

					local var_89_50 = var_89_49:GetComponentInChildren(typeof(CharacterEffect))

					var_89_50.enabled = true

					local var_89_51 = GameObjectTools.GetOrAddComponent(var_89_49, typeof(DynamicBoneHelper))

					if var_89_51 then
						var_89_51:EnableDynamicBone(false)
					end

					arg_86_1:ShowWeapon(var_89_50.transform, false)

					arg_86_1.var_[var_89_47 .. "Animator"] = var_89_50.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_86_1.var_[var_89_47 .. "Animator"].applyRootMotion = true
					arg_86_1.var_[var_89_47 .. "LipSync"] = var_89_50.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_89_52 = arg_86_1.actors_["10103ui_story"].transform
			local var_89_53 = 3.8

			if var_89_53 < arg_86_1.time_ and arg_86_1.time_ <= var_89_53 + arg_89_0 then
				arg_86_1.var_.moveOldPos10103ui_story = var_89_52.localPosition

				local var_89_54 = GameObjectTools.GetOrAddComponent(var_89_52.gameObject, typeof(DynamicBoneHelper))

				if var_89_54 then
					var_89_54:EnableDynamicBone(false)
				end
			end

			local var_89_55 = 0.001

			if var_89_53 <= arg_86_1.time_ and arg_86_1.time_ < var_89_53 + var_89_55 then
				local var_89_56 = (arg_86_1.time_ - var_89_53) / var_89_55
				local var_89_57 = Vector3.New(0, -0.95, -6.2)

				var_89_52.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10103ui_story, var_89_57, var_89_56)

				local var_89_58 = manager.ui.mainCamera.transform.position - var_89_52.position

				var_89_52.forward = Vector3.New(var_89_58.x, var_89_58.y, var_89_58.z)

				local var_89_59 = var_89_52.localEulerAngles

				var_89_59.z = 0
				var_89_59.x = 0
				var_89_52.localEulerAngles = var_89_59
			end

			if arg_86_1.time_ >= var_89_53 + var_89_55 and arg_86_1.time_ < var_89_53 + var_89_55 + arg_89_0 then
				var_89_52.localPosition = Vector3.New(0, -0.95, -6.2)

				local var_89_60 = manager.ui.mainCamera.transform.position - var_89_52.position

				var_89_52.forward = Vector3.New(var_89_60.x, var_89_60.y, var_89_60.z)

				local var_89_61 = var_89_52.localEulerAngles

				var_89_61.z = 0
				var_89_61.x = 0
				var_89_52.localEulerAngles = var_89_61

				local var_89_62 = GameObjectTools.GetOrAddComponent(var_89_52.gameObject, typeof(DynamicBoneHelper))

				if var_89_62 then
					var_89_62:EnableDynamicBone(true)
				end
			end

			local var_89_63 = arg_86_1.actors_["10103ui_story"]
			local var_89_64 = 3.8

			if var_89_64 < arg_86_1.time_ and arg_86_1.time_ <= var_89_64 + arg_89_0 and not isNil(var_89_63) and arg_86_1.var_.characterEffect10103ui_story == nil then
				arg_86_1.var_.characterEffect10103ui_story = var_89_63:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_65 = 0.200000002980232

			if var_89_64 <= arg_86_1.time_ and arg_86_1.time_ < var_89_64 + var_89_65 and not isNil(var_89_63) then
				local var_89_66 = (arg_86_1.time_ - var_89_64) / var_89_65

				if arg_86_1.var_.characterEffect10103ui_story and not isNil(var_89_63) then
					arg_86_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_64 + var_89_65 and arg_86_1.time_ < var_89_64 + var_89_65 + arg_89_0 and not isNil(var_89_63) and arg_86_1.var_.characterEffect10103ui_story then
				arg_86_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_89_67 = 3.8

			if var_89_67 < arg_86_1.time_ and arg_86_1.time_ <= var_89_67 + arg_89_0 then
				arg_86_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			local var_89_68 = 3.8

			if var_89_68 < arg_86_1.time_ and arg_86_1.time_ <= var_89_68 + arg_89_0 then
				arg_86_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_89_69 = 0.166666666666667
			local var_89_70 = 1

			if var_89_69 < arg_86_1.time_ and arg_86_1.time_ <= var_89_69 + arg_89_0 then
				local var_89_71 = "stop"
				local var_89_72 = "effect"

				arg_86_1:AudioAction(var_89_71, var_89_72, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_89_73 = 1.53333333333333
			local var_89_74 = 1

			if var_89_73 < arg_86_1.time_ and arg_86_1.time_ <= var_89_73 + arg_89_0 then
				local var_89_75 = "play"
				local var_89_76 = "effect"

				arg_86_1:AudioAction(var_89_75, var_89_76, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_89_77 = 1.53333333333333
			local var_89_78 = 1

			if var_89_77 < arg_86_1.time_ and arg_86_1.time_ <= var_89_77 + arg_89_0 then
				local var_89_79 = "play"
				local var_89_80 = "music"

				arg_86_1:AudioAction(var_89_79, var_89_80, "bgm_activity_4_5_story_serious", "story", "bgm_activity_4_5_story_serious.awb")

				local var_89_81 = ""
				local var_89_82 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "story")

				if var_89_82 ~= "" then
					if arg_86_1.bgmTxt_.text ~= var_89_82 and arg_86_1.bgmTxt_.text ~= "" then
						if arg_86_1.bgmTxt2_.text ~= "" then
							arg_86_1.bgmTxt_.text = arg_86_1.bgmTxt2_.text
						end

						arg_86_1.bgmTxt2_.text = var_89_82

						arg_86_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_86_1.bgmTxt_.text = var_89_82
						arg_86_1.bgmTxt2_.text = var_89_82
					end

					if arg_86_1.bgmTimer then
						arg_86_1.bgmTimer:Stop()

						arg_86_1.bgmTimer = nil
					end

					if arg_86_1.settingData.show_music_name == 1 then
						arg_86_1.musicController:SetSelectedState("show")
						arg_86_1.musicAnimator_:Play("open", 0, 0)

						if arg_86_1.settingData.music_time ~= 0 then
							arg_86_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_86_1.settingData.music_time), function()
								if arg_86_1 == nil or isNil(arg_86_1.bgmTxt_) then
									return
								end

								arg_86_1.musicController:SetSelectedState("hide")
								arg_86_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_89_83 = 3.8

			if var_89_83 < arg_86_1.time_ and arg_86_1.time_ <= var_89_83 + arg_89_0 then
				local var_89_84 = arg_86_1.actors_["10103ui_story"]

				if not isNil(var_89_84) then
					local var_89_85 = GameObjectTools.GetOrAddComponent(var_89_84, typeof(DynamicBoneHelper))

					if var_89_85 then
						var_89_85:EnableDynamicBone(true)
					end
				end
			end

			if arg_86_1.frameCnt_ <= 1 then
				arg_86_1.dialog_:SetActive(false)
			end

			local var_89_86 = 4
			local var_89_87 = 0.325

			if var_89_86 < arg_86_1.time_ and arg_86_1.time_ <= var_89_86 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				arg_86_1.dialog_:SetActive(true)

				arg_86_1.dialogCg_.alpha = 0

				local var_89_88 = LeanTween.value(arg_86_1.dialog_, 0, 1, 0.3)

				var_89_88:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_86_1.dialogCg_.alpha = arg_91_0
				end))
				var_89_88:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_86_1.dialog_)
					var_89_88:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_86_1.duration_ = arg_86_1.duration_ + 0.3

				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_89 = arg_86_1:FormatText(StoryNameCfg[1214].name)

				arg_86_1.leftNameTxt_.text = var_89_89

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_90 = arg_86_1:GetWordFromCfg(322121021)
				local var_89_91 = arg_86_1:FormatText(var_89_90.content)

				arg_86_1.text_.text = var_89_91

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_92 = 13
				local var_89_93 = utf8.len(var_89_91)
				local var_89_94 = var_89_92 <= 0 and var_89_87 or var_89_87 * (var_89_93 / var_89_92)

				if var_89_94 > 0 and var_89_87 < var_89_94 then
					arg_86_1.talkMaxDuration = var_89_94
					var_89_86 = var_89_86 + 0.3

					if var_89_94 + var_89_86 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_94 + var_89_86
					end
				end

				arg_86_1.text_.text = var_89_91
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121021", "story_v_out_322121.awb") ~= 0 then
					local var_89_95 = manager.audio:GetVoiceLength("story_v_out_322121", "322121021", "story_v_out_322121.awb") / 1000

					if var_89_95 + var_89_86 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_95 + var_89_86
					end

					if var_89_90.prefab_name ~= "" and arg_86_1.actors_[var_89_90.prefab_name] ~= nil then
						local var_89_96 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_90.prefab_name].transform, "story_v_out_322121", "322121021", "story_v_out_322121.awb")

						arg_86_1:RecordAudio("322121021", var_89_96)
						arg_86_1:RecordAudio("322121021", var_89_96)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_322121", "322121021", "story_v_out_322121.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_322121", "322121021", "story_v_out_322121.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_97 = var_89_86 + 0.3
			local var_89_98 = math.max(var_89_87, arg_86_1.talkMaxDuration)

			if var_89_97 <= arg_86_1.time_ and arg_86_1.time_ < var_89_97 + var_89_98 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_97) / var_89_98

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_97 + var_89_98 and arg_86_1.time_ < var_89_97 + var_89_98 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play322121022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322121022
		arg_93_1.duration_ = 13.2

		local var_93_0 = {
			zh = 9.4,
			ja = 13.2
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play322121023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = "10130ui_story"

			if arg_93_1.actors_[var_96_0] == nil then
				local var_96_1 = Asset.Load("Char/" .. "10130ui_story")

				if not isNil(var_96_1) then
					local var_96_2 = Object.Instantiate(Asset.Load("Char/" .. "10130ui_story"), arg_93_1.stage_.transform)

					var_96_2.name = var_96_0
					var_96_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_93_1.actors_[var_96_0] = var_96_2

					local var_96_3 = var_96_2:GetComponentInChildren(typeof(CharacterEffect))

					var_96_3.enabled = true

					local var_96_4 = GameObjectTools.GetOrAddComponent(var_96_2, typeof(DynamicBoneHelper))

					if var_96_4 then
						var_96_4:EnableDynamicBone(false)
					end

					arg_93_1:ShowWeapon(var_96_3.transform, false)

					arg_93_1.var_[var_96_0 .. "Animator"] = var_96_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_93_1.var_[var_96_0 .. "Animator"].applyRootMotion = true
					arg_93_1.var_[var_96_0 .. "LipSync"] = var_96_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_96_5 = arg_93_1.actors_["10130ui_story"].transform
			local var_96_6 = 0

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.var_.moveOldPos10130ui_story = var_96_5.localPosition
			end

			local var_96_7 = 0.001

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_7 then
				local var_96_8 = (arg_93_1.time_ - var_96_6) / var_96_7
				local var_96_9 = Vector3.New(0.77, -1.02, -5.81)

				var_96_5.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10130ui_story, var_96_9, var_96_8)

				local var_96_10 = manager.ui.mainCamera.transform.position - var_96_5.position

				var_96_5.forward = Vector3.New(var_96_10.x, var_96_10.y, var_96_10.z)

				local var_96_11 = var_96_5.localEulerAngles

				var_96_11.z = 0
				var_96_11.x = 0
				var_96_5.localEulerAngles = var_96_11
			end

			if arg_93_1.time_ >= var_96_6 + var_96_7 and arg_93_1.time_ < var_96_6 + var_96_7 + arg_96_0 then
				var_96_5.localPosition = Vector3.New(0.77, -1.02, -5.81)

				local var_96_12 = manager.ui.mainCamera.transform.position - var_96_5.position

				var_96_5.forward = Vector3.New(var_96_12.x, var_96_12.y, var_96_12.z)

				local var_96_13 = var_96_5.localEulerAngles

				var_96_13.z = 0
				var_96_13.x = 0
				var_96_5.localEulerAngles = var_96_13
			end

			local var_96_14 = arg_93_1.actors_["10103ui_story"].transform
			local var_96_15 = 0

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.var_.moveOldPos10103ui_story = var_96_14.localPosition

				local var_96_16 = GameObjectTools.GetOrAddComponent(var_96_14.gameObject, typeof(DynamicBoneHelper))

				if var_96_16 then
					var_96_16:EnableDynamicBone(false)
				end
			end

			local var_96_17 = 0.001

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_17 then
				local var_96_18 = (arg_93_1.time_ - var_96_15) / var_96_17
				local var_96_19 = Vector3.New(-0.7, -0.95, -6.2)

				var_96_14.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10103ui_story, var_96_19, var_96_18)

				local var_96_20 = manager.ui.mainCamera.transform.position - var_96_14.position

				var_96_14.forward = Vector3.New(var_96_20.x, var_96_20.y, var_96_20.z)

				local var_96_21 = var_96_14.localEulerAngles

				var_96_21.z = 0
				var_96_21.x = 0
				var_96_14.localEulerAngles = var_96_21
			end

			if arg_93_1.time_ >= var_96_15 + var_96_17 and arg_93_1.time_ < var_96_15 + var_96_17 + arg_96_0 then
				var_96_14.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_96_22 = manager.ui.mainCamera.transform.position - var_96_14.position

				var_96_14.forward = Vector3.New(var_96_22.x, var_96_22.y, var_96_22.z)

				local var_96_23 = var_96_14.localEulerAngles

				var_96_23.z = 0
				var_96_23.x = 0
				var_96_14.localEulerAngles = var_96_23

				local var_96_24 = GameObjectTools.GetOrAddComponent(var_96_14.gameObject, typeof(DynamicBoneHelper))

				if var_96_24 then
					var_96_24:EnableDynamicBone(true)
				end
			end

			local var_96_25 = arg_93_1.actors_["10130ui_story"]
			local var_96_26 = 0

			if var_96_26 < arg_93_1.time_ and arg_93_1.time_ <= var_96_26 + arg_96_0 and not isNil(var_96_25) and arg_93_1.var_.characterEffect10130ui_story == nil then
				arg_93_1.var_.characterEffect10130ui_story = var_96_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_27 = 0.200000002980232

			if var_96_26 <= arg_93_1.time_ and arg_93_1.time_ < var_96_26 + var_96_27 and not isNil(var_96_25) then
				local var_96_28 = (arg_93_1.time_ - var_96_26) / var_96_27

				if arg_93_1.var_.characterEffect10130ui_story and not isNil(var_96_25) then
					arg_93_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_26 + var_96_27 and arg_93_1.time_ < var_96_26 + var_96_27 + arg_96_0 and not isNil(var_96_25) and arg_93_1.var_.characterEffect10130ui_story then
				arg_93_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_96_29 = arg_93_1.actors_["10103ui_story"]
			local var_96_30 = 0

			if var_96_30 < arg_93_1.time_ and arg_93_1.time_ <= var_96_30 + arg_96_0 and not isNil(var_96_29) and arg_93_1.var_.characterEffect10103ui_story == nil then
				arg_93_1.var_.characterEffect10103ui_story = var_96_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_31 = 0.200000002980232

			if var_96_30 <= arg_93_1.time_ and arg_93_1.time_ < var_96_30 + var_96_31 and not isNil(var_96_29) then
				local var_96_32 = (arg_93_1.time_ - var_96_30) / var_96_31

				if arg_93_1.var_.characterEffect10103ui_story and not isNil(var_96_29) then
					local var_96_33 = Mathf.Lerp(0, 0.5, var_96_32)

					arg_93_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10103ui_story.fillRatio = var_96_33
				end
			end

			if arg_93_1.time_ >= var_96_30 + var_96_31 and arg_93_1.time_ < var_96_30 + var_96_31 + arg_96_0 and not isNil(var_96_29) and arg_93_1.var_.characterEffect10103ui_story then
				local var_96_34 = 0.5

				arg_93_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10103ui_story.fillRatio = var_96_34
			end

			local var_96_35 = 0

			if var_96_35 < arg_93_1.time_ and arg_93_1.time_ <= var_96_35 + arg_96_0 then
				arg_93_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action1_1")
			end

			local var_96_36 = 0

			if var_96_36 < arg_93_1.time_ and arg_93_1.time_ <= var_96_36 + arg_96_0 then
				arg_93_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_37 = 0

			if var_96_37 < arg_93_1.time_ and arg_93_1.time_ <= var_96_37 + arg_96_0 then
				local var_96_38 = arg_93_1.actors_["10103ui_story"]

				if not isNil(var_96_38) then
					local var_96_39 = GameObjectTools.GetOrAddComponent(var_96_38, typeof(DynamicBoneHelper))

					if var_96_39 then
						var_96_39:EnableDynamicBone(true)
					end
				end
			end

			local var_96_40 = 0
			local var_96_41 = 0.625

			if var_96_40 < arg_93_1.time_ and arg_93_1.time_ <= var_96_40 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_42 = arg_93_1:FormatText(StoryNameCfg[1049].name)

				arg_93_1.leftNameTxt_.text = var_96_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_43 = arg_93_1:GetWordFromCfg(322121022)
				local var_96_44 = arg_93_1:FormatText(var_96_43.content)

				arg_93_1.text_.text = var_96_44

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_45 = 25
				local var_96_46 = utf8.len(var_96_44)
				local var_96_47 = var_96_45 <= 0 and var_96_41 or var_96_41 * (var_96_46 / var_96_45)

				if var_96_47 > 0 and var_96_41 < var_96_47 then
					arg_93_1.talkMaxDuration = var_96_47

					if var_96_47 + var_96_40 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_47 + var_96_40
					end
				end

				arg_93_1.text_.text = var_96_44
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121022", "story_v_out_322121.awb") ~= 0 then
					local var_96_48 = manager.audio:GetVoiceLength("story_v_out_322121", "322121022", "story_v_out_322121.awb") / 1000

					if var_96_48 + var_96_40 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_48 + var_96_40
					end

					if var_96_43.prefab_name ~= "" and arg_93_1.actors_[var_96_43.prefab_name] ~= nil then
						local var_96_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_43.prefab_name].transform, "story_v_out_322121", "322121022", "story_v_out_322121.awb")

						arg_93_1:RecordAudio("322121022", var_96_49)
						arg_93_1:RecordAudio("322121022", var_96_49)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_322121", "322121022", "story_v_out_322121.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_322121", "322121022", "story_v_out_322121.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_50 = math.max(var_96_41, arg_93_1.talkMaxDuration)

			if var_96_40 <= arg_93_1.time_ and arg_93_1.time_ < var_96_40 + var_96_50 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_40) / var_96_50

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_40 + var_96_50 and arg_93_1.time_ < var_96_40 + var_96_50 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play322121023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322121023
		arg_97_1.duration_ = 10.17

		local var_97_0 = {
			zh = 9.1,
			ja = 10.166
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play322121024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10103ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10103ui_story = var_100_0.localPosition

				local var_100_2 = GameObjectTools.GetOrAddComponent(var_100_0.gameObject, typeof(DynamicBoneHelper))

				if var_100_2 then
					var_100_2:EnableDynamicBone(false)
				end
			end

			local var_100_3 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_3 then
				local var_100_4 = (arg_97_1.time_ - var_100_1) / var_100_3
				local var_100_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10103ui_story, var_100_5, var_100_4)

				local var_100_6 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_6.x, var_100_6.y, var_100_6.z)

				local var_100_7 = var_100_0.localEulerAngles

				var_100_7.z = 0
				var_100_7.x = 0
				var_100_0.localEulerAngles = var_100_7
			end

			if arg_97_1.time_ >= var_100_1 + var_100_3 and arg_97_1.time_ < var_100_1 + var_100_3 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_100_8 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_8.x, var_100_8.y, var_100_8.z)

				local var_100_9 = var_100_0.localEulerAngles

				var_100_9.z = 0
				var_100_9.x = 0
				var_100_0.localEulerAngles = var_100_9

				local var_100_10 = GameObjectTools.GetOrAddComponent(var_100_0.gameObject, typeof(DynamicBoneHelper))

				if var_100_10 then
					var_100_10:EnableDynamicBone(true)
				end
			end

			local var_100_11 = arg_97_1.actors_["10103ui_story"]
			local var_100_12 = 0

			if var_100_12 < arg_97_1.time_ and arg_97_1.time_ <= var_100_12 + arg_100_0 and not isNil(var_100_11) and arg_97_1.var_.characterEffect10103ui_story == nil then
				arg_97_1.var_.characterEffect10103ui_story = var_100_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_13 = 0.200000002980232

			if var_100_12 <= arg_97_1.time_ and arg_97_1.time_ < var_100_12 + var_100_13 and not isNil(var_100_11) then
				local var_100_14 = (arg_97_1.time_ - var_100_12) / var_100_13

				if arg_97_1.var_.characterEffect10103ui_story and not isNil(var_100_11) then
					arg_97_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_12 + var_100_13 and arg_97_1.time_ < var_100_12 + var_100_13 + arg_100_0 and not isNil(var_100_11) and arg_97_1.var_.characterEffect10103ui_story then
				arg_97_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_100_15 = arg_97_1.actors_["10130ui_story"]
			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 and not isNil(var_100_15) and arg_97_1.var_.characterEffect10130ui_story == nil then
				arg_97_1.var_.characterEffect10130ui_story = var_100_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_17 = 0.200000002980232

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_17 and not isNil(var_100_15) then
				local var_100_18 = (arg_97_1.time_ - var_100_16) / var_100_17

				if arg_97_1.var_.characterEffect10130ui_story and not isNil(var_100_15) then
					local var_100_19 = Mathf.Lerp(0, 0.5, var_100_18)

					arg_97_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10130ui_story.fillRatio = var_100_19
				end
			end

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 and not isNil(var_100_15) and arg_97_1.var_.characterEffect10130ui_story then
				local var_100_20 = 0.5

				arg_97_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10130ui_story.fillRatio = var_100_20
			end

			local var_100_21 = 0

			if var_100_21 < arg_97_1.time_ and arg_97_1.time_ <= var_100_21 + arg_100_0 then
				arg_97_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_1")
			end

			local var_100_22 = 0

			if var_100_22 < arg_97_1.time_ and arg_97_1.time_ <= var_100_22 + arg_100_0 then
				arg_97_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_100_23 = 0

			if var_100_23 < arg_97_1.time_ and arg_97_1.time_ <= var_100_23 + arg_100_0 then
				local var_100_24 = arg_97_1.actors_["10103ui_story"]

				if not isNil(var_100_24) then
					local var_100_25 = GameObjectTools.GetOrAddComponent(var_100_24, typeof(DynamicBoneHelper))

					if var_100_25 then
						var_100_25:EnableDynamicBone(true)
					end
				end
			end

			local var_100_26 = 0
			local var_100_27 = 1.05

			if var_100_26 < arg_97_1.time_ and arg_97_1.time_ <= var_100_26 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_28 = arg_97_1:FormatText(StoryNameCfg[1214].name)

				arg_97_1.leftNameTxt_.text = var_100_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_29 = arg_97_1:GetWordFromCfg(322121023)
				local var_100_30 = arg_97_1:FormatText(var_100_29.content)

				arg_97_1.text_.text = var_100_30

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_31 = 42
				local var_100_32 = utf8.len(var_100_30)
				local var_100_33 = var_100_31 <= 0 and var_100_27 or var_100_27 * (var_100_32 / var_100_31)

				if var_100_33 > 0 and var_100_27 < var_100_33 then
					arg_97_1.talkMaxDuration = var_100_33

					if var_100_33 + var_100_26 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_33 + var_100_26
					end
				end

				arg_97_1.text_.text = var_100_30
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121023", "story_v_out_322121.awb") ~= 0 then
					local var_100_34 = manager.audio:GetVoiceLength("story_v_out_322121", "322121023", "story_v_out_322121.awb") / 1000

					if var_100_34 + var_100_26 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_34 + var_100_26
					end

					if var_100_29.prefab_name ~= "" and arg_97_1.actors_[var_100_29.prefab_name] ~= nil then
						local var_100_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_29.prefab_name].transform, "story_v_out_322121", "322121023", "story_v_out_322121.awb")

						arg_97_1:RecordAudio("322121023", var_100_35)
						arg_97_1:RecordAudio("322121023", var_100_35)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_322121", "322121023", "story_v_out_322121.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_322121", "322121023", "story_v_out_322121.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_36 = math.max(var_100_27, arg_97_1.talkMaxDuration)

			if var_100_26 <= arg_97_1.time_ and arg_97_1.time_ < var_100_26 + var_100_36 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_26) / var_100_36

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_26 + var_100_36 and arg_97_1.time_ < var_100_26 + var_100_36 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play322121024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322121024
		arg_101_1.duration_ = 15.23

		local var_101_0 = {
			zh = 12.066,
			ja = 15.233
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play322121025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.3

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[1214].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(322121024)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 52
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121024", "story_v_out_322121.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_322121", "322121024", "story_v_out_322121.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_322121", "322121024", "story_v_out_322121.awb")

						arg_101_1:RecordAudio("322121024", var_104_9)
						arg_101_1:RecordAudio("322121024", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_322121", "322121024", "story_v_out_322121.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_322121", "322121024", "story_v_out_322121.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_10 and arg_101_1.time_ < var_104_0 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play322121025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322121025
		arg_105_1.duration_ = 15.73

		local var_105_0 = {
			zh = 10.766,
			ja = 15.733
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play322121026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10103ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10103ui_story = var_108_0.localPosition

				local var_108_2 = GameObjectTools.GetOrAddComponent(var_108_0.gameObject, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(false)
				end
			end

			local var_108_3 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_3 then
				local var_108_4 = (arg_105_1.time_ - var_108_1) / var_108_3
				local var_108_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10103ui_story, var_108_5, var_108_4)

				local var_108_6 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_6.x, var_108_6.y, var_108_6.z)

				local var_108_7 = var_108_0.localEulerAngles

				var_108_7.z = 0
				var_108_7.x = 0
				var_108_0.localEulerAngles = var_108_7
			end

			if arg_105_1.time_ >= var_108_1 + var_108_3 and arg_105_1.time_ < var_108_1 + var_108_3 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_108_8 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_8.x, var_108_8.y, var_108_8.z)

				local var_108_9 = var_108_0.localEulerAngles

				var_108_9.z = 0
				var_108_9.x = 0
				var_108_0.localEulerAngles = var_108_9

				local var_108_10 = GameObjectTools.GetOrAddComponent(var_108_0.gameObject, typeof(DynamicBoneHelper))

				if var_108_10 then
					var_108_10:EnableDynamicBone(true)
				end
			end

			local var_108_11 = 0

			if var_108_11 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 then
				arg_105_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_2")
			end

			local var_108_12 = 0

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_108_13 = 0

			if var_108_13 < arg_105_1.time_ and arg_105_1.time_ <= var_108_13 + arg_108_0 then
				local var_108_14 = arg_105_1.actors_["10103ui_story"]

				if not isNil(var_108_14) then
					local var_108_15 = GameObjectTools.GetOrAddComponent(var_108_14, typeof(DynamicBoneHelper))

					if var_108_15 then
						var_108_15:EnableDynamicBone(true)
					end
				end
			end

			local var_108_16 = 0
			local var_108_17 = 1.125

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_18 = arg_105_1:FormatText(StoryNameCfg[1214].name)

				arg_105_1.leftNameTxt_.text = var_108_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_19 = arg_105_1:GetWordFromCfg(322121025)
				local var_108_20 = arg_105_1:FormatText(var_108_19.content)

				arg_105_1.text_.text = var_108_20

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_21 = 45
				local var_108_22 = utf8.len(var_108_20)
				local var_108_23 = var_108_21 <= 0 and var_108_17 or var_108_17 * (var_108_22 / var_108_21)

				if var_108_23 > 0 and var_108_17 < var_108_23 then
					arg_105_1.talkMaxDuration = var_108_23

					if var_108_23 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_16
					end
				end

				arg_105_1.text_.text = var_108_20
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121025", "story_v_out_322121.awb") ~= 0 then
					local var_108_24 = manager.audio:GetVoiceLength("story_v_out_322121", "322121025", "story_v_out_322121.awb") / 1000

					if var_108_24 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_24 + var_108_16
					end

					if var_108_19.prefab_name ~= "" and arg_105_1.actors_[var_108_19.prefab_name] ~= nil then
						local var_108_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_19.prefab_name].transform, "story_v_out_322121", "322121025", "story_v_out_322121.awb")

						arg_105_1:RecordAudio("322121025", var_108_25)
						arg_105_1:RecordAudio("322121025", var_108_25)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_322121", "322121025", "story_v_out_322121.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_322121", "322121025", "story_v_out_322121.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_26 = math.max(var_108_17, arg_105_1.talkMaxDuration)

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_26 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_16) / var_108_26

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_16 + var_108_26 and arg_105_1.time_ < var_108_16 + var_108_26 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play322121026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322121026
		arg_109_1.duration_ = 7.33

		local var_109_0 = {
			zh = 6.733,
			ja = 7.333
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
				arg_109_0:Play322121027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.575

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[1214].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(322121026)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 23
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121026", "story_v_out_322121.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_322121", "322121026", "story_v_out_322121.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_322121", "322121026", "story_v_out_322121.awb")

						arg_109_1:RecordAudio("322121026", var_112_9)
						arg_109_1:RecordAudio("322121026", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_322121", "322121026", "story_v_out_322121.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_322121", "322121026", "story_v_out_322121.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_10 and arg_109_1.time_ < var_112_0 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play322121027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322121027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play322121028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10103ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10103ui_story = var_116_0.localPosition

				local var_116_2 = GameObjectTools.GetOrAddComponent(var_116_0.gameObject, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(false)
				end
			end

			local var_116_3 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_3 then
				local var_116_4 = (arg_113_1.time_ - var_116_1) / var_116_3
				local var_116_5 = Vector3.New(0, 100, 0)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10103ui_story, var_116_5, var_116_4)

				local var_116_6 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_6.x, var_116_6.y, var_116_6.z)

				local var_116_7 = var_116_0.localEulerAngles

				var_116_7.z = 0
				var_116_7.x = 0
				var_116_0.localEulerAngles = var_116_7
			end

			if arg_113_1.time_ >= var_116_1 + var_116_3 and arg_113_1.time_ < var_116_1 + var_116_3 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, 100, 0)

				local var_116_8 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_8.x, var_116_8.y, var_116_8.z)

				local var_116_9 = var_116_0.localEulerAngles

				var_116_9.z = 0
				var_116_9.x = 0
				var_116_0.localEulerAngles = var_116_9

				local var_116_10 = GameObjectTools.GetOrAddComponent(var_116_0.gameObject, typeof(DynamicBoneHelper))

				if var_116_10 then
					var_116_10:EnableDynamicBone(true)
				end
			end

			local var_116_11 = arg_113_1.actors_["10130ui_story"].transform
			local var_116_12 = 0

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 then
				arg_113_1.var_.moveOldPos10130ui_story = var_116_11.localPosition
			end

			local var_116_13 = 0.001

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_13 then
				local var_116_14 = (arg_113_1.time_ - var_116_12) / var_116_13
				local var_116_15 = Vector3.New(0, 100, 0)

				var_116_11.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10130ui_story, var_116_15, var_116_14)

				local var_116_16 = manager.ui.mainCamera.transform.position - var_116_11.position

				var_116_11.forward = Vector3.New(var_116_16.x, var_116_16.y, var_116_16.z)

				local var_116_17 = var_116_11.localEulerAngles

				var_116_17.z = 0
				var_116_17.x = 0
				var_116_11.localEulerAngles = var_116_17
			end

			if arg_113_1.time_ >= var_116_12 + var_116_13 and arg_113_1.time_ < var_116_12 + var_116_13 + arg_116_0 then
				var_116_11.localPosition = Vector3.New(0, 100, 0)

				local var_116_18 = manager.ui.mainCamera.transform.position - var_116_11.position

				var_116_11.forward = Vector3.New(var_116_18.x, var_116_18.y, var_116_18.z)

				local var_116_19 = var_116_11.localEulerAngles

				var_116_19.z = 0
				var_116_19.x = 0
				var_116_11.localEulerAngles = var_116_19
			end

			local var_116_20 = 0
			local var_116_21 = 1.2

			if var_116_20 < arg_113_1.time_ and arg_113_1.time_ <= var_116_20 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_22 = arg_113_1:GetWordFromCfg(322121027)
				local var_116_23 = arg_113_1:FormatText(var_116_22.content)

				arg_113_1.text_.text = var_116_23

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_24 = 48
				local var_116_25 = utf8.len(var_116_23)
				local var_116_26 = var_116_24 <= 0 and var_116_21 or var_116_21 * (var_116_25 / var_116_24)

				if var_116_26 > 0 and var_116_21 < var_116_26 then
					arg_113_1.talkMaxDuration = var_116_26

					if var_116_26 + var_116_20 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_26 + var_116_20
					end
				end

				arg_113_1.text_.text = var_116_23
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_27 = math.max(var_116_21, arg_113_1.talkMaxDuration)

			if var_116_20 <= arg_113_1.time_ and arg_113_1.time_ < var_116_20 + var_116_27 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_20) / var_116_27

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_20 + var_116_27 and arg_113_1.time_ < var_116_20 + var_116_27 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play322121028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 322121028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play322121029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 1.75

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_2 = arg_117_1:GetWordFromCfg(322121028)
				local var_120_3 = arg_117_1:FormatText(var_120_2.content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 70
				local var_120_5 = utf8.len(var_120_3)
				local var_120_6 = var_120_4 <= 0 and var_120_1 or var_120_1 * (var_120_5 / var_120_4)

				if var_120_6 > 0 and var_120_1 < var_120_6 then
					arg_117_1.talkMaxDuration = var_120_6

					if var_120_6 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_7 and arg_117_1.time_ < var_120_0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play322121029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 322121029
		arg_121_1.duration_ = 8.87

		local var_121_0 = {
			zh = 4.8,
			ja = 8.866
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
				arg_121_0:Play322121030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = "4037ui_story"

			if arg_121_1.actors_[var_124_0] == nil then
				local var_124_1 = Asset.Load("Char/" .. "4037ui_story")

				if not isNil(var_124_1) then
					local var_124_2 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_121_1.stage_.transform)

					var_124_2.name = var_124_0
					var_124_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_121_1.actors_[var_124_0] = var_124_2

					local var_124_3 = var_124_2:GetComponentInChildren(typeof(CharacterEffect))

					var_124_3.enabled = true

					local var_124_4 = GameObjectTools.GetOrAddComponent(var_124_2, typeof(DynamicBoneHelper))

					if var_124_4 then
						var_124_4:EnableDynamicBone(false)
					end

					arg_121_1:ShowWeapon(var_124_3.transform, false)

					arg_121_1.var_[var_124_0 .. "Animator"] = var_124_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_121_1.var_[var_124_0 .. "Animator"].applyRootMotion = true
					arg_121_1.var_[var_124_0 .. "LipSync"] = var_124_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_124_5 = arg_121_1.actors_["4037ui_story"].transform
			local var_124_6 = 0

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.var_.moveOldPos4037ui_story = var_124_5.localPosition
			end

			local var_124_7 = 0.001

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_7 then
				local var_124_8 = (arg_121_1.time_ - var_124_6) / var_124_7
				local var_124_9 = Vector3.New(-0.7, -1.12, -6.2)

				var_124_5.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos4037ui_story, var_124_9, var_124_8)

				local var_124_10 = manager.ui.mainCamera.transform.position - var_124_5.position

				var_124_5.forward = Vector3.New(var_124_10.x, var_124_10.y, var_124_10.z)

				local var_124_11 = var_124_5.localEulerAngles

				var_124_11.z = 0
				var_124_11.x = 0
				var_124_5.localEulerAngles = var_124_11
			end

			if arg_121_1.time_ >= var_124_6 + var_124_7 and arg_121_1.time_ < var_124_6 + var_124_7 + arg_124_0 then
				var_124_5.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_124_12 = manager.ui.mainCamera.transform.position - var_124_5.position

				var_124_5.forward = Vector3.New(var_124_12.x, var_124_12.y, var_124_12.z)

				local var_124_13 = var_124_5.localEulerAngles

				var_124_13.z = 0
				var_124_13.x = 0
				var_124_5.localEulerAngles = var_124_13
			end

			local var_124_14 = arg_121_1.actors_["4037ui_story"]
			local var_124_15 = 0

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 and not isNil(var_124_14) and arg_121_1.var_.characterEffect4037ui_story == nil then
				arg_121_1.var_.characterEffect4037ui_story = var_124_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_16 = 0.200000002980232

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_16 and not isNil(var_124_14) then
				local var_124_17 = (arg_121_1.time_ - var_124_15) / var_124_16

				if arg_121_1.var_.characterEffect4037ui_story and not isNil(var_124_14) then
					arg_121_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_15 + var_124_16 and arg_121_1.time_ < var_124_15 + var_124_16 + arg_124_0 and not isNil(var_124_14) and arg_121_1.var_.characterEffect4037ui_story then
				arg_121_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_124_18 = 0

			if var_124_18 < arg_121_1.time_ and arg_121_1.time_ <= var_124_18 + arg_124_0 then
				arg_121_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			local var_124_19 = 0

			if var_124_19 < arg_121_1.time_ and arg_121_1.time_ <= var_124_19 + arg_124_0 then
				arg_121_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_124_20 = 0
			local var_124_21 = 0.6

			if var_124_20 < arg_121_1.time_ and arg_121_1.time_ <= var_124_20 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_22 = arg_121_1:FormatText(StoryNameCfg[453].name)

				arg_121_1.leftNameTxt_.text = var_124_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_23 = arg_121_1:GetWordFromCfg(322121029)
				local var_124_24 = arg_121_1:FormatText(var_124_23.content)

				arg_121_1.text_.text = var_124_24

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_25 = 24
				local var_124_26 = utf8.len(var_124_24)
				local var_124_27 = var_124_25 <= 0 and var_124_21 or var_124_21 * (var_124_26 / var_124_25)

				if var_124_27 > 0 and var_124_21 < var_124_27 then
					arg_121_1.talkMaxDuration = var_124_27

					if var_124_27 + var_124_20 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_27 + var_124_20
					end
				end

				arg_121_1.text_.text = var_124_24
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121029", "story_v_out_322121.awb") ~= 0 then
					local var_124_28 = manager.audio:GetVoiceLength("story_v_out_322121", "322121029", "story_v_out_322121.awb") / 1000

					if var_124_28 + var_124_20 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_28 + var_124_20
					end

					if var_124_23.prefab_name ~= "" and arg_121_1.actors_[var_124_23.prefab_name] ~= nil then
						local var_124_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_23.prefab_name].transform, "story_v_out_322121", "322121029", "story_v_out_322121.awb")

						arg_121_1:RecordAudio("322121029", var_124_29)
						arg_121_1:RecordAudio("322121029", var_124_29)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_322121", "322121029", "story_v_out_322121.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_322121", "322121029", "story_v_out_322121.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_30 = math.max(var_124_21, arg_121_1.talkMaxDuration)

			if var_124_20 <= arg_121_1.time_ and arg_121_1.time_ < var_124_20 + var_124_30 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_20) / var_124_30

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_20 + var_124_30 and arg_121_1.time_ < var_124_20 + var_124_30 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play322121030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 322121030
		arg_125_1.duration_ = 5.3

		local var_125_0 = {
			zh = 2.8,
			ja = 5.3
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play322121031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10103ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos10103ui_story = var_128_0.localPosition

				local var_128_2 = GameObjectTools.GetOrAddComponent(var_128_0.gameObject, typeof(DynamicBoneHelper))

				if var_128_2 then
					var_128_2:EnableDynamicBone(false)
				end
			end

			local var_128_3 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_3 then
				local var_128_4 = (arg_125_1.time_ - var_128_1) / var_128_3
				local var_128_5 = Vector3.New(0.7, -0.95, -6.2)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10103ui_story, var_128_5, var_128_4)

				local var_128_6 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_6.x, var_128_6.y, var_128_6.z)

				local var_128_7 = var_128_0.localEulerAngles

				var_128_7.z = 0
				var_128_7.x = 0
				var_128_0.localEulerAngles = var_128_7
			end

			if arg_125_1.time_ >= var_128_1 + var_128_3 and arg_125_1.time_ < var_128_1 + var_128_3 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0.7, -0.95, -6.2)

				local var_128_8 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_8.x, var_128_8.y, var_128_8.z)

				local var_128_9 = var_128_0.localEulerAngles

				var_128_9.z = 0
				var_128_9.x = 0
				var_128_0.localEulerAngles = var_128_9

				local var_128_10 = GameObjectTools.GetOrAddComponent(var_128_0.gameObject, typeof(DynamicBoneHelper))

				if var_128_10 then
					var_128_10:EnableDynamicBone(true)
				end
			end

			local var_128_11 = arg_125_1.actors_["10103ui_story"]
			local var_128_12 = 0

			if var_128_12 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 and not isNil(var_128_11) and arg_125_1.var_.characterEffect10103ui_story == nil then
				arg_125_1.var_.characterEffect10103ui_story = var_128_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_13 = 0.200000002980232

			if var_128_12 <= arg_125_1.time_ and arg_125_1.time_ < var_128_12 + var_128_13 and not isNil(var_128_11) then
				local var_128_14 = (arg_125_1.time_ - var_128_12) / var_128_13

				if arg_125_1.var_.characterEffect10103ui_story and not isNil(var_128_11) then
					arg_125_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_12 + var_128_13 and arg_125_1.time_ < var_128_12 + var_128_13 + arg_128_0 and not isNil(var_128_11) and arg_125_1.var_.characterEffect10103ui_story then
				arg_125_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_128_15 = arg_125_1.actors_["4037ui_story"]
			local var_128_16 = 0

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 and not isNil(var_128_15) and arg_125_1.var_.characterEffect4037ui_story == nil then
				arg_125_1.var_.characterEffect4037ui_story = var_128_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_17 = 0.200000002980232

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_17 and not isNil(var_128_15) then
				local var_128_18 = (arg_125_1.time_ - var_128_16) / var_128_17

				if arg_125_1.var_.characterEffect4037ui_story and not isNil(var_128_15) then
					local var_128_19 = Mathf.Lerp(0, 0.5, var_128_18)

					arg_125_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_125_1.var_.characterEffect4037ui_story.fillRatio = var_128_19
				end
			end

			if arg_125_1.time_ >= var_128_16 + var_128_17 and arg_125_1.time_ < var_128_16 + var_128_17 + arg_128_0 and not isNil(var_128_15) and arg_125_1.var_.characterEffect4037ui_story then
				local var_128_20 = 0.5

				arg_125_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_125_1.var_.characterEffect4037ui_story.fillRatio = var_128_20
			end

			local var_128_21 = 0

			if var_128_21 < arg_125_1.time_ and arg_125_1.time_ <= var_128_21 + arg_128_0 then
				arg_125_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			local var_128_22 = 0

			if var_128_22 < arg_125_1.time_ and arg_125_1.time_ <= var_128_22 + arg_128_0 then
				arg_125_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_128_23 = 0

			if var_128_23 < arg_125_1.time_ and arg_125_1.time_ <= var_128_23 + arg_128_0 then
				local var_128_24 = arg_125_1.actors_["10103ui_story"]

				if not isNil(var_128_24) then
					local var_128_25 = GameObjectTools.GetOrAddComponent(var_128_24, typeof(DynamicBoneHelper))

					if var_128_25 then
						var_128_25:EnableDynamicBone(true)
					end
				end
			end

			local var_128_26 = 0
			local var_128_27 = 0.2

			if var_128_26 < arg_125_1.time_ and arg_125_1.time_ <= var_128_26 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_28 = arg_125_1:FormatText(StoryNameCfg[1214].name)

				arg_125_1.leftNameTxt_.text = var_128_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_29 = arg_125_1:GetWordFromCfg(322121030)
				local var_128_30 = arg_125_1:FormatText(var_128_29.content)

				arg_125_1.text_.text = var_128_30

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_31 = 8
				local var_128_32 = utf8.len(var_128_30)
				local var_128_33 = var_128_31 <= 0 and var_128_27 or var_128_27 * (var_128_32 / var_128_31)

				if var_128_33 > 0 and var_128_27 < var_128_33 then
					arg_125_1.talkMaxDuration = var_128_33

					if var_128_33 + var_128_26 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_33 + var_128_26
					end
				end

				arg_125_1.text_.text = var_128_30
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121030", "story_v_out_322121.awb") ~= 0 then
					local var_128_34 = manager.audio:GetVoiceLength("story_v_out_322121", "322121030", "story_v_out_322121.awb") / 1000

					if var_128_34 + var_128_26 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_34 + var_128_26
					end

					if var_128_29.prefab_name ~= "" and arg_125_1.actors_[var_128_29.prefab_name] ~= nil then
						local var_128_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_29.prefab_name].transform, "story_v_out_322121", "322121030", "story_v_out_322121.awb")

						arg_125_1:RecordAudio("322121030", var_128_35)
						arg_125_1:RecordAudio("322121030", var_128_35)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_322121", "322121030", "story_v_out_322121.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_322121", "322121030", "story_v_out_322121.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_36 = math.max(var_128_27, arg_125_1.talkMaxDuration)

			if var_128_26 <= arg_125_1.time_ and arg_125_1.time_ < var_128_26 + var_128_36 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_26) / var_128_36

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_26 + var_128_36 and arg_125_1.time_ < var_128_26 + var_128_36 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
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
	Play322121031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 322121031
		arg_129_1.duration_ = 8.53

		local var_129_0 = {
			zh = 6.033,
			ja = 8.533
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
				arg_129_0:Play322121032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["4037ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos4037ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(-0.7, -1.12, -6.2)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos4037ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = arg_129_1.actors_["4037ui_story"]
			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect4037ui_story == nil then
				arg_129_1.var_.characterEffect4037ui_story = var_132_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_11 = 0.200000002980232

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_11 and not isNil(var_132_9) then
				local var_132_12 = (arg_129_1.time_ - var_132_10) / var_132_11

				if arg_129_1.var_.characterEffect4037ui_story and not isNil(var_132_9) then
					arg_129_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_10 + var_132_11 and arg_129_1.time_ < var_132_10 + var_132_11 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect4037ui_story then
				arg_129_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_132_13 = arg_129_1.actors_["10103ui_story"]
			local var_132_14 = 0

			if var_132_14 < arg_129_1.time_ and arg_129_1.time_ <= var_132_14 + arg_132_0 and not isNil(var_132_13) and arg_129_1.var_.characterEffect10103ui_story == nil then
				arg_129_1.var_.characterEffect10103ui_story = var_132_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_15 = 0.200000002980232

			if var_132_14 <= arg_129_1.time_ and arg_129_1.time_ < var_132_14 + var_132_15 and not isNil(var_132_13) then
				local var_132_16 = (arg_129_1.time_ - var_132_14) / var_132_15

				if arg_129_1.var_.characterEffect10103ui_story and not isNil(var_132_13) then
					local var_132_17 = Mathf.Lerp(0, 0.5, var_132_16)

					arg_129_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10103ui_story.fillRatio = var_132_17
				end
			end

			if arg_129_1.time_ >= var_132_14 + var_132_15 and arg_129_1.time_ < var_132_14 + var_132_15 + arg_132_0 and not isNil(var_132_13) and arg_129_1.var_.characterEffect10103ui_story then
				local var_132_18 = 0.5

				arg_129_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10103ui_story.fillRatio = var_132_18
			end

			local var_132_19 = 0

			if var_132_19 < arg_129_1.time_ and arg_129_1.time_ <= var_132_19 + arg_132_0 then
				arg_129_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_2")
			end

			local var_132_20 = 0

			if var_132_20 < arg_129_1.time_ and arg_129_1.time_ <= var_132_20 + arg_132_0 then
				arg_129_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_132_21 = 0

			if var_132_21 < arg_129_1.time_ and arg_129_1.time_ <= var_132_21 + arg_132_0 then
				local var_132_22 = arg_129_1.actors_["10103ui_story"]

				if not isNil(var_132_22) then
					local var_132_23 = GameObjectTools.GetOrAddComponent(var_132_22, typeof(DynamicBoneHelper))

					if var_132_23 then
						var_132_23:EnableDynamicBone(true)
					end
				end
			end

			local var_132_24 = 0
			local var_132_25 = 0.625

			if var_132_24 < arg_129_1.time_ and arg_129_1.time_ <= var_132_24 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_26 = arg_129_1:FormatText(StoryNameCfg[453].name)

				arg_129_1.leftNameTxt_.text = var_132_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_27 = arg_129_1:GetWordFromCfg(322121031)
				local var_132_28 = arg_129_1:FormatText(var_132_27.content)

				arg_129_1.text_.text = var_132_28

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_29 = 25
				local var_132_30 = utf8.len(var_132_28)
				local var_132_31 = var_132_29 <= 0 and var_132_25 or var_132_25 * (var_132_30 / var_132_29)

				if var_132_31 > 0 and var_132_25 < var_132_31 then
					arg_129_1.talkMaxDuration = var_132_31

					if var_132_31 + var_132_24 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_31 + var_132_24
					end
				end

				arg_129_1.text_.text = var_132_28
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121031", "story_v_out_322121.awb") ~= 0 then
					local var_132_32 = manager.audio:GetVoiceLength("story_v_out_322121", "322121031", "story_v_out_322121.awb") / 1000

					if var_132_32 + var_132_24 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_32 + var_132_24
					end

					if var_132_27.prefab_name ~= "" and arg_129_1.actors_[var_132_27.prefab_name] ~= nil then
						local var_132_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_27.prefab_name].transform, "story_v_out_322121", "322121031", "story_v_out_322121.awb")

						arg_129_1:RecordAudio("322121031", var_132_33)
						arg_129_1:RecordAudio("322121031", var_132_33)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_322121", "322121031", "story_v_out_322121.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_322121", "322121031", "story_v_out_322121.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_34 = math.max(var_132_25, arg_129_1.talkMaxDuration)

			if var_132_24 <= arg_129_1.time_ and arg_129_1.time_ < var_132_24 + var_132_34 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_24) / var_132_34

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_24 + var_132_34 and arg_129_1.time_ < var_132_24 + var_132_34 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play322121032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 322121032
		arg_133_1.duration_ = 3.5

		local var_133_0 = {
			zh = 1.999999999999,
			ja = 3.5
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
				arg_133_0:Play322121033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10130ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos10130ui_story = var_136_0.localPosition
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(0.77, -1.02, -5.81)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10130ui_story, var_136_4, var_136_3)

				local var_136_5 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_5.x, var_136_5.y, var_136_5.z)

				local var_136_6 = var_136_0.localEulerAngles

				var_136_6.z = 0
				var_136_6.x = 0
				var_136_0.localEulerAngles = var_136_6
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0.77, -1.02, -5.81)

				local var_136_7 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_7.x, var_136_7.y, var_136_7.z)

				local var_136_8 = var_136_0.localEulerAngles

				var_136_8.z = 0
				var_136_8.x = 0
				var_136_0.localEulerAngles = var_136_8
			end

			local var_136_9 = arg_133_1.actors_["10103ui_story"].transform
			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1.var_.moveOldPos10103ui_story = var_136_9.localPosition

				local var_136_11 = GameObjectTools.GetOrAddComponent(var_136_9.gameObject, typeof(DynamicBoneHelper))

				if var_136_11 then
					var_136_11:EnableDynamicBone(false)
				end
			end

			local var_136_12 = 0.001

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_12 then
				local var_136_13 = (arg_133_1.time_ - var_136_10) / var_136_12
				local var_136_14 = Vector3.New(0, 100, 0)

				var_136_9.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10103ui_story, var_136_14, var_136_13)

				local var_136_15 = manager.ui.mainCamera.transform.position - var_136_9.position

				var_136_9.forward = Vector3.New(var_136_15.x, var_136_15.y, var_136_15.z)

				local var_136_16 = var_136_9.localEulerAngles

				var_136_16.z = 0
				var_136_16.x = 0
				var_136_9.localEulerAngles = var_136_16
			end

			if arg_133_1.time_ >= var_136_10 + var_136_12 and arg_133_1.time_ < var_136_10 + var_136_12 + arg_136_0 then
				var_136_9.localPosition = Vector3.New(0, 100, 0)

				local var_136_17 = manager.ui.mainCamera.transform.position - var_136_9.position

				var_136_9.forward = Vector3.New(var_136_17.x, var_136_17.y, var_136_17.z)

				local var_136_18 = var_136_9.localEulerAngles

				var_136_18.z = 0
				var_136_18.x = 0
				var_136_9.localEulerAngles = var_136_18

				local var_136_19 = GameObjectTools.GetOrAddComponent(var_136_9.gameObject, typeof(DynamicBoneHelper))

				if var_136_19 then
					var_136_19:EnableDynamicBone(true)
				end
			end

			local var_136_20 = arg_133_1.actors_["10130ui_story"]
			local var_136_21 = 0

			if var_136_21 < arg_133_1.time_ and arg_133_1.time_ <= var_136_21 + arg_136_0 and not isNil(var_136_20) and arg_133_1.var_.characterEffect10130ui_story == nil then
				arg_133_1.var_.characterEffect10130ui_story = var_136_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_22 = 0.200000002980232

			if var_136_21 <= arg_133_1.time_ and arg_133_1.time_ < var_136_21 + var_136_22 and not isNil(var_136_20) then
				local var_136_23 = (arg_133_1.time_ - var_136_21) / var_136_22

				if arg_133_1.var_.characterEffect10130ui_story and not isNil(var_136_20) then
					arg_133_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_21 + var_136_22 and arg_133_1.time_ < var_136_21 + var_136_22 + arg_136_0 and not isNil(var_136_20) and arg_133_1.var_.characterEffect10130ui_story then
				arg_133_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_136_24 = arg_133_1.actors_["4037ui_story"]
			local var_136_25 = 0

			if var_136_25 < arg_133_1.time_ and arg_133_1.time_ <= var_136_25 + arg_136_0 and not isNil(var_136_24) and arg_133_1.var_.characterEffect4037ui_story == nil then
				arg_133_1.var_.characterEffect4037ui_story = var_136_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_26 = 0.200000002980232

			if var_136_25 <= arg_133_1.time_ and arg_133_1.time_ < var_136_25 + var_136_26 and not isNil(var_136_24) then
				local var_136_27 = (arg_133_1.time_ - var_136_25) / var_136_26

				if arg_133_1.var_.characterEffect4037ui_story and not isNil(var_136_24) then
					local var_136_28 = Mathf.Lerp(0, 0.5, var_136_27)

					arg_133_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_133_1.var_.characterEffect4037ui_story.fillRatio = var_136_28
				end
			end

			if arg_133_1.time_ >= var_136_25 + var_136_26 and arg_133_1.time_ < var_136_25 + var_136_26 + arg_136_0 and not isNil(var_136_24) and arg_133_1.var_.characterEffect4037ui_story then
				local var_136_29 = 0.5

				arg_133_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_133_1.var_.characterEffect4037ui_story.fillRatio = var_136_29
			end

			local var_136_30 = 0

			if var_136_30 < arg_133_1.time_ and arg_133_1.time_ <= var_136_30 + arg_136_0 then
				arg_133_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action1_1")
			end

			local var_136_31 = 0

			if var_136_31 < arg_133_1.time_ and arg_133_1.time_ <= var_136_31 + arg_136_0 then
				arg_133_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_136_32 = 0
			local var_136_33 = 0.075

			if var_136_32 < arg_133_1.time_ and arg_133_1.time_ <= var_136_32 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_34 = arg_133_1:FormatText(StoryNameCfg[1049].name)

				arg_133_1.leftNameTxt_.text = var_136_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_35 = arg_133_1:GetWordFromCfg(322121032)
				local var_136_36 = arg_133_1:FormatText(var_136_35.content)

				arg_133_1.text_.text = var_136_36

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_37 = 3
				local var_136_38 = utf8.len(var_136_36)
				local var_136_39 = var_136_37 <= 0 and var_136_33 or var_136_33 * (var_136_38 / var_136_37)

				if var_136_39 > 0 and var_136_33 < var_136_39 then
					arg_133_1.talkMaxDuration = var_136_39

					if var_136_39 + var_136_32 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_39 + var_136_32
					end
				end

				arg_133_1.text_.text = var_136_36
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121032", "story_v_out_322121.awb") ~= 0 then
					local var_136_40 = manager.audio:GetVoiceLength("story_v_out_322121", "322121032", "story_v_out_322121.awb") / 1000

					if var_136_40 + var_136_32 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_40 + var_136_32
					end

					if var_136_35.prefab_name ~= "" and arg_133_1.actors_[var_136_35.prefab_name] ~= nil then
						local var_136_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_35.prefab_name].transform, "story_v_out_322121", "322121032", "story_v_out_322121.awb")

						arg_133_1:RecordAudio("322121032", var_136_41)
						arg_133_1:RecordAudio("322121032", var_136_41)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_322121", "322121032", "story_v_out_322121.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_322121", "322121032", "story_v_out_322121.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_42 = math.max(var_136_33, arg_133_1.talkMaxDuration)

			if var_136_32 <= arg_133_1.time_ and arg_133_1.time_ < var_136_32 + var_136_42 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_32) / var_136_42

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_32 + var_136_42 and arg_133_1.time_ < var_136_32 + var_136_42 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play322121033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 322121033
		arg_137_1.duration_ = 10.8

		local var_137_0 = {
			zh = 6.033,
			ja = 10.8
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
				arg_137_0:Play322121034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["4037ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect4037ui_story == nil then
				arg_137_1.var_.characterEffect4037ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect4037ui_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect4037ui_story then
				arg_137_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_140_4 = arg_137_1.actors_["10130ui_story"]
			local var_140_5 = 0

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect10130ui_story == nil then
				arg_137_1.var_.characterEffect10130ui_story = var_140_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_6 = 0.200000002980232

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_6 and not isNil(var_140_4) then
				local var_140_7 = (arg_137_1.time_ - var_140_5) / var_140_6

				if arg_137_1.var_.characterEffect10130ui_story and not isNil(var_140_4) then
					local var_140_8 = Mathf.Lerp(0, 0.5, var_140_7)

					arg_137_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10130ui_story.fillRatio = var_140_8
				end
			end

			if arg_137_1.time_ >= var_140_5 + var_140_6 and arg_137_1.time_ < var_140_5 + var_140_6 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect10130ui_story then
				local var_140_9 = 0.5

				arg_137_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10130ui_story.fillRatio = var_140_9
			end

			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_140_11 = 0
			local var_140_12 = 0.675

			if var_140_11 < arg_137_1.time_ and arg_137_1.time_ <= var_140_11 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_13 = arg_137_1:FormatText(StoryNameCfg[453].name)

				arg_137_1.leftNameTxt_.text = var_140_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_14 = arg_137_1:GetWordFromCfg(322121033)
				local var_140_15 = arg_137_1:FormatText(var_140_14.content)

				arg_137_1.text_.text = var_140_15

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_16 = 27
				local var_140_17 = utf8.len(var_140_15)
				local var_140_18 = var_140_16 <= 0 and var_140_12 or var_140_12 * (var_140_17 / var_140_16)

				if var_140_18 > 0 and var_140_12 < var_140_18 then
					arg_137_1.talkMaxDuration = var_140_18

					if var_140_18 + var_140_11 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_18 + var_140_11
					end
				end

				arg_137_1.text_.text = var_140_15
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121033", "story_v_out_322121.awb") ~= 0 then
					local var_140_19 = manager.audio:GetVoiceLength("story_v_out_322121", "322121033", "story_v_out_322121.awb") / 1000

					if var_140_19 + var_140_11 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_19 + var_140_11
					end

					if var_140_14.prefab_name ~= "" and arg_137_1.actors_[var_140_14.prefab_name] ~= nil then
						local var_140_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_14.prefab_name].transform, "story_v_out_322121", "322121033", "story_v_out_322121.awb")

						arg_137_1:RecordAudio("322121033", var_140_20)
						arg_137_1:RecordAudio("322121033", var_140_20)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_322121", "322121033", "story_v_out_322121.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_322121", "322121033", "story_v_out_322121.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_21 = math.max(var_140_12, arg_137_1.talkMaxDuration)

			if var_140_11 <= arg_137_1.time_ and arg_137_1.time_ < var_140_11 + var_140_21 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_11) / var_140_21

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_11 + var_140_21 and arg_137_1.time_ < var_140_11 + var_140_21 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play322121034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 322121034
		arg_141_1.duration_ = 8.1

		local var_141_0 = {
			zh = 4.433,
			ja = 8.1
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
				arg_141_0:Play322121035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10130ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos10130ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(0.77, -1.02, -5.81)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10130ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0.77, -1.02, -5.81)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["10130ui_story"]
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect10130ui_story == nil then
				arg_141_1.var_.characterEffect10130ui_story = var_144_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_11 = 0.200000002980232

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 and not isNil(var_144_9) then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11

				if arg_141_1.var_.characterEffect10130ui_story and not isNil(var_144_9) then
					arg_141_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect10130ui_story then
				arg_141_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_144_13 = arg_141_1.actors_["4037ui_story"]
			local var_144_14 = 0

			if var_144_14 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 and not isNil(var_144_13) and arg_141_1.var_.characterEffect4037ui_story == nil then
				arg_141_1.var_.characterEffect4037ui_story = var_144_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_15 = 0.200000002980232

			if var_144_14 <= arg_141_1.time_ and arg_141_1.time_ < var_144_14 + var_144_15 and not isNil(var_144_13) then
				local var_144_16 = (arg_141_1.time_ - var_144_14) / var_144_15

				if arg_141_1.var_.characterEffect4037ui_story and not isNil(var_144_13) then
					local var_144_17 = Mathf.Lerp(0, 0.5, var_144_16)

					arg_141_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_141_1.var_.characterEffect4037ui_story.fillRatio = var_144_17
				end
			end

			if arg_141_1.time_ >= var_144_14 + var_144_15 and arg_141_1.time_ < var_144_14 + var_144_15 + arg_144_0 and not isNil(var_144_13) and arg_141_1.var_.characterEffect4037ui_story then
				local var_144_18 = 0.5

				arg_141_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_141_1.var_.characterEffect4037ui_story.fillRatio = var_144_18
			end

			local var_144_19 = 0

			if var_144_19 < arg_141_1.time_ and arg_141_1.time_ <= var_144_19 + arg_144_0 then
				arg_141_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action3_1")
			end

			local var_144_20 = 0

			if var_144_20 < arg_141_1.time_ and arg_141_1.time_ <= var_144_20 + arg_144_0 then
				arg_141_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva", "EmotionTimelineAnimator")
			end

			local var_144_21 = 0
			local var_144_22 = 0.45

			if var_144_21 < arg_141_1.time_ and arg_141_1.time_ <= var_144_21 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_23 = arg_141_1:FormatText(StoryNameCfg[1049].name)

				arg_141_1.leftNameTxt_.text = var_144_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_24 = arg_141_1:GetWordFromCfg(322121034)
				local var_144_25 = arg_141_1:FormatText(var_144_24.content)

				arg_141_1.text_.text = var_144_25

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_26 = 18
				local var_144_27 = utf8.len(var_144_25)
				local var_144_28 = var_144_26 <= 0 and var_144_22 or var_144_22 * (var_144_27 / var_144_26)

				if var_144_28 > 0 and var_144_22 < var_144_28 then
					arg_141_1.talkMaxDuration = var_144_28

					if var_144_28 + var_144_21 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_28 + var_144_21
					end
				end

				arg_141_1.text_.text = var_144_25
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121034", "story_v_out_322121.awb") ~= 0 then
					local var_144_29 = manager.audio:GetVoiceLength("story_v_out_322121", "322121034", "story_v_out_322121.awb") / 1000

					if var_144_29 + var_144_21 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_29 + var_144_21
					end

					if var_144_24.prefab_name ~= "" and arg_141_1.actors_[var_144_24.prefab_name] ~= nil then
						local var_144_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_24.prefab_name].transform, "story_v_out_322121", "322121034", "story_v_out_322121.awb")

						arg_141_1:RecordAudio("322121034", var_144_30)
						arg_141_1:RecordAudio("322121034", var_144_30)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_322121", "322121034", "story_v_out_322121.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_322121", "322121034", "story_v_out_322121.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_31 = math.max(var_144_22, arg_141_1.talkMaxDuration)

			if var_144_21 <= arg_141_1.time_ and arg_141_1.time_ < var_144_21 + var_144_31 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_21) / var_144_31

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_21 + var_144_31 and arg_141_1.time_ < var_144_21 + var_144_31 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
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
	Play322121035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 322121035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play322121036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10130ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos10130ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, 100, 0)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10130ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, 100, 0)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["4037ui_story"].transform
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.var_.moveOldPos4037ui_story = var_148_9.localPosition
			end

			local var_148_11 = 0.001

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11
				local var_148_13 = Vector3.New(0, 100, 0)

				var_148_9.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos4037ui_story, var_148_13, var_148_12)

				local var_148_14 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_14.x, var_148_14.y, var_148_14.z)

				local var_148_15 = var_148_9.localEulerAngles

				var_148_15.z = 0
				var_148_15.x = 0
				var_148_9.localEulerAngles = var_148_15
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 then
				var_148_9.localPosition = Vector3.New(0, 100, 0)

				local var_148_16 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_16.x, var_148_16.y, var_148_16.z)

				local var_148_17 = var_148_9.localEulerAngles

				var_148_17.z = 0
				var_148_17.x = 0
				var_148_9.localEulerAngles = var_148_17
			end

			local var_148_18 = 0
			local var_148_19 = 0.925

			if var_148_18 < arg_145_1.time_ and arg_145_1.time_ <= var_148_18 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_20 = arg_145_1:GetWordFromCfg(322121035)
				local var_148_21 = arg_145_1:FormatText(var_148_20.content)

				arg_145_1.text_.text = var_148_21

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_22 = 37
				local var_148_23 = utf8.len(var_148_21)
				local var_148_24 = var_148_22 <= 0 and var_148_19 or var_148_19 * (var_148_23 / var_148_22)

				if var_148_24 > 0 and var_148_19 < var_148_24 then
					arg_145_1.talkMaxDuration = var_148_24

					if var_148_24 + var_148_18 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_24 + var_148_18
					end
				end

				arg_145_1.text_.text = var_148_21
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_25 = math.max(var_148_19, arg_145_1.talkMaxDuration)

			if var_148_18 <= arg_145_1.time_ and arg_145_1.time_ < var_148_18 + var_148_25 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_18) / var_148_25

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_18 + var_148_25 and arg_145_1.time_ < var_148_18 + var_148_25 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play322121036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 322121036
		arg_149_1.duration_ = 5.07

		local var_149_0 = {
			zh = 3.9,
			ja = 5.066
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play322121037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["4037ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos4037ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(0, -1.12, -6.2)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos4037ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["4037ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect4037ui_story == nil then
				arg_149_1.var_.characterEffect4037ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect4037ui_story and not isNil(var_152_9) then
					arg_149_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect4037ui_story then
				arg_149_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_152_13 = 0

			if var_152_13 < arg_149_1.time_ and arg_149_1.time_ <= var_152_13 + arg_152_0 then
				arg_149_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action5_1")
			end

			local var_152_14 = 0

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				arg_149_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_152_15 = 0
			local var_152_16 = 0.4

			if var_152_15 < arg_149_1.time_ and arg_149_1.time_ <= var_152_15 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_17 = arg_149_1:FormatText(StoryNameCfg[453].name)

				arg_149_1.leftNameTxt_.text = var_152_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_18 = arg_149_1:GetWordFromCfg(322121036)
				local var_152_19 = arg_149_1:FormatText(var_152_18.content)

				arg_149_1.text_.text = var_152_19

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_20 = 16
				local var_152_21 = utf8.len(var_152_19)
				local var_152_22 = var_152_20 <= 0 and var_152_16 or var_152_16 * (var_152_21 / var_152_20)

				if var_152_22 > 0 and var_152_16 < var_152_22 then
					arg_149_1.talkMaxDuration = var_152_22

					if var_152_22 + var_152_15 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_22 + var_152_15
					end
				end

				arg_149_1.text_.text = var_152_19
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121036", "story_v_out_322121.awb") ~= 0 then
					local var_152_23 = manager.audio:GetVoiceLength("story_v_out_322121", "322121036", "story_v_out_322121.awb") / 1000

					if var_152_23 + var_152_15 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_23 + var_152_15
					end

					if var_152_18.prefab_name ~= "" and arg_149_1.actors_[var_152_18.prefab_name] ~= nil then
						local var_152_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_18.prefab_name].transform, "story_v_out_322121", "322121036", "story_v_out_322121.awb")

						arg_149_1:RecordAudio("322121036", var_152_24)
						arg_149_1:RecordAudio("322121036", var_152_24)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_322121", "322121036", "story_v_out_322121.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_322121", "322121036", "story_v_out_322121.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_25 = math.max(var_152_16, arg_149_1.talkMaxDuration)

			if var_152_15 <= arg_149_1.time_ and arg_149_1.time_ < var_152_15 + var_152_25 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_15) / var_152_25

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_15 + var_152_25 and arg_149_1.time_ < var_152_15 + var_152_25 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play322121037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 322121037
		arg_153_1.duration_ = 14.6

		local var_153_0 = {
			zh = 10.633,
			ja = 14.6
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
				arg_153_0:Play322121038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 1.225

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[453].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(322121037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 49
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

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121037", "story_v_out_322121.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_322121", "322121037", "story_v_out_322121.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_322121", "322121037", "story_v_out_322121.awb")

						arg_153_1:RecordAudio("322121037", var_156_9)
						arg_153_1:RecordAudio("322121037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_322121", "322121037", "story_v_out_322121.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_322121", "322121037", "story_v_out_322121.awb")
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
	Play322121038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 322121038
		arg_157_1.duration_ = 9.2

		local var_157_0 = {
			zh = 3.166,
			ja = 9.2
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play322121039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10130ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10130ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0.77, -1.02, -5.81)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10130ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0.77, -1.02, -5.81)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["4037ui_story"].transform
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1.var_.moveOldPos4037ui_story = var_160_9.localPosition
			end

			local var_160_11 = 0.001

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11
				local var_160_13 = Vector3.New(-0.7, -1.12, -6.2)

				var_160_9.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos4037ui_story, var_160_13, var_160_12)

				local var_160_14 = manager.ui.mainCamera.transform.position - var_160_9.position

				var_160_9.forward = Vector3.New(var_160_14.x, var_160_14.y, var_160_14.z)

				local var_160_15 = var_160_9.localEulerAngles

				var_160_15.z = 0
				var_160_15.x = 0
				var_160_9.localEulerAngles = var_160_15
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 then
				var_160_9.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_160_16 = manager.ui.mainCamera.transform.position - var_160_9.position

				var_160_9.forward = Vector3.New(var_160_16.x, var_160_16.y, var_160_16.z)

				local var_160_17 = var_160_9.localEulerAngles

				var_160_17.z = 0
				var_160_17.x = 0
				var_160_9.localEulerAngles = var_160_17
			end

			local var_160_18 = arg_157_1.actors_["10130ui_story"]
			local var_160_19 = 0

			if var_160_19 < arg_157_1.time_ and arg_157_1.time_ <= var_160_19 + arg_160_0 and not isNil(var_160_18) and arg_157_1.var_.characterEffect10130ui_story == nil then
				arg_157_1.var_.characterEffect10130ui_story = var_160_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_20 = 0.200000002980232

			if var_160_19 <= arg_157_1.time_ and arg_157_1.time_ < var_160_19 + var_160_20 and not isNil(var_160_18) then
				local var_160_21 = (arg_157_1.time_ - var_160_19) / var_160_20

				if arg_157_1.var_.characterEffect10130ui_story and not isNil(var_160_18) then
					arg_157_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_19 + var_160_20 and arg_157_1.time_ < var_160_19 + var_160_20 + arg_160_0 and not isNil(var_160_18) and arg_157_1.var_.characterEffect10130ui_story then
				arg_157_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_160_22 = arg_157_1.actors_["4037ui_story"]
			local var_160_23 = 0

			if var_160_23 < arg_157_1.time_ and arg_157_1.time_ <= var_160_23 + arg_160_0 and not isNil(var_160_22) and arg_157_1.var_.characterEffect4037ui_story == nil then
				arg_157_1.var_.characterEffect4037ui_story = var_160_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_24 = 0.200000002980232

			if var_160_23 <= arg_157_1.time_ and arg_157_1.time_ < var_160_23 + var_160_24 and not isNil(var_160_22) then
				local var_160_25 = (arg_157_1.time_ - var_160_23) / var_160_24

				if arg_157_1.var_.characterEffect4037ui_story and not isNil(var_160_22) then
					local var_160_26 = Mathf.Lerp(0, 0.5, var_160_25)

					arg_157_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_157_1.var_.characterEffect4037ui_story.fillRatio = var_160_26
				end
			end

			if arg_157_1.time_ >= var_160_23 + var_160_24 and arg_157_1.time_ < var_160_23 + var_160_24 + arg_160_0 and not isNil(var_160_22) and arg_157_1.var_.characterEffect4037ui_story then
				local var_160_27 = 0.5

				arg_157_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_157_1.var_.characterEffect4037ui_story.fillRatio = var_160_27
			end

			local var_160_28 = 0

			if var_160_28 < arg_157_1.time_ and arg_157_1.time_ <= var_160_28 + arg_160_0 then
				arg_157_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action5_1")
			end

			local var_160_29 = 0

			if var_160_29 < arg_157_1.time_ and arg_157_1.time_ <= var_160_29 + arg_160_0 then
				arg_157_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_160_30 = 0
			local var_160_31 = 0.2

			if var_160_30 < arg_157_1.time_ and arg_157_1.time_ <= var_160_30 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_32 = arg_157_1:FormatText(StoryNameCfg[1049].name)

				arg_157_1.leftNameTxt_.text = var_160_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_33 = arg_157_1:GetWordFromCfg(322121038)
				local var_160_34 = arg_157_1:FormatText(var_160_33.content)

				arg_157_1.text_.text = var_160_34

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_35 = 8
				local var_160_36 = utf8.len(var_160_34)
				local var_160_37 = var_160_35 <= 0 and var_160_31 or var_160_31 * (var_160_36 / var_160_35)

				if var_160_37 > 0 and var_160_31 < var_160_37 then
					arg_157_1.talkMaxDuration = var_160_37

					if var_160_37 + var_160_30 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_37 + var_160_30
					end
				end

				arg_157_1.text_.text = var_160_34
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121038", "story_v_out_322121.awb") ~= 0 then
					local var_160_38 = manager.audio:GetVoiceLength("story_v_out_322121", "322121038", "story_v_out_322121.awb") / 1000

					if var_160_38 + var_160_30 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_38 + var_160_30
					end

					if var_160_33.prefab_name ~= "" and arg_157_1.actors_[var_160_33.prefab_name] ~= nil then
						local var_160_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_33.prefab_name].transform, "story_v_out_322121", "322121038", "story_v_out_322121.awb")

						arg_157_1:RecordAudio("322121038", var_160_39)
						arg_157_1:RecordAudio("322121038", var_160_39)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_322121", "322121038", "story_v_out_322121.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_322121", "322121038", "story_v_out_322121.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_40 = math.max(var_160_31, arg_157_1.talkMaxDuration)

			if var_160_30 <= arg_157_1.time_ and arg_157_1.time_ < var_160_30 + var_160_40 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_30) / var_160_40

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_30 + var_160_40 and arg_157_1.time_ < var_160_30 + var_160_40 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play322121039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 322121039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play322121040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10130ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos10130ui_story = var_164_0.localPosition
			end

			local var_164_2 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2
				local var_164_4 = Vector3.New(0, 100, 0)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10130ui_story, var_164_4, var_164_3)

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

			local var_164_9 = arg_161_1.actors_["4037ui_story"].transform
			local var_164_10 = 0

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.var_.moveOldPos4037ui_story = var_164_9.localPosition
			end

			local var_164_11 = 0.001

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_11 then
				local var_164_12 = (arg_161_1.time_ - var_164_10) / var_164_11
				local var_164_13 = Vector3.New(0, 100, 0)

				var_164_9.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos4037ui_story, var_164_13, var_164_12)

				local var_164_14 = manager.ui.mainCamera.transform.position - var_164_9.position

				var_164_9.forward = Vector3.New(var_164_14.x, var_164_14.y, var_164_14.z)

				local var_164_15 = var_164_9.localEulerAngles

				var_164_15.z = 0
				var_164_15.x = 0
				var_164_9.localEulerAngles = var_164_15
			end

			if arg_161_1.time_ >= var_164_10 + var_164_11 and arg_161_1.time_ < var_164_10 + var_164_11 + arg_164_0 then
				var_164_9.localPosition = Vector3.New(0, 100, 0)

				local var_164_16 = manager.ui.mainCamera.transform.position - var_164_9.position

				var_164_9.forward = Vector3.New(var_164_16.x, var_164_16.y, var_164_16.z)

				local var_164_17 = var_164_9.localEulerAngles

				var_164_17.z = 0
				var_164_17.x = 0
				var_164_9.localEulerAngles = var_164_17
			end

			local var_164_18 = 0.1
			local var_164_19 = 1

			if var_164_18 < arg_161_1.time_ and arg_161_1.time_ <= var_164_18 + arg_164_0 then
				local var_164_20 = "play"
				local var_164_21 = "effect"

				arg_161_1:AudioAction(var_164_20, var_164_21, "se_story_side_1067", "se_story_1067_horse02", "")
			end

			local var_164_22 = 0
			local var_164_23 = 1.1

			if var_164_22 < arg_161_1.time_ and arg_161_1.time_ <= var_164_22 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_24 = arg_161_1:GetWordFromCfg(322121039)
				local var_164_25 = arg_161_1:FormatText(var_164_24.content)

				arg_161_1.text_.text = var_164_25

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_26 = 44
				local var_164_27 = utf8.len(var_164_25)
				local var_164_28 = var_164_26 <= 0 and var_164_23 or var_164_23 * (var_164_27 / var_164_26)

				if var_164_28 > 0 and var_164_23 < var_164_28 then
					arg_161_1.talkMaxDuration = var_164_28

					if var_164_28 + var_164_22 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_28 + var_164_22
					end
				end

				arg_161_1.text_.text = var_164_25
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_29 = math.max(var_164_23, arg_161_1.talkMaxDuration)

			if var_164_22 <= arg_161_1.time_ and arg_161_1.time_ < var_164_22 + var_164_29 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_22) / var_164_29

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_22 + var_164_29 and arg_161_1.time_ < var_164_22 + var_164_29 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play322121040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 322121040
		arg_165_1.duration_ = 4.3

		local var_165_0 = {
			zh = 2,
			ja = 4.3
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play322121041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10103ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos10103ui_story = var_168_0.localPosition

				local var_168_2 = GameObjectTools.GetOrAddComponent(var_168_0.gameObject, typeof(DynamicBoneHelper))

				if var_168_2 then
					var_168_2:EnableDynamicBone(false)
				end
			end

			local var_168_3 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_3 then
				local var_168_4 = (arg_165_1.time_ - var_168_1) / var_168_3
				local var_168_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10103ui_story, var_168_5, var_168_4)

				local var_168_6 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_6.x, var_168_6.y, var_168_6.z)

				local var_168_7 = var_168_0.localEulerAngles

				var_168_7.z = 0
				var_168_7.x = 0
				var_168_0.localEulerAngles = var_168_7
			end

			if arg_165_1.time_ >= var_168_1 + var_168_3 and arg_165_1.time_ < var_168_1 + var_168_3 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_168_8 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_8.x, var_168_8.y, var_168_8.z)

				local var_168_9 = var_168_0.localEulerAngles

				var_168_9.z = 0
				var_168_9.x = 0
				var_168_0.localEulerAngles = var_168_9

				local var_168_10 = GameObjectTools.GetOrAddComponent(var_168_0.gameObject, typeof(DynamicBoneHelper))

				if var_168_10 then
					var_168_10:EnableDynamicBone(true)
				end
			end

			local var_168_11 = arg_165_1.actors_["10103ui_story"]
			local var_168_12 = 0

			if var_168_12 < arg_165_1.time_ and arg_165_1.time_ <= var_168_12 + arg_168_0 and not isNil(var_168_11) and arg_165_1.var_.characterEffect10103ui_story == nil then
				arg_165_1.var_.characterEffect10103ui_story = var_168_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_13 = 0.200000002980232

			if var_168_12 <= arg_165_1.time_ and arg_165_1.time_ < var_168_12 + var_168_13 and not isNil(var_168_11) then
				local var_168_14 = (arg_165_1.time_ - var_168_12) / var_168_13

				if arg_165_1.var_.characterEffect10103ui_story and not isNil(var_168_11) then
					arg_165_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_12 + var_168_13 and arg_165_1.time_ < var_168_12 + var_168_13 + arg_168_0 and not isNil(var_168_11) and arg_165_1.var_.characterEffect10103ui_story then
				arg_165_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_168_15 = 0

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			local var_168_16 = 0

			if var_168_16 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 then
				arg_165_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_168_17 = 0

			if var_168_17 < arg_165_1.time_ and arg_165_1.time_ <= var_168_17 + arg_168_0 then
				local var_168_18 = arg_165_1.actors_["10103ui_story"]

				if not isNil(var_168_18) then
					local var_168_19 = GameObjectTools.GetOrAddComponent(var_168_18, typeof(DynamicBoneHelper))

					if var_168_19 then
						var_168_19:EnableDynamicBone(true)
					end
				end
			end

			local var_168_20 = 0
			local var_168_21 = 0.25

			if var_168_20 < arg_165_1.time_ and arg_165_1.time_ <= var_168_20 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_22 = arg_165_1:FormatText(StoryNameCfg[1214].name)

				arg_165_1.leftNameTxt_.text = var_168_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_23 = arg_165_1:GetWordFromCfg(322121040)
				local var_168_24 = arg_165_1:FormatText(var_168_23.content)

				arg_165_1.text_.text = var_168_24

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_25 = 10
				local var_168_26 = utf8.len(var_168_24)
				local var_168_27 = var_168_25 <= 0 and var_168_21 or var_168_21 * (var_168_26 / var_168_25)

				if var_168_27 > 0 and var_168_21 < var_168_27 then
					arg_165_1.talkMaxDuration = var_168_27

					if var_168_27 + var_168_20 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_27 + var_168_20
					end
				end

				arg_165_1.text_.text = var_168_24
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121040", "story_v_out_322121.awb") ~= 0 then
					local var_168_28 = manager.audio:GetVoiceLength("story_v_out_322121", "322121040", "story_v_out_322121.awb") / 1000

					if var_168_28 + var_168_20 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_28 + var_168_20
					end

					if var_168_23.prefab_name ~= "" and arg_165_1.actors_[var_168_23.prefab_name] ~= nil then
						local var_168_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_23.prefab_name].transform, "story_v_out_322121", "322121040", "story_v_out_322121.awb")

						arg_165_1:RecordAudio("322121040", var_168_29)
						arg_165_1:RecordAudio("322121040", var_168_29)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_322121", "322121040", "story_v_out_322121.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_322121", "322121040", "story_v_out_322121.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_30 = math.max(var_168_21, arg_165_1.talkMaxDuration)

			if var_168_20 <= arg_165_1.time_ and arg_165_1.time_ < var_168_20 + var_168_30 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_20) / var_168_30

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_20 + var_168_30 and arg_165_1.time_ < var_168_20 + var_168_30 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
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
	Play322121041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 322121041
		arg_169_1.duration_ = 4.47

		local var_169_0 = {
			zh = 2.433,
			ja = 4.466
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play322121042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["4037ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos4037ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0.7, -1.12, -6.2)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos4037ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["4037ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect4037ui_story == nil then
				arg_169_1.var_.characterEffect4037ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect4037ui_story and not isNil(var_172_9) then
					arg_169_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect4037ui_story then
				arg_169_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_172_13 = arg_169_1.actors_["10103ui_story"]
			local var_172_14 = 0

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 and not isNil(var_172_13) and arg_169_1.var_.characterEffect10103ui_story == nil then
				arg_169_1.var_.characterEffect10103ui_story = var_172_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_15 = 0.200000002980232

			if var_172_14 <= arg_169_1.time_ and arg_169_1.time_ < var_172_14 + var_172_15 and not isNil(var_172_13) then
				local var_172_16 = (arg_169_1.time_ - var_172_14) / var_172_15

				if arg_169_1.var_.characterEffect10103ui_story and not isNil(var_172_13) then
					local var_172_17 = Mathf.Lerp(0, 0.5, var_172_16)

					arg_169_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_169_1.var_.characterEffect10103ui_story.fillRatio = var_172_17
				end
			end

			if arg_169_1.time_ >= var_172_14 + var_172_15 and arg_169_1.time_ < var_172_14 + var_172_15 + arg_172_0 and not isNil(var_172_13) and arg_169_1.var_.characterEffect10103ui_story then
				local var_172_18 = 0.5

				arg_169_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_169_1.var_.characterEffect10103ui_story.fillRatio = var_172_18
			end

			local var_172_19 = 0

			if var_172_19 < arg_169_1.time_ and arg_169_1.time_ <= var_172_19 + arg_172_0 then
				arg_169_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_172_20 = 0

			if var_172_20 < arg_169_1.time_ and arg_169_1.time_ <= var_172_20 + arg_172_0 then
				arg_169_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_172_21 = 0
			local var_172_22 = 0.3

			if var_172_21 < arg_169_1.time_ and arg_169_1.time_ <= var_172_21 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_23 = arg_169_1:FormatText(StoryNameCfg[453].name)

				arg_169_1.leftNameTxt_.text = var_172_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_24 = arg_169_1:GetWordFromCfg(322121041)
				local var_172_25 = arg_169_1:FormatText(var_172_24.content)

				arg_169_1.text_.text = var_172_25

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_26 = 12
				local var_172_27 = utf8.len(var_172_25)
				local var_172_28 = var_172_26 <= 0 and var_172_22 or var_172_22 * (var_172_27 / var_172_26)

				if var_172_28 > 0 and var_172_22 < var_172_28 then
					arg_169_1.talkMaxDuration = var_172_28

					if var_172_28 + var_172_21 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_28 + var_172_21
					end
				end

				arg_169_1.text_.text = var_172_25
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121041", "story_v_out_322121.awb") ~= 0 then
					local var_172_29 = manager.audio:GetVoiceLength("story_v_out_322121", "322121041", "story_v_out_322121.awb") / 1000

					if var_172_29 + var_172_21 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_29 + var_172_21
					end

					if var_172_24.prefab_name ~= "" and arg_169_1.actors_[var_172_24.prefab_name] ~= nil then
						local var_172_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_24.prefab_name].transform, "story_v_out_322121", "322121041", "story_v_out_322121.awb")

						arg_169_1:RecordAudio("322121041", var_172_30)
						arg_169_1:RecordAudio("322121041", var_172_30)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_322121", "322121041", "story_v_out_322121.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_322121", "322121041", "story_v_out_322121.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_31 = math.max(var_172_22, arg_169_1.talkMaxDuration)

			if var_172_21 <= arg_169_1.time_ and arg_169_1.time_ < var_172_21 + var_172_31 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_21) / var_172_31

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_21 + var_172_31 and arg_169_1.time_ < var_172_21 + var_172_31 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play322121042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 322121042
		arg_173_1.duration_ = 14.2

		local var_173_0 = {
			zh = 9.1,
			ja = 14.2
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
				arg_173_0:Play322121043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10103ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos10103ui_story = var_176_0.localPosition

				local var_176_2 = GameObjectTools.GetOrAddComponent(var_176_0.gameObject, typeof(DynamicBoneHelper))

				if var_176_2 then
					var_176_2:EnableDynamicBone(false)
				end
			end

			local var_176_3 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_3 then
				local var_176_4 = (arg_173_1.time_ - var_176_1) / var_176_3
				local var_176_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10103ui_story, var_176_5, var_176_4)

				local var_176_6 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_6.x, var_176_6.y, var_176_6.z)

				local var_176_7 = var_176_0.localEulerAngles

				var_176_7.z = 0
				var_176_7.x = 0
				var_176_0.localEulerAngles = var_176_7
			end

			if arg_173_1.time_ >= var_176_1 + var_176_3 and arg_173_1.time_ < var_176_1 + var_176_3 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_176_8 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_8.x, var_176_8.y, var_176_8.z)

				local var_176_9 = var_176_0.localEulerAngles

				var_176_9.z = 0
				var_176_9.x = 0
				var_176_0.localEulerAngles = var_176_9

				local var_176_10 = GameObjectTools.GetOrAddComponent(var_176_0.gameObject, typeof(DynamicBoneHelper))

				if var_176_10 then
					var_176_10:EnableDynamicBone(true)
				end
			end

			local var_176_11 = arg_173_1.actors_["10103ui_story"]
			local var_176_12 = 0

			if var_176_12 < arg_173_1.time_ and arg_173_1.time_ <= var_176_12 + arg_176_0 and not isNil(var_176_11) and arg_173_1.var_.characterEffect10103ui_story == nil then
				arg_173_1.var_.characterEffect10103ui_story = var_176_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_13 = 0.200000002980232

			if var_176_12 <= arg_173_1.time_ and arg_173_1.time_ < var_176_12 + var_176_13 and not isNil(var_176_11) then
				local var_176_14 = (arg_173_1.time_ - var_176_12) / var_176_13

				if arg_173_1.var_.characterEffect10103ui_story and not isNil(var_176_11) then
					arg_173_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_12 + var_176_13 and arg_173_1.time_ < var_176_12 + var_176_13 + arg_176_0 and not isNil(var_176_11) and arg_173_1.var_.characterEffect10103ui_story then
				arg_173_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_176_15 = arg_173_1.actors_["4037ui_story"]
			local var_176_16 = 0

			if var_176_16 < arg_173_1.time_ and arg_173_1.time_ <= var_176_16 + arg_176_0 and not isNil(var_176_15) and arg_173_1.var_.characterEffect4037ui_story == nil then
				arg_173_1.var_.characterEffect4037ui_story = var_176_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_17 = 0.200000002980232

			if var_176_16 <= arg_173_1.time_ and arg_173_1.time_ < var_176_16 + var_176_17 and not isNil(var_176_15) then
				local var_176_18 = (arg_173_1.time_ - var_176_16) / var_176_17

				if arg_173_1.var_.characterEffect4037ui_story and not isNil(var_176_15) then
					local var_176_19 = Mathf.Lerp(0, 0.5, var_176_18)

					arg_173_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_173_1.var_.characterEffect4037ui_story.fillRatio = var_176_19
				end
			end

			if arg_173_1.time_ >= var_176_16 + var_176_17 and arg_173_1.time_ < var_176_16 + var_176_17 + arg_176_0 and not isNil(var_176_15) and arg_173_1.var_.characterEffect4037ui_story then
				local var_176_20 = 0.5

				arg_173_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_173_1.var_.characterEffect4037ui_story.fillRatio = var_176_20
			end

			local var_176_21 = 0

			if var_176_21 < arg_173_1.time_ and arg_173_1.time_ <= var_176_21 + arg_176_0 then
				arg_173_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action4_1")
			end

			local var_176_22 = 0

			if var_176_22 < arg_173_1.time_ and arg_173_1.time_ <= var_176_22 + arg_176_0 then
				arg_173_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_176_23 = 0

			if var_176_23 < arg_173_1.time_ and arg_173_1.time_ <= var_176_23 + arg_176_0 then
				local var_176_24 = arg_173_1.actors_["10103ui_story"]

				if not isNil(var_176_24) then
					local var_176_25 = GameObjectTools.GetOrAddComponent(var_176_24, typeof(DynamicBoneHelper))

					if var_176_25 then
						var_176_25:EnableDynamicBone(true)
					end
				end
			end

			local var_176_26 = 0
			local var_176_27 = 1

			if var_176_26 < arg_173_1.time_ and arg_173_1.time_ <= var_176_26 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_28 = arg_173_1:FormatText(StoryNameCfg[1214].name)

				arg_173_1.leftNameTxt_.text = var_176_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_29 = arg_173_1:GetWordFromCfg(322121042)
				local var_176_30 = arg_173_1:FormatText(var_176_29.content)

				arg_173_1.text_.text = var_176_30

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_31 = 40
				local var_176_32 = utf8.len(var_176_30)
				local var_176_33 = var_176_31 <= 0 and var_176_27 or var_176_27 * (var_176_32 / var_176_31)

				if var_176_33 > 0 and var_176_27 < var_176_33 then
					arg_173_1.talkMaxDuration = var_176_33

					if var_176_33 + var_176_26 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_33 + var_176_26
					end
				end

				arg_173_1.text_.text = var_176_30
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121042", "story_v_out_322121.awb") ~= 0 then
					local var_176_34 = manager.audio:GetVoiceLength("story_v_out_322121", "322121042", "story_v_out_322121.awb") / 1000

					if var_176_34 + var_176_26 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_34 + var_176_26
					end

					if var_176_29.prefab_name ~= "" and arg_173_1.actors_[var_176_29.prefab_name] ~= nil then
						local var_176_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_29.prefab_name].transform, "story_v_out_322121", "322121042", "story_v_out_322121.awb")

						arg_173_1:RecordAudio("322121042", var_176_35)
						arg_173_1:RecordAudio("322121042", var_176_35)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_322121", "322121042", "story_v_out_322121.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_322121", "322121042", "story_v_out_322121.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_36 = math.max(var_176_27, arg_173_1.talkMaxDuration)

			if var_176_26 <= arg_173_1.time_ and arg_173_1.time_ < var_176_26 + var_176_36 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_26) / var_176_36

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_26 + var_176_36 and arg_173_1.time_ < var_176_26 + var_176_36 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play322121043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 322121043
		arg_177_1.duration_ = 16.2

		local var_177_0 = {
			zh = 11.333,
			ja = 16.2
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play322121044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 1

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[1214].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(322121043)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121043", "story_v_out_322121.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_322121", "322121043", "story_v_out_322121.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_322121", "322121043", "story_v_out_322121.awb")

						arg_177_1:RecordAudio("322121043", var_180_9)
						arg_177_1:RecordAudio("322121043", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_322121", "322121043", "story_v_out_322121.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_322121", "322121043", "story_v_out_322121.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_10 and arg_177_1.time_ < var_180_0 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play322121044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 322121044
		arg_181_1.duration_ = 6.1

		local var_181_0 = {
			zh = 4.033,
			ja = 6.1
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play322121045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["4037ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos4037ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0.7, -1.12, -6.2)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos4037ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["4037ui_story"]
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect4037ui_story == nil then
				arg_181_1.var_.characterEffect4037ui_story = var_184_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_11 = 0.200000002980232

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 and not isNil(var_184_9) then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11

				if arg_181_1.var_.characterEffect4037ui_story and not isNil(var_184_9) then
					arg_181_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect4037ui_story then
				arg_181_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_184_13 = arg_181_1.actors_["10103ui_story"]
			local var_184_14 = 0

			if var_184_14 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 and not isNil(var_184_13) and arg_181_1.var_.characterEffect10103ui_story == nil then
				arg_181_1.var_.characterEffect10103ui_story = var_184_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_15 = 0.200000002980232

			if var_184_14 <= arg_181_1.time_ and arg_181_1.time_ < var_184_14 + var_184_15 and not isNil(var_184_13) then
				local var_184_16 = (arg_181_1.time_ - var_184_14) / var_184_15

				if arg_181_1.var_.characterEffect10103ui_story and not isNil(var_184_13) then
					local var_184_17 = Mathf.Lerp(0, 0.5, var_184_16)

					arg_181_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10103ui_story.fillRatio = var_184_17
				end
			end

			if arg_181_1.time_ >= var_184_14 + var_184_15 and arg_181_1.time_ < var_184_14 + var_184_15 + arg_184_0 and not isNil(var_184_13) and arg_181_1.var_.characterEffect10103ui_story then
				local var_184_18 = 0.5

				arg_181_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10103ui_story.fillRatio = var_184_18
			end

			local var_184_19 = 0

			if var_184_19 < arg_181_1.time_ and arg_181_1.time_ <= var_184_19 + arg_184_0 then
				arg_181_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_1")
			end

			local var_184_20 = 0

			if var_184_20 < arg_181_1.time_ and arg_181_1.time_ <= var_184_20 + arg_184_0 then
				arg_181_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_184_21 = 0
			local var_184_22 = 0.35

			if var_184_21 < arg_181_1.time_ and arg_181_1.time_ <= var_184_21 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_23 = arg_181_1:FormatText(StoryNameCfg[453].name)

				arg_181_1.leftNameTxt_.text = var_184_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_24 = arg_181_1:GetWordFromCfg(322121044)
				local var_184_25 = arg_181_1:FormatText(var_184_24.content)

				arg_181_1.text_.text = var_184_25

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_26 = 14
				local var_184_27 = utf8.len(var_184_25)
				local var_184_28 = var_184_26 <= 0 and var_184_22 or var_184_22 * (var_184_27 / var_184_26)

				if var_184_28 > 0 and var_184_22 < var_184_28 then
					arg_181_1.talkMaxDuration = var_184_28

					if var_184_28 + var_184_21 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_28 + var_184_21
					end
				end

				arg_181_1.text_.text = var_184_25
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121044", "story_v_out_322121.awb") ~= 0 then
					local var_184_29 = manager.audio:GetVoiceLength("story_v_out_322121", "322121044", "story_v_out_322121.awb") / 1000

					if var_184_29 + var_184_21 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_29 + var_184_21
					end

					if var_184_24.prefab_name ~= "" and arg_181_1.actors_[var_184_24.prefab_name] ~= nil then
						local var_184_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_24.prefab_name].transform, "story_v_out_322121", "322121044", "story_v_out_322121.awb")

						arg_181_1:RecordAudio("322121044", var_184_30)
						arg_181_1:RecordAudio("322121044", var_184_30)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_322121", "322121044", "story_v_out_322121.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_322121", "322121044", "story_v_out_322121.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_31 = math.max(var_184_22, arg_181_1.talkMaxDuration)

			if var_184_21 <= arg_181_1.time_ and arg_181_1.time_ < var_184_21 + var_184_31 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_21) / var_184_31

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_21 + var_184_31 and arg_181_1.time_ < var_184_21 + var_184_31 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play322121045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 322121045
		arg_185_1.duration_ = 5.17

		local var_185_0 = {
			zh = 3.066,
			ja = 5.166
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play322121046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10103ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos10103ui_story = var_188_0.localPosition

				local var_188_2 = GameObjectTools.GetOrAddComponent(var_188_0.gameObject, typeof(DynamicBoneHelper))

				if var_188_2 then
					var_188_2:EnableDynamicBone(false)
				end
			end

			local var_188_3 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_3 then
				local var_188_4 = (arg_185_1.time_ - var_188_1) / var_188_3
				local var_188_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10103ui_story, var_188_5, var_188_4)

				local var_188_6 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_6.x, var_188_6.y, var_188_6.z)

				local var_188_7 = var_188_0.localEulerAngles

				var_188_7.z = 0
				var_188_7.x = 0
				var_188_0.localEulerAngles = var_188_7
			end

			if arg_185_1.time_ >= var_188_1 + var_188_3 and arg_185_1.time_ < var_188_1 + var_188_3 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_188_8 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_8.x, var_188_8.y, var_188_8.z)

				local var_188_9 = var_188_0.localEulerAngles

				var_188_9.z = 0
				var_188_9.x = 0
				var_188_0.localEulerAngles = var_188_9

				local var_188_10 = GameObjectTools.GetOrAddComponent(var_188_0.gameObject, typeof(DynamicBoneHelper))

				if var_188_10 then
					var_188_10:EnableDynamicBone(true)
				end
			end

			local var_188_11 = arg_185_1.actors_["10103ui_story"]
			local var_188_12 = 0

			if var_188_12 < arg_185_1.time_ and arg_185_1.time_ <= var_188_12 + arg_188_0 and not isNil(var_188_11) and arg_185_1.var_.characterEffect10103ui_story == nil then
				arg_185_1.var_.characterEffect10103ui_story = var_188_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_13 = 0.200000002980232

			if var_188_12 <= arg_185_1.time_ and arg_185_1.time_ < var_188_12 + var_188_13 and not isNil(var_188_11) then
				local var_188_14 = (arg_185_1.time_ - var_188_12) / var_188_13

				if arg_185_1.var_.characterEffect10103ui_story and not isNil(var_188_11) then
					arg_185_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_12 + var_188_13 and arg_185_1.time_ < var_188_12 + var_188_13 + arg_188_0 and not isNil(var_188_11) and arg_185_1.var_.characterEffect10103ui_story then
				arg_185_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_188_15 = arg_185_1.actors_["4037ui_story"]
			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.characterEffect4037ui_story == nil then
				arg_185_1.var_.characterEffect4037ui_story = var_188_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_17 = 0.200000002980232

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 and not isNil(var_188_15) then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17

				if arg_185_1.var_.characterEffect4037ui_story and not isNil(var_188_15) then
					local var_188_19 = Mathf.Lerp(0, 0.5, var_188_18)

					arg_185_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_185_1.var_.characterEffect4037ui_story.fillRatio = var_188_19
				end
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.characterEffect4037ui_story then
				local var_188_20 = 0.5

				arg_185_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_185_1.var_.characterEffect4037ui_story.fillRatio = var_188_20
			end

			local var_188_21 = 0

			if var_188_21 < arg_185_1.time_ and arg_185_1.time_ <= var_188_21 + arg_188_0 then
				arg_185_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action4_2")
			end

			local var_188_22 = 0

			if var_188_22 < arg_185_1.time_ and arg_185_1.time_ <= var_188_22 + arg_188_0 then
				arg_185_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_188_23 = 0

			if var_188_23 < arg_185_1.time_ and arg_185_1.time_ <= var_188_23 + arg_188_0 then
				local var_188_24 = arg_185_1.actors_["10103ui_story"]

				if not isNil(var_188_24) then
					local var_188_25 = GameObjectTools.GetOrAddComponent(var_188_24, typeof(DynamicBoneHelper))

					if var_188_25 then
						var_188_25:EnableDynamicBone(true)
					end
				end
			end

			local var_188_26 = 0
			local var_188_27 = 0.25

			if var_188_26 < arg_185_1.time_ and arg_185_1.time_ <= var_188_26 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_28 = arg_185_1:FormatText(StoryNameCfg[1214].name)

				arg_185_1.leftNameTxt_.text = var_188_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_29 = arg_185_1:GetWordFromCfg(322121045)
				local var_188_30 = arg_185_1:FormatText(var_188_29.content)

				arg_185_1.text_.text = var_188_30

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_31 = 10
				local var_188_32 = utf8.len(var_188_30)
				local var_188_33 = var_188_31 <= 0 and var_188_27 or var_188_27 * (var_188_32 / var_188_31)

				if var_188_33 > 0 and var_188_27 < var_188_33 then
					arg_185_1.talkMaxDuration = var_188_33

					if var_188_33 + var_188_26 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_33 + var_188_26
					end
				end

				arg_185_1.text_.text = var_188_30
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121045", "story_v_out_322121.awb") ~= 0 then
					local var_188_34 = manager.audio:GetVoiceLength("story_v_out_322121", "322121045", "story_v_out_322121.awb") / 1000

					if var_188_34 + var_188_26 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_34 + var_188_26
					end

					if var_188_29.prefab_name ~= "" and arg_185_1.actors_[var_188_29.prefab_name] ~= nil then
						local var_188_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_29.prefab_name].transform, "story_v_out_322121", "322121045", "story_v_out_322121.awb")

						arg_185_1:RecordAudio("322121045", var_188_35)
						arg_185_1:RecordAudio("322121045", var_188_35)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_322121", "322121045", "story_v_out_322121.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_322121", "322121045", "story_v_out_322121.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_36 = math.max(var_188_27, arg_185_1.talkMaxDuration)

			if var_188_26 <= arg_185_1.time_ and arg_185_1.time_ < var_188_26 + var_188_36 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_26) / var_188_36

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_26 + var_188_36 and arg_185_1.time_ < var_188_26 + var_188_36 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play322121046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 322121046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play322121047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10103ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10103ui_story = var_192_0.localPosition

				local var_192_2 = GameObjectTools.GetOrAddComponent(var_192_0.gameObject, typeof(DynamicBoneHelper))

				if var_192_2 then
					var_192_2:EnableDynamicBone(false)
				end
			end

			local var_192_3 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_3 then
				local var_192_4 = (arg_189_1.time_ - var_192_1) / var_192_3
				local var_192_5 = Vector3.New(0, 100, 0)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10103ui_story, var_192_5, var_192_4)

				local var_192_6 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_6.x, var_192_6.y, var_192_6.z)

				local var_192_7 = var_192_0.localEulerAngles

				var_192_7.z = 0
				var_192_7.x = 0
				var_192_0.localEulerAngles = var_192_7
			end

			if arg_189_1.time_ >= var_192_1 + var_192_3 and arg_189_1.time_ < var_192_1 + var_192_3 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, 100, 0)

				local var_192_8 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_8.x, var_192_8.y, var_192_8.z)

				local var_192_9 = var_192_0.localEulerAngles

				var_192_9.z = 0
				var_192_9.x = 0
				var_192_0.localEulerAngles = var_192_9

				local var_192_10 = GameObjectTools.GetOrAddComponent(var_192_0.gameObject, typeof(DynamicBoneHelper))

				if var_192_10 then
					var_192_10:EnableDynamicBone(true)
				end
			end

			local var_192_11 = arg_189_1.actors_["4037ui_story"].transform
			local var_192_12 = 0

			if var_192_12 < arg_189_1.time_ and arg_189_1.time_ <= var_192_12 + arg_192_0 then
				arg_189_1.var_.moveOldPos4037ui_story = var_192_11.localPosition
			end

			local var_192_13 = 0.001

			if var_192_12 <= arg_189_1.time_ and arg_189_1.time_ < var_192_12 + var_192_13 then
				local var_192_14 = (arg_189_1.time_ - var_192_12) / var_192_13
				local var_192_15 = Vector3.New(0, 100, 0)

				var_192_11.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos4037ui_story, var_192_15, var_192_14)

				local var_192_16 = manager.ui.mainCamera.transform.position - var_192_11.position

				var_192_11.forward = Vector3.New(var_192_16.x, var_192_16.y, var_192_16.z)

				local var_192_17 = var_192_11.localEulerAngles

				var_192_17.z = 0
				var_192_17.x = 0
				var_192_11.localEulerAngles = var_192_17
			end

			if arg_189_1.time_ >= var_192_12 + var_192_13 and arg_189_1.time_ < var_192_12 + var_192_13 + arg_192_0 then
				var_192_11.localPosition = Vector3.New(0, 100, 0)

				local var_192_18 = manager.ui.mainCamera.transform.position - var_192_11.position

				var_192_11.forward = Vector3.New(var_192_18.x, var_192_18.y, var_192_18.z)

				local var_192_19 = var_192_11.localEulerAngles

				var_192_19.z = 0
				var_192_19.x = 0
				var_192_11.localEulerAngles = var_192_19
			end

			local var_192_20 = 0.200000002980232
			local var_192_21 = 1

			if var_192_20 < arg_189_1.time_ and arg_189_1.time_ <= var_192_20 + arg_192_0 then
				local var_192_22 = "play"
				local var_192_23 = "effect"

				arg_189_1:AudioAction(var_192_22, var_192_23, "se_story_145", "se_story_145_summon_slime2", "")
			end

			local var_192_24 = 0
			local var_192_25 = 1.225

			if var_192_24 < arg_189_1.time_ and arg_189_1.time_ <= var_192_24 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_26 = arg_189_1:GetWordFromCfg(322121046)
				local var_192_27 = arg_189_1:FormatText(var_192_26.content)

				arg_189_1.text_.text = var_192_27

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_28 = 49
				local var_192_29 = utf8.len(var_192_27)
				local var_192_30 = var_192_28 <= 0 and var_192_25 or var_192_25 * (var_192_29 / var_192_28)

				if var_192_30 > 0 and var_192_25 < var_192_30 then
					arg_189_1.talkMaxDuration = var_192_30

					if var_192_30 + var_192_24 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_30 + var_192_24
					end
				end

				arg_189_1.text_.text = var_192_27
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_31 = math.max(var_192_25, arg_189_1.talkMaxDuration)

			if var_192_24 <= arg_189_1.time_ and arg_189_1.time_ < var_192_24 + var_192_31 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_24) / var_192_31

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_24 + var_192_31 and arg_189_1.time_ < var_192_24 + var_192_31 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play322121047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 322121047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play322121048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 1.575

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(322121047)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 63
				local var_196_5 = utf8.len(var_196_3)
				local var_196_6 = var_196_4 <= 0 and var_196_1 or var_196_1 * (var_196_5 / var_196_4)

				if var_196_6 > 0 and var_196_1 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_7 and arg_193_1.time_ < var_196_0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play322121048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 322121048
		arg_197_1.duration_ = 2

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play322121049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["4037ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos4037ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0, -1.12, -6.2)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos4037ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["4037ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect4037ui_story == nil then
				arg_197_1.var_.characterEffect4037ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect4037ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect4037ui_story then
				arg_197_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_200_13 = 0

			if var_200_13 < arg_197_1.time_ and arg_197_1.time_ <= var_200_13 + arg_200_0 then
				arg_197_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_200_14 = 0

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva", "EmotionTimelineAnimator")
			end

			local var_200_15 = 0
			local var_200_16 = 0.05

			if var_200_15 < arg_197_1.time_ and arg_197_1.time_ <= var_200_15 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_17 = arg_197_1:FormatText(StoryNameCfg[453].name)

				arg_197_1.leftNameTxt_.text = var_200_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_18 = arg_197_1:GetWordFromCfg(322121048)
				local var_200_19 = arg_197_1:FormatText(var_200_18.content)

				arg_197_1.text_.text = var_200_19

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_20 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121048", "story_v_out_322121.awb") ~= 0 then
					local var_200_23 = manager.audio:GetVoiceLength("story_v_out_322121", "322121048", "story_v_out_322121.awb") / 1000

					if var_200_23 + var_200_15 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_23 + var_200_15
					end

					if var_200_18.prefab_name ~= "" and arg_197_1.actors_[var_200_18.prefab_name] ~= nil then
						local var_200_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_18.prefab_name].transform, "story_v_out_322121", "322121048", "story_v_out_322121.awb")

						arg_197_1:RecordAudio("322121048", var_200_24)
						arg_197_1:RecordAudio("322121048", var_200_24)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_322121", "322121048", "story_v_out_322121.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_322121", "322121048", "story_v_out_322121.awb")
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
				actorName = "4037ui_story",
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
	Play322121049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 322121049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play322121050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["4037ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos4037ui_story = var_204_0.localPosition
			end

			local var_204_2 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2
				local var_204_4 = Vector3.New(0, 100, 0)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos4037ui_story, var_204_4, var_204_3)

				local var_204_5 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_5.x, var_204_5.y, var_204_5.z)

				local var_204_6 = var_204_0.localEulerAngles

				var_204_6.z = 0
				var_204_6.x = 0
				var_204_0.localEulerAngles = var_204_6
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, 100, 0)

				local var_204_7 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_7.x, var_204_7.y, var_204_7.z)

				local var_204_8 = var_204_0.localEulerAngles

				var_204_8.z = 0
				var_204_8.x = 0
				var_204_0.localEulerAngles = var_204_8
			end

			local var_204_9 = 0.1
			local var_204_10 = 1

			if var_204_9 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 then
				local var_204_11 = "play"
				local var_204_12 = "effect"

				arg_201_1:AudioAction(var_204_11, var_204_12, "se_story_143", "se_story_143_walk08", "")
			end

			local var_204_13 = 0
			local var_204_14 = 1.35

			if var_204_13 < arg_201_1.time_ and arg_201_1.time_ <= var_204_13 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_15 = arg_201_1:GetWordFromCfg(322121049)
				local var_204_16 = arg_201_1:FormatText(var_204_15.content)

				arg_201_1.text_.text = var_204_16

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_17 = 54
				local var_204_18 = utf8.len(var_204_16)
				local var_204_19 = var_204_17 <= 0 and var_204_14 or var_204_14 * (var_204_18 / var_204_17)

				if var_204_19 > 0 and var_204_14 < var_204_19 then
					arg_201_1.talkMaxDuration = var_204_19

					if var_204_19 + var_204_13 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_19 + var_204_13
					end
				end

				arg_201_1.text_.text = var_204_16
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_20 = math.max(var_204_14, arg_201_1.talkMaxDuration)

			if var_204_13 <= arg_201_1.time_ and arg_201_1.time_ < var_204_13 + var_204_20 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_13) / var_204_20

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_13 + var_204_20 and arg_201_1.time_ < var_204_13 + var_204_20 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play322121050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 322121050
		arg_205_1.duration_ = 9.9

		local var_205_0 = {
			zh = 7.633,
			ja = 9.9
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play322121051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = "10150ui_story"

			if arg_205_1.actors_[var_208_0] == nil then
				local var_208_1 = Asset.Load("Char/" .. "10150ui_story")

				if not isNil(var_208_1) then
					local var_208_2 = Object.Instantiate(Asset.Load("Char/" .. "10150ui_story"), arg_205_1.stage_.transform)

					var_208_2.name = var_208_0
					var_208_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_205_1.actors_[var_208_0] = var_208_2

					local var_208_3 = var_208_2:GetComponentInChildren(typeof(CharacterEffect))

					var_208_3.enabled = true

					local var_208_4 = GameObjectTools.GetOrAddComponent(var_208_2, typeof(DynamicBoneHelper))

					if var_208_4 then
						var_208_4:EnableDynamicBone(false)
					end

					arg_205_1:ShowWeapon(var_208_3.transform, false)

					arg_205_1.var_[var_208_0 .. "Animator"] = var_208_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_205_1.var_[var_208_0 .. "Animator"].applyRootMotion = true
					arg_205_1.var_[var_208_0 .. "LipSync"] = var_208_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_208_5 = arg_205_1.actors_["10150ui_story"].transform
			local var_208_6 = 0

			if var_208_6 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 then
				arg_205_1.var_.moveOldPos10150ui_story = var_208_5.localPosition

				local var_208_7 = GameObjectTools.GetOrAddComponent(var_208_5.gameObject, typeof(DynamicBoneHelper))

				if var_208_7 then
					var_208_7:EnableDynamicBone(false)
				end
			end

			local var_208_8 = 0.001

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_8 then
				local var_208_9 = (arg_205_1.time_ - var_208_6) / var_208_8
				local var_208_10 = Vector3.New(-0.9, -1.73, -5.5)

				var_208_5.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10150ui_story, var_208_10, var_208_9)

				local var_208_11 = manager.ui.mainCamera.transform.position - var_208_5.position

				var_208_5.forward = Vector3.New(var_208_11.x, var_208_11.y, var_208_11.z)

				local var_208_12 = var_208_5.localEulerAngles

				var_208_12.z = 0
				var_208_12.x = 0
				var_208_5.localEulerAngles = var_208_12
			end

			if arg_205_1.time_ >= var_208_6 + var_208_8 and arg_205_1.time_ < var_208_6 + var_208_8 + arg_208_0 then
				var_208_5.localPosition = Vector3.New(-0.9, -1.73, -5.5)

				local var_208_13 = manager.ui.mainCamera.transform.position - var_208_5.position

				var_208_5.forward = Vector3.New(var_208_13.x, var_208_13.y, var_208_13.z)

				local var_208_14 = var_208_5.localEulerAngles

				var_208_14.z = 0
				var_208_14.x = 0
				var_208_5.localEulerAngles = var_208_14

				local var_208_15 = GameObjectTools.GetOrAddComponent(var_208_5.gameObject, typeof(DynamicBoneHelper))

				if var_208_15 then
					var_208_15:EnableDynamicBone(true)
				end
			end

			local var_208_16 = arg_205_1.actors_["10150ui_story"]
			local var_208_17 = 0

			if var_208_17 < arg_205_1.time_ and arg_205_1.time_ <= var_208_17 + arg_208_0 and not isNil(var_208_16) and arg_205_1.var_.characterEffect10150ui_story == nil then
				arg_205_1.var_.characterEffect10150ui_story = var_208_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_18 = 0.200000002980232

			if var_208_17 <= arg_205_1.time_ and arg_205_1.time_ < var_208_17 + var_208_18 and not isNil(var_208_16) then
				local var_208_19 = (arg_205_1.time_ - var_208_17) / var_208_18

				if arg_205_1.var_.characterEffect10150ui_story and not isNil(var_208_16) then
					arg_205_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_17 + var_208_18 and arg_205_1.time_ < var_208_17 + var_208_18 + arg_208_0 and not isNil(var_208_16) and arg_205_1.var_.characterEffect10150ui_story then
				arg_205_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_208_20 = 0

			if var_208_20 < arg_205_1.time_ and arg_205_1.time_ <= var_208_20 + arg_208_0 then
				arg_205_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			local var_208_21 = 0

			if var_208_21 < arg_205_1.time_ and arg_205_1.time_ <= var_208_21 + arg_208_0 then
				arg_205_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_208_22 = arg_205_1.actors_["4037ui_story"].transform
			local var_208_23 = 0

			if var_208_23 < arg_205_1.time_ and arg_205_1.time_ <= var_208_23 + arg_208_0 then
				arg_205_1.var_.moveOldPos4037ui_story = var_208_22.localPosition
			end

			local var_208_24 = 0.001

			if var_208_23 <= arg_205_1.time_ and arg_205_1.time_ < var_208_23 + var_208_24 then
				local var_208_25 = (arg_205_1.time_ - var_208_23) / var_208_24
				local var_208_26 = Vector3.New(0, 100, 0)

				var_208_22.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos4037ui_story, var_208_26, var_208_25)

				local var_208_27 = manager.ui.mainCamera.transform.position - var_208_22.position

				var_208_22.forward = Vector3.New(var_208_27.x, var_208_27.y, var_208_27.z)

				local var_208_28 = var_208_22.localEulerAngles

				var_208_28.z = 0
				var_208_28.x = 0
				var_208_22.localEulerAngles = var_208_28
			end

			if arg_205_1.time_ >= var_208_23 + var_208_24 and arg_205_1.time_ < var_208_23 + var_208_24 + arg_208_0 then
				var_208_22.localPosition = Vector3.New(0, 100, 0)

				local var_208_29 = manager.ui.mainCamera.transform.position - var_208_22.position

				var_208_22.forward = Vector3.New(var_208_29.x, var_208_29.y, var_208_29.z)

				local var_208_30 = var_208_22.localEulerAngles

				var_208_30.z = 0
				var_208_30.x = 0
				var_208_22.localEulerAngles = var_208_30
			end

			local var_208_31 = 0
			local var_208_32 = 0.475

			if var_208_31 < arg_205_1.time_ and arg_205_1.time_ <= var_208_31 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_33 = arg_205_1:FormatText(StoryNameCfg[1361].name)

				arg_205_1.leftNameTxt_.text = var_208_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_34 = arg_205_1:GetWordFromCfg(322121050)
				local var_208_35 = arg_205_1:FormatText(var_208_34.content)

				arg_205_1.text_.text = var_208_35

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_36 = 19
				local var_208_37 = utf8.len(var_208_35)
				local var_208_38 = var_208_36 <= 0 and var_208_32 or var_208_32 * (var_208_37 / var_208_36)

				if var_208_38 > 0 and var_208_32 < var_208_38 then
					arg_205_1.talkMaxDuration = var_208_38

					if var_208_38 + var_208_31 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_38 + var_208_31
					end
				end

				arg_205_1.text_.text = var_208_35
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121050", "story_v_out_322121.awb") ~= 0 then
					local var_208_39 = manager.audio:GetVoiceLength("story_v_out_322121", "322121050", "story_v_out_322121.awb") / 1000

					if var_208_39 + var_208_31 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_39 + var_208_31
					end

					if var_208_34.prefab_name ~= "" and arg_205_1.actors_[var_208_34.prefab_name] ~= nil then
						local var_208_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_34.prefab_name].transform, "story_v_out_322121", "322121050", "story_v_out_322121.awb")

						arg_205_1:RecordAudio("322121050", var_208_40)
						arg_205_1:RecordAudio("322121050", var_208_40)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_322121", "322121050", "story_v_out_322121.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_322121", "322121050", "story_v_out_322121.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_41 = math.max(var_208_32, arg_205_1.talkMaxDuration)

			if var_208_31 <= arg_205_1.time_ and arg_205_1.time_ < var_208_31 + var_208_41 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_31) / var_208_41

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_31 + var_208_41 and arg_205_1.time_ < var_208_31 + var_208_41 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play322121051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 322121051
		arg_209_1.duration_ = 10.2

		local var_209_0 = {
			zh = 6.533,
			ja = 10.2
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
				arg_209_0:Play322121052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["4037ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos4037ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0.7, -1.12, -6.2)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos4037ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = arg_209_1.actors_["4037ui_story"]
			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect4037ui_story == nil then
				arg_209_1.var_.characterEffect4037ui_story = var_212_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_11 = 0.200000002980232

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_11 and not isNil(var_212_9) then
				local var_212_12 = (arg_209_1.time_ - var_212_10) / var_212_11

				if arg_209_1.var_.characterEffect4037ui_story and not isNil(var_212_9) then
					arg_209_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_10 + var_212_11 and arg_209_1.time_ < var_212_10 + var_212_11 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect4037ui_story then
				arg_209_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_212_13 = arg_209_1.actors_["10150ui_story"]
			local var_212_14 = 0

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 and not isNil(var_212_13) and arg_209_1.var_.characterEffect10150ui_story == nil then
				arg_209_1.var_.characterEffect10150ui_story = var_212_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_15 = 0.200000002980232

			if var_212_14 <= arg_209_1.time_ and arg_209_1.time_ < var_212_14 + var_212_15 and not isNil(var_212_13) then
				local var_212_16 = (arg_209_1.time_ - var_212_14) / var_212_15

				if arg_209_1.var_.characterEffect10150ui_story and not isNil(var_212_13) then
					local var_212_17 = Mathf.Lerp(0, 0.5, var_212_16)

					arg_209_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_209_1.var_.characterEffect10150ui_story.fillRatio = var_212_17
				end
			end

			if arg_209_1.time_ >= var_212_14 + var_212_15 and arg_209_1.time_ < var_212_14 + var_212_15 + arg_212_0 and not isNil(var_212_13) and arg_209_1.var_.characterEffect10150ui_story then
				local var_212_18 = 0.5

				arg_209_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_209_1.var_.characterEffect10150ui_story.fillRatio = var_212_18
			end

			local var_212_19 = 0

			if var_212_19 < arg_209_1.time_ and arg_209_1.time_ <= var_212_19 + arg_212_0 then
				arg_209_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_212_20 = 0

			if var_212_20 < arg_209_1.time_ and arg_209_1.time_ <= var_212_20 + arg_212_0 then
				arg_209_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_212_21 = 0
			local var_212_22 = 0.7

			if var_212_21 < arg_209_1.time_ and arg_209_1.time_ <= var_212_21 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_23 = arg_209_1:FormatText(StoryNameCfg[453].name)

				arg_209_1.leftNameTxt_.text = var_212_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_24 = arg_209_1:GetWordFromCfg(322121051)
				local var_212_25 = arg_209_1:FormatText(var_212_24.content)

				arg_209_1.text_.text = var_212_25

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_26 = 28
				local var_212_27 = utf8.len(var_212_25)
				local var_212_28 = var_212_26 <= 0 and var_212_22 or var_212_22 * (var_212_27 / var_212_26)

				if var_212_28 > 0 and var_212_22 < var_212_28 then
					arg_209_1.talkMaxDuration = var_212_28

					if var_212_28 + var_212_21 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_28 + var_212_21
					end
				end

				arg_209_1.text_.text = var_212_25
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121051", "story_v_out_322121.awb") ~= 0 then
					local var_212_29 = manager.audio:GetVoiceLength("story_v_out_322121", "322121051", "story_v_out_322121.awb") / 1000

					if var_212_29 + var_212_21 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_29 + var_212_21
					end

					if var_212_24.prefab_name ~= "" and arg_209_1.actors_[var_212_24.prefab_name] ~= nil then
						local var_212_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_24.prefab_name].transform, "story_v_out_322121", "322121051", "story_v_out_322121.awb")

						arg_209_1:RecordAudio("322121051", var_212_30)
						arg_209_1:RecordAudio("322121051", var_212_30)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_322121", "322121051", "story_v_out_322121.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_322121", "322121051", "story_v_out_322121.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_31 = math.max(var_212_22, arg_209_1.talkMaxDuration)

			if var_212_21 <= arg_209_1.time_ and arg_209_1.time_ < var_212_21 + var_212_31 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_21) / var_212_31

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_21 + var_212_31 and arg_209_1.time_ < var_212_21 + var_212_31 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play322121052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 322121052
		arg_213_1.duration_ = 5.93

		local var_213_0 = {
			zh = 5.6,
			ja = 5.933
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
				arg_213_0:Play322121053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10150ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos10150ui_story = var_216_0.localPosition

				local var_216_2 = GameObjectTools.GetOrAddComponent(var_216_0.gameObject, typeof(DynamicBoneHelper))

				if var_216_2 then
					var_216_2:EnableDynamicBone(false)
				end
			end

			local var_216_3 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_3 then
				local var_216_4 = (arg_213_1.time_ - var_216_1) / var_216_3
				local var_216_5 = Vector3.New(-0.9, -1.73, -5.5)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10150ui_story, var_216_5, var_216_4)

				local var_216_6 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_6.x, var_216_6.y, var_216_6.z)

				local var_216_7 = var_216_0.localEulerAngles

				var_216_7.z = 0
				var_216_7.x = 0
				var_216_0.localEulerAngles = var_216_7
			end

			if arg_213_1.time_ >= var_216_1 + var_216_3 and arg_213_1.time_ < var_216_1 + var_216_3 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(-0.9, -1.73, -5.5)

				local var_216_8 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_8.x, var_216_8.y, var_216_8.z)

				local var_216_9 = var_216_0.localEulerAngles

				var_216_9.z = 0
				var_216_9.x = 0
				var_216_0.localEulerAngles = var_216_9

				local var_216_10 = GameObjectTools.GetOrAddComponent(var_216_0.gameObject, typeof(DynamicBoneHelper))

				if var_216_10 then
					var_216_10:EnableDynamicBone(true)
				end
			end

			local var_216_11 = arg_213_1.actors_["10150ui_story"]
			local var_216_12 = 0

			if var_216_12 < arg_213_1.time_ and arg_213_1.time_ <= var_216_12 + arg_216_0 and not isNil(var_216_11) and arg_213_1.var_.characterEffect10150ui_story == nil then
				arg_213_1.var_.characterEffect10150ui_story = var_216_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_13 = 0.200000002980232

			if var_216_12 <= arg_213_1.time_ and arg_213_1.time_ < var_216_12 + var_216_13 and not isNil(var_216_11) then
				local var_216_14 = (arg_213_1.time_ - var_216_12) / var_216_13

				if arg_213_1.var_.characterEffect10150ui_story and not isNil(var_216_11) then
					arg_213_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_12 + var_216_13 and arg_213_1.time_ < var_216_12 + var_216_13 + arg_216_0 and not isNil(var_216_11) and arg_213_1.var_.characterEffect10150ui_story then
				arg_213_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_216_15 = arg_213_1.actors_["4037ui_story"]
			local var_216_16 = 0

			if var_216_16 < arg_213_1.time_ and arg_213_1.time_ <= var_216_16 + arg_216_0 and not isNil(var_216_15) and arg_213_1.var_.characterEffect4037ui_story == nil then
				arg_213_1.var_.characterEffect4037ui_story = var_216_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_17 = 0.200000002980232

			if var_216_16 <= arg_213_1.time_ and arg_213_1.time_ < var_216_16 + var_216_17 and not isNil(var_216_15) then
				local var_216_18 = (arg_213_1.time_ - var_216_16) / var_216_17

				if arg_213_1.var_.characterEffect4037ui_story and not isNil(var_216_15) then
					local var_216_19 = Mathf.Lerp(0, 0.5, var_216_18)

					arg_213_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_213_1.var_.characterEffect4037ui_story.fillRatio = var_216_19
				end
			end

			if arg_213_1.time_ >= var_216_16 + var_216_17 and arg_213_1.time_ < var_216_16 + var_216_17 + arg_216_0 and not isNil(var_216_15) and arg_213_1.var_.characterEffect4037ui_story then
				local var_216_20 = 0.5

				arg_213_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_213_1.var_.characterEffect4037ui_story.fillRatio = var_216_20
			end

			local var_216_21 = 0

			if var_216_21 < arg_213_1.time_ and arg_213_1.time_ <= var_216_21 + arg_216_0 then
				arg_213_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_1")
			end

			local var_216_22 = 0

			if var_216_22 < arg_213_1.time_ and arg_213_1.time_ <= var_216_22 + arg_216_0 then
				arg_213_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_216_23 = 0
			local var_216_24 = 0.475

			if var_216_23 < arg_213_1.time_ and arg_213_1.time_ <= var_216_23 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_25 = arg_213_1:FormatText(StoryNameCfg[1361].name)

				arg_213_1.leftNameTxt_.text = var_216_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_26 = arg_213_1:GetWordFromCfg(322121052)
				local var_216_27 = arg_213_1:FormatText(var_216_26.content)

				arg_213_1.text_.text = var_216_27

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_28 = 19
				local var_216_29 = utf8.len(var_216_27)
				local var_216_30 = var_216_28 <= 0 and var_216_24 or var_216_24 * (var_216_29 / var_216_28)

				if var_216_30 > 0 and var_216_24 < var_216_30 then
					arg_213_1.talkMaxDuration = var_216_30

					if var_216_30 + var_216_23 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_30 + var_216_23
					end
				end

				arg_213_1.text_.text = var_216_27
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121052", "story_v_out_322121.awb") ~= 0 then
					local var_216_31 = manager.audio:GetVoiceLength("story_v_out_322121", "322121052", "story_v_out_322121.awb") / 1000

					if var_216_31 + var_216_23 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_31 + var_216_23
					end

					if var_216_26.prefab_name ~= "" and arg_213_1.actors_[var_216_26.prefab_name] ~= nil then
						local var_216_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_26.prefab_name].transform, "story_v_out_322121", "322121052", "story_v_out_322121.awb")

						arg_213_1:RecordAudio("322121052", var_216_32)
						arg_213_1:RecordAudio("322121052", var_216_32)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_322121", "322121052", "story_v_out_322121.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_322121", "322121052", "story_v_out_322121.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_33 = math.max(var_216_24, arg_213_1.talkMaxDuration)

			if var_216_23 <= arg_213_1.time_ and arg_213_1.time_ < var_216_23 + var_216_33 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_23) / var_216_33

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_23 + var_216_33 and arg_213_1.time_ < var_216_23 + var_216_33 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play322121053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 322121053
		arg_217_1.duration_ = 4.83

		local var_217_0 = {
			zh = 4.833,
			ja = 4.3
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play322121054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["4037ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos4037ui_story = var_220_0.localPosition
			end

			local var_220_2 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2
				local var_220_4 = Vector3.New(0.7, -1.12, -6.2)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos4037ui_story, var_220_4, var_220_3)

				local var_220_5 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_5.x, var_220_5.y, var_220_5.z)

				local var_220_6 = var_220_0.localEulerAngles

				var_220_6.z = 0
				var_220_6.x = 0
				var_220_0.localEulerAngles = var_220_6
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_220_7 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_7.x, var_220_7.y, var_220_7.z)

				local var_220_8 = var_220_0.localEulerAngles

				var_220_8.z = 0
				var_220_8.x = 0
				var_220_0.localEulerAngles = var_220_8
			end

			local var_220_9 = arg_217_1.actors_["4037ui_story"]
			local var_220_10 = 0

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect4037ui_story == nil then
				arg_217_1.var_.characterEffect4037ui_story = var_220_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_11 = 0.200000002980232

			if var_220_10 <= arg_217_1.time_ and arg_217_1.time_ < var_220_10 + var_220_11 and not isNil(var_220_9) then
				local var_220_12 = (arg_217_1.time_ - var_220_10) / var_220_11

				if arg_217_1.var_.characterEffect4037ui_story and not isNil(var_220_9) then
					arg_217_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_10 + var_220_11 and arg_217_1.time_ < var_220_10 + var_220_11 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect4037ui_story then
				arg_217_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_220_13 = arg_217_1.actors_["10150ui_story"]
			local var_220_14 = 0

			if var_220_14 < arg_217_1.time_ and arg_217_1.time_ <= var_220_14 + arg_220_0 and not isNil(var_220_13) and arg_217_1.var_.characterEffect10150ui_story == nil then
				arg_217_1.var_.characterEffect10150ui_story = var_220_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_15 = 0.200000002980232

			if var_220_14 <= arg_217_1.time_ and arg_217_1.time_ < var_220_14 + var_220_15 and not isNil(var_220_13) then
				local var_220_16 = (arg_217_1.time_ - var_220_14) / var_220_15

				if arg_217_1.var_.characterEffect10150ui_story and not isNil(var_220_13) then
					local var_220_17 = Mathf.Lerp(0, 0.5, var_220_16)

					arg_217_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_217_1.var_.characterEffect10150ui_story.fillRatio = var_220_17
				end
			end

			if arg_217_1.time_ >= var_220_14 + var_220_15 and arg_217_1.time_ < var_220_14 + var_220_15 + arg_220_0 and not isNil(var_220_13) and arg_217_1.var_.characterEffect10150ui_story then
				local var_220_18 = 0.5

				arg_217_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_217_1.var_.characterEffect10150ui_story.fillRatio = var_220_18
			end

			local var_220_19 = 0

			if var_220_19 < arg_217_1.time_ and arg_217_1.time_ <= var_220_19 + arg_220_0 then
				arg_217_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_220_20 = 0

			if var_220_20 < arg_217_1.time_ and arg_217_1.time_ <= var_220_20 + arg_220_0 then
				arg_217_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_220_21 = 0
			local var_220_22 = 0.05

			if var_220_21 < arg_217_1.time_ and arg_217_1.time_ <= var_220_21 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_23 = arg_217_1:FormatText(StoryNameCfg[453].name)

				arg_217_1.leftNameTxt_.text = var_220_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_24 = arg_217_1:GetWordFromCfg(322121053)
				local var_220_25 = arg_217_1:FormatText(var_220_24.content)

				arg_217_1.text_.text = var_220_25

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_26 = 2
				local var_220_27 = utf8.len(var_220_25)
				local var_220_28 = var_220_26 <= 0 and var_220_22 or var_220_22 * (var_220_27 / var_220_26)

				if var_220_28 > 0 and var_220_22 < var_220_28 then
					arg_217_1.talkMaxDuration = var_220_28

					if var_220_28 + var_220_21 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_28 + var_220_21
					end
				end

				arg_217_1.text_.text = var_220_25
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121053", "story_v_out_322121.awb") ~= 0 then
					local var_220_29 = manager.audio:GetVoiceLength("story_v_out_322121", "322121053", "story_v_out_322121.awb") / 1000

					if var_220_29 + var_220_21 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_29 + var_220_21
					end

					if var_220_24.prefab_name ~= "" and arg_217_1.actors_[var_220_24.prefab_name] ~= nil then
						local var_220_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_24.prefab_name].transform, "story_v_out_322121", "322121053", "story_v_out_322121.awb")

						arg_217_1:RecordAudio("322121053", var_220_30)
						arg_217_1:RecordAudio("322121053", var_220_30)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_322121", "322121053", "story_v_out_322121.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_322121", "322121053", "story_v_out_322121.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_31 = math.max(var_220_22, arg_217_1.talkMaxDuration)

			if var_220_21 <= arg_217_1.time_ and arg_217_1.time_ < var_220_21 + var_220_31 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_21) / var_220_31

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_21 + var_220_31 and arg_217_1.time_ < var_220_21 + var_220_31 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play322121054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 322121054
		arg_221_1.duration_ = 1.77

		local var_221_0 = {
			zh = 1.266,
			ja = 1.766
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
				arg_221_0:Play322121055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10150ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect10150ui_story == nil then
				arg_221_1.var_.characterEffect10150ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect10150ui_story and not isNil(var_224_0) then
					arg_221_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect10150ui_story then
				arg_221_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_224_4 = arg_221_1.actors_["4037ui_story"]
			local var_224_5 = 0

			if var_224_5 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 and not isNil(var_224_4) and arg_221_1.var_.characterEffect4037ui_story == nil then
				arg_221_1.var_.characterEffect4037ui_story = var_224_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_6 = 0.200000002980232

			if var_224_5 <= arg_221_1.time_ and arg_221_1.time_ < var_224_5 + var_224_6 and not isNil(var_224_4) then
				local var_224_7 = (arg_221_1.time_ - var_224_5) / var_224_6

				if arg_221_1.var_.characterEffect4037ui_story and not isNil(var_224_4) then
					local var_224_8 = Mathf.Lerp(0, 0.5, var_224_7)

					arg_221_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_221_1.var_.characterEffect4037ui_story.fillRatio = var_224_8
				end
			end

			if arg_221_1.time_ >= var_224_5 + var_224_6 and arg_221_1.time_ < var_224_5 + var_224_6 + arg_224_0 and not isNil(var_224_4) and arg_221_1.var_.characterEffect4037ui_story then
				local var_224_9 = 0.5

				arg_221_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_221_1.var_.characterEffect4037ui_story.fillRatio = var_224_9
			end

			local var_224_10 = 0
			local var_224_11 = 0.125

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_12 = arg_221_1:FormatText(StoryNameCfg[1361].name)

				arg_221_1.leftNameTxt_.text = var_224_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_13 = arg_221_1:GetWordFromCfg(322121054)
				local var_224_14 = arg_221_1:FormatText(var_224_13.content)

				arg_221_1.text_.text = var_224_14

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_15 = 5
				local var_224_16 = utf8.len(var_224_14)
				local var_224_17 = var_224_15 <= 0 and var_224_11 or var_224_11 * (var_224_16 / var_224_15)

				if var_224_17 > 0 and var_224_11 < var_224_17 then
					arg_221_1.talkMaxDuration = var_224_17

					if var_224_17 + var_224_10 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_17 + var_224_10
					end
				end

				arg_221_1.text_.text = var_224_14
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121054", "story_v_out_322121.awb") ~= 0 then
					local var_224_18 = manager.audio:GetVoiceLength("story_v_out_322121", "322121054", "story_v_out_322121.awb") / 1000

					if var_224_18 + var_224_10 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_18 + var_224_10
					end

					if var_224_13.prefab_name ~= "" and arg_221_1.actors_[var_224_13.prefab_name] ~= nil then
						local var_224_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_13.prefab_name].transform, "story_v_out_322121", "322121054", "story_v_out_322121.awb")

						arg_221_1:RecordAudio("322121054", var_224_19)
						arg_221_1:RecordAudio("322121054", var_224_19)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_322121", "322121054", "story_v_out_322121.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_322121", "322121054", "story_v_out_322121.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_20 = math.max(var_224_11, arg_221_1.talkMaxDuration)

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_20 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_10) / var_224_20

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_10 + var_224_20 and arg_221_1.time_ < var_224_10 + var_224_20 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play322121055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 322121055
		arg_225_1.duration_ = 5.73

		local var_225_0 = {
			zh = 4.033,
			ja = 5.733
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play322121056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["4037ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos4037ui_story = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(0.7, -1.12, -6.2)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos4037ui_story, var_228_4, var_228_3)

				local var_228_5 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_5.x, var_228_5.y, var_228_5.z)

				local var_228_6 = var_228_0.localEulerAngles

				var_228_6.z = 0
				var_228_6.x = 0
				var_228_0.localEulerAngles = var_228_6
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_228_7 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_7.x, var_228_7.y, var_228_7.z)

				local var_228_8 = var_228_0.localEulerAngles

				var_228_8.z = 0
				var_228_8.x = 0
				var_228_0.localEulerAngles = var_228_8
			end

			local var_228_9 = arg_225_1.actors_["4037ui_story"]
			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect4037ui_story == nil then
				arg_225_1.var_.characterEffect4037ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_11 = 0.200000002980232

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_11 and not isNil(var_228_9) then
				local var_228_12 = (arg_225_1.time_ - var_228_10) / var_228_11

				if arg_225_1.var_.characterEffect4037ui_story and not isNil(var_228_9) then
					arg_225_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_10 + var_228_11 and arg_225_1.time_ < var_228_10 + var_228_11 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect4037ui_story then
				arg_225_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_228_13 = arg_225_1.actors_["10150ui_story"]
			local var_228_14 = 0

			if var_228_14 < arg_225_1.time_ and arg_225_1.time_ <= var_228_14 + arg_228_0 and not isNil(var_228_13) and arg_225_1.var_.characterEffect10150ui_story == nil then
				arg_225_1.var_.characterEffect10150ui_story = var_228_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_15 = 0.200000002980232

			if var_228_14 <= arg_225_1.time_ and arg_225_1.time_ < var_228_14 + var_228_15 and not isNil(var_228_13) then
				local var_228_16 = (arg_225_1.time_ - var_228_14) / var_228_15

				if arg_225_1.var_.characterEffect10150ui_story and not isNil(var_228_13) then
					local var_228_17 = Mathf.Lerp(0, 0.5, var_228_16)

					arg_225_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10150ui_story.fillRatio = var_228_17
				end
			end

			if arg_225_1.time_ >= var_228_14 + var_228_15 and arg_225_1.time_ < var_228_14 + var_228_15 + arg_228_0 and not isNil(var_228_13) and arg_225_1.var_.characterEffect10150ui_story then
				local var_228_18 = 0.5

				arg_225_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10150ui_story.fillRatio = var_228_18
			end

			local var_228_19 = 0

			if var_228_19 < arg_225_1.time_ and arg_225_1.time_ <= var_228_19 + arg_228_0 then
				arg_225_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			local var_228_20 = 0

			if var_228_20 < arg_225_1.time_ and arg_225_1.time_ <= var_228_20 + arg_228_0 then
				arg_225_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_228_21 = 0
			local var_228_22 = 0.35

			if var_228_21 < arg_225_1.time_ and arg_225_1.time_ <= var_228_21 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_23 = arg_225_1:FormatText(StoryNameCfg[453].name)

				arg_225_1.leftNameTxt_.text = var_228_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_24 = arg_225_1:GetWordFromCfg(322121055)
				local var_228_25 = arg_225_1:FormatText(var_228_24.content)

				arg_225_1.text_.text = var_228_25

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_26 = 14
				local var_228_27 = utf8.len(var_228_25)
				local var_228_28 = var_228_26 <= 0 and var_228_22 or var_228_22 * (var_228_27 / var_228_26)

				if var_228_28 > 0 and var_228_22 < var_228_28 then
					arg_225_1.talkMaxDuration = var_228_28

					if var_228_28 + var_228_21 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_28 + var_228_21
					end
				end

				arg_225_1.text_.text = var_228_25
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121055", "story_v_out_322121.awb") ~= 0 then
					local var_228_29 = manager.audio:GetVoiceLength("story_v_out_322121", "322121055", "story_v_out_322121.awb") / 1000

					if var_228_29 + var_228_21 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_29 + var_228_21
					end

					if var_228_24.prefab_name ~= "" and arg_225_1.actors_[var_228_24.prefab_name] ~= nil then
						local var_228_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_24.prefab_name].transform, "story_v_out_322121", "322121055", "story_v_out_322121.awb")

						arg_225_1:RecordAudio("322121055", var_228_30)
						arg_225_1:RecordAudio("322121055", var_228_30)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_322121", "322121055", "story_v_out_322121.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_322121", "322121055", "story_v_out_322121.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_31 = math.max(var_228_22, arg_225_1.talkMaxDuration)

			if var_228_21 <= arg_225_1.time_ and arg_225_1.time_ < var_228_21 + var_228_31 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_21) / var_228_31

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_21 + var_228_31 and arg_225_1.time_ < var_228_21 + var_228_31 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play322121056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 322121056
		arg_229_1.duration_ = 4.73

		local var_229_0 = {
			zh = 4,
			ja = 4.733
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
				arg_229_0:Play322121057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10150ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect10150ui_story == nil then
				arg_229_1.var_.characterEffect10150ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect10150ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect10150ui_story then
				arg_229_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_232_4 = arg_229_1.actors_["4037ui_story"]
			local var_232_5 = 0

			if var_232_5 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 and not isNil(var_232_4) and arg_229_1.var_.characterEffect4037ui_story == nil then
				arg_229_1.var_.characterEffect4037ui_story = var_232_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_6 = 0.200000002980232

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_6 and not isNil(var_232_4) then
				local var_232_7 = (arg_229_1.time_ - var_232_5) / var_232_6

				if arg_229_1.var_.characterEffect4037ui_story and not isNil(var_232_4) then
					local var_232_8 = Mathf.Lerp(0, 0.5, var_232_7)

					arg_229_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_229_1.var_.characterEffect4037ui_story.fillRatio = var_232_8
				end
			end

			if arg_229_1.time_ >= var_232_5 + var_232_6 and arg_229_1.time_ < var_232_5 + var_232_6 + arg_232_0 and not isNil(var_232_4) and arg_229_1.var_.characterEffect4037ui_story then
				local var_232_9 = 0.5

				arg_229_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_229_1.var_.characterEffect4037ui_story.fillRatio = var_232_9
			end

			local var_232_10 = 0

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 then
				arg_229_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_2")
			end

			local var_232_11 = 0
			local var_232_12 = 0.25

			if var_232_11 < arg_229_1.time_ and arg_229_1.time_ <= var_232_11 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_13 = arg_229_1:FormatText(StoryNameCfg[1361].name)

				arg_229_1.leftNameTxt_.text = var_232_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_14 = arg_229_1:GetWordFromCfg(322121056)
				local var_232_15 = arg_229_1:FormatText(var_232_14.content)

				arg_229_1.text_.text = var_232_15

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_16 = 10
				local var_232_17 = utf8.len(var_232_15)
				local var_232_18 = var_232_16 <= 0 and var_232_12 or var_232_12 * (var_232_17 / var_232_16)

				if var_232_18 > 0 and var_232_12 < var_232_18 then
					arg_229_1.talkMaxDuration = var_232_18

					if var_232_18 + var_232_11 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_18 + var_232_11
					end
				end

				arg_229_1.text_.text = var_232_15
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121056", "story_v_out_322121.awb") ~= 0 then
					local var_232_19 = manager.audio:GetVoiceLength("story_v_out_322121", "322121056", "story_v_out_322121.awb") / 1000

					if var_232_19 + var_232_11 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_19 + var_232_11
					end

					if var_232_14.prefab_name ~= "" and arg_229_1.actors_[var_232_14.prefab_name] ~= nil then
						local var_232_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_14.prefab_name].transform, "story_v_out_322121", "322121056", "story_v_out_322121.awb")

						arg_229_1:RecordAudio("322121056", var_232_20)
						arg_229_1:RecordAudio("322121056", var_232_20)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_322121", "322121056", "story_v_out_322121.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_322121", "322121056", "story_v_out_322121.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_21 = math.max(var_232_12, arg_229_1.talkMaxDuration)

			if var_232_11 <= arg_229_1.time_ and arg_229_1.time_ < var_232_11 + var_232_21 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_11) / var_232_21

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_11 + var_232_21 and arg_229_1.time_ < var_232_11 + var_232_21 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play322121057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 322121057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play322121058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10150ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos10150ui_story = var_236_0.localPosition

				local var_236_2 = GameObjectTools.GetOrAddComponent(var_236_0.gameObject, typeof(DynamicBoneHelper))

				if var_236_2 then
					var_236_2:EnableDynamicBone(false)
				end
			end

			local var_236_3 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_3 then
				local var_236_4 = (arg_233_1.time_ - var_236_1) / var_236_3
				local var_236_5 = Vector3.New(0, 100, 0)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10150ui_story, var_236_5, var_236_4)

				local var_236_6 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_6.x, var_236_6.y, var_236_6.z)

				local var_236_7 = var_236_0.localEulerAngles

				var_236_7.z = 0
				var_236_7.x = 0
				var_236_0.localEulerAngles = var_236_7
			end

			if arg_233_1.time_ >= var_236_1 + var_236_3 and arg_233_1.time_ < var_236_1 + var_236_3 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, 100, 0)

				local var_236_8 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_8.x, var_236_8.y, var_236_8.z)

				local var_236_9 = var_236_0.localEulerAngles

				var_236_9.z = 0
				var_236_9.x = 0
				var_236_0.localEulerAngles = var_236_9

				local var_236_10 = GameObjectTools.GetOrAddComponent(var_236_0.gameObject, typeof(DynamicBoneHelper))

				if var_236_10 then
					var_236_10:EnableDynamicBone(true)
				end
			end

			local var_236_11 = arg_233_1.actors_["4037ui_story"].transform
			local var_236_12 = 0

			if var_236_12 < arg_233_1.time_ and arg_233_1.time_ <= var_236_12 + arg_236_0 then
				arg_233_1.var_.moveOldPos4037ui_story = var_236_11.localPosition
			end

			local var_236_13 = 0.001

			if var_236_12 <= arg_233_1.time_ and arg_233_1.time_ < var_236_12 + var_236_13 then
				local var_236_14 = (arg_233_1.time_ - var_236_12) / var_236_13
				local var_236_15 = Vector3.New(0, 100, 0)

				var_236_11.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos4037ui_story, var_236_15, var_236_14)

				local var_236_16 = manager.ui.mainCamera.transform.position - var_236_11.position

				var_236_11.forward = Vector3.New(var_236_16.x, var_236_16.y, var_236_16.z)

				local var_236_17 = var_236_11.localEulerAngles

				var_236_17.z = 0
				var_236_17.x = 0
				var_236_11.localEulerAngles = var_236_17
			end

			if arg_233_1.time_ >= var_236_12 + var_236_13 and arg_233_1.time_ < var_236_12 + var_236_13 + arg_236_0 then
				var_236_11.localPosition = Vector3.New(0, 100, 0)

				local var_236_18 = manager.ui.mainCamera.transform.position - var_236_11.position

				var_236_11.forward = Vector3.New(var_236_18.x, var_236_18.y, var_236_18.z)

				local var_236_19 = var_236_11.localEulerAngles

				var_236_19.z = 0
				var_236_19.x = 0
				var_236_11.localEulerAngles = var_236_19
			end

			local var_236_20 = 0.220118200406432
			local var_236_21 = 1

			if var_236_20 < arg_233_1.time_ and arg_233_1.time_ <= var_236_20 + arg_236_0 then
				local var_236_22 = "play"
				local var_236_23 = "effect"

				arg_233_1:AudioAction(var_236_22, var_236_23, "se_story_activity_1_2_1", "se_story_activity_1_2_1_sword", "")
			end

			local var_236_24 = 0
			local var_236_25 = 0.95

			if var_236_24 < arg_233_1.time_ and arg_233_1.time_ <= var_236_24 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_26 = arg_233_1:GetWordFromCfg(322121057)
				local var_236_27 = arg_233_1:FormatText(var_236_26.content)

				arg_233_1.text_.text = var_236_27

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_28 = 38
				local var_236_29 = utf8.len(var_236_27)
				local var_236_30 = var_236_28 <= 0 and var_236_25 or var_236_25 * (var_236_29 / var_236_28)

				if var_236_30 > 0 and var_236_25 < var_236_30 then
					arg_233_1.talkMaxDuration = var_236_30

					if var_236_30 + var_236_24 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_30 + var_236_24
					end
				end

				arg_233_1.text_.text = var_236_27
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_31 = math.max(var_236_25, arg_233_1.talkMaxDuration)

			if var_236_24 <= arg_233_1.time_ and arg_233_1.time_ < var_236_24 + var_236_31 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_24) / var_236_31

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_24 + var_236_31 and arg_233_1.time_ < var_236_24 + var_236_31 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play322121058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 322121058
		arg_237_1.duration_ = 2.07

		local var_237_0 = {
			zh = 1.533,
			ja = 2.066
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play322121059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["4037ui_story"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos4037ui_story = var_240_0.localPosition
			end

			local var_240_2 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2
				local var_240_4 = Vector3.New(-0.7, -1.12, -6.2)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos4037ui_story, var_240_4, var_240_3)

				local var_240_5 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_5.x, var_240_5.y, var_240_5.z)

				local var_240_6 = var_240_0.localEulerAngles

				var_240_6.z = 0
				var_240_6.x = 0
				var_240_0.localEulerAngles = var_240_6
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_240_7 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_7.x, var_240_7.y, var_240_7.z)

				local var_240_8 = var_240_0.localEulerAngles

				var_240_8.z = 0
				var_240_8.x = 0
				var_240_0.localEulerAngles = var_240_8
			end

			local var_240_9 = arg_237_1.actors_["4037ui_story"]
			local var_240_10 = 0

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect4037ui_story == nil then
				arg_237_1.var_.characterEffect4037ui_story = var_240_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_11 = 0.200000002980232

			if var_240_10 <= arg_237_1.time_ and arg_237_1.time_ < var_240_10 + var_240_11 and not isNil(var_240_9) then
				local var_240_12 = (arg_237_1.time_ - var_240_10) / var_240_11

				if arg_237_1.var_.characterEffect4037ui_story and not isNil(var_240_9) then
					arg_237_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_10 + var_240_11 and arg_237_1.time_ < var_240_10 + var_240_11 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect4037ui_story then
				arg_237_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_240_13 = 0

			if var_240_13 < arg_237_1.time_ and arg_237_1.time_ <= var_240_13 + arg_240_0 then
				arg_237_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_240_14 = 0

			if var_240_14 < arg_237_1.time_ and arg_237_1.time_ <= var_240_14 + arg_240_0 then
				arg_237_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_240_15 = 0
			local var_240_16 = 0.15

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_17 = arg_237_1:FormatText(StoryNameCfg[453].name)

				arg_237_1.leftNameTxt_.text = var_240_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_18 = arg_237_1:GetWordFromCfg(322121058)
				local var_240_19 = arg_237_1:FormatText(var_240_18.content)

				arg_237_1.text_.text = var_240_19

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_20 = 6
				local var_240_21 = utf8.len(var_240_19)
				local var_240_22 = var_240_20 <= 0 and var_240_16 or var_240_16 * (var_240_21 / var_240_20)

				if var_240_22 > 0 and var_240_16 < var_240_22 then
					arg_237_1.talkMaxDuration = var_240_22

					if var_240_22 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_22 + var_240_15
					end
				end

				arg_237_1.text_.text = var_240_19
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121058", "story_v_out_322121.awb") ~= 0 then
					local var_240_23 = manager.audio:GetVoiceLength("story_v_out_322121", "322121058", "story_v_out_322121.awb") / 1000

					if var_240_23 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_23 + var_240_15
					end

					if var_240_18.prefab_name ~= "" and arg_237_1.actors_[var_240_18.prefab_name] ~= nil then
						local var_240_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_18.prefab_name].transform, "story_v_out_322121", "322121058", "story_v_out_322121.awb")

						arg_237_1:RecordAudio("322121058", var_240_24)
						arg_237_1:RecordAudio("322121058", var_240_24)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_322121", "322121058", "story_v_out_322121.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_322121", "322121058", "story_v_out_322121.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_25 = math.max(var_240_16, arg_237_1.talkMaxDuration)

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_25 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_15) / var_240_25

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_15 + var_240_25 and arg_237_1.time_ < var_240_15 + var_240_25 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play322121059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 322121059
		arg_241_1.duration_ = 6.5

		local var_241_0 = {
			zh = 5.133,
			ja = 6.5
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play322121060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10150ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos10150ui_story = var_244_0.localPosition

				local var_244_2 = GameObjectTools.GetOrAddComponent(var_244_0.gameObject, typeof(DynamicBoneHelper))

				if var_244_2 then
					var_244_2:EnableDynamicBone(false)
				end
			end

			local var_244_3 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_3 then
				local var_244_4 = (arg_241_1.time_ - var_244_1) / var_244_3
				local var_244_5 = Vector3.New(0.9, -1.73, -5.5)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10150ui_story, var_244_5, var_244_4)

				local var_244_6 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_6.x, var_244_6.y, var_244_6.z)

				local var_244_7 = var_244_0.localEulerAngles

				var_244_7.z = 0
				var_244_7.x = 0
				var_244_0.localEulerAngles = var_244_7
			end

			if arg_241_1.time_ >= var_244_1 + var_244_3 and arg_241_1.time_ < var_244_1 + var_244_3 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0.9, -1.73, -5.5)

				local var_244_8 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_8.x, var_244_8.y, var_244_8.z)

				local var_244_9 = var_244_0.localEulerAngles

				var_244_9.z = 0
				var_244_9.x = 0
				var_244_0.localEulerAngles = var_244_9

				local var_244_10 = GameObjectTools.GetOrAddComponent(var_244_0.gameObject, typeof(DynamicBoneHelper))

				if var_244_10 then
					var_244_10:EnableDynamicBone(true)
				end
			end

			local var_244_11 = arg_241_1.actors_["10150ui_story"]
			local var_244_12 = 0

			if var_244_12 < arg_241_1.time_ and arg_241_1.time_ <= var_244_12 + arg_244_0 and not isNil(var_244_11) and arg_241_1.var_.characterEffect10150ui_story == nil then
				arg_241_1.var_.characterEffect10150ui_story = var_244_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_13 = 0.200000002980232

			if var_244_12 <= arg_241_1.time_ and arg_241_1.time_ < var_244_12 + var_244_13 and not isNil(var_244_11) then
				local var_244_14 = (arg_241_1.time_ - var_244_12) / var_244_13

				if arg_241_1.var_.characterEffect10150ui_story and not isNil(var_244_11) then
					arg_241_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_12 + var_244_13 and arg_241_1.time_ < var_244_12 + var_244_13 + arg_244_0 and not isNil(var_244_11) and arg_241_1.var_.characterEffect10150ui_story then
				arg_241_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_244_15 = arg_241_1.actors_["4037ui_story"]
			local var_244_16 = 0

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.characterEffect4037ui_story == nil then
				arg_241_1.var_.characterEffect4037ui_story = var_244_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_17 = 0.200000002980232

			if var_244_16 <= arg_241_1.time_ and arg_241_1.time_ < var_244_16 + var_244_17 and not isNil(var_244_15) then
				local var_244_18 = (arg_241_1.time_ - var_244_16) / var_244_17

				if arg_241_1.var_.characterEffect4037ui_story and not isNil(var_244_15) then
					local var_244_19 = Mathf.Lerp(0, 0.5, var_244_18)

					arg_241_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_241_1.var_.characterEffect4037ui_story.fillRatio = var_244_19
				end
			end

			if arg_241_1.time_ >= var_244_16 + var_244_17 and arg_241_1.time_ < var_244_16 + var_244_17 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.characterEffect4037ui_story then
				local var_244_20 = 0.5

				arg_241_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_241_1.var_.characterEffect4037ui_story.fillRatio = var_244_20
			end

			local var_244_21 = 0

			if var_244_21 < arg_241_1.time_ and arg_241_1.time_ <= var_244_21 + arg_244_0 then
				arg_241_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			local var_244_22 = 0

			if var_244_22 < arg_241_1.time_ and arg_241_1.time_ <= var_244_22 + arg_244_0 then
				arg_241_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_244_23 = 0
			local var_244_24 = 0.525

			if var_244_23 < arg_241_1.time_ and arg_241_1.time_ <= var_244_23 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_25 = arg_241_1:FormatText(StoryNameCfg[1361].name)

				arg_241_1.leftNameTxt_.text = var_244_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_26 = arg_241_1:GetWordFromCfg(322121059)
				local var_244_27 = arg_241_1:FormatText(var_244_26.content)

				arg_241_1.text_.text = var_244_27

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_28 = 21
				local var_244_29 = utf8.len(var_244_27)
				local var_244_30 = var_244_28 <= 0 and var_244_24 or var_244_24 * (var_244_29 / var_244_28)

				if var_244_30 > 0 and var_244_24 < var_244_30 then
					arg_241_1.talkMaxDuration = var_244_30

					if var_244_30 + var_244_23 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_30 + var_244_23
					end
				end

				arg_241_1.text_.text = var_244_27
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121059", "story_v_out_322121.awb") ~= 0 then
					local var_244_31 = manager.audio:GetVoiceLength("story_v_out_322121", "322121059", "story_v_out_322121.awb") / 1000

					if var_244_31 + var_244_23 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_31 + var_244_23
					end

					if var_244_26.prefab_name ~= "" and arg_241_1.actors_[var_244_26.prefab_name] ~= nil then
						local var_244_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_26.prefab_name].transform, "story_v_out_322121", "322121059", "story_v_out_322121.awb")

						arg_241_1:RecordAudio("322121059", var_244_32)
						arg_241_1:RecordAudio("322121059", var_244_32)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_322121", "322121059", "story_v_out_322121.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_322121", "322121059", "story_v_out_322121.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_33 = math.max(var_244_24, arg_241_1.talkMaxDuration)

			if var_244_23 <= arg_241_1.time_ and arg_241_1.time_ < var_244_23 + var_244_33 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_23) / var_244_33

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_23 + var_244_33 and arg_241_1.time_ < var_244_23 + var_244_33 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play322121060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 322121060
		arg_245_1.duration_ = 4.17

		local var_245_0 = {
			zh = 2.433,
			ja = 4.166
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play322121061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["4037ui_story"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos4037ui_story = var_248_0.localPosition
			end

			local var_248_2 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2
				local var_248_4 = Vector3.New(-0.7, -1.12, -6.2)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos4037ui_story, var_248_4, var_248_3)

				local var_248_5 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_5.x, var_248_5.y, var_248_5.z)

				local var_248_6 = var_248_0.localEulerAngles

				var_248_6.z = 0
				var_248_6.x = 0
				var_248_0.localEulerAngles = var_248_6
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_248_7 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_7.x, var_248_7.y, var_248_7.z)

				local var_248_8 = var_248_0.localEulerAngles

				var_248_8.z = 0
				var_248_8.x = 0
				var_248_0.localEulerAngles = var_248_8
			end

			local var_248_9 = arg_245_1.actors_["4037ui_story"]
			local var_248_10 = 0

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 and not isNil(var_248_9) and arg_245_1.var_.characterEffect4037ui_story == nil then
				arg_245_1.var_.characterEffect4037ui_story = var_248_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_11 = 0.200000002980232

			if var_248_10 <= arg_245_1.time_ and arg_245_1.time_ < var_248_10 + var_248_11 and not isNil(var_248_9) then
				local var_248_12 = (arg_245_1.time_ - var_248_10) / var_248_11

				if arg_245_1.var_.characterEffect4037ui_story and not isNil(var_248_9) then
					arg_245_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_10 + var_248_11 and arg_245_1.time_ < var_248_10 + var_248_11 + arg_248_0 and not isNil(var_248_9) and arg_245_1.var_.characterEffect4037ui_story then
				arg_245_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_248_13 = arg_245_1.actors_["10150ui_story"]
			local var_248_14 = 0

			if var_248_14 < arg_245_1.time_ and arg_245_1.time_ <= var_248_14 + arg_248_0 and not isNil(var_248_13) and arg_245_1.var_.characterEffect10150ui_story == nil then
				arg_245_1.var_.characterEffect10150ui_story = var_248_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_15 = 0.200000002980232

			if var_248_14 <= arg_245_1.time_ and arg_245_1.time_ < var_248_14 + var_248_15 and not isNil(var_248_13) then
				local var_248_16 = (arg_245_1.time_ - var_248_14) / var_248_15

				if arg_245_1.var_.characterEffect10150ui_story and not isNil(var_248_13) then
					local var_248_17 = Mathf.Lerp(0, 0.5, var_248_16)

					arg_245_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10150ui_story.fillRatio = var_248_17
				end
			end

			if arg_245_1.time_ >= var_248_14 + var_248_15 and arg_245_1.time_ < var_248_14 + var_248_15 + arg_248_0 and not isNil(var_248_13) and arg_245_1.var_.characterEffect10150ui_story then
				local var_248_18 = 0.5

				arg_245_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10150ui_story.fillRatio = var_248_18
			end

			local var_248_19 = 0

			if var_248_19 < arg_245_1.time_ and arg_245_1.time_ <= var_248_19 + arg_248_0 then
				arg_245_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			local var_248_20 = 0

			if var_248_20 < arg_245_1.time_ and arg_245_1.time_ <= var_248_20 + arg_248_0 then
				arg_245_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_248_21 = 0
			local var_248_22 = 0.2

			if var_248_21 < arg_245_1.time_ and arg_245_1.time_ <= var_248_21 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_23 = arg_245_1:FormatText(StoryNameCfg[453].name)

				arg_245_1.leftNameTxt_.text = var_248_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_24 = arg_245_1:GetWordFromCfg(322121060)
				local var_248_25 = arg_245_1:FormatText(var_248_24.content)

				arg_245_1.text_.text = var_248_25

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_26 = 8
				local var_248_27 = utf8.len(var_248_25)
				local var_248_28 = var_248_26 <= 0 and var_248_22 or var_248_22 * (var_248_27 / var_248_26)

				if var_248_28 > 0 and var_248_22 < var_248_28 then
					arg_245_1.talkMaxDuration = var_248_28

					if var_248_28 + var_248_21 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_28 + var_248_21
					end
				end

				arg_245_1.text_.text = var_248_25
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121060", "story_v_out_322121.awb") ~= 0 then
					local var_248_29 = manager.audio:GetVoiceLength("story_v_out_322121", "322121060", "story_v_out_322121.awb") / 1000

					if var_248_29 + var_248_21 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_29 + var_248_21
					end

					if var_248_24.prefab_name ~= "" and arg_245_1.actors_[var_248_24.prefab_name] ~= nil then
						local var_248_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_24.prefab_name].transform, "story_v_out_322121", "322121060", "story_v_out_322121.awb")

						arg_245_1:RecordAudio("322121060", var_248_30)
						arg_245_1:RecordAudio("322121060", var_248_30)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_322121", "322121060", "story_v_out_322121.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_322121", "322121060", "story_v_out_322121.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_31 = math.max(var_248_22, arg_245_1.talkMaxDuration)

			if var_248_21 <= arg_245_1.time_ and arg_245_1.time_ < var_248_21 + var_248_31 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_21) / var_248_31

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_21 + var_248_31 and arg_245_1.time_ < var_248_21 + var_248_31 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play322121061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 322121061
		arg_249_1.duration_ = 8.07

		local var_249_0 = {
			zh = 6.366,
			ja = 8.066
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
				arg_249_0:Play322121062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10150ui_story"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos10150ui_story = var_252_0.localPosition

				local var_252_2 = GameObjectTools.GetOrAddComponent(var_252_0.gameObject, typeof(DynamicBoneHelper))

				if var_252_2 then
					var_252_2:EnableDynamicBone(false)
				end
			end

			local var_252_3 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_3 then
				local var_252_4 = (arg_249_1.time_ - var_252_1) / var_252_3
				local var_252_5 = Vector3.New(0.9, -1.73, -5.5)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10150ui_story, var_252_5, var_252_4)

				local var_252_6 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_6.x, var_252_6.y, var_252_6.z)

				local var_252_7 = var_252_0.localEulerAngles

				var_252_7.z = 0
				var_252_7.x = 0
				var_252_0.localEulerAngles = var_252_7
			end

			if arg_249_1.time_ >= var_252_1 + var_252_3 and arg_249_1.time_ < var_252_1 + var_252_3 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0.9, -1.73, -5.5)

				local var_252_8 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_8.x, var_252_8.y, var_252_8.z)

				local var_252_9 = var_252_0.localEulerAngles

				var_252_9.z = 0
				var_252_9.x = 0
				var_252_0.localEulerAngles = var_252_9

				local var_252_10 = GameObjectTools.GetOrAddComponent(var_252_0.gameObject, typeof(DynamicBoneHelper))

				if var_252_10 then
					var_252_10:EnableDynamicBone(true)
				end
			end

			local var_252_11 = arg_249_1.actors_["10150ui_story"]
			local var_252_12 = 0

			if var_252_12 < arg_249_1.time_ and arg_249_1.time_ <= var_252_12 + arg_252_0 and not isNil(var_252_11) and arg_249_1.var_.characterEffect10150ui_story == nil then
				arg_249_1.var_.characterEffect10150ui_story = var_252_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_13 = 0.200000002980232

			if var_252_12 <= arg_249_1.time_ and arg_249_1.time_ < var_252_12 + var_252_13 and not isNil(var_252_11) then
				local var_252_14 = (arg_249_1.time_ - var_252_12) / var_252_13

				if arg_249_1.var_.characterEffect10150ui_story and not isNil(var_252_11) then
					arg_249_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_12 + var_252_13 and arg_249_1.time_ < var_252_12 + var_252_13 + arg_252_0 and not isNil(var_252_11) and arg_249_1.var_.characterEffect10150ui_story then
				arg_249_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_252_15 = arg_249_1.actors_["4037ui_story"]
			local var_252_16 = 0

			if var_252_16 < arg_249_1.time_ and arg_249_1.time_ <= var_252_16 + arg_252_0 and not isNil(var_252_15) and arg_249_1.var_.characterEffect4037ui_story == nil then
				arg_249_1.var_.characterEffect4037ui_story = var_252_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_17 = 0.200000002980232

			if var_252_16 <= arg_249_1.time_ and arg_249_1.time_ < var_252_16 + var_252_17 and not isNil(var_252_15) then
				local var_252_18 = (arg_249_1.time_ - var_252_16) / var_252_17

				if arg_249_1.var_.characterEffect4037ui_story and not isNil(var_252_15) then
					local var_252_19 = Mathf.Lerp(0, 0.5, var_252_18)

					arg_249_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_249_1.var_.characterEffect4037ui_story.fillRatio = var_252_19
				end
			end

			if arg_249_1.time_ >= var_252_16 + var_252_17 and arg_249_1.time_ < var_252_16 + var_252_17 + arg_252_0 and not isNil(var_252_15) and arg_249_1.var_.characterEffect4037ui_story then
				local var_252_20 = 0.5

				arg_249_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_249_1.var_.characterEffect4037ui_story.fillRatio = var_252_20
			end

			local var_252_21 = 0
			local var_252_22 = 0.55

			if var_252_21 < arg_249_1.time_ and arg_249_1.time_ <= var_252_21 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_23 = arg_249_1:FormatText(StoryNameCfg[1361].name)

				arg_249_1.leftNameTxt_.text = var_252_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_24 = arg_249_1:GetWordFromCfg(322121061)
				local var_252_25 = arg_249_1:FormatText(var_252_24.content)

				arg_249_1.text_.text = var_252_25

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_26 = 22
				local var_252_27 = utf8.len(var_252_25)
				local var_252_28 = var_252_26 <= 0 and var_252_22 or var_252_22 * (var_252_27 / var_252_26)

				if var_252_28 > 0 and var_252_22 < var_252_28 then
					arg_249_1.talkMaxDuration = var_252_28

					if var_252_28 + var_252_21 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_28 + var_252_21
					end
				end

				arg_249_1.text_.text = var_252_25
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121061", "story_v_out_322121.awb") ~= 0 then
					local var_252_29 = manager.audio:GetVoiceLength("story_v_out_322121", "322121061", "story_v_out_322121.awb") / 1000

					if var_252_29 + var_252_21 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_29 + var_252_21
					end

					if var_252_24.prefab_name ~= "" and arg_249_1.actors_[var_252_24.prefab_name] ~= nil then
						local var_252_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_24.prefab_name].transform, "story_v_out_322121", "322121061", "story_v_out_322121.awb")

						arg_249_1:RecordAudio("322121061", var_252_30)
						arg_249_1:RecordAudio("322121061", var_252_30)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_322121", "322121061", "story_v_out_322121.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_322121", "322121061", "story_v_out_322121.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_31 = math.max(var_252_22, arg_249_1.talkMaxDuration)

			if var_252_21 <= arg_249_1.time_ and arg_249_1.time_ < var_252_21 + var_252_31 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_21) / var_252_31

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_21 + var_252_31 and arg_249_1.time_ < var_252_21 + var_252_31 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322121062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 322121062
		arg_253_1.duration_ = 4.37

		local var_253_0 = {
			zh = 1.999999999999,
			ja = 4.366
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play322121063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["4037ui_story"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos4037ui_story = var_256_0.localPosition
			end

			local var_256_2 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2
				local var_256_4 = Vector3.New(-0.7, -1.12, -6.2)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos4037ui_story, var_256_4, var_256_3)

				local var_256_5 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_5.x, var_256_5.y, var_256_5.z)

				local var_256_6 = var_256_0.localEulerAngles

				var_256_6.z = 0
				var_256_6.x = 0
				var_256_0.localEulerAngles = var_256_6
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_256_7 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_7.x, var_256_7.y, var_256_7.z)

				local var_256_8 = var_256_0.localEulerAngles

				var_256_8.z = 0
				var_256_8.x = 0
				var_256_0.localEulerAngles = var_256_8
			end

			local var_256_9 = arg_253_1.actors_["4037ui_story"]
			local var_256_10 = 0

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect4037ui_story == nil then
				arg_253_1.var_.characterEffect4037ui_story = var_256_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_11 = 0.200000002980232

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_11 and not isNil(var_256_9) then
				local var_256_12 = (arg_253_1.time_ - var_256_10) / var_256_11

				if arg_253_1.var_.characterEffect4037ui_story and not isNil(var_256_9) then
					arg_253_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_10 + var_256_11 and arg_253_1.time_ < var_256_10 + var_256_11 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect4037ui_story then
				arg_253_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_256_13 = arg_253_1.actors_["10150ui_story"]
			local var_256_14 = 0

			if var_256_14 < arg_253_1.time_ and arg_253_1.time_ <= var_256_14 + arg_256_0 and not isNil(var_256_13) and arg_253_1.var_.characterEffect10150ui_story == nil then
				arg_253_1.var_.characterEffect10150ui_story = var_256_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_15 = 0.200000002980232

			if var_256_14 <= arg_253_1.time_ and arg_253_1.time_ < var_256_14 + var_256_15 and not isNil(var_256_13) then
				local var_256_16 = (arg_253_1.time_ - var_256_14) / var_256_15

				if arg_253_1.var_.characterEffect10150ui_story and not isNil(var_256_13) then
					local var_256_17 = Mathf.Lerp(0, 0.5, var_256_16)

					arg_253_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10150ui_story.fillRatio = var_256_17
				end
			end

			if arg_253_1.time_ >= var_256_14 + var_256_15 and arg_253_1.time_ < var_256_14 + var_256_15 + arg_256_0 and not isNil(var_256_13) and arg_253_1.var_.characterEffect10150ui_story then
				local var_256_18 = 0.5

				arg_253_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10150ui_story.fillRatio = var_256_18
			end

			local var_256_19 = 0

			if var_256_19 < arg_253_1.time_ and arg_253_1.time_ <= var_256_19 + arg_256_0 then
				arg_253_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_2")
			end

			local var_256_20 = 0

			if var_256_20 < arg_253_1.time_ and arg_253_1.time_ <= var_256_20 + arg_256_0 then
				arg_253_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_256_21 = 0
			local var_256_22 = 0.175

			if var_256_21 < arg_253_1.time_ and arg_253_1.time_ <= var_256_21 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_23 = arg_253_1:FormatText(StoryNameCfg[453].name)

				arg_253_1.leftNameTxt_.text = var_256_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_24 = arg_253_1:GetWordFromCfg(322121062)
				local var_256_25 = arg_253_1:FormatText(var_256_24.content)

				arg_253_1.text_.text = var_256_25

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_26 = 7
				local var_256_27 = utf8.len(var_256_25)
				local var_256_28 = var_256_26 <= 0 and var_256_22 or var_256_22 * (var_256_27 / var_256_26)

				if var_256_28 > 0 and var_256_22 < var_256_28 then
					arg_253_1.talkMaxDuration = var_256_28

					if var_256_28 + var_256_21 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_28 + var_256_21
					end
				end

				arg_253_1.text_.text = var_256_25
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121062", "story_v_out_322121.awb") ~= 0 then
					local var_256_29 = manager.audio:GetVoiceLength("story_v_out_322121", "322121062", "story_v_out_322121.awb") / 1000

					if var_256_29 + var_256_21 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_29 + var_256_21
					end

					if var_256_24.prefab_name ~= "" and arg_253_1.actors_[var_256_24.prefab_name] ~= nil then
						local var_256_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_24.prefab_name].transform, "story_v_out_322121", "322121062", "story_v_out_322121.awb")

						arg_253_1:RecordAudio("322121062", var_256_30)
						arg_253_1:RecordAudio("322121062", var_256_30)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_322121", "322121062", "story_v_out_322121.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_322121", "322121062", "story_v_out_322121.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_31 = math.max(var_256_22, arg_253_1.talkMaxDuration)

			if var_256_21 <= arg_253_1.time_ and arg_253_1.time_ < var_256_21 + var_256_31 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_21) / var_256_31

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_21 + var_256_31 and arg_253_1.time_ < var_256_21 + var_256_31 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play322121063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 322121063
		arg_257_1.duration_ = 7.9

		local var_257_0 = {
			zh = 7.133,
			ja = 7.9
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
				arg_257_0:Play322121064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10150ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos10150ui_story = var_260_0.localPosition

				local var_260_2 = GameObjectTools.GetOrAddComponent(var_260_0.gameObject, typeof(DynamicBoneHelper))

				if var_260_2 then
					var_260_2:EnableDynamicBone(false)
				end
			end

			local var_260_3 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_3 then
				local var_260_4 = (arg_257_1.time_ - var_260_1) / var_260_3
				local var_260_5 = Vector3.New(0.9, -1.73, -5.5)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10150ui_story, var_260_5, var_260_4)

				local var_260_6 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_6.x, var_260_6.y, var_260_6.z)

				local var_260_7 = var_260_0.localEulerAngles

				var_260_7.z = 0
				var_260_7.x = 0
				var_260_0.localEulerAngles = var_260_7
			end

			if arg_257_1.time_ >= var_260_1 + var_260_3 and arg_257_1.time_ < var_260_1 + var_260_3 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0.9, -1.73, -5.5)

				local var_260_8 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_8.x, var_260_8.y, var_260_8.z)

				local var_260_9 = var_260_0.localEulerAngles

				var_260_9.z = 0
				var_260_9.x = 0
				var_260_0.localEulerAngles = var_260_9

				local var_260_10 = GameObjectTools.GetOrAddComponent(var_260_0.gameObject, typeof(DynamicBoneHelper))

				if var_260_10 then
					var_260_10:EnableDynamicBone(true)
				end
			end

			local var_260_11 = arg_257_1.actors_["10150ui_story"]
			local var_260_12 = 0

			if var_260_12 < arg_257_1.time_ and arg_257_1.time_ <= var_260_12 + arg_260_0 and not isNil(var_260_11) and arg_257_1.var_.characterEffect10150ui_story == nil then
				arg_257_1.var_.characterEffect10150ui_story = var_260_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_13 = 0.200000002980232

			if var_260_12 <= arg_257_1.time_ and arg_257_1.time_ < var_260_12 + var_260_13 and not isNil(var_260_11) then
				local var_260_14 = (arg_257_1.time_ - var_260_12) / var_260_13

				if arg_257_1.var_.characterEffect10150ui_story and not isNil(var_260_11) then
					arg_257_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_12 + var_260_13 and arg_257_1.time_ < var_260_12 + var_260_13 + arg_260_0 and not isNil(var_260_11) and arg_257_1.var_.characterEffect10150ui_story then
				arg_257_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_260_15 = arg_257_1.actors_["4037ui_story"]
			local var_260_16 = 0

			if var_260_16 < arg_257_1.time_ and arg_257_1.time_ <= var_260_16 + arg_260_0 and not isNil(var_260_15) and arg_257_1.var_.characterEffect4037ui_story == nil then
				arg_257_1.var_.characterEffect4037ui_story = var_260_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_17 = 0.200000002980232

			if var_260_16 <= arg_257_1.time_ and arg_257_1.time_ < var_260_16 + var_260_17 and not isNil(var_260_15) then
				local var_260_18 = (arg_257_1.time_ - var_260_16) / var_260_17

				if arg_257_1.var_.characterEffect4037ui_story and not isNil(var_260_15) then
					local var_260_19 = Mathf.Lerp(0, 0.5, var_260_18)

					arg_257_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_257_1.var_.characterEffect4037ui_story.fillRatio = var_260_19
				end
			end

			if arg_257_1.time_ >= var_260_16 + var_260_17 and arg_257_1.time_ < var_260_16 + var_260_17 + arg_260_0 and not isNil(var_260_15) and arg_257_1.var_.characterEffect4037ui_story then
				local var_260_20 = 0.5

				arg_257_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_257_1.var_.characterEffect4037ui_story.fillRatio = var_260_20
			end

			local var_260_21 = 0

			if var_260_21 < arg_257_1.time_ and arg_257_1.time_ <= var_260_21 + arg_260_0 then
				arg_257_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action6_1")
			end

			local var_260_22 = 0

			if var_260_22 < arg_257_1.time_ and arg_257_1.time_ <= var_260_22 + arg_260_0 then
				arg_257_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_260_23 = 0
			local var_260_24 = 0.625

			if var_260_23 < arg_257_1.time_ and arg_257_1.time_ <= var_260_23 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_25 = arg_257_1:FormatText(StoryNameCfg[1361].name)

				arg_257_1.leftNameTxt_.text = var_260_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_26 = arg_257_1:GetWordFromCfg(322121063)
				local var_260_27 = arg_257_1:FormatText(var_260_26.content)

				arg_257_1.text_.text = var_260_27

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_28 = 25
				local var_260_29 = utf8.len(var_260_27)
				local var_260_30 = var_260_28 <= 0 and var_260_24 or var_260_24 * (var_260_29 / var_260_28)

				if var_260_30 > 0 and var_260_24 < var_260_30 then
					arg_257_1.talkMaxDuration = var_260_30

					if var_260_30 + var_260_23 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_30 + var_260_23
					end
				end

				arg_257_1.text_.text = var_260_27
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121063", "story_v_out_322121.awb") ~= 0 then
					local var_260_31 = manager.audio:GetVoiceLength("story_v_out_322121", "322121063", "story_v_out_322121.awb") / 1000

					if var_260_31 + var_260_23 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_31 + var_260_23
					end

					if var_260_26.prefab_name ~= "" and arg_257_1.actors_[var_260_26.prefab_name] ~= nil then
						local var_260_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_26.prefab_name].transform, "story_v_out_322121", "322121063", "story_v_out_322121.awb")

						arg_257_1:RecordAudio("322121063", var_260_32)
						arg_257_1:RecordAudio("322121063", var_260_32)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_322121", "322121063", "story_v_out_322121.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_322121", "322121063", "story_v_out_322121.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_33 = math.max(var_260_24, arg_257_1.talkMaxDuration)

			if var_260_23 <= arg_257_1.time_ and arg_257_1.time_ < var_260_23 + var_260_33 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_23) / var_260_33

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_23 + var_260_33 and arg_257_1.time_ < var_260_23 + var_260_33 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play322121064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 322121064
		arg_261_1.duration_ = 2.4

		local var_261_0 = {
			zh = 1.8,
			ja = 2.4
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
				arg_261_0:Play322121065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["4037ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect4037ui_story == nil then
				arg_261_1.var_.characterEffect4037ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect4037ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect4037ui_story then
				arg_261_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_264_4 = arg_261_1.actors_["10150ui_story"]
			local var_264_5 = 0

			if var_264_5 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect10150ui_story == nil then
				arg_261_1.var_.characterEffect10150ui_story = var_264_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_6 = 0.200000002980232

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_6 and not isNil(var_264_4) then
				local var_264_7 = (arg_261_1.time_ - var_264_5) / var_264_6

				if arg_261_1.var_.characterEffect10150ui_story and not isNil(var_264_4) then
					local var_264_8 = Mathf.Lerp(0, 0.5, var_264_7)

					arg_261_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_261_1.var_.characterEffect10150ui_story.fillRatio = var_264_8
				end
			end

			if arg_261_1.time_ >= var_264_5 + var_264_6 and arg_261_1.time_ < var_264_5 + var_264_6 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect10150ui_story then
				local var_264_9 = 0.5

				arg_261_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_261_1.var_.characterEffect10150ui_story.fillRatio = var_264_9
			end

			local var_264_10 = 0
			local var_264_11 = 0.125

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_12 = arg_261_1:FormatText(StoryNameCfg[453].name)

				arg_261_1.leftNameTxt_.text = var_264_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_13 = arg_261_1:GetWordFromCfg(322121064)
				local var_264_14 = arg_261_1:FormatText(var_264_13.content)

				arg_261_1.text_.text = var_264_14

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_15 = 5
				local var_264_16 = utf8.len(var_264_14)
				local var_264_17 = var_264_15 <= 0 and var_264_11 or var_264_11 * (var_264_16 / var_264_15)

				if var_264_17 > 0 and var_264_11 < var_264_17 then
					arg_261_1.talkMaxDuration = var_264_17

					if var_264_17 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_17 + var_264_10
					end
				end

				arg_261_1.text_.text = var_264_14
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121064", "story_v_out_322121.awb") ~= 0 then
					local var_264_18 = manager.audio:GetVoiceLength("story_v_out_322121", "322121064", "story_v_out_322121.awb") / 1000

					if var_264_18 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_18 + var_264_10
					end

					if var_264_13.prefab_name ~= "" and arg_261_1.actors_[var_264_13.prefab_name] ~= nil then
						local var_264_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_13.prefab_name].transform, "story_v_out_322121", "322121064", "story_v_out_322121.awb")

						arg_261_1:RecordAudio("322121064", var_264_19)
						arg_261_1:RecordAudio("322121064", var_264_19)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_322121", "322121064", "story_v_out_322121.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_322121", "322121064", "story_v_out_322121.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_20 = math.max(var_264_11, arg_261_1.talkMaxDuration)

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_20 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_10) / var_264_20

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_10 + var_264_20 and arg_261_1.time_ < var_264_10 + var_264_20 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play322121065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 322121065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play322121066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["10150ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos10150ui_story = var_268_0.localPosition

				local var_268_2 = GameObjectTools.GetOrAddComponent(var_268_0.gameObject, typeof(DynamicBoneHelper))

				if var_268_2 then
					var_268_2:EnableDynamicBone(false)
				end
			end

			local var_268_3 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_3 then
				local var_268_4 = (arg_265_1.time_ - var_268_1) / var_268_3
				local var_268_5 = Vector3.New(0, 100, 0)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10150ui_story, var_268_5, var_268_4)

				local var_268_6 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_6.x, var_268_6.y, var_268_6.z)

				local var_268_7 = var_268_0.localEulerAngles

				var_268_7.z = 0
				var_268_7.x = 0
				var_268_0.localEulerAngles = var_268_7
			end

			if arg_265_1.time_ >= var_268_1 + var_268_3 and arg_265_1.time_ < var_268_1 + var_268_3 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(0, 100, 0)

				local var_268_8 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_8.x, var_268_8.y, var_268_8.z)

				local var_268_9 = var_268_0.localEulerAngles

				var_268_9.z = 0
				var_268_9.x = 0
				var_268_0.localEulerAngles = var_268_9

				local var_268_10 = GameObjectTools.GetOrAddComponent(var_268_0.gameObject, typeof(DynamicBoneHelper))

				if var_268_10 then
					var_268_10:EnableDynamicBone(true)
				end
			end

			local var_268_11 = arg_265_1.actors_["4037ui_story"].transform
			local var_268_12 = 0

			if var_268_12 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 then
				arg_265_1.var_.moveOldPos4037ui_story = var_268_11.localPosition
			end

			local var_268_13 = 0.001

			if var_268_12 <= arg_265_1.time_ and arg_265_1.time_ < var_268_12 + var_268_13 then
				local var_268_14 = (arg_265_1.time_ - var_268_12) / var_268_13
				local var_268_15 = Vector3.New(0, 100, 0)

				var_268_11.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos4037ui_story, var_268_15, var_268_14)

				local var_268_16 = manager.ui.mainCamera.transform.position - var_268_11.position

				var_268_11.forward = Vector3.New(var_268_16.x, var_268_16.y, var_268_16.z)

				local var_268_17 = var_268_11.localEulerAngles

				var_268_17.z = 0
				var_268_17.x = 0
				var_268_11.localEulerAngles = var_268_17
			end

			if arg_265_1.time_ >= var_268_12 + var_268_13 and arg_265_1.time_ < var_268_12 + var_268_13 + arg_268_0 then
				var_268_11.localPosition = Vector3.New(0, 100, 0)

				local var_268_18 = manager.ui.mainCamera.transform.position - var_268_11.position

				var_268_11.forward = Vector3.New(var_268_18.x, var_268_18.y, var_268_18.z)

				local var_268_19 = var_268_11.localEulerAngles

				var_268_19.z = 0
				var_268_19.x = 0
				var_268_11.localEulerAngles = var_268_19
			end

			local var_268_20 = 0
			local var_268_21 = 1.375

			if var_268_20 < arg_265_1.time_ and arg_265_1.time_ <= var_268_20 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_22 = arg_265_1:GetWordFromCfg(322121065)
				local var_268_23 = arg_265_1:FormatText(var_268_22.content)

				arg_265_1.text_.text = var_268_23

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_24 = 55
				local var_268_25 = utf8.len(var_268_23)
				local var_268_26 = var_268_24 <= 0 and var_268_21 or var_268_21 * (var_268_25 / var_268_24)

				if var_268_26 > 0 and var_268_21 < var_268_26 then
					arg_265_1.talkMaxDuration = var_268_26

					if var_268_26 + var_268_20 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_26 + var_268_20
					end
				end

				arg_265_1.text_.text = var_268_23
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_27 = math.max(var_268_21, arg_265_1.talkMaxDuration)

			if var_268_20 <= arg_265_1.time_ and arg_265_1.time_ < var_268_20 + var_268_27 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_20) / var_268_27

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_20 + var_268_27 and arg_265_1.time_ < var_268_20 + var_268_27 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play322121066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322121066
		arg_269_1.duration_ = 11

		local var_269_0 = {
			zh = 7.666,
			ja = 11
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
				arg_269_0:Play322121067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["4037ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos4037ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0, -1.12, -6.2)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos4037ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["4037ui_story"]
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect4037ui_story == nil then
				arg_269_1.var_.characterEffect4037ui_story = var_272_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.200000002980232

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 and not isNil(var_272_9) then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11

				if arg_269_1.var_.characterEffect4037ui_story and not isNil(var_272_9) then
					arg_269_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect4037ui_story then
				arg_269_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_272_13 = 0

			if var_272_13 < arg_269_1.time_ and arg_269_1.time_ <= var_272_13 + arg_272_0 then
				arg_269_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_272_14 = 0

			if var_272_14 < arg_269_1.time_ and arg_269_1.time_ <= var_272_14 + arg_272_0 then
				arg_269_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_272_15 = 0
			local var_272_16 = 0.7

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_17 = arg_269_1:FormatText(StoryNameCfg[453].name)

				arg_269_1.leftNameTxt_.text = var_272_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_18 = arg_269_1:GetWordFromCfg(322121066)
				local var_272_19 = arg_269_1:FormatText(var_272_18.content)

				arg_269_1.text_.text = var_272_19

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_20 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121066", "story_v_out_322121.awb") ~= 0 then
					local var_272_23 = manager.audio:GetVoiceLength("story_v_out_322121", "322121066", "story_v_out_322121.awb") / 1000

					if var_272_23 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_23 + var_272_15
					end

					if var_272_18.prefab_name ~= "" and arg_269_1.actors_[var_272_18.prefab_name] ~= nil then
						local var_272_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_18.prefab_name].transform, "story_v_out_322121", "322121066", "story_v_out_322121.awb")

						arg_269_1:RecordAudio("322121066", var_272_24)
						arg_269_1:RecordAudio("322121066", var_272_24)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322121", "322121066", "story_v_out_322121.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322121", "322121066", "story_v_out_322121.awb")
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
				actorName = "4037ui_story",
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
	Play322121067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322121067
		arg_273_1.duration_ = 12.7

		local var_273_0 = {
			zh = 7,
			ja = 12.7
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play322121068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action5_1")
			end

			local var_276_1 = 0
			local var_276_2 = 0.725

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_3 = arg_273_1:FormatText(StoryNameCfg[453].name)

				arg_273_1.leftNameTxt_.text = var_276_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_4 = arg_273_1:GetWordFromCfg(322121067)
				local var_276_5 = arg_273_1:FormatText(var_276_4.content)

				arg_273_1.text_.text = var_276_5

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_6 = 29
				local var_276_7 = utf8.len(var_276_5)
				local var_276_8 = var_276_6 <= 0 and var_276_2 or var_276_2 * (var_276_7 / var_276_6)

				if var_276_8 > 0 and var_276_2 < var_276_8 then
					arg_273_1.talkMaxDuration = var_276_8

					if var_276_8 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_5
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121067", "story_v_out_322121.awb") ~= 0 then
					local var_276_9 = manager.audio:GetVoiceLength("story_v_out_322121", "322121067", "story_v_out_322121.awb") / 1000

					if var_276_9 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_1
					end

					if var_276_4.prefab_name ~= "" and arg_273_1.actors_[var_276_4.prefab_name] ~= nil then
						local var_276_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_4.prefab_name].transform, "story_v_out_322121", "322121067", "story_v_out_322121.awb")

						arg_273_1:RecordAudio("322121067", var_276_10)
						arg_273_1:RecordAudio("322121067", var_276_10)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322121", "322121067", "story_v_out_322121.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322121", "322121067", "story_v_out_322121.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_11 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_11 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_11

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_11 and arg_273_1.time_ < var_276_1 + var_276_11 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play322121068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322121068
		arg_277_1.duration_ = 11.97

		local var_277_0 = {
			zh = 8.966,
			ja = 11.966
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play322121069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.8

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[453].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_3 = arg_277_1:GetWordFromCfg(322121068)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 32
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121068", "story_v_out_322121.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_out_322121", "322121068", "story_v_out_322121.awb") / 1000

					if var_280_8 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_0
					end

					if var_280_3.prefab_name ~= "" and arg_277_1.actors_[var_280_3.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_3.prefab_name].transform, "story_v_out_322121", "322121068", "story_v_out_322121.awb")

						arg_277_1:RecordAudio("322121068", var_280_9)
						arg_277_1:RecordAudio("322121068", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322121", "322121068", "story_v_out_322121.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322121", "322121068", "story_v_out_322121.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_10 and arg_277_1.time_ < var_280_0 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play322121069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322121069
		arg_281_1.duration_ = 3.4

		local var_281_0 = {
			zh = 3.4,
			ja = 2.766
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play322121070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10150ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos10150ui_story = var_284_0.localPosition

				local var_284_2 = GameObjectTools.GetOrAddComponent(var_284_0.gameObject, typeof(DynamicBoneHelper))

				if var_284_2 then
					var_284_2:EnableDynamicBone(false)
				end
			end

			local var_284_3 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_3 then
				local var_284_4 = (arg_281_1.time_ - var_284_1) / var_284_3
				local var_284_5 = Vector3.New(0, -1.73, -5.5)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10150ui_story, var_284_5, var_284_4)

				local var_284_6 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_6.x, var_284_6.y, var_284_6.z)

				local var_284_7 = var_284_0.localEulerAngles

				var_284_7.z = 0
				var_284_7.x = 0
				var_284_0.localEulerAngles = var_284_7
			end

			if arg_281_1.time_ >= var_284_1 + var_284_3 and arg_281_1.time_ < var_284_1 + var_284_3 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, -1.73, -5.5)

				local var_284_8 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_8.x, var_284_8.y, var_284_8.z)

				local var_284_9 = var_284_0.localEulerAngles

				var_284_9.z = 0
				var_284_9.x = 0
				var_284_0.localEulerAngles = var_284_9

				local var_284_10 = GameObjectTools.GetOrAddComponent(var_284_0.gameObject, typeof(DynamicBoneHelper))

				if var_284_10 then
					var_284_10:EnableDynamicBone(true)
				end
			end

			local var_284_11 = arg_281_1.actors_["4037ui_story"].transform
			local var_284_12 = 0

			if var_284_12 < arg_281_1.time_ and arg_281_1.time_ <= var_284_12 + arg_284_0 then
				arg_281_1.var_.moveOldPos4037ui_story = var_284_11.localPosition
			end

			local var_284_13 = 0.001

			if var_284_12 <= arg_281_1.time_ and arg_281_1.time_ < var_284_12 + var_284_13 then
				local var_284_14 = (arg_281_1.time_ - var_284_12) / var_284_13
				local var_284_15 = Vector3.New(0, 100, 0)

				var_284_11.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos4037ui_story, var_284_15, var_284_14)

				local var_284_16 = manager.ui.mainCamera.transform.position - var_284_11.position

				var_284_11.forward = Vector3.New(var_284_16.x, var_284_16.y, var_284_16.z)

				local var_284_17 = var_284_11.localEulerAngles

				var_284_17.z = 0
				var_284_17.x = 0
				var_284_11.localEulerAngles = var_284_17
			end

			if arg_281_1.time_ >= var_284_12 + var_284_13 and arg_281_1.time_ < var_284_12 + var_284_13 + arg_284_0 then
				var_284_11.localPosition = Vector3.New(0, 100, 0)

				local var_284_18 = manager.ui.mainCamera.transform.position - var_284_11.position

				var_284_11.forward = Vector3.New(var_284_18.x, var_284_18.y, var_284_18.z)

				local var_284_19 = var_284_11.localEulerAngles

				var_284_19.z = 0
				var_284_19.x = 0
				var_284_11.localEulerAngles = var_284_19
			end

			local var_284_20 = arg_281_1.actors_["10150ui_story"]
			local var_284_21 = 0

			if var_284_21 < arg_281_1.time_ and arg_281_1.time_ <= var_284_21 + arg_284_0 and not isNil(var_284_20) and arg_281_1.var_.characterEffect10150ui_story == nil then
				arg_281_1.var_.characterEffect10150ui_story = var_284_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_22 = 0.200000002980232

			if var_284_21 <= arg_281_1.time_ and arg_281_1.time_ < var_284_21 + var_284_22 and not isNil(var_284_20) then
				local var_284_23 = (arg_281_1.time_ - var_284_21) / var_284_22

				if arg_281_1.var_.characterEffect10150ui_story and not isNil(var_284_20) then
					arg_281_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_21 + var_284_22 and arg_281_1.time_ < var_284_21 + var_284_22 + arg_284_0 and not isNil(var_284_20) and arg_281_1.var_.characterEffect10150ui_story then
				arg_281_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_284_24 = arg_281_1.actors_["4037ui_story"]
			local var_284_25 = 0

			if var_284_25 < arg_281_1.time_ and arg_281_1.time_ <= var_284_25 + arg_284_0 and not isNil(var_284_24) and arg_281_1.var_.characterEffect4037ui_story == nil then
				arg_281_1.var_.characterEffect4037ui_story = var_284_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_26 = 0.200000002980232

			if var_284_25 <= arg_281_1.time_ and arg_281_1.time_ < var_284_25 + var_284_26 and not isNil(var_284_24) then
				local var_284_27 = (arg_281_1.time_ - var_284_25) / var_284_26

				if arg_281_1.var_.characterEffect4037ui_story and not isNil(var_284_24) then
					local var_284_28 = Mathf.Lerp(0, 0.5, var_284_27)

					arg_281_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_281_1.var_.characterEffect4037ui_story.fillRatio = var_284_28
				end
			end

			if arg_281_1.time_ >= var_284_25 + var_284_26 and arg_281_1.time_ < var_284_25 + var_284_26 + arg_284_0 and not isNil(var_284_24) and arg_281_1.var_.characterEffect4037ui_story then
				local var_284_29 = 0.5

				arg_281_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_281_1.var_.characterEffect4037ui_story.fillRatio = var_284_29
			end

			local var_284_30 = 0

			if var_284_30 < arg_281_1.time_ and arg_281_1.time_ <= var_284_30 + arg_284_0 then
				arg_281_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action3_1")
			end

			local var_284_31 = 0
			local var_284_32 = 0.275

			if var_284_31 < arg_281_1.time_ and arg_281_1.time_ <= var_284_31 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_33 = arg_281_1:FormatText(StoryNameCfg[1361].name)

				arg_281_1.leftNameTxt_.text = var_284_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_34 = arg_281_1:GetWordFromCfg(322121069)
				local var_284_35 = arg_281_1:FormatText(var_284_34.content)

				arg_281_1.text_.text = var_284_35

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_36 = 11
				local var_284_37 = utf8.len(var_284_35)
				local var_284_38 = var_284_36 <= 0 and var_284_32 or var_284_32 * (var_284_37 / var_284_36)

				if var_284_38 > 0 and var_284_32 < var_284_38 then
					arg_281_1.talkMaxDuration = var_284_38

					if var_284_38 + var_284_31 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_38 + var_284_31
					end
				end

				arg_281_1.text_.text = var_284_35
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121069", "story_v_out_322121.awb") ~= 0 then
					local var_284_39 = manager.audio:GetVoiceLength("story_v_out_322121", "322121069", "story_v_out_322121.awb") / 1000

					if var_284_39 + var_284_31 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_39 + var_284_31
					end

					if var_284_34.prefab_name ~= "" and arg_281_1.actors_[var_284_34.prefab_name] ~= nil then
						local var_284_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_34.prefab_name].transform, "story_v_out_322121", "322121069", "story_v_out_322121.awb")

						arg_281_1:RecordAudio("322121069", var_284_40)
						arg_281_1:RecordAudio("322121069", var_284_40)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_322121", "322121069", "story_v_out_322121.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_322121", "322121069", "story_v_out_322121.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_41 = math.max(var_284_32, arg_281_1.talkMaxDuration)

			if var_284_31 <= arg_281_1.time_ and arg_281_1.time_ < var_284_31 + var_284_41 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_31) / var_284_41

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_31 + var_284_41 and arg_281_1.time_ < var_284_31 + var_284_41 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play322121070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322121070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play322121071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10150ui_story"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos10150ui_story = var_288_0.localPosition

				local var_288_2 = GameObjectTools.GetOrAddComponent(var_288_0.gameObject, typeof(DynamicBoneHelper))

				if var_288_2 then
					var_288_2:EnableDynamicBone(false)
				end
			end

			local var_288_3 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_3 then
				local var_288_4 = (arg_285_1.time_ - var_288_1) / var_288_3
				local var_288_5 = Vector3.New(0, 100, 0)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10150ui_story, var_288_5, var_288_4)

				local var_288_6 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_6.x, var_288_6.y, var_288_6.z)

				local var_288_7 = var_288_0.localEulerAngles

				var_288_7.z = 0
				var_288_7.x = 0
				var_288_0.localEulerAngles = var_288_7
			end

			if arg_285_1.time_ >= var_288_1 + var_288_3 and arg_285_1.time_ < var_288_1 + var_288_3 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(0, 100, 0)

				local var_288_8 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_8.x, var_288_8.y, var_288_8.z)

				local var_288_9 = var_288_0.localEulerAngles

				var_288_9.z = 0
				var_288_9.x = 0
				var_288_0.localEulerAngles = var_288_9

				local var_288_10 = GameObjectTools.GetOrAddComponent(var_288_0.gameObject, typeof(DynamicBoneHelper))

				if var_288_10 then
					var_288_10:EnableDynamicBone(true)
				end
			end

			local var_288_11 = 0.1
			local var_288_12 = 1

			if var_288_11 < arg_285_1.time_ and arg_285_1.time_ <= var_288_11 + arg_288_0 then
				local var_288_13 = "play"
				local var_288_14 = "effect"

				arg_285_1:AudioAction(var_288_13, var_288_14, "se_story_140", "se_story_140_drop02", "")
			end

			local var_288_15 = 0
			local var_288_16 = 1.15

			if var_288_15 < arg_285_1.time_ and arg_285_1.time_ <= var_288_15 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_17 = arg_285_1:GetWordFromCfg(322121070)
				local var_288_18 = arg_285_1:FormatText(var_288_17.content)

				arg_285_1.text_.text = var_288_18

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_19 = 46
				local var_288_20 = utf8.len(var_288_18)
				local var_288_21 = var_288_19 <= 0 and var_288_16 or var_288_16 * (var_288_20 / var_288_19)

				if var_288_21 > 0 and var_288_16 < var_288_21 then
					arg_285_1.talkMaxDuration = var_288_21

					if var_288_21 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_21 + var_288_15
					end
				end

				arg_285_1.text_.text = var_288_18
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_22 = math.max(var_288_16, arg_285_1.talkMaxDuration)

			if var_288_15 <= arg_285_1.time_ and arg_285_1.time_ < var_288_15 + var_288_22 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_15) / var_288_22

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_15 + var_288_22 and arg_285_1.time_ < var_288_15 + var_288_22 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play322121071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322121071
		arg_289_1.duration_ = 5.5

		local var_289_0 = {
			zh = 4.533,
			ja = 5.5
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play322121072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["4037ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos4037ui_story = var_292_0.localPosition
			end

			local var_292_2 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2
				local var_292_4 = Vector3.New(-0.7, -1.12, -6.2)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos4037ui_story, var_292_4, var_292_3)

				local var_292_5 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_5.x, var_292_5.y, var_292_5.z)

				local var_292_6 = var_292_0.localEulerAngles

				var_292_6.z = 0
				var_292_6.x = 0
				var_292_0.localEulerAngles = var_292_6
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_292_7 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_7.x, var_292_7.y, var_292_7.z)

				local var_292_8 = var_292_0.localEulerAngles

				var_292_8.z = 0
				var_292_8.x = 0
				var_292_0.localEulerAngles = var_292_8
			end

			local var_292_9 = arg_289_1.actors_["4037ui_story"]
			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 and not isNil(var_292_9) and arg_289_1.var_.characterEffect4037ui_story == nil then
				arg_289_1.var_.characterEffect4037ui_story = var_292_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_11 = 0.200000002980232

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_11 and not isNil(var_292_9) then
				local var_292_12 = (arg_289_1.time_ - var_292_10) / var_292_11

				if arg_289_1.var_.characterEffect4037ui_story and not isNil(var_292_9) then
					arg_289_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_10 + var_292_11 and arg_289_1.time_ < var_292_10 + var_292_11 + arg_292_0 and not isNil(var_292_9) and arg_289_1.var_.characterEffect4037ui_story then
				arg_289_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_292_13 = 0

			if var_292_13 < arg_289_1.time_ and arg_289_1.time_ <= var_292_13 + arg_292_0 then
				arg_289_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_292_14 = 0

			if var_292_14 < arg_289_1.time_ and arg_289_1.time_ <= var_292_14 + arg_292_0 then
				arg_289_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_292_15 = 0
			local var_292_16 = 0.35

			if var_292_15 < arg_289_1.time_ and arg_289_1.time_ <= var_292_15 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_17 = arg_289_1:FormatText(StoryNameCfg[453].name)

				arg_289_1.leftNameTxt_.text = var_292_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_18 = arg_289_1:GetWordFromCfg(322121071)
				local var_292_19 = arg_289_1:FormatText(var_292_18.content)

				arg_289_1.text_.text = var_292_19

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_20 = 14
				local var_292_21 = utf8.len(var_292_19)
				local var_292_22 = var_292_20 <= 0 and var_292_16 or var_292_16 * (var_292_21 / var_292_20)

				if var_292_22 > 0 and var_292_16 < var_292_22 then
					arg_289_1.talkMaxDuration = var_292_22

					if var_292_22 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_22 + var_292_15
					end
				end

				arg_289_1.text_.text = var_292_19
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121071", "story_v_out_322121.awb") ~= 0 then
					local var_292_23 = manager.audio:GetVoiceLength("story_v_out_322121", "322121071", "story_v_out_322121.awb") / 1000

					if var_292_23 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_23 + var_292_15
					end

					if var_292_18.prefab_name ~= "" and arg_289_1.actors_[var_292_18.prefab_name] ~= nil then
						local var_292_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_18.prefab_name].transform, "story_v_out_322121", "322121071", "story_v_out_322121.awb")

						arg_289_1:RecordAudio("322121071", var_292_24)
						arg_289_1:RecordAudio("322121071", var_292_24)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_322121", "322121071", "story_v_out_322121.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_322121", "322121071", "story_v_out_322121.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_25 = math.max(var_292_16, arg_289_1.talkMaxDuration)

			if var_292_15 <= arg_289_1.time_ and arg_289_1.time_ < var_292_15 + var_292_25 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_15) / var_292_25

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_15 + var_292_25 and arg_289_1.time_ < var_292_15 + var_292_25 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play322121072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 322121072
		arg_293_1.duration_ = 5.63

		local var_293_0 = {
			zh = 5.633,
			ja = 5.333
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play322121073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["10150ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos10150ui_story = var_296_0.localPosition

				local var_296_2 = GameObjectTools.GetOrAddComponent(var_296_0.gameObject, typeof(DynamicBoneHelper))

				if var_296_2 then
					var_296_2:EnableDynamicBone(false)
				end
			end

			local var_296_3 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_3 then
				local var_296_4 = (arg_293_1.time_ - var_296_1) / var_296_3
				local var_296_5 = Vector3.New(0.9, -1.73, -5.5)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10150ui_story, var_296_5, var_296_4)

				local var_296_6 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_6.x, var_296_6.y, var_296_6.z)

				local var_296_7 = var_296_0.localEulerAngles

				var_296_7.z = 0
				var_296_7.x = 0
				var_296_0.localEulerAngles = var_296_7
			end

			if arg_293_1.time_ >= var_296_1 + var_296_3 and arg_293_1.time_ < var_296_1 + var_296_3 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(0.9, -1.73, -5.5)

				local var_296_8 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_8.x, var_296_8.y, var_296_8.z)

				local var_296_9 = var_296_0.localEulerAngles

				var_296_9.z = 0
				var_296_9.x = 0
				var_296_0.localEulerAngles = var_296_9

				local var_296_10 = GameObjectTools.GetOrAddComponent(var_296_0.gameObject, typeof(DynamicBoneHelper))

				if var_296_10 then
					var_296_10:EnableDynamicBone(true)
				end
			end

			local var_296_11 = arg_293_1.actors_["10150ui_story"]
			local var_296_12 = 0

			if var_296_12 < arg_293_1.time_ and arg_293_1.time_ <= var_296_12 + arg_296_0 and not isNil(var_296_11) and arg_293_1.var_.characterEffect10150ui_story == nil then
				arg_293_1.var_.characterEffect10150ui_story = var_296_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_13 = 0.200000002980232

			if var_296_12 <= arg_293_1.time_ and arg_293_1.time_ < var_296_12 + var_296_13 and not isNil(var_296_11) then
				local var_296_14 = (arg_293_1.time_ - var_296_12) / var_296_13

				if arg_293_1.var_.characterEffect10150ui_story and not isNil(var_296_11) then
					arg_293_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_12 + var_296_13 and arg_293_1.time_ < var_296_12 + var_296_13 + arg_296_0 and not isNil(var_296_11) and arg_293_1.var_.characterEffect10150ui_story then
				arg_293_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_296_15 = arg_293_1.actors_["4037ui_story"]
			local var_296_16 = 0

			if var_296_16 < arg_293_1.time_ and arg_293_1.time_ <= var_296_16 + arg_296_0 and not isNil(var_296_15) and arg_293_1.var_.characterEffect4037ui_story == nil then
				arg_293_1.var_.characterEffect4037ui_story = var_296_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_17 = 0.200000002980232

			if var_296_16 <= arg_293_1.time_ and arg_293_1.time_ < var_296_16 + var_296_17 and not isNil(var_296_15) then
				local var_296_18 = (arg_293_1.time_ - var_296_16) / var_296_17

				if arg_293_1.var_.characterEffect4037ui_story and not isNil(var_296_15) then
					local var_296_19 = Mathf.Lerp(0, 0.5, var_296_18)

					arg_293_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_293_1.var_.characterEffect4037ui_story.fillRatio = var_296_19
				end
			end

			if arg_293_1.time_ >= var_296_16 + var_296_17 and arg_293_1.time_ < var_296_16 + var_296_17 + arg_296_0 and not isNil(var_296_15) and arg_293_1.var_.characterEffect4037ui_story then
				local var_296_20 = 0.5

				arg_293_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_293_1.var_.characterEffect4037ui_story.fillRatio = var_296_20
			end

			local var_296_21 = 0

			if var_296_21 < arg_293_1.time_ and arg_293_1.time_ <= var_296_21 + arg_296_0 then
				arg_293_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			local var_296_22 = 0

			if var_296_22 < arg_293_1.time_ and arg_293_1.time_ <= var_296_22 + arg_296_0 then
				arg_293_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_296_23 = 0
			local var_296_24 = 0.55

			if var_296_23 < arg_293_1.time_ and arg_293_1.time_ <= var_296_23 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_25 = arg_293_1:FormatText(StoryNameCfg[1361].name)

				arg_293_1.leftNameTxt_.text = var_296_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_26 = arg_293_1:GetWordFromCfg(322121072)
				local var_296_27 = arg_293_1:FormatText(var_296_26.content)

				arg_293_1.text_.text = var_296_27

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_28 = 22
				local var_296_29 = utf8.len(var_296_27)
				local var_296_30 = var_296_28 <= 0 and var_296_24 or var_296_24 * (var_296_29 / var_296_28)

				if var_296_30 > 0 and var_296_24 < var_296_30 then
					arg_293_1.talkMaxDuration = var_296_30

					if var_296_30 + var_296_23 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_30 + var_296_23
					end
				end

				arg_293_1.text_.text = var_296_27
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121072", "story_v_out_322121.awb") ~= 0 then
					local var_296_31 = manager.audio:GetVoiceLength("story_v_out_322121", "322121072", "story_v_out_322121.awb") / 1000

					if var_296_31 + var_296_23 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_31 + var_296_23
					end

					if var_296_26.prefab_name ~= "" and arg_293_1.actors_[var_296_26.prefab_name] ~= nil then
						local var_296_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_26.prefab_name].transform, "story_v_out_322121", "322121072", "story_v_out_322121.awb")

						arg_293_1:RecordAudio("322121072", var_296_32)
						arg_293_1:RecordAudio("322121072", var_296_32)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322121", "322121072", "story_v_out_322121.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322121", "322121072", "story_v_out_322121.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_33 = math.max(var_296_24, arg_293_1.talkMaxDuration)

			if var_296_23 <= arg_293_1.time_ and arg_293_1.time_ < var_296_23 + var_296_33 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_23) / var_296_33

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_23 + var_296_33 and arg_293_1.time_ < var_296_23 + var_296_33 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play322121073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 322121073
		arg_297_1.duration_ = 2.8

		local var_297_0 = {
			zh = 2.366,
			ja = 2.8
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play322121074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["4037ui_story"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos4037ui_story = var_300_0.localPosition
			end

			local var_300_2 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2
				local var_300_4 = Vector3.New(-0.7, -1.12, -6.2)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos4037ui_story, var_300_4, var_300_3)

				local var_300_5 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_5.x, var_300_5.y, var_300_5.z)

				local var_300_6 = var_300_0.localEulerAngles

				var_300_6.z = 0
				var_300_6.x = 0
				var_300_0.localEulerAngles = var_300_6
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(-0.7, -1.12, -6.2)

				local var_300_7 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_7.x, var_300_7.y, var_300_7.z)

				local var_300_8 = var_300_0.localEulerAngles

				var_300_8.z = 0
				var_300_8.x = 0
				var_300_0.localEulerAngles = var_300_8
			end

			local var_300_9 = arg_297_1.actors_["4037ui_story"]
			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 and not isNil(var_300_9) and arg_297_1.var_.characterEffect4037ui_story == nil then
				arg_297_1.var_.characterEffect4037ui_story = var_300_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_11 = 0.200000002980232

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_11 and not isNil(var_300_9) then
				local var_300_12 = (arg_297_1.time_ - var_300_10) / var_300_11

				if arg_297_1.var_.characterEffect4037ui_story and not isNil(var_300_9) then
					arg_297_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_10 + var_300_11 and arg_297_1.time_ < var_300_10 + var_300_11 + arg_300_0 and not isNil(var_300_9) and arg_297_1.var_.characterEffect4037ui_story then
				arg_297_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_300_13 = arg_297_1.actors_["10150ui_story"]
			local var_300_14 = 0

			if var_300_14 < arg_297_1.time_ and arg_297_1.time_ <= var_300_14 + arg_300_0 and not isNil(var_300_13) and arg_297_1.var_.characterEffect10150ui_story == nil then
				arg_297_1.var_.characterEffect10150ui_story = var_300_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_15 = 0.200000002980232

			if var_300_14 <= arg_297_1.time_ and arg_297_1.time_ < var_300_14 + var_300_15 and not isNil(var_300_13) then
				local var_300_16 = (arg_297_1.time_ - var_300_14) / var_300_15

				if arg_297_1.var_.characterEffect10150ui_story and not isNil(var_300_13) then
					local var_300_17 = Mathf.Lerp(0, 0.5, var_300_16)

					arg_297_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_297_1.var_.characterEffect10150ui_story.fillRatio = var_300_17
				end
			end

			if arg_297_1.time_ >= var_300_14 + var_300_15 and arg_297_1.time_ < var_300_14 + var_300_15 + arg_300_0 and not isNil(var_300_13) and arg_297_1.var_.characterEffect10150ui_story then
				local var_300_18 = 0.5

				arg_297_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_297_1.var_.characterEffect10150ui_story.fillRatio = var_300_18
			end

			local var_300_19 = 0

			if var_300_19 < arg_297_1.time_ and arg_297_1.time_ <= var_300_19 + arg_300_0 then
				arg_297_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action4_1")
			end

			local var_300_20 = 0

			if var_300_20 < arg_297_1.time_ and arg_297_1.time_ <= var_300_20 + arg_300_0 then
				arg_297_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_300_21 = 0
			local var_300_22 = 0.3

			if var_300_21 < arg_297_1.time_ and arg_297_1.time_ <= var_300_21 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_23 = arg_297_1:FormatText(StoryNameCfg[453].name)

				arg_297_1.leftNameTxt_.text = var_300_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_24 = arg_297_1:GetWordFromCfg(322121073)
				local var_300_25 = arg_297_1:FormatText(var_300_24.content)

				arg_297_1.text_.text = var_300_25

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_26 = 12
				local var_300_27 = utf8.len(var_300_25)
				local var_300_28 = var_300_26 <= 0 and var_300_22 or var_300_22 * (var_300_27 / var_300_26)

				if var_300_28 > 0 and var_300_22 < var_300_28 then
					arg_297_1.talkMaxDuration = var_300_28

					if var_300_28 + var_300_21 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_28 + var_300_21
					end
				end

				arg_297_1.text_.text = var_300_25
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121073", "story_v_out_322121.awb") ~= 0 then
					local var_300_29 = manager.audio:GetVoiceLength("story_v_out_322121", "322121073", "story_v_out_322121.awb") / 1000

					if var_300_29 + var_300_21 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_29 + var_300_21
					end

					if var_300_24.prefab_name ~= "" and arg_297_1.actors_[var_300_24.prefab_name] ~= nil then
						local var_300_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_24.prefab_name].transform, "story_v_out_322121", "322121073", "story_v_out_322121.awb")

						arg_297_1:RecordAudio("322121073", var_300_30)
						arg_297_1:RecordAudio("322121073", var_300_30)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_322121", "322121073", "story_v_out_322121.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_322121", "322121073", "story_v_out_322121.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_31 = math.max(var_300_22, arg_297_1.talkMaxDuration)

			if var_300_21 <= arg_297_1.time_ and arg_297_1.time_ < var_300_21 + var_300_31 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_21) / var_300_31

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_21 + var_300_31 and arg_297_1.time_ < var_300_21 + var_300_31 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play322121074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 322121074
		arg_301_1.duration_ = 2.63

		local var_301_0 = {
			zh = 2.633,
			ja = 2.466
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play322121075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action4_2")
			end

			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_304_2 = 0
			local var_304_3 = 0.2

			if var_304_2 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_4 = arg_301_1:FormatText(StoryNameCfg[453].name)

				arg_301_1.leftNameTxt_.text = var_304_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_5 = arg_301_1:GetWordFromCfg(322121074)
				local var_304_6 = arg_301_1:FormatText(var_304_5.content)

				arg_301_1.text_.text = var_304_6

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_7 = 8
				local var_304_8 = utf8.len(var_304_6)
				local var_304_9 = var_304_7 <= 0 and var_304_3 or var_304_3 * (var_304_8 / var_304_7)

				if var_304_9 > 0 and var_304_3 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_2
					end
				end

				arg_301_1.text_.text = var_304_6
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121074", "story_v_out_322121.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_out_322121", "322121074", "story_v_out_322121.awb") / 1000

					if var_304_10 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_2
					end

					if var_304_5.prefab_name ~= "" and arg_301_1.actors_[var_304_5.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_5.prefab_name].transform, "story_v_out_322121", "322121074", "story_v_out_322121.awb")

						arg_301_1:RecordAudio("322121074", var_304_11)
						arg_301_1:RecordAudio("322121074", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_322121", "322121074", "story_v_out_322121.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_322121", "322121074", "story_v_out_322121.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_3, arg_301_1.talkMaxDuration)

			if var_304_2 <= arg_301_1.time_ and arg_301_1.time_ < var_304_2 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_2) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_2 + var_304_12 and arg_301_1.time_ < var_304_2 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play322121075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 322121075
		arg_305_1.duration_ = 5.13

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play322121076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["4037ui_story"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos4037ui_story = var_308_0.localPosition
			end

			local var_308_2 = 0.001

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2
				local var_308_4 = Vector3.New(0, 100, 0)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos4037ui_story, var_308_4, var_308_3)

				local var_308_5 = manager.ui.mainCamera.transform.position - var_308_0.position

				var_308_0.forward = Vector3.New(var_308_5.x, var_308_5.y, var_308_5.z)

				local var_308_6 = var_308_0.localEulerAngles

				var_308_6.z = 0
				var_308_6.x = 0
				var_308_0.localEulerAngles = var_308_6
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(0, 100, 0)

				local var_308_7 = manager.ui.mainCamera.transform.position - var_308_0.position

				var_308_0.forward = Vector3.New(var_308_7.x, var_308_7.y, var_308_7.z)

				local var_308_8 = var_308_0.localEulerAngles

				var_308_8.z = 0
				var_308_8.x = 0
				var_308_0.localEulerAngles = var_308_8
			end

			local var_308_9 = arg_305_1.actors_["10150ui_story"].transform
			local var_308_10 = 0

			if var_308_10 < arg_305_1.time_ and arg_305_1.time_ <= var_308_10 + arg_308_0 then
				arg_305_1.var_.moveOldPos10150ui_story = var_308_9.localPosition

				local var_308_11 = GameObjectTools.GetOrAddComponent(var_308_9.gameObject, typeof(DynamicBoneHelper))

				if var_308_11 then
					var_308_11:EnableDynamicBone(false)
				end
			end

			local var_308_12 = 0.001

			if var_308_10 <= arg_305_1.time_ and arg_305_1.time_ < var_308_10 + var_308_12 then
				local var_308_13 = (arg_305_1.time_ - var_308_10) / var_308_12
				local var_308_14 = Vector3.New(0, 100, 0)

				var_308_9.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10150ui_story, var_308_14, var_308_13)

				local var_308_15 = manager.ui.mainCamera.transform.position - var_308_9.position

				var_308_9.forward = Vector3.New(var_308_15.x, var_308_15.y, var_308_15.z)

				local var_308_16 = var_308_9.localEulerAngles

				var_308_16.z = 0
				var_308_16.x = 0
				var_308_9.localEulerAngles = var_308_16
			end

			if arg_305_1.time_ >= var_308_10 + var_308_12 and arg_305_1.time_ < var_308_10 + var_308_12 + arg_308_0 then
				var_308_9.localPosition = Vector3.New(0, 100, 0)

				local var_308_17 = manager.ui.mainCamera.transform.position - var_308_9.position

				var_308_9.forward = Vector3.New(var_308_17.x, var_308_17.y, var_308_17.z)

				local var_308_18 = var_308_9.localEulerAngles

				var_308_18.z = 0
				var_308_18.x = 0
				var_308_9.localEulerAngles = var_308_18

				local var_308_19 = GameObjectTools.GetOrAddComponent(var_308_9.gameObject, typeof(DynamicBoneHelper))

				if var_308_19 then
					var_308_19:EnableDynamicBone(true)
				end
			end

			local var_308_20 = 0.1
			local var_308_21 = 1

			if var_308_20 < arg_305_1.time_ and arg_305_1.time_ <= var_308_20 + arg_308_0 then
				local var_308_22 = "play"
				local var_308_23 = "effect"

				arg_305_1:AudioAction(var_308_22, var_308_23, "se_story_143", "se_story_143_flipper_attack", "")
			end

			local var_308_24 = manager.ui.mainCamera.transform
			local var_308_25 = 0.1

			if var_308_25 < arg_305_1.time_ and arg_305_1.time_ <= var_308_25 + arg_308_0 then
				local var_308_26 = arg_305_1.var_.effect1075
				local var_308_27
				local var_308_28 = var_308_24

				if not var_308_26 then
					var_308_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_308_28)
					var_308_26.name = "1075"
					arg_305_1.var_.effect1075 = var_308_26
				else
					var_308_26.transform:SetParent(var_308_28)
				end

				var_308_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_308_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_308_29 = manager.ui.mainCamera.transform
			local var_308_30 = 2.93333333333333

			if var_308_30 < arg_305_1.time_ and arg_305_1.time_ <= var_308_30 + arg_308_0 then
				local var_308_31 = arg_305_1.var_.effect1075

				if var_308_31 then
					Object.Destroy(var_308_31)

					arg_305_1.var_.effect1075 = nil
				end
			end

			local var_308_32 = 0
			local var_308_33 = 1.675

			if var_308_32 < arg_305_1.time_ and arg_305_1.time_ <= var_308_32 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_34 = arg_305_1:GetWordFromCfg(322121075)
				local var_308_35 = arg_305_1:FormatText(var_308_34.content)

				arg_305_1.text_.text = var_308_35

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_36 = 67
				local var_308_37 = utf8.len(var_308_35)
				local var_308_38 = var_308_36 <= 0 and var_308_33 or var_308_33 * (var_308_37 / var_308_36)

				if var_308_38 > 0 and var_308_33 < var_308_38 then
					arg_305_1.talkMaxDuration = var_308_38

					if var_308_38 + var_308_32 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_38 + var_308_32
					end
				end

				arg_305_1.text_.text = var_308_35
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_39 = math.max(var_308_33, arg_305_1.talkMaxDuration)

			if var_308_32 <= arg_305_1.time_ and arg_305_1.time_ < var_308_32 + var_308_39 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_32) / var_308_39

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_32 + var_308_39 and arg_305_1.time_ < var_308_32 + var_308_39 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play322121076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 322121076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play322121077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.7
			local var_312_1 = 1

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				local var_312_2 = "play"
				local var_312_3 = "effect"

				arg_309_1:AudioAction(var_312_2, var_312_3, "se_story_1310", "se_story_1310_footstep04", "")
			end

			local var_312_4 = manager.ui.mainCamera.transform
			local var_312_5 = 0.7

			if var_312_5 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				local var_312_6 = arg_309_1.var_.effect1076
				local var_312_7
				local var_312_8 = var_312_4

				if not var_312_6 then
					var_312_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue"), var_312_8)
					var_312_6.name = "1076"
					arg_309_1.var_.effect1076 = var_312_6
				else
					var_312_6.transform:SetParent(var_312_8)
				end

				var_312_6.transform.localPosition = Vector3.New(0.36, 0.57, 0)
				var_312_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_312_9 = manager.ui.mainCamera.transform
			local var_312_10 = 1.93333333333333

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 then
				local var_312_11 = arg_309_1.var_.effect1076

				if var_312_11 then
					Object.Destroy(var_312_11)

					arg_309_1.var_.effect1076 = nil
				end
			end

			local var_312_12 = 0
			local var_312_13 = 1.3

			if var_312_12 < arg_309_1.time_ and arg_309_1.time_ <= var_312_12 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_14 = arg_309_1:GetWordFromCfg(322121076)
				local var_312_15 = arg_309_1:FormatText(var_312_14.content)

				arg_309_1.text_.text = var_312_15

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_16 = 52
				local var_312_17 = utf8.len(var_312_15)
				local var_312_18 = var_312_16 <= 0 and var_312_13 or var_312_13 * (var_312_17 / var_312_16)

				if var_312_18 > 0 and var_312_13 < var_312_18 then
					arg_309_1.talkMaxDuration = var_312_18

					if var_312_18 + var_312_12 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_18 + var_312_12
					end
				end

				arg_309_1.text_.text = var_312_15
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_19 = math.max(var_312_13, arg_309_1.talkMaxDuration)

			if var_312_12 <= arg_309_1.time_ and arg_309_1.time_ < var_312_12 + var_312_19 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_12) / var_312_19

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_12 + var_312_19 and arg_309_1.time_ < var_312_12 + var_312_19 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play322121077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 322121077
		arg_313_1.duration_ = 4.13

		local var_313_0 = {
			zh = 3.133,
			ja = 4.133
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play322121078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = "1043ui_story"

			if arg_313_1.actors_[var_316_0] == nil then
				local var_316_1 = Asset.Load("Char/" .. "1043ui_story")

				if not isNil(var_316_1) then
					local var_316_2 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_313_1.stage_.transform)

					var_316_2.name = var_316_0
					var_316_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_313_1.actors_[var_316_0] = var_316_2

					local var_316_3 = var_316_2:GetComponentInChildren(typeof(CharacterEffect))

					var_316_3.enabled = true

					local var_316_4 = GameObjectTools.GetOrAddComponent(var_316_2, typeof(DynamicBoneHelper))

					if var_316_4 then
						var_316_4:EnableDynamicBone(false)
					end

					arg_313_1:ShowWeapon(var_316_3.transform, false)

					arg_313_1.var_[var_316_0 .. "Animator"] = var_316_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_313_1.var_[var_316_0 .. "Animator"].applyRootMotion = true
					arg_313_1.var_[var_316_0 .. "LipSync"] = var_316_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_316_5 = arg_313_1.actors_["1043ui_story"].transform
			local var_316_6 = 0

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.var_.moveOldPos1043ui_story = var_316_5.localPosition
			end

			local var_316_7 = 0.001

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_7 then
				local var_316_8 = (arg_313_1.time_ - var_316_6) / var_316_7
				local var_316_9 = Vector3.New(0.01, -1.01, -5.73)

				var_316_5.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1043ui_story, var_316_9, var_316_8)

				local var_316_10 = manager.ui.mainCamera.transform.position - var_316_5.position

				var_316_5.forward = Vector3.New(var_316_10.x, var_316_10.y, var_316_10.z)

				local var_316_11 = var_316_5.localEulerAngles

				var_316_11.z = 0
				var_316_11.x = 0
				var_316_5.localEulerAngles = var_316_11
			end

			if arg_313_1.time_ >= var_316_6 + var_316_7 and arg_313_1.time_ < var_316_6 + var_316_7 + arg_316_0 then
				var_316_5.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_316_12 = manager.ui.mainCamera.transform.position - var_316_5.position

				var_316_5.forward = Vector3.New(var_316_12.x, var_316_12.y, var_316_12.z)

				local var_316_13 = var_316_5.localEulerAngles

				var_316_13.z = 0
				var_316_13.x = 0
				var_316_5.localEulerAngles = var_316_13
			end

			local var_316_14 = arg_313_1.actors_["1043ui_story"]
			local var_316_15 = 0

			if var_316_15 < arg_313_1.time_ and arg_313_1.time_ <= var_316_15 + arg_316_0 and not isNil(var_316_14) and arg_313_1.var_.characterEffect1043ui_story == nil then
				arg_313_1.var_.characterEffect1043ui_story = var_316_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_16 = 0.200000002980232

			if var_316_15 <= arg_313_1.time_ and arg_313_1.time_ < var_316_15 + var_316_16 and not isNil(var_316_14) then
				local var_316_17 = (arg_313_1.time_ - var_316_15) / var_316_16

				if arg_313_1.var_.characterEffect1043ui_story and not isNil(var_316_14) then
					arg_313_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_15 + var_316_16 and arg_313_1.time_ < var_316_15 + var_316_16 + arg_316_0 and not isNil(var_316_14) and arg_313_1.var_.characterEffect1043ui_story then
				arg_313_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_316_18 = 0

			if var_316_18 < arg_313_1.time_ and arg_313_1.time_ <= var_316_18 + arg_316_0 then
				arg_313_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_316_19 = 0

			if var_316_19 < arg_313_1.time_ and arg_313_1.time_ <= var_316_19 + arg_316_0 then
				arg_313_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_316_20 = 0
			local var_316_21 = 0.275

			if var_316_20 < arg_313_1.time_ and arg_313_1.time_ <= var_316_20 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_22 = arg_313_1:FormatText(StoryNameCfg[1156].name)

				arg_313_1.leftNameTxt_.text = var_316_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_23 = arg_313_1:GetWordFromCfg(322121077)
				local var_316_24 = arg_313_1:FormatText(var_316_23.content)

				arg_313_1.text_.text = var_316_24

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_25 = 11
				local var_316_26 = utf8.len(var_316_24)
				local var_316_27 = var_316_25 <= 0 and var_316_21 or var_316_21 * (var_316_26 / var_316_25)

				if var_316_27 > 0 and var_316_21 < var_316_27 then
					arg_313_1.talkMaxDuration = var_316_27

					if var_316_27 + var_316_20 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_27 + var_316_20
					end
				end

				arg_313_1.text_.text = var_316_24
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121077", "story_v_out_322121.awb") ~= 0 then
					local var_316_28 = manager.audio:GetVoiceLength("story_v_out_322121", "322121077", "story_v_out_322121.awb") / 1000

					if var_316_28 + var_316_20 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_28 + var_316_20
					end

					if var_316_23.prefab_name ~= "" and arg_313_1.actors_[var_316_23.prefab_name] ~= nil then
						local var_316_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_23.prefab_name].transform, "story_v_out_322121", "322121077", "story_v_out_322121.awb")

						arg_313_1:RecordAudio("322121077", var_316_29)
						arg_313_1:RecordAudio("322121077", var_316_29)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_322121", "322121077", "story_v_out_322121.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_322121", "322121077", "story_v_out_322121.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_30 = math.max(var_316_21, arg_313_1.talkMaxDuration)

			if var_316_20 <= arg_313_1.time_ and arg_313_1.time_ < var_316_20 + var_316_30 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_20) / var_316_30

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_20 + var_316_30 and arg_313_1.time_ < var_316_20 + var_316_30 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play322121078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 322121078
		arg_317_1.duration_ = 7.13

		local var_317_0 = {
			zh = 6.666,
			ja = 7.133
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play322121079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["4037ui_story"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos4037ui_story = var_320_0.localPosition
			end

			local var_320_2 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2
				local var_320_4 = Vector3.New(0.7, -1.12, -6.2)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos4037ui_story, var_320_4, var_320_3)

				local var_320_5 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_5.x, var_320_5.y, var_320_5.z)

				local var_320_6 = var_320_0.localEulerAngles

				var_320_6.z = 0
				var_320_6.x = 0
				var_320_0.localEulerAngles = var_320_6
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_320_7 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_7.x, var_320_7.y, var_320_7.z)

				local var_320_8 = var_320_0.localEulerAngles

				var_320_8.z = 0
				var_320_8.x = 0
				var_320_0.localEulerAngles = var_320_8
			end

			local var_320_9 = arg_317_1.actors_["1043ui_story"].transform
			local var_320_10 = 0

			if var_320_10 < arg_317_1.time_ and arg_317_1.time_ <= var_320_10 + arg_320_0 then
				arg_317_1.var_.moveOldPos1043ui_story = var_320_9.localPosition
			end

			local var_320_11 = 0.001

			if var_320_10 <= arg_317_1.time_ and arg_317_1.time_ < var_320_10 + var_320_11 then
				local var_320_12 = (arg_317_1.time_ - var_320_10) / var_320_11
				local var_320_13 = Vector3.New(-0.92, -1.01, -5.73)

				var_320_9.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1043ui_story, var_320_13, var_320_12)

				local var_320_14 = manager.ui.mainCamera.transform.position - var_320_9.position

				var_320_9.forward = Vector3.New(var_320_14.x, var_320_14.y, var_320_14.z)

				local var_320_15 = var_320_9.localEulerAngles

				var_320_15.z = 0
				var_320_15.x = 0
				var_320_9.localEulerAngles = var_320_15
			end

			if arg_317_1.time_ >= var_320_10 + var_320_11 and arg_317_1.time_ < var_320_10 + var_320_11 + arg_320_0 then
				var_320_9.localPosition = Vector3.New(-0.92, -1.01, -5.73)

				local var_320_16 = manager.ui.mainCamera.transform.position - var_320_9.position

				var_320_9.forward = Vector3.New(var_320_16.x, var_320_16.y, var_320_16.z)

				local var_320_17 = var_320_9.localEulerAngles

				var_320_17.z = 0
				var_320_17.x = 0
				var_320_9.localEulerAngles = var_320_17
			end

			local var_320_18 = arg_317_1.actors_["4037ui_story"]
			local var_320_19 = 0

			if var_320_19 < arg_317_1.time_ and arg_317_1.time_ <= var_320_19 + arg_320_0 and not isNil(var_320_18) and arg_317_1.var_.characterEffect4037ui_story == nil then
				arg_317_1.var_.characterEffect4037ui_story = var_320_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_20 = 0.200000002980232

			if var_320_19 <= arg_317_1.time_ and arg_317_1.time_ < var_320_19 + var_320_20 and not isNil(var_320_18) then
				local var_320_21 = (arg_317_1.time_ - var_320_19) / var_320_20

				if arg_317_1.var_.characterEffect4037ui_story and not isNil(var_320_18) then
					arg_317_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_19 + var_320_20 and arg_317_1.time_ < var_320_19 + var_320_20 + arg_320_0 and not isNil(var_320_18) and arg_317_1.var_.characterEffect4037ui_story then
				arg_317_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_320_22 = arg_317_1.actors_["1043ui_story"]
			local var_320_23 = 0

			if var_320_23 < arg_317_1.time_ and arg_317_1.time_ <= var_320_23 + arg_320_0 and not isNil(var_320_22) and arg_317_1.var_.characterEffect1043ui_story == nil then
				arg_317_1.var_.characterEffect1043ui_story = var_320_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_24 = 0.200000002980232

			if var_320_23 <= arg_317_1.time_ and arg_317_1.time_ < var_320_23 + var_320_24 and not isNil(var_320_22) then
				local var_320_25 = (arg_317_1.time_ - var_320_23) / var_320_24

				if arg_317_1.var_.characterEffect1043ui_story and not isNil(var_320_22) then
					local var_320_26 = Mathf.Lerp(0, 0.5, var_320_25)

					arg_317_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1043ui_story.fillRatio = var_320_26
				end
			end

			if arg_317_1.time_ >= var_320_23 + var_320_24 and arg_317_1.time_ < var_320_23 + var_320_24 + arg_320_0 and not isNil(var_320_22) and arg_317_1.var_.characterEffect1043ui_story then
				local var_320_27 = 0.5

				arg_317_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1043ui_story.fillRatio = var_320_27
			end

			local var_320_28 = 0

			if var_320_28 < arg_317_1.time_ and arg_317_1.time_ <= var_320_28 + arg_320_0 then
				arg_317_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_320_29 = 0

			if var_320_29 < arg_317_1.time_ and arg_317_1.time_ <= var_320_29 + arg_320_0 then
				arg_317_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_320_30 = 0
			local var_320_31 = 0.475

			if var_320_30 < arg_317_1.time_ and arg_317_1.time_ <= var_320_30 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_32 = arg_317_1:FormatText(StoryNameCfg[453].name)

				arg_317_1.leftNameTxt_.text = var_320_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_33 = arg_317_1:GetWordFromCfg(322121078)
				local var_320_34 = arg_317_1:FormatText(var_320_33.content)

				arg_317_1.text_.text = var_320_34

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_35 = 19
				local var_320_36 = utf8.len(var_320_34)
				local var_320_37 = var_320_35 <= 0 and var_320_31 or var_320_31 * (var_320_36 / var_320_35)

				if var_320_37 > 0 and var_320_31 < var_320_37 then
					arg_317_1.talkMaxDuration = var_320_37

					if var_320_37 + var_320_30 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_37 + var_320_30
					end
				end

				arg_317_1.text_.text = var_320_34
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121078", "story_v_out_322121.awb") ~= 0 then
					local var_320_38 = manager.audio:GetVoiceLength("story_v_out_322121", "322121078", "story_v_out_322121.awb") / 1000

					if var_320_38 + var_320_30 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_38 + var_320_30
					end

					if var_320_33.prefab_name ~= "" and arg_317_1.actors_[var_320_33.prefab_name] ~= nil then
						local var_320_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_33.prefab_name].transform, "story_v_out_322121", "322121078", "story_v_out_322121.awb")

						arg_317_1:RecordAudio("322121078", var_320_39)
						arg_317_1:RecordAudio("322121078", var_320_39)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_322121", "322121078", "story_v_out_322121.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_322121", "322121078", "story_v_out_322121.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_40 = math.max(var_320_31, arg_317_1.talkMaxDuration)

			if var_320_30 <= arg_317_1.time_ and arg_317_1.time_ < var_320_30 + var_320_40 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_30) / var_320_40

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_30 + var_320_40 and arg_317_1.time_ < var_320_30 + var_320_40 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play322121079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 322121079
		arg_321_1.duration_ = 7

		local var_321_0 = {
			zh = 3.366,
			ja = 7
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play322121080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.35

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[453].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_3 = arg_321_1:GetWordFromCfg(322121079)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 14
				local var_324_6 = utf8.len(var_324_4)
				local var_324_7 = var_324_5 <= 0 and var_324_1 or var_324_1 * (var_324_6 / var_324_5)

				if var_324_7 > 0 and var_324_1 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121079", "story_v_out_322121.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_out_322121", "322121079", "story_v_out_322121.awb") / 1000

					if var_324_8 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_0
					end

					if var_324_3.prefab_name ~= "" and arg_321_1.actors_[var_324_3.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_3.prefab_name].transform, "story_v_out_322121", "322121079", "story_v_out_322121.awb")

						arg_321_1:RecordAudio("322121079", var_324_9)
						arg_321_1:RecordAudio("322121079", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_322121", "322121079", "story_v_out_322121.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_322121", "322121079", "story_v_out_322121.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_10 and arg_321_1.time_ < var_324_0 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play322121080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 322121080
		arg_325_1.duration_ = 3.73

		local var_325_0 = {
			zh = 3.7,
			ja = 3.733
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play322121081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_1")
			end

			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_328_2 = 0
			local var_328_3 = 0.25

			if var_328_2 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_4 = arg_325_1:FormatText(StoryNameCfg[453].name)

				arg_325_1.leftNameTxt_.text = var_328_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_5 = arg_325_1:GetWordFromCfg(322121080)
				local var_328_6 = arg_325_1:FormatText(var_328_5.content)

				arg_325_1.text_.text = var_328_6

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_7 = 10
				local var_328_8 = utf8.len(var_328_6)
				local var_328_9 = var_328_7 <= 0 and var_328_3 or var_328_3 * (var_328_8 / var_328_7)

				if var_328_9 > 0 and var_328_3 < var_328_9 then
					arg_325_1.talkMaxDuration = var_328_9

					if var_328_9 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_9 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_6
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121080", "story_v_out_322121.awb") ~= 0 then
					local var_328_10 = manager.audio:GetVoiceLength("story_v_out_322121", "322121080", "story_v_out_322121.awb") / 1000

					if var_328_10 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_2
					end

					if var_328_5.prefab_name ~= "" and arg_325_1.actors_[var_328_5.prefab_name] ~= nil then
						local var_328_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_5.prefab_name].transform, "story_v_out_322121", "322121080", "story_v_out_322121.awb")

						arg_325_1:RecordAudio("322121080", var_328_11)
						arg_325_1:RecordAudio("322121080", var_328_11)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_322121", "322121080", "story_v_out_322121.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_322121", "322121080", "story_v_out_322121.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_12 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_12 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_12

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_12 and arg_325_1.time_ < var_328_2 + var_328_12 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play322121081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 322121081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play322121082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1043ui_story"].transform
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.var_.moveOldPos1043ui_story = var_332_0.localPosition
			end

			local var_332_2 = 0.001

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2
				local var_332_4 = Vector3.New(0, 100, 0)

				var_332_0.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1043ui_story, var_332_4, var_332_3)

				local var_332_5 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_5.x, var_332_5.y, var_332_5.z)

				local var_332_6 = var_332_0.localEulerAngles

				var_332_6.z = 0
				var_332_6.x = 0
				var_332_0.localEulerAngles = var_332_6
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 then
				var_332_0.localPosition = Vector3.New(0, 100, 0)

				local var_332_7 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_7.x, var_332_7.y, var_332_7.z)

				local var_332_8 = var_332_0.localEulerAngles

				var_332_8.z = 0
				var_332_8.x = 0
				var_332_0.localEulerAngles = var_332_8
			end

			local var_332_9 = arg_329_1.actors_["4037ui_story"].transform
			local var_332_10 = 0

			if var_332_10 < arg_329_1.time_ and arg_329_1.time_ <= var_332_10 + arg_332_0 then
				arg_329_1.var_.moveOldPos4037ui_story = var_332_9.localPosition
			end

			local var_332_11 = 0.001

			if var_332_10 <= arg_329_1.time_ and arg_329_1.time_ < var_332_10 + var_332_11 then
				local var_332_12 = (arg_329_1.time_ - var_332_10) / var_332_11
				local var_332_13 = Vector3.New(0, 100, 0)

				var_332_9.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos4037ui_story, var_332_13, var_332_12)

				local var_332_14 = manager.ui.mainCamera.transform.position - var_332_9.position

				var_332_9.forward = Vector3.New(var_332_14.x, var_332_14.y, var_332_14.z)

				local var_332_15 = var_332_9.localEulerAngles

				var_332_15.z = 0
				var_332_15.x = 0
				var_332_9.localEulerAngles = var_332_15
			end

			if arg_329_1.time_ >= var_332_10 + var_332_11 and arg_329_1.time_ < var_332_10 + var_332_11 + arg_332_0 then
				var_332_9.localPosition = Vector3.New(0, 100, 0)

				local var_332_16 = manager.ui.mainCamera.transform.position - var_332_9.position

				var_332_9.forward = Vector3.New(var_332_16.x, var_332_16.y, var_332_16.z)

				local var_332_17 = var_332_9.localEulerAngles

				var_332_17.z = 0
				var_332_17.x = 0
				var_332_9.localEulerAngles = var_332_17
			end

			local var_332_18 = 0
			local var_332_19 = 1.625

			if var_332_18 < arg_329_1.time_ and arg_329_1.time_ <= var_332_18 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_20 = arg_329_1:GetWordFromCfg(322121081)
				local var_332_21 = arg_329_1:FormatText(var_332_20.content)

				arg_329_1.text_.text = var_332_21

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_22 = 65
				local var_332_23 = utf8.len(var_332_21)
				local var_332_24 = var_332_22 <= 0 and var_332_19 or var_332_19 * (var_332_23 / var_332_22)

				if var_332_24 > 0 and var_332_19 < var_332_24 then
					arg_329_1.talkMaxDuration = var_332_24

					if var_332_24 + var_332_18 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_24 + var_332_18
					end
				end

				arg_329_1.text_.text = var_332_21
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_25 = math.max(var_332_19, arg_329_1.talkMaxDuration)

			if var_332_18 <= arg_329_1.time_ and arg_329_1.time_ < var_332_18 + var_332_25 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_18) / var_332_25

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_18 + var_332_25 and arg_329_1.time_ < var_332_18 + var_332_25 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play322121082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 322121082
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play322121083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0
			local var_336_1 = 1.05

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_2 = arg_333_1:GetWordFromCfg(322121082)
				local var_336_3 = arg_333_1:FormatText(var_336_2.content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_4 = 42
				local var_336_5 = utf8.len(var_336_3)
				local var_336_6 = var_336_4 <= 0 and var_336_1 or var_336_1 * (var_336_5 / var_336_4)

				if var_336_6 > 0 and var_336_1 < var_336_6 then
					arg_333_1.talkMaxDuration = var_336_6

					if var_336_6 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_6 + var_336_0
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_1, arg_333_1.talkMaxDuration)

			if var_336_0 <= arg_333_1.time_ and arg_333_1.time_ < var_336_0 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_0) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_0 + var_336_7 and arg_333_1.time_ < var_336_0 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play322121083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 322121083
		arg_337_1.duration_ = 2

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play322121084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["10150ui_story"].transform
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.var_.moveOldPos10150ui_story = var_340_0.localPosition

				local var_340_2 = GameObjectTools.GetOrAddComponent(var_340_0.gameObject, typeof(DynamicBoneHelper))

				if var_340_2 then
					var_340_2:EnableDynamicBone(false)
				end
			end

			local var_340_3 = 0.001

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_3 then
				local var_340_4 = (arg_337_1.time_ - var_340_1) / var_340_3
				local var_340_5 = Vector3.New(0, -1.73, -5.5)

				var_340_0.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10150ui_story, var_340_5, var_340_4)

				local var_340_6 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_6.x, var_340_6.y, var_340_6.z)

				local var_340_7 = var_340_0.localEulerAngles

				var_340_7.z = 0
				var_340_7.x = 0
				var_340_0.localEulerAngles = var_340_7
			end

			if arg_337_1.time_ >= var_340_1 + var_340_3 and arg_337_1.time_ < var_340_1 + var_340_3 + arg_340_0 then
				var_340_0.localPosition = Vector3.New(0, -1.73, -5.5)

				local var_340_8 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_8.x, var_340_8.y, var_340_8.z)

				local var_340_9 = var_340_0.localEulerAngles

				var_340_9.z = 0
				var_340_9.x = 0
				var_340_0.localEulerAngles = var_340_9

				local var_340_10 = GameObjectTools.GetOrAddComponent(var_340_0.gameObject, typeof(DynamicBoneHelper))

				if var_340_10 then
					var_340_10:EnableDynamicBone(true)
				end
			end

			local var_340_11 = arg_337_1.actors_["10150ui_story"]
			local var_340_12 = 0

			if var_340_12 < arg_337_1.time_ and arg_337_1.time_ <= var_340_12 + arg_340_0 and not isNil(var_340_11) and arg_337_1.var_.characterEffect10150ui_story == nil then
				arg_337_1.var_.characterEffect10150ui_story = var_340_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_13 = 0.200000002980232

			if var_340_12 <= arg_337_1.time_ and arg_337_1.time_ < var_340_12 + var_340_13 and not isNil(var_340_11) then
				local var_340_14 = (arg_337_1.time_ - var_340_12) / var_340_13

				if arg_337_1.var_.characterEffect10150ui_story and not isNil(var_340_11) then
					arg_337_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_12 + var_340_13 and arg_337_1.time_ < var_340_12 + var_340_13 + arg_340_0 and not isNil(var_340_11) and arg_337_1.var_.characterEffect10150ui_story then
				arg_337_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_340_15 = 0

			if var_340_15 < arg_337_1.time_ and arg_337_1.time_ <= var_340_15 + arg_340_0 then
				arg_337_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action3_1")
			end

			local var_340_16 = 0

			if var_340_16 < arg_337_1.time_ and arg_337_1.time_ <= var_340_16 + arg_340_0 then
				arg_337_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_340_17 = 0
			local var_340_18 = 1

			if var_340_17 < arg_337_1.time_ and arg_337_1.time_ <= var_340_17 + arg_340_0 then
				local var_340_19 = "play"
				local var_340_20 = "music"

				arg_337_1:AudioAction(var_340_19, var_340_20, "bgm_activity_4_5_story_serious", "battle", "bgm_activity_4_5_story_serious.awb")

				local var_340_21 = ""
				local var_340_22 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "battle")

				if var_340_22 ~= "" then
					if arg_337_1.bgmTxt_.text ~= var_340_22 and arg_337_1.bgmTxt_.text ~= "" then
						if arg_337_1.bgmTxt2_.text ~= "" then
							arg_337_1.bgmTxt_.text = arg_337_1.bgmTxt2_.text
						end

						arg_337_1.bgmTxt2_.text = var_340_22

						arg_337_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_337_1.bgmTxt_.text = var_340_22
						arg_337_1.bgmTxt2_.text = var_340_22
					end

					if arg_337_1.bgmTimer then
						arg_337_1.bgmTimer:Stop()

						arg_337_1.bgmTimer = nil
					end

					if arg_337_1.settingData.show_music_name == 1 then
						arg_337_1.musicController:SetSelectedState("show")
						arg_337_1.musicAnimator_:Play("open", 0, 0)

						if arg_337_1.settingData.music_time ~= 0 then
							arg_337_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_337_1.settingData.music_time), function()
								if arg_337_1 == nil or isNil(arg_337_1.bgmTxt_) then
									return
								end

								arg_337_1.musicController:SetSelectedState("hide")
								arg_337_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_340_23 = 0
			local var_340_24 = 0.1

			if var_340_23 < arg_337_1.time_ and arg_337_1.time_ <= var_340_23 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_25 = arg_337_1:FormatText(StoryNameCfg[1361].name)

				arg_337_1.leftNameTxt_.text = var_340_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_26 = arg_337_1:GetWordFromCfg(322121083)
				local var_340_27 = arg_337_1:FormatText(var_340_26.content)

				arg_337_1.text_.text = var_340_27

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_28 = 4
				local var_340_29 = utf8.len(var_340_27)
				local var_340_30 = var_340_28 <= 0 and var_340_24 or var_340_24 * (var_340_29 / var_340_28)

				if var_340_30 > 0 and var_340_24 < var_340_30 then
					arg_337_1.talkMaxDuration = var_340_30

					if var_340_30 + var_340_23 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_30 + var_340_23
					end
				end

				arg_337_1.text_.text = var_340_27
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121083", "story_v_out_322121.awb") ~= 0 then
					local var_340_31 = manager.audio:GetVoiceLength("story_v_out_322121", "322121083", "story_v_out_322121.awb") / 1000

					if var_340_31 + var_340_23 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_31 + var_340_23
					end

					if var_340_26.prefab_name ~= "" and arg_337_1.actors_[var_340_26.prefab_name] ~= nil then
						local var_340_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_26.prefab_name].transform, "story_v_out_322121", "322121083", "story_v_out_322121.awb")

						arg_337_1:RecordAudio("322121083", var_340_32)
						arg_337_1:RecordAudio("322121083", var_340_32)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_322121", "322121083", "story_v_out_322121.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_322121", "322121083", "story_v_out_322121.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_33 = math.max(var_340_24, arg_337_1.talkMaxDuration)

			if var_340_23 <= arg_337_1.time_ and arg_337_1.time_ < var_340_23 + var_340_33 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_23) / var_340_33

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_23 + var_340_33 and arg_337_1.time_ < var_340_23 + var_340_33 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play322121084 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 322121084
		arg_342_1.duration_ = 2.8

		local var_342_0 = {
			zh = 1.999999999999,
			ja = 2.8
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
			arg_342_1.auto_ = false
		end

		function arg_342_1.playNext_(arg_344_0)
			arg_342_1.onStoryFinished_()
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1043ui_story"].transform
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.var_.moveOldPos1043ui_story = var_345_0.localPosition
			end

			local var_345_2 = 0.001

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2
				local var_345_4 = Vector3.New(0.81, -1.01, -5.73)

				var_345_0.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1043ui_story, var_345_4, var_345_3)

				local var_345_5 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_5.x, var_345_5.y, var_345_5.z)

				local var_345_6 = var_345_0.localEulerAngles

				var_345_6.z = 0
				var_345_6.x = 0
				var_345_0.localEulerAngles = var_345_6
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 then
				var_345_0.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_345_7 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_7.x, var_345_7.y, var_345_7.z)

				local var_345_8 = var_345_0.localEulerAngles

				var_345_8.z = 0
				var_345_8.x = 0
				var_345_0.localEulerAngles = var_345_8
			end

			local var_345_9 = arg_342_1.actors_["10150ui_story"].transform
			local var_345_10 = 0

			if var_345_10 < arg_342_1.time_ and arg_342_1.time_ <= var_345_10 + arg_345_0 then
				arg_342_1.var_.moveOldPos10150ui_story = var_345_9.localPosition

				local var_345_11 = GameObjectTools.GetOrAddComponent(var_345_9.gameObject, typeof(DynamicBoneHelper))

				if var_345_11 then
					var_345_11:EnableDynamicBone(false)
				end
			end

			local var_345_12 = 0.001

			if var_345_10 <= arg_342_1.time_ and arg_342_1.time_ < var_345_10 + var_345_12 then
				local var_345_13 = (arg_342_1.time_ - var_345_10) / var_345_12
				local var_345_14 = Vector3.New(-0.9, -1.73, -5.5)

				var_345_9.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos10150ui_story, var_345_14, var_345_13)

				local var_345_15 = manager.ui.mainCamera.transform.position - var_345_9.position

				var_345_9.forward = Vector3.New(var_345_15.x, var_345_15.y, var_345_15.z)

				local var_345_16 = var_345_9.localEulerAngles

				var_345_16.z = 0
				var_345_16.x = 0
				var_345_9.localEulerAngles = var_345_16
			end

			if arg_342_1.time_ >= var_345_10 + var_345_12 and arg_342_1.time_ < var_345_10 + var_345_12 + arg_345_0 then
				var_345_9.localPosition = Vector3.New(-0.9, -1.73, -5.5)

				local var_345_17 = manager.ui.mainCamera.transform.position - var_345_9.position

				var_345_9.forward = Vector3.New(var_345_17.x, var_345_17.y, var_345_17.z)

				local var_345_18 = var_345_9.localEulerAngles

				var_345_18.z = 0
				var_345_18.x = 0
				var_345_9.localEulerAngles = var_345_18

				local var_345_19 = GameObjectTools.GetOrAddComponent(var_345_9.gameObject, typeof(DynamicBoneHelper))

				if var_345_19 then
					var_345_19:EnableDynamicBone(true)
				end
			end

			local var_345_20 = arg_342_1.actors_["1043ui_story"]
			local var_345_21 = 0

			if var_345_21 < arg_342_1.time_ and arg_342_1.time_ <= var_345_21 + arg_345_0 and not isNil(var_345_20) and arg_342_1.var_.characterEffect1043ui_story == nil then
				arg_342_1.var_.characterEffect1043ui_story = var_345_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_22 = 0.200000002980232

			if var_345_21 <= arg_342_1.time_ and arg_342_1.time_ < var_345_21 + var_345_22 and not isNil(var_345_20) then
				local var_345_23 = (arg_342_1.time_ - var_345_21) / var_345_22

				if arg_342_1.var_.characterEffect1043ui_story and not isNil(var_345_20) then
					arg_342_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= var_345_21 + var_345_22 and arg_342_1.time_ < var_345_21 + var_345_22 + arg_345_0 and not isNil(var_345_20) and arg_342_1.var_.characterEffect1043ui_story then
				arg_342_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_345_24 = arg_342_1.actors_["10150ui_story"]
			local var_345_25 = 0

			if var_345_25 < arg_342_1.time_ and arg_342_1.time_ <= var_345_25 + arg_345_0 and not isNil(var_345_24) and arg_342_1.var_.characterEffect10150ui_story == nil then
				arg_342_1.var_.characterEffect10150ui_story = var_345_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_26 = 0.200000002980232

			if var_345_25 <= arg_342_1.time_ and arg_342_1.time_ < var_345_25 + var_345_26 and not isNil(var_345_24) then
				local var_345_27 = (arg_342_1.time_ - var_345_25) / var_345_26

				if arg_342_1.var_.characterEffect10150ui_story and not isNil(var_345_24) then
					local var_345_28 = Mathf.Lerp(0, 0.5, var_345_27)

					arg_342_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_342_1.var_.characterEffect10150ui_story.fillRatio = var_345_28
				end
			end

			if arg_342_1.time_ >= var_345_25 + var_345_26 and arg_342_1.time_ < var_345_25 + var_345_26 + arg_345_0 and not isNil(var_345_24) and arg_342_1.var_.characterEffect10150ui_story then
				local var_345_29 = 0.5

				arg_342_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_342_1.var_.characterEffect10150ui_story.fillRatio = var_345_29
			end

			local var_345_30 = 0

			if var_345_30 < arg_342_1.time_ and arg_342_1.time_ <= var_345_30 + arg_345_0 then
				arg_342_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_1")
			end

			local var_345_31 = 0

			if var_345_31 < arg_342_1.time_ and arg_342_1.time_ <= var_345_31 + arg_345_0 then
				arg_342_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_345_32 = 0
			local var_345_33 = 0.2

			if var_345_32 < arg_342_1.time_ and arg_342_1.time_ <= var_345_32 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_34 = arg_342_1:FormatText(StoryNameCfg[1156].name)

				arg_342_1.leftNameTxt_.text = var_345_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_35 = arg_342_1:GetWordFromCfg(322121084)
				local var_345_36 = arg_342_1:FormatText(var_345_35.content)

				arg_342_1.text_.text = var_345_36

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_37 = 8
				local var_345_38 = utf8.len(var_345_36)
				local var_345_39 = var_345_37 <= 0 and var_345_33 or var_345_33 * (var_345_38 / var_345_37)

				if var_345_39 > 0 and var_345_33 < var_345_39 then
					arg_342_1.talkMaxDuration = var_345_39

					if var_345_39 + var_345_32 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_39 + var_345_32
					end
				end

				arg_342_1.text_.text = var_345_36
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121084", "story_v_out_322121.awb") ~= 0 then
					local var_345_40 = manager.audio:GetVoiceLength("story_v_out_322121", "322121084", "story_v_out_322121.awb") / 1000

					if var_345_40 + var_345_32 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_40 + var_345_32
					end

					if var_345_35.prefab_name ~= "" and arg_342_1.actors_[var_345_35.prefab_name] ~= nil then
						local var_345_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_35.prefab_name].transform, "story_v_out_322121", "322121084", "story_v_out_322121.awb")

						arg_342_1:RecordAudio("322121084", var_345_41)
						arg_342_1:RecordAudio("322121084", var_345_41)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_322121", "322121084", "story_v_out_322121.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_322121", "322121084", "story_v_out_322121.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_42 = math.max(var_345_33, arg_342_1.talkMaxDuration)

			if var_345_32 <= arg_342_1.time_ and arg_342_1.time_ < var_345_32 + var_345_42 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_32) / var_345_42

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_32 + var_345_42 and arg_342_1.time_ < var_345_32 + var_345_42 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L14f",
		"TextureConfig/Background/L17f"
	},
	voices = {
		"story_v_out_322121.awb"
	}
}
