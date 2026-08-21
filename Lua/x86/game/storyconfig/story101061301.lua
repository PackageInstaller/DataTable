return {
	Play106131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106131001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play106131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "C01b"

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
				local var_4_5 = arg_1_1.bgs_.C01b

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
					if iter_4_0 ~= "C01b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.C01b
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueC01b = var_4_18.color.a
					arg_1_1.var_.alphaMatValueC01b = var_4_18
				end

				arg_1_1.var_.alphaOldValueC01b = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueC01b, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueC01b then
					local var_4_22 = arg_1_1.var_.alphaMatValueC01b.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueC01b.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueC01b then
				local var_4_23 = arg_1_1.var_.alphaMatValueC01b
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0
			local var_4_26 = 1

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_27 = "play"
				local var_4_28 = "music"

				arg_1_1:AudioAction(var_4_27, var_4_28, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_29 = ""
				local var_4_30 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_30 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_30 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_30

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_30
						arg_1_1.bgmTxt2_.text = var_4_30
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

			local var_4_31 = 0

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_32 = 2

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_33 = 2
			local var_4_34 = 0.375

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_35 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_35:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_36 = arg_1_1:GetWordFromCfg(106131001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 15
				local var_4_39 = utf8.len(var_4_37)
				local var_4_40 = var_4_38 <= 0 and var_4_34 or var_4_34 * (var_4_39 / var_4_38)

				if var_4_40 > 0 and var_4_34 < var_4_40 then
					arg_1_1.talkMaxDuration = var_4_40
					var_4_33 = var_4_33 + 0.3

					if var_4_40 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_37
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_41 = var_4_33 + 0.3
			local var_4_42 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_41) / var_4_42

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play106131002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 106131002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play106131003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.125

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(106131002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 45
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play106131003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 106131003
		arg_12_1.duration_ = 3.5

		local var_12_0 = {
			ja = 3,
			ko = 2.133,
			zh = 3.5,
			en = 2.666
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play106131004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1093ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_12_1.stage_.transform)

					var_15_2.name = var_15_0
					var_15_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_0] = var_15_2

					local var_15_3 = var_15_2:GetComponentInChildren(typeof(CharacterEffect))

					var_15_3.enabled = true

					local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_2, typeof(DynamicBoneHelper))

					if var_15_4 then
						var_15_4:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_3.transform, false)

					arg_12_1.var_[var_15_0 .. "Animator"] = var_15_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_0 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_0 .. "LipSync"] = var_15_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_5 = arg_12_1.actors_["1093ui_story"]
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1093ui_story == nil then
				arg_12_1.var_.characterEffect1093ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 and not isNil(var_15_5) then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7

				if arg_12_1.var_.characterEffect1093ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1093ui_story then
				arg_12_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_15_9 = "3004_tpose"

			if arg_12_1.actors_[var_15_9] == nil then
				local var_15_10 = Asset.Load("Char/" .. "3004_tpose")

				if not isNil(var_15_10) then
					local var_15_11 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_12_1.stage_.transform)

					var_15_11.name = var_15_9
					var_15_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_9] = var_15_11

					local var_15_12 = var_15_11:GetComponentInChildren(typeof(CharacterEffect))

					var_15_12.enabled = true

					local var_15_13 = GameObjectTools.GetOrAddComponent(var_15_11, typeof(DynamicBoneHelper))

					if var_15_13 then
						var_15_13:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_12.transform, false)

					arg_12_1.var_[var_15_9 .. "Animator"] = var_15_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_9 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_9 .. "LipSync"] = var_15_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_14 = arg_12_1.actors_["3004_tpose"].transform
			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 then
				arg_12_1.var_.moveOldPos3004_tpose = var_15_14.localPosition

				local var_15_16 = GameObjectTools.GetOrAddComponent(var_15_14.gameObject, typeof(DynamicBoneHelper))

				if var_15_16 then
					var_15_16:EnableDynamicBone(false)
				end
			end

			local var_15_17 = 0.001

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_17 then
				local var_15_18 = (arg_12_1.time_ - var_15_15) / var_15_17
				local var_15_19 = Vector3.New(0.7, -2.22, -3.1)

				var_15_14.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3004_tpose, var_15_19, var_15_18)

				local var_15_20 = manager.ui.mainCamera.transform.position - var_15_14.position

				var_15_14.forward = Vector3.New(var_15_20.x, var_15_20.y, var_15_20.z)

				local var_15_21 = var_15_14.localEulerAngles

				var_15_21.z = 0
				var_15_21.x = 0
				var_15_14.localEulerAngles = var_15_21
			end

			if arg_12_1.time_ >= var_15_15 + var_15_17 and arg_12_1.time_ < var_15_15 + var_15_17 + arg_15_0 then
				var_15_14.localPosition = Vector3.New(0.7, -2.22, -3.1)

				local var_15_22 = manager.ui.mainCamera.transform.position - var_15_14.position

				var_15_14.forward = Vector3.New(var_15_22.x, var_15_22.y, var_15_22.z)

				local var_15_23 = var_15_14.localEulerAngles

				var_15_23.z = 0
				var_15_23.x = 0
				var_15_14.localEulerAngles = var_15_23

				local var_15_24 = GameObjectTools.GetOrAddComponent(var_15_14.gameObject, typeof(DynamicBoneHelper))

				if var_15_24 then
					var_15_24:EnableDynamicBone(true)
				end
			end

			local var_15_25 = 0

			if var_15_25 < arg_12_1.time_ and arg_12_1.time_ <= var_15_25 + arg_15_0 then
				arg_12_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_15_26 = arg_12_1.actors_["1093ui_story"].transform
			local var_15_27 = 0

			if var_15_27 < arg_12_1.time_ and arg_12_1.time_ <= var_15_27 + arg_15_0 then
				arg_12_1.var_.moveOldPos1093ui_story = var_15_26.localPosition

				local var_15_28 = "1093ui_story"

				arg_12_1:ShowWeapon(arg_12_1.var_[var_15_28 .. "Animator"].transform, true)
			end

			local var_15_29 = 0.001

			if var_15_27 <= arg_12_1.time_ and arg_12_1.time_ < var_15_27 + var_15_29 then
				local var_15_30 = (arg_12_1.time_ - var_15_27) / var_15_29
				local var_15_31 = Vector3.New(-0.7, -1.11, -5.88)

				var_15_26.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1093ui_story, var_15_31, var_15_30)

				local var_15_32 = manager.ui.mainCamera.transform.position - var_15_26.position

				var_15_26.forward = Vector3.New(var_15_32.x, var_15_32.y, var_15_32.z)

				local var_15_33 = var_15_26.localEulerAngles

				var_15_33.z = 0
				var_15_33.x = 0
				var_15_26.localEulerAngles = var_15_33
			end

			if arg_12_1.time_ >= var_15_27 + var_15_29 and arg_12_1.time_ < var_15_27 + var_15_29 + arg_15_0 then
				var_15_26.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_15_34 = manager.ui.mainCamera.transform.position - var_15_26.position

				var_15_26.forward = Vector3.New(var_15_34.x, var_15_34.y, var_15_34.z)

				local var_15_35 = var_15_26.localEulerAngles

				var_15_35.z = 0
				var_15_35.x = 0
				var_15_26.localEulerAngles = var_15_35
			end

			local var_15_36 = 0

			if var_15_36 < arg_12_1.time_ and arg_12_1.time_ <= var_15_36 + arg_15_0 then
				arg_12_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action10_2")
			end

			local var_15_37 = 0

			if var_15_37 < arg_12_1.time_ and arg_12_1.time_ <= var_15_37 + arg_15_0 then
				arg_12_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_15_38 = 0
			local var_15_39 = 0.175

			if var_15_38 < arg_12_1.time_ and arg_12_1.time_ <= var_15_38 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_40 = arg_12_1:FormatText(StoryNameCfg[73].name)

				arg_12_1.leftNameTxt_.text = var_15_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_41 = arg_12_1:GetWordFromCfg(106131003)
				local var_15_42 = arg_12_1:FormatText(var_15_41.content)

				arg_12_1.text_.text = var_15_42

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_43 = 7
				local var_15_44 = utf8.len(var_15_42)
				local var_15_45 = var_15_43 <= 0 and var_15_39 or var_15_39 * (var_15_44 / var_15_43)

				if var_15_45 > 0 and var_15_39 < var_15_45 then
					arg_12_1.talkMaxDuration = var_15_45

					if var_15_45 + var_15_38 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_45 + var_15_38
					end
				end

				arg_12_1.text_.text = var_15_42
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131003", "story_v_out_106131.awb") ~= 0 then
					local var_15_46 = manager.audio:GetVoiceLength("story_v_out_106131", "106131003", "story_v_out_106131.awb") / 1000

					if var_15_46 + var_15_38 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_46 + var_15_38
					end

					if var_15_41.prefab_name ~= "" and arg_12_1.actors_[var_15_41.prefab_name] ~= nil then
						local var_15_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_41.prefab_name].transform, "story_v_out_106131", "106131003", "story_v_out_106131.awb")

						arg_12_1:RecordAudio("106131003", var_15_47)
						arg_12_1:RecordAudio("106131003", var_15_47)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_106131", "106131003", "story_v_out_106131.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_106131", "106131003", "story_v_out_106131.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_48 = math.max(var_15_39, arg_12_1.talkMaxDuration)

			if var_15_38 <= arg_12_1.time_ and arg_12_1.time_ < var_15_38 + var_15_48 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_38) / var_15_48

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_38 + var_15_48 and arg_12_1.time_ < var_15_38 + var_15_48 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play106131004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 106131004
		arg_16_1.duration_ = 7.93

		local var_16_0 = {
			ja = 7.933,
			ko = 3.733,
			zh = 5.6,
			en = 4.466
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
				arg_16_0:Play106131005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["3004_tpose"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect3004_tpose == nil then
				arg_16_1.var_.characterEffect3004_tpose = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect3004_tpose and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect3004_tpose then
				arg_16_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_19_4 = arg_16_1.actors_["1093ui_story"]
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1093ui_story == nil then
				arg_16_1.var_.characterEffect1093ui_story = var_19_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.1

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 and not isNil(var_19_4) then
				local var_19_7 = (arg_16_1.time_ - var_19_5) / var_19_6

				if arg_16_1.var_.characterEffect1093ui_story and not isNil(var_19_4) then
					local var_19_8 = Mathf.Lerp(0, 0.5, var_19_7)

					arg_16_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1093ui_story.fillRatio = var_19_8
				end
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1093ui_story then
				local var_19_9 = 0.5

				arg_16_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1093ui_story.fillRatio = var_19_9
			end

			local var_19_10 = 0
			local var_19_11 = 0.425

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_12 = arg_16_1:FormatText(StoryNameCfg[82].name)

				arg_16_1.leftNameTxt_.text = var_19_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_13 = arg_16_1:GetWordFromCfg(106131004)
				local var_19_14 = arg_16_1:FormatText(var_19_13.content)

				arg_16_1.text_.text = var_19_14

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_15 = 17
				local var_19_16 = utf8.len(var_19_14)
				local var_19_17 = var_19_15 <= 0 and var_19_11 or var_19_11 * (var_19_16 / var_19_15)

				if var_19_17 > 0 and var_19_11 < var_19_17 then
					arg_16_1.talkMaxDuration = var_19_17

					if var_19_17 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_17 + var_19_10
					end
				end

				arg_16_1.text_.text = var_19_14
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131004", "story_v_out_106131.awb") ~= 0 then
					local var_19_18 = manager.audio:GetVoiceLength("story_v_out_106131", "106131004", "story_v_out_106131.awb") / 1000

					if var_19_18 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_18 + var_19_10
					end

					if var_19_13.prefab_name ~= "" and arg_16_1.actors_[var_19_13.prefab_name] ~= nil then
						local var_19_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_13.prefab_name].transform, "story_v_out_106131", "106131004", "story_v_out_106131.awb")

						arg_16_1:RecordAudio("106131004", var_19_19)
						arg_16_1:RecordAudio("106131004", var_19_19)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_106131", "106131004", "story_v_out_106131.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_106131", "106131004", "story_v_out_106131.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_20 = math.max(var_19_11, arg_16_1.talkMaxDuration)

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_20 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_10) / var_19_20

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_10 + var_19_20 and arg_16_1.time_ < var_19_10 + var_19_20 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play106131005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 106131005
		arg_20_1.duration_ = 9.37

		local var_20_0 = {
			ja = 9.366,
			ko = 7.133,
			zh = 8.266,
			en = 7.8
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
				arg_20_0:Play106131006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.825

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[82].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:GetWordFromCfg(106131005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 32
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131005", "story_v_out_106131.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_106131", "106131005", "story_v_out_106131.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_106131", "106131005", "story_v_out_106131.awb")

						arg_20_1:RecordAudio("106131005", var_23_9)
						arg_20_1:RecordAudio("106131005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_106131", "106131005", "story_v_out_106131.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_106131", "106131005", "story_v_out_106131.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play106131006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 106131006
		arg_24_1.duration_ = 15.7

		local var_24_0 = {
			ja = 15.7,
			ko = 8.1,
			zh = 10.666,
			en = 11
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play106131007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 1.05

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[82].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:GetWordFromCfg(106131006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 42
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131006", "story_v_out_106131.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_106131", "106131006", "story_v_out_106131.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_106131", "106131006", "story_v_out_106131.awb")

						arg_24_1:RecordAudio("106131006", var_27_9)
						arg_24_1:RecordAudio("106131006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_106131", "106131006", "story_v_out_106131.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_106131", "106131006", "story_v_out_106131.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_10 and arg_24_1.time_ < var_27_0 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play106131007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 106131007
		arg_28_1.duration_ = 4.87

		local var_28_0 = {
			ja = 4.633,
			ko = 4.866,
			zh = 4.8,
			en = 4.4
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
				arg_28_0:Play106131008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1093ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1093ui_story == nil then
				arg_28_1.var_.characterEffect1093ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1093ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1093ui_story then
				arg_28_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["3004_tpose"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect3004_tpose == nil then
				arg_28_1.var_.characterEffect3004_tpose = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.1

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect3004_tpose and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_28_1.var_.characterEffect3004_tpose.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect3004_tpose then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_28_1.var_.characterEffect3004_tpose.fillRatio = var_31_9
			end

			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_31_11 = 0
			local var_31_12 = 0.575

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_13 = arg_28_1:FormatText(StoryNameCfg[73].name)

				arg_28_1.leftNameTxt_.text = var_31_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_14 = arg_28_1:GetWordFromCfg(106131007)
				local var_31_15 = arg_28_1:FormatText(var_31_14.content)

				arg_28_1.text_.text = var_31_15

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_16 = 23
				local var_31_17 = utf8.len(var_31_15)
				local var_31_18 = var_31_16 <= 0 and var_31_12 or var_31_12 * (var_31_17 / var_31_16)

				if var_31_18 > 0 and var_31_12 < var_31_18 then
					arg_28_1.talkMaxDuration = var_31_18

					if var_31_18 + var_31_11 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_11
					end
				end

				arg_28_1.text_.text = var_31_15
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131007", "story_v_out_106131.awb") ~= 0 then
					local var_31_19 = manager.audio:GetVoiceLength("story_v_out_106131", "106131007", "story_v_out_106131.awb") / 1000

					if var_31_19 + var_31_11 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_19 + var_31_11
					end

					if var_31_14.prefab_name ~= "" and arg_28_1.actors_[var_31_14.prefab_name] ~= nil then
						local var_31_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_14.prefab_name].transform, "story_v_out_106131", "106131007", "story_v_out_106131.awb")

						arg_28_1:RecordAudio("106131007", var_31_20)
						arg_28_1:RecordAudio("106131007", var_31_20)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_106131", "106131007", "story_v_out_106131.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_106131", "106131007", "story_v_out_106131.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_21 = math.max(var_31_12, arg_28_1.talkMaxDuration)

			if var_31_11 <= arg_28_1.time_ and arg_28_1.time_ < var_31_11 + var_31_21 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_11) / var_31_21

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_11 + var_31_21 and arg_28_1.time_ < var_31_11 + var_31_21 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play106131008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 106131008
		arg_32_1.duration_ = 10.23

		local var_32_0 = {
			ja = 9.1,
			ko = 6.366,
			zh = 8.466,
			en = 10.233
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
				arg_32_0:Play106131009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["3004_tpose"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3004_tpose == nil then
				arg_32_1.var_.characterEffect3004_tpose = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect3004_tpose and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3004_tpose then
				arg_32_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["1093ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1093ui_story == nil then
				arg_32_1.var_.characterEffect1093ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.1

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect1093ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1093ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1093ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1093ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0
			local var_35_11 = 0.9

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_12 = arg_32_1:FormatText(StoryNameCfg[82].name)

				arg_32_1.leftNameTxt_.text = var_35_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_13 = arg_32_1:GetWordFromCfg(106131008)
				local var_35_14 = arg_32_1:FormatText(var_35_13.content)

				arg_32_1.text_.text = var_35_14

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 36
				local var_35_16 = utf8.len(var_35_14)
				local var_35_17 = var_35_15 <= 0 and var_35_11 or var_35_11 * (var_35_16 / var_35_15)

				if var_35_17 > 0 and var_35_11 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_10
					end
				end

				arg_32_1.text_.text = var_35_14
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131008", "story_v_out_106131.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_106131", "106131008", "story_v_out_106131.awb") / 1000

					if var_35_18 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_10
					end

					if var_35_13.prefab_name ~= "" and arg_32_1.actors_[var_35_13.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_13.prefab_name].transform, "story_v_out_106131", "106131008", "story_v_out_106131.awb")

						arg_32_1:RecordAudio("106131008", var_35_19)
						arg_32_1:RecordAudio("106131008", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_106131", "106131008", "story_v_out_106131.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_106131", "106131008", "story_v_out_106131.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_11, arg_32_1.talkMaxDuration)

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_10) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_10 + var_35_20 and arg_32_1.time_ < var_35_10 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play106131009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 106131009
		arg_36_1.duration_ = 6.33

		local var_36_0 = {
			ja = 5.4,
			ko = 4.766,
			zh = 6.333,
			en = 5.033
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
				arg_36_0:Play106131010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.65

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[82].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:GetWordFromCfg(106131009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 26
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131009", "story_v_out_106131.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_106131", "106131009", "story_v_out_106131.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_106131", "106131009", "story_v_out_106131.awb")

						arg_36_1:RecordAudio("106131009", var_39_9)
						arg_36_1:RecordAudio("106131009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_106131", "106131009", "story_v_out_106131.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_106131", "106131009", "story_v_out_106131.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_10 and arg_36_1.time_ < var_39_0 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play106131010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 106131010
		arg_40_1.duration_ = 14.8

		local var_40_0 = {
			ja = 14.8,
			ko = 12.366,
			zh = 14.7,
			en = 12.1
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
				arg_40_0:Play106131011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 1.375

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[82].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(106131010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 55
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131010", "story_v_out_106131.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_106131", "106131010", "story_v_out_106131.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_106131", "106131010", "story_v_out_106131.awb")

						arg_40_1:RecordAudio("106131010", var_43_9)
						arg_40_1:RecordAudio("106131010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_106131", "106131010", "story_v_out_106131.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_106131", "106131010", "story_v_out_106131.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play106131011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 106131011
		arg_44_1.duration_ = 5.63

		local var_44_0 = {
			ja = 5,
			ko = 4.633,
			zh = 5.633,
			en = 3.166
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play106131012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.4

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[82].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:GetWordFromCfg(106131011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 16
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131011", "story_v_out_106131.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_106131", "106131011", "story_v_out_106131.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_106131", "106131011", "story_v_out_106131.awb")

						arg_44_1:RecordAudio("106131011", var_47_9)
						arg_44_1:RecordAudio("106131011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_106131", "106131011", "story_v_out_106131.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_106131", "106131011", "story_v_out_106131.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play106131012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 106131012
		arg_48_1.duration_ = 9.3

		local var_48_0 = {
			ja = 9.3,
			ko = 4.7,
			zh = 6.933,
			en = 5
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play106131013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.625

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[82].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(106131012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 25
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131012", "story_v_out_106131.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_106131", "106131012", "story_v_out_106131.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_106131", "106131012", "story_v_out_106131.awb")

						arg_48_1:RecordAudio("106131012", var_51_9)
						arg_48_1:RecordAudio("106131012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_106131", "106131012", "story_v_out_106131.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_106131", "106131012", "story_v_out_106131.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play106131013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 106131013
		arg_52_1.duration_ = 9.17

		local var_52_0 = {
			ja = 6.6,
			ko = 7,
			zh = 8.666,
			en = 9.166
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play106131014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.725

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[82].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:GetWordFromCfg(106131013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 27
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131013", "story_v_out_106131.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_106131", "106131013", "story_v_out_106131.awb") / 1000

					if var_55_8 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_0
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_106131", "106131013", "story_v_out_106131.awb")

						arg_52_1:RecordAudio("106131013", var_55_9)
						arg_52_1:RecordAudio("106131013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_106131", "106131013", "story_v_out_106131.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_106131", "106131013", "story_v_out_106131.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_10 and arg_52_1.time_ < var_55_0 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play106131014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 106131014
		arg_56_1.duration_ = 4.8

		local var_56_0 = {
			ja = 4.8,
			ko = 4,
			zh = 4.366,
			en = 4.233
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play106131015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1093ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1093ui_story == nil then
				arg_56_1.var_.characterEffect1093ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1093ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1093ui_story then
				arg_56_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["3004_tpose"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect3004_tpose == nil then
				arg_56_1.var_.characterEffect3004_tpose = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.1

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect3004_tpose and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_56_1.var_.characterEffect3004_tpose.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect3004_tpose then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_56_1.var_.characterEffect3004_tpose.fillRatio = var_59_9
			end

			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_59_11 = 0
			local var_59_12 = 0.4

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_13 = arg_56_1:FormatText(StoryNameCfg[73].name)

				arg_56_1.leftNameTxt_.text = var_59_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_14 = arg_56_1:GetWordFromCfg(106131014)
				local var_59_15 = arg_56_1:FormatText(var_59_14.content)

				arg_56_1.text_.text = var_59_15

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_16 = 16
				local var_59_17 = utf8.len(var_59_15)
				local var_59_18 = var_59_16 <= 0 and var_59_12 or var_59_12 * (var_59_17 / var_59_16)

				if var_59_18 > 0 and var_59_12 < var_59_18 then
					arg_56_1.talkMaxDuration = var_59_18

					if var_59_18 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_11
					end
				end

				arg_56_1.text_.text = var_59_15
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131014", "story_v_out_106131.awb") ~= 0 then
					local var_59_19 = manager.audio:GetVoiceLength("story_v_out_106131", "106131014", "story_v_out_106131.awb") / 1000

					if var_59_19 + var_59_11 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_19 + var_59_11
					end

					if var_59_14.prefab_name ~= "" and arg_56_1.actors_[var_59_14.prefab_name] ~= nil then
						local var_59_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_14.prefab_name].transform, "story_v_out_106131", "106131014", "story_v_out_106131.awb")

						arg_56_1:RecordAudio("106131014", var_59_20)
						arg_56_1:RecordAudio("106131014", var_59_20)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_106131", "106131014", "story_v_out_106131.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_106131", "106131014", "story_v_out_106131.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_21 = math.max(var_59_12, arg_56_1.talkMaxDuration)

			if var_59_11 <= arg_56_1.time_ and arg_56_1.time_ < var_59_11 + var_59_21 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_11) / var_59_21

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_11 + var_59_21 and arg_56_1.time_ < var_59_11 + var_59_21 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play106131015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 106131015
		arg_60_1.duration_ = 10.67

		local var_60_0 = {
			ja = 7.366,
			ko = 7.833,
			zh = 9.7,
			en = 10.666
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play106131016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["3004_tpose"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect3004_tpose == nil then
				arg_60_1.var_.characterEffect3004_tpose = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect3004_tpose and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect3004_tpose then
				arg_60_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["1093ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1093ui_story == nil then
				arg_60_1.var_.characterEffect1093ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.1

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect1093ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1093ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1093ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1093ui_story.fillRatio = var_63_9
			end

			local var_63_10 = 0
			local var_63_11 = 0.825

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_12 = arg_60_1:FormatText(StoryNameCfg[82].name)

				arg_60_1.leftNameTxt_.text = var_63_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_13 = arg_60_1:GetWordFromCfg(106131015)
				local var_63_14 = arg_60_1:FormatText(var_63_13.content)

				arg_60_1.text_.text = var_63_14

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_15 = 33
				local var_63_16 = utf8.len(var_63_14)
				local var_63_17 = var_63_15 <= 0 and var_63_11 or var_63_11 * (var_63_16 / var_63_15)

				if var_63_17 > 0 and var_63_11 < var_63_17 then
					arg_60_1.talkMaxDuration = var_63_17

					if var_63_17 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_17 + var_63_10
					end
				end

				arg_60_1.text_.text = var_63_14
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131015", "story_v_out_106131.awb") ~= 0 then
					local var_63_18 = manager.audio:GetVoiceLength("story_v_out_106131", "106131015", "story_v_out_106131.awb") / 1000

					if var_63_18 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_18 + var_63_10
					end

					if var_63_13.prefab_name ~= "" and arg_60_1.actors_[var_63_13.prefab_name] ~= nil then
						local var_63_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_13.prefab_name].transform, "story_v_out_106131", "106131015", "story_v_out_106131.awb")

						arg_60_1:RecordAudio("106131015", var_63_19)
						arg_60_1:RecordAudio("106131015", var_63_19)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_106131", "106131015", "story_v_out_106131.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_106131", "106131015", "story_v_out_106131.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_20 = math.max(var_63_11, arg_60_1.talkMaxDuration)

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_20 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_10) / var_63_20

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_10 + var_63_20 and arg_60_1.time_ < var_63_10 + var_63_20 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play106131016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 106131016
		arg_64_1.duration_ = 12

		local var_64_0 = {
			ja = 12,
			ko = 9.166,
			zh = 9.233,
			en = 8.9
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play106131017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1093ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1093ui_story == nil then
				arg_64_1.var_.characterEffect1093ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1093ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1093ui_story then
				arg_64_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["3004_tpose"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect3004_tpose == nil then
				arg_64_1.var_.characterEffect3004_tpose = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect3004_tpose and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_64_1.var_.characterEffect3004_tpose.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect3004_tpose then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_64_1.var_.characterEffect3004_tpose.fillRatio = var_67_9
			end

			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_67_11 = 0
			local var_67_12 = 1.05

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_13 = arg_64_1:FormatText(StoryNameCfg[73].name)

				arg_64_1.leftNameTxt_.text = var_67_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_14 = arg_64_1:GetWordFromCfg(106131016)
				local var_67_15 = arg_64_1:FormatText(var_67_14.content)

				arg_64_1.text_.text = var_67_15

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_16 = 42
				local var_67_17 = utf8.len(var_67_15)
				local var_67_18 = var_67_16 <= 0 and var_67_12 or var_67_12 * (var_67_17 / var_67_16)

				if var_67_18 > 0 and var_67_12 < var_67_18 then
					arg_64_1.talkMaxDuration = var_67_18

					if var_67_18 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_18 + var_67_11
					end
				end

				arg_64_1.text_.text = var_67_15
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131016", "story_v_out_106131.awb") ~= 0 then
					local var_67_19 = manager.audio:GetVoiceLength("story_v_out_106131", "106131016", "story_v_out_106131.awb") / 1000

					if var_67_19 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_19 + var_67_11
					end

					if var_67_14.prefab_name ~= "" and arg_64_1.actors_[var_67_14.prefab_name] ~= nil then
						local var_67_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_14.prefab_name].transform, "story_v_out_106131", "106131016", "story_v_out_106131.awb")

						arg_64_1:RecordAudio("106131016", var_67_20)
						arg_64_1:RecordAudio("106131016", var_67_20)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_106131", "106131016", "story_v_out_106131.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_106131", "106131016", "story_v_out_106131.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_21 = math.max(var_67_12, arg_64_1.talkMaxDuration)

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_21 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_11) / var_67_21

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_11 + var_67_21 and arg_64_1.time_ < var_67_11 + var_67_21 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play106131017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 106131017
		arg_68_1.duration_ = 6.33

		local var_68_0 = {
			ja = 6.333,
			ko = 2.8,
			zh = 6.166,
			en = 2.666
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play106131018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["3004_tpose"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect3004_tpose == nil then
				arg_68_1.var_.characterEffect3004_tpose = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect3004_tpose and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect3004_tpose then
				arg_68_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["1093ui_story"]
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1093ui_story == nil then
				arg_68_1.var_.characterEffect1093ui_story = var_71_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.1

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 and not isNil(var_71_4) then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6

				if arg_68_1.var_.characterEffect1093ui_story and not isNil(var_71_4) then
					local var_71_8 = Mathf.Lerp(0, 0.5, var_71_7)

					arg_68_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1093ui_story.fillRatio = var_71_8
				end
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1093ui_story then
				local var_71_9 = 0.5

				arg_68_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1093ui_story.fillRatio = var_71_9
			end

			local var_71_10 = 0
			local var_71_11 = 0.325

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_12 = arg_68_1:FormatText(StoryNameCfg[82].name)

				arg_68_1.leftNameTxt_.text = var_71_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_13 = arg_68_1:GetWordFromCfg(106131017)
				local var_71_14 = arg_68_1:FormatText(var_71_13.content)

				arg_68_1.text_.text = var_71_14

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_15 = 13
				local var_71_16 = utf8.len(var_71_14)
				local var_71_17 = var_71_15 <= 0 and var_71_11 or var_71_11 * (var_71_16 / var_71_15)

				if var_71_17 > 0 and var_71_11 < var_71_17 then
					arg_68_1.talkMaxDuration = var_71_17

					if var_71_17 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_17 + var_71_10
					end
				end

				arg_68_1.text_.text = var_71_14
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131017", "story_v_out_106131.awb") ~= 0 then
					local var_71_18 = manager.audio:GetVoiceLength("story_v_out_106131", "106131017", "story_v_out_106131.awb") / 1000

					if var_71_18 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_18 + var_71_10
					end

					if var_71_13.prefab_name ~= "" and arg_68_1.actors_[var_71_13.prefab_name] ~= nil then
						local var_71_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_13.prefab_name].transform, "story_v_out_106131", "106131017", "story_v_out_106131.awb")

						arg_68_1:RecordAudio("106131017", var_71_19)
						arg_68_1:RecordAudio("106131017", var_71_19)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_106131", "106131017", "story_v_out_106131.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_106131", "106131017", "story_v_out_106131.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_20 = math.max(var_71_11, arg_68_1.talkMaxDuration)

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_20 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_10) / var_71_20

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_10 + var_71_20 and arg_68_1.time_ < var_71_10 + var_71_20 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play106131018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 106131018
		arg_72_1.duration_ = 2.37

		local var_72_0 = {
			ja = 1.333,
			ko = 1.933,
			zh = 1.4,
			en = 2.366
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play106131019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1093ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1093ui_story == nil then
				arg_72_1.var_.characterEffect1093ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1093ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1093ui_story then
				arg_72_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_75_4 = arg_72_1.actors_["3004_tpose"]
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect3004_tpose == nil then
				arg_72_1.var_.characterEffect3004_tpose = var_75_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.1

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 and not isNil(var_75_4) then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6

				if arg_72_1.var_.characterEffect3004_tpose and not isNil(var_75_4) then
					local var_75_8 = Mathf.Lerp(0, 0.5, var_75_7)

					arg_72_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_72_1.var_.characterEffect3004_tpose.fillRatio = var_75_8
				end
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect3004_tpose then
				local var_75_9 = 0.5

				arg_72_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_72_1.var_.characterEffect3004_tpose.fillRatio = var_75_9
			end

			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_75_11 = 0
			local var_75_12 = 0.125

			if var_75_11 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_13 = arg_72_1:FormatText(StoryNameCfg[73].name)

				arg_72_1.leftNameTxt_.text = var_75_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_14 = arg_72_1:GetWordFromCfg(106131018)
				local var_75_15 = arg_72_1:FormatText(var_75_14.content)

				arg_72_1.text_.text = var_75_15

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_16 = 5
				local var_75_17 = utf8.len(var_75_15)
				local var_75_18 = var_75_16 <= 0 and var_75_12 or var_75_12 * (var_75_17 / var_75_16)

				if var_75_18 > 0 and var_75_12 < var_75_18 then
					arg_72_1.talkMaxDuration = var_75_18

					if var_75_18 + var_75_11 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_18 + var_75_11
					end
				end

				arg_72_1.text_.text = var_75_15
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131018", "story_v_out_106131.awb") ~= 0 then
					local var_75_19 = manager.audio:GetVoiceLength("story_v_out_106131", "106131018", "story_v_out_106131.awb") / 1000

					if var_75_19 + var_75_11 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_19 + var_75_11
					end

					if var_75_14.prefab_name ~= "" and arg_72_1.actors_[var_75_14.prefab_name] ~= nil then
						local var_75_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_14.prefab_name].transform, "story_v_out_106131", "106131018", "story_v_out_106131.awb")

						arg_72_1:RecordAudio("106131018", var_75_20)
						arg_72_1:RecordAudio("106131018", var_75_20)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_106131", "106131018", "story_v_out_106131.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_106131", "106131018", "story_v_out_106131.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_21 = math.max(var_75_12, arg_72_1.talkMaxDuration)

			if var_75_11 <= arg_72_1.time_ and arg_72_1.time_ < var_75_11 + var_75_21 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_11) / var_75_21

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_11 + var_75_21 and arg_72_1.time_ < var_75_11 + var_75_21 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play106131019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 106131019
		arg_76_1.duration_ = 10.37

		local var_76_0 = {
			ja = 9.866,
			ko = 7.133,
			zh = 10.366,
			en = 7.733
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play106131020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["3004_tpose"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect3004_tpose == nil then
				arg_76_1.var_.characterEffect3004_tpose = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect3004_tpose and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect3004_tpose then
				arg_76_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["1093ui_story"]
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1093ui_story == nil then
				arg_76_1.var_.characterEffect1093ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_6 = 0.1

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 and not isNil(var_79_4) then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6

				if arg_76_1.var_.characterEffect1093ui_story and not isNil(var_79_4) then
					local var_79_8 = Mathf.Lerp(0, 0.5, var_79_7)

					arg_76_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1093ui_story.fillRatio = var_79_8
				end
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1093ui_story then
				local var_79_9 = 0.5

				arg_76_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1093ui_story.fillRatio = var_79_9
			end

			local var_79_10 = 0
			local var_79_11 = 1

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_12 = arg_76_1:FormatText(StoryNameCfg[82].name)

				arg_76_1.leftNameTxt_.text = var_79_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_13 = arg_76_1:GetWordFromCfg(106131019)
				local var_79_14 = arg_76_1:FormatText(var_79_13.content)

				arg_76_1.text_.text = var_79_14

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_15 = 40
				local var_79_16 = utf8.len(var_79_14)
				local var_79_17 = var_79_15 <= 0 and var_79_11 or var_79_11 * (var_79_16 / var_79_15)

				if var_79_17 > 0 and var_79_11 < var_79_17 then
					arg_76_1.talkMaxDuration = var_79_17

					if var_79_17 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_17 + var_79_10
					end
				end

				arg_76_1.text_.text = var_79_14
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131019", "story_v_out_106131.awb") ~= 0 then
					local var_79_18 = manager.audio:GetVoiceLength("story_v_out_106131", "106131019", "story_v_out_106131.awb") / 1000

					if var_79_18 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_18 + var_79_10
					end

					if var_79_13.prefab_name ~= "" and arg_76_1.actors_[var_79_13.prefab_name] ~= nil then
						local var_79_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_13.prefab_name].transform, "story_v_out_106131", "106131019", "story_v_out_106131.awb")

						arg_76_1:RecordAudio("106131019", var_79_19)
						arg_76_1:RecordAudio("106131019", var_79_19)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_106131", "106131019", "story_v_out_106131.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_106131", "106131019", "story_v_out_106131.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_20 = math.max(var_79_11, arg_76_1.talkMaxDuration)

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_20 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_10) / var_79_20

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_10 + var_79_20 and arg_76_1.time_ < var_79_10 + var_79_20 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play106131020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 106131020
		arg_80_1.duration_ = 9.2

		local var_80_0 = {
			ja = 4.7,
			ko = 9.2,
			zh = 9.066,
			en = 6.433
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play106131021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1093ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1093ui_story == nil then
				arg_80_1.var_.characterEffect1093ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1093ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1093ui_story then
				arg_80_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["3004_tpose"]
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect3004_tpose == nil then
				arg_80_1.var_.characterEffect3004_tpose = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.1

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 and not isNil(var_83_4) then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6

				if arg_80_1.var_.characterEffect3004_tpose and not isNil(var_83_4) then
					local var_83_8 = Mathf.Lerp(0, 0.5, var_83_7)

					arg_80_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_80_1.var_.characterEffect3004_tpose.fillRatio = var_83_8
				end
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect3004_tpose then
				local var_83_9 = 0.5

				arg_80_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_80_1.var_.characterEffect3004_tpose.fillRatio = var_83_9
			end

			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_83_11 = 0
			local var_83_12 = 0.9

			if var_83_11 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_13 = arg_80_1:FormatText(StoryNameCfg[73].name)

				arg_80_1.leftNameTxt_.text = var_83_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_14 = arg_80_1:GetWordFromCfg(106131020)
				local var_83_15 = arg_80_1:FormatText(var_83_14.content)

				arg_80_1.text_.text = var_83_15

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_16 = 36
				local var_83_17 = utf8.len(var_83_15)
				local var_83_18 = var_83_16 <= 0 and var_83_12 or var_83_12 * (var_83_17 / var_83_16)

				if var_83_18 > 0 and var_83_12 < var_83_18 then
					arg_80_1.talkMaxDuration = var_83_18

					if var_83_18 + var_83_11 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_18 + var_83_11
					end
				end

				arg_80_1.text_.text = var_83_15
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131020", "story_v_out_106131.awb") ~= 0 then
					local var_83_19 = manager.audio:GetVoiceLength("story_v_out_106131", "106131020", "story_v_out_106131.awb") / 1000

					if var_83_19 + var_83_11 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_19 + var_83_11
					end

					if var_83_14.prefab_name ~= "" and arg_80_1.actors_[var_83_14.prefab_name] ~= nil then
						local var_83_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_14.prefab_name].transform, "story_v_out_106131", "106131020", "story_v_out_106131.awb")

						arg_80_1:RecordAudio("106131020", var_83_20)
						arg_80_1:RecordAudio("106131020", var_83_20)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_106131", "106131020", "story_v_out_106131.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_106131", "106131020", "story_v_out_106131.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_21 = math.max(var_83_12, arg_80_1.talkMaxDuration)

			if var_83_11 <= arg_80_1.time_ and arg_80_1.time_ < var_83_11 + var_83_21 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_11) / var_83_21

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_11 + var_83_21 and arg_80_1.time_ < var_83_11 + var_83_21 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play106131021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 106131021
		arg_84_1.duration_ = 5.77

		local var_84_0 = {
			ja = 5.766,
			ko = 5.7,
			zh = 5.4,
			en = 5.533
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
				arg_84_0:Play106131022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["3004_tpose"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect3004_tpose == nil then
				arg_84_1.var_.characterEffect3004_tpose = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect3004_tpose and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect3004_tpose then
				arg_84_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_87_4 = arg_84_1.actors_["1093ui_story"]
			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1093ui_story == nil then
				arg_84_1.var_.characterEffect1093ui_story = var_87_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.1

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 and not isNil(var_87_4) then
				local var_87_7 = (arg_84_1.time_ - var_87_5) / var_87_6

				if arg_84_1.var_.characterEffect1093ui_story and not isNil(var_87_4) then
					local var_87_8 = Mathf.Lerp(0, 0.5, var_87_7)

					arg_84_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1093ui_story.fillRatio = var_87_8
				end
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1093ui_story then
				local var_87_9 = 0.5

				arg_84_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1093ui_story.fillRatio = var_87_9
			end

			local var_87_10 = 0
			local var_87_11 = 0.425

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_12 = arg_84_1:FormatText(StoryNameCfg[82].name)

				arg_84_1.leftNameTxt_.text = var_87_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_13 = arg_84_1:GetWordFromCfg(106131021)
				local var_87_14 = arg_84_1:FormatText(var_87_13.content)

				arg_84_1.text_.text = var_87_14

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_15 = 17
				local var_87_16 = utf8.len(var_87_14)
				local var_87_17 = var_87_15 <= 0 and var_87_11 or var_87_11 * (var_87_16 / var_87_15)

				if var_87_17 > 0 and var_87_11 < var_87_17 then
					arg_84_1.talkMaxDuration = var_87_17

					if var_87_17 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_17 + var_87_10
					end
				end

				arg_84_1.text_.text = var_87_14
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131021", "story_v_out_106131.awb") ~= 0 then
					local var_87_18 = manager.audio:GetVoiceLength("story_v_out_106131", "106131021", "story_v_out_106131.awb") / 1000

					if var_87_18 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_18 + var_87_10
					end

					if var_87_13.prefab_name ~= "" and arg_84_1.actors_[var_87_13.prefab_name] ~= nil then
						local var_87_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_13.prefab_name].transform, "story_v_out_106131", "106131021", "story_v_out_106131.awb")

						arg_84_1:RecordAudio("106131021", var_87_19)
						arg_84_1:RecordAudio("106131021", var_87_19)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_106131", "106131021", "story_v_out_106131.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_106131", "106131021", "story_v_out_106131.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_20 = math.max(var_87_11, arg_84_1.talkMaxDuration)

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_20 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_10) / var_87_20

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_10 + var_87_20 and arg_84_1.time_ < var_87_10 + var_87_20 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play106131022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 106131022
		arg_88_1.duration_ = 10.57

		local var_88_0 = {
			ja = 9,
			ko = 10,
			zh = 10.566,
			en = 10.266
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
				arg_88_0:Play106131023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1093ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1093ui_story == nil then
				arg_88_1.var_.characterEffect1093ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1093ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1093ui_story then
				arg_88_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_91_4 = arg_88_1.actors_["3004_tpose"]
			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect3004_tpose == nil then
				arg_88_1.var_.characterEffect3004_tpose = var_91_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.1

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 and not isNil(var_91_4) then
				local var_91_7 = (arg_88_1.time_ - var_91_5) / var_91_6

				if arg_88_1.var_.characterEffect3004_tpose and not isNil(var_91_4) then
					local var_91_8 = Mathf.Lerp(0, 0.5, var_91_7)

					arg_88_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_88_1.var_.characterEffect3004_tpose.fillRatio = var_91_8
				end
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect3004_tpose then
				local var_91_9 = 0.5

				arg_88_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_88_1.var_.characterEffect3004_tpose.fillRatio = var_91_9
			end

			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_91_11 = 0
			local var_91_12 = 1.15

			if var_91_11 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_13 = arg_88_1:FormatText(StoryNameCfg[73].name)

				arg_88_1.leftNameTxt_.text = var_91_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_14 = arg_88_1:GetWordFromCfg(106131022)
				local var_91_15 = arg_88_1:FormatText(var_91_14.content)

				arg_88_1.text_.text = var_91_15

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_16 = 46
				local var_91_17 = utf8.len(var_91_15)
				local var_91_18 = var_91_16 <= 0 and var_91_12 or var_91_12 * (var_91_17 / var_91_16)

				if var_91_18 > 0 and var_91_12 < var_91_18 then
					arg_88_1.talkMaxDuration = var_91_18

					if var_91_18 + var_91_11 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_18 + var_91_11
					end
				end

				arg_88_1.text_.text = var_91_15
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131022", "story_v_out_106131.awb") ~= 0 then
					local var_91_19 = manager.audio:GetVoiceLength("story_v_out_106131", "106131022", "story_v_out_106131.awb") / 1000

					if var_91_19 + var_91_11 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_19 + var_91_11
					end

					if var_91_14.prefab_name ~= "" and arg_88_1.actors_[var_91_14.prefab_name] ~= nil then
						local var_91_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_14.prefab_name].transform, "story_v_out_106131", "106131022", "story_v_out_106131.awb")

						arg_88_1:RecordAudio("106131022", var_91_20)
						arg_88_1:RecordAudio("106131022", var_91_20)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_106131", "106131022", "story_v_out_106131.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_106131", "106131022", "story_v_out_106131.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_21 = math.max(var_91_12, arg_88_1.talkMaxDuration)

			if var_91_11 <= arg_88_1.time_ and arg_88_1.time_ < var_91_11 + var_91_21 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_11) / var_91_21

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_11 + var_91_21 and arg_88_1.time_ < var_91_11 + var_91_21 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play106131023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 106131023
		arg_92_1.duration_ = 3.33

		local var_92_0 = {
			ja = 3.333,
			ko = 3.3,
			zh = 2.7,
			en = 1.9
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
				arg_92_0:Play106131024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["3004_tpose"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect3004_tpose == nil then
				arg_92_1.var_.characterEffect3004_tpose = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.1

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect3004_tpose and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect3004_tpose then
				arg_92_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_95_4 = arg_92_1.actors_["1093ui_story"]
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1093ui_story == nil then
				arg_92_1.var_.characterEffect1093ui_story = var_95_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.1

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 and not isNil(var_95_4) then
				local var_95_7 = (arg_92_1.time_ - var_95_5) / var_95_6

				if arg_92_1.var_.characterEffect1093ui_story and not isNil(var_95_4) then
					local var_95_8 = Mathf.Lerp(0, 0.5, var_95_7)

					arg_92_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1093ui_story.fillRatio = var_95_8
				end
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1093ui_story then
				local var_95_9 = 0.5

				arg_92_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1093ui_story.fillRatio = var_95_9
			end

			local var_95_10 = 0
			local var_95_11 = 0.075

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_12 = arg_92_1:FormatText(StoryNameCfg[82].name)

				arg_92_1.leftNameTxt_.text = var_95_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_13 = arg_92_1:GetWordFromCfg(106131023)
				local var_95_14 = arg_92_1:FormatText(var_95_13.content)

				arg_92_1.text_.text = var_95_14

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_15 = 3
				local var_95_16 = utf8.len(var_95_14)
				local var_95_17 = var_95_15 <= 0 and var_95_11 or var_95_11 * (var_95_16 / var_95_15)

				if var_95_17 > 0 and var_95_11 < var_95_17 then
					arg_92_1.talkMaxDuration = var_95_17

					if var_95_17 + var_95_10 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_17 + var_95_10
					end
				end

				arg_92_1.text_.text = var_95_14
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131023", "story_v_out_106131.awb") ~= 0 then
					local var_95_18 = manager.audio:GetVoiceLength("story_v_out_106131", "106131023", "story_v_out_106131.awb") / 1000

					if var_95_18 + var_95_10 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_18 + var_95_10
					end

					if var_95_13.prefab_name ~= "" and arg_92_1.actors_[var_95_13.prefab_name] ~= nil then
						local var_95_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_13.prefab_name].transform, "story_v_out_106131", "106131023", "story_v_out_106131.awb")

						arg_92_1:RecordAudio("106131023", var_95_19)
						arg_92_1:RecordAudio("106131023", var_95_19)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_106131", "106131023", "story_v_out_106131.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_106131", "106131023", "story_v_out_106131.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_20 = math.max(var_95_11, arg_92_1.talkMaxDuration)

			if var_95_10 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_20 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_10) / var_95_20

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_10 + var_95_20 and arg_92_1.time_ < var_95_10 + var_95_20 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play106131024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 106131024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play106131025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["3004_tpose"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect3004_tpose == nil then
				arg_96_1.var_.characterEffect3004_tpose = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect3004_tpose and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_96_1.var_.characterEffect3004_tpose.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect3004_tpose then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_96_1.var_.characterEffect3004_tpose.fillRatio = var_99_5
			end

			local var_99_6 = 0
			local var_99_7 = 0.875

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_8 = arg_96_1:GetWordFromCfg(106131024)
				local var_99_9 = arg_96_1:FormatText(var_99_8.content)

				arg_96_1.text_.text = var_99_9

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_10 = 35
				local var_99_11 = utf8.len(var_99_9)
				local var_99_12 = var_99_10 <= 0 and var_99_7 or var_99_7 * (var_99_11 / var_99_10)

				if var_99_12 > 0 and var_99_7 < var_99_12 then
					arg_96_1.talkMaxDuration = var_99_12

					if var_99_12 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_12 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_9
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_13 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_13 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_13

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_13 and arg_96_1.time_ < var_99_6 + var_99_13 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play106131025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 106131025
		arg_100_1.duration_ = 7.07

		local var_100_0 = {
			ja = 5.733,
			ko = 6.2,
			zh = 7.066,
			en = 6.866
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
				arg_100_0:Play106131026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["3004_tpose"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect3004_tpose == nil then
				arg_100_1.var_.characterEffect3004_tpose = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.1

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect3004_tpose and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect3004_tpose then
				arg_100_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_103_4 = 0
			local var_103_5 = 0.55

			if var_103_4 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_6 = arg_100_1:FormatText(StoryNameCfg[82].name)

				arg_100_1.leftNameTxt_.text = var_103_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_7 = arg_100_1:GetWordFromCfg(106131025)
				local var_103_8 = arg_100_1:FormatText(var_103_7.content)

				arg_100_1.text_.text = var_103_8

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 22
				local var_103_10 = utf8.len(var_103_8)
				local var_103_11 = var_103_9 <= 0 and var_103_5 or var_103_5 * (var_103_10 / var_103_9)

				if var_103_11 > 0 and var_103_5 < var_103_11 then
					arg_100_1.talkMaxDuration = var_103_11

					if var_103_11 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_11 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_8
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131025", "story_v_out_106131.awb") ~= 0 then
					local var_103_12 = manager.audio:GetVoiceLength("story_v_out_106131", "106131025", "story_v_out_106131.awb") / 1000

					if var_103_12 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_12 + var_103_4
					end

					if var_103_7.prefab_name ~= "" and arg_100_1.actors_[var_103_7.prefab_name] ~= nil then
						local var_103_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_7.prefab_name].transform, "story_v_out_106131", "106131025", "story_v_out_106131.awb")

						arg_100_1:RecordAudio("106131025", var_103_13)
						arg_100_1:RecordAudio("106131025", var_103_13)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_106131", "106131025", "story_v_out_106131.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_106131", "106131025", "story_v_out_106131.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_14 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_14 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_14

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_14 and arg_100_1.time_ < var_103_4 + var_103_14 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play106131026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 106131026
		arg_104_1.duration_ = 18.4

		local var_104_0 = {
			ja = 8.866,
			ko = 17,
			zh = 18.4,
			en = 14.533
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
				arg_104_0:Play106131027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 1.4

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[82].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_3 = arg_104_1:GetWordFromCfg(106131026)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 56
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

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131026", "story_v_out_106131.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_106131", "106131026", "story_v_out_106131.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_106131", "106131026", "story_v_out_106131.awb")

						arg_104_1:RecordAudio("106131026", var_107_9)
						arg_104_1:RecordAudio("106131026", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_106131", "106131026", "story_v_out_106131.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_106131", "106131026", "story_v_out_106131.awb")
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
	Play106131027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 106131027
		arg_108_1.duration_ = 6.5

		local var_108_0 = {
			ja = 5.7,
			ko = 3.733,
			zh = 5.366,
			en = 6.5
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
				arg_108_0:Play106131028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1093ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1093ui_story == nil then
				arg_108_1.var_.characterEffect1093ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.1

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1093ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1093ui_story then
				arg_108_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_111_4 = arg_108_1.actors_["3004_tpose"]
			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect3004_tpose == nil then
				arg_108_1.var_.characterEffect3004_tpose = var_111_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_6 = 0.1

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_6 and not isNil(var_111_4) then
				local var_111_7 = (arg_108_1.time_ - var_111_5) / var_111_6

				if arg_108_1.var_.characterEffect3004_tpose and not isNil(var_111_4) then
					local var_111_8 = Mathf.Lerp(0, 0.5, var_111_7)

					arg_108_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_108_1.var_.characterEffect3004_tpose.fillRatio = var_111_8
				end
			end

			if arg_108_1.time_ >= var_111_5 + var_111_6 and arg_108_1.time_ < var_111_5 + var_111_6 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect3004_tpose then
				local var_111_9 = 0.5

				arg_108_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_108_1.var_.characterEffect3004_tpose.fillRatio = var_111_9
			end

			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 then
				arg_108_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_111_11 = 0
			local var_111_12 = 0.675

			if var_111_11 < arg_108_1.time_ and arg_108_1.time_ <= var_111_11 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_13 = arg_108_1:FormatText(StoryNameCfg[73].name)

				arg_108_1.leftNameTxt_.text = var_111_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_14 = arg_108_1:GetWordFromCfg(106131027)
				local var_111_15 = arg_108_1:FormatText(var_111_14.content)

				arg_108_1.text_.text = var_111_15

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_16 = 27
				local var_111_17 = utf8.len(var_111_15)
				local var_111_18 = var_111_16 <= 0 and var_111_12 or var_111_12 * (var_111_17 / var_111_16)

				if var_111_18 > 0 and var_111_12 < var_111_18 then
					arg_108_1.talkMaxDuration = var_111_18

					if var_111_18 + var_111_11 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_18 + var_111_11
					end
				end

				arg_108_1.text_.text = var_111_15
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131027", "story_v_out_106131.awb") ~= 0 then
					local var_111_19 = manager.audio:GetVoiceLength("story_v_out_106131", "106131027", "story_v_out_106131.awb") / 1000

					if var_111_19 + var_111_11 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_19 + var_111_11
					end

					if var_111_14.prefab_name ~= "" and arg_108_1.actors_[var_111_14.prefab_name] ~= nil then
						local var_111_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_14.prefab_name].transform, "story_v_out_106131", "106131027", "story_v_out_106131.awb")

						arg_108_1:RecordAudio("106131027", var_111_20)
						arg_108_1:RecordAudio("106131027", var_111_20)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_106131", "106131027", "story_v_out_106131.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_106131", "106131027", "story_v_out_106131.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_21 = math.max(var_111_12, arg_108_1.talkMaxDuration)

			if var_111_11 <= arg_108_1.time_ and arg_108_1.time_ < var_111_11 + var_111_21 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_11) / var_111_21

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_11 + var_111_21 and arg_108_1.time_ < var_111_11 + var_111_21 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play106131028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 106131028
		arg_112_1.duration_ = 10.53

		local var_112_0 = {
			ja = 10.533,
			ko = 6.3,
			zh = 9.3,
			en = 6.533
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play106131029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["3004_tpose"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect3004_tpose == nil then
				arg_112_1.var_.characterEffect3004_tpose = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.1

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect3004_tpose and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect3004_tpose then
				arg_112_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_115_4 = arg_112_1.actors_["1093ui_story"]
			local var_115_5 = 0

			if var_115_5 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect1093ui_story == nil then
				arg_112_1.var_.characterEffect1093ui_story = var_115_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_6 = 0.1

			if var_115_5 <= arg_112_1.time_ and arg_112_1.time_ < var_115_5 + var_115_6 and not isNil(var_115_4) then
				local var_115_7 = (arg_112_1.time_ - var_115_5) / var_115_6

				if arg_112_1.var_.characterEffect1093ui_story and not isNil(var_115_4) then
					local var_115_8 = Mathf.Lerp(0, 0.5, var_115_7)

					arg_112_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1093ui_story.fillRatio = var_115_8
				end
			end

			if arg_112_1.time_ >= var_115_5 + var_115_6 and arg_112_1.time_ < var_115_5 + var_115_6 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect1093ui_story then
				local var_115_9 = 0.5

				arg_112_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1093ui_story.fillRatio = var_115_9
			end

			local var_115_10 = 0
			local var_115_11 = 0.675

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_12 = arg_112_1:FormatText(StoryNameCfg[82].name)

				arg_112_1.leftNameTxt_.text = var_115_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_13 = arg_112_1:GetWordFromCfg(106131028)
				local var_115_14 = arg_112_1:FormatText(var_115_13.content)

				arg_112_1.text_.text = var_115_14

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_15 = 27
				local var_115_16 = utf8.len(var_115_14)
				local var_115_17 = var_115_15 <= 0 and var_115_11 or var_115_11 * (var_115_16 / var_115_15)

				if var_115_17 > 0 and var_115_11 < var_115_17 then
					arg_112_1.talkMaxDuration = var_115_17

					if var_115_17 + var_115_10 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_17 + var_115_10
					end
				end

				arg_112_1.text_.text = var_115_14
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131028", "story_v_out_106131.awb") ~= 0 then
					local var_115_18 = manager.audio:GetVoiceLength("story_v_out_106131", "106131028", "story_v_out_106131.awb") / 1000

					if var_115_18 + var_115_10 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_18 + var_115_10
					end

					if var_115_13.prefab_name ~= "" and arg_112_1.actors_[var_115_13.prefab_name] ~= nil then
						local var_115_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_13.prefab_name].transform, "story_v_out_106131", "106131028", "story_v_out_106131.awb")

						arg_112_1:RecordAudio("106131028", var_115_19)
						arg_112_1:RecordAudio("106131028", var_115_19)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_106131", "106131028", "story_v_out_106131.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_106131", "106131028", "story_v_out_106131.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_20 = math.max(var_115_11, arg_112_1.talkMaxDuration)

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_20 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_10) / var_115_20

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_10 + var_115_20 and arg_112_1.time_ < var_115_10 + var_115_20 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play106131029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 106131029
		arg_116_1.duration_ = 3.03

		local var_116_0 = {
			ja = 1.8,
			ko = 3.033,
			zh = 1.966,
			en = 1.566
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
				arg_116_0:Play106131030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["3004_tpose"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect3004_tpose == nil then
				arg_116_1.var_.characterEffect3004_tpose = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.1

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect3004_tpose and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_116_1.var_.characterEffect3004_tpose.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect3004_tpose then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_116_1.var_.characterEffect3004_tpose.fillRatio = var_119_5
			end

			local var_119_6 = 0
			local var_119_7 = 0.325

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_8 = arg_116_1:FormatText(StoryNameCfg[84].name)

				arg_116_1.leftNameTxt_.text = var_119_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_9 = arg_116_1:GetWordFromCfg(106131029)
				local var_119_10 = arg_116_1:FormatText(var_119_9.content)

				arg_116_1.text_.text = var_119_10

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131029", "story_v_out_106131.awb") ~= 0 then
					local var_119_14 = manager.audio:GetVoiceLength("story_v_out_106131", "106131029", "story_v_out_106131.awb") / 1000

					if var_119_14 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_6
					end

					if var_119_9.prefab_name ~= "" and arg_116_1.actors_[var_119_9.prefab_name] ~= nil then
						local var_119_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_9.prefab_name].transform, "story_v_out_106131", "106131029", "story_v_out_106131.awb")

						arg_116_1:RecordAudio("106131029", var_119_15)
						arg_116_1:RecordAudio("106131029", var_119_15)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_106131", "106131029", "story_v_out_106131.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_106131", "106131029", "story_v_out_106131.awb")
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
	Play106131030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 106131030
		arg_120_1.duration_ = 9

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play106131031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1093ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1093ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(10, -1.16, -5.28)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1093ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(10, -1.16, -5.28)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = arg_120_1.actors_["3004_tpose"].transform
			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1.var_.moveOldPos3004_tpose = var_123_9.localPosition

				local var_123_11 = GameObjectTools.GetOrAddComponent(var_123_9.gameObject, typeof(DynamicBoneHelper))

				if var_123_11 then
					var_123_11:EnableDynamicBone(false)
				end
			end

			local var_123_12 = 0.001

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_12 then
				local var_123_13 = (arg_120_1.time_ - var_123_10) / var_123_12
				local var_123_14 = Vector3.New(10, -2.27, -2.5)

				var_123_9.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos3004_tpose, var_123_14, var_123_13)

				local var_123_15 = manager.ui.mainCamera.transform.position - var_123_9.position

				var_123_9.forward = Vector3.New(var_123_15.x, var_123_15.y, var_123_15.z)

				local var_123_16 = var_123_9.localEulerAngles

				var_123_16.z = 0
				var_123_16.x = 0
				var_123_9.localEulerAngles = var_123_16
			end

			if arg_120_1.time_ >= var_123_10 + var_123_12 and arg_120_1.time_ < var_123_10 + var_123_12 + arg_123_0 then
				var_123_9.localPosition = Vector3.New(10, -2.27, -2.5)

				local var_123_17 = manager.ui.mainCamera.transform.position - var_123_9.position

				var_123_9.forward = Vector3.New(var_123_17.x, var_123_17.y, var_123_17.z)

				local var_123_18 = var_123_9.localEulerAngles

				var_123_18.z = 0
				var_123_18.x = 0
				var_123_9.localEulerAngles = var_123_18

				local var_123_19 = GameObjectTools.GetOrAddComponent(var_123_9.gameObject, typeof(DynamicBoneHelper))

				if var_123_19 then
					var_123_19:EnableDynamicBone(true)
				end
			end

			local var_123_20 = 1.56666666666667
			local var_123_21 = 1

			if var_123_20 < arg_120_1.time_ and arg_120_1.time_ <= var_123_20 + arg_123_0 then
				local var_123_22 = "play"
				local var_123_23 = "effect"

				arg_120_1:AudioAction(var_123_22, var_123_23, "se_story_6", "se_story_6_throw_down", "")
			end

			local var_123_24 = 0

			if var_123_24 < arg_120_1.time_ and arg_120_1.time_ <= var_123_24 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = true

				arg_120_1:SetGaussion(false)
			end

			local var_123_25 = 2

			if var_123_24 <= arg_120_1.time_ and arg_120_1.time_ < var_123_24 + var_123_25 then
				local var_123_26 = (arg_120_1.time_ - var_123_24) / var_123_25
				local var_123_27 = Color.New(0, 0, 0)

				var_123_27.a = Mathf.Lerp(0, 1, var_123_26)
				arg_120_1.mask_.color = var_123_27
			end

			if arg_120_1.time_ >= var_123_24 + var_123_25 and arg_120_1.time_ < var_123_24 + var_123_25 + arg_123_0 then
				local var_123_28 = Color.New(0, 0, 0)

				var_123_28.a = 1
				arg_120_1.mask_.color = var_123_28
			end

			local var_123_29 = 2

			if var_123_29 < arg_120_1.time_ and arg_120_1.time_ <= var_123_29 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = true

				arg_120_1:SetGaussion(false)
			end

			local var_123_30 = 2

			if var_123_29 <= arg_120_1.time_ and arg_120_1.time_ < var_123_29 + var_123_30 then
				local var_123_31 = (arg_120_1.time_ - var_123_29) / var_123_30
				local var_123_32 = Color.New(0, 0, 0)

				var_123_32.a = Mathf.Lerp(1, 0, var_123_31)
				arg_120_1.mask_.color = var_123_32
			end

			if arg_120_1.time_ >= var_123_29 + var_123_30 and arg_120_1.time_ < var_123_29 + var_123_30 + arg_123_0 then
				local var_123_33 = Color.New(0, 0, 0)
				local var_123_34 = 0

				arg_120_1.mask_.enabled = false
				var_123_33.a = var_123_34
				arg_120_1.mask_.color = var_123_33
			end

			local var_123_35 = "S0612"

			if arg_120_1.bgs_[var_123_35] == nil then
				local var_123_36 = Object.Instantiate(arg_120_1.paintGo_)

				var_123_36:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_123_35)
				var_123_36.name = var_123_35
				var_123_36.transform.parent = arg_120_1.stage_.transform
				var_123_36.transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.bgs_[var_123_35] = var_123_36
			end

			local var_123_37 = 2

			if var_123_37 < arg_120_1.time_ and arg_120_1.time_ <= var_123_37 + arg_123_0 then
				local var_123_38 = manager.ui.mainCamera.transform.localPosition
				local var_123_39 = Vector3.New(0, 0, 10) + Vector3.New(var_123_38.x, var_123_38.y, 0)
				local var_123_40 = arg_120_1.bgs_.S0612

				var_123_40.transform.localPosition = var_123_39
				var_123_40.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_123_41 = var_123_40:GetComponent("SpriteRenderer")

				if var_123_41 and var_123_41.sprite then
					local var_123_42 = (var_123_40.transform.localPosition - var_123_38).z
					local var_123_43 = manager.ui.mainCameraCom_
					local var_123_44 = 2 * var_123_42 * Mathf.Tan(var_123_43.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_123_45 = var_123_44 * var_123_43.aspect
					local var_123_46 = var_123_41.sprite.bounds.size.x
					local var_123_47 = var_123_41.sprite.bounds.size.y
					local var_123_48 = var_123_45 / var_123_46
					local var_123_49 = var_123_44 / var_123_47
					local var_123_50 = var_123_49 < var_123_48 and var_123_48 or var_123_49

					var_123_40.transform.localScale = Vector3.New(var_123_50, var_123_50, 0)
				end

				for iter_123_0, iter_123_1 in pairs(arg_120_1.bgs_) do
					if iter_123_0 ~= "S0612" then
						iter_123_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_123_51 = manager.ui.mainCamera.transform
			local var_123_52 = 1.56666666666667

			if var_123_52 < arg_120_1.time_ and arg_120_1.time_ <= var_123_52 + arg_123_0 then
				local var_123_53 = arg_120_1.var_.effectkanyidao
				local var_123_54
				local var_123_55 = var_123_51

				if not var_123_53 then
					var_123_53 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_123_55)
					var_123_53.name = "kanyidao"
					arg_120_1.var_.effectkanyidao = var_123_53
				else
					var_123_53.transform:SetParent(var_123_55)
				end

				var_123_53.transform.localPosition = Vector3.New(0, 0, 0)
				var_123_53.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_123_56 = arg_120_1.bgs_.S0612.transform
			local var_123_57 = 2

			if var_123_57 < arg_120_1.time_ and arg_120_1.time_ <= var_123_57 + arg_123_0 then
				arg_120_1.var_.moveOldPosS0612 = var_123_56.localPosition
			end

			local var_123_58 = 0.001

			if var_123_57 <= arg_120_1.time_ and arg_120_1.time_ < var_123_57 + var_123_58 then
				local var_123_59 = (arg_120_1.time_ - var_123_57) / var_123_58
				local var_123_60 = Vector3.New(0, 1, 9.5)

				var_123_56.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPosS0612, var_123_60, var_123_59)
			end

			if arg_120_1.time_ >= var_123_57 + var_123_58 and arg_120_1.time_ < var_123_57 + var_123_58 + arg_123_0 then
				var_123_56.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_123_61 = arg_120_1.bgs_.S0612.transform
			local var_123_62 = 2.034

			if var_123_62 < arg_120_1.time_ and arg_120_1.time_ <= var_123_62 + arg_123_0 then
				arg_120_1.var_.moveOldPosS0612 = var_123_61.localPosition
			end

			local var_123_63 = 3.116

			if var_123_62 <= arg_120_1.time_ and arg_120_1.time_ < var_123_62 + var_123_63 then
				local var_123_64 = (arg_120_1.time_ - var_123_62) / var_123_63
				local var_123_65 = Vector3.New(0, 1, 10)

				var_123_61.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPosS0612, var_123_65, var_123_64)
			end

			if arg_120_1.time_ >= var_123_62 + var_123_63 and arg_120_1.time_ < var_123_62 + var_123_63 + arg_123_0 then
				var_123_61.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_120_1.frameCnt_ <= 1 then
				arg_120_1.dialog_:SetActive(false)
			end

			local var_123_66 = 4
			local var_123_67 = 1.15

			if var_123_66 < arg_120_1.time_ and arg_120_1.time_ <= var_123_66 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0

				arg_120_1.dialog_:SetActive(true)

				arg_120_1.dialogCg_.alpha = 0

				local var_123_68 = LeanTween.value(arg_120_1.dialog_, 0, 1, 0.3)

				var_123_68:setOnUpdate(LuaHelper.FloatAction(function(arg_124_0)
					arg_120_1.dialogCg_.alpha = arg_124_0
				end))
				var_123_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_120_1.dialog_)
					var_123_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_120_1.duration_ = arg_120_1.duration_ + 0.3

				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_69 = arg_120_1:GetWordFromCfg(106131030)
				local var_123_70 = arg_120_1:FormatText(var_123_69.content)

				arg_120_1.text_.text = var_123_70

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_71 = 46
				local var_123_72 = utf8.len(var_123_70)
				local var_123_73 = var_123_71 <= 0 and var_123_67 or var_123_67 * (var_123_72 / var_123_71)

				if var_123_73 > 0 and var_123_67 < var_123_73 then
					arg_120_1.talkMaxDuration = var_123_73
					var_123_66 = var_123_66 + 0.3

					if var_123_73 + var_123_66 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_73 + var_123_66
					end
				end

				arg_120_1.text_.text = var_123_70
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_74 = var_123_66 + 0.3
			local var_123_75 = math.max(var_123_67, arg_120_1.talkMaxDuration)

			if var_123_74 <= arg_120_1.time_ and arg_120_1.time_ < var_123_74 + var_123_75 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_74) / var_123_75

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_74 + var_123_75 and arg_120_1.time_ < var_123_74 + var_123_75 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "S0612",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0612",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.116,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play106131031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 106131031
		arg_126_1.duration_ = 4.6

		local var_126_0 = {
			ja = 4.6,
			ko = 2.633,
			zh = 4.133,
			en = 4.566
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play106131032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = manager.ui.mainCamera.transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				local var_129_2 = arg_126_1.var_.effectkanyidao

				if var_129_2 then
					Object.Destroy(var_129_2)

					arg_126_1.var_.effectkanyidao = nil
				end
			end

			local var_129_3 = 0
			local var_129_4 = 0.4

			if var_129_3 < arg_126_1.time_ and arg_126_1.time_ <= var_129_3 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_5 = arg_126_1:FormatText(StoryNameCfg[73].name)

				arg_126_1.leftNameTxt_.text = var_129_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_6 = arg_126_1:GetWordFromCfg(106131031)
				local var_129_7 = arg_126_1:FormatText(var_129_6.content)

				arg_126_1.text_.text = var_129_7

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_8 = 13
				local var_129_9 = utf8.len(var_129_7)
				local var_129_10 = var_129_8 <= 0 and var_129_4 or var_129_4 * (var_129_9 / var_129_8)

				if var_129_10 > 0 and var_129_4 < var_129_10 then
					arg_126_1.talkMaxDuration = var_129_10

					if var_129_10 + var_129_3 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_10 + var_129_3
					end
				end

				arg_126_1.text_.text = var_129_7
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131031", "story_v_out_106131.awb") ~= 0 then
					local var_129_11 = manager.audio:GetVoiceLength("story_v_out_106131", "106131031", "story_v_out_106131.awb") / 1000

					if var_129_11 + var_129_3 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_11 + var_129_3
					end

					if var_129_6.prefab_name ~= "" and arg_126_1.actors_[var_129_6.prefab_name] ~= nil then
						local var_129_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_6.prefab_name].transform, "story_v_out_106131", "106131031", "story_v_out_106131.awb")

						arg_126_1:RecordAudio("106131031", var_129_12)
						arg_126_1:RecordAudio("106131031", var_129_12)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_106131", "106131031", "story_v_out_106131.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_106131", "106131031", "story_v_out_106131.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_13 = math.max(var_129_4, arg_126_1.talkMaxDuration)

			if var_129_3 <= arg_126_1.time_ and arg_126_1.time_ < var_129_3 + var_129_13 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_3) / var_129_13

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_3 + var_129_13 and arg_126_1.time_ < var_129_3 + var_129_13 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play106131032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 106131032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play106131033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.65

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_2 = arg_130_1:GetWordFromCfg(106131032)
				local var_133_3 = arg_130_1:FormatText(var_133_2.content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 26
				local var_133_5 = utf8.len(var_133_3)
				local var_133_6 = var_133_4 <= 0 and var_133_1 or var_133_1 * (var_133_5 / var_133_4)

				if var_133_6 > 0 and var_133_1 < var_133_6 then
					arg_130_1.talkMaxDuration = var_133_6

					if var_133_6 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_7 and arg_130_1.time_ < var_133_0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play106131033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 106131033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play106131034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 1.35

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_2 = arg_134_1:GetWordFromCfg(106131033)
				local var_137_3 = arg_134_1:FormatText(var_137_2.content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 54
				local var_137_5 = utf8.len(var_137_3)
				local var_137_6 = var_137_4 <= 0 and var_137_1 or var_137_1 * (var_137_5 / var_137_4)

				if var_137_6 > 0 and var_137_1 < var_137_6 then
					arg_134_1.talkMaxDuration = var_137_6

					if var_137_6 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_7 and arg_134_1.time_ < var_137_0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play106131034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 106131034
		arg_138_1.duration_ = 4.37

		local var_138_0 = {
			ja = 3,
			ko = 2.933,
			zh = 4.366,
			en = 3.866
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play106131035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 0.375

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_2 = arg_138_1:FormatText(StoryNameCfg[84].name)

				arg_138_1.leftNameTxt_.text = var_141_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:GetWordFromCfg(106131034)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 15
				local var_141_6 = utf8.len(var_141_4)
				local var_141_7 = var_141_5 <= 0 and var_141_1 or var_141_1 * (var_141_6 / var_141_5)

				if var_141_7 > 0 and var_141_1 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131034", "story_v_out_106131.awb") ~= 0 then
					local var_141_8 = manager.audio:GetVoiceLength("story_v_out_106131", "106131034", "story_v_out_106131.awb") / 1000

					if var_141_8 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_0
					end

					if var_141_3.prefab_name ~= "" and arg_138_1.actors_[var_141_3.prefab_name] ~= nil then
						local var_141_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_3.prefab_name].transform, "story_v_out_106131", "106131034", "story_v_out_106131.awb")

						arg_138_1:RecordAudio("106131034", var_141_9)
						arg_138_1:RecordAudio("106131034", var_141_9)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_106131", "106131034", "story_v_out_106131.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_106131", "106131034", "story_v_out_106131.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_10 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_10 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_10

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_10 and arg_138_1.time_ < var_141_0 + var_141_10 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play106131035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 106131035
		arg_142_1.duration_ = 3.4

		local var_142_0 = {
			ja = 2.8,
			ko = 2.766,
			zh = 3.4,
			en = 3.066
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play106131036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.225

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[82].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(106131035)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 9
				local var_145_6 = utf8.len(var_145_4)
				local var_145_7 = var_145_5 <= 0 and var_145_1 or var_145_1 * (var_145_6 / var_145_5)

				if var_145_7 > 0 and var_145_1 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_4
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131035", "story_v_out_106131.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_106131", "106131035", "story_v_out_106131.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_106131", "106131035", "story_v_out_106131.awb")

						arg_142_1:RecordAudio("106131035", var_145_9)
						arg_142_1:RecordAudio("106131035", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_106131", "106131035", "story_v_out_106131.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_106131", "106131035", "story_v_out_106131.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_10 and arg_142_1.time_ < var_145_0 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play106131036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 106131036
		arg_146_1.duration_ = 6.4

		local var_146_0 = {
			ja = 5.233,
			ko = 3.3,
			zh = 3.1,
			en = 6.4
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play106131037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.3

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[73].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_3 = arg_146_1:GetWordFromCfg(106131036)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 12
				local var_149_6 = utf8.len(var_149_4)
				local var_149_7 = var_149_5 <= 0 and var_149_1 or var_149_1 * (var_149_6 / var_149_5)

				if var_149_7 > 0 and var_149_1 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131036", "story_v_out_106131.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_out_106131", "106131036", "story_v_out_106131.awb") / 1000

					if var_149_8 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_0
					end

					if var_149_3.prefab_name ~= "" and arg_146_1.actors_[var_149_3.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_3.prefab_name].transform, "story_v_out_106131", "106131036", "story_v_out_106131.awb")

						arg_146_1:RecordAudio("106131036", var_149_9)
						arg_146_1:RecordAudio("106131036", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_106131", "106131036", "story_v_out_106131.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_106131", "106131036", "story_v_out_106131.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_10 and arg_146_1.time_ < var_149_0 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play106131037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 106131037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play106131038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.975

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_2 = arg_150_1:GetWordFromCfg(106131037)
				local var_153_3 = arg_150_1:FormatText(var_153_2.content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 39
				local var_153_5 = utf8.len(var_153_3)
				local var_153_6 = var_153_4 <= 0 and var_153_1 or var_153_1 * (var_153_5 / var_153_4)

				if var_153_6 > 0 and var_153_1 < var_153_6 then
					arg_150_1.talkMaxDuration = var_153_6

					if var_153_6 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_6 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_7 and arg_150_1.time_ < var_153_0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play106131038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 106131038
		arg_154_1.duration_ = 7.87

		local var_154_0 = {
			ja = 7.866,
			ko = 4.3,
			zh = 5.1,
			en = 4.066
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
			arg_154_1.auto_ = false
		end

		function arg_154_1.playNext_(arg_156_0)
			arg_154_1.onStoryFinished_()
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 0.375

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_2 = arg_154_1:FormatText(StoryNameCfg[84].name)

				arg_154_1.leftNameTxt_.text = var_157_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_3 = arg_154_1:GetWordFromCfg(106131038)
				local var_157_4 = arg_154_1:FormatText(var_157_3.content)

				arg_154_1.text_.text = var_157_4

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 15
				local var_157_6 = utf8.len(var_157_4)
				local var_157_7 = var_157_5 <= 0 and var_157_1 or var_157_1 * (var_157_6 / var_157_5)

				if var_157_7 > 0 and var_157_1 < var_157_7 then
					arg_154_1.talkMaxDuration = var_157_7

					if var_157_7 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_7 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_4
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106131", "106131038", "story_v_out_106131.awb") ~= 0 then
					local var_157_8 = manager.audio:GetVoiceLength("story_v_out_106131", "106131038", "story_v_out_106131.awb") / 1000

					if var_157_8 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_8 + var_157_0
					end

					if var_157_3.prefab_name ~= "" and arg_154_1.actors_[var_157_3.prefab_name] ~= nil then
						local var_157_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_3.prefab_name].transform, "story_v_out_106131", "106131038", "story_v_out_106131.awb")

						arg_154_1:RecordAudio("106131038", var_157_9)
						arg_154_1:RecordAudio("106131038", var_157_9)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_106131", "106131038", "story_v_out_106131.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_106131", "106131038", "story_v_out_106131.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_10 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_10 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_10

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_10 and arg_154_1.time_ < var_157_0 + var_157_10 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C01b",
		"TextureConfig/Background/S0612"
	},
	voices = {
		"story_v_out_106131.awb"
	}
}
