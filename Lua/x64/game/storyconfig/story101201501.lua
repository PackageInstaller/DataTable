return {
	Play120151001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120151001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play120151002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J13f"

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
				local var_4_5 = arg_1_1.bgs_.J13f

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
					if iter_4_0 ~= "J13f" then
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
			local var_4_23 = 0.1

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

			local var_4_28 = 0.5
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 1.999999999999
			local var_4_35 = 0.725

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(120151001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 29
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

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
	Play120151002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 120151002
		arg_9_1.duration_ = 6

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play120151003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = manager.ui.mainCamera.transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = var_12_0.localPosition
			end

			local var_12_2 = 0.6

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / 0.066
				local var_12_4, var_12_5 = math.modf(var_12_3)

				var_12_0.localPosition = Vector3.New(var_12_5 * 0.13, var_12_5 * 0.13, var_12_5 * 0.13) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 then
				var_12_0.localPosition = arg_9_1.var_.shakeOldPos
			end

			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			local var_12_7 = 0.966666666666666

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			local var_12_8 = manager.ui.mainCamera.transform
			local var_12_9 = 0

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				local var_12_10 = arg_9_1.var_.effectF03daoguang1
				local var_12_11
				local var_12_12 = var_12_8

				if not var_12_10 then
					var_12_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_12_12)
					var_12_10.name = "daoguang1"
					arg_9_1.var_.effectF03daoguang1 = var_12_10
				else
					var_12_10.transform:SetParent(var_12_12)
				end

				var_12_10.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_12_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_12_13 = manager.ui.mainCamera.transform
			local var_12_14 = 0.866666666666666

			if var_12_14 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				local var_12_15 = arg_9_1.var_.effectF03daoguang1

				if var_12_15 then
					Object.Destroy(var_12_15)

					arg_9_1.var_.effectF03daoguang1 = nil
				end
			end

			local var_12_16 = 0
			local var_12_17 = 1

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 then
				local var_12_18 = "play"
				local var_12_19 = "effect"

				arg_9_1:AudioAction(var_12_18, var_12_19, "se_story_16", "se_story_16_metal02", "")
			end

			local var_12_20 = "1071ui_story"

			if arg_9_1.actors_[var_12_20] == nil then
				local var_12_21 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_12_21) then
					local var_12_22 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_9_1.stage_.transform)

					var_12_22.name = var_12_20
					var_12_22.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_20] = var_12_22

					local var_12_23 = var_12_22:GetComponentInChildren(typeof(CharacterEffect))

					var_12_23.enabled = true

					local var_12_24 = GameObjectTools.GetOrAddComponent(var_12_22, typeof(DynamicBoneHelper))

					if var_12_24 then
						var_12_24:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_23.transform, false)

					arg_9_1.var_[var_12_20 .. "Animator"] = var_12_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_20 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_20 .. "LipSync"] = var_12_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_25 = 0

			if var_12_25 < arg_9_1.time_ and arg_9_1.time_ <= var_12_25 + arg_12_0 then
				arg_9_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_26 = 1
			local var_12_27 = 1.175

			if var_12_26 < arg_9_1.time_ and arg_9_1.time_ <= var_12_26 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_28 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_28:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_29 = arg_9_1:GetWordFromCfg(120151002)
				local var_12_30 = arg_9_1:FormatText(var_12_29.content)

				arg_9_1.text_.text = var_12_30

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_31 = 47
				local var_12_32 = utf8.len(var_12_30)
				local var_12_33 = var_12_31 <= 0 and var_12_27 or var_12_27 * (var_12_32 / var_12_31)

				if var_12_33 > 0 and var_12_27 < var_12_33 then
					arg_9_1.talkMaxDuration = var_12_33
					var_12_26 = var_12_26 + 0.3

					if var_12_33 + var_12_26 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_33 + var_12_26
					end
				end

				arg_9_1.text_.text = var_12_30
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_34 = var_12_26 + 0.3
			local var_12_35 = math.max(var_12_27, arg_9_1.talkMaxDuration)

			if var_12_34 <= arg_9_1.time_ and arg_9_1.time_ < var_12_34 + var_12_35 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_34) / var_12_35

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_34 + var_12_35 and arg_9_1.time_ < var_12_34 + var_12_35 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play120151003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 120151003
		arg_15_1.duration_ = 2.77

		local var_15_0 = {
			zh = 2.766,
			ja = 2.333
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play120151004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["1071ui_story"].transform
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.var_.moveOldPos1071ui_story = var_18_0.localPosition
			end

			local var_18_2 = 0.001

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_2 then
				local var_18_3 = (arg_15_1.time_ - var_18_1) / var_18_2
				local var_18_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_18_0.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1071ui_story, var_18_4, var_18_3)

				local var_18_5 = manager.ui.mainCamera.transform.position - var_18_0.position

				var_18_0.forward = Vector3.New(var_18_5.x, var_18_5.y, var_18_5.z)

				local var_18_6 = var_18_0.localEulerAngles

				var_18_6.z = 0
				var_18_6.x = 0
				var_18_0.localEulerAngles = var_18_6
			end

			if arg_15_1.time_ >= var_18_1 + var_18_2 and arg_15_1.time_ < var_18_1 + var_18_2 + arg_18_0 then
				var_18_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_18_7 = manager.ui.mainCamera.transform.position - var_18_0.position

				var_18_0.forward = Vector3.New(var_18_7.x, var_18_7.y, var_18_7.z)

				local var_18_8 = var_18_0.localEulerAngles

				var_18_8.z = 0
				var_18_8.x = 0
				var_18_0.localEulerAngles = var_18_8
			end

			local var_18_9 = "10037ui_story"

			if arg_15_1.actors_[var_18_9] == nil then
				local var_18_10 = Asset.Load("Char/" .. "10037ui_story")

				if not isNil(var_18_10) then
					local var_18_11 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_15_1.stage_.transform)

					var_18_11.name = var_18_9
					var_18_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_15_1.actors_[var_18_9] = var_18_11

					local var_18_12 = var_18_11:GetComponentInChildren(typeof(CharacterEffect))

					var_18_12.enabled = true

					local var_18_13 = GameObjectTools.GetOrAddComponent(var_18_11, typeof(DynamicBoneHelper))

					if var_18_13 then
						var_18_13:EnableDynamicBone(false)
					end

					arg_15_1:ShowWeapon(var_18_12.transform, false)

					arg_15_1.var_[var_18_9 .. "Animator"] = var_18_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_15_1.var_[var_18_9 .. "Animator"].applyRootMotion = true
					arg_15_1.var_[var_18_9 .. "LipSync"] = var_18_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_18_14 = arg_15_1.actors_["10037ui_story"].transform
			local var_18_15 = 0

			if var_18_15 < arg_15_1.time_ and arg_15_1.time_ <= var_18_15 + arg_18_0 then
				arg_15_1.var_.moveOldPos10037ui_story = var_18_14.localPosition
			end

			local var_18_16 = 0.001

			if var_18_15 <= arg_15_1.time_ and arg_15_1.time_ < var_18_15 + var_18_16 then
				local var_18_17 = (arg_15_1.time_ - var_18_15) / var_18_16
				local var_18_18 = Vector3.New(0.7, -1.13, -6.2)

				var_18_14.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10037ui_story, var_18_18, var_18_17)

				local var_18_19 = manager.ui.mainCamera.transform.position - var_18_14.position

				var_18_14.forward = Vector3.New(var_18_19.x, var_18_19.y, var_18_19.z)

				local var_18_20 = var_18_14.localEulerAngles

				var_18_20.z = 0
				var_18_20.x = 0
				var_18_14.localEulerAngles = var_18_20
			end

			if arg_15_1.time_ >= var_18_15 + var_18_16 and arg_15_1.time_ < var_18_15 + var_18_16 + arg_18_0 then
				var_18_14.localPosition = Vector3.New(0.7, -1.13, -6.2)

				local var_18_21 = manager.ui.mainCamera.transform.position - var_18_14.position

				var_18_14.forward = Vector3.New(var_18_21.x, var_18_21.y, var_18_21.z)

				local var_18_22 = var_18_14.localEulerAngles

				var_18_22.z = 0
				var_18_22.x = 0
				var_18_14.localEulerAngles = var_18_22
			end

			local var_18_23 = 0

			if var_18_23 < arg_15_1.time_ and arg_15_1.time_ <= var_18_23 + arg_18_0 then
				arg_15_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_18_24 = arg_15_1.actors_["1071ui_story"]
			local var_18_25 = 0

			if var_18_25 < arg_15_1.time_ and arg_15_1.time_ <= var_18_25 + arg_18_0 and not isNil(var_18_24) and arg_15_1.var_.characterEffect1071ui_story == nil then
				arg_15_1.var_.characterEffect1071ui_story = var_18_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_26 = 0.2

			if var_18_25 <= arg_15_1.time_ and arg_15_1.time_ < var_18_25 + var_18_26 and not isNil(var_18_24) then
				local var_18_27 = (arg_15_1.time_ - var_18_25) / var_18_26

				if arg_15_1.var_.characterEffect1071ui_story and not isNil(var_18_24) then
					arg_15_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_25 + var_18_26 and arg_15_1.time_ < var_18_25 + var_18_26 + arg_18_0 and not isNil(var_18_24) and arg_15_1.var_.characterEffect1071ui_story then
				arg_15_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_18_28 = 0

			if var_18_28 < arg_15_1.time_ and arg_15_1.time_ <= var_18_28 + arg_18_0 then
				arg_15_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_18_29 = 0

			if var_18_29 < arg_15_1.time_ and arg_15_1.time_ <= var_18_29 + arg_18_0 then
				arg_15_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			local var_18_30 = arg_15_1.actors_["10037ui_story"]
			local var_18_31 = 0

			if var_18_31 < arg_15_1.time_ and arg_15_1.time_ <= var_18_31 + arg_18_0 and not isNil(var_18_30) and arg_15_1.var_.characterEffect10037ui_story == nil then
				arg_15_1.var_.characterEffect10037ui_story = var_18_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_32 = 0.0166666666666667

			if var_18_31 <= arg_15_1.time_ and arg_15_1.time_ < var_18_31 + var_18_32 and not isNil(var_18_30) then
				local var_18_33 = (arg_15_1.time_ - var_18_31) / var_18_32

				if arg_15_1.var_.characterEffect10037ui_story and not isNil(var_18_30) then
					local var_18_34 = Mathf.Lerp(0, 0.5, var_18_33)

					arg_15_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_15_1.var_.characterEffect10037ui_story.fillRatio = var_18_34
				end
			end

			if arg_15_1.time_ >= var_18_31 + var_18_32 and arg_15_1.time_ < var_18_31 + var_18_32 + arg_18_0 and not isNil(var_18_30) and arg_15_1.var_.characterEffect10037ui_story then
				local var_18_35 = 0.5

				arg_15_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_15_1.var_.characterEffect10037ui_story.fillRatio = var_18_35
			end

			local var_18_36 = 0
			local var_18_37 = 0.325

			if var_18_36 < arg_15_1.time_ and arg_15_1.time_ <= var_18_36 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_38 = arg_15_1:FormatText(StoryNameCfg[384].name)

				arg_15_1.leftNameTxt_.text = var_18_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_39 = arg_15_1:GetWordFromCfg(120151003)
				local var_18_40 = arg_15_1:FormatText(var_18_39.content)

				arg_15_1.text_.text = var_18_40

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_41 = 13
				local var_18_42 = utf8.len(var_18_40)
				local var_18_43 = var_18_41 <= 0 and var_18_37 or var_18_37 * (var_18_42 / var_18_41)

				if var_18_43 > 0 and var_18_37 < var_18_43 then
					arg_15_1.talkMaxDuration = var_18_43

					if var_18_43 + var_18_36 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_43 + var_18_36
					end
				end

				arg_15_1.text_.text = var_18_40
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151003", "story_v_out_120151.awb") ~= 0 then
					local var_18_44 = manager.audio:GetVoiceLength("story_v_out_120151", "120151003", "story_v_out_120151.awb") / 1000

					if var_18_44 + var_18_36 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_44 + var_18_36
					end

					if var_18_39.prefab_name ~= "" and arg_15_1.actors_[var_18_39.prefab_name] ~= nil then
						local var_18_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_39.prefab_name].transform, "story_v_out_120151", "120151003", "story_v_out_120151.awb")

						arg_15_1:RecordAudio("120151003", var_18_45)
						arg_15_1:RecordAudio("120151003", var_18_45)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_120151", "120151003", "story_v_out_120151.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_120151", "120151003", "story_v_out_120151.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_46 = math.max(var_18_37, arg_15_1.talkMaxDuration)

			if var_18_36 <= arg_15_1.time_ and arg_15_1.time_ < var_18_36 + var_18_46 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_36) / var_18_46

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_36 + var_18_46 and arg_15_1.time_ < var_18_36 + var_18_46 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play120151004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 120151004
		arg_19_1.duration_ = 5.43

		local var_19_0 = {
			zh = 2.933,
			ja = 5.433
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play120151005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1071ui_story"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1071ui_story == nil then
				arg_19_1.var_.characterEffect1071ui_story = var_22_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.2

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 and not isNil(var_22_0) then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2

				if arg_19_1.var_.characterEffect1071ui_story and not isNil(var_22_0) then
					local var_22_4 = Mathf.Lerp(0, 0.5, var_22_3)

					arg_19_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1071ui_story.fillRatio = var_22_4
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1071ui_story then
				local var_22_5 = 0.5

				arg_19_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1071ui_story.fillRatio = var_22_5
			end

			local var_22_6 = arg_19_1.actors_["10037ui_story"].transform
			local var_22_7 = 0

			if var_22_7 < arg_19_1.time_ and arg_19_1.time_ <= var_22_7 + arg_22_0 then
				arg_19_1.var_.moveOldPos10037ui_story = var_22_6.localPosition
			end

			local var_22_8 = 0.001

			if var_22_7 <= arg_19_1.time_ and arg_19_1.time_ < var_22_7 + var_22_8 then
				local var_22_9 = (arg_19_1.time_ - var_22_7) / var_22_8
				local var_22_10 = Vector3.New(0.7, -1.13, -6.2)

				var_22_6.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos10037ui_story, var_22_10, var_22_9)

				local var_22_11 = manager.ui.mainCamera.transform.position - var_22_6.position

				var_22_6.forward = Vector3.New(var_22_11.x, var_22_11.y, var_22_11.z)

				local var_22_12 = var_22_6.localEulerAngles

				var_22_12.z = 0
				var_22_12.x = 0
				var_22_6.localEulerAngles = var_22_12
			end

			if arg_19_1.time_ >= var_22_7 + var_22_8 and arg_19_1.time_ < var_22_7 + var_22_8 + arg_22_0 then
				var_22_6.localPosition = Vector3.New(0.7, -1.13, -6.2)

				local var_22_13 = manager.ui.mainCamera.transform.position - var_22_6.position

				var_22_6.forward = Vector3.New(var_22_13.x, var_22_13.y, var_22_13.z)

				local var_22_14 = var_22_6.localEulerAngles

				var_22_14.z = 0
				var_22_14.x = 0
				var_22_6.localEulerAngles = var_22_14
			end

			local var_22_15 = 0

			if var_22_15 < arg_19_1.time_ and arg_19_1.time_ <= var_22_15 + arg_22_0 then
				arg_19_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action3_1")
			end

			local var_22_16 = 0

			if var_22_16 < arg_19_1.time_ and arg_19_1.time_ <= var_22_16 + arg_22_0 then
				arg_19_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_22_17 = arg_19_1.actors_["10037ui_story"]
			local var_22_18 = 0

			if var_22_18 < arg_19_1.time_ and arg_19_1.time_ <= var_22_18 + arg_22_0 and not isNil(var_22_17) and arg_19_1.var_.characterEffect10037ui_story == nil then
				arg_19_1.var_.characterEffect10037ui_story = var_22_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_19 = 0.2

			if var_22_18 <= arg_19_1.time_ and arg_19_1.time_ < var_22_18 + var_22_19 and not isNil(var_22_17) then
				local var_22_20 = (arg_19_1.time_ - var_22_18) / var_22_19

				if arg_19_1.var_.characterEffect10037ui_story and not isNil(var_22_17) then
					arg_19_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= var_22_18 + var_22_19 and arg_19_1.time_ < var_22_18 + var_22_19 + arg_22_0 and not isNil(var_22_17) and arg_19_1.var_.characterEffect10037ui_story then
				arg_19_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_22_21 = 0
			local var_22_22 = 0.325

			if var_22_21 < arg_19_1.time_ and arg_19_1.time_ <= var_22_21 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_23 = arg_19_1:FormatText(StoryNameCfg[383].name)

				arg_19_1.leftNameTxt_.text = var_22_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_24 = arg_19_1:GetWordFromCfg(120151004)
				local var_22_25 = arg_19_1:FormatText(var_22_24.content)

				arg_19_1.text_.text = var_22_25

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_26 = 13
				local var_22_27 = utf8.len(var_22_25)
				local var_22_28 = var_22_26 <= 0 and var_22_22 or var_22_22 * (var_22_27 / var_22_26)

				if var_22_28 > 0 and var_22_22 < var_22_28 then
					arg_19_1.talkMaxDuration = var_22_28

					if var_22_28 + var_22_21 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_28 + var_22_21
					end
				end

				arg_19_1.text_.text = var_22_25
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151004", "story_v_out_120151.awb") ~= 0 then
					local var_22_29 = manager.audio:GetVoiceLength("story_v_out_120151", "120151004", "story_v_out_120151.awb") / 1000

					if var_22_29 + var_22_21 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_29 + var_22_21
					end

					if var_22_24.prefab_name ~= "" and arg_19_1.actors_[var_22_24.prefab_name] ~= nil then
						local var_22_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_24.prefab_name].transform, "story_v_out_120151", "120151004", "story_v_out_120151.awb")

						arg_19_1:RecordAudio("120151004", var_22_30)
						arg_19_1:RecordAudio("120151004", var_22_30)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_120151", "120151004", "story_v_out_120151.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_120151", "120151004", "story_v_out_120151.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_31 = math.max(var_22_22, arg_19_1.talkMaxDuration)

			if var_22_21 <= arg_19_1.time_ and arg_19_1.time_ < var_22_21 + var_22_31 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_21) / var_22_31

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_21 + var_22_31 and arg_19_1.time_ < var_22_21 + var_22_31 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play120151005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 120151005
		arg_23_1.duration_ = 7.37

		local var_23_0 = {
			zh = 7.233,
			ja = 7.366
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play120151006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1071ui_story"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1071ui_story == nil then
				arg_23_1.var_.characterEffect1071ui_story = var_26_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.2

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.characterEffect1071ui_story and not isNil(var_26_0) then
					arg_23_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1071ui_story then
				arg_23_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_26_4 = arg_23_1.actors_["10037ui_story"]
			local var_26_5 = 0

			if var_26_5 < arg_23_1.time_ and arg_23_1.time_ <= var_26_5 + arg_26_0 and not isNil(var_26_4) and arg_23_1.var_.characterEffect10037ui_story == nil then
				arg_23_1.var_.characterEffect10037ui_story = var_26_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_6 = 0.2

			if var_26_5 <= arg_23_1.time_ and arg_23_1.time_ < var_26_5 + var_26_6 and not isNil(var_26_4) then
				local var_26_7 = (arg_23_1.time_ - var_26_5) / var_26_6

				if arg_23_1.var_.characterEffect10037ui_story and not isNil(var_26_4) then
					local var_26_8 = Mathf.Lerp(0, 0.5, var_26_7)

					arg_23_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_23_1.var_.characterEffect10037ui_story.fillRatio = var_26_8
				end
			end

			if arg_23_1.time_ >= var_26_5 + var_26_6 and arg_23_1.time_ < var_26_5 + var_26_6 + arg_26_0 and not isNil(var_26_4) and arg_23_1.var_.characterEffect10037ui_story then
				local var_26_9 = 0.5

				arg_23_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_23_1.var_.characterEffect10037ui_story.fillRatio = var_26_9
			end

			local var_26_10 = 0
			local var_26_11 = 0.825

			if var_26_10 < arg_23_1.time_ and arg_23_1.time_ <= var_26_10 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_12 = arg_23_1:FormatText(StoryNameCfg[384].name)

				arg_23_1.leftNameTxt_.text = var_26_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_13 = arg_23_1:GetWordFromCfg(120151005)
				local var_26_14 = arg_23_1:FormatText(var_26_13.content)

				arg_23_1.text_.text = var_26_14

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_15 = 33
				local var_26_16 = utf8.len(var_26_14)
				local var_26_17 = var_26_15 <= 0 and var_26_11 or var_26_11 * (var_26_16 / var_26_15)

				if var_26_17 > 0 and var_26_11 < var_26_17 then
					arg_23_1.talkMaxDuration = var_26_17

					if var_26_17 + var_26_10 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_17 + var_26_10
					end
				end

				arg_23_1.text_.text = var_26_14
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151005", "story_v_out_120151.awb") ~= 0 then
					local var_26_18 = manager.audio:GetVoiceLength("story_v_out_120151", "120151005", "story_v_out_120151.awb") / 1000

					if var_26_18 + var_26_10 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_18 + var_26_10
					end

					if var_26_13.prefab_name ~= "" and arg_23_1.actors_[var_26_13.prefab_name] ~= nil then
						local var_26_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_13.prefab_name].transform, "story_v_out_120151", "120151005", "story_v_out_120151.awb")

						arg_23_1:RecordAudio("120151005", var_26_19)
						arg_23_1:RecordAudio("120151005", var_26_19)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_120151", "120151005", "story_v_out_120151.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_120151", "120151005", "story_v_out_120151.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_20 = math.max(var_26_11, arg_23_1.talkMaxDuration)

			if var_26_10 <= arg_23_1.time_ and arg_23_1.time_ < var_26_10 + var_26_20 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_10) / var_26_20

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_10 + var_26_20 and arg_23_1.time_ < var_26_10 + var_26_20 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play120151006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 120151006
		arg_27_1.duration_ = 2.83

		local var_27_0 = {
			zh = 1.999999999999,
			ja = 2.833
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play120151007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_30_1 = 0
			local var_30_2 = 0.125

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_3 = arg_27_1:FormatText(StoryNameCfg[384].name)

				arg_27_1.leftNameTxt_.text = var_30_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_4 = arg_27_1:GetWordFromCfg(120151006)
				local var_30_5 = arg_27_1:FormatText(var_30_4.content)

				arg_27_1.text_.text = var_30_5

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_6 = 5
				local var_30_7 = utf8.len(var_30_5)
				local var_30_8 = var_30_6 <= 0 and var_30_2 or var_30_2 * (var_30_7 / var_30_6)

				if var_30_8 > 0 and var_30_2 < var_30_8 then
					arg_27_1.talkMaxDuration = var_30_8

					if var_30_8 + var_30_1 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_1
					end
				end

				arg_27_1.text_.text = var_30_5
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151006", "story_v_out_120151.awb") ~= 0 then
					local var_30_9 = manager.audio:GetVoiceLength("story_v_out_120151", "120151006", "story_v_out_120151.awb") / 1000

					if var_30_9 + var_30_1 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_1
					end

					if var_30_4.prefab_name ~= "" and arg_27_1.actors_[var_30_4.prefab_name] ~= nil then
						local var_30_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_4.prefab_name].transform, "story_v_out_120151", "120151006", "story_v_out_120151.awb")

						arg_27_1:RecordAudio("120151006", var_30_10)
						arg_27_1:RecordAudio("120151006", var_30_10)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_120151", "120151006", "story_v_out_120151.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_120151", "120151006", "story_v_out_120151.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_11 = math.max(var_30_2, arg_27_1.talkMaxDuration)

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_11 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_1) / var_30_11

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_1 + var_30_11 and arg_27_1.time_ < var_30_1 + var_30_11 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play120151007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 120151007
		arg_31_1.duration_ = 2.6

		local var_31_0 = {
			zh = 1.999999999999,
			ja = 2.6
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play120151008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_34_1 = arg_31_1.actors_["10037ui_story"]
			local var_34_2 = 0

			if var_34_2 < arg_31_1.time_ and arg_31_1.time_ <= var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect10037ui_story == nil then
				arg_31_1.var_.characterEffect10037ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_3 = 0.2

			if var_34_2 <= arg_31_1.time_ and arg_31_1.time_ < var_34_2 + var_34_3 and not isNil(var_34_1) then
				local var_34_4 = (arg_31_1.time_ - var_34_2) / var_34_3

				if arg_31_1.var_.characterEffect10037ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_2 + var_34_3 and arg_31_1.time_ < var_34_2 + var_34_3 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect10037ui_story then
				arg_31_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_34_5 = arg_31_1.actors_["1071ui_story"]
			local var_34_6 = 0

			if var_34_6 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect1071ui_story == nil then
				arg_31_1.var_.characterEffect1071ui_story = var_34_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_7 = 0.2

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_7 and not isNil(var_34_5) then
				local var_34_8 = (arg_31_1.time_ - var_34_6) / var_34_7

				if arg_31_1.var_.characterEffect1071ui_story and not isNil(var_34_5) then
					local var_34_9 = Mathf.Lerp(0, 0.5, var_34_8)

					arg_31_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1071ui_story.fillRatio = var_34_9
				end
			end

			if arg_31_1.time_ >= var_34_6 + var_34_7 and arg_31_1.time_ < var_34_6 + var_34_7 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect1071ui_story then
				local var_34_10 = 0.5

				arg_31_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1071ui_story.fillRatio = var_34_10
			end

			local var_34_11 = 0
			local var_34_12 = 0.175

			if var_34_11 < arg_31_1.time_ and arg_31_1.time_ <= var_34_11 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_13 = arg_31_1:FormatText(StoryNameCfg[383].name)

				arg_31_1.leftNameTxt_.text = var_34_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_14 = arg_31_1:GetWordFromCfg(120151007)
				local var_34_15 = arg_31_1:FormatText(var_34_14.content)

				arg_31_1.text_.text = var_34_15

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_16 = 7
				local var_34_17 = utf8.len(var_34_15)
				local var_34_18 = var_34_16 <= 0 and var_34_12 or var_34_12 * (var_34_17 / var_34_16)

				if var_34_18 > 0 and var_34_12 < var_34_18 then
					arg_31_1.talkMaxDuration = var_34_18

					if var_34_18 + var_34_11 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_18 + var_34_11
					end
				end

				arg_31_1.text_.text = var_34_15
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151007", "story_v_out_120151.awb") ~= 0 then
					local var_34_19 = manager.audio:GetVoiceLength("story_v_out_120151", "120151007", "story_v_out_120151.awb") / 1000

					if var_34_19 + var_34_11 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_19 + var_34_11
					end

					if var_34_14.prefab_name ~= "" and arg_31_1.actors_[var_34_14.prefab_name] ~= nil then
						local var_34_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_14.prefab_name].transform, "story_v_out_120151", "120151007", "story_v_out_120151.awb")

						arg_31_1:RecordAudio("120151007", var_34_20)
						arg_31_1:RecordAudio("120151007", var_34_20)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_120151", "120151007", "story_v_out_120151.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_120151", "120151007", "story_v_out_120151.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_21 = math.max(var_34_12, arg_31_1.talkMaxDuration)

			if var_34_11 <= arg_31_1.time_ and arg_31_1.time_ < var_34_11 + var_34_21 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_11) / var_34_21

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_11 + var_34_21 and arg_31_1.time_ < var_34_11 + var_34_21 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play120151008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 120151008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play120151009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1071ui_story"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos1071ui_story = var_38_0.localPosition
			end

			local var_38_2 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2
				local var_38_4 = Vector3.New(0, 100, 0)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1071ui_story, var_38_4, var_38_3)

				local var_38_5 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_5.x, var_38_5.y, var_38_5.z)

				local var_38_6 = var_38_0.localEulerAngles

				var_38_6.z = 0
				var_38_6.x = 0
				var_38_0.localEulerAngles = var_38_6
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0, 100, 0)

				local var_38_7 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_7.x, var_38_7.y, var_38_7.z)

				local var_38_8 = var_38_0.localEulerAngles

				var_38_8.z = 0
				var_38_8.x = 0
				var_38_0.localEulerAngles = var_38_8
			end

			local var_38_9 = arg_35_1.actors_["10037ui_story"].transform
			local var_38_10 = 0

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 then
				arg_35_1.var_.moveOldPos10037ui_story = var_38_9.localPosition
			end

			local var_38_11 = 0.001

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_11 then
				local var_38_12 = (arg_35_1.time_ - var_38_10) / var_38_11
				local var_38_13 = Vector3.New(0, 100, 0)

				var_38_9.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10037ui_story, var_38_13, var_38_12)

				local var_38_14 = manager.ui.mainCamera.transform.position - var_38_9.position

				var_38_9.forward = Vector3.New(var_38_14.x, var_38_14.y, var_38_14.z)

				local var_38_15 = var_38_9.localEulerAngles

				var_38_15.z = 0
				var_38_15.x = 0
				var_38_9.localEulerAngles = var_38_15
			end

			if arg_35_1.time_ >= var_38_10 + var_38_11 and arg_35_1.time_ < var_38_10 + var_38_11 + arg_38_0 then
				var_38_9.localPosition = Vector3.New(0, 100, 0)

				local var_38_16 = manager.ui.mainCamera.transform.position - var_38_9.position

				var_38_9.forward = Vector3.New(var_38_16.x, var_38_16.y, var_38_16.z)

				local var_38_17 = var_38_9.localEulerAngles

				var_38_17.z = 0
				var_38_17.x = 0
				var_38_9.localEulerAngles = var_38_17
			end

			local var_38_18 = 0
			local var_38_19 = 0.825

			if var_38_18 < arg_35_1.time_ and arg_35_1.time_ <= var_38_18 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_20 = arg_35_1:GetWordFromCfg(120151008)
				local var_38_21 = arg_35_1:FormatText(var_38_20.content)

				arg_35_1.text_.text = var_38_21

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_22 = 33
				local var_38_23 = utf8.len(var_38_21)
				local var_38_24 = var_38_22 <= 0 and var_38_19 or var_38_19 * (var_38_23 / var_38_22)

				if var_38_24 > 0 and var_38_19 < var_38_24 then
					arg_35_1.talkMaxDuration = var_38_24

					if var_38_24 + var_38_18 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_24 + var_38_18
					end
				end

				arg_35_1.text_.text = var_38_21
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_25 = math.max(var_38_19, arg_35_1.talkMaxDuration)

			if var_38_18 <= arg_35_1.time_ and arg_35_1.time_ < var_38_18 + var_38_25 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_18) / var_38_25

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_18 + var_38_25 and arg_35_1.time_ < var_38_18 + var_38_25 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play120151009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 120151009
		arg_39_1.duration_ = 3.03

		local var_39_0 = {
			zh = 1.999999999999,
			ja = 3.033
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play120151010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1071ui_story"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos1071ui_story = var_42_0.localPosition
			end

			local var_42_2 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2
				local var_42_4 = Vector3.New(0, -1.05, -6.2)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1071ui_story, var_42_4, var_42_3)

				local var_42_5 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_5.x, var_42_5.y, var_42_5.z)

				local var_42_6 = var_42_0.localEulerAngles

				var_42_6.z = 0
				var_42_6.x = 0
				var_42_0.localEulerAngles = var_42_6
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_42_7 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_7.x, var_42_7.y, var_42_7.z)

				local var_42_8 = var_42_0.localEulerAngles

				var_42_8.z = 0
				var_42_8.x = 0
				var_42_0.localEulerAngles = var_42_8
			end

			local var_42_9 = 0

			if var_42_9 < arg_39_1.time_ and arg_39_1.time_ <= var_42_9 + arg_42_0 then
				arg_39_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_42_10 = 0

			if var_42_10 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 then
				arg_39_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_42_11 = arg_39_1.actors_["1071ui_story"]
			local var_42_12 = 0

			if var_42_12 < arg_39_1.time_ and arg_39_1.time_ <= var_42_12 + arg_42_0 and not isNil(var_42_11) and arg_39_1.var_.characterEffect1071ui_story == nil then
				arg_39_1.var_.characterEffect1071ui_story = var_42_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_13 = 0.2

			if var_42_12 <= arg_39_1.time_ and arg_39_1.time_ < var_42_12 + var_42_13 and not isNil(var_42_11) then
				local var_42_14 = (arg_39_1.time_ - var_42_12) / var_42_13

				if arg_39_1.var_.characterEffect1071ui_story and not isNil(var_42_11) then
					arg_39_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_12 + var_42_13 and arg_39_1.time_ < var_42_12 + var_42_13 + arg_42_0 and not isNil(var_42_11) and arg_39_1.var_.characterEffect1071ui_story then
				arg_39_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_42_15 = 0
			local var_42_16 = 0.15

			if var_42_15 < arg_39_1.time_ and arg_39_1.time_ <= var_42_15 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_17 = arg_39_1:FormatText(StoryNameCfg[384].name)

				arg_39_1.leftNameTxt_.text = var_42_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_18 = arg_39_1:GetWordFromCfg(120151009)
				local var_42_19 = arg_39_1:FormatText(var_42_18.content)

				arg_39_1.text_.text = var_42_19

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_20 = 6
				local var_42_21 = utf8.len(var_42_19)
				local var_42_22 = var_42_20 <= 0 and var_42_16 or var_42_16 * (var_42_21 / var_42_20)

				if var_42_22 > 0 and var_42_16 < var_42_22 then
					arg_39_1.talkMaxDuration = var_42_22

					if var_42_22 + var_42_15 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_22 + var_42_15
					end
				end

				arg_39_1.text_.text = var_42_19
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151009", "story_v_out_120151.awb") ~= 0 then
					local var_42_23 = manager.audio:GetVoiceLength("story_v_out_120151", "120151009", "story_v_out_120151.awb") / 1000

					if var_42_23 + var_42_15 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_23 + var_42_15
					end

					if var_42_18.prefab_name ~= "" and arg_39_1.actors_[var_42_18.prefab_name] ~= nil then
						local var_42_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_18.prefab_name].transform, "story_v_out_120151", "120151009", "story_v_out_120151.awb")

						arg_39_1:RecordAudio("120151009", var_42_24)
						arg_39_1:RecordAudio("120151009", var_42_24)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_120151", "120151009", "story_v_out_120151.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_120151", "120151009", "story_v_out_120151.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_25 = math.max(var_42_16, arg_39_1.talkMaxDuration)

			if var_42_15 <= arg_39_1.time_ and arg_39_1.time_ < var_42_15 + var_42_25 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_15) / var_42_25

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_15 + var_42_25 and arg_39_1.time_ < var_42_15 + var_42_25 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play120151010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 120151010
		arg_43_1.duration_ = 7.67

		local var_43_0 = {
			zh = 4.1,
			ja = 7.666
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play120151011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_46_1 = 0
			local var_46_2 = 0.575

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_3 = arg_43_1:FormatText(StoryNameCfg[384].name)

				arg_43_1.leftNameTxt_.text = var_46_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_4 = arg_43_1:GetWordFromCfg(120151010)
				local var_46_5 = arg_43_1:FormatText(var_46_4.content)

				arg_43_1.text_.text = var_46_5

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_6 = 23
				local var_46_7 = utf8.len(var_46_5)
				local var_46_8 = var_46_6 <= 0 and var_46_2 or var_46_2 * (var_46_7 / var_46_6)

				if var_46_8 > 0 and var_46_2 < var_46_8 then
					arg_43_1.talkMaxDuration = var_46_8

					if var_46_8 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_5
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151010", "story_v_out_120151.awb") ~= 0 then
					local var_46_9 = manager.audio:GetVoiceLength("story_v_out_120151", "120151010", "story_v_out_120151.awb") / 1000

					if var_46_9 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_1
					end

					if var_46_4.prefab_name ~= "" and arg_43_1.actors_[var_46_4.prefab_name] ~= nil then
						local var_46_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_4.prefab_name].transform, "story_v_out_120151", "120151010", "story_v_out_120151.awb")

						arg_43_1:RecordAudio("120151010", var_46_10)
						arg_43_1:RecordAudio("120151010", var_46_10)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_120151", "120151010", "story_v_out_120151.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_120151", "120151010", "story_v_out_120151.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_11 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_11 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_11

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_11 and arg_43_1.time_ < var_46_1 + var_46_11 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play120151011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 120151011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play120151012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1071ui_story"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos1071ui_story = var_50_0.localPosition
			end

			local var_50_2 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2
				local var_50_4 = Vector3.New(0, 100, 0)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1071ui_story, var_50_4, var_50_3)

				local var_50_5 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_5.x, var_50_5.y, var_50_5.z)

				local var_50_6 = var_50_0.localEulerAngles

				var_50_6.z = 0
				var_50_6.x = 0
				var_50_0.localEulerAngles = var_50_6
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, 100, 0)

				local var_50_7 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_7.x, var_50_7.y, var_50_7.z)

				local var_50_8 = var_50_0.localEulerAngles

				var_50_8.z = 0
				var_50_8.x = 0
				var_50_0.localEulerAngles = var_50_8
			end

			local var_50_9 = 0
			local var_50_10 = 1.075

			if var_50_9 < arg_47_1.time_ and arg_47_1.time_ <= var_50_9 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_11 = arg_47_1:GetWordFromCfg(120151011)
				local var_50_12 = arg_47_1:FormatText(var_50_11.content)

				arg_47_1.text_.text = var_50_12

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 43
				local var_50_14 = utf8.len(var_50_12)
				local var_50_15 = var_50_13 <= 0 and var_50_10 or var_50_10 * (var_50_14 / var_50_13)

				if var_50_15 > 0 and var_50_10 < var_50_15 then
					arg_47_1.talkMaxDuration = var_50_15

					if var_50_15 + var_50_9 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_15 + var_50_9
					end
				end

				arg_47_1.text_.text = var_50_12
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_10, arg_47_1.talkMaxDuration)

			if var_50_9 <= arg_47_1.time_ and arg_47_1.time_ < var_50_9 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_9) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_9 + var_50_16 and arg_47_1.time_ < var_50_9 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play120151012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 120151012
		arg_51_1.duration_ = 2.07

		local var_51_0 = {
			zh = 1.4,
			ja = 2.066
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play120151013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.075

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[384].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(120151012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 3
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151012", "story_v_out_120151.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_120151", "120151012", "story_v_out_120151.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_120151", "120151012", "story_v_out_120151.awb")

						arg_51_1:RecordAudio("120151012", var_54_9)
						arg_51_1:RecordAudio("120151012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_120151", "120151012", "story_v_out_120151.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_120151", "120151012", "story_v_out_120151.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_10 and arg_51_1.time_ < var_54_0 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play120151013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 120151013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play120151014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 1.1

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_2 = arg_55_1:GetWordFromCfg(120151013)
				local var_58_3 = arg_55_1:FormatText(var_58_2.content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 44
				local var_58_5 = utf8.len(var_58_3)
				local var_58_6 = var_58_4 <= 0 and var_58_1 or var_58_1 * (var_58_5 / var_58_4)

				if var_58_6 > 0 and var_58_1 < var_58_6 then
					arg_55_1.talkMaxDuration = var_58_6

					if var_58_6 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_7 and arg_55_1.time_ < var_58_0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play120151014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 120151014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play120151015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 1

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_2 = arg_59_1:GetWordFromCfg(120151014)
				local var_62_3 = arg_59_1:FormatText(var_62_2.content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 40
				local var_62_5 = utf8.len(var_62_3)
				local var_62_6 = var_62_4 <= 0 and var_62_1 or var_62_1 * (var_62_5 / var_62_4)

				if var_62_6 > 0 and var_62_1 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_7 and arg_59_1.time_ < var_62_0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play120151015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 120151015
		arg_63_1.duration_ = 9

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play120151016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = "ST46"

			if arg_63_1.bgs_[var_66_0] == nil then
				local var_66_1 = Object.Instantiate(arg_63_1.paintGo_)

				var_66_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_66_0)
				var_66_1.name = var_66_0
				var_66_1.transform.parent = arg_63_1.stage_.transform
				var_66_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.bgs_[var_66_0] = var_66_1
			end

			local var_66_2 = 1.999999999999

			if var_66_2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				local var_66_3 = manager.ui.mainCamera.transform.localPosition
				local var_66_4 = Vector3.New(0, 0, 10) + Vector3.New(var_66_3.x, var_66_3.y, 0)
				local var_66_5 = arg_63_1.bgs_.ST46

				var_66_5.transform.localPosition = var_66_4
				var_66_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_6 = var_66_5:GetComponent("SpriteRenderer")

				if var_66_6 and var_66_6.sprite then
					local var_66_7 = (var_66_5.transform.localPosition - var_66_3).z
					local var_66_8 = manager.ui.mainCameraCom_
					local var_66_9 = 2 * var_66_7 * Mathf.Tan(var_66_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_66_10 = var_66_9 * var_66_8.aspect
					local var_66_11 = var_66_6.sprite.bounds.size.x
					local var_66_12 = var_66_6.sprite.bounds.size.y
					local var_66_13 = var_66_10 / var_66_11
					local var_66_14 = var_66_9 / var_66_12
					local var_66_15 = var_66_14 < var_66_13 and var_66_13 or var_66_14

					var_66_5.transform.localScale = Vector3.New(var_66_15, var_66_15, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "ST46" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_16 = 0

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_17 = 2

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_17 then
				local var_66_18 = (arg_63_1.time_ - var_66_16) / var_66_17
				local var_66_19 = Color.New(0, 0, 0)

				var_66_19.a = Mathf.Lerp(0, 1, var_66_18)
				arg_63_1.mask_.color = var_66_19
			end

			if arg_63_1.time_ >= var_66_16 + var_66_17 and arg_63_1.time_ < var_66_16 + var_66_17 + arg_66_0 then
				local var_66_20 = Color.New(0, 0, 0)

				var_66_20.a = 1
				arg_63_1.mask_.color = var_66_20
			end

			local var_66_21 = 2

			if var_66_21 < arg_63_1.time_ and arg_63_1.time_ <= var_66_21 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_22 = 2

			if var_66_21 <= arg_63_1.time_ and arg_63_1.time_ < var_66_21 + var_66_22 then
				local var_66_23 = (arg_63_1.time_ - var_66_21) / var_66_22
				local var_66_24 = Color.New(0, 0, 0)

				var_66_24.a = Mathf.Lerp(1, 0, var_66_23)
				arg_63_1.mask_.color = var_66_24
			end

			if arg_63_1.time_ >= var_66_21 + var_66_22 and arg_63_1.time_ < var_66_21 + var_66_22 + arg_66_0 then
				local var_66_25 = Color.New(0, 0, 0)
				local var_66_26 = 0

				arg_63_1.mask_.enabled = false
				var_66_25.a = var_66_26
				arg_63_1.mask_.color = var_66_25
			end

			local var_66_27 = 3.999999999999

			if var_66_27 < arg_63_1.time_ and arg_63_1.time_ <= var_66_27 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			local var_66_28 = 1

			if arg_63_1.time_ >= var_66_27 + var_66_28 and arg_63_1.time_ < var_66_27 + var_66_28 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			local var_66_29 = arg_63_1.bgs_.ST46.transform
			local var_66_30 = 2

			if var_66_30 < arg_63_1.time_ and arg_63_1.time_ <= var_66_30 + arg_66_0 then
				arg_63_1.var_.moveOldPosST46 = var_66_29.localPosition
			end

			local var_66_31 = 3.5

			if var_66_30 <= arg_63_1.time_ and arg_63_1.time_ < var_66_30 + var_66_31 then
				local var_66_32 = (arg_63_1.time_ - var_66_30) / var_66_31
				local var_66_33 = Vector3.New(0, 1, 9.5)

				var_66_29.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPosST46, var_66_33, var_66_32)
			end

			if arg_63_1.time_ >= var_66_30 + var_66_31 and arg_63_1.time_ < var_66_30 + var_66_31 + arg_66_0 then
				var_66_29.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_66_34 = 4

			if var_66_34 < arg_63_1.time_ and arg_63_1.time_ <= var_66_34 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			local var_66_35 = 1.5

			if arg_63_1.time_ >= var_66_34 + var_66_35 and arg_63_1.time_ < var_66_34 + var_66_35 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_36 = 3.999999999999
			local var_66_37 = 1

			if var_66_36 < arg_63_1.time_ and arg_63_1.time_ <= var_66_36 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_38 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_38:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_39 = arg_63_1:GetWordFromCfg(120151015)
				local var_66_40 = arg_63_1:FormatText(var_66_39.content)

				arg_63_1.text_.text = var_66_40

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_41 = 40
				local var_66_42 = utf8.len(var_66_40)
				local var_66_43 = var_66_41 <= 0 and var_66_37 or var_66_37 * (var_66_42 / var_66_41)

				if var_66_43 > 0 and var_66_37 < var_66_43 then
					arg_63_1.talkMaxDuration = var_66_43
					var_66_36 = var_66_36 + 0.3

					if var_66_43 + var_66_36 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_43 + var_66_36
					end
				end

				arg_63_1.text_.text = var_66_40
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_44 = var_66_36 + 0.3
			local var_66_45 = math.max(var_66_37, arg_63_1.talkMaxDuration)

			if var_66_44 <= arg_63_1.time_ and arg_63_1.time_ < var_66_44 + var_66_45 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_44) / var_66_45

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_44 + var_66_45 and arg_63_1.time_ < var_66_44 + var_66_45 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST46",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play120151016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 120151016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play120151017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.275

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(120151016)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 51
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play120151017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 120151017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play120151018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 1.5

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:GetWordFromCfg(120151017)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 60
				local var_76_5 = utf8.len(var_76_3)
				local var_76_6 = var_76_4 <= 0 and var_76_1 or var_76_1 * (var_76_5 / var_76_4)

				if var_76_6 > 0 and var_76_1 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_7 and arg_73_1.time_ < var_76_0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play120151018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 120151018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play120151019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 1.2

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(120151018)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 48
				local var_80_5 = utf8.len(var_80_3)
				local var_80_6 = var_80_4 <= 0 and var_80_1 or var_80_1 * (var_80_5 / var_80_4)

				if var_80_6 > 0 and var_80_1 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_7 and arg_77_1.time_ < var_80_0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play120151019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 120151019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play120151020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = manager.ui.mainCamera.transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.shakeOldPos = var_84_0.localPosition
			end

			local var_84_2 = 1

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / 0.066
				local var_84_4, var_84_5 = math.modf(var_84_3)

				var_84_0.localPosition = Vector3.New(var_84_5 * 0.13, var_84_5 * 0.13, var_84_5 * 0.13) + arg_81_1.var_.shakeOldPos
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = arg_81_1.var_.shakeOldPos
			end

			local var_84_6 = 0

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.allBtn_.enabled = false
			end

			local var_84_7 = 1

			if arg_81_1.time_ >= var_84_6 + var_84_7 and arg_81_1.time_ < var_84_6 + var_84_7 + arg_84_0 then
				arg_81_1.allBtn_.enabled = true
			end

			local var_84_8 = 0
			local var_84_9 = 1

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				local var_84_10 = "play"
				local var_84_11 = "effect"

				arg_81_1:AudioAction(var_84_10, var_84_11, "se_story_120_00", "se_story_120_00_jianbing_move", "")
			end

			local var_84_12 = 0
			local var_84_13 = 0.05

			if var_84_12 < arg_81_1.time_ and arg_81_1.time_ <= var_84_12 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_14 = arg_81_1:GetWordFromCfg(120151019)
				local var_84_15 = arg_81_1:FormatText(var_84_14.content)

				arg_81_1.text_.text = var_84_15

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_16 = 2
				local var_84_17 = utf8.len(var_84_15)
				local var_84_18 = var_84_16 <= 0 and var_84_13 or var_84_13 * (var_84_17 / var_84_16)

				if var_84_18 > 0 and var_84_13 < var_84_18 then
					arg_81_1.talkMaxDuration = var_84_18

					if var_84_18 + var_84_12 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_18 + var_84_12
					end
				end

				arg_81_1.text_.text = var_84_15
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_19 = math.max(var_84_13, arg_81_1.talkMaxDuration)

			if var_84_12 <= arg_81_1.time_ and arg_81_1.time_ < var_84_12 + var_84_19 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_12) / var_84_19

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_12 + var_84_19 and arg_81_1.time_ < var_84_12 + var_84_19 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play120151020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 120151020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play120151021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 1.2

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:GetWordFromCfg(120151020)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 48
				local var_88_5 = utf8.len(var_88_3)
				local var_88_6 = var_88_4 <= 0 and var_88_1 or var_88_1 * (var_88_5 / var_88_4)

				if var_88_6 > 0 and var_88_1 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_7 and arg_85_1.time_ < var_88_0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play120151021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 120151021
		arg_89_1.duration_ = 3.1

		local var_89_0 = {
			zh = 1.8,
			ja = 3.1
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play120151022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.15

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[384].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(120151021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 6
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151021", "story_v_out_120151.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_120151", "120151021", "story_v_out_120151.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_120151", "120151021", "story_v_out_120151.awb")

						arg_89_1:RecordAudio("120151021", var_92_9)
						arg_89_1:RecordAudio("120151021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_120151", "120151021", "story_v_out_120151.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_120151", "120151021", "story_v_out_120151.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play120151022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 120151022
		arg_93_1.duration_ = 1.27

		local var_93_0 = {
			zh = 1.066,
			ja = 1.266
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
				arg_93_0:Play120151023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.075

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[378].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(120151022)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 3
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151022", "story_v_out_120151.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_120151", "120151022", "story_v_out_120151.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_120151", "120151022", "story_v_out_120151.awb")

						arg_93_1:RecordAudio("120151022", var_96_9)
						arg_93_1:RecordAudio("120151022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_120151", "120151022", "story_v_out_120151.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_120151", "120151022", "story_v_out_120151.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play120151023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 120151023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play120151024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.675

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(120151023)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 27
				local var_100_5 = utf8.len(var_100_3)
				local var_100_6 = var_100_4 <= 0 and var_100_1 or var_100_1 * (var_100_5 / var_100_4)

				if var_100_6 > 0 and var_100_1 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_7 and arg_97_1.time_ < var_100_0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play120151024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 120151024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play120151025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_104_1 = 0
			local var_104_2 = 1.025

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(120151024)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 41
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_2 or var_104_2 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_2 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_8 and arg_101_1.time_ < var_104_1 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play120151025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 120151025
		arg_105_1.duration_ = 3.2

		local var_105_0 = {
			zh = 2.466666666666,
			ja = 3.2
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
				arg_105_0:Play120151026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1071ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1071ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0.7, -1.05, -6.2)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1071ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 then
				arg_105_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_108_10 = arg_105_1.actors_["1071ui_story"]
			local var_108_11 = 0

			if var_108_11 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 and not isNil(var_108_10) and arg_105_1.var_.characterEffect1071ui_story == nil then
				arg_105_1.var_.characterEffect1071ui_story = var_108_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_12 = 0.2

			if var_108_11 <= arg_105_1.time_ and arg_105_1.time_ < var_108_11 + var_108_12 and not isNil(var_108_10) then
				local var_108_13 = (arg_105_1.time_ - var_108_11) / var_108_12

				if arg_105_1.var_.characterEffect1071ui_story and not isNil(var_108_10) then
					local var_108_14 = Mathf.Lerp(0, 0.5, var_108_13)

					arg_105_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1071ui_story.fillRatio = var_108_14
				end
			end

			if arg_105_1.time_ >= var_108_11 + var_108_12 and arg_105_1.time_ < var_108_11 + var_108_12 + arg_108_0 and not isNil(var_108_10) and arg_105_1.var_.characterEffect1071ui_story then
				local var_108_15 = 0.5

				arg_105_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1071ui_story.fillRatio = var_108_15
			end

			local var_108_16 = "1069ui_story"

			if arg_105_1.actors_[var_108_16] == nil then
				local var_108_17 = Asset.Load("Char/" .. "1069ui_story")

				if not isNil(var_108_17) then
					local var_108_18 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_105_1.stage_.transform)

					var_108_18.name = var_108_16
					var_108_18.transform.localPosition = Vector3.New(0, 100, 0)
					arg_105_1.actors_[var_108_16] = var_108_18

					local var_108_19 = var_108_18:GetComponentInChildren(typeof(CharacterEffect))

					var_108_19.enabled = true

					local var_108_20 = GameObjectTools.GetOrAddComponent(var_108_18, typeof(DynamicBoneHelper))

					if var_108_20 then
						var_108_20:EnableDynamicBone(false)
					end

					arg_105_1:ShowWeapon(var_108_19.transform, false)

					arg_105_1.var_[var_108_16 .. "Animator"] = var_108_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_105_1.var_[var_108_16 .. "Animator"].applyRootMotion = true
					arg_105_1.var_[var_108_16 .. "LipSync"] = var_108_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_108_21 = arg_105_1.actors_["1069ui_story"].transform
			local var_108_22 = 0

			if var_108_22 < arg_105_1.time_ and arg_105_1.time_ <= var_108_22 + arg_108_0 then
				arg_105_1.var_.moveOldPos1069ui_story = var_108_21.localPosition
			end

			local var_108_23 = 0.001

			if var_108_22 <= arg_105_1.time_ and arg_105_1.time_ < var_108_22 + var_108_23 then
				local var_108_24 = (arg_105_1.time_ - var_108_22) / var_108_23
				local var_108_25 = Vector3.New(-0.7, -1, -6)

				var_108_21.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1069ui_story, var_108_25, var_108_24)

				local var_108_26 = manager.ui.mainCamera.transform.position - var_108_21.position

				var_108_21.forward = Vector3.New(var_108_26.x, var_108_26.y, var_108_26.z)

				local var_108_27 = var_108_21.localEulerAngles

				var_108_27.z = 0
				var_108_27.x = 0
				var_108_21.localEulerAngles = var_108_27
			end

			if arg_105_1.time_ >= var_108_22 + var_108_23 and arg_105_1.time_ < var_108_22 + var_108_23 + arg_108_0 then
				var_108_21.localPosition = Vector3.New(-0.7, -1, -6)

				local var_108_28 = manager.ui.mainCamera.transform.position - var_108_21.position

				var_108_21.forward = Vector3.New(var_108_28.x, var_108_28.y, var_108_28.z)

				local var_108_29 = var_108_21.localEulerAngles

				var_108_29.z = 0
				var_108_29.x = 0
				var_108_21.localEulerAngles = var_108_29
			end

			local var_108_30 = 0

			if var_108_30 < arg_105_1.time_ and arg_105_1.time_ <= var_108_30 + arg_108_0 then
				arg_105_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action1_1")
			end

			local var_108_31 = 0

			if var_108_31 < arg_105_1.time_ and arg_105_1.time_ <= var_108_31 + arg_108_0 then
				arg_105_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_108_32 = arg_105_1.actors_["1069ui_story"]
			local var_108_33 = 0

			if var_108_33 < arg_105_1.time_ and arg_105_1.time_ <= var_108_33 + arg_108_0 and not isNil(var_108_32) and arg_105_1.var_.characterEffect1069ui_story == nil then
				arg_105_1.var_.characterEffect1069ui_story = var_108_32:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_34 = 0.2

			if var_108_33 <= arg_105_1.time_ and arg_105_1.time_ < var_108_33 + var_108_34 and not isNil(var_108_32) then
				local var_108_35 = (arg_105_1.time_ - var_108_33) / var_108_34

				if arg_105_1.var_.characterEffect1069ui_story and not isNil(var_108_32) then
					arg_105_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_33 + var_108_34 and arg_105_1.time_ < var_108_33 + var_108_34 + arg_108_0 and not isNil(var_108_32) and arg_105_1.var_.characterEffect1069ui_story then
				arg_105_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_108_36 = 0
			local var_108_37 = 0.1

			if var_108_36 < arg_105_1.time_ and arg_105_1.time_ <= var_108_36 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_38 = arg_105_1:FormatText(StoryNameCfg[378].name)

				arg_105_1.leftNameTxt_.text = var_108_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_39 = arg_105_1:GetWordFromCfg(120151025)
				local var_108_40 = arg_105_1:FormatText(var_108_39.content)

				arg_105_1.text_.text = var_108_40

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_41 = 4
				local var_108_42 = utf8.len(var_108_40)
				local var_108_43 = var_108_41 <= 0 and var_108_37 or var_108_37 * (var_108_42 / var_108_41)

				if var_108_43 > 0 and var_108_37 < var_108_43 then
					arg_105_1.talkMaxDuration = var_108_43

					if var_108_43 + var_108_36 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_43 + var_108_36
					end
				end

				arg_105_1.text_.text = var_108_40
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151025", "story_v_out_120151.awb") ~= 0 then
					local var_108_44 = manager.audio:GetVoiceLength("story_v_out_120151", "120151025", "story_v_out_120151.awb") / 1000

					if var_108_44 + var_108_36 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_44 + var_108_36
					end

					if var_108_39.prefab_name ~= "" and arg_105_1.actors_[var_108_39.prefab_name] ~= nil then
						local var_108_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_39.prefab_name].transform, "story_v_out_120151", "120151025", "story_v_out_120151.awb")

						arg_105_1:RecordAudio("120151025", var_108_45)
						arg_105_1:RecordAudio("120151025", var_108_45)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_120151", "120151025", "story_v_out_120151.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_120151", "120151025", "story_v_out_120151.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_46 = math.max(var_108_37, arg_105_1.talkMaxDuration)

			if var_108_36 <= arg_105_1.time_ and arg_105_1.time_ < var_108_36 + var_108_46 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_36) / var_108_46

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_36 + var_108_46 and arg_105_1.time_ < var_108_36 + var_108_46 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play120151026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 120151026
		arg_109_1.duration_ = 4.33

		local var_109_0 = {
			zh = 4.333,
			ja = 4
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
				arg_109_0:Play120151027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1069ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1069ui_story == nil then
				arg_109_1.var_.characterEffect1069ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1069ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1069ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1069ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1069ui_story.fillRatio = var_112_5
			end

			local var_112_6 = arg_109_1.actors_["1071ui_story"]
			local var_112_7 = 0

			if var_112_7 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect1071ui_story == nil then
				arg_109_1.var_.characterEffect1071ui_story = var_112_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_8 = 0.2

			if var_112_7 <= arg_109_1.time_ and arg_109_1.time_ < var_112_7 + var_112_8 and not isNil(var_112_6) then
				local var_112_9 = (arg_109_1.time_ - var_112_7) / var_112_8

				if arg_109_1.var_.characterEffect1071ui_story and not isNil(var_112_6) then
					arg_109_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_7 + var_112_8 and arg_109_1.time_ < var_112_7 + var_112_8 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect1071ui_story then
				arg_109_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				arg_109_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_112_11 = 0
			local var_112_12 = 0.3

			if var_112_11 < arg_109_1.time_ and arg_109_1.time_ <= var_112_11 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_13 = arg_109_1:FormatText(StoryNameCfg[384].name)

				arg_109_1.leftNameTxt_.text = var_112_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_14 = arg_109_1:GetWordFromCfg(120151026)
				local var_112_15 = arg_109_1:FormatText(var_112_14.content)

				arg_109_1.text_.text = var_112_15

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_16 = 12
				local var_112_17 = utf8.len(var_112_15)
				local var_112_18 = var_112_16 <= 0 and var_112_12 or var_112_12 * (var_112_17 / var_112_16)

				if var_112_18 > 0 and var_112_12 < var_112_18 then
					arg_109_1.talkMaxDuration = var_112_18

					if var_112_18 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_18 + var_112_11
					end
				end

				arg_109_1.text_.text = var_112_15
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151026", "story_v_out_120151.awb") ~= 0 then
					local var_112_19 = manager.audio:GetVoiceLength("story_v_out_120151", "120151026", "story_v_out_120151.awb") / 1000

					if var_112_19 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_19 + var_112_11
					end

					if var_112_14.prefab_name ~= "" and arg_109_1.actors_[var_112_14.prefab_name] ~= nil then
						local var_112_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_14.prefab_name].transform, "story_v_out_120151", "120151026", "story_v_out_120151.awb")

						arg_109_1:RecordAudio("120151026", var_112_20)
						arg_109_1:RecordAudio("120151026", var_112_20)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_120151", "120151026", "story_v_out_120151.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_120151", "120151026", "story_v_out_120151.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_21 = math.max(var_112_12, arg_109_1.talkMaxDuration)

			if var_112_11 <= arg_109_1.time_ and arg_109_1.time_ < var_112_11 + var_112_21 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_11) / var_112_21

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_11 + var_112_21 and arg_109_1.time_ < var_112_11 + var_112_21 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play120151027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 120151027
		arg_113_1.duration_ = 9.47

		local var_113_0 = {
			zh = 6.566,
			ja = 9.466
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play120151028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_116_2 = 0
			local var_116_3 = 0.675

			if var_116_2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_4 = arg_113_1:FormatText(StoryNameCfg[384].name)

				arg_113_1.leftNameTxt_.text = var_116_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_5 = arg_113_1:GetWordFromCfg(120151027)
				local var_116_6 = arg_113_1:FormatText(var_116_5.content)

				arg_113_1.text_.text = var_116_6

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 27
				local var_116_8 = utf8.len(var_116_6)
				local var_116_9 = var_116_7 <= 0 and var_116_3 or var_116_3 * (var_116_8 / var_116_7)

				if var_116_9 > 0 and var_116_3 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_6
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151027", "story_v_out_120151.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_120151", "120151027", "story_v_out_120151.awb") / 1000

					if var_116_10 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_2
					end

					if var_116_5.prefab_name ~= "" and arg_113_1.actors_[var_116_5.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_5.prefab_name].transform, "story_v_out_120151", "120151027", "story_v_out_120151.awb")

						arg_113_1:RecordAudio("120151027", var_116_11)
						arg_113_1:RecordAudio("120151027", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_120151", "120151027", "story_v_out_120151.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_120151", "120151027", "story_v_out_120151.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_12 and arg_113_1.time_ < var_116_2 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play120151028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 120151028
		arg_117_1.duration_ = 2.73

		local var_117_0 = {
			zh = 2.333,
			ja = 2.733
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
				arg_117_0:Play120151029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_120_1 = arg_117_1.actors_["1069ui_story"]
			local var_120_2 = 0

			if var_120_2 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1069ui_story == nil then
				arg_117_1.var_.characterEffect1069ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.2

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_3 and not isNil(var_120_1) then
				local var_120_4 = (arg_117_1.time_ - var_120_2) / var_120_3

				if arg_117_1.var_.characterEffect1069ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_2 + var_120_3 and arg_117_1.time_ < var_120_2 + var_120_3 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1069ui_story then
				arg_117_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_120_5 = arg_117_1.actors_["1071ui_story"]
			local var_120_6 = 0

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1071ui_story == nil then
				arg_117_1.var_.characterEffect1071ui_story = var_120_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_7 = 0.2

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_7 and not isNil(var_120_5) then
				local var_120_8 = (arg_117_1.time_ - var_120_6) / var_120_7

				if arg_117_1.var_.characterEffect1071ui_story and not isNil(var_120_5) then
					local var_120_9 = Mathf.Lerp(0, 0.5, var_120_8)

					arg_117_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1071ui_story.fillRatio = var_120_9
				end
			end

			if arg_117_1.time_ >= var_120_6 + var_120_7 and arg_117_1.time_ < var_120_6 + var_120_7 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1071ui_story then
				local var_120_10 = 0.5

				arg_117_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1071ui_story.fillRatio = var_120_10
			end

			local var_120_11 = 0

			if var_120_11 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				arg_117_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_120_12 = 0
			local var_120_13 = 0.25

			if var_120_12 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_14 = arg_117_1:FormatText(StoryNameCfg[378].name)

				arg_117_1.leftNameTxt_.text = var_120_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_15 = arg_117_1:GetWordFromCfg(120151028)
				local var_120_16 = arg_117_1:FormatText(var_120_15.content)

				arg_117_1.text_.text = var_120_16

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_17 = 10
				local var_120_18 = utf8.len(var_120_16)
				local var_120_19 = var_120_17 <= 0 and var_120_13 or var_120_13 * (var_120_18 / var_120_17)

				if var_120_19 > 0 and var_120_13 < var_120_19 then
					arg_117_1.talkMaxDuration = var_120_19

					if var_120_19 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_19 + var_120_12
					end
				end

				arg_117_1.text_.text = var_120_16
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151028", "story_v_out_120151.awb") ~= 0 then
					local var_120_20 = manager.audio:GetVoiceLength("story_v_out_120151", "120151028", "story_v_out_120151.awb") / 1000

					if var_120_20 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_20 + var_120_12
					end

					if var_120_15.prefab_name ~= "" and arg_117_1.actors_[var_120_15.prefab_name] ~= nil then
						local var_120_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_15.prefab_name].transform, "story_v_out_120151", "120151028", "story_v_out_120151.awb")

						arg_117_1:RecordAudio("120151028", var_120_21)
						arg_117_1:RecordAudio("120151028", var_120_21)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_120151", "120151028", "story_v_out_120151.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_120151", "120151028", "story_v_out_120151.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_22 = math.max(var_120_13, arg_117_1.talkMaxDuration)

			if var_120_12 <= arg_117_1.time_ and arg_117_1.time_ < var_120_12 + var_120_22 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_12) / var_120_22

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_12 + var_120_22 and arg_117_1.time_ < var_120_12 + var_120_22 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play120151029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 120151029
		arg_121_1.duration_ = 4.9

		local var_121_0 = {
			zh = 4.333,
			ja = 4.9
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
				arg_121_0:Play120151030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_124_1 = 0
			local var_124_2 = 0.4

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_3 = arg_121_1:FormatText(StoryNameCfg[378].name)

				arg_121_1.leftNameTxt_.text = var_124_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_4 = arg_121_1:GetWordFromCfg(120151029)
				local var_124_5 = arg_121_1:FormatText(var_124_4.content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 16
				local var_124_7 = utf8.len(var_124_5)
				local var_124_8 = var_124_6 <= 0 and var_124_2 or var_124_2 * (var_124_7 / var_124_6)

				if var_124_8 > 0 and var_124_2 < var_124_8 then
					arg_121_1.talkMaxDuration = var_124_8

					if var_124_8 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151029", "story_v_out_120151.awb") ~= 0 then
					local var_124_9 = manager.audio:GetVoiceLength("story_v_out_120151", "120151029", "story_v_out_120151.awb") / 1000

					if var_124_9 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_1
					end

					if var_124_4.prefab_name ~= "" and arg_121_1.actors_[var_124_4.prefab_name] ~= nil then
						local var_124_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_4.prefab_name].transform, "story_v_out_120151", "120151029", "story_v_out_120151.awb")

						arg_121_1:RecordAudio("120151029", var_124_10)
						arg_121_1:RecordAudio("120151029", var_124_10)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_120151", "120151029", "story_v_out_120151.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_120151", "120151029", "story_v_out_120151.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_11 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_11 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_11

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_11 and arg_121_1.time_ < var_124_1 + var_124_11 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play120151030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 120151030
		arg_125_1.duration_ = 6.17

		local var_125_0 = {
			zh = 4,
			ja = 6.166
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
				arg_125_0:Play120151031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1069ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1069ui_story == nil then
				arg_125_1.var_.characterEffect1069ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1069ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1069ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1069ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1069ui_story.fillRatio = var_128_5
			end

			local var_128_6 = 0
			local var_128_7 = 0.375

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_8 = arg_125_1:FormatText(StoryNameCfg[383].name)

				arg_125_1.leftNameTxt_.text = var_128_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10037")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_9 = arg_125_1:GetWordFromCfg(120151030)
				local var_128_10 = arg_125_1:FormatText(var_128_9.content)

				arg_125_1.text_.text = var_128_10

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 15
				local var_128_12 = utf8.len(var_128_10)
				local var_128_13 = var_128_11 <= 0 and var_128_7 or var_128_7 * (var_128_12 / var_128_11)

				if var_128_13 > 0 and var_128_7 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_10
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151030", "story_v_out_120151.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_out_120151", "120151030", "story_v_out_120151.awb") / 1000

					if var_128_14 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_6
					end

					if var_128_9.prefab_name ~= "" and arg_125_1.actors_[var_128_9.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_9.prefab_name].transform, "story_v_out_120151", "120151030", "story_v_out_120151.awb")

						arg_125_1:RecordAudio("120151030", var_128_15)
						arg_125_1:RecordAudio("120151030", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_120151", "120151030", "story_v_out_120151.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_120151", "120151030", "story_v_out_120151.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_16 and arg_125_1.time_ < var_128_6 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play120151031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 120151031
		arg_129_1.duration_ = 7.43

		local var_129_0 = {
			zh = 4.6,
			ja = 7.433
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
				arg_129_0:Play120151032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_132_1 = arg_129_1.actors_["1069ui_story"]
			local var_132_2 = 0

			if var_132_2 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1069ui_story == nil then
				arg_129_1.var_.characterEffect1069ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_3 = 0.2

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_3 and not isNil(var_132_1) then
				local var_132_4 = (arg_129_1.time_ - var_132_2) / var_132_3

				if arg_129_1.var_.characterEffect1069ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_2 + var_132_3 and arg_129_1.time_ < var_132_2 + var_132_3 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1069ui_story then
				arg_129_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_132_5 = 0
			local var_132_6 = 0.5

			if var_132_5 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_7 = arg_129_1:FormatText(StoryNameCfg[378].name)

				arg_129_1.leftNameTxt_.text = var_132_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(120151031)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 20
				local var_132_11 = utf8.len(var_132_9)
				local var_132_12 = var_132_10 <= 0 and var_132_6 or var_132_6 * (var_132_11 / var_132_10)

				if var_132_12 > 0 and var_132_6 < var_132_12 then
					arg_129_1.talkMaxDuration = var_132_12

					if var_132_12 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_5
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151031", "story_v_out_120151.awb") ~= 0 then
					local var_132_13 = manager.audio:GetVoiceLength("story_v_out_120151", "120151031", "story_v_out_120151.awb") / 1000

					if var_132_13 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_5
					end

					if var_132_8.prefab_name ~= "" and arg_129_1.actors_[var_132_8.prefab_name] ~= nil then
						local var_132_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_8.prefab_name].transform, "story_v_out_120151", "120151031", "story_v_out_120151.awb")

						arg_129_1:RecordAudio("120151031", var_132_14)
						arg_129_1:RecordAudio("120151031", var_132_14)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_120151", "120151031", "story_v_out_120151.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_120151", "120151031", "story_v_out_120151.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_15 = math.max(var_132_6, arg_129_1.talkMaxDuration)

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_15 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_5) / var_132_15

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_5 + var_132_15 and arg_129_1.time_ < var_132_5 + var_132_15 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play120151032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 120151032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play120151033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1069ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1069ui_story == nil then
				arg_133_1.var_.characterEffect1069ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1069ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1069ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1069ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1069ui_story.fillRatio = var_136_5
			end

			local var_136_6 = 0
			local var_136_7 = 0.05

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_8 = arg_133_1:FormatText(StoryNameCfg[383].name)

				arg_133_1.leftNameTxt_.text = var_136_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10037")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_9 = arg_133_1:GetWordFromCfg(120151032)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 2
				local var_136_12 = utf8.len(var_136_10)
				local var_136_13 = var_136_11 <= 0 and var_136_7 or var_136_7 * (var_136_12 / var_136_11)

				if var_136_13 > 0 and var_136_7 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_10
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_14 and arg_133_1.time_ < var_136_6 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play120151033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 120151033
		arg_137_1.duration_ = 4.9

		local var_137_0 = {
			zh = 4.9,
			ja = 4.2
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
				arg_137_0:Play120151034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_140_1 = arg_137_1.actors_["1069ui_story"]
			local var_140_2 = 0

			if var_140_2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1069ui_story == nil then
				arg_137_1.var_.characterEffect1069ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_3 = 0.2

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_3 and not isNil(var_140_1) then
				local var_140_4 = (arg_137_1.time_ - var_140_2) / var_140_3

				if arg_137_1.var_.characterEffect1069ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_2 + var_140_3 and arg_137_1.time_ < var_140_2 + var_140_3 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1069ui_story then
				arg_137_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_140_5 = 0
			local var_140_6 = 0.475

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_7 = arg_137_1:FormatText(StoryNameCfg[378].name)

				arg_137_1.leftNameTxt_.text = var_140_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_8 = arg_137_1:GetWordFromCfg(120151033)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 19
				local var_140_11 = utf8.len(var_140_9)
				local var_140_12 = var_140_10 <= 0 and var_140_6 or var_140_6 * (var_140_11 / var_140_10)

				if var_140_12 > 0 and var_140_6 < var_140_12 then
					arg_137_1.talkMaxDuration = var_140_12

					if var_140_12 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151033", "story_v_out_120151.awb") ~= 0 then
					local var_140_13 = manager.audio:GetVoiceLength("story_v_out_120151", "120151033", "story_v_out_120151.awb") / 1000

					if var_140_13 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_5
					end

					if var_140_8.prefab_name ~= "" and arg_137_1.actors_[var_140_8.prefab_name] ~= nil then
						local var_140_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_8.prefab_name].transform, "story_v_out_120151", "120151033", "story_v_out_120151.awb")

						arg_137_1:RecordAudio("120151033", var_140_14)
						arg_137_1:RecordAudio("120151033", var_140_14)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_120151", "120151033", "story_v_out_120151.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_120151", "120151033", "story_v_out_120151.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_15 = math.max(var_140_6, arg_137_1.talkMaxDuration)

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_15 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_5) / var_140_15

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_5 + var_140_15 and arg_137_1.time_ < var_140_5 + var_140_15 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play120151034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 120151034
		arg_141_1.duration_ = 3.33

		local var_141_0 = {
			zh = 1.999999999999,
			ja = 3.333
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
				arg_141_0:Play120151035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_144_1 = 0
			local var_144_2 = 0.2

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_3 = arg_141_1:FormatText(StoryNameCfg[378].name)

				arg_141_1.leftNameTxt_.text = var_144_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_4 = arg_141_1:GetWordFromCfg(120151034)
				local var_144_5 = arg_141_1:FormatText(var_144_4.content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_6 = 8
				local var_144_7 = utf8.len(var_144_5)
				local var_144_8 = var_144_6 <= 0 and var_144_2 or var_144_2 * (var_144_7 / var_144_6)

				if var_144_8 > 0 and var_144_2 < var_144_8 then
					arg_141_1.talkMaxDuration = var_144_8

					if var_144_8 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151034", "story_v_out_120151.awb") ~= 0 then
					local var_144_9 = manager.audio:GetVoiceLength("story_v_out_120151", "120151034", "story_v_out_120151.awb") / 1000

					if var_144_9 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_1
					end

					if var_144_4.prefab_name ~= "" and arg_141_1.actors_[var_144_4.prefab_name] ~= nil then
						local var_144_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_4.prefab_name].transform, "story_v_out_120151", "120151034", "story_v_out_120151.awb")

						arg_141_1:RecordAudio("120151034", var_144_10)
						arg_141_1:RecordAudio("120151034", var_144_10)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_120151", "120151034", "story_v_out_120151.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_120151", "120151034", "story_v_out_120151.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_11 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_11 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_11

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_11 and arg_141_1.time_ < var_144_1 + var_144_11 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play120151035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 120151035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play120151036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1069ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1069ui_story == nil then
				arg_145_1.var_.characterEffect1069ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect1069ui_story and not isNil(var_148_0) then
					local var_148_4 = Mathf.Lerp(0, 0.5, var_148_3)

					arg_145_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1069ui_story.fillRatio = var_148_4
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1069ui_story then
				local var_148_5 = 0.5

				arg_145_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1069ui_story.fillRatio = var_148_5
			end

			local var_148_6 = 0
			local var_148_7 = 1.025

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

				local var_148_8 = arg_145_1:GetWordFromCfg(120151035)
				local var_148_9 = arg_145_1:FormatText(var_148_8.content)

				arg_145_1.text_.text = var_148_9

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_10 = 41
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
	Play120151036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 120151036
		arg_149_1.duration_ = 11

		local var_149_0 = {
			zh = 4.8,
			ja = 11
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
				arg_149_0:Play120151037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_152_1 = arg_149_1.actors_["1071ui_story"]
			local var_152_2 = 0

			if var_152_2 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1071ui_story == nil then
				arg_149_1.var_.characterEffect1071ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.2

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_3 and not isNil(var_152_1) then
				local var_152_4 = (arg_149_1.time_ - var_152_2) / var_152_3

				if arg_149_1.var_.characterEffect1071ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_2 + var_152_3 and arg_149_1.time_ < var_152_2 + var_152_3 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1071ui_story then
				arg_149_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_152_5 = 0
			local var_152_6 = 0.4

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_7 = arg_149_1:FormatText(StoryNameCfg[384].name)

				arg_149_1.leftNameTxt_.text = var_152_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:GetWordFromCfg(120151036)
				local var_152_9 = arg_149_1:FormatText(var_152_8.content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_10 = 16
				local var_152_11 = utf8.len(var_152_9)
				local var_152_12 = var_152_10 <= 0 and var_152_6 or var_152_6 * (var_152_11 / var_152_10)

				if var_152_12 > 0 and var_152_6 < var_152_12 then
					arg_149_1.talkMaxDuration = var_152_12

					if var_152_12 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_5
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151036", "story_v_out_120151.awb") ~= 0 then
					local var_152_13 = manager.audio:GetVoiceLength("story_v_out_120151", "120151036", "story_v_out_120151.awb") / 1000

					if var_152_13 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_5
					end

					if var_152_8.prefab_name ~= "" and arg_149_1.actors_[var_152_8.prefab_name] ~= nil then
						local var_152_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_8.prefab_name].transform, "story_v_out_120151", "120151036", "story_v_out_120151.awb")

						arg_149_1:RecordAudio("120151036", var_152_14)
						arg_149_1:RecordAudio("120151036", var_152_14)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_120151", "120151036", "story_v_out_120151.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_120151", "120151036", "story_v_out_120151.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_15 = math.max(var_152_6, arg_149_1.talkMaxDuration)

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_15 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_5) / var_152_15

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_5 + var_152_15 and arg_149_1.time_ < var_152_5 + var_152_15 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play120151037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 120151037
		arg_153_1.duration_ = 5.97

		local var_153_0 = {
			zh = 5.966,
			ja = 4.4
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
				arg_153_0:Play120151038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_156_1 = arg_153_1.actors_["1069ui_story"]
			local var_156_2 = 0

			if var_156_2 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1069ui_story == nil then
				arg_153_1.var_.characterEffect1069ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.2

			if var_156_2 <= arg_153_1.time_ and arg_153_1.time_ < var_156_2 + var_156_3 and not isNil(var_156_1) then
				local var_156_4 = (arg_153_1.time_ - var_156_2) / var_156_3

				if arg_153_1.var_.characterEffect1069ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_2 + var_156_3 and arg_153_1.time_ < var_156_2 + var_156_3 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1069ui_story then
				arg_153_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_156_5 = arg_153_1.actors_["1071ui_story"]
			local var_156_6 = 0

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect1071ui_story == nil then
				arg_153_1.var_.characterEffect1071ui_story = var_156_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_7 = 0.2

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_7 and not isNil(var_156_5) then
				local var_156_8 = (arg_153_1.time_ - var_156_6) / var_156_7

				if arg_153_1.var_.characterEffect1071ui_story and not isNil(var_156_5) then
					local var_156_9 = Mathf.Lerp(0, 0.5, var_156_8)

					arg_153_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1071ui_story.fillRatio = var_156_9
				end
			end

			if arg_153_1.time_ >= var_156_6 + var_156_7 and arg_153_1.time_ < var_156_6 + var_156_7 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect1071ui_story then
				local var_156_10 = 0.5

				arg_153_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1071ui_story.fillRatio = var_156_10
			end

			local var_156_11 = 0
			local var_156_12 = 0.675

			if var_156_11 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_13 = arg_153_1:FormatText(StoryNameCfg[378].name)

				arg_153_1.leftNameTxt_.text = var_156_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_14 = arg_153_1:GetWordFromCfg(120151037)
				local var_156_15 = arg_153_1:FormatText(var_156_14.content)

				arg_153_1.text_.text = var_156_15

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_16 = 27
				local var_156_17 = utf8.len(var_156_15)
				local var_156_18 = var_156_16 <= 0 and var_156_12 or var_156_12 * (var_156_17 / var_156_16)

				if var_156_18 > 0 and var_156_12 < var_156_18 then
					arg_153_1.talkMaxDuration = var_156_18

					if var_156_18 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_18 + var_156_11
					end
				end

				arg_153_1.text_.text = var_156_15
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151037", "story_v_out_120151.awb") ~= 0 then
					local var_156_19 = manager.audio:GetVoiceLength("story_v_out_120151", "120151037", "story_v_out_120151.awb") / 1000

					if var_156_19 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_11
					end

					if var_156_14.prefab_name ~= "" and arg_153_1.actors_[var_156_14.prefab_name] ~= nil then
						local var_156_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_14.prefab_name].transform, "story_v_out_120151", "120151037", "story_v_out_120151.awb")

						arg_153_1:RecordAudio("120151037", var_156_20)
						arg_153_1:RecordAudio("120151037", var_156_20)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_120151", "120151037", "story_v_out_120151.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_120151", "120151037", "story_v_out_120151.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_21 = math.max(var_156_12, arg_153_1.talkMaxDuration)

			if var_156_11 <= arg_153_1.time_ and arg_153_1.time_ < var_156_11 + var_156_21 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_11) / var_156_21

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_11 + var_156_21 and arg_153_1.time_ < var_156_11 + var_156_21 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play120151038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 120151038
		arg_157_1.duration_ = 5.77

		local var_157_0 = {
			zh = 5.766,
			ja = 4.9
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
				arg_157_0:Play120151039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1069ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1069ui_story == nil then
				arg_157_1.var_.characterEffect1069ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1069ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1069ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1069ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1069ui_story.fillRatio = var_160_5
			end

			local var_160_6 = arg_157_1.actors_["1071ui_story"]
			local var_160_7 = 0

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect1071ui_story == nil then
				arg_157_1.var_.characterEffect1071ui_story = var_160_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_8 = 0.2

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_8 and not isNil(var_160_6) then
				local var_160_9 = (arg_157_1.time_ - var_160_7) / var_160_8

				if arg_157_1.var_.characterEffect1071ui_story and not isNil(var_160_6) then
					arg_157_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_7 + var_160_8 and arg_157_1.time_ < var_160_7 + var_160_8 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect1071ui_story then
				arg_157_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_160_11 = 0

			if var_160_11 < arg_157_1.time_ and arg_157_1.time_ <= var_160_11 + arg_160_0 then
				arg_157_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action6_1")
			end

			local var_160_12 = 0
			local var_160_13 = 0.275

			if var_160_12 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_14 = arg_157_1:FormatText(StoryNameCfg[384].name)

				arg_157_1.leftNameTxt_.text = var_160_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_15 = arg_157_1:GetWordFromCfg(120151038)
				local var_160_16 = arg_157_1:FormatText(var_160_15.content)

				arg_157_1.text_.text = var_160_16

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_17 = 11
				local var_160_18 = utf8.len(var_160_16)
				local var_160_19 = var_160_17 <= 0 and var_160_13 or var_160_13 * (var_160_18 / var_160_17)

				if var_160_19 > 0 and var_160_13 < var_160_19 then
					arg_157_1.talkMaxDuration = var_160_19

					if var_160_19 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_19 + var_160_12
					end
				end

				arg_157_1.text_.text = var_160_16
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151038", "story_v_out_120151.awb") ~= 0 then
					local var_160_20 = manager.audio:GetVoiceLength("story_v_out_120151", "120151038", "story_v_out_120151.awb") / 1000

					if var_160_20 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_20 + var_160_12
					end

					if var_160_15.prefab_name ~= "" and arg_157_1.actors_[var_160_15.prefab_name] ~= nil then
						local var_160_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_15.prefab_name].transform, "story_v_out_120151", "120151038", "story_v_out_120151.awb")

						arg_157_1:RecordAudio("120151038", var_160_21)
						arg_157_1:RecordAudio("120151038", var_160_21)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_120151", "120151038", "story_v_out_120151.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_120151", "120151038", "story_v_out_120151.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_22 = math.max(var_160_13, arg_157_1.talkMaxDuration)

			if var_160_12 <= arg_157_1.time_ and arg_157_1.time_ < var_160_12 + var_160_22 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_12) / var_160_22

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_12 + var_160_22 and arg_157_1.time_ < var_160_12 + var_160_22 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play120151039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 120151039
		arg_161_1.duration_ = 4.43

		local var_161_0 = {
			zh = 4.2,
			ja = 4.433
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
				arg_161_0:Play120151040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_164_1 = arg_161_1.actors_["1069ui_story"]
			local var_164_2 = 0

			if var_164_2 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1069ui_story == nil then
				arg_161_1.var_.characterEffect1069ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_3 = 0.2

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_3 and not isNil(var_164_1) then
				local var_164_4 = (arg_161_1.time_ - var_164_2) / var_164_3

				if arg_161_1.var_.characterEffect1069ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_2 + var_164_3 and arg_161_1.time_ < var_164_2 + var_164_3 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1069ui_story then
				arg_161_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_164_5 = arg_161_1.actors_["1071ui_story"]
			local var_164_6 = 0

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1071ui_story == nil then
				arg_161_1.var_.characterEffect1071ui_story = var_164_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_7 = 0.2

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_7 and not isNil(var_164_5) then
				local var_164_8 = (arg_161_1.time_ - var_164_6) / var_164_7

				if arg_161_1.var_.characterEffect1071ui_story and not isNil(var_164_5) then
					local var_164_9 = Mathf.Lerp(0, 0.5, var_164_8)

					arg_161_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1071ui_story.fillRatio = var_164_9
				end
			end

			if arg_161_1.time_ >= var_164_6 + var_164_7 and arg_161_1.time_ < var_164_6 + var_164_7 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1071ui_story then
				local var_164_10 = 0.5

				arg_161_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1071ui_story.fillRatio = var_164_10
			end

			local var_164_11 = 0

			if var_164_11 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				arg_161_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action6_2")
			end

			local var_164_12 = 0

			if var_164_12 < arg_161_1.time_ and arg_161_1.time_ <= var_164_12 + arg_164_0 then
				arg_161_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_164_13 = 0
			local var_164_14 = 0.45

			if var_164_13 < arg_161_1.time_ and arg_161_1.time_ <= var_164_13 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_15 = arg_161_1:FormatText(StoryNameCfg[378].name)

				arg_161_1.leftNameTxt_.text = var_164_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_16 = arg_161_1:GetWordFromCfg(120151039)
				local var_164_17 = arg_161_1:FormatText(var_164_16.content)

				arg_161_1.text_.text = var_164_17

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_18 = 18
				local var_164_19 = utf8.len(var_164_17)
				local var_164_20 = var_164_18 <= 0 and var_164_14 or var_164_14 * (var_164_19 / var_164_18)

				if var_164_20 > 0 and var_164_14 < var_164_20 then
					arg_161_1.talkMaxDuration = var_164_20

					if var_164_20 + var_164_13 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_20 + var_164_13
					end
				end

				arg_161_1.text_.text = var_164_17
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151039", "story_v_out_120151.awb") ~= 0 then
					local var_164_21 = manager.audio:GetVoiceLength("story_v_out_120151", "120151039", "story_v_out_120151.awb") / 1000

					if var_164_21 + var_164_13 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_21 + var_164_13
					end

					if var_164_16.prefab_name ~= "" and arg_161_1.actors_[var_164_16.prefab_name] ~= nil then
						local var_164_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_16.prefab_name].transform, "story_v_out_120151", "120151039", "story_v_out_120151.awb")

						arg_161_1:RecordAudio("120151039", var_164_22)
						arg_161_1:RecordAudio("120151039", var_164_22)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_120151", "120151039", "story_v_out_120151.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_120151", "120151039", "story_v_out_120151.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_23 = math.max(var_164_14, arg_161_1.talkMaxDuration)

			if var_164_13 <= arg_161_1.time_ and arg_161_1.time_ < var_164_13 + var_164_23 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_13) / var_164_23

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_13 + var_164_23 and arg_161_1.time_ < var_164_13 + var_164_23 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play120151040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 120151040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play120151041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1069ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1069ui_story == nil then
				arg_165_1.var_.characterEffect1069ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.2

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1069ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1069ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1069ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1069ui_story.fillRatio = var_168_5
			end

			local var_168_6 = 0
			local var_168_7 = 1.275

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(120151040)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 51
				local var_168_11 = utf8.len(var_168_9)
				local var_168_12 = var_168_10 <= 0 and var_168_7 or var_168_7 * (var_168_11 / var_168_10)

				if var_168_12 > 0 and var_168_7 < var_168_12 then
					arg_165_1.talkMaxDuration = var_168_12

					if var_168_12 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_13 and arg_165_1.time_ < var_168_6 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play120151041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 120151041
		arg_169_1.duration_ = 3.5

		local var_169_0 = {
			zh = 3.5,
			ja = 2.133
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
				arg_169_0:Play120151042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_172_1 = arg_169_1.actors_["1071ui_story"]
			local var_172_2 = 0

			if var_172_2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1071ui_story == nil then
				arg_169_1.var_.characterEffect1071ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_3 = 0.2

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_3 and not isNil(var_172_1) then
				local var_172_4 = (arg_169_1.time_ - var_172_2) / var_172_3

				if arg_169_1.var_.characterEffect1071ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_2 + var_172_3 and arg_169_1.time_ < var_172_2 + var_172_3 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1071ui_story then
				arg_169_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_172_5 = 0
			local var_172_6 = 0.35

			if var_172_5 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_7 = arg_169_1:FormatText(StoryNameCfg[384].name)

				arg_169_1.leftNameTxt_.text = var_172_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(120151041)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_10 = 14
				local var_172_11 = utf8.len(var_172_9)
				local var_172_12 = var_172_10 <= 0 and var_172_6 or var_172_6 * (var_172_11 / var_172_10)

				if var_172_12 > 0 and var_172_6 < var_172_12 then
					arg_169_1.talkMaxDuration = var_172_12

					if var_172_12 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_5
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151041", "story_v_out_120151.awb") ~= 0 then
					local var_172_13 = manager.audio:GetVoiceLength("story_v_out_120151", "120151041", "story_v_out_120151.awb") / 1000

					if var_172_13 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_5
					end

					if var_172_8.prefab_name ~= "" and arg_169_1.actors_[var_172_8.prefab_name] ~= nil then
						local var_172_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_8.prefab_name].transform, "story_v_out_120151", "120151041", "story_v_out_120151.awb")

						arg_169_1:RecordAudio("120151041", var_172_14)
						arg_169_1:RecordAudio("120151041", var_172_14)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_120151", "120151041", "story_v_out_120151.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_120151", "120151041", "story_v_out_120151.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_15 = math.max(var_172_6, arg_169_1.talkMaxDuration)

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_15 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_5) / var_172_15

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_5 + var_172_15 and arg_169_1.time_ < var_172_5 + var_172_15 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play120151042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 120151042
		arg_173_1.duration_ = 9.37

		local var_173_0 = {
			zh = 9.366,
			ja = 6.933
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
				arg_173_0:Play120151043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 1.075

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[384].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:GetWordFromCfg(120151042)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151042", "story_v_out_120151.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_120151", "120151042", "story_v_out_120151.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_out_120151", "120151042", "story_v_out_120151.awb")

						arg_173_1:RecordAudio("120151042", var_176_9)
						arg_173_1:RecordAudio("120151042", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_120151", "120151042", "story_v_out_120151.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_120151", "120151042", "story_v_out_120151.awb")
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
	Play120151043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 120151043
		arg_177_1.duration_ = 7.6

		local var_177_0 = {
			zh = 7.6,
			ja = 6.066
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
				arg_177_0:Play120151044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.975

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[384].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(120151043)
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

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151043", "story_v_out_120151.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_120151", "120151043", "story_v_out_120151.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_120151", "120151043", "story_v_out_120151.awb")

						arg_177_1:RecordAudio("120151043", var_180_9)
						arg_177_1:RecordAudio("120151043", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_120151", "120151043", "story_v_out_120151.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_120151", "120151043", "story_v_out_120151.awb")
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
	Play120151044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 120151044
		arg_181_1.duration_ = 6.9

		local var_181_0 = {
			zh = 2.666,
			ja = 6.9
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
				arg_181_0:Play120151045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10037ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect10037ui_story == nil then
				arg_181_1.var_.characterEffect10037ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect10037ui_story and not isNil(var_184_0) then
					arg_181_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect10037ui_story then
				arg_181_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["1071ui_story"].transform
			local var_184_5 = 0

			if var_184_5 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 then
				arg_181_1.var_.moveOldPos1071ui_story = var_184_4.localPosition
			end

			local var_184_6 = 0.001

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_6 then
				local var_184_7 = (arg_181_1.time_ - var_184_5) / var_184_6
				local var_184_8 = Vector3.New(0, 100, 0)

				var_184_4.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1071ui_story, var_184_8, var_184_7)

				local var_184_9 = manager.ui.mainCamera.transform.position - var_184_4.position

				var_184_4.forward = Vector3.New(var_184_9.x, var_184_9.y, var_184_9.z)

				local var_184_10 = var_184_4.localEulerAngles

				var_184_10.z = 0
				var_184_10.x = 0
				var_184_4.localEulerAngles = var_184_10
			end

			if arg_181_1.time_ >= var_184_5 + var_184_6 and arg_181_1.time_ < var_184_5 + var_184_6 + arg_184_0 then
				var_184_4.localPosition = Vector3.New(0, 100, 0)

				local var_184_11 = manager.ui.mainCamera.transform.position - var_184_4.position

				var_184_4.forward = Vector3.New(var_184_11.x, var_184_11.y, var_184_11.z)

				local var_184_12 = var_184_4.localEulerAngles

				var_184_12.z = 0
				var_184_12.x = 0
				var_184_4.localEulerAngles = var_184_12
			end

			local var_184_13 = arg_181_1.actors_["1069ui_story"].transform
			local var_184_14 = 0

			if var_184_14 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 then
				arg_181_1.var_.moveOldPos1069ui_story = var_184_13.localPosition
			end

			local var_184_15 = 0.001

			if var_184_14 <= arg_181_1.time_ and arg_181_1.time_ < var_184_14 + var_184_15 then
				local var_184_16 = (arg_181_1.time_ - var_184_14) / var_184_15
				local var_184_17 = Vector3.New(0, 100, 0)

				var_184_13.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1069ui_story, var_184_17, var_184_16)

				local var_184_18 = manager.ui.mainCamera.transform.position - var_184_13.position

				var_184_13.forward = Vector3.New(var_184_18.x, var_184_18.y, var_184_18.z)

				local var_184_19 = var_184_13.localEulerAngles

				var_184_19.z = 0
				var_184_19.x = 0
				var_184_13.localEulerAngles = var_184_19
			end

			if arg_181_1.time_ >= var_184_14 + var_184_15 and arg_181_1.time_ < var_184_14 + var_184_15 + arg_184_0 then
				var_184_13.localPosition = Vector3.New(0, 100, 0)

				local var_184_20 = manager.ui.mainCamera.transform.position - var_184_13.position

				var_184_13.forward = Vector3.New(var_184_20.x, var_184_20.y, var_184_20.z)

				local var_184_21 = var_184_13.localEulerAngles

				var_184_21.z = 0
				var_184_21.x = 0
				var_184_13.localEulerAngles = var_184_21
			end

			local var_184_22 = arg_181_1.actors_["10037ui_story"].transform
			local var_184_23 = 0

			if var_184_23 < arg_181_1.time_ and arg_181_1.time_ <= var_184_23 + arg_184_0 then
				arg_181_1.var_.moveOldPos10037ui_story = var_184_22.localPosition
			end

			local var_184_24 = 0.001

			if var_184_23 <= arg_181_1.time_ and arg_181_1.time_ < var_184_23 + var_184_24 then
				local var_184_25 = (arg_181_1.time_ - var_184_23) / var_184_24
				local var_184_26 = Vector3.New(0, -1.13, -6.2)

				var_184_22.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10037ui_story, var_184_26, var_184_25)

				local var_184_27 = manager.ui.mainCamera.transform.position - var_184_22.position

				var_184_22.forward = Vector3.New(var_184_27.x, var_184_27.y, var_184_27.z)

				local var_184_28 = var_184_22.localEulerAngles

				var_184_28.z = 0
				var_184_28.x = 0
				var_184_22.localEulerAngles = var_184_28
			end

			if arg_181_1.time_ >= var_184_23 + var_184_24 and arg_181_1.time_ < var_184_23 + var_184_24 + arg_184_0 then
				var_184_22.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_184_29 = manager.ui.mainCamera.transform.position - var_184_22.position

				var_184_22.forward = Vector3.New(var_184_29.x, var_184_29.y, var_184_29.z)

				local var_184_30 = var_184_22.localEulerAngles

				var_184_30.z = 0
				var_184_30.x = 0
				var_184_22.localEulerAngles = var_184_30
			end

			local var_184_31 = 0

			if var_184_31 < arg_181_1.time_ and arg_181_1.time_ <= var_184_31 + arg_184_0 then
				arg_181_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action2_1")
			end

			local var_184_32 = 0

			if var_184_32 < arg_181_1.time_ and arg_181_1.time_ <= var_184_32 + arg_184_0 then
				arg_181_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_184_33 = 0
			local var_184_34 = 0.225

			if var_184_33 < arg_181_1.time_ and arg_181_1.time_ <= var_184_33 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_35 = arg_181_1:FormatText(StoryNameCfg[383].name)

				arg_181_1.leftNameTxt_.text = var_184_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_36 = arg_181_1:GetWordFromCfg(120151044)
				local var_184_37 = arg_181_1:FormatText(var_184_36.content)

				arg_181_1.text_.text = var_184_37

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_38 = 9
				local var_184_39 = utf8.len(var_184_37)
				local var_184_40 = var_184_38 <= 0 and var_184_34 or var_184_34 * (var_184_39 / var_184_38)

				if var_184_40 > 0 and var_184_34 < var_184_40 then
					arg_181_1.talkMaxDuration = var_184_40

					if var_184_40 + var_184_33 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_40 + var_184_33
					end
				end

				arg_181_1.text_.text = var_184_37
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151044", "story_v_out_120151.awb") ~= 0 then
					local var_184_41 = manager.audio:GetVoiceLength("story_v_out_120151", "120151044", "story_v_out_120151.awb") / 1000

					if var_184_41 + var_184_33 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_41 + var_184_33
					end

					if var_184_36.prefab_name ~= "" and arg_181_1.actors_[var_184_36.prefab_name] ~= nil then
						local var_184_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_36.prefab_name].transform, "story_v_out_120151", "120151044", "story_v_out_120151.awb")

						arg_181_1:RecordAudio("120151044", var_184_42)
						arg_181_1:RecordAudio("120151044", var_184_42)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_120151", "120151044", "story_v_out_120151.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_120151", "120151044", "story_v_out_120151.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_43 = math.max(var_184_34, arg_181_1.talkMaxDuration)

			if var_184_33 <= arg_181_1.time_ and arg_181_1.time_ < var_184_33 + var_184_43 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_33) / var_184_43

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_33 + var_184_43 and arg_181_1.time_ < var_184_33 + var_184_43 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play120151045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 120151045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play120151046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10037ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos10037ui_story = var_188_0.localPosition
			end

			local var_188_2 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(0, 100, 0)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10037ui_story, var_188_4, var_188_3)

				local var_188_5 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_5.x, var_188_5.y, var_188_5.z)

				local var_188_6 = var_188_0.localEulerAngles

				var_188_6.z = 0
				var_188_6.x = 0
				var_188_0.localEulerAngles = var_188_6
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, 100, 0)

				local var_188_7 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_7.x, var_188_7.y, var_188_7.z)

				local var_188_8 = var_188_0.localEulerAngles

				var_188_8.z = 0
				var_188_8.x = 0
				var_188_0.localEulerAngles = var_188_8
			end

			local var_188_9 = 0
			local var_188_10 = 1.175

			if var_188_9 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_11 = arg_185_1:GetWordFromCfg(120151045)
				local var_188_12 = arg_185_1:FormatText(var_188_11.content)

				arg_185_1.text_.text = var_188_12

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 47
				local var_188_14 = utf8.len(var_188_12)
				local var_188_15 = var_188_13 <= 0 and var_188_10 or var_188_10 * (var_188_14 / var_188_13)

				if var_188_15 > 0 and var_188_10 < var_188_15 then
					arg_185_1.talkMaxDuration = var_188_15

					if var_188_15 + var_188_9 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_15 + var_188_9
					end
				end

				arg_185_1.text_.text = var_188_12
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_10, arg_185_1.talkMaxDuration)

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_9) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_9 + var_188_16 and arg_185_1.time_ < var_188_9 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play120151046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 120151046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play120151047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = manager.ui.mainCamera.transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.shakeOldPos = var_192_0.localPosition
			end

			local var_192_2 = 0.6

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / 0.066
				local var_192_4, var_192_5 = math.modf(var_192_3)

				var_192_0.localPosition = Vector3.New(var_192_5 * 0.13, var_192_5 * 0.13, var_192_5 * 0.13) + arg_189_1.var_.shakeOldPos
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = arg_189_1.var_.shakeOldPos
			end

			local var_192_6 = 0

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.allBtn_.enabled = false
			end

			local var_192_7 = 0.6

			if arg_189_1.time_ >= var_192_6 + var_192_7 and arg_189_1.time_ < var_192_6 + var_192_7 + arg_192_0 then
				arg_189_1.allBtn_.enabled = true
			end

			local var_192_8 = 0
			local var_192_9 = 1

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				local var_192_10 = "play"
				local var_192_11 = "effect"

				arg_189_1:AudioAction(var_192_10, var_192_11, "se_story_120_00", "se_story_120_00_sword04", "")
			end

			local var_192_12 = 0

			if var_192_12 < arg_189_1.time_ and arg_189_1.time_ <= var_192_12 + arg_192_0 then
				arg_189_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_192_13 = arg_189_1.actors_["10037ui_story"].transform
			local var_192_14 = 0

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1.var_.moveOldPos10037ui_story = var_192_13.localPosition
			end

			local var_192_15 = 0.001

			if var_192_14 <= arg_189_1.time_ and arg_189_1.time_ < var_192_14 + var_192_15 then
				local var_192_16 = (arg_189_1.time_ - var_192_14) / var_192_15
				local var_192_17 = Vector3.New(0, 100, 0)

				var_192_13.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10037ui_story, var_192_17, var_192_16)

				local var_192_18 = manager.ui.mainCamera.transform.position - var_192_13.position

				var_192_13.forward = Vector3.New(var_192_18.x, var_192_18.y, var_192_18.z)

				local var_192_19 = var_192_13.localEulerAngles

				var_192_19.z = 0
				var_192_19.x = 0
				var_192_13.localEulerAngles = var_192_19
			end

			if arg_189_1.time_ >= var_192_14 + var_192_15 and arg_189_1.time_ < var_192_14 + var_192_15 + arg_192_0 then
				var_192_13.localPosition = Vector3.New(0, 100, 0)

				local var_192_20 = manager.ui.mainCamera.transform.position - var_192_13.position

				var_192_13.forward = Vector3.New(var_192_20.x, var_192_20.y, var_192_20.z)

				local var_192_21 = var_192_13.localEulerAngles

				var_192_21.z = 0
				var_192_21.x = 0
				var_192_13.localEulerAngles = var_192_21
			end

			local var_192_22 = 0
			local var_192_23 = 0.05

			if var_192_22 < arg_189_1.time_ and arg_189_1.time_ <= var_192_22 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_24 = arg_189_1:GetWordFromCfg(120151046)
				local var_192_25 = arg_189_1:FormatText(var_192_24.content)

				arg_189_1.text_.text = var_192_25

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_26 = 2
				local var_192_27 = utf8.len(var_192_25)
				local var_192_28 = var_192_26 <= 0 and var_192_23 or var_192_23 * (var_192_27 / var_192_26)

				if var_192_28 > 0 and var_192_23 < var_192_28 then
					arg_189_1.talkMaxDuration = var_192_28

					if var_192_28 + var_192_22 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_28 + var_192_22
					end
				end

				arg_189_1.text_.text = var_192_25
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_29 = math.max(var_192_23, arg_189_1.talkMaxDuration)

			if var_192_22 <= arg_189_1.time_ and arg_189_1.time_ < var_192_22 + var_192_29 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_22) / var_192_29

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_22 + var_192_29 and arg_189_1.time_ < var_192_22 + var_192_29 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play120151047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 120151047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play120151048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.95

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

				local var_196_2 = arg_193_1:GetWordFromCfg(120151047)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 61
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
	Play120151048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 120151048
		arg_197_1.duration_ = 3.7

		local var_197_0 = {
			zh = 3.7,
			ja = 2.5
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
				arg_197_0:Play120151049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.375

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[384].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(120151048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 15
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151048", "story_v_out_120151.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_120151", "120151048", "story_v_out_120151.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_120151", "120151048", "story_v_out_120151.awb")

						arg_197_1:RecordAudio("120151048", var_200_9)
						arg_197_1:RecordAudio("120151048", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_120151", "120151048", "story_v_out_120151.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_120151", "120151048", "story_v_out_120151.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_10 and arg_197_1.time_ < var_200_0 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play120151049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 120151049
		arg_201_1.duration_ = 1.87

		local var_201_0 = {
			zh = 1.866,
			ja = 1.166
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
				arg_201_0:Play120151050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.15

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[378].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(120151049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 6
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151049", "story_v_out_120151.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_120151", "120151049", "story_v_out_120151.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_120151", "120151049", "story_v_out_120151.awb")

						arg_201_1:RecordAudio("120151049", var_204_9)
						arg_201_1:RecordAudio("120151049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_120151", "120151049", "story_v_out_120151.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_120151", "120151049", "story_v_out_120151.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_10 and arg_201_1.time_ < var_204_0 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play120151050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 120151050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play120151051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.bgs_.ST46.transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPosST46 = var_208_0.localPosition
			end

			local var_208_2 = 3

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(0, 1, 9)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPosST46, var_208_4, var_208_3)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, 1, 9)
			end

			local var_208_5 = 0

			if var_208_5 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1.allBtn_.enabled = false
			end

			local var_208_6 = 3

			if arg_205_1.time_ >= var_208_5 + var_208_6 and arg_205_1.time_ < var_208_5 + var_208_6 + arg_208_0 then
				arg_205_1.allBtn_.enabled = true
			end

			local var_208_7 = manager.ui.mainCamera.transform
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				local var_208_9 = arg_205_1.var_.effectnenglianglianyi1
				local var_208_10
				local var_208_11 = var_208_7

				if not var_208_9 then
					var_208_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_208_11)
					var_208_9.name = "nenglianglianyi1"
					arg_205_1.var_.effectnenglianglianyi1 = var_208_9
				else
					var_208_9.transform:SetParent(var_208_11)
				end

				var_208_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_208_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_208_12 = 0
			local var_208_13 = 1.35

			if var_208_12 < arg_205_1.time_ and arg_205_1.time_ <= var_208_12 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_14 = arg_205_1:GetWordFromCfg(120151050)
				local var_208_15 = arg_205_1:FormatText(var_208_14.content)

				arg_205_1.text_.text = var_208_15

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_16 = 61
				local var_208_17 = utf8.len(var_208_15)
				local var_208_18 = var_208_16 <= 0 and var_208_13 or var_208_13 * (var_208_17 / var_208_16)

				if var_208_18 > 0 and var_208_13 < var_208_18 then
					arg_205_1.talkMaxDuration = var_208_18

					if var_208_18 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_18 + var_208_12
					end
				end

				arg_205_1.text_.text = var_208_15
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_19 = math.max(var_208_13, arg_205_1.talkMaxDuration)

			if var_208_12 <= arg_205_1.time_ and arg_205_1.time_ < var_208_12 + var_208_19 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_12) / var_208_19

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_12 + var_208_19 and arg_205_1.time_ < var_208_12 + var_208_19 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST46",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play120151051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 120151051
		arg_209_1.duration_ = 1

		local var_209_0 = {
			zh = 0.999999999999,
			ja = 1
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
				arg_209_0:Play120151052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.1

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[378].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(120151051)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151051", "story_v_out_120151.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_120151", "120151051", "story_v_out_120151.awb") / 1000

					if var_212_8 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_0
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_out_120151", "120151051", "story_v_out_120151.awb")

						arg_209_1:RecordAudio("120151051", var_212_9)
						arg_209_1:RecordAudio("120151051", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_120151", "120151051", "story_v_out_120151.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_120151", "120151051", "story_v_out_120151.awb")
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
	Play120151052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 120151052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play120151053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.525

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_2 = arg_213_1:GetWordFromCfg(120151052)
				local var_216_3 = arg_213_1:FormatText(var_216_2.content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 21
				local var_216_5 = utf8.len(var_216_3)
				local var_216_6 = var_216_4 <= 0 and var_216_1 or var_216_1 * (var_216_5 / var_216_4)

				if var_216_6 > 0 and var_216_1 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_7 and arg_213_1.time_ < var_216_0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play120151053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 120151053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play120151054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.85

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_2 = arg_217_1:GetWordFromCfg(120151053)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 34
				local var_220_5 = utf8.len(var_220_3)
				local var_220_6 = var_220_4 <= 0 and var_220_1 or var_220_1 * (var_220_5 / var_220_4)

				if var_220_6 > 0 and var_220_1 < var_220_6 then
					arg_217_1.talkMaxDuration = var_220_6

					if var_220_6 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_7 and arg_217_1.time_ < var_220_0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play120151054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 120151054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play120151055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.95

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_2 = arg_221_1:GetWordFromCfg(120151054)
				local var_224_3 = arg_221_1:FormatText(var_224_2.content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 38
				local var_224_5 = utf8.len(var_224_3)
				local var_224_6 = var_224_4 <= 0 and var_224_1 or var_224_1 * (var_224_5 / var_224_4)

				if var_224_6 > 0 and var_224_1 < var_224_6 then
					arg_221_1.talkMaxDuration = var_224_6

					if var_224_6 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_7 and arg_221_1.time_ < var_224_0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play120151055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 120151055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play120151056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 1.45

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_2 = arg_225_1:GetWordFromCfg(120151055)
				local var_228_3 = arg_225_1:FormatText(var_228_2.content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 58
				local var_228_5 = utf8.len(var_228_3)
				local var_228_6 = var_228_4 <= 0 and var_228_1 or var_228_1 * (var_228_5 / var_228_4)

				if var_228_6 > 0 and var_228_1 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_7 and arg_225_1.time_ < var_228_0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play120151056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 120151056
		arg_229_1.duration_ = 6.07

		local var_229_0 = {
			zh = 6.066,
			ja = 5.2
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
				arg_229_0:Play120151057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10037ui_story"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos10037ui_story = var_232_0.localPosition
			end

			local var_232_2 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2
				local var_232_4 = Vector3.New(0, -1.13, -6.2)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10037ui_story, var_232_4, var_232_3)

				local var_232_5 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_5.x, var_232_5.y, var_232_5.z)

				local var_232_6 = var_232_0.localEulerAngles

				var_232_6.z = 0
				var_232_6.x = 0
				var_232_0.localEulerAngles = var_232_6
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_232_7 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_7.x, var_232_7.y, var_232_7.z)

				local var_232_8 = var_232_0.localEulerAngles

				var_232_8.z = 0
				var_232_8.x = 0
				var_232_0.localEulerAngles = var_232_8
			end

			local var_232_9 = 0

			if var_232_9 < arg_229_1.time_ and arg_229_1.time_ <= var_232_9 + arg_232_0 then
				arg_229_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037actionlink/10037action423")
			end

			local var_232_10 = 0

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 then
				arg_229_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_232_11 = arg_229_1.actors_["10037ui_story"]
			local var_232_12 = 0

			if var_232_12 < arg_229_1.time_ and arg_229_1.time_ <= var_232_12 + arg_232_0 and not isNil(var_232_11) and arg_229_1.var_.characterEffect10037ui_story == nil then
				arg_229_1.var_.characterEffect10037ui_story = var_232_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_13 = 0.2

			if var_232_12 <= arg_229_1.time_ and arg_229_1.time_ < var_232_12 + var_232_13 and not isNil(var_232_11) then
				local var_232_14 = (arg_229_1.time_ - var_232_12) / var_232_13

				if arg_229_1.var_.characterEffect10037ui_story and not isNil(var_232_11) then
					arg_229_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_12 + var_232_13 and arg_229_1.time_ < var_232_12 + var_232_13 + arg_232_0 and not isNil(var_232_11) and arg_229_1.var_.characterEffect10037ui_story then
				arg_229_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_232_15 = 0
			local var_232_16 = 0.45

			if var_232_15 < arg_229_1.time_ and arg_229_1.time_ <= var_232_15 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_17 = arg_229_1:FormatText(StoryNameCfg[383].name)

				arg_229_1.leftNameTxt_.text = var_232_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_18 = arg_229_1:GetWordFromCfg(120151056)
				local var_232_19 = arg_229_1:FormatText(var_232_18.content)

				arg_229_1.text_.text = var_232_19

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_20 = 18
				local var_232_21 = utf8.len(var_232_19)
				local var_232_22 = var_232_20 <= 0 and var_232_16 or var_232_16 * (var_232_21 / var_232_20)

				if var_232_22 > 0 and var_232_16 < var_232_22 then
					arg_229_1.talkMaxDuration = var_232_22

					if var_232_22 + var_232_15 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_22 + var_232_15
					end
				end

				arg_229_1.text_.text = var_232_19
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151056", "story_v_out_120151.awb") ~= 0 then
					local var_232_23 = manager.audio:GetVoiceLength("story_v_out_120151", "120151056", "story_v_out_120151.awb") / 1000

					if var_232_23 + var_232_15 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_23 + var_232_15
					end

					if var_232_18.prefab_name ~= "" and arg_229_1.actors_[var_232_18.prefab_name] ~= nil then
						local var_232_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_18.prefab_name].transform, "story_v_out_120151", "120151056", "story_v_out_120151.awb")

						arg_229_1:RecordAudio("120151056", var_232_24)
						arg_229_1:RecordAudio("120151056", var_232_24)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_120151", "120151056", "story_v_out_120151.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_120151", "120151056", "story_v_out_120151.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_25 = math.max(var_232_16, arg_229_1.talkMaxDuration)

			if var_232_15 <= arg_229_1.time_ and arg_229_1.time_ < var_232_15 + var_232_25 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_15) / var_232_25

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_15 + var_232_25 and arg_229_1.time_ < var_232_15 + var_232_25 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play120151057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 120151057
		arg_233_1.duration_ = 8.57

		local var_233_0 = {
			zh = 8.566,
			ja = 7.833
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
				arg_233_0:Play120151058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_236_1 = 0
			local var_236_2 = 0.8

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_3 = arg_233_1:FormatText(StoryNameCfg[383].name)

				arg_233_1.leftNameTxt_.text = var_236_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_4 = arg_233_1:GetWordFromCfg(120151057)
				local var_236_5 = arg_233_1:FormatText(var_236_4.content)

				arg_233_1.text_.text = var_236_5

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_6 = 32
				local var_236_7 = utf8.len(var_236_5)
				local var_236_8 = var_236_6 <= 0 and var_236_2 or var_236_2 * (var_236_7 / var_236_6)

				if var_236_8 > 0 and var_236_2 < var_236_8 then
					arg_233_1.talkMaxDuration = var_236_8

					if var_236_8 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_5
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151057", "story_v_out_120151.awb") ~= 0 then
					local var_236_9 = manager.audio:GetVoiceLength("story_v_out_120151", "120151057", "story_v_out_120151.awb") / 1000

					if var_236_9 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_1
					end

					if var_236_4.prefab_name ~= "" and arg_233_1.actors_[var_236_4.prefab_name] ~= nil then
						local var_236_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_4.prefab_name].transform, "story_v_out_120151", "120151057", "story_v_out_120151.awb")

						arg_233_1:RecordAudio("120151057", var_236_10)
						arg_233_1:RecordAudio("120151057", var_236_10)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_120151", "120151057", "story_v_out_120151.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_120151", "120151057", "story_v_out_120151.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_11 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_11 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_11

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_11 and arg_233_1.time_ < var_236_1 + var_236_11 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play120151058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 120151058
		arg_237_1.duration_ = 11.77

		local var_237_0 = {
			zh = 10.3,
			ja = 11.766
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
				arg_237_0:Play120151059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_240_1 = 0
			local var_240_2 = 0.85

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_3 = arg_237_1:FormatText(StoryNameCfg[383].name)

				arg_237_1.leftNameTxt_.text = var_240_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_4 = arg_237_1:GetWordFromCfg(120151058)
				local var_240_5 = arg_237_1:FormatText(var_240_4.content)

				arg_237_1.text_.text = var_240_5

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_6 = 34
				local var_240_7 = utf8.len(var_240_5)
				local var_240_8 = var_240_6 <= 0 and var_240_2 or var_240_2 * (var_240_7 / var_240_6)

				if var_240_8 > 0 and var_240_2 < var_240_8 then
					arg_237_1.talkMaxDuration = var_240_8

					if var_240_8 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_5
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151058", "story_v_out_120151.awb") ~= 0 then
					local var_240_9 = manager.audio:GetVoiceLength("story_v_out_120151", "120151058", "story_v_out_120151.awb") / 1000

					if var_240_9 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_1
					end

					if var_240_4.prefab_name ~= "" and arg_237_1.actors_[var_240_4.prefab_name] ~= nil then
						local var_240_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_4.prefab_name].transform, "story_v_out_120151", "120151058", "story_v_out_120151.awb")

						arg_237_1:RecordAudio("120151058", var_240_10)
						arg_237_1:RecordAudio("120151058", var_240_10)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_120151", "120151058", "story_v_out_120151.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_120151", "120151058", "story_v_out_120151.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_11 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_11 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_11

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_11 and arg_237_1.time_ < var_240_1 + var_240_11 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play120151059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 120151059
		arg_241_1.duration_ = 7.8

		local var_241_0 = {
			zh = 3.766,
			ja = 7.8
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
				arg_241_0:Play120151060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10037ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos10037ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, 100, 0)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10037ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, 100, 0)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = arg_241_1.actors_["1071ui_story"].transform
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				arg_241_1.var_.moveOldPos1071ui_story = var_244_9.localPosition
			end

			local var_244_11 = 0.001

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_11 then
				local var_244_12 = (arg_241_1.time_ - var_244_10) / var_244_11
				local var_244_13 = Vector3.New(0, -1.05, -6.2)

				var_244_9.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1071ui_story, var_244_13, var_244_12)

				local var_244_14 = manager.ui.mainCamera.transform.position - var_244_9.position

				var_244_9.forward = Vector3.New(var_244_14.x, var_244_14.y, var_244_14.z)

				local var_244_15 = var_244_9.localEulerAngles

				var_244_15.z = 0
				var_244_15.x = 0
				var_244_9.localEulerAngles = var_244_15
			end

			if arg_241_1.time_ >= var_244_10 + var_244_11 and arg_241_1.time_ < var_244_10 + var_244_11 + arg_244_0 then
				var_244_9.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_244_16 = manager.ui.mainCamera.transform.position - var_244_9.position

				var_244_9.forward = Vector3.New(var_244_16.x, var_244_16.y, var_244_16.z)

				local var_244_17 = var_244_9.localEulerAngles

				var_244_17.z = 0
				var_244_17.x = 0
				var_244_9.localEulerAngles = var_244_17
			end

			local var_244_18 = 0

			if var_244_18 < arg_241_1.time_ and arg_241_1.time_ <= var_244_18 + arg_244_0 then
				arg_241_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_244_19 = 0

			if var_244_19 < arg_241_1.time_ and arg_241_1.time_ <= var_244_19 + arg_244_0 then
				arg_241_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_244_20 = arg_241_1.actors_["1071ui_story"]
			local var_244_21 = 0

			if var_244_21 < arg_241_1.time_ and arg_241_1.time_ <= var_244_21 + arg_244_0 and not isNil(var_244_20) and arg_241_1.var_.characterEffect1071ui_story == nil then
				arg_241_1.var_.characterEffect1071ui_story = var_244_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_22 = 0.2

			if var_244_21 <= arg_241_1.time_ and arg_241_1.time_ < var_244_21 + var_244_22 and not isNil(var_244_20) then
				local var_244_23 = (arg_241_1.time_ - var_244_21) / var_244_22

				if arg_241_1.var_.characterEffect1071ui_story and not isNil(var_244_20) then
					arg_241_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_21 + var_244_22 and arg_241_1.time_ < var_244_21 + var_244_22 + arg_244_0 and not isNil(var_244_20) and arg_241_1.var_.characterEffect1071ui_story then
				arg_241_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_244_24 = 0
			local var_244_25 = 0.45

			if var_244_24 < arg_241_1.time_ and arg_241_1.time_ <= var_244_24 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_26 = arg_241_1:FormatText(StoryNameCfg[384].name)

				arg_241_1.leftNameTxt_.text = var_244_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_27 = arg_241_1:GetWordFromCfg(120151059)
				local var_244_28 = arg_241_1:FormatText(var_244_27.content)

				arg_241_1.text_.text = var_244_28

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_29 = 18
				local var_244_30 = utf8.len(var_244_28)
				local var_244_31 = var_244_29 <= 0 and var_244_25 or var_244_25 * (var_244_30 / var_244_29)

				if var_244_31 > 0 and var_244_25 < var_244_31 then
					arg_241_1.talkMaxDuration = var_244_31

					if var_244_31 + var_244_24 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_31 + var_244_24
					end
				end

				arg_241_1.text_.text = var_244_28
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151059", "story_v_out_120151.awb") ~= 0 then
					local var_244_32 = manager.audio:GetVoiceLength("story_v_out_120151", "120151059", "story_v_out_120151.awb") / 1000

					if var_244_32 + var_244_24 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_32 + var_244_24
					end

					if var_244_27.prefab_name ~= "" and arg_241_1.actors_[var_244_27.prefab_name] ~= nil then
						local var_244_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_27.prefab_name].transform, "story_v_out_120151", "120151059", "story_v_out_120151.awb")

						arg_241_1:RecordAudio("120151059", var_244_33)
						arg_241_1:RecordAudio("120151059", var_244_33)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_120151", "120151059", "story_v_out_120151.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_120151", "120151059", "story_v_out_120151.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_34 = math.max(var_244_25, arg_241_1.talkMaxDuration)

			if var_244_24 <= arg_241_1.time_ and arg_241_1.time_ < var_244_24 + var_244_34 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_24) / var_244_34

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_24 + var_244_34 and arg_241_1.time_ < var_244_24 + var_244_34 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play120151060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 120151060
		arg_245_1.duration_ = 5.57

		local var_245_0 = {
			zh = 5.566,
			ja = 5.366
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
				arg_245_0:Play120151061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.55

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[384].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:GetWordFromCfg(120151060)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151060", "story_v_out_120151.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_120151", "120151060", "story_v_out_120151.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_120151", "120151060", "story_v_out_120151.awb")

						arg_245_1:RecordAudio("120151060", var_248_9)
						arg_245_1:RecordAudio("120151060", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_120151", "120151060", "story_v_out_120151.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_120151", "120151060", "story_v_out_120151.awb")
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
	Play120151061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 120151061
		arg_249_1.duration_ = 8.3

		local var_249_0 = {
			zh = 4.466,
			ja = 8.3
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
				arg_249_0:Play120151062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1071ui_story"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos1071ui_story = var_252_0.localPosition
			end

			local var_252_2 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2
				local var_252_4 = Vector3.New(0, 100, 0)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1071ui_story, var_252_4, var_252_3)

				local var_252_5 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_5.x, var_252_5.y, var_252_5.z)

				local var_252_6 = var_252_0.localEulerAngles

				var_252_6.z = 0
				var_252_6.x = 0
				var_252_0.localEulerAngles = var_252_6
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, 100, 0)

				local var_252_7 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_7.x, var_252_7.y, var_252_7.z)

				local var_252_8 = var_252_0.localEulerAngles

				var_252_8.z = 0
				var_252_8.x = 0
				var_252_0.localEulerAngles = var_252_8
			end

			local var_252_9 = arg_249_1.actors_["10037ui_story"].transform
			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 then
				arg_249_1.var_.moveOldPos10037ui_story = var_252_9.localPosition
			end

			local var_252_11 = 0.001

			if var_252_10 <= arg_249_1.time_ and arg_249_1.time_ < var_252_10 + var_252_11 then
				local var_252_12 = (arg_249_1.time_ - var_252_10) / var_252_11
				local var_252_13 = Vector3.New(0, -1.13, -6.2)

				var_252_9.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10037ui_story, var_252_13, var_252_12)

				local var_252_14 = manager.ui.mainCamera.transform.position - var_252_9.position

				var_252_9.forward = Vector3.New(var_252_14.x, var_252_14.y, var_252_14.z)

				local var_252_15 = var_252_9.localEulerAngles

				var_252_15.z = 0
				var_252_15.x = 0
				var_252_9.localEulerAngles = var_252_15
			end

			if arg_249_1.time_ >= var_252_10 + var_252_11 and arg_249_1.time_ < var_252_10 + var_252_11 + arg_252_0 then
				var_252_9.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_252_16 = manager.ui.mainCamera.transform.position - var_252_9.position

				var_252_9.forward = Vector3.New(var_252_16.x, var_252_16.y, var_252_16.z)

				local var_252_17 = var_252_9.localEulerAngles

				var_252_17.z = 0
				var_252_17.x = 0
				var_252_9.localEulerAngles = var_252_17
			end

			local var_252_18 = 0

			if var_252_18 < arg_249_1.time_ and arg_249_1.time_ <= var_252_18 + arg_252_0 then
				arg_249_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037actionlink/10037action432")
			end

			local var_252_19 = 0

			if var_252_19 < arg_249_1.time_ and arg_249_1.time_ <= var_252_19 + arg_252_0 then
				arg_249_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_252_20 = arg_249_1.actors_["10037ui_story"]
			local var_252_21 = 0

			if var_252_21 < arg_249_1.time_ and arg_249_1.time_ <= var_252_21 + arg_252_0 and not isNil(var_252_20) and arg_249_1.var_.characterEffect10037ui_story == nil then
				arg_249_1.var_.characterEffect10037ui_story = var_252_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_22 = 0.2

			if var_252_21 <= arg_249_1.time_ and arg_249_1.time_ < var_252_21 + var_252_22 and not isNil(var_252_20) then
				local var_252_23 = (arg_249_1.time_ - var_252_21) / var_252_22

				if arg_249_1.var_.characterEffect10037ui_story and not isNil(var_252_20) then
					arg_249_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_21 + var_252_22 and arg_249_1.time_ < var_252_21 + var_252_22 + arg_252_0 and not isNil(var_252_20) and arg_249_1.var_.characterEffect10037ui_story then
				arg_249_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_252_24 = 0
			local var_252_25 = 0.4

			if var_252_24 < arg_249_1.time_ and arg_249_1.time_ <= var_252_24 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_26 = arg_249_1:FormatText(StoryNameCfg[383].name)

				arg_249_1.leftNameTxt_.text = var_252_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_27 = arg_249_1:GetWordFromCfg(120151061)
				local var_252_28 = arg_249_1:FormatText(var_252_27.content)

				arg_249_1.text_.text = var_252_28

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_29 = 16
				local var_252_30 = utf8.len(var_252_28)
				local var_252_31 = var_252_29 <= 0 and var_252_25 or var_252_25 * (var_252_30 / var_252_29)

				if var_252_31 > 0 and var_252_25 < var_252_31 then
					arg_249_1.talkMaxDuration = var_252_31

					if var_252_31 + var_252_24 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_31 + var_252_24
					end
				end

				arg_249_1.text_.text = var_252_28
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151061", "story_v_out_120151.awb") ~= 0 then
					local var_252_32 = manager.audio:GetVoiceLength("story_v_out_120151", "120151061", "story_v_out_120151.awb") / 1000

					if var_252_32 + var_252_24 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_32 + var_252_24
					end

					if var_252_27.prefab_name ~= "" and arg_249_1.actors_[var_252_27.prefab_name] ~= nil then
						local var_252_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_27.prefab_name].transform, "story_v_out_120151", "120151061", "story_v_out_120151.awb")

						arg_249_1:RecordAudio("120151061", var_252_33)
						arg_249_1:RecordAudio("120151061", var_252_33)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_120151", "120151061", "story_v_out_120151.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_120151", "120151061", "story_v_out_120151.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_34 = math.max(var_252_25, arg_249_1.talkMaxDuration)

			if var_252_24 <= arg_249_1.time_ and arg_249_1.time_ < var_252_24 + var_252_34 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_24) / var_252_34

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_24 + var_252_34 and arg_249_1.time_ < var_252_24 + var_252_34 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play120151062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 120151062
		arg_253_1.duration_ = 13.1

		local var_253_0 = {
			zh = 11.9,
			ja = 13.1
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
				arg_253_0:Play120151063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_256_1 = 0
			local var_256_2 = 1

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_3 = arg_253_1:FormatText(StoryNameCfg[383].name)

				arg_253_1.leftNameTxt_.text = var_256_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_4 = arg_253_1:GetWordFromCfg(120151062)
				local var_256_5 = arg_253_1:FormatText(var_256_4.content)

				arg_253_1.text_.text = var_256_5

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_6 = 40
				local var_256_7 = utf8.len(var_256_5)
				local var_256_8 = var_256_6 <= 0 and var_256_2 or var_256_2 * (var_256_7 / var_256_6)

				if var_256_8 > 0 and var_256_2 < var_256_8 then
					arg_253_1.talkMaxDuration = var_256_8

					if var_256_8 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_5
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151062", "story_v_out_120151.awb") ~= 0 then
					local var_256_9 = manager.audio:GetVoiceLength("story_v_out_120151", "120151062", "story_v_out_120151.awb") / 1000

					if var_256_9 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_1
					end

					if var_256_4.prefab_name ~= "" and arg_253_1.actors_[var_256_4.prefab_name] ~= nil then
						local var_256_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_4.prefab_name].transform, "story_v_out_120151", "120151062", "story_v_out_120151.awb")

						arg_253_1:RecordAudio("120151062", var_256_10)
						arg_253_1:RecordAudio("120151062", var_256_10)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_120151", "120151062", "story_v_out_120151.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_120151", "120151062", "story_v_out_120151.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_11 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_11 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_11

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_11 and arg_253_1.time_ < var_256_1 + var_256_11 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play120151063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 120151063
		arg_257_1.duration_ = 10.5

		local var_257_0 = {
			zh = 4.433,
			ja = 10.5
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
				arg_257_0:Play120151064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_260_1 = 0
			local var_260_2 = 0.4

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_3 = arg_257_1:FormatText(StoryNameCfg[383].name)

				arg_257_1.leftNameTxt_.text = var_260_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_4 = arg_257_1:GetWordFromCfg(120151063)
				local var_260_5 = arg_257_1:FormatText(var_260_4.content)

				arg_257_1.text_.text = var_260_5

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_6 = 16
				local var_260_7 = utf8.len(var_260_5)
				local var_260_8 = var_260_6 <= 0 and var_260_2 or var_260_2 * (var_260_7 / var_260_6)

				if var_260_8 > 0 and var_260_2 < var_260_8 then
					arg_257_1.talkMaxDuration = var_260_8

					if var_260_8 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_5
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151063", "story_v_out_120151.awb") ~= 0 then
					local var_260_9 = manager.audio:GetVoiceLength("story_v_out_120151", "120151063", "story_v_out_120151.awb") / 1000

					if var_260_9 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_1
					end

					if var_260_4.prefab_name ~= "" and arg_257_1.actors_[var_260_4.prefab_name] ~= nil then
						local var_260_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_4.prefab_name].transform, "story_v_out_120151", "120151063", "story_v_out_120151.awb")

						arg_257_1:RecordAudio("120151063", var_260_10)
						arg_257_1:RecordAudio("120151063", var_260_10)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_120151", "120151063", "story_v_out_120151.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_120151", "120151063", "story_v_out_120151.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_11 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_11 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_11

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_11 and arg_257_1.time_ < var_260_1 + var_260_11 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play120151064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 120151064
		arg_261_1.duration_ = 2.4

		local var_261_0 = {
			zh = 2.333333333332,
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
				arg_261_0:Play120151065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10037ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos10037ui_story = var_264_0.localPosition
			end

			local var_264_2 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2
				local var_264_4 = Vector3.New(0, 100, 0)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10037ui_story, var_264_4, var_264_3)

				local var_264_5 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_5.x, var_264_5.y, var_264_5.z)

				local var_264_6 = var_264_0.localEulerAngles

				var_264_6.z = 0
				var_264_6.x = 0
				var_264_0.localEulerAngles = var_264_6
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0, 100, 0)

				local var_264_7 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_7.x, var_264_7.y, var_264_7.z)

				local var_264_8 = var_264_0.localEulerAngles

				var_264_8.z = 0
				var_264_8.x = 0
				var_264_0.localEulerAngles = var_264_8
			end

			local var_264_9 = arg_261_1.actors_["1069ui_story"].transform
			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1.var_.moveOldPos1069ui_story = var_264_9.localPosition
			end

			local var_264_11 = 0.001

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_11 then
				local var_264_12 = (arg_261_1.time_ - var_264_10) / var_264_11
				local var_264_13 = Vector3.New(0, -1, -6)

				var_264_9.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1069ui_story, var_264_13, var_264_12)

				local var_264_14 = manager.ui.mainCamera.transform.position - var_264_9.position

				var_264_9.forward = Vector3.New(var_264_14.x, var_264_14.y, var_264_14.z)

				local var_264_15 = var_264_9.localEulerAngles

				var_264_15.z = 0
				var_264_15.x = 0
				var_264_9.localEulerAngles = var_264_15
			end

			if arg_261_1.time_ >= var_264_10 + var_264_11 and arg_261_1.time_ < var_264_10 + var_264_11 + arg_264_0 then
				var_264_9.localPosition = Vector3.New(0, -1, -6)

				local var_264_16 = manager.ui.mainCamera.transform.position - var_264_9.position

				var_264_9.forward = Vector3.New(var_264_16.x, var_264_16.y, var_264_16.z)

				local var_264_17 = var_264_9.localEulerAngles

				var_264_17.z = 0
				var_264_17.x = 0
				var_264_9.localEulerAngles = var_264_17
			end

			local var_264_18 = 0

			if var_264_18 < arg_261_1.time_ and arg_261_1.time_ <= var_264_18 + arg_264_0 then
				arg_261_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_264_19 = 0

			if var_264_19 < arg_261_1.time_ and arg_261_1.time_ <= var_264_19 + arg_264_0 then
				arg_261_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_264_20 = arg_261_1.actors_["1069ui_story"]
			local var_264_21 = 0

			if var_264_21 < arg_261_1.time_ and arg_261_1.time_ <= var_264_21 + arg_264_0 and not isNil(var_264_20) and arg_261_1.var_.characterEffect1069ui_story == nil then
				arg_261_1.var_.characterEffect1069ui_story = var_264_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_22 = 0.2

			if var_264_21 <= arg_261_1.time_ and arg_261_1.time_ < var_264_21 + var_264_22 and not isNil(var_264_20) then
				local var_264_23 = (arg_261_1.time_ - var_264_21) / var_264_22

				if arg_261_1.var_.characterEffect1069ui_story and not isNil(var_264_20) then
					arg_261_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_21 + var_264_22 and arg_261_1.time_ < var_264_21 + var_264_22 + arg_264_0 and not isNil(var_264_20) and arg_261_1.var_.characterEffect1069ui_story then
				arg_261_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_264_24 = 0
			local var_264_25 = 0.25

			if var_264_24 < arg_261_1.time_ and arg_261_1.time_ <= var_264_24 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_26 = arg_261_1:FormatText(StoryNameCfg[378].name)

				arg_261_1.leftNameTxt_.text = var_264_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_27 = arg_261_1:GetWordFromCfg(120151064)
				local var_264_28 = arg_261_1:FormatText(var_264_27.content)

				arg_261_1.text_.text = var_264_28

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_29 = 10
				local var_264_30 = utf8.len(var_264_28)
				local var_264_31 = var_264_29 <= 0 and var_264_25 or var_264_25 * (var_264_30 / var_264_29)

				if var_264_31 > 0 and var_264_25 < var_264_31 then
					arg_261_1.talkMaxDuration = var_264_31

					if var_264_31 + var_264_24 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_31 + var_264_24
					end
				end

				arg_261_1.text_.text = var_264_28
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151064", "story_v_out_120151.awb") ~= 0 then
					local var_264_32 = manager.audio:GetVoiceLength("story_v_out_120151", "120151064", "story_v_out_120151.awb") / 1000

					if var_264_32 + var_264_24 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_32 + var_264_24
					end

					if var_264_27.prefab_name ~= "" and arg_261_1.actors_[var_264_27.prefab_name] ~= nil then
						local var_264_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_27.prefab_name].transform, "story_v_out_120151", "120151064", "story_v_out_120151.awb")

						arg_261_1:RecordAudio("120151064", var_264_33)
						arg_261_1:RecordAudio("120151064", var_264_33)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_120151", "120151064", "story_v_out_120151.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_120151", "120151064", "story_v_out_120151.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_34 = math.max(var_264_25, arg_261_1.talkMaxDuration)

			if var_264_24 <= arg_261_1.time_ and arg_261_1.time_ < var_264_24 + var_264_34 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_24) / var_264_34

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_24 + var_264_34 and arg_261_1.time_ < var_264_24 + var_264_34 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play120151065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 120151065
		arg_265_1.duration_ = 5.93

		local var_265_0 = {
			zh = 4.366,
			ja = 5.933
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play120151066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_268_1 = 0
			local var_268_2 = 0.6

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_3 = arg_265_1:FormatText(StoryNameCfg[378].name)

				arg_265_1.leftNameTxt_.text = var_268_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_4 = arg_265_1:GetWordFromCfg(120151065)
				local var_268_5 = arg_265_1:FormatText(var_268_4.content)

				arg_265_1.text_.text = var_268_5

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_6 = 24
				local var_268_7 = utf8.len(var_268_5)
				local var_268_8 = var_268_6 <= 0 and var_268_2 or var_268_2 * (var_268_7 / var_268_6)

				if var_268_8 > 0 and var_268_2 < var_268_8 then
					arg_265_1.talkMaxDuration = var_268_8

					if var_268_8 + var_268_1 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_1
					end
				end

				arg_265_1.text_.text = var_268_5
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151065", "story_v_out_120151.awb") ~= 0 then
					local var_268_9 = manager.audio:GetVoiceLength("story_v_out_120151", "120151065", "story_v_out_120151.awb") / 1000

					if var_268_9 + var_268_1 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_1
					end

					if var_268_4.prefab_name ~= "" and arg_265_1.actors_[var_268_4.prefab_name] ~= nil then
						local var_268_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_4.prefab_name].transform, "story_v_out_120151", "120151065", "story_v_out_120151.awb")

						arg_265_1:RecordAudio("120151065", var_268_10)
						arg_265_1:RecordAudio("120151065", var_268_10)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_120151", "120151065", "story_v_out_120151.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_120151", "120151065", "story_v_out_120151.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_11 = math.max(var_268_2, arg_265_1.talkMaxDuration)

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_11 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_1) / var_268_11

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_1 + var_268_11 and arg_265_1.time_ < var_268_1 + var_268_11 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play120151066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 120151066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play120151067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1069ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1069ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0, 100, 0)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1069ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0, 100, 0)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["10037ui_story"].transform
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 then
				arg_269_1.var_.moveOldPos10037ui_story = var_272_9.localPosition
			end

			local var_272_11 = 0.001

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11
				local var_272_13 = Vector3.New(0, -1.13, -6.2)

				var_272_9.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10037ui_story, var_272_13, var_272_12)

				local var_272_14 = manager.ui.mainCamera.transform.position - var_272_9.position

				var_272_9.forward = Vector3.New(var_272_14.x, var_272_14.y, var_272_14.z)

				local var_272_15 = var_272_9.localEulerAngles

				var_272_15.z = 0
				var_272_15.x = 0
				var_272_9.localEulerAngles = var_272_15
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 then
				var_272_9.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_272_16 = manager.ui.mainCamera.transform.position - var_272_9.position

				var_272_9.forward = Vector3.New(var_272_16.x, var_272_16.y, var_272_16.z)

				local var_272_17 = var_272_9.localEulerAngles

				var_272_17.z = 0
				var_272_17.x = 0
				var_272_9.localEulerAngles = var_272_17
			end

			local var_272_18 = 0

			if var_272_18 < arg_269_1.time_ and arg_269_1.time_ <= var_272_18 + arg_272_0 then
				arg_269_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			local var_272_19 = 0

			if var_272_19 < arg_269_1.time_ and arg_269_1.time_ <= var_272_19 + arg_272_0 then
				arg_269_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_272_20 = arg_269_1.actors_["10037ui_story"]
			local var_272_21 = 0

			if var_272_21 < arg_269_1.time_ and arg_269_1.time_ <= var_272_21 + arg_272_0 and not isNil(var_272_20) and arg_269_1.var_.characterEffect10037ui_story == nil then
				arg_269_1.var_.characterEffect10037ui_story = var_272_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_22 = 0.2

			if var_272_21 <= arg_269_1.time_ and arg_269_1.time_ < var_272_21 + var_272_22 and not isNil(var_272_20) then
				local var_272_23 = (arg_269_1.time_ - var_272_21) / var_272_22

				if arg_269_1.var_.characterEffect10037ui_story and not isNil(var_272_20) then
					arg_269_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_21 + var_272_22 and arg_269_1.time_ < var_272_21 + var_272_22 + arg_272_0 and not isNil(var_272_20) and arg_269_1.var_.characterEffect10037ui_story then
				arg_269_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			local var_272_24 = 0
			local var_272_25 = 0.05

			if var_272_24 < arg_269_1.time_ and arg_269_1.time_ <= var_272_24 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_26 = arg_269_1:FormatText(StoryNameCfg[383].name)

				arg_269_1.leftNameTxt_.text = var_272_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_27 = arg_269_1:GetWordFromCfg(120151066)
				local var_272_28 = arg_269_1:FormatText(var_272_27.content)

				arg_269_1.text_.text = var_272_28

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_29 = 2
				local var_272_30 = utf8.len(var_272_28)
				local var_272_31 = var_272_29 <= 0 and var_272_25 or var_272_25 * (var_272_30 / var_272_29)

				if var_272_31 > 0 and var_272_25 < var_272_31 then
					arg_269_1.talkMaxDuration = var_272_31

					if var_272_31 + var_272_24 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_31 + var_272_24
					end
				end

				arg_269_1.text_.text = var_272_28
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_32 = math.max(var_272_25, arg_269_1.talkMaxDuration)

			if var_272_24 <= arg_269_1.time_ and arg_269_1.time_ < var_272_24 + var_272_32 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_24) / var_272_32

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_24 + var_272_32 and arg_269_1.time_ < var_272_24 + var_272_32 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play120151067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 120151067
		arg_273_1.duration_ = 6.63

		local var_273_0 = {
			zh = 4.266,
			ja = 6.633
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
				arg_273_0:Play120151068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10037ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos10037ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0, -1.13, -6.2)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10037ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = 0

			if var_276_9 < arg_273_1.time_ and arg_273_1.time_ <= var_276_9 + arg_276_0 then
				arg_273_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action2_1")
			end

			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 then
				arg_273_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_276_11 = 0
			local var_276_12 = 0.375

			if var_276_11 < arg_273_1.time_ and arg_273_1.time_ <= var_276_11 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_13 = arg_273_1:FormatText(StoryNameCfg[383].name)

				arg_273_1.leftNameTxt_.text = var_276_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_14 = arg_273_1:GetWordFromCfg(120151067)
				local var_276_15 = arg_273_1:FormatText(var_276_14.content)

				arg_273_1.text_.text = var_276_15

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_16 = 15
				local var_276_17 = utf8.len(var_276_15)
				local var_276_18 = var_276_16 <= 0 and var_276_12 or var_276_12 * (var_276_17 / var_276_16)

				if var_276_18 > 0 and var_276_12 < var_276_18 then
					arg_273_1.talkMaxDuration = var_276_18

					if var_276_18 + var_276_11 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_18 + var_276_11
					end
				end

				arg_273_1.text_.text = var_276_15
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151067", "story_v_out_120151.awb") ~= 0 then
					local var_276_19 = manager.audio:GetVoiceLength("story_v_out_120151", "120151067", "story_v_out_120151.awb") / 1000

					if var_276_19 + var_276_11 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_19 + var_276_11
					end

					if var_276_14.prefab_name ~= "" and arg_273_1.actors_[var_276_14.prefab_name] ~= nil then
						local var_276_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_14.prefab_name].transform, "story_v_out_120151", "120151067", "story_v_out_120151.awb")

						arg_273_1:RecordAudio("120151067", var_276_20)
						arg_273_1:RecordAudio("120151067", var_276_20)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_120151", "120151067", "story_v_out_120151.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_120151", "120151067", "story_v_out_120151.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_21 = math.max(var_276_12, arg_273_1.talkMaxDuration)

			if var_276_11 <= arg_273_1.time_ and arg_273_1.time_ < var_276_11 + var_276_21 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_11) / var_276_21

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_11 + var_276_21 and arg_273_1.time_ < var_276_11 + var_276_21 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play120151068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 120151068
		arg_277_1.duration_ = 6.1

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play120151069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["10037ui_story"].transform
			local var_280_1 = 1.966

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos10037ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(0, 100, 0)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10037ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0, 100, 0)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = 0

			if var_280_9 < arg_277_1.time_ and arg_277_1.time_ <= var_280_9 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_10 = 2

			if var_280_9 <= arg_277_1.time_ and arg_277_1.time_ < var_280_9 + var_280_10 then
				local var_280_11 = (arg_277_1.time_ - var_280_9) / var_280_10
				local var_280_12 = Color.New(0, 0, 0)

				var_280_12.a = Mathf.Lerp(0, 1, var_280_11)
				arg_277_1.mask_.color = var_280_12
			end

			if arg_277_1.time_ >= var_280_9 + var_280_10 and arg_277_1.time_ < var_280_9 + var_280_10 + arg_280_0 then
				local var_280_13 = Color.New(0, 0, 0)

				var_280_13.a = 1
				arg_277_1.mask_.color = var_280_13
			end

			local var_280_14 = 2

			if var_280_14 < arg_277_1.time_ and arg_277_1.time_ <= var_280_14 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_15 = 2

			if var_280_14 <= arg_277_1.time_ and arg_277_1.time_ < var_280_14 + var_280_15 then
				local var_280_16 = (arg_277_1.time_ - var_280_14) / var_280_15
				local var_280_17 = Color.New(0, 0, 0)

				var_280_17.a = Mathf.Lerp(1, 0, var_280_16)
				arg_277_1.mask_.color = var_280_17
			end

			if arg_277_1.time_ >= var_280_14 + var_280_15 and arg_277_1.time_ < var_280_14 + var_280_15 + arg_280_0 then
				local var_280_18 = Color.New(0, 0, 0)
				local var_280_19 = 0

				arg_277_1.mask_.enabled = false
				var_280_18.a = var_280_19
				arg_277_1.mask_.color = var_280_18
			end

			local var_280_20 = 2

			if var_280_20 < arg_277_1.time_ and arg_277_1.time_ <= var_280_20 + arg_280_0 then
				arg_277_1.fswbg_:SetActive(true)
				arg_277_1.dialog_:SetActive(false)

				arg_277_1.fswtw_.percent = 0

				local var_280_21 = arg_277_1:GetWordFromCfg(120151068)
				local var_280_22 = arg_277_1:FormatText(var_280_21.content)

				arg_277_1.fswt_.text = var_280_22

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.fswt_)

				arg_277_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_277_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_277_1.fswtw_:SetDirty()

				arg_277_1.typewritterCharCountI18N = 0

				SetActive(arg_277_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_277_1:ShowNextGo(false)
			end

			local var_280_23 = 2.5

			if var_280_23 < arg_277_1.time_ and arg_277_1.time_ <= var_280_23 + arg_280_0 then
				arg_277_1.var_.oldValueTypewriter = arg_277_1.fswtw_.percent

				SetActive(arg_277_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_277_1:ShowNextGo(false)
			end

			local var_280_24 = 40
			local var_280_25 = 2.66666666666667
			local var_280_26 = arg_277_1:GetWordFromCfg(120151068)
			local var_280_27 = arg_277_1:FormatText(var_280_26.content)
			local var_280_28, var_280_29 = arg_277_1:GetPercentByPara(var_280_27, 1)

			if var_280_23 < arg_277_1.time_ and arg_277_1.time_ <= var_280_23 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0

				local var_280_30 = var_280_24 <= 0 and var_280_25 or var_280_25 * ((var_280_29 - arg_277_1.typewritterCharCountI18N) / var_280_24)

				if var_280_30 > 0 and var_280_25 < var_280_30 then
					arg_277_1.talkMaxDuration = var_280_30

					if var_280_30 + var_280_23 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_30 + var_280_23
					end
				end
			end

			local var_280_31 = 2.66666666666667
			local var_280_32 = math.max(var_280_31, arg_277_1.talkMaxDuration)

			if var_280_23 <= arg_277_1.time_ and arg_277_1.time_ < var_280_23 + var_280_32 then
				local var_280_33 = (arg_277_1.time_ - var_280_23) / var_280_32

				arg_277_1.fswtw_.percent = Mathf.Lerp(arg_277_1.var_.oldValueTypewriter, var_280_28, var_280_33)
				arg_277_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_277_1.fswtw_:SetDirty()
			end

			if arg_277_1.time_ >= var_280_23 + var_280_32 and arg_277_1.time_ < var_280_23 + var_280_32 + arg_280_0 then
				arg_277_1.fswtw_.percent = var_280_28

				arg_277_1.fswtw_:SetDirty()
				arg_277_1:ShowNextGo(true)

				arg_277_1.typewritterCharCountI18N = var_280_29
			end

			local var_280_34 = 2

			if var_280_34 < arg_277_1.time_ and arg_277_1.time_ <= var_280_34 + arg_280_0 then
				local var_280_35 = arg_277_1.fswbg_.transform:Find("textbox/adapt/content") or arg_277_1.fswbg_.transform:Find("textbox/content")
				local var_280_36 = arg_277_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_280_37 = var_280_35:GetComponent("Text")
				local var_280_38 = var_280_35:GetComponent("RectTransform")

				var_280_37.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_280_38.offsetMin = Vector2.New(0, 0)
				var_280_38.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play120151069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 120151069
		arg_281_1.duration_ = 3.27

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play120151070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.fswbg_:SetActive(true)
				arg_281_1.dialog_:SetActive(false)

				arg_281_1.fswtw_.percent = 0

				local var_284_1 = arg_281_1:GetWordFromCfg(120151069)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.fswt_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.fswt_)

				arg_281_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_281_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_281_1.fswtw_:SetDirty()

				arg_281_1.typewritterCharCountI18N = 0

				SetActive(arg_281_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_281_1:ShowNextGo(false)
			end

			local var_284_3 = 0.0166666666666667

			if var_284_3 < arg_281_1.time_ and arg_281_1.time_ <= var_284_3 + arg_284_0 then
				arg_281_1.var_.oldValueTypewriter = arg_281_1.fswtw_.percent

				SetActive(arg_281_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_281_1:ShowNextGo(false)
			end

			local var_284_4 = 41
			local var_284_5 = 2.73333333333333
			local var_284_6 = arg_281_1:GetWordFromCfg(120151069)
			local var_284_7 = arg_281_1:FormatText(var_284_6.content)
			local var_284_8, var_284_9 = arg_281_1:GetPercentByPara(var_284_7, 1)

			if var_284_3 < arg_281_1.time_ and arg_281_1.time_ <= var_284_3 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				local var_284_10 = var_284_4 <= 0 and var_284_5 or var_284_5 * ((var_284_9 - arg_281_1.typewritterCharCountI18N) / var_284_4)

				if var_284_10 > 0 and var_284_5 < var_284_10 then
					arg_281_1.talkMaxDuration = var_284_10

					if var_284_10 + var_284_3 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_3
					end
				end
			end

			local var_284_11 = 2.73333333333333
			local var_284_12 = math.max(var_284_11, arg_281_1.talkMaxDuration)

			if var_284_3 <= arg_281_1.time_ and arg_281_1.time_ < var_284_3 + var_284_12 then
				local var_284_13 = (arg_281_1.time_ - var_284_3) / var_284_12

				arg_281_1.fswtw_.percent = Mathf.Lerp(arg_281_1.var_.oldValueTypewriter, var_284_8, var_284_13)
				arg_281_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_281_1.fswtw_:SetDirty()
			end

			if arg_281_1.time_ >= var_284_3 + var_284_12 and arg_281_1.time_ < var_284_3 + var_284_12 + arg_284_0 then
				arg_281_1.fswtw_.percent = var_284_8

				arg_281_1.fswtw_:SetDirty()
				arg_281_1:ShowNextGo(true)

				arg_281_1.typewritterCharCountI18N = var_284_9
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play120151070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 120151070
		arg_285_1.duration_ = 4.47

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play120151071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 2

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.fswbg_:SetActive(false)
				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_285_1:ShowNextGo(false)
			end

			local var_288_1 = arg_285_1.actors_["1071ui_story"].transform
			local var_288_2 = 2

			if var_288_2 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				arg_285_1.var_.moveOldPos1071ui_story = var_288_1.localPosition
			end

			local var_288_3 = 0.001

			if var_288_2 <= arg_285_1.time_ and arg_285_1.time_ < var_288_2 + var_288_3 then
				local var_288_4 = (arg_285_1.time_ - var_288_2) / var_288_3
				local var_288_5 = Vector3.New(0.7, -1.05, -6.2)

				var_288_1.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1071ui_story, var_288_5, var_288_4)

				local var_288_6 = manager.ui.mainCamera.transform.position - var_288_1.position

				var_288_1.forward = Vector3.New(var_288_6.x, var_288_6.y, var_288_6.z)

				local var_288_7 = var_288_1.localEulerAngles

				var_288_7.z = 0
				var_288_7.x = 0
				var_288_1.localEulerAngles = var_288_7
			end

			if arg_285_1.time_ >= var_288_2 + var_288_3 and arg_285_1.time_ < var_288_2 + var_288_3 + arg_288_0 then
				var_288_1.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_288_8 = manager.ui.mainCamera.transform.position - var_288_1.position

				var_288_1.forward = Vector3.New(var_288_8.x, var_288_8.y, var_288_8.z)

				local var_288_9 = var_288_1.localEulerAngles

				var_288_9.z = 0
				var_288_9.x = 0
				var_288_1.localEulerAngles = var_288_9
			end

			local var_288_10 = arg_285_1.actors_["1071ui_story"]
			local var_288_11 = 2

			if var_288_11 < arg_285_1.time_ and arg_285_1.time_ <= var_288_11 + arg_288_0 and not isNil(var_288_10) and arg_285_1.var_.characterEffect1071ui_story == nil then
				arg_285_1.var_.characterEffect1071ui_story = var_288_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_12 = 0.0166666666666667

			if var_288_11 <= arg_285_1.time_ and arg_285_1.time_ < var_288_11 + var_288_12 and not isNil(var_288_10) then
				local var_288_13 = (arg_285_1.time_ - var_288_11) / var_288_12

				if arg_285_1.var_.characterEffect1071ui_story and not isNil(var_288_10) then
					local var_288_14 = Mathf.Lerp(0, 0.5, var_288_13)

					arg_285_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1071ui_story.fillRatio = var_288_14
				end
			end

			if arg_285_1.time_ >= var_288_11 + var_288_12 and arg_285_1.time_ < var_288_11 + var_288_12 + arg_288_0 and not isNil(var_288_10) and arg_285_1.var_.characterEffect1071ui_story then
				local var_288_15 = 0.5

				arg_285_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1071ui_story.fillRatio = var_288_15
			end

			local var_288_16 = arg_285_1.actors_["1069ui_story"].transform
			local var_288_17 = 2

			if var_288_17 < arg_285_1.time_ and arg_285_1.time_ <= var_288_17 + arg_288_0 then
				arg_285_1.var_.moveOldPos1069ui_story = var_288_16.localPosition
			end

			local var_288_18 = 0.001

			if var_288_17 <= arg_285_1.time_ and arg_285_1.time_ < var_288_17 + var_288_18 then
				local var_288_19 = (arg_285_1.time_ - var_288_17) / var_288_18
				local var_288_20 = Vector3.New(-0.7, -1, -6)

				var_288_16.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1069ui_story, var_288_20, var_288_19)

				local var_288_21 = manager.ui.mainCamera.transform.position - var_288_16.position

				var_288_16.forward = Vector3.New(var_288_21.x, var_288_21.y, var_288_21.z)

				local var_288_22 = var_288_16.localEulerAngles

				var_288_22.z = 0
				var_288_22.x = 0
				var_288_16.localEulerAngles = var_288_22
			end

			if arg_285_1.time_ >= var_288_17 + var_288_18 and arg_285_1.time_ < var_288_17 + var_288_18 + arg_288_0 then
				var_288_16.localPosition = Vector3.New(-0.7, -1, -6)

				local var_288_23 = manager.ui.mainCamera.transform.position - var_288_16.position

				var_288_16.forward = Vector3.New(var_288_23.x, var_288_23.y, var_288_23.z)

				local var_288_24 = var_288_16.localEulerAngles

				var_288_24.z = 0
				var_288_24.x = 0
				var_288_16.localEulerAngles = var_288_24
			end

			local var_288_25 = 2

			if var_288_25 < arg_285_1.time_ and arg_285_1.time_ <= var_288_25 + arg_288_0 then
				arg_285_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_288_26 = 2

			if var_288_26 < arg_285_1.time_ and arg_285_1.time_ <= var_288_26 + arg_288_0 then
				arg_285_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_288_27 = arg_285_1.actors_["1069ui_story"]
			local var_288_28 = 2

			if var_288_28 < arg_285_1.time_ and arg_285_1.time_ <= var_288_28 + arg_288_0 and not isNil(var_288_27) and arg_285_1.var_.characterEffect1069ui_story == nil then
				arg_285_1.var_.characterEffect1069ui_story = var_288_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_29 = 0.2

			if var_288_28 <= arg_285_1.time_ and arg_285_1.time_ < var_288_28 + var_288_29 and not isNil(var_288_27) then
				local var_288_30 = (arg_285_1.time_ - var_288_28) / var_288_29

				if arg_285_1.var_.characterEffect1069ui_story and not isNil(var_288_27) then
					arg_285_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_28 + var_288_29 and arg_285_1.time_ < var_288_28 + var_288_29 + arg_288_0 and not isNil(var_288_27) and arg_285_1.var_.characterEffect1069ui_story then
				arg_285_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_288_31 = 1.96666666666667

			if var_288_31 < arg_285_1.time_ and arg_285_1.time_ <= var_288_31 + arg_288_0 then
				arg_285_1.fswbg_:SetActive(false)
				arg_285_1.dialog_:SetActive(false)
				SetActive(arg_285_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_285_1:ShowNextGo(false)
			end

			local var_288_32 = 2

			if var_288_32 < arg_285_1.time_ and arg_285_1.time_ <= var_288_32 + arg_288_0 then
				arg_285_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_288_33 = 0

			if var_288_33 < arg_285_1.time_ and arg_285_1.time_ <= var_288_33 + arg_288_0 then
				arg_285_1.mask_.enabled = true
				arg_285_1.mask_.raycastTarget = true

				arg_285_1:SetGaussion(false)
			end

			local var_288_34 = 2

			if var_288_33 <= arg_285_1.time_ and arg_285_1.time_ < var_288_33 + var_288_34 then
				local var_288_35 = (arg_285_1.time_ - var_288_33) / var_288_34
				local var_288_36 = Color.New(0, 0, 0)

				var_288_36.a = Mathf.Lerp(0, 1, var_288_35)
				arg_285_1.mask_.color = var_288_36
			end

			if arg_285_1.time_ >= var_288_33 + var_288_34 and arg_285_1.time_ < var_288_33 + var_288_34 + arg_288_0 then
				local var_288_37 = Color.New(0, 0, 0)

				var_288_37.a = 1
				arg_285_1.mask_.color = var_288_37
			end

			local var_288_38 = 2

			if var_288_38 < arg_285_1.time_ and arg_285_1.time_ <= var_288_38 + arg_288_0 then
				arg_285_1.mask_.enabled = true
				arg_285_1.mask_.raycastTarget = true

				arg_285_1:SetGaussion(false)
			end

			local var_288_39 = 1

			if var_288_38 <= arg_285_1.time_ and arg_285_1.time_ < var_288_38 + var_288_39 then
				local var_288_40 = (arg_285_1.time_ - var_288_38) / var_288_39
				local var_288_41 = Color.New(0, 0, 0)

				var_288_41.a = Mathf.Lerp(1, 0, var_288_40)
				arg_285_1.mask_.color = var_288_41
			end

			if arg_285_1.time_ >= var_288_38 + var_288_39 and arg_285_1.time_ < var_288_38 + var_288_39 + arg_288_0 then
				local var_288_42 = Color.New(0, 0, 0)
				local var_288_43 = 0

				arg_285_1.mask_.enabled = false
				var_288_42.a = var_288_43
				arg_285_1.mask_.color = var_288_42
			end

			local var_288_44 = 2
			local var_288_45 = 0.125

			if var_288_44 < arg_285_1.time_ and arg_285_1.time_ <= var_288_44 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_46 = arg_285_1:FormatText(StoryNameCfg[378].name)

				arg_285_1.leftNameTxt_.text = var_288_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_47 = arg_285_1:GetWordFromCfg(120151070)
				local var_288_48 = arg_285_1:FormatText(var_288_47.content)

				arg_285_1.text_.text = var_288_48

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_49 = 5
				local var_288_50 = utf8.len(var_288_48)
				local var_288_51 = var_288_49 <= 0 and var_288_45 or var_288_45 * (var_288_50 / var_288_49)

				if var_288_51 > 0 and var_288_45 < var_288_51 then
					arg_285_1.talkMaxDuration = var_288_51

					if var_288_51 + var_288_44 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_51 + var_288_44
					end
				end

				arg_285_1.text_.text = var_288_48
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151070", "story_v_out_120151.awb") ~= 0 then
					local var_288_52 = manager.audio:GetVoiceLength("story_v_out_120151", "120151070", "story_v_out_120151.awb") / 1000

					if var_288_52 + var_288_44 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_52 + var_288_44
					end

					if var_288_47.prefab_name ~= "" and arg_285_1.actors_[var_288_47.prefab_name] ~= nil then
						local var_288_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_47.prefab_name].transform, "story_v_out_120151", "120151070", "story_v_out_120151.awb")

						arg_285_1:RecordAudio("120151070", var_288_53)
						arg_285_1:RecordAudio("120151070", var_288_53)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_120151", "120151070", "story_v_out_120151.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_120151", "120151070", "story_v_out_120151.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_54 = math.max(var_288_45, arg_285_1.talkMaxDuration)

			if var_288_44 <= arg_285_1.time_ and arg_285_1.time_ < var_288_44 + var_288_54 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_44) / var_288_54

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_44 + var_288_54 and arg_285_1.time_ < var_288_44 + var_288_54 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play120151071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 120151071
		arg_289_1.duration_ = 5

		local var_289_0 = {
			zh = 2.4,
			ja = 5
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
				arg_289_0:Play120151072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1071ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1071ui_story == nil then
				arg_289_1.var_.characterEffect1071ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.2

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1071ui_story and not isNil(var_292_0) then
					arg_289_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1071ui_story then
				arg_289_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_292_4 = arg_289_1.actors_["1069ui_story"]
			local var_292_5 = 0

			if var_292_5 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 and not isNil(var_292_4) and arg_289_1.var_.characterEffect1069ui_story == nil then
				arg_289_1.var_.characterEffect1069ui_story = var_292_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_6 = 0.2

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_6 and not isNil(var_292_4) then
				local var_292_7 = (arg_289_1.time_ - var_292_5) / var_292_6

				if arg_289_1.var_.characterEffect1069ui_story and not isNil(var_292_4) then
					local var_292_8 = Mathf.Lerp(0, 0.5, var_292_7)

					arg_289_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1069ui_story.fillRatio = var_292_8
				end
			end

			if arg_289_1.time_ >= var_292_5 + var_292_6 and arg_289_1.time_ < var_292_5 + var_292_6 + arg_292_0 and not isNil(var_292_4) and arg_289_1.var_.characterEffect1069ui_story then
				local var_292_9 = 0.5

				arg_289_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1069ui_story.fillRatio = var_292_9
			end

			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_292_11 = 0
			local var_292_12 = 0.35

			if var_292_11 < arg_289_1.time_ and arg_289_1.time_ <= var_292_11 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_13 = arg_289_1:FormatText(StoryNameCfg[384].name)

				arg_289_1.leftNameTxt_.text = var_292_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_14 = arg_289_1:GetWordFromCfg(120151071)
				local var_292_15 = arg_289_1:FormatText(var_292_14.content)

				arg_289_1.text_.text = var_292_15

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_16 = 14
				local var_292_17 = utf8.len(var_292_15)
				local var_292_18 = var_292_16 <= 0 and var_292_12 or var_292_12 * (var_292_17 / var_292_16)

				if var_292_18 > 0 and var_292_12 < var_292_18 then
					arg_289_1.talkMaxDuration = var_292_18

					if var_292_18 + var_292_11 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_18 + var_292_11
					end
				end

				arg_289_1.text_.text = var_292_15
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151071", "story_v_out_120151.awb") ~= 0 then
					local var_292_19 = manager.audio:GetVoiceLength("story_v_out_120151", "120151071", "story_v_out_120151.awb") / 1000

					if var_292_19 + var_292_11 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_19 + var_292_11
					end

					if var_292_14.prefab_name ~= "" and arg_289_1.actors_[var_292_14.prefab_name] ~= nil then
						local var_292_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_14.prefab_name].transform, "story_v_out_120151", "120151071", "story_v_out_120151.awb")

						arg_289_1:RecordAudio("120151071", var_292_20)
						arg_289_1:RecordAudio("120151071", var_292_20)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_120151", "120151071", "story_v_out_120151.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_120151", "120151071", "story_v_out_120151.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_21 = math.max(var_292_12, arg_289_1.talkMaxDuration)

			if var_292_11 <= arg_289_1.time_ and arg_289_1.time_ < var_292_11 + var_292_21 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_11) / var_292_21

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_11 + var_292_21 and arg_289_1.time_ < var_292_11 + var_292_21 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play120151072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 120151072
		arg_293_1.duration_ = 4.53

		local var_293_0 = {
			zh = 4.533,
			ja = 3.366
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
				arg_293_0:Play120151073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_296_1 = 0
			local var_296_2 = 0.5

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_3 = arg_293_1:FormatText(StoryNameCfg[384].name)

				arg_293_1.leftNameTxt_.text = var_296_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_4 = arg_293_1:GetWordFromCfg(120151072)
				local var_296_5 = arg_293_1:FormatText(var_296_4.content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_6 = 20
				local var_296_7 = utf8.len(var_296_5)
				local var_296_8 = var_296_6 <= 0 and var_296_2 or var_296_2 * (var_296_7 / var_296_6)

				if var_296_8 > 0 and var_296_2 < var_296_8 then
					arg_293_1.talkMaxDuration = var_296_8

					if var_296_8 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151072", "story_v_out_120151.awb") ~= 0 then
					local var_296_9 = manager.audio:GetVoiceLength("story_v_out_120151", "120151072", "story_v_out_120151.awb") / 1000

					if var_296_9 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_9 + var_296_1
					end

					if var_296_4.prefab_name ~= "" and arg_293_1.actors_[var_296_4.prefab_name] ~= nil then
						local var_296_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_4.prefab_name].transform, "story_v_out_120151", "120151072", "story_v_out_120151.awb")

						arg_293_1:RecordAudio("120151072", var_296_10)
						arg_293_1:RecordAudio("120151072", var_296_10)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_120151", "120151072", "story_v_out_120151.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_120151", "120151072", "story_v_out_120151.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_11 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_11 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_11

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_11 and arg_293_1.time_ < var_296_1 + var_296_11 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play120151073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 120151073
		arg_297_1.duration_ = 2.53

		local var_297_0 = {
			zh = 1.999999999999,
			ja = 2.533
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
				arg_297_0:Play120151074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_300_1 = arg_297_1.actors_["1071ui_story"]
			local var_300_2 = 0

			if var_300_2 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1071ui_story == nil then
				arg_297_1.var_.characterEffect1071ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_3 = 0.2

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_3 and not isNil(var_300_1) then
				local var_300_4 = (arg_297_1.time_ - var_300_2) / var_300_3

				if arg_297_1.var_.characterEffect1071ui_story and not isNil(var_300_1) then
					local var_300_5 = Mathf.Lerp(0, 0.5, var_300_4)

					arg_297_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1071ui_story.fillRatio = var_300_5
				end
			end

			if arg_297_1.time_ >= var_300_2 + var_300_3 and arg_297_1.time_ < var_300_2 + var_300_3 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1071ui_story then
				local var_300_6 = 0.5

				arg_297_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1071ui_story.fillRatio = var_300_6
			end

			local var_300_7 = arg_297_1.actors_["1069ui_story"]
			local var_300_8 = 0

			if var_300_8 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 and not isNil(var_300_7) and arg_297_1.var_.characterEffect1069ui_story == nil then
				arg_297_1.var_.characterEffect1069ui_story = var_300_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_9 = 0.2

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_9 and not isNil(var_300_7) then
				local var_300_10 = (arg_297_1.time_ - var_300_8) / var_300_9

				if arg_297_1.var_.characterEffect1069ui_story and not isNil(var_300_7) then
					arg_297_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_8 + var_300_9 and arg_297_1.time_ < var_300_8 + var_300_9 + arg_300_0 and not isNil(var_300_7) and arg_297_1.var_.characterEffect1069ui_story then
				arg_297_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_300_11 = 0
			local var_300_12 = 0.15

			if var_300_11 < arg_297_1.time_ and arg_297_1.time_ <= var_300_11 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_13 = arg_297_1:FormatText(StoryNameCfg[378].name)

				arg_297_1.leftNameTxt_.text = var_300_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_14 = arg_297_1:GetWordFromCfg(120151073)
				local var_300_15 = arg_297_1:FormatText(var_300_14.content)

				arg_297_1.text_.text = var_300_15

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_16 = 6
				local var_300_17 = utf8.len(var_300_15)
				local var_300_18 = var_300_16 <= 0 and var_300_12 or var_300_12 * (var_300_17 / var_300_16)

				if var_300_18 > 0 and var_300_12 < var_300_18 then
					arg_297_1.talkMaxDuration = var_300_18

					if var_300_18 + var_300_11 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_18 + var_300_11
					end
				end

				arg_297_1.text_.text = var_300_15
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151073", "story_v_out_120151.awb") ~= 0 then
					local var_300_19 = manager.audio:GetVoiceLength("story_v_out_120151", "120151073", "story_v_out_120151.awb") / 1000

					if var_300_19 + var_300_11 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_19 + var_300_11
					end

					if var_300_14.prefab_name ~= "" and arg_297_1.actors_[var_300_14.prefab_name] ~= nil then
						local var_300_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_14.prefab_name].transform, "story_v_out_120151", "120151073", "story_v_out_120151.awb")

						arg_297_1:RecordAudio("120151073", var_300_20)
						arg_297_1:RecordAudio("120151073", var_300_20)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_120151", "120151073", "story_v_out_120151.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_120151", "120151073", "story_v_out_120151.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_21 = math.max(var_300_12, arg_297_1.talkMaxDuration)

			if var_300_11 <= arg_297_1.time_ and arg_297_1.time_ < var_300_11 + var_300_21 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_11) / var_300_21

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_11 + var_300_21 and arg_297_1.time_ < var_300_11 + var_300_21 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play120151074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 120151074
		arg_301_1.duration_ = 3.87

		local var_301_0 = {
			zh = 3.866,
			ja = 3.133
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
				arg_301_0:Play120151075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action452")
			end

			local var_304_1 = arg_301_1.actors_["1071ui_story"]
			local var_304_2 = 0

			if var_304_2 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1071ui_story == nil then
				arg_301_1.var_.characterEffect1071ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_3 = 0.2

			if var_304_2 <= arg_301_1.time_ and arg_301_1.time_ < var_304_2 + var_304_3 and not isNil(var_304_1) then
				local var_304_4 = (arg_301_1.time_ - var_304_2) / var_304_3

				if arg_301_1.var_.characterEffect1071ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_2 + var_304_3 and arg_301_1.time_ < var_304_2 + var_304_3 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1071ui_story then
				arg_301_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_304_5 = arg_301_1.actors_["1069ui_story"]
			local var_304_6 = 0

			if var_304_6 < arg_301_1.time_ and arg_301_1.time_ <= var_304_6 + arg_304_0 and not isNil(var_304_5) and arg_301_1.var_.characterEffect1069ui_story == nil then
				arg_301_1.var_.characterEffect1069ui_story = var_304_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_7 = 0.2

			if var_304_6 <= arg_301_1.time_ and arg_301_1.time_ < var_304_6 + var_304_7 and not isNil(var_304_5) then
				local var_304_8 = (arg_301_1.time_ - var_304_6) / var_304_7

				if arg_301_1.var_.characterEffect1069ui_story and not isNil(var_304_5) then
					local var_304_9 = Mathf.Lerp(0, 0.5, var_304_8)

					arg_301_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1069ui_story.fillRatio = var_304_9
				end
			end

			if arg_301_1.time_ >= var_304_6 + var_304_7 and arg_301_1.time_ < var_304_6 + var_304_7 + arg_304_0 and not isNil(var_304_5) and arg_301_1.var_.characterEffect1069ui_story then
				local var_304_10 = 0.5

				arg_301_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1069ui_story.fillRatio = var_304_10
			end

			local var_304_11 = 0
			local var_304_12 = 0.35

			if var_304_11 < arg_301_1.time_ and arg_301_1.time_ <= var_304_11 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_13 = arg_301_1:FormatText(StoryNameCfg[384].name)

				arg_301_1.leftNameTxt_.text = var_304_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_14 = arg_301_1:GetWordFromCfg(120151074)
				local var_304_15 = arg_301_1:FormatText(var_304_14.content)

				arg_301_1.text_.text = var_304_15

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_16 = 14
				local var_304_17 = utf8.len(var_304_15)
				local var_304_18 = var_304_16 <= 0 and var_304_12 or var_304_12 * (var_304_17 / var_304_16)

				if var_304_18 > 0 and var_304_12 < var_304_18 then
					arg_301_1.talkMaxDuration = var_304_18

					if var_304_18 + var_304_11 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_18 + var_304_11
					end
				end

				arg_301_1.text_.text = var_304_15
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151074", "story_v_out_120151.awb") ~= 0 then
					local var_304_19 = manager.audio:GetVoiceLength("story_v_out_120151", "120151074", "story_v_out_120151.awb") / 1000

					if var_304_19 + var_304_11 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_19 + var_304_11
					end

					if var_304_14.prefab_name ~= "" and arg_301_1.actors_[var_304_14.prefab_name] ~= nil then
						local var_304_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_14.prefab_name].transform, "story_v_out_120151", "120151074", "story_v_out_120151.awb")

						arg_301_1:RecordAudio("120151074", var_304_20)
						arg_301_1:RecordAudio("120151074", var_304_20)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_120151", "120151074", "story_v_out_120151.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_120151", "120151074", "story_v_out_120151.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_21 = math.max(var_304_12, arg_301_1.talkMaxDuration)

			if var_304_11 <= arg_301_1.time_ and arg_301_1.time_ < var_304_11 + var_304_21 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_11) / var_304_21

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_11 + var_304_21 and arg_301_1.time_ < var_304_11 + var_304_21 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play120151075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 120151075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play120151076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1071ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1071ui_story == nil then
				arg_305_1.var_.characterEffect1071ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.2

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1071ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1071ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1071ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1071ui_story.fillRatio = var_308_5
			end

			local var_308_6 = 0
			local var_308_7 = 0.475

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_8 = arg_305_1:GetWordFromCfg(120151075)
				local var_308_9 = arg_305_1:FormatText(var_308_8.content)

				arg_305_1.text_.text = var_308_9

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_10 = 19
				local var_308_11 = utf8.len(var_308_9)
				local var_308_12 = var_308_10 <= 0 and var_308_7 or var_308_7 * (var_308_11 / var_308_10)

				if var_308_12 > 0 and var_308_7 < var_308_12 then
					arg_305_1.talkMaxDuration = var_308_12

					if var_308_12 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_12 + var_308_6
					end
				end

				arg_305_1.text_.text = var_308_9
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_13 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_13 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_13

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_13 and arg_305_1.time_ < var_308_6 + var_308_13 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play120151076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 120151076
		arg_309_1.duration_ = 3.37

		local var_309_0 = {
			zh = 3.366,
			ja = 3.033
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play120151077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_312_1 = arg_309_1.actors_["1069ui_story"]
			local var_312_2 = 0

			if var_312_2 < arg_309_1.time_ and arg_309_1.time_ <= var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1069ui_story == nil then
				arg_309_1.var_.characterEffect1069ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_3 = 0.2

			if var_312_2 <= arg_309_1.time_ and arg_309_1.time_ < var_312_2 + var_312_3 and not isNil(var_312_1) then
				local var_312_4 = (arg_309_1.time_ - var_312_2) / var_312_3

				if arg_309_1.var_.characterEffect1069ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_2 + var_312_3 and arg_309_1.time_ < var_312_2 + var_312_3 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1069ui_story then
				arg_309_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_312_5 = 0
			local var_312_6 = 0.5

			if var_312_5 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_7 = arg_309_1:FormatText(StoryNameCfg[378].name)

				arg_309_1.leftNameTxt_.text = var_312_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_8 = arg_309_1:GetWordFromCfg(120151076)
				local var_312_9 = arg_309_1:FormatText(var_312_8.content)

				arg_309_1.text_.text = var_312_9

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_10 = 20
				local var_312_11 = utf8.len(var_312_9)
				local var_312_12 = var_312_10 <= 0 and var_312_6 or var_312_6 * (var_312_11 / var_312_10)

				if var_312_12 > 0 and var_312_6 < var_312_12 then
					arg_309_1.talkMaxDuration = var_312_12

					if var_312_12 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_12 + var_312_5
					end
				end

				arg_309_1.text_.text = var_312_9
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151076", "story_v_out_120151.awb") ~= 0 then
					local var_312_13 = manager.audio:GetVoiceLength("story_v_out_120151", "120151076", "story_v_out_120151.awb") / 1000

					if var_312_13 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_13 + var_312_5
					end

					if var_312_8.prefab_name ~= "" and arg_309_1.actors_[var_312_8.prefab_name] ~= nil then
						local var_312_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_8.prefab_name].transform, "story_v_out_120151", "120151076", "story_v_out_120151.awb")

						arg_309_1:RecordAudio("120151076", var_312_14)
						arg_309_1:RecordAudio("120151076", var_312_14)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_120151", "120151076", "story_v_out_120151.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_120151", "120151076", "story_v_out_120151.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_15 = math.max(var_312_6, arg_309_1.talkMaxDuration)

			if var_312_5 <= arg_309_1.time_ and arg_309_1.time_ < var_312_5 + var_312_15 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_5) / var_312_15

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_5 + var_312_15 and arg_309_1.time_ < var_312_5 + var_312_15 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play120151077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 120151077
		arg_313_1.duration_ = 5.6

		local var_313_0 = {
			zh = 3.666,
			ja = 5.6
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
				arg_313_0:Play120151078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1069ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1069ui_story == nil then
				arg_313_1.var_.characterEffect1069ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.2

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1069ui_story and not isNil(var_316_0) then
					local var_316_4 = Mathf.Lerp(0, 0.5, var_316_3)

					arg_313_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1069ui_story.fillRatio = var_316_4
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1069ui_story then
				local var_316_5 = 0.5

				arg_313_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1069ui_story.fillRatio = var_316_5
			end

			local var_316_6 = 0
			local var_316_7 = 0.5

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				local var_316_8 = "play"
				local var_316_9 = "music"

				arg_313_1:AudioAction(var_316_8, var_316_9, "ui_battle", "ui_battle_stopbgm", "")

				local var_316_10 = ""
				local var_316_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_316_11 ~= "" then
					if arg_313_1.bgmTxt_.text ~= var_316_11 and arg_313_1.bgmTxt_.text ~= "" then
						if arg_313_1.bgmTxt2_.text ~= "" then
							arg_313_1.bgmTxt_.text = arg_313_1.bgmTxt2_.text
						end

						arg_313_1.bgmTxt2_.text = var_316_11

						arg_313_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_313_1.bgmTxt_.text = var_316_11
						arg_313_1.bgmTxt2_.text = var_316_11
					end

					if arg_313_1.bgmTimer then
						arg_313_1.bgmTimer:Stop()

						arg_313_1.bgmTimer = nil
					end

					if arg_313_1.settingData.show_music_name == 1 then
						arg_313_1.musicController:SetSelectedState("show")
						arg_313_1.musicAnimator_:Play("open", 0, 0)

						if arg_313_1.settingData.music_time ~= 0 then
							arg_313_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_313_1.settingData.music_time), function()
								if arg_313_1 == nil or isNil(arg_313_1.bgmTxt_) then
									return
								end

								arg_313_1.musicController:SetSelectedState("hide")
								arg_313_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_316_12 = 0
			local var_316_13 = 0.35

			if var_316_12 < arg_313_1.time_ and arg_313_1.time_ <= var_316_12 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_14 = arg_313_1:FormatText(StoryNameCfg[36].name)

				arg_313_1.leftNameTxt_.text = var_316_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_15 = arg_313_1:GetWordFromCfg(120151077)
				local var_316_16 = arg_313_1:FormatText(var_316_15.content)

				arg_313_1.text_.text = var_316_16

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_17 = 14
				local var_316_18 = utf8.len(var_316_16)
				local var_316_19 = var_316_17 <= 0 and var_316_13 or var_316_13 * (var_316_18 / var_316_17)

				if var_316_19 > 0 and var_316_13 < var_316_19 then
					arg_313_1.talkMaxDuration = var_316_19

					if var_316_19 + var_316_12 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_19 + var_316_12
					end
				end

				arg_313_1.text_.text = var_316_16
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151077", "story_v_out_120151.awb") ~= 0 then
					local var_316_20 = manager.audio:GetVoiceLength("story_v_out_120151", "120151077", "story_v_out_120151.awb") / 1000

					if var_316_20 + var_316_12 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_20 + var_316_12
					end

					if var_316_15.prefab_name ~= "" and arg_313_1.actors_[var_316_15.prefab_name] ~= nil then
						local var_316_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_15.prefab_name].transform, "story_v_out_120151", "120151077", "story_v_out_120151.awb")

						arg_313_1:RecordAudio("120151077", var_316_21)
						arg_313_1:RecordAudio("120151077", var_316_21)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_120151", "120151077", "story_v_out_120151.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_120151", "120151077", "story_v_out_120151.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_22 = math.max(var_316_13, arg_313_1.talkMaxDuration)

			if var_316_12 <= arg_313_1.time_ and arg_313_1.time_ < var_316_12 + var_316_22 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_12) / var_316_22

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_12 + var_316_22 and arg_313_1.time_ < var_316_12 + var_316_22 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play120151078 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 120151078
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play120151079(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1071ui_story"].transform
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.var_.moveOldPos1071ui_story = var_321_0.localPosition
			end

			local var_321_2 = 0.001

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2
				local var_321_4 = Vector3.New(0, 100, 0)

				var_321_0.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1071ui_story, var_321_4, var_321_3)

				local var_321_5 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_5.x, var_321_5.y, var_321_5.z)

				local var_321_6 = var_321_0.localEulerAngles

				var_321_6.z = 0
				var_321_6.x = 0
				var_321_0.localEulerAngles = var_321_6
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 then
				var_321_0.localPosition = Vector3.New(0, 100, 0)

				local var_321_7 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_7.x, var_321_7.y, var_321_7.z)

				local var_321_8 = var_321_0.localEulerAngles

				var_321_8.z = 0
				var_321_8.x = 0
				var_321_0.localEulerAngles = var_321_8
			end

			local var_321_9 = arg_318_1.actors_["1069ui_story"].transform
			local var_321_10 = 0

			if var_321_10 < arg_318_1.time_ and arg_318_1.time_ <= var_321_10 + arg_321_0 then
				arg_318_1.var_.moveOldPos1069ui_story = var_321_9.localPosition
			end

			local var_321_11 = 0.001

			if var_321_10 <= arg_318_1.time_ and arg_318_1.time_ < var_321_10 + var_321_11 then
				local var_321_12 = (arg_318_1.time_ - var_321_10) / var_321_11
				local var_321_13 = Vector3.New(0, 100, 0)

				var_321_9.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1069ui_story, var_321_13, var_321_12)

				local var_321_14 = manager.ui.mainCamera.transform.position - var_321_9.position

				var_321_9.forward = Vector3.New(var_321_14.x, var_321_14.y, var_321_14.z)

				local var_321_15 = var_321_9.localEulerAngles

				var_321_15.z = 0
				var_321_15.x = 0
				var_321_9.localEulerAngles = var_321_15
			end

			if arg_318_1.time_ >= var_321_10 + var_321_11 and arg_318_1.time_ < var_321_10 + var_321_11 + arg_321_0 then
				var_321_9.localPosition = Vector3.New(0, 100, 0)

				local var_321_16 = manager.ui.mainCamera.transform.position - var_321_9.position

				var_321_9.forward = Vector3.New(var_321_16.x, var_321_16.y, var_321_16.z)

				local var_321_17 = var_321_9.localEulerAngles

				var_321_17.z = 0
				var_321_17.x = 0
				var_321_9.localEulerAngles = var_321_17
			end

			local var_321_18 = 0
			local var_321_19 = 0.725

			if var_321_18 < arg_318_1.time_ and arg_318_1.time_ <= var_321_18 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_20 = arg_318_1:GetWordFromCfg(120151078)
				local var_321_21 = arg_318_1:FormatText(var_321_20.content)

				arg_318_1.text_.text = var_321_21

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_22 = 29
				local var_321_23 = utf8.len(var_321_21)
				local var_321_24 = var_321_22 <= 0 and var_321_19 or var_321_19 * (var_321_23 / var_321_22)

				if var_321_24 > 0 and var_321_19 < var_321_24 then
					arg_318_1.talkMaxDuration = var_321_24

					if var_321_24 + var_321_18 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_24 + var_321_18
					end
				end

				arg_318_1.text_.text = var_321_21
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_25 = math.max(var_321_19, arg_318_1.talkMaxDuration)

			if var_321_18 <= arg_318_1.time_ and arg_318_1.time_ < var_321_18 + var_321_25 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_18) / var_321_25

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_18 + var_321_25 and arg_318_1.time_ < var_321_18 + var_321_25 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play120151079 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 120151079
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play120151080(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 0.8

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_2 = arg_322_1:GetWordFromCfg(120151079)
				local var_325_3 = arg_322_1:FormatText(var_325_2.content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 32
				local var_325_5 = utf8.len(var_325_3)
				local var_325_6 = var_325_4 <= 0 and var_325_1 or var_325_1 * (var_325_5 / var_325_4)

				if var_325_6 > 0 and var_325_1 < var_325_6 then
					arg_322_1.talkMaxDuration = var_325_6

					if var_325_6 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_6 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_7 and arg_322_1.time_ < var_325_0 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play120151080 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 120151080
		arg_326_1.duration_ = 9

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play120151081(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = "J04f"

			if arg_326_1.bgs_[var_329_0] == nil then
				local var_329_1 = Object.Instantiate(arg_326_1.paintGo_)

				var_329_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_329_0)
				var_329_1.name = var_329_0
				var_329_1.transform.parent = arg_326_1.stage_.transform
				var_329_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_326_1.bgs_[var_329_0] = var_329_1
			end

			local var_329_2 = 2

			if var_329_2 < arg_326_1.time_ and arg_326_1.time_ <= var_329_2 + arg_329_0 then
				local var_329_3 = manager.ui.mainCamera.transform.localPosition
				local var_329_4 = Vector3.New(0, 0, 10) + Vector3.New(var_329_3.x, var_329_3.y, 0)
				local var_329_5 = arg_326_1.bgs_.J04f

				var_329_5.transform.localPosition = var_329_4
				var_329_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_329_6 = var_329_5:GetComponent("SpriteRenderer")

				if var_329_6 and var_329_6.sprite then
					local var_329_7 = (var_329_5.transform.localPosition - var_329_3).z
					local var_329_8 = manager.ui.mainCameraCom_
					local var_329_9 = 2 * var_329_7 * Mathf.Tan(var_329_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_329_10 = var_329_9 * var_329_8.aspect
					local var_329_11 = var_329_6.sprite.bounds.size.x
					local var_329_12 = var_329_6.sprite.bounds.size.y
					local var_329_13 = var_329_10 / var_329_11
					local var_329_14 = var_329_9 / var_329_12
					local var_329_15 = var_329_14 < var_329_13 and var_329_13 or var_329_14

					var_329_5.transform.localScale = Vector3.New(var_329_15, var_329_15, 0)
				end

				for iter_329_0, iter_329_1 in pairs(arg_326_1.bgs_) do
					if iter_329_0 ~= "J04f" then
						iter_329_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_329_16 = 0

			if var_329_16 < arg_326_1.time_ and arg_326_1.time_ <= var_329_16 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_17 = 2

			if var_329_16 <= arg_326_1.time_ and arg_326_1.time_ < var_329_16 + var_329_17 then
				local var_329_18 = (arg_326_1.time_ - var_329_16) / var_329_17
				local var_329_19 = Color.New(0, 0, 0)

				var_329_19.a = Mathf.Lerp(0, 1, var_329_18)
				arg_326_1.mask_.color = var_329_19
			end

			if arg_326_1.time_ >= var_329_16 + var_329_17 and arg_326_1.time_ < var_329_16 + var_329_17 + arg_329_0 then
				local var_329_20 = Color.New(0, 0, 0)

				var_329_20.a = 1
				arg_326_1.mask_.color = var_329_20
			end

			local var_329_21 = 2

			if var_329_21 < arg_326_1.time_ and arg_326_1.time_ <= var_329_21 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_22 = 2

			if var_329_21 <= arg_326_1.time_ and arg_326_1.time_ < var_329_21 + var_329_22 then
				local var_329_23 = (arg_326_1.time_ - var_329_21) / var_329_22
				local var_329_24 = Color.New(0, 0, 0)

				var_329_24.a = Mathf.Lerp(1, 0, var_329_23)
				arg_326_1.mask_.color = var_329_24
			end

			if arg_326_1.time_ >= var_329_21 + var_329_22 and arg_326_1.time_ < var_329_21 + var_329_22 + arg_329_0 then
				local var_329_25 = Color.New(0, 0, 0)
				local var_329_26 = 0

				arg_326_1.mask_.enabled = false
				var_329_25.a = var_329_26
				arg_326_1.mask_.color = var_329_25
			end

			local var_329_27 = 0
			local var_329_28 = 0.3

			if var_329_27 < arg_326_1.time_ and arg_326_1.time_ <= var_329_27 + arg_329_0 then
				local var_329_29 = "play"
				local var_329_30 = "music"

				arg_326_1:AudioAction(var_329_29, var_329_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_329_31 = ""
				local var_329_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_329_32 ~= "" then
					if arg_326_1.bgmTxt_.text ~= var_329_32 and arg_326_1.bgmTxt_.text ~= "" then
						if arg_326_1.bgmTxt2_.text ~= "" then
							arg_326_1.bgmTxt_.text = arg_326_1.bgmTxt2_.text
						end

						arg_326_1.bgmTxt2_.text = var_329_32

						arg_326_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_326_1.bgmTxt_.text = var_329_32
						arg_326_1.bgmTxt2_.text = var_329_32
					end

					if arg_326_1.bgmTimer then
						arg_326_1.bgmTimer:Stop()

						arg_326_1.bgmTimer = nil
					end

					if arg_326_1.settingData.show_music_name == 1 then
						arg_326_1.musicController:SetSelectedState("show")
						arg_326_1.musicAnimator_:Play("open", 0, 0)

						if arg_326_1.settingData.music_time ~= 0 then
							arg_326_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_326_1.settingData.music_time), function()
								if arg_326_1 == nil or isNil(arg_326_1.bgmTxt_) then
									return
								end

								arg_326_1.musicController:SetSelectedState("hide")
								arg_326_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_329_33 = 1.56666666666667
			local var_329_34 = 1

			if var_329_33 < arg_326_1.time_ and arg_326_1.time_ <= var_329_33 + arg_329_0 then
				local var_329_35 = "play"
				local var_329_36 = "music"

				arg_326_1:AudioAction(var_329_35, var_329_36, "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu.awb")

				local var_329_37 = ""
				local var_329_38 = manager.audio:GetAudioName("bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu")

				if var_329_38 ~= "" then
					if arg_326_1.bgmTxt_.text ~= var_329_38 and arg_326_1.bgmTxt_.text ~= "" then
						if arg_326_1.bgmTxt2_.text ~= "" then
							arg_326_1.bgmTxt_.text = arg_326_1.bgmTxt2_.text
						end

						arg_326_1.bgmTxt2_.text = var_329_38

						arg_326_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_326_1.bgmTxt_.text = var_329_38
						arg_326_1.bgmTxt2_.text = var_329_38
					end

					if arg_326_1.bgmTimer then
						arg_326_1.bgmTimer:Stop()

						arg_326_1.bgmTimer = nil
					end

					if arg_326_1.settingData.show_music_name == 1 then
						arg_326_1.musicController:SetSelectedState("show")
						arg_326_1.musicAnimator_:Play("open", 0, 0)

						if arg_326_1.settingData.music_time ~= 0 then
							arg_326_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_326_1.settingData.music_time), function()
								if arg_326_1 == nil or isNil(arg_326_1.bgmTxt_) then
									return
								end

								arg_326_1.musicController:SetSelectedState("hide")
								arg_326_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_326_1.frameCnt_ <= 1 then
				arg_326_1.dialog_:SetActive(false)
			end

			local var_329_39 = 4
			local var_329_40 = 0.975

			if var_329_39 < arg_326_1.time_ and arg_326_1.time_ <= var_329_39 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0

				arg_326_1.dialog_:SetActive(true)

				arg_326_1.dialogCg_.alpha = 0

				local var_329_41 = LeanTween.value(arg_326_1.dialog_, 0, 1, 0.3)

				var_329_41:setOnUpdate(LuaHelper.FloatAction(function(arg_332_0)
					arg_326_1.dialogCg_.alpha = arg_332_0
				end))
				var_329_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_326_1.dialog_)
					var_329_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_326_1.duration_ = arg_326_1.duration_ + 0.3

				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_42 = arg_326_1:GetWordFromCfg(120151080)
				local var_329_43 = arg_326_1:FormatText(var_329_42.content)

				arg_326_1.text_.text = var_329_43

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_44 = 39
				local var_329_45 = utf8.len(var_329_43)
				local var_329_46 = var_329_44 <= 0 and var_329_40 or var_329_40 * (var_329_45 / var_329_44)

				if var_329_46 > 0 and var_329_40 < var_329_46 then
					arg_326_1.talkMaxDuration = var_329_46
					var_329_39 = var_329_39 + 0.3

					if var_329_46 + var_329_39 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_46 + var_329_39
					end
				end

				arg_326_1.text_.text = var_329_43
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_47 = var_329_39 + 0.3
			local var_329_48 = math.max(var_329_40, arg_326_1.talkMaxDuration)

			if var_329_47 <= arg_326_1.time_ and arg_326_1.time_ < var_329_47 + var_329_48 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_47) / var_329_48

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_47 + var_329_48 and arg_326_1.time_ < var_329_47 + var_329_48 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play120151081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 120151081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play120151082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.15

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_2 = arg_334_1:FormatText(StoryNameCfg[7].name)

				arg_334_1.leftNameTxt_.text = var_337_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:GetWordFromCfg(120151081)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 6
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
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_8 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_8 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_8

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_8 and arg_334_1.time_ < var_337_0 + var_337_8 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play120151082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 120151082
		arg_338_1.duration_ = 5.4

		local var_338_0 = {
			zh = 5.4,
			ja = 3.166
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
				arg_338_0:Play120151083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = "1075ui_story"

			if arg_338_1.actors_[var_341_0] == nil then
				local var_341_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_341_1) then
					local var_341_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_338_1.stage_.transform)

					var_341_2.name = var_341_0
					var_341_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_338_1.actors_[var_341_0] = var_341_2

					local var_341_3 = var_341_2:GetComponentInChildren(typeof(CharacterEffect))

					var_341_3.enabled = true

					local var_341_4 = GameObjectTools.GetOrAddComponent(var_341_2, typeof(DynamicBoneHelper))

					if var_341_4 then
						var_341_4:EnableDynamicBone(false)
					end

					arg_338_1:ShowWeapon(var_341_3.transform, false)

					arg_338_1.var_[var_341_0 .. "Animator"] = var_341_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_338_1.var_[var_341_0 .. "Animator"].applyRootMotion = true
					arg_338_1.var_[var_341_0 .. "LipSync"] = var_341_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_341_5 = arg_338_1.actors_["1075ui_story"].transform
			local var_341_6 = 0

			if var_341_6 < arg_338_1.time_ and arg_338_1.time_ <= var_341_6 + arg_341_0 then
				arg_338_1.var_.moveOldPos1075ui_story = var_341_5.localPosition
			end

			local var_341_7 = 0.001

			if var_341_6 <= arg_338_1.time_ and arg_338_1.time_ < var_341_6 + var_341_7 then
				local var_341_8 = (arg_338_1.time_ - var_341_6) / var_341_7
				local var_341_9 = Vector3.New(0, -1.055, -6.16)

				var_341_5.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1075ui_story, var_341_9, var_341_8)

				local var_341_10 = manager.ui.mainCamera.transform.position - var_341_5.position

				var_341_5.forward = Vector3.New(var_341_10.x, var_341_10.y, var_341_10.z)

				local var_341_11 = var_341_5.localEulerAngles

				var_341_11.z = 0
				var_341_11.x = 0
				var_341_5.localEulerAngles = var_341_11
			end

			if arg_338_1.time_ >= var_341_6 + var_341_7 and arg_338_1.time_ < var_341_6 + var_341_7 + arg_341_0 then
				var_341_5.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_341_12 = manager.ui.mainCamera.transform.position - var_341_5.position

				var_341_5.forward = Vector3.New(var_341_12.x, var_341_12.y, var_341_12.z)

				local var_341_13 = var_341_5.localEulerAngles

				var_341_13.z = 0
				var_341_13.x = 0
				var_341_5.localEulerAngles = var_341_13
			end

			local var_341_14 = 0

			if var_341_14 < arg_338_1.time_ and arg_338_1.time_ <= var_341_14 + arg_341_0 then
				arg_338_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_341_15 = 0

			if var_341_15 < arg_338_1.time_ and arg_338_1.time_ <= var_341_15 + arg_341_0 then
				arg_338_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_341_16 = arg_338_1.actors_["1075ui_story"]
			local var_341_17 = 0

			if var_341_17 < arg_338_1.time_ and arg_338_1.time_ <= var_341_17 + arg_341_0 and not isNil(var_341_16) and arg_338_1.var_.characterEffect1075ui_story == nil then
				arg_338_1.var_.characterEffect1075ui_story = var_341_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_18 = 0.2

			if var_341_17 <= arg_338_1.time_ and arg_338_1.time_ < var_341_17 + var_341_18 and not isNil(var_341_16) then
				local var_341_19 = (arg_338_1.time_ - var_341_17) / var_341_18

				if arg_338_1.var_.characterEffect1075ui_story and not isNil(var_341_16) then
					arg_338_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= var_341_17 + var_341_18 and arg_338_1.time_ < var_341_17 + var_341_18 + arg_341_0 and not isNil(var_341_16) and arg_338_1.var_.characterEffect1075ui_story then
				arg_338_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_341_20 = 0
			local var_341_21 = 0.325

			if var_341_20 < arg_338_1.time_ and arg_338_1.time_ <= var_341_20 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_22 = arg_338_1:FormatText(StoryNameCfg[381].name)

				arg_338_1.leftNameTxt_.text = var_341_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_23 = arg_338_1:GetWordFromCfg(120151082)
				local var_341_24 = arg_338_1:FormatText(var_341_23.content)

				arg_338_1.text_.text = var_341_24

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_25 = 13
				local var_341_26 = utf8.len(var_341_24)
				local var_341_27 = var_341_25 <= 0 and var_341_21 or var_341_21 * (var_341_26 / var_341_25)

				if var_341_27 > 0 and var_341_21 < var_341_27 then
					arg_338_1.talkMaxDuration = var_341_27

					if var_341_27 + var_341_20 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_27 + var_341_20
					end
				end

				arg_338_1.text_.text = var_341_24
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151082", "story_v_out_120151.awb") ~= 0 then
					local var_341_28 = manager.audio:GetVoiceLength("story_v_out_120151", "120151082", "story_v_out_120151.awb") / 1000

					if var_341_28 + var_341_20 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_28 + var_341_20
					end

					if var_341_23.prefab_name ~= "" and arg_338_1.actors_[var_341_23.prefab_name] ~= nil then
						local var_341_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_23.prefab_name].transform, "story_v_out_120151", "120151082", "story_v_out_120151.awb")

						arg_338_1:RecordAudio("120151082", var_341_29)
						arg_338_1:RecordAudio("120151082", var_341_29)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_120151", "120151082", "story_v_out_120151.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_120151", "120151082", "story_v_out_120151.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_30 = math.max(var_341_21, arg_338_1.talkMaxDuration)

			if var_341_20 <= arg_338_1.time_ and arg_338_1.time_ < var_341_20 + var_341_30 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_20) / var_341_30

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_20 + var_341_30 and arg_338_1.time_ < var_341_20 + var_341_30 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play120151083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 120151083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play120151084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1075ui_story"].transform
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.var_.moveOldPos1075ui_story = var_345_0.localPosition
			end

			local var_345_2 = 0.001

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2
				local var_345_4 = Vector3.New(0, 100, 0)

				var_345_0.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1075ui_story, var_345_4, var_345_3)

				local var_345_5 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_5.x, var_345_5.y, var_345_5.z)

				local var_345_6 = var_345_0.localEulerAngles

				var_345_6.z = 0
				var_345_6.x = 0
				var_345_0.localEulerAngles = var_345_6
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 then
				var_345_0.localPosition = Vector3.New(0, 100, 0)

				local var_345_7 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_7.x, var_345_7.y, var_345_7.z)

				local var_345_8 = var_345_0.localEulerAngles

				var_345_8.z = 0
				var_345_8.x = 0
				var_345_0.localEulerAngles = var_345_8
			end

			local var_345_9 = 0
			local var_345_10 = 0.8

			if var_345_9 < arg_342_1.time_ and arg_342_1.time_ <= var_345_9 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_11 = arg_342_1:GetWordFromCfg(120151083)
				local var_345_12 = arg_342_1:FormatText(var_345_11.content)

				arg_342_1.text_.text = var_345_12

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_13 = 32
				local var_345_14 = utf8.len(var_345_12)
				local var_345_15 = var_345_13 <= 0 and var_345_10 or var_345_10 * (var_345_14 / var_345_13)

				if var_345_15 > 0 and var_345_10 < var_345_15 then
					arg_342_1.talkMaxDuration = var_345_15

					if var_345_15 + var_345_9 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_15 + var_345_9
					end
				end

				arg_342_1.text_.text = var_345_12
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_16 = math.max(var_345_10, arg_342_1.talkMaxDuration)

			if var_345_9 <= arg_342_1.time_ and arg_342_1.time_ < var_345_9 + var_345_16 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_9) / var_345_16

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_9 + var_345_16 and arg_342_1.time_ < var_345_9 + var_345_16 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play120151084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 120151084
		arg_346_1.duration_ = 3.23

		local var_346_0 = {
			zh = 3.233,
			ja = 3
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
				arg_346_0:Play120151085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = "1184ui_story"

			if arg_346_1.actors_[var_349_0] == nil then
				local var_349_1 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_349_1) then
					local var_349_2 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_346_1.stage_.transform)

					var_349_2.name = var_349_0
					var_349_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_346_1.actors_[var_349_0] = var_349_2

					local var_349_3 = var_349_2:GetComponentInChildren(typeof(CharacterEffect))

					var_349_3.enabled = true

					local var_349_4 = GameObjectTools.GetOrAddComponent(var_349_2, typeof(DynamicBoneHelper))

					if var_349_4 then
						var_349_4:EnableDynamicBone(false)
					end

					arg_346_1:ShowWeapon(var_349_3.transform, false)

					arg_346_1.var_[var_349_0 .. "Animator"] = var_349_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_346_1.var_[var_349_0 .. "Animator"].applyRootMotion = true
					arg_346_1.var_[var_349_0 .. "LipSync"] = var_349_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_349_5 = arg_346_1.actors_["1184ui_story"].transform
			local var_349_6 = 0

			if var_349_6 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				arg_346_1.var_.moveOldPos1184ui_story = var_349_5.localPosition
			end

			local var_349_7 = 0.001

			if var_349_6 <= arg_346_1.time_ and arg_346_1.time_ < var_349_6 + var_349_7 then
				local var_349_8 = (arg_346_1.time_ - var_349_6) / var_349_7
				local var_349_9 = Vector3.New(0, -0.97, -6)

				var_349_5.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1184ui_story, var_349_9, var_349_8)

				local var_349_10 = manager.ui.mainCamera.transform.position - var_349_5.position

				var_349_5.forward = Vector3.New(var_349_10.x, var_349_10.y, var_349_10.z)

				local var_349_11 = var_349_5.localEulerAngles

				var_349_11.z = 0
				var_349_11.x = 0
				var_349_5.localEulerAngles = var_349_11
			end

			if arg_346_1.time_ >= var_349_6 + var_349_7 and arg_346_1.time_ < var_349_6 + var_349_7 + arg_349_0 then
				var_349_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_349_12 = manager.ui.mainCamera.transform.position - var_349_5.position

				var_349_5.forward = Vector3.New(var_349_12.x, var_349_12.y, var_349_12.z)

				local var_349_13 = var_349_5.localEulerAngles

				var_349_13.z = 0
				var_349_13.x = 0
				var_349_5.localEulerAngles = var_349_13
			end

			local var_349_14 = 0

			if var_349_14 < arg_346_1.time_ and arg_346_1.time_ <= var_349_14 + arg_349_0 then
				arg_346_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_349_15 = 0

			if var_349_15 < arg_346_1.time_ and arg_346_1.time_ <= var_349_15 + arg_349_0 then
				arg_346_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_349_16 = arg_346_1.actors_["1184ui_story"]
			local var_349_17 = 0

			if var_349_17 < arg_346_1.time_ and arg_346_1.time_ <= var_349_17 + arg_349_0 and not isNil(var_349_16) and arg_346_1.var_.characterEffect1184ui_story == nil then
				arg_346_1.var_.characterEffect1184ui_story = var_349_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_18 = 0.2

			if var_349_17 <= arg_346_1.time_ and arg_346_1.time_ < var_349_17 + var_349_18 and not isNil(var_349_16) then
				local var_349_19 = (arg_346_1.time_ - var_349_17) / var_349_18

				if arg_346_1.var_.characterEffect1184ui_story and not isNil(var_349_16) then
					arg_346_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= var_349_17 + var_349_18 and arg_346_1.time_ < var_349_17 + var_349_18 + arg_349_0 and not isNil(var_349_16) and arg_346_1.var_.characterEffect1184ui_story then
				arg_346_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_349_20 = 0
			local var_349_21 = 0.375

			if var_349_20 < arg_346_1.time_ and arg_346_1.time_ <= var_349_20 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_22 = arg_346_1:FormatText(StoryNameCfg[6].name)

				arg_346_1.leftNameTxt_.text = var_349_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_23 = arg_346_1:GetWordFromCfg(120151084)
				local var_349_24 = arg_346_1:FormatText(var_349_23.content)

				arg_346_1.text_.text = var_349_24

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_25 = 15
				local var_349_26 = utf8.len(var_349_24)
				local var_349_27 = var_349_25 <= 0 and var_349_21 or var_349_21 * (var_349_26 / var_349_25)

				if var_349_27 > 0 and var_349_21 < var_349_27 then
					arg_346_1.talkMaxDuration = var_349_27

					if var_349_27 + var_349_20 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_27 + var_349_20
					end
				end

				arg_346_1.text_.text = var_349_24
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151084", "story_v_out_120151.awb") ~= 0 then
					local var_349_28 = manager.audio:GetVoiceLength("story_v_out_120151", "120151084", "story_v_out_120151.awb") / 1000

					if var_349_28 + var_349_20 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_28 + var_349_20
					end

					if var_349_23.prefab_name ~= "" and arg_346_1.actors_[var_349_23.prefab_name] ~= nil then
						local var_349_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_23.prefab_name].transform, "story_v_out_120151", "120151084", "story_v_out_120151.awb")

						arg_346_1:RecordAudio("120151084", var_349_29)
						arg_346_1:RecordAudio("120151084", var_349_29)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_120151", "120151084", "story_v_out_120151.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_120151", "120151084", "story_v_out_120151.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_30 = math.max(var_349_21, arg_346_1.talkMaxDuration)

			if var_349_20 <= arg_346_1.time_ and arg_346_1.time_ < var_349_20 + var_349_30 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_20) / var_349_30

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_20 + var_349_30 and arg_346_1.time_ < var_349_20 + var_349_30 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play120151085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 120151085
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play120151086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1184ui_story"].transform
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1.var_.moveOldPos1184ui_story = var_353_0.localPosition
			end

			local var_353_2 = 0.001

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2
				local var_353_4 = Vector3.New(0, 100, 0)

				var_353_0.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1184ui_story, var_353_4, var_353_3)

				local var_353_5 = manager.ui.mainCamera.transform.position - var_353_0.position

				var_353_0.forward = Vector3.New(var_353_5.x, var_353_5.y, var_353_5.z)

				local var_353_6 = var_353_0.localEulerAngles

				var_353_6.z = 0
				var_353_6.x = 0
				var_353_0.localEulerAngles = var_353_6
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 then
				var_353_0.localPosition = Vector3.New(0, 100, 0)

				local var_353_7 = manager.ui.mainCamera.transform.position - var_353_0.position

				var_353_0.forward = Vector3.New(var_353_7.x, var_353_7.y, var_353_7.z)

				local var_353_8 = var_353_0.localEulerAngles

				var_353_8.z = 0
				var_353_8.x = 0
				var_353_0.localEulerAngles = var_353_8
			end

			local var_353_9 = 0
			local var_353_10 = 1.025

			if var_353_9 < arg_350_1.time_ and arg_350_1.time_ <= var_353_9 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_11 = arg_350_1:GetWordFromCfg(120151085)
				local var_353_12 = arg_350_1:FormatText(var_353_11.content)

				arg_350_1.text_.text = var_353_12

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_13 = 41
				local var_353_14 = utf8.len(var_353_12)
				local var_353_15 = var_353_13 <= 0 and var_353_10 or var_353_10 * (var_353_14 / var_353_13)

				if var_353_15 > 0 and var_353_10 < var_353_15 then
					arg_350_1.talkMaxDuration = var_353_15

					if var_353_15 + var_353_9 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_15 + var_353_9
					end
				end

				arg_350_1.text_.text = var_353_12
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_16 = math.max(var_353_10, arg_350_1.talkMaxDuration)

			if var_353_9 <= arg_350_1.time_ and arg_350_1.time_ < var_353_9 + var_353_16 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_9) / var_353_16

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_9 + var_353_16 and arg_350_1.time_ < var_353_9 + var_353_16 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play120151086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 120151086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play120151087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0
			local var_357_1 = 0.675

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_2 = arg_354_1:GetWordFromCfg(120151086)
				local var_357_3 = arg_354_1:FormatText(var_357_2.content)

				arg_354_1.text_.text = var_357_3

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_4 = 27
				local var_357_5 = utf8.len(var_357_3)
				local var_357_6 = var_357_4 <= 0 and var_357_1 or var_357_1 * (var_357_5 / var_357_4)

				if var_357_6 > 0 and var_357_1 < var_357_6 then
					arg_354_1.talkMaxDuration = var_357_6

					if var_357_6 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_6 + var_357_0
					end
				end

				arg_354_1.text_.text = var_357_3
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_7 = math.max(var_357_1, arg_354_1.talkMaxDuration)

			if var_357_0 <= arg_354_1.time_ and arg_354_1.time_ < var_357_0 + var_357_7 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_0) / var_357_7

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_0 + var_357_7 and arg_354_1.time_ < var_357_0 + var_357_7 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play120151087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 120151087
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play120151088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = "1029ui_story"

			if arg_358_1.actors_[var_361_0] == nil then
				local var_361_1 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_361_1) then
					local var_361_2 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_358_1.stage_.transform)

					var_361_2.name = var_361_0
					var_361_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_358_1.actors_[var_361_0] = var_361_2

					local var_361_3 = var_361_2:GetComponentInChildren(typeof(CharacterEffect))

					var_361_3.enabled = true

					local var_361_4 = GameObjectTools.GetOrAddComponent(var_361_2, typeof(DynamicBoneHelper))

					if var_361_4 then
						var_361_4:EnableDynamicBone(false)
					end

					arg_358_1:ShowWeapon(var_361_3.transform, false)

					arg_358_1.var_[var_361_0 .. "Animator"] = var_361_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_358_1.var_[var_361_0 .. "Animator"].applyRootMotion = true
					arg_358_1.var_[var_361_0 .. "LipSync"] = var_361_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_361_5 = arg_358_1.actors_["1029ui_story"].transform
			local var_361_6 = 0

			if var_361_6 < arg_358_1.time_ and arg_358_1.time_ <= var_361_6 + arg_361_0 then
				arg_358_1.var_.moveOldPos1029ui_story = var_361_5.localPosition
			end

			local var_361_7 = 0.001

			if var_361_6 <= arg_358_1.time_ and arg_358_1.time_ < var_361_6 + var_361_7 then
				local var_361_8 = (arg_358_1.time_ - var_361_6) / var_361_7
				local var_361_9 = Vector3.New(0, -1.09, -6.2)

				var_361_5.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1029ui_story, var_361_9, var_361_8)

				local var_361_10 = manager.ui.mainCamera.transform.position - var_361_5.position

				var_361_5.forward = Vector3.New(var_361_10.x, var_361_10.y, var_361_10.z)

				local var_361_11 = var_361_5.localEulerAngles

				var_361_11.z = 0
				var_361_11.x = 0
				var_361_5.localEulerAngles = var_361_11
			end

			if arg_358_1.time_ >= var_361_6 + var_361_7 and arg_358_1.time_ < var_361_6 + var_361_7 + arg_361_0 then
				var_361_5.localPosition = Vector3.New(0, -1.09, -6.2)

				local var_361_12 = manager.ui.mainCamera.transform.position - var_361_5.position

				var_361_5.forward = Vector3.New(var_361_12.x, var_361_12.y, var_361_12.z)

				local var_361_13 = var_361_5.localEulerAngles

				var_361_13.z = 0
				var_361_13.x = 0
				var_361_5.localEulerAngles = var_361_13
			end

			local var_361_14 = 0

			if var_361_14 < arg_358_1.time_ and arg_358_1.time_ <= var_361_14 + arg_361_0 then
				arg_358_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			local var_361_15 = 0

			if var_361_15 < arg_358_1.time_ and arg_358_1.time_ <= var_361_15 + arg_361_0 then
				arg_358_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_361_16 = arg_358_1.actors_["1029ui_story"]
			local var_361_17 = 0

			if var_361_17 < arg_358_1.time_ and arg_358_1.time_ <= var_361_17 + arg_361_0 and not isNil(var_361_16) and arg_358_1.var_.characterEffect1029ui_story == nil then
				arg_358_1.var_.characterEffect1029ui_story = var_361_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_18 = 0.2

			if var_361_17 <= arg_358_1.time_ and arg_358_1.time_ < var_361_17 + var_361_18 and not isNil(var_361_16) then
				local var_361_19 = (arg_358_1.time_ - var_361_17) / var_361_18

				if arg_358_1.var_.characterEffect1029ui_story and not isNil(var_361_16) then
					local var_361_20 = Mathf.Lerp(0, 0.5, var_361_19)

					arg_358_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1029ui_story.fillRatio = var_361_20
				end
			end

			if arg_358_1.time_ >= var_361_17 + var_361_18 and arg_358_1.time_ < var_361_17 + var_361_18 + arg_361_0 and not isNil(var_361_16) and arg_358_1.var_.characterEffect1029ui_story then
				local var_361_21 = 0.5

				arg_358_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1029ui_story.fillRatio = var_361_21
			end

			local var_361_22 = 0
			local var_361_23 = 0.15

			if var_361_22 < arg_358_1.time_ and arg_358_1.time_ <= var_361_22 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_24 = arg_358_1:FormatText(StoryNameCfg[7].name)

				arg_358_1.leftNameTxt_.text = var_361_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_25 = arg_358_1:GetWordFromCfg(120151087)
				local var_361_26 = arg_358_1:FormatText(var_361_25.content)

				arg_358_1.text_.text = var_361_26

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_27 = 6
				local var_361_28 = utf8.len(var_361_26)
				local var_361_29 = var_361_27 <= 0 and var_361_23 or var_361_23 * (var_361_28 / var_361_27)

				if var_361_29 > 0 and var_361_23 < var_361_29 then
					arg_358_1.talkMaxDuration = var_361_29

					if var_361_29 + var_361_22 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_29 + var_361_22
					end
				end

				arg_358_1.text_.text = var_361_26
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_30 = math.max(var_361_23, arg_358_1.talkMaxDuration)

			if var_361_22 <= arg_358_1.time_ and arg_358_1.time_ < var_361_22 + var_361_30 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_22) / var_361_30

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_22 + var_361_30 and arg_358_1.time_ < var_361_22 + var_361_30 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play120151088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 120151088
		arg_362_1.duration_ = 3.73

		local var_362_0 = {
			zh = 3.733,
			ja = 3.2
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
				arg_362_0:Play120151089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_365_1 = arg_362_1.actors_["1029ui_story"]
			local var_365_2 = 0

			if var_365_2 < arg_362_1.time_ and arg_362_1.time_ <= var_365_2 + arg_365_0 and not isNil(var_365_1) and arg_362_1.var_.characterEffect1029ui_story == nil then
				arg_362_1.var_.characterEffect1029ui_story = var_365_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_3 = 0.2

			if var_365_2 <= arg_362_1.time_ and arg_362_1.time_ < var_365_2 + var_365_3 and not isNil(var_365_1) then
				local var_365_4 = (arg_362_1.time_ - var_365_2) / var_365_3

				if arg_362_1.var_.characterEffect1029ui_story and not isNil(var_365_1) then
					arg_362_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= var_365_2 + var_365_3 and arg_362_1.time_ < var_365_2 + var_365_3 + arg_365_0 and not isNil(var_365_1) and arg_362_1.var_.characterEffect1029ui_story then
				arg_362_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_365_5 = 0
			local var_365_6 = 0.35

			if var_365_5 < arg_362_1.time_ and arg_362_1.time_ <= var_365_5 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_7 = arg_362_1:FormatText(StoryNameCfg[319].name)

				arg_362_1.leftNameTxt_.text = var_365_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_8 = arg_362_1:GetWordFromCfg(120151088)
				local var_365_9 = arg_362_1:FormatText(var_365_8.content)

				arg_362_1.text_.text = var_365_9

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_10 = 14
				local var_365_11 = utf8.len(var_365_9)
				local var_365_12 = var_365_10 <= 0 and var_365_6 or var_365_6 * (var_365_11 / var_365_10)

				if var_365_12 > 0 and var_365_6 < var_365_12 then
					arg_362_1.talkMaxDuration = var_365_12

					if var_365_12 + var_365_5 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_12 + var_365_5
					end
				end

				arg_362_1.text_.text = var_365_9
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151088", "story_v_out_120151.awb") ~= 0 then
					local var_365_13 = manager.audio:GetVoiceLength("story_v_out_120151", "120151088", "story_v_out_120151.awb") / 1000

					if var_365_13 + var_365_5 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_13 + var_365_5
					end

					if var_365_8.prefab_name ~= "" and arg_362_1.actors_[var_365_8.prefab_name] ~= nil then
						local var_365_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_8.prefab_name].transform, "story_v_out_120151", "120151088", "story_v_out_120151.awb")

						arg_362_1:RecordAudio("120151088", var_365_14)
						arg_362_1:RecordAudio("120151088", var_365_14)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_120151", "120151088", "story_v_out_120151.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_120151", "120151088", "story_v_out_120151.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_15 = math.max(var_365_6, arg_362_1.talkMaxDuration)

			if var_365_5 <= arg_362_1.time_ and arg_362_1.time_ < var_365_5 + var_365_15 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_5) / var_365_15

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_5 + var_365_15 and arg_362_1.time_ < var_365_5 + var_365_15 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play120151089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 120151089
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play120151090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1029ui_story"].transform
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.var_.moveOldPos1029ui_story = var_369_0.localPosition
			end

			local var_369_2 = 0.001

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2
				local var_369_4 = Vector3.New(0, 100, 0)

				var_369_0.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1029ui_story, var_369_4, var_369_3)

				local var_369_5 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_5.x, var_369_5.y, var_369_5.z)

				local var_369_6 = var_369_0.localEulerAngles

				var_369_6.z = 0
				var_369_6.x = 0
				var_369_0.localEulerAngles = var_369_6
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 then
				var_369_0.localPosition = Vector3.New(0, 100, 0)

				local var_369_7 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_7.x, var_369_7.y, var_369_7.z)

				local var_369_8 = var_369_0.localEulerAngles

				var_369_8.z = 0
				var_369_8.x = 0
				var_369_0.localEulerAngles = var_369_8
			end

			local var_369_9 = 0
			local var_369_10 = 0.725

			if var_369_9 < arg_366_1.time_ and arg_366_1.time_ <= var_369_9 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_11 = arg_366_1:GetWordFromCfg(120151089)
				local var_369_12 = arg_366_1:FormatText(var_369_11.content)

				arg_366_1.text_.text = var_369_12

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_13 = 29
				local var_369_14 = utf8.len(var_369_12)
				local var_369_15 = var_369_13 <= 0 and var_369_10 or var_369_10 * (var_369_14 / var_369_13)

				if var_369_15 > 0 and var_369_10 < var_369_15 then
					arg_366_1.talkMaxDuration = var_369_15

					if var_369_15 + var_369_9 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_15 + var_369_9
					end
				end

				arg_366_1.text_.text = var_369_12
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_16 = math.max(var_369_10, arg_366_1.talkMaxDuration)

			if var_369_9 <= arg_366_1.time_ and arg_366_1.time_ < var_369_9 + var_369_16 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_9) / var_369_16

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_9 + var_369_16 and arg_366_1.time_ < var_369_9 + var_369_16 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play120151090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 120151090
		arg_370_1.duration_ = 7.63

		local var_370_0 = {
			zh = 7.233,
			ja = 7.633
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play120151091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["1071ui_story"].transform
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.var_.moveOldPos1071ui_story = var_373_0.localPosition
			end

			local var_373_2 = 0.001

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2
				local var_373_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_373_0.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1071ui_story, var_373_4, var_373_3)

				local var_373_5 = manager.ui.mainCamera.transform.position - var_373_0.position

				var_373_0.forward = Vector3.New(var_373_5.x, var_373_5.y, var_373_5.z)

				local var_373_6 = var_373_0.localEulerAngles

				var_373_6.z = 0
				var_373_6.x = 0
				var_373_0.localEulerAngles = var_373_6
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 then
				var_373_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_373_7 = manager.ui.mainCamera.transform.position - var_373_0.position

				var_373_0.forward = Vector3.New(var_373_7.x, var_373_7.y, var_373_7.z)

				local var_373_8 = var_373_0.localEulerAngles

				var_373_8.z = 0
				var_373_8.x = 0
				var_373_0.localEulerAngles = var_373_8
			end

			local var_373_9 = 0

			if var_373_9 < arg_370_1.time_ and arg_370_1.time_ <= var_373_9 + arg_373_0 then
				arg_370_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action4_1")
			end

			local var_373_10 = 0

			if var_373_10 < arg_370_1.time_ and arg_370_1.time_ <= var_373_10 + arg_373_0 then
				arg_370_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_373_11 = arg_370_1.actors_["1071ui_story"]
			local var_373_12 = 0

			if var_373_12 < arg_370_1.time_ and arg_370_1.time_ <= var_373_12 + arg_373_0 and not isNil(var_373_11) and arg_370_1.var_.characterEffect1071ui_story == nil then
				arg_370_1.var_.characterEffect1071ui_story = var_373_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_13 = 0.2

			if var_373_12 <= arg_370_1.time_ and arg_370_1.time_ < var_373_12 + var_373_13 and not isNil(var_373_11) then
				local var_373_14 = (arg_370_1.time_ - var_373_12) / var_373_13

				if arg_370_1.var_.characterEffect1071ui_story and not isNil(var_373_11) then
					arg_370_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= var_373_12 + var_373_13 and arg_370_1.time_ < var_373_12 + var_373_13 + arg_373_0 and not isNil(var_373_11) and arg_370_1.var_.characterEffect1071ui_story then
				arg_370_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_373_15 = 0
			local var_373_16 = 0.775

			if var_373_15 < arg_370_1.time_ and arg_370_1.time_ <= var_373_15 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_17 = arg_370_1:FormatText(StoryNameCfg[384].name)

				arg_370_1.leftNameTxt_.text = var_373_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_18 = arg_370_1:GetWordFromCfg(120151090)
				local var_373_19 = arg_370_1:FormatText(var_373_18.content)

				arg_370_1.text_.text = var_373_19

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_20 = 31
				local var_373_21 = utf8.len(var_373_19)
				local var_373_22 = var_373_20 <= 0 and var_373_16 or var_373_16 * (var_373_21 / var_373_20)

				if var_373_22 > 0 and var_373_16 < var_373_22 then
					arg_370_1.talkMaxDuration = var_373_22

					if var_373_22 + var_373_15 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_22 + var_373_15
					end
				end

				arg_370_1.text_.text = var_373_19
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151090", "story_v_out_120151.awb") ~= 0 then
					local var_373_23 = manager.audio:GetVoiceLength("story_v_out_120151", "120151090", "story_v_out_120151.awb") / 1000

					if var_373_23 + var_373_15 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_23 + var_373_15
					end

					if var_373_18.prefab_name ~= "" and arg_370_1.actors_[var_373_18.prefab_name] ~= nil then
						local var_373_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_18.prefab_name].transform, "story_v_out_120151", "120151090", "story_v_out_120151.awb")

						arg_370_1:RecordAudio("120151090", var_373_24)
						arg_370_1:RecordAudio("120151090", var_373_24)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_120151", "120151090", "story_v_out_120151.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_120151", "120151090", "story_v_out_120151.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_25 = math.max(var_373_16, arg_370_1.talkMaxDuration)

			if var_373_15 <= arg_370_1.time_ and arg_370_1.time_ < var_373_15 + var_373_25 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_15) / var_373_25

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_15 + var_373_25 and arg_370_1.time_ < var_373_15 + var_373_25 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play120151091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 120151091
		arg_374_1.duration_ = 3.87

		local var_374_0 = {
			zh = 2.7,
			ja = 3.866
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play120151092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["1071ui_story"]
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1071ui_story == nil then
				arg_374_1.var_.characterEffect1071ui_story = var_377_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_2 = 0.2

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 and not isNil(var_377_0) then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2

				if arg_374_1.var_.characterEffect1071ui_story and not isNil(var_377_0) then
					local var_377_4 = Mathf.Lerp(0, 0.5, var_377_3)

					arg_374_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_374_1.var_.characterEffect1071ui_story.fillRatio = var_377_4
				end
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1071ui_story then
				local var_377_5 = 0.5

				arg_374_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_374_1.var_.characterEffect1071ui_story.fillRatio = var_377_5
			end

			local var_377_6 = arg_374_1.actors_["1069ui_story"].transform
			local var_377_7 = 0

			if var_377_7 < arg_374_1.time_ and arg_374_1.time_ <= var_377_7 + arg_377_0 then
				arg_374_1.var_.moveOldPos1069ui_story = var_377_6.localPosition
			end

			local var_377_8 = 0.001

			if var_377_7 <= arg_374_1.time_ and arg_374_1.time_ < var_377_7 + var_377_8 then
				local var_377_9 = (arg_374_1.time_ - var_377_7) / var_377_8
				local var_377_10 = Vector3.New(0.7, -1, -6)

				var_377_6.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1069ui_story, var_377_10, var_377_9)

				local var_377_11 = manager.ui.mainCamera.transform.position - var_377_6.position

				var_377_6.forward = Vector3.New(var_377_11.x, var_377_11.y, var_377_11.z)

				local var_377_12 = var_377_6.localEulerAngles

				var_377_12.z = 0
				var_377_12.x = 0
				var_377_6.localEulerAngles = var_377_12
			end

			if arg_374_1.time_ >= var_377_7 + var_377_8 and arg_374_1.time_ < var_377_7 + var_377_8 + arg_377_0 then
				var_377_6.localPosition = Vector3.New(0.7, -1, -6)

				local var_377_13 = manager.ui.mainCamera.transform.position - var_377_6.position

				var_377_6.forward = Vector3.New(var_377_13.x, var_377_13.y, var_377_13.z)

				local var_377_14 = var_377_6.localEulerAngles

				var_377_14.z = 0
				var_377_14.x = 0
				var_377_6.localEulerAngles = var_377_14
			end

			local var_377_15 = 0

			if var_377_15 < arg_374_1.time_ and arg_374_1.time_ <= var_377_15 + arg_377_0 then
				arg_374_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_377_16 = 0

			if var_377_16 < arg_374_1.time_ and arg_374_1.time_ <= var_377_16 + arg_377_0 then
				arg_374_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_377_17 = arg_374_1.actors_["1069ui_story"]
			local var_377_18 = 0

			if var_377_18 < arg_374_1.time_ and arg_374_1.time_ <= var_377_18 + arg_377_0 and not isNil(var_377_17) and arg_374_1.var_.characterEffect1069ui_story == nil then
				arg_374_1.var_.characterEffect1069ui_story = var_377_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_19 = 0.2

			if var_377_18 <= arg_374_1.time_ and arg_374_1.time_ < var_377_18 + var_377_19 and not isNil(var_377_17) then
				local var_377_20 = (arg_374_1.time_ - var_377_18) / var_377_19

				if arg_374_1.var_.characterEffect1069ui_story and not isNil(var_377_17) then
					arg_374_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= var_377_18 + var_377_19 and arg_374_1.time_ < var_377_18 + var_377_19 + arg_377_0 and not isNil(var_377_17) and arg_374_1.var_.characterEffect1069ui_story then
				arg_374_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_377_21 = 0
			local var_377_22 = 0.3

			if var_377_21 < arg_374_1.time_ and arg_374_1.time_ <= var_377_21 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_23 = arg_374_1:FormatText(StoryNameCfg[378].name)

				arg_374_1.leftNameTxt_.text = var_377_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_24 = arg_374_1:GetWordFromCfg(120151091)
				local var_377_25 = arg_374_1:FormatText(var_377_24.content)

				arg_374_1.text_.text = var_377_25

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_26 = 12
				local var_377_27 = utf8.len(var_377_25)
				local var_377_28 = var_377_26 <= 0 and var_377_22 or var_377_22 * (var_377_27 / var_377_26)

				if var_377_28 > 0 and var_377_22 < var_377_28 then
					arg_374_1.talkMaxDuration = var_377_28

					if var_377_28 + var_377_21 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_28 + var_377_21
					end
				end

				arg_374_1.text_.text = var_377_25
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151091", "story_v_out_120151.awb") ~= 0 then
					local var_377_29 = manager.audio:GetVoiceLength("story_v_out_120151", "120151091", "story_v_out_120151.awb") / 1000

					if var_377_29 + var_377_21 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_29 + var_377_21
					end

					if var_377_24.prefab_name ~= "" and arg_374_1.actors_[var_377_24.prefab_name] ~= nil then
						local var_377_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_24.prefab_name].transform, "story_v_out_120151", "120151091", "story_v_out_120151.awb")

						arg_374_1:RecordAudio("120151091", var_377_30)
						arg_374_1:RecordAudio("120151091", var_377_30)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_120151", "120151091", "story_v_out_120151.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_120151", "120151091", "story_v_out_120151.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_31 = math.max(var_377_22, arg_374_1.talkMaxDuration)

			if var_377_21 <= arg_374_1.time_ and arg_374_1.time_ < var_377_21 + var_377_31 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_21) / var_377_31

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_21 + var_377_31 and arg_374_1.time_ < var_377_21 + var_377_31 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play120151092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 120151092
		arg_378_1.duration_ = 3

		local var_378_0 = {
			zh = 3,
			ja = 2.733
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play120151093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1075ui_story"].transform
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.var_.moveOldPos1075ui_story = var_381_0.localPosition
			end

			local var_381_2 = 0.001

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2
				local var_381_4 = Vector3.New(-0.7, -1.055, -6.16)

				var_381_0.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1075ui_story, var_381_4, var_381_3)

				local var_381_5 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_5.x, var_381_5.y, var_381_5.z)

				local var_381_6 = var_381_0.localEulerAngles

				var_381_6.z = 0
				var_381_6.x = 0
				var_381_0.localEulerAngles = var_381_6
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 then
				var_381_0.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_381_7 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_7.x, var_381_7.y, var_381_7.z)

				local var_381_8 = var_381_0.localEulerAngles

				var_381_8.z = 0
				var_381_8.x = 0
				var_381_0.localEulerAngles = var_381_8
			end

			local var_381_9 = 0

			if var_381_9 < arg_378_1.time_ and arg_378_1.time_ <= var_381_9 + arg_381_0 then
				arg_378_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_381_10 = 0

			if var_381_10 < arg_378_1.time_ and arg_378_1.time_ <= var_381_10 + arg_381_0 then
				arg_378_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_381_11 = arg_378_1.actors_["1075ui_story"]
			local var_381_12 = 0

			if var_381_12 < arg_378_1.time_ and arg_378_1.time_ <= var_381_12 + arg_381_0 and not isNil(var_381_11) and arg_378_1.var_.characterEffect1075ui_story == nil then
				arg_378_1.var_.characterEffect1075ui_story = var_381_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_13 = 0.2

			if var_381_12 <= arg_378_1.time_ and arg_378_1.time_ < var_381_12 + var_381_13 and not isNil(var_381_11) then
				local var_381_14 = (arg_378_1.time_ - var_381_12) / var_381_13

				if arg_378_1.var_.characterEffect1075ui_story and not isNil(var_381_11) then
					arg_378_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= var_381_12 + var_381_13 and arg_378_1.time_ < var_381_12 + var_381_13 + arg_381_0 and not isNil(var_381_11) and arg_378_1.var_.characterEffect1075ui_story then
				arg_378_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_381_15 = arg_378_1.actors_["1069ui_story"]
			local var_381_16 = 0

			if var_381_16 < arg_378_1.time_ and arg_378_1.time_ <= var_381_16 + arg_381_0 and not isNil(var_381_15) and arg_378_1.var_.characterEffect1069ui_story == nil then
				arg_378_1.var_.characterEffect1069ui_story = var_381_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_17 = 0.2

			if var_381_16 <= arg_378_1.time_ and arg_378_1.time_ < var_381_16 + var_381_17 and not isNil(var_381_15) then
				local var_381_18 = (arg_378_1.time_ - var_381_16) / var_381_17

				if arg_378_1.var_.characterEffect1069ui_story and not isNil(var_381_15) then
					local var_381_19 = Mathf.Lerp(0, 0.5, var_381_18)

					arg_378_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1069ui_story.fillRatio = var_381_19
				end
			end

			if arg_378_1.time_ >= var_381_16 + var_381_17 and arg_378_1.time_ < var_381_16 + var_381_17 + arg_381_0 and not isNil(var_381_15) and arg_378_1.var_.characterEffect1069ui_story then
				local var_381_20 = 0.5

				arg_378_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1069ui_story.fillRatio = var_381_20
			end

			local var_381_21 = arg_378_1.actors_["1071ui_story"].transform
			local var_381_22 = 0

			if var_381_22 < arg_378_1.time_ and arg_378_1.time_ <= var_381_22 + arg_381_0 then
				arg_378_1.var_.moveOldPos1071ui_story = var_381_21.localPosition
			end

			local var_381_23 = 0.001

			if var_381_22 <= arg_378_1.time_ and arg_378_1.time_ < var_381_22 + var_381_23 then
				local var_381_24 = (arg_378_1.time_ - var_381_22) / var_381_23
				local var_381_25 = Vector3.New(0, 100, 0)

				var_381_21.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1071ui_story, var_381_25, var_381_24)

				local var_381_26 = manager.ui.mainCamera.transform.position - var_381_21.position

				var_381_21.forward = Vector3.New(var_381_26.x, var_381_26.y, var_381_26.z)

				local var_381_27 = var_381_21.localEulerAngles

				var_381_27.z = 0
				var_381_27.x = 0
				var_381_21.localEulerAngles = var_381_27
			end

			if arg_378_1.time_ >= var_381_22 + var_381_23 and arg_378_1.time_ < var_381_22 + var_381_23 + arg_381_0 then
				var_381_21.localPosition = Vector3.New(0, 100, 0)

				local var_381_28 = manager.ui.mainCamera.transform.position - var_381_21.position

				var_381_21.forward = Vector3.New(var_381_28.x, var_381_28.y, var_381_28.z)

				local var_381_29 = var_381_21.localEulerAngles

				var_381_29.z = 0
				var_381_29.x = 0
				var_381_21.localEulerAngles = var_381_29
			end

			local var_381_30 = 0
			local var_381_31 = 0.25

			if var_381_30 < arg_378_1.time_ and arg_378_1.time_ <= var_381_30 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_32 = arg_378_1:FormatText(StoryNameCfg[381].name)

				arg_378_1.leftNameTxt_.text = var_381_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_33 = arg_378_1:GetWordFromCfg(120151092)
				local var_381_34 = arg_378_1:FormatText(var_381_33.content)

				arg_378_1.text_.text = var_381_34

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_35 = 10
				local var_381_36 = utf8.len(var_381_34)
				local var_381_37 = var_381_35 <= 0 and var_381_31 or var_381_31 * (var_381_36 / var_381_35)

				if var_381_37 > 0 and var_381_31 < var_381_37 then
					arg_378_1.talkMaxDuration = var_381_37

					if var_381_37 + var_381_30 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_37 + var_381_30
					end
				end

				arg_378_1.text_.text = var_381_34
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151092", "story_v_out_120151.awb") ~= 0 then
					local var_381_38 = manager.audio:GetVoiceLength("story_v_out_120151", "120151092", "story_v_out_120151.awb") / 1000

					if var_381_38 + var_381_30 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_38 + var_381_30
					end

					if var_381_33.prefab_name ~= "" and arg_378_1.actors_[var_381_33.prefab_name] ~= nil then
						local var_381_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_33.prefab_name].transform, "story_v_out_120151", "120151092", "story_v_out_120151.awb")

						arg_378_1:RecordAudio("120151092", var_381_39)
						arg_378_1:RecordAudio("120151092", var_381_39)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_120151", "120151092", "story_v_out_120151.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_120151", "120151092", "story_v_out_120151.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_40 = math.max(var_381_31, arg_378_1.talkMaxDuration)

			if var_381_30 <= arg_378_1.time_ and arg_378_1.time_ < var_381_30 + var_381_40 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_30) / var_381_40

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_30 + var_381_40 and arg_378_1.time_ < var_381_30 + var_381_40 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play120151093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 120151093
		arg_382_1.duration_ = 6.3

		local var_382_0 = {
			zh = 5.266,
			ja = 6.3
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play120151094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_385_1 = arg_382_1.actors_["1069ui_story"]
			local var_385_2 = 0

			if var_385_2 < arg_382_1.time_ and arg_382_1.time_ <= var_385_2 + arg_385_0 and not isNil(var_385_1) and arg_382_1.var_.characterEffect1069ui_story == nil then
				arg_382_1.var_.characterEffect1069ui_story = var_385_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_3 = 0.2

			if var_385_2 <= arg_382_1.time_ and arg_382_1.time_ < var_385_2 + var_385_3 and not isNil(var_385_1) then
				local var_385_4 = (arg_382_1.time_ - var_385_2) / var_385_3

				if arg_382_1.var_.characterEffect1069ui_story and not isNil(var_385_1) then
					arg_382_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= var_385_2 + var_385_3 and arg_382_1.time_ < var_385_2 + var_385_3 + arg_385_0 and not isNil(var_385_1) and arg_382_1.var_.characterEffect1069ui_story then
				arg_382_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_385_5 = arg_382_1.actors_["1075ui_story"]
			local var_385_6 = 0

			if var_385_6 < arg_382_1.time_ and arg_382_1.time_ <= var_385_6 + arg_385_0 and not isNil(var_385_5) and arg_382_1.var_.characterEffect1075ui_story == nil then
				arg_382_1.var_.characterEffect1075ui_story = var_385_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_7 = 0.2

			if var_385_6 <= arg_382_1.time_ and arg_382_1.time_ < var_385_6 + var_385_7 and not isNil(var_385_5) then
				local var_385_8 = (arg_382_1.time_ - var_385_6) / var_385_7

				if arg_382_1.var_.characterEffect1075ui_story and not isNil(var_385_5) then
					local var_385_9 = Mathf.Lerp(0, 0.5, var_385_8)

					arg_382_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1075ui_story.fillRatio = var_385_9
				end
			end

			if arg_382_1.time_ >= var_385_6 + var_385_7 and arg_382_1.time_ < var_385_6 + var_385_7 + arg_385_0 and not isNil(var_385_5) and arg_382_1.var_.characterEffect1075ui_story then
				local var_385_10 = 0.5

				arg_382_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1075ui_story.fillRatio = var_385_10
			end

			local var_385_11 = 0
			local var_385_12 = 0.7

			if var_385_11 < arg_382_1.time_ and arg_382_1.time_ <= var_385_11 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_13 = arg_382_1:FormatText(StoryNameCfg[378].name)

				arg_382_1.leftNameTxt_.text = var_385_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_14 = arg_382_1:GetWordFromCfg(120151093)
				local var_385_15 = arg_382_1:FormatText(var_385_14.content)

				arg_382_1.text_.text = var_385_15

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_16 = 28
				local var_385_17 = utf8.len(var_385_15)
				local var_385_18 = var_385_16 <= 0 and var_385_12 or var_385_12 * (var_385_17 / var_385_16)

				if var_385_18 > 0 and var_385_12 < var_385_18 then
					arg_382_1.talkMaxDuration = var_385_18

					if var_385_18 + var_385_11 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_18 + var_385_11
					end
				end

				arg_382_1.text_.text = var_385_15
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151093", "story_v_out_120151.awb") ~= 0 then
					local var_385_19 = manager.audio:GetVoiceLength("story_v_out_120151", "120151093", "story_v_out_120151.awb") / 1000

					if var_385_19 + var_385_11 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_19 + var_385_11
					end

					if var_385_14.prefab_name ~= "" and arg_382_1.actors_[var_385_14.prefab_name] ~= nil then
						local var_385_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_14.prefab_name].transform, "story_v_out_120151", "120151093", "story_v_out_120151.awb")

						arg_382_1:RecordAudio("120151093", var_385_20)
						arg_382_1:RecordAudio("120151093", var_385_20)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_120151", "120151093", "story_v_out_120151.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_120151", "120151093", "story_v_out_120151.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_21 = math.max(var_385_12, arg_382_1.talkMaxDuration)

			if var_385_11 <= arg_382_1.time_ and arg_382_1.time_ < var_385_11 + var_385_21 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_11) / var_385_21

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_11 + var_385_21 and arg_382_1.time_ < var_385_11 + var_385_21 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play120151094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 120151094
		arg_386_1.duration_ = 5.67

		local var_386_0 = {
			zh = 3.5,
			ja = 5.666
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play120151095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_389_1 = arg_386_1.actors_["1075ui_story"]
			local var_389_2 = 0

			if var_389_2 < arg_386_1.time_ and arg_386_1.time_ <= var_389_2 + arg_389_0 and not isNil(var_389_1) and arg_386_1.var_.characterEffect1075ui_story == nil then
				arg_386_1.var_.characterEffect1075ui_story = var_389_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_3 = 0.2

			if var_389_2 <= arg_386_1.time_ and arg_386_1.time_ < var_389_2 + var_389_3 and not isNil(var_389_1) then
				local var_389_4 = (arg_386_1.time_ - var_389_2) / var_389_3

				if arg_386_1.var_.characterEffect1075ui_story and not isNil(var_389_1) then
					arg_386_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= var_389_2 + var_389_3 and arg_386_1.time_ < var_389_2 + var_389_3 + arg_389_0 and not isNil(var_389_1) and arg_386_1.var_.characterEffect1075ui_story then
				arg_386_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_389_5 = 0
			local var_389_6 = 0.55

			if var_389_5 < arg_386_1.time_ and arg_386_1.time_ <= var_389_5 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_7 = arg_386_1:FormatText(StoryNameCfg[381].name)

				arg_386_1.leftNameTxt_.text = var_389_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_8 = arg_386_1:GetWordFromCfg(120151094)
				local var_389_9 = arg_386_1:FormatText(var_389_8.content)

				arg_386_1.text_.text = var_389_9

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_10 = 22
				local var_389_11 = utf8.len(var_389_9)
				local var_389_12 = var_389_10 <= 0 and var_389_6 or var_389_6 * (var_389_11 / var_389_10)

				if var_389_12 > 0 and var_389_6 < var_389_12 then
					arg_386_1.talkMaxDuration = var_389_12

					if var_389_12 + var_389_5 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_12 + var_389_5
					end
				end

				arg_386_1.text_.text = var_389_9
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151094", "story_v_out_120151.awb") ~= 0 then
					local var_389_13 = manager.audio:GetVoiceLength("story_v_out_120151", "120151094", "story_v_out_120151.awb") / 1000

					if var_389_13 + var_389_5 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_13 + var_389_5
					end

					if var_389_8.prefab_name ~= "" and arg_386_1.actors_[var_389_8.prefab_name] ~= nil then
						local var_389_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_8.prefab_name].transform, "story_v_out_120151", "120151094", "story_v_out_120151.awb")

						arg_386_1:RecordAudio("120151094", var_389_14)
						arg_386_1:RecordAudio("120151094", var_389_14)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_120151", "120151094", "story_v_out_120151.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_120151", "120151094", "story_v_out_120151.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_15 = math.max(var_389_6, arg_386_1.talkMaxDuration)

			if var_389_5 <= arg_386_1.time_ and arg_386_1.time_ < var_389_5 + var_389_15 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_5) / var_389_15

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_5 + var_389_15 and arg_386_1.time_ < var_389_5 + var_389_15 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play120151095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 120151095
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play120151096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["1075ui_story"].transform
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.var_.moveOldPos1075ui_story = var_393_0.localPosition
			end

			local var_393_2 = 0.001

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2
				local var_393_4 = Vector3.New(0, 100, 0)

				var_393_0.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1075ui_story, var_393_4, var_393_3)

				local var_393_5 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_5.x, var_393_5.y, var_393_5.z)

				local var_393_6 = var_393_0.localEulerAngles

				var_393_6.z = 0
				var_393_6.x = 0
				var_393_0.localEulerAngles = var_393_6
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 then
				var_393_0.localPosition = Vector3.New(0, 100, 0)

				local var_393_7 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_7.x, var_393_7.y, var_393_7.z)

				local var_393_8 = var_393_0.localEulerAngles

				var_393_8.z = 0
				var_393_8.x = 0
				var_393_0.localEulerAngles = var_393_8
			end

			local var_393_9 = arg_390_1.actors_["1069ui_story"].transform
			local var_393_10 = 0

			if var_393_10 < arg_390_1.time_ and arg_390_1.time_ <= var_393_10 + arg_393_0 then
				arg_390_1.var_.moveOldPos1069ui_story = var_393_9.localPosition
			end

			local var_393_11 = 0.001

			if var_393_10 <= arg_390_1.time_ and arg_390_1.time_ < var_393_10 + var_393_11 then
				local var_393_12 = (arg_390_1.time_ - var_393_10) / var_393_11
				local var_393_13 = Vector3.New(0, 100, 0)

				var_393_9.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1069ui_story, var_393_13, var_393_12)

				local var_393_14 = manager.ui.mainCamera.transform.position - var_393_9.position

				var_393_9.forward = Vector3.New(var_393_14.x, var_393_14.y, var_393_14.z)

				local var_393_15 = var_393_9.localEulerAngles

				var_393_15.z = 0
				var_393_15.x = 0
				var_393_9.localEulerAngles = var_393_15
			end

			if arg_390_1.time_ >= var_393_10 + var_393_11 and arg_390_1.time_ < var_393_10 + var_393_11 + arg_393_0 then
				var_393_9.localPosition = Vector3.New(0, 100, 0)

				local var_393_16 = manager.ui.mainCamera.transform.position - var_393_9.position

				var_393_9.forward = Vector3.New(var_393_16.x, var_393_16.y, var_393_16.z)

				local var_393_17 = var_393_9.localEulerAngles

				var_393_17.z = 0
				var_393_17.x = 0
				var_393_9.localEulerAngles = var_393_17
			end

			local var_393_18 = 0
			local var_393_19 = 0.525

			if var_393_18 < arg_390_1.time_ and arg_390_1.time_ <= var_393_18 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_20 = arg_390_1:GetWordFromCfg(120151095)
				local var_393_21 = arg_390_1:FormatText(var_393_20.content)

				arg_390_1.text_.text = var_393_21

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_22 = 21
				local var_393_23 = utf8.len(var_393_21)
				local var_393_24 = var_393_22 <= 0 and var_393_19 or var_393_19 * (var_393_23 / var_393_22)

				if var_393_24 > 0 and var_393_19 < var_393_24 then
					arg_390_1.talkMaxDuration = var_393_24

					if var_393_24 + var_393_18 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_24 + var_393_18
					end
				end

				arg_390_1.text_.text = var_393_21
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_25 = math.max(var_393_19, arg_390_1.talkMaxDuration)

			if var_393_18 <= arg_390_1.time_ and arg_390_1.time_ < var_393_18 + var_393_25 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_18) / var_393_25

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_18 + var_393_25 and arg_390_1.time_ < var_393_18 + var_393_25 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play120151096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 120151096
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play120151097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 0.475

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_2 = arg_394_1:GetWordFromCfg(120151096)
				local var_397_3 = arg_394_1:FormatText(var_397_2.content)

				arg_394_1.text_.text = var_397_3

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_4 = 19
				local var_397_5 = utf8.len(var_397_3)
				local var_397_6 = var_397_4 <= 0 and var_397_1 or var_397_1 * (var_397_5 / var_397_4)

				if var_397_6 > 0 and var_397_1 < var_397_6 then
					arg_394_1.talkMaxDuration = var_397_6

					if var_397_6 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_6 + var_397_0
					end
				end

				arg_394_1.text_.text = var_397_3
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_7 = math.max(var_397_1, arg_394_1.talkMaxDuration)

			if var_397_0 <= arg_394_1.time_ and arg_394_1.time_ < var_397_0 + var_397_7 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_0) / var_397_7

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_0 + var_397_7 and arg_394_1.time_ < var_397_0 + var_397_7 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play120151097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 120151097
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play120151098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 0.95

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_2 = arg_398_1:GetWordFromCfg(120151097)
				local var_401_3 = arg_398_1:FormatText(var_401_2.content)

				arg_398_1.text_.text = var_401_3

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_4 = 37
				local var_401_5 = utf8.len(var_401_3)
				local var_401_6 = var_401_4 <= 0 and var_401_1 or var_401_1 * (var_401_5 / var_401_4)

				if var_401_6 > 0 and var_401_1 < var_401_6 then
					arg_398_1.talkMaxDuration = var_401_6

					if var_401_6 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_6 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_3
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_7 and arg_398_1.time_ < var_401_0 + var_401_7 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play120151098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 120151098
		arg_402_1.duration_ = 1.67

		local var_402_0 = {
			zh = 1.666,
			ja = 1.566
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play120151099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0
			local var_405_1 = 0.15

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_2 = arg_402_1:FormatText(StoryNameCfg[381].name)

				arg_402_1.leftNameTxt_.text = var_405_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_3 = arg_402_1:GetWordFromCfg(120151098)
				local var_405_4 = arg_402_1:FormatText(var_405_3.content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 6
				local var_405_6 = utf8.len(var_405_4)
				local var_405_7 = var_405_5 <= 0 and var_405_1 or var_405_1 * (var_405_6 / var_405_5)

				if var_405_7 > 0 and var_405_1 < var_405_7 then
					arg_402_1.talkMaxDuration = var_405_7

					if var_405_7 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_4
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151098", "story_v_out_120151.awb") ~= 0 then
					local var_405_8 = manager.audio:GetVoiceLength("story_v_out_120151", "120151098", "story_v_out_120151.awb") / 1000

					if var_405_8 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_8 + var_405_0
					end

					if var_405_3.prefab_name ~= "" and arg_402_1.actors_[var_405_3.prefab_name] ~= nil then
						local var_405_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_3.prefab_name].transform, "story_v_out_120151", "120151098", "story_v_out_120151.awb")

						arg_402_1:RecordAudio("120151098", var_405_9)
						arg_402_1:RecordAudio("120151098", var_405_9)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_120151", "120151098", "story_v_out_120151.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_120151", "120151098", "story_v_out_120151.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_10 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_10 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_10

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_10 and arg_402_1.time_ < var_405_0 + var_405_10 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play120151099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 120151099
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play120151100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0
			local var_409_1 = 0.975

			if var_409_0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_2 = arg_406_1:GetWordFromCfg(120151099)
				local var_409_3 = arg_406_1:FormatText(var_409_2.content)

				arg_406_1.text_.text = var_409_3

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 39
				local var_409_5 = utf8.len(var_409_3)
				local var_409_6 = var_409_4 <= 0 and var_409_1 or var_409_1 * (var_409_5 / var_409_4)

				if var_409_6 > 0 and var_409_1 < var_409_6 then
					arg_406_1.talkMaxDuration = var_409_6

					if var_409_6 + var_409_0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_6 + var_409_0
					end
				end

				arg_406_1.text_.text = var_409_3
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_7 = math.max(var_409_1, arg_406_1.talkMaxDuration)

			if var_409_0 <= arg_406_1.time_ and arg_406_1.time_ < var_409_0 + var_409_7 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_0) / var_409_7

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_0 + var_409_7 and arg_406_1.time_ < var_409_0 + var_409_7 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play120151100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 120151100
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play120151101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0
			local var_413_1 = 0.375

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_2 = arg_410_1:FormatText(StoryNameCfg[7].name)

				arg_410_1.leftNameTxt_.text = var_413_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_3 = arg_410_1:GetWordFromCfg(120151100)
				local var_413_4 = arg_410_1:FormatText(var_413_3.content)

				arg_410_1.text_.text = var_413_4

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 15
				local var_413_6 = utf8.len(var_413_4)
				local var_413_7 = var_413_5 <= 0 and var_413_1 or var_413_1 * (var_413_6 / var_413_5)

				if var_413_7 > 0 and var_413_1 < var_413_7 then
					arg_410_1.talkMaxDuration = var_413_7

					if var_413_7 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_7 + var_413_0
					end
				end

				arg_410_1.text_.text = var_413_4
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_8 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_8 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_8

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_8 and arg_410_1.time_ < var_413_0 + var_413_8 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play120151101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 120151101
		arg_414_1.duration_ = 2.47

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play120151102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = "1076ui_story"

			if arg_414_1.actors_[var_417_0] == nil then
				local var_417_1 = Asset.Load("Char/" .. "1076ui_story")

				if not isNil(var_417_1) then
					local var_417_2 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_414_1.stage_.transform)

					var_417_2.name = var_417_0
					var_417_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_414_1.actors_[var_417_0] = var_417_2

					local var_417_3 = var_417_2:GetComponentInChildren(typeof(CharacterEffect))

					var_417_3.enabled = true

					local var_417_4 = GameObjectTools.GetOrAddComponent(var_417_2, typeof(DynamicBoneHelper))

					if var_417_4 then
						var_417_4:EnableDynamicBone(false)
					end

					arg_414_1:ShowWeapon(var_417_3.transform, false)

					arg_414_1.var_[var_417_0 .. "Animator"] = var_417_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_414_1.var_[var_417_0 .. "Animator"].applyRootMotion = true
					arg_414_1.var_[var_417_0 .. "LipSync"] = var_417_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_417_5 = arg_414_1.actors_["1076ui_story"].transform
			local var_417_6 = 0

			if var_417_6 < arg_414_1.time_ and arg_414_1.time_ <= var_417_6 + arg_417_0 then
				arg_414_1.var_.moveOldPos1076ui_story = var_417_5.localPosition
			end

			local var_417_7 = 0.001

			if var_417_6 <= arg_414_1.time_ and arg_414_1.time_ < var_417_6 + var_417_7 then
				local var_417_8 = (arg_414_1.time_ - var_417_6) / var_417_7
				local var_417_9 = Vector3.New(0, -1.06, -6.2)

				var_417_5.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1076ui_story, var_417_9, var_417_8)

				local var_417_10 = manager.ui.mainCamera.transform.position - var_417_5.position

				var_417_5.forward = Vector3.New(var_417_10.x, var_417_10.y, var_417_10.z)

				local var_417_11 = var_417_5.localEulerAngles

				var_417_11.z = 0
				var_417_11.x = 0
				var_417_5.localEulerAngles = var_417_11
			end

			if arg_414_1.time_ >= var_417_6 + var_417_7 and arg_414_1.time_ < var_417_6 + var_417_7 + arg_417_0 then
				var_417_5.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_417_12 = manager.ui.mainCamera.transform.position - var_417_5.position

				var_417_5.forward = Vector3.New(var_417_12.x, var_417_12.y, var_417_12.z)

				local var_417_13 = var_417_5.localEulerAngles

				var_417_13.z = 0
				var_417_13.x = 0
				var_417_5.localEulerAngles = var_417_13
			end

			local var_417_14 = 0

			if var_417_14 < arg_414_1.time_ and arg_414_1.time_ <= var_417_14 + arg_417_0 then
				arg_414_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_417_15 = 0

			if var_417_15 < arg_414_1.time_ and arg_414_1.time_ <= var_417_15 + arg_417_0 then
				arg_414_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_417_16 = arg_414_1.actors_["1076ui_story"]
			local var_417_17 = 0

			if var_417_17 < arg_414_1.time_ and arg_414_1.time_ <= var_417_17 + arg_417_0 and not isNil(var_417_16) and arg_414_1.var_.characterEffect1076ui_story == nil then
				arg_414_1.var_.characterEffect1076ui_story = var_417_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_18 = 0.2

			if var_417_17 <= arg_414_1.time_ and arg_414_1.time_ < var_417_17 + var_417_18 and not isNil(var_417_16) then
				local var_417_19 = (arg_414_1.time_ - var_417_17) / var_417_18

				if arg_414_1.var_.characterEffect1076ui_story and not isNil(var_417_16) then
					arg_414_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= var_417_17 + var_417_18 and arg_414_1.time_ < var_417_17 + var_417_18 + arg_417_0 and not isNil(var_417_16) and arg_414_1.var_.characterEffect1076ui_story then
				arg_414_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_417_20 = 0
			local var_417_21 = 0.125

			if var_417_20 < arg_414_1.time_ and arg_414_1.time_ <= var_417_20 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_22 = arg_414_1:FormatText(StoryNameCfg[389].name)

				arg_414_1.leftNameTxt_.text = var_417_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_23 = arg_414_1:GetWordFromCfg(120151101)
				local var_417_24 = arg_414_1:FormatText(var_417_23.content)

				arg_414_1.text_.text = var_417_24

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_25 = 5
				local var_417_26 = utf8.len(var_417_24)
				local var_417_27 = var_417_25 <= 0 and var_417_21 or var_417_21 * (var_417_26 / var_417_25)

				if var_417_27 > 0 and var_417_21 < var_417_27 then
					arg_414_1.talkMaxDuration = var_417_27

					if var_417_27 + var_417_20 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_27 + var_417_20
					end
				end

				arg_414_1.text_.text = var_417_24
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151101", "story_v_out_120151.awb") ~= 0 then
					local var_417_28 = manager.audio:GetVoiceLength("story_v_out_120151", "120151101", "story_v_out_120151.awb") / 1000

					if var_417_28 + var_417_20 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_28 + var_417_20
					end

					if var_417_23.prefab_name ~= "" and arg_414_1.actors_[var_417_23.prefab_name] ~= nil then
						local var_417_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_23.prefab_name].transform, "story_v_out_120151", "120151101", "story_v_out_120151.awb")

						arg_414_1:RecordAudio("120151101", var_417_29)
						arg_414_1:RecordAudio("120151101", var_417_29)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_120151", "120151101", "story_v_out_120151.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_120151", "120151101", "story_v_out_120151.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_30 = math.max(var_417_21, arg_414_1.talkMaxDuration)

			if var_417_20 <= arg_414_1.time_ and arg_414_1.time_ < var_417_20 + var_417_30 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_20) / var_417_30

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_20 + var_417_30 and arg_414_1.time_ < var_417_20 + var_417_30 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
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

		arg_414_1:InitPlayNodeList()
	end,
	Play120151102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 120151102
		arg_418_1.duration_ = 3.17

		local var_418_0 = {
			zh = 2.233,
			ja = 3.166
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play120151103(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0
			local var_421_1 = 0.225

			if var_421_0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_2 = arg_418_1:FormatText(StoryNameCfg[389].name)

				arg_418_1.leftNameTxt_.text = var_421_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_3 = arg_418_1:GetWordFromCfg(120151102)
				local var_421_4 = arg_418_1:FormatText(var_421_3.content)

				arg_418_1.text_.text = var_421_4

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_5 = 9
				local var_421_6 = utf8.len(var_421_4)
				local var_421_7 = var_421_5 <= 0 and var_421_1 or var_421_1 * (var_421_6 / var_421_5)

				if var_421_7 > 0 and var_421_1 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_0
					end
				end

				arg_418_1.text_.text = var_421_4
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151102", "story_v_out_120151.awb") ~= 0 then
					local var_421_8 = manager.audio:GetVoiceLength("story_v_out_120151", "120151102", "story_v_out_120151.awb") / 1000

					if var_421_8 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_8 + var_421_0
					end

					if var_421_3.prefab_name ~= "" and arg_418_1.actors_[var_421_3.prefab_name] ~= nil then
						local var_421_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_3.prefab_name].transform, "story_v_out_120151", "120151102", "story_v_out_120151.awb")

						arg_418_1:RecordAudio("120151102", var_421_9)
						arg_418_1:RecordAudio("120151102", var_421_9)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_120151", "120151102", "story_v_out_120151.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_120151", "120151102", "story_v_out_120151.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_10 = math.max(var_421_1, arg_418_1.talkMaxDuration)

			if var_421_0 <= arg_418_1.time_ and arg_418_1.time_ < var_421_0 + var_421_10 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_0) / var_421_10

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_0 + var_421_10 and arg_418_1.time_ < var_421_0 + var_421_10 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play120151103 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 120151103
		arg_422_1.duration_ = 7.67

		local var_422_0 = {
			zh = 5.4,
			ja = 7.666
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play120151104(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["1076ui_story"]
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect1076ui_story == nil then
				arg_422_1.var_.characterEffect1076ui_story = var_425_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_2 = 0.2

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_2 and not isNil(var_425_0) then
				local var_425_3 = (arg_422_1.time_ - var_425_1) / var_425_2

				if arg_422_1.var_.characterEffect1076ui_story and not isNil(var_425_0) then
					local var_425_4 = Mathf.Lerp(0, 0.5, var_425_3)

					arg_422_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_422_1.var_.characterEffect1076ui_story.fillRatio = var_425_4
				end
			end

			if arg_422_1.time_ >= var_425_1 + var_425_2 and arg_422_1.time_ < var_425_1 + var_425_2 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect1076ui_story then
				local var_425_5 = 0.5

				arg_422_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_422_1.var_.characterEffect1076ui_story.fillRatio = var_425_5
			end

			local var_425_6 = arg_422_1.actors_["1076ui_story"].transform
			local var_425_7 = 0

			if var_425_7 < arg_422_1.time_ and arg_422_1.time_ <= var_425_7 + arg_425_0 then
				arg_422_1.var_.moveOldPos1076ui_story = var_425_6.localPosition
			end

			local var_425_8 = 0.001

			if var_425_7 <= arg_422_1.time_ and arg_422_1.time_ < var_425_7 + var_425_8 then
				local var_425_9 = (arg_422_1.time_ - var_425_7) / var_425_8
				local var_425_10 = Vector3.New(-0.7, -1.06, -6.2)

				var_425_6.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1076ui_story, var_425_10, var_425_9)

				local var_425_11 = manager.ui.mainCamera.transform.position - var_425_6.position

				var_425_6.forward = Vector3.New(var_425_11.x, var_425_11.y, var_425_11.z)

				local var_425_12 = var_425_6.localEulerAngles

				var_425_12.z = 0
				var_425_12.x = 0
				var_425_6.localEulerAngles = var_425_12
			end

			if arg_422_1.time_ >= var_425_7 + var_425_8 and arg_422_1.time_ < var_425_7 + var_425_8 + arg_425_0 then
				var_425_6.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_425_13 = manager.ui.mainCamera.transform.position - var_425_6.position

				var_425_6.forward = Vector3.New(var_425_13.x, var_425_13.y, var_425_13.z)

				local var_425_14 = var_425_6.localEulerAngles

				var_425_14.z = 0
				var_425_14.x = 0
				var_425_6.localEulerAngles = var_425_14
			end

			local var_425_15 = arg_422_1.actors_["1075ui_story"].transform
			local var_425_16 = 0

			if var_425_16 < arg_422_1.time_ and arg_422_1.time_ <= var_425_16 + arg_425_0 then
				arg_422_1.var_.moveOldPos1075ui_story = var_425_15.localPosition
			end

			local var_425_17 = 0.001

			if var_425_16 <= arg_422_1.time_ and arg_422_1.time_ < var_425_16 + var_425_17 then
				local var_425_18 = (arg_422_1.time_ - var_425_16) / var_425_17
				local var_425_19 = Vector3.New(0.7, -1.055, -6.16)

				var_425_15.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1075ui_story, var_425_19, var_425_18)

				local var_425_20 = manager.ui.mainCamera.transform.position - var_425_15.position

				var_425_15.forward = Vector3.New(var_425_20.x, var_425_20.y, var_425_20.z)

				local var_425_21 = var_425_15.localEulerAngles

				var_425_21.z = 0
				var_425_21.x = 0
				var_425_15.localEulerAngles = var_425_21
			end

			if arg_422_1.time_ >= var_425_16 + var_425_17 and arg_422_1.time_ < var_425_16 + var_425_17 + arg_425_0 then
				var_425_15.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_425_22 = manager.ui.mainCamera.transform.position - var_425_15.position

				var_425_15.forward = Vector3.New(var_425_22.x, var_425_22.y, var_425_22.z)

				local var_425_23 = var_425_15.localEulerAngles

				var_425_23.z = 0
				var_425_23.x = 0
				var_425_15.localEulerAngles = var_425_23
			end

			local var_425_24 = 0

			if var_425_24 < arg_422_1.time_ and arg_422_1.time_ <= var_425_24 + arg_425_0 then
				arg_422_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_425_25 = 0

			if var_425_25 < arg_422_1.time_ and arg_422_1.time_ <= var_425_25 + arg_425_0 then
				arg_422_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_425_26 = arg_422_1.actors_["1075ui_story"]
			local var_425_27 = 0

			if var_425_27 < arg_422_1.time_ and arg_422_1.time_ <= var_425_27 + arg_425_0 and not isNil(var_425_26) and arg_422_1.var_.characterEffect1075ui_story == nil then
				arg_422_1.var_.characterEffect1075ui_story = var_425_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_28 = 0.2

			if var_425_27 <= arg_422_1.time_ and arg_422_1.time_ < var_425_27 + var_425_28 and not isNil(var_425_26) then
				local var_425_29 = (arg_422_1.time_ - var_425_27) / var_425_28

				if arg_422_1.var_.characterEffect1075ui_story and not isNil(var_425_26) then
					arg_422_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= var_425_27 + var_425_28 and arg_422_1.time_ < var_425_27 + var_425_28 + arg_425_0 and not isNil(var_425_26) and arg_422_1.var_.characterEffect1075ui_story then
				arg_422_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_425_30 = 0
			local var_425_31 = 0.6

			if var_425_30 < arg_422_1.time_ and arg_422_1.time_ <= var_425_30 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_32 = arg_422_1:FormatText(StoryNameCfg[381].name)

				arg_422_1.leftNameTxt_.text = var_425_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_33 = arg_422_1:GetWordFromCfg(120151103)
				local var_425_34 = arg_422_1:FormatText(var_425_33.content)

				arg_422_1.text_.text = var_425_34

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_35 = 24
				local var_425_36 = utf8.len(var_425_34)
				local var_425_37 = var_425_35 <= 0 and var_425_31 or var_425_31 * (var_425_36 / var_425_35)

				if var_425_37 > 0 and var_425_31 < var_425_37 then
					arg_422_1.talkMaxDuration = var_425_37

					if var_425_37 + var_425_30 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_37 + var_425_30
					end
				end

				arg_422_1.text_.text = var_425_34
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151103", "story_v_out_120151.awb") ~= 0 then
					local var_425_38 = manager.audio:GetVoiceLength("story_v_out_120151", "120151103", "story_v_out_120151.awb") / 1000

					if var_425_38 + var_425_30 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_38 + var_425_30
					end

					if var_425_33.prefab_name ~= "" and arg_422_1.actors_[var_425_33.prefab_name] ~= nil then
						local var_425_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_33.prefab_name].transform, "story_v_out_120151", "120151103", "story_v_out_120151.awb")

						arg_422_1:RecordAudio("120151103", var_425_39)
						arg_422_1:RecordAudio("120151103", var_425_39)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_120151", "120151103", "story_v_out_120151.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_120151", "120151103", "story_v_out_120151.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_40 = math.max(var_425_31, arg_422_1.talkMaxDuration)

			if var_425_30 <= arg_422_1.time_ and arg_422_1.time_ < var_425_30 + var_425_40 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_30) / var_425_40

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_30 + var_425_40 and arg_422_1.time_ < var_425_30 + var_425_40 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	Play120151104 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 120151104
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play120151105(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["1075ui_story"]
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.characterEffect1075ui_story == nil then
				arg_426_1.var_.characterEffect1075ui_story = var_429_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_2 = 0.2

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 and not isNil(var_429_0) then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2

				if arg_426_1.var_.characterEffect1075ui_story and not isNil(var_429_0) then
					local var_429_4 = Mathf.Lerp(0, 0.5, var_429_3)

					arg_426_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_426_1.var_.characterEffect1075ui_story.fillRatio = var_429_4
				end
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.characterEffect1075ui_story then
				local var_429_5 = 0.5

				arg_426_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_426_1.var_.characterEffect1075ui_story.fillRatio = var_429_5
			end

			local var_429_6 = 0
			local var_429_7 = 0.775

			if var_429_6 < arg_426_1.time_ and arg_426_1.time_ <= var_429_6 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_8 = arg_426_1:GetWordFromCfg(120151104)
				local var_429_9 = arg_426_1:FormatText(var_429_8.content)

				arg_426_1.text_.text = var_429_9

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_10 = 33
				local var_429_11 = utf8.len(var_429_9)
				local var_429_12 = var_429_10 <= 0 and var_429_7 or var_429_7 * (var_429_11 / var_429_10)

				if var_429_12 > 0 and var_429_7 < var_429_12 then
					arg_426_1.talkMaxDuration = var_429_12

					if var_429_12 + var_429_6 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_12 + var_429_6
					end
				end

				arg_426_1.text_.text = var_429_9
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_13 = math.max(var_429_7, arg_426_1.talkMaxDuration)

			if var_429_6 <= arg_426_1.time_ and arg_426_1.time_ < var_429_6 + var_429_13 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_6) / var_429_13

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_6 + var_429_13 and arg_426_1.time_ < var_429_6 + var_429_13 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play120151105 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 120151105
		arg_430_1.duration_ = 9.97

		local var_430_0 = {
			zh = 6.2,
			ja = 9.966
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
				arg_430_0:Play120151106(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["1076ui_story"]
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1076ui_story == nil then
				arg_430_1.var_.characterEffect1076ui_story = var_433_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.2

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 and not isNil(var_433_0) then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2

				if arg_430_1.var_.characterEffect1076ui_story and not isNil(var_433_0) then
					arg_430_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1076ui_story then
				arg_430_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_433_4 = 0

			if var_433_4 < arg_430_1.time_ and arg_430_1.time_ <= var_433_4 + arg_433_0 then
				arg_430_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_433_5 = 0

			if var_433_5 < arg_430_1.time_ and arg_430_1.time_ <= var_433_5 + arg_433_0 then
				arg_430_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_1")
			end

			local var_433_6 = 0
			local var_433_7 = 0.725

			if var_433_6 < arg_430_1.time_ and arg_430_1.time_ <= var_433_6 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_8 = arg_430_1:FormatText(StoryNameCfg[389].name)

				arg_430_1.leftNameTxt_.text = var_433_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_9 = arg_430_1:GetWordFromCfg(120151105)
				local var_433_10 = arg_430_1:FormatText(var_433_9.content)

				arg_430_1.text_.text = var_433_10

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_11 = 31
				local var_433_12 = utf8.len(var_433_10)
				local var_433_13 = var_433_11 <= 0 and var_433_7 or var_433_7 * (var_433_12 / var_433_11)

				if var_433_13 > 0 and var_433_7 < var_433_13 then
					arg_430_1.talkMaxDuration = var_433_13

					if var_433_13 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_13 + var_433_6
					end
				end

				arg_430_1.text_.text = var_433_10
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151105", "story_v_out_120151.awb") ~= 0 then
					local var_433_14 = manager.audio:GetVoiceLength("story_v_out_120151", "120151105", "story_v_out_120151.awb") / 1000

					if var_433_14 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_14 + var_433_6
					end

					if var_433_9.prefab_name ~= "" and arg_430_1.actors_[var_433_9.prefab_name] ~= nil then
						local var_433_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_9.prefab_name].transform, "story_v_out_120151", "120151105", "story_v_out_120151.awb")

						arg_430_1:RecordAudio("120151105", var_433_15)
						arg_430_1:RecordAudio("120151105", var_433_15)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_120151", "120151105", "story_v_out_120151.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_120151", "120151105", "story_v_out_120151.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_16 = math.max(var_433_7, arg_430_1.talkMaxDuration)

			if var_433_6 <= arg_430_1.time_ and arg_430_1.time_ < var_433_6 + var_433_16 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_6) / var_433_16

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_6 + var_433_16 and arg_430_1.time_ < var_433_6 + var_433_16 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play120151106 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 120151106
		arg_434_1.duration_ = 6.5

		local var_434_0 = {
			zh = 6.5,
			ja = 6.166
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
				arg_434_0:Play120151107(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["1184ui_story"]
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect1184ui_story == nil then
				arg_434_1.var_.characterEffect1184ui_story = var_437_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.2

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 and not isNil(var_437_0) then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2

				if arg_434_1.var_.characterEffect1184ui_story and not isNil(var_437_0) then
					arg_434_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect1184ui_story then
				arg_434_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_437_4 = arg_434_1.actors_["1184ui_story"].transform
			local var_437_5 = 0

			if var_437_5 < arg_434_1.time_ and arg_434_1.time_ <= var_437_5 + arg_437_0 then
				arg_434_1.var_.moveOldPos1184ui_story = var_437_4.localPosition
			end

			local var_437_6 = 0.001

			if var_437_5 <= arg_434_1.time_ and arg_434_1.time_ < var_437_5 + var_437_6 then
				local var_437_7 = (arg_434_1.time_ - var_437_5) / var_437_6
				local var_437_8 = Vector3.New(0, -0.97, -6)

				var_437_4.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1184ui_story, var_437_8, var_437_7)

				local var_437_9 = manager.ui.mainCamera.transform.position - var_437_4.position

				var_437_4.forward = Vector3.New(var_437_9.x, var_437_9.y, var_437_9.z)

				local var_437_10 = var_437_4.localEulerAngles

				var_437_10.z = 0
				var_437_10.x = 0
				var_437_4.localEulerAngles = var_437_10
			end

			if arg_434_1.time_ >= var_437_5 + var_437_6 and arg_434_1.time_ < var_437_5 + var_437_6 + arg_437_0 then
				var_437_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_437_11 = manager.ui.mainCamera.transform.position - var_437_4.position

				var_437_4.forward = Vector3.New(var_437_11.x, var_437_11.y, var_437_11.z)

				local var_437_12 = var_437_4.localEulerAngles

				var_437_12.z = 0
				var_437_12.x = 0
				var_437_4.localEulerAngles = var_437_12
			end

			local var_437_13 = arg_434_1.actors_["1076ui_story"].transform
			local var_437_14 = 0

			if var_437_14 < arg_434_1.time_ and arg_434_1.time_ <= var_437_14 + arg_437_0 then
				arg_434_1.var_.moveOldPos1076ui_story = var_437_13.localPosition
			end

			local var_437_15 = 0.001

			if var_437_14 <= arg_434_1.time_ and arg_434_1.time_ < var_437_14 + var_437_15 then
				local var_437_16 = (arg_434_1.time_ - var_437_14) / var_437_15
				local var_437_17 = Vector3.New(0, 100, 0)

				var_437_13.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1076ui_story, var_437_17, var_437_16)

				local var_437_18 = manager.ui.mainCamera.transform.position - var_437_13.position

				var_437_13.forward = Vector3.New(var_437_18.x, var_437_18.y, var_437_18.z)

				local var_437_19 = var_437_13.localEulerAngles

				var_437_19.z = 0
				var_437_19.x = 0
				var_437_13.localEulerAngles = var_437_19
			end

			if arg_434_1.time_ >= var_437_14 + var_437_15 and arg_434_1.time_ < var_437_14 + var_437_15 + arg_437_0 then
				var_437_13.localPosition = Vector3.New(0, 100, 0)

				local var_437_20 = manager.ui.mainCamera.transform.position - var_437_13.position

				var_437_13.forward = Vector3.New(var_437_20.x, var_437_20.y, var_437_20.z)

				local var_437_21 = var_437_13.localEulerAngles

				var_437_21.z = 0
				var_437_21.x = 0
				var_437_13.localEulerAngles = var_437_21
			end

			local var_437_22 = 0

			if var_437_22 < arg_434_1.time_ and arg_434_1.time_ <= var_437_22 + arg_437_0 then
				arg_434_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_437_23 = 0

			if var_437_23 < arg_434_1.time_ and arg_434_1.time_ <= var_437_23 + arg_437_0 then
				arg_434_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_437_24 = arg_434_1.actors_["1075ui_story"].transform
			local var_437_25 = 0

			if var_437_25 < arg_434_1.time_ and arg_434_1.time_ <= var_437_25 + arg_437_0 then
				arg_434_1.var_.moveOldPos1075ui_story = var_437_24.localPosition
			end

			local var_437_26 = 0.001

			if var_437_25 <= arg_434_1.time_ and arg_434_1.time_ < var_437_25 + var_437_26 then
				local var_437_27 = (arg_434_1.time_ - var_437_25) / var_437_26
				local var_437_28 = Vector3.New(0, 100, 0)

				var_437_24.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1075ui_story, var_437_28, var_437_27)

				local var_437_29 = manager.ui.mainCamera.transform.position - var_437_24.position

				var_437_24.forward = Vector3.New(var_437_29.x, var_437_29.y, var_437_29.z)

				local var_437_30 = var_437_24.localEulerAngles

				var_437_30.z = 0
				var_437_30.x = 0
				var_437_24.localEulerAngles = var_437_30
			end

			if arg_434_1.time_ >= var_437_25 + var_437_26 and arg_434_1.time_ < var_437_25 + var_437_26 + arg_437_0 then
				var_437_24.localPosition = Vector3.New(0, 100, 0)

				local var_437_31 = manager.ui.mainCamera.transform.position - var_437_24.position

				var_437_24.forward = Vector3.New(var_437_31.x, var_437_31.y, var_437_31.z)

				local var_437_32 = var_437_24.localEulerAngles

				var_437_32.z = 0
				var_437_32.x = 0
				var_437_24.localEulerAngles = var_437_32
			end

			local var_437_33 = 0
			local var_437_34 = 0.625

			if var_437_33 < arg_434_1.time_ and arg_434_1.time_ <= var_437_33 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_35 = arg_434_1:FormatText(StoryNameCfg[6].name)

				arg_434_1.leftNameTxt_.text = var_437_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_36 = arg_434_1:GetWordFromCfg(120151106)
				local var_437_37 = arg_434_1:FormatText(var_437_36.content)

				arg_434_1.text_.text = var_437_37

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_38 = 25
				local var_437_39 = utf8.len(var_437_37)
				local var_437_40 = var_437_38 <= 0 and var_437_34 or var_437_34 * (var_437_39 / var_437_38)

				if var_437_40 > 0 and var_437_34 < var_437_40 then
					arg_434_1.talkMaxDuration = var_437_40

					if var_437_40 + var_437_33 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_40 + var_437_33
					end
				end

				arg_434_1.text_.text = var_437_37
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151106", "story_v_out_120151.awb") ~= 0 then
					local var_437_41 = manager.audio:GetVoiceLength("story_v_out_120151", "120151106", "story_v_out_120151.awb") / 1000

					if var_437_41 + var_437_33 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_41 + var_437_33
					end

					if var_437_36.prefab_name ~= "" and arg_434_1.actors_[var_437_36.prefab_name] ~= nil then
						local var_437_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_36.prefab_name].transform, "story_v_out_120151", "120151106", "story_v_out_120151.awb")

						arg_434_1:RecordAudio("120151106", var_437_42)
						arg_434_1:RecordAudio("120151106", var_437_42)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_120151", "120151106", "story_v_out_120151.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_120151", "120151106", "story_v_out_120151.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_43 = math.max(var_437_34, arg_434_1.talkMaxDuration)

			if var_437_33 <= arg_434_1.time_ and arg_434_1.time_ < var_437_33 + var_437_43 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_33) / var_437_43

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_33 + var_437_43 and arg_434_1.time_ < var_437_33 + var_437_43 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play120151107 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 120151107
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play120151108(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["1184ui_story"].transform
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 then
				arg_438_1.var_.moveOldPos1184ui_story = var_441_0.localPosition
			end

			local var_441_2 = 0.001

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2
				local var_441_4 = Vector3.New(0, 100, 0)

				var_441_0.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1184ui_story, var_441_4, var_441_3)

				local var_441_5 = manager.ui.mainCamera.transform.position - var_441_0.position

				var_441_0.forward = Vector3.New(var_441_5.x, var_441_5.y, var_441_5.z)

				local var_441_6 = var_441_0.localEulerAngles

				var_441_6.z = 0
				var_441_6.x = 0
				var_441_0.localEulerAngles = var_441_6
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 then
				var_441_0.localPosition = Vector3.New(0, 100, 0)

				local var_441_7 = manager.ui.mainCamera.transform.position - var_441_0.position

				var_441_0.forward = Vector3.New(var_441_7.x, var_441_7.y, var_441_7.z)

				local var_441_8 = var_441_0.localEulerAngles

				var_441_8.z = 0
				var_441_8.x = 0
				var_441_0.localEulerAngles = var_441_8
			end

			local var_441_9 = 0
			local var_441_10 = 0.8

			if var_441_9 < arg_438_1.time_ and arg_438_1.time_ <= var_441_9 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_11 = arg_438_1:GetWordFromCfg(120151107)
				local var_441_12 = arg_438_1:FormatText(var_441_11.content)

				arg_438_1.text_.text = var_441_12

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_13 = 32
				local var_441_14 = utf8.len(var_441_12)
				local var_441_15 = var_441_13 <= 0 and var_441_10 or var_441_10 * (var_441_14 / var_441_13)

				if var_441_15 > 0 and var_441_10 < var_441_15 then
					arg_438_1.talkMaxDuration = var_441_15

					if var_441_15 + var_441_9 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_15 + var_441_9
					end
				end

				arg_438_1.text_.text = var_441_12
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_16 = math.max(var_441_10, arg_438_1.talkMaxDuration)

			if var_441_9 <= arg_438_1.time_ and arg_438_1.time_ < var_441_9 + var_441_16 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_9) / var_441_16

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_9 + var_441_16 and arg_438_1.time_ < var_441_9 + var_441_16 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play120151108 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 120151108
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play120151109(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0
			local var_445_1 = 1.35

			if var_445_0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, false)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_2 = arg_442_1:GetWordFromCfg(120151108)
				local var_445_3 = arg_442_1:FormatText(var_445_2.content)

				arg_442_1.text_.text = var_445_3

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_4 = 54
				local var_445_5 = utf8.len(var_445_3)
				local var_445_6 = var_445_4 <= 0 and var_445_1 or var_445_1 * (var_445_5 / var_445_4)

				if var_445_6 > 0 and var_445_1 < var_445_6 then
					arg_442_1.talkMaxDuration = var_445_6

					if var_445_6 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_6 + var_445_0
					end
				end

				arg_442_1.text_.text = var_445_3
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_7 = math.max(var_445_1, arg_442_1.talkMaxDuration)

			if var_445_0 <= arg_442_1.time_ and arg_442_1.time_ < var_445_0 + var_445_7 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_0) / var_445_7

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_0 + var_445_7 and arg_442_1.time_ < var_445_0 + var_445_7 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play120151109 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 120151109
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play120151110(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0
			local var_449_1 = 1.2

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_2 = arg_446_1:GetWordFromCfg(120151109)
				local var_449_3 = arg_446_1:FormatText(var_449_2.content)

				arg_446_1.text_.text = var_449_3

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_4 = 48
				local var_449_5 = utf8.len(var_449_3)
				local var_449_6 = var_449_4 <= 0 and var_449_1 or var_449_1 * (var_449_5 / var_449_4)

				if var_449_6 > 0 and var_449_1 < var_449_6 then
					arg_446_1.talkMaxDuration = var_449_6

					if var_449_6 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_6 + var_449_0
					end
				end

				arg_446_1.text_.text = var_449_3
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_7 = math.max(var_449_1, arg_446_1.talkMaxDuration)

			if var_449_0 <= arg_446_1.time_ and arg_446_1.time_ < var_449_0 + var_449_7 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_0) / var_449_7

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_0 + var_449_7 and arg_446_1.time_ < var_449_0 + var_449_7 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play120151110 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 120151110
		arg_450_1.duration_ = 4.43

		local var_450_0 = {
			zh = 4.133,
			ja = 4.433
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play120151111(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["1076ui_story"].transform
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.var_.moveOldPos1076ui_story = var_453_0.localPosition
			end

			local var_453_2 = 0.001

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2
				local var_453_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_453_0.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1076ui_story, var_453_4, var_453_3)

				local var_453_5 = manager.ui.mainCamera.transform.position - var_453_0.position

				var_453_0.forward = Vector3.New(var_453_5.x, var_453_5.y, var_453_5.z)

				local var_453_6 = var_453_0.localEulerAngles

				var_453_6.z = 0
				var_453_6.x = 0
				var_453_0.localEulerAngles = var_453_6
			end

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 then
				var_453_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_453_7 = manager.ui.mainCamera.transform.position - var_453_0.position

				var_453_0.forward = Vector3.New(var_453_7.x, var_453_7.y, var_453_7.z)

				local var_453_8 = var_453_0.localEulerAngles

				var_453_8.z = 0
				var_453_8.x = 0
				var_453_0.localEulerAngles = var_453_8
			end

			local var_453_9 = arg_450_1.actors_["1029ui_story"].transform
			local var_453_10 = 0

			if var_453_10 < arg_450_1.time_ and arg_450_1.time_ <= var_453_10 + arg_453_0 then
				arg_450_1.var_.moveOldPos1029ui_story = var_453_9.localPosition
			end

			local var_453_11 = 0.001

			if var_453_10 <= arg_450_1.time_ and arg_450_1.time_ < var_453_10 + var_453_11 then
				local var_453_12 = (arg_450_1.time_ - var_453_10) / var_453_11
				local var_453_13 = Vector3.New(0.7, -1.09, -6.2)

				var_453_9.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1029ui_story, var_453_13, var_453_12)

				local var_453_14 = manager.ui.mainCamera.transform.position - var_453_9.position

				var_453_9.forward = Vector3.New(var_453_14.x, var_453_14.y, var_453_14.z)

				local var_453_15 = var_453_9.localEulerAngles

				var_453_15.z = 0
				var_453_15.x = 0
				var_453_9.localEulerAngles = var_453_15
			end

			if arg_450_1.time_ >= var_453_10 + var_453_11 and arg_450_1.time_ < var_453_10 + var_453_11 + arg_453_0 then
				var_453_9.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_453_16 = manager.ui.mainCamera.transform.position - var_453_9.position

				var_453_9.forward = Vector3.New(var_453_16.x, var_453_16.y, var_453_16.z)

				local var_453_17 = var_453_9.localEulerAngles

				var_453_17.z = 0
				var_453_17.x = 0
				var_453_9.localEulerAngles = var_453_17
			end

			local var_453_18 = 0

			if var_453_18 < arg_450_1.time_ and arg_450_1.time_ <= var_453_18 + arg_453_0 then
				arg_450_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_453_19 = 0

			if var_453_19 < arg_450_1.time_ and arg_450_1.time_ <= var_453_19 + arg_453_0 then
				arg_450_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_453_20 = arg_450_1.actors_["1029ui_story"]
			local var_453_21 = 0

			if var_453_21 < arg_450_1.time_ and arg_450_1.time_ <= var_453_21 + arg_453_0 and not isNil(var_453_20) and arg_450_1.var_.characterEffect1029ui_story == nil then
				arg_450_1.var_.characterEffect1029ui_story = var_453_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_22 = 0.2

			if var_453_21 <= arg_450_1.time_ and arg_450_1.time_ < var_453_21 + var_453_22 and not isNil(var_453_20) then
				local var_453_23 = (arg_450_1.time_ - var_453_21) / var_453_22

				if arg_450_1.var_.characterEffect1029ui_story and not isNil(var_453_20) then
					arg_450_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_450_1.time_ >= var_453_21 + var_453_22 and arg_450_1.time_ < var_453_21 + var_453_22 + arg_453_0 and not isNil(var_453_20) and arg_450_1.var_.characterEffect1029ui_story then
				arg_450_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_453_24 = arg_450_1.actors_["1076ui_story"]
			local var_453_25 = 0

			if var_453_25 < arg_450_1.time_ and arg_450_1.time_ <= var_453_25 + arg_453_0 and not isNil(var_453_24) and arg_450_1.var_.characterEffect1076ui_story == nil then
				arg_450_1.var_.characterEffect1076ui_story = var_453_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_26 = 0.034

			if var_453_25 <= arg_450_1.time_ and arg_450_1.time_ < var_453_25 + var_453_26 and not isNil(var_453_24) then
				local var_453_27 = (arg_450_1.time_ - var_453_25) / var_453_26

				if arg_450_1.var_.characterEffect1076ui_story and not isNil(var_453_24) then
					local var_453_28 = Mathf.Lerp(0, 0.5, var_453_27)

					arg_450_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_450_1.var_.characterEffect1076ui_story.fillRatio = var_453_28
				end
			end

			if arg_450_1.time_ >= var_453_25 + var_453_26 and arg_450_1.time_ < var_453_25 + var_453_26 + arg_453_0 and not isNil(var_453_24) and arg_450_1.var_.characterEffect1076ui_story then
				local var_453_29 = 0.5

				arg_450_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_450_1.var_.characterEffect1076ui_story.fillRatio = var_453_29
			end

			local var_453_30 = 0

			if var_453_30 < arg_450_1.time_ and arg_450_1.time_ <= var_453_30 + arg_453_0 then
				arg_450_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_453_31 = 0
			local var_453_32 = 0.475

			if var_453_31 < arg_450_1.time_ and arg_450_1.time_ <= var_453_31 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_33 = arg_450_1:FormatText(StoryNameCfg[319].name)

				arg_450_1.leftNameTxt_.text = var_453_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_34 = arg_450_1:GetWordFromCfg(120151110)
				local var_453_35 = arg_450_1:FormatText(var_453_34.content)

				arg_450_1.text_.text = var_453_35

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_36 = 19
				local var_453_37 = utf8.len(var_453_35)
				local var_453_38 = var_453_36 <= 0 and var_453_32 or var_453_32 * (var_453_37 / var_453_36)

				if var_453_38 > 0 and var_453_32 < var_453_38 then
					arg_450_1.talkMaxDuration = var_453_38

					if var_453_38 + var_453_31 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_38 + var_453_31
					end
				end

				arg_450_1.text_.text = var_453_35
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151110", "story_v_out_120151.awb") ~= 0 then
					local var_453_39 = manager.audio:GetVoiceLength("story_v_out_120151", "120151110", "story_v_out_120151.awb") / 1000

					if var_453_39 + var_453_31 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_39 + var_453_31
					end

					if var_453_34.prefab_name ~= "" and arg_450_1.actors_[var_453_34.prefab_name] ~= nil then
						local var_453_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_34.prefab_name].transform, "story_v_out_120151", "120151110", "story_v_out_120151.awb")

						arg_450_1:RecordAudio("120151110", var_453_40)
						arg_450_1:RecordAudio("120151110", var_453_40)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_120151", "120151110", "story_v_out_120151.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_120151", "120151110", "story_v_out_120151.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_41 = math.max(var_453_32, arg_450_1.talkMaxDuration)

			if var_453_31 <= arg_450_1.time_ and arg_450_1.time_ < var_453_31 + var_453_41 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_31) / var_453_41

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_31 + var_453_41 and arg_450_1.time_ < var_453_31 + var_453_41 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_450_1:InitPlayNodeList()
	end,
	Play120151111 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 120151111
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play120151112(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["1029ui_story"]
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1029ui_story == nil then
				arg_454_1.var_.characterEffect1029ui_story = var_457_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_2 = 0.2

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_2 and not isNil(var_457_0) then
				local var_457_3 = (arg_454_1.time_ - var_457_1) / var_457_2

				if arg_454_1.var_.characterEffect1029ui_story and not isNil(var_457_0) then
					local var_457_4 = Mathf.Lerp(0, 0.5, var_457_3)

					arg_454_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_454_1.var_.characterEffect1029ui_story.fillRatio = var_457_4
				end
			end

			if arg_454_1.time_ >= var_457_1 + var_457_2 and arg_454_1.time_ < var_457_1 + var_457_2 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1029ui_story then
				local var_457_5 = 0.5

				arg_454_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_454_1.var_.characterEffect1029ui_story.fillRatio = var_457_5
			end

			local var_457_6 = 0
			local var_457_7 = 0.175

			if var_457_6 < arg_454_1.time_ and arg_454_1.time_ <= var_457_6 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_8 = arg_454_1:FormatText(StoryNameCfg[7].name)

				arg_454_1.leftNameTxt_.text = var_457_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_9 = arg_454_1:GetWordFromCfg(120151111)
				local var_457_10 = arg_454_1:FormatText(var_457_9.content)

				arg_454_1.text_.text = var_457_10

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_11 = 7
				local var_457_12 = utf8.len(var_457_10)
				local var_457_13 = var_457_11 <= 0 and var_457_7 or var_457_7 * (var_457_12 / var_457_11)

				if var_457_13 > 0 and var_457_7 < var_457_13 then
					arg_454_1.talkMaxDuration = var_457_13

					if var_457_13 + var_457_6 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_13 + var_457_6
					end
				end

				arg_454_1.text_.text = var_457_10
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_14 = math.max(var_457_7, arg_454_1.talkMaxDuration)

			if var_457_6 <= arg_454_1.time_ and arg_454_1.time_ < var_457_6 + var_457_14 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_6) / var_457_14

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_6 + var_457_14 and arg_454_1.time_ < var_457_6 + var_457_14 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play120151112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 120151112
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play120151113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 0
			local var_461_1 = 0.55

			if var_461_0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_0 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_2 = arg_458_1:GetWordFromCfg(120151112)
				local var_461_3 = arg_458_1:FormatText(var_461_2.content)

				arg_458_1.text_.text = var_461_3

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_4 = 22
				local var_461_5 = utf8.len(var_461_3)
				local var_461_6 = var_461_4 <= 0 and var_461_1 or var_461_1 * (var_461_5 / var_461_4)

				if var_461_6 > 0 and var_461_1 < var_461_6 then
					arg_458_1.talkMaxDuration = var_461_6

					if var_461_6 + var_461_0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_6 + var_461_0
					end
				end

				arg_458_1.text_.text = var_461_3
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_7 = math.max(var_461_1, arg_458_1.talkMaxDuration)

			if var_461_0 <= arg_458_1.time_ and arg_458_1.time_ < var_461_0 + var_461_7 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_0) / var_461_7

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_0 + var_461_7 and arg_458_1.time_ < var_461_0 + var_461_7 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play120151113 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 120151113
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play120151114(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["1029ui_story"].transform
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.var_.moveOldPos1029ui_story = var_465_0.localPosition
			end

			local var_465_2 = 0.001

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2
				local var_465_4 = Vector3.New(0, 100, 0)

				var_465_0.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos1029ui_story, var_465_4, var_465_3)

				local var_465_5 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_5.x, var_465_5.y, var_465_5.z)

				local var_465_6 = var_465_0.localEulerAngles

				var_465_6.z = 0
				var_465_6.x = 0
				var_465_0.localEulerAngles = var_465_6
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 then
				var_465_0.localPosition = Vector3.New(0, 100, 0)

				local var_465_7 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_7.x, var_465_7.y, var_465_7.z)

				local var_465_8 = var_465_0.localEulerAngles

				var_465_8.z = 0
				var_465_8.x = 0
				var_465_0.localEulerAngles = var_465_8
			end

			local var_465_9 = arg_462_1.actors_["1076ui_story"].transform
			local var_465_10 = 0

			if var_465_10 < arg_462_1.time_ and arg_462_1.time_ <= var_465_10 + arg_465_0 then
				arg_462_1.var_.moveOldPos1076ui_story = var_465_9.localPosition
			end

			local var_465_11 = 0.001

			if var_465_10 <= arg_462_1.time_ and arg_462_1.time_ < var_465_10 + var_465_11 then
				local var_465_12 = (arg_462_1.time_ - var_465_10) / var_465_11
				local var_465_13 = Vector3.New(0, 100, 0)

				var_465_9.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos1076ui_story, var_465_13, var_465_12)

				local var_465_14 = manager.ui.mainCamera.transform.position - var_465_9.position

				var_465_9.forward = Vector3.New(var_465_14.x, var_465_14.y, var_465_14.z)

				local var_465_15 = var_465_9.localEulerAngles

				var_465_15.z = 0
				var_465_15.x = 0
				var_465_9.localEulerAngles = var_465_15
			end

			if arg_462_1.time_ >= var_465_10 + var_465_11 and arg_462_1.time_ < var_465_10 + var_465_11 + arg_465_0 then
				var_465_9.localPosition = Vector3.New(0, 100, 0)

				local var_465_16 = manager.ui.mainCamera.transform.position - var_465_9.position

				var_465_9.forward = Vector3.New(var_465_16.x, var_465_16.y, var_465_16.z)

				local var_465_17 = var_465_9.localEulerAngles

				var_465_17.z = 0
				var_465_17.x = 0
				var_465_9.localEulerAngles = var_465_17
			end

			local var_465_18 = 0
			local var_465_19 = 1.075

			if var_465_18 < arg_462_1.time_ and arg_462_1.time_ <= var_465_18 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, false)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_20 = arg_462_1:GetWordFromCfg(120151113)
				local var_465_21 = arg_462_1:FormatText(var_465_20.content)

				arg_462_1.text_.text = var_465_21

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_22 = 43
				local var_465_23 = utf8.len(var_465_21)
				local var_465_24 = var_465_22 <= 0 and var_465_19 or var_465_19 * (var_465_23 / var_465_22)

				if var_465_24 > 0 and var_465_19 < var_465_24 then
					arg_462_1.talkMaxDuration = var_465_24

					if var_465_24 + var_465_18 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_24 + var_465_18
					end
				end

				arg_462_1.text_.text = var_465_21
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_25 = math.max(var_465_19, arg_462_1.talkMaxDuration)

			if var_465_18 <= arg_462_1.time_ and arg_462_1.time_ < var_465_18 + var_465_25 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_18) / var_465_25

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_18 + var_465_25 and arg_462_1.time_ < var_465_18 + var_465_25 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
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

		arg_462_1:InitPlayNodeList()
	end,
	Play120151114 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 120151114
		arg_466_1.duration_ = 4

		local var_466_0 = {
			zh = 4,
			ja = 3.8
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play120151115(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["1076ui_story"].transform
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 then
				arg_466_1.var_.moveOldPos1076ui_story = var_469_0.localPosition
			end

			local var_469_2 = 0.001

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2
				local var_469_4 = Vector3.New(0, -1.06, -6.2)

				var_469_0.localPosition = Vector3.Lerp(arg_466_1.var_.moveOldPos1076ui_story, var_469_4, var_469_3)

				local var_469_5 = manager.ui.mainCamera.transform.position - var_469_0.position

				var_469_0.forward = Vector3.New(var_469_5.x, var_469_5.y, var_469_5.z)

				local var_469_6 = var_469_0.localEulerAngles

				var_469_6.z = 0
				var_469_6.x = 0
				var_469_0.localEulerAngles = var_469_6
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 then
				var_469_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_469_7 = manager.ui.mainCamera.transform.position - var_469_0.position

				var_469_0.forward = Vector3.New(var_469_7.x, var_469_7.y, var_469_7.z)

				local var_469_8 = var_469_0.localEulerAngles

				var_469_8.z = 0
				var_469_8.x = 0
				var_469_0.localEulerAngles = var_469_8
			end

			local var_469_9 = 0

			if var_469_9 < arg_466_1.time_ and arg_466_1.time_ <= var_469_9 + arg_469_0 then
				arg_466_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action6_1")
			end

			local var_469_10 = 0

			if var_469_10 < arg_466_1.time_ and arg_466_1.time_ <= var_469_10 + arg_469_0 then
				arg_466_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_469_11 = arg_466_1.actors_["1076ui_story"]
			local var_469_12 = 0

			if var_469_12 < arg_466_1.time_ and arg_466_1.time_ <= var_469_12 + arg_469_0 and not isNil(var_469_11) and arg_466_1.var_.characterEffect1076ui_story == nil then
				arg_466_1.var_.characterEffect1076ui_story = var_469_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_13 = 0.2

			if var_469_12 <= arg_466_1.time_ and arg_466_1.time_ < var_469_12 + var_469_13 and not isNil(var_469_11) then
				local var_469_14 = (arg_466_1.time_ - var_469_12) / var_469_13

				if arg_466_1.var_.characterEffect1076ui_story and not isNil(var_469_11) then
					arg_466_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= var_469_12 + var_469_13 and arg_466_1.time_ < var_469_12 + var_469_13 + arg_469_0 and not isNil(var_469_11) and arg_466_1.var_.characterEffect1076ui_story then
				arg_466_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_469_15 = 0
			local var_469_16 = 0.3

			if var_469_15 < arg_466_1.time_ and arg_466_1.time_ <= var_469_15 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_17 = arg_466_1:FormatText(StoryNameCfg[389].name)

				arg_466_1.leftNameTxt_.text = var_469_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_18 = arg_466_1:GetWordFromCfg(120151114)
				local var_469_19 = arg_466_1:FormatText(var_469_18.content)

				arg_466_1.text_.text = var_469_19

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_20 = 12
				local var_469_21 = utf8.len(var_469_19)
				local var_469_22 = var_469_20 <= 0 and var_469_16 or var_469_16 * (var_469_21 / var_469_20)

				if var_469_22 > 0 and var_469_16 < var_469_22 then
					arg_466_1.talkMaxDuration = var_469_22

					if var_469_22 + var_469_15 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_22 + var_469_15
					end
				end

				arg_466_1.text_.text = var_469_19
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151114", "story_v_out_120151.awb") ~= 0 then
					local var_469_23 = manager.audio:GetVoiceLength("story_v_out_120151", "120151114", "story_v_out_120151.awb") / 1000

					if var_469_23 + var_469_15 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_23 + var_469_15
					end

					if var_469_18.prefab_name ~= "" and arg_466_1.actors_[var_469_18.prefab_name] ~= nil then
						local var_469_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_18.prefab_name].transform, "story_v_out_120151", "120151114", "story_v_out_120151.awb")

						arg_466_1:RecordAudio("120151114", var_469_24)
						arg_466_1:RecordAudio("120151114", var_469_24)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_120151", "120151114", "story_v_out_120151.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_120151", "120151114", "story_v_out_120151.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_25 = math.max(var_469_16, arg_466_1.talkMaxDuration)

			if var_469_15 <= arg_466_1.time_ and arg_466_1.time_ < var_469_15 + var_469_25 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_15) / var_469_25

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_15 + var_469_25 and arg_466_1.time_ < var_469_15 + var_469_25 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {
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

		arg_466_1:InitPlayNodeList()
	end,
	Play120151115 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 120151115
		arg_470_1.duration_ = 11.53

		local var_470_0 = {
			zh = 5.366,
			ja = 11.533
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play120151116(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0

			if var_473_0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_0 + arg_473_0 then
				arg_470_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_473_1 = 0
			local var_473_2 = 0.525

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_3 = arg_470_1:FormatText(StoryNameCfg[389].name)

				arg_470_1.leftNameTxt_.text = var_473_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_4 = arg_470_1:GetWordFromCfg(120151115)
				local var_473_5 = arg_470_1:FormatText(var_473_4.content)

				arg_470_1.text_.text = var_473_5

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_6 = 21
				local var_473_7 = utf8.len(var_473_5)
				local var_473_8 = var_473_6 <= 0 and var_473_2 or var_473_2 * (var_473_7 / var_473_6)

				if var_473_8 > 0 and var_473_2 < var_473_8 then
					arg_470_1.talkMaxDuration = var_473_8

					if var_473_8 + var_473_1 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_8 + var_473_1
					end
				end

				arg_470_1.text_.text = var_473_5
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151115", "story_v_out_120151.awb") ~= 0 then
					local var_473_9 = manager.audio:GetVoiceLength("story_v_out_120151", "120151115", "story_v_out_120151.awb") / 1000

					if var_473_9 + var_473_1 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_9 + var_473_1
					end

					if var_473_4.prefab_name ~= "" and arg_470_1.actors_[var_473_4.prefab_name] ~= nil then
						local var_473_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_4.prefab_name].transform, "story_v_out_120151", "120151115", "story_v_out_120151.awb")

						arg_470_1:RecordAudio("120151115", var_473_10)
						arg_470_1:RecordAudio("120151115", var_473_10)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_120151", "120151115", "story_v_out_120151.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_120151", "120151115", "story_v_out_120151.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_11 = math.max(var_473_2, arg_470_1.talkMaxDuration)

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_11 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_1) / var_473_11

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_1 + var_473_11 and arg_470_1.time_ < var_473_1 + var_473_11 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play120151116 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 120151116
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play120151117(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["1076ui_story"].transform
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.var_.moveOldPos1076ui_story = var_477_0.localPosition
			end

			local var_477_2 = 0.001

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2
				local var_477_4 = Vector3.New(0, 100, 0)

				var_477_0.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1076ui_story, var_477_4, var_477_3)

				local var_477_5 = manager.ui.mainCamera.transform.position - var_477_0.position

				var_477_0.forward = Vector3.New(var_477_5.x, var_477_5.y, var_477_5.z)

				local var_477_6 = var_477_0.localEulerAngles

				var_477_6.z = 0
				var_477_6.x = 0
				var_477_0.localEulerAngles = var_477_6
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 then
				var_477_0.localPosition = Vector3.New(0, 100, 0)

				local var_477_7 = manager.ui.mainCamera.transform.position - var_477_0.position

				var_477_0.forward = Vector3.New(var_477_7.x, var_477_7.y, var_477_7.z)

				local var_477_8 = var_477_0.localEulerAngles

				var_477_8.z = 0
				var_477_8.x = 0
				var_477_0.localEulerAngles = var_477_8
			end

			local var_477_9 = 0
			local var_477_10 = 0.775

			if var_477_9 < arg_474_1.time_ and arg_474_1.time_ <= var_477_9 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_11 = arg_474_1:GetWordFromCfg(120151116)
				local var_477_12 = arg_474_1:FormatText(var_477_11.content)

				arg_474_1.text_.text = var_477_12

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_13 = 31
				local var_477_14 = utf8.len(var_477_12)
				local var_477_15 = var_477_13 <= 0 and var_477_10 or var_477_10 * (var_477_14 / var_477_13)

				if var_477_15 > 0 and var_477_10 < var_477_15 then
					arg_474_1.talkMaxDuration = var_477_15

					if var_477_15 + var_477_9 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_15 + var_477_9
					end
				end

				arg_474_1.text_.text = var_477_12
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_16 = math.max(var_477_10, arg_474_1.talkMaxDuration)

			if var_477_9 <= arg_474_1.time_ and arg_474_1.time_ < var_477_9 + var_477_16 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_9) / var_477_16

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_9 + var_477_16 and arg_474_1.time_ < var_477_9 + var_477_16 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
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

		arg_474_1:InitPlayNodeList()
	end,
	Play120151117 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 120151117
		arg_478_1.duration_ = 7.07

		local var_478_0 = {
			zh = 5.1,
			ja = 7.066
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play120151118(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = arg_478_1.actors_["1075ui_story"].transform
			local var_481_1 = 0

			if var_481_1 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 then
				arg_478_1.var_.moveOldPos1075ui_story = var_481_0.localPosition
			end

			local var_481_2 = 0.001

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_2 then
				local var_481_3 = (arg_478_1.time_ - var_481_1) / var_481_2
				local var_481_4 = Vector3.New(0.7, -1.055, -6.16)

				var_481_0.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1075ui_story, var_481_4, var_481_3)

				local var_481_5 = manager.ui.mainCamera.transform.position - var_481_0.position

				var_481_0.forward = Vector3.New(var_481_5.x, var_481_5.y, var_481_5.z)

				local var_481_6 = var_481_0.localEulerAngles

				var_481_6.z = 0
				var_481_6.x = 0
				var_481_0.localEulerAngles = var_481_6
			end

			if arg_478_1.time_ >= var_481_1 + var_481_2 and arg_478_1.time_ < var_481_1 + var_481_2 + arg_481_0 then
				var_481_0.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_481_7 = manager.ui.mainCamera.transform.position - var_481_0.position

				var_481_0.forward = Vector3.New(var_481_7.x, var_481_7.y, var_481_7.z)

				local var_481_8 = var_481_0.localEulerAngles

				var_481_8.z = 0
				var_481_8.x = 0
				var_481_0.localEulerAngles = var_481_8
			end

			local var_481_9 = 0

			if var_481_9 < arg_478_1.time_ and arg_478_1.time_ <= var_481_9 + arg_481_0 then
				arg_478_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_481_10 = 0

			if var_481_10 < arg_478_1.time_ and arg_478_1.time_ <= var_481_10 + arg_481_0 then
				arg_478_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_481_11 = arg_478_1.actors_["1075ui_story"]
			local var_481_12 = 0

			if var_481_12 < arg_478_1.time_ and arg_478_1.time_ <= var_481_12 + arg_481_0 and not isNil(var_481_11) and arg_478_1.var_.characterEffect1075ui_story == nil then
				arg_478_1.var_.characterEffect1075ui_story = var_481_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_13 = 0.2

			if var_481_12 <= arg_478_1.time_ and arg_478_1.time_ < var_481_12 + var_481_13 and not isNil(var_481_11) then
				local var_481_14 = (arg_478_1.time_ - var_481_12) / var_481_13

				if arg_478_1.var_.characterEffect1075ui_story and not isNil(var_481_11) then
					arg_478_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= var_481_12 + var_481_13 and arg_478_1.time_ < var_481_12 + var_481_13 + arg_481_0 and not isNil(var_481_11) and arg_478_1.var_.characterEffect1075ui_story then
				arg_478_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_481_15 = arg_478_1.actors_["1076ui_story"].transform
			local var_481_16 = 0

			if var_481_16 < arg_478_1.time_ and arg_478_1.time_ <= var_481_16 + arg_481_0 then
				arg_478_1.var_.moveOldPos1076ui_story = var_481_15.localPosition
			end

			local var_481_17 = 0.001

			if var_481_16 <= arg_478_1.time_ and arg_478_1.time_ < var_481_16 + var_481_17 then
				local var_481_18 = (arg_478_1.time_ - var_481_16) / var_481_17
				local var_481_19 = Vector3.New(-0.7, -1.06, -6.2)

				var_481_15.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos1076ui_story, var_481_19, var_481_18)

				local var_481_20 = manager.ui.mainCamera.transform.position - var_481_15.position

				var_481_15.forward = Vector3.New(var_481_20.x, var_481_20.y, var_481_20.z)

				local var_481_21 = var_481_15.localEulerAngles

				var_481_21.z = 0
				var_481_21.x = 0
				var_481_15.localEulerAngles = var_481_21
			end

			if arg_478_1.time_ >= var_481_16 + var_481_17 and arg_478_1.time_ < var_481_16 + var_481_17 + arg_481_0 then
				var_481_15.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_481_22 = manager.ui.mainCamera.transform.position - var_481_15.position

				var_481_15.forward = Vector3.New(var_481_22.x, var_481_22.y, var_481_22.z)

				local var_481_23 = var_481_15.localEulerAngles

				var_481_23.z = 0
				var_481_23.x = 0
				var_481_15.localEulerAngles = var_481_23
			end

			local var_481_24 = arg_478_1.actors_["1076ui_story"]
			local var_481_25 = 0

			if var_481_25 < arg_478_1.time_ and arg_478_1.time_ <= var_481_25 + arg_481_0 and not isNil(var_481_24) and arg_478_1.var_.characterEffect1076ui_story == nil then
				arg_478_1.var_.characterEffect1076ui_story = var_481_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_26 = 0.0166666666666667

			if var_481_25 <= arg_478_1.time_ and arg_478_1.time_ < var_481_25 + var_481_26 and not isNil(var_481_24) then
				local var_481_27 = (arg_478_1.time_ - var_481_25) / var_481_26

				if arg_478_1.var_.characterEffect1076ui_story and not isNil(var_481_24) then
					local var_481_28 = Mathf.Lerp(0, 0.5, var_481_27)

					arg_478_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_478_1.var_.characterEffect1076ui_story.fillRatio = var_481_28
				end
			end

			if arg_478_1.time_ >= var_481_25 + var_481_26 and arg_478_1.time_ < var_481_25 + var_481_26 + arg_481_0 and not isNil(var_481_24) and arg_478_1.var_.characterEffect1076ui_story then
				local var_481_29 = 0.5

				arg_478_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_478_1.var_.characterEffect1076ui_story.fillRatio = var_481_29
			end

			local var_481_30 = 0

			if var_481_30 < arg_478_1.time_ and arg_478_1.time_ <= var_481_30 + arg_481_0 then
				arg_478_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_481_31 = 0
			local var_481_32 = 0.6

			if var_481_31 < arg_478_1.time_ and arg_478_1.time_ <= var_481_31 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_33 = arg_478_1:FormatText(StoryNameCfg[381].name)

				arg_478_1.leftNameTxt_.text = var_481_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_34 = arg_478_1:GetWordFromCfg(120151117)
				local var_481_35 = arg_478_1:FormatText(var_481_34.content)

				arg_478_1.text_.text = var_481_35

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_36 = 24
				local var_481_37 = utf8.len(var_481_35)
				local var_481_38 = var_481_36 <= 0 and var_481_32 or var_481_32 * (var_481_37 / var_481_36)

				if var_481_38 > 0 and var_481_32 < var_481_38 then
					arg_478_1.talkMaxDuration = var_481_38

					if var_481_38 + var_481_31 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_38 + var_481_31
					end
				end

				arg_478_1.text_.text = var_481_35
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151117", "story_v_out_120151.awb") ~= 0 then
					local var_481_39 = manager.audio:GetVoiceLength("story_v_out_120151", "120151117", "story_v_out_120151.awb") / 1000

					if var_481_39 + var_481_31 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_39 + var_481_31
					end

					if var_481_34.prefab_name ~= "" and arg_478_1.actors_[var_481_34.prefab_name] ~= nil then
						local var_481_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_34.prefab_name].transform, "story_v_out_120151", "120151117", "story_v_out_120151.awb")

						arg_478_1:RecordAudio("120151117", var_481_40)
						arg_478_1:RecordAudio("120151117", var_481_40)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_120151", "120151117", "story_v_out_120151.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_120151", "120151117", "story_v_out_120151.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_41 = math.max(var_481_32, arg_478_1.talkMaxDuration)

			if var_481_31 <= arg_478_1.time_ and arg_478_1.time_ < var_481_31 + var_481_41 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_31) / var_481_41

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_31 + var_481_41 and arg_478_1.time_ < var_481_31 + var_481_41 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
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

		arg_478_1:InitPlayNodeList()
	end,
	Play120151118 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 120151118
		arg_482_1.duration_ = 11.2

		local var_482_0 = {
			zh = 6.8,
			ja = 11.2
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play120151119(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = arg_482_1.actors_["1075ui_story"]
			local var_485_1 = 0

			if var_485_1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.characterEffect1075ui_story == nil then
				arg_482_1.var_.characterEffect1075ui_story = var_485_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_2 = 0.2

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_2 and not isNil(var_485_0) then
				local var_485_3 = (arg_482_1.time_ - var_485_1) / var_485_2

				if arg_482_1.var_.characterEffect1075ui_story and not isNil(var_485_0) then
					local var_485_4 = Mathf.Lerp(0, 0.5, var_485_3)

					arg_482_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_482_1.var_.characterEffect1075ui_story.fillRatio = var_485_4
				end
			end

			if arg_482_1.time_ >= var_485_1 + var_485_2 and arg_482_1.time_ < var_485_1 + var_485_2 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.characterEffect1075ui_story then
				local var_485_5 = 0.5

				arg_482_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_482_1.var_.characterEffect1075ui_story.fillRatio = var_485_5
			end

			local var_485_6 = 0

			if var_485_6 < arg_482_1.time_ and arg_482_1.time_ <= var_485_6 + arg_485_0 then
				arg_482_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_485_7 = 0

			if var_485_7 < arg_482_1.time_ and arg_482_1.time_ <= var_485_7 + arg_485_0 then
				arg_482_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_485_8 = arg_482_1.actors_["1076ui_story"]
			local var_485_9 = 0

			if var_485_9 < arg_482_1.time_ and arg_482_1.time_ <= var_485_9 + arg_485_0 and not isNil(var_485_8) and arg_482_1.var_.characterEffect1076ui_story == nil then
				arg_482_1.var_.characterEffect1076ui_story = var_485_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_10 = 0.2

			if var_485_9 <= arg_482_1.time_ and arg_482_1.time_ < var_485_9 + var_485_10 and not isNil(var_485_8) then
				local var_485_11 = (arg_482_1.time_ - var_485_9) / var_485_10

				if arg_482_1.var_.characterEffect1076ui_story and not isNil(var_485_8) then
					arg_482_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_482_1.time_ >= var_485_9 + var_485_10 and arg_482_1.time_ < var_485_9 + var_485_10 + arg_485_0 and not isNil(var_485_8) and arg_482_1.var_.characterEffect1076ui_story then
				arg_482_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_485_12 = 0
			local var_485_13 = 0.625

			if var_485_12 < arg_482_1.time_ and arg_482_1.time_ <= var_485_12 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_14 = arg_482_1:FormatText(StoryNameCfg[389].name)

				arg_482_1.leftNameTxt_.text = var_485_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_15 = arg_482_1:GetWordFromCfg(120151118)
				local var_485_16 = arg_482_1:FormatText(var_485_15.content)

				arg_482_1.text_.text = var_485_16

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_17 = 25
				local var_485_18 = utf8.len(var_485_16)
				local var_485_19 = var_485_17 <= 0 and var_485_13 or var_485_13 * (var_485_18 / var_485_17)

				if var_485_19 > 0 and var_485_13 < var_485_19 then
					arg_482_1.talkMaxDuration = var_485_19

					if var_485_19 + var_485_12 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_19 + var_485_12
					end
				end

				arg_482_1.text_.text = var_485_16
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151118", "story_v_out_120151.awb") ~= 0 then
					local var_485_20 = manager.audio:GetVoiceLength("story_v_out_120151", "120151118", "story_v_out_120151.awb") / 1000

					if var_485_20 + var_485_12 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_20 + var_485_12
					end

					if var_485_15.prefab_name ~= "" and arg_482_1.actors_[var_485_15.prefab_name] ~= nil then
						local var_485_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_15.prefab_name].transform, "story_v_out_120151", "120151118", "story_v_out_120151.awb")

						arg_482_1:RecordAudio("120151118", var_485_21)
						arg_482_1:RecordAudio("120151118", var_485_21)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_120151", "120151118", "story_v_out_120151.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_120151", "120151118", "story_v_out_120151.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_22 = math.max(var_485_13, arg_482_1.talkMaxDuration)

			if var_485_12 <= arg_482_1.time_ and arg_482_1.time_ < var_485_12 + var_485_22 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_12) / var_485_22

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_12 + var_485_22 and arg_482_1.time_ < var_485_12 + var_485_22 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play120151119 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 120151119
		arg_486_1.duration_ = 4.17

		local var_486_0 = {
			zh = 4.166,
			ja = 2.566
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play120151120(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["1076ui_story"]
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.characterEffect1076ui_story == nil then
				arg_486_1.var_.characterEffect1076ui_story = var_489_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_2 = 0.2

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_2 and not isNil(var_489_0) then
				local var_489_3 = (arg_486_1.time_ - var_489_1) / var_489_2

				if arg_486_1.var_.characterEffect1076ui_story and not isNil(var_489_0) then
					local var_489_4 = Mathf.Lerp(0, 0.5, var_489_3)

					arg_486_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_486_1.var_.characterEffect1076ui_story.fillRatio = var_489_4
				end
			end

			if arg_486_1.time_ >= var_489_1 + var_489_2 and arg_486_1.time_ < var_489_1 + var_489_2 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.characterEffect1076ui_story then
				local var_489_5 = 0.5

				arg_486_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_486_1.var_.characterEffect1076ui_story.fillRatio = var_489_5
			end

			local var_489_6 = arg_486_1.actors_["1075ui_story"]
			local var_489_7 = 0

			if var_489_7 < arg_486_1.time_ and arg_486_1.time_ <= var_489_7 + arg_489_0 and not isNil(var_489_6) and arg_486_1.var_.characterEffect1075ui_story == nil then
				arg_486_1.var_.characterEffect1075ui_story = var_489_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_8 = 0.2

			if var_489_7 <= arg_486_1.time_ and arg_486_1.time_ < var_489_7 + var_489_8 and not isNil(var_489_6) then
				local var_489_9 = (arg_486_1.time_ - var_489_7) / var_489_8

				if arg_486_1.var_.characterEffect1075ui_story and not isNil(var_489_6) then
					arg_486_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= var_489_7 + var_489_8 and arg_486_1.time_ < var_489_7 + var_489_8 + arg_489_0 and not isNil(var_489_6) and arg_486_1.var_.characterEffect1075ui_story then
				arg_486_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_489_10 = 0

			if var_489_10 < arg_486_1.time_ and arg_486_1.time_ <= var_489_10 + arg_489_0 then
				arg_486_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_489_11 = 0

			if var_489_11 < arg_486_1.time_ and arg_486_1.time_ <= var_489_11 + arg_489_0 then
				arg_486_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_489_12 = 0
			local var_489_13 = 0.2

			if var_489_12 < arg_486_1.time_ and arg_486_1.time_ <= var_489_12 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_14 = arg_486_1:FormatText(StoryNameCfg[381].name)

				arg_486_1.leftNameTxt_.text = var_489_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_15 = arg_486_1:GetWordFromCfg(120151119)
				local var_489_16 = arg_486_1:FormatText(var_489_15.content)

				arg_486_1.text_.text = var_489_16

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_17 = 8
				local var_489_18 = utf8.len(var_489_16)
				local var_489_19 = var_489_17 <= 0 and var_489_13 or var_489_13 * (var_489_18 / var_489_17)

				if var_489_19 > 0 and var_489_13 < var_489_19 then
					arg_486_1.talkMaxDuration = var_489_19

					if var_489_19 + var_489_12 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_19 + var_489_12
					end
				end

				arg_486_1.text_.text = var_489_16
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151119", "story_v_out_120151.awb") ~= 0 then
					local var_489_20 = manager.audio:GetVoiceLength("story_v_out_120151", "120151119", "story_v_out_120151.awb") / 1000

					if var_489_20 + var_489_12 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_20 + var_489_12
					end

					if var_489_15.prefab_name ~= "" and arg_486_1.actors_[var_489_15.prefab_name] ~= nil then
						local var_489_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_15.prefab_name].transform, "story_v_out_120151", "120151119", "story_v_out_120151.awb")

						arg_486_1:RecordAudio("120151119", var_489_21)
						arg_486_1:RecordAudio("120151119", var_489_21)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_120151", "120151119", "story_v_out_120151.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_120151", "120151119", "story_v_out_120151.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_22 = math.max(var_489_13, arg_486_1.talkMaxDuration)

			if var_489_12 <= arg_486_1.time_ and arg_486_1.time_ < var_489_12 + var_489_22 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_12) / var_489_22

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_12 + var_489_22 and arg_486_1.time_ < var_489_12 + var_489_22 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play120151120 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 120151120
		arg_490_1.duration_ = 6.1

		local var_490_0 = {
			zh = 4.166,
			ja = 6.1
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play120151121(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0

			if var_493_0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_0 + arg_493_0 then
				arg_490_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_493_1 = arg_490_1.actors_["1075ui_story"]
			local var_493_2 = 0

			if var_493_2 < arg_490_1.time_ and arg_490_1.time_ <= var_493_2 + arg_493_0 and not isNil(var_493_1) and arg_490_1.var_.characterEffect1075ui_story == nil then
				arg_490_1.var_.characterEffect1075ui_story = var_493_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_3 = 0.2

			if var_493_2 <= arg_490_1.time_ and arg_490_1.time_ < var_493_2 + var_493_3 and not isNil(var_493_1) then
				local var_493_4 = (arg_490_1.time_ - var_493_2) / var_493_3

				if arg_490_1.var_.characterEffect1075ui_story and not isNil(var_493_1) then
					local var_493_5 = Mathf.Lerp(0, 0.5, var_493_4)

					arg_490_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_490_1.var_.characterEffect1075ui_story.fillRatio = var_493_5
				end
			end

			if arg_490_1.time_ >= var_493_2 + var_493_3 and arg_490_1.time_ < var_493_2 + var_493_3 + arg_493_0 and not isNil(var_493_1) and arg_490_1.var_.characterEffect1075ui_story then
				local var_493_6 = 0.5

				arg_490_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_490_1.var_.characterEffect1075ui_story.fillRatio = var_493_6
			end

			local var_493_7 = arg_490_1.actors_["1076ui_story"]
			local var_493_8 = 0

			if var_493_8 < arg_490_1.time_ and arg_490_1.time_ <= var_493_8 + arg_493_0 and not isNil(var_493_7) and arg_490_1.var_.characterEffect1076ui_story == nil then
				arg_490_1.var_.characterEffect1076ui_story = var_493_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_9 = 0.2

			if var_493_8 <= arg_490_1.time_ and arg_490_1.time_ < var_493_8 + var_493_9 and not isNil(var_493_7) then
				local var_493_10 = (arg_490_1.time_ - var_493_8) / var_493_9

				if arg_490_1.var_.characterEffect1076ui_story and not isNil(var_493_7) then
					arg_490_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= var_493_8 + var_493_9 and arg_490_1.time_ < var_493_8 + var_493_9 + arg_493_0 and not isNil(var_493_7) and arg_490_1.var_.characterEffect1076ui_story then
				arg_490_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_493_11 = 0
			local var_493_12 = 0.4

			if var_493_11 < arg_490_1.time_ and arg_490_1.time_ <= var_493_11 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_13 = arg_490_1:FormatText(StoryNameCfg[389].name)

				arg_490_1.leftNameTxt_.text = var_493_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_14 = arg_490_1:GetWordFromCfg(120151120)
				local var_493_15 = arg_490_1:FormatText(var_493_14.content)

				arg_490_1.text_.text = var_493_15

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_16 = 16
				local var_493_17 = utf8.len(var_493_15)
				local var_493_18 = var_493_16 <= 0 and var_493_12 or var_493_12 * (var_493_17 / var_493_16)

				if var_493_18 > 0 and var_493_12 < var_493_18 then
					arg_490_1.talkMaxDuration = var_493_18

					if var_493_18 + var_493_11 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_18 + var_493_11
					end
				end

				arg_490_1.text_.text = var_493_15
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151120", "story_v_out_120151.awb") ~= 0 then
					local var_493_19 = manager.audio:GetVoiceLength("story_v_out_120151", "120151120", "story_v_out_120151.awb") / 1000

					if var_493_19 + var_493_11 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_19 + var_493_11
					end

					if var_493_14.prefab_name ~= "" and arg_490_1.actors_[var_493_14.prefab_name] ~= nil then
						local var_493_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_14.prefab_name].transform, "story_v_out_120151", "120151120", "story_v_out_120151.awb")

						arg_490_1:RecordAudio("120151120", var_493_20)
						arg_490_1:RecordAudio("120151120", var_493_20)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_120151", "120151120", "story_v_out_120151.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_120151", "120151120", "story_v_out_120151.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_21 = math.max(var_493_12, arg_490_1.talkMaxDuration)

			if var_493_11 <= arg_490_1.time_ and arg_490_1.time_ < var_493_11 + var_493_21 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_11) / var_493_21

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_11 + var_493_21 and arg_490_1.time_ < var_493_11 + var_493_21 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play120151121 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 120151121
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play120151122(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["1076ui_story"].transform
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 then
				arg_494_1.var_.moveOldPos1076ui_story = var_497_0.localPosition
			end

			local var_497_2 = 0.001

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2
				local var_497_4 = Vector3.New(0, 100, 0)

				var_497_0.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1076ui_story, var_497_4, var_497_3)

				local var_497_5 = manager.ui.mainCamera.transform.position - var_497_0.position

				var_497_0.forward = Vector3.New(var_497_5.x, var_497_5.y, var_497_5.z)

				local var_497_6 = var_497_0.localEulerAngles

				var_497_6.z = 0
				var_497_6.x = 0
				var_497_0.localEulerAngles = var_497_6
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 then
				var_497_0.localPosition = Vector3.New(0, 100, 0)

				local var_497_7 = manager.ui.mainCamera.transform.position - var_497_0.position

				var_497_0.forward = Vector3.New(var_497_7.x, var_497_7.y, var_497_7.z)

				local var_497_8 = var_497_0.localEulerAngles

				var_497_8.z = 0
				var_497_8.x = 0
				var_497_0.localEulerAngles = var_497_8
			end

			local var_497_9 = arg_494_1.actors_["1075ui_story"].transform
			local var_497_10 = 0

			if var_497_10 < arg_494_1.time_ and arg_494_1.time_ <= var_497_10 + arg_497_0 then
				arg_494_1.var_.moveOldPos1075ui_story = var_497_9.localPosition
			end

			local var_497_11 = 0.001

			if var_497_10 <= arg_494_1.time_ and arg_494_1.time_ < var_497_10 + var_497_11 then
				local var_497_12 = (arg_494_1.time_ - var_497_10) / var_497_11
				local var_497_13 = Vector3.New(0, 100, 0)

				var_497_9.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1075ui_story, var_497_13, var_497_12)

				local var_497_14 = manager.ui.mainCamera.transform.position - var_497_9.position

				var_497_9.forward = Vector3.New(var_497_14.x, var_497_14.y, var_497_14.z)

				local var_497_15 = var_497_9.localEulerAngles

				var_497_15.z = 0
				var_497_15.x = 0
				var_497_9.localEulerAngles = var_497_15
			end

			if arg_494_1.time_ >= var_497_10 + var_497_11 and arg_494_1.time_ < var_497_10 + var_497_11 + arg_497_0 then
				var_497_9.localPosition = Vector3.New(0, 100, 0)

				local var_497_16 = manager.ui.mainCamera.transform.position - var_497_9.position

				var_497_9.forward = Vector3.New(var_497_16.x, var_497_16.y, var_497_16.z)

				local var_497_17 = var_497_9.localEulerAngles

				var_497_17.z = 0
				var_497_17.x = 0
				var_497_9.localEulerAngles = var_497_17
			end

			local var_497_18 = 0
			local var_497_19 = 0.525

			if var_497_18 < arg_494_1.time_ and arg_494_1.time_ <= var_497_18 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, false)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_20 = arg_494_1:GetWordFromCfg(120151121)
				local var_497_21 = arg_494_1:FormatText(var_497_20.content)

				arg_494_1.text_.text = var_497_21

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_22 = 21
				local var_497_23 = utf8.len(var_497_21)
				local var_497_24 = var_497_22 <= 0 and var_497_19 or var_497_19 * (var_497_23 / var_497_22)

				if var_497_24 > 0 and var_497_19 < var_497_24 then
					arg_494_1.talkMaxDuration = var_497_24

					if var_497_24 + var_497_18 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_24 + var_497_18
					end
				end

				arg_494_1.text_.text = var_497_21
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_25 = math.max(var_497_19, arg_494_1.talkMaxDuration)

			if var_497_18 <= arg_494_1.time_ and arg_494_1.time_ < var_497_18 + var_497_25 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_18) / var_497_25

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_18 + var_497_25 and arg_494_1.time_ < var_497_18 + var_497_25 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_494_1:InitPlayNodeList()
	end,
	Play120151122 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 120151122
		arg_498_1.duration_ = 6.37

		local var_498_0 = {
			zh = 6.366,
			ja = 5.633
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
			arg_498_1.auto_ = false
		end

		function arg_498_1.playNext_(arg_500_0)
			arg_498_1.onStoryFinished_()
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["1076ui_story"].transform
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 then
				arg_498_1.var_.moveOldPos1076ui_story = var_501_0.localPosition
			end

			local var_501_2 = 0.001

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2
				local var_501_4 = Vector3.New(0, -1.06, -6.2)

				var_501_0.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1076ui_story, var_501_4, var_501_3)

				local var_501_5 = manager.ui.mainCamera.transform.position - var_501_0.position

				var_501_0.forward = Vector3.New(var_501_5.x, var_501_5.y, var_501_5.z)

				local var_501_6 = var_501_0.localEulerAngles

				var_501_6.z = 0
				var_501_6.x = 0
				var_501_0.localEulerAngles = var_501_6
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 then
				var_501_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_501_7 = manager.ui.mainCamera.transform.position - var_501_0.position

				var_501_0.forward = Vector3.New(var_501_7.x, var_501_7.y, var_501_7.z)

				local var_501_8 = var_501_0.localEulerAngles

				var_501_8.z = 0
				var_501_8.x = 0
				var_501_0.localEulerAngles = var_501_8
			end

			local var_501_9 = 0

			if var_501_9 < arg_498_1.time_ and arg_498_1.time_ <= var_501_9 + arg_501_0 then
				arg_498_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_501_10 = 0

			if var_501_10 < arg_498_1.time_ and arg_498_1.time_ <= var_501_10 + arg_501_0 then
				arg_498_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_501_11 = arg_498_1.actors_["1076ui_story"]
			local var_501_12 = 0

			if var_501_12 < arg_498_1.time_ and arg_498_1.time_ <= var_501_12 + arg_501_0 and not isNil(var_501_11) and arg_498_1.var_.characterEffect1076ui_story == nil then
				arg_498_1.var_.characterEffect1076ui_story = var_501_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_13 = 0.2

			if var_501_12 <= arg_498_1.time_ and arg_498_1.time_ < var_501_12 + var_501_13 and not isNil(var_501_11) then
				local var_501_14 = (arg_498_1.time_ - var_501_12) / var_501_13

				if arg_498_1.var_.characterEffect1076ui_story and not isNil(var_501_11) then
					arg_498_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= var_501_12 + var_501_13 and arg_498_1.time_ < var_501_12 + var_501_13 + arg_501_0 and not isNil(var_501_11) and arg_498_1.var_.characterEffect1076ui_story then
				arg_498_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_501_15 = 0
			local var_501_16 = 0.525

			if var_501_15 < arg_498_1.time_ and arg_498_1.time_ <= var_501_15 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_17 = arg_498_1:FormatText(StoryNameCfg[389].name)

				arg_498_1.leftNameTxt_.text = var_501_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_18 = arg_498_1:GetWordFromCfg(120151122)
				local var_501_19 = arg_498_1:FormatText(var_501_18.content)

				arg_498_1.text_.text = var_501_19

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_20 = 21
				local var_501_21 = utf8.len(var_501_19)
				local var_501_22 = var_501_20 <= 0 and var_501_16 or var_501_16 * (var_501_21 / var_501_20)

				if var_501_22 > 0 and var_501_16 < var_501_22 then
					arg_498_1.talkMaxDuration = var_501_22

					if var_501_22 + var_501_15 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_22 + var_501_15
					end
				end

				arg_498_1.text_.text = var_501_19
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120151", "120151122", "story_v_out_120151.awb") ~= 0 then
					local var_501_23 = manager.audio:GetVoiceLength("story_v_out_120151", "120151122", "story_v_out_120151.awb") / 1000

					if var_501_23 + var_501_15 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_23 + var_501_15
					end

					if var_501_18.prefab_name ~= "" and arg_498_1.actors_[var_501_18.prefab_name] ~= nil then
						local var_501_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_18.prefab_name].transform, "story_v_out_120151", "120151122", "story_v_out_120151.awb")

						arg_498_1:RecordAudio("120151122", var_501_24)
						arg_498_1:RecordAudio("120151122", var_501_24)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_120151", "120151122", "story_v_out_120151.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_120151", "120151122", "story_v_out_120151.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_25 = math.max(var_501_16, arg_498_1.talkMaxDuration)

			if var_501_15 <= arg_498_1.time_ and arg_498_1.time_ < var_501_15 + var_501_25 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_15) / var_501_25

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_15 + var_501_25 and arg_498_1.time_ < var_501_15 + var_501_25 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {
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

		arg_498_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J13f",
		"TextureConfig/Background/ST46",
		"TextureConfig/Background/J04f"
	},
	voices = {
		"story_v_out_120151.awb"
	}
}
