return {
	Play115131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115131001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "G03a"

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
				local var_4_5 = arg_1_1.bgs_.G03a

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
					if iter_4_0 ~= "G03a" then
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
			local var_4_23 = 0.266666666666667

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

			local var_4_28 = 0.433333333333333
			local var_4_29 = 0.566666666665667

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1")

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
			local var_4_35 = 0.875

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

				local var_4_37 = arg_1_1:GetWordFromCfg(115131001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 35
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
	Play115131002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115131002
		arg_9_1.duration_ = 17.13

		local var_9_0 = {
			ja = 17.133,
			ko = 15.633,
			zh = 16,
			en = 13.4
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play115131003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1052ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1052ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1052ui_story"), arg_9_1.stage_.transform)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentInChildren(typeof(CharacterEffect))

					var_12_3.enabled = true

					local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_2, typeof(DynamicBoneHelper))

					if var_12_4 then
						var_12_4:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_3.transform, false)

					arg_9_1.var_[var_12_0 .. "Animator"] = var_12_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_0 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_0 .. "LipSync"] = var_12_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_5 = arg_9_1.actors_["1052ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1052ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(-0.7, -1.05, -6.2)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1052ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = 0

			if var_12_14 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				arg_9_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_12_16 = arg_9_1.actors_["1052ui_story"]
			local var_12_17 = 0

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1052ui_story == nil then
				arg_9_1.var_.characterEffect1052ui_story = var_12_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_18 = 0.2

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_18 and not isNil(var_12_16) then
				local var_12_19 = (arg_9_1.time_ - var_12_17) / var_12_18

				if arg_9_1.var_.characterEffect1052ui_story and not isNil(var_12_16) then
					arg_9_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_17 + var_12_18 and arg_9_1.time_ < var_12_17 + var_12_18 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1052ui_story then
				arg_9_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_12_20 = "1024ui_story"

			if arg_9_1.actors_[var_12_20] == nil then
				local var_12_21 = Asset.Load("Char/" .. "1024ui_story")

				if not isNil(var_12_21) then
					local var_12_22 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_9_1.stage_.transform)

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
				arg_9_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_12_26 = arg_9_1.actors_["1024ui_story"]
			local var_12_27 = 0

			if var_12_27 < arg_9_1.time_ and arg_9_1.time_ <= var_12_27 + arg_12_0 and not isNil(var_12_26) and arg_9_1.var_.characterEffect1024ui_story == nil then
				arg_9_1.var_.characterEffect1024ui_story = var_12_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_28 = 0.2

			if var_12_27 <= arg_9_1.time_ and arg_9_1.time_ < var_12_27 + var_12_28 and not isNil(var_12_26) then
				local var_12_29 = (arg_9_1.time_ - var_12_27) / var_12_28

				if arg_9_1.var_.characterEffect1024ui_story and not isNil(var_12_26) then
					local var_12_30 = Mathf.Lerp(0, 0.5, var_12_29)

					arg_9_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1024ui_story.fillRatio = var_12_30
				end
			end

			if arg_9_1.time_ >= var_12_27 + var_12_28 and arg_9_1.time_ < var_12_27 + var_12_28 + arg_12_0 and not isNil(var_12_26) and arg_9_1.var_.characterEffect1024ui_story then
				local var_12_31 = 0.5

				arg_9_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1024ui_story.fillRatio = var_12_31
			end

			local var_12_32 = arg_9_1.actors_["1024ui_story"].transform
			local var_12_33 = 0

			if var_12_33 < arg_9_1.time_ and arg_9_1.time_ <= var_12_33 + arg_12_0 then
				arg_9_1.var_.moveOldPos1024ui_story = var_12_32.localPosition
			end

			local var_12_34 = 0.001

			if var_12_33 <= arg_9_1.time_ and arg_9_1.time_ < var_12_33 + var_12_34 then
				local var_12_35 = (arg_9_1.time_ - var_12_33) / var_12_34
				local var_12_36 = Vector3.New(0.7, -1, -6.05)

				var_12_32.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1024ui_story, var_12_36, var_12_35)

				local var_12_37 = manager.ui.mainCamera.transform.position - var_12_32.position

				var_12_32.forward = Vector3.New(var_12_37.x, var_12_37.y, var_12_37.z)

				local var_12_38 = var_12_32.localEulerAngles

				var_12_38.z = 0
				var_12_38.x = 0
				var_12_32.localEulerAngles = var_12_38
			end

			if arg_9_1.time_ >= var_12_33 + var_12_34 and arg_9_1.time_ < var_12_33 + var_12_34 + arg_12_0 then
				var_12_32.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_12_39 = manager.ui.mainCamera.transform.position - var_12_32.position

				var_12_32.forward = Vector3.New(var_12_39.x, var_12_39.y, var_12_39.z)

				local var_12_40 = var_12_32.localEulerAngles

				var_12_40.z = 0
				var_12_40.x = 0
				var_12_32.localEulerAngles = var_12_40
			end

			local var_12_41 = 0
			local var_12_42 = 1.45

			if var_12_41 < arg_9_1.time_ and arg_9_1.time_ <= var_12_41 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_43 = arg_9_1:FormatText(StoryNameCfg[263].name)

				arg_9_1.leftNameTxt_.text = var_12_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_44 = arg_9_1:GetWordFromCfg(115131002)
				local var_12_45 = arg_9_1:FormatText(var_12_44.content)

				arg_9_1.text_.text = var_12_45

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_46 = 58
				local var_12_47 = utf8.len(var_12_45)
				local var_12_48 = var_12_46 <= 0 and var_12_42 or var_12_42 * (var_12_47 / var_12_46)

				if var_12_48 > 0 and var_12_42 < var_12_48 then
					arg_9_1.talkMaxDuration = var_12_48

					if var_12_48 + var_12_41 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_48 + var_12_41
					end
				end

				arg_9_1.text_.text = var_12_45
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131002", "story_v_out_115131.awb") ~= 0 then
					local var_12_49 = manager.audio:GetVoiceLength("story_v_out_115131", "115131002", "story_v_out_115131.awb") / 1000

					if var_12_49 + var_12_41 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_49 + var_12_41
					end

					if var_12_44.prefab_name ~= "" and arg_9_1.actors_[var_12_44.prefab_name] ~= nil then
						local var_12_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_44.prefab_name].transform, "story_v_out_115131", "115131002", "story_v_out_115131.awb")

						arg_9_1:RecordAudio("115131002", var_12_50)
						arg_9_1:RecordAudio("115131002", var_12_50)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_115131", "115131002", "story_v_out_115131.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_115131", "115131002", "story_v_out_115131.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_51 = math.max(var_12_42, arg_9_1.talkMaxDuration)

			if var_12_41 <= arg_9_1.time_ and arg_9_1.time_ < var_12_41 + var_12_51 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_41) / var_12_51

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_41 + var_12_51 and arg_9_1.time_ < var_12_41 + var_12_51 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play115131003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115131003
		arg_13_1.duration_ = 7.23

		local var_13_0 = {
			ja = 7.233,
			ko = 4.166,
			zh = 4.133,
			en = 3.8
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
				arg_13_0:Play115131004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1052ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1052ui_story == nil then
				arg_13_1.var_.characterEffect1052ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1052ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1052ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1052ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1052ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 0.4

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_8 = arg_13_1:FormatText(StoryNameCfg[273].name)

				arg_13_1.leftNameTxt_.text = var_16_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_9 = arg_13_1:GetWordFromCfg(115131003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 16
				local var_16_12 = utf8.len(var_16_10)
				local var_16_13 = var_16_11 <= 0 and var_16_7 or var_16_7 * (var_16_12 / var_16_11)

				if var_16_13 > 0 and var_16_7 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131003", "story_v_out_115131.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_115131", "115131003", "story_v_out_115131.awb") / 1000

					if var_16_14 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_6
					end

					if var_16_9.prefab_name ~= "" and arg_13_1.actors_[var_16_9.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_9.prefab_name].transform, "story_v_out_115131", "115131003", "story_v_out_115131.awb")

						arg_13_1:RecordAudio("115131003", var_16_15)
						arg_13_1:RecordAudio("115131003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_115131", "115131003", "story_v_out_115131.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_115131", "115131003", "story_v_out_115131.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_16 and arg_13_1.time_ < var_16_6 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play115131004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115131004
		arg_17_1.duration_ = 16.87

		local var_17_0 = {
			ja = 16.866,
			ko = 11.266,
			zh = 13,
			en = 13.1
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
				arg_17_0:Play115131005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1052ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1052ui_story == nil then
				arg_17_1.var_.characterEffect1052ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1052ui_story and not isNil(var_20_0) then
					arg_17_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1052ui_story then
				arg_17_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_20_4 = 0

			if var_20_4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_20_5 = "1017ui_story"

			if arg_17_1.actors_[var_20_5] == nil then
				local var_20_6 = Asset.Load("Char/" .. "1017ui_story")

				if not isNil(var_20_6) then
					local var_20_7 = Object.Instantiate(Asset.Load("Char/" .. "1017ui_story"), arg_17_1.stage_.transform)

					var_20_7.name = var_20_5
					var_20_7.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_5] = var_20_7

					local var_20_8 = var_20_7:GetComponentInChildren(typeof(CharacterEffect))

					var_20_8.enabled = true

					local var_20_9 = GameObjectTools.GetOrAddComponent(var_20_7, typeof(DynamicBoneHelper))

					if var_20_9 then
						var_20_9:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_8.transform, false)

					arg_17_1.var_[var_20_5 .. "Animator"] = var_20_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_5 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_5 .. "LipSync"] = var_20_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_10 = arg_17_1.actors_["1017ui_story"].transform
			local var_20_11 = 0

			if var_20_11 < arg_17_1.time_ and arg_17_1.time_ <= var_20_11 + arg_20_0 then
				arg_17_1.var_.moveOldPos1017ui_story = var_20_10.localPosition
			end

			local var_20_12 = 0.001

			if var_20_11 <= arg_17_1.time_ and arg_17_1.time_ < var_20_11 + var_20_12 then
				local var_20_13 = (arg_17_1.time_ - var_20_11) / var_20_12
				local var_20_14 = Vector3.New(0, 100, 0)

				var_20_10.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1017ui_story, var_20_14, var_20_13)

				local var_20_15 = manager.ui.mainCamera.transform.position - var_20_10.position

				var_20_10.forward = Vector3.New(var_20_15.x, var_20_15.y, var_20_15.z)

				local var_20_16 = var_20_10.localEulerAngles

				var_20_16.z = 0
				var_20_16.x = 0
				var_20_10.localEulerAngles = var_20_16
			end

			if arg_17_1.time_ >= var_20_11 + var_20_12 and arg_17_1.time_ < var_20_11 + var_20_12 + arg_20_0 then
				var_20_10.localPosition = Vector3.New(0, 100, 0)

				local var_20_17 = manager.ui.mainCamera.transform.position - var_20_10.position

				var_20_10.forward = Vector3.New(var_20_17.x, var_20_17.y, var_20_17.z)

				local var_20_18 = var_20_10.localEulerAngles

				var_20_18.z = 0
				var_20_18.x = 0
				var_20_10.localEulerAngles = var_20_18
			end

			local var_20_19 = arg_17_1.actors_["1024ui_story"].transform
			local var_20_20 = 0

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.var_.moveOldPos1024ui_story = var_20_19.localPosition
			end

			local var_20_21 = 0.001

			if var_20_20 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_21 then
				local var_20_22 = (arg_17_1.time_ - var_20_20) / var_20_21
				local var_20_23 = Vector3.New(0.7, -1, -6.05)

				var_20_19.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1024ui_story, var_20_23, var_20_22)

				local var_20_24 = manager.ui.mainCamera.transform.position - var_20_19.position

				var_20_19.forward = Vector3.New(var_20_24.x, var_20_24.y, var_20_24.z)

				local var_20_25 = var_20_19.localEulerAngles

				var_20_25.z = 0
				var_20_25.x = 0
				var_20_19.localEulerAngles = var_20_25
			end

			if arg_17_1.time_ >= var_20_20 + var_20_21 and arg_17_1.time_ < var_20_20 + var_20_21 + arg_20_0 then
				var_20_19.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_20_26 = manager.ui.mainCamera.transform.position - var_20_19.position

				var_20_19.forward = Vector3.New(var_20_26.x, var_20_26.y, var_20_26.z)

				local var_20_27 = var_20_19.localEulerAngles

				var_20_27.z = 0
				var_20_27.x = 0
				var_20_19.localEulerAngles = var_20_27
			end

			local var_20_28 = 0

			if var_20_28 < arg_17_1.time_ and arg_17_1.time_ <= var_20_28 + arg_20_0 then
				arg_17_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_20_29 = arg_17_1.actors_["1024ui_story"]
			local var_20_30 = 0

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 and not isNil(var_20_29) and arg_17_1.var_.characterEffect1024ui_story == nil then
				arg_17_1.var_.characterEffect1024ui_story = var_20_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_31 = 0.2

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_31 and not isNil(var_20_29) then
				local var_20_32 = (arg_17_1.time_ - var_20_30) / var_20_31

				if arg_17_1.var_.characterEffect1024ui_story and not isNil(var_20_29) then
					local var_20_33 = Mathf.Lerp(0, 0.5, var_20_32)

					arg_17_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1024ui_story.fillRatio = var_20_33
				end
			end

			if arg_17_1.time_ >= var_20_30 + var_20_31 and arg_17_1.time_ < var_20_30 + var_20_31 + arg_20_0 and not isNil(var_20_29) and arg_17_1.var_.characterEffect1024ui_story then
				local var_20_34 = 0.5

				arg_17_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1024ui_story.fillRatio = var_20_34
			end

			local var_20_35 = 0

			if var_20_35 < arg_17_1.time_ and arg_17_1.time_ <= var_20_35 + arg_20_0 then
				arg_17_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action4_2")
			end

			local var_20_36 = 0
			local var_20_37 = 1.275

			if var_20_36 < arg_17_1.time_ and arg_17_1.time_ <= var_20_36 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_38 = arg_17_1:FormatText(StoryNameCfg[263].name)

				arg_17_1.leftNameTxt_.text = var_20_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_39 = arg_17_1:GetWordFromCfg(115131004)
				local var_20_40 = arg_17_1:FormatText(var_20_39.content)

				arg_17_1.text_.text = var_20_40

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_41 = 52
				local var_20_42 = utf8.len(var_20_40)
				local var_20_43 = var_20_41 <= 0 and var_20_37 or var_20_37 * (var_20_42 / var_20_41)

				if var_20_43 > 0 and var_20_37 < var_20_43 then
					arg_17_1.talkMaxDuration = var_20_43

					if var_20_43 + var_20_36 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_43 + var_20_36
					end
				end

				arg_17_1.text_.text = var_20_40
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131004", "story_v_out_115131.awb") ~= 0 then
					local var_20_44 = manager.audio:GetVoiceLength("story_v_out_115131", "115131004", "story_v_out_115131.awb") / 1000

					if var_20_44 + var_20_36 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_44 + var_20_36
					end

					if var_20_39.prefab_name ~= "" and arg_17_1.actors_[var_20_39.prefab_name] ~= nil then
						local var_20_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_39.prefab_name].transform, "story_v_out_115131", "115131004", "story_v_out_115131.awb")

						arg_17_1:RecordAudio("115131004", var_20_45)
						arg_17_1:RecordAudio("115131004", var_20_45)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_115131", "115131004", "story_v_out_115131.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_115131", "115131004", "story_v_out_115131.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_46 = math.max(var_20_37, arg_17_1.talkMaxDuration)

			if var_20_36 <= arg_17_1.time_ and arg_17_1.time_ < var_20_36 + var_20_46 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_36) / var_20_46

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_36 + var_20_46 and arg_17_1.time_ < var_20_36 + var_20_46 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
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
	Play115131005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115131005
		arg_21_1.duration_ = 8.6

		local var_21_0 = {
			ja = 6.533,
			ko = 8,
			zh = 8.6,
			en = 6.3
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
				arg_21_0:Play115131006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_24_1 = 0
			local var_24_2 = 0.75

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_3 = arg_21_1:FormatText(StoryNameCfg[263].name)

				arg_21_1.leftNameTxt_.text = var_24_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(115131005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 30
				local var_24_7 = utf8.len(var_24_5)
				local var_24_8 = var_24_6 <= 0 and var_24_2 or var_24_2 * (var_24_7 / var_24_6)

				if var_24_8 > 0 and var_24_2 < var_24_8 then
					arg_21_1.talkMaxDuration = var_24_8

					if var_24_8 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131005", "story_v_out_115131.awb") ~= 0 then
					local var_24_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131005", "story_v_out_115131.awb") / 1000

					if var_24_9 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_1
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_115131", "115131005", "story_v_out_115131.awb")

						arg_21_1:RecordAudio("115131005", var_24_10)
						arg_21_1:RecordAudio("115131005", var_24_10)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_115131", "115131005", "story_v_out_115131.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_115131", "115131005", "story_v_out_115131.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_11 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_11 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_11

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_11 and arg_21_1.time_ < var_24_1 + var_24_11 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play115131006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 115131006
		arg_25_1.duration_ = 2

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play115131007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1052ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1052ui_story == nil then
				arg_25_1.var_.characterEffect1052ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1052ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1052ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1052ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1052ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_7 = arg_25_1.actors_["1024ui_story"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.characterEffect1024ui_story == nil then
				arg_25_1.var_.characterEffect1024ui_story = var_28_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_9 = 0.2

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.characterEffect1024ui_story and not isNil(var_28_7) then
					arg_25_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.characterEffect1024ui_story then
				arg_25_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_28_11 = 0
			local var_28_12 = 0.175

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_13 = arg_25_1:FormatText(StoryNameCfg[265].name)

				arg_25_1.leftNameTxt_.text = var_28_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_14 = arg_25_1:GetWordFromCfg(115131006)
				local var_28_15 = arg_25_1:FormatText(var_28_14.content)

				arg_25_1.text_.text = var_28_15

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_16 = 7
				local var_28_17 = utf8.len(var_28_15)
				local var_28_18 = var_28_16 <= 0 and var_28_12 or var_28_12 * (var_28_17 / var_28_16)

				if var_28_18 > 0 and var_28_12 < var_28_18 then
					arg_25_1.talkMaxDuration = var_28_18

					if var_28_18 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_11
					end
				end

				arg_25_1.text_.text = var_28_15
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131006", "story_v_out_115131.awb") ~= 0 then
					local var_28_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131006", "story_v_out_115131.awb") / 1000

					if var_28_19 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_11
					end

					if var_28_14.prefab_name ~= "" and arg_25_1.actors_[var_28_14.prefab_name] ~= nil then
						local var_28_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_14.prefab_name].transform, "story_v_out_115131", "115131006", "story_v_out_115131.awb")

						arg_25_1:RecordAudio("115131006", var_28_20)
						arg_25_1:RecordAudio("115131006", var_28_20)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_115131", "115131006", "story_v_out_115131.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_115131", "115131006", "story_v_out_115131.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_21 = math.max(var_28_12, arg_25_1.talkMaxDuration)

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_21 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_11) / var_28_21

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_11 + var_28_21 and arg_25_1.time_ < var_28_11 + var_28_21 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play115131007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 115131007
		arg_29_1.duration_ = 18.7

		local var_29_0 = {
			ja = 18.7,
			ko = 15.133,
			zh = 17.9,
			en = 11.933
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
				arg_29_0:Play115131008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1052ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1052ui_story == nil then
				arg_29_1.var_.characterEffect1052ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1052ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1052ui_story then
				arg_29_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_32_4 = arg_29_1.actors_["1024ui_story"]
			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect1024ui_story == nil then
				arg_29_1.var_.characterEffect1024ui_story = var_32_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.2

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 and not isNil(var_32_4) then
				local var_32_7 = (arg_29_1.time_ - var_32_5) / var_32_6

				if arg_29_1.var_.characterEffect1024ui_story and not isNil(var_32_4) then
					local var_32_8 = Mathf.Lerp(0, 0.5, var_32_7)

					arg_29_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1024ui_story.fillRatio = var_32_8
				end
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect1024ui_story then
				local var_32_9 = 0.5

				arg_29_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1024ui_story.fillRatio = var_32_9
			end

			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_32_11 = 0
			local var_32_12 = 1.55

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_13 = arg_29_1:FormatText(StoryNameCfg[263].name)

				arg_29_1.leftNameTxt_.text = var_32_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(115131007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 62
				local var_32_17 = utf8.len(var_32_15)
				local var_32_18 = var_32_16 <= 0 and var_32_12 or var_32_12 * (var_32_17 / var_32_16)

				if var_32_18 > 0 and var_32_12 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18

					if var_32_18 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131007", "story_v_out_115131.awb") ~= 0 then
					local var_32_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131007", "story_v_out_115131.awb") / 1000

					if var_32_19 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_11
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_out_115131", "115131007", "story_v_out_115131.awb")

						arg_29_1:RecordAudio("115131007", var_32_20)
						arg_29_1:RecordAudio("115131007", var_32_20)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_115131", "115131007", "story_v_out_115131.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_115131", "115131007", "story_v_out_115131.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_21 and arg_29_1.time_ < var_32_11 + var_32_21 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play115131008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 115131008
		arg_33_1.duration_ = 10.7

		local var_33_0 = {
			ja = 7.833,
			ko = 10.5,
			zh = 10.7,
			en = 9.733
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
				arg_33_0:Play115131009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1052ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1052ui_story == nil then
				arg_33_1.var_.characterEffect1052ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1052ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1052ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1052ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1052ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 1.225

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[273].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(115131008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 49
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131008", "story_v_out_115131.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_115131", "115131008", "story_v_out_115131.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_out_115131", "115131008", "story_v_out_115131.awb")

						arg_33_1:RecordAudio("115131008", var_36_15)
						arg_33_1:RecordAudio("115131008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_115131", "115131008", "story_v_out_115131.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_115131", "115131008", "story_v_out_115131.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_16 and arg_33_1.time_ < var_36_6 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play115131009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 115131009
		arg_37_1.duration_ = 2

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play115131010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_40_1 = arg_37_1.actors_["1024ui_story"]
			local var_40_2 = 0

			if var_40_2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1024ui_story == nil then
				arg_37_1.var_.characterEffect1024ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.2

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_3 and not isNil(var_40_1) then
				local var_40_4 = (arg_37_1.time_ - var_40_2) / var_40_3

				if arg_37_1.var_.characterEffect1024ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_2 + var_40_3 and arg_37_1.time_ < var_40_2 + var_40_3 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1024ui_story then
				arg_37_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_40_5 = 0
			local var_40_6 = 0.05

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_7 = arg_37_1:FormatText(StoryNameCfg[265].name)

				arg_37_1.leftNameTxt_.text = var_40_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(115131009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 2
				local var_40_11 = utf8.len(var_40_9)
				local var_40_12 = var_40_10 <= 0 and var_40_6 or var_40_6 * (var_40_11 / var_40_10)

				if var_40_12 > 0 and var_40_6 < var_40_12 then
					arg_37_1.talkMaxDuration = var_40_12

					if var_40_12 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131009", "story_v_out_115131.awb") ~= 0 then
					local var_40_13 = manager.audio:GetVoiceLength("story_v_out_115131", "115131009", "story_v_out_115131.awb") / 1000

					if var_40_13 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_5
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_115131", "115131009", "story_v_out_115131.awb")

						arg_37_1:RecordAudio("115131009", var_40_14)
						arg_37_1:RecordAudio("115131009", var_40_14)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_115131", "115131009", "story_v_out_115131.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_115131", "115131009", "story_v_out_115131.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_15 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_15 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_15

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_15 and arg_37_1.time_ < var_40_5 + var_40_15 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play115131010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 115131010
		arg_41_1.duration_ = 13.63

		local var_41_0 = {
			ja = 13.633,
			ko = 10.366,
			zh = 7.866,
			en = 9.133
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
				arg_41_0:Play115131011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_1")
			end

			local var_44_2 = 0
			local var_44_3 = 1.05

			if var_44_2 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_4 = arg_41_1:FormatText(StoryNameCfg[265].name)

				arg_41_1.leftNameTxt_.text = var_44_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_5 = arg_41_1:GetWordFromCfg(115131010)
				local var_44_6 = arg_41_1:FormatText(var_44_5.content)

				arg_41_1.text_.text = var_44_6

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 42
				local var_44_8 = utf8.len(var_44_6)
				local var_44_9 = var_44_7 <= 0 and var_44_3 or var_44_3 * (var_44_8 / var_44_7)

				if var_44_9 > 0 and var_44_3 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_6
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131010", "story_v_out_115131.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131010", "story_v_out_115131.awb") / 1000

					if var_44_10 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_2
					end

					if var_44_5.prefab_name ~= "" and arg_41_1.actors_[var_44_5.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_5.prefab_name].transform, "story_v_out_115131", "115131010", "story_v_out_115131.awb")

						arg_41_1:RecordAudio("115131010", var_44_11)
						arg_41_1:RecordAudio("115131010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_115131", "115131010", "story_v_out_115131.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_115131", "115131010", "story_v_out_115131.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_12 and arg_41_1.time_ < var_44_2 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play115131011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 115131011
		arg_45_1.duration_ = 8.4

		local var_45_0 = {
			ja = 6.333,
			ko = 7.4,
			zh = 6.866,
			en = 8.4
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
				arg_45_0:Play115131012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_2")
			end

			local var_48_2 = 0
			local var_48_3 = 0.925

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_4 = arg_45_1:FormatText(StoryNameCfg[265].name)

				arg_45_1.leftNameTxt_.text = var_48_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_5 = arg_45_1:GetWordFromCfg(115131011)
				local var_48_6 = arg_45_1:FormatText(var_48_5.content)

				arg_45_1.text_.text = var_48_6

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 37
				local var_48_8 = utf8.len(var_48_6)
				local var_48_9 = var_48_7 <= 0 and var_48_3 or var_48_3 * (var_48_8 / var_48_7)

				if var_48_9 > 0 and var_48_3 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_6
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131011", "story_v_out_115131.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131011", "story_v_out_115131.awb") / 1000

					if var_48_10 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_2
					end

					if var_48_5.prefab_name ~= "" and arg_45_1.actors_[var_48_5.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_5.prefab_name].transform, "story_v_out_115131", "115131011", "story_v_out_115131.awb")

						arg_45_1:RecordAudio("115131011", var_48_11)
						arg_45_1:RecordAudio("115131011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_115131", "115131011", "story_v_out_115131.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_115131", "115131011", "story_v_out_115131.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_12 and arg_45_1.time_ < var_48_2 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play115131012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 115131012
		arg_49_1.duration_ = 9.73

		local var_49_0 = {
			ja = 6.566,
			ko = 8.2,
			zh = 9.733,
			en = 8.7
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
				arg_49_0:Play115131013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1052ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1052ui_story == nil then
				arg_49_1.var_.characterEffect1052ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1052ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1052ui_story then
				arg_49_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_52_4 = arg_49_1.actors_["1024ui_story"]
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1024ui_story == nil then
				arg_49_1.var_.characterEffect1024ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.2

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 and not isNil(var_52_4) then
				local var_52_7 = (arg_49_1.time_ - var_52_5) / var_52_6

				if arg_49_1.var_.characterEffect1024ui_story and not isNil(var_52_4) then
					local var_52_8 = Mathf.Lerp(0, 0.5, var_52_7)

					arg_49_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1024ui_story.fillRatio = var_52_8
				end
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1024ui_story then
				local var_52_9 = 0.5

				arg_49_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1024ui_story.fillRatio = var_52_9
			end

			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action7_1")
			end

			local var_52_11 = 0

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_52_12 = 0
			local var_52_13 = 0.925

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_14 = arg_49_1:FormatText(StoryNameCfg[263].name)

				arg_49_1.leftNameTxt_.text = var_52_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_15 = arg_49_1:GetWordFromCfg(115131012)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 37
				local var_52_18 = utf8.len(var_52_16)
				local var_52_19 = var_52_17 <= 0 and var_52_13 or var_52_13 * (var_52_18 / var_52_17)

				if var_52_19 > 0 and var_52_13 < var_52_19 then
					arg_49_1.talkMaxDuration = var_52_19

					if var_52_19 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_16
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131012", "story_v_out_115131.awb") ~= 0 then
					local var_52_20 = manager.audio:GetVoiceLength("story_v_out_115131", "115131012", "story_v_out_115131.awb") / 1000

					if var_52_20 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_20 + var_52_12
					end

					if var_52_15.prefab_name ~= "" and arg_49_1.actors_[var_52_15.prefab_name] ~= nil then
						local var_52_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_15.prefab_name].transform, "story_v_out_115131", "115131012", "story_v_out_115131.awb")

						arg_49_1:RecordAudio("115131012", var_52_21)
						arg_49_1:RecordAudio("115131012", var_52_21)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_115131", "115131012", "story_v_out_115131.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_115131", "115131012", "story_v_out_115131.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_22 and arg_49_1.time_ < var_52_12 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play115131013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 115131013
		arg_53_1.duration_ = 13.2

		local var_53_0 = {
			ja = 13.2,
			ko = 8.366,
			zh = 9.633,
			en = 7.666
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
				arg_53_0:Play115131014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_56_1 = 0
			local var_56_2 = 0.825

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_3 = arg_53_1:FormatText(StoryNameCfg[263].name)

				arg_53_1.leftNameTxt_.text = var_56_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(115131013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 33
				local var_56_7 = utf8.len(var_56_5)
				local var_56_8 = var_56_6 <= 0 and var_56_2 or var_56_2 * (var_56_7 / var_56_6)

				if var_56_8 > 0 and var_56_2 < var_56_8 then
					arg_53_1.talkMaxDuration = var_56_8

					if var_56_8 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131013", "story_v_out_115131.awb") ~= 0 then
					local var_56_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131013", "story_v_out_115131.awb") / 1000

					if var_56_9 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_1
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_115131", "115131013", "story_v_out_115131.awb")

						arg_53_1:RecordAudio("115131013", var_56_10)
						arg_53_1:RecordAudio("115131013", var_56_10)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_115131", "115131013", "story_v_out_115131.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_115131", "115131013", "story_v_out_115131.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_11 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_11 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_11

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_11 and arg_53_1.time_ < var_56_1 + var_56_11 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play115131014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 115131014
		arg_57_1.duration_ = 12.03

		local var_57_0 = {
			ja = 12.033,
			ko = 6.566,
			zh = 5.8,
			en = 5.833
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
				arg_57_0:Play115131015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_60_1 = 0
			local var_60_2 = 0.425

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_3 = arg_57_1:FormatText(StoryNameCfg[263].name)

				arg_57_1.leftNameTxt_.text = var_60_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(115131014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_6 = 17
				local var_60_7 = utf8.len(var_60_5)
				local var_60_8 = var_60_6 <= 0 and var_60_2 or var_60_2 * (var_60_7 / var_60_6)

				if var_60_8 > 0 and var_60_2 < var_60_8 then
					arg_57_1.talkMaxDuration = var_60_8

					if var_60_8 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131014", "story_v_out_115131.awb") ~= 0 then
					local var_60_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131014", "story_v_out_115131.awb") / 1000

					if var_60_9 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_1
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_115131", "115131014", "story_v_out_115131.awb")

						arg_57_1:RecordAudio("115131014", var_60_10)
						arg_57_1:RecordAudio("115131014", var_60_10)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_115131", "115131014", "story_v_out_115131.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_115131", "115131014", "story_v_out_115131.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_11 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_11 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_11

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_11 and arg_57_1.time_ < var_60_1 + var_60_11 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play115131015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 115131015
		arg_61_1.duration_ = 7.93

		local var_61_0 = {
			ja = 3.9,
			ko = 7.933,
			zh = 5.3,
			en = 5.2
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
				arg_61_0:Play115131016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1052ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1052ui_story == nil then
				arg_61_1.var_.characterEffect1052ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1052ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1052ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1052ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1052ui_story.fillRatio = var_64_5
			end

			local var_64_6 = 0
			local var_64_7 = 0.45

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[273].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_9 = arg_61_1:GetWordFromCfg(115131015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 18
				local var_64_12 = utf8.len(var_64_10)
				local var_64_13 = var_64_11 <= 0 and var_64_7 or var_64_7 * (var_64_12 / var_64_11)

				if var_64_13 > 0 and var_64_7 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131015", "story_v_out_115131.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_115131", "115131015", "story_v_out_115131.awb") / 1000

					if var_64_14 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_6
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_out_115131", "115131015", "story_v_out_115131.awb")

						arg_61_1:RecordAudio("115131015", var_64_15)
						arg_61_1:RecordAudio("115131015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_115131", "115131015", "story_v_out_115131.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_115131", "115131015", "story_v_out_115131.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_16 and arg_61_1.time_ < var_64_6 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play115131016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 115131016
		arg_65_1.duration_ = 15.1

		local var_65_0 = {
			ja = 10.566,
			ko = 15.1,
			zh = 14.266,
			en = 13.2
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
				arg_65_0:Play115131017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1052ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1052ui_story == nil then
				arg_65_1.var_.characterEffect1052ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1052ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1052ui_story then
				arg_65_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_68_4 = 0

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_68_5 = 0
			local var_68_6 = 1.3

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_7 = arg_65_1:FormatText(StoryNameCfg[263].name)

				arg_65_1.leftNameTxt_.text = var_68_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(115131016)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 52
				local var_68_11 = utf8.len(var_68_9)
				local var_68_12 = var_68_10 <= 0 and var_68_6 or var_68_6 * (var_68_11 / var_68_10)

				if var_68_12 > 0 and var_68_6 < var_68_12 then
					arg_65_1.talkMaxDuration = var_68_12

					if var_68_12 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131016", "story_v_out_115131.awb") ~= 0 then
					local var_68_13 = manager.audio:GetVoiceLength("story_v_out_115131", "115131016", "story_v_out_115131.awb") / 1000

					if var_68_13 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_5
					end

					if var_68_8.prefab_name ~= "" and arg_65_1.actors_[var_68_8.prefab_name] ~= nil then
						local var_68_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_8.prefab_name].transform, "story_v_out_115131", "115131016", "story_v_out_115131.awb")

						arg_65_1:RecordAudio("115131016", var_68_14)
						arg_65_1:RecordAudio("115131016", var_68_14)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_115131", "115131016", "story_v_out_115131.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_115131", "115131016", "story_v_out_115131.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_15 = math.max(var_68_6, arg_65_1.talkMaxDuration)

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_15 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_5) / var_68_15

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_5 + var_68_15 and arg_65_1.time_ < var_68_5 + var_68_15 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play115131017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 115131017
		arg_69_1.duration_ = 2.33

		local var_69_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.333,
			en = 1.999999999999
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
				arg_69_0:Play115131018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_72_1 = arg_69_1.actors_["1024ui_story"]
			local var_72_2 = 0

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1024ui_story == nil then
				arg_69_1.var_.characterEffect1024ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_3 = 0.2

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_3 and not isNil(var_72_1) then
				local var_72_4 = (arg_69_1.time_ - var_72_2) / var_72_3

				if arg_69_1.var_.characterEffect1024ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_2 + var_72_3 and arg_69_1.time_ < var_72_2 + var_72_3 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1024ui_story then
				arg_69_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_72_5 = arg_69_1.actors_["1052ui_story"]
			local var_72_6 = 0

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1052ui_story == nil then
				arg_69_1.var_.characterEffect1052ui_story = var_72_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_7 = 0.2

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_7 and not isNil(var_72_5) then
				local var_72_8 = (arg_69_1.time_ - var_72_6) / var_72_7

				if arg_69_1.var_.characterEffect1052ui_story and not isNil(var_72_5) then
					local var_72_9 = Mathf.Lerp(0, 0.5, var_72_8)

					arg_69_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1052ui_story.fillRatio = var_72_9
				end
			end

			if arg_69_1.time_ >= var_72_6 + var_72_7 and arg_69_1.time_ < var_72_6 + var_72_7 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1052ui_story then
				local var_72_10 = 0.5

				arg_69_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1052ui_story.fillRatio = var_72_10
			end

			local var_72_11 = 0
			local var_72_12 = 0.1

			if var_72_11 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_13 = arg_69_1:FormatText(StoryNameCfg[265].name)

				arg_69_1.leftNameTxt_.text = var_72_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_14 = arg_69_1:GetWordFromCfg(115131017)
				local var_72_15 = arg_69_1:FormatText(var_72_14.content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_16 = 4
				local var_72_17 = utf8.len(var_72_15)
				local var_72_18 = var_72_16 <= 0 and var_72_12 or var_72_12 * (var_72_17 / var_72_16)

				if var_72_18 > 0 and var_72_12 < var_72_18 then
					arg_69_1.talkMaxDuration = var_72_18

					if var_72_18 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_11
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131017", "story_v_out_115131.awb") ~= 0 then
					local var_72_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131017", "story_v_out_115131.awb") / 1000

					if var_72_19 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_19 + var_72_11
					end

					if var_72_14.prefab_name ~= "" and arg_69_1.actors_[var_72_14.prefab_name] ~= nil then
						local var_72_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_14.prefab_name].transform, "story_v_out_115131", "115131017", "story_v_out_115131.awb")

						arg_69_1:RecordAudio("115131017", var_72_20)
						arg_69_1:RecordAudio("115131017", var_72_20)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_115131", "115131017", "story_v_out_115131.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_115131", "115131017", "story_v_out_115131.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_21 = math.max(var_72_12, arg_69_1.talkMaxDuration)

			if var_72_11 <= arg_69_1.time_ and arg_69_1.time_ < var_72_11 + var_72_21 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_11) / var_72_21

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_11 + var_72_21 and arg_69_1.time_ < var_72_11 + var_72_21 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play115131018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 115131018
		arg_73_1.duration_ = 6.77

		local var_73_0 = {
			ja = 5.2,
			ko = 6,
			zh = 6.766,
			en = 4.466
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play115131019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1024ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1024ui_story == nil then
				arg_73_1.var_.characterEffect1024ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1024ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1024ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1024ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1024ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_76_7 = arg_73_1.actors_["1052ui_story"]
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.characterEffect1052ui_story == nil then
				arg_73_1.var_.characterEffect1052ui_story = var_76_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_9 = 0.2

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 and not isNil(var_76_7) then
				local var_76_10 = (arg_73_1.time_ - var_76_8) / var_76_9

				if arg_73_1.var_.characterEffect1052ui_story and not isNil(var_76_7) then
					arg_73_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.characterEffect1052ui_story then
				arg_73_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_76_11 = 0
			local var_76_12 = 0.5

			if var_76_11 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_13 = arg_73_1:FormatText(StoryNameCfg[263].name)

				arg_73_1.leftNameTxt_.text = var_76_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_14 = arg_73_1:GetWordFromCfg(115131018)
				local var_76_15 = arg_73_1:FormatText(var_76_14.content)

				arg_73_1.text_.text = var_76_15

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_16 = 20
				local var_76_17 = utf8.len(var_76_15)
				local var_76_18 = var_76_16 <= 0 and var_76_12 or var_76_12 * (var_76_17 / var_76_16)

				if var_76_18 > 0 and var_76_12 < var_76_18 then
					arg_73_1.talkMaxDuration = var_76_18

					if var_76_18 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_18 + var_76_11
					end
				end

				arg_73_1.text_.text = var_76_15
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131018", "story_v_out_115131.awb") ~= 0 then
					local var_76_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131018", "story_v_out_115131.awb") / 1000

					if var_76_19 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_11
					end

					if var_76_14.prefab_name ~= "" and arg_73_1.actors_[var_76_14.prefab_name] ~= nil then
						local var_76_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_14.prefab_name].transform, "story_v_out_115131", "115131018", "story_v_out_115131.awb")

						arg_73_1:RecordAudio("115131018", var_76_20)
						arg_73_1:RecordAudio("115131018", var_76_20)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_115131", "115131018", "story_v_out_115131.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_115131", "115131018", "story_v_out_115131.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_21 = math.max(var_76_12, arg_73_1.talkMaxDuration)

			if var_76_11 <= arg_73_1.time_ and arg_73_1.time_ < var_76_11 + var_76_21 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_11) / var_76_21

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_11 + var_76_21 and arg_73_1.time_ < var_76_11 + var_76_21 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play115131019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 115131019
		arg_77_1.duration_ = 5.7

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play115131020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1052ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1052ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, 100, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1052ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, 100, 0)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["1024ui_story"].transform
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.var_.moveOldPos1024ui_story = var_80_9.localPosition
			end

			local var_80_11 = 0.001

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11
				local var_80_13 = Vector3.New(0, 100, 0)

				var_80_9.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1024ui_story, var_80_13, var_80_12)

				local var_80_14 = manager.ui.mainCamera.transform.position - var_80_9.position

				var_80_9.forward = Vector3.New(var_80_14.x, var_80_14.y, var_80_14.z)

				local var_80_15 = var_80_9.localEulerAngles

				var_80_15.z = 0
				var_80_15.x = 0
				var_80_9.localEulerAngles = var_80_15
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 then
				var_80_9.localPosition = Vector3.New(0, 100, 0)

				local var_80_16 = manager.ui.mainCamera.transform.position - var_80_9.position

				var_80_9.forward = Vector3.New(var_80_16.x, var_80_16.y, var_80_16.z)

				local var_80_17 = var_80_9.localEulerAngles

				var_80_17.z = 0
				var_80_17.x = 0
				var_80_9.localEulerAngles = var_80_17
			end

			local var_80_18 = arg_77_1.bgs_.G03a
			local var_80_19 = 0

			if var_80_19 < arg_77_1.time_ and arg_77_1.time_ <= var_80_19 + arg_80_0 then
				local var_80_20 = var_80_18:GetComponent("SpriteRenderer")

				if var_80_20 then
					arg_77_1.var_.alphaOldValueG03a = var_80_20.color.a
					arg_77_1.var_.alphaMatValueG03a = var_80_20
				end

				arg_77_1.var_.alphaOldValueG03a = 1
			end

			local var_80_21 = 2

			if var_80_19 <= arg_77_1.time_ and arg_77_1.time_ < var_80_19 + var_80_21 then
				local var_80_22 = (arg_77_1.time_ - var_80_19) / var_80_21
				local var_80_23 = Mathf.Lerp(arg_77_1.var_.alphaOldValueG03a, 0, var_80_22)

				if arg_77_1.var_.alphaMatValueG03a then
					local var_80_24 = arg_77_1.var_.alphaMatValueG03a.color

					var_80_24.a = var_80_23
					arg_77_1.var_.alphaMatValueG03a.color = var_80_24
				end
			end

			if arg_77_1.time_ >= var_80_19 + var_80_21 and arg_77_1.time_ < var_80_19 + var_80_21 + arg_80_0 and arg_77_1.var_.alphaMatValueG03a then
				local var_80_25 = arg_77_1.var_.alphaMatValueG03a
				local var_80_26 = var_80_25.color

				var_80_26.a = 0
				var_80_25.color = var_80_26
			end

			local var_80_27 = 0

			if var_80_27 < arg_77_1.time_ and arg_77_1.time_ <= var_80_27 + arg_80_0 then
				arg_77_1.fswbg_:SetActive(true)
				arg_77_1.dialog_:SetActive(false)

				arg_77_1.fswtw_.percent = 0

				local var_80_28 = arg_77_1:GetWordFromCfg(115131019)
				local var_80_29 = arg_77_1:FormatText(var_80_28.content)

				arg_77_1.fswt_.text = var_80_29

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.fswt_)

				arg_77_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_77_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_77_1.fswtw_:SetDirty()

				arg_77_1.typewritterCharCountI18N = 0

				SetActive(arg_77_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_77_1:ShowNextGo(false)
			end

			local var_80_30 = 2

			if var_80_30 < arg_77_1.time_ and arg_77_1.time_ <= var_80_30 + arg_80_0 then
				arg_77_1.var_.oldValueTypewriter = arg_77_1.fswtw_.percent

				SetActive(arg_77_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_77_1:ShowNextGo(false)
			end

			local var_80_31 = 32
			local var_80_32 = 2.13333333333333
			local var_80_33 = arg_77_1:GetWordFromCfg(115131019)
			local var_80_34 = arg_77_1:FormatText(var_80_33.content)
			local var_80_35, var_80_36 = arg_77_1:GetPercentByPara(var_80_34, 1)

			if var_80_30 < arg_77_1.time_ and arg_77_1.time_ <= var_80_30 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				local var_80_37 = var_80_31 <= 0 and var_80_32 or var_80_32 * ((var_80_36 - arg_77_1.typewritterCharCountI18N) / var_80_31)

				if var_80_37 > 0 and var_80_32 < var_80_37 then
					arg_77_1.talkMaxDuration = var_80_37

					if var_80_37 + var_80_30 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_37 + var_80_30
					end
				end
			end

			local var_80_38 = 2.13333333333333
			local var_80_39 = math.max(var_80_38, arg_77_1.talkMaxDuration)

			if var_80_30 <= arg_77_1.time_ and arg_77_1.time_ < var_80_30 + var_80_39 then
				local var_80_40 = (arg_77_1.time_ - var_80_30) / var_80_39

				arg_77_1.fswtw_.percent = Mathf.Lerp(arg_77_1.var_.oldValueTypewriter, var_80_35, var_80_40)
				arg_77_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_77_1.fswtw_:SetDirty()
			end

			if arg_77_1.time_ >= var_80_30 + var_80_39 and arg_77_1.time_ < var_80_30 + var_80_39 + arg_80_0 then
				arg_77_1.fswtw_.percent = var_80_35

				arg_77_1.fswtw_:SetDirty()
				arg_77_1:ShowNextGo(true)

				arg_77_1.typewritterCharCountI18N = var_80_36
			end

			local var_80_41 = 2

			if var_80_41 < arg_77_1.time_ and arg_77_1.time_ <= var_80_41 + arg_80_0 then
				local var_80_42 = arg_77_1.fswbg_.transform:Find("textbox/adapt/content") or arg_77_1.fswbg_.transform:Find("textbox/content")
				local var_80_43 = arg_77_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_80_44 = var_80_42:GetComponent("Text")
				local var_80_45 = var_80_42:GetComponent("RectTransform")

				var_80_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_80_45.offsetMin = Vector2.New(0, 0)
				var_80_45.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play115131020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 115131020
		arg_81_1.duration_ = 7.12

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play115131021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.fswbg_:SetActive(true)
				arg_81_1.dialog_:SetActive(false)

				arg_81_1.fswtw_.percent = 0

				local var_84_1 = arg_81_1:GetWordFromCfg(115131020)
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

			local var_84_3 = 0.0166666666666667

			if var_84_3 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.var_.oldValueTypewriter = arg_81_1.fswtw_.percent

				SetActive(arg_81_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_81_1:ShowNextGo(false)
			end

			local var_84_4 = 27
			local var_84_5 = 1.8
			local var_84_6 = arg_81_1:GetWordFromCfg(115131020)
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

			local var_84_11 = 1.8
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

			local var_84_14 = 0
			local var_84_15 = 7.122
			local var_84_16 = manager.audio:GetVoiceLength("story_v_out_115131", "115131020", "story_v_out_115131.awb") / 1000

			if var_84_16 > 0 and var_84_15 < var_84_16 and var_84_16 + var_84_14 > arg_81_1.duration_ then
				local var_84_17 = var_84_16

				arg_81_1.duration_ = var_84_16 + var_84_14
			end

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				local var_84_18 = "play"
				local var_84_19 = "voice"

				arg_81_1:AudioAction(var_84_18, var_84_19, "story_v_out_115131", "115131020", "story_v_out_115131.awb")
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play115131021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 115131021
		arg_85_1.duration_ = 10.62

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play115131022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.fswbg_:SetActive(true)
				arg_85_1.dialog_:SetActive(false)

				arg_85_1.fswtw_.percent = 0

				local var_88_1 = arg_85_1:GetWordFromCfg(115131021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.fswt_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.fswt_)

				arg_85_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_85_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_85_1.fswtw_:SetDirty()

				arg_85_1.typewritterCharCountI18N = 0

				SetActive(arg_85_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_85_1:ShowNextGo(false)
			end

			local var_88_3 = 0.0166666666666667

			if var_88_3 < arg_85_1.time_ and arg_85_1.time_ <= var_88_3 + arg_88_0 then
				arg_85_1.var_.oldValueTypewriter = arg_85_1.fswtw_.percent

				SetActive(arg_85_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_85_1:ShowNextGo(false)
			end

			local var_88_4 = 39
			local var_88_5 = 2.6
			local var_88_6 = arg_85_1:GetWordFromCfg(115131021)
			local var_88_7 = arg_85_1:FormatText(var_88_6.content)
			local var_88_8, var_88_9 = arg_85_1:GetPercentByPara(var_88_7, 1)

			if var_88_3 < arg_85_1.time_ and arg_85_1.time_ <= var_88_3 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				local var_88_10 = var_88_4 <= 0 and var_88_5 or var_88_5 * ((var_88_9 - arg_85_1.typewritterCharCountI18N) / var_88_4)

				if var_88_10 > 0 and var_88_5 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_3 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_3
					end
				end
			end

			local var_88_11 = 2.6
			local var_88_12 = math.max(var_88_11, arg_85_1.talkMaxDuration)

			if var_88_3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_3 + var_88_12 then
				local var_88_13 = (arg_85_1.time_ - var_88_3) / var_88_12

				arg_85_1.fswtw_.percent = Mathf.Lerp(arg_85_1.var_.oldValueTypewriter, var_88_8, var_88_13)
				arg_85_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_85_1.fswtw_:SetDirty()
			end

			if arg_85_1.time_ >= var_88_3 + var_88_12 and arg_85_1.time_ < var_88_3 + var_88_12 + arg_88_0 then
				arg_85_1.fswtw_.percent = var_88_8

				arg_85_1.fswtw_:SetDirty()
				arg_85_1:ShowNextGo(true)

				arg_85_1.typewritterCharCountI18N = var_88_9
			end

			local var_88_14 = 0
			local var_88_15 = 10.621
			local var_88_16 = manager.audio:GetVoiceLength("story_v_out_115131", "115131021", "story_v_out_115131.awb") / 1000

			if var_88_16 > 0 and var_88_15 < var_88_16 and var_88_16 + var_88_14 > arg_85_1.duration_ then
				local var_88_17 = var_88_16

				arg_85_1.duration_ = var_88_16 + var_88_14
			end

			if var_88_14 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				local var_88_18 = "play"
				local var_88_19 = "voice"

				arg_85_1:AudioAction(var_88_18, var_88_19, "story_v_out_115131", "115131021", "story_v_out_115131.awb")
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play115131022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 115131022
		arg_89_1.duration_ = 8.2

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play115131023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.fswbg_:SetActive(true)
				arg_89_1.dialog_:SetActive(false)

				arg_89_1.fswtw_.percent = 0

				local var_92_1 = arg_89_1:GetWordFromCfg(115131022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.fswt_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.fswt_)

				arg_89_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_89_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_89_1.fswtw_:SetDirty()

				arg_89_1.typewritterCharCountI18N = 0

				SetActive(arg_89_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_89_1:ShowNextGo(false)
			end

			local var_92_3 = 0.0166666666666667

			if var_92_3 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.var_.oldValueTypewriter = arg_89_1.fswtw_.percent

				SetActive(arg_89_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_89_1:ShowNextGo(false)
			end

			local var_92_4 = 32
			local var_92_5 = 2.13333333333333
			local var_92_6 = arg_89_1:GetWordFromCfg(115131022)
			local var_92_7 = arg_89_1:FormatText(var_92_6.content)
			local var_92_8, var_92_9 = arg_89_1:GetPercentByPara(var_92_7, 1)

			if var_92_3 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				local var_92_10 = var_92_4 <= 0 and var_92_5 or var_92_5 * ((var_92_9 - arg_89_1.typewritterCharCountI18N) / var_92_4)

				if var_92_10 > 0 and var_92_5 < var_92_10 then
					arg_89_1.talkMaxDuration = var_92_10

					if var_92_10 + var_92_3 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_3
					end
				end
			end

			local var_92_11 = 2.13333333333333
			local var_92_12 = math.max(var_92_11, arg_89_1.talkMaxDuration)

			if var_92_3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_3 + var_92_12 then
				local var_92_13 = (arg_89_1.time_ - var_92_3) / var_92_12

				arg_89_1.fswtw_.percent = Mathf.Lerp(arg_89_1.var_.oldValueTypewriter, var_92_8, var_92_13)
				arg_89_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_89_1.fswtw_:SetDirty()
			end

			if arg_89_1.time_ >= var_92_3 + var_92_12 and arg_89_1.time_ < var_92_3 + var_92_12 + arg_92_0 then
				arg_89_1.fswtw_.percent = var_92_8

				arg_89_1.fswtw_:SetDirty()
				arg_89_1:ShowNextGo(true)

				arg_89_1.typewritterCharCountI18N = var_92_9
			end

			local var_92_14 = 0
			local var_92_15 = 8.203
			local var_92_16 = manager.audio:GetVoiceLength("story_v_out_115131", "115131022", "story_v_out_115131.awb") / 1000

			if var_92_16 > 0 and var_92_15 < var_92_16 and var_92_16 + var_92_14 > arg_89_1.duration_ then
				local var_92_17 = var_92_16

				arg_89_1.duration_ = var_92_16 + var_92_14
			end

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				local var_92_18 = "play"
				local var_92_19 = "voice"

				arg_89_1:AudioAction(var_92_18, var_92_19, "story_v_out_115131", "115131022", "story_v_out_115131.awb")
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play115131023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 115131023
		arg_93_1.duration_ = 6.5

		local var_93_0 = {
			ja = 5.766,
			ko = 5.233333333332,
			zh = 5.233333333332,
			en = 6.5
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
				arg_93_0:Play115131024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = "RO0201"

			if arg_93_1.bgs_[var_96_0] == nil then
				local var_96_1 = Object.Instantiate(arg_93_1.paintGo_)

				var_96_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_96_0)
				var_96_1.name = var_96_0
				var_96_1.transform.parent = arg_93_1.stage_.transform
				var_96_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.bgs_[var_96_0] = var_96_1
			end

			local var_96_2 = 0

			if var_96_2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				local var_96_3 = manager.ui.mainCamera.transform.localPosition
				local var_96_4 = Vector3.New(0, 0, 10) + Vector3.New(var_96_3.x, var_96_3.y, 0)
				local var_96_5 = arg_93_1.bgs_.RO0201

				var_96_5.transform.localPosition = var_96_4
				var_96_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_6 = var_96_5:GetComponent("SpriteRenderer")

				if var_96_6 and var_96_6.sprite then
					local var_96_7 = (var_96_5.transform.localPosition - var_96_3).z
					local var_96_8 = manager.ui.mainCameraCom_
					local var_96_9 = 2 * var_96_7 * Mathf.Tan(var_96_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_96_10 = var_96_9 * var_96_8.aspect
					local var_96_11 = var_96_6.sprite.bounds.size.x
					local var_96_12 = var_96_6.sprite.bounds.size.y
					local var_96_13 = var_96_10 / var_96_11
					local var_96_14 = var_96_9 / var_96_12
					local var_96_15 = var_96_14 < var_96_13 and var_96_13 or var_96_14

					var_96_5.transform.localScale = Vector3.New(var_96_15, var_96_15, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "RO0201" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_17 = 2

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_17 then
				local var_96_18 = (arg_93_1.time_ - var_96_16) / var_96_17
				local var_96_19 = Color.New(0, 0, 0)

				var_96_19.a = Mathf.Lerp(1, 0, var_96_18)
				arg_93_1.mask_.color = var_96_19
			end

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 then
				local var_96_20 = Color.New(0, 0, 0)
				local var_96_21 = 0

				arg_93_1.mask_.enabled = false
				var_96_20.a = var_96_21
				arg_93_1.mask_.color = var_96_20
			end

			local var_96_22 = "105201ui_story"

			if arg_93_1.actors_[var_96_22] == nil then
				local var_96_23 = Asset.Load("Char/" .. "105201ui_story")

				if not isNil(var_96_23) then
					local var_96_24 = Object.Instantiate(Asset.Load("Char/" .. "105201ui_story"), arg_93_1.stage_.transform)

					var_96_24.name = var_96_22
					var_96_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_93_1.actors_[var_96_22] = var_96_24

					local var_96_25 = var_96_24:GetComponentInChildren(typeof(CharacterEffect))

					var_96_25.enabled = true

					local var_96_26 = GameObjectTools.GetOrAddComponent(var_96_24, typeof(DynamicBoneHelper))

					if var_96_26 then
						var_96_26:EnableDynamicBone(false)
					end

					arg_93_1:ShowWeapon(var_96_25.transform, false)

					arg_93_1.var_[var_96_22 .. "Animator"] = var_96_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_93_1.var_[var_96_22 .. "Animator"].applyRootMotion = true
					arg_93_1.var_[var_96_22 .. "LipSync"] = var_96_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_96_27 = arg_93_1.actors_["105201ui_story"].transform
			local var_96_28 = 2.1

			if var_96_28 < arg_93_1.time_ and arg_93_1.time_ <= var_96_28 + arg_96_0 then
				arg_93_1.var_.moveOldPos105201ui_story = var_96_27.localPosition
			end

			local var_96_29 = 0.001

			if var_96_28 <= arg_93_1.time_ and arg_93_1.time_ < var_96_28 + var_96_29 then
				local var_96_30 = (arg_93_1.time_ - var_96_28) / var_96_29
				local var_96_31 = Vector3.New(-0.7, -1.05, -6.2)

				var_96_27.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos105201ui_story, var_96_31, var_96_30)

				local var_96_32 = manager.ui.mainCamera.transform.position - var_96_27.position

				var_96_27.forward = Vector3.New(var_96_32.x, var_96_32.y, var_96_32.z)

				local var_96_33 = var_96_27.localEulerAngles

				var_96_33.z = 0
				var_96_33.x = 0
				var_96_27.localEulerAngles = var_96_33
			end

			if arg_93_1.time_ >= var_96_28 + var_96_29 and arg_93_1.time_ < var_96_28 + var_96_29 + arg_96_0 then
				var_96_27.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_96_34 = manager.ui.mainCamera.transform.position - var_96_27.position

				var_96_27.forward = Vector3.New(var_96_34.x, var_96_34.y, var_96_34.z)

				local var_96_35 = var_96_27.localEulerAngles

				var_96_35.z = 0
				var_96_35.x = 0
				var_96_27.localEulerAngles = var_96_35
			end

			local var_96_36 = 2.1

			if var_96_36 < arg_93_1.time_ and arg_93_1.time_ <= var_96_36 + arg_96_0 then
				arg_93_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_96_37 = 2.1

			if var_96_37 < arg_93_1.time_ and arg_93_1.time_ <= var_96_37 + arg_96_0 then
				arg_93_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_96_38 = arg_93_1.actors_["105201ui_story"]
			local var_96_39 = 2.1

			if var_96_39 < arg_93_1.time_ and arg_93_1.time_ <= var_96_39 + arg_96_0 and not isNil(var_96_38) and arg_93_1.var_.characterEffect105201ui_story == nil then
				arg_93_1.var_.characterEffect105201ui_story = var_96_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_40 = 0.2

			if var_96_39 <= arg_93_1.time_ and arg_93_1.time_ < var_96_39 + var_96_40 and not isNil(var_96_38) then
				local var_96_41 = (arg_93_1.time_ - var_96_39) / var_96_40

				if arg_93_1.var_.characterEffect105201ui_story and not isNil(var_96_38) then
					arg_93_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_39 + var_96_40 and arg_93_1.time_ < var_96_39 + var_96_40 + arg_96_0 and not isNil(var_96_38) and arg_93_1.var_.characterEffect105201ui_story then
				arg_93_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			local var_96_42 = 0

			if var_96_42 < arg_93_1.time_ and arg_93_1.time_ <= var_96_42 + arg_96_0 then
				arg_93_1.fswbg_:SetActive(false)
				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_93_1:ShowNextGo(false)
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_43 = 2
			local var_96_44 = 0.35

			if var_96_43 < arg_93_1.time_ and arg_93_1.time_ <= var_96_43 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_45 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_45:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_46 = arg_93_1:FormatText(StoryNameCfg[263].name)

				arg_93_1.leftNameTxt_.text = var_96_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_47 = arg_93_1:GetWordFromCfg(115131023)
				local var_96_48 = arg_93_1:FormatText(var_96_47.content)

				arg_93_1.text_.text = var_96_48

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_49 = 14
				local var_96_50 = utf8.len(var_96_48)
				local var_96_51 = var_96_49 <= 0 and var_96_44 or var_96_44 * (var_96_50 / var_96_49)

				if var_96_51 > 0 and var_96_44 < var_96_51 then
					arg_93_1.talkMaxDuration = var_96_51
					var_96_43 = var_96_43 + 0.3

					if var_96_51 + var_96_43 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_51 + var_96_43
					end
				end

				arg_93_1.text_.text = var_96_48
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131023", "story_v_out_115131.awb") ~= 0 then
					local var_96_52 = manager.audio:GetVoiceLength("story_v_out_115131", "115131023", "story_v_out_115131.awb") / 1000

					if var_96_52 + var_96_43 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_52 + var_96_43
					end

					if var_96_47.prefab_name ~= "" and arg_93_1.actors_[var_96_47.prefab_name] ~= nil then
						local var_96_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_47.prefab_name].transform, "story_v_out_115131", "115131023", "story_v_out_115131.awb")

						arg_93_1:RecordAudio("115131023", var_96_53)
						arg_93_1:RecordAudio("115131023", var_96_53)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_115131", "115131023", "story_v_out_115131.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_115131", "115131023", "story_v_out_115131.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_54 = var_96_43 + 0.3
			local var_96_55 = math.max(var_96_44, arg_93_1.talkMaxDuration)

			if var_96_54 <= arg_93_1.time_ and arg_93_1.time_ < var_96_54 + var_96_55 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_54) / var_96_55

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_54 + var_96_55 and arg_93_1.time_ < var_96_54 + var_96_55 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play115131024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 115131024
		arg_99_1.duration_ = 11.53

		local var_99_0 = {
			ja = 11.533,
			ko = 6.366,
			zh = 5.1,
			en = 7.3
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
				arg_99_0:Play115131025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["105201ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect105201ui_story == nil then
				arg_99_1.var_.characterEffect105201ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.2

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect105201ui_story and not isNil(var_102_0) then
					local var_102_4 = Mathf.Lerp(0, 0.5, var_102_3)

					arg_99_1.var_.characterEffect105201ui_story.fillFlat = true
					arg_99_1.var_.characterEffect105201ui_story.fillRatio = var_102_4
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect105201ui_story then
				local var_102_5 = 0.5

				arg_99_1.var_.characterEffect105201ui_story.fillFlat = true
				arg_99_1.var_.characterEffect105201ui_story.fillRatio = var_102_5
			end

			local var_102_6 = "10014ui_story"

			if arg_99_1.actors_[var_102_6] == nil then
				local var_102_7 = Asset.Load("Char/" .. "10014ui_story")

				if not isNil(var_102_7) then
					local var_102_8 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_99_1.stage_.transform)

					var_102_8.name = var_102_6
					var_102_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_99_1.actors_[var_102_6] = var_102_8

					local var_102_9 = var_102_8:GetComponentInChildren(typeof(CharacterEffect))

					var_102_9.enabled = true

					local var_102_10 = GameObjectTools.GetOrAddComponent(var_102_8, typeof(DynamicBoneHelper))

					if var_102_10 then
						var_102_10:EnableDynamicBone(false)
					end

					arg_99_1:ShowWeapon(var_102_9.transform, false)

					arg_99_1.var_[var_102_6 .. "Animator"] = var_102_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_99_1.var_[var_102_6 .. "Animator"].applyRootMotion = true
					arg_99_1.var_[var_102_6 .. "LipSync"] = var_102_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_102_11 = arg_99_1.actors_["10014ui_story"].transform
			local var_102_12 = 0

			if var_102_12 < arg_99_1.time_ and arg_99_1.time_ <= var_102_12 + arg_102_0 then
				arg_99_1.var_.moveOldPos10014ui_story = var_102_11.localPosition
			end

			local var_102_13 = 0.001

			if var_102_12 <= arg_99_1.time_ and arg_99_1.time_ < var_102_12 + var_102_13 then
				local var_102_14 = (arg_99_1.time_ - var_102_12) / var_102_13
				local var_102_15 = Vector3.New(0.7, -1.06, -6.2)

				var_102_11.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10014ui_story, var_102_15, var_102_14)

				local var_102_16 = manager.ui.mainCamera.transform.position - var_102_11.position

				var_102_11.forward = Vector3.New(var_102_16.x, var_102_16.y, var_102_16.z)

				local var_102_17 = var_102_11.localEulerAngles

				var_102_17.z = 0
				var_102_17.x = 0
				var_102_11.localEulerAngles = var_102_17
			end

			if arg_99_1.time_ >= var_102_12 + var_102_13 and arg_99_1.time_ < var_102_12 + var_102_13 + arg_102_0 then
				var_102_11.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_102_18 = manager.ui.mainCamera.transform.position - var_102_11.position

				var_102_11.forward = Vector3.New(var_102_18.x, var_102_18.y, var_102_18.z)

				local var_102_19 = var_102_11.localEulerAngles

				var_102_19.z = 0
				var_102_19.x = 0
				var_102_11.localEulerAngles = var_102_19
			end

			local var_102_20 = 0

			if var_102_20 < arg_99_1.time_ and arg_99_1.time_ <= var_102_20 + arg_102_0 then
				arg_99_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_102_21 = arg_99_1.actors_["10014ui_story"]
			local var_102_22 = 0

			if var_102_22 < arg_99_1.time_ and arg_99_1.time_ <= var_102_22 + arg_102_0 and not isNil(var_102_21) and arg_99_1.var_.characterEffect10014ui_story == nil then
				arg_99_1.var_.characterEffect10014ui_story = var_102_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_23 = 0.2

			if var_102_22 <= arg_99_1.time_ and arg_99_1.time_ < var_102_22 + var_102_23 and not isNil(var_102_21) then
				local var_102_24 = (arg_99_1.time_ - var_102_22) / var_102_23

				if arg_99_1.var_.characterEffect10014ui_story and not isNil(var_102_21) then
					arg_99_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_22 + var_102_23 and arg_99_1.time_ < var_102_22 + var_102_23 + arg_102_0 and not isNil(var_102_21) and arg_99_1.var_.characterEffect10014ui_story then
				arg_99_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_102_25 = 0

			if var_102_25 < arg_99_1.time_ and arg_99_1.time_ <= var_102_25 + arg_102_0 then
				arg_99_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_102_26 = 0
			local var_102_27 = 0.575

			if var_102_26 < arg_99_1.time_ and arg_99_1.time_ <= var_102_26 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_28 = arg_99_1:FormatText(StoryNameCfg[264].name)

				arg_99_1.leftNameTxt_.text = var_102_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_29 = arg_99_1:GetWordFromCfg(115131024)
				local var_102_30 = arg_99_1:FormatText(var_102_29.content)

				arg_99_1.text_.text = var_102_30

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_31 = 23
				local var_102_32 = utf8.len(var_102_30)
				local var_102_33 = var_102_31 <= 0 and var_102_27 or var_102_27 * (var_102_32 / var_102_31)

				if var_102_33 > 0 and var_102_27 < var_102_33 then
					arg_99_1.talkMaxDuration = var_102_33

					if var_102_33 + var_102_26 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_33 + var_102_26
					end
				end

				arg_99_1.text_.text = var_102_30
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131024", "story_v_out_115131.awb") ~= 0 then
					local var_102_34 = manager.audio:GetVoiceLength("story_v_out_115131", "115131024", "story_v_out_115131.awb") / 1000

					if var_102_34 + var_102_26 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_34 + var_102_26
					end

					if var_102_29.prefab_name ~= "" and arg_99_1.actors_[var_102_29.prefab_name] ~= nil then
						local var_102_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_29.prefab_name].transform, "story_v_out_115131", "115131024", "story_v_out_115131.awb")

						arg_99_1:RecordAudio("115131024", var_102_35)
						arg_99_1:RecordAudio("115131024", var_102_35)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_115131", "115131024", "story_v_out_115131.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_115131", "115131024", "story_v_out_115131.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_36 = math.max(var_102_27, arg_99_1.talkMaxDuration)

			if var_102_26 <= arg_99_1.time_ and arg_99_1.time_ < var_102_26 + var_102_36 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_26) / var_102_36

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_26 + var_102_36 and arg_99_1.time_ < var_102_26 + var_102_36 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play115131025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 115131025
		arg_103_1.duration_ = 10.07

		local var_103_0 = {
			ja = 10.066,
			ko = 8.033,
			zh = 8.7,
			en = 9.333
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
				arg_103_0:Play115131026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_106_1 = arg_103_1.actors_["105201ui_story"]
			local var_106_2 = 0

			if var_106_2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect105201ui_story == nil then
				arg_103_1.var_.characterEffect105201ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_3 = 0.2

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_3 and not isNil(var_106_1) then
				local var_106_4 = (arg_103_1.time_ - var_106_2) / var_106_3

				if arg_103_1.var_.characterEffect105201ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_2 + var_106_3 and arg_103_1.time_ < var_106_2 + var_106_3 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect105201ui_story then
				arg_103_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			local var_106_5 = arg_103_1.actors_["10014ui_story"]
			local var_106_6 = 0

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 and not isNil(var_106_5) and arg_103_1.var_.characterEffect10014ui_story == nil then
				arg_103_1.var_.characterEffect10014ui_story = var_106_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_7 = 0.2

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_7 and not isNil(var_106_5) then
				local var_106_8 = (arg_103_1.time_ - var_106_6) / var_106_7

				if arg_103_1.var_.characterEffect10014ui_story and not isNil(var_106_5) then
					local var_106_9 = Mathf.Lerp(0, 0.5, var_106_8)

					arg_103_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_103_1.var_.characterEffect10014ui_story.fillRatio = var_106_9
				end
			end

			if arg_103_1.time_ >= var_106_6 + var_106_7 and arg_103_1.time_ < var_106_6 + var_106_7 + arg_106_0 and not isNil(var_106_5) and arg_103_1.var_.characterEffect10014ui_story then
				local var_106_10 = 0.5

				arg_103_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_103_1.var_.characterEffect10014ui_story.fillRatio = var_106_10
			end

			local var_106_11 = 0
			local var_106_12 = 1.125

			if var_106_11 < arg_103_1.time_ and arg_103_1.time_ <= var_106_11 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_13 = arg_103_1:FormatText(StoryNameCfg[263].name)

				arg_103_1.leftNameTxt_.text = var_106_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_14 = arg_103_1:GetWordFromCfg(115131025)
				local var_106_15 = arg_103_1:FormatText(var_106_14.content)

				arg_103_1.text_.text = var_106_15

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_16 = 45
				local var_106_17 = utf8.len(var_106_15)
				local var_106_18 = var_106_16 <= 0 and var_106_12 or var_106_12 * (var_106_17 / var_106_16)

				if var_106_18 > 0 and var_106_12 < var_106_18 then
					arg_103_1.talkMaxDuration = var_106_18

					if var_106_18 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_18 + var_106_11
					end
				end

				arg_103_1.text_.text = var_106_15
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131025", "story_v_out_115131.awb") ~= 0 then
					local var_106_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131025", "story_v_out_115131.awb") / 1000

					if var_106_19 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_19 + var_106_11
					end

					if var_106_14.prefab_name ~= "" and arg_103_1.actors_[var_106_14.prefab_name] ~= nil then
						local var_106_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_14.prefab_name].transform, "story_v_out_115131", "115131025", "story_v_out_115131.awb")

						arg_103_1:RecordAudio("115131025", var_106_20)
						arg_103_1:RecordAudio("115131025", var_106_20)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_115131", "115131025", "story_v_out_115131.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_115131", "115131025", "story_v_out_115131.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_21 = math.max(var_106_12, arg_103_1.talkMaxDuration)

			if var_106_11 <= arg_103_1.time_ and arg_103_1.time_ < var_106_11 + var_106_21 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_11) / var_106_21

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_11 + var_106_21 and arg_103_1.time_ < var_106_11 + var_106_21 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play115131026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 115131026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play115131027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["105201ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos105201ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(0, 100, 0)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos105201ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, 100, 0)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = arg_107_1.actors_["10014ui_story"].transform
			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 then
				arg_107_1.var_.moveOldPos10014ui_story = var_110_9.localPosition
			end

			local var_110_11 = 0.001

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_11 then
				local var_110_12 = (arg_107_1.time_ - var_110_10) / var_110_11
				local var_110_13 = Vector3.New(0, 100, 0)

				var_110_9.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10014ui_story, var_110_13, var_110_12)

				local var_110_14 = manager.ui.mainCamera.transform.position - var_110_9.position

				var_110_9.forward = Vector3.New(var_110_14.x, var_110_14.y, var_110_14.z)

				local var_110_15 = var_110_9.localEulerAngles

				var_110_15.z = 0
				var_110_15.x = 0
				var_110_9.localEulerAngles = var_110_15
			end

			if arg_107_1.time_ >= var_110_10 + var_110_11 and arg_107_1.time_ < var_110_10 + var_110_11 + arg_110_0 then
				var_110_9.localPosition = Vector3.New(0, 100, 0)

				local var_110_16 = manager.ui.mainCamera.transform.position - var_110_9.position

				var_110_9.forward = Vector3.New(var_110_16.x, var_110_16.y, var_110_16.z)

				local var_110_17 = var_110_9.localEulerAngles

				var_110_17.z = 0
				var_110_17.x = 0
				var_110_9.localEulerAngles = var_110_17
			end

			local var_110_18 = 0
			local var_110_19 = 1.275

			if var_110_18 < arg_107_1.time_ and arg_107_1.time_ <= var_110_18 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_20 = arg_107_1:GetWordFromCfg(115131026)
				local var_110_21 = arg_107_1:FormatText(var_110_20.content)

				arg_107_1.text_.text = var_110_21

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_22 = 51
				local var_110_23 = utf8.len(var_110_21)
				local var_110_24 = var_110_22 <= 0 and var_110_19 or var_110_19 * (var_110_23 / var_110_22)

				if var_110_24 > 0 and var_110_19 < var_110_24 then
					arg_107_1.talkMaxDuration = var_110_24

					if var_110_24 + var_110_18 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_24 + var_110_18
					end
				end

				arg_107_1.text_.text = var_110_21
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_25 = math.max(var_110_19, arg_107_1.talkMaxDuration)

			if var_110_18 <= arg_107_1.time_ and arg_107_1.time_ < var_110_18 + var_110_25 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_18) / var_110_25

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_18 + var_110_25 and arg_107_1.time_ < var_110_18 + var_110_25 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play115131027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 115131027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play115131028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 1.025

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_2 = arg_111_1:GetWordFromCfg(115131027)
				local var_114_3 = arg_111_1:FormatText(var_114_2.content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 41
				local var_114_5 = utf8.len(var_114_3)
				local var_114_6 = var_114_4 <= 0 and var_114_1 or var_114_1 * (var_114_5 / var_114_4)

				if var_114_6 > 0 and var_114_1 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_7 and arg_111_1.time_ < var_114_0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play115131028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 115131028
		arg_115_1.duration_ = 14.93

		local var_115_0 = {
			ja = 10.866,
			ko = 14.933,
			zh = 11.666,
			en = 10.766
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
				arg_115_0:Play115131029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_118_1 = arg_115_1.actors_["10014ui_story"].transform
			local var_118_2 = 0

			if var_118_2 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.var_.moveOldPos10014ui_story = var_118_1.localPosition
			end

			local var_118_3 = 0.001

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_3 then
				local var_118_4 = (arg_115_1.time_ - var_118_2) / var_118_3
				local var_118_5 = Vector3.New(0.7, -1.06, -6.2)

				var_118_1.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10014ui_story, var_118_5, var_118_4)

				local var_118_6 = manager.ui.mainCamera.transform.position - var_118_1.position

				var_118_1.forward = Vector3.New(var_118_6.x, var_118_6.y, var_118_6.z)

				local var_118_7 = var_118_1.localEulerAngles

				var_118_7.z = 0
				var_118_7.x = 0
				var_118_1.localEulerAngles = var_118_7
			end

			if arg_115_1.time_ >= var_118_2 + var_118_3 and arg_115_1.time_ < var_118_2 + var_118_3 + arg_118_0 then
				var_118_1.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_118_8 = manager.ui.mainCamera.transform.position - var_118_1.position

				var_118_1.forward = Vector3.New(var_118_8.x, var_118_8.y, var_118_8.z)

				local var_118_9 = var_118_1.localEulerAngles

				var_118_9.z = 0
				var_118_9.x = 0
				var_118_1.localEulerAngles = var_118_9
			end

			local var_118_10 = arg_115_1.actors_["10014ui_story"]
			local var_118_11 = 0

			if var_118_11 < arg_115_1.time_ and arg_115_1.time_ <= var_118_11 + arg_118_0 and not isNil(var_118_10) and arg_115_1.var_.characterEffect10014ui_story == nil then
				arg_115_1.var_.characterEffect10014ui_story = var_118_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_12 = 0.2

			if var_118_11 <= arg_115_1.time_ and arg_115_1.time_ < var_118_11 + var_118_12 and not isNil(var_118_10) then
				local var_118_13 = (arg_115_1.time_ - var_118_11) / var_118_12

				if arg_115_1.var_.characterEffect10014ui_story and not isNil(var_118_10) then
					arg_115_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_11 + var_118_12 and arg_115_1.time_ < var_118_11 + var_118_12 + arg_118_0 and not isNil(var_118_10) and arg_115_1.var_.characterEffect10014ui_story then
				arg_115_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_118_14 = arg_115_1.actors_["105201ui_story"].transform
			local var_118_15 = 0

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				arg_115_1.var_.moveOldPos105201ui_story = var_118_14.localPosition
			end

			local var_118_16 = 0.001

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_16 then
				local var_118_17 = (arg_115_1.time_ - var_118_15) / var_118_16
				local var_118_18 = Vector3.New(-0.7, -1.05, -6.2)

				var_118_14.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos105201ui_story, var_118_18, var_118_17)

				local var_118_19 = manager.ui.mainCamera.transform.position - var_118_14.position

				var_118_14.forward = Vector3.New(var_118_19.x, var_118_19.y, var_118_19.z)

				local var_118_20 = var_118_14.localEulerAngles

				var_118_20.z = 0
				var_118_20.x = 0
				var_118_14.localEulerAngles = var_118_20
			end

			if arg_115_1.time_ >= var_118_15 + var_118_16 and arg_115_1.time_ < var_118_15 + var_118_16 + arg_118_0 then
				var_118_14.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_118_21 = manager.ui.mainCamera.transform.position - var_118_14.position

				var_118_14.forward = Vector3.New(var_118_21.x, var_118_21.y, var_118_21.z)

				local var_118_22 = var_118_14.localEulerAngles

				var_118_22.z = 0
				var_118_22.x = 0
				var_118_14.localEulerAngles = var_118_22
			end

			local var_118_23 = arg_115_1.actors_["105201ui_story"]
			local var_118_24 = 0

			if var_118_24 < arg_115_1.time_ and arg_115_1.time_ <= var_118_24 + arg_118_0 and not isNil(var_118_23) and arg_115_1.var_.characterEffect105201ui_story == nil then
				arg_115_1.var_.characterEffect105201ui_story = var_118_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_25 = 0.2

			if var_118_24 <= arg_115_1.time_ and arg_115_1.time_ < var_118_24 + var_118_25 and not isNil(var_118_23) then
				local var_118_26 = (arg_115_1.time_ - var_118_24) / var_118_25

				if arg_115_1.var_.characterEffect105201ui_story and not isNil(var_118_23) then
					local var_118_27 = Mathf.Lerp(0, 0.5, var_118_26)

					arg_115_1.var_.characterEffect105201ui_story.fillFlat = true
					arg_115_1.var_.characterEffect105201ui_story.fillRatio = var_118_27
				end
			end

			if arg_115_1.time_ >= var_118_24 + var_118_25 and arg_115_1.time_ < var_118_24 + var_118_25 + arg_118_0 and not isNil(var_118_23) and arg_115_1.var_.characterEffect105201ui_story then
				local var_118_28 = 0.5

				arg_115_1.var_.characterEffect105201ui_story.fillFlat = true
				arg_115_1.var_.characterEffect105201ui_story.fillRatio = var_118_28
			end

			local var_118_29 = 0
			local var_118_30 = 1.275

			if var_118_29 < arg_115_1.time_ and arg_115_1.time_ <= var_118_29 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_31 = arg_115_1:FormatText(StoryNameCfg[264].name)

				arg_115_1.leftNameTxt_.text = var_118_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_32 = arg_115_1:GetWordFromCfg(115131028)
				local var_118_33 = arg_115_1:FormatText(var_118_32.content)

				arg_115_1.text_.text = var_118_33

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_34 = 51
				local var_118_35 = utf8.len(var_118_33)
				local var_118_36 = var_118_34 <= 0 and var_118_30 or var_118_30 * (var_118_35 / var_118_34)

				if var_118_36 > 0 and var_118_30 < var_118_36 then
					arg_115_1.talkMaxDuration = var_118_36

					if var_118_36 + var_118_29 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_36 + var_118_29
					end
				end

				arg_115_1.text_.text = var_118_33
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131028", "story_v_out_115131.awb") ~= 0 then
					local var_118_37 = manager.audio:GetVoiceLength("story_v_out_115131", "115131028", "story_v_out_115131.awb") / 1000

					if var_118_37 + var_118_29 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_37 + var_118_29
					end

					if var_118_32.prefab_name ~= "" and arg_115_1.actors_[var_118_32.prefab_name] ~= nil then
						local var_118_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_32.prefab_name].transform, "story_v_out_115131", "115131028", "story_v_out_115131.awb")

						arg_115_1:RecordAudio("115131028", var_118_38)
						arg_115_1:RecordAudio("115131028", var_118_38)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_115131", "115131028", "story_v_out_115131.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_115131", "115131028", "story_v_out_115131.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_39 = math.max(var_118_30, arg_115_1.talkMaxDuration)

			if var_118_29 <= arg_115_1.time_ and arg_115_1.time_ < var_118_29 + var_118_39 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_29) / var_118_39

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_29 + var_118_39 and arg_115_1.time_ < var_118_29 + var_118_39 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play115131029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 115131029
		arg_119_1.duration_ = 7.5

		local var_119_0 = {
			ja = 6.8,
			ko = 5.666,
			zh = 5.333,
			en = 7.5
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
				arg_119_0:Play115131030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10014ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10014ui_story == nil then
				arg_119_1.var_.characterEffect10014ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.2

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect10014ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10014ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10014ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10014ui_story.fillRatio = var_122_5
			end

			local var_122_6 = arg_119_1.actors_["105201ui_story"]
			local var_122_7 = 0

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect105201ui_story == nil then
				arg_119_1.var_.characterEffect105201ui_story = var_122_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_8 = 0.2

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_8 and not isNil(var_122_6) then
				local var_122_9 = (arg_119_1.time_ - var_122_7) / var_122_8

				if arg_119_1.var_.characterEffect105201ui_story and not isNil(var_122_6) then
					arg_119_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_7 + var_122_8 and arg_119_1.time_ < var_122_7 + var_122_8 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect105201ui_story then
				arg_119_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_122_11 = 0
			local var_122_12 = 0.625

			if var_122_11 < arg_119_1.time_ and arg_119_1.time_ <= var_122_11 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_13 = arg_119_1:FormatText(StoryNameCfg[263].name)

				arg_119_1.leftNameTxt_.text = var_122_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_14 = arg_119_1:GetWordFromCfg(115131029)
				local var_122_15 = arg_119_1:FormatText(var_122_14.content)

				arg_119_1.text_.text = var_122_15

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_16 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131029", "story_v_out_115131.awb") ~= 0 then
					local var_122_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131029", "story_v_out_115131.awb") / 1000

					if var_122_19 + var_122_11 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_19 + var_122_11
					end

					if var_122_14.prefab_name ~= "" and arg_119_1.actors_[var_122_14.prefab_name] ~= nil then
						local var_122_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_14.prefab_name].transform, "story_v_out_115131", "115131029", "story_v_out_115131.awb")

						arg_119_1:RecordAudio("115131029", var_122_20)
						arg_119_1:RecordAudio("115131029", var_122_20)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_115131", "115131029", "story_v_out_115131.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_115131", "115131029", "story_v_out_115131.awb")
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
	Play115131030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 115131030
		arg_123_1.duration_ = 13.23

		local var_123_0 = {
			ja = 13.233,
			ko = 9.5,
			zh = 9.833,
			en = 7.466
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
				arg_123_0:Play115131031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_126_1 = arg_123_1.actors_["10014ui_story"]
			local var_126_2 = 0

			if var_126_2 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect10014ui_story == nil then
				arg_123_1.var_.characterEffect10014ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_3 = 0.2

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_3 and not isNil(var_126_1) then
				local var_126_4 = (arg_123_1.time_ - var_126_2) / var_126_3

				if arg_123_1.var_.characterEffect10014ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_2 + var_126_3 and arg_123_1.time_ < var_126_2 + var_126_3 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect10014ui_story then
				arg_123_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_126_5 = arg_123_1.actors_["105201ui_story"]
			local var_126_6 = 0

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.characterEffect105201ui_story == nil then
				arg_123_1.var_.characterEffect105201ui_story = var_126_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_7 = 0.2

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_7 and not isNil(var_126_5) then
				local var_126_8 = (arg_123_1.time_ - var_126_6) / var_126_7

				if arg_123_1.var_.characterEffect105201ui_story and not isNil(var_126_5) then
					local var_126_9 = Mathf.Lerp(0, 0.5, var_126_8)

					arg_123_1.var_.characterEffect105201ui_story.fillFlat = true
					arg_123_1.var_.characterEffect105201ui_story.fillRatio = var_126_9
				end
			end

			if arg_123_1.time_ >= var_126_6 + var_126_7 and arg_123_1.time_ < var_126_6 + var_126_7 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.characterEffect105201ui_story then
				local var_126_10 = 0.5

				arg_123_1.var_.characterEffect105201ui_story.fillFlat = true
				arg_123_1.var_.characterEffect105201ui_story.fillRatio = var_126_10
			end

			local var_126_11 = 0
			local var_126_12 = 1.1

			if var_126_11 < arg_123_1.time_ and arg_123_1.time_ <= var_126_11 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_13 = arg_123_1:FormatText(StoryNameCfg[264].name)

				arg_123_1.leftNameTxt_.text = var_126_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_14 = arg_123_1:GetWordFromCfg(115131030)
				local var_126_15 = arg_123_1:FormatText(var_126_14.content)

				arg_123_1.text_.text = var_126_15

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_16 = 44
				local var_126_17 = utf8.len(var_126_15)
				local var_126_18 = var_126_16 <= 0 and var_126_12 or var_126_12 * (var_126_17 / var_126_16)

				if var_126_18 > 0 and var_126_12 < var_126_18 then
					arg_123_1.talkMaxDuration = var_126_18

					if var_126_18 + var_126_11 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_18 + var_126_11
					end
				end

				arg_123_1.text_.text = var_126_15
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131030", "story_v_out_115131.awb") ~= 0 then
					local var_126_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131030", "story_v_out_115131.awb") / 1000

					if var_126_19 + var_126_11 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_19 + var_126_11
					end

					if var_126_14.prefab_name ~= "" and arg_123_1.actors_[var_126_14.prefab_name] ~= nil then
						local var_126_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_14.prefab_name].transform, "story_v_out_115131", "115131030", "story_v_out_115131.awb")

						arg_123_1:RecordAudio("115131030", var_126_20)
						arg_123_1:RecordAudio("115131030", var_126_20)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_115131", "115131030", "story_v_out_115131.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_115131", "115131030", "story_v_out_115131.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_21 = math.max(var_126_12, arg_123_1.talkMaxDuration)

			if var_126_11 <= arg_123_1.time_ and arg_123_1.time_ < var_126_11 + var_126_21 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_11) / var_126_21

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_11 + var_126_21 and arg_123_1.time_ < var_126_11 + var_126_21 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play115131031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 115131031
		arg_127_1.duration_ = 2.6

		local var_127_0 = {
			ja = 1.999999999999,
			ko = 2.6,
			zh = 2.066,
			en = 1.999999999999
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
				arg_127_0:Play115131032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_130_2 = arg_127_1.actors_["105201ui_story"]
			local var_130_3 = 0

			if var_130_3 < arg_127_1.time_ and arg_127_1.time_ <= var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.characterEffect105201ui_story == nil then
				arg_127_1.var_.characterEffect105201ui_story = var_130_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_4 = 0.2

			if var_130_3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_3 + var_130_4 and not isNil(var_130_2) then
				local var_130_5 = (arg_127_1.time_ - var_130_3) / var_130_4

				if arg_127_1.var_.characterEffect105201ui_story and not isNil(var_130_2) then
					arg_127_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_3 + var_130_4 and arg_127_1.time_ < var_130_3 + var_130_4 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.characterEffect105201ui_story then
				arg_127_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			local var_130_6 = arg_127_1.actors_["10014ui_story"]
			local var_130_7 = 0

			if var_130_7 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect10014ui_story == nil then
				arg_127_1.var_.characterEffect10014ui_story = var_130_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_8 = 0.2

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_8 and not isNil(var_130_6) then
				local var_130_9 = (arg_127_1.time_ - var_130_7) / var_130_8

				if arg_127_1.var_.characterEffect10014ui_story and not isNil(var_130_6) then
					local var_130_10 = Mathf.Lerp(0, 0.5, var_130_9)

					arg_127_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10014ui_story.fillRatio = var_130_10
				end
			end

			if arg_127_1.time_ >= var_130_7 + var_130_8 and arg_127_1.time_ < var_130_7 + var_130_8 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect10014ui_story then
				local var_130_11 = 0.5

				arg_127_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10014ui_story.fillRatio = var_130_11
			end

			local var_130_12 = 0
			local var_130_13 = 0.225

			if var_130_12 < arg_127_1.time_ and arg_127_1.time_ <= var_130_12 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_14 = arg_127_1:FormatText(StoryNameCfg[263].name)

				arg_127_1.leftNameTxt_.text = var_130_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_15 = arg_127_1:GetWordFromCfg(115131031)
				local var_130_16 = arg_127_1:FormatText(var_130_15.content)

				arg_127_1.text_.text = var_130_16

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_17 = 9
				local var_130_18 = utf8.len(var_130_16)
				local var_130_19 = var_130_17 <= 0 and var_130_13 or var_130_13 * (var_130_18 / var_130_17)

				if var_130_19 > 0 and var_130_13 < var_130_19 then
					arg_127_1.talkMaxDuration = var_130_19

					if var_130_19 + var_130_12 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_19 + var_130_12
					end
				end

				arg_127_1.text_.text = var_130_16
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131031", "story_v_out_115131.awb") ~= 0 then
					local var_130_20 = manager.audio:GetVoiceLength("story_v_out_115131", "115131031", "story_v_out_115131.awb") / 1000

					if var_130_20 + var_130_12 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_20 + var_130_12
					end

					if var_130_15.prefab_name ~= "" and arg_127_1.actors_[var_130_15.prefab_name] ~= nil then
						local var_130_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_15.prefab_name].transform, "story_v_out_115131", "115131031", "story_v_out_115131.awb")

						arg_127_1:RecordAudio("115131031", var_130_21)
						arg_127_1:RecordAudio("115131031", var_130_21)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_115131", "115131031", "story_v_out_115131.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_115131", "115131031", "story_v_out_115131.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_22 = math.max(var_130_13, arg_127_1.talkMaxDuration)

			if var_130_12 <= arg_127_1.time_ and arg_127_1.time_ < var_130_12 + var_130_22 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_12) / var_130_22

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_12 + var_130_22 and arg_127_1.time_ < var_130_12 + var_130_22 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play115131032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 115131032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play115131033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["105201ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos105201ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0, 100, 0)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos105201ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, 100, 0)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["10014ui_story"].transform
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 then
				arg_131_1.var_.moveOldPos10014ui_story = var_134_9.localPosition
			end

			local var_134_11 = 0.001

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11
				local var_134_13 = Vector3.New(0, 100, 0)

				var_134_9.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10014ui_story, var_134_13, var_134_12)

				local var_134_14 = manager.ui.mainCamera.transform.position - var_134_9.position

				var_134_9.forward = Vector3.New(var_134_14.x, var_134_14.y, var_134_14.z)

				local var_134_15 = var_134_9.localEulerAngles

				var_134_15.z = 0
				var_134_15.x = 0
				var_134_9.localEulerAngles = var_134_15
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 then
				var_134_9.localPosition = Vector3.New(0, 100, 0)

				local var_134_16 = manager.ui.mainCamera.transform.position - var_134_9.position

				var_134_9.forward = Vector3.New(var_134_16.x, var_134_16.y, var_134_16.z)

				local var_134_17 = var_134_9.localEulerAngles

				var_134_17.z = 0
				var_134_17.x = 0
				var_134_9.localEulerAngles = var_134_17
			end

			local var_134_18 = 0
			local var_134_19 = 0.7

			if var_134_18 < arg_131_1.time_ and arg_131_1.time_ <= var_134_18 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_20 = arg_131_1:GetWordFromCfg(115131032)
				local var_134_21 = arg_131_1:FormatText(var_134_20.content)

				arg_131_1.text_.text = var_134_21

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_22 = 28
				local var_134_23 = utf8.len(var_134_21)
				local var_134_24 = var_134_22 <= 0 and var_134_19 or var_134_19 * (var_134_23 / var_134_22)

				if var_134_24 > 0 and var_134_19 < var_134_24 then
					arg_131_1.talkMaxDuration = var_134_24

					if var_134_24 + var_134_18 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_24 + var_134_18
					end
				end

				arg_131_1.text_.text = var_134_21
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_25 = math.max(var_134_19, arg_131_1.talkMaxDuration)

			if var_134_18 <= arg_131_1.time_ and arg_131_1.time_ < var_134_18 + var_134_25 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_18) / var_134_25

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_18 + var_134_25 and arg_131_1.time_ < var_134_18 + var_134_25 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play115131033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 115131033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play115131034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 1.325

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:GetWordFromCfg(115131033)
				local var_138_3 = arg_135_1:FormatText(var_138_2.content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 53
				local var_138_5 = utf8.len(var_138_3)
				local var_138_6 = var_138_4 <= 0 and var_138_1 or var_138_1 * (var_138_5 / var_138_4)

				if var_138_6 > 0 and var_138_1 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_7 and arg_135_1.time_ < var_138_0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play115131034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 115131034
		arg_139_1.duration_ = 12.07

		local var_139_0 = {
			ja = 12.066,
			ko = 7.3,
			zh = 9.466,
			en = 7.733
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
				arg_139_0:Play115131035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["105201ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos105201ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos105201ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = 0

			if var_142_9 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 then
				arg_139_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 then
				arg_139_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_142_11 = arg_139_1.actors_["105201ui_story"]
			local var_142_12 = 0

			if var_142_12 < arg_139_1.time_ and arg_139_1.time_ <= var_142_12 + arg_142_0 and not isNil(var_142_11) and arg_139_1.var_.characterEffect105201ui_story == nil then
				arg_139_1.var_.characterEffect105201ui_story = var_142_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_13 = 0.2

			if var_142_12 <= arg_139_1.time_ and arg_139_1.time_ < var_142_12 + var_142_13 and not isNil(var_142_11) then
				local var_142_14 = (arg_139_1.time_ - var_142_12) / var_142_13

				if arg_139_1.var_.characterEffect105201ui_story and not isNil(var_142_11) then
					arg_139_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_12 + var_142_13 and arg_139_1.time_ < var_142_12 + var_142_13 + arg_142_0 and not isNil(var_142_11) and arg_139_1.var_.characterEffect105201ui_story then
				arg_139_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			local var_142_15 = arg_139_1.actors_["10014ui_story"].transform
			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				arg_139_1.var_.moveOldPos10014ui_story = var_142_15.localPosition
			end

			local var_142_17 = 0.001

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_17 then
				local var_142_18 = (arg_139_1.time_ - var_142_16) / var_142_17
				local var_142_19 = Vector3.New(0.7, -1.06, -6.2)

				var_142_15.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10014ui_story, var_142_19, var_142_18)

				local var_142_20 = manager.ui.mainCamera.transform.position - var_142_15.position

				var_142_15.forward = Vector3.New(var_142_20.x, var_142_20.y, var_142_20.z)

				local var_142_21 = var_142_15.localEulerAngles

				var_142_21.z = 0
				var_142_21.x = 0
				var_142_15.localEulerAngles = var_142_21
			end

			if arg_139_1.time_ >= var_142_16 + var_142_17 and arg_139_1.time_ < var_142_16 + var_142_17 + arg_142_0 then
				var_142_15.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_142_22 = manager.ui.mainCamera.transform.position - var_142_15.position

				var_142_15.forward = Vector3.New(var_142_22.x, var_142_22.y, var_142_22.z)

				local var_142_23 = var_142_15.localEulerAngles

				var_142_23.z = 0
				var_142_23.x = 0
				var_142_15.localEulerAngles = var_142_23
			end

			local var_142_24 = arg_139_1.actors_["10014ui_story"]
			local var_142_25 = 0

			if var_142_25 < arg_139_1.time_ and arg_139_1.time_ <= var_142_25 + arg_142_0 and not isNil(var_142_24) and arg_139_1.var_.characterEffect10014ui_story == nil then
				arg_139_1.var_.characterEffect10014ui_story = var_142_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_26 = 0.2

			if var_142_25 <= arg_139_1.time_ and arg_139_1.time_ < var_142_25 + var_142_26 and not isNil(var_142_24) then
				local var_142_27 = (arg_139_1.time_ - var_142_25) / var_142_26

				if arg_139_1.var_.characterEffect10014ui_story and not isNil(var_142_24) then
					local var_142_28 = Mathf.Lerp(0, 0.5, var_142_27)

					arg_139_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10014ui_story.fillRatio = var_142_28
				end
			end

			if arg_139_1.time_ >= var_142_25 + var_142_26 and arg_139_1.time_ < var_142_25 + var_142_26 + arg_142_0 and not isNil(var_142_24) and arg_139_1.var_.characterEffect10014ui_story then
				local var_142_29 = 0.5

				arg_139_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10014ui_story.fillRatio = var_142_29
			end

			local var_142_30 = 0
			local var_142_31 = 0.525

			if var_142_30 < arg_139_1.time_ and arg_139_1.time_ <= var_142_30 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_32 = arg_139_1:FormatText(StoryNameCfg[263].name)

				arg_139_1.leftNameTxt_.text = var_142_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_33 = arg_139_1:GetWordFromCfg(115131034)
				local var_142_34 = arg_139_1:FormatText(var_142_33.content)

				arg_139_1.text_.text = var_142_34

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_35 = 21
				local var_142_36 = utf8.len(var_142_34)
				local var_142_37 = var_142_35 <= 0 and var_142_31 or var_142_31 * (var_142_36 / var_142_35)

				if var_142_37 > 0 and var_142_31 < var_142_37 then
					arg_139_1.talkMaxDuration = var_142_37

					if var_142_37 + var_142_30 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_37 + var_142_30
					end
				end

				arg_139_1.text_.text = var_142_34
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131034", "story_v_out_115131.awb") ~= 0 then
					local var_142_38 = manager.audio:GetVoiceLength("story_v_out_115131", "115131034", "story_v_out_115131.awb") / 1000

					if var_142_38 + var_142_30 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_38 + var_142_30
					end

					if var_142_33.prefab_name ~= "" and arg_139_1.actors_[var_142_33.prefab_name] ~= nil then
						local var_142_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_33.prefab_name].transform, "story_v_out_115131", "115131034", "story_v_out_115131.awb")

						arg_139_1:RecordAudio("115131034", var_142_39)
						arg_139_1:RecordAudio("115131034", var_142_39)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_115131", "115131034", "story_v_out_115131.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_115131", "115131034", "story_v_out_115131.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_40 = math.max(var_142_31, arg_139_1.talkMaxDuration)

			if var_142_30 <= arg_139_1.time_ and arg_139_1.time_ < var_142_30 + var_142_40 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_30) / var_142_40

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_30 + var_142_40 and arg_139_1.time_ < var_142_30 + var_142_40 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play115131035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 115131035
		arg_143_1.duration_ = 17.6

		local var_143_0 = {
			ja = 17.6,
			ko = 15.7,
			zh = 11.466,
			en = 15.966
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
				arg_143_0:Play115131036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["105201ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect105201ui_story == nil then
				arg_143_1.var_.characterEffect105201ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.2

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect105201ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect105201ui_story.fillFlat = true
					arg_143_1.var_.characterEffect105201ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect105201ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect105201ui_story.fillFlat = true
				arg_143_1.var_.characterEffect105201ui_story.fillRatio = var_146_5
			end

			local var_146_6 = arg_143_1.actors_["10014ui_story"]
			local var_146_7 = 0

			if var_146_7 < arg_143_1.time_ and arg_143_1.time_ <= var_146_7 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect10014ui_story == nil then
				arg_143_1.var_.characterEffect10014ui_story = var_146_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_8 = 0.2

			if var_146_7 <= arg_143_1.time_ and arg_143_1.time_ < var_146_7 + var_146_8 and not isNil(var_146_6) then
				local var_146_9 = (arg_143_1.time_ - var_146_7) / var_146_8

				if arg_143_1.var_.characterEffect10014ui_story and not isNil(var_146_6) then
					arg_143_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_7 + var_146_8 and arg_143_1.time_ < var_146_7 + var_146_8 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect10014ui_story then
				arg_143_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_146_11 = 0
			local var_146_12 = 1.325

			if var_146_11 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_13 = arg_143_1:FormatText(StoryNameCfg[264].name)

				arg_143_1.leftNameTxt_.text = var_146_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_14 = arg_143_1:GetWordFromCfg(115131035)
				local var_146_15 = arg_143_1:FormatText(var_146_14.content)

				arg_143_1.text_.text = var_146_15

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_16 = 53
				local var_146_17 = utf8.len(var_146_15)
				local var_146_18 = var_146_16 <= 0 and var_146_12 or var_146_12 * (var_146_17 / var_146_16)

				if var_146_18 > 0 and var_146_12 < var_146_18 then
					arg_143_1.talkMaxDuration = var_146_18

					if var_146_18 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_18 + var_146_11
					end
				end

				arg_143_1.text_.text = var_146_15
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131035", "story_v_out_115131.awb") ~= 0 then
					local var_146_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131035", "story_v_out_115131.awb") / 1000

					if var_146_19 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_19 + var_146_11
					end

					if var_146_14.prefab_name ~= "" and arg_143_1.actors_[var_146_14.prefab_name] ~= nil then
						local var_146_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_14.prefab_name].transform, "story_v_out_115131", "115131035", "story_v_out_115131.awb")

						arg_143_1:RecordAudio("115131035", var_146_20)
						arg_143_1:RecordAudio("115131035", var_146_20)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_115131", "115131035", "story_v_out_115131.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_115131", "115131035", "story_v_out_115131.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_21 = math.max(var_146_12, arg_143_1.talkMaxDuration)

			if var_146_11 <= arg_143_1.time_ and arg_143_1.time_ < var_146_11 + var_146_21 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_11) / var_146_21

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_11 + var_146_21 and arg_143_1.time_ < var_146_11 + var_146_21 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play115131036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 115131036
		arg_147_1.duration_ = 9.6

		local var_147_0 = {
			ja = 9.6,
			ko = 6.533,
			zh = 5.966,
			en = 6.7
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play115131037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_150_1 = 0
			local var_150_2 = 0.725

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_3 = arg_147_1:FormatText(StoryNameCfg[264].name)

				arg_147_1.leftNameTxt_.text = var_150_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_4 = arg_147_1:GetWordFromCfg(115131036)
				local var_150_5 = arg_147_1:FormatText(var_150_4.content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_6 = 29
				local var_150_7 = utf8.len(var_150_5)
				local var_150_8 = var_150_6 <= 0 and var_150_2 or var_150_2 * (var_150_7 / var_150_6)

				if var_150_8 > 0 and var_150_2 < var_150_8 then
					arg_147_1.talkMaxDuration = var_150_8

					if var_150_8 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131036", "story_v_out_115131.awb") ~= 0 then
					local var_150_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131036", "story_v_out_115131.awb") / 1000

					if var_150_9 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_1
					end

					if var_150_4.prefab_name ~= "" and arg_147_1.actors_[var_150_4.prefab_name] ~= nil then
						local var_150_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_4.prefab_name].transform, "story_v_out_115131", "115131036", "story_v_out_115131.awb")

						arg_147_1:RecordAudio("115131036", var_150_10)
						arg_147_1:RecordAudio("115131036", var_150_10)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_115131", "115131036", "story_v_out_115131.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_115131", "115131036", "story_v_out_115131.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_11 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_11 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_11

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_11 and arg_147_1.time_ < var_150_1 + var_150_11 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play115131037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 115131037
		arg_151_1.duration_ = 6.27

		local var_151_0 = {
			ja = 6.266,
			ko = 5.433,
			zh = 5.333,
			en = 5
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
				arg_151_0:Play115131038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_154_2 = arg_151_1.actors_["105201ui_story"]
			local var_154_3 = 0

			if var_154_3 < arg_151_1.time_ and arg_151_1.time_ <= var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.characterEffect105201ui_story == nil then
				arg_151_1.var_.characterEffect105201ui_story = var_154_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_4 = 0.2

			if var_154_3 <= arg_151_1.time_ and arg_151_1.time_ < var_154_3 + var_154_4 and not isNil(var_154_2) then
				local var_154_5 = (arg_151_1.time_ - var_154_3) / var_154_4

				if arg_151_1.var_.characterEffect105201ui_story and not isNil(var_154_2) then
					arg_151_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_3 + var_154_4 and arg_151_1.time_ < var_154_3 + var_154_4 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.characterEffect105201ui_story then
				arg_151_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			local var_154_6 = arg_151_1.actors_["10014ui_story"]
			local var_154_7 = 0

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect10014ui_story == nil then
				arg_151_1.var_.characterEffect10014ui_story = var_154_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_8 = 0.2

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_8 and not isNil(var_154_6) then
				local var_154_9 = (arg_151_1.time_ - var_154_7) / var_154_8

				if arg_151_1.var_.characterEffect10014ui_story and not isNil(var_154_6) then
					local var_154_10 = Mathf.Lerp(0, 0.5, var_154_9)

					arg_151_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10014ui_story.fillRatio = var_154_10
				end
			end

			if arg_151_1.time_ >= var_154_7 + var_154_8 and arg_151_1.time_ < var_154_7 + var_154_8 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect10014ui_story then
				local var_154_11 = 0.5

				arg_151_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10014ui_story.fillRatio = var_154_11
			end

			local var_154_12 = 0
			local var_154_13 = 0.75

			if var_154_12 < arg_151_1.time_ and arg_151_1.time_ <= var_154_12 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_14 = arg_151_1:FormatText(StoryNameCfg[263].name)

				arg_151_1.leftNameTxt_.text = var_154_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_15 = arg_151_1:GetWordFromCfg(115131037)
				local var_154_16 = arg_151_1:FormatText(var_154_15.content)

				arg_151_1.text_.text = var_154_16

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_17 = 30
				local var_154_18 = utf8.len(var_154_16)
				local var_154_19 = var_154_17 <= 0 and var_154_13 or var_154_13 * (var_154_18 / var_154_17)

				if var_154_19 > 0 and var_154_13 < var_154_19 then
					arg_151_1.talkMaxDuration = var_154_19

					if var_154_19 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_19 + var_154_12
					end
				end

				arg_151_1.text_.text = var_154_16
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131037", "story_v_out_115131.awb") ~= 0 then
					local var_154_20 = manager.audio:GetVoiceLength("story_v_out_115131", "115131037", "story_v_out_115131.awb") / 1000

					if var_154_20 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_20 + var_154_12
					end

					if var_154_15.prefab_name ~= "" and arg_151_1.actors_[var_154_15.prefab_name] ~= nil then
						local var_154_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_15.prefab_name].transform, "story_v_out_115131", "115131037", "story_v_out_115131.awb")

						arg_151_1:RecordAudio("115131037", var_154_21)
						arg_151_1:RecordAudio("115131037", var_154_21)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_115131", "115131037", "story_v_out_115131.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_115131", "115131037", "story_v_out_115131.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_22 = math.max(var_154_13, arg_151_1.talkMaxDuration)

			if var_154_12 <= arg_151_1.time_ and arg_151_1.time_ < var_154_12 + var_154_22 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_12) / var_154_22

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_12 + var_154_22 and arg_151_1.time_ < var_154_12 + var_154_22 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play115131038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 115131038
		arg_155_1.duration_ = 15

		local var_155_0 = {
			ja = 14.2,
			ko = 12.633,
			zh = 13.133,
			en = 15
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
				arg_155_0:Play115131039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["105201ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect105201ui_story == nil then
				arg_155_1.var_.characterEffect105201ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.2

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect105201ui_story and not isNil(var_158_0) then
					local var_158_4 = Mathf.Lerp(0, 0.5, var_158_3)

					arg_155_1.var_.characterEffect105201ui_story.fillFlat = true
					arg_155_1.var_.characterEffect105201ui_story.fillRatio = var_158_4
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect105201ui_story then
				local var_158_5 = 0.5

				arg_155_1.var_.characterEffect105201ui_story.fillFlat = true
				arg_155_1.var_.characterEffect105201ui_story.fillRatio = var_158_5
			end

			local var_158_6 = arg_155_1.actors_["10014ui_story"]
			local var_158_7 = 0

			if var_158_7 < arg_155_1.time_ and arg_155_1.time_ <= var_158_7 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect10014ui_story == nil then
				arg_155_1.var_.characterEffect10014ui_story = var_158_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_8 = 0.2

			if var_158_7 <= arg_155_1.time_ and arg_155_1.time_ < var_158_7 + var_158_8 and not isNil(var_158_6) then
				local var_158_9 = (arg_155_1.time_ - var_158_7) / var_158_8

				if arg_155_1.var_.characterEffect10014ui_story and not isNil(var_158_6) then
					arg_155_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_7 + var_158_8 and arg_155_1.time_ < var_158_7 + var_158_8 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect10014ui_story then
				arg_155_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_158_10 = 0

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 then
				arg_155_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_158_11 = 0
			local var_158_12 = 1.3

			if var_158_11 < arg_155_1.time_ and arg_155_1.time_ <= var_158_11 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_13 = arg_155_1:FormatText(StoryNameCfg[264].name)

				arg_155_1.leftNameTxt_.text = var_158_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_14 = arg_155_1:GetWordFromCfg(115131038)
				local var_158_15 = arg_155_1:FormatText(var_158_14.content)

				arg_155_1.text_.text = var_158_15

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_16 = 52
				local var_158_17 = utf8.len(var_158_15)
				local var_158_18 = var_158_16 <= 0 and var_158_12 or var_158_12 * (var_158_17 / var_158_16)

				if var_158_18 > 0 and var_158_12 < var_158_18 then
					arg_155_1.talkMaxDuration = var_158_18

					if var_158_18 + var_158_11 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_18 + var_158_11
					end
				end

				arg_155_1.text_.text = var_158_15
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131038", "story_v_out_115131.awb") ~= 0 then
					local var_158_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131038", "story_v_out_115131.awb") / 1000

					if var_158_19 + var_158_11 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_19 + var_158_11
					end

					if var_158_14.prefab_name ~= "" and arg_155_1.actors_[var_158_14.prefab_name] ~= nil then
						local var_158_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_14.prefab_name].transform, "story_v_out_115131", "115131038", "story_v_out_115131.awb")

						arg_155_1:RecordAudio("115131038", var_158_20)
						arg_155_1:RecordAudio("115131038", var_158_20)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_115131", "115131038", "story_v_out_115131.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_115131", "115131038", "story_v_out_115131.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_21 = math.max(var_158_12, arg_155_1.talkMaxDuration)

			if var_158_11 <= arg_155_1.time_ and arg_155_1.time_ < var_158_11 + var_158_21 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_11) / var_158_21

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_11 + var_158_21 and arg_155_1.time_ < var_158_11 + var_158_21 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play115131039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 115131039
		arg_159_1.duration_ = 15.03

		local var_159_0 = {
			ja = 14.733,
			ko = 15.033,
			zh = 13,
			en = 14.066
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
				arg_159_0:Play115131040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_162_1 = 0
			local var_162_2 = 1.475

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_3 = arg_159_1:FormatText(StoryNameCfg[264].name)

				arg_159_1.leftNameTxt_.text = var_162_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:GetWordFromCfg(115131039)
				local var_162_5 = arg_159_1:FormatText(var_162_4.content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_6 = 59
				local var_162_7 = utf8.len(var_162_5)
				local var_162_8 = var_162_6 <= 0 and var_162_2 or var_162_2 * (var_162_7 / var_162_6)

				if var_162_8 > 0 and var_162_2 < var_162_8 then
					arg_159_1.talkMaxDuration = var_162_8

					if var_162_8 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131039", "story_v_out_115131.awb") ~= 0 then
					local var_162_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131039", "story_v_out_115131.awb") / 1000

					if var_162_9 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_1
					end

					if var_162_4.prefab_name ~= "" and arg_159_1.actors_[var_162_4.prefab_name] ~= nil then
						local var_162_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_4.prefab_name].transform, "story_v_out_115131", "115131039", "story_v_out_115131.awb")

						arg_159_1:RecordAudio("115131039", var_162_10)
						arg_159_1:RecordAudio("115131039", var_162_10)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_115131", "115131039", "story_v_out_115131.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_115131", "115131039", "story_v_out_115131.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_11 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_11 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_11

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_11 and arg_159_1.time_ < var_162_1 + var_162_11 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play115131040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 115131040
		arg_163_1.duration_ = 10.8

		local var_163_0 = {
			ja = 10.066,
			ko = 7.9,
			zh = 7.7,
			en = 10.8
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
				arg_163_0:Play115131041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_166_1 = 0
			local var_166_2 = 0.925

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_3 = arg_163_1:FormatText(StoryNameCfg[264].name)

				arg_163_1.leftNameTxt_.text = var_166_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_4 = arg_163_1:GetWordFromCfg(115131040)
				local var_166_5 = arg_163_1:FormatText(var_166_4.content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_6 = 37
				local var_166_7 = utf8.len(var_166_5)
				local var_166_8 = var_166_6 <= 0 and var_166_2 or var_166_2 * (var_166_7 / var_166_6)

				if var_166_8 > 0 and var_166_2 < var_166_8 then
					arg_163_1.talkMaxDuration = var_166_8

					if var_166_8 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131040", "story_v_out_115131.awb") ~= 0 then
					local var_166_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131040", "story_v_out_115131.awb") / 1000

					if var_166_9 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_1
					end

					if var_166_4.prefab_name ~= "" and arg_163_1.actors_[var_166_4.prefab_name] ~= nil then
						local var_166_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_4.prefab_name].transform, "story_v_out_115131", "115131040", "story_v_out_115131.awb")

						arg_163_1:RecordAudio("115131040", var_166_10)
						arg_163_1:RecordAudio("115131040", var_166_10)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_115131", "115131040", "story_v_out_115131.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_115131", "115131040", "story_v_out_115131.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_11 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_11 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_11

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_11 and arg_163_1.time_ < var_166_1 + var_166_11 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play115131041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 115131041
		arg_167_1.duration_ = 13.1

		local var_167_0 = {
			ja = 13.1,
			ko = 5.733,
			zh = 5.6,
			en = 7.466
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
				arg_167_0:Play115131042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_170_1 = 0
			local var_170_2 = 0.575

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_3 = arg_167_1:FormatText(StoryNameCfg[264].name)

				arg_167_1.leftNameTxt_.text = var_170_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_4 = arg_167_1:GetWordFromCfg(115131041)
				local var_170_5 = arg_167_1:FormatText(var_170_4.content)

				arg_167_1.text_.text = var_170_5

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_6 = 23
				local var_170_7 = utf8.len(var_170_5)
				local var_170_8 = var_170_6 <= 0 and var_170_2 or var_170_2 * (var_170_7 / var_170_6)

				if var_170_8 > 0 and var_170_2 < var_170_8 then
					arg_167_1.talkMaxDuration = var_170_8

					if var_170_8 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_5
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131041", "story_v_out_115131.awb") ~= 0 then
					local var_170_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131041", "story_v_out_115131.awb") / 1000

					if var_170_9 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_1
					end

					if var_170_4.prefab_name ~= "" and arg_167_1.actors_[var_170_4.prefab_name] ~= nil then
						local var_170_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_4.prefab_name].transform, "story_v_out_115131", "115131041", "story_v_out_115131.awb")

						arg_167_1:RecordAudio("115131041", var_170_10)
						arg_167_1:RecordAudio("115131041", var_170_10)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_115131", "115131041", "story_v_out_115131.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_115131", "115131041", "story_v_out_115131.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_11 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_11 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_11

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_11 and arg_167_1.time_ < var_170_1 + var_170_11 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play115131042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 115131042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play115131043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10014ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect10014ui_story == nil then
				arg_171_1.var_.characterEffect10014ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.2

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect10014ui_story and not isNil(var_174_0) then
					local var_174_4 = Mathf.Lerp(0, 0.5, var_174_3)

					arg_171_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10014ui_story.fillRatio = var_174_4
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect10014ui_story then
				local var_174_5 = 0.5

				arg_171_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10014ui_story.fillRatio = var_174_5
			end

			local var_174_6 = 0
			local var_174_7 = 1.475

			if var_174_6 < arg_171_1.time_ and arg_171_1.time_ <= var_174_6 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_8 = arg_171_1:GetWordFromCfg(115131042)
				local var_174_9 = arg_171_1:FormatText(var_174_8.content)

				arg_171_1.text_.text = var_174_9

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_10 = 59
				local var_174_11 = utf8.len(var_174_9)
				local var_174_12 = var_174_10 <= 0 and var_174_7 or var_174_7 * (var_174_11 / var_174_10)

				if var_174_12 > 0 and var_174_7 < var_174_12 then
					arg_171_1.talkMaxDuration = var_174_12

					if var_174_12 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_12 + var_174_6
					end
				end

				arg_171_1.text_.text = var_174_9
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_13 = math.max(var_174_7, arg_171_1.talkMaxDuration)

			if var_174_6 <= arg_171_1.time_ and arg_171_1.time_ < var_174_6 + var_174_13 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_6) / var_174_13

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_6 + var_174_13 and arg_171_1.time_ < var_174_6 + var_174_13 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play115131043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 115131043
		arg_175_1.duration_ = 2.37

		local var_175_0 = {
			ja = 2.3,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.366
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
				arg_175_0:Play115131044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["105201ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect105201ui_story == nil then
				arg_175_1.var_.characterEffect105201ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect105201ui_story and not isNil(var_178_0) then
					arg_175_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect105201ui_story then
				arg_175_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			local var_178_4 = 0

			if var_178_4 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_178_5 = 0
			local var_178_6 = 0.1

			if var_178_5 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_7 = arg_175_1:FormatText(StoryNameCfg[263].name)

				arg_175_1.leftNameTxt_.text = var_178_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_8 = arg_175_1:GetWordFromCfg(115131043)
				local var_178_9 = arg_175_1:FormatText(var_178_8.content)

				arg_175_1.text_.text = var_178_9

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_10 = 4
				local var_178_11 = utf8.len(var_178_9)
				local var_178_12 = var_178_10 <= 0 and var_178_6 or var_178_6 * (var_178_11 / var_178_10)

				if var_178_12 > 0 and var_178_6 < var_178_12 then
					arg_175_1.talkMaxDuration = var_178_12

					if var_178_12 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_12 + var_178_5
					end
				end

				arg_175_1.text_.text = var_178_9
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131043", "story_v_out_115131.awb") ~= 0 then
					local var_178_13 = manager.audio:GetVoiceLength("story_v_out_115131", "115131043", "story_v_out_115131.awb") / 1000

					if var_178_13 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_5
					end

					if var_178_8.prefab_name ~= "" and arg_175_1.actors_[var_178_8.prefab_name] ~= nil then
						local var_178_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_8.prefab_name].transform, "story_v_out_115131", "115131043", "story_v_out_115131.awb")

						arg_175_1:RecordAudio("115131043", var_178_14)
						arg_175_1:RecordAudio("115131043", var_178_14)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_115131", "115131043", "story_v_out_115131.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_115131", "115131043", "story_v_out_115131.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_15 = math.max(var_178_6, arg_175_1.talkMaxDuration)

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_15 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_5) / var_178_15

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_5 + var_178_15 and arg_175_1.time_ < var_178_5 + var_178_15 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play115131044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 115131044
		arg_179_1.duration_ = 8.2

		local var_179_0 = {
			ja = 8.033,
			ko = 5.766,
			zh = 5.3,
			en = 8.2
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
				arg_179_0:Play115131045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["105201ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect105201ui_story == nil then
				arg_179_1.var_.characterEffect105201ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.2

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect105201ui_story and not isNil(var_182_0) then
					local var_182_4 = Mathf.Lerp(0, 0.5, var_182_3)

					arg_179_1.var_.characterEffect105201ui_story.fillFlat = true
					arg_179_1.var_.characterEffect105201ui_story.fillRatio = var_182_4
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect105201ui_story then
				local var_182_5 = 0.5

				arg_179_1.var_.characterEffect105201ui_story.fillFlat = true
				arg_179_1.var_.characterEffect105201ui_story.fillRatio = var_182_5
			end

			local var_182_6 = arg_179_1.actors_["10014ui_story"]
			local var_182_7 = 0

			if var_182_7 < arg_179_1.time_ and arg_179_1.time_ <= var_182_7 + arg_182_0 and not isNil(var_182_6) and arg_179_1.var_.characterEffect10014ui_story == nil then
				arg_179_1.var_.characterEffect10014ui_story = var_182_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_8 = 0.2

			if var_182_7 <= arg_179_1.time_ and arg_179_1.time_ < var_182_7 + var_182_8 and not isNil(var_182_6) then
				local var_182_9 = (arg_179_1.time_ - var_182_7) / var_182_8

				if arg_179_1.var_.characterEffect10014ui_story and not isNil(var_182_6) then
					arg_179_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_7 + var_182_8 and arg_179_1.time_ < var_182_7 + var_182_8 + arg_182_0 and not isNil(var_182_6) and arg_179_1.var_.characterEffect10014ui_story then
				arg_179_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_182_10 = 0

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 then
				arg_179_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_182_11 = 0
			local var_182_12 = 0.475

			if var_182_11 < arg_179_1.time_ and arg_179_1.time_ <= var_182_11 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_13 = arg_179_1:FormatText(StoryNameCfg[264].name)

				arg_179_1.leftNameTxt_.text = var_182_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_14 = arg_179_1:GetWordFromCfg(115131044)
				local var_182_15 = arg_179_1:FormatText(var_182_14.content)

				arg_179_1.text_.text = var_182_15

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_16 = 19
				local var_182_17 = utf8.len(var_182_15)
				local var_182_18 = var_182_16 <= 0 and var_182_12 or var_182_12 * (var_182_17 / var_182_16)

				if var_182_18 > 0 and var_182_12 < var_182_18 then
					arg_179_1.talkMaxDuration = var_182_18

					if var_182_18 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_18 + var_182_11
					end
				end

				arg_179_1.text_.text = var_182_15
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131044", "story_v_out_115131.awb") ~= 0 then
					local var_182_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131044", "story_v_out_115131.awb") / 1000

					if var_182_19 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_19 + var_182_11
					end

					if var_182_14.prefab_name ~= "" and arg_179_1.actors_[var_182_14.prefab_name] ~= nil then
						local var_182_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_14.prefab_name].transform, "story_v_out_115131", "115131044", "story_v_out_115131.awb")

						arg_179_1:RecordAudio("115131044", var_182_20)
						arg_179_1:RecordAudio("115131044", var_182_20)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_115131", "115131044", "story_v_out_115131.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_115131", "115131044", "story_v_out_115131.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_21 = math.max(var_182_12, arg_179_1.talkMaxDuration)

			if var_182_11 <= arg_179_1.time_ and arg_179_1.time_ < var_182_11 + var_182_21 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_11) / var_182_21

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_11 + var_182_21 and arg_179_1.time_ < var_182_11 + var_182_21 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play115131045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 115131045
		arg_183_1.duration_ = 20.77

		local var_183_0 = {
			ja = 15.9,
			ko = 20.766,
			zh = 11.433,
			en = 10.666
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
				arg_183_0:Play115131046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_186_1 = 0
			local var_186_2 = 1.275

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_3 = arg_183_1:FormatText(StoryNameCfg[264].name)

				arg_183_1.leftNameTxt_.text = var_186_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_4 = arg_183_1:GetWordFromCfg(115131045)
				local var_186_5 = arg_183_1:FormatText(var_186_4.content)

				arg_183_1.text_.text = var_186_5

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_6 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131045", "story_v_out_115131.awb") ~= 0 then
					local var_186_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131045", "story_v_out_115131.awb") / 1000

					if var_186_9 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_1
					end

					if var_186_4.prefab_name ~= "" and arg_183_1.actors_[var_186_4.prefab_name] ~= nil then
						local var_186_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_4.prefab_name].transform, "story_v_out_115131", "115131045", "story_v_out_115131.awb")

						arg_183_1:RecordAudio("115131045", var_186_10)
						arg_183_1:RecordAudio("115131045", var_186_10)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_115131", "115131045", "story_v_out_115131.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_115131", "115131045", "story_v_out_115131.awb")
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
	Play115131046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 115131046
		arg_187_1.duration_ = 6.1

		local var_187_0 = {
			ja = 6.1,
			ko = 5.266,
			zh = 5.533,
			en = 5.7
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
				arg_187_0:Play115131047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_190_1 = 0
			local var_190_2 = 0.5

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_3 = arg_187_1:FormatText(StoryNameCfg[264].name)

				arg_187_1.leftNameTxt_.text = var_190_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_4 = arg_187_1:GetWordFromCfg(115131046)
				local var_190_5 = arg_187_1:FormatText(var_190_4.content)

				arg_187_1.text_.text = var_190_5

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_6 = 20
				local var_190_7 = utf8.len(var_190_5)
				local var_190_8 = var_190_6 <= 0 and var_190_2 or var_190_2 * (var_190_7 / var_190_6)

				if var_190_8 > 0 and var_190_2 < var_190_8 then
					arg_187_1.talkMaxDuration = var_190_8

					if var_190_8 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_5
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131046", "story_v_out_115131.awb") ~= 0 then
					local var_190_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131046", "story_v_out_115131.awb") / 1000

					if var_190_9 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_1
					end

					if var_190_4.prefab_name ~= "" and arg_187_1.actors_[var_190_4.prefab_name] ~= nil then
						local var_190_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_4.prefab_name].transform, "story_v_out_115131", "115131046", "story_v_out_115131.awb")

						arg_187_1:RecordAudio("115131046", var_190_10)
						arg_187_1:RecordAudio("115131046", var_190_10)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_115131", "115131046", "story_v_out_115131.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_115131", "115131046", "story_v_out_115131.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_11 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_11 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_11

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_11 and arg_187_1.time_ < var_190_1 + var_190_11 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play115131047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 115131047
		arg_191_1.duration_ = 10.03

		local var_191_0 = {
			ja = 5.166,
			ko = 5.733,
			zh = 7.933,
			en = 10.033
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
				arg_191_0:Play115131048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = manager.ui.mainCamera.transform
			local var_194_1 = 0.325

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.shakeOldPos = var_194_0.localPosition
			end

			local var_194_2 = 1

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / 0.066
				local var_194_4, var_194_5 = math.modf(var_194_3)

				var_194_0.localPosition = Vector3.New(var_194_5 * 0.13, var_194_5 * 0.13, var_194_5 * 0.13) + arg_191_1.var_.shakeOldPos
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = arg_191_1.var_.shakeOldPos
			end

			local var_194_6 = 0

			if var_194_6 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.allBtn_.enabled = false
			end

			local var_194_7 = 1.325

			if arg_191_1.time_ >= var_194_6 + var_194_7 and arg_191_1.time_ < var_194_6 + var_194_7 + arg_194_0 then
				arg_191_1.allBtn_.enabled = true
			end

			local var_194_8 = arg_191_1.actors_["105201ui_story"].transform
			local var_194_9 = 0

			if var_194_9 < arg_191_1.time_ and arg_191_1.time_ <= var_194_9 + arg_194_0 then
				arg_191_1.var_.moveOldPos105201ui_story = var_194_8.localPosition
			end

			local var_194_10 = 0.001

			if var_194_9 <= arg_191_1.time_ and arg_191_1.time_ < var_194_9 + var_194_10 then
				local var_194_11 = (arg_191_1.time_ - var_194_9) / var_194_10
				local var_194_12 = Vector3.New(0, 100, 0)

				var_194_8.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos105201ui_story, var_194_12, var_194_11)

				local var_194_13 = manager.ui.mainCamera.transform.position - var_194_8.position

				var_194_8.forward = Vector3.New(var_194_13.x, var_194_13.y, var_194_13.z)

				local var_194_14 = var_194_8.localEulerAngles

				var_194_14.z = 0
				var_194_14.x = 0
				var_194_8.localEulerAngles = var_194_14
			end

			if arg_191_1.time_ >= var_194_9 + var_194_10 and arg_191_1.time_ < var_194_9 + var_194_10 + arg_194_0 then
				var_194_8.localPosition = Vector3.New(0, 100, 0)

				local var_194_15 = manager.ui.mainCamera.transform.position - var_194_8.position

				var_194_8.forward = Vector3.New(var_194_15.x, var_194_15.y, var_194_15.z)

				local var_194_16 = var_194_8.localEulerAngles

				var_194_16.z = 0
				var_194_16.x = 0
				var_194_8.localEulerAngles = var_194_16
			end

			local var_194_17 = arg_191_1.actors_["10014ui_story"].transform
			local var_194_18 = 0

			if var_194_18 < arg_191_1.time_ and arg_191_1.time_ <= var_194_18 + arg_194_0 then
				arg_191_1.var_.moveOldPos10014ui_story = var_194_17.localPosition
			end

			local var_194_19 = 0.001

			if var_194_18 <= arg_191_1.time_ and arg_191_1.time_ < var_194_18 + var_194_19 then
				local var_194_20 = (arg_191_1.time_ - var_194_18) / var_194_19
				local var_194_21 = Vector3.New(0, 100, 0)

				var_194_17.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10014ui_story, var_194_21, var_194_20)

				local var_194_22 = manager.ui.mainCamera.transform.position - var_194_17.position

				var_194_17.forward = Vector3.New(var_194_22.x, var_194_22.y, var_194_22.z)

				local var_194_23 = var_194_17.localEulerAngles

				var_194_23.z = 0
				var_194_23.x = 0
				var_194_17.localEulerAngles = var_194_23
			end

			if arg_191_1.time_ >= var_194_18 + var_194_19 and arg_191_1.time_ < var_194_18 + var_194_19 + arg_194_0 then
				var_194_17.localPosition = Vector3.New(0, 100, 0)

				local var_194_24 = manager.ui.mainCamera.transform.position - var_194_17.position

				var_194_17.forward = Vector3.New(var_194_24.x, var_194_24.y, var_194_24.z)

				local var_194_25 = var_194_17.localEulerAngles

				var_194_25.z = 0
				var_194_25.x = 0
				var_194_17.localEulerAngles = var_194_25
			end

			local var_194_26 = 0
			local var_194_27 = 0.325

			if var_194_26 < arg_191_1.time_ and arg_191_1.time_ <= var_194_26 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_28 = arg_191_1:FormatText(StoryNameCfg[263].name)

				arg_191_1.leftNameTxt_.text = var_194_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_105201")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_29 = arg_191_1:GetWordFromCfg(115131047)
				local var_194_30 = arg_191_1:FormatText(var_194_29.content)

				arg_191_1.text_.text = var_194_30

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_31 = 13
				local var_194_32 = utf8.len(var_194_30)
				local var_194_33 = var_194_31 <= 0 and var_194_27 or var_194_27 * (var_194_32 / var_194_31)

				if var_194_33 > 0 and var_194_27 < var_194_33 then
					arg_191_1.talkMaxDuration = var_194_33

					if var_194_33 + var_194_26 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_33 + var_194_26
					end
				end

				arg_191_1.text_.text = var_194_30
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131047", "story_v_out_115131.awb") ~= 0 then
					local var_194_34 = manager.audio:GetVoiceLength("story_v_out_115131", "115131047", "story_v_out_115131.awb") / 1000

					if var_194_34 + var_194_26 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_34 + var_194_26
					end

					if var_194_29.prefab_name ~= "" and arg_191_1.actors_[var_194_29.prefab_name] ~= nil then
						local var_194_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_29.prefab_name].transform, "story_v_out_115131", "115131047", "story_v_out_115131.awb")

						arg_191_1:RecordAudio("115131047", var_194_35)
						arg_191_1:RecordAudio("115131047", var_194_35)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_115131", "115131047", "story_v_out_115131.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_115131", "115131047", "story_v_out_115131.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_36 = math.max(var_194_27, arg_191_1.talkMaxDuration)

			if var_194_26 <= arg_191_1.time_ and arg_191_1.time_ < var_194_26 + var_194_36 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_26) / var_194_36

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_26 + var_194_36 and arg_191_1.time_ < var_194_26 + var_194_36 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play115131048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 115131048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play115131049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 1.4

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_2 = arg_195_1:GetWordFromCfg(115131048)
				local var_198_3 = arg_195_1:FormatText(var_198_2.content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 56
				local var_198_5 = utf8.len(var_198_3)
				local var_198_6 = var_198_4 <= 0 and var_198_1 or var_198_1 * (var_198_5 / var_198_4)

				if var_198_6 > 0 and var_198_1 < var_198_6 then
					arg_195_1.talkMaxDuration = var_198_6

					if var_198_6 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_7 and arg_195_1.time_ < var_198_0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play115131049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 115131049
		arg_199_1.duration_ = 11.97

		local var_199_0 = {
			ja = 6.166,
			ko = 5.333,
			zh = 11.966,
			en = 5.933
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
				arg_199_0:Play115131050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["105201ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos105201ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(-0.7, -1.05, -6.2)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos105201ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["105201ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect105201ui_story == nil then
				arg_199_1.var_.characterEffect105201ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.2

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect105201ui_story and not isNil(var_202_9) then
					arg_199_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect105201ui_story then
				arg_199_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_202_14 = 0

			if var_202_14 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 then
				arg_199_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_202_15 = 0
			local var_202_16 = 0.325

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_17 = arg_199_1:FormatText(StoryNameCfg[263].name)

				arg_199_1.leftNameTxt_.text = var_202_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:GetWordFromCfg(115131049)
				local var_202_19 = arg_199_1:FormatText(var_202_18.content)

				arg_199_1.text_.text = var_202_19

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 13
				local var_202_21 = utf8.len(var_202_19)
				local var_202_22 = var_202_20 <= 0 and var_202_16 or var_202_16 * (var_202_21 / var_202_20)

				if var_202_22 > 0 and var_202_16 < var_202_22 then
					arg_199_1.talkMaxDuration = var_202_22

					if var_202_22 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_22 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_19
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131049", "story_v_out_115131.awb") ~= 0 then
					local var_202_23 = manager.audio:GetVoiceLength("story_v_out_115131", "115131049", "story_v_out_115131.awb") / 1000

					if var_202_23 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_23 + var_202_15
					end

					if var_202_18.prefab_name ~= "" and arg_199_1.actors_[var_202_18.prefab_name] ~= nil then
						local var_202_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_18.prefab_name].transform, "story_v_out_115131", "115131049", "story_v_out_115131.awb")

						arg_199_1:RecordAudio("115131049", var_202_24)
						arg_199_1:RecordAudio("115131049", var_202_24)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_115131", "115131049", "story_v_out_115131.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_115131", "115131049", "story_v_out_115131.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_25 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_25 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_25

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_25 and arg_199_1.time_ < var_202_15 + var_202_25 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play115131050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 115131050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play115131051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["105201ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect105201ui_story == nil then
				arg_203_1.var_.characterEffect105201ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.2

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect105201ui_story and not isNil(var_206_0) then
					local var_206_4 = Mathf.Lerp(0, 0.5, var_206_3)

					arg_203_1.var_.characterEffect105201ui_story.fillFlat = true
					arg_203_1.var_.characterEffect105201ui_story.fillRatio = var_206_4
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect105201ui_story then
				local var_206_5 = 0.5

				arg_203_1.var_.characterEffect105201ui_story.fillFlat = true
				arg_203_1.var_.characterEffect105201ui_story.fillRatio = var_206_5
			end

			local var_206_6 = arg_203_1.actors_["10014ui_story"].transform
			local var_206_7 = 0

			if var_206_7 < arg_203_1.time_ and arg_203_1.time_ <= var_206_7 + arg_206_0 then
				arg_203_1.var_.moveOldPos10014ui_story = var_206_6.localPosition
			end

			local var_206_8 = 0.001

			if var_206_7 <= arg_203_1.time_ and arg_203_1.time_ < var_206_7 + var_206_8 then
				local var_206_9 = (arg_203_1.time_ - var_206_7) / var_206_8
				local var_206_10 = Vector3.New(0.7, -1.06, -6.2)

				var_206_6.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10014ui_story, var_206_10, var_206_9)

				local var_206_11 = manager.ui.mainCamera.transform.position - var_206_6.position

				var_206_6.forward = Vector3.New(var_206_11.x, var_206_11.y, var_206_11.z)

				local var_206_12 = var_206_6.localEulerAngles

				var_206_12.z = 0
				var_206_12.x = 0
				var_206_6.localEulerAngles = var_206_12
			end

			if arg_203_1.time_ >= var_206_7 + var_206_8 and arg_203_1.time_ < var_206_7 + var_206_8 + arg_206_0 then
				var_206_6.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_206_13 = manager.ui.mainCamera.transform.position - var_206_6.position

				var_206_6.forward = Vector3.New(var_206_13.x, var_206_13.y, var_206_13.z)

				local var_206_14 = var_206_6.localEulerAngles

				var_206_14.z = 0
				var_206_14.x = 0
				var_206_6.localEulerAngles = var_206_14
			end

			local var_206_15 = arg_203_1.actors_["10014ui_story"]
			local var_206_16 = 0

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 and not isNil(var_206_15) and arg_203_1.var_.characterEffect10014ui_story == nil then
				arg_203_1.var_.characterEffect10014ui_story = var_206_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_17 = 0.0166666666666667

			if var_206_16 <= arg_203_1.time_ and arg_203_1.time_ < var_206_16 + var_206_17 and not isNil(var_206_15) then
				local var_206_18 = (arg_203_1.time_ - var_206_16) / var_206_17

				if arg_203_1.var_.characterEffect10014ui_story and not isNil(var_206_15) then
					local var_206_19 = Mathf.Lerp(0, 0.5, var_206_18)

					arg_203_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10014ui_story.fillRatio = var_206_19
				end
			end

			if arg_203_1.time_ >= var_206_16 + var_206_17 and arg_203_1.time_ < var_206_16 + var_206_17 + arg_206_0 and not isNil(var_206_15) and arg_203_1.var_.characterEffect10014ui_story then
				local var_206_20 = 0.5

				arg_203_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10014ui_story.fillRatio = var_206_20
			end

			local var_206_21 = 0
			local var_206_22 = 0.375

			if var_206_21 < arg_203_1.time_ and arg_203_1.time_ <= var_206_21 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_23 = arg_203_1:GetWordFromCfg(115131050)
				local var_206_24 = arg_203_1:FormatText(var_206_23.content)

				arg_203_1.text_.text = var_206_24

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_25 = 15
				local var_206_26 = utf8.len(var_206_24)
				local var_206_27 = var_206_25 <= 0 and var_206_22 or var_206_22 * (var_206_26 / var_206_25)

				if var_206_27 > 0 and var_206_22 < var_206_27 then
					arg_203_1.talkMaxDuration = var_206_27

					if var_206_27 + var_206_21 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_27 + var_206_21
					end
				end

				arg_203_1.text_.text = var_206_24
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_28 = math.max(var_206_22, arg_203_1.talkMaxDuration)

			if var_206_21 <= arg_203_1.time_ and arg_203_1.time_ < var_206_21 + var_206_28 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_21) / var_206_28

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_21 + var_206_28 and arg_203_1.time_ < var_206_21 + var_206_28 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play115131051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 115131051
		arg_207_1.duration_ = 6.3

		local var_207_0 = {
			ja = 2.566,
			ko = 4.133,
			zh = 4.966,
			en = 6.3
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
				arg_207_0:Play115131052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_210_1 = arg_207_1.actors_["10014ui_story"]
			local var_210_2 = 0

			if var_210_2 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect10014ui_story == nil then
				arg_207_1.var_.characterEffect10014ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_3 = 0.2

			if var_210_2 <= arg_207_1.time_ and arg_207_1.time_ < var_210_2 + var_210_3 and not isNil(var_210_1) then
				local var_210_4 = (arg_207_1.time_ - var_210_2) / var_210_3

				if arg_207_1.var_.characterEffect10014ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_2 + var_210_3 and arg_207_1.time_ < var_210_2 + var_210_3 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect10014ui_story then
				arg_207_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_210_5 = 0
			local var_210_6 = 0.45

			if var_210_5 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_7 = arg_207_1:FormatText(StoryNameCfg[264].name)

				arg_207_1.leftNameTxt_.text = var_210_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_8 = arg_207_1:GetWordFromCfg(115131051)
				local var_210_9 = arg_207_1:FormatText(var_210_8.content)

				arg_207_1.text_.text = var_210_9

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_10 = 18
				local var_210_11 = utf8.len(var_210_9)
				local var_210_12 = var_210_10 <= 0 and var_210_6 or var_210_6 * (var_210_11 / var_210_10)

				if var_210_12 > 0 and var_210_6 < var_210_12 then
					arg_207_1.talkMaxDuration = var_210_12

					if var_210_12 + var_210_5 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_5
					end
				end

				arg_207_1.text_.text = var_210_9
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131051", "story_v_out_115131.awb") ~= 0 then
					local var_210_13 = manager.audio:GetVoiceLength("story_v_out_115131", "115131051", "story_v_out_115131.awb") / 1000

					if var_210_13 + var_210_5 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_5
					end

					if var_210_8.prefab_name ~= "" and arg_207_1.actors_[var_210_8.prefab_name] ~= nil then
						local var_210_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_8.prefab_name].transform, "story_v_out_115131", "115131051", "story_v_out_115131.awb")

						arg_207_1:RecordAudio("115131051", var_210_14)
						arg_207_1:RecordAudio("115131051", var_210_14)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_115131", "115131051", "story_v_out_115131.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_115131", "115131051", "story_v_out_115131.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_15 = math.max(var_210_6, arg_207_1.talkMaxDuration)

			if var_210_5 <= arg_207_1.time_ and arg_207_1.time_ < var_210_5 + var_210_15 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_5) / var_210_15

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_5 + var_210_15 and arg_207_1.time_ < var_210_5 + var_210_15 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play115131052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 115131052
		arg_211_1.duration_ = 12.5

		local var_211_0 = {
			ja = 12.5,
			ko = 9,
			zh = 6.333,
			en = 7.833
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
				arg_211_0:Play115131053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_214_1 = 0
			local var_214_2 = 0.75

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_3 = arg_211_1:FormatText(StoryNameCfg[264].name)

				arg_211_1.leftNameTxt_.text = var_214_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_4 = arg_211_1:GetWordFromCfg(115131052)
				local var_214_5 = arg_211_1:FormatText(var_214_4.content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_6 = 30
				local var_214_7 = utf8.len(var_214_5)
				local var_214_8 = var_214_6 <= 0 and var_214_2 or var_214_2 * (var_214_7 / var_214_6)

				if var_214_8 > 0 and var_214_2 < var_214_8 then
					arg_211_1.talkMaxDuration = var_214_8

					if var_214_8 + var_214_1 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_1
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131052", "story_v_out_115131.awb") ~= 0 then
					local var_214_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131052", "story_v_out_115131.awb") / 1000

					if var_214_9 + var_214_1 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_1
					end

					if var_214_4.prefab_name ~= "" and arg_211_1.actors_[var_214_4.prefab_name] ~= nil then
						local var_214_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_4.prefab_name].transform, "story_v_out_115131", "115131052", "story_v_out_115131.awb")

						arg_211_1:RecordAudio("115131052", var_214_10)
						arg_211_1:RecordAudio("115131052", var_214_10)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_115131", "115131052", "story_v_out_115131.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_115131", "115131052", "story_v_out_115131.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_11 = math.max(var_214_2, arg_211_1.talkMaxDuration)

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_11 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_1) / var_214_11

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_1 + var_214_11 and arg_211_1.time_ < var_214_1 + var_214_11 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play115131053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 115131053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play115131054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["105201ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos105201ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(0, 100, 0)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos105201ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, 100, 0)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["10014ui_story"].transform
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 then
				arg_215_1.var_.moveOldPos10014ui_story = var_218_9.localPosition
			end

			local var_218_11 = 0.001

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11
				local var_218_13 = Vector3.New(0, 100, 0)

				var_218_9.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10014ui_story, var_218_13, var_218_12)

				local var_218_14 = manager.ui.mainCamera.transform.position - var_218_9.position

				var_218_9.forward = Vector3.New(var_218_14.x, var_218_14.y, var_218_14.z)

				local var_218_15 = var_218_9.localEulerAngles

				var_218_15.z = 0
				var_218_15.x = 0
				var_218_9.localEulerAngles = var_218_15
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 then
				var_218_9.localPosition = Vector3.New(0, 100, 0)

				local var_218_16 = manager.ui.mainCamera.transform.position - var_218_9.position

				var_218_9.forward = Vector3.New(var_218_16.x, var_218_16.y, var_218_16.z)

				local var_218_17 = var_218_9.localEulerAngles

				var_218_17.z = 0
				var_218_17.x = 0
				var_218_9.localEulerAngles = var_218_17
			end

			local var_218_18 = 0
			local var_218_19 = 0.85

			if var_218_18 < arg_215_1.time_ and arg_215_1.time_ <= var_218_18 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_20 = arg_215_1:GetWordFromCfg(115131053)
				local var_218_21 = arg_215_1:FormatText(var_218_20.content)

				arg_215_1.text_.text = var_218_21

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_22 = 34
				local var_218_23 = utf8.len(var_218_21)
				local var_218_24 = var_218_22 <= 0 and var_218_19 or var_218_19 * (var_218_23 / var_218_22)

				if var_218_24 > 0 and var_218_19 < var_218_24 then
					arg_215_1.talkMaxDuration = var_218_24

					if var_218_24 + var_218_18 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_24 + var_218_18
					end
				end

				arg_215_1.text_.text = var_218_21
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_25 = math.max(var_218_19, arg_215_1.talkMaxDuration)

			if var_218_18 <= arg_215_1.time_ and arg_215_1.time_ < var_218_18 + var_218_25 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_18) / var_218_25

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_18 + var_218_25 and arg_215_1.time_ < var_218_18 + var_218_25 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play115131054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 115131054
		arg_219_1.duration_ = 8.6

		local var_219_0 = {
			ja = 5,
			ko = 8.466,
			zh = 8.066,
			en = 8.6
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
				arg_219_0:Play115131055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.65

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[263].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_105201")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(115131054)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131054", "story_v_out_115131.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_115131", "115131054", "story_v_out_115131.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_115131", "115131054", "story_v_out_115131.awb")

						arg_219_1:RecordAudio("115131054", var_222_9)
						arg_219_1:RecordAudio("115131054", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_115131", "115131054", "story_v_out_115131.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_115131", "115131054", "story_v_out_115131.awb")
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
	Play115131055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 115131055
		arg_223_1.duration_ = 3.47

		local var_223_0 = {
			ja = 2.266,
			ko = 2.766,
			zh = 3.366,
			en = 3.466
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
				arg_223_0:Play115131056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10014ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos10014ui_story = var_226_0.localPosition
			end

			local var_226_2 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2
				local var_226_4 = Vector3.New(0, -1.06, -6.2)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10014ui_story, var_226_4, var_226_3)

				local var_226_5 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_5.x, var_226_5.y, var_226_5.z)

				local var_226_6 = var_226_0.localEulerAngles

				var_226_6.z = 0
				var_226_6.x = 0
				var_226_0.localEulerAngles = var_226_6
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_226_7 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_7.x, var_226_7.y, var_226_7.z)

				local var_226_8 = var_226_0.localEulerAngles

				var_226_8.z = 0
				var_226_8.x = 0
				var_226_0.localEulerAngles = var_226_8
			end

			local var_226_9 = 0

			if var_226_9 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 then
				arg_223_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 then
				arg_223_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_226_11 = arg_223_1.actors_["10014ui_story"]
			local var_226_12 = 0

			if var_226_12 < arg_223_1.time_ and arg_223_1.time_ <= var_226_12 + arg_226_0 and not isNil(var_226_11) and arg_223_1.var_.characterEffect10014ui_story == nil then
				arg_223_1.var_.characterEffect10014ui_story = var_226_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_13 = 0.208333333333333

			if var_226_12 <= arg_223_1.time_ and arg_223_1.time_ < var_226_12 + var_226_13 and not isNil(var_226_11) then
				local var_226_14 = (arg_223_1.time_ - var_226_12) / var_226_13

				if arg_223_1.var_.characterEffect10014ui_story and not isNil(var_226_11) then
					arg_223_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_12 + var_226_13 and arg_223_1.time_ < var_226_12 + var_226_13 + arg_226_0 and not isNil(var_226_11) and arg_223_1.var_.characterEffect10014ui_story then
				arg_223_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_226_15 = 0
			local var_226_16 = 0.325

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_17 = arg_223_1:FormatText(StoryNameCfg[264].name)

				arg_223_1.leftNameTxt_.text = var_226_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_18 = arg_223_1:GetWordFromCfg(115131055)
				local var_226_19 = arg_223_1:FormatText(var_226_18.content)

				arg_223_1.text_.text = var_226_19

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_20 = 13
				local var_226_21 = utf8.len(var_226_19)
				local var_226_22 = var_226_20 <= 0 and var_226_16 or var_226_16 * (var_226_21 / var_226_20)

				if var_226_22 > 0 and var_226_16 < var_226_22 then
					arg_223_1.talkMaxDuration = var_226_22

					if var_226_22 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_22 + var_226_15
					end
				end

				arg_223_1.text_.text = var_226_19
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131055", "story_v_out_115131.awb") ~= 0 then
					local var_226_23 = manager.audio:GetVoiceLength("story_v_out_115131", "115131055", "story_v_out_115131.awb") / 1000

					if var_226_23 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_15
					end

					if var_226_18.prefab_name ~= "" and arg_223_1.actors_[var_226_18.prefab_name] ~= nil then
						local var_226_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_18.prefab_name].transform, "story_v_out_115131", "115131055", "story_v_out_115131.awb")

						arg_223_1:RecordAudio("115131055", var_226_24)
						arg_223_1:RecordAudio("115131055", var_226_24)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_115131", "115131055", "story_v_out_115131.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_115131", "115131055", "story_v_out_115131.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_25 = math.max(var_226_16, arg_223_1.talkMaxDuration)

			if var_226_15 <= arg_223_1.time_ and arg_223_1.time_ < var_226_15 + var_226_25 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_15) / var_226_25

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_15 + var_226_25 and arg_223_1.time_ < var_226_15 + var_226_25 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play115131056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 115131056
		arg_227_1.duration_ = 10.7

		local var_227_0 = {
			ja = 10,
			ko = 10.7,
			zh = 10.6,
			en = 8.766
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
				arg_227_0:Play115131057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_230_2 = 0
			local var_230_3 = 1

			if var_230_2 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_4 = arg_227_1:FormatText(StoryNameCfg[264].name)

				arg_227_1.leftNameTxt_.text = var_230_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_5 = arg_227_1:GetWordFromCfg(115131056)
				local var_230_6 = arg_227_1:FormatText(var_230_5.content)

				arg_227_1.text_.text = var_230_6

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 40
				local var_230_8 = utf8.len(var_230_6)
				local var_230_9 = var_230_7 <= 0 and var_230_3 or var_230_3 * (var_230_8 / var_230_7)

				if var_230_9 > 0 and var_230_3 < var_230_9 then
					arg_227_1.talkMaxDuration = var_230_9

					if var_230_9 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_6
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131056", "story_v_out_115131.awb") ~= 0 then
					local var_230_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131056", "story_v_out_115131.awb") / 1000

					if var_230_10 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_2
					end

					if var_230_5.prefab_name ~= "" and arg_227_1.actors_[var_230_5.prefab_name] ~= nil then
						local var_230_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_5.prefab_name].transform, "story_v_out_115131", "115131056", "story_v_out_115131.awb")

						arg_227_1:RecordAudio("115131056", var_230_11)
						arg_227_1:RecordAudio("115131056", var_230_11)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_115131", "115131056", "story_v_out_115131.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_115131", "115131056", "story_v_out_115131.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_12 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_12 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_12

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_12 and arg_227_1.time_ < var_230_2 + var_230_12 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play115131057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 115131057
		arg_231_1.duration_ = 23.1

		local var_231_0 = {
			ja = 21.1,
			ko = 17.366,
			zh = 23.1,
			en = 21.333
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
				arg_231_0:Play115131058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_1 = 2

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_1 then
				local var_234_2 = (arg_231_1.time_ - var_234_0) / var_234_1
				local var_234_3 = Color.New(0, 0, 0)

				var_234_3.a = Mathf.Lerp(0, 1, var_234_2)
				arg_231_1.mask_.color = var_234_3
			end

			if arg_231_1.time_ >= var_234_0 + var_234_1 and arg_231_1.time_ < var_234_0 + var_234_1 + arg_234_0 then
				local var_234_4 = Color.New(0, 0, 0)

				var_234_4.a = 1
				arg_231_1.mask_.color = var_234_4
			end

			local var_234_5 = 2

			if var_234_5 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_6 = 2

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_6 then
				local var_234_7 = (arg_231_1.time_ - var_234_5) / var_234_6
				local var_234_8 = Color.New(0, 0, 0)

				var_234_8.a = Mathf.Lerp(1, 0, var_234_7)
				arg_231_1.mask_.color = var_234_8
			end

			if arg_231_1.time_ >= var_234_5 + var_234_6 and arg_231_1.time_ < var_234_5 + var_234_6 + arg_234_0 then
				local var_234_9 = Color.New(0, 0, 0)
				local var_234_10 = 0

				arg_231_1.mask_.enabled = false
				var_234_9.a = var_234_10
				arg_231_1.mask_.color = var_234_9
			end

			local var_234_11 = 2

			if var_234_11 < arg_231_1.time_ and arg_231_1.time_ <= var_234_11 + arg_234_0 then
				local var_234_12 = manager.ui.mainCamera.transform.localPosition
				local var_234_13 = Vector3.New(0, 0, 10) + Vector3.New(var_234_12.x, var_234_12.y, 0)
				local var_234_14 = arg_231_1.bgs_.G03a

				var_234_14.transform.localPosition = var_234_13
				var_234_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_234_15 = var_234_14:GetComponent("SpriteRenderer")

				if var_234_15 and var_234_15.sprite then
					local var_234_16 = (var_234_14.transform.localPosition - var_234_12).z
					local var_234_17 = manager.ui.mainCameraCom_
					local var_234_18 = 2 * var_234_16 * Mathf.Tan(var_234_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_234_19 = var_234_18 * var_234_17.aspect
					local var_234_20 = var_234_15.sprite.bounds.size.x
					local var_234_21 = var_234_15.sprite.bounds.size.y
					local var_234_22 = var_234_19 / var_234_20
					local var_234_23 = var_234_18 / var_234_21
					local var_234_24 = var_234_23 < var_234_22 and var_234_22 or var_234_23

					var_234_14.transform.localScale = Vector3.New(var_234_24, var_234_24, 0)
				end

				for iter_234_0, iter_234_1 in pairs(arg_231_1.bgs_) do
					if iter_234_0 ~= "G03a" then
						iter_234_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_234_25 = arg_231_1.actors_["1052ui_story"].transform
			local var_234_26 = 3.8

			if var_234_26 < arg_231_1.time_ and arg_231_1.time_ <= var_234_26 + arg_234_0 then
				arg_231_1.var_.moveOldPos1052ui_story = var_234_25.localPosition
			end

			local var_234_27 = 0.001

			if var_234_26 <= arg_231_1.time_ and arg_231_1.time_ < var_234_26 + var_234_27 then
				local var_234_28 = (arg_231_1.time_ - var_234_26) / var_234_27
				local var_234_29 = Vector3.New(-0.7, -1.05, -6.2)

				var_234_25.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1052ui_story, var_234_29, var_234_28)

				local var_234_30 = manager.ui.mainCamera.transform.position - var_234_25.position

				var_234_25.forward = Vector3.New(var_234_30.x, var_234_30.y, var_234_30.z)

				local var_234_31 = var_234_25.localEulerAngles

				var_234_31.z = 0
				var_234_31.x = 0
				var_234_25.localEulerAngles = var_234_31
			end

			if arg_231_1.time_ >= var_234_26 + var_234_27 and arg_231_1.time_ < var_234_26 + var_234_27 + arg_234_0 then
				var_234_25.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_234_32 = manager.ui.mainCamera.transform.position - var_234_25.position

				var_234_25.forward = Vector3.New(var_234_32.x, var_234_32.y, var_234_32.z)

				local var_234_33 = var_234_25.localEulerAngles

				var_234_33.z = 0
				var_234_33.x = 0
				var_234_25.localEulerAngles = var_234_33
			end

			local var_234_34 = 3.8

			if var_234_34 < arg_231_1.time_ and arg_231_1.time_ <= var_234_34 + arg_234_0 then
				arg_231_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_234_35 = 3.8

			if var_234_35 < arg_231_1.time_ and arg_231_1.time_ <= var_234_35 + arg_234_0 then
				arg_231_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_234_36 = arg_231_1.actors_["1052ui_story"]
			local var_234_37 = 3.8

			if var_234_37 < arg_231_1.time_ and arg_231_1.time_ <= var_234_37 + arg_234_0 and not isNil(var_234_36) and arg_231_1.var_.characterEffect1052ui_story == nil then
				arg_231_1.var_.characterEffect1052ui_story = var_234_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_38 = 0.2

			if var_234_37 <= arg_231_1.time_ and arg_231_1.time_ < var_234_37 + var_234_38 and not isNil(var_234_36) then
				local var_234_39 = (arg_231_1.time_ - var_234_37) / var_234_38

				if arg_231_1.var_.characterEffect1052ui_story and not isNil(var_234_36) then
					arg_231_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_37 + var_234_38 and arg_231_1.time_ < var_234_37 + var_234_38 + arg_234_0 and not isNil(var_234_36) and arg_231_1.var_.characterEffect1052ui_story then
				arg_231_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_234_40 = arg_231_1.bgs_.G03a
			local var_234_41 = 2

			if var_234_41 < arg_231_1.time_ and arg_231_1.time_ <= var_234_41 + arg_234_0 then
				local var_234_42 = var_234_40:GetComponent("SpriteRenderer")

				if var_234_42 then
					arg_231_1.var_.alphaOldValueG03a = var_234_42.color.a
					arg_231_1.var_.alphaMatValueG03a = var_234_42
				end

				arg_231_1.var_.alphaOldValueG03a = 0
			end

			local var_234_43 = 0.0166666666666667

			if var_234_41 <= arg_231_1.time_ and arg_231_1.time_ < var_234_41 + var_234_43 then
				local var_234_44 = (arg_231_1.time_ - var_234_41) / var_234_43
				local var_234_45 = Mathf.Lerp(arg_231_1.var_.alphaOldValueG03a, 1, var_234_44)

				if arg_231_1.var_.alphaMatValueG03a then
					local var_234_46 = arg_231_1.var_.alphaMatValueG03a.color

					var_234_46.a = var_234_45
					arg_231_1.var_.alphaMatValueG03a.color = var_234_46
				end
			end

			if arg_231_1.time_ >= var_234_41 + var_234_43 and arg_231_1.time_ < var_234_41 + var_234_43 + arg_234_0 and arg_231_1.var_.alphaMatValueG03a then
				local var_234_47 = arg_231_1.var_.alphaMatValueG03a
				local var_234_48 = var_234_47.color

				var_234_48.a = 1
				var_234_47.color = var_234_48
			end

			local var_234_49 = arg_231_1.actors_["1024ui_story"].transform
			local var_234_50 = 3.8

			if var_234_50 < arg_231_1.time_ and arg_231_1.time_ <= var_234_50 + arg_234_0 then
				arg_231_1.var_.moveOldPos1024ui_story = var_234_49.localPosition
			end

			local var_234_51 = 0.001

			if var_234_50 <= arg_231_1.time_ and arg_231_1.time_ < var_234_50 + var_234_51 then
				local var_234_52 = (arg_231_1.time_ - var_234_50) / var_234_51
				local var_234_53 = Vector3.New(0.7, -1, -6.05)

				var_234_49.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1024ui_story, var_234_53, var_234_52)

				local var_234_54 = manager.ui.mainCamera.transform.position - var_234_49.position

				var_234_49.forward = Vector3.New(var_234_54.x, var_234_54.y, var_234_54.z)

				local var_234_55 = var_234_49.localEulerAngles

				var_234_55.z = 0
				var_234_55.x = 0
				var_234_49.localEulerAngles = var_234_55
			end

			if arg_231_1.time_ >= var_234_50 + var_234_51 and arg_231_1.time_ < var_234_50 + var_234_51 + arg_234_0 then
				var_234_49.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_234_56 = manager.ui.mainCamera.transform.position - var_234_49.position

				var_234_49.forward = Vector3.New(var_234_56.x, var_234_56.y, var_234_56.z)

				local var_234_57 = var_234_49.localEulerAngles

				var_234_57.z = 0
				var_234_57.x = 0
				var_234_49.localEulerAngles = var_234_57
			end

			local var_234_58 = 3.8

			if var_234_58 < arg_231_1.time_ and arg_231_1.time_ <= var_234_58 + arg_234_0 then
				arg_231_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_234_59 = 3.8

			if var_234_59 < arg_231_1.time_ and arg_231_1.time_ <= var_234_59 + arg_234_0 then
				arg_231_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_234_60 = arg_231_1.actors_["10014ui_story"].transform
			local var_234_61 = 1.966

			if var_234_61 < arg_231_1.time_ and arg_231_1.time_ <= var_234_61 + arg_234_0 then
				arg_231_1.var_.moveOldPos10014ui_story = var_234_60.localPosition
			end

			local var_234_62 = 0.001

			if var_234_61 <= arg_231_1.time_ and arg_231_1.time_ < var_234_61 + var_234_62 then
				local var_234_63 = (arg_231_1.time_ - var_234_61) / var_234_62
				local var_234_64 = Vector3.New(0, 100, 0)

				var_234_60.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10014ui_story, var_234_64, var_234_63)

				local var_234_65 = manager.ui.mainCamera.transform.position - var_234_60.position

				var_234_60.forward = Vector3.New(var_234_65.x, var_234_65.y, var_234_65.z)

				local var_234_66 = var_234_60.localEulerAngles

				var_234_66.z = 0
				var_234_66.x = 0
				var_234_60.localEulerAngles = var_234_66
			end

			if arg_231_1.time_ >= var_234_61 + var_234_62 and arg_231_1.time_ < var_234_61 + var_234_62 + arg_234_0 then
				var_234_60.localPosition = Vector3.New(0, 100, 0)

				local var_234_67 = manager.ui.mainCamera.transform.position - var_234_60.position

				var_234_60.forward = Vector3.New(var_234_67.x, var_234_67.y, var_234_67.z)

				local var_234_68 = var_234_60.localEulerAngles

				var_234_68.z = 0
				var_234_68.x = 0
				var_234_60.localEulerAngles = var_234_68
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_69 = 4
			local var_234_70 = 1.4

			if var_234_69 < arg_231_1.time_ and arg_231_1.time_ <= var_234_69 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_71 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_71:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_72 = arg_231_1:FormatText(StoryNameCfg[263].name)

				arg_231_1.leftNameTxt_.text = var_234_72

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_73 = arg_231_1:GetWordFromCfg(115131057)
				local var_234_74 = arg_231_1:FormatText(var_234_73.content)

				arg_231_1.text_.text = var_234_74

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_75 = 56
				local var_234_76 = utf8.len(var_234_74)
				local var_234_77 = var_234_75 <= 0 and var_234_70 or var_234_70 * (var_234_76 / var_234_75)

				if var_234_77 > 0 and var_234_70 < var_234_77 then
					arg_231_1.talkMaxDuration = var_234_77
					var_234_69 = var_234_69 + 0.3

					if var_234_77 + var_234_69 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_77 + var_234_69
					end
				end

				arg_231_1.text_.text = var_234_74
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131057", "story_v_out_115131.awb") ~= 0 then
					local var_234_78 = manager.audio:GetVoiceLength("story_v_out_115131", "115131057", "story_v_out_115131.awb") / 1000

					if var_234_78 + var_234_69 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_78 + var_234_69
					end

					if var_234_73.prefab_name ~= "" and arg_231_1.actors_[var_234_73.prefab_name] ~= nil then
						local var_234_79 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_73.prefab_name].transform, "story_v_out_115131", "115131057", "story_v_out_115131.awb")

						arg_231_1:RecordAudio("115131057", var_234_79)
						arg_231_1:RecordAudio("115131057", var_234_79)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_115131", "115131057", "story_v_out_115131.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_115131", "115131057", "story_v_out_115131.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_80 = var_234_69 + 0.3
			local var_234_81 = math.max(var_234_70, arg_231_1.talkMaxDuration)

			if var_234_80 <= arg_231_1.time_ and arg_231_1.time_ < var_234_80 + var_234_81 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_80) / var_234_81

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_80 + var_234_81 and arg_231_1.time_ < var_234_80 + var_234_81 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play115131058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 115131058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play115131059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1052ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1052ui_story == nil then
				arg_237_1.var_.characterEffect1052ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.2

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect1052ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1052ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1052ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1052ui_story.fillRatio = var_240_5
			end

			local var_240_6 = 0
			local var_240_7 = 0.4

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_8 = arg_237_1:GetWordFromCfg(115131058)
				local var_240_9 = arg_237_1:FormatText(var_240_8.content)

				arg_237_1.text_.text = var_240_9

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_10 = 16
				local var_240_11 = utf8.len(var_240_9)
				local var_240_12 = var_240_10 <= 0 and var_240_7 or var_240_7 * (var_240_11 / var_240_10)

				if var_240_12 > 0 and var_240_7 < var_240_12 then
					arg_237_1.talkMaxDuration = var_240_12

					if var_240_12 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_12 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_9
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_13 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_13 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_13

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_13 and arg_237_1.time_ < var_240_6 + var_240_13 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play115131059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 115131059
		arg_241_1.duration_ = 2.3

		local var_241_0 = {
			ja = 2.1,
			ko = 2.066,
			zh = 1.8,
			en = 2.3
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
				arg_241_0:Play115131060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.175

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[273].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:GetWordFromCfg(115131059)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 7
				local var_244_6 = utf8.len(var_244_4)
				local var_244_7 = var_244_5 <= 0 and var_244_1 or var_244_1 * (var_244_6 / var_244_5)

				if var_244_7 > 0 and var_244_1 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131059", "story_v_out_115131.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_115131", "115131059", "story_v_out_115131.awb") / 1000

					if var_244_8 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_0
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_115131", "115131059", "story_v_out_115131.awb")

						arg_241_1:RecordAudio("115131059", var_244_9)
						arg_241_1:RecordAudio("115131059", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_115131", "115131059", "story_v_out_115131.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_115131", "115131059", "story_v_out_115131.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_10 and arg_241_1.time_ < var_244_0 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play115131060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 115131060
		arg_245_1.duration_ = 1.37

		local var_245_0 = {
			ja = 1.366,
			ko = 1.366,
			zh = 1.366,
			en = 1.233
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
				arg_245_0:Play115131061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.075

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[266].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024_1")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(115131060)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131060", "story_v_out_115131.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_115131", "115131060", "story_v_out_115131.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_115131", "115131060", "story_v_out_115131.awb")

						arg_245_1:RecordAudio("115131060", var_248_9)
						arg_245_1:RecordAudio("115131060", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_115131", "115131060", "story_v_out_115131.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_115131", "115131060", "story_v_out_115131.awb")
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
	Play115131061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 115131061
		arg_249_1.duration_ = 16.17

		local var_249_0 = {
			ja = 16.166,
			ko = 8.9,
			zh = 11.466,
			en = 8.9
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
				arg_249_0:Play115131062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_252_1 = arg_249_1.actors_["1052ui_story"]
			local var_252_2 = 0

			if var_252_2 < arg_249_1.time_ and arg_249_1.time_ <= var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1052ui_story == nil then
				arg_249_1.var_.characterEffect1052ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_3 = 0.2

			if var_252_2 <= arg_249_1.time_ and arg_249_1.time_ < var_252_2 + var_252_3 and not isNil(var_252_1) then
				local var_252_4 = (arg_249_1.time_ - var_252_2) / var_252_3

				if arg_249_1.var_.characterEffect1052ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_2 + var_252_3 and arg_249_1.time_ < var_252_2 + var_252_3 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1052ui_story then
				arg_249_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_252_5 = 0
			local var_252_6 = 0.85

			if var_252_5 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_7 = arg_249_1:FormatText(StoryNameCfg[263].name)

				arg_249_1.leftNameTxt_.text = var_252_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_8 = arg_249_1:GetWordFromCfg(115131061)
				local var_252_9 = arg_249_1:FormatText(var_252_8.content)

				arg_249_1.text_.text = var_252_9

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_10 = 34
				local var_252_11 = utf8.len(var_252_9)
				local var_252_12 = var_252_10 <= 0 and var_252_6 or var_252_6 * (var_252_11 / var_252_10)

				if var_252_12 > 0 and var_252_6 < var_252_12 then
					arg_249_1.talkMaxDuration = var_252_12

					if var_252_12 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_12 + var_252_5
					end
				end

				arg_249_1.text_.text = var_252_9
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131061", "story_v_out_115131.awb") ~= 0 then
					local var_252_13 = manager.audio:GetVoiceLength("story_v_out_115131", "115131061", "story_v_out_115131.awb") / 1000

					if var_252_13 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_5
					end

					if var_252_8.prefab_name ~= "" and arg_249_1.actors_[var_252_8.prefab_name] ~= nil then
						local var_252_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_8.prefab_name].transform, "story_v_out_115131", "115131061", "story_v_out_115131.awb")

						arg_249_1:RecordAudio("115131061", var_252_14)
						arg_249_1:RecordAudio("115131061", var_252_14)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_115131", "115131061", "story_v_out_115131.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_115131", "115131061", "story_v_out_115131.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_15 = math.max(var_252_6, arg_249_1.talkMaxDuration)

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_15 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_5) / var_252_15

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_5 + var_252_15 and arg_249_1.time_ < var_252_5 + var_252_15 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play115131062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 115131062
		arg_253_1.duration_ = 15.8

		local var_253_0 = {
			ja = 6.4,
			ko = 11.866,
			zh = 14.1,
			en = 15.8
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
				arg_253_0:Play115131063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_256_1 = 0
			local var_256_2 = 1.1

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_3 = arg_253_1:FormatText(StoryNameCfg[263].name)

				arg_253_1.leftNameTxt_.text = var_256_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_4 = arg_253_1:GetWordFromCfg(115131062)
				local var_256_5 = arg_253_1:FormatText(var_256_4.content)

				arg_253_1.text_.text = var_256_5

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_6 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131062", "story_v_out_115131.awb") ~= 0 then
					local var_256_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131062", "story_v_out_115131.awb") / 1000

					if var_256_9 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_1
					end

					if var_256_4.prefab_name ~= "" and arg_253_1.actors_[var_256_4.prefab_name] ~= nil then
						local var_256_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_4.prefab_name].transform, "story_v_out_115131", "115131062", "story_v_out_115131.awb")

						arg_253_1:RecordAudio("115131062", var_256_10)
						arg_253_1:RecordAudio("115131062", var_256_10)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_115131", "115131062", "story_v_out_115131.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_115131", "115131062", "story_v_out_115131.awb")
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
	Play115131063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 115131063
		arg_257_1.duration_ = 1.73

		local var_257_0 = {
			ja = 1.466,
			ko = 1.233,
			zh = 1.4,
			en = 1.733
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
				arg_257_0:Play115131064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1052ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1052ui_story == nil then
				arg_257_1.var_.characterEffect1052ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.2

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect1052ui_story and not isNil(var_260_0) then
					local var_260_4 = Mathf.Lerp(0, 0.5, var_260_3)

					arg_257_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1052ui_story.fillRatio = var_260_4
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1052ui_story then
				local var_260_5 = 0.5

				arg_257_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1052ui_story.fillRatio = var_260_5
			end

			local var_260_6 = arg_257_1.actors_["1024ui_story"]
			local var_260_7 = 0

			if var_260_7 < arg_257_1.time_ and arg_257_1.time_ <= var_260_7 + arg_260_0 and not isNil(var_260_6) and arg_257_1.var_.characterEffect1024ui_story == nil then
				arg_257_1.var_.characterEffect1024ui_story = var_260_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_8 = 0.2

			if var_260_7 <= arg_257_1.time_ and arg_257_1.time_ < var_260_7 + var_260_8 and not isNil(var_260_6) then
				local var_260_9 = (arg_257_1.time_ - var_260_7) / var_260_8

				if arg_257_1.var_.characterEffect1024ui_story and not isNil(var_260_6) then
					arg_257_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_7 + var_260_8 and arg_257_1.time_ < var_260_7 + var_260_8 + arg_260_0 and not isNil(var_260_6) and arg_257_1.var_.characterEffect1024ui_story then
				arg_257_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_260_10 = 0
			local var_260_11 = 0.05

			if var_260_10 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_12 = arg_257_1:FormatText(StoryNameCfg[265].name)

				arg_257_1.leftNameTxt_.text = var_260_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_13 = arg_257_1:GetWordFromCfg(115131063)
				local var_260_14 = arg_257_1:FormatText(var_260_13.content)

				arg_257_1.text_.text = var_260_14

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_15 = 2
				local var_260_16 = utf8.len(var_260_14)
				local var_260_17 = var_260_15 <= 0 and var_260_11 or var_260_11 * (var_260_16 / var_260_15)

				if var_260_17 > 0 and var_260_11 < var_260_17 then
					arg_257_1.talkMaxDuration = var_260_17

					if var_260_17 + var_260_10 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_17 + var_260_10
					end
				end

				arg_257_1.text_.text = var_260_14
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131063", "story_v_out_115131.awb") ~= 0 then
					local var_260_18 = manager.audio:GetVoiceLength("story_v_out_115131", "115131063", "story_v_out_115131.awb") / 1000

					if var_260_18 + var_260_10 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_18 + var_260_10
					end

					if var_260_13.prefab_name ~= "" and arg_257_1.actors_[var_260_13.prefab_name] ~= nil then
						local var_260_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_13.prefab_name].transform, "story_v_out_115131", "115131063", "story_v_out_115131.awb")

						arg_257_1:RecordAudio("115131063", var_260_19)
						arg_257_1:RecordAudio("115131063", var_260_19)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_115131", "115131063", "story_v_out_115131.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_115131", "115131063", "story_v_out_115131.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_20 = math.max(var_260_11, arg_257_1.talkMaxDuration)

			if var_260_10 <= arg_257_1.time_ and arg_257_1.time_ < var_260_10 + var_260_20 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_10) / var_260_20

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_10 + var_260_20 and arg_257_1.time_ < var_260_10 + var_260_20 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play115131064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 115131064
		arg_261_1.duration_ = 2.97

		local var_261_0 = {
			ja = 1.533,
			ko = 2.766,
			zh = 2.966,
			en = 2.266
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
				arg_261_0:Play115131065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1024ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1024ui_story == nil then
				arg_261_1.var_.characterEffect1024ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.2

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1024ui_story and not isNil(var_264_0) then
					local var_264_4 = Mathf.Lerp(0, 0.5, var_264_3)

					arg_261_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1024ui_story.fillRatio = var_264_4
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1024ui_story then
				local var_264_5 = 0.5

				arg_261_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1024ui_story.fillRatio = var_264_5
			end

			local var_264_6 = 0
			local var_264_7 = 0.2

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_8 = arg_261_1:FormatText(StoryNameCfg[273].name)

				arg_261_1.leftNameTxt_.text = var_264_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_9 = arg_261_1:GetWordFromCfg(115131064)
				local var_264_10 = arg_261_1:FormatText(var_264_9.content)

				arg_261_1.text_.text = var_264_10

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_11 = 8
				local var_264_12 = utf8.len(var_264_10)
				local var_264_13 = var_264_11 <= 0 and var_264_7 or var_264_7 * (var_264_12 / var_264_11)

				if var_264_13 > 0 and var_264_7 < var_264_13 then
					arg_261_1.talkMaxDuration = var_264_13

					if var_264_13 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_13 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_10
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131064", "story_v_out_115131.awb") ~= 0 then
					local var_264_14 = manager.audio:GetVoiceLength("story_v_out_115131", "115131064", "story_v_out_115131.awb") / 1000

					if var_264_14 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_14 + var_264_6
					end

					if var_264_9.prefab_name ~= "" and arg_261_1.actors_[var_264_9.prefab_name] ~= nil then
						local var_264_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_9.prefab_name].transform, "story_v_out_115131", "115131064", "story_v_out_115131.awb")

						arg_261_1:RecordAudio("115131064", var_264_15)
						arg_261_1:RecordAudio("115131064", var_264_15)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_115131", "115131064", "story_v_out_115131.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_115131", "115131064", "story_v_out_115131.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_16 = math.max(var_264_7, arg_261_1.talkMaxDuration)

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_16 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_6) / var_264_16

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_6 + var_264_16 and arg_261_1.time_ < var_264_6 + var_264_16 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play115131065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 115131065
		arg_265_1.duration_ = 5.43

		local var_265_0 = {
			ja = 5.433,
			ko = 3,
			zh = 1.999999999999,
			en = 2.1
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
				arg_265_0:Play115131066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1024ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1024ui_story == nil then
				arg_265_1.var_.characterEffect1024ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.2

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1024ui_story and not isNil(var_268_0) then
					arg_265_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1024ui_story then
				arg_265_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_268_4 = 0

			if var_268_4 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_268_5 = 0
			local var_268_6 = 0.225

			if var_268_5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_7 = arg_265_1:FormatText(StoryNameCfg[265].name)

				arg_265_1.leftNameTxt_.text = var_268_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_8 = arg_265_1:GetWordFromCfg(115131065)
				local var_268_9 = arg_265_1:FormatText(var_268_8.content)

				arg_265_1.text_.text = var_268_9

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_10 = 9
				local var_268_11 = utf8.len(var_268_9)
				local var_268_12 = var_268_10 <= 0 and var_268_6 or var_268_6 * (var_268_11 / var_268_10)

				if var_268_12 > 0 and var_268_6 < var_268_12 then
					arg_265_1.talkMaxDuration = var_268_12

					if var_268_12 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_12 + var_268_5
					end
				end

				arg_265_1.text_.text = var_268_9
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131065", "story_v_out_115131.awb") ~= 0 then
					local var_268_13 = manager.audio:GetVoiceLength("story_v_out_115131", "115131065", "story_v_out_115131.awb") / 1000

					if var_268_13 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_5
					end

					if var_268_8.prefab_name ~= "" and arg_265_1.actors_[var_268_8.prefab_name] ~= nil then
						local var_268_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_8.prefab_name].transform, "story_v_out_115131", "115131065", "story_v_out_115131.awb")

						arg_265_1:RecordAudio("115131065", var_268_14)
						arg_265_1:RecordAudio("115131065", var_268_14)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_115131", "115131065", "story_v_out_115131.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_115131", "115131065", "story_v_out_115131.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_15 = math.max(var_268_6, arg_265_1.talkMaxDuration)

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_15 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_5) / var_268_15

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_5 + var_268_15 and arg_265_1.time_ < var_268_5 + var_268_15 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play115131066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 115131066
		arg_269_1.duration_ = 10.83

		local var_269_0 = {
			ja = 10.833,
			ko = 5.5,
			zh = 7.433,
			en = 6.833
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
				arg_269_0:Play115131067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1052ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1052ui_story == nil then
				arg_269_1.var_.characterEffect1052ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.2

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1052ui_story and not isNil(var_272_0) then
					arg_269_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1052ui_story then
				arg_269_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_272_4 = 0

			if var_272_4 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_272_5 = arg_269_1.actors_["1024ui_story"]
			local var_272_6 = 0

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.characterEffect1024ui_story == nil then
				arg_269_1.var_.characterEffect1024ui_story = var_272_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_7 = 0.2

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_7 and not isNil(var_272_5) then
				local var_272_8 = (arg_269_1.time_ - var_272_6) / var_272_7

				if arg_269_1.var_.characterEffect1024ui_story and not isNil(var_272_5) then
					local var_272_9 = Mathf.Lerp(0, 0.5, var_272_8)

					arg_269_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1024ui_story.fillRatio = var_272_9
				end
			end

			if arg_269_1.time_ >= var_272_6 + var_272_7 and arg_269_1.time_ < var_272_6 + var_272_7 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.characterEffect1024ui_story then
				local var_272_10 = 0.5

				arg_269_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1024ui_story.fillRatio = var_272_10
			end

			local var_272_11 = 0
			local var_272_12 = 0.675

			if var_272_11 < arg_269_1.time_ and arg_269_1.time_ <= var_272_11 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_13 = arg_269_1:FormatText(StoryNameCfg[263].name)

				arg_269_1.leftNameTxt_.text = var_272_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_14 = arg_269_1:GetWordFromCfg(115131066)
				local var_272_15 = arg_269_1:FormatText(var_272_14.content)

				arg_269_1.text_.text = var_272_15

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_16 = 27
				local var_272_17 = utf8.len(var_272_15)
				local var_272_18 = var_272_16 <= 0 and var_272_12 or var_272_12 * (var_272_17 / var_272_16)

				if var_272_18 > 0 and var_272_12 < var_272_18 then
					arg_269_1.talkMaxDuration = var_272_18

					if var_272_18 + var_272_11 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_18 + var_272_11
					end
				end

				arg_269_1.text_.text = var_272_15
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131066", "story_v_out_115131.awb") ~= 0 then
					local var_272_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131066", "story_v_out_115131.awb") / 1000

					if var_272_19 + var_272_11 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_19 + var_272_11
					end

					if var_272_14.prefab_name ~= "" and arg_269_1.actors_[var_272_14.prefab_name] ~= nil then
						local var_272_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_14.prefab_name].transform, "story_v_out_115131", "115131066", "story_v_out_115131.awb")

						arg_269_1:RecordAudio("115131066", var_272_20)
						arg_269_1:RecordAudio("115131066", var_272_20)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_115131", "115131066", "story_v_out_115131.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_115131", "115131066", "story_v_out_115131.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_21 = math.max(var_272_12, arg_269_1.talkMaxDuration)

			if var_272_11 <= arg_269_1.time_ and arg_269_1.time_ < var_272_11 + var_272_21 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_11) / var_272_21

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_11 + var_272_21 and arg_269_1.time_ < var_272_11 + var_272_21 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play115131067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 115131067
		arg_273_1.duration_ = 12.3

		local var_273_0 = {
			ja = 11.1,
			ko = 12.3,
			zh = 9.333,
			en = 9.533
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
				arg_273_0:Play115131068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_276_1 = arg_273_1.actors_["1024ui_story"]
			local var_276_2 = 0

			if var_276_2 < arg_273_1.time_ and arg_273_1.time_ <= var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1024ui_story == nil then
				arg_273_1.var_.characterEffect1024ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_3 = 0.2

			if var_276_2 <= arg_273_1.time_ and arg_273_1.time_ < var_276_2 + var_276_3 and not isNil(var_276_1) then
				local var_276_4 = (arg_273_1.time_ - var_276_2) / var_276_3

				if arg_273_1.var_.characterEffect1024ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_2 + var_276_3 and arg_273_1.time_ < var_276_2 + var_276_3 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1024ui_story then
				arg_273_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_276_5 = arg_273_1.actors_["1052ui_story"]
			local var_276_6 = 0

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.characterEffect1052ui_story == nil then
				arg_273_1.var_.characterEffect1052ui_story = var_276_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_7 = 0.2

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_7 and not isNil(var_276_5) then
				local var_276_8 = (arg_273_1.time_ - var_276_6) / var_276_7

				if arg_273_1.var_.characterEffect1052ui_story and not isNil(var_276_5) then
					local var_276_9 = Mathf.Lerp(0, 0.5, var_276_8)

					arg_273_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1052ui_story.fillRatio = var_276_9
				end
			end

			if arg_273_1.time_ >= var_276_6 + var_276_7 and arg_273_1.time_ < var_276_6 + var_276_7 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.characterEffect1052ui_story then
				local var_276_10 = 0.5

				arg_273_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1052ui_story.fillRatio = var_276_10
			end

			local var_276_11 = 0
			local var_276_12 = 1.1

			if var_276_11 < arg_273_1.time_ and arg_273_1.time_ <= var_276_11 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_13 = arg_273_1:FormatText(StoryNameCfg[265].name)

				arg_273_1.leftNameTxt_.text = var_276_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_14 = arg_273_1:GetWordFromCfg(115131067)
				local var_276_15 = arg_273_1:FormatText(var_276_14.content)

				arg_273_1.text_.text = var_276_15

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_16 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131067", "story_v_out_115131.awb") ~= 0 then
					local var_276_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131067", "story_v_out_115131.awb") / 1000

					if var_276_19 + var_276_11 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_19 + var_276_11
					end

					if var_276_14.prefab_name ~= "" and arg_273_1.actors_[var_276_14.prefab_name] ~= nil then
						local var_276_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_14.prefab_name].transform, "story_v_out_115131", "115131067", "story_v_out_115131.awb")

						arg_273_1:RecordAudio("115131067", var_276_20)
						arg_273_1:RecordAudio("115131067", var_276_20)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_115131", "115131067", "story_v_out_115131.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_115131", "115131067", "story_v_out_115131.awb")
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

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play115131068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 115131068
		arg_277_1.duration_ = 14.1

		local var_277_0 = {
			ja = 14.1,
			ko = 12.066,
			zh = 11.633,
			en = 10.7
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
				arg_277_0:Play115131069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1024ui_story"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1024ui_story == nil then
				arg_277_1.var_.characterEffect1024ui_story = var_280_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.2

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.characterEffect1024ui_story and not isNil(var_280_0) then
					local var_280_4 = Mathf.Lerp(0, 0.5, var_280_3)

					arg_277_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1024ui_story.fillRatio = var_280_4
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1024ui_story then
				local var_280_5 = 0.5

				arg_277_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1024ui_story.fillRatio = var_280_5
			end

			local var_280_6 = 0

			if var_280_6 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_280_7 = arg_277_1.actors_["1052ui_story"]
			local var_280_8 = 0

			if var_280_8 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.characterEffect1052ui_story == nil then
				arg_277_1.var_.characterEffect1052ui_story = var_280_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_9 = 0.2

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_9 and not isNil(var_280_7) then
				local var_280_10 = (arg_277_1.time_ - var_280_8) / var_280_9

				if arg_277_1.var_.characterEffect1052ui_story and not isNil(var_280_7) then
					arg_277_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_8 + var_280_9 and arg_277_1.time_ < var_280_8 + var_280_9 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.characterEffect1052ui_story then
				arg_277_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_280_11 = 0

			if var_280_11 < arg_277_1.time_ and arg_277_1.time_ <= var_280_11 + arg_280_0 then
				arg_277_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action7_1")
			end

			local var_280_12 = 0
			local var_280_13 = 1.175

			if var_280_12 < arg_277_1.time_ and arg_277_1.time_ <= var_280_12 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_14 = arg_277_1:FormatText(StoryNameCfg[263].name)

				arg_277_1.leftNameTxt_.text = var_280_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_15 = arg_277_1:GetWordFromCfg(115131068)
				local var_280_16 = arg_277_1:FormatText(var_280_15.content)

				arg_277_1.text_.text = var_280_16

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_17 = 47
				local var_280_18 = utf8.len(var_280_16)
				local var_280_19 = var_280_17 <= 0 and var_280_13 or var_280_13 * (var_280_18 / var_280_17)

				if var_280_19 > 0 and var_280_13 < var_280_19 then
					arg_277_1.talkMaxDuration = var_280_19

					if var_280_19 + var_280_12 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_19 + var_280_12
					end
				end

				arg_277_1.text_.text = var_280_16
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131068", "story_v_out_115131.awb") ~= 0 then
					local var_280_20 = manager.audio:GetVoiceLength("story_v_out_115131", "115131068", "story_v_out_115131.awb") / 1000

					if var_280_20 + var_280_12 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_20 + var_280_12
					end

					if var_280_15.prefab_name ~= "" and arg_277_1.actors_[var_280_15.prefab_name] ~= nil then
						local var_280_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_15.prefab_name].transform, "story_v_out_115131", "115131068", "story_v_out_115131.awb")

						arg_277_1:RecordAudio("115131068", var_280_21)
						arg_277_1:RecordAudio("115131068", var_280_21)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_115131", "115131068", "story_v_out_115131.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_115131", "115131068", "story_v_out_115131.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_22 = math.max(var_280_13, arg_277_1.talkMaxDuration)

			if var_280_12 <= arg_277_1.time_ and arg_277_1.time_ < var_280_12 + var_280_22 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_12) / var_280_22

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_12 + var_280_22 and arg_277_1.time_ < var_280_12 + var_280_22 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play115131069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 115131069
		arg_281_1.duration_ = 8.67

		local var_281_0 = {
			ja = 8.666,
			ko = 7.633,
			zh = 5.833,
			en = 5.166
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
				arg_281_0:Play115131070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_284_1 = arg_281_1.actors_["1024ui_story"]
			local var_284_2 = 0

			if var_284_2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1024ui_story == nil then
				arg_281_1.var_.characterEffect1024ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_3 = 0.2

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_3 and not isNil(var_284_1) then
				local var_284_4 = (arg_281_1.time_ - var_284_2) / var_284_3

				if arg_281_1.var_.characterEffect1024ui_story and not isNil(var_284_1) then
					arg_281_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_2 + var_284_3 and arg_281_1.time_ < var_284_2 + var_284_3 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1024ui_story then
				arg_281_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_284_5 = arg_281_1.actors_["1052ui_story"]
			local var_284_6 = 0

			if var_284_6 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 and not isNil(var_284_5) and arg_281_1.var_.characterEffect1052ui_story == nil then
				arg_281_1.var_.characterEffect1052ui_story = var_284_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_7 = 0.2

			if var_284_6 <= arg_281_1.time_ and arg_281_1.time_ < var_284_6 + var_284_7 and not isNil(var_284_5) then
				local var_284_8 = (arg_281_1.time_ - var_284_6) / var_284_7

				if arg_281_1.var_.characterEffect1052ui_story and not isNil(var_284_5) then
					local var_284_9 = Mathf.Lerp(0, 0.5, var_284_8)

					arg_281_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1052ui_story.fillRatio = var_284_9
				end
			end

			if arg_281_1.time_ >= var_284_6 + var_284_7 and arg_281_1.time_ < var_284_6 + var_284_7 + arg_284_0 and not isNil(var_284_5) and arg_281_1.var_.characterEffect1052ui_story then
				local var_284_10 = 0.5

				arg_281_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1052ui_story.fillRatio = var_284_10
			end

			local var_284_11 = 0
			local var_284_12 = 0.725

			if var_284_11 < arg_281_1.time_ and arg_281_1.time_ <= var_284_11 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_13 = arg_281_1:FormatText(StoryNameCfg[265].name)

				arg_281_1.leftNameTxt_.text = var_284_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_14 = arg_281_1:GetWordFromCfg(115131069)
				local var_284_15 = arg_281_1:FormatText(var_284_14.content)

				arg_281_1.text_.text = var_284_15

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_16 = 29
				local var_284_17 = utf8.len(var_284_15)
				local var_284_18 = var_284_16 <= 0 and var_284_12 or var_284_12 * (var_284_17 / var_284_16)

				if var_284_18 > 0 and var_284_12 < var_284_18 then
					arg_281_1.talkMaxDuration = var_284_18

					if var_284_18 + var_284_11 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_18 + var_284_11
					end
				end

				arg_281_1.text_.text = var_284_15
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131069", "story_v_out_115131.awb") ~= 0 then
					local var_284_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131069", "story_v_out_115131.awb") / 1000

					if var_284_19 + var_284_11 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_19 + var_284_11
					end

					if var_284_14.prefab_name ~= "" and arg_281_1.actors_[var_284_14.prefab_name] ~= nil then
						local var_284_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_14.prefab_name].transform, "story_v_out_115131", "115131069", "story_v_out_115131.awb")

						arg_281_1:RecordAudio("115131069", var_284_20)
						arg_281_1:RecordAudio("115131069", var_284_20)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_115131", "115131069", "story_v_out_115131.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_115131", "115131069", "story_v_out_115131.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_21 = math.max(var_284_12, arg_281_1.talkMaxDuration)

			if var_284_11 <= arg_281_1.time_ and arg_281_1.time_ < var_284_11 + var_284_21 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_11) / var_284_21

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_11 + var_284_21 and arg_281_1.time_ < var_284_11 + var_284_21 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play115131070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 115131070
		arg_285_1.duration_ = 14

		local var_285_0 = {
			ja = 14,
			ko = 11.033,
			zh = 13.766,
			en = 9.666
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play115131071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_288_1 = arg_285_1.actors_["1024ui_story"]
			local var_288_2 = 0

			if var_288_2 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1024ui_story == nil then
				arg_285_1.var_.characterEffect1024ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_3 = 0.2

			if var_288_2 <= arg_285_1.time_ and arg_285_1.time_ < var_288_2 + var_288_3 and not isNil(var_288_1) then
				local var_288_4 = (arg_285_1.time_ - var_288_2) / var_288_3

				if arg_285_1.var_.characterEffect1024ui_story and not isNil(var_288_1) then
					local var_288_5 = Mathf.Lerp(0, 0.5, var_288_4)

					arg_285_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1024ui_story.fillRatio = var_288_5
				end
			end

			if arg_285_1.time_ >= var_288_2 + var_288_3 and arg_285_1.time_ < var_288_2 + var_288_3 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1024ui_story then
				local var_288_6 = 0.5

				arg_285_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1024ui_story.fillRatio = var_288_6
			end

			local var_288_7 = arg_285_1.actors_["1052ui_story"]
			local var_288_8 = 0

			if var_288_8 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 and not isNil(var_288_7) and arg_285_1.var_.characterEffect1052ui_story == nil then
				arg_285_1.var_.characterEffect1052ui_story = var_288_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_9 = 0.2

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_9 and not isNil(var_288_7) then
				local var_288_10 = (arg_285_1.time_ - var_288_8) / var_288_9

				if arg_285_1.var_.characterEffect1052ui_story and not isNil(var_288_7) then
					arg_285_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_8 + var_288_9 and arg_285_1.time_ < var_288_8 + var_288_9 + arg_288_0 and not isNil(var_288_7) and arg_285_1.var_.characterEffect1052ui_story then
				arg_285_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_288_11 = 0
			local var_288_12 = 1.3

			if var_288_11 < arg_285_1.time_ and arg_285_1.time_ <= var_288_11 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_13 = arg_285_1:FormatText(StoryNameCfg[263].name)

				arg_285_1.leftNameTxt_.text = var_288_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_14 = arg_285_1:GetWordFromCfg(115131070)
				local var_288_15 = arg_285_1:FormatText(var_288_14.content)

				arg_285_1.text_.text = var_288_15

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_16 = 52
				local var_288_17 = utf8.len(var_288_15)
				local var_288_18 = var_288_16 <= 0 and var_288_12 or var_288_12 * (var_288_17 / var_288_16)

				if var_288_18 > 0 and var_288_12 < var_288_18 then
					arg_285_1.talkMaxDuration = var_288_18

					if var_288_18 + var_288_11 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_18 + var_288_11
					end
				end

				arg_285_1.text_.text = var_288_15
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131070", "story_v_out_115131.awb") ~= 0 then
					local var_288_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131070", "story_v_out_115131.awb") / 1000

					if var_288_19 + var_288_11 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_19 + var_288_11
					end

					if var_288_14.prefab_name ~= "" and arg_285_1.actors_[var_288_14.prefab_name] ~= nil then
						local var_288_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_14.prefab_name].transform, "story_v_out_115131", "115131070", "story_v_out_115131.awb")

						arg_285_1:RecordAudio("115131070", var_288_20)
						arg_285_1:RecordAudio("115131070", var_288_20)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_115131", "115131070", "story_v_out_115131.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_115131", "115131070", "story_v_out_115131.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_21 = math.max(var_288_12, arg_285_1.talkMaxDuration)

			if var_288_11 <= arg_285_1.time_ and arg_285_1.time_ < var_288_11 + var_288_21 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_11) / var_288_21

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_11 + var_288_21 and arg_285_1.time_ < var_288_11 + var_288_21 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play115131071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 115131071
		arg_289_1.duration_ = 17.57

		local var_289_0 = {
			ja = 16,
			ko = 12.466,
			zh = 13.233,
			en = 17.566
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
				arg_289_0:Play115131072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_292_1 = 0
			local var_292_2 = 1.225

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_3 = arg_289_1:FormatText(StoryNameCfg[263].name)

				arg_289_1.leftNameTxt_.text = var_292_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_4 = arg_289_1:GetWordFromCfg(115131071)
				local var_292_5 = arg_289_1:FormatText(var_292_4.content)

				arg_289_1.text_.text = var_292_5

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_6 = 49
				local var_292_7 = utf8.len(var_292_5)
				local var_292_8 = var_292_6 <= 0 and var_292_2 or var_292_2 * (var_292_7 / var_292_6)

				if var_292_8 > 0 and var_292_2 < var_292_8 then
					arg_289_1.talkMaxDuration = var_292_8

					if var_292_8 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_1
					end
				end

				arg_289_1.text_.text = var_292_5
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131071", "story_v_out_115131.awb") ~= 0 then
					local var_292_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131071", "story_v_out_115131.awb") / 1000

					if var_292_9 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_1
					end

					if var_292_4.prefab_name ~= "" and arg_289_1.actors_[var_292_4.prefab_name] ~= nil then
						local var_292_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_4.prefab_name].transform, "story_v_out_115131", "115131071", "story_v_out_115131.awb")

						arg_289_1:RecordAudio("115131071", var_292_10)
						arg_289_1:RecordAudio("115131071", var_292_10)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_115131", "115131071", "story_v_out_115131.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_115131", "115131071", "story_v_out_115131.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_11 = math.max(var_292_2, arg_289_1.talkMaxDuration)

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_11 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_1) / var_292_11

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_1 + var_292_11 and arg_289_1.time_ < var_292_1 + var_292_11 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play115131072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 115131072
		arg_293_1.duration_ = 17.87

		local var_293_0 = {
			ja = 12.3,
			ko = 15.7,
			zh = 17.866,
			en = 12.4
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
				arg_293_0:Play115131073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052actionlink/1052action476")
			end

			local var_296_2 = 0
			local var_296_3 = 1.55

			if var_296_2 < arg_293_1.time_ and arg_293_1.time_ <= var_296_2 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_4 = arg_293_1:FormatText(StoryNameCfg[263].name)

				arg_293_1.leftNameTxt_.text = var_296_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_5 = arg_293_1:GetWordFromCfg(115131072)
				local var_296_6 = arg_293_1:FormatText(var_296_5.content)

				arg_293_1.text_.text = var_296_6

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_7 = 62
				local var_296_8 = utf8.len(var_296_6)
				local var_296_9 = var_296_7 <= 0 and var_296_3 or var_296_3 * (var_296_8 / var_296_7)

				if var_296_9 > 0 and var_296_3 < var_296_9 then
					arg_293_1.talkMaxDuration = var_296_9

					if var_296_9 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_9 + var_296_2
					end
				end

				arg_293_1.text_.text = var_296_6
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131072", "story_v_out_115131.awb") ~= 0 then
					local var_296_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131072", "story_v_out_115131.awb") / 1000

					if var_296_10 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_2
					end

					if var_296_5.prefab_name ~= "" and arg_293_1.actors_[var_296_5.prefab_name] ~= nil then
						local var_296_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_5.prefab_name].transform, "story_v_out_115131", "115131072", "story_v_out_115131.awb")

						arg_293_1:RecordAudio("115131072", var_296_11)
						arg_293_1:RecordAudio("115131072", var_296_11)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_115131", "115131072", "story_v_out_115131.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_115131", "115131072", "story_v_out_115131.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_12 = math.max(var_296_3, arg_293_1.talkMaxDuration)

			if var_296_2 <= arg_293_1.time_ and arg_293_1.time_ < var_296_2 + var_296_12 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_2) / var_296_12

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_2 + var_296_12 and arg_293_1.time_ < var_296_2 + var_296_12 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play115131073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 115131073
		arg_297_1.duration_ = 18.3

		local var_297_0 = {
			ja = 18.3,
			ko = 17,
			zh = 12.8,
			en = 15.666
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
				arg_297_0:Play115131074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_300_1 = arg_297_1.actors_["1024ui_story"]
			local var_300_2 = 0

			if var_300_2 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1024ui_story == nil then
				arg_297_1.var_.characterEffect1024ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_3 = 0.2

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_3 and not isNil(var_300_1) then
				local var_300_4 = (arg_297_1.time_ - var_300_2) / var_300_3

				if arg_297_1.var_.characterEffect1024ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_2 + var_300_3 and arg_297_1.time_ < var_300_2 + var_300_3 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1024ui_story then
				arg_297_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_300_5 = arg_297_1.actors_["1052ui_story"]
			local var_300_6 = 0

			if var_300_6 < arg_297_1.time_ and arg_297_1.time_ <= var_300_6 + arg_300_0 and not isNil(var_300_5) and arg_297_1.var_.characterEffect1052ui_story == nil then
				arg_297_1.var_.characterEffect1052ui_story = var_300_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_7 = 0.2

			if var_300_6 <= arg_297_1.time_ and arg_297_1.time_ < var_300_6 + var_300_7 and not isNil(var_300_5) then
				local var_300_8 = (arg_297_1.time_ - var_300_6) / var_300_7

				if arg_297_1.var_.characterEffect1052ui_story and not isNil(var_300_5) then
					local var_300_9 = Mathf.Lerp(0, 0.5, var_300_8)

					arg_297_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1052ui_story.fillRatio = var_300_9
				end
			end

			if arg_297_1.time_ >= var_300_6 + var_300_7 and arg_297_1.time_ < var_300_6 + var_300_7 + arg_300_0 and not isNil(var_300_5) and arg_297_1.var_.characterEffect1052ui_story then
				local var_300_10 = 0.5

				arg_297_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1052ui_story.fillRatio = var_300_10
			end

			local var_300_11 = 0
			local var_300_12 = 1.525

			if var_300_11 < arg_297_1.time_ and arg_297_1.time_ <= var_300_11 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_13 = arg_297_1:FormatText(StoryNameCfg[265].name)

				arg_297_1.leftNameTxt_.text = var_300_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_14 = arg_297_1:GetWordFromCfg(115131073)
				local var_300_15 = arg_297_1:FormatText(var_300_14.content)

				arg_297_1.text_.text = var_300_15

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_16 = 61
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

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131073", "story_v_out_115131.awb") ~= 0 then
					local var_300_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131073", "story_v_out_115131.awb") / 1000

					if var_300_19 + var_300_11 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_19 + var_300_11
					end

					if var_300_14.prefab_name ~= "" and arg_297_1.actors_[var_300_14.prefab_name] ~= nil then
						local var_300_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_14.prefab_name].transform, "story_v_out_115131", "115131073", "story_v_out_115131.awb")

						arg_297_1:RecordAudio("115131073", var_300_20)
						arg_297_1:RecordAudio("115131073", var_300_20)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_115131", "115131073", "story_v_out_115131.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_115131", "115131073", "story_v_out_115131.awb")
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
	Play115131074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 115131074
		arg_301_1.duration_ = 16

		local var_301_0 = {
			ja = 16,
			ko = 9.6,
			zh = 11.633,
			en = 7.833
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
				arg_301_0:Play115131075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_304_1 = arg_301_1.actors_["1024ui_story"]
			local var_304_2 = 0

			if var_304_2 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1024ui_story == nil then
				arg_301_1.var_.characterEffect1024ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_3 = 0.2

			if var_304_2 <= arg_301_1.time_ and arg_301_1.time_ < var_304_2 + var_304_3 and not isNil(var_304_1) then
				local var_304_4 = (arg_301_1.time_ - var_304_2) / var_304_3

				if arg_301_1.var_.characterEffect1024ui_story and not isNil(var_304_1) then
					local var_304_5 = Mathf.Lerp(0, 0.5, var_304_4)

					arg_301_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1024ui_story.fillRatio = var_304_5
				end
			end

			if arg_301_1.time_ >= var_304_2 + var_304_3 and arg_301_1.time_ < var_304_2 + var_304_3 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1024ui_story then
				local var_304_6 = 0.5

				arg_301_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1024ui_story.fillRatio = var_304_6
			end

			local var_304_7 = arg_301_1.actors_["1052ui_story"]
			local var_304_8 = 0

			if var_304_8 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 and not isNil(var_304_7) and arg_301_1.var_.characterEffect1052ui_story == nil then
				arg_301_1.var_.characterEffect1052ui_story = var_304_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_9 = 0.2

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_9 and not isNil(var_304_7) then
				local var_304_10 = (arg_301_1.time_ - var_304_8) / var_304_9

				if arg_301_1.var_.characterEffect1052ui_story and not isNil(var_304_7) then
					arg_301_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_8 + var_304_9 and arg_301_1.time_ < var_304_8 + var_304_9 + arg_304_0 and not isNil(var_304_7) and arg_301_1.var_.characterEffect1052ui_story then
				arg_301_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_304_11 = 0
			local var_304_12 = 0.85

			if var_304_11 < arg_301_1.time_ and arg_301_1.time_ <= var_304_11 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_13 = arg_301_1:FormatText(StoryNameCfg[263].name)

				arg_301_1.leftNameTxt_.text = var_304_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_14 = arg_301_1:GetWordFromCfg(115131074)
				local var_304_15 = arg_301_1:FormatText(var_304_14.content)

				arg_301_1.text_.text = var_304_15

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_16 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131074", "story_v_out_115131.awb") ~= 0 then
					local var_304_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131074", "story_v_out_115131.awb") / 1000

					if var_304_19 + var_304_11 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_19 + var_304_11
					end

					if var_304_14.prefab_name ~= "" and arg_301_1.actors_[var_304_14.prefab_name] ~= nil then
						local var_304_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_14.prefab_name].transform, "story_v_out_115131", "115131074", "story_v_out_115131.awb")

						arg_301_1:RecordAudio("115131074", var_304_20)
						arg_301_1:RecordAudio("115131074", var_304_20)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_115131", "115131074", "story_v_out_115131.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_115131", "115131074", "story_v_out_115131.awb")
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
	Play115131075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 115131075
		arg_305_1.duration_ = 10.43

		local var_305_0 = {
			ja = 9.8,
			ko = 8.266,
			zh = 7.9,
			en = 10.433
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play115131076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1052ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1052ui_story == nil then
				arg_305_1.var_.characterEffect1052ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.2

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1052ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1052ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1052ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1052ui_story.fillRatio = var_308_5
			end

			local var_308_6 = arg_305_1.actors_["1024ui_story"].transform
			local var_308_7 = 0

			if var_308_7 < arg_305_1.time_ and arg_305_1.time_ <= var_308_7 + arg_308_0 then
				arg_305_1.var_.moveOldPos1024ui_story = var_308_6.localPosition
			end

			local var_308_8 = 0.001

			if var_308_7 <= arg_305_1.time_ and arg_305_1.time_ < var_308_7 + var_308_8 then
				local var_308_9 = (arg_305_1.time_ - var_308_7) / var_308_8
				local var_308_10 = Vector3.New(0, 100, 0)

				var_308_6.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1024ui_story, var_308_10, var_308_9)

				local var_308_11 = manager.ui.mainCamera.transform.position - var_308_6.position

				var_308_6.forward = Vector3.New(var_308_11.x, var_308_11.y, var_308_11.z)

				local var_308_12 = var_308_6.localEulerAngles

				var_308_12.z = 0
				var_308_12.x = 0
				var_308_6.localEulerAngles = var_308_12
			end

			if arg_305_1.time_ >= var_308_7 + var_308_8 and arg_305_1.time_ < var_308_7 + var_308_8 + arg_308_0 then
				var_308_6.localPosition = Vector3.New(0, 100, 0)

				local var_308_13 = manager.ui.mainCamera.transform.position - var_308_6.position

				var_308_6.forward = Vector3.New(var_308_13.x, var_308_13.y, var_308_13.z)

				local var_308_14 = var_308_6.localEulerAngles

				var_308_14.z = 0
				var_308_14.x = 0
				var_308_6.localEulerAngles = var_308_14
			end

			local var_308_15 = arg_305_1.actors_["1017ui_story"].transform
			local var_308_16 = 0

			if var_308_16 < arg_305_1.time_ and arg_305_1.time_ <= var_308_16 + arg_308_0 then
				arg_305_1.var_.moveOldPos1017ui_story = var_308_15.localPosition
			end

			local var_308_17 = 0.001

			if var_308_16 <= arg_305_1.time_ and arg_305_1.time_ < var_308_16 + var_308_17 then
				local var_308_18 = (arg_305_1.time_ - var_308_16) / var_308_17
				local var_308_19 = Vector3.New(0.7, -1.01, -6.05)

				var_308_15.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1017ui_story, var_308_19, var_308_18)

				local var_308_20 = manager.ui.mainCamera.transform.position - var_308_15.position

				var_308_15.forward = Vector3.New(var_308_20.x, var_308_20.y, var_308_20.z)

				local var_308_21 = var_308_15.localEulerAngles

				var_308_21.z = 0
				var_308_21.x = 0
				var_308_15.localEulerAngles = var_308_21
			end

			if arg_305_1.time_ >= var_308_16 + var_308_17 and arg_305_1.time_ < var_308_16 + var_308_17 + arg_308_0 then
				var_308_15.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_308_22 = manager.ui.mainCamera.transform.position - var_308_15.position

				var_308_15.forward = Vector3.New(var_308_22.x, var_308_22.y, var_308_22.z)

				local var_308_23 = var_308_15.localEulerAngles

				var_308_23.z = 0
				var_308_23.x = 0
				var_308_15.localEulerAngles = var_308_23
			end

			local var_308_24 = 0

			if var_308_24 < arg_305_1.time_ and arg_305_1.time_ <= var_308_24 + arg_308_0 then
				arg_305_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_1")
			end

			local var_308_25 = 0

			if var_308_25 < arg_305_1.time_ and arg_305_1.time_ <= var_308_25 + arg_308_0 then
				arg_305_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_308_26 = arg_305_1.actors_["1017ui_story"]
			local var_308_27 = 0

			if var_308_27 < arg_305_1.time_ and arg_305_1.time_ <= var_308_27 + arg_308_0 and not isNil(var_308_26) and arg_305_1.var_.characterEffect1017ui_story == nil then
				arg_305_1.var_.characterEffect1017ui_story = var_308_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_28 = 0.2

			if var_308_27 <= arg_305_1.time_ and arg_305_1.time_ < var_308_27 + var_308_28 and not isNil(var_308_26) then
				local var_308_29 = (arg_305_1.time_ - var_308_27) / var_308_28

				if arg_305_1.var_.characterEffect1017ui_story and not isNil(var_308_26) then
					arg_305_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= var_308_27 + var_308_28 and arg_305_1.time_ < var_308_27 + var_308_28 + arg_308_0 and not isNil(var_308_26) and arg_305_1.var_.characterEffect1017ui_story then
				arg_305_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_308_30 = 0
			local var_308_31 = 1.075

			if var_308_30 < arg_305_1.time_ and arg_305_1.time_ <= var_308_30 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_32 = arg_305_1:FormatText(StoryNameCfg[273].name)

				arg_305_1.leftNameTxt_.text = var_308_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_33 = arg_305_1:GetWordFromCfg(115131075)
				local var_308_34 = arg_305_1:FormatText(var_308_33.content)

				arg_305_1.text_.text = var_308_34

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_35 = 43
				local var_308_36 = utf8.len(var_308_34)
				local var_308_37 = var_308_35 <= 0 and var_308_31 or var_308_31 * (var_308_36 / var_308_35)

				if var_308_37 > 0 and var_308_31 < var_308_37 then
					arg_305_1.talkMaxDuration = var_308_37

					if var_308_37 + var_308_30 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_37 + var_308_30
					end
				end

				arg_305_1.text_.text = var_308_34
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131075", "story_v_out_115131.awb") ~= 0 then
					local var_308_38 = manager.audio:GetVoiceLength("story_v_out_115131", "115131075", "story_v_out_115131.awb") / 1000

					if var_308_38 + var_308_30 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_38 + var_308_30
					end

					if var_308_33.prefab_name ~= "" and arg_305_1.actors_[var_308_33.prefab_name] ~= nil then
						local var_308_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_33.prefab_name].transform, "story_v_out_115131", "115131075", "story_v_out_115131.awb")

						arg_305_1:RecordAudio("115131075", var_308_39)
						arg_305_1:RecordAudio("115131075", var_308_39)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_115131", "115131075", "story_v_out_115131.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_115131", "115131075", "story_v_out_115131.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_40 = math.max(var_308_31, arg_305_1.talkMaxDuration)

			if var_308_30 <= arg_305_1.time_ and arg_305_1.time_ < var_308_30 + var_308_40 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_30) / var_308_40

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_30 + var_308_40 and arg_305_1.time_ < var_308_30 + var_308_40 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play115131076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 115131076
		arg_309_1.duration_ = 8.83

		local var_309_0 = {
			ja = 8.833,
			ko = 8.833,
			zh = 6.233,
			en = 7.366
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
				arg_309_0:Play115131077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1017ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1017ui_story == nil then
				arg_309_1.var_.characterEffect1017ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.2

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1017ui_story and not isNil(var_312_0) then
					local var_312_4 = Mathf.Lerp(0, 0.5, var_312_3)

					arg_309_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1017ui_story.fillRatio = var_312_4
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1017ui_story then
				local var_312_5 = 0.5

				arg_309_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1017ui_story.fillRatio = var_312_5
			end

			local var_312_6 = 0
			local var_312_7 = 0.75

			if var_312_6 < arg_309_1.time_ and arg_309_1.time_ <= var_312_6 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_8 = arg_309_1:FormatText(StoryNameCfg[265].name)

				arg_309_1.leftNameTxt_.text = var_312_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_9 = arg_309_1:GetWordFromCfg(115131076)
				local var_312_10 = arg_309_1:FormatText(var_312_9.content)

				arg_309_1.text_.text = var_312_10

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_11 = 30
				local var_312_12 = utf8.len(var_312_10)
				local var_312_13 = var_312_11 <= 0 and var_312_7 or var_312_7 * (var_312_12 / var_312_11)

				if var_312_13 > 0 and var_312_7 < var_312_13 then
					arg_309_1.talkMaxDuration = var_312_13

					if var_312_13 + var_312_6 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_13 + var_312_6
					end
				end

				arg_309_1.text_.text = var_312_10
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131076", "story_v_out_115131.awb") ~= 0 then
					local var_312_14 = manager.audio:GetVoiceLength("story_v_out_115131", "115131076", "story_v_out_115131.awb") / 1000

					if var_312_14 + var_312_6 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_14 + var_312_6
					end

					if var_312_9.prefab_name ~= "" and arg_309_1.actors_[var_312_9.prefab_name] ~= nil then
						local var_312_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_9.prefab_name].transform, "story_v_out_115131", "115131076", "story_v_out_115131.awb")

						arg_309_1:RecordAudio("115131076", var_312_15)
						arg_309_1:RecordAudio("115131076", var_312_15)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_115131", "115131076", "story_v_out_115131.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_115131", "115131076", "story_v_out_115131.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_16 = math.max(var_312_7, arg_309_1.talkMaxDuration)

			if var_312_6 <= arg_309_1.time_ and arg_309_1.time_ < var_312_6 + var_312_16 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_6) / var_312_16

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_6 + var_312_16 and arg_309_1.time_ < var_312_6 + var_312_16 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play115131077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 115131077
		arg_313_1.duration_ = 2.33

		local var_313_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.333
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
				arg_313_0:Play115131078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_316_1 = arg_313_1.actors_["1017ui_story"]
			local var_316_2 = 0

			if var_316_2 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1017ui_story == nil then
				arg_313_1.var_.characterEffect1017ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_3 = 0.2

			if var_316_2 <= arg_313_1.time_ and arg_313_1.time_ < var_316_2 + var_316_3 and not isNil(var_316_1) then
				local var_316_4 = (arg_313_1.time_ - var_316_2) / var_316_3

				if arg_313_1.var_.characterEffect1017ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_2 + var_316_3 and arg_313_1.time_ < var_316_2 + var_316_3 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1017ui_story then
				arg_313_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_316_5 = 0
			local var_316_6 = 0.175

			if var_316_5 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_7 = arg_313_1:FormatText(StoryNameCfg[273].name)

				arg_313_1.leftNameTxt_.text = var_316_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_8 = arg_313_1:GetWordFromCfg(115131077)
				local var_316_9 = arg_313_1:FormatText(var_316_8.content)

				arg_313_1.text_.text = var_316_9

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_10 = 7
				local var_316_11 = utf8.len(var_316_9)
				local var_316_12 = var_316_10 <= 0 and var_316_6 or var_316_6 * (var_316_11 / var_316_10)

				if var_316_12 > 0 and var_316_6 < var_316_12 then
					arg_313_1.talkMaxDuration = var_316_12

					if var_316_12 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_12 + var_316_5
					end
				end

				arg_313_1.text_.text = var_316_9
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131077", "story_v_out_115131.awb") ~= 0 then
					local var_316_13 = manager.audio:GetVoiceLength("story_v_out_115131", "115131077", "story_v_out_115131.awb") / 1000

					if var_316_13 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_5
					end

					if var_316_8.prefab_name ~= "" and arg_313_1.actors_[var_316_8.prefab_name] ~= nil then
						local var_316_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_8.prefab_name].transform, "story_v_out_115131", "115131077", "story_v_out_115131.awb")

						arg_313_1:RecordAudio("115131077", var_316_14)
						arg_313_1:RecordAudio("115131077", var_316_14)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_115131", "115131077", "story_v_out_115131.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_115131", "115131077", "story_v_out_115131.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_15 = math.max(var_316_6, arg_313_1.talkMaxDuration)

			if var_316_5 <= arg_313_1.time_ and arg_313_1.time_ < var_316_5 + var_316_15 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_5) / var_316_15

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_5 + var_316_15 and arg_313_1.time_ < var_316_5 + var_316_15 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play115131078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 115131078
		arg_317_1.duration_ = 10.03

		local var_317_0 = {
			ja = 9.4,
			ko = 7,
			zh = 10.033,
			en = 8.7
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
				arg_317_0:Play115131079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_2")
			end

			local var_320_2 = arg_317_1.actors_["1017ui_story"]
			local var_320_3 = 0

			if var_320_3 < arg_317_1.time_ and arg_317_1.time_ <= var_320_3 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.characterEffect1017ui_story == nil then
				arg_317_1.var_.characterEffect1017ui_story = var_320_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_4 = 0.2

			if var_320_3 <= arg_317_1.time_ and arg_317_1.time_ < var_320_3 + var_320_4 and not isNil(var_320_2) then
				local var_320_5 = (arg_317_1.time_ - var_320_3) / var_320_4

				if arg_317_1.var_.characterEffect1017ui_story and not isNil(var_320_2) then
					local var_320_6 = Mathf.Lerp(0, 0.5, var_320_5)

					arg_317_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1017ui_story.fillRatio = var_320_6
				end
			end

			if arg_317_1.time_ >= var_320_3 + var_320_4 and arg_317_1.time_ < var_320_3 + var_320_4 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.characterEffect1017ui_story then
				local var_320_7 = 0.5

				arg_317_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1017ui_story.fillRatio = var_320_7
			end

			local var_320_8 = arg_317_1.actors_["1052ui_story"]
			local var_320_9 = 0

			if var_320_9 < arg_317_1.time_ and arg_317_1.time_ <= var_320_9 + arg_320_0 and not isNil(var_320_8) and arg_317_1.var_.characterEffect1052ui_story == nil then
				arg_317_1.var_.characterEffect1052ui_story = var_320_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_10 = 0.2

			if var_320_9 <= arg_317_1.time_ and arg_317_1.time_ < var_320_9 + var_320_10 and not isNil(var_320_8) then
				local var_320_11 = (arg_317_1.time_ - var_320_9) / var_320_10

				if arg_317_1.var_.characterEffect1052ui_story and not isNil(var_320_8) then
					arg_317_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_9 + var_320_10 and arg_317_1.time_ < var_320_9 + var_320_10 + arg_320_0 and not isNil(var_320_8) and arg_317_1.var_.characterEffect1052ui_story then
				arg_317_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_320_12 = 0
			local var_320_13 = 0.9

			if var_320_12 < arg_317_1.time_ and arg_317_1.time_ <= var_320_12 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_14 = arg_317_1:FormatText(StoryNameCfg[263].name)

				arg_317_1.leftNameTxt_.text = var_320_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_15 = arg_317_1:GetWordFromCfg(115131078)
				local var_320_16 = arg_317_1:FormatText(var_320_15.content)

				arg_317_1.text_.text = var_320_16

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_17 = 36
				local var_320_18 = utf8.len(var_320_16)
				local var_320_19 = var_320_17 <= 0 and var_320_13 or var_320_13 * (var_320_18 / var_320_17)

				if var_320_19 > 0 and var_320_13 < var_320_19 then
					arg_317_1.talkMaxDuration = var_320_19

					if var_320_19 + var_320_12 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_19 + var_320_12
					end
				end

				arg_317_1.text_.text = var_320_16
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131078", "story_v_out_115131.awb") ~= 0 then
					local var_320_20 = manager.audio:GetVoiceLength("story_v_out_115131", "115131078", "story_v_out_115131.awb") / 1000

					if var_320_20 + var_320_12 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_20 + var_320_12
					end

					if var_320_15.prefab_name ~= "" and arg_317_1.actors_[var_320_15.prefab_name] ~= nil then
						local var_320_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_15.prefab_name].transform, "story_v_out_115131", "115131078", "story_v_out_115131.awb")

						arg_317_1:RecordAudio("115131078", var_320_21)
						arg_317_1:RecordAudio("115131078", var_320_21)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_115131", "115131078", "story_v_out_115131.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_115131", "115131078", "story_v_out_115131.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_22 = math.max(var_320_13, arg_317_1.talkMaxDuration)

			if var_320_12 <= arg_317_1.time_ and arg_317_1.time_ < var_320_12 + var_320_22 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_12) / var_320_22

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_12 + var_320_22 and arg_317_1.time_ < var_320_12 + var_320_22 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play115131079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 115131079
		arg_321_1.duration_ = 6.6

		local var_321_0 = {
			ja = 6.6,
			ko = 3.633,
			zh = 3.433,
			en = 3.866
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
				arg_321_0:Play115131080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_324_1 = arg_321_1.actors_["1017ui_story"]
			local var_324_2 = 0

			if var_324_2 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1017ui_story == nil then
				arg_321_1.var_.characterEffect1017ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_3 = 0.2

			if var_324_2 <= arg_321_1.time_ and arg_321_1.time_ < var_324_2 + var_324_3 and not isNil(var_324_1) then
				local var_324_4 = (arg_321_1.time_ - var_324_2) / var_324_3

				if arg_321_1.var_.characterEffect1017ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_2 + var_324_3 and arg_321_1.time_ < var_324_2 + var_324_3 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1017ui_story then
				arg_321_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_324_5 = arg_321_1.actors_["1052ui_story"]
			local var_324_6 = 0

			if var_324_6 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 and not isNil(var_324_5) and arg_321_1.var_.characterEffect1052ui_story == nil then
				arg_321_1.var_.characterEffect1052ui_story = var_324_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_7 = 0.2

			if var_324_6 <= arg_321_1.time_ and arg_321_1.time_ < var_324_6 + var_324_7 and not isNil(var_324_5) then
				local var_324_8 = (arg_321_1.time_ - var_324_6) / var_324_7

				if arg_321_1.var_.characterEffect1052ui_story and not isNil(var_324_5) then
					local var_324_9 = Mathf.Lerp(0, 0.5, var_324_8)

					arg_321_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1052ui_story.fillRatio = var_324_9
				end
			end

			if arg_321_1.time_ >= var_324_6 + var_324_7 and arg_321_1.time_ < var_324_6 + var_324_7 + arg_324_0 and not isNil(var_324_5) and arg_321_1.var_.characterEffect1052ui_story then
				local var_324_10 = 0.5

				arg_321_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1052ui_story.fillRatio = var_324_10
			end

			local var_324_11 = 0

			if var_324_11 < arg_321_1.time_ and arg_321_1.time_ <= var_324_11 + arg_324_0 then
				arg_321_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_2")
			end

			local var_324_12 = 0
			local var_324_13 = 0.4

			if var_324_12 < arg_321_1.time_ and arg_321_1.time_ <= var_324_12 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_14 = arg_321_1:FormatText(StoryNameCfg[273].name)

				arg_321_1.leftNameTxt_.text = var_324_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_15 = arg_321_1:GetWordFromCfg(115131079)
				local var_324_16 = arg_321_1:FormatText(var_324_15.content)

				arg_321_1.text_.text = var_324_16

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_17 = 16
				local var_324_18 = utf8.len(var_324_16)
				local var_324_19 = var_324_17 <= 0 and var_324_13 or var_324_13 * (var_324_18 / var_324_17)

				if var_324_19 > 0 and var_324_13 < var_324_19 then
					arg_321_1.talkMaxDuration = var_324_19

					if var_324_19 + var_324_12 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_19 + var_324_12
					end
				end

				arg_321_1.text_.text = var_324_16
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131079", "story_v_out_115131.awb") ~= 0 then
					local var_324_20 = manager.audio:GetVoiceLength("story_v_out_115131", "115131079", "story_v_out_115131.awb") / 1000

					if var_324_20 + var_324_12 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_20 + var_324_12
					end

					if var_324_15.prefab_name ~= "" and arg_321_1.actors_[var_324_15.prefab_name] ~= nil then
						local var_324_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_15.prefab_name].transform, "story_v_out_115131", "115131079", "story_v_out_115131.awb")

						arg_321_1:RecordAudio("115131079", var_324_21)
						arg_321_1:RecordAudio("115131079", var_324_21)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_115131", "115131079", "story_v_out_115131.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_115131", "115131079", "story_v_out_115131.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_22 = math.max(var_324_13, arg_321_1.talkMaxDuration)

			if var_324_12 <= arg_321_1.time_ and arg_321_1.time_ < var_324_12 + var_324_22 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_12) / var_324_22

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_12 + var_324_22 and arg_321_1.time_ < var_324_12 + var_324_22 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play115131080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 115131080
		arg_325_1.duration_ = 5.63

		local var_325_0 = {
			ja = 4.466,
			ko = 5.633,
			zh = 4.533,
			en = 4.5
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
				arg_325_0:Play115131081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_328_1 = arg_325_1.actors_["1017ui_story"]
			local var_328_2 = 0

			if var_328_2 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1017ui_story == nil then
				arg_325_1.var_.characterEffect1017ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_3 = 0.2

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_3 and not isNil(var_328_1) then
				local var_328_4 = (arg_325_1.time_ - var_328_2) / var_328_3

				if arg_325_1.var_.characterEffect1017ui_story and not isNil(var_328_1) then
					local var_328_5 = Mathf.Lerp(0, 0.5, var_328_4)

					arg_325_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1017ui_story.fillRatio = var_328_5
				end
			end

			if arg_325_1.time_ >= var_328_2 + var_328_3 and arg_325_1.time_ < var_328_2 + var_328_3 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1017ui_story then
				local var_328_6 = 0.5

				arg_325_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1017ui_story.fillRatio = var_328_6
			end

			local var_328_7 = arg_325_1.actors_["1052ui_story"]
			local var_328_8 = 0

			if var_328_8 < arg_325_1.time_ and arg_325_1.time_ <= var_328_8 + arg_328_0 and not isNil(var_328_7) and arg_325_1.var_.characterEffect1052ui_story == nil then
				arg_325_1.var_.characterEffect1052ui_story = var_328_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_9 = 0.2

			if var_328_8 <= arg_325_1.time_ and arg_325_1.time_ < var_328_8 + var_328_9 and not isNil(var_328_7) then
				local var_328_10 = (arg_325_1.time_ - var_328_8) / var_328_9

				if arg_325_1.var_.characterEffect1052ui_story and not isNil(var_328_7) then
					arg_325_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_8 + var_328_9 and arg_325_1.time_ < var_328_8 + var_328_9 + arg_328_0 and not isNil(var_328_7) and arg_325_1.var_.characterEffect1052ui_story then
				arg_325_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_328_11 = 0
			local var_328_12 = 0.425

			if var_328_11 < arg_325_1.time_ and arg_325_1.time_ <= var_328_11 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_13 = arg_325_1:FormatText(StoryNameCfg[263].name)

				arg_325_1.leftNameTxt_.text = var_328_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_14 = arg_325_1:GetWordFromCfg(115131080)
				local var_328_15 = arg_325_1:FormatText(var_328_14.content)

				arg_325_1.text_.text = var_328_15

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_16 = 17
				local var_328_17 = utf8.len(var_328_15)
				local var_328_18 = var_328_16 <= 0 and var_328_12 or var_328_12 * (var_328_17 / var_328_16)

				if var_328_18 > 0 and var_328_12 < var_328_18 then
					arg_325_1.talkMaxDuration = var_328_18

					if var_328_18 + var_328_11 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_18 + var_328_11
					end
				end

				arg_325_1.text_.text = var_328_15
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131080", "story_v_out_115131.awb") ~= 0 then
					local var_328_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131080", "story_v_out_115131.awb") / 1000

					if var_328_19 + var_328_11 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_19 + var_328_11
					end

					if var_328_14.prefab_name ~= "" and arg_325_1.actors_[var_328_14.prefab_name] ~= nil then
						local var_328_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_14.prefab_name].transform, "story_v_out_115131", "115131080", "story_v_out_115131.awb")

						arg_325_1:RecordAudio("115131080", var_328_20)
						arg_325_1:RecordAudio("115131080", var_328_20)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_115131", "115131080", "story_v_out_115131.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_115131", "115131080", "story_v_out_115131.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_21 = math.max(var_328_12, arg_325_1.talkMaxDuration)

			if var_328_11 <= arg_325_1.time_ and arg_325_1.time_ < var_328_11 + var_328_21 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_11) / var_328_21

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_11 + var_328_21 and arg_325_1.time_ < var_328_11 + var_328_21 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play115131081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 115131081
		arg_329_1.duration_ = 7.3

		local var_329_0 = {
			ja = 4.333,
			ko = 3.666,
			zh = 2.7,
			en = 7.3
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play115131082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1052ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1052ui_story == nil then
				arg_329_1.var_.characterEffect1052ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.2

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect1052ui_story and not isNil(var_332_0) then
					local var_332_4 = Mathf.Lerp(0, 0.5, var_332_3)

					arg_329_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1052ui_story.fillRatio = var_332_4
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1052ui_story then
				local var_332_5 = 0.5

				arg_329_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1052ui_story.fillRatio = var_332_5
			end

			local var_332_6 = arg_329_1.actors_["1017ui_story"].transform
			local var_332_7 = 0

			if var_332_7 < arg_329_1.time_ and arg_329_1.time_ <= var_332_7 + arg_332_0 then
				arg_329_1.var_.moveOldPos1017ui_story = var_332_6.localPosition
			end

			local var_332_8 = 0.001

			if var_332_7 <= arg_329_1.time_ and arg_329_1.time_ < var_332_7 + var_332_8 then
				local var_332_9 = (arg_329_1.time_ - var_332_7) / var_332_8
				local var_332_10 = Vector3.New(0, 100, 0)

				var_332_6.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1017ui_story, var_332_10, var_332_9)

				local var_332_11 = manager.ui.mainCamera.transform.position - var_332_6.position

				var_332_6.forward = Vector3.New(var_332_11.x, var_332_11.y, var_332_11.z)

				local var_332_12 = var_332_6.localEulerAngles

				var_332_12.z = 0
				var_332_12.x = 0
				var_332_6.localEulerAngles = var_332_12
			end

			if arg_329_1.time_ >= var_332_7 + var_332_8 and arg_329_1.time_ < var_332_7 + var_332_8 + arg_332_0 then
				var_332_6.localPosition = Vector3.New(0, 100, 0)

				local var_332_13 = manager.ui.mainCamera.transform.position - var_332_6.position

				var_332_6.forward = Vector3.New(var_332_13.x, var_332_13.y, var_332_13.z)

				local var_332_14 = var_332_6.localEulerAngles

				var_332_14.z = 0
				var_332_14.x = 0
				var_332_6.localEulerAngles = var_332_14
			end

			local var_332_15 = arg_329_1.actors_["1024ui_story"].transform
			local var_332_16 = 0

			if var_332_16 < arg_329_1.time_ and arg_329_1.time_ <= var_332_16 + arg_332_0 then
				arg_329_1.var_.moveOldPos1024ui_story = var_332_15.localPosition
			end

			local var_332_17 = 0.001

			if var_332_16 <= arg_329_1.time_ and arg_329_1.time_ < var_332_16 + var_332_17 then
				local var_332_18 = (arg_329_1.time_ - var_332_16) / var_332_17
				local var_332_19 = Vector3.New(0.7, -1, -6.05)

				var_332_15.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1024ui_story, var_332_19, var_332_18)

				local var_332_20 = manager.ui.mainCamera.transform.position - var_332_15.position

				var_332_15.forward = Vector3.New(var_332_20.x, var_332_20.y, var_332_20.z)

				local var_332_21 = var_332_15.localEulerAngles

				var_332_21.z = 0
				var_332_21.x = 0
				var_332_15.localEulerAngles = var_332_21
			end

			if arg_329_1.time_ >= var_332_16 + var_332_17 and arg_329_1.time_ < var_332_16 + var_332_17 + arg_332_0 then
				var_332_15.localPosition = Vector3.New(0.7, -1, -6.05)

				local var_332_22 = manager.ui.mainCamera.transform.position - var_332_15.position

				var_332_15.forward = Vector3.New(var_332_22.x, var_332_22.y, var_332_22.z)

				local var_332_23 = var_332_15.localEulerAngles

				var_332_23.z = 0
				var_332_23.x = 0
				var_332_15.localEulerAngles = var_332_23
			end

			local var_332_24 = 0

			if var_332_24 < arg_329_1.time_ and arg_329_1.time_ <= var_332_24 + arg_332_0 then
				arg_329_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_332_25 = 0

			if var_332_25 < arg_329_1.time_ and arg_329_1.time_ <= var_332_25 + arg_332_0 then
				arg_329_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_332_26 = arg_329_1.actors_["1024ui_story"]
			local var_332_27 = 0

			if var_332_27 < arg_329_1.time_ and arg_329_1.time_ <= var_332_27 + arg_332_0 and not isNil(var_332_26) and arg_329_1.var_.characterEffect1024ui_story == nil then
				arg_329_1.var_.characterEffect1024ui_story = var_332_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_28 = 0.2

			if var_332_27 <= arg_329_1.time_ and arg_329_1.time_ < var_332_27 + var_332_28 and not isNil(var_332_26) then
				local var_332_29 = (arg_329_1.time_ - var_332_27) / var_332_28

				if arg_329_1.var_.characterEffect1024ui_story and not isNil(var_332_26) then
					arg_329_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= var_332_27 + var_332_28 and arg_329_1.time_ < var_332_27 + var_332_28 + arg_332_0 and not isNil(var_332_26) and arg_329_1.var_.characterEffect1024ui_story then
				arg_329_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_332_30 = 0
			local var_332_31 = 0.275

			if var_332_30 < arg_329_1.time_ and arg_329_1.time_ <= var_332_30 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_32 = arg_329_1:FormatText(StoryNameCfg[265].name)

				arg_329_1.leftNameTxt_.text = var_332_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_33 = arg_329_1:GetWordFromCfg(115131081)
				local var_332_34 = arg_329_1:FormatText(var_332_33.content)

				arg_329_1.text_.text = var_332_34

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_35 = 11
				local var_332_36 = utf8.len(var_332_34)
				local var_332_37 = var_332_35 <= 0 and var_332_31 or var_332_31 * (var_332_36 / var_332_35)

				if var_332_37 > 0 and var_332_31 < var_332_37 then
					arg_329_1.talkMaxDuration = var_332_37

					if var_332_37 + var_332_30 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_37 + var_332_30
					end
				end

				arg_329_1.text_.text = var_332_34
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131081", "story_v_out_115131.awb") ~= 0 then
					local var_332_38 = manager.audio:GetVoiceLength("story_v_out_115131", "115131081", "story_v_out_115131.awb") / 1000

					if var_332_38 + var_332_30 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_38 + var_332_30
					end

					if var_332_33.prefab_name ~= "" and arg_329_1.actors_[var_332_33.prefab_name] ~= nil then
						local var_332_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_33.prefab_name].transform, "story_v_out_115131", "115131081", "story_v_out_115131.awb")

						arg_329_1:RecordAudio("115131081", var_332_39)
						arg_329_1:RecordAudio("115131081", var_332_39)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_115131", "115131081", "story_v_out_115131.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_115131", "115131081", "story_v_out_115131.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_40 = math.max(var_332_31, arg_329_1.talkMaxDuration)

			if var_332_30 <= arg_329_1.time_ and arg_329_1.time_ < var_332_30 + var_332_40 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_30) / var_332_40

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_30 + var_332_40 and arg_329_1.time_ < var_332_30 + var_332_40 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play115131082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 115131082
		arg_333_1.duration_ = 11.83

		local var_333_0 = {
			ja = 11.833,
			ko = 9.633,
			zh = 9.566,
			en = 8.2
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play115131083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_336_1 = arg_333_1.actors_["1024ui_story"]
			local var_336_2 = 0

			if var_336_2 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1024ui_story == nil then
				arg_333_1.var_.characterEffect1024ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_3 = 0.2

			if var_336_2 <= arg_333_1.time_ and arg_333_1.time_ < var_336_2 + var_336_3 and not isNil(var_336_1) then
				local var_336_4 = (arg_333_1.time_ - var_336_2) / var_336_3

				if arg_333_1.var_.characterEffect1024ui_story and not isNil(var_336_1) then
					local var_336_5 = Mathf.Lerp(0, 0.5, var_336_4)

					arg_333_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1024ui_story.fillRatio = var_336_5
				end
			end

			if arg_333_1.time_ >= var_336_2 + var_336_3 and arg_333_1.time_ < var_336_2 + var_336_3 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1024ui_story then
				local var_336_6 = 0.5

				arg_333_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1024ui_story.fillRatio = var_336_6
			end

			local var_336_7 = arg_333_1.actors_["1052ui_story"]
			local var_336_8 = 0

			if var_336_8 < arg_333_1.time_ and arg_333_1.time_ <= var_336_8 + arg_336_0 and not isNil(var_336_7) and arg_333_1.var_.characterEffect1052ui_story == nil then
				arg_333_1.var_.characterEffect1052ui_story = var_336_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_9 = 0.2

			if var_336_8 <= arg_333_1.time_ and arg_333_1.time_ < var_336_8 + var_336_9 and not isNil(var_336_7) then
				local var_336_10 = (arg_333_1.time_ - var_336_8) / var_336_9

				if arg_333_1.var_.characterEffect1052ui_story and not isNil(var_336_7) then
					arg_333_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_8 + var_336_9 and arg_333_1.time_ < var_336_8 + var_336_9 + arg_336_0 and not isNil(var_336_7) and arg_333_1.var_.characterEffect1052ui_story then
				arg_333_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_336_11 = 0

			if var_336_11 < arg_333_1.time_ and arg_333_1.time_ <= var_336_11 + arg_336_0 then
				arg_333_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_1")
			end

			local var_336_12 = 0
			local var_336_13 = 1.25

			if var_336_12 < arg_333_1.time_ and arg_333_1.time_ <= var_336_12 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_14 = arg_333_1:FormatText(StoryNameCfg[263].name)

				arg_333_1.leftNameTxt_.text = var_336_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_15 = arg_333_1:GetWordFromCfg(115131082)
				local var_336_16 = arg_333_1:FormatText(var_336_15.content)

				arg_333_1.text_.text = var_336_16

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_17 = 50
				local var_336_18 = utf8.len(var_336_16)
				local var_336_19 = var_336_17 <= 0 and var_336_13 or var_336_13 * (var_336_18 / var_336_17)

				if var_336_19 > 0 and var_336_13 < var_336_19 then
					arg_333_1.talkMaxDuration = var_336_19

					if var_336_19 + var_336_12 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_19 + var_336_12
					end
				end

				arg_333_1.text_.text = var_336_16
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131082", "story_v_out_115131.awb") ~= 0 then
					local var_336_20 = manager.audio:GetVoiceLength("story_v_out_115131", "115131082", "story_v_out_115131.awb") / 1000

					if var_336_20 + var_336_12 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_20 + var_336_12
					end

					if var_336_15.prefab_name ~= "" and arg_333_1.actors_[var_336_15.prefab_name] ~= nil then
						local var_336_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_15.prefab_name].transform, "story_v_out_115131", "115131082", "story_v_out_115131.awb")

						arg_333_1:RecordAudio("115131082", var_336_21)
						arg_333_1:RecordAudio("115131082", var_336_21)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_115131", "115131082", "story_v_out_115131.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_115131", "115131082", "story_v_out_115131.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_22 = math.max(var_336_13, arg_333_1.talkMaxDuration)

			if var_336_12 <= arg_333_1.time_ and arg_333_1.time_ < var_336_12 + var_336_22 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_12) / var_336_22

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_12 + var_336_22 and arg_333_1.time_ < var_336_12 + var_336_22 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play115131083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 115131083
		arg_337_1.duration_ = 9.1

		local var_337_0 = {
			ja = 9.1,
			ko = 8.266,
			zh = 5.6,
			en = 6.7
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play115131084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1024ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1024ui_story == nil then
				arg_337_1.var_.characterEffect1024ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.2

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1024ui_story and not isNil(var_340_0) then
					arg_337_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1024ui_story then
				arg_337_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_340_4 = arg_337_1.actors_["1052ui_story"]
			local var_340_5 = 0

			if var_340_5 < arg_337_1.time_ and arg_337_1.time_ <= var_340_5 + arg_340_0 and not isNil(var_340_4) and arg_337_1.var_.characterEffect1052ui_story == nil then
				arg_337_1.var_.characterEffect1052ui_story = var_340_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_6 = 0.2

			if var_340_5 <= arg_337_1.time_ and arg_337_1.time_ < var_340_5 + var_340_6 and not isNil(var_340_4) then
				local var_340_7 = (arg_337_1.time_ - var_340_5) / var_340_6

				if arg_337_1.var_.characterEffect1052ui_story and not isNil(var_340_4) then
					local var_340_8 = Mathf.Lerp(0, 0.5, var_340_7)

					arg_337_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1052ui_story.fillRatio = var_340_8
				end
			end

			if arg_337_1.time_ >= var_340_5 + var_340_6 and arg_337_1.time_ < var_340_5 + var_340_6 + arg_340_0 and not isNil(var_340_4) and arg_337_1.var_.characterEffect1052ui_story then
				local var_340_9 = 0.5

				arg_337_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1052ui_story.fillRatio = var_340_9
			end

			local var_340_10 = 0

			if var_340_10 < arg_337_1.time_ and arg_337_1.time_ <= var_340_10 + arg_340_0 then
				arg_337_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_340_11 = 0
			local var_340_12 = 0.6

			if var_340_11 < arg_337_1.time_ and arg_337_1.time_ <= var_340_11 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_13 = arg_337_1:FormatText(StoryNameCfg[265].name)

				arg_337_1.leftNameTxt_.text = var_340_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_14 = arg_337_1:GetWordFromCfg(115131083)
				local var_340_15 = arg_337_1:FormatText(var_340_14.content)

				arg_337_1.text_.text = var_340_15

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_16 = 24
				local var_340_17 = utf8.len(var_340_15)
				local var_340_18 = var_340_16 <= 0 and var_340_12 or var_340_12 * (var_340_17 / var_340_16)

				if var_340_18 > 0 and var_340_12 < var_340_18 then
					arg_337_1.talkMaxDuration = var_340_18

					if var_340_18 + var_340_11 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_18 + var_340_11
					end
				end

				arg_337_1.text_.text = var_340_15
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131083", "story_v_out_115131.awb") ~= 0 then
					local var_340_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131083", "story_v_out_115131.awb") / 1000

					if var_340_19 + var_340_11 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_19 + var_340_11
					end

					if var_340_14.prefab_name ~= "" and arg_337_1.actors_[var_340_14.prefab_name] ~= nil then
						local var_340_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_14.prefab_name].transform, "story_v_out_115131", "115131083", "story_v_out_115131.awb")

						arg_337_1:RecordAudio("115131083", var_340_20)
						arg_337_1:RecordAudio("115131083", var_340_20)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_115131", "115131083", "story_v_out_115131.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_115131", "115131083", "story_v_out_115131.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_21 = math.max(var_340_12, arg_337_1.talkMaxDuration)

			if var_340_11 <= arg_337_1.time_ and arg_337_1.time_ < var_340_11 + var_340_21 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_11) / var_340_21

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_11 + var_340_21 and arg_337_1.time_ < var_340_11 + var_340_21 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play115131084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 115131084
		arg_341_1.duration_ = 8.83

		local var_341_0 = {
			ja = 8.833,
			ko = 5.4,
			zh = 6.4,
			en = 7.7
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play115131085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_344_1 = arg_341_1.actors_["1024ui_story"]
			local var_344_2 = 0

			if var_344_2 < arg_341_1.time_ and arg_341_1.time_ <= var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1024ui_story == nil then
				arg_341_1.var_.characterEffect1024ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_3 = 0.2

			if var_344_2 <= arg_341_1.time_ and arg_341_1.time_ < var_344_2 + var_344_3 and not isNil(var_344_1) then
				local var_344_4 = (arg_341_1.time_ - var_344_2) / var_344_3

				if arg_341_1.var_.characterEffect1024ui_story and not isNil(var_344_1) then
					local var_344_5 = Mathf.Lerp(0, 0.5, var_344_4)

					arg_341_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1024ui_story.fillRatio = var_344_5
				end
			end

			if arg_341_1.time_ >= var_344_2 + var_344_3 and arg_341_1.time_ < var_344_2 + var_344_3 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1024ui_story then
				local var_344_6 = 0.5

				arg_341_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1024ui_story.fillRatio = var_344_6
			end

			local var_344_7 = arg_341_1.actors_["1052ui_story"]
			local var_344_8 = 0

			if var_344_8 < arg_341_1.time_ and arg_341_1.time_ <= var_344_8 + arg_344_0 and not isNil(var_344_7) and arg_341_1.var_.characterEffect1052ui_story == nil then
				arg_341_1.var_.characterEffect1052ui_story = var_344_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_9 = 0.2

			if var_344_8 <= arg_341_1.time_ and arg_341_1.time_ < var_344_8 + var_344_9 and not isNil(var_344_7) then
				local var_344_10 = (arg_341_1.time_ - var_344_8) / var_344_9

				if arg_341_1.var_.characterEffect1052ui_story and not isNil(var_344_7) then
					arg_341_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_8 + var_344_9 and arg_341_1.time_ < var_344_8 + var_344_9 + arg_344_0 and not isNil(var_344_7) and arg_341_1.var_.characterEffect1052ui_story then
				arg_341_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_344_11 = 0
			local var_344_12 = 0.625

			if var_344_11 < arg_341_1.time_ and arg_341_1.time_ <= var_344_11 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_13 = arg_341_1:FormatText(StoryNameCfg[263].name)

				arg_341_1.leftNameTxt_.text = var_344_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_14 = arg_341_1:GetWordFromCfg(115131084)
				local var_344_15 = arg_341_1:FormatText(var_344_14.content)

				arg_341_1.text_.text = var_344_15

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_16 = 25
				local var_344_17 = utf8.len(var_344_15)
				local var_344_18 = var_344_16 <= 0 and var_344_12 or var_344_12 * (var_344_17 / var_344_16)

				if var_344_18 > 0 and var_344_12 < var_344_18 then
					arg_341_1.talkMaxDuration = var_344_18

					if var_344_18 + var_344_11 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_18 + var_344_11
					end
				end

				arg_341_1.text_.text = var_344_15
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131084", "story_v_out_115131.awb") ~= 0 then
					local var_344_19 = manager.audio:GetVoiceLength("story_v_out_115131", "115131084", "story_v_out_115131.awb") / 1000

					if var_344_19 + var_344_11 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_19 + var_344_11
					end

					if var_344_14.prefab_name ~= "" and arg_341_1.actors_[var_344_14.prefab_name] ~= nil then
						local var_344_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_14.prefab_name].transform, "story_v_out_115131", "115131084", "story_v_out_115131.awb")

						arg_341_1:RecordAudio("115131084", var_344_20)
						arg_341_1:RecordAudio("115131084", var_344_20)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_115131", "115131084", "story_v_out_115131.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_115131", "115131084", "story_v_out_115131.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_21 = math.max(var_344_12, arg_341_1.talkMaxDuration)

			if var_344_11 <= arg_341_1.time_ and arg_341_1.time_ < var_344_11 + var_344_21 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_11) / var_344_21

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_11 + var_344_21 and arg_341_1.time_ < var_344_11 + var_344_21 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play115131085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 115131085
		arg_345_1.duration_ = 4.17

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play115131086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1052ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1052ui_story == nil then
				arg_345_1.var_.characterEffect1052ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.2

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect1052ui_story and not isNil(var_348_0) then
					local var_348_4 = Mathf.Lerp(0, 0.5, var_348_3)

					arg_345_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1052ui_story.fillRatio = var_348_4
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1052ui_story then
				local var_348_5 = 0.5

				arg_345_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1052ui_story.fillRatio = var_348_5
			end

			local var_348_6 = arg_345_1.actors_["1024ui_story"].transform
			local var_348_7 = 0

			if var_348_7 < arg_345_1.time_ and arg_345_1.time_ <= var_348_7 + arg_348_0 then
				arg_345_1.var_.moveOldPos1024ui_story = var_348_6.localPosition
			end

			local var_348_8 = 0.001

			if var_348_7 <= arg_345_1.time_ and arg_345_1.time_ < var_348_7 + var_348_8 then
				local var_348_9 = (arg_345_1.time_ - var_348_7) / var_348_8
				local var_348_10 = Vector3.New(0, 100, 0)

				var_348_6.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1024ui_story, var_348_10, var_348_9)

				local var_348_11 = manager.ui.mainCamera.transform.position - var_348_6.position

				var_348_6.forward = Vector3.New(var_348_11.x, var_348_11.y, var_348_11.z)

				local var_348_12 = var_348_6.localEulerAngles

				var_348_12.z = 0
				var_348_12.x = 0
				var_348_6.localEulerAngles = var_348_12
			end

			if arg_345_1.time_ >= var_348_7 + var_348_8 and arg_345_1.time_ < var_348_7 + var_348_8 + arg_348_0 then
				var_348_6.localPosition = Vector3.New(0, 100, 0)

				local var_348_13 = manager.ui.mainCamera.transform.position - var_348_6.position

				var_348_6.forward = Vector3.New(var_348_13.x, var_348_13.y, var_348_13.z)

				local var_348_14 = var_348_6.localEulerAngles

				var_348_14.z = 0
				var_348_14.x = 0
				var_348_6.localEulerAngles = var_348_14
			end

			local var_348_15 = arg_345_1.actors_["1052ui_story"].transform
			local var_348_16 = 0

			if var_348_16 < arg_345_1.time_ and arg_345_1.time_ <= var_348_16 + arg_348_0 then
				arg_345_1.var_.moveOldPos1052ui_story = var_348_15.localPosition
			end

			local var_348_17 = 0.001

			if var_348_16 <= arg_345_1.time_ and arg_345_1.time_ < var_348_16 + var_348_17 then
				local var_348_18 = (arg_345_1.time_ - var_348_16) / var_348_17
				local var_348_19 = Vector3.New(0, 100, 0)

				var_348_15.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1052ui_story, var_348_19, var_348_18)

				local var_348_20 = manager.ui.mainCamera.transform.position - var_348_15.position

				var_348_15.forward = Vector3.New(var_348_20.x, var_348_20.y, var_348_20.z)

				local var_348_21 = var_348_15.localEulerAngles

				var_348_21.z = 0
				var_348_21.x = 0
				var_348_15.localEulerAngles = var_348_21
			end

			if arg_345_1.time_ >= var_348_16 + var_348_17 and arg_345_1.time_ < var_348_16 + var_348_17 + arg_348_0 then
				var_348_15.localPosition = Vector3.New(0, 100, 0)

				local var_348_22 = manager.ui.mainCamera.transform.position - var_348_15.position

				var_348_15.forward = Vector3.New(var_348_22.x, var_348_22.y, var_348_22.z)

				local var_348_23 = var_348_15.localEulerAngles

				var_348_23.z = 0
				var_348_23.x = 0
				var_348_15.localEulerAngles = var_348_23
			end

			local var_348_24 = 0
			local var_348_25 = 0.075

			if var_348_24 < arg_345_1.time_ and arg_345_1.time_ <= var_348_24 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_26 = arg_345_1:FormatText(StoryNameCfg[266].name)

				arg_345_1.leftNameTxt_.text = var_348_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024_1")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_27 = arg_345_1:GetWordFromCfg(115131085)
				local var_348_28 = arg_345_1:FormatText(var_348_27.content)

				arg_345_1.text_.text = var_348_28

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_29 = 3
				local var_348_30 = utf8.len(var_348_28)
				local var_348_31 = var_348_29 <= 0 and var_348_25 or var_348_25 * (var_348_30 / var_348_29)

				if var_348_31 > 0 and var_348_25 < var_348_31 then
					arg_345_1.talkMaxDuration = var_348_31

					if var_348_31 + var_348_24 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_31 + var_348_24
					end
				end

				arg_345_1.text_.text = var_348_28
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131085", "story_v_out_115131.awb") ~= 0 then
					local var_348_32 = manager.audio:GetVoiceLength("story_v_out_115131", "115131085", "story_v_out_115131.awb") / 1000

					if var_348_32 + var_348_24 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_32 + var_348_24
					end

					if var_348_27.prefab_name ~= "" and arg_345_1.actors_[var_348_27.prefab_name] ~= nil then
						local var_348_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_27.prefab_name].transform, "story_v_out_115131", "115131085", "story_v_out_115131.awb")

						arg_345_1:RecordAudio("115131085", var_348_33)
						arg_345_1:RecordAudio("115131085", var_348_33)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_115131", "115131085", "story_v_out_115131.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_115131", "115131085", "story_v_out_115131.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_34 = math.max(var_348_25, arg_345_1.talkMaxDuration)

			if var_348_24 <= arg_345_1.time_ and arg_345_1.time_ < var_348_24 + var_348_34 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_24) / var_348_34

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_24 + var_348_34 and arg_345_1.time_ < var_348_24 + var_348_34 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play115131086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 115131086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play115131087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0
			local var_352_1 = 0.775

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_2 = arg_349_1:GetWordFromCfg(115131086)
				local var_352_3 = arg_349_1:FormatText(var_352_2.content)

				arg_349_1.text_.text = var_352_3

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_4 = 31
				local var_352_5 = utf8.len(var_352_3)
				local var_352_6 = var_352_4 <= 0 and var_352_1 or var_352_1 * (var_352_5 / var_352_4)

				if var_352_6 > 0 and var_352_1 < var_352_6 then
					arg_349_1.talkMaxDuration = var_352_6

					if var_352_6 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_6 + var_352_0
					end
				end

				arg_349_1.text_.text = var_352_3
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_7 and arg_349_1.time_ < var_352_0 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play115131087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 115131087
		arg_353_1.duration_ = 7

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
			arg_353_1.auto_ = false
		end

		function arg_353_1.playNext_(arg_355_0)
			arg_353_1.onStoryFinished_()
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.mask_.enabled = true
				arg_353_1.mask_.raycastTarget = false

				arg_353_1:SetGaussion(false)
			end

			local var_356_1 = 2

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_1 then
				local var_356_2 = (arg_353_1.time_ - var_356_0) / var_356_1
				local var_356_3 = Color.New(1, 1, 1)

				var_356_3.a = Mathf.Lerp(1, 0, var_356_2)
				arg_353_1.mask_.color = var_356_3
			end

			if arg_353_1.time_ >= var_356_0 + var_356_1 and arg_353_1.time_ < var_356_0 + var_356_1 + arg_356_0 then
				local var_356_4 = Color.New(1, 1, 1)
				local var_356_5 = 0

				arg_353_1.mask_.enabled = false
				var_356_4.a = var_356_5
				arg_353_1.mask_.color = var_356_4
			end

			if arg_353_1.frameCnt_ <= 1 then
				arg_353_1.dialog_:SetActive(false)
			end

			local var_356_6 = 2
			local var_356_7 = 0.85

			if var_356_6 < arg_353_1.time_ and arg_353_1.time_ <= var_356_6 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0

				arg_353_1.dialog_:SetActive(true)

				arg_353_1.dialogCg_.alpha = 0

				local var_356_8 = LeanTween.value(arg_353_1.dialog_, 0, 1, 0.3)

				var_356_8:setOnUpdate(LuaHelper.FloatAction(function(arg_357_0)
					arg_353_1.dialogCg_.alpha = arg_357_0
				end))
				var_356_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_353_1.dialog_)
					var_356_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_353_1.duration_ = arg_353_1.duration_ + 0.3

				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_9 = arg_353_1:GetWordFromCfg(115131087)
				local var_356_10 = arg_353_1:FormatText(var_356_9.content)

				arg_353_1.text_.text = var_356_10

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_11 = 34
				local var_356_12 = utf8.len(var_356_10)
				local var_356_13 = var_356_11 <= 0 and var_356_7 or var_356_7 * (var_356_12 / var_356_11)

				if var_356_13 > 0 and var_356_7 < var_356_13 then
					arg_353_1.talkMaxDuration = var_356_13
					var_356_6 = var_356_6 + 0.3

					if var_356_13 + var_356_6 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_13 + var_356_6
					end
				end

				arg_353_1.text_.text = var_356_10
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_14 = var_356_6 + 0.3
			local var_356_15 = math.max(var_356_7, arg_353_1.talkMaxDuration)

			if var_356_14 <= arg_353_1.time_ and arg_353_1.time_ < var_356_14 + var_356_15 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_14) / var_356_15

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_14 + var_356_15 and arg_353_1.time_ < var_356_14 + var_356_15 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/G03a",
		"TextureConfig/Background/RO0201"
	},
	voices = {
		"story_v_out_115131.awb"
	}
}
