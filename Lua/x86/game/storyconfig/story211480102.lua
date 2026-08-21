return {
	Play114802001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114802001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114802002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST01"

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
				local var_4_5 = arg_1_1.bgs_.ST01

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
					if iter_4_0 ~= "ST01" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.ST01
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueST01 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueST01 = var_4_18
				end

				arg_1_1.var_.alphaOldValueST01 = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueST01, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueST01 then
					local var_4_22 = arg_1_1.var_.alphaMatValueST01.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueST01.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueST01 then
				local var_4_23 = arg_1_1.var_.alphaMatValueST01
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0
			local var_4_26 = 1

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_27 = "play"
				local var_4_28 = "music"

				arg_1_1:AudioAction(var_4_27, var_4_28, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_29 = ""
				local var_4_30 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_31 = 2
			local var_4_32 = 3

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				local var_4_33 = "play"
				local var_4_34 = "music"

				arg_1_1:AudioAction(var_4_33, var_4_34, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_35 = ""
				local var_4_36 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_4_36 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_36 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_36

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_36
						arg_1_1.bgmTxt2_.text = var_4_36
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

			local var_4_37 = 2
			local var_4_38 = 1.475

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_39 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_39:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_40 = arg_1_1:GetWordFromCfg(114802001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 59
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_38 or var_4_38 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_38 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_37 = var_4_37 + 0.3

					if var_4_44 + var_4_37 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_37
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_37 + 0.3
			local var_4_46 = math.max(var_4_38, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play114802002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114802002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play114802003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1148ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1148ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1148ui_story = var_12_5.localPosition

				local var_12_7 = "1148ui_story"

				arg_9_1:ShowWeapon(arg_9_1.var_[var_12_7 .. "Animator"].transform, false)
			end

			local var_12_8 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_6) / var_12_8
				local var_12_10 = Vector3.New(0, -0.8, -6.2)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1148ui_story, var_12_10, var_12_9)

				local var_12_11 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_11.x, var_12_11.y, var_12_11.z)

				local var_12_12 = var_12_5.localEulerAngles

				var_12_12.z = 0
				var_12_12.x = 0
				var_12_5.localEulerAngles = var_12_12
			end

			if arg_9_1.time_ >= var_12_6 + var_12_8 and arg_9_1.time_ < var_12_6 + var_12_8 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_12_13 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_13.x, var_12_13.y, var_12_13.z)

				local var_12_14 = var_12_5.localEulerAngles

				var_12_14.z = 0
				var_12_14.x = 0
				var_12_5.localEulerAngles = var_12_14
			end

			local var_12_15 = 0.0166666666666667

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_12_16 = 0.0166666666666667

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 then
				arg_9_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_12_17 = 0
			local var_12_18 = 1

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_19 = arg_9_1:GetWordFromCfg(114802002)
				local var_12_20 = arg_9_1:FormatText(var_12_19.content)

				arg_9_1.text_.text = var_12_20

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_21 = 50
				local var_12_22 = utf8.len(var_12_20)
				local var_12_23 = var_12_21 <= 0 and var_12_18 or var_12_18 * (var_12_22 / var_12_21)

				if var_12_23 > 0 and var_12_18 < var_12_23 then
					arg_9_1.talkMaxDuration = var_12_23

					if var_12_23 + var_12_17 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_23 + var_12_17
					end
				end

				arg_9_1.text_.text = var_12_20
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_24 = math.max(var_12_18, arg_9_1.talkMaxDuration)

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_24 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_17) / var_12_24

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_17 + var_12_24 and arg_9_1.time_ < var_12_17 + var_12_24 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play114802003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114802003
		arg_13_1.duration_ = 12.93

		local var_13_0 = {
			ja = 11.966,
			ko = 12.4,
			zh = 10.466,
			en = 12.933
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
				arg_13_0:Play114802004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1148ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1148ui_story == nil then
				arg_13_1.var_.characterEffect1148ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1148ui_story and not isNil(var_16_0) then
					arg_13_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1148ui_story then
				arg_13_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_16_4 = 0

			if var_16_4 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action475")
			end

			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_16_6 = 0
			local var_16_7 = 1.15

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_8 = arg_13_1:FormatText(StoryNameCfg[8].name)

				arg_13_1.leftNameTxt_.text = var_16_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_9 = arg_13_1:GetWordFromCfg(114802003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 46
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

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802003", "story_v_side_old_114802.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802003", "story_v_side_old_114802.awb") / 1000

					if var_16_14 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_6
					end

					if var_16_9.prefab_name ~= "" and arg_13_1.actors_[var_16_9.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_9.prefab_name].transform, "story_v_side_old_114802", "114802003", "story_v_side_old_114802.awb")

						arg_13_1:RecordAudio("114802003", var_16_15)
						arg_13_1:RecordAudio("114802003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802003", "story_v_side_old_114802.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802003", "story_v_side_old_114802.awb")
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
	Play114802004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114802004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play114802005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1148ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1148ui_story == nil then
				arg_17_1.var_.characterEffect1148ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1148ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1148ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1148ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1148ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_20_7 = 0
			local var_20_8 = 0.45

			if var_20_7 < arg_17_1.time_ and arg_17_1.time_ <= var_20_7 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_9 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_10 = arg_17_1:GetWordFromCfg(114802004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_12 = 18
				local var_20_13 = utf8.len(var_20_11)
				local var_20_14 = var_20_12 <= 0 and var_20_8 or var_20_8 * (var_20_13 / var_20_12)

				if var_20_14 > 0 and var_20_8 < var_20_14 then
					arg_17_1.talkMaxDuration = var_20_14

					if var_20_14 + var_20_7 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_7
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_15 = math.max(var_20_8, arg_17_1.talkMaxDuration)

			if var_20_7 <= arg_17_1.time_ and arg_17_1.time_ < var_20_7 + var_20_15 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_7) / var_20_15

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_7 + var_20_15 and arg_17_1.time_ < var_20_7 + var_20_15 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play114802005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114802005
		arg_21_1.duration_ = 7.07

		local var_21_0 = {
			ja = 7.066,
			ko = 3.7,
			zh = 2.766,
			en = 3.533
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
				arg_21_0:Play114802006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1148ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1148ui_story == nil then
				arg_21_1.var_.characterEffect1148ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1148ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1148ui_story then
				arg_21_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_24_4 = 0

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_24_6 = 0
			local var_24_7 = 0.225

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[8].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_9 = arg_21_1:GetWordFromCfg(114802005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 9
				local var_24_12 = utf8.len(var_24_10)
				local var_24_13 = var_24_11 <= 0 and var_24_7 or var_24_7 * (var_24_12 / var_24_11)

				if var_24_13 > 0 and var_24_7 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802005", "story_v_side_old_114802.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802005", "story_v_side_old_114802.awb") / 1000

					if var_24_14 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_6
					end

					if var_24_9.prefab_name ~= "" and arg_21_1.actors_[var_24_9.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_9.prefab_name].transform, "story_v_side_old_114802", "114802005", "story_v_side_old_114802.awb")

						arg_21_1:RecordAudio("114802005", var_24_15)
						arg_21_1:RecordAudio("114802005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802005", "story_v_side_old_114802.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802005", "story_v_side_old_114802.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_16 and arg_21_1.time_ < var_24_6 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play114802006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114802006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play114802007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1148ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1148ui_story == nil then
				arg_25_1.var_.characterEffect1148ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1148ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1148ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1148ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1148ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_28_7 = 0
			local var_28_8 = 0.2

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_9 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_10 = arg_25_1:GetWordFromCfg(114802006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_12 = 8
				local var_28_13 = utf8.len(var_28_11)
				local var_28_14 = var_28_12 <= 0 and var_28_8 or var_28_8 * (var_28_13 / var_28_12)

				if var_28_14 > 0 and var_28_8 < var_28_14 then
					arg_25_1.talkMaxDuration = var_28_14

					if var_28_14 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_15 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_15 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_7) / var_28_15

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_7 + var_28_15 and arg_25_1.time_ < var_28_7 + var_28_15 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play114802007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114802007
		arg_29_1.duration_ = 2.37

		local var_29_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.033,
			en = 2.366
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
				arg_29_0:Play114802008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1148ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1148ui_story == nil then
				arg_29_1.var_.characterEffect1148ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1148ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1148ui_story then
				arg_29_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_32_6 = 0
			local var_32_7 = 0.075

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[8].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:GetWordFromCfg(114802007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 3
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_7 or var_32_7 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_7 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802007", "story_v_side_old_114802.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802007", "story_v_side_old_114802.awb") / 1000

					if var_32_14 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_6
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_side_old_114802", "114802007", "story_v_side_old_114802.awb")

						arg_29_1:RecordAudio("114802007", var_32_15)
						arg_29_1:RecordAudio("114802007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802007", "story_v_side_old_114802.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802007", "story_v_side_old_114802.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_16 and arg_29_1.time_ < var_32_6 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114802008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114802008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play114802009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1148ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1148ui_story == nil then
				arg_33_1.var_.characterEffect1148ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1148ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1148ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1148ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1148ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.2

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(114802008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 8
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
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114802009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114802009
		arg_37_1.duration_ = 2.53

		local var_37_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.533
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
				arg_37_0:Play114802010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action495")
			end

			local var_40_1 = arg_37_1.actors_["1148ui_story"]
			local var_40_2 = 0

			if var_40_2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1148ui_story == nil then
				arg_37_1.var_.characterEffect1148ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.2

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_3 and not isNil(var_40_1) then
				local var_40_4 = (arg_37_1.time_ - var_40_2) / var_40_3

				if arg_37_1.var_.characterEffect1148ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_2 + var_40_3 and arg_37_1.time_ < var_40_2 + var_40_3 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1148ui_story then
				arg_37_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_40_6 = 0
			local var_40_7 = 0.2

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[8].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_9 = arg_37_1:GetWordFromCfg(114802009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 3
				local var_40_12 = utf8.len(var_40_10)
				local var_40_13 = var_40_11 <= 0 and var_40_7 or var_40_7 * (var_40_12 / var_40_11)

				if var_40_13 > 0 and var_40_7 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802009", "story_v_side_old_114802.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802009", "story_v_side_old_114802.awb") / 1000

					if var_40_14 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_6
					end

					if var_40_9.prefab_name ~= "" and arg_37_1.actors_[var_40_9.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_9.prefab_name].transform, "story_v_side_old_114802", "114802009", "story_v_side_old_114802.awb")

						arg_37_1:RecordAudio("114802009", var_40_15)
						arg_37_1:RecordAudio("114802009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802009", "story_v_side_old_114802.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802009", "story_v_side_old_114802.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_16 and arg_37_1.time_ < var_40_6 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play114802010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114802010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play114802011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1148ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1148ui_story == nil then
				arg_41_1.var_.characterEffect1148ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1148ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1148ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1148ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1148ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.075

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(114802010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 14
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_7 or var_44_7 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_7 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play114802011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114802011
		arg_45_1.duration_ = 8.67

		local var_45_0 = {
			ja = 4.833,
			ko = 7.066,
			zh = 5.5,
			en = 8.666
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
				arg_45_0:Play114802012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1148ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1148ui_story == nil then
				arg_45_1.var_.characterEffect1148ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1148ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1148ui_story then
				arg_45_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action457")
			end

			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_48_6 = 0
			local var_48_7 = 0.35

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[8].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_9 = arg_45_1:GetWordFromCfg(114802011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 24
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802011", "story_v_side_old_114802.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802011", "story_v_side_old_114802.awb") / 1000

					if var_48_14 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_6
					end

					if var_48_9.prefab_name ~= "" and arg_45_1.actors_[var_48_9.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_9.prefab_name].transform, "story_v_side_old_114802", "114802011", "story_v_side_old_114802.awb")

						arg_45_1:RecordAudio("114802011", var_48_15)
						arg_45_1:RecordAudio("114802011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802011", "story_v_side_old_114802.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802011", "story_v_side_old_114802.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_16 and arg_45_1.time_ < var_48_6 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114802012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114802012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play114802013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_52_2 = 0
			local var_52_3 = 0.6

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(114802012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 19
				local var_52_7 = utf8.len(var_52_5)
				local var_52_8 = var_52_6 <= 0 and var_52_3 or var_52_3 * (var_52_7 / var_52_6)

				if var_52_8 > 0 and var_52_3 < var_52_8 then
					arg_49_1.talkMaxDuration = var_52_8

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_9 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_9 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_9

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_9 and arg_49_1.time_ < var_52_2 + var_52_9 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114802013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114802013
		arg_53_1.duration_ = 15.1

		local var_53_0 = {
			ja = 15.1,
			ko = 9.633,
			zh = 9.733,
			en = 9.566
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
				arg_53_0:Play114802014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_56_2 = 0
			local var_56_3 = 0.475

			if var_56_2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_4 = arg_53_1:FormatText(StoryNameCfg[8].name)

				arg_53_1.leftNameTxt_.text = var_56_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_5 = arg_53_1:GetWordFromCfg(114802013)
				local var_56_6 = arg_53_1:FormatText(var_56_5.content)

				arg_53_1.text_.text = var_56_6

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 42
				local var_56_8 = utf8.len(var_56_6)
				local var_56_9 = var_56_7 <= 0 and var_56_3 or var_56_3 * (var_56_8 / var_56_7)

				if var_56_9 > 0 and var_56_3 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_6
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802013", "story_v_side_old_114802.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802013", "story_v_side_old_114802.awb") / 1000

					if var_56_10 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_2
					end

					if var_56_5.prefab_name ~= "" and arg_53_1.actors_[var_56_5.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_5.prefab_name].transform, "story_v_side_old_114802", "114802013", "story_v_side_old_114802.awb")

						arg_53_1:RecordAudio("114802013", var_56_11)
						arg_53_1:RecordAudio("114802013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802013", "story_v_side_old_114802.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802013", "story_v_side_old_114802.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_12 and arg_53_1.time_ < var_56_2 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play114802014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114802014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play114802015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1148ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1148ui_story == nil then
				arg_57_1.var_.characterEffect1148ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1148ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1148ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1148ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1148ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_60_7 = 0
			local var_60_8 = 1.05

			if var_60_7 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_9 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_10 = arg_57_1:GetWordFromCfg(114802014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_12 = 3
				local var_60_13 = utf8.len(var_60_11)
				local var_60_14 = var_60_12 <= 0 and var_60_8 or var_60_8 * (var_60_13 / var_60_12)

				if var_60_14 > 0 and var_60_8 < var_60_14 then
					arg_57_1.talkMaxDuration = var_60_14

					if var_60_14 + var_60_7 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_7
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_15 = math.max(var_60_8, arg_57_1.talkMaxDuration)

			if var_60_7 <= arg_57_1.time_ and arg_57_1.time_ < var_60_7 + var_60_15 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_7) / var_60_15

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_7 + var_60_15 and arg_57_1.time_ < var_60_7 + var_60_15 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114802015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114802015
		arg_61_1.duration_ = 13.83

		local var_61_0 = {
			ja = 12.633,
			ko = 13.833,
			zh = 10.933,
			en = 11.433
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
				arg_61_0:Play114802016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1148ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1148ui_story == nil then
				arg_61_1.var_.characterEffect1148ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1148ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1148ui_story then
				arg_61_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action447")
			end

			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_64_6 = 0
			local var_64_7 = 0.075

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[8].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_9 = arg_61_1:GetWordFromCfg(114802015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 37
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

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802015", "story_v_side_old_114802.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802015", "story_v_side_old_114802.awb") / 1000

					if var_64_14 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_6
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_side_old_114802", "114802015", "story_v_side_old_114802.awb")

						arg_61_1:RecordAudio("114802015", var_64_15)
						arg_61_1:RecordAudio("114802015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802015", "story_v_side_old_114802.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802015", "story_v_side_old_114802.awb")
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
	Play114802016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114802016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play114802017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_68_1 = 0
			local var_68_2 = 0.925

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(114802016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 38
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_2 or var_68_2 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_2 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_8 and arg_65_1.time_ < var_68_1 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play114802017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114802017
		arg_69_1.duration_ = 5.07

		local var_69_0 = {
			ja = 5.066,
			ko = 3.033,
			zh = 2.833,
			en = 4.033
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
				arg_69_0:Play114802018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_72_2 = 0
			local var_72_3 = 0.95

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_4 = arg_69_1:FormatText(StoryNameCfg[8].name)

				arg_69_1.leftNameTxt_.text = var_72_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_5 = arg_69_1:GetWordFromCfg(114802017)
				local var_72_6 = arg_69_1:FormatText(var_72_5.content)

				arg_69_1.text_.text = var_72_6

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 13
				local var_72_8 = utf8.len(var_72_6)
				local var_72_9 = var_72_7 <= 0 and var_72_3 or var_72_3 * (var_72_8 / var_72_7)

				if var_72_9 > 0 and var_72_3 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_6
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802017", "story_v_side_old_114802.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802017", "story_v_side_old_114802.awb") / 1000

					if var_72_10 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_2
					end

					if var_72_5.prefab_name ~= "" and arg_69_1.actors_[var_72_5.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_5.prefab_name].transform, "story_v_side_old_114802", "114802017", "story_v_side_old_114802.awb")

						arg_69_1:RecordAudio("114802017", var_72_11)
						arg_69_1:RecordAudio("114802017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802017", "story_v_side_old_114802.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802017", "story_v_side_old_114802.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_12 and arg_69_1.time_ < var_72_2 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114802018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114802018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play114802019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1148ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1148ui_story == nil then
				arg_73_1.var_.characterEffect1148ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1148ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1148ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1148ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1148ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.325

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(114802018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 12
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_7 or var_76_7 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_7 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114802019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114802019
		arg_77_1.duration_ = 14.8

		local var_77_0 = {
			ja = 14.8,
			ko = 9.433,
			zh = 11.166,
			en = 12.7
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play114802020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1148ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1148ui_story == nil then
				arg_77_1.var_.characterEffect1148ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1148ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1148ui_story then
				arg_77_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_80_4 = 0

			if var_80_4 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action464")
			end

			local var_80_5 = 0

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_80_6 = 0
			local var_80_7 = 0.3

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_8 = arg_77_1:FormatText(StoryNameCfg[8].name)

				arg_77_1.leftNameTxt_.text = var_80_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_9 = arg_77_1:GetWordFromCfg(114802019)
				local var_80_10 = arg_77_1:FormatText(var_80_9.content)

				arg_77_1.text_.text = var_80_10

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 52
				local var_80_12 = utf8.len(var_80_10)
				local var_80_13 = var_80_11 <= 0 and var_80_7 or var_80_7 * (var_80_12 / var_80_11)

				if var_80_13 > 0 and var_80_7 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_10
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802019", "story_v_side_old_114802.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802019", "story_v_side_old_114802.awb") / 1000

					if var_80_14 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_6
					end

					if var_80_9.prefab_name ~= "" and arg_77_1.actors_[var_80_9.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_9.prefab_name].transform, "story_v_side_old_114802", "114802019", "story_v_side_old_114802.awb")

						arg_77_1:RecordAudio("114802019", var_80_15)
						arg_77_1:RecordAudio("114802019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802019", "story_v_side_old_114802.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802019", "story_v_side_old_114802.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_16 and arg_77_1.time_ < var_80_6 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play114802020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114802020
		arg_81_1.duration_ = 20.33

		local var_81_0 = {
			ja = 20.333,
			ko = 10.433,
			zh = 11.233,
			en = 17.466
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play114802021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_84_1 = 0
			local var_84_2 = 1.3

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_3 = arg_81_1:FormatText(StoryNameCfg[8].name)

				arg_81_1.leftNameTxt_.text = var_84_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(114802020)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_6 = 53
				local var_84_7 = utf8.len(var_84_5)
				local var_84_8 = var_84_6 <= 0 and var_84_2 or var_84_2 * (var_84_7 / var_84_6)

				if var_84_8 > 0 and var_84_2 < var_84_8 then
					arg_81_1.talkMaxDuration = var_84_8

					if var_84_8 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802020", "story_v_side_old_114802.awb") ~= 0 then
					local var_84_9 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802020", "story_v_side_old_114802.awb") / 1000

					if var_84_9 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_1
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_side_old_114802", "114802020", "story_v_side_old_114802.awb")

						arg_81_1:RecordAudio("114802020", var_84_10)
						arg_81_1:RecordAudio("114802020", var_84_10)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802020", "story_v_side_old_114802.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802020", "story_v_side_old_114802.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_11 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_11 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_11

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_11 and arg_81_1.time_ < var_84_1 + var_84_11 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play114802021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114802021
		arg_85_1.duration_ = 7.1

		local var_85_0 = {
			ja = 7.1,
			ko = 4.166,
			zh = 4.7,
			en = 5.133
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play114802022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action446")
			end

			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_88_2 = 0
			local var_88_3 = 1.325

			if var_88_2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_4 = arg_85_1:FormatText(StoryNameCfg[8].name)

				arg_85_1.leftNameTxt_.text = var_88_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_5 = arg_85_1:GetWordFromCfg(114802021)
				local var_88_6 = arg_85_1:FormatText(var_88_5.content)

				arg_85_1.text_.text = var_88_6

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 18
				local var_88_8 = utf8.len(var_88_6)
				local var_88_9 = var_88_7 <= 0 and var_88_3 or var_88_3 * (var_88_8 / var_88_7)

				if var_88_9 > 0 and var_88_3 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_6
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802021", "story_v_side_old_114802.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802021", "story_v_side_old_114802.awb") / 1000

					if var_88_10 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_2
					end

					if var_88_5.prefab_name ~= "" and arg_85_1.actors_[var_88_5.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_5.prefab_name].transform, "story_v_side_old_114802", "114802021", "story_v_side_old_114802.awb")

						arg_85_1:RecordAudio("114802021", var_88_11)
						arg_85_1:RecordAudio("114802021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802021", "story_v_side_old_114802.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802021", "story_v_side_old_114802.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_3, arg_85_1.talkMaxDuration)

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_2) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_2 + var_88_12 and arg_85_1.time_ < var_88_2 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play114802022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114802022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play114802023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1148ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1148ui_story == nil then
				arg_89_1.var_.characterEffect1148ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1148ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1148ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1148ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1148ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_92_7 = 0
			local var_92_8 = 0.45

			if var_92_7 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_9 = arg_89_1:FormatText(StoryNameCfg[7].name)

				arg_89_1.leftNameTxt_.text = var_92_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_10 = arg_89_1:GetWordFromCfg(114802022)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_12 = 5
				local var_92_13 = utf8.len(var_92_11)
				local var_92_14 = var_92_12 <= 0 and var_92_8 or var_92_8 * (var_92_13 / var_92_12)

				if var_92_14 > 0 and var_92_8 < var_92_14 then
					arg_89_1.talkMaxDuration = var_92_14

					if var_92_14 + var_92_7 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_7
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_15 = math.max(var_92_8, arg_89_1.talkMaxDuration)

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_15 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_7) / var_92_15

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_7 + var_92_15 and arg_89_1.time_ < var_92_7 + var_92_15 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play114802023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114802023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play114802024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_2")
			end

			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_96_2 = 0
			local var_96_3 = 0.125

			if var_96_2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:GetWordFromCfg(114802023)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 26
				local var_96_7 = utf8.len(var_96_5)
				local var_96_8 = var_96_6 <= 0 and var_96_3 or var_96_3 * (var_96_7 / var_96_6)

				if var_96_8 > 0 and var_96_3 < var_96_8 then
					arg_93_1.talkMaxDuration = var_96_8

					if var_96_8 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_9 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_9 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_9

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_9 and arg_93_1.time_ < var_96_2 + var_96_9 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play114802024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114802024
		arg_97_1.duration_ = 12.87

		local var_97_0 = {
			ja = 12.866,
			ko = 7.1,
			zh = 7.233,
			en = 10.5
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
				arg_97_0:Play114802025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1148ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1148ui_story == nil then
				arg_97_1.var_.characterEffect1148ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1148ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1148ui_story then
				arg_97_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_100_4 = 0

			if var_100_4 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_100_5 = 0

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_100_6 = 0
			local var_100_7 = 0.65

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[8].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_9 = arg_97_1:GetWordFromCfg(114802024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 36
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_7 or var_100_7 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_7 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802024", "story_v_side_old_114802.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802024", "story_v_side_old_114802.awb") / 1000

					if var_100_14 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_6
					end

					if var_100_9.prefab_name ~= "" and arg_97_1.actors_[var_100_9.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_9.prefab_name].transform, "story_v_side_old_114802", "114802024", "story_v_side_old_114802.awb")

						arg_97_1:RecordAudio("114802024", var_100_15)
						arg_97_1:RecordAudio("114802024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802024", "story_v_side_old_114802.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802024", "story_v_side_old_114802.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_16 and arg_97_1.time_ < var_100_6 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play114802025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114802025
		arg_101_1.duration_ = 15.37

		local var_101_0 = {
			ja = 12.933,
			ko = 12.233,
			zh = 12.5,
			en = 15.366
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
				arg_101_0:Play114802026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_104_1 = 0
			local var_104_2 = 0.9

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_3 = arg_101_1:FormatText(StoryNameCfg[8].name)

				arg_101_1.leftNameTxt_.text = var_104_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(114802025)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_6 = 54
				local var_104_7 = utf8.len(var_104_5)
				local var_104_8 = var_104_6 <= 0 and var_104_2 or var_104_2 * (var_104_7 / var_104_6)

				if var_104_8 > 0 and var_104_2 < var_104_8 then
					arg_101_1.talkMaxDuration = var_104_8

					if var_104_8 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802025", "story_v_side_old_114802.awb") ~= 0 then
					local var_104_9 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802025", "story_v_side_old_114802.awb") / 1000

					if var_104_9 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_1
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_side_old_114802", "114802025", "story_v_side_old_114802.awb")

						arg_101_1:RecordAudio("114802025", var_104_10)
						arg_101_1:RecordAudio("114802025", var_104_10)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802025", "story_v_side_old_114802.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802025", "story_v_side_old_114802.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_11 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_11 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_11

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_11 and arg_101_1.time_ < var_104_1 + var_104_11 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play114802026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 114802026
		arg_105_1.duration_ = 14.6

		local var_105_0 = {
			ja = 9.233,
			ko = 8.1,
			zh = 9.333,
			en = 14.6
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
				arg_105_0:Play114802027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action446")
			end

			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_108_2 = 0
			local var_108_3 = 1.35

			if var_108_2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_4 = arg_105_1:FormatText(StoryNameCfg[8].name)

				arg_105_1.leftNameTxt_.text = var_108_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_5 = arg_105_1:GetWordFromCfg(114802026)
				local var_108_6 = arg_105_1:FormatText(var_108_5.content)

				arg_105_1.text_.text = var_108_6

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 43
				local var_108_8 = utf8.len(var_108_6)
				local var_108_9 = var_108_7 <= 0 and var_108_3 or var_108_3 * (var_108_8 / var_108_7)

				if var_108_9 > 0 and var_108_3 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_6
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802026", "story_v_side_old_114802.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802026", "story_v_side_old_114802.awb") / 1000

					if var_108_10 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_2
					end

					if var_108_5.prefab_name ~= "" and arg_105_1.actors_[var_108_5.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_5.prefab_name].transform, "story_v_side_old_114802", "114802026", "story_v_side_old_114802.awb")

						arg_105_1:RecordAudio("114802026", var_108_11)
						arg_105_1:RecordAudio("114802026", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802026", "story_v_side_old_114802.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802026", "story_v_side_old_114802.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_12 and arg_105_1.time_ < var_108_2 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play114802027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 114802027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play114802028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_112_1 = 0
			local var_112_2 = 1.075

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(114802027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 64
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_2 or var_112_2 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_2 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_8 and arg_109_1.time_ < var_112_1 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play114802028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 114802028
		arg_113_1.duration_ = 10.03

		local var_113_0 = {
			ja = 10.033,
			ko = 7.833,
			zh = 4.9,
			en = 7.366
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

			SetActive(arg_113_1.choicesGo_, true)

			for iter_114_0, iter_114_1 in ipairs(arg_113_1.choices_) do
				local var_114_0 = iter_114_0 <= 2

				SetActive(iter_114_1.go, var_114_0)
			end

			arg_113_1.choices_[1].txt.text = arg_113_1:FormatText(StoryChoiceCfg[88].name)
			arg_113_1.choices_[2].txt.text = arg_113_1:FormatText(StoryChoiceCfg[89].name)
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play114802030(arg_113_1)
			end

			if arg_115_0 == 2 then
				arg_113_0:Play114802034(arg_113_1)
			end

			arg_113_1:RecordChoiceLog(114802028, 88, 89)
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action464")
			end

			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_116_2 = 0
			local var_116_3 = 1.6

			if var_116_2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_4 = arg_113_1:FormatText(StoryNameCfg[8].name)

				arg_113_1.leftNameTxt_.text = var_116_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_5 = arg_113_1:GetWordFromCfg(114802028)
				local var_116_6 = arg_113_1:FormatText(var_116_5.content)

				arg_113_1.text_.text = var_116_6

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 23
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

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802028", "story_v_side_old_114802.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802028", "story_v_side_old_114802.awb") / 1000

					if var_116_10 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_2
					end

					if var_116_5.prefab_name ~= "" and arg_113_1.actors_[var_116_5.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_5.prefab_name].transform, "story_v_side_old_114802", "114802028", "story_v_side_old_114802.awb")

						arg_113_1:RecordAudio("114802028", var_116_11)
						arg_113_1:RecordAudio("114802028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802028", "story_v_side_old_114802.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802028", "story_v_side_old_114802.awb")
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
	Play114802030 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 114802030
		arg_117_1.duration_ = 8.3

		local var_117_0 = {
			ja = 8.3,
			ko = 6.4,
			zh = 5.633,
			en = 8.133
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
				arg_117_0:Play114802031(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action445")
			end

			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_120_2 = 0
			local var_120_3 = 0.575

			if var_120_2 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_4 = arg_117_1:FormatText(StoryNameCfg[8].name)

				arg_117_1.leftNameTxt_.text = var_120_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_5 = arg_117_1:GetWordFromCfg(114802030)
				local var_120_6 = arg_117_1:FormatText(var_120_5.content)

				arg_117_1.text_.text = var_120_6

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 23
				local var_120_8 = utf8.len(var_120_6)
				local var_120_9 = var_120_7 <= 0 and var_120_3 or var_120_3 * (var_120_8 / var_120_7)

				if var_120_9 > 0 and var_120_3 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_6
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802030", "story_v_side_old_114802.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802030", "story_v_side_old_114802.awb") / 1000

					if var_120_10 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_2
					end

					if var_120_5.prefab_name ~= "" and arg_117_1.actors_[var_120_5.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_5.prefab_name].transform, "story_v_side_old_114802", "114802030", "story_v_side_old_114802.awb")

						arg_117_1:RecordAudio("114802030", var_120_11)
						arg_117_1:RecordAudio("114802030", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802030", "story_v_side_old_114802.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802030", "story_v_side_old_114802.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_12 and arg_117_1.time_ < var_120_2 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play114802031 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 114802031
		arg_121_1.duration_ = 12.37

		local var_121_0 = {
			ja = 12.366,
			ko = 4.833,
			zh = 5.566,
			en = 9.3
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
				arg_121_0:Play114802032(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_124_1 = 0
			local var_124_2 = 0.275

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_3 = arg_121_1:FormatText(StoryNameCfg[8].name)

				arg_121_1.leftNameTxt_.text = var_124_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_4 = arg_121_1:GetWordFromCfg(114802031)
				local var_124_5 = arg_121_1:FormatText(var_124_4.content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 24
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

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802031", "story_v_side_old_114802.awb") ~= 0 then
					local var_124_9 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802031", "story_v_side_old_114802.awb") / 1000

					if var_124_9 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_1
					end

					if var_124_4.prefab_name ~= "" and arg_121_1.actors_[var_124_4.prefab_name] ~= nil then
						local var_124_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_4.prefab_name].transform, "story_v_side_old_114802", "114802031", "story_v_side_old_114802.awb")

						arg_121_1:RecordAudio("114802031", var_124_10)
						arg_121_1:RecordAudio("114802031", var_124_10)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802031", "story_v_side_old_114802.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802031", "story_v_side_old_114802.awb")
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
	Play114802032 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 114802032
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play114802037(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_128_2 = 0
			local var_128_3 = 0.575

			if var_128_2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_4 = arg_125_1:FormatText(StoryNameCfg[7].name)

				arg_125_1.leftNameTxt_.text = var_128_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_5 = arg_125_1:GetWordFromCfg(114802032)
				local var_128_6 = arg_125_1:FormatText(var_128_5.content)

				arg_125_1.text_.text = var_128_6

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 22
				local var_128_8 = utf8.len(var_128_6)
				local var_128_9 = var_128_7 <= 0 and var_128_3 or var_128_3 * (var_128_8 / var_128_7)

				if var_128_9 > 0 and var_128_3 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_2
					end
				end

				arg_125_1.text_.text = var_128_6
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_3, arg_125_1.talkMaxDuration)

			if var_128_2 <= arg_125_1.time_ and arg_125_1.time_ < var_128_2 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_2) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_2 + var_128_10 and arg_125_1.time_ < var_128_2 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play114802037 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 114802037
		arg_129_1.duration_ = 7.43

		local var_129_0 = {
			ja = 7.433,
			ko = 4.6,
			zh = 5.233,
			en = 5.566
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
				arg_129_0:Play114802038(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_132_2 = 0
			local var_132_3 = 0.6

			if var_132_2 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_4 = arg_129_1:FormatText(StoryNameCfg[8].name)

				arg_129_1.leftNameTxt_.text = var_132_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_5 = arg_129_1:GetWordFromCfg(114802037)
				local var_132_6 = arg_129_1:FormatText(var_132_5.content)

				arg_129_1.text_.text = var_132_6

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_7 = 18
				local var_132_8 = utf8.len(var_132_6)
				local var_132_9 = var_132_7 <= 0 and var_132_3 or var_132_3 * (var_132_8 / var_132_7)

				if var_132_9 > 0 and var_132_3 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_2
					end
				end

				arg_129_1.text_.text = var_132_6
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802037", "story_v_side_old_114802.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802037", "story_v_side_old_114802.awb") / 1000

					if var_132_10 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_2
					end

					if var_132_5.prefab_name ~= "" and arg_129_1.actors_[var_132_5.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_5.prefab_name].transform, "story_v_side_old_114802", "114802037", "story_v_side_old_114802.awb")

						arg_129_1:RecordAudio("114802037", var_132_11)
						arg_129_1:RecordAudio("114802037", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802037", "story_v_side_old_114802.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802037", "story_v_side_old_114802.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_3, arg_129_1.talkMaxDuration)

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_2) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_2 + var_132_12 and arg_129_1.time_ < var_132_2 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play114802038 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 114802038
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play114802039(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_136_1 = 0
			local var_136_2 = 0.55

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(114802038)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 26
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_2 or var_136_2 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_2 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_8 and arg_133_1.time_ < var_136_1 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play114802039 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 114802039
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play114802040(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_2")
			end

			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_140_2 = 0
			local var_140_3 = 0.25

			if var_140_2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:GetWordFromCfg(114802039)
				local var_140_5 = arg_137_1:FormatText(var_140_4.content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 57
				local var_140_7 = utf8.len(var_140_5)
				local var_140_8 = var_140_6 <= 0 and var_140_3 or var_140_3 * (var_140_7 / var_140_6)

				if var_140_8 > 0 and var_140_3 < var_140_8 then
					arg_137_1.talkMaxDuration = var_140_8

					if var_140_8 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_9 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_9 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_9

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_9 and arg_137_1.time_ < var_140_2 + var_140_9 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play114802040 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 114802040
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play114802041(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1148ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1148ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(0, 100, 0)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1148ui_story, var_144_4, var_144_3)

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
			local var_144_10 = 0.225

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_11 = arg_141_1:FormatText(StoryNameCfg[7].name)

				arg_141_1.leftNameTxt_.text = var_144_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_12 = arg_141_1:GetWordFromCfg(114802040)
				local var_144_13 = arg_141_1:FormatText(var_144_12.content)

				arg_141_1.text_.text = var_144_13

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_14 = 9
				local var_144_15 = utf8.len(var_144_13)
				local var_144_16 = var_144_14 <= 0 and var_144_10 or var_144_10 * (var_144_15 / var_144_14)

				if var_144_16 > 0 and var_144_10 < var_144_16 then
					arg_141_1.talkMaxDuration = var_144_16

					if var_144_16 + var_144_9 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_16 + var_144_9
					end
				end

				arg_141_1.text_.text = var_144_13
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_17 = math.max(var_144_10, arg_141_1.talkMaxDuration)

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_17 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_9) / var_144_17

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_9 + var_144_17 and arg_141_1.time_ < var_144_9 + var_144_17 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play114802041 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 114802041
		arg_145_1.duration_ = 8.5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play114802042(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = "ST04a"

			if arg_145_1.bgs_[var_148_0] == nil then
				local var_148_1 = Object.Instantiate(arg_145_1.paintGo_)

				var_148_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_148_0)
				var_148_1.name = var_148_0
				var_148_1.transform.parent = arg_145_1.stage_.transform
				var_148_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.bgs_[var_148_0] = var_148_1
			end

			local var_148_2 = 1.5

			if var_148_2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				local var_148_3 = manager.ui.mainCamera.transform.localPosition
				local var_148_4 = Vector3.New(0, 0, 10) + Vector3.New(var_148_3.x, var_148_3.y, 0)
				local var_148_5 = arg_145_1.bgs_.ST04a

				var_148_5.transform.localPosition = var_148_4
				var_148_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_6 = var_148_5:GetComponent("SpriteRenderer")

				if var_148_6 and var_148_6.sprite then
					local var_148_7 = (var_148_5.transform.localPosition - var_148_3).z
					local var_148_8 = manager.ui.mainCameraCom_
					local var_148_9 = 2 * var_148_7 * Mathf.Tan(var_148_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_148_10 = var_148_9 * var_148_8.aspect
					local var_148_11 = var_148_6.sprite.bounds.size.x
					local var_148_12 = var_148_6.sprite.bounds.size.y
					local var_148_13 = var_148_10 / var_148_11
					local var_148_14 = var_148_9 / var_148_12
					local var_148_15 = var_148_14 < var_148_13 and var_148_13 or var_148_14

					var_148_5.transform.localScale = Vector3.New(var_148_15, var_148_15, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "ST04a" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_148_16 = arg_145_1.bgs_.ST01
			local var_148_17 = 0

			if var_148_17 < arg_145_1.time_ and arg_145_1.time_ <= var_148_17 + arg_148_0 then
				local var_148_18 = var_148_16:GetComponent("SpriteRenderer")

				if var_148_18 then
					arg_145_1.var_.alphaOldValueST01 = var_148_18.color.a
					arg_145_1.var_.alphaMatValueST01 = var_148_18
				end

				arg_145_1.var_.alphaOldValueST01 = 1
			end

			local var_148_19 = 1.5

			if var_148_17 <= arg_145_1.time_ and arg_145_1.time_ < var_148_17 + var_148_19 then
				local var_148_20 = (arg_145_1.time_ - var_148_17) / var_148_19
				local var_148_21 = Mathf.Lerp(arg_145_1.var_.alphaOldValueST01, 0, var_148_20)

				if arg_145_1.var_.alphaMatValueST01 then
					local var_148_22 = arg_145_1.var_.alphaMatValueST01.color

					var_148_22.a = var_148_21
					arg_145_1.var_.alphaMatValueST01.color = var_148_22
				end
			end

			if arg_145_1.time_ >= var_148_17 + var_148_19 and arg_145_1.time_ < var_148_17 + var_148_19 + arg_148_0 and arg_145_1.var_.alphaMatValueST01 then
				local var_148_23 = arg_145_1.var_.alphaMatValueST01
				local var_148_24 = var_148_23.color

				var_148_24.a = 0
				var_148_23.color = var_148_24
			end

			local var_148_25 = arg_145_1.bgs_.ST04a
			local var_148_26 = 1.5

			if var_148_26 < arg_145_1.time_ and arg_145_1.time_ <= var_148_26 + arg_148_0 then
				local var_148_27 = var_148_25:GetComponent("SpriteRenderer")

				if var_148_27 then
					arg_145_1.var_.alphaOldValueST04a = var_148_27.color.a
					arg_145_1.var_.alphaMatValueST04a = var_148_27
				end

				arg_145_1.var_.alphaOldValueST04a = 0
			end

			local var_148_28 = 1.5

			if var_148_26 <= arg_145_1.time_ and arg_145_1.time_ < var_148_26 + var_148_28 then
				local var_148_29 = (arg_145_1.time_ - var_148_26) / var_148_28
				local var_148_30 = Mathf.Lerp(arg_145_1.var_.alphaOldValueST04a, 1, var_148_29)

				if arg_145_1.var_.alphaMatValueST04a then
					local var_148_31 = arg_145_1.var_.alphaMatValueST04a.color

					var_148_31.a = var_148_30
					arg_145_1.var_.alphaMatValueST04a.color = var_148_31
				end
			end

			if arg_145_1.time_ >= var_148_26 + var_148_28 and arg_145_1.time_ < var_148_26 + var_148_28 + arg_148_0 and arg_145_1.var_.alphaMatValueST04a then
				local var_148_32 = arg_145_1.var_.alphaMatValueST04a
				local var_148_33 = var_148_32.color

				var_148_33.a = 1
				var_148_32.color = var_148_33
			end

			local var_148_34 = 3
			local var_148_35 = 2

			if var_148_34 < arg_145_1.time_ and arg_145_1.time_ <= var_148_34 + arg_148_0 then
				local var_148_36 = "play"
				local var_148_37 = "music"

				arg_145_1:AudioAction(var_148_36, var_148_37, "bgm_side_daily06", "bgm_side_daily06", "bgm_side_daily06.awb")

				local var_148_38 = ""
				local var_148_39 = manager.audio:GetAudioName("bgm_side_daily06", "bgm_side_daily06")

				if var_148_39 ~= "" then
					if arg_145_1.bgmTxt_.text ~= var_148_39 and arg_145_1.bgmTxt_.text ~= "" then
						if arg_145_1.bgmTxt2_.text ~= "" then
							arg_145_1.bgmTxt_.text = arg_145_1.bgmTxt2_.text
						end

						arg_145_1.bgmTxt2_.text = var_148_39

						arg_145_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_145_1.bgmTxt_.text = var_148_39
						arg_145_1.bgmTxt2_.text = var_148_39
					end

					if arg_145_1.bgmTimer then
						arg_145_1.bgmTimer:Stop()

						arg_145_1.bgmTimer = nil
					end

					if arg_145_1.settingData.show_music_name == 1 then
						arg_145_1.musicController:SetSelectedState("show")
						arg_145_1.musicAnimator_:Play("open", 0, 0)

						if arg_145_1.settingData.music_time ~= 0 then
							arg_145_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_145_1.settingData.music_time), function()
								if arg_145_1 == nil or isNil(arg_145_1.bgmTxt_) then
									return
								end

								arg_145_1.musicController:SetSelectedState("hide")
								arg_145_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_40 = 3.5
			local var_148_41 = 1.4

			if var_148_40 < arg_145_1.time_ and arg_145_1.time_ <= var_148_40 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_42 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_42:setOnUpdate(LuaHelper.FloatAction(function(arg_150_0)
					arg_145_1.dialogCg_.alpha = arg_150_0
				end))
				var_148_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_43 = arg_145_1:GetWordFromCfg(114802041)
				local var_148_44 = arg_145_1:FormatText(var_148_43.content)

				arg_145_1.text_.text = var_148_44

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_45 = 56
				local var_148_46 = utf8.len(var_148_44)
				local var_148_47 = var_148_45 <= 0 and var_148_41 or var_148_41 * (var_148_46 / var_148_45)

				if var_148_47 > 0 and var_148_41 < var_148_47 then
					arg_145_1.talkMaxDuration = var_148_47
					var_148_40 = var_148_40 + 0.3

					if var_148_47 + var_148_40 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_47 + var_148_40
					end
				end

				arg_145_1.text_.text = var_148_44
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_48 = var_148_40 + 0.3
			local var_148_49 = math.max(var_148_41, arg_145_1.talkMaxDuration)

			if var_148_48 <= arg_145_1.time_ and arg_145_1.time_ < var_148_48 + var_148_49 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_48) / var_148_49

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_48 + var_148_49 and arg_145_1.time_ < var_148_48 + var_148_49 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play114802042 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 114802042
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play114802043(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1148ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos1148ui_story = var_155_0.localPosition

				local var_155_2 = "1148ui_story"

				arg_152_1:ShowWeapon(arg_152_1.var_[var_155_2 .. "Animator"].transform, false)
			end

			local var_155_3 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_3 then
				local var_155_4 = (arg_152_1.time_ - var_155_1) / var_155_3
				local var_155_5 = Vector3.New(0, -0.8, -6.2)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1148ui_story, var_155_5, var_155_4)

				local var_155_6 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_6.x, var_155_6.y, var_155_6.z)

				local var_155_7 = var_155_0.localEulerAngles

				var_155_7.z = 0
				var_155_7.x = 0
				var_155_0.localEulerAngles = var_155_7
			end

			if arg_152_1.time_ >= var_155_1 + var_155_3 and arg_152_1.time_ < var_155_1 + var_155_3 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_155_8 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_8.x, var_155_8.y, var_155_8.z)

				local var_155_9 = var_155_0.localEulerAngles

				var_155_9.z = 0
				var_155_9.x = 0
				var_155_0.localEulerAngles = var_155_9
			end

			local var_155_10 = 0.0166666666666667

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 then
				arg_152_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action1_1")
			end

			local var_155_11 = 0.0166666666666667

			if var_155_11 < arg_152_1.time_ and arg_152_1.time_ <= var_155_11 + arg_155_0 then
				arg_152_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_155_12 = 0
			local var_155_13 = 0.65

			if var_155_12 < arg_152_1.time_ and arg_152_1.time_ <= var_155_12 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_14 = arg_152_1:GetWordFromCfg(114802042)
				local var_155_15 = arg_152_1:FormatText(var_155_14.content)

				arg_152_1.text_.text = var_155_15

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_16 = 26
				local var_155_17 = utf8.len(var_155_15)
				local var_155_18 = var_155_16 <= 0 and var_155_13 or var_155_13 * (var_155_17 / var_155_16)

				if var_155_18 > 0 and var_155_13 < var_155_18 then
					arg_152_1.talkMaxDuration = var_155_18

					if var_155_18 + var_155_12 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_18 + var_155_12
					end
				end

				arg_152_1.text_.text = var_155_15
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_19 = math.max(var_155_13, arg_152_1.talkMaxDuration)

			if var_155_12 <= arg_152_1.time_ and arg_152_1.time_ < var_155_12 + var_155_19 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_12) / var_155_19

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_12 + var_155_19 and arg_152_1.time_ < var_155_12 + var_155_19 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play114802043 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 114802043
		arg_156_1.duration_ = 7.67

		local var_156_0 = {
			ja = 7.2,
			ko = 6.733,
			zh = 6.833,
			en = 7.666
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
				arg_156_0:Play114802044(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1148ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1148ui_story == nil then
				arg_156_1.var_.characterEffect1148ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.2

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1148ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1148ui_story then
				arg_156_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_159_4 = 0

			if var_159_4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			local var_159_5 = 0

			if var_159_5 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_159_6 = 0
			local var_159_7 = 0.55

			if var_159_6 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_8 = arg_156_1:FormatText(StoryNameCfg[8].name)

				arg_156_1.leftNameTxt_.text = var_159_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_9 = arg_156_1:GetWordFromCfg(114802043)
				local var_159_10 = arg_156_1:FormatText(var_159_9.content)

				arg_156_1.text_.text = var_159_10

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 22
				local var_159_12 = utf8.len(var_159_10)
				local var_159_13 = var_159_11 <= 0 and var_159_7 or var_159_7 * (var_159_12 / var_159_11)

				if var_159_13 > 0 and var_159_7 < var_159_13 then
					arg_156_1.talkMaxDuration = var_159_13

					if var_159_13 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_13 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_10
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802043", "story_v_side_old_114802.awb") ~= 0 then
					local var_159_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802043", "story_v_side_old_114802.awb") / 1000

					if var_159_14 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_14 + var_159_6
					end

					if var_159_9.prefab_name ~= "" and arg_156_1.actors_[var_159_9.prefab_name] ~= nil then
						local var_159_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_9.prefab_name].transform, "story_v_side_old_114802", "114802043", "story_v_side_old_114802.awb")

						arg_156_1:RecordAudio("114802043", var_159_15)
						arg_156_1:RecordAudio("114802043", var_159_15)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802043", "story_v_side_old_114802.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802043", "story_v_side_old_114802.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_16 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_16 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_16

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_16 and arg_156_1.time_ < var_159_6 + var_159_16 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play114802044 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 114802044
		arg_160_1.duration_ = 6.93

		local var_160_0 = {
			ja = 6.933,
			ko = 3.333,
			zh = 4.066,
			en = 4.333
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
				arg_160_0:Play114802045(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action467")
			end

			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_163_2 = 0
			local var_163_3 = 0.45

			if var_163_2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_4 = arg_160_1:FormatText(StoryNameCfg[8].name)

				arg_160_1.leftNameTxt_.text = var_163_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_5 = arg_160_1:GetWordFromCfg(114802044)
				local var_163_6 = arg_160_1:FormatText(var_163_5.content)

				arg_160_1.text_.text = var_163_6

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_7 = 18
				local var_163_8 = utf8.len(var_163_6)
				local var_163_9 = var_163_7 <= 0 and var_163_3 or var_163_3 * (var_163_8 / var_163_7)

				if var_163_9 > 0 and var_163_3 < var_163_9 then
					arg_160_1.talkMaxDuration = var_163_9

					if var_163_9 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_9 + var_163_2
					end
				end

				arg_160_1.text_.text = var_163_6
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802044", "story_v_side_old_114802.awb") ~= 0 then
					local var_163_10 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802044", "story_v_side_old_114802.awb") / 1000

					if var_163_10 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_10 + var_163_2
					end

					if var_163_5.prefab_name ~= "" and arg_160_1.actors_[var_163_5.prefab_name] ~= nil then
						local var_163_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_5.prefab_name].transform, "story_v_side_old_114802", "114802044", "story_v_side_old_114802.awb")

						arg_160_1:RecordAudio("114802044", var_163_11)
						arg_160_1:RecordAudio("114802044", var_163_11)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802044", "story_v_side_old_114802.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802044", "story_v_side_old_114802.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_12 = math.max(var_163_3, arg_160_1.talkMaxDuration)

			if var_163_2 <= arg_160_1.time_ and arg_160_1.time_ < var_163_2 + var_163_12 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_2) / var_163_12

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_2 + var_163_12 and arg_160_1.time_ < var_163_2 + var_163_12 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play114802045 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 114802045
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play114802046(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_167_2 = arg_164_1.actors_["1148ui_story"]
			local var_167_3 = 0

			if var_167_3 < arg_164_1.time_ and arg_164_1.time_ <= var_167_3 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.characterEffect1148ui_story == nil then
				arg_164_1.var_.characterEffect1148ui_story = var_167_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_4 = 0.2

			if var_167_3 <= arg_164_1.time_ and arg_164_1.time_ < var_167_3 + var_167_4 and not isNil(var_167_2) then
				local var_167_5 = (arg_164_1.time_ - var_167_3) / var_167_4

				if arg_164_1.var_.characterEffect1148ui_story and not isNil(var_167_2) then
					local var_167_6 = Mathf.Lerp(0, 0.5, var_167_5)

					arg_164_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1148ui_story.fillRatio = var_167_6
				end
			end

			if arg_164_1.time_ >= var_167_3 + var_167_4 and arg_164_1.time_ < var_167_3 + var_167_4 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.characterEffect1148ui_story then
				local var_167_7 = 0.5

				arg_164_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1148ui_story.fillRatio = var_167_7
			end

			local var_167_8 = 0
			local var_167_9 = 1.025

			if var_167_8 < arg_164_1.time_ and arg_164_1.time_ <= var_167_8 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_10 = arg_164_1:FormatText(StoryNameCfg[7].name)

				arg_164_1.leftNameTxt_.text = var_167_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_11 = arg_164_1:GetWordFromCfg(114802045)
				local var_167_12 = arg_164_1:FormatText(var_167_11.content)

				arg_164_1.text_.text = var_167_12

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_13 = 41
				local var_167_14 = utf8.len(var_167_12)
				local var_167_15 = var_167_13 <= 0 and var_167_9 or var_167_9 * (var_167_14 / var_167_13)

				if var_167_15 > 0 and var_167_9 < var_167_15 then
					arg_164_1.talkMaxDuration = var_167_15

					if var_167_15 + var_167_8 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_15 + var_167_8
					end
				end

				arg_164_1.text_.text = var_167_12
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_16 = math.max(var_167_9, arg_164_1.talkMaxDuration)

			if var_167_8 <= arg_164_1.time_ and arg_164_1.time_ < var_167_8 + var_167_16 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_8) / var_167_16

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_8 + var_167_16 and arg_164_1.time_ < var_167_8 + var_167_16 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play114802046 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 114802046
		arg_168_1.duration_ = 9.8

		local var_168_0 = {
			ja = 9.8,
			ko = 7.433,
			zh = 8,
			en = 7.933
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play114802047(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1148ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1148ui_story == nil then
				arg_168_1.var_.characterEffect1148ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.2

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1148ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1148ui_story then
				arg_168_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_171_4 = 0

			if var_171_4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_171_5 = 0

			if var_171_5 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_171_6 = 0
			local var_171_7 = 0.85

			if var_171_6 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_8 = arg_168_1:FormatText(StoryNameCfg[8].name)

				arg_168_1.leftNameTxt_.text = var_171_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_9 = arg_168_1:GetWordFromCfg(114802046)
				local var_171_10 = arg_168_1:FormatText(var_171_9.content)

				arg_168_1.text_.text = var_171_10

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 34
				local var_171_12 = utf8.len(var_171_10)
				local var_171_13 = var_171_11 <= 0 and var_171_7 or var_171_7 * (var_171_12 / var_171_11)

				if var_171_13 > 0 and var_171_7 < var_171_13 then
					arg_168_1.talkMaxDuration = var_171_13

					if var_171_13 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_10
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802046", "story_v_side_old_114802.awb") ~= 0 then
					local var_171_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802046", "story_v_side_old_114802.awb") / 1000

					if var_171_14 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_14 + var_171_6
					end

					if var_171_9.prefab_name ~= "" and arg_168_1.actors_[var_171_9.prefab_name] ~= nil then
						local var_171_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_9.prefab_name].transform, "story_v_side_old_114802", "114802046", "story_v_side_old_114802.awb")

						arg_168_1:RecordAudio("114802046", var_171_15)
						arg_168_1:RecordAudio("114802046", var_171_15)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802046", "story_v_side_old_114802.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802046", "story_v_side_old_114802.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_16 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_16 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_16

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_16 and arg_168_1.time_ < var_171_6 + var_171_16 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play114802047 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 114802047
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play114802048(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_2")
			end

			local var_175_1 = arg_172_1.actors_["1148ui_story"]
			local var_175_2 = 0

			if var_175_2 < arg_172_1.time_ and arg_172_1.time_ <= var_175_2 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect1148ui_story == nil then
				arg_172_1.var_.characterEffect1148ui_story = var_175_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_3 = 0.2

			if var_175_2 <= arg_172_1.time_ and arg_172_1.time_ < var_175_2 + var_175_3 and not isNil(var_175_1) then
				local var_175_4 = (arg_172_1.time_ - var_175_2) / var_175_3

				if arg_172_1.var_.characterEffect1148ui_story and not isNil(var_175_1) then
					local var_175_5 = Mathf.Lerp(0, 0.5, var_175_4)

					arg_172_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1148ui_story.fillRatio = var_175_5
				end
			end

			if arg_172_1.time_ >= var_175_2 + var_175_3 and arg_172_1.time_ < var_175_2 + var_175_3 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect1148ui_story then
				local var_175_6 = 0.5

				arg_172_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1148ui_story.fillRatio = var_175_6
			end

			local var_175_7 = 0
			local var_175_8 = 0.125

			if var_175_7 < arg_172_1.time_ and arg_172_1.time_ <= var_175_7 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_9 = arg_172_1:FormatText(StoryNameCfg[7].name)

				arg_172_1.leftNameTxt_.text = var_175_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_10 = arg_172_1:GetWordFromCfg(114802047)
				local var_175_11 = arg_172_1:FormatText(var_175_10.content)

				arg_172_1.text_.text = var_175_11

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_12 = 5
				local var_175_13 = utf8.len(var_175_11)
				local var_175_14 = var_175_12 <= 0 and var_175_8 or var_175_8 * (var_175_13 / var_175_12)

				if var_175_14 > 0 and var_175_8 < var_175_14 then
					arg_172_1.talkMaxDuration = var_175_14

					if var_175_14 + var_175_7 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_14 + var_175_7
					end
				end

				arg_172_1.text_.text = var_175_11
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_15 = math.max(var_175_8, arg_172_1.talkMaxDuration)

			if var_175_7 <= arg_172_1.time_ and arg_172_1.time_ < var_175_7 + var_175_15 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_7) / var_175_15

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_7 + var_175_15 and arg_172_1.time_ < var_175_7 + var_175_15 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play114802048 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 114802048
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play114802049(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1148ui_story"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos1148ui_story = var_179_0.localPosition

				local var_179_2 = "1148ui_story"

				arg_176_1:ShowWeapon(arg_176_1.var_[var_179_2 .. "Animator"].transform, false)
			end

			local var_179_3 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_3 then
				local var_179_4 = (arg_176_1.time_ - var_179_1) / var_179_3
				local var_179_5 = Vector3.New(-0.7, -0.8, -6.2)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1148ui_story, var_179_5, var_179_4)

				local var_179_6 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_6.x, var_179_6.y, var_179_6.z)

				local var_179_7 = var_179_0.localEulerAngles

				var_179_7.z = 0
				var_179_7.x = 0
				var_179_0.localEulerAngles = var_179_7
			end

			if arg_176_1.time_ >= var_179_1 + var_179_3 and arg_176_1.time_ < var_179_1 + var_179_3 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_179_8 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_8.x, var_179_8.y, var_179_8.z)

				local var_179_9 = var_179_0.localEulerAngles

				var_179_9.z = 0
				var_179_9.x = 0
				var_179_0.localEulerAngles = var_179_9
			end

			local var_179_10 = "1039ui_story"

			if arg_176_1.actors_[var_179_10] == nil then
				local var_179_11 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_179_11) then
					local var_179_12 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_176_1.stage_.transform)

					var_179_12.name = var_179_10
					var_179_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_176_1.actors_[var_179_10] = var_179_12

					local var_179_13 = var_179_12:GetComponentInChildren(typeof(CharacterEffect))

					var_179_13.enabled = true

					local var_179_14 = GameObjectTools.GetOrAddComponent(var_179_12, typeof(DynamicBoneHelper))

					if var_179_14 then
						var_179_14:EnableDynamicBone(false)
					end

					arg_176_1:ShowWeapon(var_179_13.transform, false)

					arg_176_1.var_[var_179_10 .. "Animator"] = var_179_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_176_1.var_[var_179_10 .. "Animator"].applyRootMotion = true
					arg_176_1.var_[var_179_10 .. "LipSync"] = var_179_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_179_15 = arg_176_1.actors_["1039ui_story"].transform
			local var_179_16 = 0

			if var_179_16 < arg_176_1.time_ and arg_176_1.time_ <= var_179_16 + arg_179_0 then
				arg_176_1.var_.moveOldPos1039ui_story = var_179_15.localPosition

				local var_179_17 = "1039ui_story"

				arg_176_1:ShowWeapon(arg_176_1.var_[var_179_17 .. "Animator"].transform, false)
			end

			local var_179_18 = 0.001

			if var_179_16 <= arg_176_1.time_ and arg_176_1.time_ < var_179_16 + var_179_18 then
				local var_179_19 = (arg_176_1.time_ - var_179_16) / var_179_18
				local var_179_20 = Vector3.New(0.7, -1.01, -5.9)

				var_179_15.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1039ui_story, var_179_20, var_179_19)

				local var_179_21 = manager.ui.mainCamera.transform.position - var_179_15.position

				var_179_15.forward = Vector3.New(var_179_21.x, var_179_21.y, var_179_21.z)

				local var_179_22 = var_179_15.localEulerAngles

				var_179_22.z = 0
				var_179_22.x = 0
				var_179_15.localEulerAngles = var_179_22
			end

			if arg_176_1.time_ >= var_179_16 + var_179_18 and arg_176_1.time_ < var_179_16 + var_179_18 + arg_179_0 then
				var_179_15.localPosition = Vector3.New(0.7, -1.01, -5.9)

				local var_179_23 = manager.ui.mainCamera.transform.position - var_179_15.position

				var_179_15.forward = Vector3.New(var_179_23.x, var_179_23.y, var_179_23.z)

				local var_179_24 = var_179_15.localEulerAngles

				var_179_24.z = 0
				var_179_24.x = 0
				var_179_15.localEulerAngles = var_179_24
			end

			local var_179_25 = 0.0166666666666667

			if var_179_25 < arg_176_1.time_ and arg_176_1.time_ <= var_179_25 + arg_179_0 then
				arg_176_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action1_1")
			end

			local var_179_26 = 0.0166666666666667

			if var_179_26 < arg_176_1.time_ and arg_176_1.time_ <= var_179_26 + arg_179_0 then
				arg_176_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_179_27 = 0.0166666666666667

			if var_179_27 < arg_176_1.time_ and arg_176_1.time_ <= var_179_27 + arg_179_0 then
				arg_176_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_179_28 = 0
			local var_179_29 = 1.075

			if var_179_28 < arg_176_1.time_ and arg_176_1.time_ <= var_179_28 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_30 = arg_176_1:GetWordFromCfg(114802048)
				local var_179_31 = arg_176_1:FormatText(var_179_30.content)

				arg_176_1.text_.text = var_179_31

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_32 = 43
				local var_179_33 = utf8.len(var_179_31)
				local var_179_34 = var_179_32 <= 0 and var_179_29 or var_179_29 * (var_179_33 / var_179_32)

				if var_179_34 > 0 and var_179_29 < var_179_34 then
					arg_176_1.talkMaxDuration = var_179_34

					if var_179_34 + var_179_28 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_34 + var_179_28
					end
				end

				arg_176_1.text_.text = var_179_31
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_35 = math.max(var_179_29, arg_176_1.talkMaxDuration)

			if var_179_28 <= arg_176_1.time_ and arg_176_1.time_ < var_179_28 + var_179_35 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_28) / var_179_35

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_28 + var_179_35 and arg_176_1.time_ < var_179_28 + var_179_35 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play114802049 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 114802049
		arg_180_1.duration_ = 5.4

		local var_180_0 = {
			ja = 5.4,
			ko = 4.133,
			zh = 3,
			en = 3.933
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
				arg_180_0:Play114802050(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1039ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1039ui_story == nil then
				arg_180_1.var_.characterEffect1039ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1039ui_story and not isNil(var_183_0) then
					arg_180_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1039ui_story then
				arg_180_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_183_4 = 0

			if var_183_4 < arg_180_1.time_ and arg_180_1.time_ <= var_183_4 + arg_183_0 then
				arg_180_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			local var_183_5 = 0

			if var_183_5 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 then
				arg_180_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_183_6 = 0
			local var_183_7 = 0.4

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_8 = arg_180_1:FormatText(StoryNameCfg[9].name)

				arg_180_1.leftNameTxt_.text = var_183_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_9 = arg_180_1:GetWordFromCfg(114802049)
				local var_183_10 = arg_180_1:FormatText(var_183_9.content)

				arg_180_1.text_.text = var_183_10

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 16
				local var_183_12 = utf8.len(var_183_10)
				local var_183_13 = var_183_11 <= 0 and var_183_7 or var_183_7 * (var_183_12 / var_183_11)

				if var_183_13 > 0 and var_183_7 < var_183_13 then
					arg_180_1.talkMaxDuration = var_183_13

					if var_183_13 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_10
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802049", "story_v_side_old_114802.awb") ~= 0 then
					local var_183_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802049", "story_v_side_old_114802.awb") / 1000

					if var_183_14 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_14 + var_183_6
					end

					if var_183_9.prefab_name ~= "" and arg_180_1.actors_[var_183_9.prefab_name] ~= nil then
						local var_183_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_9.prefab_name].transform, "story_v_side_old_114802", "114802049", "story_v_side_old_114802.awb")

						arg_180_1:RecordAudio("114802049", var_183_15)
						arg_180_1:RecordAudio("114802049", var_183_15)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802049", "story_v_side_old_114802.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802049", "story_v_side_old_114802.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_16 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_16 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_16

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_16 and arg_180_1.time_ < var_183_6 + var_183_16 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play114802050 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 114802050
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play114802051(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1039ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1039ui_story == nil then
				arg_184_1.var_.characterEffect1039ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.2

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1039ui_story and not isNil(var_187_0) then
					local var_187_4 = Mathf.Lerp(0, 0.5, var_187_3)

					arg_184_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1039ui_story.fillRatio = var_187_4
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1039ui_story then
				local var_187_5 = 0.5

				arg_184_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1039ui_story.fillRatio = var_187_5
			end

			local var_187_6 = 0

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_187_7 = 0
			local var_187_8 = 0.575

			if var_187_7 < arg_184_1.time_ and arg_184_1.time_ <= var_187_7 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_9 = arg_184_1:FormatText(StoryNameCfg[7].name)

				arg_184_1.leftNameTxt_.text = var_187_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_10 = arg_184_1:GetWordFromCfg(114802050)
				local var_187_11 = arg_184_1:FormatText(var_187_10.content)

				arg_184_1.text_.text = var_187_11

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_12 = 23
				local var_187_13 = utf8.len(var_187_11)
				local var_187_14 = var_187_12 <= 0 and var_187_8 or var_187_8 * (var_187_13 / var_187_12)

				if var_187_14 > 0 and var_187_8 < var_187_14 then
					arg_184_1.talkMaxDuration = var_187_14

					if var_187_14 + var_187_7 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_14 + var_187_7
					end
				end

				arg_184_1.text_.text = var_187_11
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_15 = math.max(var_187_8, arg_184_1.talkMaxDuration)

			if var_187_7 <= arg_184_1.time_ and arg_184_1.time_ < var_187_7 + var_187_15 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_7) / var_187_15

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_7 + var_187_15 and arg_184_1.time_ < var_187_7 + var_187_15 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play114802051 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 114802051
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play114802052(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action463")
			end

			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_191_2 = 0

			if var_191_2 < arg_188_1.time_ and arg_188_1.time_ <= var_191_2 + arg_191_0 then
				arg_188_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_191_3 = 0
			local var_191_4 = 1.45

			if var_191_3 < arg_188_1.time_ and arg_188_1.time_ <= var_191_3 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_5 = arg_188_1:GetWordFromCfg(114802051)
				local var_191_6 = arg_188_1:FormatText(var_191_5.content)

				arg_188_1.text_.text = var_191_6

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_7 = 58
				local var_191_8 = utf8.len(var_191_6)
				local var_191_9 = var_191_7 <= 0 and var_191_4 or var_191_4 * (var_191_8 / var_191_7)

				if var_191_9 > 0 and var_191_4 < var_191_9 then
					arg_188_1.talkMaxDuration = var_191_9

					if var_191_9 + var_191_3 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_9 + var_191_3
					end
				end

				arg_188_1.text_.text = var_191_6
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_10 = math.max(var_191_4, arg_188_1.talkMaxDuration)

			if var_191_3 <= arg_188_1.time_ and arg_188_1.time_ < var_191_3 + var_191_10 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_3) / var_191_10

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_3 + var_191_10 and arg_188_1.time_ < var_191_3 + var_191_10 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play114802052 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 114802052
		arg_192_1.duration_ = 4.4

		local var_192_0 = {
			ja = 4.4,
			ko = 3.833,
			zh = 2.233,
			en = 3.933
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
				arg_192_0:Play114802053(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1039ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1039ui_story == nil then
				arg_192_1.var_.characterEffect1039ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.2

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect1039ui_story and not isNil(var_195_0) then
					arg_192_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1039ui_story then
				arg_192_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_195_4 = 0

			if var_195_4 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_195_5 = 0
			local var_195_6 = 0.3

			if var_195_5 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_7 = arg_192_1:FormatText(StoryNameCfg[9].name)

				arg_192_1.leftNameTxt_.text = var_195_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_8 = arg_192_1:GetWordFromCfg(114802052)
				local var_195_9 = arg_192_1:FormatText(var_195_8.content)

				arg_192_1.text_.text = var_195_9

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_10 = 12
				local var_195_11 = utf8.len(var_195_9)
				local var_195_12 = var_195_10 <= 0 and var_195_6 or var_195_6 * (var_195_11 / var_195_10)

				if var_195_12 > 0 and var_195_6 < var_195_12 then
					arg_192_1.talkMaxDuration = var_195_12

					if var_195_12 + var_195_5 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_12 + var_195_5
					end
				end

				arg_192_1.text_.text = var_195_9
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802052", "story_v_side_old_114802.awb") ~= 0 then
					local var_195_13 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802052", "story_v_side_old_114802.awb") / 1000

					if var_195_13 + var_195_5 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_13 + var_195_5
					end

					if var_195_8.prefab_name ~= "" and arg_192_1.actors_[var_195_8.prefab_name] ~= nil then
						local var_195_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_8.prefab_name].transform, "story_v_side_old_114802", "114802052", "story_v_side_old_114802.awb")

						arg_192_1:RecordAudio("114802052", var_195_14)
						arg_192_1:RecordAudio("114802052", var_195_14)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802052", "story_v_side_old_114802.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802052", "story_v_side_old_114802.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_15 = math.max(var_195_6, arg_192_1.talkMaxDuration)

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_15 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_5) / var_195_15

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_5 + var_195_15 and arg_192_1.time_ < var_195_5 + var_195_15 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play114802053 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 114802053
		arg_196_1.duration_ = 14.5

		local var_196_0 = {
			ja = 10.533,
			ko = 11.366,
			zh = 11.566,
			en = 14.5
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
				arg_196_0:Play114802054(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action475")
			end

			local var_199_1 = arg_196_1.actors_["1148ui_story"]
			local var_199_2 = 0

			if var_199_2 < arg_196_1.time_ and arg_196_1.time_ <= var_199_2 + arg_199_0 and not isNil(var_199_1) and arg_196_1.var_.characterEffect1148ui_story == nil then
				arg_196_1.var_.characterEffect1148ui_story = var_199_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_3 = 0.2

			if var_199_2 <= arg_196_1.time_ and arg_196_1.time_ < var_199_2 + var_199_3 and not isNil(var_199_1) then
				local var_199_4 = (arg_196_1.time_ - var_199_2) / var_199_3

				if arg_196_1.var_.characterEffect1148ui_story and not isNil(var_199_1) then
					arg_196_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_2 + var_199_3 and arg_196_1.time_ < var_199_2 + var_199_3 + arg_199_0 and not isNil(var_199_1) and arg_196_1.var_.characterEffect1148ui_story then
				arg_196_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_199_5 = arg_196_1.actors_["1039ui_story"]
			local var_199_6 = 0

			if var_199_6 < arg_196_1.time_ and arg_196_1.time_ <= var_199_6 + arg_199_0 and not isNil(var_199_5) and arg_196_1.var_.characterEffect1039ui_story == nil then
				arg_196_1.var_.characterEffect1039ui_story = var_199_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_7 = 0.2

			if var_199_6 <= arg_196_1.time_ and arg_196_1.time_ < var_199_6 + var_199_7 and not isNil(var_199_5) then
				local var_199_8 = (arg_196_1.time_ - var_199_6) / var_199_7

				if arg_196_1.var_.characterEffect1039ui_story and not isNil(var_199_5) then
					local var_199_9 = Mathf.Lerp(0, 0.5, var_199_8)

					arg_196_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1039ui_story.fillRatio = var_199_9
				end
			end

			if arg_196_1.time_ >= var_199_6 + var_199_7 and arg_196_1.time_ < var_199_6 + var_199_7 + arg_199_0 and not isNil(var_199_5) and arg_196_1.var_.characterEffect1039ui_story then
				local var_199_10 = 0.5

				arg_196_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1039ui_story.fillRatio = var_199_10
			end

			local var_199_11 = 0

			if var_199_11 < arg_196_1.time_ and arg_196_1.time_ <= var_199_11 + arg_199_0 then
				arg_196_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_199_12 = 0
			local var_199_13 = 1.25

			if var_199_12 < arg_196_1.time_ and arg_196_1.time_ <= var_199_12 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_14 = arg_196_1:FormatText(StoryNameCfg[8].name)

				arg_196_1.leftNameTxt_.text = var_199_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_15 = arg_196_1:GetWordFromCfg(114802053)
				local var_199_16 = arg_196_1:FormatText(var_199_15.content)

				arg_196_1.text_.text = var_199_16

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_17 = 50
				local var_199_18 = utf8.len(var_199_16)
				local var_199_19 = var_199_17 <= 0 and var_199_13 or var_199_13 * (var_199_18 / var_199_17)

				if var_199_19 > 0 and var_199_13 < var_199_19 then
					arg_196_1.talkMaxDuration = var_199_19

					if var_199_19 + var_199_12 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_19 + var_199_12
					end
				end

				arg_196_1.text_.text = var_199_16
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802053", "story_v_side_old_114802.awb") ~= 0 then
					local var_199_20 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802053", "story_v_side_old_114802.awb") / 1000

					if var_199_20 + var_199_12 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_20 + var_199_12
					end

					if var_199_15.prefab_name ~= "" and arg_196_1.actors_[var_199_15.prefab_name] ~= nil then
						local var_199_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_15.prefab_name].transform, "story_v_side_old_114802", "114802053", "story_v_side_old_114802.awb")

						arg_196_1:RecordAudio("114802053", var_199_21)
						arg_196_1:RecordAudio("114802053", var_199_21)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802053", "story_v_side_old_114802.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802053", "story_v_side_old_114802.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_22 = math.max(var_199_13, arg_196_1.talkMaxDuration)

			if var_199_12 <= arg_196_1.time_ and arg_196_1.time_ < var_199_12 + var_199_22 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_12) / var_199_22

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_12 + var_199_22 and arg_196_1.time_ < var_199_12 + var_199_22 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play114802054 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 114802054
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play114802055(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action437")
			end

			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_203_2 = arg_200_1.actors_["1148ui_story"]
			local var_203_3 = 0

			if var_203_3 < arg_200_1.time_ and arg_200_1.time_ <= var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.characterEffect1148ui_story == nil then
				arg_200_1.var_.characterEffect1148ui_story = var_203_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_4 = 0.2

			if var_203_3 <= arg_200_1.time_ and arg_200_1.time_ < var_203_3 + var_203_4 and not isNil(var_203_2) then
				local var_203_5 = (arg_200_1.time_ - var_203_3) / var_203_4

				if arg_200_1.var_.characterEffect1148ui_story and not isNil(var_203_2) then
					local var_203_6 = Mathf.Lerp(0, 0.5, var_203_5)

					arg_200_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1148ui_story.fillRatio = var_203_6
				end
			end

			if arg_200_1.time_ >= var_203_3 + var_203_4 and arg_200_1.time_ < var_203_3 + var_203_4 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.characterEffect1148ui_story then
				local var_203_7 = 0.5

				arg_200_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1148ui_story.fillRatio = var_203_7
			end

			local var_203_8 = 0

			if var_203_8 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 then
				arg_200_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_203_9 = 0
			local var_203_10 = 0.875

			if var_203_9 < arg_200_1.time_ and arg_200_1.time_ <= var_203_9 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_11 = arg_200_1:GetWordFromCfg(114802054)
				local var_203_12 = arg_200_1:FormatText(var_203_11.content)

				arg_200_1.text_.text = var_203_12

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_13 = 35
				local var_203_14 = utf8.len(var_203_12)
				local var_203_15 = var_203_13 <= 0 and var_203_10 or var_203_10 * (var_203_14 / var_203_13)

				if var_203_15 > 0 and var_203_10 < var_203_15 then
					arg_200_1.talkMaxDuration = var_203_15

					if var_203_15 + var_203_9 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_15 + var_203_9
					end
				end

				arg_200_1.text_.text = var_203_12
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_16 = math.max(var_203_10, arg_200_1.talkMaxDuration)

			if var_203_9 <= arg_200_1.time_ and arg_200_1.time_ < var_203_9 + var_203_16 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_9) / var_203_16

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_9 + var_203_16 and arg_200_1.time_ < var_203_9 + var_203_16 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play114802055 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 114802055
		arg_204_1.duration_ = 4.5

		local var_204_0 = {
			ja = 3.833,
			ko = 2.766,
			zh = 4.5,
			en = 2.733
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
				arg_204_0:Play114802056(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1039ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1039ui_story == nil then
				arg_204_1.var_.characterEffect1039ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.2

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect1039ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1039ui_story then
				arg_204_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_207_4 = 0

			if var_207_4 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_207_5 = 0
			local var_207_6 = 0.3

			if var_207_5 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_7 = arg_204_1:FormatText(StoryNameCfg[9].name)

				arg_204_1.leftNameTxt_.text = var_207_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_8 = arg_204_1:GetWordFromCfg(114802055)
				local var_207_9 = arg_204_1:FormatText(var_207_8.content)

				arg_204_1.text_.text = var_207_9

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_10 = 12
				local var_207_11 = utf8.len(var_207_9)
				local var_207_12 = var_207_10 <= 0 and var_207_6 or var_207_6 * (var_207_11 / var_207_10)

				if var_207_12 > 0 and var_207_6 < var_207_12 then
					arg_204_1.talkMaxDuration = var_207_12

					if var_207_12 + var_207_5 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_12 + var_207_5
					end
				end

				arg_204_1.text_.text = var_207_9
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802055", "story_v_side_old_114802.awb") ~= 0 then
					local var_207_13 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802055", "story_v_side_old_114802.awb") / 1000

					if var_207_13 + var_207_5 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_13 + var_207_5
					end

					if var_207_8.prefab_name ~= "" and arg_204_1.actors_[var_207_8.prefab_name] ~= nil then
						local var_207_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_8.prefab_name].transform, "story_v_side_old_114802", "114802055", "story_v_side_old_114802.awb")

						arg_204_1:RecordAudio("114802055", var_207_14)
						arg_204_1:RecordAudio("114802055", var_207_14)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802055", "story_v_side_old_114802.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802055", "story_v_side_old_114802.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_15 = math.max(var_207_6, arg_204_1.talkMaxDuration)

			if var_207_5 <= arg_204_1.time_ and arg_204_1.time_ < var_207_5 + var_207_15 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_5) / var_207_15

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_5 + var_207_15 and arg_204_1.time_ < var_207_5 + var_207_15 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play114802056 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 114802056
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play114802057(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1039ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1039ui_story == nil then
				arg_208_1.var_.characterEffect1039ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.2

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect1039ui_story and not isNil(var_211_0) then
					local var_211_4 = Mathf.Lerp(0, 0.5, var_211_3)

					arg_208_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1039ui_story.fillRatio = var_211_4
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1039ui_story then
				local var_211_5 = 0.5

				arg_208_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1039ui_story.fillRatio = var_211_5
			end

			local var_211_6 = 0
			local var_211_7 = 0.675

			if var_211_6 < arg_208_1.time_ and arg_208_1.time_ <= var_211_6 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_8 = arg_208_1:FormatText(StoryNameCfg[7].name)

				arg_208_1.leftNameTxt_.text = var_211_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_9 = arg_208_1:GetWordFromCfg(114802056)
				local var_211_10 = arg_208_1:FormatText(var_211_9.content)

				arg_208_1.text_.text = var_211_10

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_11 = 27
				local var_211_12 = utf8.len(var_211_10)
				local var_211_13 = var_211_11 <= 0 and var_211_7 or var_211_7 * (var_211_12 / var_211_11)

				if var_211_13 > 0 and var_211_7 < var_211_13 then
					arg_208_1.talkMaxDuration = var_211_13

					if var_211_13 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_13 + var_211_6
					end
				end

				arg_208_1.text_.text = var_211_10
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_14 = math.max(var_211_7, arg_208_1.talkMaxDuration)

			if var_211_6 <= arg_208_1.time_ and arg_208_1.time_ < var_211_6 + var_211_14 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_6) / var_211_14

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_6 + var_211_14 and arg_208_1.time_ < var_211_6 + var_211_14 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play114802057 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 114802057
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play114802058(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action473")
			end

			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_215_2 = 0
			local var_215_3 = 1.3

			if var_215_2 < arg_212_1.time_ and arg_212_1.time_ <= var_215_2 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_4 = arg_212_1:GetWordFromCfg(114802057)
				local var_215_5 = arg_212_1:FormatText(var_215_4.content)

				arg_212_1.text_.text = var_215_5

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_6 = 52
				local var_215_7 = utf8.len(var_215_5)
				local var_215_8 = var_215_6 <= 0 and var_215_3 or var_215_3 * (var_215_7 / var_215_6)

				if var_215_8 > 0 and var_215_3 < var_215_8 then
					arg_212_1.talkMaxDuration = var_215_8

					if var_215_8 + var_215_2 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_2
					end
				end

				arg_212_1.text_.text = var_215_5
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_9 = math.max(var_215_3, arg_212_1.talkMaxDuration)

			if var_215_2 <= arg_212_1.time_ and arg_212_1.time_ < var_215_2 + var_215_9 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_2) / var_215_9

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_2 + var_215_9 and arg_212_1.time_ < var_215_2 + var_215_9 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play114802058 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 114802058
		arg_216_1.duration_ = 11.9

		local var_216_0 = {
			ja = 11.9,
			ko = 6.466,
			zh = 4.266,
			en = 8.433
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
				arg_216_0:Play114802059(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1039ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1039ui_story == nil then
				arg_216_1.var_.characterEffect1039ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.2

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect1039ui_story and not isNil(var_219_0) then
					arg_216_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1039ui_story then
				arg_216_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_219_4 = 0

			if var_219_4 < arg_216_1.time_ and arg_216_1.time_ <= var_219_4 + arg_219_0 then
				arg_216_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			local var_219_5 = 0

			if var_219_5 < arg_216_1.time_ and arg_216_1.time_ <= var_219_5 + arg_219_0 then
				arg_216_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action435")
			end

			local var_219_6 = 0
			local var_219_7 = 0.55

			if var_219_6 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_8 = arg_216_1:FormatText(StoryNameCfg[9].name)

				arg_216_1.leftNameTxt_.text = var_219_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_9 = arg_216_1:GetWordFromCfg(114802058)
				local var_219_10 = arg_216_1:FormatText(var_219_9.content)

				arg_216_1.text_.text = var_219_10

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_11 = 22
				local var_219_12 = utf8.len(var_219_10)
				local var_219_13 = var_219_11 <= 0 and var_219_7 or var_219_7 * (var_219_12 / var_219_11)

				if var_219_13 > 0 and var_219_7 < var_219_13 then
					arg_216_1.talkMaxDuration = var_219_13

					if var_219_13 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_13 + var_219_6
					end
				end

				arg_216_1.text_.text = var_219_10
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802058", "story_v_side_old_114802.awb") ~= 0 then
					local var_219_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802058", "story_v_side_old_114802.awb") / 1000

					if var_219_14 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_14 + var_219_6
					end

					if var_219_9.prefab_name ~= "" and arg_216_1.actors_[var_219_9.prefab_name] ~= nil then
						local var_219_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_9.prefab_name].transform, "story_v_side_old_114802", "114802058", "story_v_side_old_114802.awb")

						arg_216_1:RecordAudio("114802058", var_219_15)
						arg_216_1:RecordAudio("114802058", var_219_15)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802058", "story_v_side_old_114802.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802058", "story_v_side_old_114802.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_16 = math.max(var_219_7, arg_216_1.talkMaxDuration)

			if var_219_6 <= arg_216_1.time_ and arg_216_1.time_ < var_219_6 + var_219_16 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_6) / var_219_16

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_6 + var_219_16 and arg_216_1.time_ < var_219_6 + var_219_16 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play114802059 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 114802059
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play114802060(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1039ui_story"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1039ui_story == nil then
				arg_220_1.var_.characterEffect1039ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.2

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.characterEffect1039ui_story and not isNil(var_223_0) then
					local var_223_4 = Mathf.Lerp(0, 0.5, var_223_3)

					arg_220_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1039ui_story.fillRatio = var_223_4
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1039ui_story then
				local var_223_5 = 0.5

				arg_220_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1039ui_story.fillRatio = var_223_5
			end

			local var_223_6 = 0

			if var_223_6 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_223_7 = 0
			local var_223_8 = 0.1

			if var_223_7 < arg_220_1.time_ and arg_220_1.time_ <= var_223_7 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_9 = arg_220_1:FormatText(StoryNameCfg[7].name)

				arg_220_1.leftNameTxt_.text = var_223_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_10 = arg_220_1:GetWordFromCfg(114802059)
				local var_223_11 = arg_220_1:FormatText(var_223_10.content)

				arg_220_1.text_.text = var_223_11

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_12 = 4
				local var_223_13 = utf8.len(var_223_11)
				local var_223_14 = var_223_12 <= 0 and var_223_8 or var_223_8 * (var_223_13 / var_223_12)

				if var_223_14 > 0 and var_223_8 < var_223_14 then
					arg_220_1.talkMaxDuration = var_223_14

					if var_223_14 + var_223_7 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_14 + var_223_7
					end
				end

				arg_220_1.text_.text = var_223_11
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_15 = math.max(var_223_8, arg_220_1.talkMaxDuration)

			if var_223_7 <= arg_220_1.time_ and arg_220_1.time_ < var_223_7 + var_223_15 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_7) / var_223_15

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_7 + var_223_15 and arg_220_1.time_ < var_223_7 + var_223_15 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play114802060 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 114802060
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play114802061(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0

			if var_227_0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_1")
			end

			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action453")
			end

			local var_227_2 = 0

			if var_227_2 < arg_224_1.time_ and arg_224_1.time_ <= var_227_2 + arg_227_0 then
				arg_224_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_227_3 = 0

			if var_227_3 < arg_224_1.time_ and arg_224_1.time_ <= var_227_3 + arg_227_0 then
				arg_224_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_227_4 = 0
			local var_227_5 = 0.6

			if var_227_4 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_6 = arg_224_1:GetWordFromCfg(114802060)
				local var_227_7 = arg_224_1:FormatText(var_227_6.content)

				arg_224_1.text_.text = var_227_7

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_8 = 24
				local var_227_9 = utf8.len(var_227_7)
				local var_227_10 = var_227_8 <= 0 and var_227_5 or var_227_5 * (var_227_9 / var_227_8)

				if var_227_10 > 0 and var_227_5 < var_227_10 then
					arg_224_1.talkMaxDuration = var_227_10

					if var_227_10 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_10 + var_227_4
					end
				end

				arg_224_1.text_.text = var_227_7
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_11 = math.max(var_227_5, arg_224_1.talkMaxDuration)

			if var_227_4 <= arg_224_1.time_ and arg_224_1.time_ < var_227_4 + var_227_11 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_4) / var_227_11

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_4 + var_227_11 and arg_224_1.time_ < var_227_4 + var_227_11 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play114802061 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 114802061
		arg_228_1.duration_ = 2.07

		local var_228_0 = {
			ja = 2.066,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_228_0:Play114802062(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1148ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1148ui_story == nil then
				arg_228_1.var_.characterEffect1148ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.2

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect1148ui_story and not isNil(var_231_0) then
					arg_228_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1148ui_story then
				arg_228_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_231_4 = 0

			if var_231_4 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action426")
			end

			local var_231_5 = 0

			if var_231_5 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 then
				arg_228_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_231_6 = 0

			if var_231_6 < arg_228_1.time_ and arg_228_1.time_ <= var_231_6 + arg_231_0 then
				arg_228_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_231_7 = 0
			local var_231_8 = 0.1

			if var_231_7 < arg_228_1.time_ and arg_228_1.time_ <= var_231_7 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_9 = arg_228_1:FormatText(StoryNameCfg[8].name)

				arg_228_1.leftNameTxt_.text = var_231_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_10 = arg_228_1:GetWordFromCfg(114802061)
				local var_231_11 = arg_228_1:FormatText(var_231_10.content)

				arg_228_1.text_.text = var_231_11

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_12 = 4
				local var_231_13 = utf8.len(var_231_11)
				local var_231_14 = var_231_12 <= 0 and var_231_8 or var_231_8 * (var_231_13 / var_231_12)

				if var_231_14 > 0 and var_231_8 < var_231_14 then
					arg_228_1.talkMaxDuration = var_231_14

					if var_231_14 + var_231_7 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_14 + var_231_7
					end
				end

				arg_228_1.text_.text = var_231_11
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802061", "story_v_side_old_114802.awb") ~= 0 then
					local var_231_15 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802061", "story_v_side_old_114802.awb") / 1000

					if var_231_15 + var_231_7 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_15 + var_231_7
					end

					if var_231_10.prefab_name ~= "" and arg_228_1.actors_[var_231_10.prefab_name] ~= nil then
						local var_231_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_10.prefab_name].transform, "story_v_side_old_114802", "114802061", "story_v_side_old_114802.awb")

						arg_228_1:RecordAudio("114802061", var_231_16)
						arg_228_1:RecordAudio("114802061", var_231_16)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802061", "story_v_side_old_114802.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802061", "story_v_side_old_114802.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_17 = math.max(var_231_8, arg_228_1.talkMaxDuration)

			if var_231_7 <= arg_228_1.time_ and arg_228_1.time_ < var_231_7 + var_231_17 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_7) / var_231_17

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_7 + var_231_17 and arg_228_1.time_ < var_231_7 + var_231_17 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play114802062 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 114802062
		arg_232_1.duration_ = 10.87

		local var_232_0 = {
			ja = 8.633,
			ko = 7.933,
			zh = 8.366,
			en = 10.866
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
				arg_232_0:Play114802063(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1039ui_story"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1039ui_story == nil then
				arg_232_1.var_.characterEffect1039ui_story = var_235_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.2

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.characterEffect1039ui_story and not isNil(var_235_0) then
					arg_232_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1039ui_story then
				arg_232_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_235_4 = 0

			if var_235_4 < arg_232_1.time_ and arg_232_1.time_ <= var_235_4 + arg_235_0 then
				arg_232_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action435")
			end

			local var_235_5 = arg_232_1.actors_["1148ui_story"]
			local var_235_6 = 0

			if var_235_6 < arg_232_1.time_ and arg_232_1.time_ <= var_235_6 + arg_235_0 and not isNil(var_235_5) and arg_232_1.var_.characterEffect1148ui_story == nil then
				arg_232_1.var_.characterEffect1148ui_story = var_235_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_7 = 0.2

			if var_235_6 <= arg_232_1.time_ and arg_232_1.time_ < var_235_6 + var_235_7 and not isNil(var_235_5) then
				local var_235_8 = (arg_232_1.time_ - var_235_6) / var_235_7

				if arg_232_1.var_.characterEffect1148ui_story and not isNil(var_235_5) then
					local var_235_9 = Mathf.Lerp(0, 0.5, var_235_8)

					arg_232_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1148ui_story.fillRatio = var_235_9
				end
			end

			if arg_232_1.time_ >= var_235_6 + var_235_7 and arg_232_1.time_ < var_235_6 + var_235_7 + arg_235_0 and not isNil(var_235_5) and arg_232_1.var_.characterEffect1148ui_story then
				local var_235_10 = 0.5

				arg_232_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1148ui_story.fillRatio = var_235_10
			end

			local var_235_11 = 0

			if var_235_11 < arg_232_1.time_ and arg_232_1.time_ <= var_235_11 + arg_235_0 then
				arg_232_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_235_12 = 0

			if var_235_12 < arg_232_1.time_ and arg_232_1.time_ <= var_235_12 + arg_235_0 then
				arg_232_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_235_13 = 0
			local var_235_14 = 1.05

			if var_235_13 < arg_232_1.time_ and arg_232_1.time_ <= var_235_13 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_15 = arg_232_1:FormatText(StoryNameCfg[9].name)

				arg_232_1.leftNameTxt_.text = var_235_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_16 = arg_232_1:GetWordFromCfg(114802062)
				local var_235_17 = arg_232_1:FormatText(var_235_16.content)

				arg_232_1.text_.text = var_235_17

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_18 = 42
				local var_235_19 = utf8.len(var_235_17)
				local var_235_20 = var_235_18 <= 0 and var_235_14 or var_235_14 * (var_235_19 / var_235_18)

				if var_235_20 > 0 and var_235_14 < var_235_20 then
					arg_232_1.talkMaxDuration = var_235_20

					if var_235_20 + var_235_13 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_20 + var_235_13
					end
				end

				arg_232_1.text_.text = var_235_17
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802062", "story_v_side_old_114802.awb") ~= 0 then
					local var_235_21 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802062", "story_v_side_old_114802.awb") / 1000

					if var_235_21 + var_235_13 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_21 + var_235_13
					end

					if var_235_16.prefab_name ~= "" and arg_232_1.actors_[var_235_16.prefab_name] ~= nil then
						local var_235_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_16.prefab_name].transform, "story_v_side_old_114802", "114802062", "story_v_side_old_114802.awb")

						arg_232_1:RecordAudio("114802062", var_235_22)
						arg_232_1:RecordAudio("114802062", var_235_22)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802062", "story_v_side_old_114802.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802062", "story_v_side_old_114802.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_23 = math.max(var_235_14, arg_232_1.talkMaxDuration)

			if var_235_13 <= arg_232_1.time_ and arg_232_1.time_ < var_235_13 + var_235_23 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_13) / var_235_23

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_13 + var_235_23 and arg_232_1.time_ < var_235_13 + var_235_23 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play114802063 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 114802063
		arg_236_1.duration_ = 12.9

		local var_236_0 = {
			ja = 9.8,
			ko = 9.233,
			zh = 8.966,
			en = 12.9
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
				arg_236_0:Play114802064(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1148ui_story"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1148ui_story == nil then
				arg_236_1.var_.characterEffect1148ui_story = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.2

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.characterEffect1148ui_story and not isNil(var_239_0) then
					arg_236_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1148ui_story then
				arg_236_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_239_4 = 0

			if var_239_4 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action464")
			end

			local var_239_5 = arg_236_1.actors_["1039ui_story"]
			local var_239_6 = 0

			if var_239_6 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 and not isNil(var_239_5) and arg_236_1.var_.characterEffect1039ui_story == nil then
				arg_236_1.var_.characterEffect1039ui_story = var_239_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_7 = 0.2

			if var_239_6 <= arg_236_1.time_ and arg_236_1.time_ < var_239_6 + var_239_7 and not isNil(var_239_5) then
				local var_239_8 = (arg_236_1.time_ - var_239_6) / var_239_7

				if arg_236_1.var_.characterEffect1039ui_story and not isNil(var_239_5) then
					local var_239_9 = Mathf.Lerp(0, 0.5, var_239_8)

					arg_236_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1039ui_story.fillRatio = var_239_9
				end
			end

			if arg_236_1.time_ >= var_239_6 + var_239_7 and arg_236_1.time_ < var_239_6 + var_239_7 + arg_239_0 and not isNil(var_239_5) and arg_236_1.var_.characterEffect1039ui_story then
				local var_239_10 = 0.5

				arg_236_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1039ui_story.fillRatio = var_239_10
			end

			local var_239_11 = 0

			if var_239_11 < arg_236_1.time_ and arg_236_1.time_ <= var_239_11 + arg_239_0 then
				arg_236_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_239_12 = 0

			if var_239_12 < arg_236_1.time_ and arg_236_1.time_ <= var_239_12 + arg_239_0 then
				arg_236_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_239_13 = 0
			local var_239_14 = 1.05

			if var_239_13 < arg_236_1.time_ and arg_236_1.time_ <= var_239_13 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_15 = arg_236_1:FormatText(StoryNameCfg[8].name)

				arg_236_1.leftNameTxt_.text = var_239_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_16 = arg_236_1:GetWordFromCfg(114802063)
				local var_239_17 = arg_236_1:FormatText(var_239_16.content)

				arg_236_1.text_.text = var_239_17

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_18 = 42
				local var_239_19 = utf8.len(var_239_17)
				local var_239_20 = var_239_18 <= 0 and var_239_14 or var_239_14 * (var_239_19 / var_239_18)

				if var_239_20 > 0 and var_239_14 < var_239_20 then
					arg_236_1.talkMaxDuration = var_239_20

					if var_239_20 + var_239_13 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_20 + var_239_13
					end
				end

				arg_236_1.text_.text = var_239_17
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802063", "story_v_side_old_114802.awb") ~= 0 then
					local var_239_21 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802063", "story_v_side_old_114802.awb") / 1000

					if var_239_21 + var_239_13 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_21 + var_239_13
					end

					if var_239_16.prefab_name ~= "" and arg_236_1.actors_[var_239_16.prefab_name] ~= nil then
						local var_239_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_16.prefab_name].transform, "story_v_side_old_114802", "114802063", "story_v_side_old_114802.awb")

						arg_236_1:RecordAudio("114802063", var_239_22)
						arg_236_1:RecordAudio("114802063", var_239_22)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802063", "story_v_side_old_114802.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802063", "story_v_side_old_114802.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_23 = math.max(var_239_14, arg_236_1.talkMaxDuration)

			if var_239_13 <= arg_236_1.time_ and arg_236_1.time_ < var_239_13 + var_239_23 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_13) / var_239_23

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_13 + var_239_23 and arg_236_1.time_ < var_239_13 + var_239_23 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play114802064 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 114802064
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play114802065(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_2")
			end

			local var_243_1 = arg_240_1.actors_["1148ui_story"]
			local var_243_2 = 0

			if var_243_2 < arg_240_1.time_ and arg_240_1.time_ <= var_243_2 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect1148ui_story == nil then
				arg_240_1.var_.characterEffect1148ui_story = var_243_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_3 = 0.2

			if var_243_2 <= arg_240_1.time_ and arg_240_1.time_ < var_243_2 + var_243_3 and not isNil(var_243_1) then
				local var_243_4 = (arg_240_1.time_ - var_243_2) / var_243_3

				if arg_240_1.var_.characterEffect1148ui_story and not isNil(var_243_1) then
					local var_243_5 = Mathf.Lerp(0, 0.5, var_243_4)

					arg_240_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1148ui_story.fillRatio = var_243_5
				end
			end

			if arg_240_1.time_ >= var_243_2 + var_243_3 and arg_240_1.time_ < var_243_2 + var_243_3 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect1148ui_story then
				local var_243_6 = 0.5

				arg_240_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1148ui_story.fillRatio = var_243_6
			end

			local var_243_7 = 0

			if var_243_7 < arg_240_1.time_ and arg_240_1.time_ <= var_243_7 + arg_243_0 then
				arg_240_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_243_8 = 0

			if var_243_8 < arg_240_1.time_ and arg_240_1.time_ <= var_243_8 + arg_243_0 then
				arg_240_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_243_9 = 0
			local var_243_10 = 0.7

			if var_243_9 < arg_240_1.time_ and arg_240_1.time_ <= var_243_9 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_11 = arg_240_1:GetWordFromCfg(114802064)
				local var_243_12 = arg_240_1:FormatText(var_243_11.content)

				arg_240_1.text_.text = var_243_12

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_13 = 28
				local var_243_14 = utf8.len(var_243_12)
				local var_243_15 = var_243_13 <= 0 and var_243_10 or var_243_10 * (var_243_14 / var_243_13)

				if var_243_15 > 0 and var_243_10 < var_243_15 then
					arg_240_1.talkMaxDuration = var_243_15

					if var_243_15 + var_243_9 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_15 + var_243_9
					end
				end

				arg_240_1.text_.text = var_243_12
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_16 = math.max(var_243_10, arg_240_1.talkMaxDuration)

			if var_243_9 <= arg_240_1.time_ and arg_240_1.time_ < var_243_9 + var_243_16 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_9) / var_243_16

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_9 + var_243_16 and arg_240_1.time_ < var_243_9 + var_243_16 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play114802065 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 114802065
		arg_244_1.duration_ = 12.3

		local var_244_0 = {
			ja = 12.3,
			ko = 7.633,
			zh = 10.8,
			en = 9.366
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
				arg_244_0:Play114802066(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			local var_247_1 = arg_244_1.actors_["1148ui_story"]
			local var_247_2 = 0

			if var_247_2 < arg_244_1.time_ and arg_244_1.time_ <= var_247_2 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1148ui_story == nil then
				arg_244_1.var_.characterEffect1148ui_story = var_247_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_3 = 0.2

			if var_247_2 <= arg_244_1.time_ and arg_244_1.time_ < var_247_2 + var_247_3 and not isNil(var_247_1) then
				local var_247_4 = (arg_244_1.time_ - var_247_2) / var_247_3

				if arg_244_1.var_.characterEffect1148ui_story and not isNil(var_247_1) then
					arg_244_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= var_247_2 + var_247_3 and arg_244_1.time_ < var_247_2 + var_247_3 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1148ui_story then
				arg_244_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_247_5 = 0

			if var_247_5 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 then
				arg_244_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_247_6 = 0

			if var_247_6 < arg_244_1.time_ and arg_244_1.time_ <= var_247_6 + arg_247_0 then
				arg_244_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_247_7 = 0
			local var_247_8 = 0.975

			if var_247_7 < arg_244_1.time_ and arg_244_1.time_ <= var_247_7 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_9 = arg_244_1:FormatText(StoryNameCfg[8].name)

				arg_244_1.leftNameTxt_.text = var_247_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_10 = arg_244_1:GetWordFromCfg(114802065)
				local var_247_11 = arg_244_1:FormatText(var_247_10.content)

				arg_244_1.text_.text = var_247_11

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_12 = 39
				local var_247_13 = utf8.len(var_247_11)
				local var_247_14 = var_247_12 <= 0 and var_247_8 or var_247_8 * (var_247_13 / var_247_12)

				if var_247_14 > 0 and var_247_8 < var_247_14 then
					arg_244_1.talkMaxDuration = var_247_14

					if var_247_14 + var_247_7 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_14 + var_247_7
					end
				end

				arg_244_1.text_.text = var_247_11
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802065", "story_v_side_old_114802.awb") ~= 0 then
					local var_247_15 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802065", "story_v_side_old_114802.awb") / 1000

					if var_247_15 + var_247_7 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_15 + var_247_7
					end

					if var_247_10.prefab_name ~= "" and arg_244_1.actors_[var_247_10.prefab_name] ~= nil then
						local var_247_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_10.prefab_name].transform, "story_v_side_old_114802", "114802065", "story_v_side_old_114802.awb")

						arg_244_1:RecordAudio("114802065", var_247_16)
						arg_244_1:RecordAudio("114802065", var_247_16)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802065", "story_v_side_old_114802.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802065", "story_v_side_old_114802.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_17 = math.max(var_247_8, arg_244_1.talkMaxDuration)

			if var_247_7 <= arg_244_1.time_ and arg_244_1.time_ < var_247_7 + var_247_17 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_7) / var_247_17

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_7 + var_247_17 and arg_244_1.time_ < var_247_7 + var_247_17 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play114802066 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 114802066
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play114802067(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["1148ui_story"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect1148ui_story == nil then
				arg_248_1.var_.characterEffect1148ui_story = var_251_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.2

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.characterEffect1148ui_story and not isNil(var_251_0) then
					local var_251_4 = Mathf.Lerp(0, 0.5, var_251_3)

					arg_248_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1148ui_story.fillRatio = var_251_4
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect1148ui_story then
				local var_251_5 = 0.5

				arg_248_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1148ui_story.fillRatio = var_251_5
			end

			local var_251_6 = 0

			if var_251_6 < arg_248_1.time_ and arg_248_1.time_ <= var_251_6 + arg_251_0 then
				arg_248_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_251_7 = 0

			if var_251_7 < arg_248_1.time_ and arg_248_1.time_ <= var_251_7 + arg_251_0 then
				arg_248_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_251_8 = 0
			local var_251_9 = 1.3

			if var_251_8 < arg_248_1.time_ and arg_248_1.time_ <= var_251_8 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_10 = arg_248_1:GetWordFromCfg(114802066)
				local var_251_11 = arg_248_1:FormatText(var_251_10.content)

				arg_248_1.text_.text = var_251_11

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_12 = 52
				local var_251_13 = utf8.len(var_251_11)
				local var_251_14 = var_251_12 <= 0 and var_251_9 or var_251_9 * (var_251_13 / var_251_12)

				if var_251_14 > 0 and var_251_9 < var_251_14 then
					arg_248_1.talkMaxDuration = var_251_14

					if var_251_14 + var_251_8 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_14 + var_251_8
					end
				end

				arg_248_1.text_.text = var_251_11
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_15 = math.max(var_251_9, arg_248_1.talkMaxDuration)

			if var_251_8 <= arg_248_1.time_ and arg_248_1.time_ < var_251_8 + var_251_15 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_8) / var_251_15

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_8 + var_251_15 and arg_248_1.time_ < var_251_8 + var_251_15 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play114802067 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 114802067
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play114802068(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action456")
			end

			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_255_2 = 0

			if var_255_2 < arg_252_1.time_ and arg_252_1.time_ <= var_255_2 + arg_255_0 then
				arg_252_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_255_3 = 0
			local var_255_4 = 0.55

			if var_255_3 < arg_252_1.time_ and arg_252_1.time_ <= var_255_3 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_5 = arg_252_1:GetWordFromCfg(114802067)
				local var_255_6 = arg_252_1:FormatText(var_255_5.content)

				arg_252_1.text_.text = var_255_6

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_7 = 22
				local var_255_8 = utf8.len(var_255_6)
				local var_255_9 = var_255_7 <= 0 and var_255_4 or var_255_4 * (var_255_8 / var_255_7)

				if var_255_9 > 0 and var_255_4 < var_255_9 then
					arg_252_1.talkMaxDuration = var_255_9

					if var_255_9 + var_255_3 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_9 + var_255_3
					end
				end

				arg_252_1.text_.text = var_255_6
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_10 = math.max(var_255_4, arg_252_1.talkMaxDuration)

			if var_255_3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_3 + var_255_10 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_3) / var_255_10

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_3 + var_255_10 and arg_252_1.time_ < var_255_3 + var_255_10 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play114802068 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 114802068
		arg_256_1.duration_ = 4.57

		local var_256_0 = {
			ja = 4.566,
			ko = 3.233,
			zh = 2.333,
			en = 2.9
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
				arg_256_0:Play114802069(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1039ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1039ui_story == nil then
				arg_256_1.var_.characterEffect1039ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.2

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect1039ui_story and not isNil(var_259_0) then
					arg_256_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1039ui_story then
				arg_256_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_259_4 = 0

			if var_259_4 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_259_5 = 0

			if var_259_5 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 then
				arg_256_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_259_6 = 0
			local var_259_7 = 0.275

			if var_259_6 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_8 = arg_256_1:FormatText(StoryNameCfg[9].name)

				arg_256_1.leftNameTxt_.text = var_259_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_9 = arg_256_1:GetWordFromCfg(114802068)
				local var_259_10 = arg_256_1:FormatText(var_259_9.content)

				arg_256_1.text_.text = var_259_10

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_11 = 11
				local var_259_12 = utf8.len(var_259_10)
				local var_259_13 = var_259_11 <= 0 and var_259_7 or var_259_7 * (var_259_12 / var_259_11)

				if var_259_13 > 0 and var_259_7 < var_259_13 then
					arg_256_1.talkMaxDuration = var_259_13

					if var_259_13 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_13 + var_259_6
					end
				end

				arg_256_1.text_.text = var_259_10
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802068", "story_v_side_old_114802.awb") ~= 0 then
					local var_259_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802068", "story_v_side_old_114802.awb") / 1000

					if var_259_14 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_14 + var_259_6
					end

					if var_259_9.prefab_name ~= "" and arg_256_1.actors_[var_259_9.prefab_name] ~= nil then
						local var_259_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_9.prefab_name].transform, "story_v_side_old_114802", "114802068", "story_v_side_old_114802.awb")

						arg_256_1:RecordAudio("114802068", var_259_15)
						arg_256_1:RecordAudio("114802068", var_259_15)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802068", "story_v_side_old_114802.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802068", "story_v_side_old_114802.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_16 = math.max(var_259_7, arg_256_1.talkMaxDuration)

			if var_259_6 <= arg_256_1.time_ and arg_256_1.time_ < var_259_6 + var_259_16 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_6) / var_259_16

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_6 + var_259_16 and arg_256_1.time_ < var_259_6 + var_259_16 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play114802069 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 114802069
		arg_260_1.duration_ = 6.93

		local var_260_0 = {
			ja = 6.933,
			ko = 3.4,
			zh = 4.133,
			en = 4.533
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
				arg_260_0:Play114802070(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1148ui_story"]
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1148ui_story == nil then
				arg_260_1.var_.characterEffect1148ui_story = var_263_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.2

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 and not isNil(var_263_0) then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2

				if arg_260_1.var_.characterEffect1148ui_story and not isNil(var_263_0) then
					arg_260_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1148ui_story then
				arg_260_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_263_4 = 0

			if var_263_4 < arg_260_1.time_ and arg_260_1.time_ <= var_263_4 + arg_263_0 then
				arg_260_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action467")
			end

			local var_263_5 = arg_260_1.actors_["1039ui_story"]
			local var_263_6 = 0

			if var_263_6 < arg_260_1.time_ and arg_260_1.time_ <= var_263_6 + arg_263_0 and not isNil(var_263_5) and arg_260_1.var_.characterEffect1039ui_story == nil then
				arg_260_1.var_.characterEffect1039ui_story = var_263_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_7 = 0.2

			if var_263_6 <= arg_260_1.time_ and arg_260_1.time_ < var_263_6 + var_263_7 and not isNil(var_263_5) then
				local var_263_8 = (arg_260_1.time_ - var_263_6) / var_263_7

				if arg_260_1.var_.characterEffect1039ui_story and not isNil(var_263_5) then
					local var_263_9 = Mathf.Lerp(0, 0.5, var_263_8)

					arg_260_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1039ui_story.fillRatio = var_263_9
				end
			end

			if arg_260_1.time_ >= var_263_6 + var_263_7 and arg_260_1.time_ < var_263_6 + var_263_7 + arg_263_0 and not isNil(var_263_5) and arg_260_1.var_.characterEffect1039ui_story then
				local var_263_10 = 0.5

				arg_260_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1039ui_story.fillRatio = var_263_10
			end

			local var_263_11 = 0

			if var_263_11 < arg_260_1.time_ and arg_260_1.time_ <= var_263_11 + arg_263_0 then
				arg_260_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_263_12 = 0

			if var_263_12 < arg_260_1.time_ and arg_260_1.time_ <= var_263_12 + arg_263_0 then
				arg_260_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_263_13 = 0
			local var_263_14 = 0.325

			if var_263_13 < arg_260_1.time_ and arg_260_1.time_ <= var_263_13 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_15 = arg_260_1:FormatText(StoryNameCfg[8].name)

				arg_260_1.leftNameTxt_.text = var_263_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_16 = arg_260_1:GetWordFromCfg(114802069)
				local var_263_17 = arg_260_1:FormatText(var_263_16.content)

				arg_260_1.text_.text = var_263_17

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_18 = 13
				local var_263_19 = utf8.len(var_263_17)
				local var_263_20 = var_263_18 <= 0 and var_263_14 or var_263_14 * (var_263_19 / var_263_18)

				if var_263_20 > 0 and var_263_14 < var_263_20 then
					arg_260_1.talkMaxDuration = var_263_20

					if var_263_20 + var_263_13 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_20 + var_263_13
					end
				end

				arg_260_1.text_.text = var_263_17
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802069", "story_v_side_old_114802.awb") ~= 0 then
					local var_263_21 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802069", "story_v_side_old_114802.awb") / 1000

					if var_263_21 + var_263_13 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_21 + var_263_13
					end

					if var_263_16.prefab_name ~= "" and arg_260_1.actors_[var_263_16.prefab_name] ~= nil then
						local var_263_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_16.prefab_name].transform, "story_v_side_old_114802", "114802069", "story_v_side_old_114802.awb")

						arg_260_1:RecordAudio("114802069", var_263_22)
						arg_260_1:RecordAudio("114802069", var_263_22)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802069", "story_v_side_old_114802.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802069", "story_v_side_old_114802.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_23 = math.max(var_263_14, arg_260_1.talkMaxDuration)

			if var_263_13 <= arg_260_1.time_ and arg_260_1.time_ < var_263_13 + var_263_23 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_13) / var_263_23

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_13 + var_263_23 and arg_260_1.time_ < var_263_13 + var_263_23 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play114802070 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 114802070
		arg_264_1.duration_ = 11.6

		local var_264_0 = {
			ja = 11.5,
			ko = 11.6,
			zh = 10.3,
			en = 10.266
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
				arg_264_0:Play114802071(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1039ui_story"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1039ui_story == nil then
				arg_264_1.var_.characterEffect1039ui_story = var_267_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.2

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.characterEffect1039ui_story and not isNil(var_267_0) then
					arg_264_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1039ui_story then
				arg_264_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_267_4 = 0

			if var_267_4 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action464")
			end

			local var_267_5 = arg_264_1.actors_["1148ui_story"]
			local var_267_6 = 0

			if var_267_6 < arg_264_1.time_ and arg_264_1.time_ <= var_267_6 + arg_267_0 and not isNil(var_267_5) and arg_264_1.var_.characterEffect1148ui_story == nil then
				arg_264_1.var_.characterEffect1148ui_story = var_267_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_7 = 0.2

			if var_267_6 <= arg_264_1.time_ and arg_264_1.time_ < var_267_6 + var_267_7 and not isNil(var_267_5) then
				local var_267_8 = (arg_264_1.time_ - var_267_6) / var_267_7

				if arg_264_1.var_.characterEffect1148ui_story and not isNil(var_267_5) then
					local var_267_9 = Mathf.Lerp(0, 0.5, var_267_8)

					arg_264_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1148ui_story.fillRatio = var_267_9
				end
			end

			if arg_264_1.time_ >= var_267_6 + var_267_7 and arg_264_1.time_ < var_267_6 + var_267_7 + arg_267_0 and not isNil(var_267_5) and arg_264_1.var_.characterEffect1148ui_story then
				local var_267_10 = 0.5

				arg_264_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1148ui_story.fillRatio = var_267_10
			end

			local var_267_11 = 0

			if var_267_11 < arg_264_1.time_ and arg_264_1.time_ <= var_267_11 + arg_267_0 then
				arg_264_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_267_12 = 0

			if var_267_12 < arg_264_1.time_ and arg_264_1.time_ <= var_267_12 + arg_267_0 then
				arg_264_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_267_13 = 0
			local var_267_14 = 1.3

			if var_267_13 < arg_264_1.time_ and arg_264_1.time_ <= var_267_13 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_15 = arg_264_1:FormatText(StoryNameCfg[9].name)

				arg_264_1.leftNameTxt_.text = var_267_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_16 = arg_264_1:GetWordFromCfg(114802070)
				local var_267_17 = arg_264_1:FormatText(var_267_16.content)

				arg_264_1.text_.text = var_267_17

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_18 = 52
				local var_267_19 = utf8.len(var_267_17)
				local var_267_20 = var_267_18 <= 0 and var_267_14 or var_267_14 * (var_267_19 / var_267_18)

				if var_267_20 > 0 and var_267_14 < var_267_20 then
					arg_264_1.talkMaxDuration = var_267_20

					if var_267_20 + var_267_13 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_20 + var_267_13
					end
				end

				arg_264_1.text_.text = var_267_17
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802070", "story_v_side_old_114802.awb") ~= 0 then
					local var_267_21 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802070", "story_v_side_old_114802.awb") / 1000

					if var_267_21 + var_267_13 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_21 + var_267_13
					end

					if var_267_16.prefab_name ~= "" and arg_264_1.actors_[var_267_16.prefab_name] ~= nil then
						local var_267_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_16.prefab_name].transform, "story_v_side_old_114802", "114802070", "story_v_side_old_114802.awb")

						arg_264_1:RecordAudio("114802070", var_267_22)
						arg_264_1:RecordAudio("114802070", var_267_22)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802070", "story_v_side_old_114802.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802070", "story_v_side_old_114802.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_23 = math.max(var_267_14, arg_264_1.talkMaxDuration)

			if var_267_13 <= arg_264_1.time_ and arg_264_1.time_ < var_267_13 + var_267_23 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_13) / var_267_23

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_13 + var_267_23 and arg_264_1.time_ < var_267_13 + var_267_23 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play114802071 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 114802071
		arg_268_1.duration_ = 13.37

		local var_268_0 = {
			ja = 7.133,
			ko = 13.366,
			zh = 10.733,
			en = 13.166
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
				arg_268_0:Play114802072(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action472")
			end

			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_271_2 = 0

			if var_271_2 < arg_268_1.time_ and arg_268_1.time_ <= var_271_2 + arg_271_0 then
				arg_268_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_271_3 = 0
			local var_271_4 = 1.35

			if var_271_3 < arg_268_1.time_ and arg_268_1.time_ <= var_271_3 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_5 = arg_268_1:FormatText(StoryNameCfg[9].name)

				arg_268_1.leftNameTxt_.text = var_271_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_6 = arg_268_1:GetWordFromCfg(114802071)
				local var_271_7 = arg_268_1:FormatText(var_271_6.content)

				arg_268_1.text_.text = var_271_7

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_8 = 54
				local var_271_9 = utf8.len(var_271_7)
				local var_271_10 = var_271_8 <= 0 and var_271_4 or var_271_4 * (var_271_9 / var_271_8)

				if var_271_10 > 0 and var_271_4 < var_271_10 then
					arg_268_1.talkMaxDuration = var_271_10

					if var_271_10 + var_271_3 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_10 + var_271_3
					end
				end

				arg_268_1.text_.text = var_271_7
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802071", "story_v_side_old_114802.awb") ~= 0 then
					local var_271_11 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802071", "story_v_side_old_114802.awb") / 1000

					if var_271_11 + var_271_3 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_11 + var_271_3
					end

					if var_271_6.prefab_name ~= "" and arg_268_1.actors_[var_271_6.prefab_name] ~= nil then
						local var_271_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_6.prefab_name].transform, "story_v_side_old_114802", "114802071", "story_v_side_old_114802.awb")

						arg_268_1:RecordAudio("114802071", var_271_12)
						arg_268_1:RecordAudio("114802071", var_271_12)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802071", "story_v_side_old_114802.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802071", "story_v_side_old_114802.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_13 = math.max(var_271_4, arg_268_1.talkMaxDuration)

			if var_271_3 <= arg_268_1.time_ and arg_268_1.time_ < var_271_3 + var_271_13 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_3) / var_271_13

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_3 + var_271_13 and arg_268_1.time_ < var_271_3 + var_271_13 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play114802072 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 114802072
		arg_272_1.duration_ = 8.83

		local var_272_0 = {
			ja = 8.833,
			ko = 5.533,
			zh = 4.2,
			en = 5.033
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play114802073(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action445")
			end

			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_275_2 = 0

			if var_275_2 < arg_272_1.time_ and arg_272_1.time_ <= var_275_2 + arg_275_0 then
				arg_272_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_275_3 = 0
			local var_275_4 = 0.525

			if var_275_3 < arg_272_1.time_ and arg_272_1.time_ <= var_275_3 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_5 = arg_272_1:FormatText(StoryNameCfg[9].name)

				arg_272_1.leftNameTxt_.text = var_275_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_6 = arg_272_1:GetWordFromCfg(114802072)
				local var_275_7 = arg_272_1:FormatText(var_275_6.content)

				arg_272_1.text_.text = var_275_7

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_8 = 25
				local var_275_9 = utf8.len(var_275_7)
				local var_275_10 = var_275_8 <= 0 and var_275_4 or var_275_4 * (var_275_9 / var_275_8)

				if var_275_10 > 0 and var_275_4 < var_275_10 then
					arg_272_1.talkMaxDuration = var_275_10

					if var_275_10 + var_275_3 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_10 + var_275_3
					end
				end

				arg_272_1.text_.text = var_275_7
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802072", "story_v_side_old_114802.awb") ~= 0 then
					local var_275_11 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802072", "story_v_side_old_114802.awb") / 1000

					if var_275_11 + var_275_3 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_11 + var_275_3
					end

					if var_275_6.prefab_name ~= "" and arg_272_1.actors_[var_275_6.prefab_name] ~= nil then
						local var_275_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_6.prefab_name].transform, "story_v_side_old_114802", "114802072", "story_v_side_old_114802.awb")

						arg_272_1:RecordAudio("114802072", var_275_12)
						arg_272_1:RecordAudio("114802072", var_275_12)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802072", "story_v_side_old_114802.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802072", "story_v_side_old_114802.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_13 = math.max(var_275_4, arg_272_1.talkMaxDuration)

			if var_275_3 <= arg_272_1.time_ and arg_272_1.time_ < var_275_3 + var_275_13 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_3) / var_275_13

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_3 + var_275_13 and arg_272_1.time_ < var_275_3 + var_275_13 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play114802073 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 114802073
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play114802074(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action427")
			end

			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_279_2 = 0

			if var_279_2 < arg_276_1.time_ and arg_276_1.time_ <= var_279_2 + arg_279_0 then
				arg_276_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_279_3 = arg_276_1.actors_["1039ui_story"]
			local var_279_4 = 0

			if var_279_4 < arg_276_1.time_ and arg_276_1.time_ <= var_279_4 + arg_279_0 and not isNil(var_279_3) and arg_276_1.var_.characterEffect1039ui_story == nil then
				arg_276_1.var_.characterEffect1039ui_story = var_279_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_5 = 0.2

			if var_279_4 <= arg_276_1.time_ and arg_276_1.time_ < var_279_4 + var_279_5 and not isNil(var_279_3) then
				local var_279_6 = (arg_276_1.time_ - var_279_4) / var_279_5

				if arg_276_1.var_.characterEffect1039ui_story and not isNil(var_279_3) then
					local var_279_7 = Mathf.Lerp(0, 0.5, var_279_6)

					arg_276_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1039ui_story.fillRatio = var_279_7
				end
			end

			if arg_276_1.time_ >= var_279_4 + var_279_5 and arg_276_1.time_ < var_279_4 + var_279_5 + arg_279_0 and not isNil(var_279_3) and arg_276_1.var_.characterEffect1039ui_story then
				local var_279_8 = 0.5

				arg_276_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1039ui_story.fillRatio = var_279_8
			end

			local var_279_9 = 0
			local var_279_10 = 1.025

			if var_279_9 < arg_276_1.time_ and arg_276_1.time_ <= var_279_9 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_11 = arg_276_1:GetWordFromCfg(114802073)
				local var_279_12 = arg_276_1:FormatText(var_279_11.content)

				arg_276_1.text_.text = var_279_12

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_13 = 41
				local var_279_14 = utf8.len(var_279_12)
				local var_279_15 = var_279_13 <= 0 and var_279_10 or var_279_10 * (var_279_14 / var_279_13)

				if var_279_15 > 0 and var_279_10 < var_279_15 then
					arg_276_1.talkMaxDuration = var_279_15

					if var_279_15 + var_279_9 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_15 + var_279_9
					end
				end

				arg_276_1.text_.text = var_279_12
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_16 = math.max(var_279_10, arg_276_1.talkMaxDuration)

			if var_279_9 <= arg_276_1.time_ and arg_276_1.time_ < var_279_9 + var_279_16 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_9) / var_279_16

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_9 + var_279_16 and arg_276_1.time_ < var_279_9 + var_279_16 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play114802074 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 114802074
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play114802075(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action472")
			end

			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action453")
			end

			local var_283_2 = 0

			if var_283_2 < arg_280_1.time_ and arg_280_1.time_ <= var_283_2 + arg_283_0 then
				arg_280_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_283_3 = 0

			if var_283_3 < arg_280_1.time_ and arg_280_1.time_ <= var_283_3 + arg_283_0 then
				arg_280_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_283_4 = 0
			local var_283_5 = 0.3

			if var_283_4 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_6 = arg_280_1:FormatText(StoryNameCfg[7].name)

				arg_280_1.leftNameTxt_.text = var_283_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_7 = arg_280_1:GetWordFromCfg(114802074)
				local var_283_8 = arg_280_1:FormatText(var_283_7.content)

				arg_280_1.text_.text = var_283_8

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_9 = 12
				local var_283_10 = utf8.len(var_283_8)
				local var_283_11 = var_283_9 <= 0 and var_283_5 or var_283_5 * (var_283_10 / var_283_9)

				if var_283_11 > 0 and var_283_5 < var_283_11 then
					arg_280_1.talkMaxDuration = var_283_11

					if var_283_11 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_11 + var_283_4
					end
				end

				arg_280_1.text_.text = var_283_8
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_12 = math.max(var_283_5, arg_280_1.talkMaxDuration)

			if var_283_4 <= arg_280_1.time_ and arg_280_1.time_ < var_283_4 + var_283_12 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_4) / var_283_12

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_4 + var_283_12 and arg_280_1.time_ < var_283_4 + var_283_12 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play114802075 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 114802075
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play114802076(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action436")
			end

			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_287_2 = 0

			if var_287_2 < arg_284_1.time_ and arg_284_1.time_ <= var_287_2 + arg_287_0 then
				arg_284_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_287_3 = 0
			local var_287_4 = 0.75

			if var_287_3 < arg_284_1.time_ and arg_284_1.time_ <= var_287_3 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_5 = arg_284_1:GetWordFromCfg(114802075)
				local var_287_6 = arg_284_1:FormatText(var_287_5.content)

				arg_284_1.text_.text = var_287_6

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_7 = 30
				local var_287_8 = utf8.len(var_287_6)
				local var_287_9 = var_287_7 <= 0 and var_287_4 or var_287_4 * (var_287_8 / var_287_7)

				if var_287_9 > 0 and var_287_4 < var_287_9 then
					arg_284_1.talkMaxDuration = var_287_9

					if var_287_9 + var_287_3 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_9 + var_287_3
					end
				end

				arg_284_1.text_.text = var_287_6
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_10 = math.max(var_287_4, arg_284_1.talkMaxDuration)

			if var_287_3 <= arg_284_1.time_ and arg_284_1.time_ < var_287_3 + var_287_10 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_3) / var_287_10

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_3 + var_287_10 and arg_284_1.time_ < var_287_3 + var_287_10 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play114802076 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 114802076
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play114802077(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0

			if var_291_0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_0 + arg_291_0 then
				arg_288_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action427")
			end

			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_291_2 = 0

			if var_291_2 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				arg_288_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_291_3 = 0
			local var_291_4 = 0.175

			if var_291_3 < arg_288_1.time_ and arg_288_1.time_ <= var_291_3 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_5 = arg_288_1:FormatText(StoryNameCfg[7].name)

				arg_288_1.leftNameTxt_.text = var_291_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_6 = arg_288_1:GetWordFromCfg(114802076)
				local var_291_7 = arg_288_1:FormatText(var_291_6.content)

				arg_288_1.text_.text = var_291_7

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_8 = 7
				local var_291_9 = utf8.len(var_291_7)
				local var_291_10 = var_291_8 <= 0 and var_291_4 or var_291_4 * (var_291_9 / var_291_8)

				if var_291_10 > 0 and var_291_4 < var_291_10 then
					arg_288_1.talkMaxDuration = var_291_10

					if var_291_10 + var_291_3 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_10 + var_291_3
					end
				end

				arg_288_1.text_.text = var_291_7
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_11 = math.max(var_291_4, arg_288_1.talkMaxDuration)

			if var_291_3 <= arg_288_1.time_ and arg_288_1.time_ < var_291_3 + var_291_11 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_3) / var_291_11

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_3 + var_291_11 and arg_288_1.time_ < var_291_3 + var_291_11 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play114802077 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 114802077
		arg_292_1.duration_ = 9.77

		local var_292_0 = {
			ja = 9.766,
			ko = 6.333,
			zh = 5.033,
			en = 9.766
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
				arg_292_0:Play114802078(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1039ui_story"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1039ui_story == nil then
				arg_292_1.var_.characterEffect1039ui_story = var_295_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.2

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.characterEffect1039ui_story and not isNil(var_295_0) then
					arg_292_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1039ui_story then
				arg_292_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_295_4 = 0

			if var_295_4 < arg_292_1.time_ and arg_292_1.time_ <= var_295_4 + arg_295_0 then
				arg_292_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action464")
			end

			local var_295_5 = 0

			if var_295_5 < arg_292_1.time_ and arg_292_1.time_ <= var_295_5 + arg_295_0 then
				arg_292_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_295_6 = 0

			if var_295_6 < arg_292_1.time_ and arg_292_1.time_ <= var_295_6 + arg_295_0 then
				arg_292_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_295_7 = 0

			if var_295_7 < arg_292_1.time_ and arg_292_1.time_ <= var_295_7 + arg_295_0 then
				arg_292_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_295_8 = 0
			local var_295_9 = 0.675

			if var_295_8 < arg_292_1.time_ and arg_292_1.time_ <= var_295_8 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_10 = arg_292_1:FormatText(StoryNameCfg[9].name)

				arg_292_1.leftNameTxt_.text = var_295_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_11 = arg_292_1:GetWordFromCfg(114802077)
				local var_295_12 = arg_292_1:FormatText(var_295_11.content)

				arg_292_1.text_.text = var_295_12

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_13 = 27
				local var_295_14 = utf8.len(var_295_12)
				local var_295_15 = var_295_13 <= 0 and var_295_9 or var_295_9 * (var_295_14 / var_295_13)

				if var_295_15 > 0 and var_295_9 < var_295_15 then
					arg_292_1.talkMaxDuration = var_295_15

					if var_295_15 + var_295_8 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_15 + var_295_8
					end
				end

				arg_292_1.text_.text = var_295_12
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802077", "story_v_side_old_114802.awb") ~= 0 then
					local var_295_16 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802077", "story_v_side_old_114802.awb") / 1000

					if var_295_16 + var_295_8 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_16 + var_295_8
					end

					if var_295_11.prefab_name ~= "" and arg_292_1.actors_[var_295_11.prefab_name] ~= nil then
						local var_295_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_11.prefab_name].transform, "story_v_side_old_114802", "114802077", "story_v_side_old_114802.awb")

						arg_292_1:RecordAudio("114802077", var_295_17)
						arg_292_1:RecordAudio("114802077", var_295_17)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802077", "story_v_side_old_114802.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802077", "story_v_side_old_114802.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_18 = math.max(var_295_9, arg_292_1.talkMaxDuration)

			if var_295_8 <= arg_292_1.time_ and arg_292_1.time_ < var_295_8 + var_295_18 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_8) / var_295_18

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_8 + var_295_18 and arg_292_1.time_ < var_295_8 + var_295_18 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play114802078 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 114802078
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play114802079(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action446")
			end

			local var_299_1 = arg_296_1.actors_["1039ui_story"]
			local var_299_2 = 0

			if var_299_2 < arg_296_1.time_ and arg_296_1.time_ <= var_299_2 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1039ui_story == nil then
				arg_296_1.var_.characterEffect1039ui_story = var_299_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_3 = 0.2

			if var_299_2 <= arg_296_1.time_ and arg_296_1.time_ < var_299_2 + var_299_3 and not isNil(var_299_1) then
				local var_299_4 = (arg_296_1.time_ - var_299_2) / var_299_3

				if arg_296_1.var_.characterEffect1039ui_story and not isNil(var_299_1) then
					local var_299_5 = Mathf.Lerp(0, 0.5, var_299_4)

					arg_296_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1039ui_story.fillRatio = var_299_5
				end
			end

			if arg_296_1.time_ >= var_299_2 + var_299_3 and arg_296_1.time_ < var_299_2 + var_299_3 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1039ui_story then
				local var_299_6 = 0.5

				arg_296_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1039ui_story.fillRatio = var_299_6
			end

			local var_299_7 = 0

			if var_299_7 < arg_296_1.time_ and arg_296_1.time_ <= var_299_7 + arg_299_0 then
				arg_296_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_299_8 = 0

			if var_299_8 < arg_296_1.time_ and arg_296_1.time_ <= var_299_8 + arg_299_0 then
				arg_296_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_299_9 = 0
			local var_299_10 = 0.375

			if var_299_9 < arg_296_1.time_ and arg_296_1.time_ <= var_299_9 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_11 = arg_296_1:FormatText(StoryNameCfg[7].name)

				arg_296_1.leftNameTxt_.text = var_299_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_12 = arg_296_1:GetWordFromCfg(114802078)
				local var_299_13 = arg_296_1:FormatText(var_299_12.content)

				arg_296_1.text_.text = var_299_13

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_14 = 15
				local var_299_15 = utf8.len(var_299_13)
				local var_299_16 = var_299_14 <= 0 and var_299_10 or var_299_10 * (var_299_15 / var_299_14)

				if var_299_16 > 0 and var_299_10 < var_299_16 then
					arg_296_1.talkMaxDuration = var_299_16

					if var_299_16 + var_299_9 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_16 + var_299_9
					end
				end

				arg_296_1.text_.text = var_299_13
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_17 = math.max(var_299_10, arg_296_1.talkMaxDuration)

			if var_299_9 <= arg_296_1.time_ and arg_296_1.time_ < var_299_9 + var_299_17 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_9) / var_299_17

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_9 + var_299_17 and arg_296_1.time_ < var_299_9 + var_299_17 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play114802079 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 114802079
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play114802080(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_303_2 = 0
			local var_303_3 = 0.725

			if var_303_2 < arg_300_1.time_ and arg_300_1.time_ <= var_303_2 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_4 = arg_300_1:GetWordFromCfg(114802079)
				local var_303_5 = arg_300_1:FormatText(var_303_4.content)

				arg_300_1.text_.text = var_303_5

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_6 = 29
				local var_303_7 = utf8.len(var_303_5)
				local var_303_8 = var_303_6 <= 0 and var_303_3 or var_303_3 * (var_303_7 / var_303_6)

				if var_303_8 > 0 and var_303_3 < var_303_8 then
					arg_300_1.talkMaxDuration = var_303_8

					if var_303_8 + var_303_2 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_8 + var_303_2
					end
				end

				arg_300_1.text_.text = var_303_5
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_9 = math.max(var_303_3, arg_300_1.talkMaxDuration)

			if var_303_2 <= arg_300_1.time_ and arg_300_1.time_ < var_303_2 + var_303_9 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_2) / var_303_9

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_2 + var_303_9 and arg_300_1.time_ < var_303_2 + var_303_9 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play114802080 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 114802080
		arg_304_1.duration_ = 10.2

		local var_304_0 = {
			ja = 7.4,
			ko = 6.933,
			zh = 5.3,
			en = 10.2
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
				arg_304_0:Play114802081(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1039ui_story"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1039ui_story == nil then
				arg_304_1.var_.characterEffect1039ui_story = var_307_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.2

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.characterEffect1039ui_story and not isNil(var_307_0) then
					arg_304_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1039ui_story then
				arg_304_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_307_4 = 0

			if var_307_4 < arg_304_1.time_ and arg_304_1.time_ <= var_307_4 + arg_307_0 then
				arg_304_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action464")
			end

			local var_307_5 = 0

			if var_307_5 < arg_304_1.time_ and arg_304_1.time_ <= var_307_5 + arg_307_0 then
				arg_304_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_307_6 = 0

			if var_307_6 < arg_304_1.time_ and arg_304_1.time_ <= var_307_6 + arg_307_0 then
				arg_304_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_307_7 = 0
			local var_307_8 = 0.675

			if var_307_7 < arg_304_1.time_ and arg_304_1.time_ <= var_307_7 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_9 = arg_304_1:FormatText(StoryNameCfg[9].name)

				arg_304_1.leftNameTxt_.text = var_307_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_10 = arg_304_1:GetWordFromCfg(114802080)
				local var_307_11 = arg_304_1:FormatText(var_307_10.content)

				arg_304_1.text_.text = var_307_11

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_12 = 27
				local var_307_13 = utf8.len(var_307_11)
				local var_307_14 = var_307_12 <= 0 and var_307_8 or var_307_8 * (var_307_13 / var_307_12)

				if var_307_14 > 0 and var_307_8 < var_307_14 then
					arg_304_1.talkMaxDuration = var_307_14

					if var_307_14 + var_307_7 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_14 + var_307_7
					end
				end

				arg_304_1.text_.text = var_307_11
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802080", "story_v_side_old_114802.awb") ~= 0 then
					local var_307_15 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802080", "story_v_side_old_114802.awb") / 1000

					if var_307_15 + var_307_7 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_15 + var_307_7
					end

					if var_307_10.prefab_name ~= "" and arg_304_1.actors_[var_307_10.prefab_name] ~= nil then
						local var_307_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_10.prefab_name].transform, "story_v_side_old_114802", "114802080", "story_v_side_old_114802.awb")

						arg_304_1:RecordAudio("114802080", var_307_16)
						arg_304_1:RecordAudio("114802080", var_307_16)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802080", "story_v_side_old_114802.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802080", "story_v_side_old_114802.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_17 = math.max(var_307_8, arg_304_1.talkMaxDuration)

			if var_307_7 <= arg_304_1.time_ and arg_304_1.time_ < var_307_7 + var_307_17 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_7) / var_307_17

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_7 + var_307_17 and arg_304_1.time_ < var_307_7 + var_307_17 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play114802081 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 114802081
		arg_308_1.duration_ = 3.13

		local var_308_0 = {
			ja = 3.133,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_308_0:Play114802082(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_1")
			end

			local var_311_1 = arg_308_1.actors_["1148ui_story"]
			local var_311_2 = 0

			if var_311_2 < arg_308_1.time_ and arg_308_1.time_ <= var_311_2 + arg_311_0 and not isNil(var_311_1) and arg_308_1.var_.characterEffect1148ui_story == nil then
				arg_308_1.var_.characterEffect1148ui_story = var_311_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_3 = 0.2

			if var_311_2 <= arg_308_1.time_ and arg_308_1.time_ < var_311_2 + var_311_3 and not isNil(var_311_1) then
				local var_311_4 = (arg_308_1.time_ - var_311_2) / var_311_3

				if arg_308_1.var_.characterEffect1148ui_story and not isNil(var_311_1) then
					arg_308_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= var_311_2 + var_311_3 and arg_308_1.time_ < var_311_2 + var_311_3 + arg_311_0 and not isNil(var_311_1) and arg_308_1.var_.characterEffect1148ui_story then
				arg_308_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_311_5 = arg_308_1.actors_["1039ui_story"]
			local var_311_6 = 0

			if var_311_6 < arg_308_1.time_ and arg_308_1.time_ <= var_311_6 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.characterEffect1039ui_story == nil then
				arg_308_1.var_.characterEffect1039ui_story = var_311_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_7 = 0.2

			if var_311_6 <= arg_308_1.time_ and arg_308_1.time_ < var_311_6 + var_311_7 and not isNil(var_311_5) then
				local var_311_8 = (arg_308_1.time_ - var_311_6) / var_311_7

				if arg_308_1.var_.characterEffect1039ui_story and not isNil(var_311_5) then
					local var_311_9 = Mathf.Lerp(0, 0.5, var_311_8)

					arg_308_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1039ui_story.fillRatio = var_311_9
				end
			end

			if arg_308_1.time_ >= var_311_6 + var_311_7 and arg_308_1.time_ < var_311_6 + var_311_7 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.characterEffect1039ui_story then
				local var_311_10 = 0.5

				arg_308_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1039ui_story.fillRatio = var_311_10
			end

			local var_311_11 = 0

			if var_311_11 < arg_308_1.time_ and arg_308_1.time_ <= var_311_11 + arg_311_0 then
				arg_308_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_311_12 = 0

			if var_311_12 < arg_308_1.time_ and arg_308_1.time_ <= var_311_12 + arg_311_0 then
				arg_308_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_311_13 = 0
			local var_311_14 = 0.05

			if var_311_13 < arg_308_1.time_ and arg_308_1.time_ <= var_311_13 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_15 = arg_308_1:FormatText(StoryNameCfg[8].name)

				arg_308_1.leftNameTxt_.text = var_311_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_16 = arg_308_1:GetWordFromCfg(114802081)
				local var_311_17 = arg_308_1:FormatText(var_311_16.content)

				arg_308_1.text_.text = var_311_17

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_18 = 2
				local var_311_19 = utf8.len(var_311_17)
				local var_311_20 = var_311_18 <= 0 and var_311_14 or var_311_14 * (var_311_19 / var_311_18)

				if var_311_20 > 0 and var_311_14 < var_311_20 then
					arg_308_1.talkMaxDuration = var_311_20

					if var_311_20 + var_311_13 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_20 + var_311_13
					end
				end

				arg_308_1.text_.text = var_311_17
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802081", "story_v_side_old_114802.awb") ~= 0 then
					local var_311_21 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802081", "story_v_side_old_114802.awb") / 1000

					if var_311_21 + var_311_13 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_21 + var_311_13
					end

					if var_311_16.prefab_name ~= "" and arg_308_1.actors_[var_311_16.prefab_name] ~= nil then
						local var_311_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_16.prefab_name].transform, "story_v_side_old_114802", "114802081", "story_v_side_old_114802.awb")

						arg_308_1:RecordAudio("114802081", var_311_22)
						arg_308_1:RecordAudio("114802081", var_311_22)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802081", "story_v_side_old_114802.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802081", "story_v_side_old_114802.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_23 = math.max(var_311_14, arg_308_1.talkMaxDuration)

			if var_311_13 <= arg_308_1.time_ and arg_308_1.time_ < var_311_13 + var_311_23 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_13) / var_311_23

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_13 + var_311_23 and arg_308_1.time_ < var_311_13 + var_311_23 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play114802082 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 114802082
		arg_312_1.duration_ = 8.07

		local var_312_0 = {
			ja = 8.066,
			ko = 3.4,
			zh = 3.566,
			en = 3.7
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play114802083(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1039ui_story"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.characterEffect1039ui_story == nil then
				arg_312_1.var_.characterEffect1039ui_story = var_315_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.2

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.characterEffect1039ui_story and not isNil(var_315_0) then
					arg_312_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.characterEffect1039ui_story then
				arg_312_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_315_4 = 0

			if var_315_4 < arg_312_1.time_ and arg_312_1.time_ <= var_315_4 + arg_315_0 then
				arg_312_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action446")
			end

			local var_315_5 = 0

			if var_315_5 < arg_312_1.time_ and arg_312_1.time_ <= var_315_5 + arg_315_0 then
				arg_312_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_315_6 = arg_312_1.actors_["1148ui_story"]
			local var_315_7 = 0

			if var_315_7 < arg_312_1.time_ and arg_312_1.time_ <= var_315_7 + arg_315_0 and not isNil(var_315_6) and arg_312_1.var_.characterEffect1148ui_story == nil then
				arg_312_1.var_.characterEffect1148ui_story = var_315_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_8 = 0.2

			if var_315_7 <= arg_312_1.time_ and arg_312_1.time_ < var_315_7 + var_315_8 and not isNil(var_315_6) then
				local var_315_9 = (arg_312_1.time_ - var_315_7) / var_315_8

				if arg_312_1.var_.characterEffect1148ui_story and not isNil(var_315_6) then
					local var_315_10 = Mathf.Lerp(0, 0.5, var_315_9)

					arg_312_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1148ui_story.fillRatio = var_315_10
				end
			end

			if arg_312_1.time_ >= var_315_7 + var_315_8 and arg_312_1.time_ < var_315_7 + var_315_8 + arg_315_0 and not isNil(var_315_6) and arg_312_1.var_.characterEffect1148ui_story then
				local var_315_11 = 0.5

				arg_312_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1148ui_story.fillRatio = var_315_11
			end

			local var_315_12 = 0

			if var_315_12 < arg_312_1.time_ and arg_312_1.time_ <= var_315_12 + arg_315_0 then
				arg_312_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_315_13 = 0
			local var_315_14 = 0.35

			if var_315_13 < arg_312_1.time_ and arg_312_1.time_ <= var_315_13 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_15 = arg_312_1:FormatText(StoryNameCfg[9].name)

				arg_312_1.leftNameTxt_.text = var_315_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_16 = arg_312_1:GetWordFromCfg(114802082)
				local var_315_17 = arg_312_1:FormatText(var_315_16.content)

				arg_312_1.text_.text = var_315_17

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_18 = 14
				local var_315_19 = utf8.len(var_315_17)
				local var_315_20 = var_315_18 <= 0 and var_315_14 or var_315_14 * (var_315_19 / var_315_18)

				if var_315_20 > 0 and var_315_14 < var_315_20 then
					arg_312_1.talkMaxDuration = var_315_20

					if var_315_20 + var_315_13 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_20 + var_315_13
					end
				end

				arg_312_1.text_.text = var_315_17
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802082", "story_v_side_old_114802.awb") ~= 0 then
					local var_315_21 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802082", "story_v_side_old_114802.awb") / 1000

					if var_315_21 + var_315_13 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_21 + var_315_13
					end

					if var_315_16.prefab_name ~= "" and arg_312_1.actors_[var_315_16.prefab_name] ~= nil then
						local var_315_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_16.prefab_name].transform, "story_v_side_old_114802", "114802082", "story_v_side_old_114802.awb")

						arg_312_1:RecordAudio("114802082", var_315_22)
						arg_312_1:RecordAudio("114802082", var_315_22)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802082", "story_v_side_old_114802.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802082", "story_v_side_old_114802.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_23 = math.max(var_315_14, arg_312_1.talkMaxDuration)

			if var_315_13 <= arg_312_1.time_ and arg_312_1.time_ < var_315_13 + var_315_23 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_13) / var_315_23

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_13 + var_315_23 and arg_312_1.time_ < var_315_13 + var_315_23 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play114802083 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 114802083
		arg_316_1.duration_ = 2.33

		local var_316_0 = {
			ja = 2.333,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play114802084(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action427")
			end

			local var_319_1 = arg_316_1.actors_["1148ui_story"]
			local var_319_2 = 0

			if var_319_2 < arg_316_1.time_ and arg_316_1.time_ <= var_319_2 + arg_319_0 and not isNil(var_319_1) and arg_316_1.var_.characterEffect1148ui_story == nil then
				arg_316_1.var_.characterEffect1148ui_story = var_319_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_3 = 0.2

			if var_319_2 <= arg_316_1.time_ and arg_316_1.time_ < var_319_2 + var_319_3 and not isNil(var_319_1) then
				local var_319_4 = (arg_316_1.time_ - var_319_2) / var_319_3

				if arg_316_1.var_.characterEffect1148ui_story and not isNil(var_319_1) then
					arg_316_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= var_319_2 + var_319_3 and arg_316_1.time_ < var_319_2 + var_319_3 + arg_319_0 and not isNil(var_319_1) and arg_316_1.var_.characterEffect1148ui_story then
				arg_316_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_319_5 = arg_316_1.actors_["1039ui_story"]
			local var_319_6 = 0

			if var_319_6 < arg_316_1.time_ and arg_316_1.time_ <= var_319_6 + arg_319_0 and not isNil(var_319_5) and arg_316_1.var_.characterEffect1039ui_story == nil then
				arg_316_1.var_.characterEffect1039ui_story = var_319_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_7 = 0.2

			if var_319_6 <= arg_316_1.time_ and arg_316_1.time_ < var_319_6 + var_319_7 and not isNil(var_319_5) then
				local var_319_8 = (arg_316_1.time_ - var_319_6) / var_319_7

				if arg_316_1.var_.characterEffect1039ui_story and not isNil(var_319_5) then
					local var_319_9 = Mathf.Lerp(0, 0.5, var_319_8)

					arg_316_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1039ui_story.fillRatio = var_319_9
				end
			end

			if arg_316_1.time_ >= var_319_6 + var_319_7 and arg_316_1.time_ < var_319_6 + var_319_7 + arg_319_0 and not isNil(var_319_5) and arg_316_1.var_.characterEffect1039ui_story then
				local var_319_10 = 0.5

				arg_316_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1039ui_story.fillRatio = var_319_10
			end

			local var_319_11 = 0

			if var_319_11 < arg_316_1.time_ and arg_316_1.time_ <= var_319_11 + arg_319_0 then
				arg_316_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_319_12 = 0

			if var_319_12 < arg_316_1.time_ and arg_316_1.time_ <= var_319_12 + arg_319_0 then
				arg_316_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_319_13 = 0
			local var_319_14 = 0.075

			if var_319_13 < arg_316_1.time_ and arg_316_1.time_ <= var_319_13 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_15 = arg_316_1:FormatText(StoryNameCfg[8].name)

				arg_316_1.leftNameTxt_.text = var_319_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_16 = arg_316_1:GetWordFromCfg(114802083)
				local var_319_17 = arg_316_1:FormatText(var_319_16.content)

				arg_316_1.text_.text = var_319_17

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_18 = 3
				local var_319_19 = utf8.len(var_319_17)
				local var_319_20 = var_319_18 <= 0 and var_319_14 or var_319_14 * (var_319_19 / var_319_18)

				if var_319_20 > 0 and var_319_14 < var_319_20 then
					arg_316_1.talkMaxDuration = var_319_20

					if var_319_20 + var_319_13 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_20 + var_319_13
					end
				end

				arg_316_1.text_.text = var_319_17
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802083", "story_v_side_old_114802.awb") ~= 0 then
					local var_319_21 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802083", "story_v_side_old_114802.awb") / 1000

					if var_319_21 + var_319_13 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_21 + var_319_13
					end

					if var_319_16.prefab_name ~= "" and arg_316_1.actors_[var_319_16.prefab_name] ~= nil then
						local var_319_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_16.prefab_name].transform, "story_v_side_old_114802", "114802083", "story_v_side_old_114802.awb")

						arg_316_1:RecordAudio("114802083", var_319_22)
						arg_316_1:RecordAudio("114802083", var_319_22)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802083", "story_v_side_old_114802.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802083", "story_v_side_old_114802.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_23 = math.max(var_319_14, arg_316_1.talkMaxDuration)

			if var_319_13 <= arg_316_1.time_ and arg_316_1.time_ < var_319_13 + var_319_23 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_13) / var_319_23

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_13 + var_319_23 and arg_316_1.time_ < var_319_13 + var_319_23 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play114802084 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 114802084
		arg_320_1.duration_ = 5

		local var_320_0 = {
			ja = 4.6,
			ko = 3.9,
			zh = 4.066,
			en = 5
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
				arg_320_0:Play114802085(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action475")
			end

			local var_323_2 = 0

			if var_323_2 < arg_320_1.time_ and arg_320_1.time_ <= var_323_2 + arg_323_0 then
				arg_320_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_323_3 = 0
			local var_323_4 = 0.45

			if var_323_3 < arg_320_1.time_ and arg_320_1.time_ <= var_323_3 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_5 = arg_320_1:FormatText(StoryNameCfg[8].name)

				arg_320_1.leftNameTxt_.text = var_323_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_6 = arg_320_1:GetWordFromCfg(114802084)
				local var_323_7 = arg_320_1:FormatText(var_323_6.content)

				arg_320_1.text_.text = var_323_7

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_8 = 18
				local var_323_9 = utf8.len(var_323_7)
				local var_323_10 = var_323_8 <= 0 and var_323_4 or var_323_4 * (var_323_9 / var_323_8)

				if var_323_10 > 0 and var_323_4 < var_323_10 then
					arg_320_1.talkMaxDuration = var_323_10

					if var_323_10 + var_323_3 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_10 + var_323_3
					end
				end

				arg_320_1.text_.text = var_323_7
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802084", "story_v_side_old_114802.awb") ~= 0 then
					local var_323_11 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802084", "story_v_side_old_114802.awb") / 1000

					if var_323_11 + var_323_3 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_11 + var_323_3
					end

					if var_323_6.prefab_name ~= "" and arg_320_1.actors_[var_323_6.prefab_name] ~= nil then
						local var_323_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_6.prefab_name].transform, "story_v_side_old_114802", "114802084", "story_v_side_old_114802.awb")

						arg_320_1:RecordAudio("114802084", var_323_12)
						arg_320_1:RecordAudio("114802084", var_323_12)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802084", "story_v_side_old_114802.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802084", "story_v_side_old_114802.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_13 = math.max(var_323_4, arg_320_1.talkMaxDuration)

			if var_323_3 <= arg_320_1.time_ and arg_320_1.time_ < var_323_3 + var_323_13 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_3) / var_323_13

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_3 + var_323_13 and arg_320_1.time_ < var_323_3 + var_323_13 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play114802085 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 114802085
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play114802086(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["1148ui_story"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1148ui_story == nil then
				arg_324_1.var_.characterEffect1148ui_story = var_327_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.2

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.characterEffect1148ui_story and not isNil(var_327_0) then
					local var_327_4 = Mathf.Lerp(0, 0.5, var_327_3)

					arg_324_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1148ui_story.fillRatio = var_327_4
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1148ui_story then
				local var_327_5 = 0.5

				arg_324_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1148ui_story.fillRatio = var_327_5
			end

			local var_327_6 = 0

			if var_327_6 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 then
				arg_324_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_327_7 = 0

			if var_327_7 < arg_324_1.time_ and arg_324_1.time_ <= var_327_7 + arg_327_0 then
				arg_324_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_327_8 = 0
			local var_327_9 = 0.725

			if var_327_8 < arg_324_1.time_ and arg_324_1.time_ <= var_327_8 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_10 = arg_324_1:FormatText(StoryNameCfg[7].name)

				arg_324_1.leftNameTxt_.text = var_327_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_11 = arg_324_1:GetWordFromCfg(114802085)
				local var_327_12 = arg_324_1:FormatText(var_327_11.content)

				arg_324_1.text_.text = var_327_12

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_13 = 29
				local var_327_14 = utf8.len(var_327_12)
				local var_327_15 = var_327_13 <= 0 and var_327_9 or var_327_9 * (var_327_14 / var_327_13)

				if var_327_15 > 0 and var_327_9 < var_327_15 then
					arg_324_1.talkMaxDuration = var_327_15

					if var_327_15 + var_327_8 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_15 + var_327_8
					end
				end

				arg_324_1.text_.text = var_327_12
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_16 = math.max(var_327_9, arg_324_1.talkMaxDuration)

			if var_327_8 <= arg_324_1.time_ and arg_324_1.time_ < var_327_8 + var_327_16 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_8) / var_327_16

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_8 + var_327_16 and arg_324_1.time_ < var_327_8 + var_327_16 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play114802086 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 114802086
		arg_328_1.duration_ = 8.43

		local var_328_0 = {
			ja = 8.066,
			ko = 7.333,
			zh = 6.6,
			en = 8.433
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play114802087(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1148ui_story"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1148ui_story == nil then
				arg_328_1.var_.characterEffect1148ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.2

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.characterEffect1148ui_story and not isNil(var_331_0) then
					arg_328_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1148ui_story then
				arg_328_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_331_4 = 0

			if var_331_4 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action457")
			end

			local var_331_5 = 0

			if var_331_5 < arg_328_1.time_ and arg_328_1.time_ <= var_331_5 + arg_331_0 then
				arg_328_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_331_6 = 0

			if var_331_6 < arg_328_1.time_ and arg_328_1.time_ <= var_331_6 + arg_331_0 then
				arg_328_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_331_7 = 0
			local var_331_8 = 0.85

			if var_331_7 < arg_328_1.time_ and arg_328_1.time_ <= var_331_7 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_9 = arg_328_1:FormatText(StoryNameCfg[8].name)

				arg_328_1.leftNameTxt_.text = var_331_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_10 = arg_328_1:GetWordFromCfg(114802086)
				local var_331_11 = arg_328_1:FormatText(var_331_10.content)

				arg_328_1.text_.text = var_331_11

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_12 = 34
				local var_331_13 = utf8.len(var_331_11)
				local var_331_14 = var_331_12 <= 0 and var_331_8 or var_331_8 * (var_331_13 / var_331_12)

				if var_331_14 > 0 and var_331_8 < var_331_14 then
					arg_328_1.talkMaxDuration = var_331_14

					if var_331_14 + var_331_7 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_14 + var_331_7
					end
				end

				arg_328_1.text_.text = var_331_11
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802086", "story_v_side_old_114802.awb") ~= 0 then
					local var_331_15 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802086", "story_v_side_old_114802.awb") / 1000

					if var_331_15 + var_331_7 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_15 + var_331_7
					end

					if var_331_10.prefab_name ~= "" and arg_328_1.actors_[var_331_10.prefab_name] ~= nil then
						local var_331_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_10.prefab_name].transform, "story_v_side_old_114802", "114802086", "story_v_side_old_114802.awb")

						arg_328_1:RecordAudio("114802086", var_331_16)
						arg_328_1:RecordAudio("114802086", var_331_16)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802086", "story_v_side_old_114802.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802086", "story_v_side_old_114802.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_17 = math.max(var_331_8, arg_328_1.talkMaxDuration)

			if var_331_7 <= arg_328_1.time_ and arg_328_1.time_ < var_331_7 + var_331_17 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_7) / var_331_17

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_7 + var_331_17 and arg_328_1.time_ < var_331_7 + var_331_17 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play114802087 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 114802087
		arg_332_1.duration_ = 12.83

		local var_332_0 = {
			ja = 11,
			ko = 11.166,
			zh = 9.933,
			en = 12.833
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play114802088(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["1039ui_story"]
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1039ui_story == nil then
				arg_332_1.var_.characterEffect1039ui_story = var_335_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.2

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 and not isNil(var_335_0) then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2

				if arg_332_1.var_.characterEffect1039ui_story and not isNil(var_335_0) then
					arg_332_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1039ui_story then
				arg_332_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_335_4 = 0

			if var_335_4 < arg_332_1.time_ and arg_332_1.time_ <= var_335_4 + arg_335_0 then
				arg_332_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action465")
			end

			local var_335_5 = 0

			if var_335_5 < arg_332_1.time_ and arg_332_1.time_ <= var_335_5 + arg_335_0 then
				arg_332_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_335_6 = arg_332_1.actors_["1148ui_story"]
			local var_335_7 = 0

			if var_335_7 < arg_332_1.time_ and arg_332_1.time_ <= var_335_7 + arg_335_0 and not isNil(var_335_6) and arg_332_1.var_.characterEffect1148ui_story == nil then
				arg_332_1.var_.characterEffect1148ui_story = var_335_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_8 = 0.2

			if var_335_7 <= arg_332_1.time_ and arg_332_1.time_ < var_335_7 + var_335_8 and not isNil(var_335_6) then
				local var_335_9 = (arg_332_1.time_ - var_335_7) / var_335_8

				if arg_332_1.var_.characterEffect1148ui_story and not isNil(var_335_6) then
					local var_335_10 = Mathf.Lerp(0, 0.5, var_335_9)

					arg_332_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1148ui_story.fillRatio = var_335_10
				end
			end

			if arg_332_1.time_ >= var_335_7 + var_335_8 and arg_332_1.time_ < var_335_7 + var_335_8 + arg_335_0 and not isNil(var_335_6) and arg_332_1.var_.characterEffect1148ui_story then
				local var_335_11 = 0.5

				arg_332_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1148ui_story.fillRatio = var_335_11
			end

			local var_335_12 = 0

			if var_335_12 < arg_332_1.time_ and arg_332_1.time_ <= var_335_12 + arg_335_0 then
				arg_332_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_335_13 = 0

			if var_335_13 < arg_332_1.time_ and arg_332_1.time_ <= var_335_13 + arg_335_0 then
				arg_332_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_335_14 = 0
			local var_335_15 = 1.225

			if var_335_14 < arg_332_1.time_ and arg_332_1.time_ <= var_335_14 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_16 = arg_332_1:FormatText(StoryNameCfg[9].name)

				arg_332_1.leftNameTxt_.text = var_335_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_17 = arg_332_1:GetWordFromCfg(114802087)
				local var_335_18 = arg_332_1:FormatText(var_335_17.content)

				arg_332_1.text_.text = var_335_18

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_19 = 49
				local var_335_20 = utf8.len(var_335_18)
				local var_335_21 = var_335_19 <= 0 and var_335_15 or var_335_15 * (var_335_20 / var_335_19)

				if var_335_21 > 0 and var_335_15 < var_335_21 then
					arg_332_1.talkMaxDuration = var_335_21

					if var_335_21 + var_335_14 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_21 + var_335_14
					end
				end

				arg_332_1.text_.text = var_335_18
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802087", "story_v_side_old_114802.awb") ~= 0 then
					local var_335_22 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802087", "story_v_side_old_114802.awb") / 1000

					if var_335_22 + var_335_14 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_22 + var_335_14
					end

					if var_335_17.prefab_name ~= "" and arg_332_1.actors_[var_335_17.prefab_name] ~= nil then
						local var_335_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_17.prefab_name].transform, "story_v_side_old_114802", "114802087", "story_v_side_old_114802.awb")

						arg_332_1:RecordAudio("114802087", var_335_23)
						arg_332_1:RecordAudio("114802087", var_335_23)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802087", "story_v_side_old_114802.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802087", "story_v_side_old_114802.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_24 = math.max(var_335_15, arg_332_1.talkMaxDuration)

			if var_335_14 <= arg_332_1.time_ and arg_332_1.time_ < var_335_14 + var_335_24 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_14) / var_335_24

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_14 + var_335_24 and arg_332_1.time_ < var_335_14 + var_335_24 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play114802088 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 114802088
		arg_336_1.duration_ = 8.2

		local var_336_0 = {
			ja = 8.2,
			ko = 6.733,
			zh = 5.533,
			en = 4.7
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play114802089(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action454")
			end

			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_339_2 = 0

			if var_339_2 < arg_336_1.time_ and arg_336_1.time_ <= var_339_2 + arg_339_0 then
				arg_336_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_339_3 = 0
			local var_339_4 = 0.575

			if var_339_3 < arg_336_1.time_ and arg_336_1.time_ <= var_339_3 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_5 = arg_336_1:FormatText(StoryNameCfg[9].name)

				arg_336_1.leftNameTxt_.text = var_339_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_6 = arg_336_1:GetWordFromCfg(114802088)
				local var_339_7 = arg_336_1:FormatText(var_339_6.content)

				arg_336_1.text_.text = var_339_7

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_8 = 23
				local var_339_9 = utf8.len(var_339_7)
				local var_339_10 = var_339_8 <= 0 and var_339_4 or var_339_4 * (var_339_9 / var_339_8)

				if var_339_10 > 0 and var_339_4 < var_339_10 then
					arg_336_1.talkMaxDuration = var_339_10

					if var_339_10 + var_339_3 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_10 + var_339_3
					end
				end

				arg_336_1.text_.text = var_339_7
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802088", "story_v_side_old_114802.awb") ~= 0 then
					local var_339_11 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802088", "story_v_side_old_114802.awb") / 1000

					if var_339_11 + var_339_3 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_11 + var_339_3
					end

					if var_339_6.prefab_name ~= "" and arg_336_1.actors_[var_339_6.prefab_name] ~= nil then
						local var_339_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_6.prefab_name].transform, "story_v_side_old_114802", "114802088", "story_v_side_old_114802.awb")

						arg_336_1:RecordAudio("114802088", var_339_12)
						arg_336_1:RecordAudio("114802088", var_339_12)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802088", "story_v_side_old_114802.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802088", "story_v_side_old_114802.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_13 = math.max(var_339_4, arg_336_1.talkMaxDuration)

			if var_339_3 <= arg_336_1.time_ and arg_336_1.time_ < var_339_3 + var_339_13 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_3) / var_339_13

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_3 + var_339_13 and arg_336_1.time_ < var_339_3 + var_339_13 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play114802089 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 114802089
		arg_340_1.duration_ = 12.8

		local var_340_0 = {
			ja = 8.933,
			ko = 12.8,
			zh = 11.7,
			en = 11.666
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play114802090(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_343_2 = 0
			local var_343_3 = 1.475

			if var_343_2 < arg_340_1.time_ and arg_340_1.time_ <= var_343_2 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_4 = arg_340_1:FormatText(StoryNameCfg[9].name)

				arg_340_1.leftNameTxt_.text = var_343_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_5 = arg_340_1:GetWordFromCfg(114802089)
				local var_343_6 = arg_340_1:FormatText(var_343_5.content)

				arg_340_1.text_.text = var_343_6

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_7 = 59
				local var_343_8 = utf8.len(var_343_6)
				local var_343_9 = var_343_7 <= 0 and var_343_3 or var_343_3 * (var_343_8 / var_343_7)

				if var_343_9 > 0 and var_343_3 < var_343_9 then
					arg_340_1.talkMaxDuration = var_343_9

					if var_343_9 + var_343_2 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_9 + var_343_2
					end
				end

				arg_340_1.text_.text = var_343_6
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802089", "story_v_side_old_114802.awb") ~= 0 then
					local var_343_10 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802089", "story_v_side_old_114802.awb") / 1000

					if var_343_10 + var_343_2 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_10 + var_343_2
					end

					if var_343_5.prefab_name ~= "" and arg_340_1.actors_[var_343_5.prefab_name] ~= nil then
						local var_343_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_5.prefab_name].transform, "story_v_side_old_114802", "114802089", "story_v_side_old_114802.awb")

						arg_340_1:RecordAudio("114802089", var_343_11)
						arg_340_1:RecordAudio("114802089", var_343_11)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802089", "story_v_side_old_114802.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802089", "story_v_side_old_114802.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_12 = math.max(var_343_3, arg_340_1.talkMaxDuration)

			if var_343_2 <= arg_340_1.time_ and arg_340_1.time_ < var_343_2 + var_343_12 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_2) / var_343_12

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_2 + var_343_12 and arg_340_1.time_ < var_343_2 + var_343_12 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play114802090 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 114802090
		arg_344_1.duration_ = 4.13

		local var_344_0 = {
			ja = 3.666,
			ko = 3.366,
			zh = 2.8,
			en = 4.133
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play114802091(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_347_2 = 0

			if var_347_2 < arg_344_1.time_ and arg_344_1.time_ <= var_347_2 + arg_347_0 then
				arg_344_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_347_3 = 0
			local var_347_4 = 0.325

			if var_347_3 < arg_344_1.time_ and arg_344_1.time_ <= var_347_3 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_5 = arg_344_1:FormatText(StoryNameCfg[9].name)

				arg_344_1.leftNameTxt_.text = var_347_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_6 = arg_344_1:GetWordFromCfg(114802090)
				local var_347_7 = arg_344_1:FormatText(var_347_6.content)

				arg_344_1.text_.text = var_347_7

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_8 = 13
				local var_347_9 = utf8.len(var_347_7)
				local var_347_10 = var_347_8 <= 0 and var_347_4 or var_347_4 * (var_347_9 / var_347_8)

				if var_347_10 > 0 and var_347_4 < var_347_10 then
					arg_344_1.talkMaxDuration = var_347_10

					if var_347_10 + var_347_3 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_10 + var_347_3
					end
				end

				arg_344_1.text_.text = var_347_7
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802090", "story_v_side_old_114802.awb") ~= 0 then
					local var_347_11 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802090", "story_v_side_old_114802.awb") / 1000

					if var_347_11 + var_347_3 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_11 + var_347_3
					end

					if var_347_6.prefab_name ~= "" and arg_344_1.actors_[var_347_6.prefab_name] ~= nil then
						local var_347_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_6.prefab_name].transform, "story_v_side_old_114802", "114802090", "story_v_side_old_114802.awb")

						arg_344_1:RecordAudio("114802090", var_347_12)
						arg_344_1:RecordAudio("114802090", var_347_12)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802090", "story_v_side_old_114802.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802090", "story_v_side_old_114802.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_13 = math.max(var_347_4, arg_344_1.talkMaxDuration)

			if var_347_3 <= arg_344_1.time_ and arg_344_1.time_ < var_347_3 + var_347_13 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_3) / var_347_13

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_3 + var_347_13 and arg_344_1.time_ < var_347_3 + var_347_13 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play114802091 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 114802091
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play114802092(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1039ui_story"]
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect1039ui_story == nil then
				arg_348_1.var_.characterEffect1039ui_story = var_351_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_2 = 0.2

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 and not isNil(var_351_0) then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2

				if arg_348_1.var_.characterEffect1039ui_story and not isNil(var_351_0) then
					local var_351_4 = Mathf.Lerp(0, 0.5, var_351_3)

					arg_348_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_348_1.var_.characterEffect1039ui_story.fillRatio = var_351_4
				end
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect1039ui_story then
				local var_351_5 = 0.5

				arg_348_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_348_1.var_.characterEffect1039ui_story.fillRatio = var_351_5
			end

			local var_351_6 = 0

			if var_351_6 < arg_348_1.time_ and arg_348_1.time_ <= var_351_6 + arg_351_0 then
				arg_348_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_351_7 = 0

			if var_351_7 < arg_348_1.time_ and arg_348_1.time_ <= var_351_7 + arg_351_0 then
				arg_348_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_351_8 = 0
			local var_351_9 = 0.875

			if var_351_8 < arg_348_1.time_ and arg_348_1.time_ <= var_351_8 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_10 = arg_348_1:GetWordFromCfg(114802091)
				local var_351_11 = arg_348_1:FormatText(var_351_10.content)

				arg_348_1.text_.text = var_351_11

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_12 = 35
				local var_351_13 = utf8.len(var_351_11)
				local var_351_14 = var_351_12 <= 0 and var_351_9 or var_351_9 * (var_351_13 / var_351_12)

				if var_351_14 > 0 and var_351_9 < var_351_14 then
					arg_348_1.talkMaxDuration = var_351_14

					if var_351_14 + var_351_8 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_14 + var_351_8
					end
				end

				arg_348_1.text_.text = var_351_11
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_15 = math.max(var_351_9, arg_348_1.talkMaxDuration)

			if var_351_8 <= arg_348_1.time_ and arg_348_1.time_ < var_351_8 + var_351_15 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_8) / var_351_15

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_8 + var_351_15 and arg_348_1.time_ < var_351_8 + var_351_15 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play114802092 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 114802092
		arg_352_1.duration_ = 7

		local var_352_0 = {
			ja = 7,
			ko = 4.033,
			zh = 3.3,
			en = 5.233
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play114802093(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1039ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1039ui_story == nil then
				arg_352_1.var_.characterEffect1039ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.2

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect1039ui_story and not isNil(var_355_0) then
					arg_352_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1039ui_story then
				arg_352_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_355_4 = 0

			if var_355_4 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_355_5 = 0

			if var_355_5 < arg_352_1.time_ and arg_352_1.time_ <= var_355_5 + arg_355_0 then
				arg_352_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_355_6 = 0

			if var_355_6 < arg_352_1.time_ and arg_352_1.time_ <= var_355_6 + arg_355_0 then
				arg_352_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_355_7 = 0
			local var_355_8 = 0.425

			if var_355_7 < arg_352_1.time_ and arg_352_1.time_ <= var_355_7 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_9 = arg_352_1:FormatText(StoryNameCfg[9].name)

				arg_352_1.leftNameTxt_.text = var_355_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_10 = arg_352_1:GetWordFromCfg(114802092)
				local var_355_11 = arg_352_1:FormatText(var_355_10.content)

				arg_352_1.text_.text = var_355_11

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_12 = 17
				local var_355_13 = utf8.len(var_355_11)
				local var_355_14 = var_355_12 <= 0 and var_355_8 or var_355_8 * (var_355_13 / var_355_12)

				if var_355_14 > 0 and var_355_8 < var_355_14 then
					arg_352_1.talkMaxDuration = var_355_14

					if var_355_14 + var_355_7 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_14 + var_355_7
					end
				end

				arg_352_1.text_.text = var_355_11
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802092", "story_v_side_old_114802.awb") ~= 0 then
					local var_355_15 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802092", "story_v_side_old_114802.awb") / 1000

					if var_355_15 + var_355_7 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_15 + var_355_7
					end

					if var_355_10.prefab_name ~= "" and arg_352_1.actors_[var_355_10.prefab_name] ~= nil then
						local var_355_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_10.prefab_name].transform, "story_v_side_old_114802", "114802092", "story_v_side_old_114802.awb")

						arg_352_1:RecordAudio("114802092", var_355_16)
						arg_352_1:RecordAudio("114802092", var_355_16)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802092", "story_v_side_old_114802.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802092", "story_v_side_old_114802.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_17 = math.max(var_355_8, arg_352_1.talkMaxDuration)

			if var_355_7 <= arg_352_1.time_ and arg_352_1.time_ < var_355_7 + var_355_17 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_7) / var_355_17

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_7 + var_355_17 and arg_352_1.time_ < var_355_7 + var_355_17 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play114802093 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 114802093
		arg_356_1.duration_ = 3.43

		local var_356_0 = {
			ja = 3.433,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play114802094(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["1148ui_story"]
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect1148ui_story == nil then
				arg_356_1.var_.characterEffect1148ui_story = var_359_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.2

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 and not isNil(var_359_0) then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2

				if arg_356_1.var_.characterEffect1148ui_story and not isNil(var_359_0) then
					arg_356_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect1148ui_story then
				arg_356_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_359_4 = arg_356_1.actors_["1039ui_story"]
			local var_359_5 = 0

			if var_359_5 < arg_356_1.time_ and arg_356_1.time_ <= var_359_5 + arg_359_0 and not isNil(var_359_4) and arg_356_1.var_.characterEffect1039ui_story == nil then
				arg_356_1.var_.characterEffect1039ui_story = var_359_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_6 = 0.2

			if var_359_5 <= arg_356_1.time_ and arg_356_1.time_ < var_359_5 + var_359_6 and not isNil(var_359_4) then
				local var_359_7 = (arg_356_1.time_ - var_359_5) / var_359_6

				if arg_356_1.var_.characterEffect1039ui_story and not isNil(var_359_4) then
					local var_359_8 = Mathf.Lerp(0, 0.5, var_359_7)

					arg_356_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_356_1.var_.characterEffect1039ui_story.fillRatio = var_359_8
				end
			end

			if arg_356_1.time_ >= var_359_5 + var_359_6 and arg_356_1.time_ < var_359_5 + var_359_6 + arg_359_0 and not isNil(var_359_4) and arg_356_1.var_.characterEffect1039ui_story then
				local var_359_9 = 0.5

				arg_356_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_356_1.var_.characterEffect1039ui_story.fillRatio = var_359_9
			end

			local var_359_10 = 0

			if var_359_10 < arg_356_1.time_ and arg_356_1.time_ <= var_359_10 + arg_359_0 then
				arg_356_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_359_11 = 0

			if var_359_11 < arg_356_1.time_ and arg_356_1.time_ <= var_359_11 + arg_359_0 then
				arg_356_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_359_12 = 0
			local var_359_13 = 0.075

			if var_359_12 < arg_356_1.time_ and arg_356_1.time_ <= var_359_12 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_14 = arg_356_1:FormatText(StoryNameCfg[8].name)

				arg_356_1.leftNameTxt_.text = var_359_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_15 = arg_356_1:GetWordFromCfg(114802093)
				local var_359_16 = arg_356_1:FormatText(var_359_15.content)

				arg_356_1.text_.text = var_359_16

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_17 = 3
				local var_359_18 = utf8.len(var_359_16)
				local var_359_19 = var_359_17 <= 0 and var_359_13 or var_359_13 * (var_359_18 / var_359_17)

				if var_359_19 > 0 and var_359_13 < var_359_19 then
					arg_356_1.talkMaxDuration = var_359_19

					if var_359_19 + var_359_12 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_19 + var_359_12
					end
				end

				arg_356_1.text_.text = var_359_16
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802093", "story_v_side_old_114802.awb") ~= 0 then
					local var_359_20 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802093", "story_v_side_old_114802.awb") / 1000

					if var_359_20 + var_359_12 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_20 + var_359_12
					end

					if var_359_15.prefab_name ~= "" and arg_356_1.actors_[var_359_15.prefab_name] ~= nil then
						local var_359_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_15.prefab_name].transform, "story_v_side_old_114802", "114802093", "story_v_side_old_114802.awb")

						arg_356_1:RecordAudio("114802093", var_359_21)
						arg_356_1:RecordAudio("114802093", var_359_21)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802093", "story_v_side_old_114802.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802093", "story_v_side_old_114802.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_22 = math.max(var_359_13, arg_356_1.talkMaxDuration)

			if var_359_12 <= arg_356_1.time_ and arg_356_1.time_ < var_359_12 + var_359_22 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_12) / var_359_22

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_12 + var_359_22 and arg_356_1.time_ < var_359_12 + var_359_22 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play114802094 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 114802094
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play114802095(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["1039ui_story"].transform
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.var_.moveOldPos1039ui_story = var_363_0.localPosition
			end

			local var_363_2 = 0.001

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2
				local var_363_4 = Vector3.New(0, 100, 0)

				var_363_0.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos1039ui_story, var_363_4, var_363_3)

				local var_363_5 = manager.ui.mainCamera.transform.position - var_363_0.position

				var_363_0.forward = Vector3.New(var_363_5.x, var_363_5.y, var_363_5.z)

				local var_363_6 = var_363_0.localEulerAngles

				var_363_6.z = 0
				var_363_6.x = 0
				var_363_0.localEulerAngles = var_363_6
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 then
				var_363_0.localPosition = Vector3.New(0, 100, 0)

				local var_363_7 = manager.ui.mainCamera.transform.position - var_363_0.position

				var_363_0.forward = Vector3.New(var_363_7.x, var_363_7.y, var_363_7.z)

				local var_363_8 = var_363_0.localEulerAngles

				var_363_8.z = 0
				var_363_8.x = 0
				var_363_0.localEulerAngles = var_363_8
			end

			local var_363_9 = arg_360_1.actors_["1148ui_story"].transform
			local var_363_10 = 0

			if var_363_10 < arg_360_1.time_ and arg_360_1.time_ <= var_363_10 + arg_363_0 then
				arg_360_1.var_.moveOldPos1148ui_story = var_363_9.localPosition

				local var_363_11 = "1148ui_story"

				arg_360_1:ShowWeapon(arg_360_1.var_[var_363_11 .. "Animator"].transform, false)
			end

			local var_363_12 = 0.001

			if var_363_10 <= arg_360_1.time_ and arg_360_1.time_ < var_363_10 + var_363_12 then
				local var_363_13 = (arg_360_1.time_ - var_363_10) / var_363_12
				local var_363_14 = Vector3.New(0, -0.8, -6.2)

				var_363_9.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos1148ui_story, var_363_14, var_363_13)

				local var_363_15 = manager.ui.mainCamera.transform.position - var_363_9.position

				var_363_9.forward = Vector3.New(var_363_15.x, var_363_15.y, var_363_15.z)

				local var_363_16 = var_363_9.localEulerAngles

				var_363_16.z = 0
				var_363_16.x = 0
				var_363_9.localEulerAngles = var_363_16
			end

			if arg_360_1.time_ >= var_363_10 + var_363_12 and arg_360_1.time_ < var_363_10 + var_363_12 + arg_363_0 then
				var_363_9.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_363_17 = manager.ui.mainCamera.transform.position - var_363_9.position

				var_363_9.forward = Vector3.New(var_363_17.x, var_363_17.y, var_363_17.z)

				local var_363_18 = var_363_9.localEulerAngles

				var_363_18.z = 0
				var_363_18.x = 0
				var_363_9.localEulerAngles = var_363_18
			end

			local var_363_19 = 0.0166666666666667

			if var_363_19 < arg_360_1.time_ and arg_360_1.time_ <= var_363_19 + arg_363_0 then
				arg_360_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_363_20 = 0.0166666666666667

			if var_363_20 < arg_360_1.time_ and arg_360_1.time_ <= var_363_20 + arg_363_0 then
				arg_360_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_363_21 = 0
			local var_363_22 = 0.65

			if var_363_21 < arg_360_1.time_ and arg_360_1.time_ <= var_363_21 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_23 = arg_360_1:GetWordFromCfg(114802094)
				local var_363_24 = arg_360_1:FormatText(var_363_23.content)

				arg_360_1.text_.text = var_363_24

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_25 = 26
				local var_363_26 = utf8.len(var_363_24)
				local var_363_27 = var_363_25 <= 0 and var_363_22 or var_363_22 * (var_363_26 / var_363_25)

				if var_363_27 > 0 and var_363_22 < var_363_27 then
					arg_360_1.talkMaxDuration = var_363_27

					if var_363_27 + var_363_21 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_27 + var_363_21
					end
				end

				arg_360_1.text_.text = var_363_24
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_28 = math.max(var_363_22, arg_360_1.talkMaxDuration)

			if var_363_21 <= arg_360_1.time_ and arg_360_1.time_ < var_363_21 + var_363_28 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_21) / var_363_28

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_21 + var_363_28 and arg_360_1.time_ < var_363_21 + var_363_28 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_360_1:InitPlayNodeList()
	end,
	Play114802095 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 114802095
		arg_364_1.duration_ = 6.67

		local var_364_0 = {
			ja = 6.666,
			ko = 5.333,
			zh = 6.233,
			en = 5.966
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play114802096(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_367_1 = 0
			local var_367_2 = 0.475

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_3 = arg_364_1:FormatText(StoryNameCfg[8].name)

				arg_364_1.leftNameTxt_.text = var_367_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_4 = arg_364_1:GetWordFromCfg(114802095)
				local var_367_5 = arg_364_1:FormatText(var_367_4.content)

				arg_364_1.text_.text = var_367_5

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_6 = 19
				local var_367_7 = utf8.len(var_367_5)
				local var_367_8 = var_367_6 <= 0 and var_367_2 or var_367_2 * (var_367_7 / var_367_6)

				if var_367_8 > 0 and var_367_2 < var_367_8 then
					arg_364_1.talkMaxDuration = var_367_8

					if var_367_8 + var_367_1 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_1
					end
				end

				arg_364_1.text_.text = var_367_5
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802095", "story_v_side_old_114802.awb") ~= 0 then
					local var_367_9 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802095", "story_v_side_old_114802.awb") / 1000

					if var_367_9 + var_367_1 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_9 + var_367_1
					end

					if var_367_4.prefab_name ~= "" and arg_364_1.actors_[var_367_4.prefab_name] ~= nil then
						local var_367_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_4.prefab_name].transform, "story_v_side_old_114802", "114802095", "story_v_side_old_114802.awb")

						arg_364_1:RecordAudio("114802095", var_367_10)
						arg_364_1:RecordAudio("114802095", var_367_10)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802095", "story_v_side_old_114802.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802095", "story_v_side_old_114802.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_11 = math.max(var_367_2, arg_364_1.talkMaxDuration)

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_11 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_1) / var_367_11

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_1 + var_367_11 and arg_364_1.time_ < var_367_1 + var_367_11 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play114802096 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 114802096
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play114802097(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["1148ui_story"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect1148ui_story == nil then
				arg_368_1.var_.characterEffect1148ui_story = var_371_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.2

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.characterEffect1148ui_story and not isNil(var_371_0) then
					local var_371_4 = Mathf.Lerp(0, 0.5, var_371_3)

					arg_368_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_368_1.var_.characterEffect1148ui_story.fillRatio = var_371_4
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect1148ui_story then
				local var_371_5 = 0.5

				arg_368_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_368_1.var_.characterEffect1148ui_story.fillRatio = var_371_5
			end

			local var_371_6 = 0
			local var_371_7 = 0.275

			if var_371_6 < arg_368_1.time_ and arg_368_1.time_ <= var_371_6 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_8 = arg_368_1:FormatText(StoryNameCfg[7].name)

				arg_368_1.leftNameTxt_.text = var_371_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_9 = arg_368_1:GetWordFromCfg(114802096)
				local var_371_10 = arg_368_1:FormatText(var_371_9.content)

				arg_368_1.text_.text = var_371_10

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_11 = 11
				local var_371_12 = utf8.len(var_371_10)
				local var_371_13 = var_371_11 <= 0 and var_371_7 or var_371_7 * (var_371_12 / var_371_11)

				if var_371_13 > 0 and var_371_7 < var_371_13 then
					arg_368_1.talkMaxDuration = var_371_13

					if var_371_13 + var_371_6 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_13 + var_371_6
					end
				end

				arg_368_1.text_.text = var_371_10
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_14 = math.max(var_371_7, arg_368_1.talkMaxDuration)

			if var_371_6 <= arg_368_1.time_ and arg_368_1.time_ < var_371_6 + var_371_14 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_6) / var_371_14

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_6 + var_371_14 and arg_368_1.time_ < var_371_6 + var_371_14 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play114802097 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 114802097
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play114802098(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action475")
			end

			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_375_2 = 0
			local var_375_3 = 0.625

			if var_375_2 < arg_372_1.time_ and arg_372_1.time_ <= var_375_2 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_4 = arg_372_1:GetWordFromCfg(114802097)
				local var_375_5 = arg_372_1:FormatText(var_375_4.content)

				arg_372_1.text_.text = var_375_5

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_6 = 25
				local var_375_7 = utf8.len(var_375_5)
				local var_375_8 = var_375_6 <= 0 and var_375_3 or var_375_3 * (var_375_7 / var_375_6)

				if var_375_8 > 0 and var_375_3 < var_375_8 then
					arg_372_1.talkMaxDuration = var_375_8

					if var_375_8 + var_375_2 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_8 + var_375_2
					end
				end

				arg_372_1.text_.text = var_375_5
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_9 = math.max(var_375_3, arg_372_1.talkMaxDuration)

			if var_375_2 <= arg_372_1.time_ and arg_372_1.time_ < var_375_2 + var_375_9 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_2) / var_375_9

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_2 + var_375_9 and arg_372_1.time_ < var_375_2 + var_375_9 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play114802098 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 114802098
		arg_376_1.duration_ = 11.2

		local var_376_0 = {
			ja = 11.2,
			ko = 6.833,
			zh = 6.333,
			en = 8.933
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play114802099(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["1148ui_story"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect1148ui_story == nil then
				arg_376_1.var_.characterEffect1148ui_story = var_379_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.2

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.characterEffect1148ui_story and not isNil(var_379_0) then
					arg_376_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect1148ui_story then
				arg_376_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_379_4 = 0

			if var_379_4 < arg_376_1.time_ and arg_376_1.time_ <= var_379_4 + arg_379_0 then
				arg_376_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action456")
			end

			local var_379_5 = 0

			if var_379_5 < arg_376_1.time_ and arg_376_1.time_ <= var_379_5 + arg_379_0 then
				arg_376_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_379_6 = 0
			local var_379_7 = 0.8

			if var_379_6 < arg_376_1.time_ and arg_376_1.time_ <= var_379_6 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_8 = arg_376_1:FormatText(StoryNameCfg[8].name)

				arg_376_1.leftNameTxt_.text = var_379_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_9 = arg_376_1:GetWordFromCfg(114802098)
				local var_379_10 = arg_376_1:FormatText(var_379_9.content)

				arg_376_1.text_.text = var_379_10

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_11 = 32
				local var_379_12 = utf8.len(var_379_10)
				local var_379_13 = var_379_11 <= 0 and var_379_7 or var_379_7 * (var_379_12 / var_379_11)

				if var_379_13 > 0 and var_379_7 < var_379_13 then
					arg_376_1.talkMaxDuration = var_379_13

					if var_379_13 + var_379_6 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_13 + var_379_6
					end
				end

				arg_376_1.text_.text = var_379_10
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802098", "story_v_side_old_114802.awb") ~= 0 then
					local var_379_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802098", "story_v_side_old_114802.awb") / 1000

					if var_379_14 + var_379_6 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_14 + var_379_6
					end

					if var_379_9.prefab_name ~= "" and arg_376_1.actors_[var_379_9.prefab_name] ~= nil then
						local var_379_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_9.prefab_name].transform, "story_v_side_old_114802", "114802098", "story_v_side_old_114802.awb")

						arg_376_1:RecordAudio("114802098", var_379_15)
						arg_376_1:RecordAudio("114802098", var_379_15)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802098", "story_v_side_old_114802.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802098", "story_v_side_old_114802.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_16 = math.max(var_379_7, arg_376_1.talkMaxDuration)

			if var_379_6 <= arg_376_1.time_ and arg_376_1.time_ < var_379_6 + var_379_16 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_6) / var_379_16

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_6 + var_379_16 and arg_376_1.time_ < var_379_6 + var_379_16 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play114802099 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 114802099
		arg_380_1.duration_ = 8.87

		local var_380_0 = {
			ja = 8.866,
			ko = 5.633,
			zh = 7.033,
			en = 8.466
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
			arg_380_1.auto_ = false
		end

		function arg_380_1.playNext_(arg_382_0)
			arg_380_1.onStoryFinished_()
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action463")
			end

			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_383_2 = 0
			local var_383_3 = 0.85

			if var_383_2 < arg_380_1.time_ and arg_380_1.time_ <= var_383_2 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_4 = arg_380_1:FormatText(StoryNameCfg[8].name)

				arg_380_1.leftNameTxt_.text = var_383_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_5 = arg_380_1:GetWordFromCfg(114802099)
				local var_383_6 = arg_380_1:FormatText(var_383_5.content)

				arg_380_1.text_.text = var_383_6

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_7 = 34
				local var_383_8 = utf8.len(var_383_6)
				local var_383_9 = var_383_7 <= 0 and var_383_3 or var_383_3 * (var_383_8 / var_383_7)

				if var_383_9 > 0 and var_383_3 < var_383_9 then
					arg_380_1.talkMaxDuration = var_383_9

					if var_383_9 + var_383_2 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_9 + var_383_2
					end
				end

				arg_380_1.text_.text = var_383_6
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802099", "story_v_side_old_114802.awb") ~= 0 then
					local var_383_10 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802099", "story_v_side_old_114802.awb") / 1000

					if var_383_10 + var_383_2 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_10 + var_383_2
					end

					if var_383_5.prefab_name ~= "" and arg_380_1.actors_[var_383_5.prefab_name] ~= nil then
						local var_383_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_5.prefab_name].transform, "story_v_side_old_114802", "114802099", "story_v_side_old_114802.awb")

						arg_380_1:RecordAudio("114802099", var_383_11)
						arg_380_1:RecordAudio("114802099", var_383_11)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802099", "story_v_side_old_114802.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802099", "story_v_side_old_114802.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_12 = math.max(var_383_3, arg_380_1.talkMaxDuration)

			if var_383_2 <= arg_380_1.time_ and arg_380_1.time_ < var_383_2 + var_383_12 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_2) / var_383_12

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_2 + var_383_12 and arg_380_1.time_ < var_383_2 + var_383_12 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play114802034 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 114802034
		arg_384_1.duration_ = 11.23

		local var_384_0 = {
			ja = 11.233,
			ko = 9.733,
			zh = 10.4,
			en = 10.466
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play114802035(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = "1148ui_story"

			if arg_384_1.actors_[var_387_0] == nil then
				local var_387_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_387_1) then
					local var_387_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_384_1.stage_.transform)

					var_387_2.name = var_387_0
					var_387_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_384_1.actors_[var_387_0] = var_387_2

					local var_387_3 = var_387_2:GetComponentInChildren(typeof(CharacterEffect))

					var_387_3.enabled = true

					local var_387_4 = GameObjectTools.GetOrAddComponent(var_387_2, typeof(DynamicBoneHelper))

					if var_387_4 then
						var_387_4:EnableDynamicBone(false)
					end

					arg_384_1:ShowWeapon(var_387_3.transform, false)

					arg_384_1.var_[var_387_0 .. "Animator"] = var_387_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_384_1.var_[var_387_0 .. "Animator"].applyRootMotion = true
					arg_384_1.var_[var_387_0 .. "LipSync"] = var_387_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_387_5 = 0

			if var_387_5 < arg_384_1.time_ and arg_384_1.time_ <= var_387_5 + arg_387_0 then
				arg_384_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action447")
			end

			local var_387_6 = "1148ui_story"

			if arg_384_1.actors_[var_387_6] == nil then
				local var_387_7 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_387_7) then
					local var_387_8 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_384_1.stage_.transform)

					var_387_8.name = var_387_6
					var_387_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_384_1.actors_[var_387_6] = var_387_8

					local var_387_9 = var_387_8:GetComponentInChildren(typeof(CharacterEffect))

					var_387_9.enabled = true

					local var_387_10 = GameObjectTools.GetOrAddComponent(var_387_8, typeof(DynamicBoneHelper))

					if var_387_10 then
						var_387_10:EnableDynamicBone(false)
					end

					arg_384_1:ShowWeapon(var_387_9.transform, false)

					arg_384_1.var_[var_387_6 .. "Animator"] = var_387_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_384_1.var_[var_387_6 .. "Animator"].applyRootMotion = true
					arg_384_1.var_[var_387_6 .. "LipSync"] = var_387_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_387_11 = 0

			if var_387_11 < arg_384_1.time_ and arg_384_1.time_ <= var_387_11 + arg_387_0 then
				arg_384_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_387_12 = 0
			local var_387_13 = 0.575

			if var_387_12 < arg_384_1.time_ and arg_384_1.time_ <= var_387_12 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_14 = arg_384_1:FormatText(StoryNameCfg[8].name)

				arg_384_1.leftNameTxt_.text = var_387_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_15 = arg_384_1:GetWordFromCfg(114802034)
				local var_387_16 = arg_384_1:FormatText(var_387_15.content)

				arg_384_1.text_.text = var_387_16

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_17 = 41
				local var_387_18 = utf8.len(var_387_16)
				local var_387_19 = var_387_17 <= 0 and var_387_13 or var_387_13 * (var_387_18 / var_387_17)

				if var_387_19 > 0 and var_387_13 < var_387_19 then
					arg_384_1.talkMaxDuration = var_387_19

					if var_387_19 + var_387_12 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_19 + var_387_12
					end
				end

				arg_384_1.text_.text = var_387_16
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802034", "story_v_side_old_114802.awb") ~= 0 then
					local var_387_20 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802034", "story_v_side_old_114802.awb") / 1000

					if var_387_20 + var_387_12 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_20 + var_387_12
					end

					if var_387_15.prefab_name ~= "" and arg_384_1.actors_[var_387_15.prefab_name] ~= nil then
						local var_387_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_15.prefab_name].transform, "story_v_side_old_114802", "114802034", "story_v_side_old_114802.awb")

						arg_384_1:RecordAudio("114802034", var_387_21)
						arg_384_1:RecordAudio("114802034", var_387_21)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802034", "story_v_side_old_114802.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802034", "story_v_side_old_114802.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_22 = math.max(var_387_13, arg_384_1.talkMaxDuration)

			if var_387_12 <= arg_384_1.time_ and arg_384_1.time_ < var_387_12 + var_387_22 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_12) / var_387_22

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_12 + var_387_22 and arg_384_1.time_ < var_387_12 + var_387_22 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play114802035 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 114802035
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play114802036(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1148ui_story"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1148ui_story == nil then
				arg_388_1.var_.characterEffect1148ui_story = var_391_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.2

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.characterEffect1148ui_story and not isNil(var_391_0) then
					local var_391_4 = Mathf.Lerp(0, 0.5, var_391_3)

					arg_388_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_388_1.var_.characterEffect1148ui_story.fillRatio = var_391_4
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1148ui_story then
				local var_391_5 = 0.5

				arg_388_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_388_1.var_.characterEffect1148ui_story.fillRatio = var_391_5
			end

			local var_391_6 = 0
			local var_391_7 = 0.275

			if var_391_6 < arg_388_1.time_ and arg_388_1.time_ <= var_391_6 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_8 = arg_388_1:FormatText(StoryNameCfg[7].name)

				arg_388_1.leftNameTxt_.text = var_391_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_9 = arg_388_1:GetWordFromCfg(114802035)
				local var_391_10 = arg_388_1:FormatText(var_391_9.content)

				arg_388_1.text_.text = var_391_10

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_11 = 5
				local var_391_12 = utf8.len(var_391_10)
				local var_391_13 = var_391_11 <= 0 and var_391_7 or var_391_7 * (var_391_12 / var_391_11)

				if var_391_13 > 0 and var_391_7 < var_391_13 then
					arg_388_1.talkMaxDuration = var_391_13

					if var_391_13 + var_391_6 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_13 + var_391_6
					end
				end

				arg_388_1.text_.text = var_391_10
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_14 = math.max(var_391_7, arg_388_1.talkMaxDuration)

			if var_391_6 <= arg_388_1.time_ and arg_388_1.time_ < var_391_6 + var_391_14 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_6) / var_391_14

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_6 + var_391_14 and arg_388_1.time_ < var_391_6 + var_391_14 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play114802036 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 114802036
		arg_392_1.duration_ = 12.97

		local var_392_0 = {
			ja = 12.966,
			ko = 11.133,
			zh = 9.633,
			en = 12.866
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play114802037(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1148ui_story"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1148ui_story == nil then
				arg_392_1.var_.characterEffect1148ui_story = var_395_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_2 = 0.2

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.characterEffect1148ui_story and not isNil(var_395_0) then
					arg_392_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1148ui_story then
				arg_392_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_395_4 = 0

			if var_395_4 < arg_392_1.time_ and arg_392_1.time_ <= var_395_4 + arg_395_0 then
				arg_392_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			local var_395_5 = 0

			if var_395_5 < arg_392_1.time_ and arg_392_1.time_ <= var_395_5 + arg_395_0 then
				arg_392_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_395_6 = 0
			local var_395_7 = 0.575

			if var_395_6 < arg_392_1.time_ and arg_392_1.time_ <= var_395_6 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_8 = arg_392_1:FormatText(StoryNameCfg[8].name)

				arg_392_1.leftNameTxt_.text = var_395_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_9 = arg_392_1:GetWordFromCfg(114802036)
				local var_395_10 = arg_392_1:FormatText(var_395_9.content)

				arg_392_1.text_.text = var_395_10

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_11 = 44
				local var_395_12 = utf8.len(var_395_10)
				local var_395_13 = var_395_11 <= 0 and var_395_7 or var_395_7 * (var_395_12 / var_395_11)

				if var_395_13 > 0 and var_395_7 < var_395_13 then
					arg_392_1.talkMaxDuration = var_395_13

					if var_395_13 + var_395_6 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_13 + var_395_6
					end
				end

				arg_392_1.text_.text = var_395_10
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_114802", "114802036", "story_v_side_old_114802.awb") ~= 0 then
					local var_395_14 = manager.audio:GetVoiceLength("story_v_side_old_114802", "114802036", "story_v_side_old_114802.awb") / 1000

					if var_395_14 + var_395_6 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_14 + var_395_6
					end

					if var_395_9.prefab_name ~= "" and arg_392_1.actors_[var_395_9.prefab_name] ~= nil then
						local var_395_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_9.prefab_name].transform, "story_v_side_old_114802", "114802036", "story_v_side_old_114802.awb")

						arg_392_1:RecordAudio("114802036", var_395_15)
						arg_392_1:RecordAudio("114802036", var_395_15)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_side_old_114802", "114802036", "story_v_side_old_114802.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_side_old_114802", "114802036", "story_v_side_old_114802.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_16 = math.max(var_395_7, arg_392_1.talkMaxDuration)

			if var_395_6 <= arg_392_1.time_ and arg_392_1.time_ < var_395_6 + var_395_16 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_6) / var_395_16

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_6 + var_395_16 and arg_392_1.time_ < var_395_6 + var_395_16 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/ST04a"
	},
	voices = {
		"story_v_side_old_114802.awb"
	}
}
