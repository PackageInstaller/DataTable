return {
	Play120121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120121001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play120121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST31"

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
				local var_4_5 = arg_1_1.bgs_.ST31

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
					if iter_4_0 ~= "ST31" then
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
			local var_4_23 = 0.166666666666667

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

			local var_4_28 = 0.8
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

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

			local var_4_34 = 2
			local var_4_35 = 0.25

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

				local var_4_37 = arg_1_1:GetWordFromCfg(120121001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 10
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
	Play120121002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 120121002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play120121003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.825

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

				local var_12_2 = arg_9_1:GetWordFromCfg(120121002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 33
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
	Play120121003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 120121003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play120121004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1071ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_13_1.stage_.transform)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

					var_16_3.enabled = true

					local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

					if var_16_4 then
						var_16_4:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_3.transform, false)

					arg_13_1.var_[var_16_0 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_0 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_0 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_16_6 = 0
			local var_16_7 = 0.725

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:GetWordFromCfg(120121003)
				local var_16_9 = arg_13_1:FormatText(var_16_8.content)

				arg_13_1.text_.text = var_16_9

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 29
				local var_16_11 = utf8.len(var_16_9)
				local var_16_12 = var_16_10 <= 0 and var_16_7 or var_16_7 * (var_16_11 / var_16_10)

				if var_16_12 > 0 and var_16_7 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12

					if var_16_12 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_9
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_13 and arg_13_1.time_ < var_16_6 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play120121004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 120121004
		arg_17_1.duration_ = 8.2

		local var_17_0 = {
			zh = 6.266,
			ja = 8.2
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
				arg_17_0:Play120121005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1071ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1071ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1071ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = "10042ui_story"

			if arg_17_1.actors_[var_20_9] == nil then
				local var_20_10 = Asset.Load("Char/" .. "10042ui_story")

				if not isNil(var_20_10) then
					local var_20_11 = Object.Instantiate(Asset.Load("Char/" .. "10042ui_story"), arg_17_1.stage_.transform)

					var_20_11.name = var_20_9
					var_20_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_9] = var_20_11

					local var_20_12 = var_20_11:GetComponentInChildren(typeof(CharacterEffect))

					var_20_12.enabled = true

					local var_20_13 = GameObjectTools.GetOrAddComponent(var_20_11, typeof(DynamicBoneHelper))

					if var_20_13 then
						var_20_13:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_12.transform, false)

					arg_17_1.var_[var_20_9 .. "Animator"] = var_20_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_9 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_9 .. "LipSync"] = var_20_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_14 = arg_17_1.actors_["10042ui_story"].transform
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.var_.moveOldPos10042ui_story = var_20_14.localPosition
			end

			local var_20_16 = 0.001

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16
				local var_20_18 = Vector3.New(0.7, -1.12, -6.2)

				var_20_14.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10042ui_story, var_20_18, var_20_17)

				local var_20_19 = manager.ui.mainCamera.transform.position - var_20_14.position

				var_20_14.forward = Vector3.New(var_20_19.x, var_20_19.y, var_20_19.z)

				local var_20_20 = var_20_14.localEulerAngles

				var_20_20.z = 0
				var_20_20.x = 0
				var_20_14.localEulerAngles = var_20_20
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 then
				var_20_14.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_20_21 = manager.ui.mainCamera.transform.position - var_20_14.position

				var_20_14.forward = Vector3.New(var_20_21.x, var_20_21.y, var_20_21.z)

				local var_20_22 = var_20_14.localEulerAngles

				var_20_22.z = 0
				var_20_22.x = 0
				var_20_14.localEulerAngles = var_20_22
			end

			local var_20_23 = arg_17_1.actors_["1071ui_story"]
			local var_20_24 = 0

			if var_20_24 < arg_17_1.time_ and arg_17_1.time_ <= var_20_24 + arg_20_0 and not isNil(var_20_23) and arg_17_1.var_.characterEffect1071ui_story == nil then
				arg_17_1.var_.characterEffect1071ui_story = var_20_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_25 = 0.2

			if var_20_24 <= arg_17_1.time_ and arg_17_1.time_ < var_20_24 + var_20_25 and not isNil(var_20_23) then
				local var_20_26 = (arg_17_1.time_ - var_20_24) / var_20_25

				if arg_17_1.var_.characterEffect1071ui_story and not isNil(var_20_23) then
					arg_17_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_24 + var_20_25 and arg_17_1.time_ < var_20_24 + var_20_25 + arg_20_0 and not isNil(var_20_23) and arg_17_1.var_.characterEffect1071ui_story then
				arg_17_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_20_27 = arg_17_1.actors_["10042ui_story"]
			local var_20_28 = 0

			if var_20_28 < arg_17_1.time_ and arg_17_1.time_ <= var_20_28 + arg_20_0 and not isNil(var_20_27) and arg_17_1.var_.characterEffect10042ui_story == nil then
				arg_17_1.var_.characterEffect10042ui_story = var_20_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_29 = 0.034

			if var_20_28 <= arg_17_1.time_ and arg_17_1.time_ < var_20_28 + var_20_29 and not isNil(var_20_27) then
				local var_20_30 = (arg_17_1.time_ - var_20_28) / var_20_29

				if arg_17_1.var_.characterEffect10042ui_story and not isNil(var_20_27) then
					local var_20_31 = Mathf.Lerp(0, 0.5, var_20_30)

					arg_17_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10042ui_story.fillRatio = var_20_31
				end
			end

			if arg_17_1.time_ >= var_20_28 + var_20_29 and arg_17_1.time_ < var_20_28 + var_20_29 + arg_20_0 and not isNil(var_20_27) and arg_17_1.var_.characterEffect10042ui_story then
				local var_20_32 = 0.5

				arg_17_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10042ui_story.fillRatio = var_20_32
			end

			local var_20_33 = 0

			if var_20_33 < arg_17_1.time_ and arg_17_1.time_ <= var_20_33 + arg_20_0 then
				arg_17_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_20_34 = 0
			local var_20_35 = 0.625

			if var_20_34 < arg_17_1.time_ and arg_17_1.time_ <= var_20_34 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_36 = arg_17_1:FormatText(StoryNameCfg[384].name)

				arg_17_1.leftNameTxt_.text = var_20_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_37 = arg_17_1:GetWordFromCfg(120121004)
				local var_20_38 = arg_17_1:FormatText(var_20_37.content)

				arg_17_1.text_.text = var_20_38

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_39 = 25
				local var_20_40 = utf8.len(var_20_38)
				local var_20_41 = var_20_39 <= 0 and var_20_35 or var_20_35 * (var_20_40 / var_20_39)

				if var_20_41 > 0 and var_20_35 < var_20_41 then
					arg_17_1.talkMaxDuration = var_20_41

					if var_20_41 + var_20_34 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_41 + var_20_34
					end
				end

				arg_17_1.text_.text = var_20_38
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121004", "story_v_out_120121.awb") ~= 0 then
					local var_20_42 = manager.audio:GetVoiceLength("story_v_out_120121", "120121004", "story_v_out_120121.awb") / 1000

					if var_20_42 + var_20_34 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_42 + var_20_34
					end

					if var_20_37.prefab_name ~= "" and arg_17_1.actors_[var_20_37.prefab_name] ~= nil then
						local var_20_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_37.prefab_name].transform, "story_v_out_120121", "120121004", "story_v_out_120121.awb")

						arg_17_1:RecordAudio("120121004", var_20_43)
						arg_17_1:RecordAudio("120121004", var_20_43)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_120121", "120121004", "story_v_out_120121.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_120121", "120121004", "story_v_out_120121.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_44 = math.max(var_20_35, arg_17_1.talkMaxDuration)

			if var_20_34 <= arg_17_1.time_ and arg_17_1.time_ < var_20_34 + var_20_44 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_34) / var_20_44

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_34 + var_20_44 and arg_17_1.time_ < var_20_34 + var_20_44 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play120121005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 120121005
		arg_21_1.duration_ = 6.13

		local var_21_0 = {
			zh = 3.833,
			ja = 6.133
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
				arg_21_0:Play120121006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1071ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1071ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1071ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["10042ui_story"].transform
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.var_.moveOldPos10042ui_story = var_24_9.localPosition
			end

			local var_24_11 = 0.001

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11
				local var_24_13 = Vector3.New(0.7, -1.12, -6.2)

				var_24_9.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10042ui_story, var_24_13, var_24_12)

				local var_24_14 = manager.ui.mainCamera.transform.position - var_24_9.position

				var_24_9.forward = Vector3.New(var_24_14.x, var_24_14.y, var_24_14.z)

				local var_24_15 = var_24_9.localEulerAngles

				var_24_15.z = 0
				var_24_15.x = 0
				var_24_9.localEulerAngles = var_24_15
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 then
				var_24_9.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_24_16 = manager.ui.mainCamera.transform.position - var_24_9.position

				var_24_9.forward = Vector3.New(var_24_16.x, var_24_16.y, var_24_16.z)

				local var_24_17 = var_24_9.localEulerAngles

				var_24_17.z = 0
				var_24_17.x = 0
				var_24_9.localEulerAngles = var_24_17
			end

			local var_24_18 = arg_21_1.actors_["1071ui_story"]
			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 and not isNil(var_24_18) and arg_21_1.var_.characterEffect1071ui_story == nil then
				arg_21_1.var_.characterEffect1071ui_story = var_24_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_20 = 0.2

			if var_24_19 <= arg_21_1.time_ and arg_21_1.time_ < var_24_19 + var_24_20 and not isNil(var_24_18) then
				local var_24_21 = (arg_21_1.time_ - var_24_19) / var_24_20

				if arg_21_1.var_.characterEffect1071ui_story and not isNil(var_24_18) then
					local var_24_22 = Mathf.Lerp(0, 0.5, var_24_21)

					arg_21_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1071ui_story.fillRatio = var_24_22
				end
			end

			if arg_21_1.time_ >= var_24_19 + var_24_20 and arg_21_1.time_ < var_24_19 + var_24_20 + arg_24_0 and not isNil(var_24_18) and arg_21_1.var_.characterEffect1071ui_story then
				local var_24_23 = 0.5

				arg_21_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1071ui_story.fillRatio = var_24_23
			end

			local var_24_24 = arg_21_1.actors_["10042ui_story"]
			local var_24_25 = 0

			if var_24_25 < arg_21_1.time_ and arg_21_1.time_ <= var_24_25 + arg_24_0 and not isNil(var_24_24) and arg_21_1.var_.characterEffect10042ui_story == nil then
				arg_21_1.var_.characterEffect10042ui_story = var_24_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_26 = 0.2

			if var_24_25 <= arg_21_1.time_ and arg_21_1.time_ < var_24_25 + var_24_26 and not isNil(var_24_24) then
				local var_24_27 = (arg_21_1.time_ - var_24_25) / var_24_26

				if arg_21_1.var_.characterEffect10042ui_story and not isNil(var_24_24) then
					arg_21_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_25 + var_24_26 and arg_21_1.time_ < var_24_25 + var_24_26 + arg_24_0 and not isNil(var_24_24) and arg_21_1.var_.characterEffect10042ui_story then
				arg_21_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_24_28 = 0

			if var_24_28 < arg_21_1.time_ and arg_21_1.time_ <= var_24_28 + arg_24_0 then
				arg_21_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action2_1")
			end

			local var_24_29 = 0
			local var_24_30 = 0.525

			if var_24_29 < arg_21_1.time_ and arg_21_1.time_ <= var_24_29 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_31 = arg_21_1:FormatText(StoryNameCfg[388].name)

				arg_21_1.leftNameTxt_.text = var_24_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_32 = arg_21_1:GetWordFromCfg(120121005)
				local var_24_33 = arg_21_1:FormatText(var_24_32.content)

				arg_21_1.text_.text = var_24_33

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_34 = 21
				local var_24_35 = utf8.len(var_24_33)
				local var_24_36 = var_24_34 <= 0 and var_24_30 or var_24_30 * (var_24_35 / var_24_34)

				if var_24_36 > 0 and var_24_30 < var_24_36 then
					arg_21_1.talkMaxDuration = var_24_36

					if var_24_36 + var_24_29 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_36 + var_24_29
					end
				end

				arg_21_1.text_.text = var_24_33
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121005", "story_v_out_120121.awb") ~= 0 then
					local var_24_37 = manager.audio:GetVoiceLength("story_v_out_120121", "120121005", "story_v_out_120121.awb") / 1000

					if var_24_37 + var_24_29 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_37 + var_24_29
					end

					if var_24_32.prefab_name ~= "" and arg_21_1.actors_[var_24_32.prefab_name] ~= nil then
						local var_24_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_32.prefab_name].transform, "story_v_out_120121", "120121005", "story_v_out_120121.awb")

						arg_21_1:RecordAudio("120121005", var_24_38)
						arg_21_1:RecordAudio("120121005", var_24_38)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_120121", "120121005", "story_v_out_120121.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_120121", "120121005", "story_v_out_120121.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_39 = math.max(var_24_30, arg_21_1.talkMaxDuration)

			if var_24_29 <= arg_21_1.time_ and arg_21_1.time_ < var_24_29 + var_24_39 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_29) / var_24_39

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_29 + var_24_39 and arg_21_1.time_ < var_24_29 + var_24_39 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play120121006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 120121006
		arg_25_1.duration_ = 8.7

		local var_25_0 = {
			zh = 8.7,
			ja = 6.2
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
				arg_25_0:Play120121007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1071ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1071ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1071ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["10042ui_story"].transform
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.var_.moveOldPos10042ui_story = var_28_9.localPosition
			end

			local var_28_11 = 0.001

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11
				local var_28_13 = Vector3.New(0.7, -1.12, -6.2)

				var_28_9.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10042ui_story, var_28_13, var_28_12)

				local var_28_14 = manager.ui.mainCamera.transform.position - var_28_9.position

				var_28_9.forward = Vector3.New(var_28_14.x, var_28_14.y, var_28_14.z)

				local var_28_15 = var_28_9.localEulerAngles

				var_28_15.z = 0
				var_28_15.x = 0
				var_28_9.localEulerAngles = var_28_15
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 then
				var_28_9.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_28_16 = manager.ui.mainCamera.transform.position - var_28_9.position

				var_28_9.forward = Vector3.New(var_28_16.x, var_28_16.y, var_28_16.z)

				local var_28_17 = var_28_9.localEulerAngles

				var_28_17.z = 0
				var_28_17.x = 0
				var_28_9.localEulerAngles = var_28_17
			end

			local var_28_18 = arg_25_1.actors_["1071ui_story"]
			local var_28_19 = 0

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 and not isNil(var_28_18) and arg_25_1.var_.characterEffect1071ui_story == nil then
				arg_25_1.var_.characterEffect1071ui_story = var_28_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_20 = 0.2

			if var_28_19 <= arg_25_1.time_ and arg_25_1.time_ < var_28_19 + var_28_20 and not isNil(var_28_18) then
				local var_28_21 = (arg_25_1.time_ - var_28_19) / var_28_20

				if arg_25_1.var_.characterEffect1071ui_story and not isNil(var_28_18) then
					arg_25_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_19 + var_28_20 and arg_25_1.time_ < var_28_19 + var_28_20 + arg_28_0 and not isNil(var_28_18) and arg_25_1.var_.characterEffect1071ui_story then
				arg_25_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_28_22 = arg_25_1.actors_["10042ui_story"]
			local var_28_23 = 0

			if var_28_23 < arg_25_1.time_ and arg_25_1.time_ <= var_28_23 + arg_28_0 and not isNil(var_28_22) and arg_25_1.var_.characterEffect10042ui_story == nil then
				arg_25_1.var_.characterEffect10042ui_story = var_28_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_24 = 0.2

			if var_28_23 <= arg_25_1.time_ and arg_25_1.time_ < var_28_23 + var_28_24 and not isNil(var_28_22) then
				local var_28_25 = (arg_25_1.time_ - var_28_23) / var_28_24

				if arg_25_1.var_.characterEffect10042ui_story and not isNil(var_28_22) then
					local var_28_26 = Mathf.Lerp(0, 0.5, var_28_25)

					arg_25_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10042ui_story.fillRatio = var_28_26
				end
			end

			if arg_25_1.time_ >= var_28_23 + var_28_24 and arg_25_1.time_ < var_28_23 + var_28_24 + arg_28_0 and not isNil(var_28_22) and arg_25_1.var_.characterEffect10042ui_story then
				local var_28_27 = 0.5

				arg_25_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10042ui_story.fillRatio = var_28_27
			end

			local var_28_28 = 0
			local var_28_29 = 1.075

			if var_28_28 < arg_25_1.time_ and arg_25_1.time_ <= var_28_28 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_30 = arg_25_1:FormatText(StoryNameCfg[384].name)

				arg_25_1.leftNameTxt_.text = var_28_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_31 = arg_25_1:GetWordFromCfg(120121006)
				local var_28_32 = arg_25_1:FormatText(var_28_31.content)

				arg_25_1.text_.text = var_28_32

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_33 = 43
				local var_28_34 = utf8.len(var_28_32)
				local var_28_35 = var_28_33 <= 0 and var_28_29 or var_28_29 * (var_28_34 / var_28_33)

				if var_28_35 > 0 and var_28_29 < var_28_35 then
					arg_25_1.talkMaxDuration = var_28_35

					if var_28_35 + var_28_28 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_35 + var_28_28
					end
				end

				arg_25_1.text_.text = var_28_32
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121006", "story_v_out_120121.awb") ~= 0 then
					local var_28_36 = manager.audio:GetVoiceLength("story_v_out_120121", "120121006", "story_v_out_120121.awb") / 1000

					if var_28_36 + var_28_28 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_36 + var_28_28
					end

					if var_28_31.prefab_name ~= "" and arg_25_1.actors_[var_28_31.prefab_name] ~= nil then
						local var_28_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_31.prefab_name].transform, "story_v_out_120121", "120121006", "story_v_out_120121.awb")

						arg_25_1:RecordAudio("120121006", var_28_37)
						arg_25_1:RecordAudio("120121006", var_28_37)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_120121", "120121006", "story_v_out_120121.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_120121", "120121006", "story_v_out_120121.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_38 = math.max(var_28_29, arg_25_1.talkMaxDuration)

			if var_28_28 <= arg_25_1.time_ and arg_25_1.time_ < var_28_28 + var_28_38 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_28) / var_28_38

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_28 + var_28_38 and arg_25_1.time_ < var_28_28 + var_28_38 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play120121007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 120121007
		arg_29_1.duration_ = 5

		local var_29_0 = {
			zh = 4.366,
			ja = 5
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
				arg_29_0:Play120121008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1071ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1071ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1071ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["10042ui_story"].transform
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1.var_.moveOldPos10042ui_story = var_32_9.localPosition
			end

			local var_32_11 = 0.001

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11
				local var_32_13 = Vector3.New(0.7, -1.12, -6.2)

				var_32_9.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10042ui_story, var_32_13, var_32_12)

				local var_32_14 = manager.ui.mainCamera.transform.position - var_32_9.position

				var_32_9.forward = Vector3.New(var_32_14.x, var_32_14.y, var_32_14.z)

				local var_32_15 = var_32_9.localEulerAngles

				var_32_15.z = 0
				var_32_15.x = 0
				var_32_9.localEulerAngles = var_32_15
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 then
				var_32_9.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_32_16 = manager.ui.mainCamera.transform.position - var_32_9.position

				var_32_9.forward = Vector3.New(var_32_16.x, var_32_16.y, var_32_16.z)

				local var_32_17 = var_32_9.localEulerAngles

				var_32_17.z = 0
				var_32_17.x = 0
				var_32_9.localEulerAngles = var_32_17
			end

			local var_32_18 = arg_29_1.actors_["1071ui_story"]
			local var_32_19 = 0

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 and not isNil(var_32_18) and arg_29_1.var_.characterEffect1071ui_story == nil then
				arg_29_1.var_.characterEffect1071ui_story = var_32_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_20 = 0.2

			if var_32_19 <= arg_29_1.time_ and arg_29_1.time_ < var_32_19 + var_32_20 and not isNil(var_32_18) then
				local var_32_21 = (arg_29_1.time_ - var_32_19) / var_32_20

				if arg_29_1.var_.characterEffect1071ui_story and not isNil(var_32_18) then
					local var_32_22 = Mathf.Lerp(0, 0.5, var_32_21)

					arg_29_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1071ui_story.fillRatio = var_32_22
				end
			end

			if arg_29_1.time_ >= var_32_19 + var_32_20 and arg_29_1.time_ < var_32_19 + var_32_20 + arg_32_0 and not isNil(var_32_18) and arg_29_1.var_.characterEffect1071ui_story then
				local var_32_23 = 0.5

				arg_29_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1071ui_story.fillRatio = var_32_23
			end

			local var_32_24 = arg_29_1.actors_["10042ui_story"]
			local var_32_25 = 0

			if var_32_25 < arg_29_1.time_ and arg_29_1.time_ <= var_32_25 + arg_32_0 and not isNil(var_32_24) and arg_29_1.var_.characterEffect10042ui_story == nil then
				arg_29_1.var_.characterEffect10042ui_story = var_32_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_26 = 0.2

			if var_32_25 <= arg_29_1.time_ and arg_29_1.time_ < var_32_25 + var_32_26 and not isNil(var_32_24) then
				local var_32_27 = (arg_29_1.time_ - var_32_25) / var_32_26

				if arg_29_1.var_.characterEffect10042ui_story and not isNil(var_32_24) then
					arg_29_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_25 + var_32_26 and arg_29_1.time_ < var_32_25 + var_32_26 + arg_32_0 and not isNil(var_32_24) and arg_29_1.var_.characterEffect10042ui_story then
				arg_29_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_32_28 = 0
			local var_32_29 = 0.5

			if var_32_28 < arg_29_1.time_ and arg_29_1.time_ <= var_32_28 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_30 = arg_29_1:FormatText(StoryNameCfg[388].name)

				arg_29_1.leftNameTxt_.text = var_32_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_31 = arg_29_1:GetWordFromCfg(120121007)
				local var_32_32 = arg_29_1:FormatText(var_32_31.content)

				arg_29_1.text_.text = var_32_32

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_33 = 20
				local var_32_34 = utf8.len(var_32_32)
				local var_32_35 = var_32_33 <= 0 and var_32_29 or var_32_29 * (var_32_34 / var_32_33)

				if var_32_35 > 0 and var_32_29 < var_32_35 then
					arg_29_1.talkMaxDuration = var_32_35

					if var_32_35 + var_32_28 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_35 + var_32_28
					end
				end

				arg_29_1.text_.text = var_32_32
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121007", "story_v_out_120121.awb") ~= 0 then
					local var_32_36 = manager.audio:GetVoiceLength("story_v_out_120121", "120121007", "story_v_out_120121.awb") / 1000

					if var_32_36 + var_32_28 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_36 + var_32_28
					end

					if var_32_31.prefab_name ~= "" and arg_29_1.actors_[var_32_31.prefab_name] ~= nil then
						local var_32_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_31.prefab_name].transform, "story_v_out_120121", "120121007", "story_v_out_120121.awb")

						arg_29_1:RecordAudio("120121007", var_32_37)
						arg_29_1:RecordAudio("120121007", var_32_37)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_120121", "120121007", "story_v_out_120121.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_120121", "120121007", "story_v_out_120121.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_38 = math.max(var_32_29, arg_29_1.talkMaxDuration)

			if var_32_28 <= arg_29_1.time_ and arg_29_1.time_ < var_32_28 + var_32_38 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_28) / var_32_38

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_28 + var_32_38 and arg_29_1.time_ < var_32_28 + var_32_38 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play120121008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 120121008
		arg_33_1.duration_ = 7.5

		local var_33_0 = {
			zh = 6.066,
			ja = 7.5
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
				arg_33_0:Play120121009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1071ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1071ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1071ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["10042ui_story"].transform
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.var_.moveOldPos10042ui_story = var_36_9.localPosition
			end

			local var_36_11 = 0.001

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11
				local var_36_13 = Vector3.New(0.7, -1.12, -6.2)

				var_36_9.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10042ui_story, var_36_13, var_36_12)

				local var_36_14 = manager.ui.mainCamera.transform.position - var_36_9.position

				var_36_9.forward = Vector3.New(var_36_14.x, var_36_14.y, var_36_14.z)

				local var_36_15 = var_36_9.localEulerAngles

				var_36_15.z = 0
				var_36_15.x = 0
				var_36_9.localEulerAngles = var_36_15
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 then
				var_36_9.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_36_16 = manager.ui.mainCamera.transform.position - var_36_9.position

				var_36_9.forward = Vector3.New(var_36_16.x, var_36_16.y, var_36_16.z)

				local var_36_17 = var_36_9.localEulerAngles

				var_36_17.z = 0
				var_36_17.x = 0
				var_36_9.localEulerAngles = var_36_17
			end

			local var_36_18 = arg_33_1.actors_["1071ui_story"]
			local var_36_19 = 0

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 and not isNil(var_36_18) and arg_33_1.var_.characterEffect1071ui_story == nil then
				arg_33_1.var_.characterEffect1071ui_story = var_36_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_20 = 0.2

			if var_36_19 <= arg_33_1.time_ and arg_33_1.time_ < var_36_19 + var_36_20 and not isNil(var_36_18) then
				local var_36_21 = (arg_33_1.time_ - var_36_19) / var_36_20

				if arg_33_1.var_.characterEffect1071ui_story and not isNil(var_36_18) then
					arg_33_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_19 + var_36_20 and arg_33_1.time_ < var_36_19 + var_36_20 + arg_36_0 and not isNil(var_36_18) and arg_33_1.var_.characterEffect1071ui_story then
				arg_33_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_36_22 = arg_33_1.actors_["10042ui_story"]
			local var_36_23 = 0

			if var_36_23 < arg_33_1.time_ and arg_33_1.time_ <= var_36_23 + arg_36_0 and not isNil(var_36_22) and arg_33_1.var_.characterEffect10042ui_story == nil then
				arg_33_1.var_.characterEffect10042ui_story = var_36_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_24 = 0.2

			if var_36_23 <= arg_33_1.time_ and arg_33_1.time_ < var_36_23 + var_36_24 and not isNil(var_36_22) then
				local var_36_25 = (arg_33_1.time_ - var_36_23) / var_36_24

				if arg_33_1.var_.characterEffect10042ui_story and not isNil(var_36_22) then
					local var_36_26 = Mathf.Lerp(0, 0.5, var_36_25)

					arg_33_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10042ui_story.fillRatio = var_36_26
				end
			end

			if arg_33_1.time_ >= var_36_23 + var_36_24 and arg_33_1.time_ < var_36_23 + var_36_24 + arg_36_0 and not isNil(var_36_22) and arg_33_1.var_.characterEffect10042ui_story then
				local var_36_27 = 0.5

				arg_33_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10042ui_story.fillRatio = var_36_27
			end

			local var_36_28 = 0

			if var_36_28 < arg_33_1.time_ and arg_33_1.time_ <= var_36_28 + arg_36_0 then
				arg_33_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action435")
			end

			local var_36_29 = 0
			local var_36_30 = 0.8

			if var_36_29 < arg_33_1.time_ and arg_33_1.time_ <= var_36_29 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_31 = arg_33_1:FormatText(StoryNameCfg[384].name)

				arg_33_1.leftNameTxt_.text = var_36_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_32 = arg_33_1:GetWordFromCfg(120121008)
				local var_36_33 = arg_33_1:FormatText(var_36_32.content)

				arg_33_1.text_.text = var_36_33

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_34 = 32
				local var_36_35 = utf8.len(var_36_33)
				local var_36_36 = var_36_34 <= 0 and var_36_30 or var_36_30 * (var_36_35 / var_36_34)

				if var_36_36 > 0 and var_36_30 < var_36_36 then
					arg_33_1.talkMaxDuration = var_36_36

					if var_36_36 + var_36_29 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_36 + var_36_29
					end
				end

				arg_33_1.text_.text = var_36_33
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121008", "story_v_out_120121.awb") ~= 0 then
					local var_36_37 = manager.audio:GetVoiceLength("story_v_out_120121", "120121008", "story_v_out_120121.awb") / 1000

					if var_36_37 + var_36_29 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_37 + var_36_29
					end

					if var_36_32.prefab_name ~= "" and arg_33_1.actors_[var_36_32.prefab_name] ~= nil then
						local var_36_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_32.prefab_name].transform, "story_v_out_120121", "120121008", "story_v_out_120121.awb")

						arg_33_1:RecordAudio("120121008", var_36_38)
						arg_33_1:RecordAudio("120121008", var_36_38)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_120121", "120121008", "story_v_out_120121.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_120121", "120121008", "story_v_out_120121.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_39 = math.max(var_36_30, arg_33_1.talkMaxDuration)

			if var_36_29 <= arg_33_1.time_ and arg_33_1.time_ < var_36_29 + var_36_39 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_29) / var_36_39

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_29 + var_36_39 and arg_33_1.time_ < var_36_29 + var_36_39 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play120121009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 120121009
		arg_37_1.duration_ = 7.2

		local var_37_0 = {
			zh = 5.333,
			ja = 7.2
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
				arg_37_0:Play120121010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.725

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[384].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(120121009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121009", "story_v_out_120121.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_120121", "120121009", "story_v_out_120121.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_120121", "120121009", "story_v_out_120121.awb")

						arg_37_1:RecordAudio("120121009", var_40_9)
						arg_37_1:RecordAudio("120121009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_120121", "120121009", "story_v_out_120121.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_120121", "120121009", "story_v_out_120121.awb")
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
	Play120121010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 120121010
		arg_41_1.duration_ = 10.7

		local var_41_0 = {
			zh = 3.966,
			ja = 10.7
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
				arg_41_0:Play120121011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1071ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1071ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1071ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["10042ui_story"].transform
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1.var_.moveOldPos10042ui_story = var_44_9.localPosition
			end

			local var_44_11 = 0.001

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11
				local var_44_13 = Vector3.New(0.7, -1.12, -6.2)

				var_44_9.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10042ui_story, var_44_13, var_44_12)

				local var_44_14 = manager.ui.mainCamera.transform.position - var_44_9.position

				var_44_9.forward = Vector3.New(var_44_14.x, var_44_14.y, var_44_14.z)

				local var_44_15 = var_44_9.localEulerAngles

				var_44_15.z = 0
				var_44_15.x = 0
				var_44_9.localEulerAngles = var_44_15
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 then
				var_44_9.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_44_16 = manager.ui.mainCamera.transform.position - var_44_9.position

				var_44_9.forward = Vector3.New(var_44_16.x, var_44_16.y, var_44_16.z)

				local var_44_17 = var_44_9.localEulerAngles

				var_44_17.z = 0
				var_44_17.x = 0
				var_44_9.localEulerAngles = var_44_17
			end

			local var_44_18 = arg_41_1.actors_["1071ui_story"]
			local var_44_19 = 0

			if var_44_19 < arg_41_1.time_ and arg_41_1.time_ <= var_44_19 + arg_44_0 and not isNil(var_44_18) and arg_41_1.var_.characterEffect1071ui_story == nil then
				arg_41_1.var_.characterEffect1071ui_story = var_44_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_20 = 0.2

			if var_44_19 <= arg_41_1.time_ and arg_41_1.time_ < var_44_19 + var_44_20 and not isNil(var_44_18) then
				local var_44_21 = (arg_41_1.time_ - var_44_19) / var_44_20

				if arg_41_1.var_.characterEffect1071ui_story and not isNil(var_44_18) then
					local var_44_22 = Mathf.Lerp(0, 0.5, var_44_21)

					arg_41_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1071ui_story.fillRatio = var_44_22
				end
			end

			if arg_41_1.time_ >= var_44_19 + var_44_20 and arg_41_1.time_ < var_44_19 + var_44_20 + arg_44_0 and not isNil(var_44_18) and arg_41_1.var_.characterEffect1071ui_story then
				local var_44_23 = 0.5

				arg_41_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1071ui_story.fillRatio = var_44_23
			end

			local var_44_24 = arg_41_1.actors_["10042ui_story"]
			local var_44_25 = 0

			if var_44_25 < arg_41_1.time_ and arg_41_1.time_ <= var_44_25 + arg_44_0 and not isNil(var_44_24) and arg_41_1.var_.characterEffect10042ui_story == nil then
				arg_41_1.var_.characterEffect10042ui_story = var_44_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_26 = 0.2

			if var_44_25 <= arg_41_1.time_ and arg_41_1.time_ < var_44_25 + var_44_26 and not isNil(var_44_24) then
				local var_44_27 = (arg_41_1.time_ - var_44_25) / var_44_26

				if arg_41_1.var_.characterEffect10042ui_story and not isNil(var_44_24) then
					arg_41_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_25 + var_44_26 and arg_41_1.time_ < var_44_25 + var_44_26 + arg_44_0 and not isNil(var_44_24) and arg_41_1.var_.characterEffect10042ui_story then
				arg_41_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_44_28 = 0
			local var_44_29 = 0.6

			if var_44_28 < arg_41_1.time_ and arg_41_1.time_ <= var_44_28 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_30 = arg_41_1:FormatText(StoryNameCfg[388].name)

				arg_41_1.leftNameTxt_.text = var_44_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_31 = arg_41_1:GetWordFromCfg(120121010)
				local var_44_32 = arg_41_1:FormatText(var_44_31.content)

				arg_41_1.text_.text = var_44_32

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_33 = 24
				local var_44_34 = utf8.len(var_44_32)
				local var_44_35 = var_44_33 <= 0 and var_44_29 or var_44_29 * (var_44_34 / var_44_33)

				if var_44_35 > 0 and var_44_29 < var_44_35 then
					arg_41_1.talkMaxDuration = var_44_35

					if var_44_35 + var_44_28 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_35 + var_44_28
					end
				end

				arg_41_1.text_.text = var_44_32
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121010", "story_v_out_120121.awb") ~= 0 then
					local var_44_36 = manager.audio:GetVoiceLength("story_v_out_120121", "120121010", "story_v_out_120121.awb") / 1000

					if var_44_36 + var_44_28 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_36 + var_44_28
					end

					if var_44_31.prefab_name ~= "" and arg_41_1.actors_[var_44_31.prefab_name] ~= nil then
						local var_44_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_31.prefab_name].transform, "story_v_out_120121", "120121010", "story_v_out_120121.awb")

						arg_41_1:RecordAudio("120121010", var_44_37)
						arg_41_1:RecordAudio("120121010", var_44_37)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_120121", "120121010", "story_v_out_120121.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_120121", "120121010", "story_v_out_120121.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_38 = math.max(var_44_29, arg_41_1.talkMaxDuration)

			if var_44_28 <= arg_41_1.time_ and arg_41_1.time_ < var_44_28 + var_44_38 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_28) / var_44_38

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_28 + var_44_38 and arg_41_1.time_ < var_44_28 + var_44_38 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play120121011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 120121011
		arg_45_1.duration_ = 3

		local var_45_0 = {
			zh = 3,
			ja = 2.2
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
				arg_45_0:Play120121012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1071ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1071ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1071ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["10042ui_story"].transform
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.var_.moveOldPos10042ui_story = var_48_9.localPosition
			end

			local var_48_11 = 0.001

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11
				local var_48_13 = Vector3.New(0.7, -1.12, -6.2)

				var_48_9.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10042ui_story, var_48_13, var_48_12)

				local var_48_14 = manager.ui.mainCamera.transform.position - var_48_9.position

				var_48_9.forward = Vector3.New(var_48_14.x, var_48_14.y, var_48_14.z)

				local var_48_15 = var_48_9.localEulerAngles

				var_48_15.z = 0
				var_48_15.x = 0
				var_48_9.localEulerAngles = var_48_15
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 then
				var_48_9.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_48_16 = manager.ui.mainCamera.transform.position - var_48_9.position

				var_48_9.forward = Vector3.New(var_48_16.x, var_48_16.y, var_48_16.z)

				local var_48_17 = var_48_9.localEulerAngles

				var_48_17.z = 0
				var_48_17.x = 0
				var_48_9.localEulerAngles = var_48_17
			end

			local var_48_18 = arg_45_1.actors_["1071ui_story"]
			local var_48_19 = 0

			if var_48_19 < arg_45_1.time_ and arg_45_1.time_ <= var_48_19 + arg_48_0 and not isNil(var_48_18) and arg_45_1.var_.characterEffect1071ui_story == nil then
				arg_45_1.var_.characterEffect1071ui_story = var_48_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_20 = 0.2

			if var_48_19 <= arg_45_1.time_ and arg_45_1.time_ < var_48_19 + var_48_20 and not isNil(var_48_18) then
				local var_48_21 = (arg_45_1.time_ - var_48_19) / var_48_20

				if arg_45_1.var_.characterEffect1071ui_story and not isNil(var_48_18) then
					arg_45_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_19 + var_48_20 and arg_45_1.time_ < var_48_19 + var_48_20 + arg_48_0 and not isNil(var_48_18) and arg_45_1.var_.characterEffect1071ui_story then
				arg_45_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_48_22 = arg_45_1.actors_["10042ui_story"]
			local var_48_23 = 0

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 and not isNil(var_48_22) and arg_45_1.var_.characterEffect10042ui_story == nil then
				arg_45_1.var_.characterEffect10042ui_story = var_48_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_24 = 0.2

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_24 and not isNil(var_48_22) then
				local var_48_25 = (arg_45_1.time_ - var_48_23) / var_48_24

				if arg_45_1.var_.characterEffect10042ui_story and not isNil(var_48_22) then
					local var_48_26 = Mathf.Lerp(0, 0.5, var_48_25)

					arg_45_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10042ui_story.fillRatio = var_48_26
				end
			end

			if arg_45_1.time_ >= var_48_23 + var_48_24 and arg_45_1.time_ < var_48_23 + var_48_24 + arg_48_0 and not isNil(var_48_22) and arg_45_1.var_.characterEffect10042ui_story then
				local var_48_27 = 0.5

				arg_45_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10042ui_story.fillRatio = var_48_27
			end

			local var_48_28 = 0
			local var_48_29 = 0.2

			if var_48_28 < arg_45_1.time_ and arg_45_1.time_ <= var_48_28 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_30 = arg_45_1:FormatText(StoryNameCfg[384].name)

				arg_45_1.leftNameTxt_.text = var_48_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_31 = arg_45_1:GetWordFromCfg(120121011)
				local var_48_32 = arg_45_1:FormatText(var_48_31.content)

				arg_45_1.text_.text = var_48_32

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_33 = 8
				local var_48_34 = utf8.len(var_48_32)
				local var_48_35 = var_48_33 <= 0 and var_48_29 or var_48_29 * (var_48_34 / var_48_33)

				if var_48_35 > 0 and var_48_29 < var_48_35 then
					arg_45_1.talkMaxDuration = var_48_35

					if var_48_35 + var_48_28 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_35 + var_48_28
					end
				end

				arg_45_1.text_.text = var_48_32
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121011", "story_v_out_120121.awb") ~= 0 then
					local var_48_36 = manager.audio:GetVoiceLength("story_v_out_120121", "120121011", "story_v_out_120121.awb") / 1000

					if var_48_36 + var_48_28 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_36 + var_48_28
					end

					if var_48_31.prefab_name ~= "" and arg_45_1.actors_[var_48_31.prefab_name] ~= nil then
						local var_48_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_31.prefab_name].transform, "story_v_out_120121", "120121011", "story_v_out_120121.awb")

						arg_45_1:RecordAudio("120121011", var_48_37)
						arg_45_1:RecordAudio("120121011", var_48_37)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_120121", "120121011", "story_v_out_120121.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_120121", "120121011", "story_v_out_120121.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_38 = math.max(var_48_29, arg_45_1.talkMaxDuration)

			if var_48_28 <= arg_45_1.time_ and arg_45_1.time_ < var_48_28 + var_48_38 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_28) / var_48_38

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_28 + var_48_38 and arg_45_1.time_ < var_48_28 + var_48_38 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play120121012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 120121012
		arg_49_1.duration_ = 7.1

		local var_49_0 = {
			zh = 3.7,
			ja = 7.1
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
				arg_49_0:Play120121013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1071ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1071ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0, 100, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1071ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, 100, 0)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["10042ui_story"].transform
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.var_.moveOldPos10042ui_story = var_52_9.localPosition
			end

			local var_52_11 = 0.001

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11
				local var_52_13 = Vector3.New(0, 100, 0)

				var_52_9.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10042ui_story, var_52_13, var_52_12)

				local var_52_14 = manager.ui.mainCamera.transform.position - var_52_9.position

				var_52_9.forward = Vector3.New(var_52_14.x, var_52_14.y, var_52_14.z)

				local var_52_15 = var_52_9.localEulerAngles

				var_52_15.z = 0
				var_52_15.x = 0
				var_52_9.localEulerAngles = var_52_15
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 then
				var_52_9.localPosition = Vector3.New(0, 100, 0)

				local var_52_16 = manager.ui.mainCamera.transform.position - var_52_9.position

				var_52_9.forward = Vector3.New(var_52_16.x, var_52_16.y, var_52_16.z)

				local var_52_17 = var_52_9.localEulerAngles

				var_52_17.z = 0
				var_52_17.x = 0
				var_52_9.localEulerAngles = var_52_17
			end

			local var_52_18 = 0
			local var_52_19 = 0.5

			if var_52_18 < arg_49_1.time_ and arg_49_1.time_ <= var_52_18 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_20 = arg_49_1:FormatText(StoryNameCfg[384].name)

				arg_49_1.leftNameTxt_.text = var_52_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_21 = arg_49_1:GetWordFromCfg(120121012)
				local var_52_22 = arg_49_1:FormatText(var_52_21.content)

				arg_49_1.text_.text = var_52_22

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_23 = 20
				local var_52_24 = utf8.len(var_52_22)
				local var_52_25 = var_52_23 <= 0 and var_52_19 or var_52_19 * (var_52_24 / var_52_23)

				if var_52_25 > 0 and var_52_19 < var_52_25 then
					arg_49_1.talkMaxDuration = var_52_25

					if var_52_25 + var_52_18 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_25 + var_52_18
					end
				end

				arg_49_1.text_.text = var_52_22
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121012", "story_v_out_120121.awb") ~= 0 then
					local var_52_26 = manager.audio:GetVoiceLength("story_v_out_120121", "120121012", "story_v_out_120121.awb") / 1000

					if var_52_26 + var_52_18 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_26 + var_52_18
					end

					if var_52_21.prefab_name ~= "" and arg_49_1.actors_[var_52_21.prefab_name] ~= nil then
						local var_52_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_21.prefab_name].transform, "story_v_out_120121", "120121012", "story_v_out_120121.awb")

						arg_49_1:RecordAudio("120121012", var_52_27)
						arg_49_1:RecordAudio("120121012", var_52_27)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_120121", "120121012", "story_v_out_120121.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_120121", "120121012", "story_v_out_120121.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_28 = math.max(var_52_19, arg_49_1.talkMaxDuration)

			if var_52_18 <= arg_49_1.time_ and arg_49_1.time_ < var_52_18 + var_52_28 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_18) / var_52_28

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_18 + var_52_28 and arg_49_1.time_ < var_52_18 + var_52_28 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play120121013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 120121013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play120121014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(120121013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 40
				local var_56_5 = utf8.len(var_56_3)
				local var_56_6 = var_56_4 <= 0 and var_56_1 or var_56_1 * (var_56_5 / var_56_4)

				if var_56_6 > 0 and var_56_1 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_7 and arg_53_1.time_ < var_56_0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play120121014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 120121014
		arg_57_1.duration_ = 10.97

		local var_57_0 = {
			zh = 9.566,
			ja = 10.966
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
				arg_57_0:Play120121015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1071ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1071ui_story == nil then
				arg_57_1.var_.characterEffect1071ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1071ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1071ui_story then
				arg_57_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_60_4 = arg_57_1.actors_["1071ui_story"].transform
			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.var_.moveOldPos1071ui_story = var_60_4.localPosition
			end

			local var_60_6 = 0.001

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_6 then
				local var_60_7 = (arg_57_1.time_ - var_60_5) / var_60_6
				local var_60_8 = Vector3.New(0, -1.05, -6.2)

				var_60_4.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1071ui_story, var_60_8, var_60_7)

				local var_60_9 = manager.ui.mainCamera.transform.position - var_60_4.position

				var_60_4.forward = Vector3.New(var_60_9.x, var_60_9.y, var_60_9.z)

				local var_60_10 = var_60_4.localEulerAngles

				var_60_10.z = 0
				var_60_10.x = 0
				var_60_4.localEulerAngles = var_60_10
			end

			if arg_57_1.time_ >= var_60_5 + var_60_6 and arg_57_1.time_ < var_60_5 + var_60_6 + arg_60_0 then
				var_60_4.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_60_11 = manager.ui.mainCamera.transform.position - var_60_4.position

				var_60_4.forward = Vector3.New(var_60_11.x, var_60_11.y, var_60_11.z)

				local var_60_12 = var_60_4.localEulerAngles

				var_60_12.z = 0
				var_60_12.x = 0
				var_60_4.localEulerAngles = var_60_12
			end

			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_60_15 = 0
			local var_60_16 = 0.9

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_17 = arg_57_1:FormatText(StoryNameCfg[384].name)

				arg_57_1.leftNameTxt_.text = var_60_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(120121014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 36
				local var_60_21 = utf8.len(var_60_19)
				local var_60_22 = var_60_20 <= 0 and var_60_16 or var_60_16 * (var_60_21 / var_60_20)

				if var_60_22 > 0 and var_60_16 < var_60_22 then
					arg_57_1.talkMaxDuration = var_60_22

					if var_60_22 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_15
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121014", "story_v_out_120121.awb") ~= 0 then
					local var_60_23 = manager.audio:GetVoiceLength("story_v_out_120121", "120121014", "story_v_out_120121.awb") / 1000

					if var_60_23 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_15
					end

					if var_60_18.prefab_name ~= "" and arg_57_1.actors_[var_60_18.prefab_name] ~= nil then
						local var_60_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_18.prefab_name].transform, "story_v_out_120121", "120121014", "story_v_out_120121.awb")

						arg_57_1:RecordAudio("120121014", var_60_24)
						arg_57_1:RecordAudio("120121014", var_60_24)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_120121", "120121014", "story_v_out_120121.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_120121", "120121014", "story_v_out_120121.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_25 = math.max(var_60_16, arg_57_1.talkMaxDuration)

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_25 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_15) / var_60_25

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_15 + var_60_25 and arg_57_1.time_ < var_60_15 + var_60_25 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play120121015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 120121015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play120121016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1071ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1071ui_story == nil then
				arg_61_1.var_.characterEffect1071ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1071ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1071ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1071ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1071ui_story.fillRatio = var_64_5
			end

			local var_64_6 = arg_61_1.actors_["1071ui_story"].transform
			local var_64_7 = 0

			if var_64_7 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 then
				arg_61_1.var_.moveOldPos1071ui_story = var_64_6.localPosition
			end

			local var_64_8 = 0.001

			if var_64_7 <= arg_61_1.time_ and arg_61_1.time_ < var_64_7 + var_64_8 then
				local var_64_9 = (arg_61_1.time_ - var_64_7) / var_64_8
				local var_64_10 = Vector3.New(0, -1.05, -6.2)

				var_64_6.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1071ui_story, var_64_10, var_64_9)

				local var_64_11 = manager.ui.mainCamera.transform.position - var_64_6.position

				var_64_6.forward = Vector3.New(var_64_11.x, var_64_11.y, var_64_11.z)

				local var_64_12 = var_64_6.localEulerAngles

				var_64_12.z = 0
				var_64_12.x = 0
				var_64_6.localEulerAngles = var_64_12
			end

			if arg_61_1.time_ >= var_64_7 + var_64_8 and arg_61_1.time_ < var_64_7 + var_64_8 + arg_64_0 then
				var_64_6.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_64_13 = manager.ui.mainCamera.transform.position - var_64_6.position

				var_64_6.forward = Vector3.New(var_64_13.x, var_64_13.y, var_64_13.z)

				local var_64_14 = var_64_6.localEulerAngles

				var_64_14.z = 0
				var_64_14.x = 0
				var_64_6.localEulerAngles = var_64_14
			end

			local var_64_15 = 0
			local var_64_16 = 0.4

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_17 = arg_61_1:GetWordFromCfg(120121015)
				local var_64_18 = arg_61_1:FormatText(var_64_17.content)

				arg_61_1.text_.text = var_64_18

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_19 = 16
				local var_64_20 = utf8.len(var_64_18)
				local var_64_21 = var_64_19 <= 0 and var_64_16 or var_64_16 * (var_64_20 / var_64_19)

				if var_64_21 > 0 and var_64_16 < var_64_21 then
					arg_61_1.talkMaxDuration = var_64_21

					if var_64_21 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_21 + var_64_15
					end
				end

				arg_61_1.text_.text = var_64_18
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_22 = math.max(var_64_16, arg_61_1.talkMaxDuration)

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_22 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_15) / var_64_22

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_15 + var_64_22 and arg_61_1.time_ < var_64_15 + var_64_22 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play120121016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 120121016
		arg_65_1.duration_ = 7.97

		local var_65_0 = {
			zh = 5.333,
			ja = 7.966
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
				arg_65_0:Play120121017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1071ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1071ui_story == nil then
				arg_65_1.var_.characterEffect1071ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1071ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1071ui_story then
				arg_65_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_68_4 = arg_65_1.actors_["1071ui_story"].transform
			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.var_.moveOldPos1071ui_story = var_68_4.localPosition
			end

			local var_68_6 = 0.001

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_6 then
				local var_68_7 = (arg_65_1.time_ - var_68_5) / var_68_6
				local var_68_8 = Vector3.New(0, -1.05, -6.2)

				var_68_4.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1071ui_story, var_68_8, var_68_7)

				local var_68_9 = manager.ui.mainCamera.transform.position - var_68_4.position

				var_68_4.forward = Vector3.New(var_68_9.x, var_68_9.y, var_68_9.z)

				local var_68_10 = var_68_4.localEulerAngles

				var_68_10.z = 0
				var_68_10.x = 0
				var_68_4.localEulerAngles = var_68_10
			end

			if arg_65_1.time_ >= var_68_5 + var_68_6 and arg_65_1.time_ < var_68_5 + var_68_6 + arg_68_0 then
				var_68_4.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_68_11 = manager.ui.mainCamera.transform.position - var_68_4.position

				var_68_4.forward = Vector3.New(var_68_11.x, var_68_11.y, var_68_11.z)

				local var_68_12 = var_68_4.localEulerAngles

				var_68_12.z = 0
				var_68_12.x = 0
				var_68_4.localEulerAngles = var_68_12
			end

			local var_68_13 = 0
			local var_68_14 = 0.6

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_15 = arg_65_1:FormatText(StoryNameCfg[384].name)

				arg_65_1.leftNameTxt_.text = var_68_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_16 = arg_65_1:GetWordFromCfg(120121016)
				local var_68_17 = arg_65_1:FormatText(var_68_16.content)

				arg_65_1.text_.text = var_68_17

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_18 = 24
				local var_68_19 = utf8.len(var_68_17)
				local var_68_20 = var_68_18 <= 0 and var_68_14 or var_68_14 * (var_68_19 / var_68_18)

				if var_68_20 > 0 and var_68_14 < var_68_20 then
					arg_65_1.talkMaxDuration = var_68_20

					if var_68_20 + var_68_13 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_13
					end
				end

				arg_65_1.text_.text = var_68_17
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121016", "story_v_out_120121.awb") ~= 0 then
					local var_68_21 = manager.audio:GetVoiceLength("story_v_out_120121", "120121016", "story_v_out_120121.awb") / 1000

					if var_68_21 + var_68_13 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_21 + var_68_13
					end

					if var_68_16.prefab_name ~= "" and arg_65_1.actors_[var_68_16.prefab_name] ~= nil then
						local var_68_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_16.prefab_name].transform, "story_v_out_120121", "120121016", "story_v_out_120121.awb")

						arg_65_1:RecordAudio("120121016", var_68_22)
						arg_65_1:RecordAudio("120121016", var_68_22)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_120121", "120121016", "story_v_out_120121.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_120121", "120121016", "story_v_out_120121.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_23 = math.max(var_68_14, arg_65_1.talkMaxDuration)

			if var_68_13 <= arg_65_1.time_ and arg_65_1.time_ < var_68_13 + var_68_23 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_13) / var_68_23

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_13 + var_68_23 and arg_65_1.time_ < var_68_13 + var_68_23 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play120121017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 120121017
		arg_69_1.duration_ = 5.33

		local var_69_0 = {
			zh = 3.5,
			ja = 5.333
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
				arg_69_0:Play120121018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.375

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[384].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(120121017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121017", "story_v_out_120121.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_120121", "120121017", "story_v_out_120121.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_120121", "120121017", "story_v_out_120121.awb")

						arg_69_1:RecordAudio("120121017", var_72_9)
						arg_69_1:RecordAudio("120121017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_120121", "120121017", "story_v_out_120121.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_120121", "120121017", "story_v_out_120121.awb")
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
	Play120121018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 120121018
		arg_73_1.duration_ = 4.67

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play120121019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = "STblack"

			if arg_73_1.bgs_[var_76_0] == nil then
				local var_76_1 = Object.Instantiate(arg_73_1.paintGo_)

				var_76_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_76_0)
				var_76_1.name = var_76_0
				var_76_1.transform.parent = arg_73_1.stage_.transform
				var_76_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.bgs_[var_76_0] = var_76_1
			end

			local var_76_2 = 2

			if var_76_2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				local var_76_3 = manager.ui.mainCamera.transform.localPosition
				local var_76_4 = Vector3.New(0, 0, 10) + Vector3.New(var_76_3.x, var_76_3.y, 0)
				local var_76_5 = arg_73_1.bgs_.STblack

				var_76_5.transform.localPosition = var_76_4
				var_76_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_76_6 = var_76_5:GetComponent("SpriteRenderer")

				if var_76_6 and var_76_6.sprite then
					local var_76_7 = (var_76_5.transform.localPosition - var_76_3).z
					local var_76_8 = manager.ui.mainCameraCom_
					local var_76_9 = 2 * var_76_7 * Mathf.Tan(var_76_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_76_10 = var_76_9 * var_76_8.aspect
					local var_76_11 = var_76_6.sprite.bounds.size.x
					local var_76_12 = var_76_6.sprite.bounds.size.y
					local var_76_13 = var_76_10 / var_76_11
					local var_76_14 = var_76_9 / var_76_12
					local var_76_15 = var_76_14 < var_76_13 and var_76_13 or var_76_14

					var_76_5.transform.localScale = Vector3.New(var_76_15, var_76_15, 0)
				end

				for iter_76_0, iter_76_1 in pairs(arg_73_1.bgs_) do
					if iter_76_0 ~= "STblack" then
						iter_76_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_17 = 2

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17
				local var_76_19 = Color.New(0, 0, 0)

				var_76_19.a = Mathf.Lerp(0, 1, var_76_18)
				arg_73_1.mask_.color = var_76_19
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 then
				local var_76_20 = Color.New(0, 0, 0)

				var_76_20.a = 1
				arg_73_1.mask_.color = var_76_20
			end

			local var_76_21 = 2

			if var_76_21 < arg_73_1.time_ and arg_73_1.time_ <= var_76_21 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_22 = 2

			if var_76_21 <= arg_73_1.time_ and arg_73_1.time_ < var_76_21 + var_76_22 then
				local var_76_23 = (arg_73_1.time_ - var_76_21) / var_76_22
				local var_76_24 = Color.New(0, 0, 0)

				var_76_24.a = Mathf.Lerp(1, 0, var_76_23)
				arg_73_1.mask_.color = var_76_24
			end

			if arg_73_1.time_ >= var_76_21 + var_76_22 and arg_73_1.time_ < var_76_21 + var_76_22 + arg_76_0 then
				local var_76_25 = Color.New(0, 0, 0)
				local var_76_26 = 0

				arg_73_1.mask_.enabled = false
				var_76_25.a = var_76_26
				arg_73_1.mask_.color = var_76_25
			end

			local var_76_27 = arg_73_1.actors_["1071ui_story"].transform
			local var_76_28 = 1.966

			if var_76_28 < arg_73_1.time_ and arg_73_1.time_ <= var_76_28 + arg_76_0 then
				arg_73_1.var_.moveOldPos1071ui_story = var_76_27.localPosition
			end

			local var_76_29 = 0.001

			if var_76_28 <= arg_73_1.time_ and arg_73_1.time_ < var_76_28 + var_76_29 then
				local var_76_30 = (arg_73_1.time_ - var_76_28) / var_76_29
				local var_76_31 = Vector3.New(0, 100, 0)

				var_76_27.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1071ui_story, var_76_31, var_76_30)

				local var_76_32 = manager.ui.mainCamera.transform.position - var_76_27.position

				var_76_27.forward = Vector3.New(var_76_32.x, var_76_32.y, var_76_32.z)

				local var_76_33 = var_76_27.localEulerAngles

				var_76_33.z = 0
				var_76_33.x = 0
				var_76_27.localEulerAngles = var_76_33
			end

			if arg_73_1.time_ >= var_76_28 + var_76_29 and arg_73_1.time_ < var_76_28 + var_76_29 + arg_76_0 then
				var_76_27.localPosition = Vector3.New(0, 100, 0)

				local var_76_34 = manager.ui.mainCamera.transform.position - var_76_27.position

				var_76_27.forward = Vector3.New(var_76_34.x, var_76_34.y, var_76_34.z)

				local var_76_35 = var_76_27.localEulerAngles

				var_76_35.z = 0
				var_76_35.x = 0
				var_76_27.localEulerAngles = var_76_35
			end

			local var_76_36 = 2

			if var_76_36 < arg_73_1.time_ and arg_73_1.time_ <= var_76_36 + arg_76_0 then
				arg_73_1.fswbg_:SetActive(true)
				arg_73_1.dialog_:SetActive(false)

				arg_73_1.fswtw_.percent = 0

				local var_76_37 = arg_73_1:GetWordFromCfg(120121018)
				local var_76_38 = arg_73_1:FormatText(var_76_37.content)

				arg_73_1.fswt_.text = var_76_38

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.fswt_)

				arg_73_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_73_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_73_1.fswtw_:SetDirty()

				arg_73_1.typewritterCharCountI18N = 0

				SetActive(arg_73_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_73_1:ShowNextGo(false)
			end

			local var_76_39 = 2.01666666666667

			if var_76_39 < arg_73_1.time_ and arg_73_1.time_ <= var_76_39 + arg_76_0 then
				arg_73_1.var_.oldValueTypewriter = arg_73_1.fswtw_.percent

				SetActive(arg_73_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_73_1:ShowNextGo(false)
			end

			local var_76_40 = 27
			local var_76_41 = 1.8
			local var_76_42 = arg_73_1:GetWordFromCfg(120121018)
			local var_76_43 = arg_73_1:FormatText(var_76_42.content)
			local var_76_44, var_76_45 = arg_73_1:GetPercentByPara(var_76_43, 1)

			if var_76_39 < arg_73_1.time_ and arg_73_1.time_ <= var_76_39 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				local var_76_46 = var_76_40 <= 0 and var_76_41 or var_76_41 * ((var_76_45 - arg_73_1.typewritterCharCountI18N) / var_76_40)

				if var_76_46 > 0 and var_76_41 < var_76_46 then
					arg_73_1.talkMaxDuration = var_76_46

					if var_76_46 + var_76_39 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_46 + var_76_39
					end
				end
			end

			local var_76_47 = 1.8
			local var_76_48 = math.max(var_76_47, arg_73_1.talkMaxDuration)

			if var_76_39 <= arg_73_1.time_ and arg_73_1.time_ < var_76_39 + var_76_48 then
				local var_76_49 = (arg_73_1.time_ - var_76_39) / var_76_48

				arg_73_1.fswtw_.percent = Mathf.Lerp(arg_73_1.var_.oldValueTypewriter, var_76_44, var_76_49)
				arg_73_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_73_1.fswtw_:SetDirty()
			end

			if arg_73_1.time_ >= var_76_39 + var_76_48 and arg_73_1.time_ < var_76_39 + var_76_48 + arg_76_0 then
				arg_73_1.fswtw_.percent = var_76_44

				arg_73_1.fswtw_:SetDirty()
				arg_73_1:ShowNextGo(true)

				arg_73_1.typewritterCharCountI18N = var_76_45
			end

			local var_76_50 = 2

			if var_76_50 < arg_73_1.time_ and arg_73_1.time_ <= var_76_50 + arg_76_0 then
				local var_76_51 = arg_73_1.fswbg_.transform:Find("textbox/adapt/content") or arg_73_1.fswbg_.transform:Find("textbox/content")
				local var_76_52 = arg_73_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_76_53 = var_76_51:GetComponent("Text")
				local var_76_54 = var_76_51:GetComponent("RectTransform")

				var_76_53.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_76_54.offsetMin = Vector2.New(0, 0)
				var_76_54.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play120121019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 120121019
		arg_77_1.duration_ = 2.08

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play120121020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.fswbg_:SetActive(true)
				arg_77_1.dialog_:SetActive(false)

				arg_77_1.fswtw_.percent = 0

				local var_80_1 = arg_77_1:GetWordFromCfg(120121019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.fswt_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.fswt_)

				arg_77_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_77_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_77_1.fswtw_:SetDirty()

				arg_77_1.typewritterCharCountI18N = 0

				SetActive(arg_77_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_77_1:ShowNextGo(false)
			end

			local var_80_3 = 0.0166666666666667

			if var_80_3 < arg_77_1.time_ and arg_77_1.time_ <= var_80_3 + arg_80_0 then
				arg_77_1.var_.oldValueTypewriter = arg_77_1.fswtw_.percent

				SetActive(arg_77_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_77_1:ShowNextGo(false)
			end

			local var_80_4 = 31
			local var_80_5 = 2.06666666666667
			local var_80_6 = arg_77_1:GetWordFromCfg(120121019)
			local var_80_7 = arg_77_1:FormatText(var_80_6.content)
			local var_80_8, var_80_9 = arg_77_1:GetPercentByPara(var_80_7, 1)

			if var_80_3 < arg_77_1.time_ and arg_77_1.time_ <= var_80_3 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				local var_80_10 = var_80_4 <= 0 and var_80_5 or var_80_5 * ((var_80_9 - arg_77_1.typewritterCharCountI18N) / var_80_4)

				if var_80_10 > 0 and var_80_5 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_3 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_3
					end
				end
			end

			local var_80_11 = 2.06666666666667
			local var_80_12 = math.max(var_80_11, arg_77_1.talkMaxDuration)

			if var_80_3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_3 + var_80_12 then
				local var_80_13 = (arg_77_1.time_ - var_80_3) / var_80_12

				arg_77_1.fswtw_.percent = Mathf.Lerp(arg_77_1.var_.oldValueTypewriter, var_80_8, var_80_13)
				arg_77_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_77_1.fswtw_:SetDirty()
			end

			if arg_77_1.time_ >= var_80_3 + var_80_12 and arg_77_1.time_ < var_80_3 + var_80_12 + arg_80_0 then
				arg_77_1.fswtw_.percent = var_80_8

				arg_77_1.fswtw_:SetDirty()
				arg_77_1:ShowNextGo(true)

				arg_77_1.typewritterCharCountI18N = var_80_9
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play120121020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 120121020
		arg_81_1.duration_ = 4.08

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play120121021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.fswbg_:SetActive(true)
				arg_81_1.dialog_:SetActive(false)

				arg_81_1.fswtw_.percent = 0

				local var_84_1 = arg_81_1:GetWordFromCfg(120121020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.fswt_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.fswt_)

				arg_81_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_81_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_81_1.fswtw_:SetDirty()

				arg_81_1.typewritterCharCountI18N = 0

				SetActive(arg_81_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_81_1:ShowNextGo(false)
			end

			local var_84_3 = 0.0166666666666666

			if var_84_3 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.var_.oldValueTypewriter = arg_81_1.fswtw_.percent

				SetActive(arg_81_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_81_1:ShowNextGo(false)
			end

			local var_84_4 = 62
			local var_84_5 = 4.06666666666667
			local var_84_6 = arg_81_1:GetWordFromCfg(120121020)
			local var_84_7 = arg_81_1:FormatText(var_84_6.content)
			local var_84_8, var_84_9 = arg_81_1:GetPercentByPara(var_84_7, 1)

			if var_84_3 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				local var_84_10 = var_84_4 <= 0 and var_84_5 or var_84_5 * ((var_84_9 - arg_81_1.typewritterCharCountI18N) / var_84_4)

				if var_84_10 > 0 and var_84_5 < var_84_10 then
					arg_81_1.talkMaxDuration = var_84_10

					if var_84_10 + var_84_3 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_3
					end
				end
			end

			local var_84_11 = 4.06666666666667
			local var_84_12 = math.max(var_84_11, arg_81_1.talkMaxDuration)

			if var_84_3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_3 + var_84_12 then
				local var_84_13 = (arg_81_1.time_ - var_84_3) / var_84_12

				arg_81_1.fswtw_.percent = Mathf.Lerp(arg_81_1.var_.oldValueTypewriter, var_84_8, var_84_13)
				arg_81_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_81_1.fswtw_:SetDirty()
			end

			if arg_81_1.time_ >= var_84_3 + var_84_12 and arg_81_1.time_ < var_84_3 + var_84_12 + arg_84_0 then
				arg_81_1.fswtw_.percent = var_84_8

				arg_81_1.fswtw_:SetDirty()
				arg_81_1:ShowNextGo(true)

				arg_81_1.typewritterCharCountI18N = var_84_9
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play120121021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 120121021
		arg_85_1.duration_ = 9

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play120121022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = "J13f"

			if arg_85_1.bgs_[var_88_0] == nil then
				local var_88_1 = Object.Instantiate(arg_85_1.paintGo_)

				var_88_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_88_0)
				var_88_1.name = var_88_0
				var_88_1.transform.parent = arg_85_1.stage_.transform
				var_88_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.bgs_[var_88_0] = var_88_1
			end

			local var_88_2 = 2

			if var_88_2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				local var_88_3 = manager.ui.mainCamera.transform.localPosition
				local var_88_4 = Vector3.New(0, 0, 10) + Vector3.New(var_88_3.x, var_88_3.y, 0)
				local var_88_5 = arg_85_1.bgs_.J13f

				var_88_5.transform.localPosition = var_88_4
				var_88_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_6 = var_88_5:GetComponent("SpriteRenderer")

				if var_88_6 and var_88_6.sprite then
					local var_88_7 = (var_88_5.transform.localPosition - var_88_3).z
					local var_88_8 = manager.ui.mainCameraCom_
					local var_88_9 = 2 * var_88_7 * Mathf.Tan(var_88_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_88_10 = var_88_9 * var_88_8.aspect
					local var_88_11 = var_88_6.sprite.bounds.size.x
					local var_88_12 = var_88_6.sprite.bounds.size.y
					local var_88_13 = var_88_10 / var_88_11
					local var_88_14 = var_88_9 / var_88_12
					local var_88_15 = var_88_14 < var_88_13 and var_88_13 or var_88_14

					var_88_5.transform.localScale = Vector3.New(var_88_15, var_88_15, 0)
				end

				for iter_88_0, iter_88_1 in pairs(arg_85_1.bgs_) do
					if iter_88_0 ~= "J13f" then
						iter_88_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_16 = 0

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_17 = 2

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_17 then
				local var_88_18 = (arg_85_1.time_ - var_88_16) / var_88_17
				local var_88_19 = Color.New(0, 0, 0)

				var_88_19.a = Mathf.Lerp(0, 1, var_88_18)
				arg_85_1.mask_.color = var_88_19
			end

			if arg_85_1.time_ >= var_88_16 + var_88_17 and arg_85_1.time_ < var_88_16 + var_88_17 + arg_88_0 then
				local var_88_20 = Color.New(0, 0, 0)

				var_88_20.a = 1
				arg_85_1.mask_.color = var_88_20
			end

			local var_88_21 = 2

			if var_88_21 < arg_85_1.time_ and arg_85_1.time_ <= var_88_21 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_22 = 2

			if var_88_21 <= arg_85_1.time_ and arg_85_1.time_ < var_88_21 + var_88_22 then
				local var_88_23 = (arg_85_1.time_ - var_88_21) / var_88_22
				local var_88_24 = Color.New(0, 0, 0)

				var_88_24.a = Mathf.Lerp(1, 0, var_88_23)
				arg_85_1.mask_.color = var_88_24
			end

			if arg_85_1.time_ >= var_88_21 + var_88_22 and arg_85_1.time_ < var_88_21 + var_88_22 + arg_88_0 then
				local var_88_25 = Color.New(0, 0, 0)
				local var_88_26 = 0

				arg_85_1.mask_.enabled = false
				var_88_25.a = var_88_26
				arg_85_1.mask_.color = var_88_25
			end

			local var_88_27 = 0
			local var_88_28 = 0.866666666666667

			if var_88_27 < arg_85_1.time_ and arg_85_1.time_ <= var_88_27 + arg_88_0 then
				local var_88_29 = "play"
				local var_88_30 = "music"

				arg_85_1:AudioAction(var_88_29, var_88_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_88_31 = ""
				local var_88_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_88_32 ~= "" then
					if arg_85_1.bgmTxt_.text ~= var_88_32 and arg_85_1.bgmTxt_.text ~= "" then
						if arg_85_1.bgmTxt2_.text ~= "" then
							arg_85_1.bgmTxt_.text = arg_85_1.bgmTxt2_.text
						end

						arg_85_1.bgmTxt2_.text = var_88_32

						arg_85_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_85_1.bgmTxt_.text = var_88_32
						arg_85_1.bgmTxt2_.text = var_88_32
					end

					if arg_85_1.bgmTimer then
						arg_85_1.bgmTimer:Stop()

						arg_85_1.bgmTimer = nil
					end

					if arg_85_1.settingData.show_music_name == 1 then
						arg_85_1.musicController:SetSelectedState("show")
						arg_85_1.musicAnimator_:Play("open", 0, 0)

						if arg_85_1.settingData.music_time ~= 0 then
							arg_85_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_85_1.settingData.music_time), function()
								if arg_85_1 == nil or isNil(arg_85_1.bgmTxt_) then
									return
								end

								arg_85_1.musicController:SetSelectedState("hide")
								arg_85_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_88_33 = 2

			if var_88_33 < arg_85_1.time_ and arg_85_1.time_ <= var_88_33 + arg_88_0 then
				arg_85_1.fswbg_:SetActive(false)
				arg_85_1.dialog_:SetActive(false)
				SetActive(arg_85_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_85_1:ShowNextGo(false)
			end

			local var_88_34 = "J13f_blur"

			if arg_85_1.bgs_[var_88_34] == nil then
				local var_88_35 = Object.Instantiate(arg_85_1.blurPaintGo_)
				local var_88_36 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_88_34)

				var_88_35:GetComponent("SpriteRenderer").sprite = var_88_36
				var_88_35.name = var_88_34
				var_88_35.transform.parent = arg_85_1.stage_.transform
				var_88_35.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.bgs_[var_88_34] = var_88_35
			end

			local var_88_37 = 2
			local var_88_38 = arg_85_1.bgs_[var_88_34]

			if var_88_37 < arg_85_1.time_ and arg_85_1.time_ <= var_88_37 + arg_88_0 then
				local var_88_39 = manager.ui.mainCamera.transform.localPosition
				local var_88_40 = Vector3.New(0, 0, 10) + Vector3.New(var_88_39.x, var_88_39.y, 0)

				var_88_38.transform.localPosition = var_88_40
				var_88_38.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_41 = var_88_38:GetComponent("SpriteRenderer")

				if var_88_41 and var_88_41.sprite then
					local var_88_42 = (var_88_38.transform.localPosition - var_88_39).z
					local var_88_43 = manager.ui.mainCameraCom_
					local var_88_44 = 2 * var_88_42 * Mathf.Tan(var_88_43.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_88_45 = var_88_44 * var_88_43.aspect
					local var_88_46 = var_88_41.sprite.bounds.size.x
					local var_88_47 = var_88_41.sprite.bounds.size.y
					local var_88_48 = var_88_45 / var_88_46
					local var_88_49 = var_88_44 / var_88_47
					local var_88_50 = var_88_49 < var_88_48 and var_88_48 or var_88_49

					var_88_38.transform.localScale = Vector3.New(var_88_50, var_88_50, 0)
				end
			end

			local var_88_51 = 2

			if var_88_37 <= arg_85_1.time_ and arg_85_1.time_ < var_88_37 + var_88_51 then
				local var_88_52 = (arg_85_1.time_ - var_88_37) / var_88_51
				local var_88_53 = Color.New(1, 1, 1)

				var_88_53.a = Mathf.Lerp(1, 0, var_88_52)

				var_88_38:GetComponent("SpriteRenderer").material:SetColor("_Color", var_88_53)
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_54 = 4
			local var_88_55 = 0.825

			if var_88_54 < arg_85_1.time_ and arg_85_1.time_ <= var_88_54 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_56 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_56:setOnUpdate(LuaHelper.FloatAction(function(arg_90_0)
					arg_85_1.dialogCg_.alpha = arg_90_0
				end))
				var_88_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_57 = arg_85_1:GetWordFromCfg(120121021)
				local var_88_58 = arg_85_1:FormatText(var_88_57.content)

				arg_85_1.text_.text = var_88_58

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_59 = 33
				local var_88_60 = utf8.len(var_88_58)
				local var_88_61 = var_88_59 <= 0 and var_88_55 or var_88_55 * (var_88_60 / var_88_59)

				if var_88_61 > 0 and var_88_55 < var_88_61 then
					arg_85_1.talkMaxDuration = var_88_61
					var_88_54 = var_88_54 + 0.3

					if var_88_61 + var_88_54 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_61 + var_88_54
					end
				end

				arg_85_1.text_.text = var_88_58
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_62 = var_88_54 + 0.3
			local var_88_63 = math.max(var_88_55, arg_85_1.talkMaxDuration)

			if var_88_62 <= arg_85_1.time_ and arg_85_1.time_ < var_88_62 + var_88_63 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_62) / var_88_63

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_62 + var_88_63 and arg_85_1.time_ < var_88_62 + var_88_63 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play120121022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 120121022
		arg_92_1.duration_ = 8.53

		local var_92_0 = {
			zh = 4.333,
			ja = 8.533
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
				arg_92_0:Play120121023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 0.5

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[384].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(120121022)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 20
				local var_95_6 = utf8.len(var_95_4)
				local var_95_7 = var_95_5 <= 0 and var_95_1 or var_95_1 * (var_95_6 / var_95_5)

				if var_95_7 > 0 and var_95_1 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121022", "story_v_out_120121.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_120121", "120121022", "story_v_out_120121.awb") / 1000

					if var_95_8 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_0
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_120121", "120121022", "story_v_out_120121.awb")

						arg_92_1:RecordAudio("120121022", var_95_9)
						arg_92_1:RecordAudio("120121022", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_120121", "120121022", "story_v_out_120121.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_120121", "120121022", "story_v_out_120121.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_10 and arg_92_1.time_ < var_95_0 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play120121023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 120121023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play120121024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.4

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_2 = arg_96_1:GetWordFromCfg(120121023)
				local var_99_3 = arg_96_1:FormatText(var_99_2.content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 16
				local var_99_5 = utf8.len(var_99_3)
				local var_99_6 = var_99_4 <= 0 and var_99_1 or var_99_1 * (var_99_5 / var_99_4)

				if var_99_6 > 0 and var_99_1 < var_99_6 then
					arg_96_1.talkMaxDuration = var_99_6

					if var_99_6 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_7 and arg_96_1.time_ < var_99_0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play120121024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 120121024
		arg_100_1.duration_ = 2.4

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play120121025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = "1075ui_story"

			if arg_100_1.actors_[var_103_0] == nil then
				local var_103_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_103_1) then
					local var_103_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_100_1.stage_.transform)

					var_103_2.name = var_103_0
					var_103_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_100_1.actors_[var_103_0] = var_103_2

					local var_103_3 = var_103_2:GetComponentInChildren(typeof(CharacterEffect))

					var_103_3.enabled = true

					local var_103_4 = GameObjectTools.GetOrAddComponent(var_103_2, typeof(DynamicBoneHelper))

					if var_103_4 then
						var_103_4:EnableDynamicBone(false)
					end

					arg_100_1:ShowWeapon(var_103_3.transform, false)

					arg_100_1.var_[var_103_0 .. "Animator"] = var_103_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_100_1.var_[var_103_0 .. "Animator"].applyRootMotion = true
					arg_100_1.var_[var_103_0 .. "LipSync"] = var_103_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_103_5 = arg_100_1.actors_["1075ui_story"].transform
			local var_103_6 = 0

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.var_.moveOldPos1075ui_story = var_103_5.localPosition
			end

			local var_103_7 = 0.001

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_7 then
				local var_103_8 = (arg_100_1.time_ - var_103_6) / var_103_7
				local var_103_9 = Vector3.New(0, -1.055, -6.16)

				var_103_5.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1075ui_story, var_103_9, var_103_8)

				local var_103_10 = manager.ui.mainCamera.transform.position - var_103_5.position

				var_103_5.forward = Vector3.New(var_103_10.x, var_103_10.y, var_103_10.z)

				local var_103_11 = var_103_5.localEulerAngles

				var_103_11.z = 0
				var_103_11.x = 0
				var_103_5.localEulerAngles = var_103_11
			end

			if arg_100_1.time_ >= var_103_6 + var_103_7 and arg_100_1.time_ < var_103_6 + var_103_7 + arg_103_0 then
				var_103_5.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_103_12 = manager.ui.mainCamera.transform.position - var_103_5.position

				var_103_5.forward = Vector3.New(var_103_12.x, var_103_12.y, var_103_12.z)

				local var_103_13 = var_103_5.localEulerAngles

				var_103_13.z = 0
				var_103_13.x = 0
				var_103_5.localEulerAngles = var_103_13
			end

			local var_103_14 = 0

			if var_103_14 < arg_100_1.time_ and arg_100_1.time_ <= var_103_14 + arg_103_0 then
				arg_100_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_103_15 = 0

			if var_103_15 < arg_100_1.time_ and arg_100_1.time_ <= var_103_15 + arg_103_0 then
				arg_100_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_103_16 = 0
			local var_103_17 = 0.15

			if var_103_16 < arg_100_1.time_ and arg_100_1.time_ <= var_103_16 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_18 = arg_100_1:FormatText(StoryNameCfg[381].name)

				arg_100_1.leftNameTxt_.text = var_103_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_19 = arg_100_1:GetWordFromCfg(120121024)
				local var_103_20 = arg_100_1:FormatText(var_103_19.content)

				arg_100_1.text_.text = var_103_20

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_21 = 6
				local var_103_22 = utf8.len(var_103_20)
				local var_103_23 = var_103_21 <= 0 and var_103_17 or var_103_17 * (var_103_22 / var_103_21)

				if var_103_23 > 0 and var_103_17 < var_103_23 then
					arg_100_1.talkMaxDuration = var_103_23

					if var_103_23 + var_103_16 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_23 + var_103_16
					end
				end

				arg_100_1.text_.text = var_103_20
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121024", "story_v_out_120121.awb") ~= 0 then
					local var_103_24 = manager.audio:GetVoiceLength("story_v_out_120121", "120121024", "story_v_out_120121.awb") / 1000

					if var_103_24 + var_103_16 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_24 + var_103_16
					end

					if var_103_19.prefab_name ~= "" and arg_100_1.actors_[var_103_19.prefab_name] ~= nil then
						local var_103_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_19.prefab_name].transform, "story_v_out_120121", "120121024", "story_v_out_120121.awb")

						arg_100_1:RecordAudio("120121024", var_103_25)
						arg_100_1:RecordAudio("120121024", var_103_25)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_120121", "120121024", "story_v_out_120121.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_120121", "120121024", "story_v_out_120121.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_26 = math.max(var_103_17, arg_100_1.talkMaxDuration)

			if var_103_16 <= arg_100_1.time_ and arg_100_1.time_ < var_103_16 + var_103_26 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_16) / var_103_26

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_16 + var_103_26 and arg_100_1.time_ < var_103_16 + var_103_26 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
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

		arg_100_1:InitPlayNodeList()
	end,
	Play120121025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 120121025
		arg_104_1.duration_ = 5.27

		local var_104_0 = {
			zh = 4.1,
			ja = 5.266
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
				arg_104_0:Play120121026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.525

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[381].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_3 = arg_104_1:GetWordFromCfg(120121025)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 21
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121025", "story_v_out_120121.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_120121", "120121025", "story_v_out_120121.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_120121", "120121025", "story_v_out_120121.awb")

						arg_104_1:RecordAudio("120121025", var_107_9)
						arg_104_1:RecordAudio("120121025", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_120121", "120121025", "story_v_out_120121.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_120121", "120121025", "story_v_out_120121.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_10 and arg_104_1.time_ < var_107_0 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play120121026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 120121026
		arg_108_1.duration_ = 2

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play120121027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.166666666666667

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				local var_111_2 = "play"
				local var_111_3 = "music"

				arg_108_1:AudioAction(var_111_2, var_111_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_111_4 = ""
				local var_111_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_111_5 ~= "" then
					if arg_108_1.bgmTxt_.text ~= var_111_5 and arg_108_1.bgmTxt_.text ~= "" then
						if arg_108_1.bgmTxt2_.text ~= "" then
							arg_108_1.bgmTxt_.text = arg_108_1.bgmTxt2_.text
						end

						arg_108_1.bgmTxt2_.text = var_111_5

						arg_108_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_108_1.bgmTxt_.text = var_111_5
						arg_108_1.bgmTxt2_.text = var_111_5
					end

					if arg_108_1.bgmTimer then
						arg_108_1.bgmTimer:Stop()

						arg_108_1.bgmTimer = nil
					end

					if arg_108_1.settingData.show_music_name == 1 then
						arg_108_1.musicController:SetSelectedState("show")
						arg_108_1.musicAnimator_:Play("open", 0, 0)

						if arg_108_1.settingData.music_time ~= 0 then
							arg_108_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_108_1.settingData.music_time), function()
								if arg_108_1 == nil or isNil(arg_108_1.bgmTxt_) then
									return
								end

								arg_108_1.musicController:SetSelectedState("hide")
								arg_108_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_111_6 = 0.233333333333333
			local var_111_7 = 1

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				local var_111_8 = "play"
				local var_111_9 = "music"

				arg_108_1:AudioAction(var_111_8, var_111_9, "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu.awb")

				local var_111_10 = ""
				local var_111_11 = manager.audio:GetAudioName("bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu")

				if var_111_11 ~= "" then
					if arg_108_1.bgmTxt_.text ~= var_111_11 and arg_108_1.bgmTxt_.text ~= "" then
						if arg_108_1.bgmTxt2_.text ~= "" then
							arg_108_1.bgmTxt_.text = arg_108_1.bgmTxt2_.text
						end

						arg_108_1.bgmTxt2_.text = var_111_11

						arg_108_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_108_1.bgmTxt_.text = var_111_11
						arg_108_1.bgmTxt2_.text = var_111_11
					end

					if arg_108_1.bgmTimer then
						arg_108_1.bgmTimer:Stop()

						arg_108_1.bgmTimer = nil
					end

					if arg_108_1.settingData.show_music_name == 1 then
						arg_108_1.musicController:SetSelectedState("show")
						arg_108_1.musicAnimator_:Play("open", 0, 0)

						if arg_108_1.settingData.music_time ~= 0 then
							arg_108_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_108_1.settingData.music_time), function()
								if arg_108_1 == nil or isNil(arg_108_1.bgmTxt_) then
									return
								end

								arg_108_1.musicController:SetSelectedState("hide")
								arg_108_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_111_12 = 0

			if var_111_12 < arg_108_1.time_ and arg_108_1.time_ <= var_111_12 + arg_111_0 then
				arg_108_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_111_13 = arg_108_1.actors_["1075ui_story"]
			local var_111_14 = 0

			if var_111_14 < arg_108_1.time_ and arg_108_1.time_ <= var_111_14 + arg_111_0 and not isNil(var_111_13) and arg_108_1.var_.characterEffect1075ui_story == nil then
				arg_108_1.var_.characterEffect1075ui_story = var_111_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_15 = 0.2

			if var_111_14 <= arg_108_1.time_ and arg_108_1.time_ < var_111_14 + var_111_15 and not isNil(var_111_13) then
				local var_111_16 = (arg_108_1.time_ - var_111_14) / var_111_15

				if arg_108_1.var_.characterEffect1075ui_story and not isNil(var_111_13) then
					local var_111_17 = Mathf.Lerp(0, 0.5, var_111_16)

					arg_108_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1075ui_story.fillRatio = var_111_17
				end
			end

			if arg_108_1.time_ >= var_111_14 + var_111_15 and arg_108_1.time_ < var_111_14 + var_111_15 + arg_111_0 and not isNil(var_111_13) and arg_108_1.var_.characterEffect1075ui_story then
				local var_111_18 = 0.5

				arg_108_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1075ui_story.fillRatio = var_111_18
			end

			local var_111_19 = 0
			local var_111_20 = 0.05

			if var_111_19 < arg_108_1.time_ and arg_108_1.time_ <= var_111_19 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_21 = arg_108_1:FormatText(StoryNameCfg[384].name)

				arg_108_1.leftNameTxt_.text = var_111_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_22 = arg_108_1:GetWordFromCfg(120121026)
				local var_111_23 = arg_108_1:FormatText(var_111_22.content)

				arg_108_1.text_.text = var_111_23

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_24 = 2
				local var_111_25 = utf8.len(var_111_23)
				local var_111_26 = var_111_24 <= 0 and var_111_20 or var_111_20 * (var_111_25 / var_111_24)

				if var_111_26 > 0 and var_111_20 < var_111_26 then
					arg_108_1.talkMaxDuration = var_111_26

					if var_111_26 + var_111_19 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_26 + var_111_19
					end
				end

				arg_108_1.text_.text = var_111_23
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121026", "story_v_out_120121.awb") ~= 0 then
					local var_111_27 = manager.audio:GetVoiceLength("story_v_out_120121", "120121026", "story_v_out_120121.awb") / 1000

					if var_111_27 + var_111_19 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_27 + var_111_19
					end

					if var_111_22.prefab_name ~= "" and arg_108_1.actors_[var_111_22.prefab_name] ~= nil then
						local var_111_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_22.prefab_name].transform, "story_v_out_120121", "120121026", "story_v_out_120121.awb")

						arg_108_1:RecordAudio("120121026", var_111_28)
						arg_108_1:RecordAudio("120121026", var_111_28)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_120121", "120121026", "story_v_out_120121.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_120121", "120121026", "story_v_out_120121.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_29 = math.max(var_111_20, arg_108_1.talkMaxDuration)

			if var_111_19 <= arg_108_1.time_ and arg_108_1.time_ < var_111_19 + var_111_29 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_19) / var_111_29

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_19 + var_111_29 and arg_108_1.time_ < var_111_19 + var_111_29 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play120121027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 120121027
		arg_114_1.duration_ = 11.6

		local var_114_0 = {
			zh = 11.6,
			ja = 7.433
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
				arg_114_0:Play120121028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1071ui_story"].transform
			local var_117_1 = 3.8

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos1071ui_story = var_117_0.localPosition
			end

			local var_117_2 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2
				local var_117_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1071ui_story, var_117_4, var_117_3)

				local var_117_5 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_5.x, var_117_5.y, var_117_5.z)

				local var_117_6 = var_117_0.localEulerAngles

				var_117_6.z = 0
				var_117_6.x = 0
				var_117_0.localEulerAngles = var_117_6
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_117_7 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_7.x, var_117_7.y, var_117_7.z)

				local var_117_8 = var_117_0.localEulerAngles

				var_117_8.z = 0
				var_117_8.x = 0
				var_117_0.localEulerAngles = var_117_8
			end

			local var_117_9 = arg_114_1.actors_["1075ui_story"].transform
			local var_117_10 = 3.8

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1.var_.moveOldPos1075ui_story = var_117_9.localPosition
			end

			local var_117_11 = 0.001

			if var_117_10 <= arg_114_1.time_ and arg_114_1.time_ < var_117_10 + var_117_11 then
				local var_117_12 = (arg_114_1.time_ - var_117_10) / var_117_11
				local var_117_13 = Vector3.New(0.7, -1.055, -6.16)

				var_117_9.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1075ui_story, var_117_13, var_117_12)

				local var_117_14 = manager.ui.mainCamera.transform.position - var_117_9.position

				var_117_9.forward = Vector3.New(var_117_14.x, var_117_14.y, var_117_14.z)

				local var_117_15 = var_117_9.localEulerAngles

				var_117_15.z = 0
				var_117_15.x = 0
				var_117_9.localEulerAngles = var_117_15
			end

			if arg_114_1.time_ >= var_117_10 + var_117_11 and arg_114_1.time_ < var_117_10 + var_117_11 + arg_117_0 then
				var_117_9.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_117_16 = manager.ui.mainCamera.transform.position - var_117_9.position

				var_117_9.forward = Vector3.New(var_117_16.x, var_117_16.y, var_117_16.z)

				local var_117_17 = var_117_9.localEulerAngles

				var_117_17.z = 0
				var_117_17.x = 0
				var_117_9.localEulerAngles = var_117_17
			end

			local var_117_18 = arg_114_1.actors_["1071ui_story"]
			local var_117_19 = 3.8

			if var_117_19 < arg_114_1.time_ and arg_114_1.time_ <= var_117_19 + arg_117_0 and not isNil(var_117_18) and arg_114_1.var_.characterEffect1071ui_story == nil then
				arg_114_1.var_.characterEffect1071ui_story = var_117_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_20 = 0.2

			if var_117_19 <= arg_114_1.time_ and arg_114_1.time_ < var_117_19 + var_117_20 and not isNil(var_117_18) then
				local var_117_21 = (arg_114_1.time_ - var_117_19) / var_117_20

				if arg_114_1.var_.characterEffect1071ui_story and not isNil(var_117_18) then
					arg_114_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_19 + var_117_20 and arg_114_1.time_ < var_117_19 + var_117_20 + arg_117_0 and not isNil(var_117_18) and arg_114_1.var_.characterEffect1071ui_story then
				arg_114_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_117_22 = arg_114_1.actors_["1075ui_story"]
			local var_117_23 = 3.8

			if var_117_23 < arg_114_1.time_ and arg_114_1.time_ <= var_117_23 + arg_117_0 and not isNil(var_117_22) and arg_114_1.var_.characterEffect1075ui_story == nil then
				arg_114_1.var_.characterEffect1075ui_story = var_117_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_24 = 0.034

			if var_117_23 <= arg_114_1.time_ and arg_114_1.time_ < var_117_23 + var_117_24 and not isNil(var_117_22) then
				local var_117_25 = (arg_114_1.time_ - var_117_23) / var_117_24

				if arg_114_1.var_.characterEffect1075ui_story and not isNil(var_117_22) then
					local var_117_26 = Mathf.Lerp(0, 0.5, var_117_25)

					arg_114_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1075ui_story.fillRatio = var_117_26
				end
			end

			if arg_114_1.time_ >= var_117_23 + var_117_24 and arg_114_1.time_ < var_117_23 + var_117_24 + arg_117_0 and not isNil(var_117_22) and arg_114_1.var_.characterEffect1075ui_story then
				local var_117_27 = 0.5

				arg_114_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1075ui_story.fillRatio = var_117_27
			end

			local var_117_28 = 3.8

			if var_117_28 < arg_114_1.time_ and arg_114_1.time_ <= var_117_28 + arg_117_0 then
				arg_114_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action7_1")
			end

			local var_117_29 = 3.8

			if var_117_29 < arg_114_1.time_ and arg_114_1.time_ <= var_117_29 + arg_117_0 then
				arg_114_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_117_30 = 0

			if var_117_30 < arg_114_1.time_ and arg_114_1.time_ <= var_117_30 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_31 = 2

			if var_117_30 <= arg_114_1.time_ and arg_114_1.time_ < var_117_30 + var_117_31 then
				local var_117_32 = (arg_114_1.time_ - var_117_30) / var_117_31
				local var_117_33 = Color.New(0, 0, 0)

				var_117_33.a = Mathf.Lerp(0, 1, var_117_32)
				arg_114_1.mask_.color = var_117_33
			end

			if arg_114_1.time_ >= var_117_30 + var_117_31 and arg_114_1.time_ < var_117_30 + var_117_31 + arg_117_0 then
				local var_117_34 = Color.New(0, 0, 0)

				var_117_34.a = 1
				arg_114_1.mask_.color = var_117_34
			end

			local var_117_35 = 2

			if var_117_35 < arg_114_1.time_ and arg_114_1.time_ <= var_117_35 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_36 = 2

			if var_117_35 <= arg_114_1.time_ and arg_114_1.time_ < var_117_35 + var_117_36 then
				local var_117_37 = (arg_114_1.time_ - var_117_35) / var_117_36
				local var_117_38 = Color.New(0, 0, 0)

				var_117_38.a = Mathf.Lerp(1, 0, var_117_37)
				arg_114_1.mask_.color = var_117_38
			end

			if arg_114_1.time_ >= var_117_35 + var_117_36 and arg_114_1.time_ < var_117_35 + var_117_36 + arg_117_0 then
				local var_117_39 = Color.New(0, 0, 0)
				local var_117_40 = 0

				arg_114_1.mask_.enabled = false
				var_117_39.a = var_117_40
				arg_114_1.mask_.color = var_117_39
			end

			local var_117_41 = arg_114_1.actors_["1075ui_story"].transform
			local var_117_42 = 1.966

			if var_117_42 < arg_114_1.time_ and arg_114_1.time_ <= var_117_42 + arg_117_0 then
				arg_114_1.var_.moveOldPos1075ui_story = var_117_41.localPosition
			end

			local var_117_43 = 0.001

			if var_117_42 <= arg_114_1.time_ and arg_114_1.time_ < var_117_42 + var_117_43 then
				local var_117_44 = (arg_114_1.time_ - var_117_42) / var_117_43
				local var_117_45 = Vector3.New(0, 100, 0)

				var_117_41.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1075ui_story, var_117_45, var_117_44)

				local var_117_46 = manager.ui.mainCamera.transform.position - var_117_41.position

				var_117_41.forward = Vector3.New(var_117_46.x, var_117_46.y, var_117_46.z)

				local var_117_47 = var_117_41.localEulerAngles

				var_117_47.z = 0
				var_117_47.x = 0
				var_117_41.localEulerAngles = var_117_47
			end

			if arg_114_1.time_ >= var_117_42 + var_117_43 and arg_114_1.time_ < var_117_42 + var_117_43 + arg_117_0 then
				var_117_41.localPosition = Vector3.New(0, 100, 0)

				local var_117_48 = manager.ui.mainCamera.transform.position - var_117_41.position

				var_117_41.forward = Vector3.New(var_117_48.x, var_117_48.y, var_117_48.z)

				local var_117_49 = var_117_41.localEulerAngles

				var_117_49.z = 0
				var_117_49.x = 0
				var_117_41.localEulerAngles = var_117_49
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_50 = 4
			local var_117_51 = 0.625

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

				local var_117_53 = arg_114_1:FormatText(StoryNameCfg[384].name)

				arg_114_1.leftNameTxt_.text = var_117_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_54 = arg_114_1:GetWordFromCfg(120121027)
				local var_117_55 = arg_114_1:FormatText(var_117_54.content)

				arg_114_1.text_.text = var_117_55

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_56 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121027", "story_v_out_120121.awb") ~= 0 then
					local var_117_59 = manager.audio:GetVoiceLength("story_v_out_120121", "120121027", "story_v_out_120121.awb") / 1000

					if var_117_59 + var_117_50 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_59 + var_117_50
					end

					if var_117_54.prefab_name ~= "" and arg_114_1.actors_[var_117_54.prefab_name] ~= nil then
						local var_117_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_54.prefab_name].transform, "story_v_out_120121", "120121027", "story_v_out_120121.awb")

						arg_114_1:RecordAudio("120121027", var_117_60)
						arg_114_1:RecordAudio("120121027", var_117_60)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_120121", "120121027", "story_v_out_120121.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_120121", "120121027", "story_v_out_120121.awb")
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play120121028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 120121028
		arg_120_1.duration_ = 5.9

		local var_120_0 = {
			zh = 5.566,
			ja = 5.9
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play120121029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1071ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1071ui_story == nil then
				arg_120_1.var_.characterEffect1071ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.2

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1071ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1071ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1071ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1071ui_story.fillRatio = var_123_5
			end

			local var_123_6 = arg_120_1.actors_["1075ui_story"]
			local var_123_7 = 0

			if var_123_7 < arg_120_1.time_ and arg_120_1.time_ <= var_123_7 + arg_123_0 and not isNil(var_123_6) and arg_120_1.var_.characterEffect1075ui_story == nil then
				arg_120_1.var_.characterEffect1075ui_story = var_123_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_8 = 0.2

			if var_123_7 <= arg_120_1.time_ and arg_120_1.time_ < var_123_7 + var_123_8 and not isNil(var_123_6) then
				local var_123_9 = (arg_120_1.time_ - var_123_7) / var_123_8

				if arg_120_1.var_.characterEffect1075ui_story and not isNil(var_123_6) then
					arg_120_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_7 + var_123_8 and arg_120_1.time_ < var_123_7 + var_123_8 + arg_123_0 and not isNil(var_123_6) and arg_120_1.var_.characterEffect1075ui_story then
				arg_120_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			local var_123_11 = 0

			if var_123_11 < arg_120_1.time_ and arg_120_1.time_ <= var_123_11 + arg_123_0 then
				arg_120_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_123_12 = 0
			local var_123_13 = 0.7

			if var_123_12 < arg_120_1.time_ and arg_120_1.time_ <= var_123_12 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_14 = arg_120_1:FormatText(StoryNameCfg[381].name)

				arg_120_1.leftNameTxt_.text = var_123_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_15 = arg_120_1:GetWordFromCfg(120121028)
				local var_123_16 = arg_120_1:FormatText(var_123_15.content)

				arg_120_1.text_.text = var_123_16

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_17 = 28
				local var_123_18 = utf8.len(var_123_16)
				local var_123_19 = var_123_17 <= 0 and var_123_13 or var_123_13 * (var_123_18 / var_123_17)

				if var_123_19 > 0 and var_123_13 < var_123_19 then
					arg_120_1.talkMaxDuration = var_123_19

					if var_123_19 + var_123_12 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_19 + var_123_12
					end
				end

				arg_120_1.text_.text = var_123_16
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121028", "story_v_out_120121.awb") ~= 0 then
					local var_123_20 = manager.audio:GetVoiceLength("story_v_out_120121", "120121028", "story_v_out_120121.awb") / 1000

					if var_123_20 + var_123_12 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_20 + var_123_12
					end

					if var_123_15.prefab_name ~= "" and arg_120_1.actors_[var_123_15.prefab_name] ~= nil then
						local var_123_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_15.prefab_name].transform, "story_v_out_120121", "120121028", "story_v_out_120121.awb")

						arg_120_1:RecordAudio("120121028", var_123_21)
						arg_120_1:RecordAudio("120121028", var_123_21)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_120121", "120121028", "story_v_out_120121.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_120121", "120121028", "story_v_out_120121.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_22 = math.max(var_123_13, arg_120_1.talkMaxDuration)

			if var_123_12 <= arg_120_1.time_ and arg_120_1.time_ < var_123_12 + var_123_22 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_12) / var_123_22

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_12 + var_123_22 and arg_120_1.time_ < var_123_12 + var_123_22 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play120121029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 120121029
		arg_124_1.duration_ = 6.93

		local var_124_0 = {
			zh = 3.533,
			ja = 6.933
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
				arg_124_0:Play120121030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1071ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1071ui_story == nil then
				arg_124_1.var_.characterEffect1071ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect1071ui_story and not isNil(var_127_0) then
					arg_124_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1071ui_story then
				arg_124_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_127_4 = arg_124_1.actors_["1075ui_story"]
			local var_127_5 = 0

			if var_127_5 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 and not isNil(var_127_4) and arg_124_1.var_.characterEffect1075ui_story == nil then
				arg_124_1.var_.characterEffect1075ui_story = var_127_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_6 = 0.2

			if var_127_5 <= arg_124_1.time_ and arg_124_1.time_ < var_127_5 + var_127_6 and not isNil(var_127_4) then
				local var_127_7 = (arg_124_1.time_ - var_127_5) / var_127_6

				if arg_124_1.var_.characterEffect1075ui_story and not isNil(var_127_4) then
					local var_127_8 = Mathf.Lerp(0, 0.5, var_127_7)

					arg_124_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1075ui_story.fillRatio = var_127_8
				end
			end

			if arg_124_1.time_ >= var_127_5 + var_127_6 and arg_124_1.time_ < var_127_5 + var_127_6 + arg_127_0 and not isNil(var_127_4) and arg_124_1.var_.characterEffect1075ui_story then
				local var_127_9 = 0.5

				arg_124_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1075ui_story.fillRatio = var_127_9
			end

			local var_127_10 = 0

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 then
				arg_124_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action7_2")
			end

			local var_127_11 = 0
			local var_127_12 = 0.4

			if var_127_11 < arg_124_1.time_ and arg_124_1.time_ <= var_127_11 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_13 = arg_124_1:FormatText(StoryNameCfg[384].name)

				arg_124_1.leftNameTxt_.text = var_127_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_14 = arg_124_1:GetWordFromCfg(120121029)
				local var_127_15 = arg_124_1:FormatText(var_127_14.content)

				arg_124_1.text_.text = var_127_15

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_16 = 16
				local var_127_17 = utf8.len(var_127_15)
				local var_127_18 = var_127_16 <= 0 and var_127_12 or var_127_12 * (var_127_17 / var_127_16)

				if var_127_18 > 0 and var_127_12 < var_127_18 then
					arg_124_1.talkMaxDuration = var_127_18

					if var_127_18 + var_127_11 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_18 + var_127_11
					end
				end

				arg_124_1.text_.text = var_127_15
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121029", "story_v_out_120121.awb") ~= 0 then
					local var_127_19 = manager.audio:GetVoiceLength("story_v_out_120121", "120121029", "story_v_out_120121.awb") / 1000

					if var_127_19 + var_127_11 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_19 + var_127_11
					end

					if var_127_14.prefab_name ~= "" and arg_124_1.actors_[var_127_14.prefab_name] ~= nil then
						local var_127_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_14.prefab_name].transform, "story_v_out_120121", "120121029", "story_v_out_120121.awb")

						arg_124_1:RecordAudio("120121029", var_127_20)
						arg_124_1:RecordAudio("120121029", var_127_20)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_120121", "120121029", "story_v_out_120121.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_120121", "120121029", "story_v_out_120121.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_21 = math.max(var_127_12, arg_124_1.talkMaxDuration)

			if var_127_11 <= arg_124_1.time_ and arg_124_1.time_ < var_127_11 + var_127_21 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_11) / var_127_21

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_11 + var_127_21 and arg_124_1.time_ < var_127_11 + var_127_21 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play120121030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 120121030
		arg_128_1.duration_ = 4.53

		local var_128_0 = {
			zh = 2.133,
			ja = 4.533
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play120121031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1071ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos1071ui_story = var_131_0.localPosition
			end

			local var_131_2 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2
				local var_131_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1071ui_story, var_131_4, var_131_3)

				local var_131_5 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_5.x, var_131_5.y, var_131_5.z)

				local var_131_6 = var_131_0.localEulerAngles

				var_131_6.z = 0
				var_131_6.x = 0
				var_131_0.localEulerAngles = var_131_6
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_131_7 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_7.x, var_131_7.y, var_131_7.z)

				local var_131_8 = var_131_0.localEulerAngles

				var_131_8.z = 0
				var_131_8.x = 0
				var_131_0.localEulerAngles = var_131_8
			end

			local var_131_9 = arg_128_1.actors_["1075ui_story"].transform
			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1.var_.moveOldPos1075ui_story = var_131_9.localPosition
			end

			local var_131_11 = 0.001

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_11 then
				local var_131_12 = (arg_128_1.time_ - var_131_10) / var_131_11
				local var_131_13 = Vector3.New(0.7, -1.055, -6.16)

				var_131_9.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1075ui_story, var_131_13, var_131_12)

				local var_131_14 = manager.ui.mainCamera.transform.position - var_131_9.position

				var_131_9.forward = Vector3.New(var_131_14.x, var_131_14.y, var_131_14.z)

				local var_131_15 = var_131_9.localEulerAngles

				var_131_15.z = 0
				var_131_15.x = 0
				var_131_9.localEulerAngles = var_131_15
			end

			if arg_128_1.time_ >= var_131_10 + var_131_11 and arg_128_1.time_ < var_131_10 + var_131_11 + arg_131_0 then
				var_131_9.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_131_16 = manager.ui.mainCamera.transform.position - var_131_9.position

				var_131_9.forward = Vector3.New(var_131_16.x, var_131_16.y, var_131_16.z)

				local var_131_17 = var_131_9.localEulerAngles

				var_131_17.z = 0
				var_131_17.x = 0
				var_131_9.localEulerAngles = var_131_17
			end

			local var_131_18 = arg_128_1.actors_["1071ui_story"]
			local var_131_19 = 0

			if var_131_19 < arg_128_1.time_ and arg_128_1.time_ <= var_131_19 + arg_131_0 and not isNil(var_131_18) and arg_128_1.var_.characterEffect1071ui_story == nil then
				arg_128_1.var_.characterEffect1071ui_story = var_131_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_20 = 0.2

			if var_131_19 <= arg_128_1.time_ and arg_128_1.time_ < var_131_19 + var_131_20 and not isNil(var_131_18) then
				local var_131_21 = (arg_128_1.time_ - var_131_19) / var_131_20

				if arg_128_1.var_.characterEffect1071ui_story and not isNil(var_131_18) then
					local var_131_22 = Mathf.Lerp(0, 0.5, var_131_21)

					arg_128_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1071ui_story.fillRatio = var_131_22
				end
			end

			if arg_128_1.time_ >= var_131_19 + var_131_20 and arg_128_1.time_ < var_131_19 + var_131_20 + arg_131_0 and not isNil(var_131_18) and arg_128_1.var_.characterEffect1071ui_story then
				local var_131_23 = 0.5

				arg_128_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1071ui_story.fillRatio = var_131_23
			end

			local var_131_24 = arg_128_1.actors_["1075ui_story"]
			local var_131_25 = 0

			if var_131_25 < arg_128_1.time_ and arg_128_1.time_ <= var_131_25 + arg_131_0 and not isNil(var_131_24) and arg_128_1.var_.characterEffect1075ui_story == nil then
				arg_128_1.var_.characterEffect1075ui_story = var_131_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_26 = 0.2

			if var_131_25 <= arg_128_1.time_ and arg_128_1.time_ < var_131_25 + var_131_26 and not isNil(var_131_24) then
				local var_131_27 = (arg_128_1.time_ - var_131_25) / var_131_26

				if arg_128_1.var_.characterEffect1075ui_story and not isNil(var_131_24) then
					arg_128_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_25 + var_131_26 and arg_128_1.time_ < var_131_25 + var_131_26 + arg_131_0 and not isNil(var_131_24) and arg_128_1.var_.characterEffect1075ui_story then
				arg_128_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_131_28 = 0

			if var_131_28 < arg_128_1.time_ and arg_128_1.time_ <= var_131_28 + arg_131_0 then
				arg_128_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_2")
			end

			local var_131_29 = 0

			if var_131_29 < arg_128_1.time_ and arg_128_1.time_ <= var_131_29 + arg_131_0 then
				arg_128_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_131_30 = 0
			local var_131_31 = 0.25

			if var_131_30 < arg_128_1.time_ and arg_128_1.time_ <= var_131_30 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_32 = arg_128_1:FormatText(StoryNameCfg[381].name)

				arg_128_1.leftNameTxt_.text = var_131_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_33 = arg_128_1:GetWordFromCfg(120121030)
				local var_131_34 = arg_128_1:FormatText(var_131_33.content)

				arg_128_1.text_.text = var_131_34

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_35 = 10
				local var_131_36 = utf8.len(var_131_34)
				local var_131_37 = var_131_35 <= 0 and var_131_31 or var_131_31 * (var_131_36 / var_131_35)

				if var_131_37 > 0 and var_131_31 < var_131_37 then
					arg_128_1.talkMaxDuration = var_131_37

					if var_131_37 + var_131_30 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_37 + var_131_30
					end
				end

				arg_128_1.text_.text = var_131_34
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121030", "story_v_out_120121.awb") ~= 0 then
					local var_131_38 = manager.audio:GetVoiceLength("story_v_out_120121", "120121030", "story_v_out_120121.awb") / 1000

					if var_131_38 + var_131_30 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_38 + var_131_30
					end

					if var_131_33.prefab_name ~= "" and arg_128_1.actors_[var_131_33.prefab_name] ~= nil then
						local var_131_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_33.prefab_name].transform, "story_v_out_120121", "120121030", "story_v_out_120121.awb")

						arg_128_1:RecordAudio("120121030", var_131_39)
						arg_128_1:RecordAudio("120121030", var_131_39)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_120121", "120121030", "story_v_out_120121.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_120121", "120121030", "story_v_out_120121.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_40 = math.max(var_131_31, arg_128_1.talkMaxDuration)

			if var_131_30 <= arg_128_1.time_ and arg_128_1.time_ < var_131_30 + var_131_40 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_30) / var_131_40

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_30 + var_131_40 and arg_128_1.time_ < var_131_30 + var_131_40 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play120121031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 120121031
		arg_132_1.duration_ = 3.3

		local var_132_0 = {
			zh = 3.3,
			ja = 3.2
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
				arg_132_0:Play120121032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1071ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos1071ui_story = var_135_0.localPosition
			end

			local var_135_2 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2
				local var_135_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1071ui_story, var_135_4, var_135_3)

				local var_135_5 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_5.x, var_135_5.y, var_135_5.z)

				local var_135_6 = var_135_0.localEulerAngles

				var_135_6.z = 0
				var_135_6.x = 0
				var_135_0.localEulerAngles = var_135_6
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_135_7 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_7.x, var_135_7.y, var_135_7.z)

				local var_135_8 = var_135_0.localEulerAngles

				var_135_8.z = 0
				var_135_8.x = 0
				var_135_0.localEulerAngles = var_135_8
			end

			local var_135_9 = arg_132_1.actors_["1075ui_story"].transform
			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1.var_.moveOldPos1075ui_story = var_135_9.localPosition
			end

			local var_135_11 = 0.001

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_11 then
				local var_135_12 = (arg_132_1.time_ - var_135_10) / var_135_11
				local var_135_13 = Vector3.New(0.7, -1.055, -6.16)

				var_135_9.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1075ui_story, var_135_13, var_135_12)

				local var_135_14 = manager.ui.mainCamera.transform.position - var_135_9.position

				var_135_9.forward = Vector3.New(var_135_14.x, var_135_14.y, var_135_14.z)

				local var_135_15 = var_135_9.localEulerAngles

				var_135_15.z = 0
				var_135_15.x = 0
				var_135_9.localEulerAngles = var_135_15
			end

			if arg_132_1.time_ >= var_135_10 + var_135_11 and arg_132_1.time_ < var_135_10 + var_135_11 + arg_135_0 then
				var_135_9.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_135_16 = manager.ui.mainCamera.transform.position - var_135_9.position

				var_135_9.forward = Vector3.New(var_135_16.x, var_135_16.y, var_135_16.z)

				local var_135_17 = var_135_9.localEulerAngles

				var_135_17.z = 0
				var_135_17.x = 0
				var_135_9.localEulerAngles = var_135_17
			end

			local var_135_18 = arg_132_1.actors_["1071ui_story"]
			local var_135_19 = 0

			if var_135_19 < arg_132_1.time_ and arg_132_1.time_ <= var_135_19 + arg_135_0 and not isNil(var_135_18) and arg_132_1.var_.characterEffect1071ui_story == nil then
				arg_132_1.var_.characterEffect1071ui_story = var_135_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_20 = 0.2

			if var_135_19 <= arg_132_1.time_ and arg_132_1.time_ < var_135_19 + var_135_20 and not isNil(var_135_18) then
				local var_135_21 = (arg_132_1.time_ - var_135_19) / var_135_20

				if arg_132_1.var_.characterEffect1071ui_story and not isNil(var_135_18) then
					arg_132_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_19 + var_135_20 and arg_132_1.time_ < var_135_19 + var_135_20 + arg_135_0 and not isNil(var_135_18) and arg_132_1.var_.characterEffect1071ui_story then
				arg_132_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_135_22 = arg_132_1.actors_["1075ui_story"]
			local var_135_23 = 0

			if var_135_23 < arg_132_1.time_ and arg_132_1.time_ <= var_135_23 + arg_135_0 and not isNil(var_135_22) and arg_132_1.var_.characterEffect1075ui_story == nil then
				arg_132_1.var_.characterEffect1075ui_story = var_135_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_24 = 0.2

			if var_135_23 <= arg_132_1.time_ and arg_132_1.time_ < var_135_23 + var_135_24 and not isNil(var_135_22) then
				local var_135_25 = (arg_132_1.time_ - var_135_23) / var_135_24

				if arg_132_1.var_.characterEffect1075ui_story and not isNil(var_135_22) then
					local var_135_26 = Mathf.Lerp(0, 0.5, var_135_25)

					arg_132_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1075ui_story.fillRatio = var_135_26
				end
			end

			if arg_132_1.time_ >= var_135_23 + var_135_24 and arg_132_1.time_ < var_135_23 + var_135_24 + arg_135_0 and not isNil(var_135_22) and arg_132_1.var_.characterEffect1075ui_story then
				local var_135_27 = 0.5

				arg_132_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1075ui_story.fillRatio = var_135_27
			end

			local var_135_28 = 0

			if var_135_28 < arg_132_1.time_ and arg_132_1.time_ <= var_135_28 + arg_135_0 then
				arg_132_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_135_29 = 0
			local var_135_30 = 0.35

			if var_135_29 < arg_132_1.time_ and arg_132_1.time_ <= var_135_29 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_31 = arg_132_1:FormatText(StoryNameCfg[384].name)

				arg_132_1.leftNameTxt_.text = var_135_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_32 = arg_132_1:GetWordFromCfg(120121031)
				local var_135_33 = arg_132_1:FormatText(var_135_32.content)

				arg_132_1.text_.text = var_135_33

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_34 = 14
				local var_135_35 = utf8.len(var_135_33)
				local var_135_36 = var_135_34 <= 0 and var_135_30 or var_135_30 * (var_135_35 / var_135_34)

				if var_135_36 > 0 and var_135_30 < var_135_36 then
					arg_132_1.talkMaxDuration = var_135_36

					if var_135_36 + var_135_29 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_36 + var_135_29
					end
				end

				arg_132_1.text_.text = var_135_33
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121031", "story_v_out_120121.awb") ~= 0 then
					local var_135_37 = manager.audio:GetVoiceLength("story_v_out_120121", "120121031", "story_v_out_120121.awb") / 1000

					if var_135_37 + var_135_29 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_37 + var_135_29
					end

					if var_135_32.prefab_name ~= "" and arg_132_1.actors_[var_135_32.prefab_name] ~= nil then
						local var_135_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_32.prefab_name].transform, "story_v_out_120121", "120121031", "story_v_out_120121.awb")

						arg_132_1:RecordAudio("120121031", var_135_38)
						arg_132_1:RecordAudio("120121031", var_135_38)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_120121", "120121031", "story_v_out_120121.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_120121", "120121031", "story_v_out_120121.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_39 = math.max(var_135_30, arg_132_1.talkMaxDuration)

			if var_135_29 <= arg_132_1.time_ and arg_132_1.time_ < var_135_29 + var_135_39 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_29) / var_135_39

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_29 + var_135_39 and arg_132_1.time_ < var_135_29 + var_135_39 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play120121032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 120121032
		arg_136_1.duration_ = 8.37

		local var_136_0 = {
			zh = 5.7,
			ja = 8.366
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
				arg_136_0:Play120121033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.675

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[384].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:GetWordFromCfg(120121032)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 27
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121032", "story_v_out_120121.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_120121", "120121032", "story_v_out_120121.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_120121", "120121032", "story_v_out_120121.awb")

						arg_136_1:RecordAudio("120121032", var_139_9)
						arg_136_1:RecordAudio("120121032", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_120121", "120121032", "story_v_out_120121.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_120121", "120121032", "story_v_out_120121.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_10 and arg_136_1.time_ < var_139_0 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play120121033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 120121033
		arg_140_1.duration_ = 6.13

		local var_140_0 = {
			zh = 4.933,
			ja = 6.133
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
				arg_140_0:Play120121034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1071ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos1071ui_story = var_143_0.localPosition
			end

			local var_143_2 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2
				local var_143_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1071ui_story, var_143_4, var_143_3)

				local var_143_5 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_5.x, var_143_5.y, var_143_5.z)

				local var_143_6 = var_143_0.localEulerAngles

				var_143_6.z = 0
				var_143_6.x = 0
				var_143_0.localEulerAngles = var_143_6
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_143_7 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_7.x, var_143_7.y, var_143_7.z)

				local var_143_8 = var_143_0.localEulerAngles

				var_143_8.z = 0
				var_143_8.x = 0
				var_143_0.localEulerAngles = var_143_8
			end

			local var_143_9 = arg_140_1.actors_["1075ui_story"].transform
			local var_143_10 = 0

			if var_143_10 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 then
				arg_140_1.var_.moveOldPos1075ui_story = var_143_9.localPosition
			end

			local var_143_11 = 0.001

			if var_143_10 <= arg_140_1.time_ and arg_140_1.time_ < var_143_10 + var_143_11 then
				local var_143_12 = (arg_140_1.time_ - var_143_10) / var_143_11
				local var_143_13 = Vector3.New(0.7, -1.055, -6.16)

				var_143_9.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1075ui_story, var_143_13, var_143_12)

				local var_143_14 = manager.ui.mainCamera.transform.position - var_143_9.position

				var_143_9.forward = Vector3.New(var_143_14.x, var_143_14.y, var_143_14.z)

				local var_143_15 = var_143_9.localEulerAngles

				var_143_15.z = 0
				var_143_15.x = 0
				var_143_9.localEulerAngles = var_143_15
			end

			if arg_140_1.time_ >= var_143_10 + var_143_11 and arg_140_1.time_ < var_143_10 + var_143_11 + arg_143_0 then
				var_143_9.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_143_16 = manager.ui.mainCamera.transform.position - var_143_9.position

				var_143_9.forward = Vector3.New(var_143_16.x, var_143_16.y, var_143_16.z)

				local var_143_17 = var_143_9.localEulerAngles

				var_143_17.z = 0
				var_143_17.x = 0
				var_143_9.localEulerAngles = var_143_17
			end

			local var_143_18 = arg_140_1.actors_["1071ui_story"]
			local var_143_19 = 0

			if var_143_19 < arg_140_1.time_ and arg_140_1.time_ <= var_143_19 + arg_143_0 and not isNil(var_143_18) and arg_140_1.var_.characterEffect1071ui_story == nil then
				arg_140_1.var_.characterEffect1071ui_story = var_143_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_20 = 0.2

			if var_143_19 <= arg_140_1.time_ and arg_140_1.time_ < var_143_19 + var_143_20 and not isNil(var_143_18) then
				local var_143_21 = (arg_140_1.time_ - var_143_19) / var_143_20

				if arg_140_1.var_.characterEffect1071ui_story and not isNil(var_143_18) then
					local var_143_22 = Mathf.Lerp(0, 0.5, var_143_21)

					arg_140_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1071ui_story.fillRatio = var_143_22
				end
			end

			if arg_140_1.time_ >= var_143_19 + var_143_20 and arg_140_1.time_ < var_143_19 + var_143_20 + arg_143_0 and not isNil(var_143_18) and arg_140_1.var_.characterEffect1071ui_story then
				local var_143_23 = 0.5

				arg_140_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1071ui_story.fillRatio = var_143_23
			end

			local var_143_24 = arg_140_1.actors_["1075ui_story"]
			local var_143_25 = 0

			if var_143_25 < arg_140_1.time_ and arg_140_1.time_ <= var_143_25 + arg_143_0 and not isNil(var_143_24) and arg_140_1.var_.characterEffect1075ui_story == nil then
				arg_140_1.var_.characterEffect1075ui_story = var_143_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_26 = 0.2

			if var_143_25 <= arg_140_1.time_ and arg_140_1.time_ < var_143_25 + var_143_26 and not isNil(var_143_24) then
				local var_143_27 = (arg_140_1.time_ - var_143_25) / var_143_26

				if arg_140_1.var_.characterEffect1075ui_story and not isNil(var_143_24) then
					arg_140_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_25 + var_143_26 and arg_140_1.time_ < var_143_25 + var_143_26 + arg_143_0 and not isNil(var_143_24) and arg_140_1.var_.characterEffect1075ui_story then
				arg_140_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_143_28 = 0

			if var_143_28 < arg_140_1.time_ and arg_140_1.time_ <= var_143_28 + arg_143_0 then
				arg_140_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_143_29 = 0
			local var_143_30 = 0.625

			if var_143_29 < arg_140_1.time_ and arg_140_1.time_ <= var_143_29 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_31 = arg_140_1:FormatText(StoryNameCfg[381].name)

				arg_140_1.leftNameTxt_.text = var_143_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_32 = arg_140_1:GetWordFromCfg(120121033)
				local var_143_33 = arg_140_1:FormatText(var_143_32.content)

				arg_140_1.text_.text = var_143_33

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_34 = 25
				local var_143_35 = utf8.len(var_143_33)
				local var_143_36 = var_143_34 <= 0 and var_143_30 or var_143_30 * (var_143_35 / var_143_34)

				if var_143_36 > 0 and var_143_30 < var_143_36 then
					arg_140_1.talkMaxDuration = var_143_36

					if var_143_36 + var_143_29 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_36 + var_143_29
					end
				end

				arg_140_1.text_.text = var_143_33
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121033", "story_v_out_120121.awb") ~= 0 then
					local var_143_37 = manager.audio:GetVoiceLength("story_v_out_120121", "120121033", "story_v_out_120121.awb") / 1000

					if var_143_37 + var_143_29 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_37 + var_143_29
					end

					if var_143_32.prefab_name ~= "" and arg_140_1.actors_[var_143_32.prefab_name] ~= nil then
						local var_143_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_32.prefab_name].transform, "story_v_out_120121", "120121033", "story_v_out_120121.awb")

						arg_140_1:RecordAudio("120121033", var_143_38)
						arg_140_1:RecordAudio("120121033", var_143_38)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_120121", "120121033", "story_v_out_120121.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_120121", "120121033", "story_v_out_120121.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_39 = math.max(var_143_30, arg_140_1.talkMaxDuration)

			if var_143_29 <= arg_140_1.time_ and arg_140_1.time_ < var_143_29 + var_143_39 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_29) / var_143_39

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_29 + var_143_39 and arg_140_1.time_ < var_143_29 + var_143_39 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play120121034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 120121034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play120121035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1071ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos1071ui_story = var_147_0.localPosition
			end

			local var_147_2 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2
				local var_147_4 = Vector3.New(0, 100, 0)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1071ui_story, var_147_4, var_147_3)

				local var_147_5 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_5.x, var_147_5.y, var_147_5.z)

				local var_147_6 = var_147_0.localEulerAngles

				var_147_6.z = 0
				var_147_6.x = 0
				var_147_0.localEulerAngles = var_147_6
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, 100, 0)

				local var_147_7 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_7.x, var_147_7.y, var_147_7.z)

				local var_147_8 = var_147_0.localEulerAngles

				var_147_8.z = 0
				var_147_8.x = 0
				var_147_0.localEulerAngles = var_147_8
			end

			local var_147_9 = arg_144_1.actors_["1075ui_story"].transform
			local var_147_10 = 0

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 then
				arg_144_1.var_.moveOldPos1075ui_story = var_147_9.localPosition
			end

			local var_147_11 = 0.001

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_11 then
				local var_147_12 = (arg_144_1.time_ - var_147_10) / var_147_11
				local var_147_13 = Vector3.New(0, 100, 0)

				var_147_9.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1075ui_story, var_147_13, var_147_12)

				local var_147_14 = manager.ui.mainCamera.transform.position - var_147_9.position

				var_147_9.forward = Vector3.New(var_147_14.x, var_147_14.y, var_147_14.z)

				local var_147_15 = var_147_9.localEulerAngles

				var_147_15.z = 0
				var_147_15.x = 0
				var_147_9.localEulerAngles = var_147_15
			end

			if arg_144_1.time_ >= var_147_10 + var_147_11 and arg_144_1.time_ < var_147_10 + var_147_11 + arg_147_0 then
				var_147_9.localPosition = Vector3.New(0, 100, 0)

				local var_147_16 = manager.ui.mainCamera.transform.position - var_147_9.position

				var_147_9.forward = Vector3.New(var_147_16.x, var_147_16.y, var_147_16.z)

				local var_147_17 = var_147_9.localEulerAngles

				var_147_17.z = 0
				var_147_17.x = 0
				var_147_9.localEulerAngles = var_147_17
			end

			local var_147_18 = 0
			local var_147_19 = 1.25

			if var_147_18 < arg_144_1.time_ and arg_144_1.time_ <= var_147_18 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_20 = arg_144_1:GetWordFromCfg(120121034)
				local var_147_21 = arg_144_1:FormatText(var_147_20.content)

				arg_144_1.text_.text = var_147_21

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_22 = 50
				local var_147_23 = utf8.len(var_147_21)
				local var_147_24 = var_147_22 <= 0 and var_147_19 or var_147_19 * (var_147_23 / var_147_22)

				if var_147_24 > 0 and var_147_19 < var_147_24 then
					arg_144_1.talkMaxDuration = var_147_24

					if var_147_24 + var_147_18 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_24 + var_147_18
					end
				end

				arg_144_1.text_.text = var_147_21
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_25 = math.max(var_147_19, arg_144_1.talkMaxDuration)

			if var_147_18 <= arg_144_1.time_ and arg_144_1.time_ < var_147_18 + var_147_25 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_18) / var_147_25

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_18 + var_147_25 and arg_144_1.time_ < var_147_18 + var_147_25 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play120121035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 120121035
		arg_148_1.duration_ = 4.73

		local var_148_0 = {
			zh = 2.066,
			ja = 4.733
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
				arg_148_0:Play120121036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1071ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1071ui_story == nil then
				arg_148_1.var_.characterEffect1071ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect1071ui_story and not isNil(var_151_0) then
					arg_148_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1071ui_story then
				arg_148_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_151_4 = arg_148_1.actors_["1075ui_story"]
			local var_151_5 = 0

			if var_151_5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect1075ui_story == nil then
				arg_148_1.var_.characterEffect1075ui_story = var_151_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_6 = 0.2

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_6 and not isNil(var_151_4) then
				local var_151_7 = (arg_148_1.time_ - var_151_5) / var_151_6

				if arg_148_1.var_.characterEffect1075ui_story and not isNil(var_151_4) then
					local var_151_8 = Mathf.Lerp(0, 0.5, var_151_7)

					arg_148_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1075ui_story.fillRatio = var_151_8
				end
			end

			if arg_148_1.time_ >= var_151_5 + var_151_6 and arg_148_1.time_ < var_151_5 + var_151_6 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect1075ui_story then
				local var_151_9 = 0.5

				arg_148_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1075ui_story.fillRatio = var_151_9
			end

			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 then
				arg_148_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_151_11 = arg_148_1.actors_["1071ui_story"].transform
			local var_151_12 = 0

			if var_151_12 < arg_148_1.time_ and arg_148_1.time_ <= var_151_12 + arg_151_0 then
				arg_148_1.var_.moveOldPos1071ui_story = var_151_11.localPosition
			end

			local var_151_13 = 0.001

			if var_151_12 <= arg_148_1.time_ and arg_148_1.time_ < var_151_12 + var_151_13 then
				local var_151_14 = (arg_148_1.time_ - var_151_12) / var_151_13
				local var_151_15 = Vector3.New(-0.7, -1.05, -6.2)

				var_151_11.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1071ui_story, var_151_15, var_151_14)

				local var_151_16 = manager.ui.mainCamera.transform.position - var_151_11.position

				var_151_11.forward = Vector3.New(var_151_16.x, var_151_16.y, var_151_16.z)

				local var_151_17 = var_151_11.localEulerAngles

				var_151_17.z = 0
				var_151_17.x = 0
				var_151_11.localEulerAngles = var_151_17
			end

			if arg_148_1.time_ >= var_151_12 + var_151_13 and arg_148_1.time_ < var_151_12 + var_151_13 + arg_151_0 then
				var_151_11.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_151_18 = manager.ui.mainCamera.transform.position - var_151_11.position

				var_151_11.forward = Vector3.New(var_151_18.x, var_151_18.y, var_151_18.z)

				local var_151_19 = var_151_11.localEulerAngles

				var_151_19.z = 0
				var_151_19.x = 0
				var_151_11.localEulerAngles = var_151_19
			end

			local var_151_20 = arg_148_1.actors_["1075ui_story"].transform
			local var_151_21 = 0

			if var_151_21 < arg_148_1.time_ and arg_148_1.time_ <= var_151_21 + arg_151_0 then
				arg_148_1.var_.moveOldPos1075ui_story = var_151_20.localPosition
			end

			local var_151_22 = 0.001

			if var_151_21 <= arg_148_1.time_ and arg_148_1.time_ < var_151_21 + var_151_22 then
				local var_151_23 = (arg_148_1.time_ - var_151_21) / var_151_22
				local var_151_24 = Vector3.New(0.7, -1.055, -6.16)

				var_151_20.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1075ui_story, var_151_24, var_151_23)

				local var_151_25 = manager.ui.mainCamera.transform.position - var_151_20.position

				var_151_20.forward = Vector3.New(var_151_25.x, var_151_25.y, var_151_25.z)

				local var_151_26 = var_151_20.localEulerAngles

				var_151_26.z = 0
				var_151_26.x = 0
				var_151_20.localEulerAngles = var_151_26
			end

			if arg_148_1.time_ >= var_151_21 + var_151_22 and arg_148_1.time_ < var_151_21 + var_151_22 + arg_151_0 then
				var_151_20.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_151_27 = manager.ui.mainCamera.transform.position - var_151_20.position

				var_151_20.forward = Vector3.New(var_151_27.x, var_151_27.y, var_151_27.z)

				local var_151_28 = var_151_20.localEulerAngles

				var_151_28.z = 0
				var_151_28.x = 0
				var_151_20.localEulerAngles = var_151_28
			end

			local var_151_29 = 0
			local var_151_30 = 0.225

			if var_151_29 < arg_148_1.time_ and arg_148_1.time_ <= var_151_29 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_31 = arg_148_1:FormatText(StoryNameCfg[384].name)

				arg_148_1.leftNameTxt_.text = var_151_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_32 = arg_148_1:GetWordFromCfg(120121035)
				local var_151_33 = arg_148_1:FormatText(var_151_32.content)

				arg_148_1.text_.text = var_151_33

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_34 = 9
				local var_151_35 = utf8.len(var_151_33)
				local var_151_36 = var_151_34 <= 0 and var_151_30 or var_151_30 * (var_151_35 / var_151_34)

				if var_151_36 > 0 and var_151_30 < var_151_36 then
					arg_148_1.talkMaxDuration = var_151_36

					if var_151_36 + var_151_29 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_36 + var_151_29
					end
				end

				arg_148_1.text_.text = var_151_33
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121035", "story_v_out_120121.awb") ~= 0 then
					local var_151_37 = manager.audio:GetVoiceLength("story_v_out_120121", "120121035", "story_v_out_120121.awb") / 1000

					if var_151_37 + var_151_29 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_37 + var_151_29
					end

					if var_151_32.prefab_name ~= "" and arg_148_1.actors_[var_151_32.prefab_name] ~= nil then
						local var_151_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_32.prefab_name].transform, "story_v_out_120121", "120121035", "story_v_out_120121.awb")

						arg_148_1:RecordAudio("120121035", var_151_38)
						arg_148_1:RecordAudio("120121035", var_151_38)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_120121", "120121035", "story_v_out_120121.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_120121", "120121035", "story_v_out_120121.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_39 = math.max(var_151_30, arg_148_1.talkMaxDuration)

			if var_151_29 <= arg_148_1.time_ and arg_148_1.time_ < var_151_29 + var_151_39 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_29) / var_151_39

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_29 + var_151_39 and arg_148_1.time_ < var_151_29 + var_151_39 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play120121036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 120121036
		arg_152_1.duration_ = 7.4

		local var_152_0 = {
			zh = 7.4,
			ja = 6.8
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
				arg_152_0:Play120121037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1071ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1071ui_story == nil then
				arg_152_1.var_.characterEffect1071ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.2

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect1071ui_story and not isNil(var_155_0) then
					local var_155_4 = Mathf.Lerp(0, 0.5, var_155_3)

					arg_152_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1071ui_story.fillRatio = var_155_4
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1071ui_story then
				local var_155_5 = 0.5

				arg_152_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1071ui_story.fillRatio = var_155_5
			end

			local var_155_6 = arg_152_1.actors_["1075ui_story"]
			local var_155_7 = 0

			if var_155_7 < arg_152_1.time_ and arg_152_1.time_ <= var_155_7 + arg_155_0 and not isNil(var_155_6) and arg_152_1.var_.characterEffect1075ui_story == nil then
				arg_152_1.var_.characterEffect1075ui_story = var_155_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_8 = 0.2

			if var_155_7 <= arg_152_1.time_ and arg_152_1.time_ < var_155_7 + var_155_8 and not isNil(var_155_6) then
				local var_155_9 = (arg_152_1.time_ - var_155_7) / var_155_8

				if arg_152_1.var_.characterEffect1075ui_story and not isNil(var_155_6) then
					arg_152_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_7 + var_155_8 and arg_152_1.time_ < var_155_7 + var_155_8 + arg_155_0 and not isNil(var_155_6) and arg_152_1.var_.characterEffect1075ui_story then
				arg_152_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 then
				arg_152_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_155_11 = 0

			if var_155_11 < arg_152_1.time_ and arg_152_1.time_ <= var_155_11 + arg_155_0 then
				arg_152_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_155_12 = 0
			local var_155_13 = 1

			if var_155_12 < arg_152_1.time_ and arg_152_1.time_ <= var_155_12 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_14 = arg_152_1:FormatText(StoryNameCfg[381].name)

				arg_152_1.leftNameTxt_.text = var_155_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_15 = arg_152_1:GetWordFromCfg(120121036)
				local var_155_16 = arg_152_1:FormatText(var_155_15.content)

				arg_152_1.text_.text = var_155_16

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_17 = 42
				local var_155_18 = utf8.len(var_155_16)
				local var_155_19 = var_155_17 <= 0 and var_155_13 or var_155_13 * (var_155_18 / var_155_17)

				if var_155_19 > 0 and var_155_13 < var_155_19 then
					arg_152_1.talkMaxDuration = var_155_19

					if var_155_19 + var_155_12 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_19 + var_155_12
					end
				end

				arg_152_1.text_.text = var_155_16
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121036", "story_v_out_120121.awb") ~= 0 then
					local var_155_20 = manager.audio:GetVoiceLength("story_v_out_120121", "120121036", "story_v_out_120121.awb") / 1000

					if var_155_20 + var_155_12 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_20 + var_155_12
					end

					if var_155_15.prefab_name ~= "" and arg_152_1.actors_[var_155_15.prefab_name] ~= nil then
						local var_155_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_15.prefab_name].transform, "story_v_out_120121", "120121036", "story_v_out_120121.awb")

						arg_152_1:RecordAudio("120121036", var_155_21)
						arg_152_1:RecordAudio("120121036", var_155_21)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_120121", "120121036", "story_v_out_120121.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_120121", "120121036", "story_v_out_120121.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_22 = math.max(var_155_13, arg_152_1.talkMaxDuration)

			if var_155_12 <= arg_152_1.time_ and arg_152_1.time_ < var_155_12 + var_155_22 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_12) / var_155_22

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_12 + var_155_22 and arg_152_1.time_ < var_155_12 + var_155_22 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play120121037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 120121037
		arg_156_1.duration_ = 5.77

		local var_156_0 = {
			zh = 4.066,
			ja = 5.766
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
				arg_156_0:Play120121038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1071ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1071ui_story == nil then
				arg_156_1.var_.characterEffect1071ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.2

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1071ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1071ui_story then
				arg_156_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_159_4 = arg_156_1.actors_["1075ui_story"]
			local var_159_5 = 0

			if var_159_5 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect1075ui_story == nil then
				arg_156_1.var_.characterEffect1075ui_story = var_159_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_6 = 0.2

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_6 and not isNil(var_159_4) then
				local var_159_7 = (arg_156_1.time_ - var_159_5) / var_159_6

				if arg_156_1.var_.characterEffect1075ui_story and not isNil(var_159_4) then
					local var_159_8 = Mathf.Lerp(0, 0.5, var_159_7)

					arg_156_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1075ui_story.fillRatio = var_159_8
				end
			end

			if arg_156_1.time_ >= var_159_5 + var_159_6 and arg_156_1.time_ < var_159_5 + var_159_6 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect1075ui_story then
				local var_159_9 = 0.5

				arg_156_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1075ui_story.fillRatio = var_159_9
			end

			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 then
				arg_156_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_159_11 = 0

			if var_159_11 < arg_156_1.time_ and arg_156_1.time_ <= var_159_11 + arg_159_0 then
				arg_156_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_159_12 = 0
			local var_159_13 = 0.45

			if var_159_12 < arg_156_1.time_ and arg_156_1.time_ <= var_159_12 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_14 = arg_156_1:FormatText(StoryNameCfg[384].name)

				arg_156_1.leftNameTxt_.text = var_159_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_15 = arg_156_1:GetWordFromCfg(120121037)
				local var_159_16 = arg_156_1:FormatText(var_159_15.content)

				arg_156_1.text_.text = var_159_16

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_17 = 18
				local var_159_18 = utf8.len(var_159_16)
				local var_159_19 = var_159_17 <= 0 and var_159_13 or var_159_13 * (var_159_18 / var_159_17)

				if var_159_19 > 0 and var_159_13 < var_159_19 then
					arg_156_1.talkMaxDuration = var_159_19

					if var_159_19 + var_159_12 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_19 + var_159_12
					end
				end

				arg_156_1.text_.text = var_159_16
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121037", "story_v_out_120121.awb") ~= 0 then
					local var_159_20 = manager.audio:GetVoiceLength("story_v_out_120121", "120121037", "story_v_out_120121.awb") / 1000

					if var_159_20 + var_159_12 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_20 + var_159_12
					end

					if var_159_15.prefab_name ~= "" and arg_156_1.actors_[var_159_15.prefab_name] ~= nil then
						local var_159_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_15.prefab_name].transform, "story_v_out_120121", "120121037", "story_v_out_120121.awb")

						arg_156_1:RecordAudio("120121037", var_159_21)
						arg_156_1:RecordAudio("120121037", var_159_21)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_120121", "120121037", "story_v_out_120121.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_120121", "120121037", "story_v_out_120121.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_22 = math.max(var_159_13, arg_156_1.talkMaxDuration)

			if var_159_12 <= arg_156_1.time_ and arg_156_1.time_ < var_159_12 + var_159_22 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_12) / var_159_22

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_12 + var_159_22 and arg_156_1.time_ < var_159_12 + var_159_22 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play120121038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 120121038
		arg_160_1.duration_ = 4.6

		local var_160_0 = {
			zh = 4.6,
			ja = 3
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
				arg_160_0:Play120121039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action435")
			end

			local var_163_1 = 0
			local var_163_2 = 0.5

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_3 = arg_160_1:FormatText(StoryNameCfg[384].name)

				arg_160_1.leftNameTxt_.text = var_163_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_4 = arg_160_1:GetWordFromCfg(120121038)
				local var_163_5 = arg_160_1:FormatText(var_163_4.content)

				arg_160_1.text_.text = var_163_5

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_6 = 20
				local var_163_7 = utf8.len(var_163_5)
				local var_163_8 = var_163_6 <= 0 and var_163_2 or var_163_2 * (var_163_7 / var_163_6)

				if var_163_8 > 0 and var_163_2 < var_163_8 then
					arg_160_1.talkMaxDuration = var_163_8

					if var_163_8 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_1
					end
				end

				arg_160_1.text_.text = var_163_5
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121038", "story_v_out_120121.awb") ~= 0 then
					local var_163_9 = manager.audio:GetVoiceLength("story_v_out_120121", "120121038", "story_v_out_120121.awb") / 1000

					if var_163_9 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_9 + var_163_1
					end

					if var_163_4.prefab_name ~= "" and arg_160_1.actors_[var_163_4.prefab_name] ~= nil then
						local var_163_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_4.prefab_name].transform, "story_v_out_120121", "120121038", "story_v_out_120121.awb")

						arg_160_1:RecordAudio("120121038", var_163_10)
						arg_160_1:RecordAudio("120121038", var_163_10)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_120121", "120121038", "story_v_out_120121.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_120121", "120121038", "story_v_out_120121.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_11 = math.max(var_163_2, arg_160_1.talkMaxDuration)

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_11 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_1) / var_163_11

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_1 + var_163_11 and arg_160_1.time_ < var_163_1 + var_163_11 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play120121039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 120121039
		arg_164_1.duration_ = 5.5

		local var_164_0 = {
			zh = 5.5,
			ja = 4.766
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
				arg_164_0:Play120121040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_167_1 = 0
			local var_167_2 = 0.425

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_3 = arg_164_1:FormatText(StoryNameCfg[384].name)

				arg_164_1.leftNameTxt_.text = var_167_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_4 = arg_164_1:GetWordFromCfg(120121039)
				local var_167_5 = arg_164_1:FormatText(var_167_4.content)

				arg_164_1.text_.text = var_167_5

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_6 = 17
				local var_167_7 = utf8.len(var_167_5)
				local var_167_8 = var_167_6 <= 0 and var_167_2 or var_167_2 * (var_167_7 / var_167_6)

				if var_167_8 > 0 and var_167_2 < var_167_8 then
					arg_164_1.talkMaxDuration = var_167_8

					if var_167_8 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_1
					end
				end

				arg_164_1.text_.text = var_167_5
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121039", "story_v_out_120121.awb") ~= 0 then
					local var_167_9 = manager.audio:GetVoiceLength("story_v_out_120121", "120121039", "story_v_out_120121.awb") / 1000

					if var_167_9 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_9 + var_167_1
					end

					if var_167_4.prefab_name ~= "" and arg_164_1.actors_[var_167_4.prefab_name] ~= nil then
						local var_167_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_4.prefab_name].transform, "story_v_out_120121", "120121039", "story_v_out_120121.awb")

						arg_164_1:RecordAudio("120121039", var_167_10)
						arg_164_1:RecordAudio("120121039", var_167_10)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_120121", "120121039", "story_v_out_120121.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_120121", "120121039", "story_v_out_120121.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_11 = math.max(var_167_2, arg_164_1.talkMaxDuration)

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_11 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_1) / var_167_11

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_1 + var_167_11 and arg_164_1.time_ < var_167_1 + var_167_11 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play120121040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 120121040
		arg_168_1.duration_ = 4.77

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play120121041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1071ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1071ui_story == nil then
				arg_168_1.var_.characterEffect1071ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.2

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1071ui_story and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1071ui_story.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1071ui_story then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1071ui_story.fillRatio = var_171_5
			end

			local var_171_6 = arg_168_1.actors_["1075ui_story"]
			local var_171_7 = 0

			if var_171_7 < arg_168_1.time_ and arg_168_1.time_ <= var_171_7 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect1075ui_story == nil then
				arg_168_1.var_.characterEffect1075ui_story = var_171_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_8 = 0.2

			if var_171_7 <= arg_168_1.time_ and arg_168_1.time_ < var_171_7 + var_171_8 and not isNil(var_171_6) then
				local var_171_9 = (arg_168_1.time_ - var_171_7) / var_171_8

				if arg_168_1.var_.characterEffect1075ui_story and not isNil(var_171_6) then
					arg_168_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_7 + var_171_8 and arg_168_1.time_ < var_171_7 + var_171_8 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect1075ui_story then
				arg_168_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_171_10 = 0

			if var_171_10 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 then
				arg_168_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_171_11 = 0
			local var_171_12 = 0.575

			if var_171_11 < arg_168_1.time_ and arg_168_1.time_ <= var_171_11 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_13 = arg_168_1:FormatText(StoryNameCfg[381].name)

				arg_168_1.leftNameTxt_.text = var_171_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_14 = arg_168_1:GetWordFromCfg(120121040)
				local var_171_15 = arg_168_1:FormatText(var_171_14.content)

				arg_168_1.text_.text = var_171_15

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_16 = 23
				local var_171_17 = utf8.len(var_171_15)
				local var_171_18 = var_171_16 <= 0 and var_171_12 or var_171_12 * (var_171_17 / var_171_16)

				if var_171_18 > 0 and var_171_12 < var_171_18 then
					arg_168_1.talkMaxDuration = var_171_18

					if var_171_18 + var_171_11 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_18 + var_171_11
					end
				end

				arg_168_1.text_.text = var_171_15
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121040", "story_v_out_120121.awb") ~= 0 then
					local var_171_19 = manager.audio:GetVoiceLength("story_v_out_120121", "120121040", "story_v_out_120121.awb") / 1000

					if var_171_19 + var_171_11 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_19 + var_171_11
					end

					if var_171_14.prefab_name ~= "" and arg_168_1.actors_[var_171_14.prefab_name] ~= nil then
						local var_171_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_14.prefab_name].transform, "story_v_out_120121", "120121040", "story_v_out_120121.awb")

						arg_168_1:RecordAudio("120121040", var_171_20)
						arg_168_1:RecordAudio("120121040", var_171_20)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_120121", "120121040", "story_v_out_120121.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_120121", "120121040", "story_v_out_120121.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_21 = math.max(var_171_12, arg_168_1.talkMaxDuration)

			if var_171_11 <= arg_168_1.time_ and arg_168_1.time_ < var_171_11 + var_171_21 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_11) / var_171_21

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_11 + var_171_21 and arg_168_1.time_ < var_171_11 + var_171_21 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play120121041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 120121041
		arg_172_1.duration_ = 3.4

		local var_172_0 = {
			zh = 3.1,
			ja = 3.4
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play120121042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1071ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1071ui_story == nil then
				arg_172_1.var_.characterEffect1071ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1071ui_story and not isNil(var_175_0) then
					arg_172_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1071ui_story then
				arg_172_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_175_4 = arg_172_1.actors_["1075ui_story"]
			local var_175_5 = 0

			if var_175_5 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 and not isNil(var_175_4) and arg_172_1.var_.characterEffect1075ui_story == nil then
				arg_172_1.var_.characterEffect1075ui_story = var_175_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_6 = 0.2

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_6 and not isNil(var_175_4) then
				local var_175_7 = (arg_172_1.time_ - var_175_5) / var_175_6

				if arg_172_1.var_.characterEffect1075ui_story and not isNil(var_175_4) then
					local var_175_8 = Mathf.Lerp(0, 0.5, var_175_7)

					arg_172_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1075ui_story.fillRatio = var_175_8
				end
			end

			if arg_172_1.time_ >= var_175_5 + var_175_6 and arg_172_1.time_ < var_175_5 + var_175_6 + arg_175_0 and not isNil(var_175_4) and arg_172_1.var_.characterEffect1075ui_story then
				local var_175_9 = 0.5

				arg_172_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1075ui_story.fillRatio = var_175_9
			end

			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 then
				arg_172_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action6_1")
			end

			local var_175_11 = 0
			local var_175_12 = 0.275

			if var_175_11 < arg_172_1.time_ and arg_172_1.time_ <= var_175_11 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_13 = arg_172_1:FormatText(StoryNameCfg[384].name)

				arg_172_1.leftNameTxt_.text = var_175_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_14 = arg_172_1:GetWordFromCfg(120121041)
				local var_175_15 = arg_172_1:FormatText(var_175_14.content)

				arg_172_1.text_.text = var_175_15

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_16 = 11
				local var_175_17 = utf8.len(var_175_15)
				local var_175_18 = var_175_16 <= 0 and var_175_12 or var_175_12 * (var_175_17 / var_175_16)

				if var_175_18 > 0 and var_175_12 < var_175_18 then
					arg_172_1.talkMaxDuration = var_175_18

					if var_175_18 + var_175_11 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_18 + var_175_11
					end
				end

				arg_172_1.text_.text = var_175_15
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121041", "story_v_out_120121.awb") ~= 0 then
					local var_175_19 = manager.audio:GetVoiceLength("story_v_out_120121", "120121041", "story_v_out_120121.awb") / 1000

					if var_175_19 + var_175_11 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_19 + var_175_11
					end

					if var_175_14.prefab_name ~= "" and arg_172_1.actors_[var_175_14.prefab_name] ~= nil then
						local var_175_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_14.prefab_name].transform, "story_v_out_120121", "120121041", "story_v_out_120121.awb")

						arg_172_1:RecordAudio("120121041", var_175_20)
						arg_172_1:RecordAudio("120121041", var_175_20)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_120121", "120121041", "story_v_out_120121.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_120121", "120121041", "story_v_out_120121.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_21 = math.max(var_175_12, arg_172_1.talkMaxDuration)

			if var_175_11 <= arg_172_1.time_ and arg_172_1.time_ < var_175_11 + var_175_21 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_11) / var_175_21

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_11 + var_175_21 and arg_172_1.time_ < var_175_11 + var_175_21 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play120121042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 120121042
		arg_176_1.duration_ = 9.57

		local var_176_0 = {
			zh = 5.1,
			ja = 9.566
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
				arg_176_0:Play120121043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1071ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1071ui_story == nil then
				arg_176_1.var_.characterEffect1071ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1071ui_story and not isNil(var_179_0) then
					local var_179_4 = Mathf.Lerp(0, 0.5, var_179_3)

					arg_176_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1071ui_story.fillRatio = var_179_4
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1071ui_story then
				local var_179_5 = 0.5

				arg_176_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1071ui_story.fillRatio = var_179_5
			end

			local var_179_6 = arg_176_1.actors_["1075ui_story"]
			local var_179_7 = 0

			if var_179_7 < arg_176_1.time_ and arg_176_1.time_ <= var_179_7 + arg_179_0 and not isNil(var_179_6) and arg_176_1.var_.characterEffect1075ui_story == nil then
				arg_176_1.var_.characterEffect1075ui_story = var_179_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_8 = 0.2

			if var_179_7 <= arg_176_1.time_ and arg_176_1.time_ < var_179_7 + var_179_8 and not isNil(var_179_6) then
				local var_179_9 = (arg_176_1.time_ - var_179_7) / var_179_8

				if arg_176_1.var_.characterEffect1075ui_story and not isNil(var_179_6) then
					arg_176_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_7 + var_179_8 and arg_176_1.time_ < var_179_7 + var_179_8 + arg_179_0 and not isNil(var_179_6) and arg_176_1.var_.characterEffect1075ui_story then
				arg_176_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_179_10 = 0

			if var_179_10 < arg_176_1.time_ and arg_176_1.time_ <= var_179_10 + arg_179_0 then
				arg_176_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_179_11 = 0

			if var_179_11 < arg_176_1.time_ and arg_176_1.time_ <= var_179_11 + arg_179_0 then
				arg_176_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_179_12 = 0
			local var_179_13 = 0.525

			if var_179_12 < arg_176_1.time_ and arg_176_1.time_ <= var_179_12 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_14 = arg_176_1:FormatText(StoryNameCfg[381].name)

				arg_176_1.leftNameTxt_.text = var_179_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_15 = arg_176_1:GetWordFromCfg(120121042)
				local var_179_16 = arg_176_1:FormatText(var_179_15.content)

				arg_176_1.text_.text = var_179_16

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_17 = 21
				local var_179_18 = utf8.len(var_179_16)
				local var_179_19 = var_179_17 <= 0 and var_179_13 or var_179_13 * (var_179_18 / var_179_17)

				if var_179_19 > 0 and var_179_13 < var_179_19 then
					arg_176_1.talkMaxDuration = var_179_19

					if var_179_19 + var_179_12 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_19 + var_179_12
					end
				end

				arg_176_1.text_.text = var_179_16
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121042", "story_v_out_120121.awb") ~= 0 then
					local var_179_20 = manager.audio:GetVoiceLength("story_v_out_120121", "120121042", "story_v_out_120121.awb") / 1000

					if var_179_20 + var_179_12 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_20 + var_179_12
					end

					if var_179_15.prefab_name ~= "" and arg_176_1.actors_[var_179_15.prefab_name] ~= nil then
						local var_179_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_15.prefab_name].transform, "story_v_out_120121", "120121042", "story_v_out_120121.awb")

						arg_176_1:RecordAudio("120121042", var_179_21)
						arg_176_1:RecordAudio("120121042", var_179_21)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_120121", "120121042", "story_v_out_120121.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_120121", "120121042", "story_v_out_120121.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_22 = math.max(var_179_13, arg_176_1.talkMaxDuration)

			if var_179_12 <= arg_176_1.time_ and arg_176_1.time_ < var_179_12 + var_179_22 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_12) / var_179_22

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_12 + var_179_22 and arg_176_1.time_ < var_179_12 + var_179_22 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play120121043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 120121043
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play120121044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1071ui_story"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos1071ui_story = var_183_0.localPosition
			end

			local var_183_2 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2
				local var_183_4 = Vector3.New(0, 100, 0)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1071ui_story, var_183_4, var_183_3)

				local var_183_5 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_5.x, var_183_5.y, var_183_5.z)

				local var_183_6 = var_183_0.localEulerAngles

				var_183_6.z = 0
				var_183_6.x = 0
				var_183_0.localEulerAngles = var_183_6
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(0, 100, 0)

				local var_183_7 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_7.x, var_183_7.y, var_183_7.z)

				local var_183_8 = var_183_0.localEulerAngles

				var_183_8.z = 0
				var_183_8.x = 0
				var_183_0.localEulerAngles = var_183_8
			end

			local var_183_9 = arg_180_1.actors_["1075ui_story"].transform
			local var_183_10 = 0

			if var_183_10 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 then
				arg_180_1.var_.moveOldPos1075ui_story = var_183_9.localPosition
			end

			local var_183_11 = 0.001

			if var_183_10 <= arg_180_1.time_ and arg_180_1.time_ < var_183_10 + var_183_11 then
				local var_183_12 = (arg_180_1.time_ - var_183_10) / var_183_11
				local var_183_13 = Vector3.New(0, 100, 0)

				var_183_9.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1075ui_story, var_183_13, var_183_12)

				local var_183_14 = manager.ui.mainCamera.transform.position - var_183_9.position

				var_183_9.forward = Vector3.New(var_183_14.x, var_183_14.y, var_183_14.z)

				local var_183_15 = var_183_9.localEulerAngles

				var_183_15.z = 0
				var_183_15.x = 0
				var_183_9.localEulerAngles = var_183_15
			end

			if arg_180_1.time_ >= var_183_10 + var_183_11 and arg_180_1.time_ < var_183_10 + var_183_11 + arg_183_0 then
				var_183_9.localPosition = Vector3.New(0, 100, 0)

				local var_183_16 = manager.ui.mainCamera.transform.position - var_183_9.position

				var_183_9.forward = Vector3.New(var_183_16.x, var_183_16.y, var_183_16.z)

				local var_183_17 = var_183_9.localEulerAngles

				var_183_17.z = 0
				var_183_17.x = 0
				var_183_9.localEulerAngles = var_183_17
			end

			local var_183_18 = 0
			local var_183_19 = 0.55

			if var_183_18 < arg_180_1.time_ and arg_180_1.time_ <= var_183_18 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_20 = arg_180_1:GetWordFromCfg(120121043)
				local var_183_21 = arg_180_1:FormatText(var_183_20.content)

				arg_180_1.text_.text = var_183_21

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_22 = 22
				local var_183_23 = utf8.len(var_183_21)
				local var_183_24 = var_183_22 <= 0 and var_183_19 or var_183_19 * (var_183_23 / var_183_22)

				if var_183_24 > 0 and var_183_19 < var_183_24 then
					arg_180_1.talkMaxDuration = var_183_24

					if var_183_24 + var_183_18 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_24 + var_183_18
					end
				end

				arg_180_1.text_.text = var_183_21
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_25 = math.max(var_183_19, arg_180_1.talkMaxDuration)

			if var_183_18 <= arg_180_1.time_ and arg_180_1.time_ < var_183_18 + var_183_25 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_18) / var_183_25

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_18 + var_183_25 and arg_180_1.time_ < var_183_18 + var_183_25 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play120121044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 120121044
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play120121045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0
			local var_187_1 = 0.925

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_2 = arg_184_1:GetWordFromCfg(120121044)
				local var_187_3 = arg_184_1:FormatText(var_187_2.content)

				arg_184_1.text_.text = var_187_3

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_4 = 37
				local var_187_5 = utf8.len(var_187_3)
				local var_187_6 = var_187_4 <= 0 and var_187_1 or var_187_1 * (var_187_5 / var_187_4)

				if var_187_6 > 0 and var_187_1 < var_187_6 then
					arg_184_1.talkMaxDuration = var_187_6

					if var_187_6 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_6 + var_187_0
					end
				end

				arg_184_1.text_.text = var_187_3
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_7 = math.max(var_187_1, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_7 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_0) / var_187_7

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_7 and arg_184_1.time_ < var_187_0 + var_187_7 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play120121045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 120121045
		arg_188_1.duration_ = 10.57

		local var_188_0 = {
			zh = 5.666,
			ja = 10.566
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
				arg_188_0:Play120121046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1071ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos1071ui_story = var_191_0.localPosition
			end

			local var_191_2 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2
				local var_191_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1071ui_story, var_191_4, var_191_3)

				local var_191_5 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_5.x, var_191_5.y, var_191_5.z)

				local var_191_6 = var_191_0.localEulerAngles

				var_191_6.z = 0
				var_191_6.x = 0
				var_191_0.localEulerAngles = var_191_6
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_191_7 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_7.x, var_191_7.y, var_191_7.z)

				local var_191_8 = var_191_0.localEulerAngles

				var_191_8.z = 0
				var_191_8.x = 0
				var_191_0.localEulerAngles = var_191_8
			end

			local var_191_9 = arg_188_1.actors_["1075ui_story"].transform
			local var_191_10 = 0

			if var_191_10 < arg_188_1.time_ and arg_188_1.time_ <= var_191_10 + arg_191_0 then
				arg_188_1.var_.moveOldPos1075ui_story = var_191_9.localPosition
			end

			local var_191_11 = 0.001

			if var_191_10 <= arg_188_1.time_ and arg_188_1.time_ < var_191_10 + var_191_11 then
				local var_191_12 = (arg_188_1.time_ - var_191_10) / var_191_11
				local var_191_13 = Vector3.New(0.7, -1.055, -6.16)

				var_191_9.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1075ui_story, var_191_13, var_191_12)

				local var_191_14 = manager.ui.mainCamera.transform.position - var_191_9.position

				var_191_9.forward = Vector3.New(var_191_14.x, var_191_14.y, var_191_14.z)

				local var_191_15 = var_191_9.localEulerAngles

				var_191_15.z = 0
				var_191_15.x = 0
				var_191_9.localEulerAngles = var_191_15
			end

			if arg_188_1.time_ >= var_191_10 + var_191_11 and arg_188_1.time_ < var_191_10 + var_191_11 + arg_191_0 then
				var_191_9.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_191_16 = manager.ui.mainCamera.transform.position - var_191_9.position

				var_191_9.forward = Vector3.New(var_191_16.x, var_191_16.y, var_191_16.z)

				local var_191_17 = var_191_9.localEulerAngles

				var_191_17.z = 0
				var_191_17.x = 0
				var_191_9.localEulerAngles = var_191_17
			end

			local var_191_18 = arg_188_1.actors_["1071ui_story"]
			local var_191_19 = 0

			if var_191_19 < arg_188_1.time_ and arg_188_1.time_ <= var_191_19 + arg_191_0 and not isNil(var_191_18) and arg_188_1.var_.characterEffect1071ui_story == nil then
				arg_188_1.var_.characterEffect1071ui_story = var_191_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_20 = 0.2

			if var_191_19 <= arg_188_1.time_ and arg_188_1.time_ < var_191_19 + var_191_20 and not isNil(var_191_18) then
				local var_191_21 = (arg_188_1.time_ - var_191_19) / var_191_20

				if arg_188_1.var_.characterEffect1071ui_story and not isNil(var_191_18) then
					arg_188_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_19 + var_191_20 and arg_188_1.time_ < var_191_19 + var_191_20 + arg_191_0 and not isNil(var_191_18) and arg_188_1.var_.characterEffect1071ui_story then
				arg_188_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_191_22 = arg_188_1.actors_["1075ui_story"]
			local var_191_23 = 0

			if var_191_23 < arg_188_1.time_ and arg_188_1.time_ <= var_191_23 + arg_191_0 and not isNil(var_191_22) and arg_188_1.var_.characterEffect1075ui_story == nil then
				arg_188_1.var_.characterEffect1075ui_story = var_191_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_24 = 0.034

			if var_191_23 <= arg_188_1.time_ and arg_188_1.time_ < var_191_23 + var_191_24 and not isNil(var_191_22) then
				local var_191_25 = (arg_188_1.time_ - var_191_23) / var_191_24

				if arg_188_1.var_.characterEffect1075ui_story and not isNil(var_191_22) then
					arg_188_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_23 + var_191_24 and arg_188_1.time_ < var_191_23 + var_191_24 + arg_191_0 and not isNil(var_191_22) and arg_188_1.var_.characterEffect1075ui_story then
				arg_188_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_191_26 = 0

			if var_191_26 < arg_188_1.time_ and arg_188_1.time_ <= var_191_26 + arg_191_0 then
				arg_188_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_191_27 = arg_188_1.actors_["1075ui_story"]
			local var_191_28 = 0

			if var_191_28 < arg_188_1.time_ and arg_188_1.time_ <= var_191_28 + arg_191_0 and not isNil(var_191_27) and arg_188_1.var_.characterEffect1075ui_story == nil then
				arg_188_1.var_.characterEffect1075ui_story = var_191_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_29 = 0.034

			if var_191_28 <= arg_188_1.time_ and arg_188_1.time_ < var_191_28 + var_191_29 and not isNil(var_191_27) then
				local var_191_30 = (arg_188_1.time_ - var_191_28) / var_191_29

				if arg_188_1.var_.characterEffect1075ui_story and not isNil(var_191_27) then
					local var_191_31 = Mathf.Lerp(0, 0.5, var_191_30)

					arg_188_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1075ui_story.fillRatio = var_191_31
				end
			end

			if arg_188_1.time_ >= var_191_28 + var_191_29 and arg_188_1.time_ < var_191_28 + var_191_29 + arg_191_0 and not isNil(var_191_27) and arg_188_1.var_.characterEffect1075ui_story then
				local var_191_32 = 0.5

				arg_188_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1075ui_story.fillRatio = var_191_32
			end

			local var_191_33 = 0
			local var_191_34 = 0.675

			if var_191_33 < arg_188_1.time_ and arg_188_1.time_ <= var_191_33 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_35 = arg_188_1:FormatText(StoryNameCfg[384].name)

				arg_188_1.leftNameTxt_.text = var_191_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_36 = arg_188_1:GetWordFromCfg(120121045)
				local var_191_37 = arg_188_1:FormatText(var_191_36.content)

				arg_188_1.text_.text = var_191_37

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_38 = 27
				local var_191_39 = utf8.len(var_191_37)
				local var_191_40 = var_191_38 <= 0 and var_191_34 or var_191_34 * (var_191_39 / var_191_38)

				if var_191_40 > 0 and var_191_34 < var_191_40 then
					arg_188_1.talkMaxDuration = var_191_40

					if var_191_40 + var_191_33 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_40 + var_191_33
					end
				end

				arg_188_1.text_.text = var_191_37
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121045", "story_v_out_120121.awb") ~= 0 then
					local var_191_41 = manager.audio:GetVoiceLength("story_v_out_120121", "120121045", "story_v_out_120121.awb") / 1000

					if var_191_41 + var_191_33 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_41 + var_191_33
					end

					if var_191_36.prefab_name ~= "" and arg_188_1.actors_[var_191_36.prefab_name] ~= nil then
						local var_191_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_36.prefab_name].transform, "story_v_out_120121", "120121045", "story_v_out_120121.awb")

						arg_188_1:RecordAudio("120121045", var_191_42)
						arg_188_1:RecordAudio("120121045", var_191_42)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_120121", "120121045", "story_v_out_120121.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_120121", "120121045", "story_v_out_120121.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_43 = math.max(var_191_34, arg_188_1.talkMaxDuration)

			if var_191_33 <= arg_188_1.time_ and arg_188_1.time_ < var_191_33 + var_191_43 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_33) / var_191_43

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_33 + var_191_43 and arg_188_1.time_ < var_191_33 + var_191_43 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play120121046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 120121046
		arg_192_1.duration_ = 5.23

		local var_192_0 = {
			zh = 1.999999999999,
			ja = 5.233
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
				arg_192_0:Play120121047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1071ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1071ui_story == nil then
				arg_192_1.var_.characterEffect1071ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.2

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect1071ui_story and not isNil(var_195_0) then
					local var_195_4 = Mathf.Lerp(0, 0.5, var_195_3)

					arg_192_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1071ui_story.fillRatio = var_195_4
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1071ui_story then
				local var_195_5 = 0.5

				arg_192_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1071ui_story.fillRatio = var_195_5
			end

			local var_195_6 = arg_192_1.actors_["1075ui_story"]
			local var_195_7 = 0

			if var_195_7 < arg_192_1.time_ and arg_192_1.time_ <= var_195_7 + arg_195_0 and not isNil(var_195_6) and arg_192_1.var_.characterEffect1075ui_story == nil then
				arg_192_1.var_.characterEffect1075ui_story = var_195_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_8 = 0.2

			if var_195_7 <= arg_192_1.time_ and arg_192_1.time_ < var_195_7 + var_195_8 and not isNil(var_195_6) then
				local var_195_9 = (arg_192_1.time_ - var_195_7) / var_195_8

				if arg_192_1.var_.characterEffect1075ui_story and not isNil(var_195_6) then
					arg_192_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_7 + var_195_8 and arg_192_1.time_ < var_195_7 + var_195_8 + arg_195_0 and not isNil(var_195_6) and arg_192_1.var_.characterEffect1075ui_story then
				arg_192_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_195_10 = 0

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 then
				arg_192_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_195_11 = 0
			local var_195_12 = 0.225

			if var_195_11 < arg_192_1.time_ and arg_192_1.time_ <= var_195_11 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_13 = arg_192_1:FormatText(StoryNameCfg[381].name)

				arg_192_1.leftNameTxt_.text = var_195_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_14 = arg_192_1:GetWordFromCfg(120121046)
				local var_195_15 = arg_192_1:FormatText(var_195_14.content)

				arg_192_1.text_.text = var_195_15

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_16 = 9
				local var_195_17 = utf8.len(var_195_15)
				local var_195_18 = var_195_16 <= 0 and var_195_12 or var_195_12 * (var_195_17 / var_195_16)

				if var_195_18 > 0 and var_195_12 < var_195_18 then
					arg_192_1.talkMaxDuration = var_195_18

					if var_195_18 + var_195_11 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_18 + var_195_11
					end
				end

				arg_192_1.text_.text = var_195_15
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121046", "story_v_out_120121.awb") ~= 0 then
					local var_195_19 = manager.audio:GetVoiceLength("story_v_out_120121", "120121046", "story_v_out_120121.awb") / 1000

					if var_195_19 + var_195_11 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_19 + var_195_11
					end

					if var_195_14.prefab_name ~= "" and arg_192_1.actors_[var_195_14.prefab_name] ~= nil then
						local var_195_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_14.prefab_name].transform, "story_v_out_120121", "120121046", "story_v_out_120121.awb")

						arg_192_1:RecordAudio("120121046", var_195_20)
						arg_192_1:RecordAudio("120121046", var_195_20)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_120121", "120121046", "story_v_out_120121.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_120121", "120121046", "story_v_out_120121.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_21 = math.max(var_195_12, arg_192_1.talkMaxDuration)

			if var_195_11 <= arg_192_1.time_ and arg_192_1.time_ < var_195_11 + var_195_21 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_11) / var_195_21

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_11 + var_195_21 and arg_192_1.time_ < var_195_11 + var_195_21 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play120121047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 120121047
		arg_196_1.duration_ = 5.13

		local var_196_0 = {
			zh = 4.033,
			ja = 5.133
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
				arg_196_0:Play120121048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1071ui_story"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect1071ui_story == nil then
				arg_196_1.var_.characterEffect1071ui_story = var_199_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.2

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.characterEffect1071ui_story and not isNil(var_199_0) then
					arg_196_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect1071ui_story then
				arg_196_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_199_4 = arg_196_1.actors_["1075ui_story"]
			local var_199_5 = 0

			if var_199_5 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 and not isNil(var_199_4) and arg_196_1.var_.characterEffect1075ui_story == nil then
				arg_196_1.var_.characterEffect1075ui_story = var_199_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_6 = 0.2

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_6 and not isNil(var_199_4) then
				local var_199_7 = (arg_196_1.time_ - var_199_5) / var_199_6

				if arg_196_1.var_.characterEffect1075ui_story and not isNil(var_199_4) then
					local var_199_8 = Mathf.Lerp(0, 0.5, var_199_7)

					arg_196_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1075ui_story.fillRatio = var_199_8
				end
			end

			if arg_196_1.time_ >= var_199_5 + var_199_6 and arg_196_1.time_ < var_199_5 + var_199_6 + arg_199_0 and not isNil(var_199_4) and arg_196_1.var_.characterEffect1075ui_story then
				local var_199_9 = 0.5

				arg_196_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1075ui_story.fillRatio = var_199_9
			end

			local var_199_10 = 0

			if var_199_10 < arg_196_1.time_ and arg_196_1.time_ <= var_199_10 + arg_199_0 then
				arg_196_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_199_11 = 0
			local var_199_12 = 0.4

			if var_199_11 < arg_196_1.time_ and arg_196_1.time_ <= var_199_11 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_13 = arg_196_1:FormatText(StoryNameCfg[384].name)

				arg_196_1.leftNameTxt_.text = var_199_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_14 = arg_196_1:GetWordFromCfg(120121047)
				local var_199_15 = arg_196_1:FormatText(var_199_14.content)

				arg_196_1.text_.text = var_199_15

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_16 = 16
				local var_199_17 = utf8.len(var_199_15)
				local var_199_18 = var_199_16 <= 0 and var_199_12 or var_199_12 * (var_199_17 / var_199_16)

				if var_199_18 > 0 and var_199_12 < var_199_18 then
					arg_196_1.talkMaxDuration = var_199_18

					if var_199_18 + var_199_11 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_18 + var_199_11
					end
				end

				arg_196_1.text_.text = var_199_15
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121047", "story_v_out_120121.awb") ~= 0 then
					local var_199_19 = manager.audio:GetVoiceLength("story_v_out_120121", "120121047", "story_v_out_120121.awb") / 1000

					if var_199_19 + var_199_11 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_19 + var_199_11
					end

					if var_199_14.prefab_name ~= "" and arg_196_1.actors_[var_199_14.prefab_name] ~= nil then
						local var_199_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_14.prefab_name].transform, "story_v_out_120121", "120121047", "story_v_out_120121.awb")

						arg_196_1:RecordAudio("120121047", var_199_20)
						arg_196_1:RecordAudio("120121047", var_199_20)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_120121", "120121047", "story_v_out_120121.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_120121", "120121047", "story_v_out_120121.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_21 = math.max(var_199_12, arg_196_1.talkMaxDuration)

			if var_199_11 <= arg_196_1.time_ and arg_196_1.time_ < var_199_11 + var_199_21 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_11) / var_199_21

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_11 + var_199_21 and arg_196_1.time_ < var_199_11 + var_199_21 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play120121048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 120121048
		arg_200_1.duration_ = 12.13

		local var_200_0 = {
			zh = 11.866,
			ja = 12.133
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
				arg_200_0:Play120121049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 1.375

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_2 = arg_200_1:FormatText(StoryNameCfg[384].name)

				arg_200_1.leftNameTxt_.text = var_203_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_3 = arg_200_1:GetWordFromCfg(120121048)
				local var_203_4 = arg_200_1:FormatText(var_203_3.content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 55
				local var_203_6 = utf8.len(var_203_4)
				local var_203_7 = var_203_5 <= 0 and var_203_1 or var_203_1 * (var_203_6 / var_203_5)

				if var_203_7 > 0 and var_203_1 < var_203_7 then
					arg_200_1.talkMaxDuration = var_203_7

					if var_203_7 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_7 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_4
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121048", "story_v_out_120121.awb") ~= 0 then
					local var_203_8 = manager.audio:GetVoiceLength("story_v_out_120121", "120121048", "story_v_out_120121.awb") / 1000

					if var_203_8 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_8 + var_203_0
					end

					if var_203_3.prefab_name ~= "" and arg_200_1.actors_[var_203_3.prefab_name] ~= nil then
						local var_203_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_3.prefab_name].transform, "story_v_out_120121", "120121048", "story_v_out_120121.awb")

						arg_200_1:RecordAudio("120121048", var_203_9)
						arg_200_1:RecordAudio("120121048", var_203_9)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_120121", "120121048", "story_v_out_120121.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_120121", "120121048", "story_v_out_120121.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_10 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_10 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_10

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_10 and arg_200_1.time_ < var_203_0 + var_203_10 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play120121049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 120121049
		arg_204_1.duration_ = 11.77

		local var_204_0 = {
			zh = 7.5,
			ja = 11.766
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
				arg_204_0:Play120121050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.9

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_2 = arg_204_1:FormatText(StoryNameCfg[384].name)

				arg_204_1.leftNameTxt_.text = var_207_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_3 = arg_204_1:GetWordFromCfg(120121049)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 36
				local var_207_6 = utf8.len(var_207_4)
				local var_207_7 = var_207_5 <= 0 and var_207_1 or var_207_1 * (var_207_6 / var_207_5)

				if var_207_7 > 0 and var_207_1 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121049", "story_v_out_120121.awb") ~= 0 then
					local var_207_8 = manager.audio:GetVoiceLength("story_v_out_120121", "120121049", "story_v_out_120121.awb") / 1000

					if var_207_8 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_0
					end

					if var_207_3.prefab_name ~= "" and arg_204_1.actors_[var_207_3.prefab_name] ~= nil then
						local var_207_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_3.prefab_name].transform, "story_v_out_120121", "120121049", "story_v_out_120121.awb")

						arg_204_1:RecordAudio("120121049", var_207_9)
						arg_204_1:RecordAudio("120121049", var_207_9)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_120121", "120121049", "story_v_out_120121.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_120121", "120121049", "story_v_out_120121.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_10 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_10 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_10

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_10 and arg_204_1.time_ < var_207_0 + var_207_10 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play120121050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 120121050
		arg_208_1.duration_ = 7.9

		local var_208_0 = {
			zh = 6.5,
			ja = 7.9
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
			arg_208_1.auto_ = false
		end

		function arg_208_1.playNext_(arg_210_0)
			arg_208_1.onStoryFinished_()
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action423")
			end

			local var_211_1 = 0
			local var_211_2 = 0.75

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_3 = arg_208_1:FormatText(StoryNameCfg[384].name)

				arg_208_1.leftNameTxt_.text = var_211_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_4 = arg_208_1:GetWordFromCfg(120121050)
				local var_211_5 = arg_208_1:FormatText(var_211_4.content)

				arg_208_1.text_.text = var_211_5

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_6 = 30
				local var_211_7 = utf8.len(var_211_5)
				local var_211_8 = var_211_6 <= 0 and var_211_2 or var_211_2 * (var_211_7 / var_211_6)

				if var_211_8 > 0 and var_211_2 < var_211_8 then
					arg_208_1.talkMaxDuration = var_211_8

					if var_211_8 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_1
					end
				end

				arg_208_1.text_.text = var_211_5
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121050", "story_v_out_120121.awb") ~= 0 then
					local var_211_9 = manager.audio:GetVoiceLength("story_v_out_120121", "120121050", "story_v_out_120121.awb") / 1000

					if var_211_9 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_9 + var_211_1
					end

					if var_211_4.prefab_name ~= "" and arg_208_1.actors_[var_211_4.prefab_name] ~= nil then
						local var_211_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_4.prefab_name].transform, "story_v_out_120121", "120121050", "story_v_out_120121.awb")

						arg_208_1:RecordAudio("120121050", var_211_10)
						arg_208_1:RecordAudio("120121050", var_211_10)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_120121", "120121050", "story_v_out_120121.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_120121", "120121050", "story_v_out_120121.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_11 = math.max(var_211_2, arg_208_1.talkMaxDuration)

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_11 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_1) / var_211_11

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_1 + var_211_11 and arg_208_1.time_ < var_211_1 + var_211_11 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J13f"
	},
	voices = {
		"story_v_out_120121.awb"
	}
}
