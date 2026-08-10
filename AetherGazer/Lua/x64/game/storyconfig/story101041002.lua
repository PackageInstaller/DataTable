return {
	Play104102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104102001
		arg_1_1.duration_ = 10.87

		local var_1_0 = {
			ja = 10.866,
			ko = 9.433,
			zh = 10.433,
			en = 8.766
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
				arg_1_0:Play104102002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = "B13"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = arg_1_1.bgs_.B13
			local var_4_9 = 0

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				local var_4_10 = var_4_8:GetComponent("SpriteRenderer")

				if var_4_10 then
					arg_1_1.var_.alphaOldValueB13 = var_4_10.color.a
					arg_1_1.var_.alphaMatValueB13 = var_4_10
				end

				arg_1_1.var_.alphaOldValueB13 = 0
			end

			local var_4_11 = 1.5

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_11 then
				local var_4_12 = (arg_1_1.time_ - var_4_9) / var_4_11
				local var_4_13 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB13, 1, var_4_12)

				if arg_1_1.var_.alphaMatValueB13 then
					local var_4_14 = arg_1_1.var_.alphaMatValueB13.color

					var_4_14.a = var_4_13
					arg_1_1.var_.alphaMatValueB13.color = var_4_14
				end
			end

			if arg_1_1.time_ >= var_4_9 + var_4_11 and arg_1_1.time_ < var_4_9 + var_4_11 + arg_4_0 and arg_1_1.var_.alphaMatValueB13 then
				local var_4_15 = arg_1_1.var_.alphaMatValueB13
				local var_4_16 = var_4_15.color

				var_4_16.a = 1
				var_4_15.color = var_4_16
			end

			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = manager.ui.mainCamera.transform.localPosition
				local var_4_19 = Vector3.New(0, 0, 10) + Vector3.New(var_4_18.x, var_4_18.y, 0)
				local var_4_20 = arg_1_1.bgs_.B13

				var_4_20.transform.localPosition = var_4_19
				var_4_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_21 = var_4_20:GetComponent("SpriteRenderer")

				if var_4_21 and var_4_21.sprite then
					local var_4_22 = (var_4_20.transform.localPosition - var_4_18).z
					local var_4_23 = manager.ui.mainCameraCom_
					local var_4_24 = 2 * var_4_22 * Mathf.Tan(var_4_23.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_25 = var_4_24 * var_4_23.aspect
					local var_4_26 = var_4_21.sprite.bounds.size.x
					local var_4_27 = var_4_21.sprite.bounds.size.y
					local var_4_28 = var_4_25 / var_4_26
					local var_4_29 = var_4_24 / var_4_27
					local var_4_30 = var_4_29 < var_4_28 and var_4_28 or var_4_29

					var_4_20.transform.localScale = Vector3.New(var_4_30, var_4_30, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
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
			local var_4_34 = 0.825

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

				local var_4_36 = arg_1_1:FormatText(StoryNameCfg[10].name)

				arg_1_1.leftNameTxt_.text = var_4_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_37 = arg_1_1:GetWordFromCfg(104102001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102001", "story_v_out_104102.awb") ~= 0 then
					local var_4_42 = manager.audio:GetVoiceLength("story_v_out_104102", "104102001", "story_v_out_104102.awb") / 1000

					if var_4_42 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_33
					end

					if var_4_37.prefab_name ~= "" and arg_1_1.actors_[var_4_37.prefab_name] ~= nil then
						local var_4_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_37.prefab_name].transform, "story_v_out_104102", "104102001", "story_v_out_104102.awb")

						arg_1_1:RecordAudio("104102001", var_4_43)
						arg_1_1:RecordAudio("104102001", var_4_43)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_104102", "104102001", "story_v_out_104102.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_104102", "104102001", "story_v_out_104102.awb")
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
	Play104102002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104102002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play104102003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.55

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[7].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(104102002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 22
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_8 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_8 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_8

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_8 and arg_8_1.time_ < var_11_0 + var_11_8 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play104102003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104102003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play104102004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.725

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(104102003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 29
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play104102004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104102004
		arg_16_1.duration_ = 5.23

		local var_16_0 = {
			ja = 3.233,
			ko = 3.3,
			zh = 5.233,
			en = 3.566
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
				arg_16_0:Play104102005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1032ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1032ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1032ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["1032ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos1032ui_story = var_19_5.localPosition
			end

			local var_19_7 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7
				local var_19_9 = Vector3.New(0, -1.05, -6.2)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1032ui_story, var_19_9, var_19_8)

				local var_19_10 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_10.x, var_19_10.y, var_19_10.z)

				local var_19_11 = var_19_5.localEulerAngles

				var_19_11.z = 0
				var_19_11.x = 0
				var_19_5.localEulerAngles = var_19_11
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_19_12 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_12.x, var_19_12.y, var_19_12.z)

				local var_19_13 = var_19_5.localEulerAngles

				var_19_13.z = 0
				var_19_13.x = 0
				var_19_5.localEulerAngles = var_19_13
			end

			local var_19_14 = 0

			if var_19_14 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action4_1")
			end

			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_19_16 = arg_16_1.actors_["1032ui_story"]
			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 and not isNil(var_19_16) and arg_16_1.var_.characterEffect1032ui_story == nil then
				arg_16_1.var_.characterEffect1032ui_story = var_19_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_18 = 0.2

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_18 and not isNil(var_19_16) then
				local var_19_19 = (arg_16_1.time_ - var_19_17) / var_19_18

				if arg_16_1.var_.characterEffect1032ui_story and not isNil(var_19_16) then
					arg_16_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_17 + var_19_18 and arg_16_1.time_ < var_19_17 + var_19_18 + arg_19_0 and not isNil(var_19_16) and arg_16_1.var_.characterEffect1032ui_story then
				arg_16_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			local var_19_20 = 0
			local var_19_21 = 0.5

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_22 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_22:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
					arg_16_1.dialogCg_.alpha = arg_20_0
				end))
				var_19_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_23 = arg_16_1:FormatText(StoryNameCfg[61].name)

				arg_16_1.leftNameTxt_.text = var_19_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_24 = arg_16_1:GetWordFromCfg(104102004)
				local var_19_25 = arg_16_1:FormatText(var_19_24.content)

				arg_16_1.text_.text = var_19_25

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_26 = 20
				local var_19_27 = utf8.len(var_19_25)
				local var_19_28 = var_19_26 <= 0 and var_19_21 or var_19_21 * (var_19_27 / var_19_26)

				if var_19_28 > 0 and var_19_21 < var_19_28 then
					arg_16_1.talkMaxDuration = var_19_28
					var_19_20 = var_19_20 + 0.3

					if var_19_28 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_20
					end
				end

				arg_16_1.text_.text = var_19_25
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102004", "story_v_out_104102.awb") ~= 0 then
					local var_19_29 = manager.audio:GetVoiceLength("story_v_out_104102", "104102004", "story_v_out_104102.awb") / 1000

					if var_19_29 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_29 + var_19_20
					end

					if var_19_24.prefab_name ~= "" and arg_16_1.actors_[var_19_24.prefab_name] ~= nil then
						local var_19_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_24.prefab_name].transform, "story_v_out_104102", "104102004", "story_v_out_104102.awb")

						arg_16_1:RecordAudio("104102004", var_19_30)
						arg_16_1:RecordAudio("104102004", var_19_30)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104102", "104102004", "story_v_out_104102.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104102", "104102004", "story_v_out_104102.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_31 = var_19_20 + 0.3
			local var_19_32 = math.max(var_19_21, arg_16_1.talkMaxDuration)

			if var_19_31 <= arg_16_1.time_ and arg_16_1.time_ < var_19_31 + var_19_32 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_31) / var_19_32

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_31 + var_19_32 and arg_16_1.time_ < var_19_31 + var_19_32 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play104102005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 104102005
		arg_22_1.duration_ = 3.63

		local var_22_0 = {
			ja = 2.233,
			ko = 1.833,
			zh = 3.633,
			en = 3.133
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play104102006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1032ui_story"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1032ui_story == nil then
				arg_22_1.var_.characterEffect1032ui_story = var_25_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_2 = 0.2

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.characterEffect1032ui_story and not isNil(var_25_0) then
					local var_25_4 = Mathf.Lerp(0, 0.5, var_25_3)

					arg_22_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_22_1.var_.characterEffect1032ui_story.fillRatio = var_25_4
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1032ui_story then
				local var_25_5 = 0.5

				arg_22_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_22_1.var_.characterEffect1032ui_story.fillRatio = var_25_5
			end

			local var_25_6 = 0
			local var_25_7 = 0.325

			if var_25_6 < arg_22_1.time_ and arg_22_1.time_ <= var_25_6 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_8 = arg_22_1:FormatText(StoryNameCfg[10].name)

				arg_22_1.leftNameTxt_.text = var_25_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_9 = arg_22_1:GetWordFromCfg(104102005)
				local var_25_10 = arg_22_1:FormatText(var_25_9.content)

				arg_22_1.text_.text = var_25_10

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_11 = 13
				local var_25_12 = utf8.len(var_25_10)
				local var_25_13 = var_25_11 <= 0 and var_25_7 or var_25_7 * (var_25_12 / var_25_11)

				if var_25_13 > 0 and var_25_7 < var_25_13 then
					arg_22_1.talkMaxDuration = var_25_13

					if var_25_13 + var_25_6 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_13 + var_25_6
					end
				end

				arg_22_1.text_.text = var_25_10
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102005", "story_v_out_104102.awb") ~= 0 then
					local var_25_14 = manager.audio:GetVoiceLength("story_v_out_104102", "104102005", "story_v_out_104102.awb") / 1000

					if var_25_14 + var_25_6 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_14 + var_25_6
					end

					if var_25_9.prefab_name ~= "" and arg_22_1.actors_[var_25_9.prefab_name] ~= nil then
						local var_25_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_9.prefab_name].transform, "story_v_out_104102", "104102005", "story_v_out_104102.awb")

						arg_22_1:RecordAudio("104102005", var_25_15)
						arg_22_1:RecordAudio("104102005", var_25_15)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_104102", "104102005", "story_v_out_104102.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_104102", "104102005", "story_v_out_104102.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_16 = math.max(var_25_7, arg_22_1.talkMaxDuration)

			if var_25_6 <= arg_22_1.time_ and arg_22_1.time_ < var_25_6 + var_25_16 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_6) / var_25_16

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_6 + var_25_16 and arg_22_1.time_ < var_25_6 + var_25_16 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play104102006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 104102006
		arg_26_1.duration_ = 5.57

		local var_26_0 = {
			ja = 5.566,
			ko = 3.633,
			zh = 4.7,
			en = 2.633
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
				arg_26_0:Play104102007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1032ui_story"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1032ui_story == nil then
				arg_26_1.var_.characterEffect1032ui_story = var_29_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.2

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.characterEffect1032ui_story and not isNil(var_29_0) then
					arg_26_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1032ui_story then
				arg_26_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			local var_29_4 = 0

			if var_29_4 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032actionlink/1032action443")
			end

			local var_29_5 = 0

			if var_29_5 < arg_26_1.time_ and arg_26_1.time_ <= var_29_5 + arg_29_0 then
				arg_26_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_29_6 = 0
			local var_29_7 = 0.425

			if var_29_6 < arg_26_1.time_ and arg_26_1.time_ <= var_29_6 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_8 = arg_26_1:FormatText(StoryNameCfg[61].name)

				arg_26_1.leftNameTxt_.text = var_29_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_9 = arg_26_1:GetWordFromCfg(104102006)
				local var_29_10 = arg_26_1:FormatText(var_29_9.content)

				arg_26_1.text_.text = var_29_10

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_11 = 17
				local var_29_12 = utf8.len(var_29_10)
				local var_29_13 = var_29_11 <= 0 and var_29_7 or var_29_7 * (var_29_12 / var_29_11)

				if var_29_13 > 0 and var_29_7 < var_29_13 then
					arg_26_1.talkMaxDuration = var_29_13

					if var_29_13 + var_29_6 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_13 + var_29_6
					end
				end

				arg_26_1.text_.text = var_29_10
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102006", "story_v_out_104102.awb") ~= 0 then
					local var_29_14 = manager.audio:GetVoiceLength("story_v_out_104102", "104102006", "story_v_out_104102.awb") / 1000

					if var_29_14 + var_29_6 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_14 + var_29_6
					end

					if var_29_9.prefab_name ~= "" and arg_26_1.actors_[var_29_9.prefab_name] ~= nil then
						local var_29_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_9.prefab_name].transform, "story_v_out_104102", "104102006", "story_v_out_104102.awb")

						arg_26_1:RecordAudio("104102006", var_29_15)
						arg_26_1:RecordAudio("104102006", var_29_15)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_104102", "104102006", "story_v_out_104102.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_104102", "104102006", "story_v_out_104102.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_16 = math.max(var_29_7, arg_26_1.talkMaxDuration)

			if var_29_6 <= arg_26_1.time_ and arg_26_1.time_ < var_29_6 + var_29_16 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_6) / var_29_16

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_6 + var_29_16 and arg_26_1.time_ < var_29_6 + var_29_16 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play104102007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 104102007
		arg_30_1.duration_ = 5.97

		local var_30_0 = {
			ja = 3.833,
			ko = 3.5,
			zh = 5.966,
			en = 4.566
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
				arg_30_0:Play104102008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032actionlink/1032action437")
			end

			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_33_2 = 0
			local var_33_3 = 0.575

			if var_33_2 < arg_30_1.time_ and arg_30_1.time_ <= var_33_2 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_4 = arg_30_1:FormatText(StoryNameCfg[61].name)

				arg_30_1.leftNameTxt_.text = var_33_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_5 = arg_30_1:GetWordFromCfg(104102007)
				local var_33_6 = arg_30_1:FormatText(var_33_5.content)

				arg_30_1.text_.text = var_33_6

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_7 = 23
				local var_33_8 = utf8.len(var_33_6)
				local var_33_9 = var_33_7 <= 0 and var_33_3 or var_33_3 * (var_33_8 / var_33_7)

				if var_33_9 > 0 and var_33_3 < var_33_9 then
					arg_30_1.talkMaxDuration = var_33_9

					if var_33_9 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_9 + var_33_2
					end
				end

				arg_30_1.text_.text = var_33_6
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102007", "story_v_out_104102.awb") ~= 0 then
					local var_33_10 = manager.audio:GetVoiceLength("story_v_out_104102", "104102007", "story_v_out_104102.awb") / 1000

					if var_33_10 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_2
					end

					if var_33_5.prefab_name ~= "" and arg_30_1.actors_[var_33_5.prefab_name] ~= nil then
						local var_33_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_5.prefab_name].transform, "story_v_out_104102", "104102007", "story_v_out_104102.awb")

						arg_30_1:RecordAudio("104102007", var_33_11)
						arg_30_1:RecordAudio("104102007", var_33_11)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_104102", "104102007", "story_v_out_104102.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_104102", "104102007", "story_v_out_104102.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_12 = math.max(var_33_3, arg_30_1.talkMaxDuration)

			if var_33_2 <= arg_30_1.time_ and arg_30_1.time_ < var_33_2 + var_33_12 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_2) / var_33_12

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_2 + var_33_12 and arg_30_1.time_ < var_33_2 + var_33_12 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play104102008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 104102008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play104102009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1032ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1032ui_story == nil then
				arg_34_1.var_.characterEffect1032ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.2

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect1032ui_story and not isNil(var_37_0) then
					local var_37_4 = Mathf.Lerp(0, 0.5, var_37_3)

					arg_34_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1032ui_story.fillRatio = var_37_4
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1032ui_story then
				local var_37_5 = 0.5

				arg_34_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1032ui_story.fillRatio = var_37_5
			end

			local var_37_6 = 0
			local var_37_7 = 0.05

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_8 = arg_34_1:FormatText(StoryNameCfg[7].name)

				arg_34_1.leftNameTxt_.text = var_37_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_9 = arg_34_1:GetWordFromCfg(104102008)
				local var_37_10 = arg_34_1:FormatText(var_37_9.content)

				arg_34_1.text_.text = var_37_10

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_11 = 2
				local var_37_12 = utf8.len(var_37_10)
				local var_37_13 = var_37_11 <= 0 and var_37_7 or var_37_7 * (var_37_12 / var_37_11)

				if var_37_13 > 0 and var_37_7 < var_37_13 then
					arg_34_1.talkMaxDuration = var_37_13

					if var_37_13 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_13 + var_37_6
					end
				end

				arg_34_1.text_.text = var_37_10
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_14 = math.max(var_37_7, arg_34_1.talkMaxDuration)

			if var_37_6 <= arg_34_1.time_ and arg_34_1.time_ < var_37_6 + var_37_14 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_6) / var_37_14

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_6 + var_37_14 and arg_34_1.time_ < var_37_6 + var_37_14 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play104102009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 104102009
		arg_38_1.duration_ = 8

		local var_38_0 = {
			ja = 8,
			ko = 5.233,
			zh = 6.066,
			en = 6.366
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play104102010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = "1037ui_story"

			if arg_38_1.actors_[var_41_0] == nil then
				local var_41_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_41_1) then
					local var_41_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_38_1.stage_.transform)

					var_41_2.name = var_41_0
					var_41_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_38_1.actors_[var_41_0] = var_41_2

					local var_41_3 = var_41_2:GetComponentInChildren(typeof(CharacterEffect))

					var_41_3.enabled = true

					local var_41_4 = GameObjectTools.GetOrAddComponent(var_41_2, typeof(DynamicBoneHelper))

					if var_41_4 then
						var_41_4:EnableDynamicBone(false)
					end

					arg_38_1:ShowWeapon(var_41_3.transform, false)

					arg_38_1.var_[var_41_0 .. "Animator"] = var_41_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_38_1.var_[var_41_0 .. "Animator"].applyRootMotion = true
					arg_38_1.var_[var_41_0 .. "LipSync"] = var_41_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_41_5 = arg_38_1.actors_["1037ui_story"]
			local var_41_6 = 0

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 and not isNil(var_41_5) and arg_38_1.var_.characterEffect1037ui_story == nil then
				arg_38_1.var_.characterEffect1037ui_story = var_41_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_7 = 0.1

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_7 and not isNil(var_41_5) then
				local var_41_8 = (arg_38_1.time_ - var_41_6) / var_41_7

				if arg_38_1.var_.characterEffect1037ui_story and not isNil(var_41_5) then
					arg_38_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_6 + var_41_7 and arg_38_1.time_ < var_41_6 + var_41_7 + arg_41_0 and not isNil(var_41_5) and arg_38_1.var_.characterEffect1037ui_story then
				arg_38_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_41_9 = arg_38_1.actors_["1037ui_story"].transform
			local var_41_10 = 0

			if var_41_10 < arg_38_1.time_ and arg_38_1.time_ <= var_41_10 + arg_41_0 then
				arg_38_1.var_.moveOldPos1037ui_story = var_41_9.localPosition
			end

			local var_41_11 = 0.001

			if var_41_10 <= arg_38_1.time_ and arg_38_1.time_ < var_41_10 + var_41_11 then
				local var_41_12 = (arg_38_1.time_ - var_41_10) / var_41_11
				local var_41_13 = Vector3.New(0.7, -1.09, -5.81)

				var_41_9.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1037ui_story, var_41_13, var_41_12)

				local var_41_14 = manager.ui.mainCamera.transform.position - var_41_9.position

				var_41_9.forward = Vector3.New(var_41_14.x, var_41_14.y, var_41_14.z)

				local var_41_15 = var_41_9.localEulerAngles

				var_41_15.z = 0
				var_41_15.x = 0
				var_41_9.localEulerAngles = var_41_15
			end

			if arg_38_1.time_ >= var_41_10 + var_41_11 and arg_38_1.time_ < var_41_10 + var_41_11 + arg_41_0 then
				var_41_9.localPosition = Vector3.New(0.7, -1.09, -5.81)

				local var_41_16 = manager.ui.mainCamera.transform.position - var_41_9.position

				var_41_9.forward = Vector3.New(var_41_16.x, var_41_16.y, var_41_16.z)

				local var_41_17 = var_41_9.localEulerAngles

				var_41_17.z = 0
				var_41_17.x = 0
				var_41_9.localEulerAngles = var_41_17
			end

			local var_41_18 = 0

			if var_41_18 < arg_38_1.time_ and arg_38_1.time_ <= var_41_18 + arg_41_0 then
				arg_38_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_1")
			end

			local var_41_19 = arg_38_1.actors_["1032ui_story"].transform
			local var_41_20 = 0

			if var_41_20 < arg_38_1.time_ and arg_38_1.time_ <= var_41_20 + arg_41_0 then
				arg_38_1.var_.moveOldPos1032ui_story = var_41_19.localPosition
			end

			local var_41_21 = 0.100000001490116

			if var_41_20 <= arg_38_1.time_ and arg_38_1.time_ < var_41_20 + var_41_21 then
				local var_41_22 = (arg_38_1.time_ - var_41_20) / var_41_21
				local var_41_23 = Vector3.New(-0.7, -1.05, -6.2)

				var_41_19.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1032ui_story, var_41_23, var_41_22)

				local var_41_24 = manager.ui.mainCamera.transform.position - var_41_19.position

				var_41_19.forward = Vector3.New(var_41_24.x, var_41_24.y, var_41_24.z)

				local var_41_25 = var_41_19.localEulerAngles

				var_41_25.z = 0
				var_41_25.x = 0
				var_41_19.localEulerAngles = var_41_25
			end

			if arg_38_1.time_ >= var_41_20 + var_41_21 and arg_38_1.time_ < var_41_20 + var_41_21 + arg_41_0 then
				var_41_19.localPosition = Vector3.New(-0.7, -1.05, -6.2)

				local var_41_26 = manager.ui.mainCamera.transform.position - var_41_19.position

				var_41_19.forward = Vector3.New(var_41_26.x, var_41_26.y, var_41_26.z)

				local var_41_27 = var_41_19.localEulerAngles

				var_41_27.z = 0
				var_41_27.x = 0
				var_41_19.localEulerAngles = var_41_27
			end

			local var_41_28 = arg_38_1.actors_["1032ui_story"]
			local var_41_29 = 0

			if var_41_29 < arg_38_1.time_ and arg_38_1.time_ <= var_41_29 + arg_41_0 and not isNil(var_41_28) and arg_38_1.var_.characterEffect1032ui_story == nil then
				arg_38_1.var_.characterEffect1032ui_story = var_41_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_30 = 0.1

			if var_41_29 <= arg_38_1.time_ and arg_38_1.time_ < var_41_29 + var_41_30 and not isNil(var_41_28) then
				local var_41_31 = (arg_38_1.time_ - var_41_29) / var_41_30

				if arg_38_1.var_.characterEffect1032ui_story and not isNil(var_41_28) then
					local var_41_32 = Mathf.Lerp(0, 0.5, var_41_31)

					arg_38_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1032ui_story.fillRatio = var_41_32
				end
			end

			if arg_38_1.time_ >= var_41_29 + var_41_30 and arg_38_1.time_ < var_41_29 + var_41_30 + arg_41_0 and not isNil(var_41_28) and arg_38_1.var_.characterEffect1032ui_story then
				local var_41_33 = 0.5

				arg_38_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1032ui_story.fillRatio = var_41_33
			end

			local var_41_34 = 0

			if var_41_34 < arg_38_1.time_ and arg_38_1.time_ <= var_41_34 + arg_41_0 then
				arg_38_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_41_35 = 0
			local var_41_36 = 0.6

			if var_41_35 < arg_38_1.time_ and arg_38_1.time_ <= var_41_35 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_37 = arg_38_1:FormatText(StoryNameCfg[15].name)

				arg_38_1.leftNameTxt_.text = var_41_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_38 = arg_38_1:GetWordFromCfg(104102009)
				local var_41_39 = arg_38_1:FormatText(var_41_38.content)

				arg_38_1.text_.text = var_41_39

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_40 = 24
				local var_41_41 = utf8.len(var_41_39)
				local var_41_42 = var_41_40 <= 0 and var_41_36 or var_41_36 * (var_41_41 / var_41_40)

				if var_41_42 > 0 and var_41_36 < var_41_42 then
					arg_38_1.talkMaxDuration = var_41_42

					if var_41_42 + var_41_35 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_42 + var_41_35
					end
				end

				arg_38_1.text_.text = var_41_39
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102009", "story_v_out_104102.awb") ~= 0 then
					local var_41_43 = manager.audio:GetVoiceLength("story_v_out_104102", "104102009", "story_v_out_104102.awb") / 1000

					if var_41_43 + var_41_35 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_43 + var_41_35
					end

					if var_41_38.prefab_name ~= "" and arg_38_1.actors_[var_41_38.prefab_name] ~= nil then
						local var_41_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_38.prefab_name].transform, "story_v_out_104102", "104102009", "story_v_out_104102.awb")

						arg_38_1:RecordAudio("104102009", var_41_44)
						arg_38_1:RecordAudio("104102009", var_41_44)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_104102", "104102009", "story_v_out_104102.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_104102", "104102009", "story_v_out_104102.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_45 = math.max(var_41_36, arg_38_1.talkMaxDuration)

			if var_41_35 <= arg_38_1.time_ and arg_38_1.time_ < var_41_35 + var_41_45 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_35) / var_41_45

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_35 + var_41_45 and arg_38_1.time_ < var_41_35 + var_41_45 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.100000001490116,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play104102010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 104102010
		arg_42_1.duration_ = 5.2

		local var_42_0 = {
			ja = 5.2,
			ko = 3.4,
			zh = 3.6,
			en = 3.7
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
				arg_42_0:Play104102011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_2")
			end

			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_45_2 = 0
			local var_45_3 = 0.425

			if var_45_2 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_4 = arg_42_1:FormatText(StoryNameCfg[15].name)

				arg_42_1.leftNameTxt_.text = var_45_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_5 = arg_42_1:GetWordFromCfg(104102010)
				local var_45_6 = arg_42_1:FormatText(var_45_5.content)

				arg_42_1.text_.text = var_45_6

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_7 = 17
				local var_45_8 = utf8.len(var_45_6)
				local var_45_9 = var_45_7 <= 0 and var_45_3 or var_45_3 * (var_45_8 / var_45_7)

				if var_45_9 > 0 and var_45_3 < var_45_9 then
					arg_42_1.talkMaxDuration = var_45_9

					if var_45_9 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_9 + var_45_2
					end
				end

				arg_42_1.text_.text = var_45_6
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102010", "story_v_out_104102.awb") ~= 0 then
					local var_45_10 = manager.audio:GetVoiceLength("story_v_out_104102", "104102010", "story_v_out_104102.awb") / 1000

					if var_45_10 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_2
					end

					if var_45_5.prefab_name ~= "" and arg_42_1.actors_[var_45_5.prefab_name] ~= nil then
						local var_45_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_5.prefab_name].transform, "story_v_out_104102", "104102010", "story_v_out_104102.awb")

						arg_42_1:RecordAudio("104102010", var_45_11)
						arg_42_1:RecordAudio("104102010", var_45_11)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_104102", "104102010", "story_v_out_104102.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_104102", "104102010", "story_v_out_104102.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_12 = math.max(var_45_3, arg_42_1.talkMaxDuration)

			if var_45_2 <= arg_42_1.time_ and arg_42_1.time_ < var_45_2 + var_45_12 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_2) / var_45_12

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_2 + var_45_12 and arg_42_1.time_ < var_45_2 + var_45_12 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play104102011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 104102011
		arg_46_1.duration_ = 6.73

		local var_46_0 = {
			ja = 6.733,
			ko = 6.033,
			zh = 5.2,
			en = 4.466
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play104102012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1037ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1037ui_story == nil then
				arg_46_1.var_.characterEffect1037ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.1

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect1037ui_story and not isNil(var_49_0) then
					local var_49_4 = Mathf.Lerp(0, 0.5, var_49_3)

					arg_46_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1037ui_story.fillRatio = var_49_4
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1037ui_story then
				local var_49_5 = 0.5

				arg_46_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1037ui_story.fillRatio = var_49_5
			end

			local var_49_6 = 0
			local var_49_7 = 0.5

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_8 = arg_46_1:FormatText(StoryNameCfg[10].name)

				arg_46_1.leftNameTxt_.text = var_49_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_9 = arg_46_1:GetWordFromCfg(104102011)
				local var_49_10 = arg_46_1:FormatText(var_49_9.content)

				arg_46_1.text_.text = var_49_10

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_11 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102011", "story_v_out_104102.awb") ~= 0 then
					local var_49_14 = manager.audio:GetVoiceLength("story_v_out_104102", "104102011", "story_v_out_104102.awb") / 1000

					if var_49_14 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_14 + var_49_6
					end

					if var_49_9.prefab_name ~= "" and arg_46_1.actors_[var_49_9.prefab_name] ~= nil then
						local var_49_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_9.prefab_name].transform, "story_v_out_104102", "104102011", "story_v_out_104102.awb")

						arg_46_1:RecordAudio("104102011", var_49_15)
						arg_46_1:RecordAudio("104102011", var_49_15)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_104102", "104102011", "story_v_out_104102.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_104102", "104102011", "story_v_out_104102.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_16 = math.max(var_49_7, arg_46_1.talkMaxDuration)

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_16 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_6) / var_49_16

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_6 + var_49_16 and arg_46_1.time_ < var_49_6 + var_49_16 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play104102012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 104102012
		arg_50_1.duration_ = 5.53

		local var_50_0 = {
			ja = 5.533,
			ko = 2.7,
			zh = 3.866,
			en = 3.533
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
				arg_50_0:Play104102013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1032ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1032ui_story == nil then
				arg_50_1.var_.characterEffect1032ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.1

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect1032ui_story and not isNil(var_53_0) then
					arg_50_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1032ui_story then
				arg_50_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			local var_53_4 = 0

			if var_53_4 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action7_2")
			end

			local var_53_5 = 0

			if var_53_5 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_53_6 = 0
			local var_53_7 = 0.375

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[61].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_9 = arg_50_1:GetWordFromCfg(104102012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 15
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_7 or var_53_7 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_7 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102012", "story_v_out_104102.awb") ~= 0 then
					local var_53_14 = manager.audio:GetVoiceLength("story_v_out_104102", "104102012", "story_v_out_104102.awb") / 1000

					if var_53_14 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_6
					end

					if var_53_9.prefab_name ~= "" and arg_50_1.actors_[var_53_9.prefab_name] ~= nil then
						local var_53_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_9.prefab_name].transform, "story_v_out_104102", "104102012", "story_v_out_104102.awb")

						arg_50_1:RecordAudio("104102012", var_53_15)
						arg_50_1:RecordAudio("104102012", var_53_15)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_104102", "104102012", "story_v_out_104102.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_104102", "104102012", "story_v_out_104102.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_16 and arg_50_1.time_ < var_53_6 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play104102013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 104102013
		arg_54_1.duration_ = 0.1

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"

			SetActive(arg_54_1.choicesGo_, true)

			for iter_55_0, iter_55_1 in ipairs(arg_54_1.choices_) do
				local var_55_0 = iter_55_0 <= 2

				SetActive(iter_55_1.go, var_55_0)
			end

			arg_54_1.choices_[1].txt.text = arg_54_1:FormatText(StoryChoiceCfg[28].name)
			arg_54_1.choices_[2].txt.text = arg_54_1:FormatText(StoryChoiceCfg[29].name)
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play104102018(arg_54_1)
			end

			if arg_56_0 == 2 then
				arg_54_0:Play104102014(arg_54_1)
			end

			arg_54_1:RecordChoiceLog(104102013, 28, 29)
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1032ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1032ui_story == nil then
				arg_54_1.var_.characterEffect1032ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.1

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1032ui_story and not isNil(var_57_0) then
					local var_57_4 = Mathf.Lerp(0, 0.5, var_57_3)

					arg_54_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1032ui_story.fillRatio = var_57_4
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1032ui_story then
				local var_57_5 = 0.5

				arg_54_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1032ui_story.fillRatio = var_57_5
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play104102018 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 104102018
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play104102019(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1032ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1032ui_story == nil then
				arg_58_1.var_.characterEffect1032ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.1

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect1032ui_story and not isNil(var_61_0) then
					local var_61_4 = Mathf.Lerp(0, 0.5, var_61_3)

					arg_58_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1032ui_story.fillRatio = var_61_4
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1032ui_story then
				local var_61_5 = 0.5

				arg_58_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1032ui_story.fillRatio = var_61_5
			end

			local var_61_6 = 0
			local var_61_7 = 0.35

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

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_9 = arg_58_1:GetWordFromCfg(104102018)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 14
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
	Play104102019 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 104102019
		arg_62_1.duration_ = 2.9

		local var_62_0 = {
			ja = 2.133,
			ko = 2.6,
			zh = 2.666,
			en = 2.9
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
				arg_62_0:Play104102020(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1032ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1032ui_story == nil then
				arg_62_1.var_.characterEffect1032ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.1

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1032ui_story and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1032ui_story then
				arg_62_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			local var_65_4 = 0

			if var_65_4 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action1_1")
			end

			local var_65_5 = 0

			if var_65_5 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 then
				arg_62_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_65_6 = 0
			local var_65_7 = 0.15

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[61].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_9 = arg_62_1:GetWordFromCfg(104102019)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 6
				local var_65_12 = utf8.len(var_65_10)
				local var_65_13 = var_65_11 <= 0 and var_65_7 or var_65_7 * (var_65_12 / var_65_11)

				if var_65_13 > 0 and var_65_7 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_10
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102019", "story_v_out_104102.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_out_104102", "104102019", "story_v_out_104102.awb") / 1000

					if var_65_14 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_6
					end

					if var_65_9.prefab_name ~= "" and arg_62_1.actors_[var_65_9.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_9.prefab_name].transform, "story_v_out_104102", "104102019", "story_v_out_104102.awb")

						arg_62_1:RecordAudio("104102019", var_65_15)
						arg_62_1:RecordAudio("104102019", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_104102", "104102019", "story_v_out_104102.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_104102", "104102019", "story_v_out_104102.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_16 and arg_62_1.time_ < var_65_6 + var_65_16 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play104102020 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 104102020
		arg_66_1.duration_ = 8.27

		local var_66_0 = {
			ja = 7.133,
			ko = 6.433,
			zh = 8.266,
			en = 7.766
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
				arg_66_0:Play104102021(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_69_1 = 0
			local var_69_2 = 0.95

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_3 = arg_66_1:FormatText(StoryNameCfg[61].name)

				arg_66_1.leftNameTxt_.text = var_69_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_4 = arg_66_1:GetWordFromCfg(104102020)
				local var_69_5 = arg_66_1:FormatText(var_69_4.content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_6 = 38
				local var_69_7 = utf8.len(var_69_5)
				local var_69_8 = var_69_6 <= 0 and var_69_2 or var_69_2 * (var_69_7 / var_69_6)

				if var_69_8 > 0 and var_69_2 < var_69_8 then
					arg_66_1.talkMaxDuration = var_69_8

					if var_69_8 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_1
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102020", "story_v_out_104102.awb") ~= 0 then
					local var_69_9 = manager.audio:GetVoiceLength("story_v_out_104102", "104102020", "story_v_out_104102.awb") / 1000

					if var_69_9 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_1
					end

					if var_69_4.prefab_name ~= "" and arg_66_1.actors_[var_69_4.prefab_name] ~= nil then
						local var_69_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_4.prefab_name].transform, "story_v_out_104102", "104102020", "story_v_out_104102.awb")

						arg_66_1:RecordAudio("104102020", var_69_10)
						arg_66_1:RecordAudio("104102020", var_69_10)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_104102", "104102020", "story_v_out_104102.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_104102", "104102020", "story_v_out_104102.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_11 = math.max(var_69_2, arg_66_1.talkMaxDuration)

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_11 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_1) / var_69_11

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_1 + var_69_11 and arg_66_1.time_ < var_69_1 + var_69_11 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play104102021 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 104102021
		arg_70_1.duration_ = 12.9

		local var_70_0 = {
			ja = 12.9,
			ko = 7.466,
			zh = 7.166,
			en = 7.8
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play104102022(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1037ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1037ui_story == nil then
				arg_70_1.var_.characterEffect1037ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.1

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1037ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1037ui_story then
				arg_70_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["1032ui_story"]
			local var_73_5 = 0

			if var_73_5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1032ui_story == nil then
				arg_70_1.var_.characterEffect1032ui_story = var_73_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_6 = 0.1

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 and not isNil(var_73_4) then
				local var_73_7 = (arg_70_1.time_ - var_73_5) / var_73_6

				if arg_70_1.var_.characterEffect1032ui_story and not isNil(var_73_4) then
					local var_73_8 = Mathf.Lerp(0, 0.5, var_73_7)

					arg_70_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1032ui_story.fillRatio = var_73_8
				end
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1032ui_story then
				local var_73_9 = 0.5

				arg_70_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1032ui_story.fillRatio = var_73_9
			end

			local var_73_10 = 0

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_73_11 = 0
			local var_73_12 = 0.875

			if var_73_11 < arg_70_1.time_ and arg_70_1.time_ <= var_73_11 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_13 = arg_70_1:FormatText(StoryNameCfg[15].name)

				arg_70_1.leftNameTxt_.text = var_73_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_14 = arg_70_1:GetWordFromCfg(104102021)
				local var_73_15 = arg_70_1:FormatText(var_73_14.content)

				arg_70_1.text_.text = var_73_15

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_16 = 35
				local var_73_17 = utf8.len(var_73_15)
				local var_73_18 = var_73_16 <= 0 and var_73_12 or var_73_12 * (var_73_17 / var_73_16)

				if var_73_18 > 0 and var_73_12 < var_73_18 then
					arg_70_1.talkMaxDuration = var_73_18

					if var_73_18 + var_73_11 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_18 + var_73_11
					end
				end

				arg_70_1.text_.text = var_73_15
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102021", "story_v_out_104102.awb") ~= 0 then
					local var_73_19 = manager.audio:GetVoiceLength("story_v_out_104102", "104102021", "story_v_out_104102.awb") / 1000

					if var_73_19 + var_73_11 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_19 + var_73_11
					end

					if var_73_14.prefab_name ~= "" and arg_70_1.actors_[var_73_14.prefab_name] ~= nil then
						local var_73_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_14.prefab_name].transform, "story_v_out_104102", "104102021", "story_v_out_104102.awb")

						arg_70_1:RecordAudio("104102021", var_73_20)
						arg_70_1:RecordAudio("104102021", var_73_20)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_104102", "104102021", "story_v_out_104102.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_104102", "104102021", "story_v_out_104102.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_21 = math.max(var_73_12, arg_70_1.talkMaxDuration)

			if var_73_11 <= arg_70_1.time_ and arg_70_1.time_ < var_73_11 + var_73_21 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_11) / var_73_21

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_11 + var_73_21 and arg_70_1.time_ < var_73_11 + var_73_21 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play104102022 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 104102022
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play104102023(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1037ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1037ui_story == nil then
				arg_74_1.var_.characterEffect1037ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.1

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect1037ui_story and not isNil(var_77_0) then
					local var_77_4 = Mathf.Lerp(0, 0.5, var_77_3)

					arg_74_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1037ui_story.fillRatio = var_77_4
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1037ui_story then
				local var_77_5 = 0.5

				arg_74_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1037ui_story.fillRatio = var_77_5
			end

			local var_77_6 = 0
			local var_77_7 = 0.7

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_8 = arg_74_1:FormatText(StoryNameCfg[7].name)

				arg_74_1.leftNameTxt_.text = var_77_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_9 = arg_74_1:GetWordFromCfg(104102022)
				local var_77_10 = arg_74_1:FormatText(var_77_9.content)

				arg_74_1.text_.text = var_77_10

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_11 = 28
				local var_77_12 = utf8.len(var_77_10)
				local var_77_13 = var_77_11 <= 0 and var_77_7 or var_77_7 * (var_77_12 / var_77_11)

				if var_77_13 > 0 and var_77_7 < var_77_13 then
					arg_74_1.talkMaxDuration = var_77_13

					if var_77_13 + var_77_6 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_13 + var_77_6
					end
				end

				arg_74_1.text_.text = var_77_10
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_14 = math.max(var_77_7, arg_74_1.talkMaxDuration)

			if var_77_6 <= arg_74_1.time_ and arg_74_1.time_ < var_77_6 + var_77_14 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_6) / var_77_14

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_6 + var_77_14 and arg_74_1.time_ < var_77_6 + var_77_14 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play104102023 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 104102023
		arg_78_1.duration_ = 3.27

		local var_78_0 = {
			ja = 2.633,
			ko = 2.5,
			zh = 3.266,
			en = 1.666
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
				arg_78_0:Play104102024(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 1

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				local var_81_2 = "play"
				local var_81_3 = "effect"

				arg_78_1:AudioAction(var_81_2, var_81_3, "se_story", "se_story_robot_excited", "")
			end

			local var_81_4 = arg_78_1.actors_["1032ui_story"].transform
			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.var_.moveOldPos1032ui_story = var_81_4.localPosition
			end

			local var_81_6 = 0.001

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_6 then
				local var_81_7 = (arg_78_1.time_ - var_81_5) / var_81_6
				local var_81_8 = Vector3.New(0, 100, 0)

				var_81_4.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1032ui_story, var_81_8, var_81_7)

				local var_81_9 = manager.ui.mainCamera.transform.position - var_81_4.position

				var_81_4.forward = Vector3.New(var_81_9.x, var_81_9.y, var_81_9.z)

				local var_81_10 = var_81_4.localEulerAngles

				var_81_10.z = 0
				var_81_10.x = 0
				var_81_4.localEulerAngles = var_81_10
			end

			if arg_78_1.time_ >= var_81_5 + var_81_6 and arg_78_1.time_ < var_81_5 + var_81_6 + arg_81_0 then
				var_81_4.localPosition = Vector3.New(0, 100, 0)

				local var_81_11 = manager.ui.mainCamera.transform.position - var_81_4.position

				var_81_4.forward = Vector3.New(var_81_11.x, var_81_11.y, var_81_11.z)

				local var_81_12 = var_81_4.localEulerAngles

				var_81_12.z = 0
				var_81_12.x = 0
				var_81_4.localEulerAngles = var_81_12
			end

			local var_81_13 = arg_78_1.actors_["1037ui_story"].transform
			local var_81_14 = 0

			if var_81_14 < arg_78_1.time_ and arg_78_1.time_ <= var_81_14 + arg_81_0 then
				arg_78_1.var_.moveOldPos1037ui_story = var_81_13.localPosition
			end

			local var_81_15 = 0.001

			if var_81_14 <= arg_78_1.time_ and arg_78_1.time_ < var_81_14 + var_81_15 then
				local var_81_16 = (arg_78_1.time_ - var_81_14) / var_81_15
				local var_81_17 = Vector3.New(0, 100, 0)

				var_81_13.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1037ui_story, var_81_17, var_81_16)

				local var_81_18 = manager.ui.mainCamera.transform.position - var_81_13.position

				var_81_13.forward = Vector3.New(var_81_18.x, var_81_18.y, var_81_18.z)

				local var_81_19 = var_81_13.localEulerAngles

				var_81_19.z = 0
				var_81_19.x = 0
				var_81_13.localEulerAngles = var_81_19
			end

			if arg_78_1.time_ >= var_81_14 + var_81_15 and arg_78_1.time_ < var_81_14 + var_81_15 + arg_81_0 then
				var_81_13.localPosition = Vector3.New(0, 100, 0)

				local var_81_20 = manager.ui.mainCamera.transform.position - var_81_13.position

				var_81_13.forward = Vector3.New(var_81_20.x, var_81_20.y, var_81_20.z)

				local var_81_21 = var_81_13.localEulerAngles

				var_81_21.z = 0
				var_81_21.x = 0
				var_81_13.localEulerAngles = var_81_21
			end

			local var_81_22 = "2069_tpose"

			if arg_78_1.actors_[var_81_22] == nil then
				local var_81_23 = Asset.Load("Char/" .. "2069_tpose")

				if not isNil(var_81_23) then
					local var_81_24 = Object.Instantiate(Asset.Load("Char/" .. "2069_tpose"), arg_78_1.stage_.transform)

					var_81_24.name = var_81_22
					var_81_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_78_1.actors_[var_81_22] = var_81_24

					local var_81_25 = var_81_24:GetComponentInChildren(typeof(CharacterEffect))

					var_81_25.enabled = true

					local var_81_26 = GameObjectTools.GetOrAddComponent(var_81_24, typeof(DynamicBoneHelper))

					if var_81_26 then
						var_81_26:EnableDynamicBone(false)
					end

					arg_78_1:ShowWeapon(var_81_25.transform, false)

					arg_78_1.var_[var_81_22 .. "Animator"] = var_81_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_78_1.var_[var_81_22 .. "Animator"].applyRootMotion = true
					arg_78_1.var_[var_81_22 .. "LipSync"] = var_81_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_81_27 = arg_78_1.actors_["2069_tpose"].transform
			local var_81_28 = 0

			if var_81_28 < arg_78_1.time_ and arg_78_1.time_ <= var_81_28 + arg_81_0 then
				arg_78_1.var_.moveOldPos2069_tpose = var_81_27.localPosition

				local var_81_29 = GameObjectTools.GetOrAddComponent(var_81_27.gameObject, typeof(DynamicBoneHelper))

				if var_81_29 then
					var_81_29:EnableDynamicBone(false)
				end
			end

			local var_81_30 = 0.001

			if var_81_28 <= arg_78_1.time_ and arg_78_1.time_ < var_81_28 + var_81_30 then
				local var_81_31 = (arg_78_1.time_ - var_81_28) / var_81_30
				local var_81_32 = Vector3.New(-0.7, -0.51, -3.1)

				var_81_27.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos2069_tpose, var_81_32, var_81_31)

				local var_81_33 = manager.ui.mainCamera.transform.position - var_81_27.position

				var_81_27.forward = Vector3.New(var_81_33.x, var_81_33.y, var_81_33.z)

				local var_81_34 = var_81_27.localEulerAngles

				var_81_34.z = 0
				var_81_34.x = 0
				var_81_27.localEulerAngles = var_81_34
			end

			if arg_78_1.time_ >= var_81_28 + var_81_30 and arg_78_1.time_ < var_81_28 + var_81_30 + arg_81_0 then
				var_81_27.localPosition = Vector3.New(-0.7, -0.51, -3.1)

				local var_81_35 = manager.ui.mainCamera.transform.position - var_81_27.position

				var_81_27.forward = Vector3.New(var_81_35.x, var_81_35.y, var_81_35.z)

				local var_81_36 = var_81_27.localEulerAngles

				var_81_36.z = 0
				var_81_36.x = 0
				var_81_27.localEulerAngles = var_81_36

				local var_81_37 = GameObjectTools.GetOrAddComponent(var_81_27.gameObject, typeof(DynamicBoneHelper))

				if var_81_37 then
					var_81_37:EnableDynamicBone(true)
				end
			end

			local var_81_38 = "2070_tpose"

			if arg_78_1.actors_[var_81_38] == nil then
				local var_81_39 = Asset.Load("Char/" .. "2070_tpose")

				if not isNil(var_81_39) then
					local var_81_40 = Object.Instantiate(Asset.Load("Char/" .. "2070_tpose"), arg_78_1.stage_.transform)

					var_81_40.name = var_81_38
					var_81_40.transform.localPosition = Vector3.New(0, 100, 0)
					arg_78_1.actors_[var_81_38] = var_81_40

					local var_81_41 = var_81_40:GetComponentInChildren(typeof(CharacterEffect))

					var_81_41.enabled = true

					local var_81_42 = GameObjectTools.GetOrAddComponent(var_81_40, typeof(DynamicBoneHelper))

					if var_81_42 then
						var_81_42:EnableDynamicBone(false)
					end

					arg_78_1:ShowWeapon(var_81_41.transform, false)

					arg_78_1.var_[var_81_38 .. "Animator"] = var_81_41.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_78_1.var_[var_81_38 .. "Animator"].applyRootMotion = true
					arg_78_1.var_[var_81_38 .. "LipSync"] = var_81_41.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_81_43 = arg_78_1.actors_["2070_tpose"].transform
			local var_81_44 = 0

			if var_81_44 < arg_78_1.time_ and arg_78_1.time_ <= var_81_44 + arg_81_0 then
				arg_78_1.var_.moveOldPos2070_tpose = var_81_43.localPosition

				local var_81_45 = GameObjectTools.GetOrAddComponent(var_81_43.gameObject, typeof(DynamicBoneHelper))

				if var_81_45 then
					var_81_45:EnableDynamicBone(false)
				end
			end

			local var_81_46 = 0.001

			if var_81_44 <= arg_78_1.time_ and arg_78_1.time_ < var_81_44 + var_81_46 then
				local var_81_47 = (arg_78_1.time_ - var_81_44) / var_81_46
				local var_81_48 = Vector3.New(0.7, -0.49, -3.1)

				var_81_43.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos2070_tpose, var_81_48, var_81_47)

				local var_81_49 = manager.ui.mainCamera.transform.position - var_81_43.position

				var_81_43.forward = Vector3.New(var_81_49.x, var_81_49.y, var_81_49.z)

				local var_81_50 = var_81_43.localEulerAngles

				var_81_50.z = 0
				var_81_50.x = 0
				var_81_43.localEulerAngles = var_81_50
			end

			if arg_78_1.time_ >= var_81_44 + var_81_46 and arg_78_1.time_ < var_81_44 + var_81_46 + arg_81_0 then
				var_81_43.localPosition = Vector3.New(0.7, -0.49, -3.1)

				local var_81_51 = manager.ui.mainCamera.transform.position - var_81_43.position

				var_81_43.forward = Vector3.New(var_81_51.x, var_81_51.y, var_81_51.z)

				local var_81_52 = var_81_43.localEulerAngles

				var_81_52.z = 0
				var_81_52.x = 0
				var_81_43.localEulerAngles = var_81_52

				local var_81_53 = GameObjectTools.GetOrAddComponent(var_81_43.gameObject, typeof(DynamicBoneHelper))

				if var_81_53 then
					var_81_53:EnableDynamicBone(true)
				end
			end

			local var_81_54 = arg_78_1.actors_["2069_tpose"]
			local var_81_55 = 0

			if var_81_55 < arg_78_1.time_ and arg_78_1.time_ <= var_81_55 + arg_81_0 and not isNil(var_81_54) and arg_78_1.var_.characterEffect2069_tpose == nil then
				arg_78_1.var_.characterEffect2069_tpose = var_81_54:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_56 = 0.2

			if var_81_55 <= arg_78_1.time_ and arg_78_1.time_ < var_81_55 + var_81_56 and not isNil(var_81_54) then
				local var_81_57 = (arg_78_1.time_ - var_81_55) / var_81_56

				if arg_78_1.var_.characterEffect2069_tpose and not isNil(var_81_54) then
					arg_78_1.var_.characterEffect2069_tpose.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_55 + var_81_56 and arg_78_1.time_ < var_81_55 + var_81_56 + arg_81_0 and not isNil(var_81_54) and arg_78_1.var_.characterEffect2069_tpose then
				arg_78_1.var_.characterEffect2069_tpose.fillFlat = false
			end

			local var_81_58 = arg_78_1.actors_["2070_tpose"]
			local var_81_59 = 0

			if var_81_59 < arg_78_1.time_ and arg_78_1.time_ <= var_81_59 + arg_81_0 and not isNil(var_81_58) and arg_78_1.var_.characterEffect2070_tpose == nil then
				arg_78_1.var_.characterEffect2070_tpose = var_81_58:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_60 = 0.2

			if var_81_59 <= arg_78_1.time_ and arg_78_1.time_ < var_81_59 + var_81_60 and not isNil(var_81_58) then
				local var_81_61 = (arg_78_1.time_ - var_81_59) / var_81_60

				if arg_78_1.var_.characterEffect2070_tpose and not isNil(var_81_58) then
					arg_78_1.var_.characterEffect2070_tpose.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_59 + var_81_60 and arg_78_1.time_ < var_81_59 + var_81_60 + arg_81_0 and not isNil(var_81_58) and arg_78_1.var_.characterEffect2070_tpose then
				arg_78_1.var_.characterEffect2070_tpose.fillFlat = false
			end

			local var_81_62 = 0
			local var_81_63 = 0.225

			if var_81_62 < arg_78_1.time_ and arg_78_1.time_ <= var_81_62 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_64 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_64:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_65 = arg_78_1:FormatText(StoryNameCfg[29].name)

				arg_78_1.leftNameTxt_.text = var_81_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_66 = arg_78_1:GetWordFromCfg(104102023)
				local var_81_67 = arg_78_1:FormatText(var_81_66.content)

				arg_78_1.text_.text = var_81_67

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_68 = 9
				local var_81_69 = utf8.len(var_81_67)
				local var_81_70 = var_81_68 <= 0 and var_81_63 or var_81_63 * (var_81_69 / var_81_68)

				if var_81_70 > 0 and var_81_63 < var_81_70 then
					arg_78_1.talkMaxDuration = var_81_70
					var_81_62 = var_81_62 + 0.3

					if var_81_70 + var_81_62 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_70 + var_81_62
					end
				end

				arg_78_1.text_.text = var_81_67
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102023", "story_v_out_104102.awb") ~= 0 then
					local var_81_71 = manager.audio:GetVoiceLength("story_v_out_104102", "104102023", "story_v_out_104102.awb") / 1000

					if var_81_71 + var_81_62 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_71 + var_81_62
					end

					if var_81_66.prefab_name ~= "" and arg_78_1.actors_[var_81_66.prefab_name] ~= nil then
						local var_81_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_66.prefab_name].transform, "story_v_out_104102", "104102023", "story_v_out_104102.awb")

						arg_78_1:RecordAudio("104102023", var_81_72)
						arg_78_1:RecordAudio("104102023", var_81_72)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_104102", "104102023", "story_v_out_104102.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_104102", "104102023", "story_v_out_104102.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_73 = var_81_62 + 0.3
			local var_81_74 = math.max(var_81_63, arg_78_1.talkMaxDuration)

			if var_81_73 <= arg_78_1.time_ and arg_78_1.time_ < var_81_73 + var_81_74 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_73) / var_81_74

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_73 + var_81_74 and arg_78_1.time_ < var_81_73 + var_81_74 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2069_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2070_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play104102024 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 104102024
		arg_84_1.duration_ = 4.67

		local var_84_0 = {
			ja = 3.533,
			ko = 3.633,
			zh = 4.666,
			en = 2.766
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
				arg_84_0:Play104102025(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 1

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				local var_87_2 = "play"
				local var_87_3 = "effect"

				arg_84_1:AudioAction(var_87_2, var_87_3, "se_story", "se_story_robot_excited", "")
			end

			local var_87_4 = 0
			local var_87_5 = 0.275

			if var_87_4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_6 = arg_84_1:FormatText(StoryNameCfg[29].name)

				arg_84_1.leftNameTxt_.text = var_87_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_7 = arg_84_1:GetWordFromCfg(104102024)
				local var_87_8 = arg_84_1:FormatText(var_87_7.content)

				arg_84_1.text_.text = var_87_8

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 11
				local var_87_10 = utf8.len(var_87_8)
				local var_87_11 = var_87_9 <= 0 and var_87_5 or var_87_5 * (var_87_10 / var_87_9)

				if var_87_11 > 0 and var_87_5 < var_87_11 then
					arg_84_1.talkMaxDuration = var_87_11

					if var_87_11 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_11 + var_87_4
					end
				end

				arg_84_1.text_.text = var_87_8
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102024", "story_v_out_104102.awb") ~= 0 then
					local var_87_12 = manager.audio:GetVoiceLength("story_v_out_104102", "104102024", "story_v_out_104102.awb") / 1000

					if var_87_12 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_12 + var_87_4
					end

					if var_87_7.prefab_name ~= "" and arg_84_1.actors_[var_87_7.prefab_name] ~= nil then
						local var_87_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_7.prefab_name].transform, "story_v_out_104102", "104102024", "story_v_out_104102.awb")

						arg_84_1:RecordAudio("104102024", var_87_13)
						arg_84_1:RecordAudio("104102024", var_87_13)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_104102", "104102024", "story_v_out_104102.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_104102", "104102024", "story_v_out_104102.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_14 = math.max(var_87_5, arg_84_1.talkMaxDuration)

			if var_87_4 <= arg_84_1.time_ and arg_84_1.time_ < var_87_4 + var_87_14 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_4) / var_87_14

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_4 + var_87_14 and arg_84_1.time_ < var_87_4 + var_87_14 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play104102025 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 104102025
		arg_88_1.duration_ = 4.17

		local var_88_0 = {
			ja = 3.266,
			ko = 2.9,
			zh = 2.8,
			en = 4.166
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
				arg_88_0:Play104102026(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1037ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1037ui_story == nil then
				arg_88_1.var_.characterEffect1037ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1037ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1037ui_story then
				arg_88_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_91_4 = arg_88_1.actors_["1037ui_story"].transform
			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.var_.moveOldPos1037ui_story = var_91_4.localPosition
			end

			local var_91_6 = 0.001

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 then
				local var_91_7 = (arg_88_1.time_ - var_91_5) / var_91_6
				local var_91_8 = Vector3.New(0, -1.09, -5.81)

				var_91_4.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1037ui_story, var_91_8, var_91_7)

				local var_91_9 = manager.ui.mainCamera.transform.position - var_91_4.position

				var_91_4.forward = Vector3.New(var_91_9.x, var_91_9.y, var_91_9.z)

				local var_91_10 = var_91_4.localEulerAngles

				var_91_10.z = 0
				var_91_10.x = 0
				var_91_4.localEulerAngles = var_91_10
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 then
				var_91_4.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_91_11 = manager.ui.mainCamera.transform.position - var_91_4.position

				var_91_4.forward = Vector3.New(var_91_11.x, var_91_11.y, var_91_11.z)

				local var_91_12 = var_91_4.localEulerAngles

				var_91_12.z = 0
				var_91_12.x = 0
				var_91_4.localEulerAngles = var_91_12
			end

			local var_91_13 = 0

			if var_91_13 < arg_88_1.time_ and arg_88_1.time_ <= var_91_13 + arg_91_0 then
				arg_88_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action6_1")
			end

			local var_91_14 = arg_88_1.actors_["2069_tpose"].transform
			local var_91_15 = 0

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1.var_.moveOldPos2069_tpose = var_91_14.localPosition

				local var_91_16 = GameObjectTools.GetOrAddComponent(var_91_14.gameObject, typeof(DynamicBoneHelper))

				if var_91_16 then
					var_91_16:EnableDynamicBone(false)
				end
			end

			local var_91_17 = 0.001

			if var_91_15 <= arg_88_1.time_ and arg_88_1.time_ < var_91_15 + var_91_17 then
				local var_91_18 = (arg_88_1.time_ - var_91_15) / var_91_17
				local var_91_19 = Vector3.New(0, 100, 0)

				var_91_14.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos2069_tpose, var_91_19, var_91_18)

				local var_91_20 = manager.ui.mainCamera.transform.position - var_91_14.position

				var_91_14.forward = Vector3.New(var_91_20.x, var_91_20.y, var_91_20.z)

				local var_91_21 = var_91_14.localEulerAngles

				var_91_21.z = 0
				var_91_21.x = 0
				var_91_14.localEulerAngles = var_91_21
			end

			if arg_88_1.time_ >= var_91_15 + var_91_17 and arg_88_1.time_ < var_91_15 + var_91_17 + arg_91_0 then
				var_91_14.localPosition = Vector3.New(0, 100, 0)

				local var_91_22 = manager.ui.mainCamera.transform.position - var_91_14.position

				var_91_14.forward = Vector3.New(var_91_22.x, var_91_22.y, var_91_22.z)

				local var_91_23 = var_91_14.localEulerAngles

				var_91_23.z = 0
				var_91_23.x = 0
				var_91_14.localEulerAngles = var_91_23

				local var_91_24 = GameObjectTools.GetOrAddComponent(var_91_14.gameObject, typeof(DynamicBoneHelper))

				if var_91_24 then
					var_91_24:EnableDynamicBone(true)
				end
			end

			local var_91_25 = arg_88_1.actors_["2070_tpose"].transform
			local var_91_26 = 0

			if var_91_26 < arg_88_1.time_ and arg_88_1.time_ <= var_91_26 + arg_91_0 then
				arg_88_1.var_.moveOldPos2070_tpose = var_91_25.localPosition

				local var_91_27 = GameObjectTools.GetOrAddComponent(var_91_25.gameObject, typeof(DynamicBoneHelper))

				if var_91_27 then
					var_91_27:EnableDynamicBone(false)
				end
			end

			local var_91_28 = 0.001

			if var_91_26 <= arg_88_1.time_ and arg_88_1.time_ < var_91_26 + var_91_28 then
				local var_91_29 = (arg_88_1.time_ - var_91_26) / var_91_28
				local var_91_30 = Vector3.New(0, 100, 0)

				var_91_25.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos2070_tpose, var_91_30, var_91_29)

				local var_91_31 = manager.ui.mainCamera.transform.position - var_91_25.position

				var_91_25.forward = Vector3.New(var_91_31.x, var_91_31.y, var_91_31.z)

				local var_91_32 = var_91_25.localEulerAngles

				var_91_32.z = 0
				var_91_32.x = 0
				var_91_25.localEulerAngles = var_91_32
			end

			if arg_88_1.time_ >= var_91_26 + var_91_28 and arg_88_1.time_ < var_91_26 + var_91_28 + arg_91_0 then
				var_91_25.localPosition = Vector3.New(0, 100, 0)

				local var_91_33 = manager.ui.mainCamera.transform.position - var_91_25.position

				var_91_25.forward = Vector3.New(var_91_33.x, var_91_33.y, var_91_33.z)

				local var_91_34 = var_91_25.localEulerAngles

				var_91_34.z = 0
				var_91_34.x = 0
				var_91_25.localEulerAngles = var_91_34

				local var_91_35 = GameObjectTools.GetOrAddComponent(var_91_25.gameObject, typeof(DynamicBoneHelper))

				if var_91_35 then
					var_91_35:EnableDynamicBone(true)
				end
			end

			local var_91_36 = 0

			if var_91_36 < arg_88_1.time_ and arg_88_1.time_ <= var_91_36 + arg_91_0 then
				arg_88_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_91_37 = 0
			local var_91_38 = 0.3

			if var_91_37 < arg_88_1.time_ and arg_88_1.time_ <= var_91_37 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_39 = arg_88_1:FormatText(StoryNameCfg[15].name)

				arg_88_1.leftNameTxt_.text = var_91_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_40 = arg_88_1:GetWordFromCfg(104102025)
				local var_91_41 = arg_88_1:FormatText(var_91_40.content)

				arg_88_1.text_.text = var_91_41

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_42 = 12
				local var_91_43 = utf8.len(var_91_41)
				local var_91_44 = var_91_42 <= 0 and var_91_38 or var_91_38 * (var_91_43 / var_91_42)

				if var_91_44 > 0 and var_91_38 < var_91_44 then
					arg_88_1.talkMaxDuration = var_91_44

					if var_91_44 + var_91_37 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_44 + var_91_37
					end
				end

				arg_88_1.text_.text = var_91_41
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102025", "story_v_out_104102.awb") ~= 0 then
					local var_91_45 = manager.audio:GetVoiceLength("story_v_out_104102", "104102025", "story_v_out_104102.awb") / 1000

					if var_91_45 + var_91_37 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_45 + var_91_37
					end

					if var_91_40.prefab_name ~= "" and arg_88_1.actors_[var_91_40.prefab_name] ~= nil then
						local var_91_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_40.prefab_name].transform, "story_v_out_104102", "104102025", "story_v_out_104102.awb")

						arg_88_1:RecordAudio("104102025", var_91_46)
						arg_88_1:RecordAudio("104102025", var_91_46)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_104102", "104102025", "story_v_out_104102.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_104102", "104102025", "story_v_out_104102.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_47 = math.max(var_91_38, arg_88_1.talkMaxDuration)

			if var_91_37 <= arg_88_1.time_ and arg_88_1.time_ < var_91_37 + var_91_47 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_37) / var_91_47

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_37 + var_91_47 and arg_88_1.time_ < var_91_37 + var_91_47 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2069_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2070_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play104102026 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 104102026
		arg_92_1.duration_ = 9.53

		local var_92_0 = {
			ja = 9.533,
			ko = 7.733,
			zh = 8.6,
			en = 6.633
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
				arg_92_0:Play104102027(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1037ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1037ui_story == nil then
				arg_92_1.var_.characterEffect1037ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.1

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1037ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1037ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1037ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1037ui_story.fillRatio = var_95_5
			end

			local var_95_6 = 0
			local var_95_7 = 0.925

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_8 = arg_92_1:FormatText(StoryNameCfg[10].name)

				arg_92_1.leftNameTxt_.text = var_95_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_9 = arg_92_1:GetWordFromCfg(104102026)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102026", "story_v_out_104102.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_104102", "104102026", "story_v_out_104102.awb") / 1000

					if var_95_14 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_6
					end

					if var_95_9.prefab_name ~= "" and arg_92_1.actors_[var_95_9.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_9.prefab_name].transform, "story_v_out_104102", "104102026", "story_v_out_104102.awb")

						arg_92_1:RecordAudio("104102026", var_95_15)
						arg_92_1:RecordAudio("104102026", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_104102", "104102026", "story_v_out_104102.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_104102", "104102026", "story_v_out_104102.awb")
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
	Play104102027 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 104102027
		arg_96_1.duration_ = 14.43

		local var_96_0 = {
			ja = 11.966,
			ko = 10.733,
			zh = 12.7,
			en = 14.433
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
				arg_96_0:Play104102028(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1032ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1032ui_story == nil then
				arg_96_1.var_.characterEffect1032ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1032ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1032ui_story then
				arg_96_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			local var_99_4 = 0

			if var_99_4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action8_1")
			end

			local var_99_5 = arg_96_1.actors_["1032ui_story"].transform
			local var_99_6 = 0

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.var_.moveOldPos1032ui_story = var_99_5.localPosition

				local var_99_7 = "1032ui_story"

				arg_96_1:ShowWeapon(arg_96_1.var_[var_99_7 .. "Animator"].transform, false)
			end

			local var_99_8 = 0.001

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_8 then
				local var_99_9 = (arg_96_1.time_ - var_99_6) / var_99_8
				local var_99_10 = Vector3.New(0, -1.05, -6.2)

				var_99_5.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1032ui_story, var_99_10, var_99_9)

				local var_99_11 = manager.ui.mainCamera.transform.position - var_99_5.position

				var_99_5.forward = Vector3.New(var_99_11.x, var_99_11.y, var_99_11.z)

				local var_99_12 = var_99_5.localEulerAngles

				var_99_12.z = 0
				var_99_12.x = 0
				var_99_5.localEulerAngles = var_99_12
			end

			if arg_96_1.time_ >= var_99_6 + var_99_8 and arg_96_1.time_ < var_99_6 + var_99_8 + arg_99_0 then
				var_99_5.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_99_13 = manager.ui.mainCamera.transform.position - var_99_5.position

				var_99_5.forward = Vector3.New(var_99_13.x, var_99_13.y, var_99_13.z)

				local var_99_14 = var_99_5.localEulerAngles

				var_99_14.z = 0
				var_99_14.x = 0
				var_99_5.localEulerAngles = var_99_14
			end

			local var_99_15 = arg_96_1.actors_["1037ui_story"].transform
			local var_99_16 = 0

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				arg_96_1.var_.moveOldPos1037ui_story = var_99_15.localPosition
			end

			local var_99_17 = 0.001

			if var_99_16 <= arg_96_1.time_ and arg_96_1.time_ < var_99_16 + var_99_17 then
				local var_99_18 = (arg_96_1.time_ - var_99_16) / var_99_17
				local var_99_19 = Vector3.New(0, 100, 0)

				var_99_15.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1037ui_story, var_99_19, var_99_18)

				local var_99_20 = manager.ui.mainCamera.transform.position - var_99_15.position

				var_99_15.forward = Vector3.New(var_99_20.x, var_99_20.y, var_99_20.z)

				local var_99_21 = var_99_15.localEulerAngles

				var_99_21.z = 0
				var_99_21.x = 0
				var_99_15.localEulerAngles = var_99_21
			end

			if arg_96_1.time_ >= var_99_16 + var_99_17 and arg_96_1.time_ < var_99_16 + var_99_17 + arg_99_0 then
				var_99_15.localPosition = Vector3.New(0, 100, 0)

				local var_99_22 = manager.ui.mainCamera.transform.position - var_99_15.position

				var_99_15.forward = Vector3.New(var_99_22.x, var_99_22.y, var_99_22.z)

				local var_99_23 = var_99_15.localEulerAngles

				var_99_23.z = 0
				var_99_23.x = 0
				var_99_15.localEulerAngles = var_99_23
			end

			local var_99_24 = 0

			if var_99_24 < arg_96_1.time_ and arg_96_1.time_ <= var_99_24 + arg_99_0 then
				arg_96_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_99_25 = 0
			local var_99_26 = 1.4

			if var_99_25 < arg_96_1.time_ and arg_96_1.time_ <= var_99_25 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_27 = arg_96_1:FormatText(StoryNameCfg[61].name)

				arg_96_1.leftNameTxt_.text = var_99_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_28 = arg_96_1:GetWordFromCfg(104102027)
				local var_99_29 = arg_96_1:FormatText(var_99_28.content)

				arg_96_1.text_.text = var_99_29

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_30 = 56
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

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102027", "story_v_out_104102.awb") ~= 0 then
					local var_99_33 = manager.audio:GetVoiceLength("story_v_out_104102", "104102027", "story_v_out_104102.awb") / 1000

					if var_99_33 + var_99_25 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_33 + var_99_25
					end

					if var_99_28.prefab_name ~= "" and arg_96_1.actors_[var_99_28.prefab_name] ~= nil then
						local var_99_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_28.prefab_name].transform, "story_v_out_104102", "104102027", "story_v_out_104102.awb")

						arg_96_1:RecordAudio("104102027", var_99_34)
						arg_96_1:RecordAudio("104102027", var_99_34)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_104102", "104102027", "story_v_out_104102.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_104102", "104102027", "story_v_out_104102.awb")
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
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play104102028 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 104102028
		arg_100_1.duration_ = 11.63

		local var_100_0 = {
			ja = 11.633,
			ko = 6,
			zh = 9.066,
			en = 7.3
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
				arg_100_0:Play104102029(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_103_1 = 0
			local var_103_2 = 0.875

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_3 = arg_100_1:FormatText(StoryNameCfg[61].name)

				arg_100_1.leftNameTxt_.text = var_103_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_4 = arg_100_1:GetWordFromCfg(104102028)
				local var_103_5 = arg_100_1:FormatText(var_103_4.content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_6 = 35
				local var_103_7 = utf8.len(var_103_5)
				local var_103_8 = var_103_6 <= 0 and var_103_2 or var_103_2 * (var_103_7 / var_103_6)

				if var_103_8 > 0 and var_103_2 < var_103_8 then
					arg_100_1.talkMaxDuration = var_103_8

					if var_103_8 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102028", "story_v_out_104102.awb") ~= 0 then
					local var_103_9 = manager.audio:GetVoiceLength("story_v_out_104102", "104102028", "story_v_out_104102.awb") / 1000

					if var_103_9 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_1
					end

					if var_103_4.prefab_name ~= "" and arg_100_1.actors_[var_103_4.prefab_name] ~= nil then
						local var_103_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_4.prefab_name].transform, "story_v_out_104102", "104102028", "story_v_out_104102.awb")

						arg_100_1:RecordAudio("104102028", var_103_10)
						arg_100_1:RecordAudio("104102028", var_103_10)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_104102", "104102028", "story_v_out_104102.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_104102", "104102028", "story_v_out_104102.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_11 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_11 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_11

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_11 and arg_100_1.time_ < var_103_1 + var_103_11 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play104102029 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 104102029
		arg_104_1.duration_ = 4.87

		local var_104_0 = {
			ja = 3.466,
			ko = 4.333,
			zh = 4.866,
			en = 4.733
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
				arg_104_0:Play104102030(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_107_1 = 0
			local var_107_2 = 0.475

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_3 = arg_104_1:FormatText(StoryNameCfg[61].name)

				arg_104_1.leftNameTxt_.text = var_107_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_4 = arg_104_1:GetWordFromCfg(104102029)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_6 = 19
				local var_107_7 = utf8.len(var_107_5)
				local var_107_8 = var_107_6 <= 0 and var_107_2 or var_107_2 * (var_107_7 / var_107_6)

				if var_107_8 > 0 and var_107_2 < var_107_8 then
					arg_104_1.talkMaxDuration = var_107_8

					if var_107_8 + var_107_1 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_1
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102029", "story_v_out_104102.awb") ~= 0 then
					local var_107_9 = manager.audio:GetVoiceLength("story_v_out_104102", "104102029", "story_v_out_104102.awb") / 1000

					if var_107_9 + var_107_1 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_1
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_out_104102", "104102029", "story_v_out_104102.awb")

						arg_104_1:RecordAudio("104102029", var_107_10)
						arg_104_1:RecordAudio("104102029", var_107_10)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_104102", "104102029", "story_v_out_104102.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_104102", "104102029", "story_v_out_104102.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_11 = math.max(var_107_2, arg_104_1.talkMaxDuration)

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_11 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_1) / var_107_11

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_1 + var_107_11 and arg_104_1.time_ < var_107_1 + var_107_11 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play104102030 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 104102030
		arg_108_1.duration_ = 6.53

		local var_108_0 = {
			ja = 6.533,
			ko = 5.1,
			zh = 4.666,
			en = 4.8
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
				arg_108_0:Play104102031(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1032ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1032ui_story = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(0, 100, 0)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1032ui_story, var_111_4, var_111_3)

				local var_111_5 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_5.x, var_111_5.y, var_111_5.z)

				local var_111_6 = var_111_0.localEulerAngles

				var_111_6.z = 0
				var_111_6.x = 0
				var_111_0.localEulerAngles = var_111_6
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0, 100, 0)

				local var_111_7 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_7.x, var_111_7.y, var_111_7.z)

				local var_111_8 = var_111_0.localEulerAngles

				var_111_8.z = 0
				var_111_8.x = 0
				var_111_0.localEulerAngles = var_111_8
			end

			local var_111_9 = 0
			local var_111_10 = 0.425

			if var_111_9 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_11 = arg_108_1:FormatText(StoryNameCfg[10].name)

				arg_108_1.leftNameTxt_.text = var_111_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_12 = arg_108_1:GetWordFromCfg(104102030)
				local var_111_13 = arg_108_1:FormatText(var_111_12.content)

				arg_108_1.text_.text = var_111_13

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_14 = 17
				local var_111_15 = utf8.len(var_111_13)
				local var_111_16 = var_111_14 <= 0 and var_111_10 or var_111_10 * (var_111_15 / var_111_14)

				if var_111_16 > 0 and var_111_10 < var_111_16 then
					arg_108_1.talkMaxDuration = var_111_16

					if var_111_16 + var_111_9 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_16 + var_111_9
					end
				end

				arg_108_1.text_.text = var_111_13
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102030", "story_v_out_104102.awb") ~= 0 then
					local var_111_17 = manager.audio:GetVoiceLength("story_v_out_104102", "104102030", "story_v_out_104102.awb") / 1000

					if var_111_17 + var_111_9 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_17 + var_111_9
					end

					if var_111_12.prefab_name ~= "" and arg_108_1.actors_[var_111_12.prefab_name] ~= nil then
						local var_111_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_12.prefab_name].transform, "story_v_out_104102", "104102030", "story_v_out_104102.awb")

						arg_108_1:RecordAudio("104102030", var_111_18)
						arg_108_1:RecordAudio("104102030", var_111_18)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_104102", "104102030", "story_v_out_104102.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_104102", "104102030", "story_v_out_104102.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_19 = math.max(var_111_10, arg_108_1.talkMaxDuration)

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_19 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_9) / var_111_19

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_9 + var_111_19 and arg_108_1.time_ < var_111_9 + var_111_19 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play104102031 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 104102031
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play104102032(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.15

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[7].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(104102031)
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
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_8 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_8 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_8

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_8 and arg_112_1.time_ < var_115_0 + var_115_8 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play104102032 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 104102032
		arg_116_1.duration_ = 8.87

		local var_116_0 = {
			ja = 8.866,
			ko = 5.766,
			zh = 7.233,
			en = 8.1
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
				arg_116_0:Play104102033(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.8

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[10].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:GetWordFromCfg(104102032)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102032", "story_v_out_104102.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_104102", "104102032", "story_v_out_104102.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_104102", "104102032", "story_v_out_104102.awb")

						arg_116_1:RecordAudio("104102032", var_119_9)
						arg_116_1:RecordAudio("104102032", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_104102", "104102032", "story_v_out_104102.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_104102", "104102032", "story_v_out_104102.awb")
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
	Play104102033 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 104102033
		arg_120_1.duration_ = 9.5

		local var_120_0 = {
			ja = 9.5,
			ko = 6.866,
			zh = 5.933,
			en = 7.233
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
				arg_120_0:Play104102034(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.725

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[10].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(104102033)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 29
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102033", "story_v_out_104102.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_104102", "104102033", "story_v_out_104102.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_104102", "104102033", "story_v_out_104102.awb")

						arg_120_1:RecordAudio("104102033", var_123_9)
						arg_120_1:RecordAudio("104102033", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_104102", "104102033", "story_v_out_104102.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_104102", "104102033", "story_v_out_104102.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play104102034 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 104102034
		arg_124_1.duration_ = 4.57

		local var_124_0 = {
			ja = 4.2,
			ko = 3.966,
			zh = 3.533,
			en = 4.566
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
				arg_124_0:Play104102035(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1037ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1037ui_story == nil then
				arg_124_1.var_.characterEffect1037ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.1

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect1037ui_story and not isNil(var_127_0) then
					arg_124_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1037ui_story then
				arg_124_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_127_4 = arg_124_1.actors_["1037ui_story"].transform
			local var_127_5 = 0

			if var_127_5 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 then
				arg_124_1.var_.moveOldPos1037ui_story = var_127_4.localPosition
			end

			local var_127_6 = 0.001

			if var_127_5 <= arg_124_1.time_ and arg_124_1.time_ < var_127_5 + var_127_6 then
				local var_127_7 = (arg_124_1.time_ - var_127_5) / var_127_6
				local var_127_8 = Vector3.New(0, -1.09, -5.81)

				var_127_4.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1037ui_story, var_127_8, var_127_7)

				local var_127_9 = manager.ui.mainCamera.transform.position - var_127_4.position

				var_127_4.forward = Vector3.New(var_127_9.x, var_127_9.y, var_127_9.z)

				local var_127_10 = var_127_4.localEulerAngles

				var_127_10.z = 0
				var_127_10.x = 0
				var_127_4.localEulerAngles = var_127_10
			end

			if arg_124_1.time_ >= var_127_5 + var_127_6 and arg_124_1.time_ < var_127_5 + var_127_6 + arg_127_0 then
				var_127_4.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_127_11 = manager.ui.mainCamera.transform.position - var_127_4.position

				var_127_4.forward = Vector3.New(var_127_11.x, var_127_11.y, var_127_11.z)

				local var_127_12 = var_127_4.localEulerAngles

				var_127_12.z = 0
				var_127_12.x = 0
				var_127_4.localEulerAngles = var_127_12
			end

			local var_127_13 = 0

			if var_127_13 < arg_124_1.time_ and arg_124_1.time_ <= var_127_13 + arg_127_0 then
				arg_124_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_127_14 = 0

			if var_127_14 < arg_124_1.time_ and arg_124_1.time_ <= var_127_14 + arg_127_0 then
				arg_124_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_127_15 = 0
			local var_127_16 = 0.425

			if var_127_15 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_17 = arg_124_1:FormatText(StoryNameCfg[15].name)

				arg_124_1.leftNameTxt_.text = var_127_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_18 = arg_124_1:GetWordFromCfg(104102034)
				local var_127_19 = arg_124_1:FormatText(var_127_18.content)

				arg_124_1.text_.text = var_127_19

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_20 = 16
				local var_127_21 = utf8.len(var_127_19)
				local var_127_22 = var_127_20 <= 0 and var_127_16 or var_127_16 * (var_127_21 / var_127_20)

				if var_127_22 > 0 and var_127_16 < var_127_22 then
					arg_124_1.talkMaxDuration = var_127_22

					if var_127_22 + var_127_15 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_22 + var_127_15
					end
				end

				arg_124_1.text_.text = var_127_19
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102034", "story_v_out_104102.awb") ~= 0 then
					local var_127_23 = manager.audio:GetVoiceLength("story_v_out_104102", "104102034", "story_v_out_104102.awb") / 1000

					if var_127_23 + var_127_15 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_23 + var_127_15
					end

					if var_127_18.prefab_name ~= "" and arg_124_1.actors_[var_127_18.prefab_name] ~= nil then
						local var_127_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_18.prefab_name].transform, "story_v_out_104102", "104102034", "story_v_out_104102.awb")

						arg_124_1:RecordAudio("104102034", var_127_24)
						arg_124_1:RecordAudio("104102034", var_127_24)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_104102", "104102034", "story_v_out_104102.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_104102", "104102034", "story_v_out_104102.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_25 = math.max(var_127_16, arg_124_1.talkMaxDuration)

			if var_127_15 <= arg_124_1.time_ and arg_124_1.time_ < var_127_15 + var_127_25 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_15) / var_127_25

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_15 + var_127_25 and arg_124_1.time_ < var_127_15 + var_127_25 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play104102035 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 104102035
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
			arg_128_1.auto_ = false
		end

		function arg_128_1.playNext_(arg_130_0)
			arg_128_1.onStoryFinished_()
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1037ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1037ui_story == nil then
				arg_128_1.var_.characterEffect1037ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.1

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1037ui_story and not isNil(var_131_0) then
					local var_131_4 = Mathf.Lerp(0, 0.5, var_131_3)

					arg_128_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1037ui_story.fillRatio = var_131_4
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1037ui_story then
				local var_131_5 = 0.5

				arg_128_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1037ui_story.fillRatio = var_131_5
			end

			local var_131_6 = 0
			local var_131_7 = 0.25

			if var_131_6 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_8 = arg_128_1:FormatText(StoryNameCfg[7].name)

				arg_128_1.leftNameTxt_.text = var_131_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_9 = arg_128_1:GetWordFromCfg(104102035)
				local var_131_10 = arg_128_1:FormatText(var_131_9.content)

				arg_128_1.text_.text = var_131_10

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_11 = 10
				local var_131_12 = utf8.len(var_131_10)
				local var_131_13 = var_131_11 <= 0 and var_131_7 or var_131_7 * (var_131_12 / var_131_11)

				if var_131_13 > 0 and var_131_7 < var_131_13 then
					arg_128_1.talkMaxDuration = var_131_13

					if var_131_13 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_13 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_10
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_14 and arg_128_1.time_ < var_131_6 + var_131_14 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play104102014 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 104102014
		arg_132_1.duration_ = 5.13

		local var_132_0 = {
			ja = 4.933,
			ko = 4,
			zh = 5.133,
			en = 4.466
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
				arg_132_0:Play104102015(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1032ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1032ui_story == nil then
				arg_132_1.var_.characterEffect1032ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.1

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1032ui_story and not isNil(var_135_0) then
					arg_132_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1032ui_story then
				arg_132_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			local var_135_4 = "1032ui_story"

			if arg_132_1.actors_[var_135_4] == nil then
				local var_135_5 = Asset.Load("Char/" .. "1032ui_story")

				if not isNil(var_135_5) then
					local var_135_6 = Object.Instantiate(Asset.Load("Char/" .. "1032ui_story"), arg_132_1.stage_.transform)

					var_135_6.name = var_135_4
					var_135_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_132_1.actors_[var_135_4] = var_135_6

					local var_135_7 = var_135_6:GetComponentInChildren(typeof(CharacterEffect))

					var_135_7.enabled = true

					local var_135_8 = GameObjectTools.GetOrAddComponent(var_135_6, typeof(DynamicBoneHelper))

					if var_135_8 then
						var_135_8:EnableDynamicBone(false)
					end

					arg_132_1:ShowWeapon(var_135_7.transform, false)

					arg_132_1.var_[var_135_4 .. "Animator"] = var_135_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_132_1.var_[var_135_4 .. "Animator"].applyRootMotion = true
					arg_132_1.var_[var_135_4 .. "LipSync"] = var_135_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 then
				arg_132_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_135_10 = "1032ui_story"

			if arg_132_1.actors_[var_135_10] == nil then
				local var_135_11 = Asset.Load("Char/" .. "1032ui_story")

				if not isNil(var_135_11) then
					local var_135_12 = Object.Instantiate(Asset.Load("Char/" .. "1032ui_story"), arg_132_1.stage_.transform)

					var_135_12.name = var_135_10
					var_135_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_132_1.actors_[var_135_10] = var_135_12

					local var_135_13 = var_135_12:GetComponentInChildren(typeof(CharacterEffect))

					var_135_13.enabled = true

					local var_135_14 = GameObjectTools.GetOrAddComponent(var_135_12, typeof(DynamicBoneHelper))

					if var_135_14 then
						var_135_14:EnableDynamicBone(false)
					end

					arg_132_1:ShowWeapon(var_135_13.transform, false)

					arg_132_1.var_[var_135_10 .. "Animator"] = var_135_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_132_1.var_[var_135_10 .. "Animator"].applyRootMotion = true
					arg_132_1.var_[var_135_10 .. "LipSync"] = var_135_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_135_15 = 0

			if var_135_15 < arg_132_1.time_ and arg_132_1.time_ <= var_135_15 + arg_135_0 then
				arg_132_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_135_16 = 0
			local var_135_17 = 0.4

			if var_135_16 < arg_132_1.time_ and arg_132_1.time_ <= var_135_16 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_18 = arg_132_1:FormatText(StoryNameCfg[61].name)

				arg_132_1.leftNameTxt_.text = var_135_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_19 = arg_132_1:GetWordFromCfg(104102014)
				local var_135_20 = arg_132_1:FormatText(var_135_19.content)

				arg_132_1.text_.text = var_135_20

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_21 = 16
				local var_135_22 = utf8.len(var_135_20)
				local var_135_23 = var_135_21 <= 0 and var_135_17 or var_135_17 * (var_135_22 / var_135_21)

				if var_135_23 > 0 and var_135_17 < var_135_23 then
					arg_132_1.talkMaxDuration = var_135_23

					if var_135_23 + var_135_16 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_23 + var_135_16
					end
				end

				arg_132_1.text_.text = var_135_20
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102014", "story_v_out_104102.awb") ~= 0 then
					local var_135_24 = manager.audio:GetVoiceLength("story_v_out_104102", "104102014", "story_v_out_104102.awb") / 1000

					if var_135_24 + var_135_16 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_24 + var_135_16
					end

					if var_135_19.prefab_name ~= "" and arg_132_1.actors_[var_135_19.prefab_name] ~= nil then
						local var_135_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_19.prefab_name].transform, "story_v_out_104102", "104102014", "story_v_out_104102.awb")

						arg_132_1:RecordAudio("104102014", var_135_25)
						arg_132_1:RecordAudio("104102014", var_135_25)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_104102", "104102014", "story_v_out_104102.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_104102", "104102014", "story_v_out_104102.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_26 = math.max(var_135_17, arg_132_1.talkMaxDuration)

			if var_135_16 <= arg_132_1.time_ and arg_132_1.time_ < var_135_16 + var_135_26 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_16) / var_135_26

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_16 + var_135_26 and arg_132_1.time_ < var_135_16 + var_135_26 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play104102015 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 104102015
		arg_136_1.duration_ = 2.47

		local var_136_0 = {
			ja = 1.999999999999,
			ko = 2.466,
			zh = 2.233,
			en = 1.999999999999
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
				arg_136_0:Play104102016(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1037ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1037ui_story == nil then
				arg_136_1.var_.characterEffect1037ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.1

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1037ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1037ui_story then
				arg_136_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_139_4 = 0

			if var_139_4 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_1")
			end

			local var_139_5 = arg_136_1.actors_["1032ui_story"]
			local var_139_6 = 0

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 and not isNil(var_139_5) and arg_136_1.var_.characterEffect1032ui_story == nil then
				arg_136_1.var_.characterEffect1032ui_story = var_139_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_7 = 0.1

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_7 and not isNil(var_139_5) then
				local var_139_8 = (arg_136_1.time_ - var_139_6) / var_139_7

				if arg_136_1.var_.characterEffect1032ui_story and not isNil(var_139_5) then
					local var_139_9 = Mathf.Lerp(0, 0.5, var_139_8)

					arg_136_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1032ui_story.fillRatio = var_139_9
				end
			end

			if arg_136_1.time_ >= var_139_6 + var_139_7 and arg_136_1.time_ < var_139_6 + var_139_7 + arg_139_0 and not isNil(var_139_5) and arg_136_1.var_.characterEffect1032ui_story then
				local var_139_10 = 0.5

				arg_136_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1032ui_story.fillRatio = var_139_10
			end

			local var_139_11 = 0

			if var_139_11 < arg_136_1.time_ and arg_136_1.time_ <= var_139_11 + arg_139_0 then
				arg_136_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_139_12 = 0
			local var_139_13 = 0.175

			if var_139_12 < arg_136_1.time_ and arg_136_1.time_ <= var_139_12 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_14 = arg_136_1:FormatText(StoryNameCfg[15].name)

				arg_136_1.leftNameTxt_.text = var_139_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_15 = arg_136_1:GetWordFromCfg(104102015)
				local var_139_16 = arg_136_1:FormatText(var_139_15.content)

				arg_136_1.text_.text = var_139_16

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_17 = 7
				local var_139_18 = utf8.len(var_139_16)
				local var_139_19 = var_139_17 <= 0 and var_139_13 or var_139_13 * (var_139_18 / var_139_17)

				if var_139_19 > 0 and var_139_13 < var_139_19 then
					arg_136_1.talkMaxDuration = var_139_19

					if var_139_19 + var_139_12 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_19 + var_139_12
					end
				end

				arg_136_1.text_.text = var_139_16
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102015", "story_v_out_104102.awb") ~= 0 then
					local var_139_20 = manager.audio:GetVoiceLength("story_v_out_104102", "104102015", "story_v_out_104102.awb") / 1000

					if var_139_20 + var_139_12 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_20 + var_139_12
					end

					if var_139_15.prefab_name ~= "" and arg_136_1.actors_[var_139_15.prefab_name] ~= nil then
						local var_139_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_15.prefab_name].transform, "story_v_out_104102", "104102015", "story_v_out_104102.awb")

						arg_136_1:RecordAudio("104102015", var_139_21)
						arg_136_1:RecordAudio("104102015", var_139_21)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_104102", "104102015", "story_v_out_104102.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_104102", "104102015", "story_v_out_104102.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_22 = math.max(var_139_13, arg_136_1.talkMaxDuration)

			if var_139_12 <= arg_136_1.time_ and arg_136_1.time_ < var_139_12 + var_139_22 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_12) / var_139_22

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_12 + var_139_22 and arg_136_1.time_ < var_139_12 + var_139_22 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play104102016 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 104102016
		arg_140_1.duration_ = 6.63

		local var_140_0 = {
			ja = 6.066,
			ko = 5.6,
			zh = 6.633,
			en = 6.5
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
				arg_140_0:Play104102017(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1037ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1037ui_story == nil then
				arg_140_1.var_.characterEffect1037ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.1

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1037ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1037ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1037ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1037ui_story.fillRatio = var_143_5
			end

			local var_143_6 = arg_140_1.actors_["1032ui_story"]
			local var_143_7 = 0

			if var_143_7 < arg_140_1.time_ and arg_140_1.time_ <= var_143_7 + arg_143_0 and not isNil(var_143_6) and arg_140_1.var_.characterEffect1032ui_story == nil then
				arg_140_1.var_.characterEffect1032ui_story = var_143_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_8 = 0.1

			if var_143_7 <= arg_140_1.time_ and arg_140_1.time_ < var_143_7 + var_143_8 and not isNil(var_143_6) then
				local var_143_9 = (arg_140_1.time_ - var_143_7) / var_143_8

				if arg_140_1.var_.characterEffect1032ui_story and not isNil(var_143_6) then
					arg_140_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_7 + var_143_8 and arg_140_1.time_ < var_143_7 + var_143_8 + arg_143_0 and not isNil(var_143_6) and arg_140_1.var_.characterEffect1032ui_story then
				arg_140_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			local var_143_10 = 0

			if var_143_10 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 then
				arg_140_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action9_1")
			end

			local var_143_11 = 0

			if var_143_11 < arg_140_1.time_ and arg_140_1.time_ <= var_143_11 + arg_143_0 then
				arg_140_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_143_12 = 0
			local var_143_13 = 0.775

			if var_143_12 < arg_140_1.time_ and arg_140_1.time_ <= var_143_12 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_14 = arg_140_1:FormatText(StoryNameCfg[61].name)

				arg_140_1.leftNameTxt_.text = var_143_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_15 = arg_140_1:GetWordFromCfg(104102016)
				local var_143_16 = arg_140_1:FormatText(var_143_15.content)

				arg_140_1.text_.text = var_143_16

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_17 = 31
				local var_143_18 = utf8.len(var_143_16)
				local var_143_19 = var_143_17 <= 0 and var_143_13 or var_143_13 * (var_143_18 / var_143_17)

				if var_143_19 > 0 and var_143_13 < var_143_19 then
					arg_140_1.talkMaxDuration = var_143_19

					if var_143_19 + var_143_12 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_19 + var_143_12
					end
				end

				arg_140_1.text_.text = var_143_16
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102016", "story_v_out_104102.awb") ~= 0 then
					local var_143_20 = manager.audio:GetVoiceLength("story_v_out_104102", "104102016", "story_v_out_104102.awb") / 1000

					if var_143_20 + var_143_12 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_20 + var_143_12
					end

					if var_143_15.prefab_name ~= "" and arg_140_1.actors_[var_143_15.prefab_name] ~= nil then
						local var_143_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_15.prefab_name].transform, "story_v_out_104102", "104102016", "story_v_out_104102.awb")

						arg_140_1:RecordAudio("104102016", var_143_21)
						arg_140_1:RecordAudio("104102016", var_143_21)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_104102", "104102016", "story_v_out_104102.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_104102", "104102016", "story_v_out_104102.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_22 = math.max(var_143_13, arg_140_1.talkMaxDuration)

			if var_143_12 <= arg_140_1.time_ and arg_140_1.time_ < var_143_12 + var_143_22 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_12) / var_143_22

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_12 + var_143_22 and arg_140_1.time_ < var_143_12 + var_143_22 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play104102017 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 104102017
		arg_144_1.duration_ = 9.17

		local var_144_0 = {
			ja = 9.166,
			ko = 5.4,
			zh = 8.6,
			en = 7.1
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
				arg_144_0:Play104102018(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_147_1 = 0
			local var_147_2 = 0.775

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_3 = arg_144_1:FormatText(StoryNameCfg[61].name)

				arg_144_1.leftNameTxt_.text = var_147_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_4 = arg_144_1:GetWordFromCfg(104102017)
				local var_147_5 = arg_144_1:FormatText(var_147_4.content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_6 = 30
				local var_147_7 = utf8.len(var_147_5)
				local var_147_8 = var_147_6 <= 0 and var_147_2 or var_147_2 * (var_147_7 / var_147_6)

				if var_147_8 > 0 and var_147_2 < var_147_8 then
					arg_144_1.talkMaxDuration = var_147_8

					if var_147_8 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_1
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104102", "104102017", "story_v_out_104102.awb") ~= 0 then
					local var_147_9 = manager.audio:GetVoiceLength("story_v_out_104102", "104102017", "story_v_out_104102.awb") / 1000

					if var_147_9 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_9 + var_147_1
					end

					if var_147_4.prefab_name ~= "" and arg_144_1.actors_[var_147_4.prefab_name] ~= nil then
						local var_147_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_4.prefab_name].transform, "story_v_out_104102", "104102017", "story_v_out_104102.awb")

						arg_144_1:RecordAudio("104102017", var_147_10)
						arg_144_1:RecordAudio("104102017", var_147_10)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_104102", "104102017", "story_v_out_104102.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_104102", "104102017", "story_v_out_104102.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_11 = math.max(var_147_2, arg_144_1.talkMaxDuration)

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_11 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_1) / var_147_11

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_1 + var_147_11 and arg_144_1.time_ < var_147_1 + var_147_11 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13"
	},
	voices = {
		"story_v_out_104102.awb"
	}
}
