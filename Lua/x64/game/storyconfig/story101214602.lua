return {
	Play121462001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121462001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play121462002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J02g"

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
				local var_4_5 = arg_1_1.bgs_.J02g

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
					if iter_4_0 ~= "J02g" then
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

			local var_4_28 = 0.133333333333333
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

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
			local var_4_35 = 0.375

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

				local var_4_37 = arg_1_1:GetWordFromCfg(121462001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 15
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
	Play121462002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121462002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play121462003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.375

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

				local var_12_2 = arg_9_1:GetWordFromCfg(121462002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 55
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
	Play121462003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121462003
		arg_13_1.duration_ = 4.6

		local var_13_0 = {
			ja = 4.6,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play121462004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1184ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["1184ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1184ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(-0.7, -0.97, -6)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1184ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["1184ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1184ui_story == nil then
				arg_13_1.var_.characterEffect1184ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect1184ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1184ui_story then
				arg_13_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_16_20 = "1076ui_story"

			if arg_13_1.actors_[var_16_20] == nil then
				local var_16_21 = Asset.Load("Char/" .. "1076ui_story")

				if not isNil(var_16_21) then
					local var_16_22 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_13_1.stage_.transform)

					var_16_22.name = var_16_20
					var_16_22.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_20] = var_16_22

					local var_16_23 = var_16_22:GetComponentInChildren(typeof(CharacterEffect))

					var_16_23.enabled = true

					local var_16_24 = GameObjectTools.GetOrAddComponent(var_16_22, typeof(DynamicBoneHelper))

					if var_16_24 then
						var_16_24:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_23.transform, false)

					arg_13_1.var_[var_16_20 .. "Animator"] = var_16_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_20 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_20 .. "LipSync"] = var_16_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_25 = arg_13_1.actors_["1076ui_story"].transform
			local var_16_26 = 0

			if var_16_26 < arg_13_1.time_ and arg_13_1.time_ <= var_16_26 + arg_16_0 then
				arg_13_1.var_.moveOldPos1076ui_story = var_16_25.localPosition
			end

			local var_16_27 = 0.001

			if var_16_26 <= arg_13_1.time_ and arg_13_1.time_ < var_16_26 + var_16_27 then
				local var_16_28 = (arg_13_1.time_ - var_16_26) / var_16_27
				local var_16_29 = Vector3.New(0.7, -1.06, -6.2)

				var_16_25.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1076ui_story, var_16_29, var_16_28)

				local var_16_30 = manager.ui.mainCamera.transform.position - var_16_25.position

				var_16_25.forward = Vector3.New(var_16_30.x, var_16_30.y, var_16_30.z)

				local var_16_31 = var_16_25.localEulerAngles

				var_16_31.z = 0
				var_16_31.x = 0
				var_16_25.localEulerAngles = var_16_31
			end

			if arg_13_1.time_ >= var_16_26 + var_16_27 and arg_13_1.time_ < var_16_26 + var_16_27 + arg_16_0 then
				var_16_25.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_16_32 = manager.ui.mainCamera.transform.position - var_16_25.position

				var_16_25.forward = Vector3.New(var_16_32.x, var_16_32.y, var_16_32.z)

				local var_16_33 = var_16_25.localEulerAngles

				var_16_33.z = 0
				var_16_33.x = 0
				var_16_25.localEulerAngles = var_16_33
			end

			local var_16_34 = arg_13_1.actors_["1076ui_story"]
			local var_16_35 = 0

			if var_16_35 < arg_13_1.time_ and arg_13_1.time_ <= var_16_35 + arg_16_0 and not isNil(var_16_34) and arg_13_1.var_.characterEffect1076ui_story == nil then
				arg_13_1.var_.characterEffect1076ui_story = var_16_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_36 = 0.200000002980232

			if var_16_35 <= arg_13_1.time_ and arg_13_1.time_ < var_16_35 + var_16_36 and not isNil(var_16_34) then
				local var_16_37 = (arg_13_1.time_ - var_16_35) / var_16_36

				if arg_13_1.var_.characterEffect1076ui_story and not isNil(var_16_34) then
					local var_16_38 = Mathf.Lerp(0, 0.5, var_16_37)

					arg_13_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1076ui_story.fillRatio = var_16_38
				end
			end

			if arg_13_1.time_ >= var_16_35 + var_16_36 and arg_13_1.time_ < var_16_35 + var_16_36 + arg_16_0 and not isNil(var_16_34) and arg_13_1.var_.characterEffect1076ui_story then
				local var_16_39 = 0.5

				arg_13_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1076ui_story.fillRatio = var_16_39
			end

			local var_16_40 = 0

			if var_16_40 < arg_13_1.time_ and arg_13_1.time_ <= var_16_40 + arg_16_0 then
				arg_13_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_16_41 = 0

			if var_16_41 < arg_13_1.time_ and arg_13_1.time_ <= var_16_41 + arg_16_0 then
				arg_13_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_16_42 = 0
			local var_16_43 = 0.15

			if var_16_42 < arg_13_1.time_ and arg_13_1.time_ <= var_16_42 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_44 = arg_13_1:FormatText(StoryNameCfg[6].name)

				arg_13_1.leftNameTxt_.text = var_16_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_45 = arg_13_1:GetWordFromCfg(121462003)
				local var_16_46 = arg_13_1:FormatText(var_16_45.content)

				arg_13_1.text_.text = var_16_46

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_47 = 6
				local var_16_48 = utf8.len(var_16_46)
				local var_16_49 = var_16_47 <= 0 and var_16_43 or var_16_43 * (var_16_48 / var_16_47)

				if var_16_49 > 0 and var_16_43 < var_16_49 then
					arg_13_1.talkMaxDuration = var_16_49

					if var_16_49 + var_16_42 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_49 + var_16_42
					end
				end

				arg_13_1.text_.text = var_16_46
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462003", "story_v_out_121462.awb") ~= 0 then
					local var_16_50 = manager.audio:GetVoiceLength("story_v_out_121462", "121462003", "story_v_out_121462.awb") / 1000

					if var_16_50 + var_16_42 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_50 + var_16_42
					end

					if var_16_45.prefab_name ~= "" and arg_13_1.actors_[var_16_45.prefab_name] ~= nil then
						local var_16_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_45.prefab_name].transform, "story_v_out_121462", "121462003", "story_v_out_121462.awb")

						arg_13_1:RecordAudio("121462003", var_16_51)
						arg_13_1:RecordAudio("121462003", var_16_51)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_121462", "121462003", "story_v_out_121462.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_121462", "121462003", "story_v_out_121462.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_52 = math.max(var_16_43, arg_13_1.talkMaxDuration)

			if var_16_42 <= arg_13_1.time_ and arg_13_1.time_ < var_16_42 + var_16_52 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_42) / var_16_52

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_42 + var_16_52 and arg_13_1.time_ < var_16_42 + var_16_52 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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

		arg_13_1:InitPlayNodeList()
	end,
	Play121462004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121462004
		arg_17_1.duration_ = 1.43

		local var_17_0 = {
			ja = 1.433,
			ko = 1.033,
			zh = 1.033
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
				arg_17_0:Play121462005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1184ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1184ui_story == nil then
				arg_17_1.var_.characterEffect1184ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1184ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1184ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1184ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1184ui_story.fillRatio = var_20_5
			end

			local var_20_6 = arg_17_1.actors_["1076ui_story"]
			local var_20_7 = 0

			if var_20_7 < arg_17_1.time_ and arg_17_1.time_ <= var_20_7 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.characterEffect1076ui_story == nil then
				arg_17_1.var_.characterEffect1076ui_story = var_20_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_8 = 0.200000002980232

			if var_20_7 <= arg_17_1.time_ and arg_17_1.time_ < var_20_7 + var_20_8 and not isNil(var_20_6) then
				local var_20_9 = (arg_17_1.time_ - var_20_7) / var_20_8

				if arg_17_1.var_.characterEffect1076ui_story and not isNil(var_20_6) then
					arg_17_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_7 + var_20_8 and arg_17_1.time_ < var_20_7 + var_20_8 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.characterEffect1076ui_story then
				arg_17_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_20_10 = 0
			local var_20_11 = 0.075

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_12 = arg_17_1:FormatText(StoryNameCfg[389].name)

				arg_17_1.leftNameTxt_.text = var_20_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_13 = arg_17_1:GetWordFromCfg(121462004)
				local var_20_14 = arg_17_1:FormatText(var_20_13.content)

				arg_17_1.text_.text = var_20_14

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 3
				local var_20_16 = utf8.len(var_20_14)
				local var_20_17 = var_20_15 <= 0 and var_20_11 or var_20_11 * (var_20_16 / var_20_15)

				if var_20_17 > 0 and var_20_11 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_14
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462004", "story_v_out_121462.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_121462", "121462004", "story_v_out_121462.awb") / 1000

					if var_20_18 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_10
					end

					if var_20_13.prefab_name ~= "" and arg_17_1.actors_[var_20_13.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_13.prefab_name].transform, "story_v_out_121462", "121462004", "story_v_out_121462.awb")

						arg_17_1:RecordAudio("121462004", var_20_19)
						arg_17_1:RecordAudio("121462004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_121462", "121462004", "story_v_out_121462.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_121462", "121462004", "story_v_out_121462.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_20 = math.max(var_20_11, arg_17_1.talkMaxDuration)

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_10) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_10 + var_20_20 and arg_17_1.time_ < var_20_10 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play121462005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 121462005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play121462006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1184ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1184ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1184ui_story, var_24_4, var_24_3)

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

			local var_24_9 = arg_21_1.actors_["1184ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1184ui_story == nil then
				arg_21_1.var_.characterEffect1184ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect1184ui_story and not isNil(var_24_9) then
					local var_24_13 = Mathf.Lerp(0, 0.5, var_24_12)

					arg_21_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1184ui_story.fillRatio = var_24_13
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1184ui_story then
				local var_24_14 = 0.5

				arg_21_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1184ui_story.fillRatio = var_24_14
			end

			local var_24_15 = arg_21_1.actors_["1076ui_story"].transform
			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.var_.moveOldPos1076ui_story = var_24_15.localPosition
			end

			local var_24_17 = 0.001

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_17 then
				local var_24_18 = (arg_21_1.time_ - var_24_16) / var_24_17
				local var_24_19 = Vector3.New(0, 100, 0)

				var_24_15.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1076ui_story, var_24_19, var_24_18)

				local var_24_20 = manager.ui.mainCamera.transform.position - var_24_15.position

				var_24_15.forward = Vector3.New(var_24_20.x, var_24_20.y, var_24_20.z)

				local var_24_21 = var_24_15.localEulerAngles

				var_24_21.z = 0
				var_24_21.x = 0
				var_24_15.localEulerAngles = var_24_21
			end

			if arg_21_1.time_ >= var_24_16 + var_24_17 and arg_21_1.time_ < var_24_16 + var_24_17 + arg_24_0 then
				var_24_15.localPosition = Vector3.New(0, 100, 0)

				local var_24_22 = manager.ui.mainCamera.transform.position - var_24_15.position

				var_24_15.forward = Vector3.New(var_24_22.x, var_24_22.y, var_24_22.z)

				local var_24_23 = var_24_15.localEulerAngles

				var_24_23.z = 0
				var_24_23.x = 0
				var_24_15.localEulerAngles = var_24_23
			end

			local var_24_24 = arg_21_1.actors_["1076ui_story"]
			local var_24_25 = 0

			if var_24_25 < arg_21_1.time_ and arg_21_1.time_ <= var_24_25 + arg_24_0 and not isNil(var_24_24) and arg_21_1.var_.characterEffect1076ui_story == nil then
				arg_21_1.var_.characterEffect1076ui_story = var_24_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_26 = 0.200000002980232

			if var_24_25 <= arg_21_1.time_ and arg_21_1.time_ < var_24_25 + var_24_26 and not isNil(var_24_24) then
				local var_24_27 = (arg_21_1.time_ - var_24_25) / var_24_26

				if arg_21_1.var_.characterEffect1076ui_story and not isNil(var_24_24) then
					local var_24_28 = Mathf.Lerp(0, 0.5, var_24_27)

					arg_21_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1076ui_story.fillRatio = var_24_28
				end
			end

			if arg_21_1.time_ >= var_24_25 + var_24_26 and arg_21_1.time_ < var_24_25 + var_24_26 + arg_24_0 and not isNil(var_24_24) and arg_21_1.var_.characterEffect1076ui_story then
				local var_24_29 = 0.5

				arg_21_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1076ui_story.fillRatio = var_24_29
			end

			local var_24_30 = 0
			local var_24_31 = 0.433333333333333

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 then
				local var_24_32 = "play"
				local var_24_33 = "effect"

				arg_21_1:AudioAction(var_24_32, var_24_33, "se_story_16", "se_story_16_archery", "")
			end

			local var_24_34 = 0
			local var_24_35 = 0.625

			if var_24_34 < arg_21_1.time_ and arg_21_1.time_ <= var_24_34 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_36 = arg_21_1:GetWordFromCfg(121462005)
				local var_24_37 = arg_21_1:FormatText(var_24_36.content)

				arg_21_1.text_.text = var_24_37

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_38 = 25
				local var_24_39 = utf8.len(var_24_37)
				local var_24_40 = var_24_38 <= 0 and var_24_35 or var_24_35 * (var_24_39 / var_24_38)

				if var_24_40 > 0 and var_24_35 < var_24_40 then
					arg_21_1.talkMaxDuration = var_24_40

					if var_24_40 + var_24_34 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_40 + var_24_34
					end
				end

				arg_21_1.text_.text = var_24_37
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_41 = math.max(var_24_35, arg_21_1.talkMaxDuration)

			if var_24_34 <= arg_21_1.time_ and arg_21_1.time_ < var_24_34 + var_24_41 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_34) / var_24_41

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_34 + var_24_41 and arg_21_1.time_ < var_24_34 + var_24_41 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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

		arg_21_1:InitPlayNodeList()
	end,
	Play121462006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 121462006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play121462007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.433333333333333

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				local var_28_2 = "play"
				local var_28_3 = "effect"

				arg_25_1:AudioAction(var_28_2, var_28_3, "se_story_9", "se_story_9_black_fog02", "")
			end

			local var_28_4 = 0
			local var_28_5 = 1.25

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(121462006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_8 = 50
				local var_28_9 = utf8.len(var_28_7)
				local var_28_10 = var_28_8 <= 0 and var_28_5 or var_28_5 * (var_28_9 / var_28_8)

				if var_28_10 > 0 and var_28_5 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_11 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_11 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_11

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_11 and arg_25_1.time_ < var_28_4 + var_28_11 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play121462007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 121462007
		arg_29_1.duration_ = 7

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play121462008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_1 = 2

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_1 then
				local var_32_2 = (arg_29_1.time_ - var_32_0) / var_32_1
				local var_32_3 = Color.New(1, 1, 1)

				var_32_3.a = Mathf.Lerp(1, 0, var_32_2)
				arg_29_1.mask_.color = var_32_3
			end

			if arg_29_1.time_ >= var_32_0 + var_32_1 and arg_29_1.time_ < var_32_0 + var_32_1 + arg_32_0 then
				local var_32_4 = Color.New(1, 1, 1)
				local var_32_5 = 0

				arg_29_1.mask_.enabled = false
				var_32_4.a = var_32_5
				arg_29_1.mask_.color = var_32_4
			end

			local var_32_6 = manager.ui.mainCamera.transform
			local var_32_7 = 0.466666666666667

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.var_.shakeOldPos = var_32_6.localPosition
			end

			local var_32_8 = 1.099999

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_8 then
				local var_32_9 = (arg_29_1.time_ - var_32_7) / 0.066
				local var_32_10, var_32_11 = math.modf(var_32_9)

				var_32_6.localPosition = Vector3.New(var_32_11 * 0.13, var_32_11 * 0.13, var_32_11 * 0.13) + arg_29_1.var_.shakeOldPos
			end

			if arg_29_1.time_ >= var_32_7 + var_32_8 and arg_29_1.time_ < var_32_7 + var_32_8 + arg_32_0 then
				var_32_6.localPosition = arg_29_1.var_.shakeOldPos
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_12 = 2
			local var_32_13 = 0.875

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_14 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_14:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_15 = arg_29_1:GetWordFromCfg(121462007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 35
				local var_32_18 = utf8.len(var_32_16)
				local var_32_19 = var_32_17 <= 0 and var_32_13 or var_32_13 * (var_32_18 / var_32_17)

				if var_32_19 > 0 and var_32_13 < var_32_19 then
					arg_29_1.talkMaxDuration = var_32_19
					var_32_12 = var_32_12 + 0.3

					if var_32_19 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_16
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_20 = var_32_12 + 0.3
			local var_32_21 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_20 <= arg_29_1.time_ and arg_29_1.time_ < var_32_20 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_20) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_20 + var_32_21 and arg_29_1.time_ < var_32_20 + var_32_21 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play121462008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 121462008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play121462009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.25

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[7].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:GetWordFromCfg(121462008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 10
				local var_38_6 = utf8.len(var_38_4)
				local var_38_7 = var_38_5 <= 0 and var_38_1 or var_38_1 * (var_38_6 / var_38_5)

				if var_38_7 > 0 and var_38_1 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_8 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_8 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_8

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_8 and arg_35_1.time_ < var_38_0 + var_38_8 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play121462009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 121462009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play121462010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.9

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_2 = arg_39_1:GetWordFromCfg(121462009)
				local var_42_3 = arg_39_1:FormatText(var_42_2.content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 36
				local var_42_5 = utf8.len(var_42_3)
				local var_42_6 = var_42_4 <= 0 and var_42_1 or var_42_1 * (var_42_5 / var_42_4)

				if var_42_6 > 0 and var_42_1 < var_42_6 then
					arg_39_1.talkMaxDuration = var_42_6

					if var_42_6 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_7 and arg_39_1.time_ < var_42_0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play121462010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 121462010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play121462011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 1.075

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_2 = arg_43_1:GetWordFromCfg(121462010)
				local var_46_3 = arg_43_1:FormatText(var_46_2.content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 43
				local var_46_5 = utf8.len(var_46_3)
				local var_46_6 = var_46_4 <= 0 and var_46_1 or var_46_1 * (var_46_5 / var_46_4)

				if var_46_6 > 0 and var_46_1 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_7 and arg_43_1.time_ < var_46_0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play121462011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 121462011
		arg_47_1.duration_ = 5.67

		local var_47_0 = {
			ja = 4.466,
			ko = 5.666,
			zh = 5.666
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play121462012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1184ui_story"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos1184ui_story = var_50_0.localPosition
			end

			local var_50_2 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2
				local var_50_4 = Vector3.New(-0.7, -0.97, -6)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1184ui_story, var_50_4, var_50_3)

				local var_50_5 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_5.x, var_50_5.y, var_50_5.z)

				local var_50_6 = var_50_0.localEulerAngles

				var_50_6.z = 0
				var_50_6.x = 0
				var_50_0.localEulerAngles = var_50_6
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_50_7 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_7.x, var_50_7.y, var_50_7.z)

				local var_50_8 = var_50_0.localEulerAngles

				var_50_8.z = 0
				var_50_8.x = 0
				var_50_0.localEulerAngles = var_50_8
			end

			local var_50_9 = arg_47_1.actors_["1184ui_story"]
			local var_50_10 = 0

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 and not isNil(var_50_9) and arg_47_1.var_.characterEffect1184ui_story == nil then
				arg_47_1.var_.characterEffect1184ui_story = var_50_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_11 = 0.200000002980232

			if var_50_10 <= arg_47_1.time_ and arg_47_1.time_ < var_50_10 + var_50_11 and not isNil(var_50_9) then
				local var_50_12 = (arg_47_1.time_ - var_50_10) / var_50_11

				if arg_47_1.var_.characterEffect1184ui_story and not isNil(var_50_9) then
					arg_47_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_10 + var_50_11 and arg_47_1.time_ < var_50_10 + var_50_11 + arg_50_0 and not isNil(var_50_9) and arg_47_1.var_.characterEffect1184ui_story then
				arg_47_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_50_13 = 0

			if var_50_13 < arg_47_1.time_ and arg_47_1.time_ <= var_50_13 + arg_50_0 then
				arg_47_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_50_14 = 0

			if var_50_14 < arg_47_1.time_ and arg_47_1.time_ <= var_50_14 + arg_50_0 then
				arg_47_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_50_15 = arg_47_1.actors_["1076ui_story"].transform
			local var_50_16 = 0

			if var_50_16 < arg_47_1.time_ and arg_47_1.time_ <= var_50_16 + arg_50_0 then
				arg_47_1.var_.moveOldPos1076ui_story = var_50_15.localPosition
			end

			local var_50_17 = 0.001

			if var_50_16 <= arg_47_1.time_ and arg_47_1.time_ < var_50_16 + var_50_17 then
				local var_50_18 = (arg_47_1.time_ - var_50_16) / var_50_17
				local var_50_19 = Vector3.New(0.7, -1.06, -6.2)

				var_50_15.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1076ui_story, var_50_19, var_50_18)

				local var_50_20 = manager.ui.mainCamera.transform.position - var_50_15.position

				var_50_15.forward = Vector3.New(var_50_20.x, var_50_20.y, var_50_20.z)

				local var_50_21 = var_50_15.localEulerAngles

				var_50_21.z = 0
				var_50_21.x = 0
				var_50_15.localEulerAngles = var_50_21
			end

			if arg_47_1.time_ >= var_50_16 + var_50_17 and arg_47_1.time_ < var_50_16 + var_50_17 + arg_50_0 then
				var_50_15.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_50_22 = manager.ui.mainCamera.transform.position - var_50_15.position

				var_50_15.forward = Vector3.New(var_50_22.x, var_50_22.y, var_50_22.z)

				local var_50_23 = var_50_15.localEulerAngles

				var_50_23.z = 0
				var_50_23.x = 0
				var_50_15.localEulerAngles = var_50_23
			end

			local var_50_24 = arg_47_1.actors_["1076ui_story"]
			local var_50_25 = 0

			if var_50_25 < arg_47_1.time_ and arg_47_1.time_ <= var_50_25 + arg_50_0 and not isNil(var_50_24) and arg_47_1.var_.characterEffect1076ui_story == nil then
				arg_47_1.var_.characterEffect1076ui_story = var_50_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_26 = 0.200000002980232

			if var_50_25 <= arg_47_1.time_ and arg_47_1.time_ < var_50_25 + var_50_26 and not isNil(var_50_24) then
				local var_50_27 = (arg_47_1.time_ - var_50_25) / var_50_26

				if arg_47_1.var_.characterEffect1076ui_story and not isNil(var_50_24) then
					local var_50_28 = Mathf.Lerp(0, 0.5, var_50_27)

					arg_47_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1076ui_story.fillRatio = var_50_28
				end
			end

			if arg_47_1.time_ >= var_50_25 + var_50_26 and arg_47_1.time_ < var_50_25 + var_50_26 + arg_50_0 and not isNil(var_50_24) and arg_47_1.var_.characterEffect1076ui_story then
				local var_50_29 = 0.5

				arg_47_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1076ui_story.fillRatio = var_50_29
			end

			local var_50_30 = 0

			if var_50_30 < arg_47_1.time_ and arg_47_1.time_ <= var_50_30 + arg_50_0 then
				arg_47_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_50_31 = 0
			local var_50_32 = 0.5

			if var_50_31 < arg_47_1.time_ and arg_47_1.time_ <= var_50_31 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_33 = arg_47_1:FormatText(StoryNameCfg[6].name)

				arg_47_1.leftNameTxt_.text = var_50_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_34 = arg_47_1:GetWordFromCfg(121462011)
				local var_50_35 = arg_47_1:FormatText(var_50_34.content)

				arg_47_1.text_.text = var_50_35

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_36 = 20
				local var_50_37 = utf8.len(var_50_35)
				local var_50_38 = var_50_36 <= 0 and var_50_32 or var_50_32 * (var_50_37 / var_50_36)

				if var_50_38 > 0 and var_50_32 < var_50_38 then
					arg_47_1.talkMaxDuration = var_50_38

					if var_50_38 + var_50_31 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_38 + var_50_31
					end
				end

				arg_47_1.text_.text = var_50_35
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462011", "story_v_out_121462.awb") ~= 0 then
					local var_50_39 = manager.audio:GetVoiceLength("story_v_out_121462", "121462011", "story_v_out_121462.awb") / 1000

					if var_50_39 + var_50_31 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_39 + var_50_31
					end

					if var_50_34.prefab_name ~= "" and arg_47_1.actors_[var_50_34.prefab_name] ~= nil then
						local var_50_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_34.prefab_name].transform, "story_v_out_121462", "121462011", "story_v_out_121462.awb")

						arg_47_1:RecordAudio("121462011", var_50_40)
						arg_47_1:RecordAudio("121462011", var_50_40)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_121462", "121462011", "story_v_out_121462.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_121462", "121462011", "story_v_out_121462.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_41 = math.max(var_50_32, arg_47_1.talkMaxDuration)

			if var_50_31 <= arg_47_1.time_ and arg_47_1.time_ < var_50_31 + var_50_41 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_31) / var_50_41

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_31 + var_50_41 and arg_47_1.time_ < var_50_31 + var_50_41 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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

		arg_47_1:InitPlayNodeList()
	end,
	Play121462012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 121462012
		arg_51_1.duration_ = 8.3

		local var_51_0 = {
			ja = 8.3,
			ko = 5.9,
			zh = 5.9
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
				arg_51_0:Play121462013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1184ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1184ui_story == nil then
				arg_51_1.var_.characterEffect1184ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect1184ui_story and not isNil(var_54_0) then
					local var_54_4 = Mathf.Lerp(0, 0.5, var_54_3)

					arg_51_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1184ui_story.fillRatio = var_54_4
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1184ui_story then
				local var_54_5 = 0.5

				arg_51_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1184ui_story.fillRatio = var_54_5
			end

			local var_54_6 = arg_51_1.actors_["1076ui_story"]
			local var_54_7 = 0

			if var_54_7 < arg_51_1.time_ and arg_51_1.time_ <= var_54_7 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect1076ui_story == nil then
				arg_51_1.var_.characterEffect1076ui_story = var_54_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_8 = 0.200000002980232

			if var_54_7 <= arg_51_1.time_ and arg_51_1.time_ < var_54_7 + var_54_8 and not isNil(var_54_6) then
				local var_54_9 = (arg_51_1.time_ - var_54_7) / var_54_8

				if arg_51_1.var_.characterEffect1076ui_story and not isNil(var_54_6) then
					arg_51_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_7 + var_54_8 and arg_51_1.time_ < var_54_7 + var_54_8 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect1076ui_story then
				arg_51_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_54_10 = 0
			local var_54_11 = 0.45

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_12 = arg_51_1:FormatText(StoryNameCfg[389].name)

				arg_51_1.leftNameTxt_.text = var_54_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_13 = arg_51_1:GetWordFromCfg(121462012)
				local var_54_14 = arg_51_1:FormatText(var_54_13.content)

				arg_51_1.text_.text = var_54_14

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_15 = 18
				local var_54_16 = utf8.len(var_54_14)
				local var_54_17 = var_54_15 <= 0 and var_54_11 or var_54_11 * (var_54_16 / var_54_15)

				if var_54_17 > 0 and var_54_11 < var_54_17 then
					arg_51_1.talkMaxDuration = var_54_17

					if var_54_17 + var_54_10 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_17 + var_54_10
					end
				end

				arg_51_1.text_.text = var_54_14
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462012", "story_v_out_121462.awb") ~= 0 then
					local var_54_18 = manager.audio:GetVoiceLength("story_v_out_121462", "121462012", "story_v_out_121462.awb") / 1000

					if var_54_18 + var_54_10 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_18 + var_54_10
					end

					if var_54_13.prefab_name ~= "" and arg_51_1.actors_[var_54_13.prefab_name] ~= nil then
						local var_54_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_13.prefab_name].transform, "story_v_out_121462", "121462012", "story_v_out_121462.awb")

						arg_51_1:RecordAudio("121462012", var_54_19)
						arg_51_1:RecordAudio("121462012", var_54_19)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_121462", "121462012", "story_v_out_121462.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_121462", "121462012", "story_v_out_121462.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_20 = math.max(var_54_11, arg_51_1.talkMaxDuration)

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_20 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_10) / var_54_20

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_10 + var_54_20 and arg_51_1.time_ < var_54_10 + var_54_20 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play121462013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 121462013
		arg_55_1.duration_ = 5.37

		local var_55_0 = {
			ja = 5.366,
			ko = 2.7,
			zh = 2.7
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
				arg_55_0:Play121462014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.6

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[389].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_3 = arg_55_1:GetWordFromCfg(121462013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 24
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462013", "story_v_out_121462.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_121462", "121462013", "story_v_out_121462.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_121462", "121462013", "story_v_out_121462.awb")

						arg_55_1:RecordAudio("121462013", var_58_9)
						arg_55_1:RecordAudio("121462013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_121462", "121462013", "story_v_out_121462.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_121462", "121462013", "story_v_out_121462.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_10 and arg_55_1.time_ < var_58_0 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play121462014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 121462014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play121462015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1076ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1076ui_story == nil then
				arg_59_1.var_.characterEffect1076ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1076ui_story and not isNil(var_62_0) then
					local var_62_4 = Mathf.Lerp(0, 0.5, var_62_3)

					arg_59_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1076ui_story.fillRatio = var_62_4
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1076ui_story then
				local var_62_5 = 0.5

				arg_59_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1076ui_story.fillRatio = var_62_5
			end

			local var_62_6 = 0
			local var_62_7 = 0.475

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_8 = arg_59_1:FormatText(StoryNameCfg[7].name)

				arg_59_1.leftNameTxt_.text = var_62_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_9 = arg_59_1:GetWordFromCfg(121462014)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 19
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
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_14 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_14 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_14

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_14 and arg_59_1.time_ < var_62_6 + var_62_14 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play121462015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 121462015
		arg_63_1.duration_ = 14.6

		local var_63_0 = {
			ja = 14.6,
			ko = 8.4,
			zh = 8.4
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
				arg_63_0:Play121462016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.7

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[10].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(121462015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 28
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462015", "story_v_out_121462.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_121462", "121462015", "story_v_out_121462.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_121462", "121462015", "story_v_out_121462.awb")

						arg_63_1:RecordAudio("121462015", var_66_9)
						arg_63_1:RecordAudio("121462015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_121462", "121462015", "story_v_out_121462.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_121462", "121462015", "story_v_out_121462.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_10 and arg_63_1.time_ < var_66_0 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play121462016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 121462016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play121462017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.725

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_2 = arg_67_1:GetWordFromCfg(121462016)
				local var_70_3 = arg_67_1:FormatText(var_70_2.content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 29
				local var_70_5 = utf8.len(var_70_3)
				local var_70_6 = var_70_4 <= 0 and var_70_1 or var_70_1 * (var_70_5 / var_70_4)

				if var_70_6 > 0 and var_70_1 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_7 and arg_67_1.time_ < var_70_0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play121462017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 121462017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play121462018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 1.075

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

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:GetWordFromCfg(121462017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 43
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
	Play121462018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 121462018
		arg_75_1.duration_ = 10.1

		local var_75_0 = {
			ja = 10.1,
			ko = 7.733,
			zh = 7.733
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play121462019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1184ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1184ui_story == nil then
				arg_75_1.var_.characterEffect1184ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1184ui_story and not isNil(var_78_0) then
					arg_75_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1184ui_story then
				arg_75_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_78_4 = 0

			if var_78_4 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_78_5 = 0

			if var_78_5 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_78_6 = 0
			local var_78_7 = 0.875

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_8 = arg_75_1:FormatText(StoryNameCfg[6].name)

				arg_75_1.leftNameTxt_.text = var_78_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_9 = arg_75_1:GetWordFromCfg(121462018)
				local var_78_10 = arg_75_1:FormatText(var_78_9.content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_11 = 35
				local var_78_12 = utf8.len(var_78_10)
				local var_78_13 = var_78_11 <= 0 and var_78_7 or var_78_7 * (var_78_12 / var_78_11)

				if var_78_13 > 0 and var_78_7 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462018", "story_v_out_121462.awb") ~= 0 then
					local var_78_14 = manager.audio:GetVoiceLength("story_v_out_121462", "121462018", "story_v_out_121462.awb") / 1000

					if var_78_14 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_6
					end

					if var_78_9.prefab_name ~= "" and arg_75_1.actors_[var_78_9.prefab_name] ~= nil then
						local var_78_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_9.prefab_name].transform, "story_v_out_121462", "121462018", "story_v_out_121462.awb")

						arg_75_1:RecordAudio("121462018", var_78_15)
						arg_75_1:RecordAudio("121462018", var_78_15)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_121462", "121462018", "story_v_out_121462.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_121462", "121462018", "story_v_out_121462.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_16 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_16 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_16

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_16 and arg_75_1.time_ < var_78_6 + var_78_16 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play121462019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 121462019
		arg_79_1.duration_ = 11.77

		local var_79_0 = {
			ja = 11.766,
			ko = 7.133,
			zh = 7.133
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play121462020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.9

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[6].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:GetWordFromCfg(121462019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 36
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462019", "story_v_out_121462.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_121462", "121462019", "story_v_out_121462.awb") / 1000

					if var_82_8 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_0
					end

					if var_82_3.prefab_name ~= "" and arg_79_1.actors_[var_82_3.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_3.prefab_name].transform, "story_v_out_121462", "121462019", "story_v_out_121462.awb")

						arg_79_1:RecordAudio("121462019", var_82_9)
						arg_79_1:RecordAudio("121462019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_121462", "121462019", "story_v_out_121462.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_121462", "121462019", "story_v_out_121462.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_10 and arg_79_1.time_ < var_82_0 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play121462020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 121462020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play121462021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1184ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1184ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, 100, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1184ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, 100, 0)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = arg_83_1.actors_["1184ui_story"]
			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 and not isNil(var_86_9) and arg_83_1.var_.characterEffect1184ui_story == nil then
				arg_83_1.var_.characterEffect1184ui_story = var_86_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_11 = 0.200000002980232

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_11 and not isNil(var_86_9) then
				local var_86_12 = (arg_83_1.time_ - var_86_10) / var_86_11

				if arg_83_1.var_.characterEffect1184ui_story and not isNil(var_86_9) then
					local var_86_13 = Mathf.Lerp(0, 0.5, var_86_12)

					arg_83_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1184ui_story.fillRatio = var_86_13
				end
			end

			if arg_83_1.time_ >= var_86_10 + var_86_11 and arg_83_1.time_ < var_86_10 + var_86_11 + arg_86_0 and not isNil(var_86_9) and arg_83_1.var_.characterEffect1184ui_story then
				local var_86_14 = 0.5

				arg_83_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1184ui_story.fillRatio = var_86_14
			end

			local var_86_15 = arg_83_1.actors_["1076ui_story"].transform
			local var_86_16 = 0

			if var_86_16 < arg_83_1.time_ and arg_83_1.time_ <= var_86_16 + arg_86_0 then
				arg_83_1.var_.moveOldPos1076ui_story = var_86_15.localPosition
			end

			local var_86_17 = 0.001

			if var_86_16 <= arg_83_1.time_ and arg_83_1.time_ < var_86_16 + var_86_17 then
				local var_86_18 = (arg_83_1.time_ - var_86_16) / var_86_17
				local var_86_19 = Vector3.New(0, 100, 0)

				var_86_15.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1076ui_story, var_86_19, var_86_18)

				local var_86_20 = manager.ui.mainCamera.transform.position - var_86_15.position

				var_86_15.forward = Vector3.New(var_86_20.x, var_86_20.y, var_86_20.z)

				local var_86_21 = var_86_15.localEulerAngles

				var_86_21.z = 0
				var_86_21.x = 0
				var_86_15.localEulerAngles = var_86_21
			end

			if arg_83_1.time_ >= var_86_16 + var_86_17 and arg_83_1.time_ < var_86_16 + var_86_17 + arg_86_0 then
				var_86_15.localPosition = Vector3.New(0, 100, 0)

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
			local var_86_31 = 0.975

			if var_86_30 < arg_83_1.time_ and arg_83_1.time_ <= var_86_30 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_32 = arg_83_1:GetWordFromCfg(121462020)
				local var_86_33 = arg_83_1:FormatText(var_86_32.content)

				arg_83_1.text_.text = var_86_33

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_34 = 39
				local var_86_35 = utf8.len(var_86_33)
				local var_86_36 = var_86_34 <= 0 and var_86_31 or var_86_31 * (var_86_35 / var_86_34)

				if var_86_36 > 0 and var_86_31 < var_86_36 then
					arg_83_1.talkMaxDuration = var_86_36

					if var_86_36 + var_86_30 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_36 + var_86_30
					end
				end

				arg_83_1.text_.text = var_86_33
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_37 = math.max(var_86_31, arg_83_1.talkMaxDuration)

			if var_86_30 <= arg_83_1.time_ and arg_83_1.time_ < var_86_30 + var_86_37 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_30) / var_86_37

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_30 + var_86_37 and arg_83_1.time_ < var_86_30 + var_86_37 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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
	Play121462021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 121462021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play121462022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 1.425

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_2 = arg_87_1:GetWordFromCfg(121462021)
				local var_90_3 = arg_87_1:FormatText(var_90_2.content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 57
				local var_90_5 = utf8.len(var_90_3)
				local var_90_6 = var_90_4 <= 0 and var_90_1 or var_90_1 * (var_90_5 / var_90_4)

				if var_90_6 > 0 and var_90_1 < var_90_6 then
					arg_87_1.talkMaxDuration = var_90_6

					if var_90_6 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_6 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_7 and arg_87_1.time_ < var_90_0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play121462022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 121462022
		arg_91_1.duration_ = 5.57

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play121462023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = "STblack"

			if arg_91_1.bgs_[var_94_0] == nil then
				local var_94_1 = Object.Instantiate(arg_91_1.paintGo_)

				var_94_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_94_0)
				var_94_1.name = var_94_0
				var_94_1.transform.parent = arg_91_1.stage_.transform
				var_94_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.bgs_[var_94_0] = var_94_1
			end

			local var_94_2 = 2

			if var_94_2 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				local var_94_3 = manager.ui.mainCamera.transform.localPosition
				local var_94_4 = Vector3.New(0, 0, 10) + Vector3.New(var_94_3.x, var_94_3.y, 0)
				local var_94_5 = arg_91_1.bgs_.STblack

				var_94_5.transform.localPosition = var_94_4
				var_94_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_6 = var_94_5:GetComponent("SpriteRenderer")

				if var_94_6 and var_94_6.sprite then
					local var_94_7 = (var_94_5.transform.localPosition - var_94_3).z
					local var_94_8 = manager.ui.mainCameraCom_
					local var_94_9 = 2 * var_94_7 * Mathf.Tan(var_94_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_94_10 = var_94_9 * var_94_8.aspect
					local var_94_11 = var_94_6.sprite.bounds.size.x
					local var_94_12 = var_94_6.sprite.bounds.size.y
					local var_94_13 = var_94_10 / var_94_11
					local var_94_14 = var_94_9 / var_94_12
					local var_94_15 = var_94_14 < var_94_13 and var_94_13 or var_94_14

					var_94_5.transform.localScale = Vector3.New(var_94_15, var_94_15, 0)
				end

				for iter_94_0, iter_94_1 in pairs(arg_91_1.bgs_) do
					if iter_94_0 ~= "STblack" then
						iter_94_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_94_16 = 0

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_17 = 2

			if var_94_16 <= arg_91_1.time_ and arg_91_1.time_ < var_94_16 + var_94_17 then
				local var_94_18 = (arg_91_1.time_ - var_94_16) / var_94_17
				local var_94_19 = Color.New(0, 0, 0)

				var_94_19.a = Mathf.Lerp(0, 1, var_94_18)
				arg_91_1.mask_.color = var_94_19
			end

			if arg_91_1.time_ >= var_94_16 + var_94_17 and arg_91_1.time_ < var_94_16 + var_94_17 + arg_94_0 then
				local var_94_20 = Color.New(0, 0, 0)

				var_94_20.a = 1
				arg_91_1.mask_.color = var_94_20
			end

			local var_94_21 = 2

			if var_94_21 < arg_91_1.time_ and arg_91_1.time_ <= var_94_21 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_22 = 2

			if var_94_21 <= arg_91_1.time_ and arg_91_1.time_ < var_94_21 + var_94_22 then
				local var_94_23 = (arg_91_1.time_ - var_94_21) / var_94_22
				local var_94_24 = Color.New(0, 0, 0)

				var_94_24.a = Mathf.Lerp(1, 0, var_94_23)
				arg_91_1.mask_.color = var_94_24
			end

			if arg_91_1.time_ >= var_94_21 + var_94_22 and arg_91_1.time_ < var_94_21 + var_94_22 + arg_94_0 then
				local var_94_25 = Color.New(0, 0, 0)
				local var_94_26 = 0

				arg_91_1.mask_.enabled = false
				var_94_25.a = var_94_26
				arg_91_1.mask_.color = var_94_25
			end

			local var_94_27 = 2

			if var_94_27 < arg_91_1.time_ and arg_91_1.time_ <= var_94_27 + arg_94_0 then
				arg_91_1.fswbg_:SetActive(true)
				arg_91_1.dialog_:SetActive(false)

				arg_91_1.fswtw_.percent = 0

				local var_94_28 = arg_91_1:GetWordFromCfg(121462022)
				local var_94_29 = arg_91_1:FormatText(var_94_28.content)

				arg_91_1.fswt_.text = var_94_29

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.fswt_)

				arg_91_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_91_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_91_1.fswtw_:SetDirty()

				arg_91_1.typewritterCharCountI18N = 0

				SetActive(arg_91_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_91_1:ShowNextGo(false)
			end

			local var_94_30 = 2.01666666666667

			if var_94_30 < arg_91_1.time_ and arg_91_1.time_ <= var_94_30 + arg_94_0 then
				arg_91_1.var_.oldValueTypewriter = arg_91_1.fswtw_.percent

				SetActive(arg_91_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_91_1:ShowNextGo(false)
			end

			local var_94_31 = 49
			local var_94_32 = 3.26666666666667
			local var_94_33 = arg_91_1:GetWordFromCfg(121462022)
			local var_94_34 = arg_91_1:FormatText(var_94_33.content)
			local var_94_35, var_94_36 = arg_91_1:GetPercentByPara(var_94_34, 1)

			if var_94_30 < arg_91_1.time_ and arg_91_1.time_ <= var_94_30 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				local var_94_37 = var_94_31 <= 0 and var_94_32 or var_94_32 * ((var_94_36 - arg_91_1.typewritterCharCountI18N) / var_94_31)

				if var_94_37 > 0 and var_94_32 < var_94_37 then
					arg_91_1.talkMaxDuration = var_94_37

					if var_94_37 + var_94_30 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_37 + var_94_30
					end
				end
			end

			local var_94_38 = 3.26666666666667
			local var_94_39 = math.max(var_94_38, arg_91_1.talkMaxDuration)

			if var_94_30 <= arg_91_1.time_ and arg_91_1.time_ < var_94_30 + var_94_39 then
				local var_94_40 = (arg_91_1.time_ - var_94_30) / var_94_39

				arg_91_1.fswtw_.percent = Mathf.Lerp(arg_91_1.var_.oldValueTypewriter, var_94_35, var_94_40)
				arg_91_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_91_1.fswtw_:SetDirty()
			end

			if arg_91_1.time_ >= var_94_30 + var_94_39 and arg_91_1.time_ < var_94_30 + var_94_39 + arg_94_0 then
				arg_91_1.fswtw_.percent = var_94_35

				arg_91_1.fswtw_:SetDirty()
				arg_91_1:ShowNextGo(true)

				arg_91_1.typewritterCharCountI18N = var_94_36
			end

			local var_94_41 = 2

			if var_94_41 < arg_91_1.time_ and arg_91_1.time_ <= var_94_41 + arg_94_0 then
				local var_94_42 = arg_91_1.fswbg_.transform:Find("textbox/adapt/content") or arg_91_1.fswbg_.transform:Find("textbox/content")
				local var_94_43 = arg_91_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_94_44 = var_94_42:GetComponent("Text")
				local var_94_45 = var_94_42:GetComponent("RectTransform")

				var_94_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_94_45.offsetMin = Vector2.New(0, 0)
				var_94_45.offsetMax = Vector2.New(0, 0)
			end

			local var_94_46 = 1.6
			local var_94_47 = 1

			if var_94_46 < arg_91_1.time_ and arg_91_1.time_ <= var_94_46 + arg_94_0 then
				local var_94_48 = "play"
				local var_94_49 = "effect"

				arg_91_1:AudioAction(var_94_48, var_94_49, "se_story_121_04", "se_story_121_04_wind_loop", "")
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play121462023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 121462023
		arg_95_1.duration_ = 9

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play121462024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = "XH0303"

			if arg_95_1.bgs_[var_98_0] == nil then
				local var_98_1 = Object.Instantiate(arg_95_1.paintGo_)

				var_98_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_98_0)
				var_98_1.name = var_98_0
				var_98_1.transform.parent = arg_95_1.stage_.transform
				var_98_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.bgs_[var_98_0] = var_98_1
			end

			local var_98_2 = 2

			if var_98_2 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				local var_98_3 = manager.ui.mainCamera.transform.localPosition
				local var_98_4 = Vector3.New(0, 0, 10) + Vector3.New(var_98_3.x, var_98_3.y, 0)
				local var_98_5 = arg_95_1.bgs_.XH0303

				var_98_5.transform.localPosition = var_98_4
				var_98_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_6 = var_98_5:GetComponent("SpriteRenderer")

				if var_98_6 and var_98_6.sprite then
					local var_98_7 = (var_98_5.transform.localPosition - var_98_3).z
					local var_98_8 = manager.ui.mainCameraCom_
					local var_98_9 = 2 * var_98_7 * Mathf.Tan(var_98_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_98_10 = var_98_9 * var_98_8.aspect
					local var_98_11 = var_98_6.sprite.bounds.size.x
					local var_98_12 = var_98_6.sprite.bounds.size.y
					local var_98_13 = var_98_10 / var_98_11
					local var_98_14 = var_98_9 / var_98_12
					local var_98_15 = var_98_14 < var_98_13 and var_98_13 or var_98_14

					var_98_5.transform.localScale = Vector3.New(var_98_15, var_98_15, 0)
				end

				for iter_98_0, iter_98_1 in pairs(arg_95_1.bgs_) do
					if iter_98_0 ~= "XH0303" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_16 = 0

			if var_98_16 < arg_95_1.time_ and arg_95_1.time_ <= var_98_16 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_17 = 2

			if var_98_16 <= arg_95_1.time_ and arg_95_1.time_ < var_98_16 + var_98_17 then
				local var_98_18 = (arg_95_1.time_ - var_98_16) / var_98_17
				local var_98_19 = Color.New(0, 0, 0)

				var_98_19.a = Mathf.Lerp(0, 1, var_98_18)
				arg_95_1.mask_.color = var_98_19
			end

			if arg_95_1.time_ >= var_98_16 + var_98_17 and arg_95_1.time_ < var_98_16 + var_98_17 + arg_98_0 then
				local var_98_20 = Color.New(0, 0, 0)

				var_98_20.a = 1
				arg_95_1.mask_.color = var_98_20
			end

			local var_98_21 = 2

			if var_98_21 < arg_95_1.time_ and arg_95_1.time_ <= var_98_21 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_22 = 2

			if var_98_21 <= arg_95_1.time_ and arg_95_1.time_ < var_98_21 + var_98_22 then
				local var_98_23 = (arg_95_1.time_ - var_98_21) / var_98_22
				local var_98_24 = Color.New(0, 0, 0)

				var_98_24.a = Mathf.Lerp(1, 0, var_98_23)
				arg_95_1.mask_.color = var_98_24
			end

			if arg_95_1.time_ >= var_98_21 + var_98_22 and arg_95_1.time_ < var_98_21 + var_98_22 + arg_98_0 then
				local var_98_25 = Color.New(0, 0, 0)
				local var_98_26 = 0

				arg_95_1.mask_.enabled = false
				var_98_25.a = var_98_26
				arg_95_1.mask_.color = var_98_25
			end

			local var_98_27 = 1.98333333333333

			if var_98_27 < arg_95_1.time_ and arg_95_1.time_ <= var_98_27 + arg_98_0 then
				arg_95_1.fswbg_:SetActive(false)
				arg_95_1.dialog_:SetActive(false)
				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_28 = arg_95_1.bgs_.XH0303.transform
			local var_98_29 = 2

			if var_98_29 < arg_95_1.time_ and arg_95_1.time_ <= var_98_29 + arg_98_0 then
				arg_95_1.var_.moveOldPosXH0303 = var_98_28.localPosition
			end

			local var_98_30 = 0.001

			if var_98_29 <= arg_95_1.time_ and arg_95_1.time_ < var_98_29 + var_98_30 then
				local var_98_31 = (arg_95_1.time_ - var_98_29) / var_98_30
				local var_98_32 = Vector3.New(0, 1, 9)

				var_98_28.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPosXH0303, var_98_32, var_98_31)
			end

			if arg_95_1.time_ >= var_98_29 + var_98_30 and arg_95_1.time_ < var_98_29 + var_98_30 + arg_98_0 then
				var_98_28.localPosition = Vector3.New(0, 1, 9)
			end

			local var_98_33 = arg_95_1.bgs_.XH0303.transform
			local var_98_34 = 2.01666666666667

			if var_98_34 < arg_95_1.time_ and arg_95_1.time_ <= var_98_34 + arg_98_0 then
				arg_95_1.var_.moveOldPosXH0303 = var_98_33.localPosition
			end

			local var_98_35 = 3.98333333333333

			if var_98_34 <= arg_95_1.time_ and arg_95_1.time_ < var_98_34 + var_98_35 then
				local var_98_36 = (arg_95_1.time_ - var_98_34) / var_98_35
				local var_98_37 = Vector3.New(0, 1, 10)

				var_98_33.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPosXH0303, var_98_37, var_98_36)
			end

			if arg_95_1.time_ >= var_98_34 + var_98_35 and arg_95_1.time_ < var_98_34 + var_98_35 + arg_98_0 then
				var_98_33.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_38 = 4
			local var_98_39 = 0.45

			if var_98_38 < arg_95_1.time_ and arg_95_1.time_ <= var_98_38 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_40 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_40:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_41 = arg_95_1:GetWordFromCfg(121462023)
				local var_98_42 = arg_95_1:FormatText(var_98_41.content)

				arg_95_1.text_.text = var_98_42

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_43 = 18
				local var_98_44 = utf8.len(var_98_42)
				local var_98_45 = var_98_43 <= 0 and var_98_39 or var_98_39 * (var_98_44 / var_98_43)

				if var_98_45 > 0 and var_98_39 < var_98_45 then
					arg_95_1.talkMaxDuration = var_98_45
					var_98_38 = var_98_38 + 0.3

					if var_98_45 + var_98_38 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_45 + var_98_38
					end
				end

				arg_95_1.text_.text = var_98_42
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_46 = var_98_38 + 0.3
			local var_98_47 = math.max(var_98_39, arg_95_1.talkMaxDuration)

			if var_98_46 <= arg_95_1.time_ and arg_95_1.time_ < var_98_46 + var_98_47 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_46) / var_98_47

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_46 + var_98_47 and arg_95_1.time_ < var_98_46 + var_98_47 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0303",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0303",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.98333333333333,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play121462024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 121462024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play121462025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.15

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(121462024)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 46
				local var_104_5 = utf8.len(var_104_3)
				local var_104_6 = var_104_4 <= 0 and var_104_1 or var_104_1 * (var_104_5 / var_104_4)

				if var_104_6 > 0 and var_104_1 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_7 and arg_101_1.time_ < var_104_0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play121462025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 121462025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play121462026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 1.3

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(121462025)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 52
				local var_108_5 = utf8.len(var_108_3)
				local var_108_6 = var_108_4 <= 0 and var_108_1 or var_108_1 * (var_108_5 / var_108_4)

				if var_108_6 > 0 and var_108_1 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_7 and arg_105_1.time_ < var_108_0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play121462026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 121462026
		arg_109_1.duration_ = 13.6

		local var_109_0 = {
			ja = 10.966,
			ko = 13.6,
			zh = 13.6
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
				arg_109_0:Play121462027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.7

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[389].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(121462026)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462026", "story_v_out_121462.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_121462", "121462026", "story_v_out_121462.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_121462", "121462026", "story_v_out_121462.awb")

						arg_109_1:RecordAudio("121462026", var_112_9)
						arg_109_1:RecordAudio("121462026", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_121462", "121462026", "story_v_out_121462.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_121462", "121462026", "story_v_out_121462.awb")
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
	Play121462027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 121462027
		arg_113_1.duration_ = 15.33

		local var_113_0 = {
			ja = 15.333,
			ko = 11.066,
			zh = 11.066
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
				arg_113_0:Play121462028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.7

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[389].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(121462027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462027", "story_v_out_121462.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_121462", "121462027", "story_v_out_121462.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_121462", "121462027", "story_v_out_121462.awb")

						arg_113_1:RecordAudio("121462027", var_116_9)
						arg_113_1:RecordAudio("121462027", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_121462", "121462027", "story_v_out_121462.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_121462", "121462027", "story_v_out_121462.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play121462028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 121462028
		arg_117_1.duration_ = 13.43

		local var_117_0 = {
			ja = 13.433,
			ko = 11.466,
			zh = 11.466
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
				arg_117_0:Play121462029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.7

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[389].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(121462028)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462028", "story_v_out_121462.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_121462", "121462028", "story_v_out_121462.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_121462", "121462028", "story_v_out_121462.awb")

						arg_117_1:RecordAudio("121462028", var_120_9)
						arg_117_1:RecordAudio("121462028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_121462", "121462028", "story_v_out_121462.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_121462", "121462028", "story_v_out_121462.awb")
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
	Play121462029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 121462029
		arg_121_1.duration_ = 14.97

		local var_121_0 = {
			ja = 14.966,
			ko = 14.433,
			zh = 14.433
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
				arg_121_0:Play121462030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.7

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[389].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:GetWordFromCfg(121462029)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462029", "story_v_out_121462.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_out_121462", "121462029", "story_v_out_121462.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_121462", "121462029", "story_v_out_121462.awb")

						arg_121_1:RecordAudio("121462029", var_124_9)
						arg_121_1:RecordAudio("121462029", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_121462", "121462029", "story_v_out_121462.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_121462", "121462029", "story_v_out_121462.awb")
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
	Play121462030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 121462030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play121462031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.875

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(121462030)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 35
				local var_128_5 = utf8.len(var_128_3)
				local var_128_6 = var_128_4 <= 0 and var_128_1 or var_128_1 * (var_128_5 / var_128_4)

				if var_128_6 > 0 and var_128_1 < var_128_6 then
					arg_125_1.talkMaxDuration = var_128_6

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_7 and arg_125_1.time_ < var_128_0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play121462031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 121462031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play121462032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.425

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

				local var_132_2 = arg_129_1:GetWordFromCfg(121462031)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 17
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
	Play121462032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 121462032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play121462033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.875

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[7].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:GetWordFromCfg(121462032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 35
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
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_8 and arg_133_1.time_ < var_136_0 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play121462033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 121462033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play121462034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.575

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_2

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

				local var_140_3 = arg_137_1:GetWordFromCfg(121462033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 23
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
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play121462034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 121462034
		arg_141_1.duration_ = 2.7

		local var_141_0 = {
			ja = 2.7,
			ko = 1.1,
			zh = 1.1
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
				arg_141_0:Play121462035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.1

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[389].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(121462034)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 4
				local var_144_6 = utf8.len(var_144_4)
				local var_144_7 = var_144_5 <= 0 and var_144_1 or var_144_1 * (var_144_6 / var_144_5)

				if var_144_7 > 0 and var_144_1 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462034", "story_v_out_121462.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_121462", "121462034", "story_v_out_121462.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_121462", "121462034", "story_v_out_121462.awb")

						arg_141_1:RecordAudio("121462034", var_144_9)
						arg_141_1:RecordAudio("121462034", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_121462", "121462034", "story_v_out_121462.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_121462", "121462034", "story_v_out_121462.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_10 and arg_141_1.time_ < var_144_0 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play121462035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 121462035
		arg_145_1.duration_ = 9.13

		local var_145_0 = {
			ja = 9.133,
			ko = 8.533,
			zh = 8.533
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play121462036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.75

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[389].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(121462035)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462035", "story_v_out_121462.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_121462", "121462035", "story_v_out_121462.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_121462", "121462035", "story_v_out_121462.awb")

						arg_145_1:RecordAudio("121462035", var_148_9)
						arg_145_1:RecordAudio("121462035", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_121462", "121462035", "story_v_out_121462.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_121462", "121462035", "story_v_out_121462.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play121462036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 121462036
		arg_149_1.duration_ = 7.87

		local var_149_0 = {
			ja = 7.866,
			ko = 5.266,
			zh = 5.266
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
				arg_149_0:Play121462037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.425

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[389].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(121462036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462036", "story_v_out_121462.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_121462", "121462036", "story_v_out_121462.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_121462", "121462036", "story_v_out_121462.awb")

						arg_149_1:RecordAudio("121462036", var_152_9)
						arg_149_1:RecordAudio("121462036", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_121462", "121462036", "story_v_out_121462.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_121462", "121462036", "story_v_out_121462.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_10 and arg_149_1.time_ < var_152_0 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play121462037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 121462037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play121462038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.825

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[7].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(121462037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 33
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
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_8 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_8 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_8

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_8 and arg_153_1.time_ < var_156_0 + var_156_8 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play121462038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 121462038
		arg_157_1.duration_ = 2.83

		local var_157_0 = {
			ja = 2.833,
			ko = 1.2,
			zh = 1.2
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
				arg_157_0:Play121462039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.1

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[389].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(121462038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462038", "story_v_out_121462.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_121462", "121462038", "story_v_out_121462.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_121462", "121462038", "story_v_out_121462.awb")

						arg_157_1:RecordAudio("121462038", var_160_9)
						arg_157_1:RecordAudio("121462038", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_121462", "121462038", "story_v_out_121462.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_121462", "121462038", "story_v_out_121462.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_10 and arg_157_1.time_ < var_160_0 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play121462039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 121462039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play121462040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.6

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_2 = arg_161_1:GetWordFromCfg(121462039)
				local var_164_3 = arg_161_1:FormatText(var_164_2.content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 24
				local var_164_5 = utf8.len(var_164_3)
				local var_164_6 = var_164_4 <= 0 and var_164_1 or var_164_1 * (var_164_5 / var_164_4)

				if var_164_6 > 0 and var_164_1 < var_164_6 then
					arg_161_1.talkMaxDuration = var_164_6

					if var_164_6 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_7 and arg_161_1.time_ < var_164_0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play121462040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 121462040
		arg_165_1.duration_ = 9

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play121462041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 2

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				local var_168_1 = manager.ui.mainCamera.transform.localPosition
				local var_168_2 = Vector3.New(0, 0, 10) + Vector3.New(var_168_1.x, var_168_1.y, 0)
				local var_168_3 = arg_165_1.bgs_.J02g

				var_168_3.transform.localPosition = var_168_2
				var_168_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_168_4 = var_168_3:GetComponent("SpriteRenderer")

				if var_168_4 and var_168_4.sprite then
					local var_168_5 = (var_168_3.transform.localPosition - var_168_1).z
					local var_168_6 = manager.ui.mainCameraCom_
					local var_168_7 = 2 * var_168_5 * Mathf.Tan(var_168_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_168_8 = var_168_7 * var_168_6.aspect
					local var_168_9 = var_168_4.sprite.bounds.size.x
					local var_168_10 = var_168_4.sprite.bounds.size.y
					local var_168_11 = var_168_8 / var_168_9
					local var_168_12 = var_168_7 / var_168_10
					local var_168_13 = var_168_12 < var_168_11 and var_168_11 or var_168_12

					var_168_3.transform.localScale = Vector3.New(var_168_13, var_168_13, 0)
				end

				for iter_168_0, iter_168_1 in pairs(arg_165_1.bgs_) do
					if iter_168_0 ~= "J02g" then
						iter_168_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_168_14 = 0

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_15 = 2

			if var_168_14 <= arg_165_1.time_ and arg_165_1.time_ < var_168_14 + var_168_15 then
				local var_168_16 = (arg_165_1.time_ - var_168_14) / var_168_15
				local var_168_17 = Color.New(0, 0, 0)

				var_168_17.a = Mathf.Lerp(0, 1, var_168_16)
				arg_165_1.mask_.color = var_168_17
			end

			if arg_165_1.time_ >= var_168_14 + var_168_15 and arg_165_1.time_ < var_168_14 + var_168_15 + arg_168_0 then
				local var_168_18 = Color.New(0, 0, 0)

				var_168_18.a = 1
				arg_165_1.mask_.color = var_168_18
			end

			local var_168_19 = 2

			if var_168_19 < arg_165_1.time_ and arg_165_1.time_ <= var_168_19 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_20 = 2

			if var_168_19 <= arg_165_1.time_ and arg_165_1.time_ < var_168_19 + var_168_20 then
				local var_168_21 = (arg_165_1.time_ - var_168_19) / var_168_20
				local var_168_22 = Color.New(0, 0, 0)

				var_168_22.a = Mathf.Lerp(1, 0, var_168_21)
				arg_165_1.mask_.color = var_168_22
			end

			if arg_165_1.time_ >= var_168_19 + var_168_20 and arg_165_1.time_ < var_168_19 + var_168_20 + arg_168_0 then
				local var_168_23 = Color.New(0, 0, 0)
				local var_168_24 = 0

				arg_165_1.mask_.enabled = false
				var_168_23.a = var_168_24
				arg_165_1.mask_.color = var_168_23
			end

			local var_168_25 = 0
			local var_168_26 = 1

			if var_168_25 < arg_165_1.time_ and arg_165_1.time_ <= var_168_25 + arg_168_0 then
				local var_168_27 = "stop"
				local var_168_28 = "effect"

				arg_165_1:AudioAction(var_168_27, var_168_28, "se_story_121_04", "se_story_121_04_wind_loop", "")
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_29 = 3.999999999999
			local var_168_30 = 0.75

			if var_168_29 < arg_165_1.time_ and arg_165_1.time_ <= var_168_29 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_31 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_31:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_32 = arg_165_1:GetWordFromCfg(121462040)
				local var_168_33 = arg_165_1:FormatText(var_168_32.content)

				arg_165_1.text_.text = var_168_33

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_34 = 30
				local var_168_35 = utf8.len(var_168_33)
				local var_168_36 = var_168_34 <= 0 and var_168_30 or var_168_30 * (var_168_35 / var_168_34)

				if var_168_36 > 0 and var_168_30 < var_168_36 then
					arg_165_1.talkMaxDuration = var_168_36
					var_168_29 = var_168_29 + 0.3

					if var_168_36 + var_168_29 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_36 + var_168_29
					end
				end

				arg_165_1.text_.text = var_168_33
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_37 = var_168_29 + 0.3
			local var_168_38 = math.max(var_168_30, arg_165_1.talkMaxDuration)

			if var_168_37 <= arg_165_1.time_ and arg_165_1.time_ < var_168_37 + var_168_38 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_37) / var_168_38

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_37 + var_168_38 and arg_165_1.time_ < var_168_37 + var_168_38 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play121462041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 121462041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play121462042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.225

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[7].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(121462041)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 9
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
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_8 and arg_171_1.time_ < var_174_0 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play121462042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 121462042
		arg_175_1.duration_ = 9

		local var_175_0 = {
			ja = 9,
			ko = 4.966,
			zh = 4.966
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
				arg_175_0:Play121462043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1184ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1184ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, -0.97, -6)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1184ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["1184ui_story"]
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect1184ui_story == nil then
				arg_175_1.var_.characterEffect1184ui_story = var_178_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_11 = 0.200000002980232

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 and not isNil(var_178_9) then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11

				if arg_175_1.var_.characterEffect1184ui_story and not isNil(var_178_9) then
					arg_175_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect1184ui_story then
				arg_175_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_178_13 = 0

			if var_178_13 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_178_14 = 0

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 then
				arg_175_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_178_15 = 0
			local var_178_16 = 0.425

			if var_178_15 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_17 = arg_175_1:FormatText(StoryNameCfg[6].name)

				arg_175_1.leftNameTxt_.text = var_178_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_18 = arg_175_1:GetWordFromCfg(121462042)
				local var_178_19 = arg_175_1:FormatText(var_178_18.content)

				arg_175_1.text_.text = var_178_19

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_20 = 16
				local var_178_21 = utf8.len(var_178_19)
				local var_178_22 = var_178_20 <= 0 and var_178_16 or var_178_16 * (var_178_21 / var_178_20)

				if var_178_22 > 0 and var_178_16 < var_178_22 then
					arg_175_1.talkMaxDuration = var_178_22

					if var_178_22 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_22 + var_178_15
					end
				end

				arg_175_1.text_.text = var_178_19
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462042", "story_v_out_121462.awb") ~= 0 then
					local var_178_23 = manager.audio:GetVoiceLength("story_v_out_121462", "121462042", "story_v_out_121462.awb") / 1000

					if var_178_23 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_23 + var_178_15
					end

					if var_178_18.prefab_name ~= "" and arg_175_1.actors_[var_178_18.prefab_name] ~= nil then
						local var_178_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_18.prefab_name].transform, "story_v_out_121462", "121462042", "story_v_out_121462.awb")

						arg_175_1:RecordAudio("121462042", var_178_24)
						arg_175_1:RecordAudio("121462042", var_178_24)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_121462", "121462042", "story_v_out_121462.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_121462", "121462042", "story_v_out_121462.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_25 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_25 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_15) / var_178_25

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_15 + var_178_25 and arg_175_1.time_ < var_178_15 + var_178_25 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play121462043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 121462043
		arg_179_1.duration_ = 17.17

		local var_179_0 = {
			ja = 17.166,
			ko = 10.566,
			zh = 10.566
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
				arg_179_0:Play121462044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_182_2 = 0
			local var_182_3 = 1.05

			if var_182_2 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_4 = arg_179_1:FormatText(StoryNameCfg[6].name)

				arg_179_1.leftNameTxt_.text = var_182_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_5 = arg_179_1:GetWordFromCfg(121462043)
				local var_182_6 = arg_179_1:FormatText(var_182_5.content)

				arg_179_1.text_.text = var_182_6

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 42
				local var_182_8 = utf8.len(var_182_6)
				local var_182_9 = var_182_7 <= 0 and var_182_3 or var_182_3 * (var_182_8 / var_182_7)

				if var_182_9 > 0 and var_182_3 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_6
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462043", "story_v_out_121462.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_out_121462", "121462043", "story_v_out_121462.awb") / 1000

					if var_182_10 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_2
					end

					if var_182_5.prefab_name ~= "" and arg_179_1.actors_[var_182_5.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_5.prefab_name].transform, "story_v_out_121462", "121462043", "story_v_out_121462.awb")

						arg_179_1:RecordAudio("121462043", var_182_11)
						arg_179_1:RecordAudio("121462043", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_121462", "121462043", "story_v_out_121462.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_121462", "121462043", "story_v_out_121462.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_12 and arg_179_1.time_ < var_182_2 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play121462044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 121462044
		arg_183_1.duration_ = 15.2

		local var_183_0 = {
			ja = 15.2,
			ko = 14.733,
			zh = 14.733
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
				arg_183_0:Play121462045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_186_1 = 0
			local var_186_2 = 1.2

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_3 = arg_183_1:FormatText(StoryNameCfg[6].name)

				arg_183_1.leftNameTxt_.text = var_186_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_4 = arg_183_1:GetWordFromCfg(121462044)
				local var_186_5 = arg_183_1:FormatText(var_186_4.content)

				arg_183_1.text_.text = var_186_5

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_6 = 48
				local var_186_7 = utf8.len(var_186_5)
				local var_186_8 = var_186_6 <= 0 and var_186_2 or var_186_2 * (var_186_7 / var_186_6)

				if var_186_8 > 0 and var_186_2 < var_186_8 then
					arg_183_1.talkMaxDuration = var_186_8

					if var_186_8 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_5
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462044", "story_v_out_121462.awb") ~= 0 then
					local var_186_9 = manager.audio:GetVoiceLength("story_v_out_121462", "121462044", "story_v_out_121462.awb") / 1000

					if var_186_9 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_1
					end

					if var_186_4.prefab_name ~= "" and arg_183_1.actors_[var_186_4.prefab_name] ~= nil then
						local var_186_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_4.prefab_name].transform, "story_v_out_121462", "121462044", "story_v_out_121462.awb")

						arg_183_1:RecordAudio("121462044", var_186_10)
						arg_183_1:RecordAudio("121462044", var_186_10)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_121462", "121462044", "story_v_out_121462.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_121462", "121462044", "story_v_out_121462.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_11 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_11 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_11

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_11 and arg_183_1.time_ < var_186_1 + var_186_11 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play121462045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 121462045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play121462046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1184ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1184ui_story == nil then
				arg_187_1.var_.characterEffect1184ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1184ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1184ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1184ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1184ui_story.fillRatio = var_190_5
			end

			local var_190_6 = 0
			local var_190_7 = 0.1

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_8 = arg_187_1:FormatText(StoryNameCfg[7].name)

				arg_187_1.leftNameTxt_.text = var_190_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_9 = arg_187_1:GetWordFromCfg(121462045)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 4
				local var_190_12 = utf8.len(var_190_10)
				local var_190_13 = var_190_11 <= 0 and var_190_7 or var_190_7 * (var_190_12 / var_190_11)

				if var_190_13 > 0 and var_190_7 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_6
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_14 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_14 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_14

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_14 and arg_187_1.time_ < var_190_6 + var_190_14 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play121462046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 121462046
		arg_191_1.duration_ = 11.5

		local var_191_0 = {
			ja = 11.5,
			ko = 6.733,
			zh = 6.733
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
				arg_191_0:Play121462047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_194_1 = arg_191_1.actors_["1184ui_story"]
			local var_194_2 = 0

			if var_194_2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1184ui_story == nil then
				arg_191_1.var_.characterEffect1184ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_3 = 0.200000002980232

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_3 and not isNil(var_194_1) then
				local var_194_4 = (arg_191_1.time_ - var_194_2) / var_194_3

				if arg_191_1.var_.characterEffect1184ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_2 + var_194_3 and arg_191_1.time_ < var_194_2 + var_194_3 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1184ui_story then
				arg_191_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_194_5 = 0
			local var_194_6 = 0.775

			if var_194_5 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_7 = arg_191_1:FormatText(StoryNameCfg[6].name)

				arg_191_1.leftNameTxt_.text = var_194_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:GetWordFromCfg(121462046)
				local var_194_9 = arg_191_1:FormatText(var_194_8.content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 31
				local var_194_11 = utf8.len(var_194_9)
				local var_194_12 = var_194_10 <= 0 and var_194_6 or var_194_6 * (var_194_11 / var_194_10)

				if var_194_12 > 0 and var_194_6 < var_194_12 then
					arg_191_1.talkMaxDuration = var_194_12

					if var_194_12 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462046", "story_v_out_121462.awb") ~= 0 then
					local var_194_13 = manager.audio:GetVoiceLength("story_v_out_121462", "121462046", "story_v_out_121462.awb") / 1000

					if var_194_13 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_5
					end

					if var_194_8.prefab_name ~= "" and arg_191_1.actors_[var_194_8.prefab_name] ~= nil then
						local var_194_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_8.prefab_name].transform, "story_v_out_121462", "121462046", "story_v_out_121462.awb")

						arg_191_1:RecordAudio("121462046", var_194_14)
						arg_191_1:RecordAudio("121462046", var_194_14)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_121462", "121462046", "story_v_out_121462.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_121462", "121462046", "story_v_out_121462.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_15 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_15 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_5) / var_194_15

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_5 + var_194_15 and arg_191_1.time_ < var_194_5 + var_194_15 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play121462047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 121462047
		arg_195_1.duration_ = 19.07

		local var_195_0 = {
			ja = 19.066,
			ko = 15.366,
			zh = 15.366
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
				arg_195_0:Play121462048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 1.45

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[6].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_3 = arg_195_1:GetWordFromCfg(121462047)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 58
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

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462047", "story_v_out_121462.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_121462", "121462047", "story_v_out_121462.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_121462", "121462047", "story_v_out_121462.awb")

						arg_195_1:RecordAudio("121462047", var_198_9)
						arg_195_1:RecordAudio("121462047", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_121462", "121462047", "story_v_out_121462.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_121462", "121462047", "story_v_out_121462.awb")
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
	Play121462048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 121462048
		arg_199_1.duration_ = 12.27

		local var_199_0 = {
			ja = 12.266,
			ko = 12.166,
			zh = 12.166
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
				arg_199_0:Play121462049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.925

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[6].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:GetWordFromCfg(121462048)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 36
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462048", "story_v_out_121462.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_121462", "121462048", "story_v_out_121462.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_121462", "121462048", "story_v_out_121462.awb")

						arg_199_1:RecordAudio("121462048", var_202_9)
						arg_199_1:RecordAudio("121462048", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_121462", "121462048", "story_v_out_121462.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_121462", "121462048", "story_v_out_121462.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_10 and arg_199_1.time_ < var_202_0 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play121462049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 121462049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play121462050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1184ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1184ui_story == nil then
				arg_203_1.var_.characterEffect1184ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1184ui_story and not isNil(var_206_0) then
					local var_206_4 = Mathf.Lerp(0, 0.5, var_206_3)

					arg_203_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1184ui_story.fillRatio = var_206_4
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1184ui_story then
				local var_206_5 = 0.5

				arg_203_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1184ui_story.fillRatio = var_206_5
			end

			local var_206_6 = 0
			local var_206_7 = 0.8

			if var_206_6 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_8 = arg_203_1:GetWordFromCfg(121462049)
				local var_206_9 = arg_203_1:FormatText(var_206_8.content)

				arg_203_1.text_.text = var_206_9

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_10 = 32
				local var_206_11 = utf8.len(var_206_9)
				local var_206_12 = var_206_10 <= 0 and var_206_7 or var_206_7 * (var_206_11 / var_206_10)

				if var_206_12 > 0 and var_206_7 < var_206_12 then
					arg_203_1.talkMaxDuration = var_206_12

					if var_206_12 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_9
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_13 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_13 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_13

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_13 and arg_203_1.time_ < var_206_6 + var_206_13 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play121462050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 121462050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play121462051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.65

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[7].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(121462050)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 26
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play121462051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 121462051
		arg_211_1.duration_ = 14.27

		local var_211_0 = {
			ja = 14.266,
			ko = 6.5,
			zh = 6.5
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
				arg_211_0:Play121462052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1184ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1184ui_story == nil then
				arg_211_1.var_.characterEffect1184ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect1184ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1184ui_story then
				arg_211_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_214_4 = 0

			if var_214_4 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action437")
			end

			local var_214_5 = 0

			if var_214_5 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_214_6 = 0
			local var_214_7 = 0.7

			if var_214_6 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_8 = arg_211_1:FormatText(StoryNameCfg[6].name)

				arg_211_1.leftNameTxt_.text = var_214_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_9 = arg_211_1:GetWordFromCfg(121462051)
				local var_214_10 = arg_211_1:FormatText(var_214_9.content)

				arg_211_1.text_.text = var_214_10

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_11 = 28
				local var_214_12 = utf8.len(var_214_10)
				local var_214_13 = var_214_11 <= 0 and var_214_7 or var_214_7 * (var_214_12 / var_214_11)

				if var_214_13 > 0 and var_214_7 < var_214_13 then
					arg_211_1.talkMaxDuration = var_214_13

					if var_214_13 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_6
					end
				end

				arg_211_1.text_.text = var_214_10
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462051", "story_v_out_121462.awb") ~= 0 then
					local var_214_14 = manager.audio:GetVoiceLength("story_v_out_121462", "121462051", "story_v_out_121462.awb") / 1000

					if var_214_14 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_14 + var_214_6
					end

					if var_214_9.prefab_name ~= "" and arg_211_1.actors_[var_214_9.prefab_name] ~= nil then
						local var_214_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_9.prefab_name].transform, "story_v_out_121462", "121462051", "story_v_out_121462.awb")

						arg_211_1:RecordAudio("121462051", var_214_15)
						arg_211_1:RecordAudio("121462051", var_214_15)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_121462", "121462051", "story_v_out_121462.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_121462", "121462051", "story_v_out_121462.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_16 = math.max(var_214_7, arg_211_1.talkMaxDuration)

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_16 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_6) / var_214_16

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_6 + var_214_16 and arg_211_1.time_ < var_214_6 + var_214_16 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play121462052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 121462052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play121462053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1184ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1184ui_story == nil then
				arg_215_1.var_.characterEffect1184ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect1184ui_story and not isNil(var_218_0) then
					local var_218_4 = Mathf.Lerp(0, 0.5, var_218_3)

					arg_215_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1184ui_story.fillRatio = var_218_4
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1184ui_story then
				local var_218_5 = 0.5

				arg_215_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1184ui_story.fillRatio = var_218_5
			end

			local var_218_6 = 0
			local var_218_7 = 0.475

			if var_218_6 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_8 = arg_215_1:FormatText(StoryNameCfg[7].name)

				arg_215_1.leftNameTxt_.text = var_218_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_9 = arg_215_1:GetWordFromCfg(121462052)
				local var_218_10 = arg_215_1:FormatText(var_218_9.content)

				arg_215_1.text_.text = var_218_10

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 19
				local var_218_12 = utf8.len(var_218_10)
				local var_218_13 = var_218_11 <= 0 and var_218_7 or var_218_7 * (var_218_12 / var_218_11)

				if var_218_13 > 0 and var_218_7 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_10
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_14 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_14 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_14

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_14 and arg_215_1.time_ < var_218_6 + var_218_14 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play121462053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 121462053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play121462054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1184ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1184ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(0, 100, 0)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1184ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, 100, 0)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = arg_219_1.actors_["1184ui_story"]
			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect1184ui_story == nil then
				arg_219_1.var_.characterEffect1184ui_story = var_222_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_11 = 0.200000002980232

			if var_222_10 <= arg_219_1.time_ and arg_219_1.time_ < var_222_10 + var_222_11 and not isNil(var_222_9) then
				local var_222_12 = (arg_219_1.time_ - var_222_10) / var_222_11

				if arg_219_1.var_.characterEffect1184ui_story and not isNil(var_222_9) then
					local var_222_13 = Mathf.Lerp(0, 0.5, var_222_12)

					arg_219_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1184ui_story.fillRatio = var_222_13
				end
			end

			if arg_219_1.time_ >= var_222_10 + var_222_11 and arg_219_1.time_ < var_222_10 + var_222_11 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect1184ui_story then
				local var_222_14 = 0.5

				arg_219_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1184ui_story.fillRatio = var_222_14
			end

			local var_222_15 = 0
			local var_222_16 = 0.633333333333333

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				local var_222_17 = "play"
				local var_222_18 = "effect"

				arg_219_1:AudioAction(var_222_17, var_222_18, "se_story_121_04", "se_story_121_04_spacegap", "")
			end

			local var_222_19 = 0
			local var_222_20 = 0.725

			if var_222_19 < arg_219_1.time_ and arg_219_1.time_ <= var_222_19 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_21 = arg_219_1:GetWordFromCfg(121462053)
				local var_222_22 = arg_219_1:FormatText(var_222_21.content)

				arg_219_1.text_.text = var_222_22

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_23 = 29
				local var_222_24 = utf8.len(var_222_22)
				local var_222_25 = var_222_23 <= 0 and var_222_20 or var_222_20 * (var_222_24 / var_222_23)

				if var_222_25 > 0 and var_222_20 < var_222_25 then
					arg_219_1.talkMaxDuration = var_222_25

					if var_222_25 + var_222_19 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_25 + var_222_19
					end
				end

				arg_219_1.text_.text = var_222_22
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_26 = math.max(var_222_20, arg_219_1.talkMaxDuration)

			if var_222_19 <= arg_219_1.time_ and arg_219_1.time_ < var_222_19 + var_222_26 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_19) / var_222_26

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_19 + var_222_26 and arg_219_1.time_ < var_222_19 + var_222_26 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play121462054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 121462054
		arg_223_1.duration_ = 14.27

		local var_223_0 = {
			ja = 14.266,
			ko = 6.3,
			zh = 6.3
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
				arg_223_0:Play121462055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1184ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos1184ui_story = var_226_0.localPosition
			end

			local var_226_2 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2
				local var_226_4 = Vector3.New(-0.7, -0.97, -6)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1184ui_story, var_226_4, var_226_3)

				local var_226_5 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_5.x, var_226_5.y, var_226_5.z)

				local var_226_6 = var_226_0.localEulerAngles

				var_226_6.z = 0
				var_226_6.x = 0
				var_226_0.localEulerAngles = var_226_6
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_226_7 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_7.x, var_226_7.y, var_226_7.z)

				local var_226_8 = var_226_0.localEulerAngles

				var_226_8.z = 0
				var_226_8.x = 0
				var_226_0.localEulerAngles = var_226_8
			end

			local var_226_9 = arg_223_1.actors_["1184ui_story"]
			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1184ui_story == nil then
				arg_223_1.var_.characterEffect1184ui_story = var_226_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_11 = 0.200000002980232

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_11 and not isNil(var_226_9) then
				local var_226_12 = (arg_223_1.time_ - var_226_10) / var_226_11

				if arg_223_1.var_.characterEffect1184ui_story and not isNil(var_226_9) then
					local var_226_13 = Mathf.Lerp(0, 0.5, var_226_12)

					arg_223_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1184ui_story.fillRatio = var_226_13
				end
			end

			if arg_223_1.time_ >= var_226_10 + var_226_11 and arg_223_1.time_ < var_226_10 + var_226_11 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1184ui_story then
				local var_226_14 = 0.5

				arg_223_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1184ui_story.fillRatio = var_226_14
			end

			local var_226_15 = arg_223_1.actors_["1076ui_story"].transform
			local var_226_16 = 0

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 then
				arg_223_1.var_.moveOldPos1076ui_story = var_226_15.localPosition
			end

			local var_226_17 = 0.001

			if var_226_16 <= arg_223_1.time_ and arg_223_1.time_ < var_226_16 + var_226_17 then
				local var_226_18 = (arg_223_1.time_ - var_226_16) / var_226_17
				local var_226_19 = Vector3.New(0.7, -1.06, -6.2)

				var_226_15.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1076ui_story, var_226_19, var_226_18)

				local var_226_20 = manager.ui.mainCamera.transform.position - var_226_15.position

				var_226_15.forward = Vector3.New(var_226_20.x, var_226_20.y, var_226_20.z)

				local var_226_21 = var_226_15.localEulerAngles

				var_226_21.z = 0
				var_226_21.x = 0
				var_226_15.localEulerAngles = var_226_21
			end

			if arg_223_1.time_ >= var_226_16 + var_226_17 and arg_223_1.time_ < var_226_16 + var_226_17 + arg_226_0 then
				var_226_15.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_226_22 = manager.ui.mainCamera.transform.position - var_226_15.position

				var_226_15.forward = Vector3.New(var_226_22.x, var_226_22.y, var_226_22.z)

				local var_226_23 = var_226_15.localEulerAngles

				var_226_23.z = 0
				var_226_23.x = 0
				var_226_15.localEulerAngles = var_226_23
			end

			local var_226_24 = arg_223_1.actors_["1076ui_story"]
			local var_226_25 = 0

			if var_226_25 < arg_223_1.time_ and arg_223_1.time_ <= var_226_25 + arg_226_0 and not isNil(var_226_24) and arg_223_1.var_.characterEffect1076ui_story == nil then
				arg_223_1.var_.characterEffect1076ui_story = var_226_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_26 = 0.200000002980232

			if var_226_25 <= arg_223_1.time_ and arg_223_1.time_ < var_226_25 + var_226_26 and not isNil(var_226_24) then
				local var_226_27 = (arg_223_1.time_ - var_226_25) / var_226_26

				if arg_223_1.var_.characterEffect1076ui_story and not isNil(var_226_24) then
					arg_223_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_25 + var_226_26 and arg_223_1.time_ < var_226_25 + var_226_26 + arg_226_0 and not isNil(var_226_24) and arg_223_1.var_.characterEffect1076ui_story then
				arg_223_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_226_28 = 0

			if var_226_28 < arg_223_1.time_ and arg_223_1.time_ <= var_226_28 + arg_226_0 then
				arg_223_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_226_29 = 0

			if var_226_29 < arg_223_1.time_ and arg_223_1.time_ <= var_226_29 + arg_226_0 then
				arg_223_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_30 = 0

			if var_226_30 < arg_223_1.time_ and arg_223_1.time_ <= var_226_30 + arg_226_0 then
				arg_223_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_226_31 = 0
			local var_226_32 = 0.725

			if var_226_31 < arg_223_1.time_ and arg_223_1.time_ <= var_226_31 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_33 = arg_223_1:FormatText(StoryNameCfg[389].name)

				arg_223_1.leftNameTxt_.text = var_226_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_34 = arg_223_1:GetWordFromCfg(121462054)
				local var_226_35 = arg_223_1:FormatText(var_226_34.content)

				arg_223_1.text_.text = var_226_35

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_36 = 29
				local var_226_37 = utf8.len(var_226_35)
				local var_226_38 = var_226_36 <= 0 and var_226_32 or var_226_32 * (var_226_37 / var_226_36)

				if var_226_38 > 0 and var_226_32 < var_226_38 then
					arg_223_1.talkMaxDuration = var_226_38

					if var_226_38 + var_226_31 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_38 + var_226_31
					end
				end

				arg_223_1.text_.text = var_226_35
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462054", "story_v_out_121462.awb") ~= 0 then
					local var_226_39 = manager.audio:GetVoiceLength("story_v_out_121462", "121462054", "story_v_out_121462.awb") / 1000

					if var_226_39 + var_226_31 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_39 + var_226_31
					end

					if var_226_34.prefab_name ~= "" and arg_223_1.actors_[var_226_34.prefab_name] ~= nil then
						local var_226_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_34.prefab_name].transform, "story_v_out_121462", "121462054", "story_v_out_121462.awb")

						arg_223_1:RecordAudio("121462054", var_226_40)
						arg_223_1:RecordAudio("121462054", var_226_40)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_121462", "121462054", "story_v_out_121462.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_121462", "121462054", "story_v_out_121462.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_41 = math.max(var_226_32, arg_223_1.talkMaxDuration)

			if var_226_31 <= arg_223_1.time_ and arg_223_1.time_ < var_226_31 + var_226_41 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_31) / var_226_41

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_31 + var_226_41 and arg_223_1.time_ < var_226_31 + var_226_41 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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

		arg_223_1:InitPlayNodeList()
	end,
	Play121462055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 121462055
		arg_227_1.duration_ = 9.17

		local var_227_0 = {
			ja = 9.166,
			ko = 5.466,
			zh = 5.466
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
				arg_227_0:Play121462056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.7

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[389].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_3 = arg_227_1:GetWordFromCfg(121462055)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 28
				local var_230_6 = utf8.len(var_230_4)
				local var_230_7 = var_230_5 <= 0 and var_230_1 or var_230_1 * (var_230_6 / var_230_5)

				if var_230_7 > 0 and var_230_1 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462055", "story_v_out_121462.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_121462", "121462055", "story_v_out_121462.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_121462", "121462055", "story_v_out_121462.awb")

						arg_227_1:RecordAudio("121462055", var_230_9)
						arg_227_1:RecordAudio("121462055", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_121462", "121462055", "story_v_out_121462.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_121462", "121462055", "story_v_out_121462.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_10 and arg_227_1.time_ < var_230_0 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play121462056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 121462056
		arg_231_1.duration_ = 6.7

		local var_231_0 = {
			ja = 5.9,
			ko = 6.7,
			zh = 6.7
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
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play121462057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1184ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1184ui_story == nil then
				arg_231_1.var_.characterEffect1184ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1184ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1184ui_story then
				arg_231_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_234_4 = 0

			if var_234_4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_234_5 = 0

			if var_234_5 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_6 = arg_231_1.actors_["1076ui_story"]
			local var_234_7 = 0

			if var_234_7 < arg_231_1.time_ and arg_231_1.time_ <= var_234_7 + arg_234_0 and not isNil(var_234_6) and arg_231_1.var_.characterEffect1076ui_story == nil then
				arg_231_1.var_.characterEffect1076ui_story = var_234_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_8 = 0.200000002980232

			if var_234_7 <= arg_231_1.time_ and arg_231_1.time_ < var_234_7 + var_234_8 and not isNil(var_234_6) then
				local var_234_9 = (arg_231_1.time_ - var_234_7) / var_234_8

				if arg_231_1.var_.characterEffect1076ui_story and not isNil(var_234_6) then
					local var_234_10 = Mathf.Lerp(0, 0.5, var_234_9)

					arg_231_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1076ui_story.fillRatio = var_234_10
				end
			end

			if arg_231_1.time_ >= var_234_7 + var_234_8 and arg_231_1.time_ < var_234_7 + var_234_8 + arg_234_0 and not isNil(var_234_6) and arg_231_1.var_.characterEffect1076ui_story then
				local var_234_11 = 0.5

				arg_231_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1076ui_story.fillRatio = var_234_11
			end

			local var_234_12 = 0
			local var_234_13 = 0.5

			if var_234_12 < arg_231_1.time_ and arg_231_1.time_ <= var_234_12 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_14 = arg_231_1:FormatText(StoryNameCfg[6].name)

				arg_231_1.leftNameTxt_.text = var_234_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_15 = arg_231_1:GetWordFromCfg(121462056)
				local var_234_16 = arg_231_1:FormatText(var_234_15.content)

				arg_231_1.text_.text = var_234_16

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_17 = 20
				local var_234_18 = utf8.len(var_234_16)
				local var_234_19 = var_234_17 <= 0 and var_234_13 or var_234_13 * (var_234_18 / var_234_17)

				if var_234_19 > 0 and var_234_13 < var_234_19 then
					arg_231_1.talkMaxDuration = var_234_19

					if var_234_19 + var_234_12 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_19 + var_234_12
					end
				end

				arg_231_1.text_.text = var_234_16
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462056", "story_v_out_121462.awb") ~= 0 then
					local var_234_20 = manager.audio:GetVoiceLength("story_v_out_121462", "121462056", "story_v_out_121462.awb") / 1000

					if var_234_20 + var_234_12 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_20 + var_234_12
					end

					if var_234_15.prefab_name ~= "" and arg_231_1.actors_[var_234_15.prefab_name] ~= nil then
						local var_234_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_15.prefab_name].transform, "story_v_out_121462", "121462056", "story_v_out_121462.awb")

						arg_231_1:RecordAudio("121462056", var_234_21)
						arg_231_1:RecordAudio("121462056", var_234_21)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_121462", "121462056", "story_v_out_121462.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_121462", "121462056", "story_v_out_121462.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_22 = math.max(var_234_13, arg_231_1.talkMaxDuration)

			if var_234_12 <= arg_231_1.time_ and arg_231_1.time_ < var_234_12 + var_234_22 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_12) / var_234_22

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_12 + var_234_22 and arg_231_1.time_ < var_234_12 + var_234_22 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play121462057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 121462057
		arg_235_1.duration_ = 7.8

		local var_235_0 = {
			ja = 7.8,
			ko = 2.466,
			zh = 2.466
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
				arg_235_0:Play121462058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1076ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1076ui_story == nil then
				arg_235_1.var_.characterEffect1076ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect1076ui_story and not isNil(var_238_0) then
					arg_235_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1076ui_story then
				arg_235_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_238_4 = arg_235_1.actors_["1184ui_story"]
			local var_238_5 = 0

			if var_238_5 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect1184ui_story == nil then
				arg_235_1.var_.characterEffect1184ui_story = var_238_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_6 = 0.200000002980232

			if var_238_5 <= arg_235_1.time_ and arg_235_1.time_ < var_238_5 + var_238_6 and not isNil(var_238_4) then
				local var_238_7 = (arg_235_1.time_ - var_238_5) / var_238_6

				if arg_235_1.var_.characterEffect1184ui_story and not isNil(var_238_4) then
					local var_238_8 = Mathf.Lerp(0, 0.5, var_238_7)

					arg_235_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1184ui_story.fillRatio = var_238_8
				end
			end

			if arg_235_1.time_ >= var_238_5 + var_238_6 and arg_235_1.time_ < var_238_5 + var_238_6 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect1184ui_story then
				local var_238_9 = 0.5

				arg_235_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1184ui_story.fillRatio = var_238_9
			end

			local var_238_10 = 0
			local var_238_11 = 0.325

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_12 = arg_235_1:FormatText(StoryNameCfg[389].name)

				arg_235_1.leftNameTxt_.text = var_238_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_13 = arg_235_1:GetWordFromCfg(121462057)
				local var_238_14 = arg_235_1:FormatText(var_238_13.content)

				arg_235_1.text_.text = var_238_14

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_15 = 13
				local var_238_16 = utf8.len(var_238_14)
				local var_238_17 = var_238_15 <= 0 and var_238_11 or var_238_11 * (var_238_16 / var_238_15)

				if var_238_17 > 0 and var_238_11 < var_238_17 then
					arg_235_1.talkMaxDuration = var_238_17

					if var_238_17 + var_238_10 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_17 + var_238_10
					end
				end

				arg_235_1.text_.text = var_238_14
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462057", "story_v_out_121462.awb") ~= 0 then
					local var_238_18 = manager.audio:GetVoiceLength("story_v_out_121462", "121462057", "story_v_out_121462.awb") / 1000

					if var_238_18 + var_238_10 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_18 + var_238_10
					end

					if var_238_13.prefab_name ~= "" and arg_235_1.actors_[var_238_13.prefab_name] ~= nil then
						local var_238_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_13.prefab_name].transform, "story_v_out_121462", "121462057", "story_v_out_121462.awb")

						arg_235_1:RecordAudio("121462057", var_238_19)
						arg_235_1:RecordAudio("121462057", var_238_19)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_121462", "121462057", "story_v_out_121462.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_121462", "121462057", "story_v_out_121462.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_20 = math.max(var_238_11, arg_235_1.talkMaxDuration)

			if var_238_10 <= arg_235_1.time_ and arg_235_1.time_ < var_238_10 + var_238_20 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_10) / var_238_20

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_10 + var_238_20 and arg_235_1.time_ < var_238_10 + var_238_20 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play121462058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 121462058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play121462059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1076ui_story"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1076ui_story == nil then
				arg_239_1.var_.characterEffect1076ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.characterEffect1076ui_story and not isNil(var_242_0) then
					local var_242_4 = Mathf.Lerp(0, 0.5, var_242_3)

					arg_239_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1076ui_story.fillRatio = var_242_4
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1076ui_story then
				local var_242_5 = 0.5

				arg_239_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1076ui_story.fillRatio = var_242_5
			end

			local var_242_6 = 0
			local var_242_7 = 0.85

			if var_242_6 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_8 = arg_239_1:GetWordFromCfg(121462058)
				local var_242_9 = arg_239_1:FormatText(var_242_8.content)

				arg_239_1.text_.text = var_242_9

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_10 = 34
				local var_242_11 = utf8.len(var_242_9)
				local var_242_12 = var_242_10 <= 0 and var_242_7 or var_242_7 * (var_242_11 / var_242_10)

				if var_242_12 > 0 and var_242_7 < var_242_12 then
					arg_239_1.talkMaxDuration = var_242_12

					if var_242_12 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_12 + var_242_6
					end
				end

				arg_239_1.text_.text = var_242_9
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_13 = math.max(var_242_7, arg_239_1.talkMaxDuration)

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_13 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_6) / var_242_13

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_6 + var_242_13 and arg_239_1.time_ < var_242_6 + var_242_13 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play121462059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 121462059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play121462060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.0666666666666667

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				local var_246_2 = "play"
				local var_246_3 = "effect"

				arg_243_1:AudioAction(var_246_2, var_246_3, "se_story_121_04", "se_story_121_04_roar_loop", "")
			end

			local var_246_4 = 0
			local var_246_5 = 1.475

			if var_246_4 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_6 = arg_243_1:GetWordFromCfg(121462059)
				local var_246_7 = arg_243_1:FormatText(var_246_6.content)

				arg_243_1.text_.text = var_246_7

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_8 = 59
				local var_246_9 = utf8.len(var_246_7)
				local var_246_10 = var_246_8 <= 0 and var_246_5 or var_246_5 * (var_246_9 / var_246_8)

				if var_246_10 > 0 and var_246_5 < var_246_10 then
					arg_243_1.talkMaxDuration = var_246_10

					if var_246_10 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_4
					end
				end

				arg_243_1.text_.text = var_246_7
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_11 = math.max(var_246_5, arg_243_1.talkMaxDuration)

			if var_246_4 <= arg_243_1.time_ and arg_243_1.time_ < var_246_4 + var_246_11 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_4) / var_246_11

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_4 + var_246_11 and arg_243_1.time_ < var_246_4 + var_246_11 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play121462060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 121462060
		arg_247_1.duration_ = 5.1

		local var_247_0 = {
			ja = 5.1,
			ko = 3.933,
			zh = 3.933
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
				arg_247_0:Play121462061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1184ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos1184ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(-0.7, -0.97, -6)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1184ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["1184ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1184ui_story == nil then
				arg_247_1.var_.characterEffect1184ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect1184ui_story and not isNil(var_250_9) then
					arg_247_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1184ui_story then
				arg_247_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_250_13 = 0

			if var_250_13 < arg_247_1.time_ and arg_247_1.time_ <= var_250_13 + arg_250_0 then
				arg_247_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_250_14 = 0
			local var_250_15 = 0.4

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_16 = arg_247_1:FormatText(StoryNameCfg[6].name)

				arg_247_1.leftNameTxt_.text = var_250_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_17 = arg_247_1:GetWordFromCfg(121462060)
				local var_250_18 = arg_247_1:FormatText(var_250_17.content)

				arg_247_1.text_.text = var_250_18

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_19 = 16
				local var_250_20 = utf8.len(var_250_18)
				local var_250_21 = var_250_19 <= 0 and var_250_15 or var_250_15 * (var_250_20 / var_250_19)

				if var_250_21 > 0 and var_250_15 < var_250_21 then
					arg_247_1.talkMaxDuration = var_250_21

					if var_250_21 + var_250_14 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_21 + var_250_14
					end
				end

				arg_247_1.text_.text = var_250_18
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121462", "121462060", "story_v_out_121462.awb") ~= 0 then
					local var_250_22 = manager.audio:GetVoiceLength("story_v_out_121462", "121462060", "story_v_out_121462.awb") / 1000

					if var_250_22 + var_250_14 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_22 + var_250_14
					end

					if var_250_17.prefab_name ~= "" and arg_247_1.actors_[var_250_17.prefab_name] ~= nil then
						local var_250_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_17.prefab_name].transform, "story_v_out_121462", "121462060", "story_v_out_121462.awb")

						arg_247_1:RecordAudio("121462060", var_250_23)
						arg_247_1:RecordAudio("121462060", var_250_23)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_121462", "121462060", "story_v_out_121462.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_121462", "121462060", "story_v_out_121462.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_24 = math.max(var_250_15, arg_247_1.talkMaxDuration)

			if var_250_14 <= arg_247_1.time_ and arg_247_1.time_ < var_250_14 + var_250_24 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_14) / var_250_24

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_14 + var_250_24 and arg_247_1.time_ < var_250_14 + var_250_24 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play121462061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 121462061
		arg_251_1.duration_ = 7.53

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play121462062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.833333333333333

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				local var_254_1 = manager.ui.mainCamera.transform.localPosition
				local var_254_2 = Vector3.New(0, 0, 10) + Vector3.New(var_254_1.x, var_254_1.y, 0)
				local var_254_3 = arg_251_1.bgs_.STblack

				var_254_3.transform.localPosition = var_254_2
				var_254_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_254_4 = var_254_3:GetComponent("SpriteRenderer")

				if var_254_4 and var_254_4.sprite then
					local var_254_5 = (var_254_3.transform.localPosition - var_254_1).z
					local var_254_6 = manager.ui.mainCameraCom_
					local var_254_7 = 2 * var_254_5 * Mathf.Tan(var_254_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_254_8 = var_254_7 * var_254_6.aspect
					local var_254_9 = var_254_4.sprite.bounds.size.x
					local var_254_10 = var_254_4.sprite.bounds.size.y
					local var_254_11 = var_254_8 / var_254_9
					local var_254_12 = var_254_7 / var_254_10
					local var_254_13 = var_254_12 < var_254_11 and var_254_11 or var_254_12

					var_254_3.transform.localScale = Vector3.New(var_254_13, var_254_13, 0)
				end

				for iter_254_0, iter_254_1 in pairs(arg_251_1.bgs_) do
					if iter_254_0 ~= "STblack" then
						iter_254_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_254_14 = 0.833333333333333

			if var_254_14 < arg_251_1.time_ and arg_251_1.time_ <= var_254_14 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_15 = 2

			if var_254_14 <= arg_251_1.time_ and arg_251_1.time_ < var_254_14 + var_254_15 then
				local var_254_16 = (arg_251_1.time_ - var_254_14) / var_254_15
				local var_254_17 = Color.New(1, 1, 1)

				var_254_17.a = Mathf.Lerp(1, 0, var_254_16)
				arg_251_1.mask_.color = var_254_17
			end

			if arg_251_1.time_ >= var_254_14 + var_254_15 and arg_251_1.time_ < var_254_14 + var_254_15 + arg_254_0 then
				local var_254_18 = Color.New(1, 1, 1)
				local var_254_19 = 0

				arg_251_1.mask_.enabled = false
				var_254_18.a = var_254_19
				arg_251_1.mask_.color = var_254_18
			end

			local var_254_20 = arg_251_1.actors_["1184ui_story"].transform
			local var_254_21 = 0

			if var_254_21 < arg_251_1.time_ and arg_251_1.time_ <= var_254_21 + arg_254_0 then
				arg_251_1.var_.moveOldPos1184ui_story = var_254_20.localPosition
			end

			local var_254_22 = 0.001

			if var_254_21 <= arg_251_1.time_ and arg_251_1.time_ < var_254_21 + var_254_22 then
				local var_254_23 = (arg_251_1.time_ - var_254_21) / var_254_22
				local var_254_24 = Vector3.New(0, 100, 0)

				var_254_20.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1184ui_story, var_254_24, var_254_23)

				local var_254_25 = manager.ui.mainCamera.transform.position - var_254_20.position

				var_254_20.forward = Vector3.New(var_254_25.x, var_254_25.y, var_254_25.z)

				local var_254_26 = var_254_20.localEulerAngles

				var_254_26.z = 0
				var_254_26.x = 0
				var_254_20.localEulerAngles = var_254_26
			end

			if arg_251_1.time_ >= var_254_21 + var_254_22 and arg_251_1.time_ < var_254_21 + var_254_22 + arg_254_0 then
				var_254_20.localPosition = Vector3.New(0, 100, 0)

				local var_254_27 = manager.ui.mainCamera.transform.position - var_254_20.position

				var_254_20.forward = Vector3.New(var_254_27.x, var_254_27.y, var_254_27.z)

				local var_254_28 = var_254_20.localEulerAngles

				var_254_28.z = 0
				var_254_28.x = 0
				var_254_20.localEulerAngles = var_254_28
			end

			local var_254_29 = arg_251_1.actors_["1184ui_story"]
			local var_254_30 = 0

			if var_254_30 < arg_251_1.time_ and arg_251_1.time_ <= var_254_30 + arg_254_0 and not isNil(var_254_29) and arg_251_1.var_.characterEffect1184ui_story == nil then
				arg_251_1.var_.characterEffect1184ui_story = var_254_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_31 = 0.200000002980232

			if var_254_30 <= arg_251_1.time_ and arg_251_1.time_ < var_254_30 + var_254_31 and not isNil(var_254_29) then
				local var_254_32 = (arg_251_1.time_ - var_254_30) / var_254_31

				if arg_251_1.var_.characterEffect1184ui_story and not isNil(var_254_29) then
					local var_254_33 = Mathf.Lerp(0, 0.5, var_254_32)

					arg_251_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1184ui_story.fillRatio = var_254_33
				end
			end

			if arg_251_1.time_ >= var_254_30 + var_254_31 and arg_251_1.time_ < var_254_30 + var_254_31 + arg_254_0 and not isNil(var_254_29) and arg_251_1.var_.characterEffect1184ui_story then
				local var_254_34 = 0.5

				arg_251_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1184ui_story.fillRatio = var_254_34
			end

			local var_254_35 = arg_251_1.actors_["1076ui_story"].transform
			local var_254_36 = 0

			if var_254_36 < arg_251_1.time_ and arg_251_1.time_ <= var_254_36 + arg_254_0 then
				arg_251_1.var_.moveOldPos1076ui_story = var_254_35.localPosition
			end

			local var_254_37 = 0.001

			if var_254_36 <= arg_251_1.time_ and arg_251_1.time_ < var_254_36 + var_254_37 then
				local var_254_38 = (arg_251_1.time_ - var_254_36) / var_254_37
				local var_254_39 = Vector3.New(0, 100, 0)

				var_254_35.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1076ui_story, var_254_39, var_254_38)

				local var_254_40 = manager.ui.mainCamera.transform.position - var_254_35.position

				var_254_35.forward = Vector3.New(var_254_40.x, var_254_40.y, var_254_40.z)

				local var_254_41 = var_254_35.localEulerAngles

				var_254_41.z = 0
				var_254_41.x = 0
				var_254_35.localEulerAngles = var_254_41
			end

			if arg_251_1.time_ >= var_254_36 + var_254_37 and arg_251_1.time_ < var_254_36 + var_254_37 + arg_254_0 then
				var_254_35.localPosition = Vector3.New(0, 100, 0)

				local var_254_42 = manager.ui.mainCamera.transform.position - var_254_35.position

				var_254_35.forward = Vector3.New(var_254_42.x, var_254_42.y, var_254_42.z)

				local var_254_43 = var_254_35.localEulerAngles

				var_254_43.z = 0
				var_254_43.x = 0
				var_254_35.localEulerAngles = var_254_43
			end

			local var_254_44 = arg_251_1.actors_["1076ui_story"]
			local var_254_45 = 0

			if var_254_45 < arg_251_1.time_ and arg_251_1.time_ <= var_254_45 + arg_254_0 and not isNil(var_254_44) and arg_251_1.var_.characterEffect1076ui_story == nil then
				arg_251_1.var_.characterEffect1076ui_story = var_254_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_46 = 0.200000002980232

			if var_254_45 <= arg_251_1.time_ and arg_251_1.time_ < var_254_45 + var_254_46 and not isNil(var_254_44) then
				local var_254_47 = (arg_251_1.time_ - var_254_45) / var_254_46

				if arg_251_1.var_.characterEffect1076ui_story and not isNil(var_254_44) then
					local var_254_48 = Mathf.Lerp(0, 0.5, var_254_47)

					arg_251_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1076ui_story.fillRatio = var_254_48
				end
			end

			if arg_251_1.time_ >= var_254_45 + var_254_46 and arg_251_1.time_ < var_254_45 + var_254_46 + arg_254_0 and not isNil(var_254_44) and arg_251_1.var_.characterEffect1076ui_story then
				local var_254_49 = 0.5

				arg_251_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1076ui_story.fillRatio = var_254_49
			end

			local var_254_50 = manager.ui.mainCamera.transform
			local var_254_51 = 0

			if var_254_51 < arg_251_1.time_ and arg_251_1.time_ <= var_254_51 + arg_254_0 then
				arg_251_1.var_.shakeOldPos = var_254_50.localPosition
			end

			local var_254_52 = 1

			if var_254_51 <= arg_251_1.time_ and arg_251_1.time_ < var_254_51 + var_254_52 then
				local var_254_53 = (arg_251_1.time_ - var_254_51) / 0.066
				local var_254_54, var_254_55 = math.modf(var_254_53)

				var_254_50.localPosition = Vector3.New(var_254_55 * 0.13, var_254_55 * 0.13, var_254_55 * 0.13) + arg_251_1.var_.shakeOldPos
			end

			if arg_251_1.time_ >= var_254_51 + var_254_52 and arg_251_1.time_ < var_254_51 + var_254_52 + arg_254_0 then
				var_254_50.localPosition = arg_251_1.var_.shakeOldPos
			end

			local var_254_56 = 0
			local var_254_57 = 1

			if var_254_56 < arg_251_1.time_ and arg_251_1.time_ <= var_254_56 + arg_254_0 then
				local var_254_58 = "play"
				local var_254_59 = "effect"

				arg_251_1:AudioAction(var_254_58, var_254_59, "se_story_15", "se_story_15_blast02", "")
			end

			local var_254_60 = 0
			local var_254_61 = 1

			if var_254_60 < arg_251_1.time_ and arg_251_1.time_ <= var_254_60 + arg_254_0 then
				local var_254_62 = "play"
				local var_254_63 = "effect"

				arg_251_1:AudioAction(var_254_62, var_254_63, "se_story_7", "se_story_7_blast", "")
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_64 = 2.53333333333333
			local var_254_65 = 0.3

			if var_254_64 < arg_251_1.time_ and arg_251_1.time_ <= var_254_64 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_66 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_66:setOnUpdate(LuaHelper.FloatAction(function(arg_255_0)
					arg_251_1.dialogCg_.alpha = arg_255_0
				end))
				var_254_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_67 = arg_251_1:GetWordFromCfg(121462061)
				local var_254_68 = arg_251_1:FormatText(var_254_67.content)

				arg_251_1.text_.text = var_254_68

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_69 = 12
				local var_254_70 = utf8.len(var_254_68)
				local var_254_71 = var_254_69 <= 0 and var_254_65 or var_254_65 * (var_254_70 / var_254_69)

				if var_254_71 > 0 and var_254_65 < var_254_71 then
					arg_251_1.talkMaxDuration = var_254_71
					var_254_64 = var_254_64 + 0.3

					if var_254_71 + var_254_64 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_71 + var_254_64
					end
				end

				arg_251_1.text_.text = var_254_68
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_72 = var_254_64 + 0.3
			local var_254_73 = math.max(var_254_65, arg_251_1.talkMaxDuration)

			if var_254_72 <= arg_251_1.time_ and arg_251_1.time_ < var_254_72 + var_254_73 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_72) / var_254_73

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_72 + var_254_73 and arg_251_1.time_ < var_254_72 + var_254_73 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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

		arg_251_1:InitPlayNodeList()
	end,
	Play121462062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 121462062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
			arg_257_1.auto_ = false
		end

		function arg_257_1.playNext_(arg_259_0)
			arg_257_1.onStoryFinished_()
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 1.1

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_2 = arg_257_1:GetWordFromCfg(121462062)
				local var_260_3 = arg_257_1:FormatText(var_260_2.content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 44
				local var_260_5 = utf8.len(var_260_3)
				local var_260_6 = var_260_4 <= 0 and var_260_1 or var_260_1 * (var_260_5 / var_260_4)

				if var_260_6 > 0 and var_260_1 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_7 and arg_257_1.time_ < var_260_0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J02g",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XH0303"
	},
	voices = {
		"story_v_out_121462.awb"
	}
}
