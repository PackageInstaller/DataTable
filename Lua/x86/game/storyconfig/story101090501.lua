return {
	Play109051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 109051001
		arg_1_1.duration_ = 4.33

		local var_1_0 = {
			ja = 4.233,
			ko = 3.9,
			zh = 4.333,
			en = 3.566
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play109051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "C04a"

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
				local var_4_5 = arg_1_1.bgs_.C04a

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
					if iter_4_0 ~= "C04a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.C04a
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueC04a = var_4_18.color.a
					arg_1_1.var_.alphaMatValueC04a = var_4_18
				end

				arg_1_1.var_.alphaOldValueC04a = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueC04a, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueC04a then
					local var_4_22 = arg_1_1.var_.alphaMatValueC04a.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueC04a.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueC04a then
				local var_4_23 = arg_1_1.var_.alphaMatValueC04a
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0
			local var_4_26 = 1

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_27 = "play"
				local var_4_28 = "music"

				arg_1_1:AudioAction(var_4_27, var_4_28, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_29 = ""
				local var_4_30 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

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
			local var_4_34 = 0.175

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_36 = arg_1_1:FormatText(StoryNameCfg[99].name)

				arg_1_1.leftNameTxt_.text = var_4_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_37 = arg_1_1:GetWordFromCfg(109051001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 7
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_34 or var_4_34 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_34 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_33 = var_4_33 + 0.3

					if var_4_41 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051001", "story_v_out_109051.awb") ~= 0 then
					local var_4_42 = manager.audio:GetVoiceLength("story_v_out_109051", "109051001", "story_v_out_109051.awb") / 1000

					if var_4_42 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_33
					end

					if var_4_37.prefab_name ~= "" and arg_1_1.actors_[var_4_37.prefab_name] ~= nil then
						local var_4_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_37.prefab_name].transform, "story_v_out_109051", "109051001", "story_v_out_109051.awb")

						arg_1_1:RecordAudio("109051001", var_4_43)
						arg_1_1:RecordAudio("109051001", var_4_43)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_109051", "109051001", "story_v_out_109051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_109051", "109051001", "story_v_out_109051.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_33 + 0.3
			local var_4_45 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_44) / var_4_45

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play109051002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 109051002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play109051003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.6

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story_9", "se_story_9_jump", "")
			end

			local var_11_4 = 0
			local var_11_5 = 0.95

			if var_11_4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_6 = arg_8_1:GetWordFromCfg(109051002)
				local var_11_7 = arg_8_1:FormatText(var_11_6.content)

				arg_8_1.text_.text = var_11_7

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_8 = 38
				local var_11_9 = utf8.len(var_11_7)
				local var_11_10 = var_11_8 <= 0 and var_11_5 or var_11_5 * (var_11_9 / var_11_8)

				if var_11_10 > 0 and var_11_5 < var_11_10 then
					arg_8_1.talkMaxDuration = var_11_10

					if var_11_10 + var_11_4 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_10 + var_11_4
					end
				end

				arg_8_1.text_.text = var_11_7
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_11 = math.max(var_11_5, arg_8_1.talkMaxDuration)

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_11 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_4) / var_11_11

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_4 + var_11_11 and arg_8_1.time_ < var_11_4 + var_11_11 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play109051003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 109051003
		arg_12_1.duration_ = 6.53

		local var_12_0 = {
			ja = 2.6,
			ko = 5.033,
			zh = 4.7,
			en = 6.533
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
				arg_12_0:Play109051004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "3004_tpose"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "3004_tpose")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["3004_tpose"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos3004_tpose = var_15_5.localPosition

				local var_15_7 = GameObjectTools.GetOrAddComponent(var_15_5.gameObject, typeof(DynamicBoneHelper))

				if var_15_7 then
					var_15_7:EnableDynamicBone(false)
				end
			end

			local var_15_8 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_8 then
				local var_15_9 = (arg_12_1.time_ - var_15_6) / var_15_8
				local var_15_10 = Vector3.New(0, -2.22, -3.1)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3004_tpose, var_15_10, var_15_9)

				local var_15_11 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_11.x, var_15_11.y, var_15_11.z)

				local var_15_12 = var_15_5.localEulerAngles

				var_15_12.z = 0
				var_15_12.x = 0
				var_15_5.localEulerAngles = var_15_12
			end

			if arg_12_1.time_ >= var_15_6 + var_15_8 and arg_12_1.time_ < var_15_6 + var_15_8 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_15_13 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_13.x, var_15_13.y, var_15_13.z)

				local var_15_14 = var_15_5.localEulerAngles

				var_15_14.z = 0
				var_15_14.x = 0
				var_15_5.localEulerAngles = var_15_14

				local var_15_15 = GameObjectTools.GetOrAddComponent(var_15_5.gameObject, typeof(DynamicBoneHelper))

				if var_15_15 then
					var_15_15:EnableDynamicBone(true)
				end
			end

			local var_15_16 = arg_12_1.actors_["3004_tpose"]
			local var_15_17 = 0

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 and not isNil(var_15_16) and arg_12_1.var_.characterEffect3004_tpose == nil then
				arg_12_1.var_.characterEffect3004_tpose = var_15_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_18 = 0.2

			if var_15_17 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_18 and not isNil(var_15_16) then
				local var_15_19 = (arg_12_1.time_ - var_15_17) / var_15_18

				if arg_12_1.var_.characterEffect3004_tpose and not isNil(var_15_16) then
					arg_12_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_17 + var_15_18 and arg_12_1.time_ < var_15_17 + var_15_18 + arg_15_0 and not isNil(var_15_16) and arg_12_1.var_.characterEffect3004_tpose then
				arg_12_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_15_20 = 0

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_15_21 = 0
			local var_15_22 = 0.525

			if var_15_21 < arg_12_1.time_ and arg_12_1.time_ <= var_15_21 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_23 = arg_12_1:FormatText(StoryNameCfg[82].name)

				arg_12_1.leftNameTxt_.text = var_15_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_24 = arg_12_1:GetWordFromCfg(109051003)
				local var_15_25 = arg_12_1:FormatText(var_15_24.content)

				arg_12_1.text_.text = var_15_25

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_26 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051003", "story_v_out_109051.awb") ~= 0 then
					local var_15_29 = manager.audio:GetVoiceLength("story_v_out_109051", "109051003", "story_v_out_109051.awb") / 1000

					if var_15_29 + var_15_21 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_29 + var_15_21
					end

					if var_15_24.prefab_name ~= "" and arg_12_1.actors_[var_15_24.prefab_name] ~= nil then
						local var_15_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_24.prefab_name].transform, "story_v_out_109051", "109051003", "story_v_out_109051.awb")

						arg_12_1:RecordAudio("109051003", var_15_30)
						arg_12_1:RecordAudio("109051003", var_15_30)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_109051", "109051003", "story_v_out_109051.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_109051", "109051003", "story_v_out_109051.awb")
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
				actorName = "3004_tpose",
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
	Play109051004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 109051004
		arg_16_1.duration_ = 2.07

		local var_16_0 = {
			ja = 1.333,
			ko = 1.7,
			zh = 1.433,
			en = 2.066
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
				arg_16_0:Play109051005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["3004_tpose"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos3004_tpose = var_19_0.localPosition

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end
			end

			local var_19_3 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_3 then
				local var_19_4 = (arg_16_1.time_ - var_19_1) / var_19_3
				local var_19_5 = Vector3.New(0, 100, 0)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3004_tpose, var_19_5, var_19_4)

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

			local var_19_11 = 0
			local var_19_12 = 0.1

			if var_19_11 < arg_16_1.time_ and arg_16_1.time_ <= var_19_11 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_13 = arg_16_1:FormatText(StoryNameCfg[99].name)

				arg_16_1.leftNameTxt_.text = var_19_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_14 = arg_16_1:GetWordFromCfg(109051004)
				local var_19_15 = arg_16_1:FormatText(var_19_14.content)

				arg_16_1.text_.text = var_19_15

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_16 = 4
				local var_19_17 = utf8.len(var_19_15)
				local var_19_18 = var_19_16 <= 0 and var_19_12 or var_19_12 * (var_19_17 / var_19_16)

				if var_19_18 > 0 and var_19_12 < var_19_18 then
					arg_16_1.talkMaxDuration = var_19_18

					if var_19_18 + var_19_11 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_18 + var_19_11
					end
				end

				arg_16_1.text_.text = var_19_15
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051004", "story_v_out_109051.awb") ~= 0 then
					local var_19_19 = manager.audio:GetVoiceLength("story_v_out_109051", "109051004", "story_v_out_109051.awb") / 1000

					if var_19_19 + var_19_11 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_19 + var_19_11
					end

					if var_19_14.prefab_name ~= "" and arg_16_1.actors_[var_19_14.prefab_name] ~= nil then
						local var_19_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_14.prefab_name].transform, "story_v_out_109051", "109051004", "story_v_out_109051.awb")

						arg_16_1:RecordAudio("109051004", var_19_20)
						arg_16_1:RecordAudio("109051004", var_19_20)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_109051", "109051004", "story_v_out_109051.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_109051", "109051004", "story_v_out_109051.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_21 = math.max(var_19_12, arg_16_1.talkMaxDuration)

			if var_19_11 <= arg_16_1.time_ and arg_16_1.time_ < var_19_11 + var_19_21 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_11) / var_19_21

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_11 + var_19_21 and arg_16_1.time_ < var_19_11 + var_19_21 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
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
	Play109051005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 109051005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play109051006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.875

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(109051005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 35
				local var_23_5 = utf8.len(var_23_3)
				local var_23_6 = var_23_4 <= 0 and var_23_1 or var_23_1 * (var_23_5 / var_23_4)

				if var_23_6 > 0 and var_23_1 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_7 and arg_20_1.time_ < var_23_0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play109051006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 109051006
		arg_24_1.duration_ = 7.67

		local var_24_0 = {
			ja = 7.366,
			ko = 4.533,
			zh = 7.666,
			en = 4.8
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
				arg_24_0:Play109051007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.725

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[99].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(109051006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051006", "story_v_out_109051.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_109051", "109051006", "story_v_out_109051.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_109051", "109051006", "story_v_out_109051.awb")

						arg_24_1:RecordAudio("109051006", var_27_9)
						arg_24_1:RecordAudio("109051006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_109051", "109051006", "story_v_out_109051.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_109051", "109051006", "story_v_out_109051.awb")
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
	Play109051007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 109051007
		arg_28_1.duration_ = 7.13

		local var_28_0 = {
			ja = 7.133,
			ko = 5,
			zh = 6.7,
			en = 6.3
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
				arg_28_0:Play109051008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["3004_tpose"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos3004_tpose = var_31_0.localPosition

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0.gameObject, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end
			end

			local var_31_3 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_3 then
				local var_31_4 = (arg_28_1.time_ - var_31_1) / var_31_3
				local var_31_5 = Vector3.New(0, -2.22, -3.1)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3004_tpose, var_31_5, var_31_4)

				local var_31_6 = manager.ui.mainCamera.transform.position - var_31_0.position

				var_31_0.forward = Vector3.New(var_31_6.x, var_31_6.y, var_31_6.z)

				local var_31_7 = var_31_0.localEulerAngles

				var_31_7.z = 0
				var_31_7.x = 0
				var_31_0.localEulerAngles = var_31_7
			end

			if arg_28_1.time_ >= var_31_1 + var_31_3 and arg_28_1.time_ < var_31_1 + var_31_3 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0, -2.22, -3.1)

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

			local var_31_11 = arg_28_1.actors_["3004_tpose"]
			local var_31_12 = 0

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.characterEffect3004_tpose == nil then
				arg_28_1.var_.characterEffect3004_tpose = var_31_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_13 = 0.2

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_13 and not isNil(var_31_11) then
				local var_31_14 = (arg_28_1.time_ - var_31_12) / var_31_13

				if arg_28_1.var_.characterEffect3004_tpose and not isNil(var_31_11) then
					arg_28_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_12 + var_31_13 and arg_28_1.time_ < var_31_12 + var_31_13 + arg_31_0 and not isNil(var_31_11) and arg_28_1.var_.characterEffect3004_tpose then
				arg_28_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_31_15 = 0

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_31_16 = 0
			local var_31_17 = 0.575

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_18 = arg_28_1:FormatText(StoryNameCfg[158].name)

				arg_28_1.leftNameTxt_.text = var_31_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_19 = arg_28_1:GetWordFromCfg(109051007)
				local var_31_20 = arg_28_1:FormatText(var_31_19.content)

				arg_28_1.text_.text = var_31_20

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_21 = 23
				local var_31_22 = utf8.len(var_31_20)
				local var_31_23 = var_31_21 <= 0 and var_31_17 or var_31_17 * (var_31_22 / var_31_21)

				if var_31_23 > 0 and var_31_17 < var_31_23 then
					arg_28_1.talkMaxDuration = var_31_23

					if var_31_23 + var_31_16 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_23 + var_31_16
					end
				end

				arg_28_1.text_.text = var_31_20
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051007", "story_v_out_109051.awb") ~= 0 then
					local var_31_24 = manager.audio:GetVoiceLength("story_v_out_109051", "109051007", "story_v_out_109051.awb") / 1000

					if var_31_24 + var_31_16 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_24 + var_31_16
					end

					if var_31_19.prefab_name ~= "" and arg_28_1.actors_[var_31_19.prefab_name] ~= nil then
						local var_31_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_19.prefab_name].transform, "story_v_out_109051", "109051007", "story_v_out_109051.awb")

						arg_28_1:RecordAudio("109051007", var_31_25)
						arg_28_1:RecordAudio("109051007", var_31_25)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_109051", "109051007", "story_v_out_109051.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_109051", "109051007", "story_v_out_109051.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_26 = math.max(var_31_17, arg_28_1.talkMaxDuration)

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_26 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_16) / var_31_26

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_16 + var_31_26 and arg_28_1.time_ < var_31_16 + var_31_26 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
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
	Play109051008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 109051008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play109051009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["3004_tpose"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos3004_tpose = var_35_0.localPosition

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end
			end

			local var_35_3 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_3 then
				local var_35_4 = (arg_32_1.time_ - var_35_1) / var_35_3
				local var_35_5 = Vector3.New(0, 100, 0)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos3004_tpose, var_35_5, var_35_4)

				local var_35_6 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_6.x, var_35_6.y, var_35_6.z)

				local var_35_7 = var_35_0.localEulerAngles

				var_35_7.z = 0
				var_35_7.x = 0
				var_35_0.localEulerAngles = var_35_7
			end

			if arg_32_1.time_ >= var_35_1 + var_35_3 and arg_32_1.time_ < var_35_1 + var_35_3 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, 100, 0)

				local var_35_8 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_8.x, var_35_8.y, var_35_8.z)

				local var_35_9 = var_35_0.localEulerAngles

				var_35_9.z = 0
				var_35_9.x = 0
				var_35_0.localEulerAngles = var_35_9

				local var_35_10 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_10 then
					var_35_10:EnableDynamicBone(true)
				end
			end

			local var_35_11 = 0
			local var_35_12 = 0.4

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_13 = arg_32_1:GetWordFromCfg(109051008)
				local var_35_14 = arg_32_1:FormatText(var_35_13.content)

				arg_32_1.text_.text = var_35_14

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 16
				local var_35_16 = utf8.len(var_35_14)
				local var_35_17 = var_35_15 <= 0 and var_35_12 or var_35_12 * (var_35_16 / var_35_15)

				if var_35_17 > 0 and var_35_12 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_11 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_11
					end
				end

				arg_32_1.text_.text = var_35_14
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_18 = math.max(var_35_12, arg_32_1.talkMaxDuration)

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_18 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_11) / var_35_18

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_11 + var_35_18 and arg_32_1.time_ < var_35_11 + var_35_18 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
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
	Play109051009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 109051009
		arg_36_1.duration_ = 5.5

		local var_36_0 = {
			ja = 5.5,
			ko = 4,
			zh = 4.633,
			en = 3.933
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
				arg_36_0:Play109051010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.375

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[99].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(109051009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051009", "story_v_out_109051.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_109051", "109051009", "story_v_out_109051.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_109051", "109051009", "story_v_out_109051.awb")

						arg_36_1:RecordAudio("109051009", var_39_9)
						arg_36_1:RecordAudio("109051009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_109051", "109051009", "story_v_out_109051.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_109051", "109051009", "story_v_out_109051.awb")
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
	Play109051010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 109051010
		arg_40_1.duration_ = 29.1

		local var_40_0 = {
			ja = 29.1,
			ko = 7.6,
			zh = 13.6,
			en = 12.133
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
				arg_40_0:Play109051011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = "3007_tpose"

			if arg_40_1.actors_[var_43_0] == nil then
				local var_43_1 = Asset.Load("Char/" .. "3007_tpose")

				if not isNil(var_43_1) then
					local var_43_2 = Object.Instantiate(Asset.Load("Char/" .. "3007_tpose"), arg_40_1.stage_.transform)

					var_43_2.name = var_43_0
					var_43_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_40_1.actors_[var_43_0] = var_43_2

					local var_43_3 = var_43_2:GetComponentInChildren(typeof(CharacterEffect))

					var_43_3.enabled = true

					local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_2, typeof(DynamicBoneHelper))

					if var_43_4 then
						var_43_4:EnableDynamicBone(false)
					end

					arg_40_1:ShowWeapon(var_43_3.transform, false)

					arg_40_1.var_[var_43_0 .. "Animator"] = var_43_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_40_1.var_[var_43_0 .. "Animator"].applyRootMotion = true
					arg_40_1.var_[var_43_0 .. "LipSync"] = var_43_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_43_5 = arg_40_1.actors_["3007_tpose"].transform
			local var_43_6 = 0

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.var_.moveOldPos3007_tpose = var_43_5.localPosition

				local var_43_7 = GameObjectTools.GetOrAddComponent(var_43_5.gameObject, typeof(DynamicBoneHelper))

				if var_43_7 then
					var_43_7:EnableDynamicBone(false)
				end
			end

			local var_43_8 = 0.001

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_8 then
				local var_43_9 = (arg_40_1.time_ - var_43_6) / var_43_8
				local var_43_10 = Vector3.New(0, -2.25, -1.9)

				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos3007_tpose, var_43_10, var_43_9)

				local var_43_11 = manager.ui.mainCamera.transform.position - var_43_5.position

				var_43_5.forward = Vector3.New(var_43_11.x, var_43_11.y, var_43_11.z)

				local var_43_12 = var_43_5.localEulerAngles

				var_43_12.z = 0
				var_43_12.x = 0
				var_43_5.localEulerAngles = var_43_12
			end

			if arg_40_1.time_ >= var_43_6 + var_43_8 and arg_40_1.time_ < var_43_6 + var_43_8 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(0, -2.25, -1.9)

				local var_43_13 = manager.ui.mainCamera.transform.position - var_43_5.position

				var_43_5.forward = Vector3.New(var_43_13.x, var_43_13.y, var_43_13.z)

				local var_43_14 = var_43_5.localEulerAngles

				var_43_14.z = 0
				var_43_14.x = 0
				var_43_5.localEulerAngles = var_43_14

				local var_43_15 = GameObjectTools.GetOrAddComponent(var_43_5.gameObject, typeof(DynamicBoneHelper))

				if var_43_15 then
					var_43_15:EnableDynamicBone(true)
				end
			end

			local var_43_16 = arg_40_1.actors_["3007_tpose"]
			local var_43_17 = 0

			if var_43_17 < arg_40_1.time_ and arg_40_1.time_ <= var_43_17 + arg_43_0 and not isNil(var_43_16) and arg_40_1.var_.characterEffect3007_tpose == nil then
				arg_40_1.var_.characterEffect3007_tpose = var_43_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_18 = 0.2

			if var_43_17 <= arg_40_1.time_ and arg_40_1.time_ < var_43_17 + var_43_18 and not isNil(var_43_16) then
				local var_43_19 = (arg_40_1.time_ - var_43_17) / var_43_18

				if arg_40_1.var_.characterEffect3007_tpose and not isNil(var_43_16) then
					arg_40_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_17 + var_43_18 and arg_40_1.time_ < var_43_17 + var_43_18 + arg_43_0 and not isNil(var_43_16) and arg_40_1.var_.characterEffect3007_tpose then
				arg_40_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_43_20 = 0

			if var_43_20 < arg_40_1.time_ and arg_40_1.time_ <= var_43_20 + arg_43_0 then
				arg_40_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_43_21 = 0
			local var_43_22 = 0.65

			if var_43_21 < arg_40_1.time_ and arg_40_1.time_ <= var_43_21 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_23 = arg_40_1:FormatText(StoryNameCfg[158].name)

				arg_40_1.leftNameTxt_.text = var_43_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_24 = arg_40_1:GetWordFromCfg(109051010)
				local var_43_25 = arg_40_1:FormatText(var_43_24.content)

				arg_40_1.text_.text = var_43_25

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_26 = 26
				local var_43_27 = utf8.len(var_43_25)
				local var_43_28 = var_43_26 <= 0 and var_43_22 or var_43_22 * (var_43_27 / var_43_26)

				if var_43_28 > 0 and var_43_22 < var_43_28 then
					arg_40_1.talkMaxDuration = var_43_28

					if var_43_28 + var_43_21 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_28 + var_43_21
					end
				end

				arg_40_1.text_.text = var_43_25
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051010", "story_v_out_109051.awb") ~= 0 then
					local var_43_29 = manager.audio:GetVoiceLength("story_v_out_109051", "109051010", "story_v_out_109051.awb") / 1000

					if var_43_29 + var_43_21 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_29 + var_43_21
					end

					if var_43_24.prefab_name ~= "" and arg_40_1.actors_[var_43_24.prefab_name] ~= nil then
						local var_43_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_24.prefab_name].transform, "story_v_out_109051", "109051010", "story_v_out_109051.awb")

						arg_40_1:RecordAudio("109051010", var_43_30)
						arg_40_1:RecordAudio("109051010", var_43_30)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_109051", "109051010", "story_v_out_109051.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_109051", "109051010", "story_v_out_109051.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_31 = math.max(var_43_22, arg_40_1.talkMaxDuration)

			if var_43_21 <= arg_40_1.time_ and arg_40_1.time_ < var_43_21 + var_43_31 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_21) / var_43_31

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_21 + var_43_31 and arg_40_1.time_ < var_43_21 + var_43_31 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play109051011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 109051011
		arg_44_1.duration_ = 7.6

		local var_44_0 = {
			ja = 7,
			ko = 1.4,
			zh = 7.6,
			en = 2.5
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
				arg_44_0:Play109051012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["3007_tpose"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect3007_tpose == nil then
				arg_44_1.var_.characterEffect3007_tpose = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.2

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect3007_tpose and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_44_1.var_.characterEffect3007_tpose.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect3007_tpose then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_44_1.var_.characterEffect3007_tpose.fillRatio = var_47_5
			end

			local var_47_6 = 0
			local var_47_7 = 0.3

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_8 = arg_44_1:FormatText(StoryNameCfg[99].name)

				arg_44_1.leftNameTxt_.text = var_47_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_9 = arg_44_1:GetWordFromCfg(109051011)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 9
				local var_47_12 = utf8.len(var_47_10)
				local var_47_13 = var_47_11 <= 0 and var_47_7 or var_47_7 * (var_47_12 / var_47_11)

				if var_47_13 > 0 and var_47_7 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051011", "story_v_out_109051.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_109051", "109051011", "story_v_out_109051.awb") / 1000

					if var_47_14 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_6
					end

					if var_47_9.prefab_name ~= "" and arg_44_1.actors_[var_47_9.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_9.prefab_name].transform, "story_v_out_109051", "109051011", "story_v_out_109051.awb")

						arg_44_1:RecordAudio("109051011", var_47_15)
						arg_44_1:RecordAudio("109051011", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_109051", "109051011", "story_v_out_109051.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_109051", "109051011", "story_v_out_109051.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_16 and arg_44_1.time_ < var_47_6 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play109051012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 109051012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play109051013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.5

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(109051012)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 20
				local var_51_5 = utf8.len(var_51_3)
				local var_51_6 = var_51_4 <= 0 and var_51_1 or var_51_1 * (var_51_5 / var_51_4)

				if var_51_6 > 0 and var_51_1 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_7 and arg_48_1.time_ < var_51_0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play109051013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 109051013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play109051014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 1.3

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(109051013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 52
				local var_55_5 = utf8.len(var_55_3)
				local var_55_6 = var_55_4 <= 0 and var_55_1 or var_55_1 * (var_55_5 / var_55_4)

				if var_55_6 > 0 and var_55_1 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_7 and arg_52_1.time_ < var_55_0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play109051014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 109051014
		arg_56_1.duration_ = 11.7

		local var_56_0 = {
			ja = 10.2,
			ko = 8.266,
			zh = 10.4,
			en = 11.7
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
				arg_56_0:Play109051015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.775

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[99].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(109051014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 31
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051014", "story_v_out_109051.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_109051", "109051014", "story_v_out_109051.awb") / 1000

					if var_59_8 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_0
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_109051", "109051014", "story_v_out_109051.awb")

						arg_56_1:RecordAudio("109051014", var_59_9)
						arg_56_1:RecordAudio("109051014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_109051", "109051014", "story_v_out_109051.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_109051", "109051014", "story_v_out_109051.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_10 and arg_56_1.time_ < var_59_0 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play109051015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 109051015
		arg_60_1.duration_ = 9.37

		local var_60_0 = {
			ja = 8.066,
			ko = 8.766,
			zh = 9.366,
			en = 8.266
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
				arg_60_0:Play109051016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.975

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[99].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(109051015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 39
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051015", "story_v_out_109051.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_109051", "109051015", "story_v_out_109051.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_109051", "109051015", "story_v_out_109051.awb")

						arg_60_1:RecordAudio("109051015", var_63_9)
						arg_60_1:RecordAudio("109051015", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_109051", "109051015", "story_v_out_109051.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_109051", "109051015", "story_v_out_109051.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_10 and arg_60_1.time_ < var_63_0 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play109051016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 109051016
		arg_64_1.duration_ = 4.6

		local var_64_0 = {
			ja = 4.6,
			ko = 1.666,
			zh = 1.933,
			en = 2.566
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
				arg_64_0:Play109051017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["3007_tpose"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect3007_tpose == nil then
				arg_64_1.var_.characterEffect3007_tpose = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect3007_tpose and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect3007_tpose then
				arg_64_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_67_4 = 0
			local var_67_5 = 0.1

			if var_67_4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_6 = arg_64_1:FormatText(StoryNameCfg[158].name)

				arg_64_1.leftNameTxt_.text = var_67_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_7 = arg_64_1:GetWordFromCfg(109051016)
				local var_67_8 = arg_64_1:FormatText(var_67_7.content)

				arg_64_1.text_.text = var_67_8

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 4
				local var_67_10 = utf8.len(var_67_8)
				local var_67_11 = var_67_9 <= 0 and var_67_5 or var_67_5 * (var_67_10 / var_67_9)

				if var_67_11 > 0 and var_67_5 < var_67_11 then
					arg_64_1.talkMaxDuration = var_67_11

					if var_67_11 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_11 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_8
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051016", "story_v_out_109051.awb") ~= 0 then
					local var_67_12 = manager.audio:GetVoiceLength("story_v_out_109051", "109051016", "story_v_out_109051.awb") / 1000

					if var_67_12 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_12 + var_67_4
					end

					if var_67_7.prefab_name ~= "" and arg_64_1.actors_[var_67_7.prefab_name] ~= nil then
						local var_67_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_7.prefab_name].transform, "story_v_out_109051", "109051016", "story_v_out_109051.awb")

						arg_64_1:RecordAudio("109051016", var_67_13)
						arg_64_1:RecordAudio("109051016", var_67_13)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_109051", "109051016", "story_v_out_109051.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_109051", "109051016", "story_v_out_109051.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_14 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_14 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_14

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_14 and arg_64_1.time_ < var_67_4 + var_67_14 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play109051017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 109051017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play109051018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["3007_tpose"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect3007_tpose == nil then
				arg_68_1.var_.characterEffect3007_tpose = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect3007_tpose and not isNil(var_71_0) then
					local var_71_4 = Mathf.Lerp(0, 0.5, var_71_3)

					arg_68_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_68_1.var_.characterEffect3007_tpose.fillRatio = var_71_4
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect3007_tpose then
				local var_71_5 = 0.5

				arg_68_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_68_1.var_.characterEffect3007_tpose.fillRatio = var_71_5
			end

			local var_71_6 = 0
			local var_71_7 = 0.75

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_8 = arg_68_1:GetWordFromCfg(109051017)
				local var_71_9 = arg_68_1:FormatText(var_71_8.content)

				arg_68_1.text_.text = var_71_9

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_10 = 30
				local var_71_11 = utf8.len(var_71_9)
				local var_71_12 = var_71_10 <= 0 and var_71_7 or var_71_7 * (var_71_11 / var_71_10)

				if var_71_12 > 0 and var_71_7 < var_71_12 then
					arg_68_1.talkMaxDuration = var_71_12

					if var_71_12 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_12 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_9
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_13 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_13 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_13

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_13 and arg_68_1.time_ < var_71_6 + var_71_13 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play109051018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 109051018
		arg_72_1.duration_ = 2.73

		local var_72_0 = {
			ja = 2.733,
			ko = 1.2,
			zh = 2.1,
			en = 1.233
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
				arg_72_0:Play109051019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.1

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[99].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:GetWordFromCfg(109051018)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051018", "story_v_out_109051.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_109051", "109051018", "story_v_out_109051.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_109051", "109051018", "story_v_out_109051.awb")

						arg_72_1:RecordAudio("109051018", var_75_9)
						arg_72_1:RecordAudio("109051018", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_109051", "109051018", "story_v_out_109051.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_109051", "109051018", "story_v_out_109051.awb")
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
	Play109051019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 109051019
		arg_76_1.duration_ = 3.73

		local var_76_0 = {
			ja = 3.733,
			ko = 1.066,
			zh = 1.366,
			en = 3.633
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
				arg_76_0:Play109051020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["3007_tpose"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect3007_tpose == nil then
				arg_76_1.var_.characterEffect3007_tpose = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect3007_tpose and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect3007_tpose then
				arg_76_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_79_4 = 0
			local var_79_5 = 0.05

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_6 = arg_76_1:FormatText(StoryNameCfg[158].name)

				arg_76_1.leftNameTxt_.text = var_79_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_7 = arg_76_1:GetWordFromCfg(109051019)
				local var_79_8 = arg_76_1:FormatText(var_79_7.content)

				arg_76_1.text_.text = var_79_8

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 2
				local var_79_10 = utf8.len(var_79_8)
				local var_79_11 = var_79_9 <= 0 and var_79_5 or var_79_5 * (var_79_10 / var_79_9)

				if var_79_11 > 0 and var_79_5 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_8
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051019", "story_v_out_109051.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_109051", "109051019", "story_v_out_109051.awb") / 1000

					if var_79_12 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_4
					end

					if var_79_7.prefab_name ~= "" and arg_76_1.actors_[var_79_7.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_7.prefab_name].transform, "story_v_out_109051", "109051019", "story_v_out_109051.awb")

						arg_76_1:RecordAudio("109051019", var_79_13)
						arg_76_1:RecordAudio("109051019", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_109051", "109051019", "story_v_out_109051.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_109051", "109051019", "story_v_out_109051.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_14 and arg_76_1.time_ < var_79_4 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play109051020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 109051020
		arg_80_1.duration_ = 5.7

		local var_80_0 = {
			ja = 5.7,
			ko = 4.2,
			zh = 4.066,
			en = 3.933
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
				arg_80_0:Play109051021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["3007_tpose"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect3007_tpose == nil then
				arg_80_1.var_.characterEffect3007_tpose = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.2

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect3007_tpose and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_80_1.var_.characterEffect3007_tpose.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect3007_tpose then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_80_1.var_.characterEffect3007_tpose.fillRatio = var_83_5
			end

			local var_83_6 = 0
			local var_83_7 = 0.35

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_8 = arg_80_1:FormatText(StoryNameCfg[87].name)

				arg_80_1.leftNameTxt_.text = var_83_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4014")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_9 = arg_80_1:GetWordFromCfg(109051020)
				local var_83_10 = arg_80_1:FormatText(var_83_9.content)

				arg_80_1.text_.text = var_83_10

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 14
				local var_83_12 = utf8.len(var_83_10)
				local var_83_13 = var_83_11 <= 0 and var_83_7 or var_83_7 * (var_83_12 / var_83_11)

				if var_83_13 > 0 and var_83_7 < var_83_13 then
					arg_80_1.talkMaxDuration = var_83_13

					if var_83_13 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_6
					end
				end

				arg_80_1.text_.text = var_83_10
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051020", "story_v_out_109051.awb") ~= 0 then
					local var_83_14 = manager.audio:GetVoiceLength("story_v_out_109051", "109051020", "story_v_out_109051.awb") / 1000

					if var_83_14 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_14 + var_83_6
					end

					if var_83_9.prefab_name ~= "" and arg_80_1.actors_[var_83_9.prefab_name] ~= nil then
						local var_83_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_9.prefab_name].transform, "story_v_out_109051", "109051020", "story_v_out_109051.awb")

						arg_80_1:RecordAudio("109051020", var_83_15)
						arg_80_1:RecordAudio("109051020", var_83_15)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_109051", "109051020", "story_v_out_109051.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_109051", "109051020", "story_v_out_109051.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_16 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_16 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_16

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_16 and arg_80_1.time_ < var_83_6 + var_83_16 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play109051021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 109051021
		arg_84_1.duration_ = 3.2

		local var_84_0 = {
			ja = 3.2,
			ko = 2.3,
			zh = 2.733,
			en = 1.733
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
				arg_84_0:Play109051022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.25

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[99].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(109051021)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051021", "story_v_out_109051.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_109051", "109051021", "story_v_out_109051.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_109051", "109051021", "story_v_out_109051.awb")

						arg_84_1:RecordAudio("109051021", var_87_9)
						arg_84_1:RecordAudio("109051021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_109051", "109051021", "story_v_out_109051.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_109051", "109051021", "story_v_out_109051.awb")
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
	Play109051022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 109051022
		arg_88_1.duration_ = 11.57

		local var_88_0 = {
			ja = 11.566,
			ko = 7.633,
			zh = 10.033,
			en = 10.666
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
				arg_88_0:Play109051023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["3007_tpose"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos3007_tpose = var_91_0.localPosition

				local var_91_2 = GameObjectTools.GetOrAddComponent(var_91_0.gameObject, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(false)
				end
			end

			local var_91_3 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_3 then
				local var_91_4 = (arg_88_1.time_ - var_91_1) / var_91_3
				local var_91_5 = Vector3.New(0, 100, 0)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos3007_tpose, var_91_5, var_91_4)

				local var_91_6 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_6.x, var_91_6.y, var_91_6.z)

				local var_91_7 = var_91_0.localEulerAngles

				var_91_7.z = 0
				var_91_7.x = 0
				var_91_0.localEulerAngles = var_91_7
			end

			if arg_88_1.time_ >= var_91_1 + var_91_3 and arg_88_1.time_ < var_91_1 + var_91_3 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, 100, 0)

				local var_91_8 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_8.x, var_91_8.y, var_91_8.z)

				local var_91_9 = var_91_0.localEulerAngles

				var_91_9.z = 0
				var_91_9.x = 0
				var_91_0.localEulerAngles = var_91_9

				local var_91_10 = GameObjectTools.GetOrAddComponent(var_91_0.gameObject, typeof(DynamicBoneHelper))

				if var_91_10 then
					var_91_10:EnableDynamicBone(true)
				end
			end

			local var_91_11 = "4014_tpose"

			if arg_88_1.actors_[var_91_11] == nil then
				local var_91_12 = Asset.Load("Char/" .. "4014_tpose")

				if not isNil(var_91_12) then
					local var_91_13 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_88_1.stage_.transform)

					var_91_13.name = var_91_11
					var_91_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_88_1.actors_[var_91_11] = var_91_13

					local var_91_14 = var_91_13:GetComponentInChildren(typeof(CharacterEffect))

					var_91_14.enabled = true

					local var_91_15 = GameObjectTools.GetOrAddComponent(var_91_13, typeof(DynamicBoneHelper))

					if var_91_15 then
						var_91_15:EnableDynamicBone(false)
					end

					arg_88_1:ShowWeapon(var_91_14.transform, false)

					arg_88_1.var_[var_91_11 .. "Animator"] = var_91_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_88_1.var_[var_91_11 .. "Animator"].applyRootMotion = true
					arg_88_1.var_[var_91_11 .. "LipSync"] = var_91_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_91_16 = arg_88_1.actors_["4014_tpose"].transform
			local var_91_17 = 0

			if var_91_17 < arg_88_1.time_ and arg_88_1.time_ <= var_91_17 + arg_91_0 then
				arg_88_1.var_.moveOldPos4014_tpose = var_91_16.localPosition

				local var_91_18 = GameObjectTools.GetOrAddComponent(var_91_16.gameObject, typeof(DynamicBoneHelper))

				if var_91_18 then
					var_91_18:EnableDynamicBone(false)
				end
			end

			local var_91_19 = 0.001

			if var_91_17 <= arg_88_1.time_ and arg_88_1.time_ < var_91_17 + var_91_19 then
				local var_91_20 = (arg_88_1.time_ - var_91_17) / var_91_19
				local var_91_21 = Vector3.New(0, -1.95, -4.2)

				var_91_16.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos4014_tpose, var_91_21, var_91_20)

				local var_91_22 = manager.ui.mainCamera.transform.position - var_91_16.position

				var_91_16.forward = Vector3.New(var_91_22.x, var_91_22.y, var_91_22.z)

				local var_91_23 = var_91_16.localEulerAngles

				var_91_23.z = 0
				var_91_23.x = 0
				var_91_16.localEulerAngles = var_91_23
			end

			if arg_88_1.time_ >= var_91_17 + var_91_19 and arg_88_1.time_ < var_91_17 + var_91_19 + arg_91_0 then
				var_91_16.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_91_24 = manager.ui.mainCamera.transform.position - var_91_16.position

				var_91_16.forward = Vector3.New(var_91_24.x, var_91_24.y, var_91_24.z)

				local var_91_25 = var_91_16.localEulerAngles

				var_91_25.z = 0
				var_91_25.x = 0
				var_91_16.localEulerAngles = var_91_25

				local var_91_26 = GameObjectTools.GetOrAddComponent(var_91_16.gameObject, typeof(DynamicBoneHelper))

				if var_91_26 then
					var_91_26:EnableDynamicBone(true)
				end
			end

			local var_91_27 = arg_88_1.actors_["4014_tpose"]
			local var_91_28 = 0

			if var_91_28 < arg_88_1.time_ and arg_88_1.time_ <= var_91_28 + arg_91_0 and not isNil(var_91_27) and arg_88_1.var_.characterEffect4014_tpose == nil then
				arg_88_1.var_.characterEffect4014_tpose = var_91_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_29 = 0.2

			if var_91_28 <= arg_88_1.time_ and arg_88_1.time_ < var_91_28 + var_91_29 and not isNil(var_91_27) then
				local var_91_30 = (arg_88_1.time_ - var_91_28) / var_91_29

				if arg_88_1.var_.characterEffect4014_tpose and not isNil(var_91_27) then
					arg_88_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_28 + var_91_29 and arg_88_1.time_ < var_91_28 + var_91_29 + arg_91_0 and not isNil(var_91_27) and arg_88_1.var_.characterEffect4014_tpose then
				arg_88_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_91_31 = 0

			if var_91_31 < arg_88_1.time_ and arg_88_1.time_ <= var_91_31 + arg_91_0 then
				arg_88_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_91_32 = 0
			local var_91_33 = 0.85

			if var_91_32 < arg_88_1.time_ and arg_88_1.time_ <= var_91_32 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_34 = arg_88_1:FormatText(StoryNameCfg[87].name)

				arg_88_1.leftNameTxt_.text = var_91_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_35 = arg_88_1:GetWordFromCfg(109051022)
				local var_91_36 = arg_88_1:FormatText(var_91_35.content)

				arg_88_1.text_.text = var_91_36

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_37 = 34
				local var_91_38 = utf8.len(var_91_36)
				local var_91_39 = var_91_37 <= 0 and var_91_33 or var_91_33 * (var_91_38 / var_91_37)

				if var_91_39 > 0 and var_91_33 < var_91_39 then
					arg_88_1.talkMaxDuration = var_91_39

					if var_91_39 + var_91_32 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_39 + var_91_32
					end
				end

				arg_88_1.text_.text = var_91_36
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051022", "story_v_out_109051.awb") ~= 0 then
					local var_91_40 = manager.audio:GetVoiceLength("story_v_out_109051", "109051022", "story_v_out_109051.awb") / 1000

					if var_91_40 + var_91_32 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_40 + var_91_32
					end

					if var_91_35.prefab_name ~= "" and arg_88_1.actors_[var_91_35.prefab_name] ~= nil then
						local var_91_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_35.prefab_name].transform, "story_v_out_109051", "109051022", "story_v_out_109051.awb")

						arg_88_1:RecordAudio("109051022", var_91_41)
						arg_88_1:RecordAudio("109051022", var_91_41)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_109051", "109051022", "story_v_out_109051.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_109051", "109051022", "story_v_out_109051.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_42 = math.max(var_91_33, arg_88_1.talkMaxDuration)

			if var_91_32 <= arg_88_1.time_ and arg_88_1.time_ < var_91_32 + var_91_42 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_32) / var_91_42

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_32 + var_91_42 and arg_88_1.time_ < var_91_32 + var_91_42 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play109051023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 109051023
		arg_92_1.duration_ = 8.97

		local var_92_0 = {
			ja = 8.966,
			ko = 5.8,
			zh = 4.566,
			en = 4.866
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
				arg_92_0:Play109051024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["4014_tpose"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect4014_tpose == nil then
				arg_92_1.var_.characterEffect4014_tpose = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.2

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect4014_tpose and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_92_1.var_.characterEffect4014_tpose.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect4014_tpose then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_92_1.var_.characterEffect4014_tpose.fillRatio = var_95_5
			end

			local var_95_6 = 0
			local var_95_7 = 0.525

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_8 = arg_92_1:FormatText(StoryNameCfg[99].name)

				arg_92_1.leftNameTxt_.text = var_95_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_9 = arg_92_1:GetWordFromCfg(109051023)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 21
				local var_95_12 = utf8.len(var_95_10)
				local var_95_13 = var_95_11 <= 0 and var_95_7 or var_95_7 * (var_95_12 / var_95_11)

				if var_95_13 > 0 and var_95_7 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_10
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051023", "story_v_out_109051.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_109051", "109051023", "story_v_out_109051.awb") / 1000

					if var_95_14 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_6
					end

					if var_95_9.prefab_name ~= "" and arg_92_1.actors_[var_95_9.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_9.prefab_name].transform, "story_v_out_109051", "109051023", "story_v_out_109051.awb")

						arg_92_1:RecordAudio("109051023", var_95_15)
						arg_92_1:RecordAudio("109051023", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_109051", "109051023", "story_v_out_109051.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_109051", "109051023", "story_v_out_109051.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_16 and arg_92_1.time_ < var_95_6 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play109051024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 109051024
		arg_96_1.duration_ = 17.53

		local var_96_0 = {
			ja = 13.633,
			ko = 11.666,
			zh = 10.266,
			en = 17.533
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
				arg_96_0:Play109051025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["4014_tpose"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect4014_tpose == nil then
				arg_96_1.var_.characterEffect4014_tpose = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect4014_tpose and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect4014_tpose then
				arg_96_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_99_4 = 0
			local var_99_5 = 0.8

			if var_99_4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_6 = arg_96_1:FormatText(StoryNameCfg[87].name)

				arg_96_1.leftNameTxt_.text = var_99_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_7 = arg_96_1:GetWordFromCfg(109051024)
				local var_99_8 = arg_96_1:FormatText(var_99_7.content)

				arg_96_1.text_.text = var_99_8

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 32
				local var_99_10 = utf8.len(var_99_8)
				local var_99_11 = var_99_9 <= 0 and var_99_5 or var_99_5 * (var_99_10 / var_99_9)

				if var_99_11 > 0 and var_99_5 < var_99_11 then
					arg_96_1.talkMaxDuration = var_99_11

					if var_99_11 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_11 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_8
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051024", "story_v_out_109051.awb") ~= 0 then
					local var_99_12 = manager.audio:GetVoiceLength("story_v_out_109051", "109051024", "story_v_out_109051.awb") / 1000

					if var_99_12 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_12 + var_99_4
					end

					if var_99_7.prefab_name ~= "" and arg_96_1.actors_[var_99_7.prefab_name] ~= nil then
						local var_99_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_7.prefab_name].transform, "story_v_out_109051", "109051024", "story_v_out_109051.awb")

						arg_96_1:RecordAudio("109051024", var_99_13)
						arg_96_1:RecordAudio("109051024", var_99_13)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_109051", "109051024", "story_v_out_109051.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_109051", "109051024", "story_v_out_109051.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_14 = math.max(var_99_5, arg_96_1.talkMaxDuration)

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_14 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_4) / var_99_14

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_4 + var_99_14 and arg_96_1.time_ < var_99_4 + var_99_14 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play109051025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 109051025
		arg_100_1.duration_ = 19.1

		local var_100_0 = {
			ja = 19.1,
			ko = 6.9,
			zh = 9.866,
			en = 14.7
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
				arg_100_0:Play109051026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["4014_tpose"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos4014_tpose = var_103_0.localPosition

				local var_103_2 = GameObjectTools.GetOrAddComponent(var_103_0.gameObject, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(false)
				end
			end

			local var_103_3 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_3 then
				local var_103_4 = (arg_100_1.time_ - var_103_1) / var_103_3
				local var_103_5 = Vector3.New(0, 100, 0)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos4014_tpose, var_103_5, var_103_4)

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

			local var_103_11 = arg_100_1.actors_["3007_tpose"].transform
			local var_103_12 = 0

			if var_103_12 < arg_100_1.time_ and arg_100_1.time_ <= var_103_12 + arg_103_0 then
				arg_100_1.var_.moveOldPos3007_tpose = var_103_11.localPosition

				local var_103_13 = GameObjectTools.GetOrAddComponent(var_103_11.gameObject, typeof(DynamicBoneHelper))

				if var_103_13 then
					var_103_13:EnableDynamicBone(false)
				end
			end

			local var_103_14 = 0.001

			if var_103_12 <= arg_100_1.time_ and arg_100_1.time_ < var_103_12 + var_103_14 then
				local var_103_15 = (arg_100_1.time_ - var_103_12) / var_103_14
				local var_103_16 = Vector3.New(0, -2.25, -1.9)

				var_103_11.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos3007_tpose, var_103_16, var_103_15)

				local var_103_17 = manager.ui.mainCamera.transform.position - var_103_11.position

				var_103_11.forward = Vector3.New(var_103_17.x, var_103_17.y, var_103_17.z)

				local var_103_18 = var_103_11.localEulerAngles

				var_103_18.z = 0
				var_103_18.x = 0
				var_103_11.localEulerAngles = var_103_18
			end

			if arg_100_1.time_ >= var_103_12 + var_103_14 and arg_100_1.time_ < var_103_12 + var_103_14 + arg_103_0 then
				var_103_11.localPosition = Vector3.New(0, -2.25, -1.9)

				local var_103_19 = manager.ui.mainCamera.transform.position - var_103_11.position

				var_103_11.forward = Vector3.New(var_103_19.x, var_103_19.y, var_103_19.z)

				local var_103_20 = var_103_11.localEulerAngles

				var_103_20.z = 0
				var_103_20.x = 0
				var_103_11.localEulerAngles = var_103_20

				local var_103_21 = GameObjectTools.GetOrAddComponent(var_103_11.gameObject, typeof(DynamicBoneHelper))

				if var_103_21 then
					var_103_21:EnableDynamicBone(true)
				end
			end

			local var_103_22 = arg_100_1.actors_["3007_tpose"]
			local var_103_23 = 0

			if var_103_23 < arg_100_1.time_ and arg_100_1.time_ <= var_103_23 + arg_103_0 and not isNil(var_103_22) and arg_100_1.var_.characterEffect3007_tpose == nil then
				arg_100_1.var_.characterEffect3007_tpose = var_103_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_24 = 0.2

			if var_103_23 <= arg_100_1.time_ and arg_100_1.time_ < var_103_23 + var_103_24 and not isNil(var_103_22) then
				local var_103_25 = (arg_100_1.time_ - var_103_23) / var_103_24

				if arg_100_1.var_.characterEffect3007_tpose and not isNil(var_103_22) then
					arg_100_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_23 + var_103_24 and arg_100_1.time_ < var_103_23 + var_103_24 + arg_103_0 and not isNil(var_103_22) and arg_100_1.var_.characterEffect3007_tpose then
				arg_100_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_103_26 = 0

			if var_103_26 < arg_100_1.time_ and arg_100_1.time_ <= var_103_26 + arg_103_0 then
				arg_100_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_103_27 = 0
			local var_103_28 = 0.575

			if var_103_27 < arg_100_1.time_ and arg_100_1.time_ <= var_103_27 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_29 = arg_100_1:FormatText(StoryNameCfg[158].name)

				arg_100_1.leftNameTxt_.text = var_103_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_30 = arg_100_1:GetWordFromCfg(109051025)
				local var_103_31 = arg_100_1:FormatText(var_103_30.content)

				arg_100_1.text_.text = var_103_31

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_32 = 23
				local var_103_33 = utf8.len(var_103_31)
				local var_103_34 = var_103_32 <= 0 and var_103_28 or var_103_28 * (var_103_33 / var_103_32)

				if var_103_34 > 0 and var_103_28 < var_103_34 then
					arg_100_1.talkMaxDuration = var_103_34

					if var_103_34 + var_103_27 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_34 + var_103_27
					end
				end

				arg_100_1.text_.text = var_103_31
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051025", "story_v_out_109051.awb") ~= 0 then
					local var_103_35 = manager.audio:GetVoiceLength("story_v_out_109051", "109051025", "story_v_out_109051.awb") / 1000

					if var_103_35 + var_103_27 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_35 + var_103_27
					end

					if var_103_30.prefab_name ~= "" and arg_100_1.actors_[var_103_30.prefab_name] ~= nil then
						local var_103_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_30.prefab_name].transform, "story_v_out_109051", "109051025", "story_v_out_109051.awb")

						arg_100_1:RecordAudio("109051025", var_103_36)
						arg_100_1:RecordAudio("109051025", var_103_36)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_109051", "109051025", "story_v_out_109051.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_109051", "109051025", "story_v_out_109051.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_37 = math.max(var_103_28, arg_100_1.talkMaxDuration)

			if var_103_27 <= arg_100_1.time_ and arg_100_1.time_ < var_103_27 + var_103_37 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_27) / var_103_37

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_27 + var_103_37 and arg_100_1.time_ < var_103_27 + var_103_37 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3007_tpose",
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
	Play109051026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 109051026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play109051027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["3007_tpose"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect3007_tpose == nil then
				arg_104_1.var_.characterEffect3007_tpose = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect3007_tpose and not isNil(var_107_0) then
					local var_107_4 = Mathf.Lerp(0, 0.5, var_107_3)

					arg_104_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_104_1.var_.characterEffect3007_tpose.fillRatio = var_107_4
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect3007_tpose then
				local var_107_5 = 0.5

				arg_104_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_104_1.var_.characterEffect3007_tpose.fillRatio = var_107_5
			end

			local var_107_6 = arg_104_1.actors_["3007_tpose"].transform
			local var_107_7 = 0.566666666666667

			if var_107_7 < arg_104_1.time_ and arg_104_1.time_ <= var_107_7 + arg_107_0 then
				arg_104_1.var_.shakeOldPos3007_tpose = var_107_6.localPosition
			end

			local var_107_8 = 0.2

			if var_107_7 <= arg_104_1.time_ and arg_104_1.time_ < var_107_7 + var_107_8 then
				local var_107_9 = (arg_104_1.time_ - var_107_7) / 0.066
				local var_107_10, var_107_11 = math.modf(var_107_9)

				var_107_6.localPosition = Vector3.New(var_107_11 * 0.15, var_107_11 * 0.15, var_107_11 * 0) + arg_104_1.var_.shakeOldPos3007_tpose
			end

			if arg_104_1.time_ >= var_107_7 + var_107_8 and arg_104_1.time_ < var_107_7 + var_107_8 + arg_107_0 then
				var_107_6.localPosition = arg_104_1.var_.shakeOldPos3007_tpose
			end

			local var_107_12 = 0
			local var_107_13 = 1

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 then
				local var_107_14 = "play"
				local var_107_15 = "effect"

				arg_104_1:AudioAction(var_107_14, var_107_15, "se_story_9", "se_story_9_smash02", "")
			end

			local var_107_16 = 0
			local var_107_17 = 1.1

			if var_107_16 < arg_104_1.time_ and arg_104_1.time_ <= var_107_16 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_18 = arg_104_1:GetWordFromCfg(109051026)
				local var_107_19 = arg_104_1:FormatText(var_107_18.content)

				arg_104_1.text_.text = var_107_19

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_20 = 44
				local var_107_21 = utf8.len(var_107_19)
				local var_107_22 = var_107_20 <= 0 and var_107_17 or var_107_17 * (var_107_21 / var_107_20)

				if var_107_22 > 0 and var_107_17 < var_107_22 then
					arg_104_1.talkMaxDuration = var_107_22

					if var_107_22 + var_107_16 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_22 + var_107_16
					end
				end

				arg_104_1.text_.text = var_107_19
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_23 = math.max(var_107_17, arg_104_1.talkMaxDuration)

			if var_107_16 <= arg_104_1.time_ and arg_104_1.time_ < var_107_16 + var_107_23 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_16) / var_107_23

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_16 + var_107_23 and arg_104_1.time_ < var_107_16 + var_107_23 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play109051027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 109051027
		arg_108_1.duration_ = 6.8

		local var_108_0 = {
			ja = 6.8,
			ko = 4.166,
			zh = 3.3,
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
				arg_108_0:Play109051028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["3007_tpose"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos3007_tpose = var_111_0.localPosition

				local var_111_2 = GameObjectTools.GetOrAddComponent(var_111_0.gameObject, typeof(DynamicBoneHelper))

				if var_111_2 then
					var_111_2:EnableDynamicBone(false)
				end
			end

			local var_111_3 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_3 then
				local var_111_4 = (arg_108_1.time_ - var_111_1) / var_111_3
				local var_111_5 = Vector3.New(0, 100, 0)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos3007_tpose, var_111_5, var_111_4)

				local var_111_6 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_6.x, var_111_6.y, var_111_6.z)

				local var_111_7 = var_111_0.localEulerAngles

				var_111_7.z = 0
				var_111_7.x = 0
				var_111_0.localEulerAngles = var_111_7
			end

			if arg_108_1.time_ >= var_111_1 + var_111_3 and arg_108_1.time_ < var_111_1 + var_111_3 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0, 100, 0)

				local var_111_8 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_8.x, var_111_8.y, var_111_8.z)

				local var_111_9 = var_111_0.localEulerAngles

				var_111_9.z = 0
				var_111_9.x = 0
				var_111_0.localEulerAngles = var_111_9

				local var_111_10 = GameObjectTools.GetOrAddComponent(var_111_0.gameObject, typeof(DynamicBoneHelper))

				if var_111_10 then
					var_111_10:EnableDynamicBone(true)
				end
			end

			local var_111_11 = arg_108_1.actors_["4014_tpose"].transform
			local var_111_12 = 0

			if var_111_12 < arg_108_1.time_ and arg_108_1.time_ <= var_111_12 + arg_111_0 then
				arg_108_1.var_.moveOldPos4014_tpose = var_111_11.localPosition

				local var_111_13 = GameObjectTools.GetOrAddComponent(var_111_11.gameObject, typeof(DynamicBoneHelper))

				if var_111_13 then
					var_111_13:EnableDynamicBone(false)
				end
			end

			local var_111_14 = 0.001

			if var_111_12 <= arg_108_1.time_ and arg_108_1.time_ < var_111_12 + var_111_14 then
				local var_111_15 = (arg_108_1.time_ - var_111_12) / var_111_14
				local var_111_16 = Vector3.New(0, -1.95, -4.2)

				var_111_11.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos4014_tpose, var_111_16, var_111_15)

				local var_111_17 = manager.ui.mainCamera.transform.position - var_111_11.position

				var_111_11.forward = Vector3.New(var_111_17.x, var_111_17.y, var_111_17.z)

				local var_111_18 = var_111_11.localEulerAngles

				var_111_18.z = 0
				var_111_18.x = 0
				var_111_11.localEulerAngles = var_111_18
			end

			if arg_108_1.time_ >= var_111_12 + var_111_14 and arg_108_1.time_ < var_111_12 + var_111_14 + arg_111_0 then
				var_111_11.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_111_19 = manager.ui.mainCamera.transform.position - var_111_11.position

				var_111_11.forward = Vector3.New(var_111_19.x, var_111_19.y, var_111_19.z)

				local var_111_20 = var_111_11.localEulerAngles

				var_111_20.z = 0
				var_111_20.x = 0
				var_111_11.localEulerAngles = var_111_20

				local var_111_21 = GameObjectTools.GetOrAddComponent(var_111_11.gameObject, typeof(DynamicBoneHelper))

				if var_111_21 then
					var_111_21:EnableDynamicBone(true)
				end
			end

			local var_111_22 = arg_108_1.actors_["4014_tpose"]
			local var_111_23 = 0

			if var_111_23 < arg_108_1.time_ and arg_108_1.time_ <= var_111_23 + arg_111_0 and not isNil(var_111_22) and arg_108_1.var_.characterEffect4014_tpose == nil then
				arg_108_1.var_.characterEffect4014_tpose = var_111_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_24 = 0.2

			if var_111_23 <= arg_108_1.time_ and arg_108_1.time_ < var_111_23 + var_111_24 and not isNil(var_111_22) then
				local var_111_25 = (arg_108_1.time_ - var_111_23) / var_111_24

				if arg_108_1.var_.characterEffect4014_tpose and not isNil(var_111_22) then
					arg_108_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_23 + var_111_24 and arg_108_1.time_ < var_111_23 + var_111_24 + arg_111_0 and not isNil(var_111_22) and arg_108_1.var_.characterEffect4014_tpose then
				arg_108_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_111_26 = 0

			if var_111_26 < arg_108_1.time_ and arg_108_1.time_ <= var_111_26 + arg_111_0 then
				arg_108_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_111_27 = 0
			local var_111_28 = 0.325

			if var_111_27 < arg_108_1.time_ and arg_108_1.time_ <= var_111_27 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_29 = arg_108_1:FormatText(StoryNameCfg[87].name)

				arg_108_1.leftNameTxt_.text = var_111_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_30 = arg_108_1:GetWordFromCfg(109051027)
				local var_111_31 = arg_108_1:FormatText(var_111_30.content)

				arg_108_1.text_.text = var_111_31

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_32 = 13
				local var_111_33 = utf8.len(var_111_31)
				local var_111_34 = var_111_32 <= 0 and var_111_28 or var_111_28 * (var_111_33 / var_111_32)

				if var_111_34 > 0 and var_111_28 < var_111_34 then
					arg_108_1.talkMaxDuration = var_111_34

					if var_111_34 + var_111_27 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_34 + var_111_27
					end
				end

				arg_108_1.text_.text = var_111_31
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051027", "story_v_out_109051.awb") ~= 0 then
					local var_111_35 = manager.audio:GetVoiceLength("story_v_out_109051", "109051027", "story_v_out_109051.awb") / 1000

					if var_111_35 + var_111_27 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_35 + var_111_27
					end

					if var_111_30.prefab_name ~= "" and arg_108_1.actors_[var_111_30.prefab_name] ~= nil then
						local var_111_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_30.prefab_name].transform, "story_v_out_109051", "109051027", "story_v_out_109051.awb")

						arg_108_1:RecordAudio("109051027", var_111_36)
						arg_108_1:RecordAudio("109051027", var_111_36)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_109051", "109051027", "story_v_out_109051.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_109051", "109051027", "story_v_out_109051.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_37 = math.max(var_111_28, arg_108_1.talkMaxDuration)

			if var_111_27 <= arg_108_1.time_ and arg_108_1.time_ < var_111_27 + var_111_37 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_27) / var_111_37

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_27 + var_111_37 and arg_108_1.time_ < var_111_27 + var_111_37 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play109051028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 109051028
		arg_112_1.duration_ = 8

		local var_112_0 = {
			ja = 6,
			ko = 8,
			zh = 6.766,
			en = 7.266
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
				arg_112_0:Play109051029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.625

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[87].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_3 = arg_112_1:GetWordFromCfg(109051028)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051028", "story_v_out_109051.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_109051", "109051028", "story_v_out_109051.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_109051", "109051028", "story_v_out_109051.awb")

						arg_112_1:RecordAudio("109051028", var_115_9)
						arg_112_1:RecordAudio("109051028", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_109051", "109051028", "story_v_out_109051.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_109051", "109051028", "story_v_out_109051.awb")
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
	Play109051029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 109051029
		arg_116_1.duration_ = 15.1

		local var_116_0 = {
			ja = 11.433,
			ko = 14.533,
			zh = 13.433,
			en = 15.1
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
				arg_116_0:Play109051030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 1.4

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[87].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:GetWordFromCfg(109051029)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 56
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051029", "story_v_out_109051.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_109051", "109051029", "story_v_out_109051.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_109051", "109051029", "story_v_out_109051.awb")

						arg_116_1:RecordAudio("109051029", var_119_9)
						arg_116_1:RecordAudio("109051029", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_109051", "109051029", "story_v_out_109051.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_109051", "109051029", "story_v_out_109051.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_10 and arg_116_1.time_ < var_119_0 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play109051030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 109051030
		arg_120_1.duration_ = 3.07

		local var_120_0 = {
			ja = 2.3,
			ko = 3.066,
			zh = 2.166,
			en = 2.5
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
				arg_120_0:Play109051031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["4014_tpose"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos4014_tpose = var_123_0.localPosition

				local var_123_2 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(false)
				end
			end

			local var_123_3 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_3 then
				local var_123_4 = (arg_120_1.time_ - var_123_1) / var_123_3
				local var_123_5 = Vector3.New(0, 100, 0)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos4014_tpose, var_123_5, var_123_4)

				local var_123_6 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_6.x, var_123_6.y, var_123_6.z)

				local var_123_7 = var_123_0.localEulerAngles

				var_123_7.z = 0
				var_123_7.x = 0
				var_123_0.localEulerAngles = var_123_7
			end

			if arg_120_1.time_ >= var_123_1 + var_123_3 and arg_120_1.time_ < var_123_1 + var_123_3 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0, 100, 0)

				local var_123_8 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_8.x, var_123_8.y, var_123_8.z)

				local var_123_9 = var_123_0.localEulerAngles

				var_123_9.z = 0
				var_123_9.x = 0
				var_123_0.localEulerAngles = var_123_9

				local var_123_10 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_10 then
					var_123_10:EnableDynamicBone(true)
				end
			end

			local var_123_11 = 0
			local var_123_12 = 0.275

			if var_123_11 < arg_120_1.time_ and arg_120_1.time_ <= var_123_11 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_13 = arg_120_1:FormatText(StoryNameCfg[99].name)

				arg_120_1.leftNameTxt_.text = var_123_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_14 = arg_120_1:GetWordFromCfg(109051030)
				local var_123_15 = arg_120_1:FormatText(var_123_14.content)

				arg_120_1.text_.text = var_123_15

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_16 = 11
				local var_123_17 = utf8.len(var_123_15)
				local var_123_18 = var_123_16 <= 0 and var_123_12 or var_123_12 * (var_123_17 / var_123_16)

				if var_123_18 > 0 and var_123_12 < var_123_18 then
					arg_120_1.talkMaxDuration = var_123_18

					if var_123_18 + var_123_11 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_18 + var_123_11
					end
				end

				arg_120_1.text_.text = var_123_15
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051030", "story_v_out_109051.awb") ~= 0 then
					local var_123_19 = manager.audio:GetVoiceLength("story_v_out_109051", "109051030", "story_v_out_109051.awb") / 1000

					if var_123_19 + var_123_11 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_19 + var_123_11
					end

					if var_123_14.prefab_name ~= "" and arg_120_1.actors_[var_123_14.prefab_name] ~= nil then
						local var_123_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_14.prefab_name].transform, "story_v_out_109051", "109051030", "story_v_out_109051.awb")

						arg_120_1:RecordAudio("109051030", var_123_20)
						arg_120_1:RecordAudio("109051030", var_123_20)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_109051", "109051030", "story_v_out_109051.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_109051", "109051030", "story_v_out_109051.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_21 = math.max(var_123_12, arg_120_1.talkMaxDuration)

			if var_123_11 <= arg_120_1.time_ and arg_120_1.time_ < var_123_11 + var_123_21 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_11) / var_123_21

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_11 + var_123_21 and arg_120_1.time_ < var_123_11 + var_123_21 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play109051031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 109051031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play109051032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.7

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				local var_127_2 = "play"
				local var_127_3 = "effect"

				arg_124_1:AudioAction(var_127_2, var_127_3, "se_story_9", "se_story_9_long_knife", "")
			end

			local var_127_4 = 0
			local var_127_5 = 1.025

			if var_127_4 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_6 = arg_124_1:GetWordFromCfg(109051031)
				local var_127_7 = arg_124_1:FormatText(var_127_6.content)

				arg_124_1.text_.text = var_127_7

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_8 = 41
				local var_127_9 = utf8.len(var_127_7)
				local var_127_10 = var_127_8 <= 0 and var_127_5 or var_127_5 * (var_127_9 / var_127_8)

				if var_127_10 > 0 and var_127_5 < var_127_10 then
					arg_124_1.talkMaxDuration = var_127_10

					if var_127_10 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_4
					end
				end

				arg_124_1.text_.text = var_127_7
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_11 = math.max(var_127_5, arg_124_1.talkMaxDuration)

			if var_127_4 <= arg_124_1.time_ and arg_124_1.time_ < var_127_4 + var_127_11 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_4) / var_127_11

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_4 + var_127_11 and arg_124_1.time_ < var_127_4 + var_127_11 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play109051032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 109051032
		arg_128_1.duration_ = 7.7

		local var_128_0 = {
			ja = 5.933,
			ko = 7.466,
			zh = 7.7,
			en = 6.333
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
				arg_128_0:Play109051033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["3004_tpose"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos3004_tpose = var_131_0.localPosition

				local var_131_2 = GameObjectTools.GetOrAddComponent(var_131_0.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(false)
				end
			end

			local var_131_3 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_3 then
				local var_131_4 = (arg_128_1.time_ - var_131_1) / var_131_3
				local var_131_5 = Vector3.New(0, -2.22, -3.1)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos3004_tpose, var_131_5, var_131_4)

				local var_131_6 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_6.x, var_131_6.y, var_131_6.z)

				local var_131_7 = var_131_0.localEulerAngles

				var_131_7.z = 0
				var_131_7.x = 0
				var_131_0.localEulerAngles = var_131_7
			end

			if arg_128_1.time_ >= var_131_1 + var_131_3 and arg_128_1.time_ < var_131_1 + var_131_3 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_131_8 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_8.x, var_131_8.y, var_131_8.z)

				local var_131_9 = var_131_0.localEulerAngles

				var_131_9.z = 0
				var_131_9.x = 0
				var_131_0.localEulerAngles = var_131_9

				local var_131_10 = GameObjectTools.GetOrAddComponent(var_131_0.gameObject, typeof(DynamicBoneHelper))

				if var_131_10 then
					var_131_10:EnableDynamicBone(true)
				end
			end

			local var_131_11 = arg_128_1.actors_["3004_tpose"]
			local var_131_12 = 0

			if var_131_12 < arg_128_1.time_ and arg_128_1.time_ <= var_131_12 + arg_131_0 and not isNil(var_131_11) and arg_128_1.var_.characterEffect3004_tpose == nil then
				arg_128_1.var_.characterEffect3004_tpose = var_131_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_13 = 0.2

			if var_131_12 <= arg_128_1.time_ and arg_128_1.time_ < var_131_12 + var_131_13 and not isNil(var_131_11) then
				local var_131_14 = (arg_128_1.time_ - var_131_12) / var_131_13

				if arg_128_1.var_.characterEffect3004_tpose and not isNil(var_131_11) then
					arg_128_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_12 + var_131_13 and arg_128_1.time_ < var_131_12 + var_131_13 + arg_131_0 and not isNil(var_131_11) and arg_128_1.var_.characterEffect3004_tpose then
				arg_128_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_131_15 = 0

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_131_16 = 0
			local var_131_17 = 0.625

			if var_131_16 < arg_128_1.time_ and arg_128_1.time_ <= var_131_16 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_18 = arg_128_1:FormatText(StoryNameCfg[82].name)

				arg_128_1.leftNameTxt_.text = var_131_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_19 = arg_128_1:GetWordFromCfg(109051032)
				local var_131_20 = arg_128_1:FormatText(var_131_19.content)

				arg_128_1.text_.text = var_131_20

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_21 = 25
				local var_131_22 = utf8.len(var_131_20)
				local var_131_23 = var_131_21 <= 0 and var_131_17 or var_131_17 * (var_131_22 / var_131_21)

				if var_131_23 > 0 and var_131_17 < var_131_23 then
					arg_128_1.talkMaxDuration = var_131_23

					if var_131_23 + var_131_16 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_16
					end
				end

				arg_128_1.text_.text = var_131_20
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051032", "story_v_out_109051.awb") ~= 0 then
					local var_131_24 = manager.audio:GetVoiceLength("story_v_out_109051", "109051032", "story_v_out_109051.awb") / 1000

					if var_131_24 + var_131_16 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_24 + var_131_16
					end

					if var_131_19.prefab_name ~= "" and arg_128_1.actors_[var_131_19.prefab_name] ~= nil then
						local var_131_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_19.prefab_name].transform, "story_v_out_109051", "109051032", "story_v_out_109051.awb")

						arg_128_1:RecordAudio("109051032", var_131_25)
						arg_128_1:RecordAudio("109051032", var_131_25)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_109051", "109051032", "story_v_out_109051.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_109051", "109051032", "story_v_out_109051.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_26 = math.max(var_131_17, arg_128_1.talkMaxDuration)

			if var_131_16 <= arg_128_1.time_ and arg_128_1.time_ < var_131_16 + var_131_26 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_16) / var_131_26

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_16 + var_131_26 and arg_128_1.time_ < var_131_16 + var_131_26 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play109051033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 109051033
		arg_132_1.duration_ = 8.73

		local var_132_0 = {
			ja = 8.733,
			ko = 8.2,
			zh = 8,
			en = 5.633
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
				arg_132_0:Play109051034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.725

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[82].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(109051033)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 29
				local var_135_6 = utf8.len(var_135_4)
				local var_135_7 = var_135_5 <= 0 and var_135_1 or var_135_1 * (var_135_6 / var_135_5)

				if var_135_7 > 0 and var_135_1 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051033", "story_v_out_109051.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_109051", "109051033", "story_v_out_109051.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_109051", "109051033", "story_v_out_109051.awb")

						arg_132_1:RecordAudio("109051033", var_135_9)
						arg_132_1:RecordAudio("109051033", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_109051", "109051033", "story_v_out_109051.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_109051", "109051033", "story_v_out_109051.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_10 and arg_132_1.time_ < var_135_0 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play109051034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 109051034
		arg_136_1.duration_ = 23.1

		local var_136_0 = {
			ja = 23.1,
			ko = 6.1,
			zh = 10.466,
			en = 14.3
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
				arg_136_0:Play109051035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["3004_tpose"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos3004_tpose = var_139_0.localPosition

				local var_139_2 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(false)
				end
			end

			local var_139_3 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_3 then
				local var_139_4 = (arg_136_1.time_ - var_139_1) / var_139_3
				local var_139_5 = Vector3.New(0, 100, 0)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos3004_tpose, var_139_5, var_139_4)

				local var_139_6 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_6.x, var_139_6.y, var_139_6.z)

				local var_139_7 = var_139_0.localEulerAngles

				var_139_7.z = 0
				var_139_7.x = 0
				var_139_0.localEulerAngles = var_139_7
			end

			if arg_136_1.time_ >= var_139_1 + var_139_3 and arg_136_1.time_ < var_139_1 + var_139_3 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, 100, 0)

				local var_139_8 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_8.x, var_139_8.y, var_139_8.z)

				local var_139_9 = var_139_0.localEulerAngles

				var_139_9.z = 0
				var_139_9.x = 0
				var_139_0.localEulerAngles = var_139_9

				local var_139_10 = GameObjectTools.GetOrAddComponent(var_139_0.gameObject, typeof(DynamicBoneHelper))

				if var_139_10 then
					var_139_10:EnableDynamicBone(true)
				end
			end

			local var_139_11 = arg_136_1.actors_["3007_tpose"].transform
			local var_139_12 = 0

			if var_139_12 < arg_136_1.time_ and arg_136_1.time_ <= var_139_12 + arg_139_0 then
				arg_136_1.var_.moveOldPos3007_tpose = var_139_11.localPosition

				local var_139_13 = GameObjectTools.GetOrAddComponent(var_139_11.gameObject, typeof(DynamicBoneHelper))

				if var_139_13 then
					var_139_13:EnableDynamicBone(false)
				end
			end

			local var_139_14 = 0.001

			if var_139_12 <= arg_136_1.time_ and arg_136_1.time_ < var_139_12 + var_139_14 then
				local var_139_15 = (arg_136_1.time_ - var_139_12) / var_139_14
				local var_139_16 = Vector3.New(0, -2.25, -1.9)

				var_139_11.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos3007_tpose, var_139_16, var_139_15)

				local var_139_17 = manager.ui.mainCamera.transform.position - var_139_11.position

				var_139_11.forward = Vector3.New(var_139_17.x, var_139_17.y, var_139_17.z)

				local var_139_18 = var_139_11.localEulerAngles

				var_139_18.z = 0
				var_139_18.x = 0
				var_139_11.localEulerAngles = var_139_18
			end

			if arg_136_1.time_ >= var_139_12 + var_139_14 and arg_136_1.time_ < var_139_12 + var_139_14 + arg_139_0 then
				var_139_11.localPosition = Vector3.New(0, -2.25, -1.9)

				local var_139_19 = manager.ui.mainCamera.transform.position - var_139_11.position

				var_139_11.forward = Vector3.New(var_139_19.x, var_139_19.y, var_139_19.z)

				local var_139_20 = var_139_11.localEulerAngles

				var_139_20.z = 0
				var_139_20.x = 0
				var_139_11.localEulerAngles = var_139_20

				local var_139_21 = GameObjectTools.GetOrAddComponent(var_139_11.gameObject, typeof(DynamicBoneHelper))

				if var_139_21 then
					var_139_21:EnableDynamicBone(true)
				end
			end

			local var_139_22 = arg_136_1.actors_["3007_tpose"]
			local var_139_23 = 0

			if var_139_23 < arg_136_1.time_ and arg_136_1.time_ <= var_139_23 + arg_139_0 and not isNil(var_139_22) and arg_136_1.var_.characterEffect3007_tpose == nil then
				arg_136_1.var_.characterEffect3007_tpose = var_139_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_24 = 0.2

			if var_139_23 <= arg_136_1.time_ and arg_136_1.time_ < var_139_23 + var_139_24 and not isNil(var_139_22) then
				local var_139_25 = (arg_136_1.time_ - var_139_23) / var_139_24

				if arg_136_1.var_.characterEffect3007_tpose and not isNil(var_139_22) then
					arg_136_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_23 + var_139_24 and arg_136_1.time_ < var_139_23 + var_139_24 + arg_139_0 and not isNil(var_139_22) and arg_136_1.var_.characterEffect3007_tpose then
				arg_136_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_139_26 = 0

			if var_139_26 < arg_136_1.time_ and arg_136_1.time_ <= var_139_26 + arg_139_0 then
				arg_136_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_139_27 = 0
			local var_139_28 = 0.625

			if var_139_27 < arg_136_1.time_ and arg_136_1.time_ <= var_139_27 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_29 = arg_136_1:FormatText(StoryNameCfg[158].name)

				arg_136_1.leftNameTxt_.text = var_139_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_30 = arg_136_1:GetWordFromCfg(109051034)
				local var_139_31 = arg_136_1:FormatText(var_139_30.content)

				arg_136_1.text_.text = var_139_31

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_32 = 25
				local var_139_33 = utf8.len(var_139_31)
				local var_139_34 = var_139_32 <= 0 and var_139_28 or var_139_28 * (var_139_33 / var_139_32)

				if var_139_34 > 0 and var_139_28 < var_139_34 then
					arg_136_1.talkMaxDuration = var_139_34

					if var_139_34 + var_139_27 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_34 + var_139_27
					end
				end

				arg_136_1.text_.text = var_139_31
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051034", "story_v_out_109051.awb") ~= 0 then
					local var_139_35 = manager.audio:GetVoiceLength("story_v_out_109051", "109051034", "story_v_out_109051.awb") / 1000

					if var_139_35 + var_139_27 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_35 + var_139_27
					end

					if var_139_30.prefab_name ~= "" and arg_136_1.actors_[var_139_30.prefab_name] ~= nil then
						local var_139_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_30.prefab_name].transform, "story_v_out_109051", "109051034", "story_v_out_109051.awb")

						arg_136_1:RecordAudio("109051034", var_139_36)
						arg_136_1:RecordAudio("109051034", var_139_36)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_109051", "109051034", "story_v_out_109051.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_109051", "109051034", "story_v_out_109051.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_37 = math.max(var_139_28, arg_136_1.talkMaxDuration)

			if var_139_27 <= arg_136_1.time_ and arg_136_1.time_ < var_139_27 + var_139_37 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_27) / var_139_37

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_27 + var_139_37 and arg_136_1.time_ < var_139_27 + var_139_37 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play109051035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 109051035
		arg_140_1.duration_ = 4.7

		local var_140_0 = {
			ja = 4.5,
			ko = 3.333,
			zh = 3.966,
			en = 4.7
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
				arg_140_0:Play109051036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["3007_tpose"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect3007_tpose == nil then
				arg_140_1.var_.characterEffect3007_tpose = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect3007_tpose and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_140_1.var_.characterEffect3007_tpose.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect3007_tpose then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_140_1.var_.characterEffect3007_tpose.fillRatio = var_143_5
			end

			local var_143_6 = 0
			local var_143_7 = 0.3

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_8 = arg_140_1:FormatText(StoryNameCfg[99].name)

				arg_140_1.leftNameTxt_.text = var_143_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_9 = arg_140_1:GetWordFromCfg(109051035)
				local var_143_10 = arg_140_1:FormatText(var_143_9.content)

				arg_140_1.text_.text = var_143_10

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 12
				local var_143_12 = utf8.len(var_143_10)
				local var_143_13 = var_143_11 <= 0 and var_143_7 or var_143_7 * (var_143_12 / var_143_11)

				if var_143_13 > 0 and var_143_7 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_10
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051035", "story_v_out_109051.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_109051", "109051035", "story_v_out_109051.awb") / 1000

					if var_143_14 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_6
					end

					if var_143_9.prefab_name ~= "" and arg_140_1.actors_[var_143_9.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_9.prefab_name].transform, "story_v_out_109051", "109051035", "story_v_out_109051.awb")

						arg_140_1:RecordAudio("109051035", var_143_15)
						arg_140_1:RecordAudio("109051035", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_109051", "109051035", "story_v_out_109051.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_109051", "109051035", "story_v_out_109051.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_16 and arg_140_1.time_ < var_143_6 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play109051036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 109051036
		arg_144_1.duration_ = 8.63

		local var_144_0 = {
			ja = 7.8,
			ko = 7,
			zh = 7.6,
			en = 8.633
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
				arg_144_0:Play109051037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["3007_tpose"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos3007_tpose = var_147_0.localPosition

				local var_147_2 = GameObjectTools.GetOrAddComponent(var_147_0.gameObject, typeof(DynamicBoneHelper))

				if var_147_2 then
					var_147_2:EnableDynamicBone(false)
				end
			end

			local var_147_3 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_3 then
				local var_147_4 = (arg_144_1.time_ - var_147_1) / var_147_3
				local var_147_5 = Vector3.New(0, 100, 0)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos3007_tpose, var_147_5, var_147_4)

				local var_147_6 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_6.x, var_147_6.y, var_147_6.z)

				local var_147_7 = var_147_0.localEulerAngles

				var_147_7.z = 0
				var_147_7.x = 0
				var_147_0.localEulerAngles = var_147_7
			end

			if arg_144_1.time_ >= var_147_1 + var_147_3 and arg_144_1.time_ < var_147_1 + var_147_3 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, 100, 0)

				local var_147_8 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_8.x, var_147_8.y, var_147_8.z)

				local var_147_9 = var_147_0.localEulerAngles

				var_147_9.z = 0
				var_147_9.x = 0
				var_147_0.localEulerAngles = var_147_9

				local var_147_10 = GameObjectTools.GetOrAddComponent(var_147_0.gameObject, typeof(DynamicBoneHelper))

				if var_147_10 then
					var_147_10:EnableDynamicBone(true)
				end
			end

			local var_147_11 = arg_144_1.actors_["3004_tpose"].transform
			local var_147_12 = 0

			if var_147_12 < arg_144_1.time_ and arg_144_1.time_ <= var_147_12 + arg_147_0 then
				arg_144_1.var_.moveOldPos3004_tpose = var_147_11.localPosition

				local var_147_13 = GameObjectTools.GetOrAddComponent(var_147_11.gameObject, typeof(DynamicBoneHelper))

				if var_147_13 then
					var_147_13:EnableDynamicBone(false)
				end
			end

			local var_147_14 = 0.001

			if var_147_12 <= arg_144_1.time_ and arg_144_1.time_ < var_147_12 + var_147_14 then
				local var_147_15 = (arg_144_1.time_ - var_147_12) / var_147_14
				local var_147_16 = Vector3.New(0, -2.22, -3.1)

				var_147_11.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos3004_tpose, var_147_16, var_147_15)

				local var_147_17 = manager.ui.mainCamera.transform.position - var_147_11.position

				var_147_11.forward = Vector3.New(var_147_17.x, var_147_17.y, var_147_17.z)

				local var_147_18 = var_147_11.localEulerAngles

				var_147_18.z = 0
				var_147_18.x = 0
				var_147_11.localEulerAngles = var_147_18
			end

			if arg_144_1.time_ >= var_147_12 + var_147_14 and arg_144_1.time_ < var_147_12 + var_147_14 + arg_147_0 then
				var_147_11.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_147_19 = manager.ui.mainCamera.transform.position - var_147_11.position

				var_147_11.forward = Vector3.New(var_147_19.x, var_147_19.y, var_147_19.z)

				local var_147_20 = var_147_11.localEulerAngles

				var_147_20.z = 0
				var_147_20.x = 0
				var_147_11.localEulerAngles = var_147_20

				local var_147_21 = GameObjectTools.GetOrAddComponent(var_147_11.gameObject, typeof(DynamicBoneHelper))

				if var_147_21 then
					var_147_21:EnableDynamicBone(true)
				end
			end

			local var_147_22 = arg_144_1.actors_["3004_tpose"]
			local var_147_23 = 0

			if var_147_23 < arg_144_1.time_ and arg_144_1.time_ <= var_147_23 + arg_147_0 and not isNil(var_147_22) and arg_144_1.var_.characterEffect3004_tpose == nil then
				arg_144_1.var_.characterEffect3004_tpose = var_147_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_24 = 0.2

			if var_147_23 <= arg_144_1.time_ and arg_144_1.time_ < var_147_23 + var_147_24 and not isNil(var_147_22) then
				local var_147_25 = (arg_144_1.time_ - var_147_23) / var_147_24

				if arg_144_1.var_.characterEffect3004_tpose and not isNil(var_147_22) then
					arg_144_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_23 + var_147_24 and arg_144_1.time_ < var_147_23 + var_147_24 + arg_147_0 and not isNil(var_147_22) and arg_144_1.var_.characterEffect3004_tpose then
				arg_144_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_147_26 = 0

			if var_147_26 < arg_144_1.time_ and arg_144_1.time_ <= var_147_26 + arg_147_0 then
				arg_144_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_147_27 = 0
			local var_147_28 = 0.65

			if var_147_27 < arg_144_1.time_ and arg_144_1.time_ <= var_147_27 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_29 = arg_144_1:FormatText(StoryNameCfg[82].name)

				arg_144_1.leftNameTxt_.text = var_147_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_30 = arg_144_1:GetWordFromCfg(109051036)
				local var_147_31 = arg_144_1:FormatText(var_147_30.content)

				arg_144_1.text_.text = var_147_31

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_32 = 26
				local var_147_33 = utf8.len(var_147_31)
				local var_147_34 = var_147_32 <= 0 and var_147_28 or var_147_28 * (var_147_33 / var_147_32)

				if var_147_34 > 0 and var_147_28 < var_147_34 then
					arg_144_1.talkMaxDuration = var_147_34

					if var_147_34 + var_147_27 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_34 + var_147_27
					end
				end

				arg_144_1.text_.text = var_147_31
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051036", "story_v_out_109051.awb") ~= 0 then
					local var_147_35 = manager.audio:GetVoiceLength("story_v_out_109051", "109051036", "story_v_out_109051.awb") / 1000

					if var_147_35 + var_147_27 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_35 + var_147_27
					end

					if var_147_30.prefab_name ~= "" and arg_144_1.actors_[var_147_30.prefab_name] ~= nil then
						local var_147_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_30.prefab_name].transform, "story_v_out_109051", "109051036", "story_v_out_109051.awb")

						arg_144_1:RecordAudio("109051036", var_147_36)
						arg_144_1:RecordAudio("109051036", var_147_36)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_109051", "109051036", "story_v_out_109051.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_109051", "109051036", "story_v_out_109051.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_37 = math.max(var_147_28, arg_144_1.talkMaxDuration)

			if var_147_27 <= arg_144_1.time_ and arg_144_1.time_ < var_147_27 + var_147_37 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_27) / var_147_37

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_27 + var_147_37 and arg_144_1.time_ < var_147_27 + var_147_37 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play109051037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 109051037
		arg_148_1.duration_ = 9.9

		local var_148_0 = {
			ja = 5.866,
			ko = 4.166,
			zh = 6.9,
			en = 9.9
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
				arg_148_0:Play109051038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["3004_tpose"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos3004_tpose = var_151_0.localPosition

				local var_151_2 = GameObjectTools.GetOrAddComponent(var_151_0.gameObject, typeof(DynamicBoneHelper))

				if var_151_2 then
					var_151_2:EnableDynamicBone(false)
				end
			end

			local var_151_3 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_3 then
				local var_151_4 = (arg_148_1.time_ - var_151_1) / var_151_3
				local var_151_5 = Vector3.New(0, 100, 0)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos3004_tpose, var_151_5, var_151_4)

				local var_151_6 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_6.x, var_151_6.y, var_151_6.z)

				local var_151_7 = var_151_0.localEulerAngles

				var_151_7.z = 0
				var_151_7.x = 0
				var_151_0.localEulerAngles = var_151_7
			end

			if arg_148_1.time_ >= var_151_1 + var_151_3 and arg_148_1.time_ < var_151_1 + var_151_3 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, 100, 0)

				local var_151_8 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_8.x, var_151_8.y, var_151_8.z)

				local var_151_9 = var_151_0.localEulerAngles

				var_151_9.z = 0
				var_151_9.x = 0
				var_151_0.localEulerAngles = var_151_9

				local var_151_10 = GameObjectTools.GetOrAddComponent(var_151_0.gameObject, typeof(DynamicBoneHelper))

				if var_151_10 then
					var_151_10:EnableDynamicBone(true)
				end
			end

			local var_151_11 = arg_148_1.actors_["3007_tpose"].transform
			local var_151_12 = 0

			if var_151_12 < arg_148_1.time_ and arg_148_1.time_ <= var_151_12 + arg_151_0 then
				arg_148_1.var_.moveOldPos3007_tpose = var_151_11.localPosition

				local var_151_13 = GameObjectTools.GetOrAddComponent(var_151_11.gameObject, typeof(DynamicBoneHelper))

				if var_151_13 then
					var_151_13:EnableDynamicBone(false)
				end
			end

			local var_151_14 = 0.001

			if var_151_12 <= arg_148_1.time_ and arg_148_1.time_ < var_151_12 + var_151_14 then
				local var_151_15 = (arg_148_1.time_ - var_151_12) / var_151_14
				local var_151_16 = Vector3.New(0, -2.25, -1.9)

				var_151_11.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos3007_tpose, var_151_16, var_151_15)

				local var_151_17 = manager.ui.mainCamera.transform.position - var_151_11.position

				var_151_11.forward = Vector3.New(var_151_17.x, var_151_17.y, var_151_17.z)

				local var_151_18 = var_151_11.localEulerAngles

				var_151_18.z = 0
				var_151_18.x = 0
				var_151_11.localEulerAngles = var_151_18
			end

			if arg_148_1.time_ >= var_151_12 + var_151_14 and arg_148_1.time_ < var_151_12 + var_151_14 + arg_151_0 then
				var_151_11.localPosition = Vector3.New(0, -2.25, -1.9)

				local var_151_19 = manager.ui.mainCamera.transform.position - var_151_11.position

				var_151_11.forward = Vector3.New(var_151_19.x, var_151_19.y, var_151_19.z)

				local var_151_20 = var_151_11.localEulerAngles

				var_151_20.z = 0
				var_151_20.x = 0
				var_151_11.localEulerAngles = var_151_20

				local var_151_21 = GameObjectTools.GetOrAddComponent(var_151_11.gameObject, typeof(DynamicBoneHelper))

				if var_151_21 then
					var_151_21:EnableDynamicBone(true)
				end
			end

			local var_151_22 = arg_148_1.actors_["3007_tpose"]
			local var_151_23 = 0

			if var_151_23 < arg_148_1.time_ and arg_148_1.time_ <= var_151_23 + arg_151_0 and not isNil(var_151_22) and arg_148_1.var_.characterEffect3007_tpose == nil then
				arg_148_1.var_.characterEffect3007_tpose = var_151_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_24 = 0.2

			if var_151_23 <= arg_148_1.time_ and arg_148_1.time_ < var_151_23 + var_151_24 and not isNil(var_151_22) then
				local var_151_25 = (arg_148_1.time_ - var_151_23) / var_151_24

				if arg_148_1.var_.characterEffect3007_tpose and not isNil(var_151_22) then
					arg_148_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_23 + var_151_24 and arg_148_1.time_ < var_151_23 + var_151_24 + arg_151_0 and not isNil(var_151_22) and arg_148_1.var_.characterEffect3007_tpose then
				arg_148_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_151_26 = 0

			if var_151_26 < arg_148_1.time_ and arg_148_1.time_ <= var_151_26 + arg_151_0 then
				arg_148_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_151_27 = 0
			local var_151_28 = 0.375

			if var_151_27 < arg_148_1.time_ and arg_148_1.time_ <= var_151_27 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_29 = arg_148_1:FormatText(StoryNameCfg[158].name)

				arg_148_1.leftNameTxt_.text = var_151_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_30 = arg_148_1:GetWordFromCfg(109051037)
				local var_151_31 = arg_148_1:FormatText(var_151_30.content)

				arg_148_1.text_.text = var_151_31

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_32 = 15
				local var_151_33 = utf8.len(var_151_31)
				local var_151_34 = var_151_32 <= 0 and var_151_28 or var_151_28 * (var_151_33 / var_151_32)

				if var_151_34 > 0 and var_151_28 < var_151_34 then
					arg_148_1.talkMaxDuration = var_151_34

					if var_151_34 + var_151_27 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_34 + var_151_27
					end
				end

				arg_148_1.text_.text = var_151_31
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051037", "story_v_out_109051.awb") ~= 0 then
					local var_151_35 = manager.audio:GetVoiceLength("story_v_out_109051", "109051037", "story_v_out_109051.awb") / 1000

					if var_151_35 + var_151_27 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_35 + var_151_27
					end

					if var_151_30.prefab_name ~= "" and arg_148_1.actors_[var_151_30.prefab_name] ~= nil then
						local var_151_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_30.prefab_name].transform, "story_v_out_109051", "109051037", "story_v_out_109051.awb")

						arg_148_1:RecordAudio("109051037", var_151_36)
						arg_148_1:RecordAudio("109051037", var_151_36)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_109051", "109051037", "story_v_out_109051.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_109051", "109051037", "story_v_out_109051.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_37 = math.max(var_151_28, arg_148_1.talkMaxDuration)

			if var_151_27 <= arg_148_1.time_ and arg_148_1.time_ < var_151_27 + var_151_37 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_27) / var_151_37

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_27 + var_151_37 and arg_148_1.time_ < var_151_27 + var_151_37 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play109051038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 109051038
		arg_152_1.duration_ = 7.33

		local var_152_0 = {
			ja = 7.1,
			ko = 3.666,
			zh = 5.4,
			en = 7.333
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
				arg_152_0:Play109051039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["3007_tpose"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos3007_tpose = var_155_0.localPosition

				local var_155_2 = GameObjectTools.GetOrAddComponent(var_155_0.gameObject, typeof(DynamicBoneHelper))

				if var_155_2 then
					var_155_2:EnableDynamicBone(false)
				end
			end

			local var_155_3 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_3 then
				local var_155_4 = (arg_152_1.time_ - var_155_1) / var_155_3
				local var_155_5 = Vector3.New(0, 100, 0)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos3007_tpose, var_155_5, var_155_4)

				local var_155_6 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_6.x, var_155_6.y, var_155_6.z)

				local var_155_7 = var_155_0.localEulerAngles

				var_155_7.z = 0
				var_155_7.x = 0
				var_155_0.localEulerAngles = var_155_7
			end

			if arg_152_1.time_ >= var_155_1 + var_155_3 and arg_152_1.time_ < var_155_1 + var_155_3 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, 100, 0)

				local var_155_8 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_8.x, var_155_8.y, var_155_8.z)

				local var_155_9 = var_155_0.localEulerAngles

				var_155_9.z = 0
				var_155_9.x = 0
				var_155_0.localEulerAngles = var_155_9

				local var_155_10 = GameObjectTools.GetOrAddComponent(var_155_0.gameObject, typeof(DynamicBoneHelper))

				if var_155_10 then
					var_155_10:EnableDynamicBone(true)
				end
			end

			local var_155_11 = arg_152_1.actors_["3004_tpose"].transform
			local var_155_12 = 0

			if var_155_12 < arg_152_1.time_ and arg_152_1.time_ <= var_155_12 + arg_155_0 then
				arg_152_1.var_.moveOldPos3004_tpose = var_155_11.localPosition

				local var_155_13 = GameObjectTools.GetOrAddComponent(var_155_11.gameObject, typeof(DynamicBoneHelper))

				if var_155_13 then
					var_155_13:EnableDynamicBone(false)
				end
			end

			local var_155_14 = 0.001

			if var_155_12 <= arg_152_1.time_ and arg_152_1.time_ < var_155_12 + var_155_14 then
				local var_155_15 = (arg_152_1.time_ - var_155_12) / var_155_14
				local var_155_16 = Vector3.New(0, -2.22, -3.1)

				var_155_11.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos3004_tpose, var_155_16, var_155_15)

				local var_155_17 = manager.ui.mainCamera.transform.position - var_155_11.position

				var_155_11.forward = Vector3.New(var_155_17.x, var_155_17.y, var_155_17.z)

				local var_155_18 = var_155_11.localEulerAngles

				var_155_18.z = 0
				var_155_18.x = 0
				var_155_11.localEulerAngles = var_155_18
			end

			if arg_152_1.time_ >= var_155_12 + var_155_14 and arg_152_1.time_ < var_155_12 + var_155_14 + arg_155_0 then
				var_155_11.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_155_19 = manager.ui.mainCamera.transform.position - var_155_11.position

				var_155_11.forward = Vector3.New(var_155_19.x, var_155_19.y, var_155_19.z)

				local var_155_20 = var_155_11.localEulerAngles

				var_155_20.z = 0
				var_155_20.x = 0
				var_155_11.localEulerAngles = var_155_20

				local var_155_21 = GameObjectTools.GetOrAddComponent(var_155_11.gameObject, typeof(DynamicBoneHelper))

				if var_155_21 then
					var_155_21:EnableDynamicBone(true)
				end
			end

			local var_155_22 = 0

			if var_155_22 < arg_152_1.time_ and arg_152_1.time_ <= var_155_22 + arg_155_0 then
				arg_152_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_155_23 = arg_152_1.actors_["3004_tpose"]
			local var_155_24 = 0

			if var_155_24 < arg_152_1.time_ and arg_152_1.time_ <= var_155_24 + arg_155_0 and not isNil(var_155_23) and arg_152_1.var_.characterEffect3004_tpose == nil then
				arg_152_1.var_.characterEffect3004_tpose = var_155_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_25 = 0.2

			if var_155_24 <= arg_152_1.time_ and arg_152_1.time_ < var_155_24 + var_155_25 and not isNil(var_155_23) then
				local var_155_26 = (arg_152_1.time_ - var_155_24) / var_155_25

				if arg_152_1.var_.characterEffect3004_tpose and not isNil(var_155_23) then
					arg_152_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_24 + var_155_25 and arg_152_1.time_ < var_155_24 + var_155_25 + arg_155_0 and not isNil(var_155_23) and arg_152_1.var_.characterEffect3004_tpose then
				arg_152_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_155_27 = 0
			local var_155_28 = 0.475

			if var_155_27 < arg_152_1.time_ and arg_152_1.time_ <= var_155_27 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_29 = arg_152_1:FormatText(StoryNameCfg[82].name)

				arg_152_1.leftNameTxt_.text = var_155_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_30 = arg_152_1:GetWordFromCfg(109051038)
				local var_155_31 = arg_152_1:FormatText(var_155_30.content)

				arg_152_1.text_.text = var_155_31

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_32 = 19
				local var_155_33 = utf8.len(var_155_31)
				local var_155_34 = var_155_32 <= 0 and var_155_28 or var_155_28 * (var_155_33 / var_155_32)

				if var_155_34 > 0 and var_155_28 < var_155_34 then
					arg_152_1.talkMaxDuration = var_155_34

					if var_155_34 + var_155_27 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_34 + var_155_27
					end
				end

				arg_152_1.text_.text = var_155_31
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051038", "story_v_out_109051.awb") ~= 0 then
					local var_155_35 = manager.audio:GetVoiceLength("story_v_out_109051", "109051038", "story_v_out_109051.awb") / 1000

					if var_155_35 + var_155_27 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_35 + var_155_27
					end

					if var_155_30.prefab_name ~= "" and arg_152_1.actors_[var_155_30.prefab_name] ~= nil then
						local var_155_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_30.prefab_name].transform, "story_v_out_109051", "109051038", "story_v_out_109051.awb")

						arg_152_1:RecordAudio("109051038", var_155_36)
						arg_152_1:RecordAudio("109051038", var_155_36)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_109051", "109051038", "story_v_out_109051.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_109051", "109051038", "story_v_out_109051.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_37 = math.max(var_155_28, arg_152_1.talkMaxDuration)

			if var_155_27 <= arg_152_1.time_ and arg_152_1.time_ < var_155_27 + var_155_37 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_27) / var_155_37

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_27 + var_155_37 and arg_152_1.time_ < var_155_27 + var_155_37 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3004_tpose",
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
	Play109051039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 109051039
		arg_156_1.duration_ = 9.43

		local var_156_0 = {
			ja = 9.433,
			ko = 9.1,
			zh = 9.266,
			en = 8.233
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
				arg_156_0:Play109051040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 0.8

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_2 = arg_156_1:FormatText(StoryNameCfg[82].name)

				arg_156_1.leftNameTxt_.text = var_159_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_3 = arg_156_1:GetWordFromCfg(109051039)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 32
				local var_159_6 = utf8.len(var_159_4)
				local var_159_7 = var_159_5 <= 0 and var_159_1 or var_159_1 * (var_159_6 / var_159_5)

				if var_159_7 > 0 and var_159_1 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_4
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051039", "story_v_out_109051.awb") ~= 0 then
					local var_159_8 = manager.audio:GetVoiceLength("story_v_out_109051", "109051039", "story_v_out_109051.awb") / 1000

					if var_159_8 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_0
					end

					if var_159_3.prefab_name ~= "" and arg_156_1.actors_[var_159_3.prefab_name] ~= nil then
						local var_159_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_3.prefab_name].transform, "story_v_out_109051", "109051039", "story_v_out_109051.awb")

						arg_156_1:RecordAudio("109051039", var_159_9)
						arg_156_1:RecordAudio("109051039", var_159_9)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_109051", "109051039", "story_v_out_109051.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_109051", "109051039", "story_v_out_109051.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_10 and arg_156_1.time_ < var_159_0 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play109051040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 109051040
		arg_160_1.duration_ = 8.67

		local var_160_0 = {
			ja = 7.2,
			ko = 7.6,
			zh = 8.666,
			en = 7.3
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
			arg_160_1.auto_ = false
		end

		function arg_160_1.playNext_(arg_162_0)
			arg_160_1.onStoryFinished_()
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 0.625

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_2 = arg_160_1:FormatText(StoryNameCfg[82].name)

				arg_160_1.leftNameTxt_.text = var_163_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:GetWordFromCfg(109051040)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 25
				local var_163_6 = utf8.len(var_163_4)
				local var_163_7 = var_163_5 <= 0 and var_163_1 or var_163_1 * (var_163_6 / var_163_5)

				if var_163_7 > 0 and var_163_1 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051040", "story_v_out_109051.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_109051", "109051040", "story_v_out_109051.awb") / 1000

					if var_163_8 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_0
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_109051", "109051040", "story_v_out_109051.awb")

						arg_160_1:RecordAudio("109051040", var_163_9)
						arg_160_1:RecordAudio("109051040", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_109051", "109051040", "story_v_out_109051.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_109051", "109051040", "story_v_out_109051.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_10 and arg_160_1.time_ < var_163_0 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C04a"
	},
	voices = {
		"story_v_out_109051.awb"
	}
}
