return {
	Play108071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 108071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play108071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "C07_1"

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
				local var_4_5 = arg_1_1.bgs_.C07_1

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
					if iter_4_0 ~= "C07_1" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.C07_1
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueC07_1 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueC07_1 = var_4_18
				end

				arg_1_1.var_.alphaOldValueC07_1 = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueC07_1, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueC07_1 then
					local var_4_22 = arg_1_1.var_.alphaMatValueC07_1.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueC07_1.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueC07_1 then
				local var_4_23 = arg_1_1.var_.alphaMatValueC07_1
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
			local var_4_34 = 0.65

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

				local var_4_36 = arg_1_1:GetWordFromCfg(108071001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 26
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
	Play108071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 108071002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play108071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.95

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

				local var_11_2 = arg_8_1:GetWordFromCfg(108071002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 38
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
	Play108071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 108071003
		arg_12_1.duration_ = 8.1

		local var_12_0 = {
			ja = 5.966,
			ko = 6,
			zh = 8.1,
			en = 7.033
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
				arg_12_0:Play108071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "3014_tpose"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "3014_tpose")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "3014_tpose"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["3014_tpose"]
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect3014_tpose == nil then
				arg_12_1.var_.characterEffect3014_tpose = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.2

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 and not isNil(var_15_5) then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7

				if arg_12_1.var_.characterEffect3014_tpose and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect3014_tpose then
				arg_12_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_15_9 = arg_12_1.actors_["3014_tpose"].transform
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.var_.moveOldPos3014_tpose = var_15_9.localPosition

				local var_15_11 = GameObjectTools.GetOrAddComponent(var_15_9.gameObject, typeof(DynamicBoneHelper))

				if var_15_11 then
					var_15_11:EnableDynamicBone(false)
				end
			end

			local var_15_12 = 0.001

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_12 then
				local var_15_13 = (arg_12_1.time_ - var_15_10) / var_15_12
				local var_15_14 = Vector3.New(0, -2.35, -2.9)

				var_15_9.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3014_tpose, var_15_14, var_15_13)

				local var_15_15 = manager.ui.mainCamera.transform.position - var_15_9.position

				var_15_9.forward = Vector3.New(var_15_15.x, var_15_15.y, var_15_15.z)

				local var_15_16 = var_15_9.localEulerAngles

				var_15_16.z = 0
				var_15_16.x = 0
				var_15_9.localEulerAngles = var_15_16
			end

			if arg_12_1.time_ >= var_15_10 + var_15_12 and arg_12_1.time_ < var_15_10 + var_15_12 + arg_15_0 then
				var_15_9.localPosition = Vector3.New(0, -2.35, -2.9)

				local var_15_17 = manager.ui.mainCamera.transform.position - var_15_9.position

				var_15_9.forward = Vector3.New(var_15_17.x, var_15_17.y, var_15_17.z)

				local var_15_18 = var_15_9.localEulerAngles

				var_15_18.z = 0
				var_15_18.x = 0
				var_15_9.localEulerAngles = var_15_18

				local var_15_19 = GameObjectTools.GetOrAddComponent(var_15_9.gameObject, typeof(DynamicBoneHelper))

				if var_15_19 then
					var_15_19:EnableDynamicBone(true)
				end
			end

			local var_15_20 = 0

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_15_21 = 0
			local var_15_22 = 0.55

			if var_15_21 < arg_12_1.time_ and arg_12_1.time_ <= var_15_21 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_23 = arg_12_1:FormatText(StoryNameCfg[96].name)

				arg_12_1.leftNameTxt_.text = var_15_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_24 = arg_12_1:GetWordFromCfg(108071003)
				local var_15_25 = arg_12_1:FormatText(var_15_24.content)

				arg_12_1.text_.text = var_15_25

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_26 = 22
				local var_15_27 = utf8.len(var_15_25)
				local var_15_28 = var_15_26 <= 0 and var_15_22 or var_15_22 * (var_15_27 / var_15_26)

				if var_15_28 > 0 and var_15_22 < var_15_28 then
					arg_12_1.talkMaxDuration = var_15_28

					if var_15_28 + var_15_21 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_28 + var_15_21
					end
				end

				arg_12_1.text_.text = var_15_25
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071003", "story_v_out_108071.awb") ~= 0 then
					local var_15_29 = manager.audio:GetVoiceLength("story_v_out_108071", "108071003", "story_v_out_108071.awb") / 1000

					if var_15_29 + var_15_21 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_29 + var_15_21
					end

					if var_15_24.prefab_name ~= "" and arg_12_1.actors_[var_15_24.prefab_name] ~= nil then
						local var_15_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_24.prefab_name].transform, "story_v_out_108071", "108071003", "story_v_out_108071.awb")

						arg_12_1:RecordAudio("108071003", var_15_30)
						arg_12_1:RecordAudio("108071003", var_15_30)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_108071", "108071003", "story_v_out_108071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_108071", "108071003", "story_v_out_108071.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_31 = math.max(var_15_22, arg_12_1.talkMaxDuration)

			if var_15_21 <= arg_12_1.time_ and arg_12_1.time_ < var_15_21 + var_15_31 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_21) / var_15_31

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_21 + var_15_31 and arg_12_1.time_ < var_15_21 + var_15_31 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play108071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 108071004
		arg_16_1.duration_ = 12.3

		local var_16_0 = {
			ja = 11.6,
			ko = 7.1,
			zh = 6.7,
			en = 12.3
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
				arg_16_0:Play108071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["3014_tpose"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos3014_tpose = var_19_0.localPosition

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end
			end

			local var_19_3 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_3 then
				local var_19_4 = (arg_16_1.time_ - var_19_1) / var_19_3
				local var_19_5 = Vector3.New(0, 100, 0)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3014_tpose, var_19_5, var_19_4)

				local var_19_6 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_6.x, var_19_6.y, var_19_6.z)

				local var_19_7 = var_19_0.localEulerAngles

				var_19_7.z = 0
				var_19_7.x = 0
				var_19_0.localEulerAngles = var_19_7
			end

			if arg_16_1.time_ >= var_19_1 + var_19_3 and arg_16_1.time_ < var_19_1 + var_19_3 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, 100, 0)

				local var_19_8 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_8.x, var_19_8.y, var_19_8.z)

				local var_19_9 = var_19_0.localEulerAngles

				var_19_9.z = 0
				var_19_9.x = 0
				var_19_0.localEulerAngles = var_19_9

				local var_19_10 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_10 then
					var_19_10:EnableDynamicBone(true)
				end
			end

			local var_19_11 = "1099ui_story"

			if arg_16_1.actors_[var_19_11] == nil then
				local var_19_12 = Asset.Load("Char/" .. "1099ui_story")

				if not isNil(var_19_12) then
					local var_19_13 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_16_1.stage_.transform)

					var_19_13.name = var_19_11
					var_19_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_11] = var_19_13

					local var_19_14 = var_19_13:GetComponentInChildren(typeof(CharacterEffect))

					var_19_14.enabled = true

					local var_19_15 = GameObjectTools.GetOrAddComponent(var_19_13, typeof(DynamicBoneHelper))

					if var_19_15 then
						var_19_15:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_14.transform, false)

					arg_16_1.var_[var_19_11 .. "Animator"] = var_19_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_11 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_11 .. "LipSync"] = var_19_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_16 = arg_16_1.actors_["1099ui_story"].transform
			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 then
				arg_16_1.var_.moveOldPos1099ui_story = var_19_16.localPosition
			end

			local var_19_18 = 0.001

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_18 then
				local var_19_19 = (arg_16_1.time_ - var_19_17) / var_19_18
				local var_19_20 = Vector3.New(0, -1.08, -5.9)

				var_19_16.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1099ui_story, var_19_20, var_19_19)

				local var_19_21 = manager.ui.mainCamera.transform.position - var_19_16.position

				var_19_16.forward = Vector3.New(var_19_21.x, var_19_21.y, var_19_21.z)

				local var_19_22 = var_19_16.localEulerAngles

				var_19_22.z = 0
				var_19_22.x = 0
				var_19_16.localEulerAngles = var_19_22
			end

			if arg_16_1.time_ >= var_19_17 + var_19_18 and arg_16_1.time_ < var_19_17 + var_19_18 + arg_19_0 then
				var_19_16.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_19_23 = manager.ui.mainCamera.transform.position - var_19_16.position

				var_19_16.forward = Vector3.New(var_19_23.x, var_19_23.y, var_19_23.z)

				local var_19_24 = var_19_16.localEulerAngles

				var_19_24.z = 0
				var_19_24.x = 0
				var_19_16.localEulerAngles = var_19_24
			end

			local var_19_25 = 0

			if var_19_25 < arg_16_1.time_ and arg_16_1.time_ <= var_19_25 + arg_19_0 then
				arg_16_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			local var_19_26 = arg_16_1.actors_["1099ui_story"]
			local var_19_27 = 0

			if var_19_27 < arg_16_1.time_ and arg_16_1.time_ <= var_19_27 + arg_19_0 and not isNil(var_19_26) and arg_16_1.var_.characterEffect1099ui_story == nil then
				arg_16_1.var_.characterEffect1099ui_story = var_19_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_28 = 0.2

			if var_19_27 <= arg_16_1.time_ and arg_16_1.time_ < var_19_27 + var_19_28 and not isNil(var_19_26) then
				local var_19_29 = (arg_16_1.time_ - var_19_27) / var_19_28

				if arg_16_1.var_.characterEffect1099ui_story and not isNil(var_19_26) then
					arg_16_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_27 + var_19_28 and arg_16_1.time_ < var_19_27 + var_19_28 + arg_19_0 and not isNil(var_19_26) and arg_16_1.var_.characterEffect1099ui_story then
				arg_16_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_19_30 = 0

			if var_19_30 < arg_16_1.time_ and arg_16_1.time_ <= var_19_30 + arg_19_0 then
				arg_16_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_19_31 = 0
			local var_19_32 = 0.75

			if var_19_31 < arg_16_1.time_ and arg_16_1.time_ <= var_19_31 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_33 = arg_16_1:FormatText(StoryNameCfg[84].name)

				arg_16_1.leftNameTxt_.text = var_19_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_34 = arg_16_1:GetWordFromCfg(108071004)
				local var_19_35 = arg_16_1:FormatText(var_19_34.content)

				arg_16_1.text_.text = var_19_35

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_36 = 37
				local var_19_37 = utf8.len(var_19_35)
				local var_19_38 = var_19_36 <= 0 and var_19_32 or var_19_32 * (var_19_37 / var_19_36)

				if var_19_38 > 0 and var_19_32 < var_19_38 then
					arg_16_1.talkMaxDuration = var_19_38

					if var_19_38 + var_19_31 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_38 + var_19_31
					end
				end

				arg_16_1.text_.text = var_19_35
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071004", "story_v_out_108071.awb") ~= 0 then
					local var_19_39 = manager.audio:GetVoiceLength("story_v_out_108071", "108071004", "story_v_out_108071.awb") / 1000

					if var_19_39 + var_19_31 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_39 + var_19_31
					end

					if var_19_34.prefab_name ~= "" and arg_16_1.actors_[var_19_34.prefab_name] ~= nil then
						local var_19_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_34.prefab_name].transform, "story_v_out_108071", "108071004", "story_v_out_108071.awb")

						arg_16_1:RecordAudio("108071004", var_19_40)
						arg_16_1:RecordAudio("108071004", var_19_40)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_108071", "108071004", "story_v_out_108071.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_108071", "108071004", "story_v_out_108071.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_41 = math.max(var_19_32, arg_16_1.talkMaxDuration)

			if var_19_31 <= arg_16_1.time_ and arg_16_1.time_ < var_19_31 + var_19_41 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_31) / var_19_41

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_31 + var_19_41 and arg_16_1.time_ < var_19_31 + var_19_41 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play108071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 108071005
		arg_20_1.duration_ = 6.57

		local var_20_0 = {
			ja = 4.6,
			ko = 5.633,
			zh = 6.566,
			en = 5.633
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
				arg_20_0:Play108071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1099ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos1099ui_story = var_23_0.localPosition
			end

			local var_23_2 = 0.5

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2
				local var_23_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1099ui_story, var_23_4, var_23_3)

				local var_23_5 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_5.x, var_23_5.y, var_23_5.z)

				local var_23_6 = var_23_0.localEulerAngles

				var_23_6.z = 0
				var_23_6.x = 0
				var_23_0.localEulerAngles = var_23_6
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_23_7 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_7.x, var_23_7.y, var_23_7.z)

				local var_23_8 = var_23_0.localEulerAngles

				var_23_8.z = 0
				var_23_8.x = 0
				var_23_0.localEulerAngles = var_23_8
			end

			local var_23_9 = "1050ui_story"

			if arg_20_1.actors_[var_23_9] == nil then
				local var_23_10 = Asset.Load("Char/" .. "1050ui_story")

				if not isNil(var_23_10) then
					local var_23_11 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_20_1.stage_.transform)

					var_23_11.name = var_23_9
					var_23_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_9] = var_23_11

					local var_23_12 = var_23_11:GetComponentInChildren(typeof(CharacterEffect))

					var_23_12.enabled = true

					local var_23_13 = GameObjectTools.GetOrAddComponent(var_23_11, typeof(DynamicBoneHelper))

					if var_23_13 then
						var_23_13:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_12.transform, false)

					arg_20_1.var_[var_23_9 .. "Animator"] = var_23_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_9 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_9 .. "LipSync"] = var_23_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_14 = arg_20_1.actors_["1050ui_story"].transform
			local var_23_15 = 0

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.var_.moveOldPos1050ui_story = var_23_14.localPosition
			end

			local var_23_16 = 0.001

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_16 then
				local var_23_17 = (arg_20_1.time_ - var_23_15) / var_23_16
				local var_23_18 = Vector3.New(0.7, -1, -6.1)

				var_23_14.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1050ui_story, var_23_18, var_23_17)

				local var_23_19 = manager.ui.mainCamera.transform.position - var_23_14.position

				var_23_14.forward = Vector3.New(var_23_19.x, var_23_19.y, var_23_19.z)

				local var_23_20 = var_23_14.localEulerAngles

				var_23_20.z = 0
				var_23_20.x = 0
				var_23_14.localEulerAngles = var_23_20
			end

			if arg_20_1.time_ >= var_23_15 + var_23_16 and arg_20_1.time_ < var_23_15 + var_23_16 + arg_23_0 then
				var_23_14.localPosition = Vector3.New(0.7, -1, -6.1)

				local var_23_21 = manager.ui.mainCamera.transform.position - var_23_14.position

				var_23_14.forward = Vector3.New(var_23_21.x, var_23_21.y, var_23_21.z)

				local var_23_22 = var_23_14.localEulerAngles

				var_23_22.z = 0
				var_23_22.x = 0
				var_23_14.localEulerAngles = var_23_22
			end

			local var_23_23 = 0

			if var_23_23 < arg_20_1.time_ and arg_20_1.time_ <= var_23_23 + arg_23_0 then
				arg_20_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_1")
			end

			local var_23_24 = arg_20_1.actors_["1050ui_story"]
			local var_23_25 = 0

			if var_23_25 < arg_20_1.time_ and arg_20_1.time_ <= var_23_25 + arg_23_0 and not isNil(var_23_24) and arg_20_1.var_.characterEffect1050ui_story == nil then
				arg_20_1.var_.characterEffect1050ui_story = var_23_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_26 = 0.2

			if var_23_25 <= arg_20_1.time_ and arg_20_1.time_ < var_23_25 + var_23_26 and not isNil(var_23_24) then
				local var_23_27 = (arg_20_1.time_ - var_23_25) / var_23_26

				if arg_20_1.var_.characterEffect1050ui_story and not isNil(var_23_24) then
					arg_20_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_25 + var_23_26 and arg_20_1.time_ < var_23_25 + var_23_26 + arg_23_0 and not isNil(var_23_24) and arg_20_1.var_.characterEffect1050ui_story then
				arg_20_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_23_28 = arg_20_1.actors_["1099ui_story"]
			local var_23_29 = 0

			if var_23_29 < arg_20_1.time_ and arg_20_1.time_ <= var_23_29 + arg_23_0 and not isNil(var_23_28) and arg_20_1.var_.characterEffect1099ui_story == nil then
				arg_20_1.var_.characterEffect1099ui_story = var_23_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_30 = 0.0166666666666667

			if var_23_29 <= arg_20_1.time_ and arg_20_1.time_ < var_23_29 + var_23_30 and not isNil(var_23_28) then
				local var_23_31 = (arg_20_1.time_ - var_23_29) / var_23_30

				if arg_20_1.var_.characterEffect1099ui_story and not isNil(var_23_28) then
					local var_23_32 = Mathf.Lerp(0, 0.5, var_23_31)

					arg_20_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1099ui_story.fillRatio = var_23_32
				end
			end

			if arg_20_1.time_ >= var_23_29 + var_23_30 and arg_20_1.time_ < var_23_29 + var_23_30 + arg_23_0 and not isNil(var_23_28) and arg_20_1.var_.characterEffect1099ui_story then
				local var_23_33 = 0.5

				arg_20_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1099ui_story.fillRatio = var_23_33
			end

			local var_23_34 = 0

			if var_23_34 < arg_20_1.time_ and arg_20_1.time_ <= var_23_34 + arg_23_0 then
				arg_20_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_23_35 = 0
			local var_23_36 = 0.625

			if var_23_35 < arg_20_1.time_ and arg_20_1.time_ <= var_23_35 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_37 = arg_20_1:FormatText(StoryNameCfg[74].name)

				arg_20_1.leftNameTxt_.text = var_23_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_38 = arg_20_1:GetWordFromCfg(108071005)
				local var_23_39 = arg_20_1:FormatText(var_23_38.content)

				arg_20_1.text_.text = var_23_39

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_40 = 25
				local var_23_41 = utf8.len(var_23_39)
				local var_23_42 = var_23_40 <= 0 and var_23_36 or var_23_36 * (var_23_41 / var_23_40)

				if var_23_42 > 0 and var_23_36 < var_23_42 then
					arg_20_1.talkMaxDuration = var_23_42

					if var_23_42 + var_23_35 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_42 + var_23_35
					end
				end

				arg_20_1.text_.text = var_23_39
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071005", "story_v_out_108071.awb") ~= 0 then
					local var_23_43 = manager.audio:GetVoiceLength("story_v_out_108071", "108071005", "story_v_out_108071.awb") / 1000

					if var_23_43 + var_23_35 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_43 + var_23_35
					end

					if var_23_38.prefab_name ~= "" and arg_20_1.actors_[var_23_38.prefab_name] ~= nil then
						local var_23_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_38.prefab_name].transform, "story_v_out_108071", "108071005", "story_v_out_108071.awb")

						arg_20_1:RecordAudio("108071005", var_23_44)
						arg_20_1:RecordAudio("108071005", var_23_44)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_108071", "108071005", "story_v_out_108071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_108071", "108071005", "story_v_out_108071.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_45 = math.max(var_23_36, arg_20_1.talkMaxDuration)

			if var_23_35 <= arg_20_1.time_ and arg_20_1.time_ < var_23_35 + var_23_45 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_35) / var_23_45

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_35 + var_23_45 and arg_20_1.time_ < var_23_35 + var_23_45 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play108071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 108071006
		arg_24_1.duration_ = 21.97

		local var_24_0 = {
			ja = 21.966,
			ko = 15.4,
			zh = 18.333,
			en = 21.033
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
				arg_24_0:Play108071007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1099ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1099ui_story = var_27_0.localPosition
			end

			local var_27_2 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2
				local var_27_4 = Vector3.New(0, 100, 0)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1099ui_story, var_27_4, var_27_3)

				local var_27_5 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_5.x, var_27_5.y, var_27_5.z)

				local var_27_6 = var_27_0.localEulerAngles

				var_27_6.z = 0
				var_27_6.x = 0
				var_27_0.localEulerAngles = var_27_6
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, 100, 0)

				local var_27_7 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_7.x, var_27_7.y, var_27_7.z)

				local var_27_8 = var_27_0.localEulerAngles

				var_27_8.z = 0
				var_27_8.x = 0
				var_27_0.localEulerAngles = var_27_8
			end

			local var_27_9 = arg_24_1.actors_["1050ui_story"].transform
			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.var_.moveOldPos1050ui_story = var_27_9.localPosition
			end

			local var_27_11 = 0.001

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_11 then
				local var_27_12 = (arg_24_1.time_ - var_27_10) / var_27_11
				local var_27_13 = Vector3.New(0, 100, 0)

				var_27_9.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1050ui_story, var_27_13, var_27_12)

				local var_27_14 = manager.ui.mainCamera.transform.position - var_27_9.position

				var_27_9.forward = Vector3.New(var_27_14.x, var_27_14.y, var_27_14.z)

				local var_27_15 = var_27_9.localEulerAngles

				var_27_15.z = 0
				var_27_15.x = 0
				var_27_9.localEulerAngles = var_27_15
			end

			if arg_24_1.time_ >= var_27_10 + var_27_11 and arg_24_1.time_ < var_27_10 + var_27_11 + arg_27_0 then
				var_27_9.localPosition = Vector3.New(0, 100, 0)

				local var_27_16 = manager.ui.mainCamera.transform.position - var_27_9.position

				var_27_9.forward = Vector3.New(var_27_16.x, var_27_16.y, var_27_16.z)

				local var_27_17 = var_27_9.localEulerAngles

				var_27_17.z = 0
				var_27_17.x = 0
				var_27_9.localEulerAngles = var_27_17
			end

			local var_27_18 = arg_24_1.actors_["3014_tpose"].transform
			local var_27_19 = 0

			if var_27_19 < arg_24_1.time_ and arg_24_1.time_ <= var_27_19 + arg_27_0 then
				arg_24_1.var_.moveOldPos3014_tpose = var_27_18.localPosition

				local var_27_20 = GameObjectTools.GetOrAddComponent(var_27_18.gameObject, typeof(DynamicBoneHelper))

				if var_27_20 then
					var_27_20:EnableDynamicBone(false)
				end
			end

			local var_27_21 = 0.001

			if var_27_19 <= arg_24_1.time_ and arg_24_1.time_ < var_27_19 + var_27_21 then
				local var_27_22 = (arg_24_1.time_ - var_27_19) / var_27_21
				local var_27_23 = Vector3.New(0, -2.35, -2.9)

				var_27_18.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos3014_tpose, var_27_23, var_27_22)

				local var_27_24 = manager.ui.mainCamera.transform.position - var_27_18.position

				var_27_18.forward = Vector3.New(var_27_24.x, var_27_24.y, var_27_24.z)

				local var_27_25 = var_27_18.localEulerAngles

				var_27_25.z = 0
				var_27_25.x = 0
				var_27_18.localEulerAngles = var_27_25
			end

			if arg_24_1.time_ >= var_27_19 + var_27_21 and arg_24_1.time_ < var_27_19 + var_27_21 + arg_27_0 then
				var_27_18.localPosition = Vector3.New(0, -2.35, -2.9)

				local var_27_26 = manager.ui.mainCamera.transform.position - var_27_18.position

				var_27_18.forward = Vector3.New(var_27_26.x, var_27_26.y, var_27_26.z)

				local var_27_27 = var_27_18.localEulerAngles

				var_27_27.z = 0
				var_27_27.x = 0
				var_27_18.localEulerAngles = var_27_27

				local var_27_28 = GameObjectTools.GetOrAddComponent(var_27_18.gameObject, typeof(DynamicBoneHelper))

				if var_27_28 then
					var_27_28:EnableDynamicBone(true)
				end
			end

			local var_27_29 = arg_24_1.actors_["3014_tpose"]
			local var_27_30 = 0

			if var_27_30 < arg_24_1.time_ and arg_24_1.time_ <= var_27_30 + arg_27_0 and not isNil(var_27_29) and arg_24_1.var_.characterEffect3014_tpose == nil then
				arg_24_1.var_.characterEffect3014_tpose = var_27_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_31 = 0.2

			if var_27_30 <= arg_24_1.time_ and arg_24_1.time_ < var_27_30 + var_27_31 and not isNil(var_27_29) then
				local var_27_32 = (arg_24_1.time_ - var_27_30) / var_27_31

				if arg_24_1.var_.characterEffect3014_tpose and not isNil(var_27_29) then
					arg_24_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_30 + var_27_31 and arg_24_1.time_ < var_27_30 + var_27_31 + arg_27_0 and not isNil(var_27_29) and arg_24_1.var_.characterEffect3014_tpose then
				arg_24_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_27_33 = 0

			if var_27_33 < arg_24_1.time_ and arg_24_1.time_ <= var_27_33 + arg_27_0 then
				arg_24_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_27_34 = 0
			local var_27_35 = 1.375

			if var_27_34 < arg_24_1.time_ and arg_24_1.time_ <= var_27_34 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_36 = arg_24_1:FormatText(StoryNameCfg[96].name)

				arg_24_1.leftNameTxt_.text = var_27_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_37 = arg_24_1:GetWordFromCfg(108071006)
				local var_27_38 = arg_24_1:FormatText(var_27_37.content)

				arg_24_1.text_.text = var_27_38

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_39 = 55
				local var_27_40 = utf8.len(var_27_38)
				local var_27_41 = var_27_39 <= 0 and var_27_35 or var_27_35 * (var_27_40 / var_27_39)

				if var_27_41 > 0 and var_27_35 < var_27_41 then
					arg_24_1.talkMaxDuration = var_27_41

					if var_27_41 + var_27_34 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_41 + var_27_34
					end
				end

				arg_24_1.text_.text = var_27_38
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071006", "story_v_out_108071.awb") ~= 0 then
					local var_27_42 = manager.audio:GetVoiceLength("story_v_out_108071", "108071006", "story_v_out_108071.awb") / 1000

					if var_27_42 + var_27_34 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_42 + var_27_34
					end

					if var_27_37.prefab_name ~= "" and arg_24_1.actors_[var_27_37.prefab_name] ~= nil then
						local var_27_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_37.prefab_name].transform, "story_v_out_108071", "108071006", "story_v_out_108071.awb")

						arg_24_1:RecordAudio("108071006", var_27_43)
						arg_24_1:RecordAudio("108071006", var_27_43)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_108071", "108071006", "story_v_out_108071.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_108071", "108071006", "story_v_out_108071.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_44 = math.max(var_27_35, arg_24_1.talkMaxDuration)

			if var_27_34 <= arg_24_1.time_ and arg_24_1.time_ < var_27_34 + var_27_44 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_34) / var_27_44

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_34 + var_27_44 and arg_24_1.time_ < var_27_34 + var_27_44 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play108071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 108071007
		arg_28_1.duration_ = 7.2

		local var_28_0 = {
			ja = 6.666,
			ko = 6.1,
			zh = 5.2,
			en = 7.2
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
				arg_28_0:Play108071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["3014_tpose"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos3014_tpose = var_31_0.localPosition

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end
			end

			local var_31_3 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_3 then
				local var_31_4 = (arg_28_1.time_ - var_31_1) / var_31_3
				local var_31_5 = Vector3.New(0, 100, 0)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3014_tpose, var_31_5, var_31_4)

				local var_31_6 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_6.x, var_31_6.y, var_31_6.z)

				local var_31_7 = var_31_0.localEulerAngles

				var_31_7.z = 0
				var_31_7.x = 0
				var_31_0.localEulerAngles = var_31_7
			end

			if arg_28_1.time_ >= var_31_1 + var_31_3 and arg_28_1.time_ < var_31_1 + var_31_3 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0, 100, 0)

				local var_31_8 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_8.x, var_31_8.y, var_31_8.z)

				local var_31_9 = var_31_0.localEulerAngles

				var_31_9.z = 0
				var_31_9.x = 0
				var_31_0.localEulerAngles = var_31_9

				local var_31_10 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_10 then
					var_31_10:EnableDynamicBone(true)
				end
			end

			local var_31_11 = arg_28_1.actors_["1050ui_story"].transform
			local var_31_12 = 0

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.var_.moveOldPos1050ui_story = var_31_11.localPosition
			end

			local var_31_13 = 0.001

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_13 then
				local var_31_14 = (arg_28_1.time_ - var_31_12) / var_31_13
				local var_31_15 = Vector3.New(0, -1, -6.1)

				var_31_11.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1050ui_story, var_31_15, var_31_14)

				local var_31_16 = manager.ui.mainCamera.transform.position - var_31_11.position

				var_31_11.forward = Vector3.New(var_31_16.x, var_31_16.y, var_31_16.z)

				local var_31_17 = var_31_11.localEulerAngles

				var_31_17.z = 0
				var_31_17.x = 0
				var_31_11.localEulerAngles = var_31_17
			end

			if arg_28_1.time_ >= var_31_12 + var_31_13 and arg_28_1.time_ < var_31_12 + var_31_13 + arg_31_0 then
				var_31_11.localPosition = Vector3.New(0, -1, -6.1)

				local var_31_18 = manager.ui.mainCamera.transform.position - var_31_11.position

				var_31_11.forward = Vector3.New(var_31_18.x, var_31_18.y, var_31_18.z)

				local var_31_19 = var_31_11.localEulerAngles

				var_31_19.z = 0
				var_31_19.x = 0
				var_31_11.localEulerAngles = var_31_19
			end

			local var_31_20 = 0

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			local var_31_21 = arg_28_1.actors_["1050ui_story"]
			local var_31_22 = 0

			if var_31_22 < arg_28_1.time_ and arg_28_1.time_ <= var_31_22 + arg_31_0 and not isNil(var_31_21) and arg_28_1.var_.characterEffect1050ui_story == nil then
				arg_28_1.var_.characterEffect1050ui_story = var_31_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_23 = 0.2

			if var_31_22 <= arg_28_1.time_ and arg_28_1.time_ < var_31_22 + var_31_23 and not isNil(var_31_21) then
				local var_31_24 = (arg_28_1.time_ - var_31_22) / var_31_23

				if arg_28_1.var_.characterEffect1050ui_story and not isNil(var_31_21) then
					arg_28_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_22 + var_31_23 and arg_28_1.time_ < var_31_22 + var_31_23 + arg_31_0 and not isNil(var_31_21) and arg_28_1.var_.characterEffect1050ui_story then
				arg_28_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_31_25 = 0
			local var_31_26 = 0.65

			if var_31_25 < arg_28_1.time_ and arg_28_1.time_ <= var_31_25 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_27 = arg_28_1:FormatText(StoryNameCfg[74].name)

				arg_28_1.leftNameTxt_.text = var_31_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_28 = arg_28_1:GetWordFromCfg(108071007)
				local var_31_29 = arg_28_1:FormatText(var_31_28.content)

				arg_28_1.text_.text = var_31_29

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_30 = 26
				local var_31_31 = utf8.len(var_31_29)
				local var_31_32 = var_31_30 <= 0 and var_31_26 or var_31_26 * (var_31_31 / var_31_30)

				if var_31_32 > 0 and var_31_26 < var_31_32 then
					arg_28_1.talkMaxDuration = var_31_32

					if var_31_32 + var_31_25 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_32 + var_31_25
					end
				end

				arg_28_1.text_.text = var_31_29
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071007", "story_v_out_108071.awb") ~= 0 then
					local var_31_33 = manager.audio:GetVoiceLength("story_v_out_108071", "108071007", "story_v_out_108071.awb") / 1000

					if var_31_33 + var_31_25 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_33 + var_31_25
					end

					if var_31_28.prefab_name ~= "" and arg_28_1.actors_[var_31_28.prefab_name] ~= nil then
						local var_31_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_28.prefab_name].transform, "story_v_out_108071", "108071007", "story_v_out_108071.awb")

						arg_28_1:RecordAudio("108071007", var_31_34)
						arg_28_1:RecordAudio("108071007", var_31_34)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_108071", "108071007", "story_v_out_108071.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_108071", "108071007", "story_v_out_108071.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_35 = math.max(var_31_26, arg_28_1.talkMaxDuration)

			if var_31_25 <= arg_28_1.time_ and arg_28_1.time_ < var_31_25 + var_31_35 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_25) / var_31_35

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_25 + var_31_35 and arg_28_1.time_ < var_31_25 + var_31_35 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play108071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 108071008
		arg_32_1.duration_ = 15.7

		local var_32_0 = {
			ja = 15.7,
			ko = 9.7,
			zh = 10.533,
			en = 10.866
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
				arg_32_0:Play108071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1050ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos1050ui_story = var_35_0.localPosition
			end

			local var_35_2 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2
				local var_35_4 = Vector3.New(0, 100, 0)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1050ui_story, var_35_4, var_35_3)

				local var_35_5 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_5.x, var_35_5.y, var_35_5.z)

				local var_35_6 = var_35_0.localEulerAngles

				var_35_6.z = 0
				var_35_6.x = 0
				var_35_0.localEulerAngles = var_35_6
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, 100, 0)

				local var_35_7 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_7.x, var_35_7.y, var_35_7.z)

				local var_35_8 = var_35_0.localEulerAngles

				var_35_8.z = 0
				var_35_8.x = 0
				var_35_0.localEulerAngles = var_35_8
			end

			local var_35_9 = arg_32_1.actors_["3014_tpose"].transform
			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.var_.moveOldPos3014_tpose = var_35_9.localPosition

				local var_35_11 = GameObjectTools.GetOrAddComponent(var_35_9.gameObject, typeof(DynamicBoneHelper))

				if var_35_11 then
					var_35_11:EnableDynamicBone(false)
				end
			end

			local var_35_12 = 0.001

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_12 then
				local var_35_13 = (arg_32_1.time_ - var_35_10) / var_35_12
				local var_35_14 = Vector3.New(0, -2.35, -2.9)

				var_35_9.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos3014_tpose, var_35_14, var_35_13)

				local var_35_15 = manager.ui.mainCamera.transform.position - var_35_9.position

				var_35_9.forward = Vector3.New(var_35_15.x, var_35_15.y, var_35_15.z)

				local var_35_16 = var_35_9.localEulerAngles

				var_35_16.z = 0
				var_35_16.x = 0
				var_35_9.localEulerAngles = var_35_16
			end

			if arg_32_1.time_ >= var_35_10 + var_35_12 and arg_32_1.time_ < var_35_10 + var_35_12 + arg_35_0 then
				var_35_9.localPosition = Vector3.New(0, -2.35, -2.9)

				local var_35_17 = manager.ui.mainCamera.transform.position - var_35_9.position

				var_35_9.forward = Vector3.New(var_35_17.x, var_35_17.y, var_35_17.z)

				local var_35_18 = var_35_9.localEulerAngles

				var_35_18.z = 0
				var_35_18.x = 0
				var_35_9.localEulerAngles = var_35_18

				local var_35_19 = GameObjectTools.GetOrAddComponent(var_35_9.gameObject, typeof(DynamicBoneHelper))

				if var_35_19 then
					var_35_19:EnableDynamicBone(true)
				end
			end

			local var_35_20 = arg_32_1.actors_["3014_tpose"]
			local var_35_21 = 0

			if var_35_21 < arg_32_1.time_ and arg_32_1.time_ <= var_35_21 + arg_35_0 and not isNil(var_35_20) and arg_32_1.var_.characterEffect3014_tpose == nil then
				arg_32_1.var_.characterEffect3014_tpose = var_35_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_22 = 0.2

			if var_35_21 <= arg_32_1.time_ and arg_32_1.time_ < var_35_21 + var_35_22 and not isNil(var_35_20) then
				local var_35_23 = (arg_32_1.time_ - var_35_21) / var_35_22

				if arg_32_1.var_.characterEffect3014_tpose and not isNil(var_35_20) then
					arg_32_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_21 + var_35_22 and arg_32_1.time_ < var_35_21 + var_35_22 + arg_35_0 and not isNil(var_35_20) and arg_32_1.var_.characterEffect3014_tpose then
				arg_32_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_35_24 = 0

			if var_35_24 < arg_32_1.time_ and arg_32_1.time_ <= var_35_24 + arg_35_0 then
				arg_32_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_35_25 = 0
			local var_35_26 = 0.875

			if var_35_25 < arg_32_1.time_ and arg_32_1.time_ <= var_35_25 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_27 = arg_32_1:FormatText(StoryNameCfg[96].name)

				arg_32_1.leftNameTxt_.text = var_35_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_28 = arg_32_1:GetWordFromCfg(108071008)
				local var_35_29 = arg_32_1:FormatText(var_35_28.content)

				arg_32_1.text_.text = var_35_29

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_30 = 34
				local var_35_31 = utf8.len(var_35_29)
				local var_35_32 = var_35_30 <= 0 and var_35_26 or var_35_26 * (var_35_31 / var_35_30)

				if var_35_32 > 0 and var_35_26 < var_35_32 then
					arg_32_1.talkMaxDuration = var_35_32

					if var_35_32 + var_35_25 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_32 + var_35_25
					end
				end

				arg_32_1.text_.text = var_35_29
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071008", "story_v_out_108071.awb") ~= 0 then
					local var_35_33 = manager.audio:GetVoiceLength("story_v_out_108071", "108071008", "story_v_out_108071.awb") / 1000

					if var_35_33 + var_35_25 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_33 + var_35_25
					end

					if var_35_28.prefab_name ~= "" and arg_32_1.actors_[var_35_28.prefab_name] ~= nil then
						local var_35_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_28.prefab_name].transform, "story_v_out_108071", "108071008", "story_v_out_108071.awb")

						arg_32_1:RecordAudio("108071008", var_35_34)
						arg_32_1:RecordAudio("108071008", var_35_34)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_108071", "108071008", "story_v_out_108071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_108071", "108071008", "story_v_out_108071.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_35 = math.max(var_35_26, arg_32_1.talkMaxDuration)

			if var_35_25 <= arg_32_1.time_ and arg_32_1.time_ < var_35_25 + var_35_35 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_25) / var_35_35

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_25 + var_35_35 and arg_32_1.time_ < var_35_25 + var_35_35 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play108071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 108071009
		arg_36_1.duration_ = 21.03

		local var_36_0 = {
			ja = 21.033,
			ko = 9.533,
			zh = 12.566,
			en = 12.3
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
				arg_36_0:Play108071010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 1.15

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[96].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:GetWordFromCfg(108071009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071009", "story_v_out_108071.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_108071", "108071009", "story_v_out_108071.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_108071", "108071009", "story_v_out_108071.awb")

						arg_36_1:RecordAudio("108071009", var_39_9)
						arg_36_1:RecordAudio("108071009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_108071", "108071009", "story_v_out_108071.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_108071", "108071009", "story_v_out_108071.awb")
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
	Play108071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 108071010
		arg_40_1.duration_ = 19.17

		local var_40_0 = {
			ja = 19.166,
			ko = 14.266,
			zh = 12.8,
			en = 11.666
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
				arg_40_0:Play108071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 1.25

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[96].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(108071010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 47
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

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071010", "story_v_out_108071.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_108071", "108071010", "story_v_out_108071.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_108071", "108071010", "story_v_out_108071.awb")

						arg_40_1:RecordAudio("108071010", var_43_9)
						arg_40_1:RecordAudio("108071010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_108071", "108071010", "story_v_out_108071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_108071", "108071010", "story_v_out_108071.awb")
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
	Play108071011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 108071011
		arg_44_1.duration_ = 4.5

		local var_44_0 = {
			ja = 2.9,
			ko = 3.566,
			zh = 4.233,
			en = 4.5
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
				arg_44_0:Play108071012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["3014_tpose"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos3014_tpose = var_47_0.localPosition

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end
			end

			local var_47_3 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_3 then
				local var_47_4 = (arg_44_1.time_ - var_47_1) / var_47_3
				local var_47_5 = Vector3.New(0, 100, 0)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos3014_tpose, var_47_5, var_47_4)

				local var_47_6 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_6.x, var_47_6.y, var_47_6.z)

				local var_47_7 = var_47_0.localEulerAngles

				var_47_7.z = 0
				var_47_7.x = 0
				var_47_0.localEulerAngles = var_47_7
			end

			if arg_44_1.time_ >= var_47_1 + var_47_3 and arg_44_1.time_ < var_47_1 + var_47_3 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, 100, 0)

				local var_47_8 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_8.x, var_47_8.y, var_47_8.z)

				local var_47_9 = var_47_0.localEulerAngles

				var_47_9.z = 0
				var_47_9.x = 0
				var_47_0.localEulerAngles = var_47_9

				local var_47_10 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_10 then
					var_47_10:EnableDynamicBone(true)
				end
			end

			local var_47_11 = arg_44_1.actors_["1050ui_story"].transform
			local var_47_12 = 0

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.var_.moveOldPos1050ui_story = var_47_11.localPosition
			end

			local var_47_13 = 0.001

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_13 then
				local var_47_14 = (arg_44_1.time_ - var_47_12) / var_47_13
				local var_47_15 = Vector3.New(0, -1, -6.1)

				var_47_11.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1050ui_story, var_47_15, var_47_14)

				local var_47_16 = manager.ui.mainCamera.transform.position - var_47_11.position

				var_47_11.forward = Vector3.New(var_47_16.x, var_47_16.y, var_47_16.z)

				local var_47_17 = var_47_11.localEulerAngles

				var_47_17.z = 0
				var_47_17.x = 0
				var_47_11.localEulerAngles = var_47_17
			end

			if arg_44_1.time_ >= var_47_12 + var_47_13 and arg_44_1.time_ < var_47_12 + var_47_13 + arg_47_0 then
				var_47_11.localPosition = Vector3.New(0, -1, -6.1)

				local var_47_18 = manager.ui.mainCamera.transform.position - var_47_11.position

				var_47_11.forward = Vector3.New(var_47_18.x, var_47_18.y, var_47_18.z)

				local var_47_19 = var_47_11.localEulerAngles

				var_47_19.z = 0
				var_47_19.x = 0
				var_47_11.localEulerAngles = var_47_19
			end

			local var_47_20 = arg_44_1.actors_["1050ui_story"]
			local var_47_21 = 0

			if var_47_21 < arg_44_1.time_ and arg_44_1.time_ <= var_47_21 + arg_47_0 and not isNil(var_47_20) and arg_44_1.var_.characterEffect1050ui_story == nil then
				arg_44_1.var_.characterEffect1050ui_story = var_47_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_22 = 0.2

			if var_47_21 <= arg_44_1.time_ and arg_44_1.time_ < var_47_21 + var_47_22 and not isNil(var_47_20) then
				local var_47_23 = (arg_44_1.time_ - var_47_21) / var_47_22

				if arg_44_1.var_.characterEffect1050ui_story and not isNil(var_47_20) then
					arg_44_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_21 + var_47_22 and arg_44_1.time_ < var_47_21 + var_47_22 + arg_47_0 and not isNil(var_47_20) and arg_44_1.var_.characterEffect1050ui_story then
				arg_44_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_47_24 = 0

			if var_47_24 < arg_44_1.time_ and arg_44_1.time_ <= var_47_24 + arg_47_0 then
				arg_44_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_47_25 = 0
			local var_47_26 = 0.45

			if var_47_25 < arg_44_1.time_ and arg_44_1.time_ <= var_47_25 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_27 = arg_44_1:FormatText(StoryNameCfg[74].name)

				arg_44_1.leftNameTxt_.text = var_47_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_28 = arg_44_1:GetWordFromCfg(108071011)
				local var_47_29 = arg_44_1:FormatText(var_47_28.content)

				arg_44_1.text_.text = var_47_29

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_30 = 18
				local var_47_31 = utf8.len(var_47_29)
				local var_47_32 = var_47_30 <= 0 and var_47_26 or var_47_26 * (var_47_31 / var_47_30)

				if var_47_32 > 0 and var_47_26 < var_47_32 then
					arg_44_1.talkMaxDuration = var_47_32

					if var_47_32 + var_47_25 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_32 + var_47_25
					end
				end

				arg_44_1.text_.text = var_47_29
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071011", "story_v_out_108071.awb") ~= 0 then
					local var_47_33 = manager.audio:GetVoiceLength("story_v_out_108071", "108071011", "story_v_out_108071.awb") / 1000

					if var_47_33 + var_47_25 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_33 + var_47_25
					end

					if var_47_28.prefab_name ~= "" and arg_44_1.actors_[var_47_28.prefab_name] ~= nil then
						local var_47_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_28.prefab_name].transform, "story_v_out_108071", "108071011", "story_v_out_108071.awb")

						arg_44_1:RecordAudio("108071011", var_47_34)
						arg_44_1:RecordAudio("108071011", var_47_34)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_108071", "108071011", "story_v_out_108071.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_108071", "108071011", "story_v_out_108071.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_35 = math.max(var_47_26, arg_44_1.talkMaxDuration)

			if var_47_25 <= arg_44_1.time_ and arg_44_1.time_ < var_47_25 + var_47_35 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_25) / var_47_35

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_25 + var_47_35 and arg_44_1.time_ < var_47_25 + var_47_35 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play108071012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 108071012
		arg_48_1.duration_ = 8.67

		local var_48_0 = {
			ja = 8.566,
			ko = 5.033,
			zh = 5.133,
			en = 8.666
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
				arg_48_0:Play108071013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1050ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos1050ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.5

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(-0.7, -1, -6.1)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1050ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(-0.7, -1, -6.1)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = arg_48_1.actors_["1099ui_story"].transform
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.var_.moveOldPos1099ui_story = var_51_9.localPosition
			end

			local var_51_11 = 0.001

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11
				local var_51_13 = Vector3.New(0.7, -1.08, -5.9)

				var_51_9.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1099ui_story, var_51_13, var_51_12)

				local var_51_14 = manager.ui.mainCamera.transform.position - var_51_9.position

				var_51_9.forward = Vector3.New(var_51_14.x, var_51_14.y, var_51_14.z)

				local var_51_15 = var_51_9.localEulerAngles

				var_51_15.z = 0
				var_51_15.x = 0
				var_51_9.localEulerAngles = var_51_15
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 then
				var_51_9.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_51_16 = manager.ui.mainCamera.transform.position - var_51_9.position

				var_51_9.forward = Vector3.New(var_51_16.x, var_51_16.y, var_51_16.z)

				local var_51_17 = var_51_9.localEulerAngles

				var_51_17.z = 0
				var_51_17.x = 0
				var_51_9.localEulerAngles = var_51_17
			end

			local var_51_18 = arg_48_1.actors_["1099ui_story"]
			local var_51_19 = 0

			if var_51_19 < arg_48_1.time_ and arg_48_1.time_ <= var_51_19 + arg_51_0 and not isNil(var_51_18) and arg_48_1.var_.characterEffect1099ui_story == nil then
				arg_48_1.var_.characterEffect1099ui_story = var_51_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_20 = 0.2

			if var_51_19 <= arg_48_1.time_ and arg_48_1.time_ < var_51_19 + var_51_20 and not isNil(var_51_18) then
				local var_51_21 = (arg_48_1.time_ - var_51_19) / var_51_20

				if arg_48_1.var_.characterEffect1099ui_story and not isNil(var_51_18) then
					arg_48_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_19 + var_51_20 and arg_48_1.time_ < var_51_19 + var_51_20 + arg_51_0 and not isNil(var_51_18) and arg_48_1.var_.characterEffect1099ui_story then
				arg_48_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_51_22 = arg_48_1.actors_["1050ui_story"]
			local var_51_23 = 0

			if var_51_23 < arg_48_1.time_ and arg_48_1.time_ <= var_51_23 + arg_51_0 and not isNil(var_51_22) and arg_48_1.var_.characterEffect1050ui_story == nil then
				arg_48_1.var_.characterEffect1050ui_story = var_51_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_24 = 0.2

			if var_51_23 <= arg_48_1.time_ and arg_48_1.time_ < var_51_23 + var_51_24 and not isNil(var_51_22) then
				local var_51_25 = (arg_48_1.time_ - var_51_23) / var_51_24

				if arg_48_1.var_.characterEffect1050ui_story and not isNil(var_51_22) then
					local var_51_26 = Mathf.Lerp(0, 0.5, var_51_25)

					arg_48_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1050ui_story.fillRatio = var_51_26
				end
			end

			if arg_48_1.time_ >= var_51_23 + var_51_24 and arg_48_1.time_ < var_51_23 + var_51_24 + arg_51_0 and not isNil(var_51_22) and arg_48_1.var_.characterEffect1050ui_story then
				local var_51_27 = 0.5

				arg_48_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1050ui_story.fillRatio = var_51_27
			end

			local var_51_28 = 0

			if var_51_28 < arg_48_1.time_ and arg_48_1.time_ <= var_51_28 + arg_51_0 then
				arg_48_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			local var_51_29 = 0

			if var_51_29 < arg_48_1.time_ and arg_48_1.time_ <= var_51_29 + arg_51_0 then
				arg_48_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_51_30 = 0
			local var_51_31 = 0.65

			if var_51_30 < arg_48_1.time_ and arg_48_1.time_ <= var_51_30 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_32 = arg_48_1:FormatText(StoryNameCfg[84].name)

				arg_48_1.leftNameTxt_.text = var_51_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_33 = arg_48_1:GetWordFromCfg(108071012)
				local var_51_34 = arg_48_1:FormatText(var_51_33.content)

				arg_48_1.text_.text = var_51_34

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_35 = 26
				local var_51_36 = utf8.len(var_51_34)
				local var_51_37 = var_51_35 <= 0 and var_51_31 or var_51_31 * (var_51_36 / var_51_35)

				if var_51_37 > 0 and var_51_31 < var_51_37 then
					arg_48_1.talkMaxDuration = var_51_37

					if var_51_37 + var_51_30 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_37 + var_51_30
					end
				end

				arg_48_1.text_.text = var_51_34
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071012", "story_v_out_108071.awb") ~= 0 then
					local var_51_38 = manager.audio:GetVoiceLength("story_v_out_108071", "108071012", "story_v_out_108071.awb") / 1000

					if var_51_38 + var_51_30 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_38 + var_51_30
					end

					if var_51_33.prefab_name ~= "" and arg_48_1.actors_[var_51_33.prefab_name] ~= nil then
						local var_51_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_33.prefab_name].transform, "story_v_out_108071", "108071012", "story_v_out_108071.awb")

						arg_48_1:RecordAudio("108071012", var_51_39)
						arg_48_1:RecordAudio("108071012", var_51_39)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_108071", "108071012", "story_v_out_108071.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_108071", "108071012", "story_v_out_108071.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_40 = math.max(var_51_31, arg_48_1.talkMaxDuration)

			if var_51_30 <= arg_48_1.time_ and arg_48_1.time_ < var_51_30 + var_51_40 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_30) / var_51_40

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_30 + var_51_40 and arg_48_1.time_ < var_51_30 + var_51_40 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play108071013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 108071013
		arg_52_1.duration_ = 10.43

		local var_52_0 = {
			ja = 10.066,
			ko = 8.366,
			zh = 7.733,
			en = 10.433
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
				arg_52_0:Play108071014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_55_1 = 0
			local var_55_2 = 1.025

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_3 = arg_52_1:FormatText(StoryNameCfg[84].name)

				arg_52_1.leftNameTxt_.text = var_55_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_4 = arg_52_1:GetWordFromCfg(108071013)
				local var_55_5 = arg_52_1:FormatText(var_55_4.content)

				arg_52_1.text_.text = var_55_5

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_6 = 41
				local var_55_7 = utf8.len(var_55_5)
				local var_55_8 = var_55_6 <= 0 and var_55_2 or var_55_2 * (var_55_7 / var_55_6)

				if var_55_8 > 0 and var_55_2 < var_55_8 then
					arg_52_1.talkMaxDuration = var_55_8

					if var_55_8 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_5
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071013", "story_v_out_108071.awb") ~= 0 then
					local var_55_9 = manager.audio:GetVoiceLength("story_v_out_108071", "108071013", "story_v_out_108071.awb") / 1000

					if var_55_9 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_1
					end

					if var_55_4.prefab_name ~= "" and arg_52_1.actors_[var_55_4.prefab_name] ~= nil then
						local var_55_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_4.prefab_name].transform, "story_v_out_108071", "108071013", "story_v_out_108071.awb")

						arg_52_1:RecordAudio("108071013", var_55_10)
						arg_52_1:RecordAudio("108071013", var_55_10)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_108071", "108071013", "story_v_out_108071.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_108071", "108071013", "story_v_out_108071.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_11 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_11 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_11

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_11 and arg_52_1.time_ < var_55_1 + var_55_11 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play108071014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 108071014
		arg_56_1.duration_ = 11.63

		local var_56_0 = {
			ja = 11.633,
			ko = 7.9,
			zh = 7.766,
			en = 9.4
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
				arg_56_0:Play108071015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_59_1 = 0
			local var_59_2 = 1

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_3 = arg_56_1:FormatText(StoryNameCfg[84].name)

				arg_56_1.leftNameTxt_.text = var_59_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_4 = arg_56_1:GetWordFromCfg(108071014)
				local var_59_5 = arg_56_1:FormatText(var_59_4.content)

				arg_56_1.text_.text = var_59_5

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 40
				local var_59_7 = utf8.len(var_59_5)
				local var_59_8 = var_59_6 <= 0 and var_59_2 or var_59_2 * (var_59_7 / var_59_6)

				if var_59_8 > 0 and var_59_2 < var_59_8 then
					arg_56_1.talkMaxDuration = var_59_8

					if var_59_8 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_5
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071014", "story_v_out_108071.awb") ~= 0 then
					local var_59_9 = manager.audio:GetVoiceLength("story_v_out_108071", "108071014", "story_v_out_108071.awb") / 1000

					if var_59_9 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_1
					end

					if var_59_4.prefab_name ~= "" and arg_56_1.actors_[var_59_4.prefab_name] ~= nil then
						local var_59_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_4.prefab_name].transform, "story_v_out_108071", "108071014", "story_v_out_108071.awb")

						arg_56_1:RecordAudio("108071014", var_59_10)
						arg_56_1:RecordAudio("108071014", var_59_10)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_108071", "108071014", "story_v_out_108071.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_108071", "108071014", "story_v_out_108071.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_11 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_11 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_11

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_11 and arg_56_1.time_ < var_59_1 + var_59_11 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play108071015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 108071015
		arg_60_1.duration_ = 11.27

		local var_60_0 = {
			ja = 11.266,
			ko = 3.7,
			zh = 3.2,
			en = 4.866
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
				arg_60_0:Play108071016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_63_1 = 0
			local var_63_2 = 0.325

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_3 = arg_60_1:FormatText(StoryNameCfg[84].name)

				arg_60_1.leftNameTxt_.text = var_63_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_4 = arg_60_1:GetWordFromCfg(108071015)
				local var_63_5 = arg_60_1:FormatText(var_63_4.content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_6 = 13
				local var_63_7 = utf8.len(var_63_5)
				local var_63_8 = var_63_6 <= 0 and var_63_2 or var_63_2 * (var_63_7 / var_63_6)

				if var_63_8 > 0 and var_63_2 < var_63_8 then
					arg_60_1.talkMaxDuration = var_63_8

					if var_63_8 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071015", "story_v_out_108071.awb") ~= 0 then
					local var_63_9 = manager.audio:GetVoiceLength("story_v_out_108071", "108071015", "story_v_out_108071.awb") / 1000

					if var_63_9 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_1
					end

					if var_63_4.prefab_name ~= "" and arg_60_1.actors_[var_63_4.prefab_name] ~= nil then
						local var_63_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_4.prefab_name].transform, "story_v_out_108071", "108071015", "story_v_out_108071.awb")

						arg_60_1:RecordAudio("108071015", var_63_10)
						arg_60_1:RecordAudio("108071015", var_63_10)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_108071", "108071015", "story_v_out_108071.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_108071", "108071015", "story_v_out_108071.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_11 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_11 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_11

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_11 and arg_60_1.time_ < var_63_1 + var_63_11 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play108071016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 108071016
		arg_64_1.duration_ = 22.8

		local var_64_0 = {
			ja = 22.8,
			ko = 15.733,
			zh = 17.233,
			en = 14.4
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
				arg_64_0:Play108071017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1099ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1099ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1099ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["1050ui_story"].transform
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.var_.moveOldPos1050ui_story = var_67_9.localPosition
			end

			local var_67_11 = 0.001

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11
				local var_67_13 = Vector3.New(0, 100, 0)

				var_67_9.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1050ui_story, var_67_13, var_67_12)

				local var_67_14 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_14.x, var_67_14.y, var_67_14.z)

				local var_67_15 = var_67_9.localEulerAngles

				var_67_15.z = 0
				var_67_15.x = 0
				var_67_9.localEulerAngles = var_67_15
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 then
				var_67_9.localPosition = Vector3.New(0, 100, 0)

				local var_67_16 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_16.x, var_67_16.y, var_67_16.z)

				local var_67_17 = var_67_9.localEulerAngles

				var_67_17.z = 0
				var_67_17.x = 0
				var_67_9.localEulerAngles = var_67_17
			end

			local var_67_18 = arg_64_1.actors_["3014_tpose"].transform
			local var_67_19 = 0

			if var_67_19 < arg_64_1.time_ and arg_64_1.time_ <= var_67_19 + arg_67_0 then
				arg_64_1.var_.moveOldPos3014_tpose = var_67_18.localPosition

				local var_67_20 = GameObjectTools.GetOrAddComponent(var_67_18.gameObject, typeof(DynamicBoneHelper))

				if var_67_20 then
					var_67_20:EnableDynamicBone(false)
				end
			end

			local var_67_21 = 0.001

			if var_67_19 <= arg_64_1.time_ and arg_64_1.time_ < var_67_19 + var_67_21 then
				local var_67_22 = (arg_64_1.time_ - var_67_19) / var_67_21
				local var_67_23 = Vector3.New(0, -2.35, -2.9)

				var_67_18.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos3014_tpose, var_67_23, var_67_22)

				local var_67_24 = manager.ui.mainCamera.transform.position - var_67_18.position

				var_67_18.forward = Vector3.New(var_67_24.x, var_67_24.y, var_67_24.z)

				local var_67_25 = var_67_18.localEulerAngles

				var_67_25.z = 0
				var_67_25.x = 0
				var_67_18.localEulerAngles = var_67_25
			end

			if arg_64_1.time_ >= var_67_19 + var_67_21 and arg_64_1.time_ < var_67_19 + var_67_21 + arg_67_0 then
				var_67_18.localPosition = Vector3.New(0, -2.35, -2.9)

				local var_67_26 = manager.ui.mainCamera.transform.position - var_67_18.position

				var_67_18.forward = Vector3.New(var_67_26.x, var_67_26.y, var_67_26.z)

				local var_67_27 = var_67_18.localEulerAngles

				var_67_27.z = 0
				var_67_27.x = 0
				var_67_18.localEulerAngles = var_67_27

				local var_67_28 = GameObjectTools.GetOrAddComponent(var_67_18.gameObject, typeof(DynamicBoneHelper))

				if var_67_28 then
					var_67_28:EnableDynamicBone(true)
				end
			end

			local var_67_29 = arg_64_1.actors_["3014_tpose"]
			local var_67_30 = 0

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 and not isNil(var_67_29) and arg_64_1.var_.characterEffect3014_tpose == nil then
				arg_64_1.var_.characterEffect3014_tpose = var_67_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_31 = 0.2

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_31 and not isNil(var_67_29) then
				local var_67_32 = (arg_64_1.time_ - var_67_30) / var_67_31

				if arg_64_1.var_.characterEffect3014_tpose and not isNil(var_67_29) then
					arg_64_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_30 + var_67_31 and arg_64_1.time_ < var_67_30 + var_67_31 + arg_67_0 and not isNil(var_67_29) and arg_64_1.var_.characterEffect3014_tpose then
				arg_64_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_67_33 = 0

			if var_67_33 < arg_64_1.time_ and arg_64_1.time_ <= var_67_33 + arg_67_0 then
				arg_64_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_67_34 = 0
			local var_67_35 = 1.375

			if var_67_34 < arg_64_1.time_ and arg_64_1.time_ <= var_67_34 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_36 = arg_64_1:FormatText(StoryNameCfg[96].name)

				arg_64_1.leftNameTxt_.text = var_67_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_37 = arg_64_1:GetWordFromCfg(108071016)
				local var_67_38 = arg_64_1:FormatText(var_67_37.content)

				arg_64_1.text_.text = var_67_38

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_39 = 53
				local var_67_40 = utf8.len(var_67_38)
				local var_67_41 = var_67_39 <= 0 and var_67_35 or var_67_35 * (var_67_40 / var_67_39)

				if var_67_41 > 0 and var_67_35 < var_67_41 then
					arg_64_1.talkMaxDuration = var_67_41

					if var_67_41 + var_67_34 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_41 + var_67_34
					end
				end

				arg_64_1.text_.text = var_67_38
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071016", "story_v_out_108071.awb") ~= 0 then
					local var_67_42 = manager.audio:GetVoiceLength("story_v_out_108071", "108071016", "story_v_out_108071.awb") / 1000

					if var_67_42 + var_67_34 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_42 + var_67_34
					end

					if var_67_37.prefab_name ~= "" and arg_64_1.actors_[var_67_37.prefab_name] ~= nil then
						local var_67_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_37.prefab_name].transform, "story_v_out_108071", "108071016", "story_v_out_108071.awb")

						arg_64_1:RecordAudio("108071016", var_67_43)
						arg_64_1:RecordAudio("108071016", var_67_43)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_108071", "108071016", "story_v_out_108071.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_108071", "108071016", "story_v_out_108071.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_44 = math.max(var_67_35, arg_64_1.talkMaxDuration)

			if var_67_34 <= arg_64_1.time_ and arg_64_1.time_ < var_67_34 + var_67_44 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_34) / var_67_44

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_34 + var_67_44 and arg_64_1.time_ < var_67_34 + var_67_44 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play108071017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 108071017
		arg_68_1.duration_ = 6.77

		local var_68_0 = {
			ja = 6.766,
			ko = 4.6,
			zh = 4.966,
			en = 3.333
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
				arg_68_0:Play108071018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.35

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[96].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_3 = arg_68_1:GetWordFromCfg(108071017)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 14
				local var_71_6 = utf8.len(var_71_4)
				local var_71_7 = var_71_5 <= 0 and var_71_1 or var_71_1 * (var_71_6 / var_71_5)

				if var_71_7 > 0 and var_71_1 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071017", "story_v_out_108071.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_108071", "108071017", "story_v_out_108071.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_108071", "108071017", "story_v_out_108071.awb")

						arg_68_1:RecordAudio("108071017", var_71_9)
						arg_68_1:RecordAudio("108071017", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_108071", "108071017", "story_v_out_108071.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_108071", "108071017", "story_v_out_108071.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_10 and arg_68_1.time_ < var_71_0 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play108071018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 108071018
		arg_72_1.duration_ = 6.87

		local var_72_0 = {
			ja = 5.933,
			ko = 5.833,
			zh = 6.866,
			en = 4.666
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
				arg_72_0:Play108071019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.575

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[96].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:GetWordFromCfg(108071018)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 23
				local var_75_6 = utf8.len(var_75_4)
				local var_75_7 = var_75_5 <= 0 and var_75_1 or var_75_1 * (var_75_6 / var_75_5)

				if var_75_7 > 0 and var_75_1 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071018", "story_v_out_108071.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_108071", "108071018", "story_v_out_108071.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_108071", "108071018", "story_v_out_108071.awb")

						arg_72_1:RecordAudio("108071018", var_75_9)
						arg_72_1:RecordAudio("108071018", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_108071", "108071018", "story_v_out_108071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_108071", "108071018", "story_v_out_108071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_10 and arg_72_1.time_ < var_75_0 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play108071019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 108071019
		arg_76_1.duration_ = 10.93

		local var_76_0 = {
			ja = 5.833,
			ko = 9,
			zh = 10.933,
			en = 9.133
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
				arg_76_0:Play108071020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.8

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[96].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_3 = arg_76_1:GetWordFromCfg(108071019)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 32
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071019", "story_v_out_108071.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_108071", "108071019", "story_v_out_108071.awb") / 1000

					if var_79_8 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_0
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_108071", "108071019", "story_v_out_108071.awb")

						arg_76_1:RecordAudio("108071019", var_79_9)
						arg_76_1:RecordAudio("108071019", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_108071", "108071019", "story_v_out_108071.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_108071", "108071019", "story_v_out_108071.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_10 and arg_76_1.time_ < var_79_0 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play108071020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 108071020
		arg_80_1.duration_ = 21.47

		local var_80_0 = {
			ja = 21.466,
			ko = 13.233,
			zh = 16.4,
			en = 16.466
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
				arg_80_0:Play108071021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 1.05

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[96].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:GetWordFromCfg(108071020)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071020", "story_v_out_108071.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_108071", "108071020", "story_v_out_108071.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_108071", "108071020", "story_v_out_108071.awb")

						arg_80_1:RecordAudio("108071020", var_83_9)
						arg_80_1:RecordAudio("108071020", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_108071", "108071020", "story_v_out_108071.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_108071", "108071020", "story_v_out_108071.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_10 and arg_80_1.time_ < var_83_0 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play108071021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 108071021
		arg_84_1.duration_ = 15.97

		local var_84_0 = {
			ja = 3.4,
			ko = 6.7,
			zh = 8.533,
			en = 15.966
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
				arg_84_0:Play108071022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.775

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[96].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:GetWordFromCfg(108071021)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 31
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071021", "story_v_out_108071.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_108071", "108071021", "story_v_out_108071.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_108071", "108071021", "story_v_out_108071.awb")

						arg_84_1:RecordAudio("108071021", var_87_9)
						arg_84_1:RecordAudio("108071021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_108071", "108071021", "story_v_out_108071.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_108071", "108071021", "story_v_out_108071.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_10 and arg_84_1.time_ < var_87_0 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play108071022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 108071022
		arg_88_1.duration_ = 21.4

		local var_88_0 = {
			ja = 21.4,
			ko = 14.6,
			zh = 17.066,
			en = 13.666
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
				arg_88_0:Play108071023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 1.25

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[96].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_3 = arg_88_1:GetWordFromCfg(108071022)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 50
				local var_91_6 = utf8.len(var_91_4)
				local var_91_7 = var_91_5 <= 0 and var_91_1 or var_91_1 * (var_91_6 / var_91_5)

				if var_91_7 > 0 and var_91_1 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071022", "story_v_out_108071.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_108071", "108071022", "story_v_out_108071.awb") / 1000

					if var_91_8 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_0
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_out_108071", "108071022", "story_v_out_108071.awb")

						arg_88_1:RecordAudio("108071022", var_91_9)
						arg_88_1:RecordAudio("108071022", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_108071", "108071022", "story_v_out_108071.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_108071", "108071022", "story_v_out_108071.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_10 and arg_88_1.time_ < var_91_0 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play108071023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 108071023
		arg_92_1.duration_ = 3.7

		local var_92_0 = {
			ja = 3.366,
			ko = 3.6,
			zh = 3.7,
			en = 2.4
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
				arg_92_0:Play108071024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["3014_tpose"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos3014_tpose = var_95_0.localPosition

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end
			end

			local var_95_3 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_3 then
				local var_95_4 = (arg_92_1.time_ - var_95_1) / var_95_3
				local var_95_5 = Vector3.New(0, 100, 0)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos3014_tpose, var_95_5, var_95_4)

				local var_95_6 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_6.x, var_95_6.y, var_95_6.z)

				local var_95_7 = var_95_0.localEulerAngles

				var_95_7.z = 0
				var_95_7.x = 0
				var_95_0.localEulerAngles = var_95_7
			end

			if arg_92_1.time_ >= var_95_1 + var_95_3 and arg_92_1.time_ < var_95_1 + var_95_3 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0, 100, 0)

				local var_95_8 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_8.x, var_95_8.y, var_95_8.z)

				local var_95_9 = var_95_0.localEulerAngles

				var_95_9.z = 0
				var_95_9.x = 0
				var_95_0.localEulerAngles = var_95_9

				local var_95_10 = GameObjectTools.GetOrAddComponent(var_95_0.gameObject, typeof(DynamicBoneHelper))

				if var_95_10 then
					var_95_10:EnableDynamicBone(true)
				end
			end

			local var_95_11 = arg_92_1.actors_["1050ui_story"].transform
			local var_95_12 = 0

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 then
				arg_92_1.var_.moveOldPos1050ui_story = var_95_11.localPosition
			end

			local var_95_13 = 0.001

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_13 then
				local var_95_14 = (arg_92_1.time_ - var_95_12) / var_95_13
				local var_95_15 = Vector3.New(0, -1, -6.1)

				var_95_11.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1050ui_story, var_95_15, var_95_14)

				local var_95_16 = manager.ui.mainCamera.transform.position - var_95_11.position

				var_95_11.forward = Vector3.New(var_95_16.x, var_95_16.y, var_95_16.z)

				local var_95_17 = var_95_11.localEulerAngles

				var_95_17.z = 0
				var_95_17.x = 0
				var_95_11.localEulerAngles = var_95_17
			end

			if arg_92_1.time_ >= var_95_12 + var_95_13 and arg_92_1.time_ < var_95_12 + var_95_13 + arg_95_0 then
				var_95_11.localPosition = Vector3.New(0, -1, -6.1)

				local var_95_18 = manager.ui.mainCamera.transform.position - var_95_11.position

				var_95_11.forward = Vector3.New(var_95_18.x, var_95_18.y, var_95_18.z)

				local var_95_19 = var_95_11.localEulerAngles

				var_95_19.z = 0
				var_95_19.x = 0
				var_95_11.localEulerAngles = var_95_19
			end

			local var_95_20 = arg_92_1.actors_["1050ui_story"]
			local var_95_21 = 0

			if var_95_21 < arg_92_1.time_ and arg_92_1.time_ <= var_95_21 + arg_95_0 and not isNil(var_95_20) and arg_92_1.var_.characterEffect1050ui_story == nil then
				arg_92_1.var_.characterEffect1050ui_story = var_95_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_22 = 0.2

			if var_95_21 <= arg_92_1.time_ and arg_92_1.time_ < var_95_21 + var_95_22 and not isNil(var_95_20) then
				local var_95_23 = (arg_92_1.time_ - var_95_21) / var_95_22

				if arg_92_1.var_.characterEffect1050ui_story and not isNil(var_95_20) then
					arg_92_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_21 + var_95_22 and arg_92_1.time_ < var_95_21 + var_95_22 + arg_95_0 and not isNil(var_95_20) and arg_92_1.var_.characterEffect1050ui_story then
				arg_92_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_95_24 = 0

			if var_95_24 < arg_92_1.time_ and arg_92_1.time_ <= var_95_24 + arg_95_0 then
				arg_92_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_95_25 = 0
			local var_95_26 = 0.375

			if var_95_25 < arg_92_1.time_ and arg_92_1.time_ <= var_95_25 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_27 = arg_92_1:FormatText(StoryNameCfg[74].name)

				arg_92_1.leftNameTxt_.text = var_95_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_28 = arg_92_1:GetWordFromCfg(108071023)
				local var_95_29 = arg_92_1:FormatText(var_95_28.content)

				arg_92_1.text_.text = var_95_29

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_30 = 15
				local var_95_31 = utf8.len(var_95_29)
				local var_95_32 = var_95_30 <= 0 and var_95_26 or var_95_26 * (var_95_31 / var_95_30)

				if var_95_32 > 0 and var_95_26 < var_95_32 then
					arg_92_1.talkMaxDuration = var_95_32

					if var_95_32 + var_95_25 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_32 + var_95_25
					end
				end

				arg_92_1.text_.text = var_95_29
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071023", "story_v_out_108071.awb") ~= 0 then
					local var_95_33 = manager.audio:GetVoiceLength("story_v_out_108071", "108071023", "story_v_out_108071.awb") / 1000

					if var_95_33 + var_95_25 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_33 + var_95_25
					end

					if var_95_28.prefab_name ~= "" and arg_92_1.actors_[var_95_28.prefab_name] ~= nil then
						local var_95_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_28.prefab_name].transform, "story_v_out_108071", "108071023", "story_v_out_108071.awb")

						arg_92_1:RecordAudio("108071023", var_95_34)
						arg_92_1:RecordAudio("108071023", var_95_34)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_108071", "108071023", "story_v_out_108071.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_108071", "108071023", "story_v_out_108071.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_35 = math.max(var_95_26, arg_92_1.talkMaxDuration)

			if var_95_25 <= arg_92_1.time_ and arg_92_1.time_ < var_95_25 + var_95_35 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_25) / var_95_35

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_25 + var_95_35 and arg_92_1.time_ < var_95_25 + var_95_35 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play108071024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 108071024
		arg_96_1.duration_ = 9.9

		local var_96_0 = {
			ja = 9.9,
			ko = 9.5,
			zh = 9.9,
			en = 7.933
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
				arg_96_0:Play108071025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1050ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos1050ui_story = var_99_0.localPosition
			end

			local var_99_2 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2
				local var_99_4 = Vector3.New(0, 100, 0)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1050ui_story, var_99_4, var_99_3)

				local var_99_5 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_5.x, var_99_5.y, var_99_5.z)

				local var_99_6 = var_99_0.localEulerAngles

				var_99_6.z = 0
				var_99_6.x = 0
				var_99_0.localEulerAngles = var_99_6
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, 100, 0)

				local var_99_7 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_7.x, var_99_7.y, var_99_7.z)

				local var_99_8 = var_99_0.localEulerAngles

				var_99_8.z = 0
				var_99_8.x = 0
				var_99_0.localEulerAngles = var_99_8
			end

			local var_99_9 = arg_96_1.actors_["3014_tpose"].transform
			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1.var_.moveOldPos3014_tpose = var_99_9.localPosition

				local var_99_11 = GameObjectTools.GetOrAddComponent(var_99_9.gameObject, typeof(DynamicBoneHelper))

				if var_99_11 then
					var_99_11:EnableDynamicBone(false)
				end
			end

			local var_99_12 = 0.001

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_12 then
				local var_99_13 = (arg_96_1.time_ - var_99_10) / var_99_12
				local var_99_14 = Vector3.New(0, -2.35, -2.9)

				var_99_9.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos3014_tpose, var_99_14, var_99_13)

				local var_99_15 = manager.ui.mainCamera.transform.position - var_99_9.position

				var_99_9.forward = Vector3.New(var_99_15.x, var_99_15.y, var_99_15.z)

				local var_99_16 = var_99_9.localEulerAngles

				var_99_16.z = 0
				var_99_16.x = 0
				var_99_9.localEulerAngles = var_99_16
			end

			if arg_96_1.time_ >= var_99_10 + var_99_12 and arg_96_1.time_ < var_99_10 + var_99_12 + arg_99_0 then
				var_99_9.localPosition = Vector3.New(0, -2.35, -2.9)

				local var_99_17 = manager.ui.mainCamera.transform.position - var_99_9.position

				var_99_9.forward = Vector3.New(var_99_17.x, var_99_17.y, var_99_17.z)

				local var_99_18 = var_99_9.localEulerAngles

				var_99_18.z = 0
				var_99_18.x = 0
				var_99_9.localEulerAngles = var_99_18

				local var_99_19 = GameObjectTools.GetOrAddComponent(var_99_9.gameObject, typeof(DynamicBoneHelper))

				if var_99_19 then
					var_99_19:EnableDynamicBone(true)
				end
			end

			local var_99_20 = arg_96_1.actors_["3014_tpose"]
			local var_99_21 = 0

			if var_99_21 < arg_96_1.time_ and arg_96_1.time_ <= var_99_21 + arg_99_0 and not isNil(var_99_20) and arg_96_1.var_.characterEffect3014_tpose == nil then
				arg_96_1.var_.characterEffect3014_tpose = var_99_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_22 = 0.2

			if var_99_21 <= arg_96_1.time_ and arg_96_1.time_ < var_99_21 + var_99_22 and not isNil(var_99_20) then
				local var_99_23 = (arg_96_1.time_ - var_99_21) / var_99_22

				if arg_96_1.var_.characterEffect3014_tpose and not isNil(var_99_20) then
					arg_96_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_21 + var_99_22 and arg_96_1.time_ < var_99_21 + var_99_22 + arg_99_0 and not isNil(var_99_20) and arg_96_1.var_.characterEffect3014_tpose then
				arg_96_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_99_24 = 0

			if var_99_24 < arg_96_1.time_ and arg_96_1.time_ <= var_99_24 + arg_99_0 then
				arg_96_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_99_25 = 0
			local var_99_26 = 0.675

			if var_99_25 < arg_96_1.time_ and arg_96_1.time_ <= var_99_25 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_27 = arg_96_1:FormatText(StoryNameCfg[96].name)

				arg_96_1.leftNameTxt_.text = var_99_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_28 = arg_96_1:GetWordFromCfg(108071024)
				local var_99_29 = arg_96_1:FormatText(var_99_28.content)

				arg_96_1.text_.text = var_99_29

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_30 = 27
				local var_99_31 = utf8.len(var_99_29)
				local var_99_32 = var_99_30 <= 0 and var_99_26 or var_99_26 * (var_99_31 / var_99_30)

				if var_99_32 > 0 and var_99_26 < var_99_32 then
					arg_96_1.talkMaxDuration = var_99_32

					if var_99_32 + var_99_25 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_32 + var_99_25
					end
				end

				arg_96_1.text_.text = var_99_29
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071024", "story_v_out_108071.awb") ~= 0 then
					local var_99_33 = manager.audio:GetVoiceLength("story_v_out_108071", "108071024", "story_v_out_108071.awb") / 1000

					if var_99_33 + var_99_25 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_33 + var_99_25
					end

					if var_99_28.prefab_name ~= "" and arg_96_1.actors_[var_99_28.prefab_name] ~= nil then
						local var_99_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_28.prefab_name].transform, "story_v_out_108071", "108071024", "story_v_out_108071.awb")

						arg_96_1:RecordAudio("108071024", var_99_34)
						arg_96_1:RecordAudio("108071024", var_99_34)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_108071", "108071024", "story_v_out_108071.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_108071", "108071024", "story_v_out_108071.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_35 = math.max(var_99_26, arg_96_1.talkMaxDuration)

			if var_99_25 <= arg_96_1.time_ and arg_96_1.time_ < var_99_25 + var_99_35 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_25) / var_99_35

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_25 + var_99_35 and arg_96_1.time_ < var_99_25 + var_99_35 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play108071025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 108071025
		arg_100_1.duration_ = 2

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play108071026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["3014_tpose"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos3014_tpose = var_103_0.localPosition

				local var_103_2 = GameObjectTools.GetOrAddComponent(var_103_0.gameObject, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(false)
				end
			end

			local var_103_3 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_3 then
				local var_103_4 = (arg_100_1.time_ - var_103_1) / var_103_3
				local var_103_5 = Vector3.New(0, 100, 0)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos3014_tpose, var_103_5, var_103_4)

				local var_103_6 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_6.x, var_103_6.y, var_103_6.z)

				local var_103_7 = var_103_0.localEulerAngles

				var_103_7.z = 0
				var_103_7.x = 0
				var_103_0.localEulerAngles = var_103_7
			end

			if arg_100_1.time_ >= var_103_1 + var_103_3 and arg_100_1.time_ < var_103_1 + var_103_3 + arg_103_0 then
				var_103_0.localPosition = Vector3.New(0, 100, 0)

				local var_103_8 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_8.x, var_103_8.y, var_103_8.z)

				local var_103_9 = var_103_0.localEulerAngles

				var_103_9.z = 0
				var_103_9.x = 0
				var_103_0.localEulerAngles = var_103_9

				local var_103_10 = GameObjectTools.GetOrAddComponent(var_103_0.gameObject, typeof(DynamicBoneHelper))

				if var_103_10 then
					var_103_10:EnableDynamicBone(true)
				end
			end

			local var_103_11 = arg_100_1.actors_["1099ui_story"].transform
			local var_103_12 = 0

			if var_103_12 < arg_100_1.time_ and arg_100_1.time_ <= var_103_12 + arg_103_0 then
				arg_100_1.var_.moveOldPos1099ui_story = var_103_11.localPosition
			end

			local var_103_13 = 0.001

			if var_103_12 <= arg_100_1.time_ and arg_100_1.time_ < var_103_12 + var_103_13 then
				local var_103_14 = (arg_100_1.time_ - var_103_12) / var_103_13
				local var_103_15 = Vector3.New(0, -1.08, -5.9)

				var_103_11.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1099ui_story, var_103_15, var_103_14)

				local var_103_16 = manager.ui.mainCamera.transform.position - var_103_11.position

				var_103_11.forward = Vector3.New(var_103_16.x, var_103_16.y, var_103_16.z)

				local var_103_17 = var_103_11.localEulerAngles

				var_103_17.z = 0
				var_103_17.x = 0
				var_103_11.localEulerAngles = var_103_17
			end

			if arg_100_1.time_ >= var_103_12 + var_103_13 and arg_100_1.time_ < var_103_12 + var_103_13 + arg_103_0 then
				var_103_11.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_103_18 = manager.ui.mainCamera.transform.position - var_103_11.position

				var_103_11.forward = Vector3.New(var_103_18.x, var_103_18.y, var_103_18.z)

				local var_103_19 = var_103_11.localEulerAngles

				var_103_19.z = 0
				var_103_19.x = 0
				var_103_11.localEulerAngles = var_103_19
			end

			local var_103_20 = arg_100_1.actors_["1099ui_story"]
			local var_103_21 = 0

			if var_103_21 < arg_100_1.time_ and arg_100_1.time_ <= var_103_21 + arg_103_0 and not isNil(var_103_20) and arg_100_1.var_.characterEffect1099ui_story == nil then
				arg_100_1.var_.characterEffect1099ui_story = var_103_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_22 = 0.2

			if var_103_21 <= arg_100_1.time_ and arg_100_1.time_ < var_103_21 + var_103_22 and not isNil(var_103_20) then
				local var_103_23 = (arg_100_1.time_ - var_103_21) / var_103_22

				if arg_100_1.var_.characterEffect1099ui_story and not isNil(var_103_20) then
					arg_100_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_21 + var_103_22 and arg_100_1.time_ < var_103_21 + var_103_22 + arg_103_0 and not isNil(var_103_20) and arg_100_1.var_.characterEffect1099ui_story then
				arg_100_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_103_24 = 0

			if var_103_24 < arg_100_1.time_ and arg_100_1.time_ <= var_103_24 + arg_103_0 then
				arg_100_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_103_25 = 0

			if var_103_25 < arg_100_1.time_ and arg_100_1.time_ <= var_103_25 + arg_103_0 then
				arg_100_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_103_26 = 0
			local var_103_27 = 0.15

			if var_103_26 < arg_100_1.time_ and arg_100_1.time_ <= var_103_26 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_28 = arg_100_1:FormatText(StoryNameCfg[84].name)

				arg_100_1.leftNameTxt_.text = var_103_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_29 = arg_100_1:GetWordFromCfg(108071025)
				local var_103_30 = arg_100_1:FormatText(var_103_29.content)

				arg_100_1.text_.text = var_103_30

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_31 = 6
				local var_103_32 = utf8.len(var_103_30)
				local var_103_33 = var_103_31 <= 0 and var_103_27 or var_103_27 * (var_103_32 / var_103_31)

				if var_103_33 > 0 and var_103_27 < var_103_33 then
					arg_100_1.talkMaxDuration = var_103_33

					if var_103_33 + var_103_26 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_33 + var_103_26
					end
				end

				arg_100_1.text_.text = var_103_30
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071025", "story_v_out_108071.awb") ~= 0 then
					local var_103_34 = manager.audio:GetVoiceLength("story_v_out_108071", "108071025", "story_v_out_108071.awb") / 1000

					if var_103_34 + var_103_26 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_34 + var_103_26
					end

					if var_103_29.prefab_name ~= "" and arg_100_1.actors_[var_103_29.prefab_name] ~= nil then
						local var_103_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_29.prefab_name].transform, "story_v_out_108071", "108071025", "story_v_out_108071.awb")

						arg_100_1:RecordAudio("108071025", var_103_35)
						arg_100_1:RecordAudio("108071025", var_103_35)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_108071", "108071025", "story_v_out_108071.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_108071", "108071025", "story_v_out_108071.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_36 = math.max(var_103_27, arg_100_1.talkMaxDuration)

			if var_103_26 <= arg_100_1.time_ and arg_100_1.time_ < var_103_26 + var_103_36 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_26) / var_103_36

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_26 + var_103_36 and arg_100_1.time_ < var_103_26 + var_103_36 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play108071026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 108071026
		arg_104_1.duration_ = 17.2

		local var_104_0 = {
			ja = 8.666,
			ko = 12.633,
			zh = 17.2,
			en = 14.1
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
				arg_104_0:Play108071027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1099ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1099ui_story = var_107_0.localPosition
			end

			local var_107_2 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2
				local var_107_4 = Vector3.New(0, 100, 0)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1099ui_story, var_107_4, var_107_3)

				local var_107_5 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_5.x, var_107_5.y, var_107_5.z)

				local var_107_6 = var_107_0.localEulerAngles

				var_107_6.z = 0
				var_107_6.x = 0
				var_107_0.localEulerAngles = var_107_6
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, 100, 0)

				local var_107_7 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_7.x, var_107_7.y, var_107_7.z)

				local var_107_8 = var_107_0.localEulerAngles

				var_107_8.z = 0
				var_107_8.x = 0
				var_107_0.localEulerAngles = var_107_8
			end

			local var_107_9 = arg_104_1.actors_["3014_tpose"].transform
			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 then
				arg_104_1.var_.moveOldPos3014_tpose = var_107_9.localPosition

				local var_107_11 = GameObjectTools.GetOrAddComponent(var_107_9.gameObject, typeof(DynamicBoneHelper))

				if var_107_11 then
					var_107_11:EnableDynamicBone(false)
				end
			end

			local var_107_12 = 0.001

			if var_107_10 <= arg_104_1.time_ and arg_104_1.time_ < var_107_10 + var_107_12 then
				local var_107_13 = (arg_104_1.time_ - var_107_10) / var_107_12
				local var_107_14 = Vector3.New(0, -2.35, -2.9)

				var_107_9.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos3014_tpose, var_107_14, var_107_13)

				local var_107_15 = manager.ui.mainCamera.transform.position - var_107_9.position

				var_107_9.forward = Vector3.New(var_107_15.x, var_107_15.y, var_107_15.z)

				local var_107_16 = var_107_9.localEulerAngles

				var_107_16.z = 0
				var_107_16.x = 0
				var_107_9.localEulerAngles = var_107_16
			end

			if arg_104_1.time_ >= var_107_10 + var_107_12 and arg_104_1.time_ < var_107_10 + var_107_12 + arg_107_0 then
				var_107_9.localPosition = Vector3.New(0, -2.35, -2.9)

				local var_107_17 = manager.ui.mainCamera.transform.position - var_107_9.position

				var_107_9.forward = Vector3.New(var_107_17.x, var_107_17.y, var_107_17.z)

				local var_107_18 = var_107_9.localEulerAngles

				var_107_18.z = 0
				var_107_18.x = 0
				var_107_9.localEulerAngles = var_107_18

				local var_107_19 = GameObjectTools.GetOrAddComponent(var_107_9.gameObject, typeof(DynamicBoneHelper))

				if var_107_19 then
					var_107_19:EnableDynamicBone(true)
				end
			end

			local var_107_20 = arg_104_1.actors_["3014_tpose"]
			local var_107_21 = 0

			if var_107_21 < arg_104_1.time_ and arg_104_1.time_ <= var_107_21 + arg_107_0 and not isNil(var_107_20) and arg_104_1.var_.characterEffect3014_tpose == nil then
				arg_104_1.var_.characterEffect3014_tpose = var_107_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_22 = 0.2

			if var_107_21 <= arg_104_1.time_ and arg_104_1.time_ < var_107_21 + var_107_22 and not isNil(var_107_20) then
				local var_107_23 = (arg_104_1.time_ - var_107_21) / var_107_22

				if arg_104_1.var_.characterEffect3014_tpose and not isNil(var_107_20) then
					arg_104_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_21 + var_107_22 and arg_104_1.time_ < var_107_21 + var_107_22 + arg_107_0 and not isNil(var_107_20) and arg_104_1.var_.characterEffect3014_tpose then
				arg_104_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_107_24 = 0

			if var_107_24 < arg_104_1.time_ and arg_104_1.time_ <= var_107_24 + arg_107_0 then
				arg_104_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_107_25 = 0
			local var_107_26 = 1.175

			if var_107_25 < arg_104_1.time_ and arg_104_1.time_ <= var_107_25 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_27 = arg_104_1:FormatText(StoryNameCfg[96].name)

				arg_104_1.leftNameTxt_.text = var_107_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_28 = arg_104_1:GetWordFromCfg(108071026)
				local var_107_29 = arg_104_1:FormatText(var_107_28.content)

				arg_104_1.text_.text = var_107_29

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_30 = 47
				local var_107_31 = utf8.len(var_107_29)
				local var_107_32 = var_107_30 <= 0 and var_107_26 or var_107_26 * (var_107_31 / var_107_30)

				if var_107_32 > 0 and var_107_26 < var_107_32 then
					arg_104_1.talkMaxDuration = var_107_32

					if var_107_32 + var_107_25 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_32 + var_107_25
					end
				end

				arg_104_1.text_.text = var_107_29
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071026", "story_v_out_108071.awb") ~= 0 then
					local var_107_33 = manager.audio:GetVoiceLength("story_v_out_108071", "108071026", "story_v_out_108071.awb") / 1000

					if var_107_33 + var_107_25 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_33 + var_107_25
					end

					if var_107_28.prefab_name ~= "" and arg_104_1.actors_[var_107_28.prefab_name] ~= nil then
						local var_107_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_28.prefab_name].transform, "story_v_out_108071", "108071026", "story_v_out_108071.awb")

						arg_104_1:RecordAudio("108071026", var_107_34)
						arg_104_1:RecordAudio("108071026", var_107_34)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_108071", "108071026", "story_v_out_108071.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_108071", "108071026", "story_v_out_108071.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_35 = math.max(var_107_26, arg_104_1.talkMaxDuration)

			if var_107_25 <= arg_104_1.time_ and arg_104_1.time_ < var_107_25 + var_107_35 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_25) / var_107_35

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_25 + var_107_35 and arg_104_1.time_ < var_107_25 + var_107_35 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play108071027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 108071027
		arg_108_1.duration_ = 11.67

		local var_108_0 = {
			ja = 11.666,
			ko = 4.1,
			zh = 5.166,
			en = 8.066
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
				arg_108_0:Play108071028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.35

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[96].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:GetWordFromCfg(108071027)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 14
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071027", "story_v_out_108071.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_108071", "108071027", "story_v_out_108071.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_108071", "108071027", "story_v_out_108071.awb")

						arg_108_1:RecordAudio("108071027", var_111_9)
						arg_108_1:RecordAudio("108071027", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_108071", "108071027", "story_v_out_108071.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_108071", "108071027", "story_v_out_108071.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_10 and arg_108_1.time_ < var_111_0 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play108071028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 108071028
		arg_112_1.duration_ = 6.97

		local var_112_0 = {
			ja = 6.966,
			ko = 3.466,
			zh = 3.566,
			en = 1.366
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
			arg_112_1.auto_ = false
		end

		function arg_112_1.playNext_(arg_114_0)
			arg_112_1.onStoryFinished_()
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.15

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[96].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_3 = arg_112_1:GetWordFromCfg(108071028)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 6
				local var_115_6 = utf8.len(var_115_4)
				local var_115_7 = var_115_5 <= 0 and var_115_1 or var_115_1 * (var_115_6 / var_115_5)

				if var_115_7 > 0 and var_115_1 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108071", "108071028", "story_v_out_108071.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_108071", "108071028", "story_v_out_108071.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_108071", "108071028", "story_v_out_108071.awb")

						arg_112_1:RecordAudio("108071028", var_115_9)
						arg_112_1:RecordAudio("108071028", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_108071", "108071028", "story_v_out_108071.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_108071", "108071028", "story_v_out_108071.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C07_1"
	},
	voices = {
		"story_v_out_108071.awb"
	}
}
