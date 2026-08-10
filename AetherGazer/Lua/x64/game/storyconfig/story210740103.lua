return {
	Play1107403001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1107403001
		arg_1_1.duration_ = 7.08

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1107403002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 1.375

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "ST45"

			if arg_1_1.bgs_[var_4_2] == nil then
				local var_4_3 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)
				var_4_3.name = var_4_2
				var_4_3.transform.parent = arg_1_1.stage_.transform
				var_4_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_2] = var_4_3
			end

			local var_4_4 = 0

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_5 = manager.ui.mainCamera.transform.localPosition
				local var_4_6 = Vector3.New(0, 0, 10) + Vector3.New(var_4_5.x, var_4_5.y, 0)
				local var_4_7 = arg_1_1.bgs_.ST45

				var_4_7.transform.localPosition = var_4_6
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = (var_4_7.transform.localPosition - var_4_5).z
					local var_4_10 = manager.ui.mainCameraCom_
					local var_4_11 = 2 * var_4_9 * Mathf.Tan(var_4_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_12 = var_4_11 * var_4_10.aspect
					local var_4_13 = var_4_8.sprite.bounds.size.x
					local var_4_14 = var_4_8.sprite.bounds.size.y
					local var_4_15 = var_4_12 / var_4_13
					local var_4_16 = var_4_11 / var_4_14
					local var_4_17 = var_4_16 < var_4_15 and var_4_15 or var_4_16

					var_4_7.transform.localScale = Vector3.New(var_4_17, var_4_17, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST45" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 1.375

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

			local var_4_24 = 0
			local var_4_25 = 0.2

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.4
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 1.375
			local var_4_37 = 0.625

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[410].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(1107403001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 25
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403001", "story_v_side_new_1107403.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403001", "story_v_side_new_1107403.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_side_new_1107403", "1107403001", "story_v_side_new_1107403.awb")

						arg_1_1:RecordAudio("1107403001", var_4_46)
						arg_1_1:RecordAudio("1107403001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403001", "story_v_side_new_1107403.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403001", "story_v_side_new_1107403.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_36 + 0.3
			local var_4_48 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1107403002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1107403002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1107403003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1074ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1074ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1074ui_story"]
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1074ui_story == nil then
				arg_9_1.var_.characterEffect1074ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_7 = 0.1

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 and not isNil(var_12_5) then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7

				if arg_9_1.var_.characterEffect1074ui_story and not isNil(var_12_5) then
					local var_12_9 = Mathf.Lerp(0, 0.5, var_12_8)

					arg_9_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1074ui_story.fillRatio = var_12_9
				end
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1074ui_story then
				local var_12_10 = 0.5

				arg_9_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1074ui_story.fillRatio = var_12_10
			end

			local var_12_11 = 0
			local var_12_12 = 0.175

			if var_12_11 < arg_9_1.time_ and arg_9_1.time_ <= var_12_11 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_13 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_14 = arg_9_1:GetWordFromCfg(1107403002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_16 = 7
				local var_12_17 = utf8.len(var_12_15)
				local var_12_18 = var_12_16 <= 0 and var_12_12 or var_12_12 * (var_12_17 / var_12_16)

				if var_12_18 > 0 and var_12_12 < var_12_18 then
					arg_9_1.talkMaxDuration = var_12_18

					if var_12_18 + var_12_11 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_11
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_19 = math.max(var_12_12, arg_9_1.talkMaxDuration)

			if var_12_11 <= arg_9_1.time_ and arg_9_1.time_ < var_12_11 + var_12_19 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_11) / var_12_19

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_11 + var_12_19 and arg_9_1.time_ < var_12_11 + var_12_19 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1107403003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1107403003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1107403004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.75

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(1107403003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 30
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1107403004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1107403004
		arg_17_1.duration_ = 2.9

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1107403005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "10044ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "10044ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_17_1.stage_.transform)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

					var_20_3.enabled = true

					local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

					if var_20_4 then
						var_20_4:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_3.transform, false)

					arg_17_1.var_[var_20_0 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_0 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_0 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_5 = arg_17_1.actors_["10044ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos10044ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0, -0.72, -6.3)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10044ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["10044ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect10044ui_story == nil then
				arg_17_1.var_.characterEffect10044ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.1

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect10044ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect10044ui_story then
				arg_17_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action2_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_20 = 0.333333333333333
			local var_20_21 = 0.2

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_22 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_22:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_23 = arg_17_1:FormatText(StoryNameCfg[380].name)

				arg_17_1.leftNameTxt_.text = var_20_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_24 = arg_17_1:GetWordFromCfg(1107403004)
				local var_20_25 = arg_17_1:FormatText(var_20_24.content)

				arg_17_1.text_.text = var_20_25

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_26 = 8
				local var_20_27 = utf8.len(var_20_25)
				local var_20_28 = var_20_26 <= 0 and var_20_21 or var_20_21 * (var_20_27 / var_20_26)

				if var_20_28 > 0 and var_20_21 < var_20_28 then
					arg_17_1.talkMaxDuration = var_20_28
					var_20_20 = var_20_20 + 0.3

					if var_20_28 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_20
					end
				end

				arg_17_1.text_.text = var_20_25
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403004", "story_v_side_new_1107403.awb") ~= 0 then
					local var_20_29 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403004", "story_v_side_new_1107403.awb") / 1000

					if var_20_29 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_29 + var_20_20
					end

					if var_20_24.prefab_name ~= "" and arg_17_1.actors_[var_20_24.prefab_name] ~= nil then
						local var_20_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_24.prefab_name].transform, "story_v_side_new_1107403", "1107403004", "story_v_side_new_1107403.awb")

						arg_17_1:RecordAudio("1107403004", var_20_30)
						arg_17_1:RecordAudio("1107403004", var_20_30)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403004", "story_v_side_new_1107403.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403004", "story_v_side_new_1107403.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_31 = var_20_20 + 0.3
			local var_20_32 = math.max(var_20_21, arg_17_1.talkMaxDuration)

			if var_20_31 <= arg_17_1.time_ and arg_17_1.time_ < var_20_31 + var_20_32 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_31) / var_20_32

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_31 + var_20_32 and arg_17_1.time_ < var_20_31 + var_20_32 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
	Play1107403005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 1107403005
		arg_23_1.duration_ = 3.8

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play1107403006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action2_2")
			end

			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_26_2 = 0
			local var_26_3 = 0.525

			if var_26_2 < arg_23_1.time_ and arg_23_1.time_ <= var_26_2 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_4 = arg_23_1:FormatText(StoryNameCfg[380].name)

				arg_23_1.leftNameTxt_.text = var_26_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_5 = arg_23_1:GetWordFromCfg(1107403005)
				local var_26_6 = arg_23_1:FormatText(var_26_5.content)

				arg_23_1.text_.text = var_26_6

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_7 = 21
				local var_26_8 = utf8.len(var_26_6)
				local var_26_9 = var_26_7 <= 0 and var_26_3 or var_26_3 * (var_26_8 / var_26_7)

				if var_26_9 > 0 and var_26_3 < var_26_9 then
					arg_23_1.talkMaxDuration = var_26_9

					if var_26_9 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_9 + var_26_2
					end
				end

				arg_23_1.text_.text = var_26_6
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403005", "story_v_side_new_1107403.awb") ~= 0 then
					local var_26_10 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403005", "story_v_side_new_1107403.awb") / 1000

					if var_26_10 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_2
					end

					if var_26_5.prefab_name ~= "" and arg_23_1.actors_[var_26_5.prefab_name] ~= nil then
						local var_26_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_5.prefab_name].transform, "story_v_side_new_1107403", "1107403005", "story_v_side_new_1107403.awb")

						arg_23_1:RecordAudio("1107403005", var_26_11)
						arg_23_1:RecordAudio("1107403005", var_26_11)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403005", "story_v_side_new_1107403.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403005", "story_v_side_new_1107403.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_12 = math.max(var_26_3, arg_23_1.talkMaxDuration)

			if var_26_2 <= arg_23_1.time_ and arg_23_1.time_ < var_26_2 + var_26_12 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_2) / var_26_12

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_2 + var_26_12 and arg_23_1.time_ < var_26_2 + var_26_12 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play1107403006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 1107403006
		arg_27_1.duration_ = 2

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play1107403007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["10044ui_story"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos10044ui_story = var_30_0.localPosition
			end

			local var_30_2 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2
				local var_30_4 = Vector3.New(-0.7, -0.72, -6.3)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10044ui_story, var_30_4, var_30_3)

				local var_30_5 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_5.x, var_30_5.y, var_30_5.z)

				local var_30_6 = var_30_0.localEulerAngles

				var_30_6.z = 0
				var_30_6.x = 0
				var_30_0.localEulerAngles = var_30_6
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_30_7 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_7.x, var_30_7.y, var_30_7.z)

				local var_30_8 = var_30_0.localEulerAngles

				var_30_8.z = 0
				var_30_8.x = 0
				var_30_0.localEulerAngles = var_30_8
			end

			local var_30_9 = arg_27_1.actors_["10044ui_story"]
			local var_30_10 = 0

			if var_30_10 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.characterEffect10044ui_story == nil then
				arg_27_1.var_.characterEffect10044ui_story = var_30_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_11 = 0.1

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_11 and not isNil(var_30_9) then
				local var_30_12 = (arg_27_1.time_ - var_30_10) / var_30_11

				if arg_27_1.var_.characterEffect10044ui_story and not isNil(var_30_9) then
					local var_30_13 = Mathf.Lerp(0, 0.5, var_30_12)

					arg_27_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_27_1.var_.characterEffect10044ui_story.fillRatio = var_30_13
				end
			end

			if arg_27_1.time_ >= var_30_10 + var_30_11 and arg_27_1.time_ < var_30_10 + var_30_11 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.characterEffect10044ui_story then
				local var_30_14 = 0.5

				arg_27_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_27_1.var_.characterEffect10044ui_story.fillRatio = var_30_14
			end

			local var_30_15 = arg_27_1.actors_["1074ui_story"].transform
			local var_30_16 = 0

			if var_30_16 < arg_27_1.time_ and arg_27_1.time_ <= var_30_16 + arg_30_0 then
				arg_27_1.var_.moveOldPos1074ui_story = var_30_15.localPosition

				local var_30_17 = "1074ui_story"

				arg_27_1:ShowWeapon(arg_27_1.var_[var_30_17 .. "Animator"].transform, false)
			end

			local var_30_18 = 0.001

			if var_30_16 <= arg_27_1.time_ and arg_27_1.time_ < var_30_16 + var_30_18 then
				local var_30_19 = (arg_27_1.time_ - var_30_16) / var_30_18
				local var_30_20 = Vector3.New(0.7, -1.055, -6.12)

				var_30_15.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1074ui_story, var_30_20, var_30_19)

				local var_30_21 = manager.ui.mainCamera.transform.position - var_30_15.position

				var_30_15.forward = Vector3.New(var_30_21.x, var_30_21.y, var_30_21.z)

				local var_30_22 = var_30_15.localEulerAngles

				var_30_22.z = 0
				var_30_22.x = 0
				var_30_15.localEulerAngles = var_30_22
			end

			if arg_27_1.time_ >= var_30_16 + var_30_18 and arg_27_1.time_ < var_30_16 + var_30_18 + arg_30_0 then
				var_30_15.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_30_23 = manager.ui.mainCamera.transform.position - var_30_15.position

				var_30_15.forward = Vector3.New(var_30_23.x, var_30_23.y, var_30_23.z)

				local var_30_24 = var_30_15.localEulerAngles

				var_30_24.z = 0
				var_30_24.x = 0
				var_30_15.localEulerAngles = var_30_24
			end

			local var_30_25 = arg_27_1.actors_["1074ui_story"]
			local var_30_26 = 0

			if var_30_26 < arg_27_1.time_ and arg_27_1.time_ <= var_30_26 + arg_30_0 and not isNil(var_30_25) and arg_27_1.var_.characterEffect1074ui_story == nil then
				arg_27_1.var_.characterEffect1074ui_story = var_30_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_27 = 0.1

			if var_30_26 <= arg_27_1.time_ and arg_27_1.time_ < var_30_26 + var_30_27 and not isNil(var_30_25) then
				local var_30_28 = (arg_27_1.time_ - var_30_26) / var_30_27

				if arg_27_1.var_.characterEffect1074ui_story and not isNil(var_30_25) then
					arg_27_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_26 + var_30_27 and arg_27_1.time_ < var_30_26 + var_30_27 + arg_30_0 and not isNil(var_30_25) and arg_27_1.var_.characterEffect1074ui_story then
				arg_27_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_30_29 = 0

			if var_30_29 < arg_27_1.time_ and arg_27_1.time_ <= var_30_29 + arg_30_0 then
				arg_27_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			local var_30_30 = 0

			if var_30_30 < arg_27_1.time_ and arg_27_1.time_ <= var_30_30 + arg_30_0 then
				arg_27_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_30_31 = 0
			local var_30_32 = 0.1

			if var_30_31 < arg_27_1.time_ and arg_27_1.time_ <= var_30_31 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_33 = arg_27_1:FormatText(StoryNameCfg[410].name)

				arg_27_1.leftNameTxt_.text = var_30_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_34 = arg_27_1:GetWordFromCfg(1107403006)
				local var_30_35 = arg_27_1:FormatText(var_30_34.content)

				arg_27_1.text_.text = var_30_35

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_36 = 4
				local var_30_37 = utf8.len(var_30_35)
				local var_30_38 = var_30_36 <= 0 and var_30_32 or var_30_32 * (var_30_37 / var_30_36)

				if var_30_38 > 0 and var_30_32 < var_30_38 then
					arg_27_1.talkMaxDuration = var_30_38

					if var_30_38 + var_30_31 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_38 + var_30_31
					end
				end

				arg_27_1.text_.text = var_30_35
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403006", "story_v_side_new_1107403.awb") ~= 0 then
					local var_30_39 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403006", "story_v_side_new_1107403.awb") / 1000

					if var_30_39 + var_30_31 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_39 + var_30_31
					end

					if var_30_34.prefab_name ~= "" and arg_27_1.actors_[var_30_34.prefab_name] ~= nil then
						local var_30_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_34.prefab_name].transform, "story_v_side_new_1107403", "1107403006", "story_v_side_new_1107403.awb")

						arg_27_1:RecordAudio("1107403006", var_30_40)
						arg_27_1:RecordAudio("1107403006", var_30_40)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403006", "story_v_side_new_1107403.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403006", "story_v_side_new_1107403.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_41 = math.max(var_30_32, arg_27_1.talkMaxDuration)

			if var_30_31 <= arg_27_1.time_ and arg_27_1.time_ < var_30_31 + var_30_41 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_31) / var_30_41

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_31 + var_30_41 and arg_27_1.time_ < var_30_31 + var_30_41 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play1107403007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 1107403007
		arg_31_1.duration_ = 3.53

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play1107403008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["10044ui_story"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect10044ui_story == nil then
				arg_31_1.var_.characterEffect10044ui_story = var_34_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.1

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.characterEffect10044ui_story and not isNil(var_34_0) then
					arg_31_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect10044ui_story then
				arg_31_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_34_4 = arg_31_1.actors_["1074ui_story"]
			local var_34_5 = 0

			if var_34_5 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect1074ui_story == nil then
				arg_31_1.var_.characterEffect1074ui_story = var_34_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_6 = 0.1

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_6 and not isNil(var_34_4) then
				local var_34_7 = (arg_31_1.time_ - var_34_5) / var_34_6

				if arg_31_1.var_.characterEffect1074ui_story and not isNil(var_34_4) then
					local var_34_8 = Mathf.Lerp(0, 0.5, var_34_7)

					arg_31_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1074ui_story.fillRatio = var_34_8
				end
			end

			if arg_31_1.time_ >= var_34_5 + var_34_6 and arg_31_1.time_ < var_34_5 + var_34_6 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect1074ui_story then
				local var_34_9 = 0.5

				arg_31_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1074ui_story.fillRatio = var_34_9
			end

			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action4_1")
			end

			local var_34_11 = 0

			if var_34_11 < arg_31_1.time_ and arg_31_1.time_ <= var_34_11 + arg_34_0 then
				arg_31_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_34_12 = 0
			local var_34_13 = 0.275

			if var_34_12 < arg_31_1.time_ and arg_31_1.time_ <= var_34_12 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_14 = arg_31_1:FormatText(StoryNameCfg[380].name)

				arg_31_1.leftNameTxt_.text = var_34_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_15 = arg_31_1:GetWordFromCfg(1107403007)
				local var_34_16 = arg_31_1:FormatText(var_34_15.content)

				arg_31_1.text_.text = var_34_16

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_17 = 11
				local var_34_18 = utf8.len(var_34_16)
				local var_34_19 = var_34_17 <= 0 and var_34_13 or var_34_13 * (var_34_18 / var_34_17)

				if var_34_19 > 0 and var_34_13 < var_34_19 then
					arg_31_1.talkMaxDuration = var_34_19

					if var_34_19 + var_34_12 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_19 + var_34_12
					end
				end

				arg_31_1.text_.text = var_34_16
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403007", "story_v_side_new_1107403.awb") ~= 0 then
					local var_34_20 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403007", "story_v_side_new_1107403.awb") / 1000

					if var_34_20 + var_34_12 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_20 + var_34_12
					end

					if var_34_15.prefab_name ~= "" and arg_31_1.actors_[var_34_15.prefab_name] ~= nil then
						local var_34_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_15.prefab_name].transform, "story_v_side_new_1107403", "1107403007", "story_v_side_new_1107403.awb")

						arg_31_1:RecordAudio("1107403007", var_34_21)
						arg_31_1:RecordAudio("1107403007", var_34_21)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403007", "story_v_side_new_1107403.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403007", "story_v_side_new_1107403.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_22 = math.max(var_34_13, arg_31_1.talkMaxDuration)

			if var_34_12 <= arg_31_1.time_ and arg_31_1.time_ < var_34_12 + var_34_22 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_12) / var_34_22

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_12 + var_34_22 and arg_31_1.time_ < var_34_12 + var_34_22 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play1107403008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 1107403008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play1107403009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["10044ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect10044ui_story == nil then
				arg_35_1.var_.characterEffect10044ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.1

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect10044ui_story and not isNil(var_38_0) then
					local var_38_4 = Mathf.Lerp(0, 0.5, var_38_3)

					arg_35_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_35_1.var_.characterEffect10044ui_story.fillRatio = var_38_4
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect10044ui_story then
				local var_38_5 = 0.5

				arg_35_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_35_1.var_.characterEffect10044ui_story.fillRatio = var_38_5
			end

			local var_38_6 = 0
			local var_38_7 = 0.525

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_8 = arg_35_1:GetWordFromCfg(1107403008)
				local var_38_9 = arg_35_1:FormatText(var_38_8.content)

				arg_35_1.text_.text = var_38_9

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_10 = 21
				local var_38_11 = utf8.len(var_38_9)
				local var_38_12 = var_38_10 <= 0 and var_38_7 or var_38_7 * (var_38_11 / var_38_10)

				if var_38_12 > 0 and var_38_7 < var_38_12 then
					arg_35_1.talkMaxDuration = var_38_12

					if var_38_12 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_12 + var_38_6
					end
				end

				arg_35_1.text_.text = var_38_9
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_13 = math.max(var_38_7, arg_35_1.talkMaxDuration)

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_13 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_6) / var_38_13

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_6 + var_38_13 and arg_35_1.time_ < var_38_6 + var_38_13 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play1107403009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 1107403009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play1107403010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.725

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[7].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:GetWordFromCfg(1107403009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 29
				local var_42_6 = utf8.len(var_42_4)
				local var_42_7 = var_42_5 <= 0 and var_42_1 or var_42_1 * (var_42_6 / var_42_5)

				if var_42_7 > 0 and var_42_1 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_8 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_8 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_8

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_8 and arg_39_1.time_ < var_42_0 + var_42_8 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play1107403010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1107403010
		arg_43_1.duration_ = 4.3

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play1107403011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1074ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1074ui_story == nil then
				arg_43_1.var_.characterEffect1074ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.1

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect1074ui_story and not isNil(var_46_0) then
					arg_43_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1074ui_story then
				arg_43_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_46_4 = 0
			local var_46_5 = 0.625

			if var_46_4 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_6 = arg_43_1:FormatText(StoryNameCfg[410].name)

				arg_43_1.leftNameTxt_.text = var_46_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_7 = arg_43_1:GetWordFromCfg(1107403010)
				local var_46_8 = arg_43_1:FormatText(var_46_7.content)

				arg_43_1.text_.text = var_46_8

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 25
				local var_46_10 = utf8.len(var_46_8)
				local var_46_11 = var_46_9 <= 0 and var_46_5 or var_46_5 * (var_46_10 / var_46_9)

				if var_46_11 > 0 and var_46_5 < var_46_11 then
					arg_43_1.talkMaxDuration = var_46_11

					if var_46_11 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_11 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_8
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403010", "story_v_side_new_1107403.awb") ~= 0 then
					local var_46_12 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403010", "story_v_side_new_1107403.awb") / 1000

					if var_46_12 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_12 + var_46_4
					end

					if var_46_7.prefab_name ~= "" and arg_43_1.actors_[var_46_7.prefab_name] ~= nil then
						local var_46_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_7.prefab_name].transform, "story_v_side_new_1107403", "1107403010", "story_v_side_new_1107403.awb")

						arg_43_1:RecordAudio("1107403010", var_46_13)
						arg_43_1:RecordAudio("1107403010", var_46_13)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403010", "story_v_side_new_1107403.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403010", "story_v_side_new_1107403.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_14 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_14 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_14

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_14 and arg_43_1.time_ < var_46_4 + var_46_14 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play1107403011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1107403011
		arg_47_1.duration_ = 2.6

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1107403012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10044ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect10044ui_story == nil then
				arg_47_1.var_.characterEffect10044ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.1

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect10044ui_story and not isNil(var_50_0) then
					arg_47_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect10044ui_story then
				arg_47_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_50_4 = arg_47_1.actors_["1074ui_story"]
			local var_50_5 = 0

			if var_50_5 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1074ui_story == nil then
				arg_47_1.var_.characterEffect1074ui_story = var_50_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_6 = 0.1

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_6 and not isNil(var_50_4) then
				local var_50_7 = (arg_47_1.time_ - var_50_5) / var_50_6

				if arg_47_1.var_.characterEffect1074ui_story and not isNil(var_50_4) then
					local var_50_8 = Mathf.Lerp(0, 0.5, var_50_7)

					arg_47_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1074ui_story.fillRatio = var_50_8
				end
			end

			if arg_47_1.time_ >= var_50_5 + var_50_6 and arg_47_1.time_ < var_50_5 + var_50_6 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1074ui_story then
				local var_50_9 = 0.5

				arg_47_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1074ui_story.fillRatio = var_50_9
			end

			local var_50_10 = 0

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 then
				arg_47_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action4_2")
			end

			local var_50_11 = 0

			if var_50_11 < arg_47_1.time_ and arg_47_1.time_ <= var_50_11 + arg_50_0 then
				arg_47_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_50_12 = 0
			local var_50_13 = 0.3

			if var_50_12 < arg_47_1.time_ and arg_47_1.time_ <= var_50_12 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_14 = arg_47_1:FormatText(StoryNameCfg[380].name)

				arg_47_1.leftNameTxt_.text = var_50_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_15 = arg_47_1:GetWordFromCfg(1107403011)
				local var_50_16 = arg_47_1:FormatText(var_50_15.content)

				arg_47_1.text_.text = var_50_16

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_17 = 12
				local var_50_18 = utf8.len(var_50_16)
				local var_50_19 = var_50_17 <= 0 and var_50_13 or var_50_13 * (var_50_18 / var_50_17)

				if var_50_19 > 0 and var_50_13 < var_50_19 then
					arg_47_1.talkMaxDuration = var_50_19

					if var_50_19 + var_50_12 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_19 + var_50_12
					end
				end

				arg_47_1.text_.text = var_50_16
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403011", "story_v_side_new_1107403.awb") ~= 0 then
					local var_50_20 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403011", "story_v_side_new_1107403.awb") / 1000

					if var_50_20 + var_50_12 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_20 + var_50_12
					end

					if var_50_15.prefab_name ~= "" and arg_47_1.actors_[var_50_15.prefab_name] ~= nil then
						local var_50_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_15.prefab_name].transform, "story_v_side_new_1107403", "1107403011", "story_v_side_new_1107403.awb")

						arg_47_1:RecordAudio("1107403011", var_50_21)
						arg_47_1:RecordAudio("1107403011", var_50_21)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403011", "story_v_side_new_1107403.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403011", "story_v_side_new_1107403.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_22 = math.max(var_50_13, arg_47_1.talkMaxDuration)

			if var_50_12 <= arg_47_1.time_ and arg_47_1.time_ < var_50_12 + var_50_22 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_12) / var_50_22

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_12 + var_50_22 and arg_47_1.time_ < var_50_12 + var_50_22 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play1107403012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1107403012
		arg_51_1.duration_ = 2

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1107403013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1074ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1074ui_story == nil then
				arg_51_1.var_.characterEffect1074ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.1

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect1074ui_story and not isNil(var_54_0) then
					arg_51_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1074ui_story then
				arg_51_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_54_4 = arg_51_1.actors_["10044ui_story"]
			local var_54_5 = 0

			if var_54_5 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.characterEffect10044ui_story == nil then
				arg_51_1.var_.characterEffect10044ui_story = var_54_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_6 = 0.1

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_6 and not isNil(var_54_4) then
				local var_54_7 = (arg_51_1.time_ - var_54_5) / var_54_6

				if arg_51_1.var_.characterEffect10044ui_story and not isNil(var_54_4) then
					local var_54_8 = Mathf.Lerp(0, 0.5, var_54_7)

					arg_51_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_51_1.var_.characterEffect10044ui_story.fillRatio = var_54_8
				end
			end

			if arg_51_1.time_ >= var_54_5 + var_54_6 and arg_51_1.time_ < var_54_5 + var_54_6 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.characterEffect10044ui_story then
				local var_54_9 = 0.5

				arg_51_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_51_1.var_.characterEffect10044ui_story.fillRatio = var_54_9
			end

			local var_54_10 = 0

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 then
				arg_51_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_2")
			end

			local var_54_11 = 0
			local var_54_12 = 0.2

			if var_54_11 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_13 = arg_51_1:FormatText(StoryNameCfg[410].name)

				arg_51_1.leftNameTxt_.text = var_54_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_14 = arg_51_1:GetWordFromCfg(1107403012)
				local var_54_15 = arg_51_1:FormatText(var_54_14.content)

				arg_51_1.text_.text = var_54_15

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_16 = 8
				local var_54_17 = utf8.len(var_54_15)
				local var_54_18 = var_54_16 <= 0 and var_54_12 or var_54_12 * (var_54_17 / var_54_16)

				if var_54_18 > 0 and var_54_12 < var_54_18 then
					arg_51_1.talkMaxDuration = var_54_18

					if var_54_18 + var_54_11 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_18 + var_54_11
					end
				end

				arg_51_1.text_.text = var_54_15
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403012", "story_v_side_new_1107403.awb") ~= 0 then
					local var_54_19 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403012", "story_v_side_new_1107403.awb") / 1000

					if var_54_19 + var_54_11 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_19 + var_54_11
					end

					if var_54_14.prefab_name ~= "" and arg_51_1.actors_[var_54_14.prefab_name] ~= nil then
						local var_54_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_14.prefab_name].transform, "story_v_side_new_1107403", "1107403012", "story_v_side_new_1107403.awb")

						arg_51_1:RecordAudio("1107403012", var_54_20)
						arg_51_1:RecordAudio("1107403012", var_54_20)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403012", "story_v_side_new_1107403.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403012", "story_v_side_new_1107403.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_21 = math.max(var_54_12, arg_51_1.talkMaxDuration)

			if var_54_11 <= arg_51_1.time_ and arg_51_1.time_ < var_54_11 + var_54_21 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_11) / var_54_21

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_11 + var_54_21 and arg_51_1.time_ < var_54_11 + var_54_21 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1107403013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1107403013
		arg_55_1.duration_ = 4.1

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1107403014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["10044ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect10044ui_story == nil then
				arg_55_1.var_.characterEffect10044ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.1

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect10044ui_story and not isNil(var_58_0) then
					arg_55_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect10044ui_story then
				arg_55_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_58_4 = arg_55_1.actors_["1074ui_story"]
			local var_58_5 = 0

			if var_58_5 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 and not isNil(var_58_4) and arg_55_1.var_.characterEffect1074ui_story == nil then
				arg_55_1.var_.characterEffect1074ui_story = var_58_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_6 = 0.1

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_6 and not isNil(var_58_4) then
				local var_58_7 = (arg_55_1.time_ - var_58_5) / var_58_6

				if arg_55_1.var_.characterEffect1074ui_story and not isNil(var_58_4) then
					local var_58_8 = Mathf.Lerp(0, 0.5, var_58_7)

					arg_55_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1074ui_story.fillRatio = var_58_8
				end
			end

			if arg_55_1.time_ >= var_58_5 + var_58_6 and arg_55_1.time_ < var_58_5 + var_58_6 + arg_58_0 and not isNil(var_58_4) and arg_55_1.var_.characterEffect1074ui_story then
				local var_58_9 = 0.5

				arg_55_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1074ui_story.fillRatio = var_58_9
			end

			local var_58_10 = 0
			local var_58_11 = 0.5

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_12 = arg_55_1:FormatText(StoryNameCfg[380].name)

				arg_55_1.leftNameTxt_.text = var_58_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_13 = arg_55_1:GetWordFromCfg(1107403013)
				local var_58_14 = arg_55_1:FormatText(var_58_13.content)

				arg_55_1.text_.text = var_58_14

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_15 = 20
				local var_58_16 = utf8.len(var_58_14)
				local var_58_17 = var_58_15 <= 0 and var_58_11 or var_58_11 * (var_58_16 / var_58_15)

				if var_58_17 > 0 and var_58_11 < var_58_17 then
					arg_55_1.talkMaxDuration = var_58_17

					if var_58_17 + var_58_10 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_17 + var_58_10
					end
				end

				arg_55_1.text_.text = var_58_14
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403013", "story_v_side_new_1107403.awb") ~= 0 then
					local var_58_18 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403013", "story_v_side_new_1107403.awb") / 1000

					if var_58_18 + var_58_10 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_18 + var_58_10
					end

					if var_58_13.prefab_name ~= "" and arg_55_1.actors_[var_58_13.prefab_name] ~= nil then
						local var_58_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_13.prefab_name].transform, "story_v_side_new_1107403", "1107403013", "story_v_side_new_1107403.awb")

						arg_55_1:RecordAudio("1107403013", var_58_19)
						arg_55_1:RecordAudio("1107403013", var_58_19)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403013", "story_v_side_new_1107403.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403013", "story_v_side_new_1107403.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_20 = math.max(var_58_11, arg_55_1.talkMaxDuration)

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_20 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_10) / var_58_20

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_10 + var_58_20 and arg_55_1.time_ < var_58_10 + var_58_20 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1107403014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1107403014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1107403015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["10044ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect10044ui_story == nil then
				arg_59_1.var_.characterEffect10044ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.0166666666666667

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect10044ui_story and not isNil(var_62_0) then
					local var_62_4 = Mathf.Lerp(0, 0.5, var_62_3)

					arg_59_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10044ui_story.fillRatio = var_62_4
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect10044ui_story then
				local var_62_5 = 0.5

				arg_59_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10044ui_story.fillRatio = var_62_5
			end

			local var_62_6 = 0
			local var_62_7 = 0.825

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

				local var_62_9 = arg_59_1:GetWordFromCfg(1107403014)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 33
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
	Play1107403015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1107403015
		arg_63_1.duration_ = 1.9

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1107403016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["10044ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10044ui_story == nil then
				arg_63_1.var_.characterEffect10044ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.1

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect10044ui_story and not isNil(var_66_0) then
					arg_63_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10044ui_story then
				arg_63_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_66_4 = 0
			local var_66_5 = 0.15

			if var_66_4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_6 = arg_63_1:FormatText(StoryNameCfg[380].name)

				arg_63_1.leftNameTxt_.text = var_66_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_7 = arg_63_1:GetWordFromCfg(1107403015)
				local var_66_8 = arg_63_1:FormatText(var_66_7.content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 6
				local var_66_10 = utf8.len(var_66_8)
				local var_66_11 = var_66_9 <= 0 and var_66_5 or var_66_5 * (var_66_10 / var_66_9)

				if var_66_11 > 0 and var_66_5 < var_66_11 then
					arg_63_1.talkMaxDuration = var_66_11

					if var_66_11 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403015", "story_v_side_new_1107403.awb") ~= 0 then
					local var_66_12 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403015", "story_v_side_new_1107403.awb") / 1000

					if var_66_12 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_12 + var_66_4
					end

					if var_66_7.prefab_name ~= "" and arg_63_1.actors_[var_66_7.prefab_name] ~= nil then
						local var_66_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_7.prefab_name].transform, "story_v_side_new_1107403", "1107403015", "story_v_side_new_1107403.awb")

						arg_63_1:RecordAudio("1107403015", var_66_13)
						arg_63_1:RecordAudio("1107403015", var_66_13)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403015", "story_v_side_new_1107403.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403015", "story_v_side_new_1107403.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_14 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_14 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_14

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_14 and arg_63_1.time_ < var_66_4 + var_66_14 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1107403016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1107403016
		arg_67_1.duration_ = 8

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1107403017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_70_1 = 0
			local var_70_2 = 1.05

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_3 = arg_67_1:FormatText(StoryNameCfg[380].name)

				arg_67_1.leftNameTxt_.text = var_70_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:GetWordFromCfg(1107403016)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_6 = 42
				local var_70_7 = utf8.len(var_70_5)
				local var_70_8 = var_70_6 <= 0 and var_70_2 or var_70_2 * (var_70_7 / var_70_6)

				if var_70_8 > 0 and var_70_2 < var_70_8 then
					arg_67_1.talkMaxDuration = var_70_8

					if var_70_8 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403016", "story_v_side_new_1107403.awb") ~= 0 then
					local var_70_9 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403016", "story_v_side_new_1107403.awb") / 1000

					if var_70_9 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_1
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_side_new_1107403", "1107403016", "story_v_side_new_1107403.awb")

						arg_67_1:RecordAudio("1107403016", var_70_10)
						arg_67_1:RecordAudio("1107403016", var_70_10)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403016", "story_v_side_new_1107403.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403016", "story_v_side_new_1107403.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_11 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_11 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_11

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_11 and arg_67_1.time_ < var_70_1 + var_70_11 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1107403017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1107403017
		arg_71_1.duration_ = 2.4

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1107403018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.3

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[380].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(1107403017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403017", "story_v_side_new_1107403.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403017", "story_v_side_new_1107403.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_side_new_1107403", "1107403017", "story_v_side_new_1107403.awb")

						arg_71_1:RecordAudio("1107403017", var_74_9)
						arg_71_1:RecordAudio("1107403017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403017", "story_v_side_new_1107403.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403017", "story_v_side_new_1107403.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play1107403018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1107403018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1107403019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10044ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect10044ui_story == nil then
				arg_75_1.var_.characterEffect10044ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.1

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect10044ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10044ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect10044ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10044ui_story.fillRatio = var_78_5
			end

			local var_78_6 = 0
			local var_78_7 = 1.075

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_8 = arg_75_1:GetWordFromCfg(1107403018)
				local var_78_9 = arg_75_1:FormatText(var_78_8.content)

				arg_75_1.text_.text = var_78_9

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 43
				local var_78_11 = utf8.len(var_78_9)
				local var_78_12 = var_78_10 <= 0 and var_78_7 or var_78_7 * (var_78_11 / var_78_10)

				if var_78_12 > 0 and var_78_7 < var_78_12 then
					arg_75_1.talkMaxDuration = var_78_12

					if var_78_12 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_12 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_9
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_13 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_13 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_13

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_13 and arg_75_1.time_ < var_78_6 + var_78_13 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1107403019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1107403019
		arg_79_1.duration_ = 5.07

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1107403020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1074ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1074ui_story == nil then
				arg_79_1.var_.characterEffect1074ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.1

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1074ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1074ui_story then
				arg_79_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_82_4 = 0

			if var_82_4 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_82_5 = 0
			local var_82_6 = 0.4

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_7 = arg_79_1:FormatText(StoryNameCfg[410].name)

				arg_79_1.leftNameTxt_.text = var_82_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_8 = arg_79_1:GetWordFromCfg(1107403019)
				local var_82_9 = arg_79_1:FormatText(var_82_8.content)

				arg_79_1.text_.text = var_82_9

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_10 = 16
				local var_82_11 = utf8.len(var_82_9)
				local var_82_12 = var_82_10 <= 0 and var_82_6 or var_82_6 * (var_82_11 / var_82_10)

				if var_82_12 > 0 and var_82_6 < var_82_12 then
					arg_79_1.talkMaxDuration = var_82_12

					if var_82_12 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_9
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403019", "story_v_side_new_1107403.awb") ~= 0 then
					local var_82_13 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403019", "story_v_side_new_1107403.awb") / 1000

					if var_82_13 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_5
					end

					if var_82_8.prefab_name ~= "" and arg_79_1.actors_[var_82_8.prefab_name] ~= nil then
						local var_82_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_8.prefab_name].transform, "story_v_side_new_1107403", "1107403019", "story_v_side_new_1107403.awb")

						arg_79_1:RecordAudio("1107403019", var_82_14)
						arg_79_1:RecordAudio("1107403019", var_82_14)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403019", "story_v_side_new_1107403.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403019", "story_v_side_new_1107403.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_15 = math.max(var_82_6, arg_79_1.talkMaxDuration)

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_15 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_5) / var_82_15

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_5 + var_82_15 and arg_79_1.time_ < var_82_5 + var_82_15 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1107403020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1107403020
		arg_83_1.duration_ = 2

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1107403021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10044ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect10044ui_story == nil then
				arg_83_1.var_.characterEffect10044ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.1

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect10044ui_story and not isNil(var_86_0) then
					arg_83_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect10044ui_story then
				arg_83_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_86_4 = arg_83_1.actors_["1074ui_story"]
			local var_86_5 = 0

			if var_86_5 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 and not isNil(var_86_4) and arg_83_1.var_.characterEffect1074ui_story == nil then
				arg_83_1.var_.characterEffect1074ui_story = var_86_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_6 = 0.1

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_6 and not isNil(var_86_4) then
				local var_86_7 = (arg_83_1.time_ - var_86_5) / var_86_6

				if arg_83_1.var_.characterEffect1074ui_story and not isNil(var_86_4) then
					local var_86_8 = Mathf.Lerp(0, 0.5, var_86_7)

					arg_83_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1074ui_story.fillRatio = var_86_8
				end
			end

			if arg_83_1.time_ >= var_86_5 + var_86_6 and arg_83_1.time_ < var_86_5 + var_86_6 + arg_86_0 and not isNil(var_86_4) and arg_83_1.var_.characterEffect1074ui_story then
				local var_86_9 = 0.5

				arg_83_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1074ui_story.fillRatio = var_86_9
			end

			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 then
				arg_83_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action435")
			end

			local var_86_11 = 0

			if var_86_11 < arg_83_1.time_ and arg_83_1.time_ <= var_86_11 + arg_86_0 then
				arg_83_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_86_12 = 0
			local var_86_13 = 0.225

			if var_86_12 < arg_83_1.time_ and arg_83_1.time_ <= var_86_12 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_14 = arg_83_1:FormatText(StoryNameCfg[380].name)

				arg_83_1.leftNameTxt_.text = var_86_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_15 = arg_83_1:GetWordFromCfg(1107403020)
				local var_86_16 = arg_83_1:FormatText(var_86_15.content)

				arg_83_1.text_.text = var_86_16

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_17 = 9
				local var_86_18 = utf8.len(var_86_16)
				local var_86_19 = var_86_17 <= 0 and var_86_13 or var_86_13 * (var_86_18 / var_86_17)

				if var_86_19 > 0 and var_86_13 < var_86_19 then
					arg_83_1.talkMaxDuration = var_86_19

					if var_86_19 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_19 + var_86_12
					end
				end

				arg_83_1.text_.text = var_86_16
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403020", "story_v_side_new_1107403.awb") ~= 0 then
					local var_86_20 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403020", "story_v_side_new_1107403.awb") / 1000

					if var_86_20 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_20 + var_86_12
					end

					if var_86_15.prefab_name ~= "" and arg_83_1.actors_[var_86_15.prefab_name] ~= nil then
						local var_86_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_15.prefab_name].transform, "story_v_side_new_1107403", "1107403020", "story_v_side_new_1107403.awb")

						arg_83_1:RecordAudio("1107403020", var_86_21)
						arg_83_1:RecordAudio("1107403020", var_86_21)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403020", "story_v_side_new_1107403.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403020", "story_v_side_new_1107403.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_22 = math.max(var_86_13, arg_83_1.talkMaxDuration)

			if var_86_12 <= arg_83_1.time_ and arg_83_1.time_ < var_86_12 + var_86_22 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_12) / var_86_22

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_12 + var_86_22 and arg_83_1.time_ < var_86_12 + var_86_22 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1107403021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1107403021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1107403022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10044ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect10044ui_story == nil then
				arg_87_1.var_.characterEffect10044ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.1

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect10044ui_story and not isNil(var_90_0) then
					local var_90_4 = Mathf.Lerp(0, 0.5, var_90_3)

					arg_87_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10044ui_story.fillRatio = var_90_4
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect10044ui_story then
				local var_90_5 = 0.5

				arg_87_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10044ui_story.fillRatio = var_90_5
			end

			local var_90_6 = 0
			local var_90_7 = 0.6

			if var_90_6 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_8 = arg_87_1:GetWordFromCfg(1107403021)
				local var_90_9 = arg_87_1:FormatText(var_90_8.content)

				arg_87_1.text_.text = var_90_9

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_10 = 24
				local var_90_11 = utf8.len(var_90_9)
				local var_90_12 = var_90_10 <= 0 and var_90_7 or var_90_7 * (var_90_11 / var_90_10)

				if var_90_12 > 0 and var_90_7 < var_90_12 then
					arg_87_1.talkMaxDuration = var_90_12

					if var_90_12 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_12 + var_90_6
					end
				end

				arg_87_1.text_.text = var_90_9
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_13 = math.max(var_90_7, arg_87_1.talkMaxDuration)

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_13 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_6) / var_90_13

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_6 + var_90_13 and arg_87_1.time_ < var_90_6 + var_90_13 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play1107403022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1107403022
		arg_91_1.duration_ = 2

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1107403023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10044ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect10044ui_story == nil then
				arg_91_1.var_.characterEffect10044ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.1

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect10044ui_story and not isNil(var_94_0) then
					arg_91_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect10044ui_story then
				arg_91_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_94_4 = 0

			if var_94_4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_2")
			end

			local var_94_5 = 0

			if var_94_5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_94_6 = 0
			local var_94_7 = 0.225

			if var_94_6 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_8 = arg_91_1:FormatText(StoryNameCfg[380].name)

				arg_91_1.leftNameTxt_.text = var_94_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_9 = arg_91_1:GetWordFromCfg(1107403022)
				local var_94_10 = arg_91_1:FormatText(var_94_9.content)

				arg_91_1.text_.text = var_94_10

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 9
				local var_94_12 = utf8.len(var_94_10)
				local var_94_13 = var_94_11 <= 0 and var_94_7 or var_94_7 * (var_94_12 / var_94_11)

				if var_94_13 > 0 and var_94_7 < var_94_13 then
					arg_91_1.talkMaxDuration = var_94_13

					if var_94_13 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_13 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_10
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403022", "story_v_side_new_1107403.awb") ~= 0 then
					local var_94_14 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403022", "story_v_side_new_1107403.awb") / 1000

					if var_94_14 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_14 + var_94_6
					end

					if var_94_9.prefab_name ~= "" and arg_91_1.actors_[var_94_9.prefab_name] ~= nil then
						local var_94_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_9.prefab_name].transform, "story_v_side_new_1107403", "1107403022", "story_v_side_new_1107403.awb")

						arg_91_1:RecordAudio("1107403022", var_94_15)
						arg_91_1:RecordAudio("1107403022", var_94_15)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403022", "story_v_side_new_1107403.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403022", "story_v_side_new_1107403.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_16 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_16 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_16

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_16 and arg_91_1.time_ < var_94_6 + var_94_16 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1107403023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1107403023
		arg_95_1.duration_ = 6.83

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1107403024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = "STblack"

			if arg_95_1.bgs_[var_98_0] == nil then
				local var_98_1 = Object.Instantiate(arg_95_1.paintGo_)

				var_98_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_98_0)
				var_98_1.name = var_98_0
				var_98_1.transform.parent = arg_95_1.stage_.transform
				var_98_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.bgs_[var_98_0] = var_98_1
			end

			local var_98_2 = 1

			if var_98_2 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				local var_98_3 = manager.ui.mainCamera.transform.localPosition
				local var_98_4 = Vector3.New(0, 0, 10) + Vector3.New(var_98_3.x, var_98_3.y, 0)
				local var_98_5 = arg_95_1.bgs_.STblack

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
					if iter_98_0 ~= "STblack" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_16 = 1

			if var_98_16 < arg_95_1.time_ and arg_95_1.time_ <= var_98_16 + arg_98_0 then
				arg_95_1.allBtn_.enabled = false
			end

			local var_98_17 = 0.666666666666667

			if arg_95_1.time_ >= var_98_16 + var_98_17 and arg_95_1.time_ < var_98_16 + var_98_17 + arg_98_0 then
				arg_95_1.allBtn_.enabled = true
			end

			local var_98_18 = 0

			if var_98_18 < arg_95_1.time_ and arg_95_1.time_ <= var_98_18 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_19 = 1

			if var_98_18 <= arg_95_1.time_ and arg_95_1.time_ < var_98_18 + var_98_19 then
				local var_98_20 = (arg_95_1.time_ - var_98_18) / var_98_19
				local var_98_21 = Color.New(0, 0, 0)

				var_98_21.a = Mathf.Lerp(0, 1, var_98_20)
				arg_95_1.mask_.color = var_98_21
			end

			if arg_95_1.time_ >= var_98_18 + var_98_19 and arg_95_1.time_ < var_98_18 + var_98_19 + arg_98_0 then
				local var_98_22 = Color.New(0, 0, 0)

				var_98_22.a = 1
				arg_95_1.mask_.color = var_98_22
			end

			local var_98_23 = 1

			if var_98_23 < arg_95_1.time_ and arg_95_1.time_ <= var_98_23 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_24 = 1

			if var_98_23 <= arg_95_1.time_ and arg_95_1.time_ < var_98_23 + var_98_24 then
				local var_98_25 = (arg_95_1.time_ - var_98_23) / var_98_24
				local var_98_26 = Color.New(0, 0, 0)

				var_98_26.a = Mathf.Lerp(1, 0, var_98_25)
				arg_95_1.mask_.color = var_98_26
			end

			if arg_95_1.time_ >= var_98_23 + var_98_24 and arg_95_1.time_ < var_98_23 + var_98_24 + arg_98_0 then
				local var_98_27 = Color.New(0, 0, 0)
				local var_98_28 = 0

				arg_95_1.mask_.enabled = false
				var_98_27.a = var_98_28
				arg_95_1.mask_.color = var_98_27
			end

			local var_98_29 = arg_95_1.actors_["1074ui_story"].transform
			local var_98_30 = 0.966

			if var_98_30 < arg_95_1.time_ and arg_95_1.time_ <= var_98_30 + arg_98_0 then
				arg_95_1.var_.moveOldPos1074ui_story = var_98_29.localPosition

				local var_98_31 = "1074ui_story"

				arg_95_1:ShowWeapon(arg_95_1.var_[var_98_31 .. "Animator"].transform, false)
			end

			local var_98_32 = 0.001

			if var_98_30 <= arg_95_1.time_ and arg_95_1.time_ < var_98_30 + var_98_32 then
				local var_98_33 = (arg_95_1.time_ - var_98_30) / var_98_32
				local var_98_34 = Vector3.New(0, 100, 0)

				var_98_29.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1074ui_story, var_98_34, var_98_33)

				local var_98_35 = manager.ui.mainCamera.transform.position - var_98_29.position

				var_98_29.forward = Vector3.New(var_98_35.x, var_98_35.y, var_98_35.z)

				local var_98_36 = var_98_29.localEulerAngles

				var_98_36.z = 0
				var_98_36.x = 0
				var_98_29.localEulerAngles = var_98_36
			end

			if arg_95_1.time_ >= var_98_30 + var_98_32 and arg_95_1.time_ < var_98_30 + var_98_32 + arg_98_0 then
				var_98_29.localPosition = Vector3.New(0, 100, 0)

				local var_98_37 = manager.ui.mainCamera.transform.position - var_98_29.position

				var_98_29.forward = Vector3.New(var_98_37.x, var_98_37.y, var_98_37.z)

				local var_98_38 = var_98_29.localEulerAngles

				var_98_38.z = 0
				var_98_38.x = 0
				var_98_29.localEulerAngles = var_98_38
			end

			local var_98_39 = arg_95_1.actors_["10044ui_story"].transform
			local var_98_40 = 0.966

			if var_98_40 < arg_95_1.time_ and arg_95_1.time_ <= var_98_40 + arg_98_0 then
				arg_95_1.var_.moveOldPos10044ui_story = var_98_39.localPosition

				local var_98_41 = "10044ui_story"

				arg_95_1:ShowWeapon(arg_95_1.var_[var_98_41 .. "Animator"].transform, false)
			end

			local var_98_42 = 0.001

			if var_98_40 <= arg_95_1.time_ and arg_95_1.time_ < var_98_40 + var_98_42 then
				local var_98_43 = (arg_95_1.time_ - var_98_40) / var_98_42
				local var_98_44 = Vector3.New(0, 100, 0)

				var_98_39.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10044ui_story, var_98_44, var_98_43)

				local var_98_45 = manager.ui.mainCamera.transform.position - var_98_39.position

				var_98_39.forward = Vector3.New(var_98_45.x, var_98_45.y, var_98_45.z)

				local var_98_46 = var_98_39.localEulerAngles

				var_98_46.z = 0
				var_98_46.x = 0
				var_98_39.localEulerAngles = var_98_46
			end

			if arg_95_1.time_ >= var_98_40 + var_98_42 and arg_95_1.time_ < var_98_40 + var_98_42 + arg_98_0 then
				var_98_39.localPosition = Vector3.New(0, 100, 0)

				local var_98_47 = manager.ui.mainCamera.transform.position - var_98_39.position

				var_98_39.forward = Vector3.New(var_98_47.x, var_98_47.y, var_98_47.z)

				local var_98_48 = var_98_39.localEulerAngles

				var_98_48.z = 0
				var_98_48.x = 0
				var_98_39.localEulerAngles = var_98_48
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_49 = 1.83333333333333
			local var_98_50 = 0.575

			if var_98_49 < arg_95_1.time_ and arg_95_1.time_ <= var_98_49 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_51 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_51:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_52 = arg_95_1:GetWordFromCfg(1107403023)
				local var_98_53 = arg_95_1:FormatText(var_98_52.content)

				arg_95_1.text_.text = var_98_53

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_54 = 23
				local var_98_55 = utf8.len(var_98_53)
				local var_98_56 = var_98_54 <= 0 and var_98_50 or var_98_50 * (var_98_55 / var_98_54)

				if var_98_56 > 0 and var_98_50 < var_98_56 then
					arg_95_1.talkMaxDuration = var_98_56
					var_98_49 = var_98_49 + 0.3

					if var_98_56 + var_98_49 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_56 + var_98_49
					end
				end

				arg_95_1.text_.text = var_98_53
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_57 = var_98_49 + 0.3
			local var_98_58 = math.max(var_98_50, arg_95_1.talkMaxDuration)

			if var_98_57 <= arg_95_1.time_ and arg_95_1.time_ < var_98_57 + var_98_58 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_57) / var_98_58

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_57 + var_98_58 and arg_95_1.time_ < var_98_57 + var_98_58 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play1107403024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1107403024
		arg_101_1.duration_ = 6.2

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1107403025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = "ST47"

			if arg_101_1.bgs_[var_104_0] == nil then
				local var_104_1 = Object.Instantiate(arg_101_1.paintGo_)

				var_104_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_104_0)
				var_104_1.name = var_104_0
				var_104_1.transform.parent = arg_101_1.stage_.transform
				var_104_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.bgs_[var_104_0] = var_104_1
			end

			local var_104_2 = 0

			if var_104_2 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				local var_104_3 = manager.ui.mainCamera.transform.localPosition
				local var_104_4 = Vector3.New(0, 0, 10) + Vector3.New(var_104_3.x, var_104_3.y, 0)
				local var_104_5 = arg_101_1.bgs_.ST47

				var_104_5.transform.localPosition = var_104_4
				var_104_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_6 = var_104_5:GetComponent("SpriteRenderer")

				if var_104_6 and var_104_6.sprite then
					local var_104_7 = (var_104_5.transform.localPosition - var_104_3).z
					local var_104_8 = manager.ui.mainCameraCom_
					local var_104_9 = 2 * var_104_7 * Mathf.Tan(var_104_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_104_10 = var_104_9 * var_104_8.aspect
					local var_104_11 = var_104_6.sprite.bounds.size.x
					local var_104_12 = var_104_6.sprite.bounds.size.y
					local var_104_13 = var_104_10 / var_104_11
					local var_104_14 = var_104_9 / var_104_12
					local var_104_15 = var_104_14 < var_104_13 and var_104_13 or var_104_14

					var_104_5.transform.localScale = Vector3.New(var_104_15, var_104_15, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "ST47" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			local var_104_17 = 1.2

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			local var_104_18 = 0

			if var_104_18 < arg_101_1.time_ and arg_101_1.time_ <= var_104_18 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_19 = 1.2

			if var_104_18 <= arg_101_1.time_ and arg_101_1.time_ < var_104_18 + var_104_19 then
				local var_104_20 = (arg_101_1.time_ - var_104_18) / var_104_19
				local var_104_21 = Color.New(0, 0, 0)

				var_104_21.a = Mathf.Lerp(1, 0, var_104_20)
				arg_101_1.mask_.color = var_104_21
			end

			if arg_101_1.time_ >= var_104_18 + var_104_19 and arg_101_1.time_ < var_104_18 + var_104_19 + arg_104_0 then
				local var_104_22 = Color.New(0, 0, 0)
				local var_104_23 = 0

				arg_101_1.mask_.enabled = false
				var_104_22.a = var_104_23
				arg_101_1.mask_.color = var_104_22
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_24 = 1.2
			local var_104_25 = 0.35

			if var_104_24 < arg_101_1.time_ and arg_101_1.time_ <= var_104_24 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_26 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_26:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_27 = arg_101_1:FormatText(StoryNameCfg[7].name)

				arg_101_1.leftNameTxt_.text = var_104_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_28 = arg_101_1:GetWordFromCfg(1107403024)
				local var_104_29 = arg_101_1:FormatText(var_104_28.content)

				arg_101_1.text_.text = var_104_29

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_30 = 14
				local var_104_31 = utf8.len(var_104_29)
				local var_104_32 = var_104_30 <= 0 and var_104_25 or var_104_25 * (var_104_31 / var_104_30)

				if var_104_32 > 0 and var_104_25 < var_104_32 then
					arg_101_1.talkMaxDuration = var_104_32
					var_104_24 = var_104_24 + 0.3

					if var_104_32 + var_104_24 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_32 + var_104_24
					end
				end

				arg_101_1.text_.text = var_104_29
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_33 = var_104_24 + 0.3
			local var_104_34 = math.max(var_104_25, arg_101_1.talkMaxDuration)

			if var_104_33 <= arg_101_1.time_ and arg_101_1.time_ < var_104_33 + var_104_34 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_33) / var_104_34

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_33 + var_104_34 and arg_101_1.time_ < var_104_33 + var_104_34 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1107403025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1107403025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1107403026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_110_2 = arg_107_1.actors_["10044ui_story"]
			local var_110_3 = 0

			if var_110_3 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.characterEffect10044ui_story == nil then
				arg_107_1.var_.characterEffect10044ui_story = var_110_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_4 = 0.1

			if var_110_3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_3 + var_110_4 and not isNil(var_110_2) then
				local var_110_5 = (arg_107_1.time_ - var_110_3) / var_110_4

				if arg_107_1.var_.characterEffect10044ui_story and not isNil(var_110_2) then
					arg_107_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_3 + var_110_4 and arg_107_1.time_ < var_110_3 + var_110_4 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.characterEffect10044ui_story then
				arg_107_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_110_6 = arg_107_1.actors_["10044ui_story"].transform
			local var_110_7 = 0

			if var_110_7 < arg_107_1.time_ and arg_107_1.time_ <= var_110_7 + arg_110_0 then
				arg_107_1.var_.moveOldPos10044ui_story = var_110_6.localPosition
			end

			local var_110_8 = 0.001

			if var_110_7 <= arg_107_1.time_ and arg_107_1.time_ < var_110_7 + var_110_8 then
				local var_110_9 = (arg_107_1.time_ - var_110_7) / var_110_8
				local var_110_10 = Vector3.New(-0.7, -0.72, -6.3)

				var_110_6.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10044ui_story, var_110_10, var_110_9)

				local var_110_11 = manager.ui.mainCamera.transform.position - var_110_6.position

				var_110_6.forward = Vector3.New(var_110_11.x, var_110_11.y, var_110_11.z)

				local var_110_12 = var_110_6.localEulerAngles

				var_110_12.z = 0
				var_110_12.x = 0
				var_110_6.localEulerAngles = var_110_12
			end

			if arg_107_1.time_ >= var_110_7 + var_110_8 and arg_107_1.time_ < var_110_7 + var_110_8 + arg_110_0 then
				var_110_6.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_110_13 = manager.ui.mainCamera.transform.position - var_110_6.position

				var_110_6.forward = Vector3.New(var_110_13.x, var_110_13.y, var_110_13.z)

				local var_110_14 = var_110_6.localEulerAngles

				var_110_14.z = 0
				var_110_14.x = 0
				var_110_6.localEulerAngles = var_110_14
			end

			local var_110_15 = 0
			local var_110_16 = 0.4

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_17 = arg_107_1:FormatText(StoryNameCfg[380].name)

				arg_107_1.leftNameTxt_.text = var_110_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_18 = arg_107_1:GetWordFromCfg(1107403025)
				local var_110_19 = arg_107_1:FormatText(var_110_18.content)

				arg_107_1.text_.text = var_110_19

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_20 = 16
				local var_110_21 = utf8.len(var_110_19)
				local var_110_22 = var_110_20 <= 0 and var_110_16 or var_110_16 * (var_110_21 / var_110_20)

				if var_110_22 > 0 and var_110_16 < var_110_22 then
					arg_107_1.talkMaxDuration = var_110_22

					if var_110_22 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_22 + var_110_15
					end
				end

				arg_107_1.text_.text = var_110_19
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403025", "story_v_side_new_1107403.awb") ~= 0 then
					local var_110_23 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403025", "story_v_side_new_1107403.awb") / 1000

					if var_110_23 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_23 + var_110_15
					end

					if var_110_18.prefab_name ~= "" and arg_107_1.actors_[var_110_18.prefab_name] ~= nil then
						local var_110_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_18.prefab_name].transform, "story_v_side_new_1107403", "1107403025", "story_v_side_new_1107403.awb")

						arg_107_1:RecordAudio("1107403025", var_110_24)
						arg_107_1:RecordAudio("1107403025", var_110_24)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403025", "story_v_side_new_1107403.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403025", "story_v_side_new_1107403.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_25 = math.max(var_110_16, arg_107_1.talkMaxDuration)

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_25 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_15) / var_110_25

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_15 + var_110_25 and arg_107_1.time_ < var_110_15 + var_110_25 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
	Play1107403026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1107403026
		arg_111_1.duration_ = 12.77

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1107403027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10044ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10044ui_story == nil then
				arg_111_1.var_.characterEffect10044ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.1

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect10044ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10044ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10044ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10044ui_story.fillRatio = var_114_5
			end

			local var_114_6 = arg_111_1.actors_["1074ui_story"].transform
			local var_114_7 = 0

			if var_114_7 < arg_111_1.time_ and arg_111_1.time_ <= var_114_7 + arg_114_0 then
				arg_111_1.var_.moveOldPos1074ui_story = var_114_6.localPosition

				local var_114_8 = "1074ui_story"

				arg_111_1:ShowWeapon(arg_111_1.var_[var_114_8 .. "Animator"].transform, false)
			end

			local var_114_9 = 0.001

			if var_114_7 <= arg_111_1.time_ and arg_111_1.time_ < var_114_7 + var_114_9 then
				local var_114_10 = (arg_111_1.time_ - var_114_7) / var_114_9
				local var_114_11 = Vector3.New(0.7, -1.055, -6.12)

				var_114_6.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1074ui_story, var_114_11, var_114_10)

				local var_114_12 = manager.ui.mainCamera.transform.position - var_114_6.position

				var_114_6.forward = Vector3.New(var_114_12.x, var_114_12.y, var_114_12.z)

				local var_114_13 = var_114_6.localEulerAngles

				var_114_13.z = 0
				var_114_13.x = 0
				var_114_6.localEulerAngles = var_114_13
			end

			if arg_111_1.time_ >= var_114_7 + var_114_9 and arg_111_1.time_ < var_114_7 + var_114_9 + arg_114_0 then
				var_114_6.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_114_14 = manager.ui.mainCamera.transform.position - var_114_6.position

				var_114_6.forward = Vector3.New(var_114_14.x, var_114_14.y, var_114_14.z)

				local var_114_15 = var_114_6.localEulerAngles

				var_114_15.z = 0
				var_114_15.x = 0
				var_114_6.localEulerAngles = var_114_15
			end

			local var_114_16 = arg_111_1.actors_["1074ui_story"]
			local var_114_17 = 0

			if var_114_17 < arg_111_1.time_ and arg_111_1.time_ <= var_114_17 + arg_114_0 and not isNil(var_114_16) and arg_111_1.var_.characterEffect1074ui_story == nil then
				arg_111_1.var_.characterEffect1074ui_story = var_114_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_18 = 0.1

			if var_114_17 <= arg_111_1.time_ and arg_111_1.time_ < var_114_17 + var_114_18 and not isNil(var_114_16) then
				local var_114_19 = (arg_111_1.time_ - var_114_17) / var_114_18

				if arg_111_1.var_.characterEffect1074ui_story and not isNil(var_114_16) then
					arg_111_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_17 + var_114_18 and arg_111_1.time_ < var_114_17 + var_114_18 + arg_114_0 and not isNil(var_114_16) and arg_111_1.var_.characterEffect1074ui_story then
				arg_111_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_114_20 = 0

			if var_114_20 < arg_111_1.time_ and arg_111_1.time_ <= var_114_20 + arg_114_0 then
				arg_111_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_114_21 = 0

			if var_114_21 < arg_111_1.time_ and arg_111_1.time_ <= var_114_21 + arg_114_0 then
				arg_111_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_114_22 = 0
			local var_114_23 = 1.375

			if var_114_22 < arg_111_1.time_ and arg_111_1.time_ <= var_114_22 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_24 = arg_111_1:FormatText(StoryNameCfg[410].name)

				arg_111_1.leftNameTxt_.text = var_114_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_25 = arg_111_1:GetWordFromCfg(1107403026)
				local var_114_26 = arg_111_1:FormatText(var_114_25.content)

				arg_111_1.text_.text = var_114_26

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_27 = 55
				local var_114_28 = utf8.len(var_114_26)
				local var_114_29 = var_114_27 <= 0 and var_114_23 or var_114_23 * (var_114_28 / var_114_27)

				if var_114_29 > 0 and var_114_23 < var_114_29 then
					arg_111_1.talkMaxDuration = var_114_29

					if var_114_29 + var_114_22 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_29 + var_114_22
					end
				end

				arg_111_1.text_.text = var_114_26
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403026", "story_v_side_new_1107403.awb") ~= 0 then
					local var_114_30 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403026", "story_v_side_new_1107403.awb") / 1000

					if var_114_30 + var_114_22 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_30 + var_114_22
					end

					if var_114_25.prefab_name ~= "" and arg_111_1.actors_[var_114_25.prefab_name] ~= nil then
						local var_114_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_25.prefab_name].transform, "story_v_side_new_1107403", "1107403026", "story_v_side_new_1107403.awb")

						arg_111_1:RecordAudio("1107403026", var_114_31)
						arg_111_1:RecordAudio("1107403026", var_114_31)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403026", "story_v_side_new_1107403.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403026", "story_v_side_new_1107403.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_32 = math.max(var_114_23, arg_111_1.talkMaxDuration)

			if var_114_22 <= arg_111_1.time_ and arg_111_1.time_ < var_114_22 + var_114_32 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_22) / var_114_32

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_22 + var_114_32 and arg_111_1.time_ < var_114_22 + var_114_32 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play1107403027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1107403027
		arg_115_1.duration_ = 2

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1107403028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1074ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1074ui_story == nil then
				arg_115_1.var_.characterEffect1074ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.1

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1074ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1074ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1074ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1074ui_story.fillRatio = var_118_5
			end

			local var_118_6 = arg_115_1.actors_["10044ui_story"]
			local var_118_7 = 0

			if var_118_7 < arg_115_1.time_ and arg_115_1.time_ <= var_118_7 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect10044ui_story == nil then
				arg_115_1.var_.characterEffect10044ui_story = var_118_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.1

			if var_118_7 <= arg_115_1.time_ and arg_115_1.time_ < var_118_7 + var_118_8 and not isNil(var_118_6) then
				local var_118_9 = (arg_115_1.time_ - var_118_7) / var_118_8

				if arg_115_1.var_.characterEffect10044ui_story and not isNil(var_118_6) then
					arg_115_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_7 + var_118_8 and arg_115_1.time_ < var_118_7 + var_118_8 + arg_118_0 and not isNil(var_118_6) and arg_115_1.var_.characterEffect10044ui_story then
				arg_115_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 then
				arg_115_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action4_1")
			end

			local var_118_11 = 0

			if var_118_11 < arg_115_1.time_ and arg_115_1.time_ <= var_118_11 + arg_118_0 then
				arg_115_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_118_12 = 0
			local var_118_13 = 0.075

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_14 = arg_115_1:FormatText(StoryNameCfg[380].name)

				arg_115_1.leftNameTxt_.text = var_118_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_15 = arg_115_1:GetWordFromCfg(1107403027)
				local var_118_16 = arg_115_1:FormatText(var_118_15.content)

				arg_115_1.text_.text = var_118_16

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_17 = 3
				local var_118_18 = utf8.len(var_118_16)
				local var_118_19 = var_118_17 <= 0 and var_118_13 or var_118_13 * (var_118_18 / var_118_17)

				if var_118_19 > 0 and var_118_13 < var_118_19 then
					arg_115_1.talkMaxDuration = var_118_19

					if var_118_19 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_19 + var_118_12
					end
				end

				arg_115_1.text_.text = var_118_16
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403027", "story_v_side_new_1107403.awb") ~= 0 then
					local var_118_20 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403027", "story_v_side_new_1107403.awb") / 1000

					if var_118_20 + var_118_12 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_12
					end

					if var_118_15.prefab_name ~= "" and arg_115_1.actors_[var_118_15.prefab_name] ~= nil then
						local var_118_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_15.prefab_name].transform, "story_v_side_new_1107403", "1107403027", "story_v_side_new_1107403.awb")

						arg_115_1:RecordAudio("1107403027", var_118_21)
						arg_115_1:RecordAudio("1107403027", var_118_21)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403027", "story_v_side_new_1107403.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403027", "story_v_side_new_1107403.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_22 = math.max(var_118_13, arg_115_1.talkMaxDuration)

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_22 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_12) / var_118_22

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_12 + var_118_22 and arg_115_1.time_ < var_118_12 + var_118_22 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play1107403028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1107403028
		arg_119_1.duration_ = 5.97

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1107403029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10044ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10044ui_story == nil then
				arg_119_1.var_.characterEffect10044ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.1

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect10044ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10044ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10044ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10044ui_story.fillRatio = var_122_5
			end

			local var_122_6 = arg_119_1.actors_["1074ui_story"]
			local var_122_7 = 0

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1074ui_story == nil then
				arg_119_1.var_.characterEffect1074ui_story = var_122_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_8 = 0.1

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_8 and not isNil(var_122_6) then
				local var_122_9 = (arg_119_1.time_ - var_122_7) / var_122_8

				if arg_119_1.var_.characterEffect1074ui_story and not isNil(var_122_6) then
					arg_119_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_7 + var_122_8 and arg_119_1.time_ < var_122_7 + var_122_8 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1074ui_story then
				arg_119_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_122_11 = 0
			local var_122_12 = 0.725

			if var_122_11 < arg_119_1.time_ and arg_119_1.time_ <= var_122_11 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_13 = arg_119_1:FormatText(StoryNameCfg[410].name)

				arg_119_1.leftNameTxt_.text = var_122_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_14 = arg_119_1:GetWordFromCfg(1107403028)
				local var_122_15 = arg_119_1:FormatText(var_122_14.content)

				arg_119_1.text_.text = var_122_15

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_16 = 29
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

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403028", "story_v_side_new_1107403.awb") ~= 0 then
					local var_122_19 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403028", "story_v_side_new_1107403.awb") / 1000

					if var_122_19 + var_122_11 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_19 + var_122_11
					end

					if var_122_14.prefab_name ~= "" and arg_119_1.actors_[var_122_14.prefab_name] ~= nil then
						local var_122_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_14.prefab_name].transform, "story_v_side_new_1107403", "1107403028", "story_v_side_new_1107403.awb")

						arg_119_1:RecordAudio("1107403028", var_122_20)
						arg_119_1:RecordAudio("1107403028", var_122_20)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403028", "story_v_side_new_1107403.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403028", "story_v_side_new_1107403.awb")
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
	Play1107403029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1107403029
		arg_123_1.duration_ = 2

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1107403030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			local var_126_1 = 0
			local var_126_2 = 0.2

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_3 = arg_123_1:FormatText(StoryNameCfg[410].name)

				arg_123_1.leftNameTxt_.text = var_126_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_4 = arg_123_1:GetWordFromCfg(1107403029)
				local var_126_5 = arg_123_1:FormatText(var_126_4.content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_6 = 8
				local var_126_7 = utf8.len(var_126_5)
				local var_126_8 = var_126_6 <= 0 and var_126_2 or var_126_2 * (var_126_7 / var_126_6)

				if var_126_8 > 0 and var_126_2 < var_126_8 then
					arg_123_1.talkMaxDuration = var_126_8

					if var_126_8 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403029", "story_v_side_new_1107403.awb") ~= 0 then
					local var_126_9 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403029", "story_v_side_new_1107403.awb") / 1000

					if var_126_9 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_1
					end

					if var_126_4.prefab_name ~= "" and arg_123_1.actors_[var_126_4.prefab_name] ~= nil then
						local var_126_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_4.prefab_name].transform, "story_v_side_new_1107403", "1107403029", "story_v_side_new_1107403.awb")

						arg_123_1:RecordAudio("1107403029", var_126_10)
						arg_123_1:RecordAudio("1107403029", var_126_10)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403029", "story_v_side_new_1107403.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403029", "story_v_side_new_1107403.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_11 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_11 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_11

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_11 and arg_123_1.time_ < var_126_1 + var_126_11 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1107403030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1107403030
		arg_127_1.duration_ = 2

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1107403031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1074ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1074ui_story == nil then
				arg_127_1.var_.characterEffect1074ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.1

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1074ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1074ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1074ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1074ui_story.fillRatio = var_130_5
			end

			local var_130_6 = arg_127_1.actors_["10044ui_story"]
			local var_130_7 = 0

			if var_130_7 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect10044ui_story == nil then
				arg_127_1.var_.characterEffect10044ui_story = var_130_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_8 = 0.1

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_8 and not isNil(var_130_6) then
				local var_130_9 = (arg_127_1.time_ - var_130_7) / var_130_8

				if arg_127_1.var_.characterEffect10044ui_story and not isNil(var_130_6) then
					arg_127_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_7 + var_130_8 and arg_127_1.time_ < var_130_7 + var_130_8 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect10044ui_story then
				arg_127_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				arg_127_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action4_2")
			end

			local var_130_11 = 0

			if var_130_11 < arg_127_1.time_ and arg_127_1.time_ <= var_130_11 + arg_130_0 then
				arg_127_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_130_12 = 0
			local var_130_13 = 0.175

			if var_130_12 < arg_127_1.time_ and arg_127_1.time_ <= var_130_12 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_14 = arg_127_1:FormatText(StoryNameCfg[380].name)

				arg_127_1.leftNameTxt_.text = var_130_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_15 = arg_127_1:GetWordFromCfg(1107403030)
				local var_130_16 = arg_127_1:FormatText(var_130_15.content)

				arg_127_1.text_.text = var_130_16

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_17 = 7
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

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403030", "story_v_side_new_1107403.awb") ~= 0 then
					local var_130_20 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403030", "story_v_side_new_1107403.awb") / 1000

					if var_130_20 + var_130_12 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_20 + var_130_12
					end

					if var_130_15.prefab_name ~= "" and arg_127_1.actors_[var_130_15.prefab_name] ~= nil then
						local var_130_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_15.prefab_name].transform, "story_v_side_new_1107403", "1107403030", "story_v_side_new_1107403.awb")

						arg_127_1:RecordAudio("1107403030", var_130_21)
						arg_127_1:RecordAudio("1107403030", var_130_21)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403030", "story_v_side_new_1107403.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403030", "story_v_side_new_1107403.awb")
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
	Play1107403031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1107403031
		arg_131_1.duration_ = 1.03

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1107403032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10044ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect10044ui_story == nil then
				arg_131_1.var_.characterEffect10044ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.1

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect10044ui_story and not isNil(var_134_0) then
					local var_134_4 = Mathf.Lerp(0, 0.5, var_134_3)

					arg_131_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10044ui_story.fillRatio = var_134_4
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect10044ui_story then
				local var_134_5 = 0.5

				arg_131_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10044ui_story.fillRatio = var_134_5
			end

			local var_134_6 = arg_131_1.actors_["1074ui_story"]
			local var_134_7 = 0

			if var_134_7 < arg_131_1.time_ and arg_131_1.time_ <= var_134_7 + arg_134_0 and not isNil(var_134_6) and arg_131_1.var_.characterEffect1074ui_story == nil then
				arg_131_1.var_.characterEffect1074ui_story = var_134_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_8 = 0.1

			if var_134_7 <= arg_131_1.time_ and arg_131_1.time_ < var_134_7 + var_134_8 and not isNil(var_134_6) then
				local var_134_9 = (arg_131_1.time_ - var_134_7) / var_134_8

				if arg_131_1.var_.characterEffect1074ui_story and not isNil(var_134_6) then
					arg_131_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_7 + var_134_8 and arg_131_1.time_ < var_134_7 + var_134_8 + arg_134_0 and not isNil(var_134_6) and arg_131_1.var_.characterEffect1074ui_story then
				arg_131_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_134_10 = 0
			local var_134_11 = 0.075

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_12 = arg_131_1:FormatText(StoryNameCfg[410].name)

				arg_131_1.leftNameTxt_.text = var_134_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_13 = arg_131_1:GetWordFromCfg(1107403031)
				local var_134_14 = arg_131_1:FormatText(var_134_13.content)

				arg_131_1.text_.text = var_134_14

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_15 = 3
				local var_134_16 = utf8.len(var_134_14)
				local var_134_17 = var_134_15 <= 0 and var_134_11 or var_134_11 * (var_134_16 / var_134_15)

				if var_134_17 > 0 and var_134_11 < var_134_17 then
					arg_131_1.talkMaxDuration = var_134_17

					if var_134_17 + var_134_10 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_17 + var_134_10
					end
				end

				arg_131_1.text_.text = var_134_14
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403031", "story_v_side_new_1107403.awb") ~= 0 then
					local var_134_18 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403031", "story_v_side_new_1107403.awb") / 1000

					if var_134_18 + var_134_10 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_18 + var_134_10
					end

					if var_134_13.prefab_name ~= "" and arg_131_1.actors_[var_134_13.prefab_name] ~= nil then
						local var_134_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_13.prefab_name].transform, "story_v_side_new_1107403", "1107403031", "story_v_side_new_1107403.awb")

						arg_131_1:RecordAudio("1107403031", var_134_19)
						arg_131_1:RecordAudio("1107403031", var_134_19)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403031", "story_v_side_new_1107403.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403031", "story_v_side_new_1107403.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_20 = math.max(var_134_11, arg_131_1.talkMaxDuration)

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_20 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_10) / var_134_20

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_10 + var_134_20 and arg_131_1.time_ < var_134_10 + var_134_20 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play1107403032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1107403032
		arg_135_1.duration_ = 6.73

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1107403033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1074ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1074ui_story == nil then
				arg_135_1.var_.characterEffect1074ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.1

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1074ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1074ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1074ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1074ui_story.fillRatio = var_138_5
			end

			local var_138_6 = arg_135_1.actors_["10044ui_story"]
			local var_138_7 = 0

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect10044ui_story == nil then
				arg_135_1.var_.characterEffect10044ui_story = var_138_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_8 = 0.1

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_8 and not isNil(var_138_6) then
				local var_138_9 = (arg_135_1.time_ - var_138_7) / var_138_8

				if arg_135_1.var_.characterEffect10044ui_story and not isNil(var_138_6) then
					arg_135_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_7 + var_138_8 and arg_135_1.time_ < var_138_7 + var_138_8 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect10044ui_story then
				arg_135_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action7_1")
			end

			local var_138_11 = 0
			local var_138_12 = 0.925

			if var_138_11 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_13 = arg_135_1:FormatText(StoryNameCfg[380].name)

				arg_135_1.leftNameTxt_.text = var_138_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_14 = arg_135_1:GetWordFromCfg(1107403032)
				local var_138_15 = arg_135_1:FormatText(var_138_14.content)

				arg_135_1.text_.text = var_138_15

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_16 = 37
				local var_138_17 = utf8.len(var_138_15)
				local var_138_18 = var_138_16 <= 0 and var_138_12 or var_138_12 * (var_138_17 / var_138_16)

				if var_138_18 > 0 and var_138_12 < var_138_18 then
					arg_135_1.talkMaxDuration = var_138_18

					if var_138_18 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_18 + var_138_11
					end
				end

				arg_135_1.text_.text = var_138_15
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403032", "story_v_side_new_1107403.awb") ~= 0 then
					local var_138_19 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403032", "story_v_side_new_1107403.awb") / 1000

					if var_138_19 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_19 + var_138_11
					end

					if var_138_14.prefab_name ~= "" and arg_135_1.actors_[var_138_14.prefab_name] ~= nil then
						local var_138_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_14.prefab_name].transform, "story_v_side_new_1107403", "1107403032", "story_v_side_new_1107403.awb")

						arg_135_1:RecordAudio("1107403032", var_138_20)
						arg_135_1:RecordAudio("1107403032", var_138_20)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403032", "story_v_side_new_1107403.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403032", "story_v_side_new_1107403.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_21 = math.max(var_138_12, arg_135_1.talkMaxDuration)

			if var_138_11 <= arg_135_1.time_ and arg_135_1.time_ < var_138_11 + var_138_21 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_11) / var_138_21

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_11 + var_138_21 and arg_135_1.time_ < var_138_11 + var_138_21 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1107403033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1107403033
		arg_139_1.duration_ = 5.97

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1107403034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.825

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[380].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:GetWordFromCfg(1107403033)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 33
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403033", "story_v_side_new_1107403.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403033", "story_v_side_new_1107403.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_side_new_1107403", "1107403033", "story_v_side_new_1107403.awb")

						arg_139_1:RecordAudio("1107403033", var_142_9)
						arg_139_1:RecordAudio("1107403033", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403033", "story_v_side_new_1107403.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403033", "story_v_side_new_1107403.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_10 and arg_139_1.time_ < var_142_0 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1107403034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1107403034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1107403035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1074ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1074ui_story == nil then
				arg_143_1.var_.characterEffect1074ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.1

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1074ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1074ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1074ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1074ui_story.fillRatio = var_146_5
			end

			local var_146_6 = arg_143_1.actors_["10044ui_story"]
			local var_146_7 = 0

			if var_146_7 < arg_143_1.time_ and arg_143_1.time_ <= var_146_7 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect10044ui_story == nil then
				arg_143_1.var_.characterEffect10044ui_story = var_146_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_8 = 0.1

			if var_146_7 <= arg_143_1.time_ and arg_143_1.time_ < var_146_7 + var_146_8 and not isNil(var_146_6) then
				local var_146_9 = (arg_143_1.time_ - var_146_7) / var_146_8

				if arg_143_1.var_.characterEffect10044ui_story and not isNil(var_146_6) then
					local var_146_10 = Mathf.Lerp(0, 0.5, var_146_9)

					arg_143_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10044ui_story.fillRatio = var_146_10
				end
			end

			if arg_143_1.time_ >= var_146_7 + var_146_8 and arg_143_1.time_ < var_146_7 + var_146_8 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect10044ui_story then
				local var_146_11 = 0.5

				arg_143_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10044ui_story.fillRatio = var_146_11
			end

			local var_146_12 = 0
			local var_146_13 = 0.475

			if var_146_12 < arg_143_1.time_ and arg_143_1.time_ <= var_146_12 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_14 = arg_143_1:GetWordFromCfg(1107403034)
				local var_146_15 = arg_143_1:FormatText(var_146_14.content)

				arg_143_1.text_.text = var_146_15

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_16 = 19
				local var_146_17 = utf8.len(var_146_15)
				local var_146_18 = var_146_16 <= 0 and var_146_13 or var_146_13 * (var_146_17 / var_146_16)

				if var_146_18 > 0 and var_146_13 < var_146_18 then
					arg_143_1.talkMaxDuration = var_146_18

					if var_146_18 + var_146_12 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_18 + var_146_12
					end
				end

				arg_143_1.text_.text = var_146_15
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_19 = math.max(var_146_13, arg_143_1.talkMaxDuration)

			if var_146_12 <= arg_143_1.time_ and arg_143_1.time_ < var_146_12 + var_146_19 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_12) / var_146_19

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_12 + var_146_19 and arg_143_1.time_ < var_146_12 + var_146_19 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1107403035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1107403035
		arg_147_1.duration_ = 2.27

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1107403036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10044ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10044ui_story == nil then
				arg_147_1.var_.characterEffect10044ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.1

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect10044ui_story and not isNil(var_150_0) then
					arg_147_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10044ui_story then
				arg_147_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_150_4 = 0

			if var_150_4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action7_2")
			end

			local var_150_5 = 0
			local var_150_6 = 0.225

			if var_150_5 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_7 = arg_147_1:FormatText(StoryNameCfg[380].name)

				arg_147_1.leftNameTxt_.text = var_150_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_8 = arg_147_1:GetWordFromCfg(1107403035)
				local var_150_9 = arg_147_1:FormatText(var_150_8.content)

				arg_147_1.text_.text = var_150_9

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 9
				local var_150_11 = utf8.len(var_150_9)
				local var_150_12 = var_150_10 <= 0 and var_150_6 or var_150_6 * (var_150_11 / var_150_10)

				if var_150_12 > 0 and var_150_6 < var_150_12 then
					arg_147_1.talkMaxDuration = var_150_12

					if var_150_12 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_5
					end
				end

				arg_147_1.text_.text = var_150_9
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403035", "story_v_side_new_1107403.awb") ~= 0 then
					local var_150_13 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403035", "story_v_side_new_1107403.awb") / 1000

					if var_150_13 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_5
					end

					if var_150_8.prefab_name ~= "" and arg_147_1.actors_[var_150_8.prefab_name] ~= nil then
						local var_150_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_8.prefab_name].transform, "story_v_side_new_1107403", "1107403035", "story_v_side_new_1107403.awb")

						arg_147_1:RecordAudio("1107403035", var_150_14)
						arg_147_1:RecordAudio("1107403035", var_150_14)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403035", "story_v_side_new_1107403.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403035", "story_v_side_new_1107403.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_15 = math.max(var_150_6, arg_147_1.talkMaxDuration)

			if var_150_5 <= arg_147_1.time_ and arg_147_1.time_ < var_150_5 + var_150_15 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_5) / var_150_15

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_5 + var_150_15 and arg_147_1.time_ < var_150_5 + var_150_15 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1107403036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1107403036
		arg_151_1.duration_ = 1

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"

			SetActive(arg_151_1.choicesGo_, true)

			for iter_152_0, iter_152_1 in ipairs(arg_151_1.choices_) do
				local var_152_0 = iter_152_0 <= 2

				SetActive(iter_152_1.go, var_152_0)
			end

			arg_151_1.choices_[1].txt.text = arg_151_1:FormatText(StoryChoiceCfg[1016].name)
			arg_151_1.choices_[2].txt.text = arg_151_1:FormatText(StoryChoiceCfg[1017].name)
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1107403037(arg_151_1)
			end

			if arg_153_0 == 2 then
				arg_151_0:Play1107403037(arg_151_1)
			end

			arg_151_1:RecordChoiceLog(1107403036, 1016, 1017)
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10044ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10044ui_story == nil then
				arg_151_1.var_.characterEffect10044ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.1

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect10044ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10044ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10044ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10044ui_story.fillRatio = var_154_5
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1107403037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1107403037
		arg_155_1.duration_ = 2.4

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1107403038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1074ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1074ui_story == nil then
				arg_155_1.var_.characterEffect1074ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.1

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1074ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1074ui_story then
				arg_155_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_158_4 = "1074ui_story"

			if arg_155_1.actors_[var_158_4] == nil then
				local var_158_5 = Asset.Load("Char/" .. "1074ui_story")

				if not isNil(var_158_5) then
					local var_158_6 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_155_1.stage_.transform)

					var_158_6.name = var_158_4
					var_158_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_155_1.actors_[var_158_4] = var_158_6

					local var_158_7 = var_158_6:GetComponentInChildren(typeof(CharacterEffect))

					var_158_7.enabled = true

					local var_158_8 = GameObjectTools.GetOrAddComponent(var_158_6, typeof(DynamicBoneHelper))

					if var_158_8 then
						var_158_8:EnableDynamicBone(false)
					end

					arg_155_1:ShowWeapon(var_158_7.transform, false)

					arg_155_1.var_[var_158_4 .. "Animator"] = var_158_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_155_1.var_[var_158_4 .. "Animator"].applyRootMotion = true
					arg_155_1.var_[var_158_4 .. "LipSync"] = var_158_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_158_9 = 0

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 then
				arg_155_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_2")
			end

			local var_158_10 = 0
			local var_158_11 = 0.3

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_12 = arg_155_1:FormatText(StoryNameCfg[410].name)

				arg_155_1.leftNameTxt_.text = var_158_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_13 = arg_155_1:GetWordFromCfg(1107403037)
				local var_158_14 = arg_155_1:FormatText(var_158_13.content)

				arg_155_1.text_.text = var_158_14

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_15 = 12
				local var_158_16 = utf8.len(var_158_14)
				local var_158_17 = var_158_15 <= 0 and var_158_11 or var_158_11 * (var_158_16 / var_158_15)

				if var_158_17 > 0 and var_158_11 < var_158_17 then
					arg_155_1.talkMaxDuration = var_158_17

					if var_158_17 + var_158_10 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_17 + var_158_10
					end
				end

				arg_155_1.text_.text = var_158_14
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403037", "story_v_side_new_1107403.awb") ~= 0 then
					local var_158_18 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403037", "story_v_side_new_1107403.awb") / 1000

					if var_158_18 + var_158_10 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_18 + var_158_10
					end

					if var_158_13.prefab_name ~= "" and arg_155_1.actors_[var_158_13.prefab_name] ~= nil then
						local var_158_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_13.prefab_name].transform, "story_v_side_new_1107403", "1107403037", "story_v_side_new_1107403.awb")

						arg_155_1:RecordAudio("1107403037", var_158_19)
						arg_155_1:RecordAudio("1107403037", var_158_19)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403037", "story_v_side_new_1107403.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403037", "story_v_side_new_1107403.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_20 = math.max(var_158_11, arg_155_1.talkMaxDuration)

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_20 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_10) / var_158_20

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_10 + var_158_20 and arg_155_1.time_ < var_158_10 + var_158_20 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1107403038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1107403038
		arg_159_1.duration_ = 3.53

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1107403039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1074ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1074ui_story == nil then
				arg_159_1.var_.characterEffect1074ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.1

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect1074ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1074ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect1074ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1074ui_story.fillRatio = var_162_5
			end

			local var_162_6 = arg_159_1.actors_["10044ui_story"]
			local var_162_7 = 0

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect10044ui_story == nil then
				arg_159_1.var_.characterEffect10044ui_story = var_162_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_8 = 0.1

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_8 and not isNil(var_162_6) then
				local var_162_9 = (arg_159_1.time_ - var_162_7) / var_162_8

				if arg_159_1.var_.characterEffect10044ui_story and not isNil(var_162_6) then
					arg_159_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_7 + var_162_8 and arg_159_1.time_ < var_162_7 + var_162_8 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect10044ui_story then
				arg_159_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 then
				arg_159_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_1")
			end

			local var_162_11 = 0

			if var_162_11 < arg_159_1.time_ and arg_159_1.time_ <= var_162_11 + arg_162_0 then
				arg_159_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_162_12 = 0
			local var_162_13 = 0.4

			if var_162_12 < arg_159_1.time_ and arg_159_1.time_ <= var_162_12 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_14 = arg_159_1:FormatText(StoryNameCfg[380].name)

				arg_159_1.leftNameTxt_.text = var_162_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_15 = arg_159_1:GetWordFromCfg(1107403038)
				local var_162_16 = arg_159_1:FormatText(var_162_15.content)

				arg_159_1.text_.text = var_162_16

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_17 = 16
				local var_162_18 = utf8.len(var_162_16)
				local var_162_19 = var_162_17 <= 0 and var_162_13 or var_162_13 * (var_162_18 / var_162_17)

				if var_162_19 > 0 and var_162_13 < var_162_19 then
					arg_159_1.talkMaxDuration = var_162_19

					if var_162_19 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_19 + var_162_12
					end
				end

				arg_159_1.text_.text = var_162_16
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403038", "story_v_side_new_1107403.awb") ~= 0 then
					local var_162_20 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403038", "story_v_side_new_1107403.awb") / 1000

					if var_162_20 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_20 + var_162_12
					end

					if var_162_15.prefab_name ~= "" and arg_159_1.actors_[var_162_15.prefab_name] ~= nil then
						local var_162_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_15.prefab_name].transform, "story_v_side_new_1107403", "1107403038", "story_v_side_new_1107403.awb")

						arg_159_1:RecordAudio("1107403038", var_162_21)
						arg_159_1:RecordAudio("1107403038", var_162_21)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403038", "story_v_side_new_1107403.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403038", "story_v_side_new_1107403.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_22 = math.max(var_162_13, arg_159_1.talkMaxDuration)

			if var_162_12 <= arg_159_1.time_ and arg_159_1.time_ < var_162_12 + var_162_22 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_12) / var_162_22

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_12 + var_162_22 and arg_159_1.time_ < var_162_12 + var_162_22 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1107403039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1107403039
		arg_163_1.duration_ = 4.6

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1107403040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_2")
			end

			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_166_2 = 0
			local var_166_3 = 0.5

			if var_166_2 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_4 = arg_163_1:FormatText(StoryNameCfg[380].name)

				arg_163_1.leftNameTxt_.text = var_166_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_5 = arg_163_1:GetWordFromCfg(1107403039)
				local var_166_6 = arg_163_1:FormatText(var_166_5.content)

				arg_163_1.text_.text = var_166_6

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 20
				local var_166_8 = utf8.len(var_166_6)
				local var_166_9 = var_166_7 <= 0 and var_166_3 or var_166_3 * (var_166_8 / var_166_7)

				if var_166_9 > 0 and var_166_3 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_6
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403039", "story_v_side_new_1107403.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403039", "story_v_side_new_1107403.awb") / 1000

					if var_166_10 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_2
					end

					if var_166_5.prefab_name ~= "" and arg_163_1.actors_[var_166_5.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_5.prefab_name].transform, "story_v_side_new_1107403", "1107403039", "story_v_side_new_1107403.awb")

						arg_163_1:RecordAudio("1107403039", var_166_11)
						arg_163_1:RecordAudio("1107403039", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403039", "story_v_side_new_1107403.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403039", "story_v_side_new_1107403.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = math.max(var_166_3, arg_163_1.talkMaxDuration)

			if var_166_2 <= arg_163_1.time_ and arg_163_1.time_ < var_166_2 + var_166_12 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_2) / var_166_12

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_2 + var_166_12 and arg_163_1.time_ < var_166_2 + var_166_12 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1107403040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1107403040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1107403041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10044ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos10044ui_story = var_170_0.localPosition
			end

			local var_170_2 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2
				local var_170_4 = Vector3.New(0, 100, 0)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10044ui_story, var_170_4, var_170_3)

				local var_170_5 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_5.x, var_170_5.y, var_170_5.z)

				local var_170_6 = var_170_0.localEulerAngles

				var_170_6.z = 0
				var_170_6.x = 0
				var_170_0.localEulerAngles = var_170_6
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(0, 100, 0)

				local var_170_7 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_7.x, var_170_7.y, var_170_7.z)

				local var_170_8 = var_170_0.localEulerAngles

				var_170_8.z = 0
				var_170_8.x = 0
				var_170_0.localEulerAngles = var_170_8
			end

			local var_170_9 = arg_167_1.actors_["1074ui_story"].transform
			local var_170_10 = 0

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 then
				arg_167_1.var_.moveOldPos1074ui_story = var_170_9.localPosition

				local var_170_11 = "1074ui_story"

				arg_167_1:ShowWeapon(arg_167_1.var_[var_170_11 .. "Animator"].transform, false)
			end

			local var_170_12 = 0.001

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_12 then
				local var_170_13 = (arg_167_1.time_ - var_170_10) / var_170_12
				local var_170_14 = Vector3.New(0, 100, 0)

				var_170_9.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1074ui_story, var_170_14, var_170_13)

				local var_170_15 = manager.ui.mainCamera.transform.position - var_170_9.position

				var_170_9.forward = Vector3.New(var_170_15.x, var_170_15.y, var_170_15.z)

				local var_170_16 = var_170_9.localEulerAngles

				var_170_16.z = 0
				var_170_16.x = 0
				var_170_9.localEulerAngles = var_170_16
			end

			if arg_167_1.time_ >= var_170_10 + var_170_12 and arg_167_1.time_ < var_170_10 + var_170_12 + arg_170_0 then
				var_170_9.localPosition = Vector3.New(0, 100, 0)

				local var_170_17 = manager.ui.mainCamera.transform.position - var_170_9.position

				var_170_9.forward = Vector3.New(var_170_17.x, var_170_17.y, var_170_17.z)

				local var_170_18 = var_170_9.localEulerAngles

				var_170_18.z = 0
				var_170_18.x = 0
				var_170_9.localEulerAngles = var_170_18
			end

			local var_170_19 = 0
			local var_170_20 = 0.875

			if var_170_19 < arg_167_1.time_ and arg_167_1.time_ <= var_170_19 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_21 = arg_167_1:GetWordFromCfg(1107403040)
				local var_170_22 = arg_167_1:FormatText(var_170_21.content)

				arg_167_1.text_.text = var_170_22

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_23 = 35
				local var_170_24 = utf8.len(var_170_22)
				local var_170_25 = var_170_23 <= 0 and var_170_20 or var_170_20 * (var_170_24 / var_170_23)

				if var_170_25 > 0 and var_170_20 < var_170_25 then
					arg_167_1.talkMaxDuration = var_170_25

					if var_170_25 + var_170_19 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_25 + var_170_19
					end
				end

				arg_167_1.text_.text = var_170_22
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_26 = math.max(var_170_20, arg_167_1.talkMaxDuration)

			if var_170_19 <= arg_167_1.time_ and arg_167_1.time_ < var_170_19 + var_170_26 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_19) / var_170_26

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_19 + var_170_26 and arg_167_1.time_ < var_170_19 + var_170_26 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play1107403041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1107403041
		arg_171_1.duration_ = 2.3

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1107403042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1074ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1074ui_story == nil then
				arg_171_1.var_.characterEffect1074ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.1

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect1074ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1074ui_story then
				arg_171_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_174_4 = arg_171_1.actors_["1074ui_story"].transform
			local var_174_5 = 0

			if var_174_5 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.var_.moveOldPos1074ui_story = var_174_4.localPosition

				local var_174_6 = "1074ui_story"

				arg_171_1:ShowWeapon(arg_171_1.var_[var_174_6 .. "Animator"].transform, false)
			end

			local var_174_7 = 0.001

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_7 then
				local var_174_8 = (arg_171_1.time_ - var_174_5) / var_174_7
				local var_174_9 = Vector3.New(0, -1.055, -6.12)

				var_174_4.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1074ui_story, var_174_9, var_174_8)

				local var_174_10 = manager.ui.mainCamera.transform.position - var_174_4.position

				var_174_4.forward = Vector3.New(var_174_10.x, var_174_10.y, var_174_10.z)

				local var_174_11 = var_174_4.localEulerAngles

				var_174_11.z = 0
				var_174_11.x = 0
				var_174_4.localEulerAngles = var_174_11
			end

			if arg_171_1.time_ >= var_174_5 + var_174_7 and arg_171_1.time_ < var_174_5 + var_174_7 + arg_174_0 then
				var_174_4.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_174_12 = manager.ui.mainCamera.transform.position - var_174_4.position

				var_174_4.forward = Vector3.New(var_174_12.x, var_174_12.y, var_174_12.z)

				local var_174_13 = var_174_4.localEulerAngles

				var_174_13.z = 0
				var_174_13.x = 0
				var_174_4.localEulerAngles = var_174_13
			end

			local var_174_14 = 0

			if var_174_14 < arg_171_1.time_ and arg_171_1.time_ <= var_174_14 + arg_174_0 then
				arg_171_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_174_15 = 0
			local var_174_16 = 0.275

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_17 = arg_171_1:FormatText(StoryNameCfg[410].name)

				arg_171_1.leftNameTxt_.text = var_174_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_18 = arg_171_1:GetWordFromCfg(1107403041)
				local var_174_19 = arg_171_1:FormatText(var_174_18.content)

				arg_171_1.text_.text = var_174_19

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_20 = 11
				local var_174_21 = utf8.len(var_174_19)
				local var_174_22 = var_174_20 <= 0 and var_174_16 or var_174_16 * (var_174_21 / var_174_20)

				if var_174_22 > 0 and var_174_16 < var_174_22 then
					arg_171_1.talkMaxDuration = var_174_22

					if var_174_22 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_22 + var_174_15
					end
				end

				arg_171_1.text_.text = var_174_19
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403041", "story_v_side_new_1107403.awb") ~= 0 then
					local var_174_23 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403041", "story_v_side_new_1107403.awb") / 1000

					if var_174_23 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_15
					end

					if var_174_18.prefab_name ~= "" and arg_171_1.actors_[var_174_18.prefab_name] ~= nil then
						local var_174_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_18.prefab_name].transform, "story_v_side_new_1107403", "1107403041", "story_v_side_new_1107403.awb")

						arg_171_1:RecordAudio("1107403041", var_174_24)
						arg_171_1:RecordAudio("1107403041", var_174_24)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403041", "story_v_side_new_1107403.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403041", "story_v_side_new_1107403.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_25 = math.max(var_174_16, arg_171_1.talkMaxDuration)

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_25 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_15) / var_174_25

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_15 + var_174_25 and arg_171_1.time_ < var_174_15 + var_174_25 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play1107403042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1107403042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1107403043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1074ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1074ui_story == nil then
				arg_175_1.var_.characterEffect1074ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.1

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1074ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1074ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1074ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1074ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0
			local var_178_7 = 0.425

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_8 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_9 = arg_175_1:GetWordFromCfg(1107403042)
				local var_178_10 = arg_175_1:FormatText(var_178_9.content)

				arg_175_1.text_.text = var_178_10

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 17
				local var_178_12 = utf8.len(var_178_10)
				local var_178_13 = var_178_11 <= 0 and var_178_7 or var_178_7 * (var_178_12 / var_178_11)

				if var_178_13 > 0 and var_178_7 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_10
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_14 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_14 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_14

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_14 and arg_175_1.time_ < var_178_6 + var_178_14 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1107403043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1107403043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1107403044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 1.075

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[7].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(1107403043)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 43
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_8 and arg_179_1.time_ < var_182_0 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1107403044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1107403044
		arg_183_1.duration_ = 1.2

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1107403045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1074ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1074ui_story == nil then
				arg_183_1.var_.characterEffect1074ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.1

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1074ui_story and not isNil(var_186_0) then
					arg_183_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1074ui_story then
				arg_183_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_186_4 = 0
			local var_186_5 = 0.1

			if var_186_4 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_6 = arg_183_1:FormatText(StoryNameCfg[410].name)

				arg_183_1.leftNameTxt_.text = var_186_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_7 = arg_183_1:GetWordFromCfg(1107403044)
				local var_186_8 = arg_183_1:FormatText(var_186_7.content)

				arg_183_1.text_.text = var_186_8

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 4
				local var_186_10 = utf8.len(var_186_8)
				local var_186_11 = var_186_9 <= 0 and var_186_5 or var_186_5 * (var_186_10 / var_186_9)

				if var_186_11 > 0 and var_186_5 < var_186_11 then
					arg_183_1.talkMaxDuration = var_186_11

					if var_186_11 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_11 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_8
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403044", "story_v_side_new_1107403.awb") ~= 0 then
					local var_186_12 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403044", "story_v_side_new_1107403.awb") / 1000

					if var_186_12 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_12 + var_186_4
					end

					if var_186_7.prefab_name ~= "" and arg_183_1.actors_[var_186_7.prefab_name] ~= nil then
						local var_186_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_7.prefab_name].transform, "story_v_side_new_1107403", "1107403044", "story_v_side_new_1107403.awb")

						arg_183_1:RecordAudio("1107403044", var_186_13)
						arg_183_1:RecordAudio("1107403044", var_186_13)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403044", "story_v_side_new_1107403.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403044", "story_v_side_new_1107403.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_14 and arg_183_1.time_ < var_186_4 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1107403045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1107403045
		arg_187_1.duration_ = 7.15

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1107403046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 1

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			local var_190_1 = 1.15

			if arg_187_1.time_ >= var_190_0 + var_190_1 and arg_187_1.time_ < var_190_0 + var_190_1 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			local var_190_2 = "J03f"

			if arg_187_1.bgs_[var_190_2] == nil then
				local var_190_3 = Object.Instantiate(arg_187_1.paintGo_)

				var_190_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_190_2)
				var_190_3.name = var_190_2
				var_190_3.transform.parent = arg_187_1.stage_.transform
				var_190_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_187_1.bgs_[var_190_2] = var_190_3
			end

			local var_190_4 = 1

			if var_190_4 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				local var_190_5 = manager.ui.mainCamera.transform.localPosition
				local var_190_6 = Vector3.New(0, 0, 10) + Vector3.New(var_190_5.x, var_190_5.y, 0)
				local var_190_7 = arg_187_1.bgs_.J03f

				var_190_7.transform.localPosition = var_190_6
				var_190_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_8 = var_190_7:GetComponent("SpriteRenderer")

				if var_190_8 and var_190_8.sprite then
					local var_190_9 = (var_190_7.transform.localPosition - var_190_5).z
					local var_190_10 = manager.ui.mainCameraCom_
					local var_190_11 = 2 * var_190_9 * Mathf.Tan(var_190_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_190_12 = var_190_11 * var_190_10.aspect
					local var_190_13 = var_190_8.sprite.bounds.size.x
					local var_190_14 = var_190_8.sprite.bounds.size.y
					local var_190_15 = var_190_12 / var_190_13
					local var_190_16 = var_190_11 / var_190_14
					local var_190_17 = var_190_16 < var_190_15 and var_190_15 or var_190_16

					var_190_7.transform.localScale = Vector3.New(var_190_17, var_190_17, 0)
				end

				for iter_190_0, iter_190_1 in pairs(arg_187_1.bgs_) do
					if iter_190_0 ~= "J03f" then
						iter_190_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_190_18 = 0

			if var_190_18 < arg_187_1.time_ and arg_187_1.time_ <= var_190_18 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_19 = 1

			if var_190_18 <= arg_187_1.time_ and arg_187_1.time_ < var_190_18 + var_190_19 then
				local var_190_20 = (arg_187_1.time_ - var_190_18) / var_190_19
				local var_190_21 = Color.New(0, 0, 0)

				var_190_21.a = Mathf.Lerp(0, 1, var_190_20)
				arg_187_1.mask_.color = var_190_21
			end

			if arg_187_1.time_ >= var_190_18 + var_190_19 and arg_187_1.time_ < var_190_18 + var_190_19 + arg_190_0 then
				local var_190_22 = Color.New(0, 0, 0)

				var_190_22.a = 1
				arg_187_1.mask_.color = var_190_22
			end

			local var_190_23 = 1

			if var_190_23 < arg_187_1.time_ and arg_187_1.time_ <= var_190_23 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_24 = 1.15

			if var_190_23 <= arg_187_1.time_ and arg_187_1.time_ < var_190_23 + var_190_24 then
				local var_190_25 = (arg_187_1.time_ - var_190_23) / var_190_24
				local var_190_26 = Color.New(0, 0, 0)

				var_190_26.a = Mathf.Lerp(1, 0, var_190_25)
				arg_187_1.mask_.color = var_190_26
			end

			if arg_187_1.time_ >= var_190_23 + var_190_24 and arg_187_1.time_ < var_190_23 + var_190_24 + arg_190_0 then
				local var_190_27 = Color.New(0, 0, 0)
				local var_190_28 = 0

				arg_187_1.mask_.enabled = false
				var_190_27.a = var_190_28
				arg_187_1.mask_.color = var_190_27
			end

			local var_190_29 = arg_187_1.actors_["1074ui_story"].transform
			local var_190_30 = 0.966000000000001

			if var_190_30 < arg_187_1.time_ and arg_187_1.time_ <= var_190_30 + arg_190_0 then
				arg_187_1.var_.moveOldPos1074ui_story = var_190_29.localPosition
			end

			local var_190_31 = 0.001

			if var_190_30 <= arg_187_1.time_ and arg_187_1.time_ < var_190_30 + var_190_31 then
				local var_190_32 = (arg_187_1.time_ - var_190_30) / var_190_31
				local var_190_33 = Vector3.New(0, 100, 0)

				var_190_29.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1074ui_story, var_190_33, var_190_32)

				local var_190_34 = manager.ui.mainCamera.transform.position - var_190_29.position

				var_190_29.forward = Vector3.New(var_190_34.x, var_190_34.y, var_190_34.z)

				local var_190_35 = var_190_29.localEulerAngles

				var_190_35.z = 0
				var_190_35.x = 0
				var_190_29.localEulerAngles = var_190_35
			end

			if arg_187_1.time_ >= var_190_30 + var_190_31 and arg_187_1.time_ < var_190_30 + var_190_31 + arg_190_0 then
				var_190_29.localPosition = Vector3.New(0, 100, 0)

				local var_190_36 = manager.ui.mainCamera.transform.position - var_190_29.position

				var_190_29.forward = Vector3.New(var_190_36.x, var_190_36.y, var_190_36.z)

				local var_190_37 = var_190_29.localEulerAngles

				var_190_37.z = 0
				var_190_37.x = 0
				var_190_29.localEulerAngles = var_190_37
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_38 = 2.15
			local var_190_39 = 1.15

			if var_190_38 < arg_187_1.time_ and arg_187_1.time_ <= var_190_38 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_40 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_40:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_41 = arg_187_1:GetWordFromCfg(1107403045)
				local var_190_42 = arg_187_1:FormatText(var_190_41.content)

				arg_187_1.text_.text = var_190_42

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_43 = 60
				local var_190_44 = utf8.len(var_190_42)
				local var_190_45 = var_190_43 <= 0 and var_190_39 or var_190_39 * (var_190_44 / var_190_43)

				if var_190_45 > 0 and var_190_39 < var_190_45 then
					arg_187_1.talkMaxDuration = var_190_45
					var_190_38 = var_190_38 + 0.3

					if var_190_45 + var_190_38 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_45 + var_190_38
					end
				end

				arg_187_1.text_.text = var_190_42
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_46 = var_190_38 + 0.3
			local var_190_47 = math.max(var_190_39, arg_187_1.talkMaxDuration)

			if var_190_46 <= arg_187_1.time_ and arg_187_1.time_ < var_190_46 + var_190_47 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_46) / var_190_47

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_46 + var_190_47 and arg_187_1.time_ < var_190_46 + var_190_47 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966000000000001,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play1107403046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1107403046
		arg_193_1.duration_ = 2

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"

			SetActive(arg_193_1.choicesGo_, true)

			for iter_194_0, iter_194_1 in ipairs(arg_193_1.choices_) do
				local var_194_0 = iter_194_0 <= 2

				SetActive(iter_194_1.go, var_194_0)
			end

			arg_193_1.choices_[1].txt.text = arg_193_1:FormatText(StoryChoiceCfg[1018].name)
			arg_193_1.choices_[2].txt.text = arg_193_1:FormatText(StoryChoiceCfg[1019].name)
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1107403047(arg_193_1)
			end

			if arg_195_0 == 2 then
				arg_193_0:Play1107403048(arg_193_1)
			end

			arg_193_1:RecordChoiceLog(1107403046, 1018, 1019)
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1107403047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1107403047
		arg_197_1.duration_ = 2.2

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1107403049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1074ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1074ui_story == nil then
				arg_197_1.var_.characterEffect1074ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.1

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1074ui_story and not isNil(var_200_0) then
					arg_197_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1074ui_story then
				arg_197_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_200_4 = 0

			if var_200_4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_200_5 = arg_197_1.actors_["1074ui_story"].transform
			local var_200_6 = 0

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.var_.moveOldPos1074ui_story = var_200_5.localPosition

				local var_200_7 = "1074ui_story"

				arg_197_1:ShowWeapon(arg_197_1.var_[var_200_7 .. "Animator"].transform, false)
			end

			local var_200_8 = 0.001

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_8 then
				local var_200_9 = (arg_197_1.time_ - var_200_6) / var_200_8
				local var_200_10 = Vector3.New(0, -1.055, -6.12)

				var_200_5.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1074ui_story, var_200_10, var_200_9)

				local var_200_11 = manager.ui.mainCamera.transform.position - var_200_5.position

				var_200_5.forward = Vector3.New(var_200_11.x, var_200_11.y, var_200_11.z)

				local var_200_12 = var_200_5.localEulerAngles

				var_200_12.z = 0
				var_200_12.x = 0
				var_200_5.localEulerAngles = var_200_12
			end

			if arg_197_1.time_ >= var_200_6 + var_200_8 and arg_197_1.time_ < var_200_6 + var_200_8 + arg_200_0 then
				var_200_5.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_200_13 = manager.ui.mainCamera.transform.position - var_200_5.position

				var_200_5.forward = Vector3.New(var_200_13.x, var_200_13.y, var_200_13.z)

				local var_200_14 = var_200_5.localEulerAngles

				var_200_14.z = 0
				var_200_14.x = 0
				var_200_5.localEulerAngles = var_200_14
			end

			local var_200_15 = 0
			local var_200_16 = 0.15

			if var_200_15 < arg_197_1.time_ and arg_197_1.time_ <= var_200_15 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_17 = arg_197_1:FormatText(StoryNameCfg[410].name)

				arg_197_1.leftNameTxt_.text = var_200_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_18 = arg_197_1:GetWordFromCfg(1107403047)
				local var_200_19 = arg_197_1:FormatText(var_200_18.content)

				arg_197_1.text_.text = var_200_19

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_20 = 6
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

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403047", "story_v_side_new_1107403.awb") ~= 0 then
					local var_200_23 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403047", "story_v_side_new_1107403.awb") / 1000

					if var_200_23 + var_200_15 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_23 + var_200_15
					end

					if var_200_18.prefab_name ~= "" and arg_197_1.actors_[var_200_18.prefab_name] ~= nil then
						local var_200_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_18.prefab_name].transform, "story_v_side_new_1107403", "1107403047", "story_v_side_new_1107403.awb")

						arg_197_1:RecordAudio("1107403047", var_200_24)
						arg_197_1:RecordAudio("1107403047", var_200_24)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403047", "story_v_side_new_1107403.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403047", "story_v_side_new_1107403.awb")
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
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play1107403049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1107403049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1107403050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1074ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1074ui_story == nil then
				arg_201_1.var_.characterEffect1074ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.1

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1074ui_story and not isNil(var_204_0) then
					local var_204_4 = Mathf.Lerp(0, 0.5, var_204_3)

					arg_201_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1074ui_story.fillRatio = var_204_4
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1074ui_story then
				local var_204_5 = 0.5

				arg_201_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1074ui_story.fillRatio = var_204_5
			end

			local var_204_6 = 0
			local var_204_7 = 0.35

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_8 = arg_201_1:FormatText(StoryNameCfg[7].name)

				arg_201_1.leftNameTxt_.text = var_204_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_9 = arg_201_1:GetWordFromCfg(1107403049)
				local var_204_10 = arg_201_1:FormatText(var_204_9.content)

				arg_201_1.text_.text = var_204_10

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 14
				local var_204_12 = utf8.len(var_204_10)
				local var_204_13 = var_204_11 <= 0 and var_204_7 or var_204_7 * (var_204_12 / var_204_11)

				if var_204_13 > 0 and var_204_7 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_10
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_14 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_14 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_14

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_14 and arg_201_1.time_ < var_204_6 + var_204_14 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1107403050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1107403050
		arg_205_1.duration_ = 5.03

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1107403051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1074ui_story"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1074ui_story == nil then
				arg_205_1.var_.characterEffect1074ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.1

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.characterEffect1074ui_story and not isNil(var_208_0) then
					arg_205_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1074ui_story then
				arg_205_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_208_4 = 0
			local var_208_5 = 0.625

			if var_208_4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_6 = arg_205_1:FormatText(StoryNameCfg[410].name)

				arg_205_1.leftNameTxt_.text = var_208_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_7 = arg_205_1:GetWordFromCfg(1107403050)
				local var_208_8 = arg_205_1:FormatText(var_208_7.content)

				arg_205_1.text_.text = var_208_8

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 25
				local var_208_10 = utf8.len(var_208_8)
				local var_208_11 = var_208_9 <= 0 and var_208_5 or var_208_5 * (var_208_10 / var_208_9)

				if var_208_11 > 0 and var_208_5 < var_208_11 then
					arg_205_1.talkMaxDuration = var_208_11

					if var_208_11 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_11 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_8
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403050", "story_v_side_new_1107403.awb") ~= 0 then
					local var_208_12 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403050", "story_v_side_new_1107403.awb") / 1000

					if var_208_12 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_12 + var_208_4
					end

					if var_208_7.prefab_name ~= "" and arg_205_1.actors_[var_208_7.prefab_name] ~= nil then
						local var_208_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_7.prefab_name].transform, "story_v_side_new_1107403", "1107403050", "story_v_side_new_1107403.awb")

						arg_205_1:RecordAudio("1107403050", var_208_13)
						arg_205_1:RecordAudio("1107403050", var_208_13)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403050", "story_v_side_new_1107403.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403050", "story_v_side_new_1107403.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_14 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_14 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_14

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_14 and arg_205_1.time_ < var_208_4 + var_208_14 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1107403051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1107403051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1107403052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1074ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1074ui_story == nil then
				arg_209_1.var_.characterEffect1074ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.1

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1074ui_story and not isNil(var_212_0) then
					local var_212_4 = Mathf.Lerp(0, 0.5, var_212_3)

					arg_209_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1074ui_story.fillRatio = var_212_4
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1074ui_story then
				local var_212_5 = 0.5

				arg_209_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1074ui_story.fillRatio = var_212_5
			end

			local var_212_6 = 0
			local var_212_7 = 0.15

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_8 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_9 = arg_209_1:GetWordFromCfg(1107403051)
				local var_212_10 = arg_209_1:FormatText(var_212_9.content)

				arg_209_1.text_.text = var_212_10

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 6
				local var_212_12 = utf8.len(var_212_10)
				local var_212_13 = var_212_11 <= 0 and var_212_7 or var_212_7 * (var_212_12 / var_212_11)

				if var_212_13 > 0 and var_212_7 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_10
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_14 and arg_209_1.time_ < var_212_6 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1107403052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1107403052
		arg_213_1.duration_ = 7.3

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1107403053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1074ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1074ui_story == nil then
				arg_213_1.var_.characterEffect1074ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.1

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1074ui_story and not isNil(var_216_0) then
					arg_213_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1074ui_story then
				arg_213_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_216_4 = 0
			local var_216_5 = 0.75

			if var_216_4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_6 = arg_213_1:FormatText(StoryNameCfg[410].name)

				arg_213_1.leftNameTxt_.text = var_216_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:GetWordFromCfg(1107403052)
				local var_216_8 = arg_213_1:FormatText(var_216_7.content)

				arg_213_1.text_.text = var_216_8

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 30
				local var_216_10 = utf8.len(var_216_8)
				local var_216_11 = var_216_9 <= 0 and var_216_5 or var_216_5 * (var_216_10 / var_216_9)

				if var_216_11 > 0 and var_216_5 < var_216_11 then
					arg_213_1.talkMaxDuration = var_216_11

					if var_216_11 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_8
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403052", "story_v_side_new_1107403.awb") ~= 0 then
					local var_216_12 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403052", "story_v_side_new_1107403.awb") / 1000

					if var_216_12 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_12 + var_216_4
					end

					if var_216_7.prefab_name ~= "" and arg_213_1.actors_[var_216_7.prefab_name] ~= nil then
						local var_216_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_7.prefab_name].transform, "story_v_side_new_1107403", "1107403052", "story_v_side_new_1107403.awb")

						arg_213_1:RecordAudio("1107403052", var_216_13)
						arg_213_1:RecordAudio("1107403052", var_216_13)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403052", "story_v_side_new_1107403.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403052", "story_v_side_new_1107403.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_14 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_14 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_14

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_14 and arg_213_1.time_ < var_216_4 + var_216_14 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1107403053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1107403053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1107403054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1074ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1074ui_story == nil then
				arg_217_1.var_.characterEffect1074ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.1

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1074ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1074ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1074ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1074ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0
			local var_220_7 = 0.85

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_8 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_9 = arg_217_1:GetWordFromCfg(1107403053)
				local var_220_10 = arg_217_1:FormatText(var_220_9.content)

				arg_217_1.text_.text = var_220_10

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 34
				local var_220_12 = utf8.len(var_220_10)
				local var_220_13 = var_220_11 <= 0 and var_220_7 or var_220_7 * (var_220_12 / var_220_11)

				if var_220_13 > 0 and var_220_7 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_10
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1107403054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1107403054
		arg_221_1.duration_ = 2.97

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1107403055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.275

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[1051].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(1107403054)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 11
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403054", "story_v_side_new_1107403.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403054", "story_v_side_new_1107403.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_side_new_1107403", "1107403054", "story_v_side_new_1107403.awb")

						arg_221_1:RecordAudio("1107403054", var_224_9)
						arg_221_1:RecordAudio("1107403054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403054", "story_v_side_new_1107403.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403054", "story_v_side_new_1107403.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_10 and arg_221_1.time_ < var_224_0 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1107403055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1107403055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1107403056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.325

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(1107403055)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 13
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_8 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_8 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_8

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_8 and arg_225_1.time_ < var_228_0 + var_228_8 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1107403056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1107403056
		arg_229_1.duration_ = 1.1

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1107403057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1074ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1074ui_story == nil then
				arg_229_1.var_.characterEffect1074ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.1

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1074ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1074ui_story then
				arg_229_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_232_4 = 0
			local var_232_5 = 0.1

			if var_232_4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_6 = arg_229_1:FormatText(StoryNameCfg[410].name)

				arg_229_1.leftNameTxt_.text = var_232_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_7 = arg_229_1:GetWordFromCfg(1107403056)
				local var_232_8 = arg_229_1:FormatText(var_232_7.content)

				arg_229_1.text_.text = var_232_8

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 4
				local var_232_10 = utf8.len(var_232_8)
				local var_232_11 = var_232_9 <= 0 and var_232_5 or var_232_5 * (var_232_10 / var_232_9)

				if var_232_11 > 0 and var_232_5 < var_232_11 then
					arg_229_1.talkMaxDuration = var_232_11

					if var_232_11 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_11 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_8
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403056", "story_v_side_new_1107403.awb") ~= 0 then
					local var_232_12 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403056", "story_v_side_new_1107403.awb") / 1000

					if var_232_12 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_12 + var_232_4
					end

					if var_232_7.prefab_name ~= "" and arg_229_1.actors_[var_232_7.prefab_name] ~= nil then
						local var_232_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_7.prefab_name].transform, "story_v_side_new_1107403", "1107403056", "story_v_side_new_1107403.awb")

						arg_229_1:RecordAudio("1107403056", var_232_13)
						arg_229_1:RecordAudio("1107403056", var_232_13)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403056", "story_v_side_new_1107403.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403056", "story_v_side_new_1107403.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_14 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_14 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_14

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_14 and arg_229_1.time_ < var_232_4 + var_232_14 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1107403057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1107403057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1107403058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1074ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1074ui_story == nil then
				arg_233_1.var_.characterEffect1074ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.1

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1074ui_story and not isNil(var_236_0) then
					local var_236_4 = Mathf.Lerp(0, 0.5, var_236_3)

					arg_233_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1074ui_story.fillRatio = var_236_4
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1074ui_story then
				local var_236_5 = 0.5

				arg_233_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1074ui_story.fillRatio = var_236_5
			end

			local var_236_6 = arg_233_1.actors_["1074ui_story"].transform
			local var_236_7 = 0

			if var_236_7 < arg_233_1.time_ and arg_233_1.time_ <= var_236_7 + arg_236_0 then
				arg_233_1.var_.moveOldPos1074ui_story = var_236_6.localPosition

				local var_236_8 = "1074ui_story"

				arg_233_1:ShowWeapon(arg_233_1.var_[var_236_8 .. "Animator"].transform, false)
			end

			local var_236_9 = 0.001

			if var_236_7 <= arg_233_1.time_ and arg_233_1.time_ < var_236_7 + var_236_9 then
				local var_236_10 = (arg_233_1.time_ - var_236_7) / var_236_9
				local var_236_11 = Vector3.New(0, 100, 0)

				var_236_6.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1074ui_story, var_236_11, var_236_10)

				local var_236_12 = manager.ui.mainCamera.transform.position - var_236_6.position

				var_236_6.forward = Vector3.New(var_236_12.x, var_236_12.y, var_236_12.z)

				local var_236_13 = var_236_6.localEulerAngles

				var_236_13.z = 0
				var_236_13.x = 0
				var_236_6.localEulerAngles = var_236_13
			end

			if arg_233_1.time_ >= var_236_7 + var_236_9 and arg_233_1.time_ < var_236_7 + var_236_9 + arg_236_0 then
				var_236_6.localPosition = Vector3.New(0, 100, 0)

				local var_236_14 = manager.ui.mainCamera.transform.position - var_236_6.position

				var_236_6.forward = Vector3.New(var_236_14.x, var_236_14.y, var_236_14.z)

				local var_236_15 = var_236_6.localEulerAngles

				var_236_15.z = 0
				var_236_15.x = 0
				var_236_6.localEulerAngles = var_236_15
			end

			local var_236_16 = 0
			local var_236_17 = 1

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				local var_236_18 = "play"
				local var_236_19 = "effect"

				arg_233_1:AudioAction(var_236_18, var_236_19, "se_story_side_1074", "se_story_side_1074_organ", "")
			end

			local var_236_20 = 0
			local var_236_21 = 0.975

			if var_236_20 < arg_233_1.time_ and arg_233_1.time_ <= var_236_20 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_22 = arg_233_1:GetWordFromCfg(1107403057)
				local var_236_23 = arg_233_1:FormatText(var_236_22.content)

				arg_233_1.text_.text = var_236_23

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_24 = 39
				local var_236_25 = utf8.len(var_236_23)
				local var_236_26 = var_236_24 <= 0 and var_236_21 or var_236_21 * (var_236_25 / var_236_24)

				if var_236_26 > 0 and var_236_21 < var_236_26 then
					arg_233_1.talkMaxDuration = var_236_26

					if var_236_26 + var_236_20 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_26 + var_236_20
					end
				end

				arg_233_1.text_.text = var_236_23
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_27 = math.max(var_236_21, arg_233_1.talkMaxDuration)

			if var_236_20 <= arg_233_1.time_ and arg_233_1.time_ < var_236_20 + var_236_27 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_20) / var_236_27

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_20 + var_236_27 and arg_233_1.time_ < var_236_20 + var_236_27 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play1107403058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1107403058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1107403059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.55

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_2 = arg_237_1:GetWordFromCfg(1107403058)
				local var_240_3 = arg_237_1:FormatText(var_240_2.content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 22
				local var_240_5 = utf8.len(var_240_3)
				local var_240_6 = var_240_4 <= 0 and var_240_1 or var_240_1 * (var_240_5 / var_240_4)

				if var_240_6 > 0 and var_240_1 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6

					if var_240_6 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_7 and arg_237_1.time_ < var_240_0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play1107403059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1107403059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1107403060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 1

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[7].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:GetWordFromCfg(1107403059)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 40
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
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_8 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_8 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_8

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_8 and arg_241_1.time_ < var_244_0 + var_244_8 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1107403060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1107403060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1107403061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.4

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[7].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(1107403060)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 16
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
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_8 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_8 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_8

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_8 and arg_245_1.time_ < var_248_0 + var_248_8 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1107403061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1107403061
		arg_249_1.duration_ = 1.83

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1107403062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1074ui_story"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos1074ui_story = var_252_0.localPosition
			end

			local var_252_2 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2
				local var_252_4 = Vector3.New(0, -1.055, -6.12)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1074ui_story, var_252_4, var_252_3)

				local var_252_5 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_5.x, var_252_5.y, var_252_5.z)

				local var_252_6 = var_252_0.localEulerAngles

				var_252_6.z = 0
				var_252_6.x = 0
				var_252_0.localEulerAngles = var_252_6
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_252_7 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_7.x, var_252_7.y, var_252_7.z)

				local var_252_8 = var_252_0.localEulerAngles

				var_252_8.z = 0
				var_252_8.x = 0
				var_252_0.localEulerAngles = var_252_8
			end

			local var_252_9 = arg_249_1.actors_["1074ui_story"]
			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect1074ui_story == nil then
				arg_249_1.var_.characterEffect1074ui_story = var_252_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_11 = 0.1

			if var_252_10 <= arg_249_1.time_ and arg_249_1.time_ < var_252_10 + var_252_11 and not isNil(var_252_9) then
				local var_252_12 = (arg_249_1.time_ - var_252_10) / var_252_11

				if arg_249_1.var_.characterEffect1074ui_story and not isNil(var_252_9) then
					arg_249_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_10 + var_252_11 and arg_249_1.time_ < var_252_10 + var_252_11 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect1074ui_story then
				arg_249_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_252_13 = 0
			local var_252_14 = 0.2

			if var_252_13 < arg_249_1.time_ and arg_249_1.time_ <= var_252_13 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_15 = arg_249_1:FormatText(StoryNameCfg[410].name)

				arg_249_1.leftNameTxt_.text = var_252_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_16 = arg_249_1:GetWordFromCfg(1107403061)
				local var_252_17 = arg_249_1:FormatText(var_252_16.content)

				arg_249_1.text_.text = var_252_17

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_18 = 8
				local var_252_19 = utf8.len(var_252_17)
				local var_252_20 = var_252_18 <= 0 and var_252_14 or var_252_14 * (var_252_19 / var_252_18)

				if var_252_20 > 0 and var_252_14 < var_252_20 then
					arg_249_1.talkMaxDuration = var_252_20

					if var_252_20 + var_252_13 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_20 + var_252_13
					end
				end

				arg_249_1.text_.text = var_252_17
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403061", "story_v_side_new_1107403.awb") ~= 0 then
					local var_252_21 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403061", "story_v_side_new_1107403.awb") / 1000

					if var_252_21 + var_252_13 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_21 + var_252_13
					end

					if var_252_16.prefab_name ~= "" and arg_249_1.actors_[var_252_16.prefab_name] ~= nil then
						local var_252_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_16.prefab_name].transform, "story_v_side_new_1107403", "1107403061", "story_v_side_new_1107403.awb")

						arg_249_1:RecordAudio("1107403061", var_252_22)
						arg_249_1:RecordAudio("1107403061", var_252_22)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403061", "story_v_side_new_1107403.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403061", "story_v_side_new_1107403.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_23 = math.max(var_252_14, arg_249_1.talkMaxDuration)

			if var_252_13 <= arg_249_1.time_ and arg_249_1.time_ < var_252_13 + var_252_23 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_13) / var_252_23

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_13 + var_252_23 and arg_249_1.time_ < var_252_13 + var_252_23 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play1107403062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1107403062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1107403063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1074ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1074ui_story == nil then
				arg_253_1.var_.characterEffect1074ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.1

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1074ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1074ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1074ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1074ui_story.fillRatio = var_256_5
			end

			local var_256_6 = 0
			local var_256_7 = 0.7

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_8 = arg_253_1:FormatText(StoryNameCfg[7].name)

				arg_253_1.leftNameTxt_.text = var_256_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_9 = arg_253_1:GetWordFromCfg(1107403062)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 28
				local var_256_12 = utf8.len(var_256_10)
				local var_256_13 = var_256_11 <= 0 and var_256_7 or var_256_7 * (var_256_12 / var_256_11)

				if var_256_13 > 0 and var_256_7 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_10
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_14 and arg_253_1.time_ < var_256_6 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1107403063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1107403063
		arg_257_1.duration_ = 3.2

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1107403064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1074ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1074ui_story == nil then
				arg_257_1.var_.characterEffect1074ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.1

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect1074ui_story and not isNil(var_260_0) then
					arg_257_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1074ui_story then
				arg_257_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_260_4 = 0
			local var_260_5 = 0.3

			if var_260_4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_6 = arg_257_1:FormatText(StoryNameCfg[410].name)

				arg_257_1.leftNameTxt_.text = var_260_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_7 = arg_257_1:GetWordFromCfg(1107403063)
				local var_260_8 = arg_257_1:FormatText(var_260_7.content)

				arg_257_1.text_.text = var_260_8

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 12
				local var_260_10 = utf8.len(var_260_8)
				local var_260_11 = var_260_9 <= 0 and var_260_5 or var_260_5 * (var_260_10 / var_260_9)

				if var_260_11 > 0 and var_260_5 < var_260_11 then
					arg_257_1.talkMaxDuration = var_260_11

					if var_260_11 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_11 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_8
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403063", "story_v_side_new_1107403.awb") ~= 0 then
					local var_260_12 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403063", "story_v_side_new_1107403.awb") / 1000

					if var_260_12 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_12 + var_260_4
					end

					if var_260_7.prefab_name ~= "" and arg_257_1.actors_[var_260_7.prefab_name] ~= nil then
						local var_260_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_7.prefab_name].transform, "story_v_side_new_1107403", "1107403063", "story_v_side_new_1107403.awb")

						arg_257_1:RecordAudio("1107403063", var_260_13)
						arg_257_1:RecordAudio("1107403063", var_260_13)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403063", "story_v_side_new_1107403.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403063", "story_v_side_new_1107403.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_14 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_14 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_14

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_14 and arg_257_1.time_ < var_260_4 + var_260_14 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1107403064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1107403064
		arg_261_1.duration_ = 4

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1107403065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.325

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[410].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:GetWordFromCfg(1107403064)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 13
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403064", "story_v_side_new_1107403.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403064", "story_v_side_new_1107403.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_side_new_1107403", "1107403064", "story_v_side_new_1107403.awb")

						arg_261_1:RecordAudio("1107403064", var_264_9)
						arg_261_1:RecordAudio("1107403064", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403064", "story_v_side_new_1107403.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403064", "story_v_side_new_1107403.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_10 and arg_261_1.time_ < var_264_0 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1107403065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1107403065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1107403066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			local var_268_1 = 0.1

			if arg_265_1.time_ >= var_268_0 + var_268_1 and arg_265_1.time_ < var_268_0 + var_268_1 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			local var_268_2 = arg_265_1.actors_["1074ui_story"]
			local var_268_3 = 0

			if var_268_3 < arg_265_1.time_ and arg_265_1.time_ <= var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect1074ui_story == nil then
				arg_265_1.var_.characterEffect1074ui_story = var_268_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_4 = 0.1

			if var_268_3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_3 + var_268_4 and not isNil(var_268_2) then
				local var_268_5 = (arg_265_1.time_ - var_268_3) / var_268_4

				if arg_265_1.var_.characterEffect1074ui_story and not isNil(var_268_2) then
					local var_268_6 = Mathf.Lerp(0, 0.5, var_268_5)

					arg_265_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1074ui_story.fillRatio = var_268_6
				end
			end

			if arg_265_1.time_ >= var_268_3 + var_268_4 and arg_265_1.time_ < var_268_3 + var_268_4 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect1074ui_story then
				local var_268_7 = 0.5

				arg_265_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1074ui_story.fillRatio = var_268_7
			end

			local var_268_8 = 0
			local var_268_9 = 0.866666666666667

			if var_268_8 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				local var_268_10 = "play"
				local var_268_11 = "effect"

				arg_265_1:AudioAction(var_268_10, var_268_11, "se_story_side_1074", "se_story_side_1074_organ", "")
			end

			local var_268_12 = 0
			local var_268_13 = 0.333333333332

			if var_268_12 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_14 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_15 = arg_265_1:GetWordFromCfg(1107403065)
				local var_268_16 = arg_265_1:FormatText(var_268_15.content)

				arg_265_1.text_.text = var_268_16

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_17 = 5
				local var_268_18 = utf8.len(var_268_16)
				local var_268_19 = var_268_17 <= 0 and var_268_13 or var_268_13 * (var_268_18 / var_268_17)

				if var_268_19 > 0 and var_268_13 < var_268_19 then
					arg_265_1.talkMaxDuration = var_268_19

					if var_268_19 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_19 + var_268_12
					end
				end

				arg_265_1.text_.text = var_268_16
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_20 = math.max(var_268_13, arg_265_1.talkMaxDuration)

			if var_268_12 <= arg_265_1.time_ and arg_265_1.time_ < var_268_12 + var_268_20 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_12) / var_268_20

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_12 + var_268_20 and arg_265_1.time_ < var_268_12 + var_268_20 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1107403066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1107403066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1107403067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.875

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_2 = arg_269_1:GetWordFromCfg(1107403066)
				local var_272_3 = arg_269_1:FormatText(var_272_2.content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 35
				local var_272_5 = utf8.len(var_272_3)
				local var_272_6 = var_272_4 <= 0 and var_272_1 or var_272_1 * (var_272_5 / var_272_4)

				if var_272_6 > 0 and var_272_1 < var_272_6 then
					arg_269_1.talkMaxDuration = var_272_6

					if var_272_6 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_6 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_7 and arg_269_1.time_ < var_272_0 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1107403067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1107403067
		arg_273_1.duration_ = 7

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1107403068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = "J03g"

			if arg_273_1.bgs_[var_276_0] == nil then
				local var_276_1 = Object.Instantiate(arg_273_1.paintGo_)

				var_276_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_276_0)
				var_276_1.name = var_276_0
				var_276_1.transform.parent = arg_273_1.stage_.transform
				var_276_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.bgs_[var_276_0] = var_276_1
			end

			local var_276_2 = 1

			if var_276_2 < arg_273_1.time_ and arg_273_1.time_ <= var_276_2 + arg_276_0 then
				local var_276_3 = manager.ui.mainCamera.transform.localPosition
				local var_276_4 = Vector3.New(0, 0, 10) + Vector3.New(var_276_3.x, var_276_3.y, 0)
				local var_276_5 = arg_273_1.bgs_.J03g

				var_276_5.transform.localPosition = var_276_4
				var_276_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_276_6 = var_276_5:GetComponent("SpriteRenderer")

				if var_276_6 and var_276_6.sprite then
					local var_276_7 = (var_276_5.transform.localPosition - var_276_3).z
					local var_276_8 = manager.ui.mainCameraCom_
					local var_276_9 = 2 * var_276_7 * Mathf.Tan(var_276_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_276_10 = var_276_9 * var_276_8.aspect
					local var_276_11 = var_276_6.sprite.bounds.size.x
					local var_276_12 = var_276_6.sprite.bounds.size.y
					local var_276_13 = var_276_10 / var_276_11
					local var_276_14 = var_276_9 / var_276_12
					local var_276_15 = var_276_14 < var_276_13 and var_276_13 or var_276_14

					var_276_5.transform.localScale = Vector3.New(var_276_15, var_276_15, 0)
				end

				for iter_276_0, iter_276_1 in pairs(arg_273_1.bgs_) do
					if iter_276_0 ~= "J03g" then
						iter_276_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_276_16 = 1.00000033333333

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 then
				arg_273_1.allBtn_.enabled = false
			end

			local var_276_17 = 0.999999666666665

			if arg_273_1.time_ >= var_276_16 + var_276_17 and arg_273_1.time_ < var_276_16 + var_276_17 + arg_276_0 then
				arg_273_1.allBtn_.enabled = true
			end

			local var_276_18 = 0

			if var_276_18 < arg_273_1.time_ and arg_273_1.time_ <= var_276_18 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_19 = 1

			if var_276_18 <= arg_273_1.time_ and arg_273_1.time_ < var_276_18 + var_276_19 then
				local var_276_20 = (arg_273_1.time_ - var_276_18) / var_276_19
				local var_276_21 = Color.New(0, 0, 0)

				var_276_21.a = Mathf.Lerp(0, 1, var_276_20)
				arg_273_1.mask_.color = var_276_21
			end

			if arg_273_1.time_ >= var_276_18 + var_276_19 and arg_273_1.time_ < var_276_18 + var_276_19 + arg_276_0 then
				local var_276_22 = Color.New(0, 0, 0)

				var_276_22.a = 1
				arg_273_1.mask_.color = var_276_22
			end

			local var_276_23 = 1

			if var_276_23 < arg_273_1.time_ and arg_273_1.time_ <= var_276_23 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_24 = 1

			if var_276_23 <= arg_273_1.time_ and arg_273_1.time_ < var_276_23 + var_276_24 then
				local var_276_25 = (arg_273_1.time_ - var_276_23) / var_276_24
				local var_276_26 = Color.New(0, 0, 0)

				var_276_26.a = Mathf.Lerp(1, 0, var_276_25)
				arg_273_1.mask_.color = var_276_26
			end

			if arg_273_1.time_ >= var_276_23 + var_276_24 and arg_273_1.time_ < var_276_23 + var_276_24 + arg_276_0 then
				local var_276_27 = Color.New(0, 0, 0)
				local var_276_28 = 0

				arg_273_1.mask_.enabled = false
				var_276_27.a = var_276_28
				arg_273_1.mask_.color = var_276_27
			end

			local var_276_29 = arg_273_1.actors_["1074ui_story"].transform
			local var_276_30 = 0.966

			if var_276_30 < arg_273_1.time_ and arg_273_1.time_ <= var_276_30 + arg_276_0 then
				arg_273_1.var_.moveOldPos1074ui_story = var_276_29.localPosition

				local var_276_31 = "1074ui_story"

				arg_273_1:ShowWeapon(arg_273_1.var_[var_276_31 .. "Animator"].transform, false)
			end

			local var_276_32 = 0.001

			if var_276_30 <= arg_273_1.time_ and arg_273_1.time_ < var_276_30 + var_276_32 then
				local var_276_33 = (arg_273_1.time_ - var_276_30) / var_276_32
				local var_276_34 = Vector3.New(0, 100, 0)

				var_276_29.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1074ui_story, var_276_34, var_276_33)

				local var_276_35 = manager.ui.mainCamera.transform.position - var_276_29.position

				var_276_29.forward = Vector3.New(var_276_35.x, var_276_35.y, var_276_35.z)

				local var_276_36 = var_276_29.localEulerAngles

				var_276_36.z = 0
				var_276_36.x = 0
				var_276_29.localEulerAngles = var_276_36
			end

			if arg_273_1.time_ >= var_276_30 + var_276_32 and arg_273_1.time_ < var_276_30 + var_276_32 + arg_276_0 then
				var_276_29.localPosition = Vector3.New(0, 100, 0)

				local var_276_37 = manager.ui.mainCamera.transform.position - var_276_29.position

				var_276_29.forward = Vector3.New(var_276_37.x, var_276_37.y, var_276_37.z)

				local var_276_38 = var_276_29.localEulerAngles

				var_276_38.z = 0
				var_276_38.x = 0
				var_276_29.localEulerAngles = var_276_38
			end

			local var_276_39 = 0.766666666666667
			local var_276_40 = 1

			if var_276_39 < arg_273_1.time_ and arg_273_1.time_ <= var_276_39 + arg_276_0 then
				local var_276_41 = "play"
				local var_276_42 = "effect"

				arg_273_1:AudioAction(var_276_41, var_276_42, "se_story_side_1074", "se_story_side_1074_countdow_loop", "")
			end

			if arg_273_1.frameCnt_ <= 1 then
				arg_273_1.dialog_:SetActive(false)
			end

			local var_276_43 = 2
			local var_276_44 = 0.95

			if var_276_43 < arg_273_1.time_ and arg_273_1.time_ <= var_276_43 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				arg_273_1.dialog_:SetActive(true)

				arg_273_1.dialogCg_.alpha = 0

				local var_276_45 = LeanTween.value(arg_273_1.dialog_, 0, 1, 0.3)

				var_276_45:setOnUpdate(LuaHelper.FloatAction(function(arg_277_0)
					arg_273_1.dialogCg_.alpha = arg_277_0
				end))
				var_276_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_273_1.dialog_)
					var_276_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_273_1.duration_ = arg_273_1.duration_ + 0.3

				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_46 = arg_273_1:GetWordFromCfg(1107403067)
				local var_276_47 = arg_273_1:FormatText(var_276_46.content)

				arg_273_1.text_.text = var_276_47

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_48 = 38
				local var_276_49 = utf8.len(var_276_47)
				local var_276_50 = var_276_48 <= 0 and var_276_44 or var_276_44 * (var_276_49 / var_276_48)

				if var_276_50 > 0 and var_276_44 < var_276_50 then
					arg_273_1.talkMaxDuration = var_276_50
					var_276_43 = var_276_43 + 0.3

					if var_276_50 + var_276_43 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_50 + var_276_43
					end
				end

				arg_273_1.text_.text = var_276_47
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_51 = var_276_43 + 0.3
			local var_276_52 = math.max(var_276_44, arg_273_1.talkMaxDuration)

			if var_276_51 <= arg_273_1.time_ and arg_273_1.time_ < var_276_51 + var_276_52 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_51) / var_276_52

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_51 + var_276_52 and arg_273_1.time_ < var_276_51 + var_276_52 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play1107403068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1107403068
		arg_279_1.duration_ = 6.23

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1107403069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1074ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos1074ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(0, -1.055, -6.12)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1074ui_story, var_282_4, var_282_3)

				local var_282_5 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_5.x, var_282_5.y, var_282_5.z)

				local var_282_6 = var_282_0.localEulerAngles

				var_282_6.z = 0
				var_282_6.x = 0
				var_282_0.localEulerAngles = var_282_6
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_282_7 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_7.x, var_282_7.y, var_282_7.z)

				local var_282_8 = var_282_0.localEulerAngles

				var_282_8.z = 0
				var_282_8.x = 0
				var_282_0.localEulerAngles = var_282_8
			end

			local var_282_9 = arg_279_1.actors_["1074ui_story"]
			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect1074ui_story == nil then
				arg_279_1.var_.characterEffect1074ui_story = var_282_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_11 = 0.1

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 and not isNil(var_282_9) then
				local var_282_12 = (arg_279_1.time_ - var_282_10) / var_282_11

				if arg_279_1.var_.characterEffect1074ui_story and not isNil(var_282_9) then
					arg_279_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect1074ui_story then
				arg_279_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_282_13 = 0
			local var_282_14 = 0.8

			if var_282_13 < arg_279_1.time_ and arg_279_1.time_ <= var_282_13 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0

				arg_279_1.dialog_:SetActive(true)

				arg_279_1.dialogCg_.alpha = 0

				local var_282_15 = LeanTween.value(arg_279_1.dialog_, 0, 1, 0.3)

				var_282_15:setOnUpdate(LuaHelper.FloatAction(function(arg_283_0)
					arg_279_1.dialogCg_.alpha = arg_283_0
				end))
				var_282_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_279_1.dialog_)
					var_282_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_279_1.duration_ = arg_279_1.duration_ + 0.3

				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_16 = arg_279_1:FormatText(StoryNameCfg[410].name)

				arg_279_1.leftNameTxt_.text = var_282_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_17 = arg_279_1:GetWordFromCfg(1107403068)
				local var_282_18 = arg_279_1:FormatText(var_282_17.content)

				arg_279_1.text_.text = var_282_18

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_19 = 32
				local var_282_20 = utf8.len(var_282_18)
				local var_282_21 = var_282_19 <= 0 and var_282_14 or var_282_14 * (var_282_20 / var_282_19)

				if var_282_21 > 0 and var_282_14 < var_282_21 then
					arg_279_1.talkMaxDuration = var_282_21
					var_282_13 = var_282_13 + 0.3

					if var_282_21 + var_282_13 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_21 + var_282_13
					end
				end

				arg_279_1.text_.text = var_282_18
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403068", "story_v_side_new_1107403.awb") ~= 0 then
					local var_282_22 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403068", "story_v_side_new_1107403.awb") / 1000

					if var_282_22 + var_282_13 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_22 + var_282_13
					end

					if var_282_17.prefab_name ~= "" and arg_279_1.actors_[var_282_17.prefab_name] ~= nil then
						local var_282_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_17.prefab_name].transform, "story_v_side_new_1107403", "1107403068", "story_v_side_new_1107403.awb")

						arg_279_1:RecordAudio("1107403068", var_282_23)
						arg_279_1:RecordAudio("1107403068", var_282_23)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403068", "story_v_side_new_1107403.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403068", "story_v_side_new_1107403.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_24 = var_282_13 + 0.3
			local var_282_25 = math.max(var_282_14, arg_279_1.talkMaxDuration)

			if var_282_24 <= arg_279_1.time_ and arg_279_1.time_ < var_282_24 + var_282_25 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_24) / var_282_25

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_24 + var_282_25 and arg_279_1.time_ < var_282_24 + var_282_25 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play1107403069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1107403069
		arg_285_1.duration_ = 2.9

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1107403070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_288_1 = 0
			local var_288_2 = 0.3

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_3 = arg_285_1:FormatText(StoryNameCfg[410].name)

				arg_285_1.leftNameTxt_.text = var_288_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_4 = arg_285_1:GetWordFromCfg(1107403069)
				local var_288_5 = arg_285_1:FormatText(var_288_4.content)

				arg_285_1.text_.text = var_288_5

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_6 = 12
				local var_288_7 = utf8.len(var_288_5)
				local var_288_8 = var_288_6 <= 0 and var_288_2 or var_288_2 * (var_288_7 / var_288_6)

				if var_288_8 > 0 and var_288_2 < var_288_8 then
					arg_285_1.talkMaxDuration = var_288_8

					if var_288_8 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_1
					end
				end

				arg_285_1.text_.text = var_288_5
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403069", "story_v_side_new_1107403.awb") ~= 0 then
					local var_288_9 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403069", "story_v_side_new_1107403.awb") / 1000

					if var_288_9 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_1
					end

					if var_288_4.prefab_name ~= "" and arg_285_1.actors_[var_288_4.prefab_name] ~= nil then
						local var_288_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_4.prefab_name].transform, "story_v_side_new_1107403", "1107403069", "story_v_side_new_1107403.awb")

						arg_285_1:RecordAudio("1107403069", var_288_10)
						arg_285_1:RecordAudio("1107403069", var_288_10)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403069", "story_v_side_new_1107403.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403069", "story_v_side_new_1107403.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_11 = math.max(var_288_2, arg_285_1.talkMaxDuration)

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_11 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_1) / var_288_11

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_1 + var_288_11 and arg_285_1.time_ < var_288_1 + var_288_11 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1107403070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1107403070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1107403071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1074ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1074ui_story == nil then
				arg_289_1.var_.characterEffect1074ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.1

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1074ui_story and not isNil(var_292_0) then
					local var_292_4 = Mathf.Lerp(0, 0.5, var_292_3)

					arg_289_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1074ui_story.fillRatio = var_292_4
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1074ui_story then
				local var_292_5 = 0.5

				arg_289_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1074ui_story.fillRatio = var_292_5
			end

			local var_292_6 = 0
			local var_292_7 = 0.15

			if var_292_6 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_8 = arg_289_1:FormatText(StoryNameCfg[7].name)

				arg_289_1.leftNameTxt_.text = var_292_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_9 = arg_289_1:GetWordFromCfg(1107403070)
				local var_292_10 = arg_289_1:FormatText(var_292_9.content)

				arg_289_1.text_.text = var_292_10

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_11 = 6
				local var_292_12 = utf8.len(var_292_10)
				local var_292_13 = var_292_11 <= 0 and var_292_7 or var_292_7 * (var_292_12 / var_292_11)

				if var_292_13 > 0 and var_292_7 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_6
					end
				end

				arg_289_1.text_.text = var_292_10
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_14 = math.max(var_292_7, arg_289_1.talkMaxDuration)

			if var_292_6 <= arg_289_1.time_ and arg_289_1.time_ < var_292_6 + var_292_14 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_6) / var_292_14

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_6 + var_292_14 and arg_289_1.time_ < var_292_6 + var_292_14 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1107403071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1107403071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1107403072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 0.825

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_2 = arg_293_1:FormatText(StoryNameCfg[7].name)

				arg_293_1.leftNameTxt_.text = var_296_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_3 = arg_293_1:GetWordFromCfg(1107403071)
				local var_296_4 = arg_293_1:FormatText(var_296_3.content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 33
				local var_296_6 = utf8.len(var_296_4)
				local var_296_7 = var_296_5 <= 0 and var_296_1 or var_296_1 * (var_296_6 / var_296_5)

				if var_296_7 > 0 and var_296_1 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_4
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_8 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_8 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_8

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_8 and arg_293_1.time_ < var_296_0 + var_296_8 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1107403072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1107403072
		arg_297_1.duration_ = 4.97

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1107403073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1074ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1074ui_story == nil then
				arg_297_1.var_.characterEffect1074ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.1

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect1074ui_story and not isNil(var_300_0) then
					arg_297_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1074ui_story then
				arg_297_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_300_4 = 0

			if var_300_4 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_300_5 = 0
			local var_300_6 = 0.225

			if var_300_5 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_7 = arg_297_1:FormatText(StoryNameCfg[410].name)

				arg_297_1.leftNameTxt_.text = var_300_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_8 = arg_297_1:GetWordFromCfg(1107403072)
				local var_300_9 = arg_297_1:FormatText(var_300_8.content)

				arg_297_1.text_.text = var_300_9

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_10 = 9
				local var_300_11 = utf8.len(var_300_9)
				local var_300_12 = var_300_10 <= 0 and var_300_6 or var_300_6 * (var_300_11 / var_300_10)

				if var_300_12 > 0 and var_300_6 < var_300_12 then
					arg_297_1.talkMaxDuration = var_300_12

					if var_300_12 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_12 + var_300_5
					end
				end

				arg_297_1.text_.text = var_300_9
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403072", "story_v_side_new_1107403.awb") ~= 0 then
					local var_300_13 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403072", "story_v_side_new_1107403.awb") / 1000

					if var_300_13 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_5
					end

					if var_300_8.prefab_name ~= "" and arg_297_1.actors_[var_300_8.prefab_name] ~= nil then
						local var_300_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_8.prefab_name].transform, "story_v_side_new_1107403", "1107403072", "story_v_side_new_1107403.awb")

						arg_297_1:RecordAudio("1107403072", var_300_14)
						arg_297_1:RecordAudio("1107403072", var_300_14)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403072", "story_v_side_new_1107403.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403072", "story_v_side_new_1107403.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_15 = math.max(var_300_6, arg_297_1.talkMaxDuration)

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_15 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_5) / var_300_15

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_5 + var_300_15 and arg_297_1.time_ < var_300_5 + var_300_15 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1107403073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1107403073
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1107403074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1074ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1074ui_story = var_304_0.localPosition
			end

			local var_304_2 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2
				local var_304_4 = Vector3.New(0, 100, 0)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1074ui_story, var_304_4, var_304_3)

				local var_304_5 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_5.x, var_304_5.y, var_304_5.z)

				local var_304_6 = var_304_0.localEulerAngles

				var_304_6.z = 0
				var_304_6.x = 0
				var_304_0.localEulerAngles = var_304_6
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0, 100, 0)

				local var_304_7 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_7.x, var_304_7.y, var_304_7.z)

				local var_304_8 = var_304_0.localEulerAngles

				var_304_8.z = 0
				var_304_8.x = 0
				var_304_0.localEulerAngles = var_304_8
			end

			local var_304_9 = 0
			local var_304_10 = 1.375

			if var_304_9 < arg_301_1.time_ and arg_301_1.time_ <= var_304_9 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_11 = arg_301_1:GetWordFromCfg(1107403073)
				local var_304_12 = arg_301_1:FormatText(var_304_11.content)

				arg_301_1.text_.text = var_304_12

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_13 = 55
				local var_304_14 = utf8.len(var_304_12)
				local var_304_15 = var_304_13 <= 0 and var_304_10 or var_304_10 * (var_304_14 / var_304_13)

				if var_304_15 > 0 and var_304_10 < var_304_15 then
					arg_301_1.talkMaxDuration = var_304_15

					if var_304_15 + var_304_9 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_15 + var_304_9
					end
				end

				arg_301_1.text_.text = var_304_12
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_16 = math.max(var_304_10, arg_301_1.talkMaxDuration)

			if var_304_9 <= arg_301_1.time_ and arg_301_1.time_ < var_304_9 + var_304_16 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_9) / var_304_16

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_9 + var_304_16 and arg_301_1.time_ < var_304_9 + var_304_16 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play1107403074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1107403074
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1107403075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.55

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(1107403074)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 22
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_8 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_8 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_8

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_8 and arg_305_1.time_ < var_308_0 + var_308_8 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1107403075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1107403075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1107403076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 1.3

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[7].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(1107403075)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 52
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_8 and arg_309_1.time_ < var_312_0 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1107403076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1107403076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1107403077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.575

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_2 = arg_313_1:FormatText(StoryNameCfg[7].name)

				arg_313_1.leftNameTxt_.text = var_316_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:GetWordFromCfg(1107403076)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 23
				local var_316_6 = utf8.len(var_316_4)
				local var_316_7 = var_316_5 <= 0 and var_316_1 or var_316_1 * (var_316_6 / var_316_5)

				if var_316_7 > 0 and var_316_1 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_8 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_8 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_8

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_8 and arg_313_1.time_ < var_316_0 + var_316_8 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1107403077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1107403077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1107403078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 1.025

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(1107403077)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 41
				local var_320_5 = utf8.len(var_320_3)
				local var_320_6 = var_320_4 <= 0 and var_320_1 or var_320_1 * (var_320_5 / var_320_4)

				if var_320_6 > 0 and var_320_1 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_7 and arg_317_1.time_ < var_320_0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1107403078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1107403078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1107403079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.825

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[7].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_3 = arg_321_1:GetWordFromCfg(1107403078)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 33
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
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_8 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_8 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_8

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_8 and arg_321_1.time_ < var_324_0 + var_324_8 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1107403079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1107403079
		arg_325_1.duration_ = 1

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"

			SetActive(arg_325_1.choicesGo_, true)

			for iter_326_0, iter_326_1 in ipairs(arg_325_1.choices_) do
				local var_326_0 = iter_326_0 <= 1

				SetActive(iter_326_1.go, var_326_0)
			end

			arg_325_1.choices_[1].txt.text = arg_325_1:FormatText(StoryChoiceCfg[1020].name)
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1107403080(arg_325_1)
			end

			arg_325_1:RecordChoiceLog(1107403079, 1020)
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			return
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1107403080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1107403080
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1107403081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 0.5

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_2 = arg_329_1:FormatText(StoryNameCfg[7].name)

				arg_329_1.leftNameTxt_.text = var_332_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:GetWordFromCfg(1107403080)
				local var_332_4 = arg_329_1:FormatText(var_332_3.content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 20
				local var_332_6 = utf8.len(var_332_4)
				local var_332_7 = var_332_5 <= 0 and var_332_1 or var_332_1 * (var_332_6 / var_332_5)

				if var_332_7 > 0 and var_332_1 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_4
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_8 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_8 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_8

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_8 and arg_329_1.time_ < var_332_0 + var_332_8 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1107403081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1107403081
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1107403082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0
			local var_336_1 = 0.4

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_2 = arg_333_1:FormatText(StoryNameCfg[7].name)

				arg_333_1.leftNameTxt_.text = var_336_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_3 = arg_333_1:GetWordFromCfg(1107403081)
				local var_336_4 = arg_333_1:FormatText(var_336_3.content)

				arg_333_1.text_.text = var_336_4

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 16
				local var_336_6 = utf8.len(var_336_4)
				local var_336_7 = var_336_5 <= 0 and var_336_1 or var_336_1 * (var_336_6 / var_336_5)

				if var_336_7 > 0 and var_336_1 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_0
					end
				end

				arg_333_1.text_.text = var_336_4
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_8 = math.max(var_336_1, arg_333_1.talkMaxDuration)

			if var_336_0 <= arg_333_1.time_ and arg_333_1.time_ < var_336_0 + var_336_8 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_0) / var_336_8

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_0 + var_336_8 and arg_333_1.time_ < var_336_0 + var_336_8 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1107403082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1107403082
		arg_337_1.duration_ = 5.07

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1107403083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1074ui_story"].transform
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.var_.moveOldPos1074ui_story = var_340_0.localPosition

				local var_340_2 = "1074ui_story"

				arg_337_1:ShowWeapon(arg_337_1.var_[var_340_2 .. "Animator"].transform, false)
			end

			local var_340_3 = 0.001

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_3 then
				local var_340_4 = (arg_337_1.time_ - var_340_1) / var_340_3
				local var_340_5 = Vector3.New(0, -1.055, -6.12)

				var_340_0.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1074ui_story, var_340_5, var_340_4)

				local var_340_6 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_6.x, var_340_6.y, var_340_6.z)

				local var_340_7 = var_340_0.localEulerAngles

				var_340_7.z = 0
				var_340_7.x = 0
				var_340_0.localEulerAngles = var_340_7
			end

			if arg_337_1.time_ >= var_340_1 + var_340_3 and arg_337_1.time_ < var_340_1 + var_340_3 + arg_340_0 then
				var_340_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_340_8 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_8.x, var_340_8.y, var_340_8.z)

				local var_340_9 = var_340_0.localEulerAngles

				var_340_9.z = 0
				var_340_9.x = 0
				var_340_0.localEulerAngles = var_340_9
			end

			local var_340_10 = arg_337_1.actors_["1074ui_story"]
			local var_340_11 = 0

			if var_340_11 < arg_337_1.time_ and arg_337_1.time_ <= var_340_11 + arg_340_0 and not isNil(var_340_10) and arg_337_1.var_.characterEffect1074ui_story == nil then
				arg_337_1.var_.characterEffect1074ui_story = var_340_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_12 = 0.1

			if var_340_11 <= arg_337_1.time_ and arg_337_1.time_ < var_340_11 + var_340_12 and not isNil(var_340_10) then
				local var_340_13 = (arg_337_1.time_ - var_340_11) / var_340_12

				if arg_337_1.var_.characterEffect1074ui_story and not isNil(var_340_10) then
					arg_337_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_11 + var_340_12 and arg_337_1.time_ < var_340_11 + var_340_12 + arg_340_0 and not isNil(var_340_10) and arg_337_1.var_.characterEffect1074ui_story then
				arg_337_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_340_14 = 0
			local var_340_15 = 0.675

			if var_340_14 < arg_337_1.time_ and arg_337_1.time_ <= var_340_14 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_16 = arg_337_1:FormatText(StoryNameCfg[410].name)

				arg_337_1.leftNameTxt_.text = var_340_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_17 = arg_337_1:GetWordFromCfg(1107403082)
				local var_340_18 = arg_337_1:FormatText(var_340_17.content)

				arg_337_1.text_.text = var_340_18

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_19 = 27
				local var_340_20 = utf8.len(var_340_18)
				local var_340_21 = var_340_19 <= 0 and var_340_15 or var_340_15 * (var_340_20 / var_340_19)

				if var_340_21 > 0 and var_340_15 < var_340_21 then
					arg_337_1.talkMaxDuration = var_340_21

					if var_340_21 + var_340_14 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_21 + var_340_14
					end
				end

				arg_337_1.text_.text = var_340_18
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403082", "story_v_side_new_1107403.awb") ~= 0 then
					local var_340_22 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403082", "story_v_side_new_1107403.awb") / 1000

					if var_340_22 + var_340_14 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_22 + var_340_14
					end

					if var_340_17.prefab_name ~= "" and arg_337_1.actors_[var_340_17.prefab_name] ~= nil then
						local var_340_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_17.prefab_name].transform, "story_v_side_new_1107403", "1107403082", "story_v_side_new_1107403.awb")

						arg_337_1:RecordAudio("1107403082", var_340_23)
						arg_337_1:RecordAudio("1107403082", var_340_23)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403082", "story_v_side_new_1107403.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403082", "story_v_side_new_1107403.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_24 = math.max(var_340_15, arg_337_1.talkMaxDuration)

			if var_340_14 <= arg_337_1.time_ and arg_337_1.time_ < var_340_14 + var_340_24 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_14) / var_340_24

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_14 + var_340_24 and arg_337_1.time_ < var_340_14 + var_340_24 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play1107403083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1107403083
		arg_341_1.duration_ = 1

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"

			SetActive(arg_341_1.choicesGo_, true)

			for iter_342_0, iter_342_1 in ipairs(arg_341_1.choices_) do
				local var_342_0 = iter_342_0 <= 1

				SetActive(iter_342_1.go, var_342_0)
			end

			arg_341_1.choices_[1].txt.text = arg_341_1:FormatText(StoryChoiceCfg[1021].name)
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1107403084(arg_341_1)
			end

			arg_341_1:RecordChoiceLog(1107403083, 1021)
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1074ui_story"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1074ui_story == nil then
				arg_341_1.var_.characterEffect1074ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.1

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.characterEffect1074ui_story and not isNil(var_344_0) then
					local var_344_4 = Mathf.Lerp(0, 0.5, var_344_3)

					arg_341_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1074ui_story.fillRatio = var_344_4
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1074ui_story then
				local var_344_5 = 0.5

				arg_341_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1074ui_story.fillRatio = var_344_5
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play1107403084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1107403084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1107403085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0
			local var_348_1 = 0.725

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_2 = arg_345_1:FormatText(StoryNameCfg[7].name)

				arg_345_1.leftNameTxt_.text = var_348_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_3 = arg_345_1:GetWordFromCfg(1107403084)
				local var_348_4 = arg_345_1:FormatText(var_348_3.content)

				arg_345_1.text_.text = var_348_4

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 29
				local var_348_6 = utf8.len(var_348_4)
				local var_348_7 = var_348_5 <= 0 and var_348_1 or var_348_1 * (var_348_6 / var_348_5)

				if var_348_7 > 0 and var_348_1 < var_348_7 then
					arg_345_1.talkMaxDuration = var_348_7

					if var_348_7 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_7 + var_348_0
					end
				end

				arg_345_1.text_.text = var_348_4
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_8 = math.max(var_348_1, arg_345_1.talkMaxDuration)

			if var_348_0 <= arg_345_1.time_ and arg_345_1.time_ < var_348_0 + var_348_8 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_0) / var_348_8

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_0 + var_348_8 and arg_345_1.time_ < var_348_0 + var_348_8 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1107403085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1107403085
		arg_349_1.duration_ = 1.7

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1107403086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1074ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1074ui_story == nil then
				arg_349_1.var_.characterEffect1074ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.1

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect1074ui_story and not isNil(var_352_0) then
					arg_349_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1074ui_story then
				arg_349_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_352_4 = 0
			local var_352_5 = 0.15

			if var_352_4 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_6 = arg_349_1:FormatText(StoryNameCfg[410].name)

				arg_349_1.leftNameTxt_.text = var_352_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_7 = arg_349_1:GetWordFromCfg(1107403085)
				local var_352_8 = arg_349_1:FormatText(var_352_7.content)

				arg_349_1.text_.text = var_352_8

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_9 = 6
				local var_352_10 = utf8.len(var_352_8)
				local var_352_11 = var_352_9 <= 0 and var_352_5 or var_352_5 * (var_352_10 / var_352_9)

				if var_352_11 > 0 and var_352_5 < var_352_11 then
					arg_349_1.talkMaxDuration = var_352_11

					if var_352_11 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_11 + var_352_4
					end
				end

				arg_349_1.text_.text = var_352_8
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403085", "story_v_side_new_1107403.awb") ~= 0 then
					local var_352_12 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403085", "story_v_side_new_1107403.awb") / 1000

					if var_352_12 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_12 + var_352_4
					end

					if var_352_7.prefab_name ~= "" and arg_349_1.actors_[var_352_7.prefab_name] ~= nil then
						local var_352_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_7.prefab_name].transform, "story_v_side_new_1107403", "1107403085", "story_v_side_new_1107403.awb")

						arg_349_1:RecordAudio("1107403085", var_352_13)
						arg_349_1:RecordAudio("1107403085", var_352_13)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403085", "story_v_side_new_1107403.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403085", "story_v_side_new_1107403.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_14 = math.max(var_352_5, arg_349_1.talkMaxDuration)

			if var_352_4 <= arg_349_1.time_ and arg_349_1.time_ < var_352_4 + var_352_14 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_4) / var_352_14

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_4 + var_352_14 and arg_349_1.time_ < var_352_4 + var_352_14 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play1107403086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1107403086
		arg_353_1.duration_ = 1.27

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1107403087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1074ui_story"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1074ui_story == nil then
				arg_353_1.var_.characterEffect1074ui_story = var_356_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.1

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.characterEffect1074ui_story and not isNil(var_356_0) then
					arg_353_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1074ui_story then
				arg_353_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_356_4 = 0
			local var_356_5 = 0.125

			if var_356_4 < arg_353_1.time_ and arg_353_1.time_ <= var_356_4 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_6 = arg_353_1:FormatText(StoryNameCfg[410].name)

				arg_353_1.leftNameTxt_.text = var_356_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_7 = arg_353_1:GetWordFromCfg(1107403086)
				local var_356_8 = arg_353_1:FormatText(var_356_7.content)

				arg_353_1.text_.text = var_356_8

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_9 = 5
				local var_356_10 = utf8.len(var_356_8)
				local var_356_11 = var_356_9 <= 0 and var_356_5 or var_356_5 * (var_356_10 / var_356_9)

				if var_356_11 > 0 and var_356_5 < var_356_11 then
					arg_353_1.talkMaxDuration = var_356_11

					if var_356_11 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_11 + var_356_4
					end
				end

				arg_353_1.text_.text = var_356_8
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403086", "story_v_side_new_1107403.awb") ~= 0 then
					local var_356_12 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403086", "story_v_side_new_1107403.awb") / 1000

					if var_356_12 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_12 + var_356_4
					end

					if var_356_7.prefab_name ~= "" and arg_353_1.actors_[var_356_7.prefab_name] ~= nil then
						local var_356_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_7.prefab_name].transform, "story_v_side_new_1107403", "1107403086", "story_v_side_new_1107403.awb")

						arg_353_1:RecordAudio("1107403086", var_356_13)
						arg_353_1:RecordAudio("1107403086", var_356_13)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403086", "story_v_side_new_1107403.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403086", "story_v_side_new_1107403.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_14 = math.max(var_356_5, arg_353_1.talkMaxDuration)

			if var_356_4 <= arg_353_1.time_ and arg_353_1.time_ < var_356_4 + var_356_14 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_4) / var_356_14

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_4 + var_356_14 and arg_353_1.time_ < var_356_4 + var_356_14 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1107403087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1107403087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1107403088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1074ui_story"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos1074ui_story = var_360_0.localPosition

				local var_360_2 = "1074ui_story"

				arg_357_1:ShowWeapon(arg_357_1.var_[var_360_2 .. "Animator"].transform, false)
			end

			local var_360_3 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_3 then
				local var_360_4 = (arg_357_1.time_ - var_360_1) / var_360_3
				local var_360_5 = Vector3.New(0, 100, 0)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1074ui_story, var_360_5, var_360_4)

				local var_360_6 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_6.x, var_360_6.y, var_360_6.z)

				local var_360_7 = var_360_0.localEulerAngles

				var_360_7.z = 0
				var_360_7.x = 0
				var_360_0.localEulerAngles = var_360_7
			end

			if arg_357_1.time_ >= var_360_1 + var_360_3 and arg_357_1.time_ < var_360_1 + var_360_3 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(0, 100, 0)

				local var_360_8 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_8.x, var_360_8.y, var_360_8.z)

				local var_360_9 = var_360_0.localEulerAngles

				var_360_9.z = 0
				var_360_9.x = 0
				var_360_0.localEulerAngles = var_360_9
			end

			local var_360_10 = 0
			local var_360_11 = 0.475

			if var_360_10 < arg_357_1.time_ and arg_357_1.time_ <= var_360_10 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0

				arg_357_1.dialog_:SetActive(true)

				arg_357_1.dialogCg_.alpha = 0

				local var_360_12 = LeanTween.value(arg_357_1.dialog_, 0, 1, 0.3)

				var_360_12:setOnUpdate(LuaHelper.FloatAction(function(arg_361_0)
					arg_357_1.dialogCg_.alpha = arg_361_0
				end))
				var_360_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_357_1.dialog_)
					var_360_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_357_1.duration_ = arg_357_1.duration_ + 0.3

				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_13 = arg_357_1:FormatText(StoryNameCfg[7].name)

				arg_357_1.leftNameTxt_.text = var_360_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_14 = arg_357_1:GetWordFromCfg(1107403087)
				local var_360_15 = arg_357_1:FormatText(var_360_14.content)

				arg_357_1.text_.text = var_360_15

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_16 = 19
				local var_360_17 = utf8.len(var_360_15)
				local var_360_18 = var_360_16 <= 0 and var_360_11 or var_360_11 * (var_360_17 / var_360_16)

				if var_360_18 > 0 and var_360_11 < var_360_18 then
					arg_357_1.talkMaxDuration = var_360_18
					var_360_10 = var_360_10 + 0.3

					if var_360_18 + var_360_10 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_18 + var_360_10
					end
				end

				arg_357_1.text_.text = var_360_15
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_19 = var_360_10 + 0.3
			local var_360_20 = math.max(var_360_11, arg_357_1.talkMaxDuration)

			if var_360_19 <= arg_357_1.time_ and arg_357_1.time_ < var_360_19 + var_360_20 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_19) / var_360_20

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_19 + var_360_20 and arg_357_1.time_ < var_360_19 + var_360_20 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play1107403088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1107403088
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1107403089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 1.05

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_2 = arg_363_1:GetWordFromCfg(1107403088)
				local var_366_3 = arg_363_1:FormatText(var_366_2.content)

				arg_363_1.text_.text = var_366_3

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 42
				local var_366_5 = utf8.len(var_366_3)
				local var_366_6 = var_366_4 <= 0 and var_366_1 or var_366_1 * (var_366_5 / var_366_4)

				if var_366_6 > 0 and var_366_1 < var_366_6 then
					arg_363_1.talkMaxDuration = var_366_6

					if var_366_6 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_6 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_3
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_7 and arg_363_1.time_ < var_366_0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1107403089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1107403089
		arg_367_1.duration_ = 2

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1107403090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1074ui_story"].transform
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.var_.moveOldPos1074ui_story = var_370_0.localPosition
			end

			local var_370_2 = 0.001

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2
				local var_370_4 = Vector3.New(0, -1.055, -6.12)

				var_370_0.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1074ui_story, var_370_4, var_370_3)

				local var_370_5 = manager.ui.mainCamera.transform.position - var_370_0.position

				var_370_0.forward = Vector3.New(var_370_5.x, var_370_5.y, var_370_5.z)

				local var_370_6 = var_370_0.localEulerAngles

				var_370_6.z = 0
				var_370_6.x = 0
				var_370_0.localEulerAngles = var_370_6
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 then
				var_370_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_370_7 = manager.ui.mainCamera.transform.position - var_370_0.position

				var_370_0.forward = Vector3.New(var_370_7.x, var_370_7.y, var_370_7.z)

				local var_370_8 = var_370_0.localEulerAngles

				var_370_8.z = 0
				var_370_8.x = 0
				var_370_0.localEulerAngles = var_370_8
			end

			local var_370_9 = arg_367_1.actors_["1074ui_story"]
			local var_370_10 = 0

			if var_370_10 < arg_367_1.time_ and arg_367_1.time_ <= var_370_10 + arg_370_0 and not isNil(var_370_9) and arg_367_1.var_.characterEffect1074ui_story == nil then
				arg_367_1.var_.characterEffect1074ui_story = var_370_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_11 = 0.1

			if var_370_10 <= arg_367_1.time_ and arg_367_1.time_ < var_370_10 + var_370_11 and not isNil(var_370_9) then
				local var_370_12 = (arg_367_1.time_ - var_370_10) / var_370_11

				if arg_367_1.var_.characterEffect1074ui_story and not isNil(var_370_9) then
					arg_367_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= var_370_10 + var_370_11 and arg_367_1.time_ < var_370_10 + var_370_11 + arg_370_0 and not isNil(var_370_9) and arg_367_1.var_.characterEffect1074ui_story then
				arg_367_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_370_13 = 0

			if var_370_13 < arg_367_1.time_ and arg_367_1.time_ <= var_370_13 + arg_370_0 then
				arg_367_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_370_14 = 0

			if var_370_14 < arg_367_1.time_ and arg_367_1.time_ <= var_370_14 + arg_370_0 then
				arg_367_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_370_15 = 0
			local var_370_16 = 0.1

			if var_370_15 < arg_367_1.time_ and arg_367_1.time_ <= var_370_15 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_17 = arg_367_1:FormatText(StoryNameCfg[410].name)

				arg_367_1.leftNameTxt_.text = var_370_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_18 = arg_367_1:GetWordFromCfg(1107403089)
				local var_370_19 = arg_367_1:FormatText(var_370_18.content)

				arg_367_1.text_.text = var_370_19

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_20 = 4
				local var_370_21 = utf8.len(var_370_19)
				local var_370_22 = var_370_20 <= 0 and var_370_16 or var_370_16 * (var_370_21 / var_370_20)

				if var_370_22 > 0 and var_370_16 < var_370_22 then
					arg_367_1.talkMaxDuration = var_370_22

					if var_370_22 + var_370_15 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_22 + var_370_15
					end
				end

				arg_367_1.text_.text = var_370_19
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403089", "story_v_side_new_1107403.awb") ~= 0 then
					local var_370_23 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403089", "story_v_side_new_1107403.awb") / 1000

					if var_370_23 + var_370_15 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_23 + var_370_15
					end

					if var_370_18.prefab_name ~= "" and arg_367_1.actors_[var_370_18.prefab_name] ~= nil then
						local var_370_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_18.prefab_name].transform, "story_v_side_new_1107403", "1107403089", "story_v_side_new_1107403.awb")

						arg_367_1:RecordAudio("1107403089", var_370_24)
						arg_367_1:RecordAudio("1107403089", var_370_24)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403089", "story_v_side_new_1107403.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403089", "story_v_side_new_1107403.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_25 = math.max(var_370_16, arg_367_1.talkMaxDuration)

			if var_370_15 <= arg_367_1.time_ and arg_367_1.time_ < var_370_15 + var_370_25 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_15) / var_370_25

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_15 + var_370_25 and arg_367_1.time_ < var_370_15 + var_370_25 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play1107403090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1107403090
		arg_371_1.duration_ = 6.97

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1107403091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 1

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.allBtn_.enabled = false
			end

			local var_374_1 = 0.666666666666665

			if arg_371_1.time_ >= var_374_0 + var_374_1 and arg_371_1.time_ < var_374_0 + var_374_1 + arg_374_0 then
				arg_371_1.allBtn_.enabled = true
			end

			local var_374_2 = 1

			if var_374_2 < arg_371_1.time_ and arg_371_1.time_ <= var_374_2 + arg_374_0 then
				local var_374_3 = manager.ui.mainCamera.transform.localPosition
				local var_374_4 = Vector3.New(0, 0, 10) + Vector3.New(var_374_3.x, var_374_3.y, 0)
				local var_374_5 = arg_371_1.bgs_.ST47

				var_374_5.transform.localPosition = var_374_4
				var_374_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_374_6 = var_374_5:GetComponent("SpriteRenderer")

				if var_374_6 and var_374_6.sprite then
					local var_374_7 = (var_374_5.transform.localPosition - var_374_3).z
					local var_374_8 = manager.ui.mainCameraCom_
					local var_374_9 = 2 * var_374_7 * Mathf.Tan(var_374_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_374_10 = var_374_9 * var_374_8.aspect
					local var_374_11 = var_374_6.sprite.bounds.size.x
					local var_374_12 = var_374_6.sprite.bounds.size.y
					local var_374_13 = var_374_10 / var_374_11
					local var_374_14 = var_374_9 / var_374_12
					local var_374_15 = var_374_14 < var_374_13 and var_374_13 or var_374_14

					var_374_5.transform.localScale = Vector3.New(var_374_15, var_374_15, 0)
				end

				for iter_374_0, iter_374_1 in pairs(arg_371_1.bgs_) do
					if iter_374_0 ~= "ST47" then
						iter_374_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_374_16 = 0

			if var_374_16 < arg_371_1.time_ and arg_371_1.time_ <= var_374_16 + arg_374_0 then
				arg_371_1.mask_.enabled = true
				arg_371_1.mask_.raycastTarget = true

				arg_371_1:SetGaussion(false)
			end

			local var_374_17 = 1

			if var_374_16 <= arg_371_1.time_ and arg_371_1.time_ < var_374_16 + var_374_17 then
				local var_374_18 = (arg_371_1.time_ - var_374_16) / var_374_17
				local var_374_19 = Color.New(0, 0, 0)

				var_374_19.a = Mathf.Lerp(0, 1, var_374_18)
				arg_371_1.mask_.color = var_374_19
			end

			if arg_371_1.time_ >= var_374_16 + var_374_17 and arg_371_1.time_ < var_374_16 + var_374_17 + arg_374_0 then
				local var_374_20 = Color.New(0, 0, 0)

				var_374_20.a = 1
				arg_371_1.mask_.color = var_374_20
			end

			local var_374_21 = 1

			if var_374_21 < arg_371_1.time_ and arg_371_1.time_ <= var_374_21 + arg_374_0 then
				arg_371_1.mask_.enabled = true
				arg_371_1.mask_.raycastTarget = true

				arg_371_1:SetGaussion(false)
			end

			local var_374_22 = 1

			if var_374_21 <= arg_371_1.time_ and arg_371_1.time_ < var_374_21 + var_374_22 then
				local var_374_23 = (arg_371_1.time_ - var_374_21) / var_374_22
				local var_374_24 = Color.New(0, 0, 0)

				var_374_24.a = Mathf.Lerp(1, 0, var_374_23)
				arg_371_1.mask_.color = var_374_24
			end

			if arg_371_1.time_ >= var_374_21 + var_374_22 and arg_371_1.time_ < var_374_21 + var_374_22 + arg_374_0 then
				local var_374_25 = Color.New(0, 0, 0)
				local var_374_26 = 0

				arg_371_1.mask_.enabled = false
				var_374_25.a = var_374_26
				arg_371_1.mask_.color = var_374_25
			end

			local var_374_27 = arg_371_1.actors_["1074ui_story"].transform
			local var_374_28 = 0.966

			if var_374_28 < arg_371_1.time_ and arg_371_1.time_ <= var_374_28 + arg_374_0 then
				arg_371_1.var_.moveOldPos1074ui_story = var_374_27.localPosition
			end

			local var_374_29 = 0.001

			if var_374_28 <= arg_371_1.time_ and arg_371_1.time_ < var_374_28 + var_374_29 then
				local var_374_30 = (arg_371_1.time_ - var_374_28) / var_374_29
				local var_374_31 = Vector3.New(0, 100, 0)

				var_374_27.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1074ui_story, var_374_31, var_374_30)

				local var_374_32 = manager.ui.mainCamera.transform.position - var_374_27.position

				var_374_27.forward = Vector3.New(var_374_32.x, var_374_32.y, var_374_32.z)

				local var_374_33 = var_374_27.localEulerAngles

				var_374_33.z = 0
				var_374_33.x = 0
				var_374_27.localEulerAngles = var_374_33
			end

			if arg_371_1.time_ >= var_374_28 + var_374_29 and arg_371_1.time_ < var_374_28 + var_374_29 + arg_374_0 then
				var_374_27.localPosition = Vector3.New(0, 100, 0)

				local var_374_34 = manager.ui.mainCamera.transform.position - var_374_27.position

				var_374_27.forward = Vector3.New(var_374_34.x, var_374_34.y, var_374_34.z)

				local var_374_35 = var_374_27.localEulerAngles

				var_374_35.z = 0
				var_374_35.x = 0
				var_374_27.localEulerAngles = var_374_35
			end

			if arg_371_1.frameCnt_ <= 1 then
				arg_371_1.dialog_:SetActive(false)
			end

			local var_374_36 = 1.97287236840154
			local var_374_37 = 1.225

			if var_374_36 < arg_371_1.time_ and arg_371_1.time_ <= var_374_36 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0

				arg_371_1.dialog_:SetActive(true)

				arg_371_1.dialogCg_.alpha = 0

				local var_374_38 = LeanTween.value(arg_371_1.dialog_, 0, 1, 0.3)

				var_374_38:setOnUpdate(LuaHelper.FloatAction(function(arg_375_0)
					arg_371_1.dialogCg_.alpha = arg_375_0
				end))
				var_374_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_371_1.dialog_)
					var_374_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_371_1.duration_ = arg_371_1.duration_ + 0.3

				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_39 = arg_371_1:GetWordFromCfg(1107403090)
				local var_374_40 = arg_371_1:FormatText(var_374_39.content)

				arg_371_1.text_.text = var_374_40

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_41 = 56
				local var_374_42 = utf8.len(var_374_40)
				local var_374_43 = var_374_41 <= 0 and var_374_37 or var_374_37 * (var_374_42 / var_374_41)

				if var_374_43 > 0 and var_374_37 < var_374_43 then
					arg_371_1.talkMaxDuration = var_374_43
					var_374_36 = var_374_36 + 0.3

					if var_374_43 + var_374_36 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_43 + var_374_36
					end
				end

				arg_371_1.text_.text = var_374_40
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_44 = var_374_36 + 0.3
			local var_374_45 = math.max(var_374_37, arg_371_1.talkMaxDuration)

			if var_374_44 <= arg_371_1.time_ and arg_371_1.time_ < var_374_44 + var_374_45 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_44) / var_374_45

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_44 + var_374_45 and arg_371_1.time_ < var_374_44 + var_374_45 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play1107403091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1107403091
		arg_377_1.duration_ = 3.6

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1107403092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1074ui_story"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect1074ui_story == nil then
				arg_377_1.var_.characterEffect1074ui_story = var_380_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.1

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 and not isNil(var_380_0) then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.characterEffect1074ui_story and not isNil(var_380_0) then
					arg_377_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect1074ui_story then
				arg_377_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_380_4 = arg_377_1.actors_["1074ui_story"].transform
			local var_380_5 = 0

			if var_380_5 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 then
				arg_377_1.var_.moveOldPos1074ui_story = var_380_4.localPosition

				local var_380_6 = "1074ui_story"

				arg_377_1:ShowWeapon(arg_377_1.var_[var_380_6 .. "Animator"].transform, false)
			end

			local var_380_7 = 0.001

			if var_380_5 <= arg_377_1.time_ and arg_377_1.time_ < var_380_5 + var_380_7 then
				local var_380_8 = (arg_377_1.time_ - var_380_5) / var_380_7
				local var_380_9 = Vector3.New(0, -1.055, -6.12)

				var_380_4.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1074ui_story, var_380_9, var_380_8)

				local var_380_10 = manager.ui.mainCamera.transform.position - var_380_4.position

				var_380_4.forward = Vector3.New(var_380_10.x, var_380_10.y, var_380_10.z)

				local var_380_11 = var_380_4.localEulerAngles

				var_380_11.z = 0
				var_380_11.x = 0
				var_380_4.localEulerAngles = var_380_11
			end

			if arg_377_1.time_ >= var_380_5 + var_380_7 and arg_377_1.time_ < var_380_5 + var_380_7 + arg_380_0 then
				var_380_4.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_380_12 = manager.ui.mainCamera.transform.position - var_380_4.position

				var_380_4.forward = Vector3.New(var_380_12.x, var_380_12.y, var_380_12.z)

				local var_380_13 = var_380_4.localEulerAngles

				var_380_13.z = 0
				var_380_13.x = 0
				var_380_4.localEulerAngles = var_380_13
			end

			local var_380_14 = 0
			local var_380_15 = 1

			if var_380_14 < arg_377_1.time_ and arg_377_1.time_ <= var_380_14 + arg_380_0 then
				local var_380_16 = "stop"
				local var_380_17 = "effect"

				arg_377_1:AudioAction(var_380_16, var_380_17, "se_story_side_1074", "se_story_side_1074_countdow_loop", "")
			end

			local var_380_18 = 0
			local var_380_19 = 0.125

			if var_380_18 < arg_377_1.time_ and arg_377_1.time_ <= var_380_18 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_20 = arg_377_1:FormatText(StoryNameCfg[410].name)

				arg_377_1.leftNameTxt_.text = var_380_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_21 = arg_377_1:GetWordFromCfg(1107403091)
				local var_380_22 = arg_377_1:FormatText(var_380_21.content)

				arg_377_1.text_.text = var_380_22

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_23 = 5
				local var_380_24 = utf8.len(var_380_22)
				local var_380_25 = var_380_23 <= 0 and var_380_19 or var_380_19 * (var_380_24 / var_380_23)

				if var_380_25 > 0 and var_380_19 < var_380_25 then
					arg_377_1.talkMaxDuration = var_380_25

					if var_380_25 + var_380_18 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_25 + var_380_18
					end
				end

				arg_377_1.text_.text = var_380_22
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403091", "story_v_side_new_1107403.awb") ~= 0 then
					local var_380_26 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403091", "story_v_side_new_1107403.awb") / 1000

					if var_380_26 + var_380_18 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_26 + var_380_18
					end

					if var_380_21.prefab_name ~= "" and arg_377_1.actors_[var_380_21.prefab_name] ~= nil then
						local var_380_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_21.prefab_name].transform, "story_v_side_new_1107403", "1107403091", "story_v_side_new_1107403.awb")

						arg_377_1:RecordAudio("1107403091", var_380_27)
						arg_377_1:RecordAudio("1107403091", var_380_27)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403091", "story_v_side_new_1107403.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403091", "story_v_side_new_1107403.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_28 = math.max(var_380_19, arg_377_1.talkMaxDuration)

			if var_380_18 <= arg_377_1.time_ and arg_377_1.time_ < var_380_18 + var_380_28 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_18) / var_380_28

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_18 + var_380_28 and arg_377_1.time_ < var_380_18 + var_380_28 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play1107403092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1107403092
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1107403093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1074ui_story"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1074ui_story == nil then
				arg_381_1.var_.characterEffect1074ui_story = var_384_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.1

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 and not isNil(var_384_0) then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2

				if arg_381_1.var_.characterEffect1074ui_story and not isNil(var_384_0) then
					local var_384_4 = Mathf.Lerp(0, 0.5, var_384_3)

					arg_381_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1074ui_story.fillRatio = var_384_4
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1074ui_story then
				local var_384_5 = 0.5

				arg_381_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1074ui_story.fillRatio = var_384_5
			end

			local var_384_6 = 0
			local var_384_7 = 0.225

			if var_384_6 < arg_381_1.time_ and arg_381_1.time_ <= var_384_6 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_8 = arg_381_1:FormatText(StoryNameCfg[7].name)

				arg_381_1.leftNameTxt_.text = var_384_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_9 = arg_381_1:GetWordFromCfg(1107403092)
				local var_384_10 = arg_381_1:FormatText(var_384_9.content)

				arg_381_1.text_.text = var_384_10

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_11 = 9
				local var_384_12 = utf8.len(var_384_10)
				local var_384_13 = var_384_11 <= 0 and var_384_7 or var_384_7 * (var_384_12 / var_384_11)

				if var_384_13 > 0 and var_384_7 < var_384_13 then
					arg_381_1.talkMaxDuration = var_384_13

					if var_384_13 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_13 + var_384_6
					end
				end

				arg_381_1.text_.text = var_384_10
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_14 = math.max(var_384_7, arg_381_1.talkMaxDuration)

			if var_384_6 <= arg_381_1.time_ and arg_381_1.time_ < var_384_6 + var_384_14 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_6) / var_384_14

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_6 + var_384_14 and arg_381_1.time_ < var_384_6 + var_384_14 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play1107403093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1107403093
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1107403094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0
			local var_388_1 = 0.35

			if var_388_0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_2 = arg_385_1:FormatText(StoryNameCfg[7].name)

				arg_385_1.leftNameTxt_.text = var_388_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_3 = arg_385_1:GetWordFromCfg(1107403093)
				local var_388_4 = arg_385_1:FormatText(var_388_3.content)

				arg_385_1.text_.text = var_388_4

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 14
				local var_388_6 = utf8.len(var_388_4)
				local var_388_7 = var_388_5 <= 0 and var_388_1 or var_388_1 * (var_388_6 / var_388_5)

				if var_388_7 > 0 and var_388_1 < var_388_7 then
					arg_385_1.talkMaxDuration = var_388_7

					if var_388_7 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_7 + var_388_0
					end
				end

				arg_385_1.text_.text = var_388_4
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_8 = math.max(var_388_1, arg_385_1.talkMaxDuration)

			if var_388_0 <= arg_385_1.time_ and arg_385_1.time_ < var_388_0 + var_388_8 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_0) / var_388_8

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_0 + var_388_8 and arg_385_1.time_ < var_388_0 + var_388_8 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1107403094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1107403094
		arg_389_1.duration_ = 2

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1107403095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["1074ui_story"]
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect1074ui_story == nil then
				arg_389_1.var_.characterEffect1074ui_story = var_392_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.1

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 and not isNil(var_392_0) then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2

				if arg_389_1.var_.characterEffect1074ui_story and not isNil(var_392_0) then
					arg_389_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect1074ui_story then
				arg_389_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_392_4 = arg_389_1.actors_["1074ui_story"].transform
			local var_392_5 = 0

			if var_392_5 < arg_389_1.time_ and arg_389_1.time_ <= var_392_5 + arg_392_0 then
				arg_389_1.var_.moveOldPos1074ui_story = var_392_4.localPosition

				local var_392_6 = "1074ui_story"

				arg_389_1:ShowWeapon(arg_389_1.var_[var_392_6 .. "Animator"].transform, false)
			end

			local var_392_7 = 0.001

			if var_392_5 <= arg_389_1.time_ and arg_389_1.time_ < var_392_5 + var_392_7 then
				local var_392_8 = (arg_389_1.time_ - var_392_5) / var_392_7
				local var_392_9 = Vector3.New(0, -1.055, -6.12)

				var_392_4.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1074ui_story, var_392_9, var_392_8)

				local var_392_10 = manager.ui.mainCamera.transform.position - var_392_4.position

				var_392_4.forward = Vector3.New(var_392_10.x, var_392_10.y, var_392_10.z)

				local var_392_11 = var_392_4.localEulerAngles

				var_392_11.z = 0
				var_392_11.x = 0
				var_392_4.localEulerAngles = var_392_11
			end

			if arg_389_1.time_ >= var_392_5 + var_392_7 and arg_389_1.time_ < var_392_5 + var_392_7 + arg_392_0 then
				var_392_4.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_392_12 = manager.ui.mainCamera.transform.position - var_392_4.position

				var_392_4.forward = Vector3.New(var_392_12.x, var_392_12.y, var_392_12.z)

				local var_392_13 = var_392_4.localEulerAngles

				var_392_13.z = 0
				var_392_13.x = 0
				var_392_4.localEulerAngles = var_392_13
			end

			local var_392_14 = 0

			if var_392_14 < arg_389_1.time_ and arg_389_1.time_ <= var_392_14 + arg_392_0 then
				arg_389_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_392_15 = 0
			local var_392_16 = 0.225

			if var_392_15 < arg_389_1.time_ and arg_389_1.time_ <= var_392_15 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_17 = arg_389_1:FormatText(StoryNameCfg[410].name)

				arg_389_1.leftNameTxt_.text = var_392_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_18 = arg_389_1:GetWordFromCfg(1107403094)
				local var_392_19 = arg_389_1:FormatText(var_392_18.content)

				arg_389_1.text_.text = var_392_19

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_20 = 9
				local var_392_21 = utf8.len(var_392_19)
				local var_392_22 = var_392_20 <= 0 and var_392_16 or var_392_16 * (var_392_21 / var_392_20)

				if var_392_22 > 0 and var_392_16 < var_392_22 then
					arg_389_1.talkMaxDuration = var_392_22

					if var_392_22 + var_392_15 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_22 + var_392_15
					end
				end

				arg_389_1.text_.text = var_392_19
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403094", "story_v_side_new_1107403.awb") ~= 0 then
					local var_392_23 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403094", "story_v_side_new_1107403.awb") / 1000

					if var_392_23 + var_392_15 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_23 + var_392_15
					end

					if var_392_18.prefab_name ~= "" and arg_389_1.actors_[var_392_18.prefab_name] ~= nil then
						local var_392_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_18.prefab_name].transform, "story_v_side_new_1107403", "1107403094", "story_v_side_new_1107403.awb")

						arg_389_1:RecordAudio("1107403094", var_392_24)
						arg_389_1:RecordAudio("1107403094", var_392_24)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403094", "story_v_side_new_1107403.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403094", "story_v_side_new_1107403.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_25 = math.max(var_392_16, arg_389_1.talkMaxDuration)

			if var_392_15 <= arg_389_1.time_ and arg_389_1.time_ < var_392_15 + var_392_25 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_15) / var_392_25

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_15 + var_392_25 and arg_389_1.time_ < var_392_15 + var_392_25 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play1107403095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1107403095
		arg_393_1.duration_ = 3.8

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1107403096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0
			local var_396_1 = 0.45

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_2 = arg_393_1:FormatText(StoryNameCfg[410].name)

				arg_393_1.leftNameTxt_.text = var_396_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_3 = arg_393_1:GetWordFromCfg(1107403095)
				local var_396_4 = arg_393_1:FormatText(var_396_3.content)

				arg_393_1.text_.text = var_396_4

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 18
				local var_396_6 = utf8.len(var_396_4)
				local var_396_7 = var_396_5 <= 0 and var_396_1 or var_396_1 * (var_396_6 / var_396_5)

				if var_396_7 > 0 and var_396_1 < var_396_7 then
					arg_393_1.talkMaxDuration = var_396_7

					if var_396_7 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_0
					end
				end

				arg_393_1.text_.text = var_396_4
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403095", "story_v_side_new_1107403.awb") ~= 0 then
					local var_396_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403095", "story_v_side_new_1107403.awb") / 1000

					if var_396_8 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_8 + var_396_0
					end

					if var_396_3.prefab_name ~= "" and arg_393_1.actors_[var_396_3.prefab_name] ~= nil then
						local var_396_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_3.prefab_name].transform, "story_v_side_new_1107403", "1107403095", "story_v_side_new_1107403.awb")

						arg_393_1:RecordAudio("1107403095", var_396_9)
						arg_393_1:RecordAudio("1107403095", var_396_9)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403095", "story_v_side_new_1107403.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403095", "story_v_side_new_1107403.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_10 = math.max(var_396_1, arg_393_1.talkMaxDuration)

			if var_396_0 <= arg_393_1.time_ and arg_393_1.time_ < var_396_0 + var_396_10 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_0) / var_396_10

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_0 + var_396_10 and arg_393_1.time_ < var_396_0 + var_396_10 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play1107403096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1107403096
		arg_397_1.duration_ = 4.5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1107403097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0
			local var_400_1 = 0.45

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_2 = arg_397_1:FormatText(StoryNameCfg[410].name)

				arg_397_1.leftNameTxt_.text = var_400_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_3 = arg_397_1:GetWordFromCfg(1107403096)
				local var_400_4 = arg_397_1:FormatText(var_400_3.content)

				arg_397_1.text_.text = var_400_4

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 18
				local var_400_6 = utf8.len(var_400_4)
				local var_400_7 = var_400_5 <= 0 and var_400_1 or var_400_1 * (var_400_6 / var_400_5)

				if var_400_7 > 0 and var_400_1 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_4
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403096", "story_v_side_new_1107403.awb") ~= 0 then
					local var_400_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403096", "story_v_side_new_1107403.awb") / 1000

					if var_400_8 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_0
					end

					if var_400_3.prefab_name ~= "" and arg_397_1.actors_[var_400_3.prefab_name] ~= nil then
						local var_400_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_3.prefab_name].transform, "story_v_side_new_1107403", "1107403096", "story_v_side_new_1107403.awb")

						arg_397_1:RecordAudio("1107403096", var_400_9)
						arg_397_1:RecordAudio("1107403096", var_400_9)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403096", "story_v_side_new_1107403.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403096", "story_v_side_new_1107403.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_10 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_10

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_10 and arg_397_1.time_ < var_400_0 + var_400_10 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1107403097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1107403097
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1107403098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1074ui_story"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect1074ui_story == nil then
				arg_401_1.var_.characterEffect1074ui_story = var_404_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.1

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 and not isNil(var_404_0) then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.characterEffect1074ui_story and not isNil(var_404_0) then
					local var_404_4 = Mathf.Lerp(0, 0.5, var_404_3)

					arg_401_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1074ui_story.fillRatio = var_404_4
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect1074ui_story then
				local var_404_5 = 0.5

				arg_401_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1074ui_story.fillRatio = var_404_5
			end

			local var_404_6 = 0
			local var_404_7 = 0.1

			if var_404_6 < arg_401_1.time_ and arg_401_1.time_ <= var_404_6 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_8 = arg_401_1:FormatText(StoryNameCfg[7].name)

				arg_401_1.leftNameTxt_.text = var_404_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_9 = arg_401_1:GetWordFromCfg(1107403097)
				local var_404_10 = arg_401_1:FormatText(var_404_9.content)

				arg_401_1.text_.text = var_404_10

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_11 = 4
				local var_404_12 = utf8.len(var_404_10)
				local var_404_13 = var_404_11 <= 0 and var_404_7 or var_404_7 * (var_404_12 / var_404_11)

				if var_404_13 > 0 and var_404_7 < var_404_13 then
					arg_401_1.talkMaxDuration = var_404_13

					if var_404_13 + var_404_6 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_13 + var_404_6
					end
				end

				arg_401_1.text_.text = var_404_10
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_14 = math.max(var_404_7, arg_401_1.talkMaxDuration)

			if var_404_6 <= arg_401_1.time_ and arg_401_1.time_ < var_404_6 + var_404_14 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_6) / var_404_14

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_6 + var_404_14 and arg_401_1.time_ < var_404_6 + var_404_14 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play1107403098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1107403098
		arg_405_1.duration_ = 2.4

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1107403099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["10044ui_story"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect10044ui_story == nil then
				arg_405_1.var_.characterEffect10044ui_story = var_408_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.1

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 and not isNil(var_408_0) then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.characterEffect10044ui_story and not isNil(var_408_0) then
					arg_405_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect10044ui_story then
				arg_405_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_408_4 = arg_405_1.actors_["10044ui_story"].transform
			local var_408_5 = 0

			if var_408_5 < arg_405_1.time_ and arg_405_1.time_ <= var_408_5 + arg_408_0 then
				arg_405_1.var_.moveOldPos10044ui_story = var_408_4.localPosition
			end

			local var_408_6 = 0.001

			if var_408_5 <= arg_405_1.time_ and arg_405_1.time_ < var_408_5 + var_408_6 then
				local var_408_7 = (arg_405_1.time_ - var_408_5) / var_408_6
				local var_408_8 = Vector3.New(-0.7, -0.72, -6.3)

				var_408_4.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10044ui_story, var_408_8, var_408_7)

				local var_408_9 = manager.ui.mainCamera.transform.position - var_408_4.position

				var_408_4.forward = Vector3.New(var_408_9.x, var_408_9.y, var_408_9.z)

				local var_408_10 = var_408_4.localEulerAngles

				var_408_10.z = 0
				var_408_10.x = 0
				var_408_4.localEulerAngles = var_408_10
			end

			if arg_405_1.time_ >= var_408_5 + var_408_6 and arg_405_1.time_ < var_408_5 + var_408_6 + arg_408_0 then
				var_408_4.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_408_11 = manager.ui.mainCamera.transform.position - var_408_4.position

				var_408_4.forward = Vector3.New(var_408_11.x, var_408_11.y, var_408_11.z)

				local var_408_12 = var_408_4.localEulerAngles

				var_408_12.z = 0
				var_408_12.x = 0
				var_408_4.localEulerAngles = var_408_12
			end

			local var_408_13 = arg_405_1.actors_["10044ui_story"]
			local var_408_14 = 0

			if var_408_14 < arg_405_1.time_ and arg_405_1.time_ <= var_408_14 + arg_408_0 and not isNil(var_408_13) and arg_405_1.var_.characterEffect10044ui_story == nil then
				arg_405_1.var_.characterEffect10044ui_story = var_408_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_15 = 0.1

			if var_408_14 <= arg_405_1.time_ and arg_405_1.time_ < var_408_14 + var_408_15 and not isNil(var_408_13) then
				local var_408_16 = (arg_405_1.time_ - var_408_14) / var_408_15

				if arg_405_1.var_.characterEffect10044ui_story and not isNil(var_408_13) then
					arg_405_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= var_408_14 + var_408_15 and arg_405_1.time_ < var_408_14 + var_408_15 + arg_408_0 and not isNil(var_408_13) and arg_405_1.var_.characterEffect10044ui_story then
				arg_405_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_408_17 = 0

			if var_408_17 < arg_405_1.time_ and arg_405_1.time_ <= var_408_17 + arg_408_0 then
				arg_405_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action2_1")
			end

			local var_408_18 = 0

			if var_408_18 < arg_405_1.time_ and arg_405_1.time_ <= var_408_18 + arg_408_0 then
				arg_405_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_408_19 = arg_405_1.actors_["1074ui_story"].transform
			local var_408_20 = 0

			if var_408_20 < arg_405_1.time_ and arg_405_1.time_ <= var_408_20 + arg_408_0 then
				arg_405_1.var_.moveOldPos1074ui_story = var_408_19.localPosition

				local var_408_21 = "1074ui_story"

				arg_405_1:ShowWeapon(arg_405_1.var_[var_408_21 .. "Animator"].transform, false)
			end

			local var_408_22 = 0.001

			if var_408_20 <= arg_405_1.time_ and arg_405_1.time_ < var_408_20 + var_408_22 then
				local var_408_23 = (arg_405_1.time_ - var_408_20) / var_408_22
				local var_408_24 = Vector3.New(0.7, -1.055, -6.12)

				var_408_19.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1074ui_story, var_408_24, var_408_23)

				local var_408_25 = manager.ui.mainCamera.transform.position - var_408_19.position

				var_408_19.forward = Vector3.New(var_408_25.x, var_408_25.y, var_408_25.z)

				local var_408_26 = var_408_19.localEulerAngles

				var_408_26.z = 0
				var_408_26.x = 0
				var_408_19.localEulerAngles = var_408_26
			end

			if arg_405_1.time_ >= var_408_20 + var_408_22 and arg_405_1.time_ < var_408_20 + var_408_22 + arg_408_0 then
				var_408_19.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_408_27 = manager.ui.mainCamera.transform.position - var_408_19.position

				var_408_19.forward = Vector3.New(var_408_27.x, var_408_27.y, var_408_27.z)

				local var_408_28 = var_408_19.localEulerAngles

				var_408_28.z = 0
				var_408_28.x = 0
				var_408_19.localEulerAngles = var_408_28
			end

			local var_408_29 = 0
			local var_408_30 = 0.225

			if var_408_29 < arg_405_1.time_ and arg_405_1.time_ <= var_408_29 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_31 = arg_405_1:FormatText(StoryNameCfg[380].name)

				arg_405_1.leftNameTxt_.text = var_408_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_32 = arg_405_1:GetWordFromCfg(1107403098)
				local var_408_33 = arg_405_1:FormatText(var_408_32.content)

				arg_405_1.text_.text = var_408_33

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_34 = 9
				local var_408_35 = utf8.len(var_408_33)
				local var_408_36 = var_408_34 <= 0 and var_408_30 or var_408_30 * (var_408_35 / var_408_34)

				if var_408_36 > 0 and var_408_30 < var_408_36 then
					arg_405_1.talkMaxDuration = var_408_36

					if var_408_36 + var_408_29 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_36 + var_408_29
					end
				end

				arg_405_1.text_.text = var_408_33
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403098", "story_v_side_new_1107403.awb") ~= 0 then
					local var_408_37 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403098", "story_v_side_new_1107403.awb") / 1000

					if var_408_37 + var_408_29 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_37 + var_408_29
					end

					if var_408_32.prefab_name ~= "" and arg_405_1.actors_[var_408_32.prefab_name] ~= nil then
						local var_408_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_32.prefab_name].transform, "story_v_side_new_1107403", "1107403098", "story_v_side_new_1107403.awb")

						arg_405_1:RecordAudio("1107403098", var_408_38)
						arg_405_1:RecordAudio("1107403098", var_408_38)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403098", "story_v_side_new_1107403.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403098", "story_v_side_new_1107403.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_39 = math.max(var_408_30, arg_405_1.talkMaxDuration)

			if var_408_29 <= arg_405_1.time_ and arg_405_1.time_ < var_408_29 + var_408_39 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_29) / var_408_39

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_29 + var_408_39 and arg_405_1.time_ < var_408_29 + var_408_39 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play1107403099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1107403099
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1107403100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["10044ui_story"]
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect10044ui_story == nil then
				arg_409_1.var_.characterEffect10044ui_story = var_412_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.1

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 and not isNil(var_412_0) then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2

				if arg_409_1.var_.characterEffect10044ui_story and not isNil(var_412_0) then
					local var_412_4 = Mathf.Lerp(0, 0.5, var_412_3)

					arg_409_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_409_1.var_.characterEffect10044ui_story.fillRatio = var_412_4
				end
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect10044ui_story then
				local var_412_5 = 0.5

				arg_409_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_409_1.var_.characterEffect10044ui_story.fillRatio = var_412_5
			end

			local var_412_6 = 0
			local var_412_7 = 0.575

			if var_412_6 < arg_409_1.time_ and arg_409_1.time_ <= var_412_6 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_8 = arg_409_1:GetWordFromCfg(1107403099)
				local var_412_9 = arg_409_1:FormatText(var_412_8.content)

				arg_409_1.text_.text = var_412_9

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_10 = 23
				local var_412_11 = utf8.len(var_412_9)
				local var_412_12 = var_412_10 <= 0 and var_412_7 or var_412_7 * (var_412_11 / var_412_10)

				if var_412_12 > 0 and var_412_7 < var_412_12 then
					arg_409_1.talkMaxDuration = var_412_12

					if var_412_12 + var_412_6 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_12 + var_412_6
					end
				end

				arg_409_1.text_.text = var_412_9
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_13 = math.max(var_412_7, arg_409_1.talkMaxDuration)

			if var_412_6 <= arg_409_1.time_ and arg_409_1.time_ < var_412_6 + var_412_13 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_6) / var_412_13

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_6 + var_412_13 and arg_409_1.time_ < var_412_6 + var_412_13 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1107403100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1107403100
		arg_413_1.duration_ = 4.37

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1107403101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["10044ui_story"].transform
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.var_.moveOldPos10044ui_story = var_416_0.localPosition
			end

			local var_416_2 = 0.001

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2
				local var_416_4 = Vector3.New(-0.7, -0.72, -6.3)

				var_416_0.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos10044ui_story, var_416_4, var_416_3)

				local var_416_5 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_5.x, var_416_5.y, var_416_5.z)

				local var_416_6 = var_416_0.localEulerAngles

				var_416_6.z = 0
				var_416_6.x = 0
				var_416_0.localEulerAngles = var_416_6
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 then
				var_416_0.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_416_7 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_7.x, var_416_7.y, var_416_7.z)

				local var_416_8 = var_416_0.localEulerAngles

				var_416_8.z = 0
				var_416_8.x = 0
				var_416_0.localEulerAngles = var_416_8
			end

			local var_416_9 = arg_413_1.actors_["10044ui_story"]
			local var_416_10 = 0

			if var_416_10 < arg_413_1.time_ and arg_413_1.time_ <= var_416_10 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect10044ui_story == nil then
				arg_413_1.var_.characterEffect10044ui_story = var_416_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_11 = 0.1

			if var_416_10 <= arg_413_1.time_ and arg_413_1.time_ < var_416_10 + var_416_11 and not isNil(var_416_9) then
				local var_416_12 = (arg_413_1.time_ - var_416_10) / var_416_11

				if arg_413_1.var_.characterEffect10044ui_story and not isNil(var_416_9) then
					arg_413_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= var_416_10 + var_416_11 and arg_413_1.time_ < var_416_10 + var_416_11 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect10044ui_story then
				arg_413_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_416_13 = 0

			if var_416_13 < arg_413_1.time_ and arg_413_1.time_ <= var_416_13 + arg_416_0 then
				arg_413_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action2_2")
			end

			local var_416_14 = 0

			if var_416_14 < arg_413_1.time_ and arg_413_1.time_ <= var_416_14 + arg_416_0 then
				arg_413_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_416_15 = 0
			local var_416_16 = 0.65

			if var_416_15 < arg_413_1.time_ and arg_413_1.time_ <= var_416_15 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_17 = arg_413_1:FormatText(StoryNameCfg[380].name)

				arg_413_1.leftNameTxt_.text = var_416_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_18 = arg_413_1:GetWordFromCfg(1107403100)
				local var_416_19 = arg_413_1:FormatText(var_416_18.content)

				arg_413_1.text_.text = var_416_19

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_20 = 26
				local var_416_21 = utf8.len(var_416_19)
				local var_416_22 = var_416_20 <= 0 and var_416_16 or var_416_16 * (var_416_21 / var_416_20)

				if var_416_22 > 0 and var_416_16 < var_416_22 then
					arg_413_1.talkMaxDuration = var_416_22

					if var_416_22 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_22 + var_416_15
					end
				end

				arg_413_1.text_.text = var_416_19
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403100", "story_v_side_new_1107403.awb") ~= 0 then
					local var_416_23 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403100", "story_v_side_new_1107403.awb") / 1000

					if var_416_23 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_23 + var_416_15
					end

					if var_416_18.prefab_name ~= "" and arg_413_1.actors_[var_416_18.prefab_name] ~= nil then
						local var_416_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_18.prefab_name].transform, "story_v_side_new_1107403", "1107403100", "story_v_side_new_1107403.awb")

						arg_413_1:RecordAudio("1107403100", var_416_24)
						arg_413_1:RecordAudio("1107403100", var_416_24)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403100", "story_v_side_new_1107403.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403100", "story_v_side_new_1107403.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_25 = math.max(var_416_16, arg_413_1.talkMaxDuration)

			if var_416_15 <= arg_413_1.time_ and arg_413_1.time_ < var_416_15 + var_416_25 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_15) / var_416_25

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_15 + var_416_25 and arg_413_1.time_ < var_416_15 + var_416_25 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play1107403101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1107403101
		arg_417_1.duration_ = 4.13

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1107403102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1074ui_story"].transform
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.var_.moveOldPos1074ui_story = var_420_0.localPosition

				local var_420_2 = "1074ui_story"

				arg_417_1:ShowWeapon(arg_417_1.var_[var_420_2 .. "Animator"].transform, false)
			end

			local var_420_3 = 0.001

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_3 then
				local var_420_4 = (arg_417_1.time_ - var_420_1) / var_420_3
				local var_420_5 = Vector3.New(0.7, -1.055, -6.12)

				var_420_0.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1074ui_story, var_420_5, var_420_4)

				local var_420_6 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_6.x, var_420_6.y, var_420_6.z)

				local var_420_7 = var_420_0.localEulerAngles

				var_420_7.z = 0
				var_420_7.x = 0
				var_420_0.localEulerAngles = var_420_7
			end

			if arg_417_1.time_ >= var_420_1 + var_420_3 and arg_417_1.time_ < var_420_1 + var_420_3 + arg_420_0 then
				var_420_0.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_420_8 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_8.x, var_420_8.y, var_420_8.z)

				local var_420_9 = var_420_0.localEulerAngles

				var_420_9.z = 0
				var_420_9.x = 0
				var_420_0.localEulerAngles = var_420_9
			end

			local var_420_10 = arg_417_1.actors_["1074ui_story"]
			local var_420_11 = 0

			if var_420_11 < arg_417_1.time_ and arg_417_1.time_ <= var_420_11 + arg_420_0 and not isNil(var_420_10) and arg_417_1.var_.characterEffect1074ui_story == nil then
				arg_417_1.var_.characterEffect1074ui_story = var_420_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_12 = 0.1

			if var_420_11 <= arg_417_1.time_ and arg_417_1.time_ < var_420_11 + var_420_12 and not isNil(var_420_10) then
				local var_420_13 = (arg_417_1.time_ - var_420_11) / var_420_12

				if arg_417_1.var_.characterEffect1074ui_story and not isNil(var_420_10) then
					arg_417_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= var_420_11 + var_420_12 and arg_417_1.time_ < var_420_11 + var_420_12 + arg_420_0 and not isNil(var_420_10) and arg_417_1.var_.characterEffect1074ui_story then
				arg_417_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_420_14 = arg_417_1.actors_["10044ui_story"]
			local var_420_15 = 0

			if var_420_15 < arg_417_1.time_ and arg_417_1.time_ <= var_420_15 + arg_420_0 and not isNil(var_420_14) and arg_417_1.var_.characterEffect10044ui_story == nil then
				arg_417_1.var_.characterEffect10044ui_story = var_420_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_16 = 0.1

			if var_420_15 <= arg_417_1.time_ and arg_417_1.time_ < var_420_15 + var_420_16 and not isNil(var_420_14) then
				local var_420_17 = (arg_417_1.time_ - var_420_15) / var_420_16

				if arg_417_1.var_.characterEffect10044ui_story and not isNil(var_420_14) then
					local var_420_18 = Mathf.Lerp(0, 0.5, var_420_17)

					arg_417_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_417_1.var_.characterEffect10044ui_story.fillRatio = var_420_18
				end
			end

			if arg_417_1.time_ >= var_420_15 + var_420_16 and arg_417_1.time_ < var_420_15 + var_420_16 + arg_420_0 and not isNil(var_420_14) and arg_417_1.var_.characterEffect10044ui_story then
				local var_420_19 = 0.5

				arg_417_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_417_1.var_.characterEffect10044ui_story.fillRatio = var_420_19
			end

			local var_420_20 = 0

			if var_420_20 < arg_417_1.time_ and arg_417_1.time_ <= var_420_20 + arg_420_0 then
				arg_417_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			local var_420_21 = 0
			local var_420_22 = 0.375

			if var_420_21 < arg_417_1.time_ and arg_417_1.time_ <= var_420_21 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_23 = arg_417_1:FormatText(StoryNameCfg[410].name)

				arg_417_1.leftNameTxt_.text = var_420_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_24 = arg_417_1:GetWordFromCfg(1107403101)
				local var_420_25 = arg_417_1:FormatText(var_420_24.content)

				arg_417_1.text_.text = var_420_25

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_26 = 15
				local var_420_27 = utf8.len(var_420_25)
				local var_420_28 = var_420_26 <= 0 and var_420_22 or var_420_22 * (var_420_27 / var_420_26)

				if var_420_28 > 0 and var_420_22 < var_420_28 then
					arg_417_1.talkMaxDuration = var_420_28

					if var_420_28 + var_420_21 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_28 + var_420_21
					end
				end

				arg_417_1.text_.text = var_420_25
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403101", "story_v_side_new_1107403.awb") ~= 0 then
					local var_420_29 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403101", "story_v_side_new_1107403.awb") / 1000

					if var_420_29 + var_420_21 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_29 + var_420_21
					end

					if var_420_24.prefab_name ~= "" and arg_417_1.actors_[var_420_24.prefab_name] ~= nil then
						local var_420_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_24.prefab_name].transform, "story_v_side_new_1107403", "1107403101", "story_v_side_new_1107403.awb")

						arg_417_1:RecordAudio("1107403101", var_420_30)
						arg_417_1:RecordAudio("1107403101", var_420_30)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403101", "story_v_side_new_1107403.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403101", "story_v_side_new_1107403.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_31 = math.max(var_420_22, arg_417_1.talkMaxDuration)

			if var_420_21 <= arg_417_1.time_ and arg_417_1.time_ < var_420_21 + var_420_31 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_21) / var_420_31

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_21 + var_420_31 and arg_417_1.time_ < var_420_21 + var_420_31 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play1107403102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1107403102
		arg_421_1.duration_ = 4.97

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1107403103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["1074ui_story"]
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.characterEffect1074ui_story == nil then
				arg_421_1.var_.characterEffect1074ui_story = var_424_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.1

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 and not isNil(var_424_0) then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2

				if arg_421_1.var_.characterEffect1074ui_story and not isNil(var_424_0) then
					local var_424_4 = Mathf.Lerp(0, 0.5, var_424_3)

					arg_421_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1074ui_story.fillRatio = var_424_4
				end
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.characterEffect1074ui_story then
				local var_424_5 = 0.5

				arg_421_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1074ui_story.fillRatio = var_424_5
			end

			local var_424_6 = arg_421_1.actors_["10044ui_story"]
			local var_424_7 = 0

			if var_424_7 < arg_421_1.time_ and arg_421_1.time_ <= var_424_7 + arg_424_0 and not isNil(var_424_6) and arg_421_1.var_.characterEffect10044ui_story == nil then
				arg_421_1.var_.characterEffect10044ui_story = var_424_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_8 = 0.1

			if var_424_7 <= arg_421_1.time_ and arg_421_1.time_ < var_424_7 + var_424_8 and not isNil(var_424_6) then
				local var_424_9 = (arg_421_1.time_ - var_424_7) / var_424_8

				if arg_421_1.var_.characterEffect10044ui_story and not isNil(var_424_6) then
					arg_421_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= var_424_7 + var_424_8 and arg_421_1.time_ < var_424_7 + var_424_8 + arg_424_0 and not isNil(var_424_6) and arg_421_1.var_.characterEffect10044ui_story then
				arg_421_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_424_10 = 0

			if var_424_10 < arg_421_1.time_ and arg_421_1.time_ <= var_424_10 + arg_424_0 then
				arg_421_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_424_11 = 0
			local var_424_12 = 0.45

			if var_424_11 < arg_421_1.time_ and arg_421_1.time_ <= var_424_11 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_13 = arg_421_1:FormatText(StoryNameCfg[380].name)

				arg_421_1.leftNameTxt_.text = var_424_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_14 = arg_421_1:GetWordFromCfg(1107403102)
				local var_424_15 = arg_421_1:FormatText(var_424_14.content)

				arg_421_1.text_.text = var_424_15

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_16 = 18
				local var_424_17 = utf8.len(var_424_15)
				local var_424_18 = var_424_16 <= 0 and var_424_12 or var_424_12 * (var_424_17 / var_424_16)

				if var_424_18 > 0 and var_424_12 < var_424_18 then
					arg_421_1.talkMaxDuration = var_424_18

					if var_424_18 + var_424_11 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_18 + var_424_11
					end
				end

				arg_421_1.text_.text = var_424_15
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403102", "story_v_side_new_1107403.awb") ~= 0 then
					local var_424_19 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403102", "story_v_side_new_1107403.awb") / 1000

					if var_424_19 + var_424_11 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_19 + var_424_11
					end

					if var_424_14.prefab_name ~= "" and arg_421_1.actors_[var_424_14.prefab_name] ~= nil then
						local var_424_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_14.prefab_name].transform, "story_v_side_new_1107403", "1107403102", "story_v_side_new_1107403.awb")

						arg_421_1:RecordAudio("1107403102", var_424_20)
						arg_421_1:RecordAudio("1107403102", var_424_20)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403102", "story_v_side_new_1107403.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403102", "story_v_side_new_1107403.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_21 = math.max(var_424_12, arg_421_1.talkMaxDuration)

			if var_424_11 <= arg_421_1.time_ and arg_421_1.time_ < var_424_11 + var_424_21 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_11) / var_424_21

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_11 + var_424_21 and arg_421_1.time_ < var_424_11 + var_424_21 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1107403103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1107403103
		arg_425_1.duration_ = 3.27

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1107403104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1074ui_story"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1074ui_story == nil then
				arg_425_1.var_.characterEffect1074ui_story = var_428_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.1

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 and not isNil(var_428_0) then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2

				if arg_425_1.var_.characterEffect1074ui_story and not isNil(var_428_0) then
					arg_425_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1074ui_story then
				arg_425_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_428_4 = arg_425_1.actors_["10044ui_story"]
			local var_428_5 = 0

			if var_428_5 < arg_425_1.time_ and arg_425_1.time_ <= var_428_5 + arg_428_0 and not isNil(var_428_4) and arg_425_1.var_.characterEffect10044ui_story == nil then
				arg_425_1.var_.characterEffect10044ui_story = var_428_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_6 = 0.1

			if var_428_5 <= arg_425_1.time_ and arg_425_1.time_ < var_428_5 + var_428_6 and not isNil(var_428_4) then
				local var_428_7 = (arg_425_1.time_ - var_428_5) / var_428_6

				if arg_425_1.var_.characterEffect10044ui_story and not isNil(var_428_4) then
					local var_428_8 = Mathf.Lerp(0, 0.5, var_428_7)

					arg_425_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_425_1.var_.characterEffect10044ui_story.fillRatio = var_428_8
				end
			end

			if arg_425_1.time_ >= var_428_5 + var_428_6 and arg_425_1.time_ < var_428_5 + var_428_6 + arg_428_0 and not isNil(var_428_4) and arg_425_1.var_.characterEffect10044ui_story then
				local var_428_9 = 0.5

				arg_425_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_425_1.var_.characterEffect10044ui_story.fillRatio = var_428_9
			end

			local var_428_10 = 0
			local var_428_11 = 0.425

			if var_428_10 < arg_425_1.time_ and arg_425_1.time_ <= var_428_10 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_12 = arg_425_1:FormatText(StoryNameCfg[410].name)

				arg_425_1.leftNameTxt_.text = var_428_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_13 = arg_425_1:GetWordFromCfg(1107403103)
				local var_428_14 = arg_425_1:FormatText(var_428_13.content)

				arg_425_1.text_.text = var_428_14

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_15 = 17
				local var_428_16 = utf8.len(var_428_14)
				local var_428_17 = var_428_15 <= 0 and var_428_11 or var_428_11 * (var_428_16 / var_428_15)

				if var_428_17 > 0 and var_428_11 < var_428_17 then
					arg_425_1.talkMaxDuration = var_428_17

					if var_428_17 + var_428_10 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_17 + var_428_10
					end
				end

				arg_425_1.text_.text = var_428_14
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403103", "story_v_side_new_1107403.awb") ~= 0 then
					local var_428_18 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403103", "story_v_side_new_1107403.awb") / 1000

					if var_428_18 + var_428_10 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_18 + var_428_10
					end

					if var_428_13.prefab_name ~= "" and arg_425_1.actors_[var_428_13.prefab_name] ~= nil then
						local var_428_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_13.prefab_name].transform, "story_v_side_new_1107403", "1107403103", "story_v_side_new_1107403.awb")

						arg_425_1:RecordAudio("1107403103", var_428_19)
						arg_425_1:RecordAudio("1107403103", var_428_19)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403103", "story_v_side_new_1107403.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403103", "story_v_side_new_1107403.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_20 = math.max(var_428_11, arg_425_1.talkMaxDuration)

			if var_428_10 <= arg_425_1.time_ and arg_425_1.time_ < var_428_10 + var_428_20 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_10) / var_428_20

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_10 + var_428_20 and arg_425_1.time_ < var_428_10 + var_428_20 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1107403104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1107403104
		arg_429_1.duration_ = 2.33

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1107403105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["1074ui_story"]
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect1074ui_story == nil then
				arg_429_1.var_.characterEffect1074ui_story = var_432_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.1

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 and not isNil(var_432_0) then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2

				if arg_429_1.var_.characterEffect1074ui_story and not isNil(var_432_0) then
					local var_432_4 = Mathf.Lerp(0, 0.5, var_432_3)

					arg_429_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1074ui_story.fillRatio = var_432_4
				end
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect1074ui_story then
				local var_432_5 = 0.5

				arg_429_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1074ui_story.fillRatio = var_432_5
			end

			local var_432_6 = arg_429_1.actors_["10044ui_story"]
			local var_432_7 = 0

			if var_432_7 < arg_429_1.time_ and arg_429_1.time_ <= var_432_7 + arg_432_0 and not isNil(var_432_6) and arg_429_1.var_.characterEffect10044ui_story == nil then
				arg_429_1.var_.characterEffect10044ui_story = var_432_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_8 = 0.1

			if var_432_7 <= arg_429_1.time_ and arg_429_1.time_ < var_432_7 + var_432_8 and not isNil(var_432_6) then
				local var_432_9 = (arg_429_1.time_ - var_432_7) / var_432_8

				if arg_429_1.var_.characterEffect10044ui_story and not isNil(var_432_6) then
					arg_429_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= var_432_7 + var_432_8 and arg_429_1.time_ < var_432_7 + var_432_8 + arg_432_0 and not isNil(var_432_6) and arg_429_1.var_.characterEffect10044ui_story then
				arg_429_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_432_10 = 0

			if var_432_10 < arg_429_1.time_ and arg_429_1.time_ <= var_432_10 + arg_432_0 then
				arg_429_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_432_11 = 0
			local var_432_12 = 0.4

			if var_432_11 < arg_429_1.time_ and arg_429_1.time_ <= var_432_11 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_13 = arg_429_1:FormatText(StoryNameCfg[380].name)

				arg_429_1.leftNameTxt_.text = var_432_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_14 = arg_429_1:GetWordFromCfg(1107403104)
				local var_432_15 = arg_429_1:FormatText(var_432_14.content)

				arg_429_1.text_.text = var_432_15

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_16 = 16
				local var_432_17 = utf8.len(var_432_15)
				local var_432_18 = var_432_16 <= 0 and var_432_12 or var_432_12 * (var_432_17 / var_432_16)

				if var_432_18 > 0 and var_432_12 < var_432_18 then
					arg_429_1.talkMaxDuration = var_432_18

					if var_432_18 + var_432_11 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_18 + var_432_11
					end
				end

				arg_429_1.text_.text = var_432_15
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403104", "story_v_side_new_1107403.awb") ~= 0 then
					local var_432_19 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403104", "story_v_side_new_1107403.awb") / 1000

					if var_432_19 + var_432_11 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_19 + var_432_11
					end

					if var_432_14.prefab_name ~= "" and arg_429_1.actors_[var_432_14.prefab_name] ~= nil then
						local var_432_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_14.prefab_name].transform, "story_v_side_new_1107403", "1107403104", "story_v_side_new_1107403.awb")

						arg_429_1:RecordAudio("1107403104", var_432_20)
						arg_429_1:RecordAudio("1107403104", var_432_20)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403104", "story_v_side_new_1107403.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403104", "story_v_side_new_1107403.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_21 = math.max(var_432_12, arg_429_1.talkMaxDuration)

			if var_432_11 <= arg_429_1.time_ and arg_429_1.time_ < var_432_11 + var_432_21 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_11) / var_432_21

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_11 + var_432_21 and arg_429_1.time_ < var_432_11 + var_432_21 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1107403105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1107403105
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1107403106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["10044ui_story"].transform
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.var_.moveOldPos10044ui_story = var_436_0.localPosition

				local var_436_2 = "10044ui_story"

				arg_433_1:ShowWeapon(arg_433_1.var_[var_436_2 .. "Animator"].transform, false)
			end

			local var_436_3 = 0.001

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_3 then
				local var_436_4 = (arg_433_1.time_ - var_436_1) / var_436_3
				local var_436_5 = Vector3.New(0, 100, 0)

				var_436_0.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos10044ui_story, var_436_5, var_436_4)

				local var_436_6 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_6.x, var_436_6.y, var_436_6.z)

				local var_436_7 = var_436_0.localEulerAngles

				var_436_7.z = 0
				var_436_7.x = 0
				var_436_0.localEulerAngles = var_436_7
			end

			if arg_433_1.time_ >= var_436_1 + var_436_3 and arg_433_1.time_ < var_436_1 + var_436_3 + arg_436_0 then
				var_436_0.localPosition = Vector3.New(0, 100, 0)

				local var_436_8 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_8.x, var_436_8.y, var_436_8.z)

				local var_436_9 = var_436_0.localEulerAngles

				var_436_9.z = 0
				var_436_9.x = 0
				var_436_0.localEulerAngles = var_436_9
			end

			local var_436_10 = arg_433_1.actors_["1074ui_story"].transform
			local var_436_11 = 0

			if var_436_11 < arg_433_1.time_ and arg_433_1.time_ <= var_436_11 + arg_436_0 then
				arg_433_1.var_.moveOldPos1074ui_story = var_436_10.localPosition

				local var_436_12 = "1074ui_story"

				arg_433_1:ShowWeapon(arg_433_1.var_[var_436_12 .. "Animator"].transform, false)
			end

			local var_436_13 = 0.001

			if var_436_11 <= arg_433_1.time_ and arg_433_1.time_ < var_436_11 + var_436_13 then
				local var_436_14 = (arg_433_1.time_ - var_436_11) / var_436_13
				local var_436_15 = Vector3.New(0, 100, 0)

				var_436_10.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1074ui_story, var_436_15, var_436_14)

				local var_436_16 = manager.ui.mainCamera.transform.position - var_436_10.position

				var_436_10.forward = Vector3.New(var_436_16.x, var_436_16.y, var_436_16.z)

				local var_436_17 = var_436_10.localEulerAngles

				var_436_17.z = 0
				var_436_17.x = 0
				var_436_10.localEulerAngles = var_436_17
			end

			if arg_433_1.time_ >= var_436_11 + var_436_13 and arg_433_1.time_ < var_436_11 + var_436_13 + arg_436_0 then
				var_436_10.localPosition = Vector3.New(0, 100, 0)

				local var_436_18 = manager.ui.mainCamera.transform.position - var_436_10.position

				var_436_10.forward = Vector3.New(var_436_18.x, var_436_18.y, var_436_18.z)

				local var_436_19 = var_436_10.localEulerAngles

				var_436_19.z = 0
				var_436_19.x = 0
				var_436_10.localEulerAngles = var_436_19
			end

			local var_436_20 = 0
			local var_436_21 = 0.65

			if var_436_20 < arg_433_1.time_ and arg_433_1.time_ <= var_436_20 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_22 = arg_433_1:GetWordFromCfg(1107403105)
				local var_436_23 = arg_433_1:FormatText(var_436_22.content)

				arg_433_1.text_.text = var_436_23

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_24 = 26
				local var_436_25 = utf8.len(var_436_23)
				local var_436_26 = var_436_24 <= 0 and var_436_21 or var_436_21 * (var_436_25 / var_436_24)

				if var_436_26 > 0 and var_436_21 < var_436_26 then
					arg_433_1.talkMaxDuration = var_436_26

					if var_436_26 + var_436_20 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_26 + var_436_20
					end
				end

				arg_433_1.text_.text = var_436_23
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_27 = math.max(var_436_21, arg_433_1.talkMaxDuration)

			if var_436_20 <= arg_433_1.time_ and arg_433_1.time_ < var_436_20 + var_436_27 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_20) / var_436_27

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_20 + var_436_27 and arg_433_1.time_ < var_436_20 + var_436_27 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play1107403106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1107403106
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1107403107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0
			local var_440_1 = 0.525

			if var_440_0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_2 = arg_437_1:FormatText(StoryNameCfg[7].name)

				arg_437_1.leftNameTxt_.text = var_440_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_3 = arg_437_1:GetWordFromCfg(1107403106)
				local var_440_4 = arg_437_1:FormatText(var_440_3.content)

				arg_437_1.text_.text = var_440_4

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 21
				local var_440_6 = utf8.len(var_440_4)
				local var_440_7 = var_440_5 <= 0 and var_440_1 or var_440_1 * (var_440_6 / var_440_5)

				if var_440_7 > 0 and var_440_1 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_0
					end
				end

				arg_437_1.text_.text = var_440_4
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_8 = math.max(var_440_1, arg_437_1.talkMaxDuration)

			if var_440_0 <= arg_437_1.time_ and arg_437_1.time_ < var_440_0 + var_440_8 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_0) / var_440_8

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_0 + var_440_8 and arg_437_1.time_ < var_440_0 + var_440_8 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play1107403107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1107403107
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1107403108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0
			local var_444_1 = 0.825

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_2 = arg_441_1:GetWordFromCfg(1107403107)
				local var_444_3 = arg_441_1:FormatText(var_444_2.content)

				arg_441_1.text_.text = var_444_3

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_4 = 33
				local var_444_5 = utf8.len(var_444_3)
				local var_444_6 = var_444_4 <= 0 and var_444_1 or var_444_1 * (var_444_5 / var_444_4)

				if var_444_6 > 0 and var_444_1 < var_444_6 then
					arg_441_1.talkMaxDuration = var_444_6

					if var_444_6 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_6 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_3
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_7 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_7 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_7

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_7 and arg_441_1.time_ < var_444_0 + var_444_7 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1107403108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1107403108
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1107403109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 0.4

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_2 = arg_445_1:FormatText(StoryNameCfg[7].name)

				arg_445_1.leftNameTxt_.text = var_448_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_3 = arg_445_1:GetWordFromCfg(1107403108)
				local var_448_4 = arg_445_1:FormatText(var_448_3.content)

				arg_445_1.text_.text = var_448_4

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 16
				local var_448_6 = utf8.len(var_448_4)
				local var_448_7 = var_448_5 <= 0 and var_448_1 or var_448_1 * (var_448_6 / var_448_5)

				if var_448_7 > 0 and var_448_1 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_0
					end
				end

				arg_445_1.text_.text = var_448_4
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_8 = math.max(var_448_1, arg_445_1.talkMaxDuration)

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_8 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_0) / var_448_8

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_0 + var_448_8 and arg_445_1.time_ < var_448_0 + var_448_8 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1107403109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1107403109
		arg_449_1.duration_ = 3.6

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1107403110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["10044ui_story"].transform
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.var_.moveOldPos10044ui_story = var_452_0.localPosition

				local var_452_2 = "10044ui_story"

				arg_449_1:ShowWeapon(arg_449_1.var_[var_452_2 .. "Animator"].transform, false)
			end

			local var_452_3 = 0.001

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_3 then
				local var_452_4 = (arg_449_1.time_ - var_452_1) / var_452_3
				local var_452_5 = Vector3.New(0, -0.72, -6.3)

				var_452_0.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos10044ui_story, var_452_5, var_452_4)

				local var_452_6 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_6.x, var_452_6.y, var_452_6.z)

				local var_452_7 = var_452_0.localEulerAngles

				var_452_7.z = 0
				var_452_7.x = 0
				var_452_0.localEulerAngles = var_452_7
			end

			if arg_449_1.time_ >= var_452_1 + var_452_3 and arg_449_1.time_ < var_452_1 + var_452_3 + arg_452_0 then
				var_452_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_452_8 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_8.x, var_452_8.y, var_452_8.z)

				local var_452_9 = var_452_0.localEulerAngles

				var_452_9.z = 0
				var_452_9.x = 0
				var_452_0.localEulerAngles = var_452_9
			end

			local var_452_10 = 0

			if var_452_10 < arg_449_1.time_ and arg_449_1.time_ <= var_452_10 + arg_452_0 then
				arg_449_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_452_11 = arg_449_1.actors_["10044ui_story"]
			local var_452_12 = 0

			if var_452_12 < arg_449_1.time_ and arg_449_1.time_ <= var_452_12 + arg_452_0 and not isNil(var_452_11) and arg_449_1.var_.characterEffect10044ui_story == nil then
				arg_449_1.var_.characterEffect10044ui_story = var_452_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_13 = 0.1

			if var_452_12 <= arg_449_1.time_ and arg_449_1.time_ < var_452_12 + var_452_13 and not isNil(var_452_11) then
				local var_452_14 = (arg_449_1.time_ - var_452_12) / var_452_13

				if arg_449_1.var_.characterEffect10044ui_story and not isNil(var_452_11) then
					arg_449_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= var_452_12 + var_452_13 and arg_449_1.time_ < var_452_12 + var_452_13 + arg_452_0 and not isNil(var_452_11) and arg_449_1.var_.characterEffect10044ui_story then
				arg_449_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_452_15 = 0
			local var_452_16 = 0.475

			if var_452_15 < arg_449_1.time_ and arg_449_1.time_ <= var_452_15 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_17 = arg_449_1:FormatText(StoryNameCfg[380].name)

				arg_449_1.leftNameTxt_.text = var_452_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_18 = arg_449_1:GetWordFromCfg(1107403109)
				local var_452_19 = arg_449_1:FormatText(var_452_18.content)

				arg_449_1.text_.text = var_452_19

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_20 = 19
				local var_452_21 = utf8.len(var_452_19)
				local var_452_22 = var_452_20 <= 0 and var_452_16 or var_452_16 * (var_452_21 / var_452_20)

				if var_452_22 > 0 and var_452_16 < var_452_22 then
					arg_449_1.talkMaxDuration = var_452_22

					if var_452_22 + var_452_15 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_22 + var_452_15
					end
				end

				arg_449_1.text_.text = var_452_19
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403109", "story_v_side_new_1107403.awb") ~= 0 then
					local var_452_23 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403109", "story_v_side_new_1107403.awb") / 1000

					if var_452_23 + var_452_15 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_23 + var_452_15
					end

					if var_452_18.prefab_name ~= "" and arg_449_1.actors_[var_452_18.prefab_name] ~= nil then
						local var_452_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_18.prefab_name].transform, "story_v_side_new_1107403", "1107403109", "story_v_side_new_1107403.awb")

						arg_449_1:RecordAudio("1107403109", var_452_24)
						arg_449_1:RecordAudio("1107403109", var_452_24)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403109", "story_v_side_new_1107403.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403109", "story_v_side_new_1107403.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_25 = math.max(var_452_16, arg_449_1.talkMaxDuration)

			if var_452_15 <= arg_449_1.time_ and arg_449_1.time_ < var_452_15 + var_452_25 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_15) / var_452_25

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_15 + var_452_25 and arg_449_1.time_ < var_452_15 + var_452_25 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play1107403110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1107403110
		arg_453_1.duration_ = 6.83

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1107403111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0
			local var_456_1 = 0.95

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_2 = arg_453_1:FormatText(StoryNameCfg[380].name)

				arg_453_1.leftNameTxt_.text = var_456_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_3 = arg_453_1:GetWordFromCfg(1107403110)
				local var_456_4 = arg_453_1:FormatText(var_456_3.content)

				arg_453_1.text_.text = var_456_4

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 38
				local var_456_6 = utf8.len(var_456_4)
				local var_456_7 = var_456_5 <= 0 and var_456_1 or var_456_1 * (var_456_6 / var_456_5)

				if var_456_7 > 0 and var_456_1 < var_456_7 then
					arg_453_1.talkMaxDuration = var_456_7

					if var_456_7 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_4
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403110", "story_v_side_new_1107403.awb") ~= 0 then
					local var_456_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403110", "story_v_side_new_1107403.awb") / 1000

					if var_456_8 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_8 + var_456_0
					end

					if var_456_3.prefab_name ~= "" and arg_453_1.actors_[var_456_3.prefab_name] ~= nil then
						local var_456_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_3.prefab_name].transform, "story_v_side_new_1107403", "1107403110", "story_v_side_new_1107403.awb")

						arg_453_1:RecordAudio("1107403110", var_456_9)
						arg_453_1:RecordAudio("1107403110", var_456_9)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403110", "story_v_side_new_1107403.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403110", "story_v_side_new_1107403.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_10 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_10 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_10

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_10 and arg_453_1.time_ < var_456_0 + var_456_10 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1107403111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1107403111
		arg_457_1.duration_ = 11.73

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1107403112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 1.475

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_2 = arg_457_1:FormatText(StoryNameCfg[380].name)

				arg_457_1.leftNameTxt_.text = var_460_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_3 = arg_457_1:GetWordFromCfg(1107403111)
				local var_460_4 = arg_457_1:FormatText(var_460_3.content)

				arg_457_1.text_.text = var_460_4

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 59
				local var_460_6 = utf8.len(var_460_4)
				local var_460_7 = var_460_5 <= 0 and var_460_1 or var_460_1 * (var_460_6 / var_460_5)

				if var_460_7 > 0 and var_460_1 < var_460_7 then
					arg_457_1.talkMaxDuration = var_460_7

					if var_460_7 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_4
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403111", "story_v_side_new_1107403.awb") ~= 0 then
					local var_460_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403111", "story_v_side_new_1107403.awb") / 1000

					if var_460_8 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_8 + var_460_0
					end

					if var_460_3.prefab_name ~= "" and arg_457_1.actors_[var_460_3.prefab_name] ~= nil then
						local var_460_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_3.prefab_name].transform, "story_v_side_new_1107403", "1107403111", "story_v_side_new_1107403.awb")

						arg_457_1:RecordAudio("1107403111", var_460_9)
						arg_457_1:RecordAudio("1107403111", var_460_9)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403111", "story_v_side_new_1107403.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403111", "story_v_side_new_1107403.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_10 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_10 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_10

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_10 and arg_457_1.time_ < var_460_0 + var_460_10 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1107403112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1107403112
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1107403113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["10044ui_story"]
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 and not isNil(var_464_0) and arg_461_1.var_.characterEffect10044ui_story == nil then
				arg_461_1.var_.characterEffect10044ui_story = var_464_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_2 = 0.1

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 and not isNil(var_464_0) then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2

				if arg_461_1.var_.characterEffect10044ui_story and not isNil(var_464_0) then
					local var_464_4 = Mathf.Lerp(0, 0.5, var_464_3)

					arg_461_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_461_1.var_.characterEffect10044ui_story.fillRatio = var_464_4
				end
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 and not isNil(var_464_0) and arg_461_1.var_.characterEffect10044ui_story then
				local var_464_5 = 0.5

				arg_461_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_461_1.var_.characterEffect10044ui_story.fillRatio = var_464_5
			end

			local var_464_6 = 0
			local var_464_7 = 0.375

			if var_464_6 < arg_461_1.time_ and arg_461_1.time_ <= var_464_6 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_8 = arg_461_1:FormatText(StoryNameCfg[7].name)

				arg_461_1.leftNameTxt_.text = var_464_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_9 = arg_461_1:GetWordFromCfg(1107403112)
				local var_464_10 = arg_461_1:FormatText(var_464_9.content)

				arg_461_1.text_.text = var_464_10

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_11 = 15
				local var_464_12 = utf8.len(var_464_10)
				local var_464_13 = var_464_11 <= 0 and var_464_7 or var_464_7 * (var_464_12 / var_464_11)

				if var_464_13 > 0 and var_464_7 < var_464_13 then
					arg_461_1.talkMaxDuration = var_464_13

					if var_464_13 + var_464_6 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_13 + var_464_6
					end
				end

				arg_461_1.text_.text = var_464_10
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_14 = math.max(var_464_7, arg_461_1.talkMaxDuration)

			if var_464_6 <= arg_461_1.time_ and arg_461_1.time_ < var_464_6 + var_464_14 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_6) / var_464_14

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_6 + var_464_14 and arg_461_1.time_ < var_464_6 + var_464_14 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1107403113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1107403113
		arg_465_1.duration_ = 9

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1107403114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_2")
			end

			local var_468_1 = arg_465_1.actors_["10044ui_story"]
			local var_468_2 = 0

			if var_468_2 < arg_465_1.time_ and arg_465_1.time_ <= var_468_2 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect10044ui_story == nil then
				arg_465_1.var_.characterEffect10044ui_story = var_468_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_3 = 0.1

			if var_468_2 <= arg_465_1.time_ and arg_465_1.time_ < var_468_2 + var_468_3 and not isNil(var_468_1) then
				local var_468_4 = (arg_465_1.time_ - var_468_2) / var_468_3

				if arg_465_1.var_.characterEffect10044ui_story and not isNil(var_468_1) then
					arg_465_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= var_468_2 + var_468_3 and arg_465_1.time_ < var_468_2 + var_468_3 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect10044ui_story then
				arg_465_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_468_5 = 0
			local var_468_6 = 1

			if var_468_5 < arg_465_1.time_ and arg_465_1.time_ <= var_468_5 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_7 = arg_465_1:FormatText(StoryNameCfg[380].name)

				arg_465_1.leftNameTxt_.text = var_468_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_8 = arg_465_1:GetWordFromCfg(1107403113)
				local var_468_9 = arg_465_1:FormatText(var_468_8.content)

				arg_465_1.text_.text = var_468_9

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_10 = 40
				local var_468_11 = utf8.len(var_468_9)
				local var_468_12 = var_468_10 <= 0 and var_468_6 or var_468_6 * (var_468_11 / var_468_10)

				if var_468_12 > 0 and var_468_6 < var_468_12 then
					arg_465_1.talkMaxDuration = var_468_12

					if var_468_12 + var_468_5 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_12 + var_468_5
					end
				end

				arg_465_1.text_.text = var_468_9
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403113", "story_v_side_new_1107403.awb") ~= 0 then
					local var_468_13 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403113", "story_v_side_new_1107403.awb") / 1000

					if var_468_13 + var_468_5 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_13 + var_468_5
					end

					if var_468_8.prefab_name ~= "" and arg_465_1.actors_[var_468_8.prefab_name] ~= nil then
						local var_468_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_8.prefab_name].transform, "story_v_side_new_1107403", "1107403113", "story_v_side_new_1107403.awb")

						arg_465_1:RecordAudio("1107403113", var_468_14)
						arg_465_1:RecordAudio("1107403113", var_468_14)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403113", "story_v_side_new_1107403.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403113", "story_v_side_new_1107403.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_15 = math.max(var_468_6, arg_465_1.talkMaxDuration)

			if var_468_5 <= arg_465_1.time_ and arg_465_1.time_ < var_468_5 + var_468_15 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_5) / var_468_15

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_5 + var_468_15 and arg_465_1.time_ < var_468_5 + var_468_15 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1107403114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1107403114
		arg_469_1.duration_ = 4.93

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1107403115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 0.65

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_2 = arg_469_1:FormatText(StoryNameCfg[380].name)

				arg_469_1.leftNameTxt_.text = var_472_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_3 = arg_469_1:GetWordFromCfg(1107403114)
				local var_472_4 = arg_469_1:FormatText(var_472_3.content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 26
				local var_472_6 = utf8.len(var_472_4)
				local var_472_7 = var_472_5 <= 0 and var_472_1 or var_472_1 * (var_472_6 / var_472_5)

				if var_472_7 > 0 and var_472_1 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_4
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403114", "story_v_side_new_1107403.awb") ~= 0 then
					local var_472_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403114", "story_v_side_new_1107403.awb") / 1000

					if var_472_8 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_8 + var_472_0
					end

					if var_472_3.prefab_name ~= "" and arg_469_1.actors_[var_472_3.prefab_name] ~= nil then
						local var_472_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_3.prefab_name].transform, "story_v_side_new_1107403", "1107403114", "story_v_side_new_1107403.awb")

						arg_469_1:RecordAudio("1107403114", var_472_9)
						arg_469_1:RecordAudio("1107403114", var_472_9)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403114", "story_v_side_new_1107403.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403114", "story_v_side_new_1107403.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_10 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_10 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_10

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_10 and arg_469_1.time_ < var_472_0 + var_472_10 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1107403115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1107403115
		arg_473_1.duration_ = 11.6

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1107403116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 1.4

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_2 = arg_473_1:FormatText(StoryNameCfg[380].name)

				arg_473_1.leftNameTxt_.text = var_476_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_3 = arg_473_1:GetWordFromCfg(1107403115)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 56
				local var_476_6 = utf8.len(var_476_4)
				local var_476_7 = var_476_5 <= 0 and var_476_1 or var_476_1 * (var_476_6 / var_476_5)

				if var_476_7 > 0 and var_476_1 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403115", "story_v_side_new_1107403.awb") ~= 0 then
					local var_476_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403115", "story_v_side_new_1107403.awb") / 1000

					if var_476_8 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_8 + var_476_0
					end

					if var_476_3.prefab_name ~= "" and arg_473_1.actors_[var_476_3.prefab_name] ~= nil then
						local var_476_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_3.prefab_name].transform, "story_v_side_new_1107403", "1107403115", "story_v_side_new_1107403.awb")

						arg_473_1:RecordAudio("1107403115", var_476_9)
						arg_473_1:RecordAudio("1107403115", var_476_9)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403115", "story_v_side_new_1107403.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403115", "story_v_side_new_1107403.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_10 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_10 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_10

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_10 and arg_473_1.time_ < var_476_0 + var_476_10 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1107403116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1107403116
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1107403117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["10044ui_story"]
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect10044ui_story == nil then
				arg_477_1.var_.characterEffect10044ui_story = var_480_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.1

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 and not isNil(var_480_0) then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2

				if arg_477_1.var_.characterEffect10044ui_story and not isNil(var_480_0) then
					local var_480_4 = Mathf.Lerp(0, 0.5, var_480_3)

					arg_477_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_477_1.var_.characterEffect10044ui_story.fillRatio = var_480_4
				end
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect10044ui_story then
				local var_480_5 = 0.5

				arg_477_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_477_1.var_.characterEffect10044ui_story.fillRatio = var_480_5
			end

			local var_480_6 = 0
			local var_480_7 = 0.5

			if var_480_6 < arg_477_1.time_ and arg_477_1.time_ <= var_480_6 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_8 = arg_477_1:FormatText(StoryNameCfg[7].name)

				arg_477_1.leftNameTxt_.text = var_480_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_9 = arg_477_1:GetWordFromCfg(1107403116)
				local var_480_10 = arg_477_1:FormatText(var_480_9.content)

				arg_477_1.text_.text = var_480_10

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_11 = 20
				local var_480_12 = utf8.len(var_480_10)
				local var_480_13 = var_480_11 <= 0 and var_480_7 or var_480_7 * (var_480_12 / var_480_11)

				if var_480_13 > 0 and var_480_7 < var_480_13 then
					arg_477_1.talkMaxDuration = var_480_13

					if var_480_13 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_13 + var_480_6
					end
				end

				arg_477_1.text_.text = var_480_10
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_14 = math.max(var_480_7, arg_477_1.talkMaxDuration)

			if var_480_6 <= arg_477_1.time_ and arg_477_1.time_ < var_480_6 + var_480_14 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_6) / var_480_14

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_6 + var_480_14 and arg_477_1.time_ < var_480_6 + var_480_14 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1107403117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1107403117
		arg_481_1.duration_ = 11.37

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1107403118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = arg_481_1.actors_["10044ui_story"]
			local var_484_1 = 0

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.characterEffect10044ui_story == nil then
				arg_481_1.var_.characterEffect10044ui_story = var_484_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.1

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_2 and not isNil(var_484_0) then
				local var_484_3 = (arg_481_1.time_ - var_484_1) / var_484_2

				if arg_481_1.var_.characterEffect10044ui_story and not isNil(var_484_0) then
					arg_481_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= var_484_1 + var_484_2 and arg_481_1.time_ < var_484_1 + var_484_2 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.characterEffect10044ui_story then
				arg_481_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_484_4 = 0
			local var_484_5 = 1.3

			if var_484_4 < arg_481_1.time_ and arg_481_1.time_ <= var_484_4 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_6 = arg_481_1:FormatText(StoryNameCfg[380].name)

				arg_481_1.leftNameTxt_.text = var_484_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_7 = arg_481_1:GetWordFromCfg(1107403117)
				local var_484_8 = arg_481_1:FormatText(var_484_7.content)

				arg_481_1.text_.text = var_484_8

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_9 = 52
				local var_484_10 = utf8.len(var_484_8)
				local var_484_11 = var_484_9 <= 0 and var_484_5 or var_484_5 * (var_484_10 / var_484_9)

				if var_484_11 > 0 and var_484_5 < var_484_11 then
					arg_481_1.talkMaxDuration = var_484_11

					if var_484_11 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_11 + var_484_4
					end
				end

				arg_481_1.text_.text = var_484_8
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403117", "story_v_side_new_1107403.awb") ~= 0 then
					local var_484_12 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403117", "story_v_side_new_1107403.awb") / 1000

					if var_484_12 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_12 + var_484_4
					end

					if var_484_7.prefab_name ~= "" and arg_481_1.actors_[var_484_7.prefab_name] ~= nil then
						local var_484_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_7.prefab_name].transform, "story_v_side_new_1107403", "1107403117", "story_v_side_new_1107403.awb")

						arg_481_1:RecordAudio("1107403117", var_484_13)
						arg_481_1:RecordAudio("1107403117", var_484_13)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403117", "story_v_side_new_1107403.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403117", "story_v_side_new_1107403.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_14 = math.max(var_484_5, arg_481_1.talkMaxDuration)

			if var_484_4 <= arg_481_1.time_ and arg_481_1.time_ < var_484_4 + var_484_14 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_4) / var_484_14

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_4 + var_484_14 and arg_481_1.time_ < var_484_4 + var_484_14 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1107403118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1107403118
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1107403119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["10044ui_story"]
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.characterEffect10044ui_story == nil then
				arg_485_1.var_.characterEffect10044ui_story = var_488_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_2 = 0.1

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 and not isNil(var_488_0) then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2

				if arg_485_1.var_.characterEffect10044ui_story and not isNil(var_488_0) then
					local var_488_4 = Mathf.Lerp(0, 0.5, var_488_3)

					arg_485_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_485_1.var_.characterEffect10044ui_story.fillRatio = var_488_4
				end
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.characterEffect10044ui_story then
				local var_488_5 = 0.5

				arg_485_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_485_1.var_.characterEffect10044ui_story.fillRatio = var_488_5
			end

			local var_488_6 = 0
			local var_488_7 = 0.6

			if var_488_6 < arg_485_1.time_ and arg_485_1.time_ <= var_488_6 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_8 = arg_485_1:FormatText(StoryNameCfg[7].name)

				arg_485_1.leftNameTxt_.text = var_488_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_9 = arg_485_1:GetWordFromCfg(1107403118)
				local var_488_10 = arg_485_1:FormatText(var_488_9.content)

				arg_485_1.text_.text = var_488_10

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_11 = 24
				local var_488_12 = utf8.len(var_488_10)
				local var_488_13 = var_488_11 <= 0 and var_488_7 or var_488_7 * (var_488_12 / var_488_11)

				if var_488_13 > 0 and var_488_7 < var_488_13 then
					arg_485_1.talkMaxDuration = var_488_13

					if var_488_13 + var_488_6 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_13 + var_488_6
					end
				end

				arg_485_1.text_.text = var_488_10
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_14 = math.max(var_488_7, arg_485_1.talkMaxDuration)

			if var_488_6 <= arg_485_1.time_ and arg_485_1.time_ < var_488_6 + var_488_14 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_6) / var_488_14

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_6 + var_488_14 and arg_485_1.time_ < var_488_6 + var_488_14 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1107403119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1107403119
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1107403120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0
			local var_492_1 = 0.75

			if var_492_0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_2 = arg_489_1:FormatText(StoryNameCfg[7].name)

				arg_489_1.leftNameTxt_.text = var_492_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_3 = arg_489_1:GetWordFromCfg(1107403119)
				local var_492_4 = arg_489_1:FormatText(var_492_3.content)

				arg_489_1.text_.text = var_492_4

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 30
				local var_492_6 = utf8.len(var_492_4)
				local var_492_7 = var_492_5 <= 0 and var_492_1 or var_492_1 * (var_492_6 / var_492_5)

				if var_492_7 > 0 and var_492_1 < var_492_7 then
					arg_489_1.talkMaxDuration = var_492_7

					if var_492_7 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_7 + var_492_0
					end
				end

				arg_489_1.text_.text = var_492_4
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_8 = math.max(var_492_1, arg_489_1.talkMaxDuration)

			if var_492_0 <= arg_489_1.time_ and arg_489_1.time_ < var_492_0 + var_492_8 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_0) / var_492_8

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_0 + var_492_8 and arg_489_1.time_ < var_492_0 + var_492_8 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1107403120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1107403120
		arg_493_1.duration_ = 2.8

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1107403121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["1074ui_story"].transform
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 then
				arg_493_1.var_.moveOldPos1074ui_story = var_496_0.localPosition

				local var_496_2 = "1074ui_story"

				arg_493_1:ShowWeapon(arg_493_1.var_[var_496_2 .. "Animator"].transform, false)
			end

			local var_496_3 = 0.001

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_3 then
				local var_496_4 = (arg_493_1.time_ - var_496_1) / var_496_3
				local var_496_5 = Vector3.New(0.7, -1.055, -6.12)

				var_496_0.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1074ui_story, var_496_5, var_496_4)

				local var_496_6 = manager.ui.mainCamera.transform.position - var_496_0.position

				var_496_0.forward = Vector3.New(var_496_6.x, var_496_6.y, var_496_6.z)

				local var_496_7 = var_496_0.localEulerAngles

				var_496_7.z = 0
				var_496_7.x = 0
				var_496_0.localEulerAngles = var_496_7
			end

			if arg_493_1.time_ >= var_496_1 + var_496_3 and arg_493_1.time_ < var_496_1 + var_496_3 + arg_496_0 then
				var_496_0.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_496_8 = manager.ui.mainCamera.transform.position - var_496_0.position

				var_496_0.forward = Vector3.New(var_496_8.x, var_496_8.y, var_496_8.z)

				local var_496_9 = var_496_0.localEulerAngles

				var_496_9.z = 0
				var_496_9.x = 0
				var_496_0.localEulerAngles = var_496_9
			end

			local var_496_10 = 0

			if var_496_10 < arg_493_1.time_ and arg_493_1.time_ <= var_496_10 + arg_496_0 then
				arg_493_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_496_11 = arg_493_1.actors_["10044ui_story"]
			local var_496_12 = 0

			if var_496_12 < arg_493_1.time_ and arg_493_1.time_ <= var_496_12 + arg_496_0 and not isNil(var_496_11) and arg_493_1.var_.characterEffect10044ui_story == nil then
				arg_493_1.var_.characterEffect10044ui_story = var_496_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_13 = 0.1

			if var_496_12 <= arg_493_1.time_ and arg_493_1.time_ < var_496_12 + var_496_13 and not isNil(var_496_11) then
				local var_496_14 = (arg_493_1.time_ - var_496_12) / var_496_13

				if arg_493_1.var_.characterEffect10044ui_story and not isNil(var_496_11) then
					local var_496_15 = Mathf.Lerp(0, 0.5, var_496_14)

					arg_493_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_493_1.var_.characterEffect10044ui_story.fillRatio = var_496_15
				end
			end

			if arg_493_1.time_ >= var_496_12 + var_496_13 and arg_493_1.time_ < var_496_12 + var_496_13 + arg_496_0 and not isNil(var_496_11) and arg_493_1.var_.characterEffect10044ui_story then
				local var_496_16 = 0.5

				arg_493_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_493_1.var_.characterEffect10044ui_story.fillRatio = var_496_16
			end

			local var_496_17 = arg_493_1.actors_["10044ui_story"].transform
			local var_496_18 = 0

			if var_496_18 < arg_493_1.time_ and arg_493_1.time_ <= var_496_18 + arg_496_0 then
				arg_493_1.var_.moveOldPos10044ui_story = var_496_17.localPosition

				local var_496_19 = "10044ui_story"

				arg_493_1:ShowWeapon(arg_493_1.var_[var_496_19 .. "Animator"].transform, false)
			end

			local var_496_20 = 0.001

			if var_496_18 <= arg_493_1.time_ and arg_493_1.time_ < var_496_18 + var_496_20 then
				local var_496_21 = (arg_493_1.time_ - var_496_18) / var_496_20
				local var_496_22 = Vector3.New(-0.7, -0.72, -6.3)

				var_496_17.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos10044ui_story, var_496_22, var_496_21)

				local var_496_23 = manager.ui.mainCamera.transform.position - var_496_17.position

				var_496_17.forward = Vector3.New(var_496_23.x, var_496_23.y, var_496_23.z)

				local var_496_24 = var_496_17.localEulerAngles

				var_496_24.z = 0
				var_496_24.x = 0
				var_496_17.localEulerAngles = var_496_24
			end

			if arg_493_1.time_ >= var_496_18 + var_496_20 and arg_493_1.time_ < var_496_18 + var_496_20 + arg_496_0 then
				var_496_17.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_496_25 = manager.ui.mainCamera.transform.position - var_496_17.position

				var_496_17.forward = Vector3.New(var_496_25.x, var_496_25.y, var_496_25.z)

				local var_496_26 = var_496_17.localEulerAngles

				var_496_26.z = 0
				var_496_26.x = 0
				var_496_17.localEulerAngles = var_496_26
			end

			local var_496_27 = arg_493_1.actors_["1074ui_story"]
			local var_496_28 = 0

			if var_496_28 < arg_493_1.time_ and arg_493_1.time_ <= var_496_28 + arg_496_0 and not isNil(var_496_27) and arg_493_1.var_.characterEffect1074ui_story == nil then
				arg_493_1.var_.characterEffect1074ui_story = var_496_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_29 = 0.1

			if var_496_28 <= arg_493_1.time_ and arg_493_1.time_ < var_496_28 + var_496_29 and not isNil(var_496_27) then
				local var_496_30 = (arg_493_1.time_ - var_496_28) / var_496_29

				if arg_493_1.var_.characterEffect1074ui_story and not isNil(var_496_27) then
					arg_493_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= var_496_28 + var_496_29 and arg_493_1.time_ < var_496_28 + var_496_29 + arg_496_0 and not isNil(var_496_27) and arg_493_1.var_.characterEffect1074ui_story then
				arg_493_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_496_31 = 0
			local var_496_32 = 0.325

			if var_496_31 < arg_493_1.time_ and arg_493_1.time_ <= var_496_31 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_33 = arg_493_1:FormatText(StoryNameCfg[410].name)

				arg_493_1.leftNameTxt_.text = var_496_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_34 = arg_493_1:GetWordFromCfg(1107403120)
				local var_496_35 = arg_493_1:FormatText(var_496_34.content)

				arg_493_1.text_.text = var_496_35

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_36 = 13
				local var_496_37 = utf8.len(var_496_35)
				local var_496_38 = var_496_36 <= 0 and var_496_32 or var_496_32 * (var_496_37 / var_496_36)

				if var_496_38 > 0 and var_496_32 < var_496_38 then
					arg_493_1.talkMaxDuration = var_496_38

					if var_496_38 + var_496_31 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_38 + var_496_31
					end
				end

				arg_493_1.text_.text = var_496_35
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403120", "story_v_side_new_1107403.awb") ~= 0 then
					local var_496_39 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403120", "story_v_side_new_1107403.awb") / 1000

					if var_496_39 + var_496_31 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_39 + var_496_31
					end

					if var_496_34.prefab_name ~= "" and arg_493_1.actors_[var_496_34.prefab_name] ~= nil then
						local var_496_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_34.prefab_name].transform, "story_v_side_new_1107403", "1107403120", "story_v_side_new_1107403.awb")

						arg_493_1:RecordAudio("1107403120", var_496_40)
						arg_493_1:RecordAudio("1107403120", var_496_40)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403120", "story_v_side_new_1107403.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403120", "story_v_side_new_1107403.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_41 = math.max(var_496_32, arg_493_1.talkMaxDuration)

			if var_496_31 <= arg_493_1.time_ and arg_493_1.time_ < var_496_31 + var_496_41 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_31) / var_496_41

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_31 + var_496_41 and arg_493_1.time_ < var_496_31 + var_496_41 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play1107403121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1107403121
		arg_497_1.duration_ = 1.23

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1107403122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.allBtn_.enabled = false
			end

			local var_500_1 = 0.3

			if arg_497_1.time_ >= var_500_0 + var_500_1 and arg_497_1.time_ < var_500_0 + var_500_1 + arg_500_0 then
				arg_497_1.allBtn_.enabled = true
			end

			local var_500_2 = arg_497_1.actors_["1074ui_story"]
			local var_500_3 = 0

			if var_500_3 < arg_497_1.time_ and arg_497_1.time_ <= var_500_3 + arg_500_0 and not isNil(var_500_2) and arg_497_1.var_.characterEffect1074ui_story == nil then
				arg_497_1.var_.characterEffect1074ui_story = var_500_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_4 = 0.1

			if var_500_3 <= arg_497_1.time_ and arg_497_1.time_ < var_500_3 + var_500_4 and not isNil(var_500_2) then
				local var_500_5 = (arg_497_1.time_ - var_500_3) / var_500_4

				if arg_497_1.var_.characterEffect1074ui_story and not isNil(var_500_2) then
					local var_500_6 = Mathf.Lerp(0, 0.5, var_500_5)

					arg_497_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_497_1.var_.characterEffect1074ui_story.fillRatio = var_500_6
				end
			end

			if arg_497_1.time_ >= var_500_3 + var_500_4 and arg_497_1.time_ < var_500_3 + var_500_4 + arg_500_0 and not isNil(var_500_2) and arg_497_1.var_.characterEffect1074ui_story then
				local var_500_7 = 0.5

				arg_497_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_497_1.var_.characterEffect1074ui_story.fillRatio = var_500_7
			end

			local var_500_8 = arg_497_1.actors_["10044ui_story"]
			local var_500_9 = 0

			if var_500_9 < arg_497_1.time_ and arg_497_1.time_ <= var_500_9 + arg_500_0 and not isNil(var_500_8) and arg_497_1.var_.characterEffect10044ui_story == nil then
				arg_497_1.var_.characterEffect10044ui_story = var_500_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_10 = 0.1

			if var_500_9 <= arg_497_1.time_ and arg_497_1.time_ < var_500_9 + var_500_10 and not isNil(var_500_8) then
				local var_500_11 = (arg_497_1.time_ - var_500_9) / var_500_10

				if arg_497_1.var_.characterEffect10044ui_story and not isNil(var_500_8) then
					arg_497_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= var_500_9 + var_500_10 and arg_497_1.time_ < var_500_9 + var_500_10 + arg_500_0 and not isNil(var_500_8) and arg_497_1.var_.characterEffect10044ui_story then
				arg_497_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_500_12 = 0
			local var_500_13 = 0.1

			if var_500_12 < arg_497_1.time_ and arg_497_1.time_ <= var_500_12 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0

				arg_497_1.dialog_:SetActive(true)

				arg_497_1.dialogCg_.alpha = 0

				local var_500_14 = LeanTween.value(arg_497_1.dialog_, 0, 1, 0.3)

				var_500_14:setOnUpdate(LuaHelper.FloatAction(function(arg_501_0)
					arg_497_1.dialogCg_.alpha = arg_501_0
				end))
				var_500_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_497_1.dialog_)
					var_500_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_497_1.duration_ = arg_497_1.duration_ + 0.3

				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_15 = arg_497_1:FormatText(StoryNameCfg[1054].name)

				arg_497_1.leftNameTxt_.text = var_500_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_16 = arg_497_1:GetWordFromCfg(1107403121)
				local var_500_17 = arg_497_1:FormatText(var_500_16.content)

				arg_497_1.text_.text = var_500_17

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_18 = 4
				local var_500_19 = utf8.len(var_500_17)
				local var_500_20 = var_500_18 <= 0 and var_500_13 or var_500_13 * (var_500_19 / var_500_18)

				if var_500_20 > 0 and var_500_13 < var_500_20 then
					arg_497_1.talkMaxDuration = var_500_20
					var_500_12 = var_500_12 + 0.3

					if var_500_20 + var_500_12 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_20 + var_500_12
					end
				end

				arg_497_1.text_.text = var_500_17
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403121", "story_v_side_new_1107403.awb") ~= 0 then
					local var_500_21 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403121", "story_v_side_new_1107403.awb") / 1000

					if var_500_21 + var_500_12 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_21 + var_500_12
					end

					if var_500_16.prefab_name ~= "" and arg_497_1.actors_[var_500_16.prefab_name] ~= nil then
						local var_500_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_16.prefab_name].transform, "story_v_side_new_1107403", "1107403121", "story_v_side_new_1107403.awb")

						arg_497_1:RecordAudio("1107403121", var_500_22)
						arg_497_1:RecordAudio("1107403121", var_500_22)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403121", "story_v_side_new_1107403.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403121", "story_v_side_new_1107403.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_23 = var_500_12 + 0.3
			local var_500_24 = math.max(var_500_13, arg_497_1.talkMaxDuration)

			if var_500_23 <= arg_497_1.time_ and arg_497_1.time_ < var_500_23 + var_500_24 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_23) / var_500_24

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_23 + var_500_24 and arg_497_1.time_ < var_500_23 + var_500_24 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1107403122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1107403122
		arg_503_1.duration_ = 1.67

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1107403123(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0
			local var_506_1 = 0.175

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0

				arg_503_1.dialog_:SetActive(true)

				arg_503_1.dialogCg_.alpha = 0

				local var_506_2 = LeanTween.value(arg_503_1.dialog_, 0, 1, 0.3)

				var_506_2:setOnUpdate(LuaHelper.FloatAction(function(arg_507_0)
					arg_503_1.dialogCg_.alpha = arg_507_0
				end))
				var_506_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_503_1.dialog_)
					var_506_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_503_1.duration_ = arg_503_1.duration_ + 0.3

				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_3 = arg_503_1:FormatText(StoryNameCfg[380].name)

				arg_503_1.leftNameTxt_.text = var_506_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_4 = arg_503_1:GetWordFromCfg(1107403122)
				local var_506_5 = arg_503_1:FormatText(var_506_4.content)

				arg_503_1.text_.text = var_506_5

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_6 = 7
				local var_506_7 = utf8.len(var_506_5)
				local var_506_8 = var_506_6 <= 0 and var_506_1 or var_506_1 * (var_506_7 / var_506_6)

				if var_506_8 > 0 and var_506_1 < var_506_8 then
					arg_503_1.talkMaxDuration = var_506_8
					var_506_0 = var_506_0 + 0.3

					if var_506_8 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_8 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_5
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403122", "story_v_side_new_1107403.awb") ~= 0 then
					local var_506_9 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403122", "story_v_side_new_1107403.awb") / 1000

					if var_506_9 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_9 + var_506_0
					end

					if var_506_4.prefab_name ~= "" and arg_503_1.actors_[var_506_4.prefab_name] ~= nil then
						local var_506_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_4.prefab_name].transform, "story_v_side_new_1107403", "1107403122", "story_v_side_new_1107403.awb")

						arg_503_1:RecordAudio("1107403122", var_506_10)
						arg_503_1:RecordAudio("1107403122", var_506_10)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403122", "story_v_side_new_1107403.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403122", "story_v_side_new_1107403.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_11 = var_506_0 + 0.3
			local var_506_12 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_11 <= arg_503_1.time_ and arg_503_1.time_ < var_506_11 + var_506_12 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_11) / var_506_12

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_11 + var_506_12 and arg_503_1.time_ < var_506_11 + var_506_12 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play1107403123 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1107403123
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1107403124(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = arg_509_1.actors_["10044ui_story"]
			local var_512_1 = 0

			if var_512_1 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.characterEffect10044ui_story == nil then
				arg_509_1.var_.characterEffect10044ui_story = var_512_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_2 = 0.1

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_2 and not isNil(var_512_0) then
				local var_512_3 = (arg_509_1.time_ - var_512_1) / var_512_2

				if arg_509_1.var_.characterEffect10044ui_story and not isNil(var_512_0) then
					local var_512_4 = Mathf.Lerp(0, 0.5, var_512_3)

					arg_509_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_509_1.var_.characterEffect10044ui_story.fillRatio = var_512_4
				end
			end

			if arg_509_1.time_ >= var_512_1 + var_512_2 and arg_509_1.time_ < var_512_1 + var_512_2 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.characterEffect10044ui_story then
				local var_512_5 = 0.5

				arg_509_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_509_1.var_.characterEffect10044ui_story.fillRatio = var_512_5
			end

			local var_512_6 = 0
			local var_512_7 = 0.4

			if var_512_6 < arg_509_1.time_ and arg_509_1.time_ <= var_512_6 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_8 = arg_509_1:FormatText(StoryNameCfg[7].name)

				arg_509_1.leftNameTxt_.text = var_512_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_9 = arg_509_1:GetWordFromCfg(1107403123)
				local var_512_10 = arg_509_1:FormatText(var_512_9.content)

				arg_509_1.text_.text = var_512_10

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_11 = 16
				local var_512_12 = utf8.len(var_512_10)
				local var_512_13 = var_512_11 <= 0 and var_512_7 or var_512_7 * (var_512_12 / var_512_11)

				if var_512_13 > 0 and var_512_7 < var_512_13 then
					arg_509_1.talkMaxDuration = var_512_13

					if var_512_13 + var_512_6 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_13 + var_512_6
					end
				end

				arg_509_1.text_.text = var_512_10
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_14 = math.max(var_512_7, arg_509_1.talkMaxDuration)

			if var_512_6 <= arg_509_1.time_ and arg_509_1.time_ < var_512_6 + var_512_14 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_6) / var_512_14

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_6 + var_512_14 and arg_509_1.time_ < var_512_6 + var_512_14 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1107403124 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1107403124
		arg_513_1.duration_ = 6.67

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1107403125(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 1

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1.allBtn_.enabled = false
			end

			local var_516_1 = 0.333333333333333

			if arg_513_1.time_ >= var_516_0 + var_516_1 and arg_513_1.time_ < var_516_0 + var_516_1 + arg_516_0 then
				arg_513_1.allBtn_.enabled = true
			end

			local var_516_2 = 1

			if var_516_2 < arg_513_1.time_ and arg_513_1.time_ <= var_516_2 + arg_516_0 then
				local var_516_3 = manager.ui.mainCamera.transform.localPosition
				local var_516_4 = Vector3.New(0, 0, 10) + Vector3.New(var_516_3.x, var_516_3.y, 0)
				local var_516_5 = arg_513_1.bgs_.STblack

				var_516_5.transform.localPosition = var_516_4
				var_516_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_516_6 = var_516_5:GetComponent("SpriteRenderer")

				if var_516_6 and var_516_6.sprite then
					local var_516_7 = (var_516_5.transform.localPosition - var_516_3).z
					local var_516_8 = manager.ui.mainCameraCom_
					local var_516_9 = 2 * var_516_7 * Mathf.Tan(var_516_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_516_10 = var_516_9 * var_516_8.aspect
					local var_516_11 = var_516_6.sprite.bounds.size.x
					local var_516_12 = var_516_6.sprite.bounds.size.y
					local var_516_13 = var_516_10 / var_516_11
					local var_516_14 = var_516_9 / var_516_12
					local var_516_15 = var_516_14 < var_516_13 and var_516_13 or var_516_14

					var_516_5.transform.localScale = Vector3.New(var_516_15, var_516_15, 0)
				end

				for iter_516_0, iter_516_1 in pairs(arg_513_1.bgs_) do
					if iter_516_0 ~= "STblack" then
						iter_516_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_516_16 = 0

			if var_516_16 < arg_513_1.time_ and arg_513_1.time_ <= var_516_16 + arg_516_0 then
				arg_513_1.mask_.enabled = true
				arg_513_1.mask_.raycastTarget = true

				arg_513_1:SetGaussion(false)
			end

			local var_516_17 = 1

			if var_516_16 <= arg_513_1.time_ and arg_513_1.time_ < var_516_16 + var_516_17 then
				local var_516_18 = (arg_513_1.time_ - var_516_16) / var_516_17
				local var_516_19 = Color.New(0, 0, 0)

				var_516_19.a = Mathf.Lerp(0, 1, var_516_18)
				arg_513_1.mask_.color = var_516_19
			end

			if arg_513_1.time_ >= var_516_16 + var_516_17 and arg_513_1.time_ < var_516_16 + var_516_17 + arg_516_0 then
				local var_516_20 = Color.New(0, 0, 0)

				var_516_20.a = 1
				arg_513_1.mask_.color = var_516_20
			end

			local var_516_21 = 1

			if var_516_21 < arg_513_1.time_ and arg_513_1.time_ <= var_516_21 + arg_516_0 then
				arg_513_1.mask_.enabled = true
				arg_513_1.mask_.raycastTarget = true

				arg_513_1:SetGaussion(false)
			end

			local var_516_22 = 1

			if var_516_21 <= arg_513_1.time_ and arg_513_1.time_ < var_516_21 + var_516_22 then
				local var_516_23 = (arg_513_1.time_ - var_516_21) / var_516_22
				local var_516_24 = Color.New(0, 0, 0)

				var_516_24.a = Mathf.Lerp(1, 0, var_516_23)
				arg_513_1.mask_.color = var_516_24
			end

			if arg_513_1.time_ >= var_516_21 + var_516_22 and arg_513_1.time_ < var_516_21 + var_516_22 + arg_516_0 then
				local var_516_25 = Color.New(0, 0, 0)
				local var_516_26 = 0

				arg_513_1.mask_.enabled = false
				var_516_25.a = var_516_26
				arg_513_1.mask_.color = var_516_25
			end

			local var_516_27 = arg_513_1.actors_["10044ui_story"].transform
			local var_516_28 = 0.966

			if var_516_28 < arg_513_1.time_ and arg_513_1.time_ <= var_516_28 + arg_516_0 then
				arg_513_1.var_.moveOldPos10044ui_story = var_516_27.localPosition
			end

			local var_516_29 = 0.001

			if var_516_28 <= arg_513_1.time_ and arg_513_1.time_ < var_516_28 + var_516_29 then
				local var_516_30 = (arg_513_1.time_ - var_516_28) / var_516_29
				local var_516_31 = Vector3.New(0, 100, 0)

				var_516_27.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos10044ui_story, var_516_31, var_516_30)

				local var_516_32 = manager.ui.mainCamera.transform.position - var_516_27.position

				var_516_27.forward = Vector3.New(var_516_32.x, var_516_32.y, var_516_32.z)

				local var_516_33 = var_516_27.localEulerAngles

				var_516_33.z = 0
				var_516_33.x = 0
				var_516_27.localEulerAngles = var_516_33
			end

			if arg_513_1.time_ >= var_516_28 + var_516_29 and arg_513_1.time_ < var_516_28 + var_516_29 + arg_516_0 then
				var_516_27.localPosition = Vector3.New(0, 100, 0)

				local var_516_34 = manager.ui.mainCamera.transform.position - var_516_27.position

				var_516_27.forward = Vector3.New(var_516_34.x, var_516_34.y, var_516_34.z)

				local var_516_35 = var_516_27.localEulerAngles

				var_516_35.z = 0
				var_516_35.x = 0
				var_516_27.localEulerAngles = var_516_35
			end

			local var_516_36 = arg_513_1.actors_["1074ui_story"].transform
			local var_516_37 = 0.966

			if var_516_37 < arg_513_1.time_ and arg_513_1.time_ <= var_516_37 + arg_516_0 then
				arg_513_1.var_.moveOldPos1074ui_story = var_516_36.localPosition
			end

			local var_516_38 = 0.001

			if var_516_37 <= arg_513_1.time_ and arg_513_1.time_ < var_516_37 + var_516_38 then
				local var_516_39 = (arg_513_1.time_ - var_516_37) / var_516_38
				local var_516_40 = Vector3.New(0, 100, 0)

				var_516_36.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos1074ui_story, var_516_40, var_516_39)

				local var_516_41 = manager.ui.mainCamera.transform.position - var_516_36.position

				var_516_36.forward = Vector3.New(var_516_41.x, var_516_41.y, var_516_41.z)

				local var_516_42 = var_516_36.localEulerAngles

				var_516_42.z = 0
				var_516_42.x = 0
				var_516_36.localEulerAngles = var_516_42
			end

			if arg_513_1.time_ >= var_516_37 + var_516_38 and arg_513_1.time_ < var_516_37 + var_516_38 + arg_516_0 then
				var_516_36.localPosition = Vector3.New(0, 100, 0)

				local var_516_43 = manager.ui.mainCamera.transform.position - var_516_36.position

				var_516_36.forward = Vector3.New(var_516_43.x, var_516_43.y, var_516_43.z)

				local var_516_44 = var_516_36.localEulerAngles

				var_516_44.z = 0
				var_516_44.x = 0
				var_516_36.localEulerAngles = var_516_44
			end

			if arg_513_1.frameCnt_ <= 1 then
				arg_513_1.dialog_:SetActive(false)
			end

			local var_516_45 = 1.66666666666667
			local var_516_46 = 0.55

			if var_516_45 < arg_513_1.time_ and arg_513_1.time_ <= var_516_45 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0

				arg_513_1.dialog_:SetActive(true)

				arg_513_1.dialogCg_.alpha = 0

				local var_516_47 = LeanTween.value(arg_513_1.dialog_, 0, 1, 0.3)

				var_516_47:setOnUpdate(LuaHelper.FloatAction(function(arg_517_0)
					arg_513_1.dialogCg_.alpha = arg_517_0
				end))
				var_516_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_513_1.dialog_)
					var_516_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_513_1.duration_ = arg_513_1.duration_ + 0.3

				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_48 = arg_513_1:GetWordFromCfg(1107403124)
				local var_516_49 = arg_513_1:FormatText(var_516_48.content)

				arg_513_1.text_.text = var_516_49

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_50 = 22
				local var_516_51 = utf8.len(var_516_49)
				local var_516_52 = var_516_50 <= 0 and var_516_46 or var_516_46 * (var_516_51 / var_516_50)

				if var_516_52 > 0 and var_516_46 < var_516_52 then
					arg_513_1.talkMaxDuration = var_516_52
					var_516_45 = var_516_45 + 0.3

					if var_516_52 + var_516_45 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_52 + var_516_45
					end
				end

				arg_513_1.text_.text = var_516_49
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_53 = var_516_45 + 0.3
			local var_516_54 = math.max(var_516_46, arg_513_1.talkMaxDuration)

			if var_516_53 <= arg_513_1.time_ and arg_513_1.time_ < var_516_53 + var_516_54 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_53) / var_516_54

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_53 + var_516_54 and arg_513_1.time_ < var_516_53 + var_516_54 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_513_1:InitPlayNodeList()
	end,
	Play1107403125 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1107403125
		arg_519_1.duration_ = 6

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1107403126(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0

			if var_522_0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.allBtn_.enabled = false
			end

			local var_522_1 = 0.666666666666667

			if arg_519_1.time_ >= var_522_0 + var_522_1 and arg_519_1.time_ < var_522_0 + var_522_1 + arg_522_0 then
				arg_519_1.allBtn_.enabled = true
			end

			local var_522_2 = "J10b"

			if arg_519_1.bgs_[var_522_2] == nil then
				local var_522_3 = Object.Instantiate(arg_519_1.paintGo_)

				var_522_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_522_2)
				var_522_3.name = var_522_2
				var_522_3.transform.parent = arg_519_1.stage_.transform
				var_522_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_519_1.bgs_[var_522_2] = var_522_3
			end

			local var_522_4 = 0

			if var_522_4 < arg_519_1.time_ and arg_519_1.time_ <= var_522_4 + arg_522_0 then
				local var_522_5 = manager.ui.mainCamera.transform.localPosition
				local var_522_6 = Vector3.New(0, 0, 10) + Vector3.New(var_522_5.x, var_522_5.y, 0)
				local var_522_7 = arg_519_1.bgs_.J10b

				var_522_7.transform.localPosition = var_522_6
				var_522_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_522_8 = var_522_7:GetComponent("SpriteRenderer")

				if var_522_8 and var_522_8.sprite then
					local var_522_9 = (var_522_7.transform.localPosition - var_522_5).z
					local var_522_10 = manager.ui.mainCameraCom_
					local var_522_11 = 2 * var_522_9 * Mathf.Tan(var_522_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_522_12 = var_522_11 * var_522_10.aspect
					local var_522_13 = var_522_8.sprite.bounds.size.x
					local var_522_14 = var_522_8.sprite.bounds.size.y
					local var_522_15 = var_522_12 / var_522_13
					local var_522_16 = var_522_11 / var_522_14
					local var_522_17 = var_522_16 < var_522_15 and var_522_15 or var_522_16

					var_522_7.transform.localScale = Vector3.New(var_522_17, var_522_17, 0)
				end

				for iter_522_0, iter_522_1 in pairs(arg_519_1.bgs_) do
					if iter_522_0 ~= "J10b" then
						iter_522_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_522_18 = 0

			if var_522_18 < arg_519_1.time_ and arg_519_1.time_ <= var_522_18 + arg_522_0 then
				arg_519_1.mask_.enabled = true
				arg_519_1.mask_.raycastTarget = true

				arg_519_1:SetGaussion(false)
			end

			local var_522_19 = 1

			if var_522_18 <= arg_519_1.time_ and arg_519_1.time_ < var_522_18 + var_522_19 then
				local var_522_20 = (arg_519_1.time_ - var_522_18) / var_522_19
				local var_522_21 = Color.New(0, 0, 0)

				var_522_21.a = Mathf.Lerp(1, 0, var_522_20)
				arg_519_1.mask_.color = var_522_21
			end

			if arg_519_1.time_ >= var_522_18 + var_522_19 and arg_519_1.time_ < var_522_18 + var_522_19 + arg_522_0 then
				local var_522_22 = Color.New(0, 0, 0)
				local var_522_23 = 0

				arg_519_1.mask_.enabled = false
				var_522_22.a = var_522_23
				arg_519_1.mask_.color = var_522_22
			end

			local var_522_24 = 0
			local var_522_25 = 0.2

			if var_522_24 < arg_519_1.time_ and arg_519_1.time_ <= var_522_24 + arg_522_0 then
				local var_522_26 = "play"
				local var_522_27 = "music"

				arg_519_1:AudioAction(var_522_26, var_522_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_522_28 = ""
				local var_522_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_522_29 ~= "" then
					if arg_519_1.bgmTxt_.text ~= var_522_29 and arg_519_1.bgmTxt_.text ~= "" then
						if arg_519_1.bgmTxt2_.text ~= "" then
							arg_519_1.bgmTxt_.text = arg_519_1.bgmTxt2_.text
						end

						arg_519_1.bgmTxt2_.text = var_522_29

						arg_519_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_519_1.bgmTxt_.text = var_522_29
						arg_519_1.bgmTxt2_.text = var_522_29
					end

					if arg_519_1.bgmTimer then
						arg_519_1.bgmTimer:Stop()

						arg_519_1.bgmTimer = nil
					end

					if arg_519_1.settingData.show_music_name == 1 then
						arg_519_1.musicController:SetSelectedState("show")
						arg_519_1.musicAnimator_:Play("open", 0, 0)

						if arg_519_1.settingData.music_time ~= 0 then
							arg_519_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_519_1.settingData.music_time), function()
								if arg_519_1 == nil or isNil(arg_519_1.bgmTxt_) then
									return
								end

								arg_519_1.musicController:SetSelectedState("hide")
								arg_519_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_522_30 = 0.4
			local var_522_31 = 1

			if var_522_30 < arg_519_1.time_ and arg_519_1.time_ <= var_522_30 + arg_522_0 then
				local var_522_32 = "play"
				local var_522_33 = "music"

				arg_519_1:AudioAction(var_522_32, var_522_33, "bgm_side_daily08", "bgm_side_daily08", "bgm_side_daily08.awb")

				local var_522_34 = ""
				local var_522_35 = manager.audio:GetAudioName("bgm_side_daily08", "bgm_side_daily08")

				if var_522_35 ~= "" then
					if arg_519_1.bgmTxt_.text ~= var_522_35 and arg_519_1.bgmTxt_.text ~= "" then
						if arg_519_1.bgmTxt2_.text ~= "" then
							arg_519_1.bgmTxt_.text = arg_519_1.bgmTxt2_.text
						end

						arg_519_1.bgmTxt2_.text = var_522_35

						arg_519_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_519_1.bgmTxt_.text = var_522_35
						arg_519_1.bgmTxt2_.text = var_522_35
					end

					if arg_519_1.bgmTimer then
						arg_519_1.bgmTimer:Stop()

						arg_519_1.bgmTimer = nil
					end

					if arg_519_1.settingData.show_music_name == 1 then
						arg_519_1.musicController:SetSelectedState("show")
						arg_519_1.musicAnimator_:Play("open", 0, 0)

						if arg_519_1.settingData.music_time ~= 0 then
							arg_519_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_519_1.settingData.music_time), function()
								if arg_519_1 == nil or isNil(arg_519_1.bgmTxt_) then
									return
								end

								arg_519_1.musicController:SetSelectedState("hide")
								arg_519_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_519_1.frameCnt_ <= 1 then
				arg_519_1.dialog_:SetActive(false)
			end

			local var_522_36 = 1
			local var_522_37 = 1.05

			if var_522_36 < arg_519_1.time_ and arg_519_1.time_ <= var_522_36 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0

				arg_519_1.dialog_:SetActive(true)

				arg_519_1.dialogCg_.alpha = 0

				local var_522_38 = LeanTween.value(arg_519_1.dialog_, 0, 1, 0.3)

				var_522_38:setOnUpdate(LuaHelper.FloatAction(function(arg_525_0)
					arg_519_1.dialogCg_.alpha = arg_525_0
				end))
				var_522_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_519_1.dialog_)
					var_522_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_519_1.duration_ = arg_519_1.duration_ + 0.3

				SetActive(arg_519_1.leftNameGo_, false)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_39 = arg_519_1:GetWordFromCfg(1107403125)
				local var_522_40 = arg_519_1:FormatText(var_522_39.content)

				arg_519_1.text_.text = var_522_40

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_41 = 42
				local var_522_42 = utf8.len(var_522_40)
				local var_522_43 = var_522_41 <= 0 and var_522_37 or var_522_37 * (var_522_42 / var_522_41)

				if var_522_43 > 0 and var_522_37 < var_522_43 then
					arg_519_1.talkMaxDuration = var_522_43
					var_522_36 = var_522_36 + 0.3

					if var_522_43 + var_522_36 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_43 + var_522_36
					end
				end

				arg_519_1.text_.text = var_522_40
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_44 = var_522_36 + 0.3
			local var_522_45 = math.max(var_522_37, arg_519_1.talkMaxDuration)

			if var_522_44 <= arg_519_1.time_ and arg_519_1.time_ < var_522_44 + var_522_45 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_44) / var_522_45

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_44 + var_522_45 and arg_519_1.time_ < var_522_44 + var_522_45 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1107403126 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1107403126
		arg_527_1.duration_ = 5.83

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1107403127(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = arg_527_1.actors_["10044ui_story"].transform
			local var_530_1 = 0

			if var_530_1 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 then
				arg_527_1.var_.moveOldPos10044ui_story = var_530_0.localPosition
			end

			local var_530_2 = 0.001

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_2 then
				local var_530_3 = (arg_527_1.time_ - var_530_1) / var_530_2
				local var_530_4 = Vector3.New(0, -0.72, -6.3)

				var_530_0.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos10044ui_story, var_530_4, var_530_3)

				local var_530_5 = manager.ui.mainCamera.transform.position - var_530_0.position

				var_530_0.forward = Vector3.New(var_530_5.x, var_530_5.y, var_530_5.z)

				local var_530_6 = var_530_0.localEulerAngles

				var_530_6.z = 0
				var_530_6.x = 0
				var_530_0.localEulerAngles = var_530_6
			end

			if arg_527_1.time_ >= var_530_1 + var_530_2 and arg_527_1.time_ < var_530_1 + var_530_2 + arg_530_0 then
				var_530_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_530_7 = manager.ui.mainCamera.transform.position - var_530_0.position

				var_530_0.forward = Vector3.New(var_530_7.x, var_530_7.y, var_530_7.z)

				local var_530_8 = var_530_0.localEulerAngles

				var_530_8.z = 0
				var_530_8.x = 0
				var_530_0.localEulerAngles = var_530_8
			end

			local var_530_9 = 0

			if var_530_9 < arg_527_1.time_ and arg_527_1.time_ <= var_530_9 + arg_530_0 then
				arg_527_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_530_10 = 0

			if var_530_10 < arg_527_1.time_ and arg_527_1.time_ <= var_530_10 + arg_530_0 then
				arg_527_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_530_11 = arg_527_1.actors_["10044ui_story"]
			local var_530_12 = 0

			if var_530_12 < arg_527_1.time_ and arg_527_1.time_ <= var_530_12 + arg_530_0 and not isNil(var_530_11) and arg_527_1.var_.characterEffect10044ui_story == nil then
				arg_527_1.var_.characterEffect10044ui_story = var_530_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_13 = 0.1

			if var_530_12 <= arg_527_1.time_ and arg_527_1.time_ < var_530_12 + var_530_13 and not isNil(var_530_11) then
				local var_530_14 = (arg_527_1.time_ - var_530_12) / var_530_13

				if arg_527_1.var_.characterEffect10044ui_story and not isNil(var_530_11) then
					arg_527_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= var_530_12 + var_530_13 and arg_527_1.time_ < var_530_12 + var_530_13 + arg_530_0 and not isNil(var_530_11) and arg_527_1.var_.characterEffect10044ui_story then
				arg_527_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_530_15 = 0
			local var_530_16 = 0.775

			if var_530_15 < arg_527_1.time_ and arg_527_1.time_ <= var_530_15 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_17 = arg_527_1:FormatText(StoryNameCfg[380].name)

				arg_527_1.leftNameTxt_.text = var_530_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_18 = arg_527_1:GetWordFromCfg(1107403126)
				local var_530_19 = arg_527_1:FormatText(var_530_18.content)

				arg_527_1.text_.text = var_530_19

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_20 = 31
				local var_530_21 = utf8.len(var_530_19)
				local var_530_22 = var_530_20 <= 0 and var_530_16 or var_530_16 * (var_530_21 / var_530_20)

				if var_530_22 > 0 and var_530_16 < var_530_22 then
					arg_527_1.talkMaxDuration = var_530_22

					if var_530_22 + var_530_15 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_22 + var_530_15
					end
				end

				arg_527_1.text_.text = var_530_19
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403126", "story_v_side_new_1107403.awb") ~= 0 then
					local var_530_23 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403126", "story_v_side_new_1107403.awb") / 1000

					if var_530_23 + var_530_15 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_23 + var_530_15
					end

					if var_530_18.prefab_name ~= "" and arg_527_1.actors_[var_530_18.prefab_name] ~= nil then
						local var_530_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_18.prefab_name].transform, "story_v_side_new_1107403", "1107403126", "story_v_side_new_1107403.awb")

						arg_527_1:RecordAudio("1107403126", var_530_24)
						arg_527_1:RecordAudio("1107403126", var_530_24)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403126", "story_v_side_new_1107403.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403126", "story_v_side_new_1107403.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_25 = math.max(var_530_16, arg_527_1.talkMaxDuration)

			if var_530_15 <= arg_527_1.time_ and arg_527_1.time_ < var_530_15 + var_530_25 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_15) / var_530_25

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_15 + var_530_25 and arg_527_1.time_ < var_530_15 + var_530_25 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_527_1:InitPlayNodeList()
	end,
	Play1107403127 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1107403127
		arg_531_1.duration_ = 2

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1107403128(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0

			if var_534_0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_0 + arg_534_0 then
				arg_531_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action4_1")
			end

			local var_534_1 = 0

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_534_2 = 0
			local var_534_3 = 0.15

			if var_534_2 < arg_531_1.time_ and arg_531_1.time_ <= var_534_2 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_4 = arg_531_1:FormatText(StoryNameCfg[380].name)

				arg_531_1.leftNameTxt_.text = var_534_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_5 = arg_531_1:GetWordFromCfg(1107403127)
				local var_534_6 = arg_531_1:FormatText(var_534_5.content)

				arg_531_1.text_.text = var_534_6

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_7 = 6
				local var_534_8 = utf8.len(var_534_6)
				local var_534_9 = var_534_7 <= 0 and var_534_3 or var_534_3 * (var_534_8 / var_534_7)

				if var_534_9 > 0 and var_534_3 < var_534_9 then
					arg_531_1.talkMaxDuration = var_534_9

					if var_534_9 + var_534_2 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_9 + var_534_2
					end
				end

				arg_531_1.text_.text = var_534_6
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403127", "story_v_side_new_1107403.awb") ~= 0 then
					local var_534_10 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403127", "story_v_side_new_1107403.awb") / 1000

					if var_534_10 + var_534_2 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_10 + var_534_2
					end

					if var_534_5.prefab_name ~= "" and arg_531_1.actors_[var_534_5.prefab_name] ~= nil then
						local var_534_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_5.prefab_name].transform, "story_v_side_new_1107403", "1107403127", "story_v_side_new_1107403.awb")

						arg_531_1:RecordAudio("1107403127", var_534_11)
						arg_531_1:RecordAudio("1107403127", var_534_11)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403127", "story_v_side_new_1107403.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403127", "story_v_side_new_1107403.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_12 = math.max(var_534_3, arg_531_1.talkMaxDuration)

			if var_534_2 <= arg_531_1.time_ and arg_531_1.time_ < var_534_2 + var_534_12 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_2) / var_534_12

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_2 + var_534_12 and arg_531_1.time_ < var_534_2 + var_534_12 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1107403128 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1107403128
		arg_535_1.duration_ = 2

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1107403129(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = arg_535_1.actors_["10044ui_story"].transform
			local var_538_1 = 0

			if var_538_1 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.var_.moveOldPos10044ui_story = var_538_0.localPosition
			end

			local var_538_2 = 0.001

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_2 then
				local var_538_3 = (arg_535_1.time_ - var_538_1) / var_538_2
				local var_538_4 = Vector3.New(-0.7, -0.72, -6.3)

				var_538_0.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos10044ui_story, var_538_4, var_538_3)

				local var_538_5 = manager.ui.mainCamera.transform.position - var_538_0.position

				var_538_0.forward = Vector3.New(var_538_5.x, var_538_5.y, var_538_5.z)

				local var_538_6 = var_538_0.localEulerAngles

				var_538_6.z = 0
				var_538_6.x = 0
				var_538_0.localEulerAngles = var_538_6
			end

			if arg_535_1.time_ >= var_538_1 + var_538_2 and arg_535_1.time_ < var_538_1 + var_538_2 + arg_538_0 then
				var_538_0.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_538_7 = manager.ui.mainCamera.transform.position - var_538_0.position

				var_538_0.forward = Vector3.New(var_538_7.x, var_538_7.y, var_538_7.z)

				local var_538_8 = var_538_0.localEulerAngles

				var_538_8.z = 0
				var_538_8.x = 0
				var_538_0.localEulerAngles = var_538_8
			end

			local var_538_9 = 0

			if var_538_9 < arg_535_1.time_ and arg_535_1.time_ <= var_538_9 + arg_538_0 then
				arg_535_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_538_10 = arg_535_1.actors_["10044ui_story"]
			local var_538_11 = 0

			if var_538_11 < arg_535_1.time_ and arg_535_1.time_ <= var_538_11 + arg_538_0 and not isNil(var_538_10) and arg_535_1.var_.characterEffect10044ui_story == nil then
				arg_535_1.var_.characterEffect10044ui_story = var_538_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_12 = 0.1

			if var_538_11 <= arg_535_1.time_ and arg_535_1.time_ < var_538_11 + var_538_12 and not isNil(var_538_10) then
				local var_538_13 = (arg_535_1.time_ - var_538_11) / var_538_12

				if arg_535_1.var_.characterEffect10044ui_story and not isNil(var_538_10) then
					local var_538_14 = Mathf.Lerp(0, 0.5, var_538_13)

					arg_535_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_535_1.var_.characterEffect10044ui_story.fillRatio = var_538_14
				end
			end

			if arg_535_1.time_ >= var_538_11 + var_538_12 and arg_535_1.time_ < var_538_11 + var_538_12 + arg_538_0 and not isNil(var_538_10) and arg_535_1.var_.characterEffect10044ui_story then
				local var_538_15 = 0.5

				arg_535_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_535_1.var_.characterEffect10044ui_story.fillRatio = var_538_15
			end

			local var_538_16 = arg_535_1.actors_["1074ui_story"]
			local var_538_17 = 0

			if var_538_17 < arg_535_1.time_ and arg_535_1.time_ <= var_538_17 + arg_538_0 and not isNil(var_538_16) and arg_535_1.var_.characterEffect1074ui_story == nil then
				arg_535_1.var_.characterEffect1074ui_story = var_538_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_18 = 0.1

			if var_538_17 <= arg_535_1.time_ and arg_535_1.time_ < var_538_17 + var_538_18 and not isNil(var_538_16) then
				local var_538_19 = (arg_535_1.time_ - var_538_17) / var_538_18

				if arg_535_1.var_.characterEffect1074ui_story and not isNil(var_538_16) then
					arg_535_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_535_1.time_ >= var_538_17 + var_538_18 and arg_535_1.time_ < var_538_17 + var_538_18 + arg_538_0 and not isNil(var_538_16) and arg_535_1.var_.characterEffect1074ui_story then
				arg_535_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_538_20 = arg_535_1.actors_["1074ui_story"].transform
			local var_538_21 = 0

			if var_538_21 < arg_535_1.time_ and arg_535_1.time_ <= var_538_21 + arg_538_0 then
				arg_535_1.var_.moveOldPos1074ui_story = var_538_20.localPosition

				local var_538_22 = "1074ui_story"

				arg_535_1:ShowWeapon(arg_535_1.var_[var_538_22 .. "Animator"].transform, false)
			end

			local var_538_23 = 0.001

			if var_538_21 <= arg_535_1.time_ and arg_535_1.time_ < var_538_21 + var_538_23 then
				local var_538_24 = (arg_535_1.time_ - var_538_21) / var_538_23
				local var_538_25 = Vector3.New(0.7, -1.055, -6.12)

				var_538_20.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1074ui_story, var_538_25, var_538_24)

				local var_538_26 = manager.ui.mainCamera.transform.position - var_538_20.position

				var_538_20.forward = Vector3.New(var_538_26.x, var_538_26.y, var_538_26.z)

				local var_538_27 = var_538_20.localEulerAngles

				var_538_27.z = 0
				var_538_27.x = 0
				var_538_20.localEulerAngles = var_538_27
			end

			if arg_535_1.time_ >= var_538_21 + var_538_23 and arg_535_1.time_ < var_538_21 + var_538_23 + arg_538_0 then
				var_538_20.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_538_28 = manager.ui.mainCamera.transform.position - var_538_20.position

				var_538_20.forward = Vector3.New(var_538_28.x, var_538_28.y, var_538_28.z)

				local var_538_29 = var_538_20.localEulerAngles

				var_538_29.z = 0
				var_538_29.x = 0
				var_538_20.localEulerAngles = var_538_29
			end

			local var_538_30 = 0
			local var_538_31 = 0.15

			if var_538_30 < arg_535_1.time_ and arg_535_1.time_ <= var_538_30 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				local var_538_32 = arg_535_1:FormatText(StoryNameCfg[410].name)

				arg_535_1.leftNameTxt_.text = var_538_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_33 = arg_535_1:GetWordFromCfg(1107403128)
				local var_538_34 = arg_535_1:FormatText(var_538_33.content)

				arg_535_1.text_.text = var_538_34

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_35 = 6
				local var_538_36 = utf8.len(var_538_34)
				local var_538_37 = var_538_35 <= 0 and var_538_31 or var_538_31 * (var_538_36 / var_538_35)

				if var_538_37 > 0 and var_538_31 < var_538_37 then
					arg_535_1.talkMaxDuration = var_538_37

					if var_538_37 + var_538_30 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_37 + var_538_30
					end
				end

				arg_535_1.text_.text = var_538_34
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403128", "story_v_side_new_1107403.awb") ~= 0 then
					local var_538_38 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403128", "story_v_side_new_1107403.awb") / 1000

					if var_538_38 + var_538_30 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_38 + var_538_30
					end

					if var_538_33.prefab_name ~= "" and arg_535_1.actors_[var_538_33.prefab_name] ~= nil then
						local var_538_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_33.prefab_name].transform, "story_v_side_new_1107403", "1107403128", "story_v_side_new_1107403.awb")

						arg_535_1:RecordAudio("1107403128", var_538_39)
						arg_535_1:RecordAudio("1107403128", var_538_39)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403128", "story_v_side_new_1107403.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403128", "story_v_side_new_1107403.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_40 = math.max(var_538_31, arg_535_1.talkMaxDuration)

			if var_538_30 <= arg_535_1.time_ and arg_535_1.time_ < var_538_30 + var_538_40 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_30) / var_538_40

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_30 + var_538_40 and arg_535_1.time_ < var_538_30 + var_538_40 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play1107403129 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1107403129
		arg_539_1.duration_ = 6.4

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1107403130(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0

			if var_542_0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_0 + arg_542_0 then
				arg_539_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action4_2")
			end

			local var_542_1 = 0

			if var_542_1 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 then
				arg_539_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_542_2 = arg_539_1.actors_["10044ui_story"]
			local var_542_3 = 0

			if var_542_3 < arg_539_1.time_ and arg_539_1.time_ <= var_542_3 + arg_542_0 and not isNil(var_542_2) and arg_539_1.var_.characterEffect10044ui_story == nil then
				arg_539_1.var_.characterEffect10044ui_story = var_542_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_4 = 0.1

			if var_542_3 <= arg_539_1.time_ and arg_539_1.time_ < var_542_3 + var_542_4 and not isNil(var_542_2) then
				local var_542_5 = (arg_539_1.time_ - var_542_3) / var_542_4

				if arg_539_1.var_.characterEffect10044ui_story and not isNil(var_542_2) then
					arg_539_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_539_1.time_ >= var_542_3 + var_542_4 and arg_539_1.time_ < var_542_3 + var_542_4 + arg_542_0 and not isNil(var_542_2) and arg_539_1.var_.characterEffect10044ui_story then
				arg_539_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_542_6 = arg_539_1.actors_["1074ui_story"]
			local var_542_7 = 0

			if var_542_7 < arg_539_1.time_ and arg_539_1.time_ <= var_542_7 + arg_542_0 and not isNil(var_542_6) and arg_539_1.var_.characterEffect1074ui_story == nil then
				arg_539_1.var_.characterEffect1074ui_story = var_542_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_8 = 0.1

			if var_542_7 <= arg_539_1.time_ and arg_539_1.time_ < var_542_7 + var_542_8 and not isNil(var_542_6) then
				local var_542_9 = (arg_539_1.time_ - var_542_7) / var_542_8

				if arg_539_1.var_.characterEffect1074ui_story and not isNil(var_542_6) then
					local var_542_10 = Mathf.Lerp(0, 0.5, var_542_9)

					arg_539_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_539_1.var_.characterEffect1074ui_story.fillRatio = var_542_10
				end
			end

			if arg_539_1.time_ >= var_542_7 + var_542_8 and arg_539_1.time_ < var_542_7 + var_542_8 + arg_542_0 and not isNil(var_542_6) and arg_539_1.var_.characterEffect1074ui_story then
				local var_542_11 = 0.5

				arg_539_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_539_1.var_.characterEffect1074ui_story.fillRatio = var_542_11
			end

			local var_542_12 = 0
			local var_542_13 = 0.8

			if var_542_12 < arg_539_1.time_ and arg_539_1.time_ <= var_542_12 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_14 = arg_539_1:FormatText(StoryNameCfg[380].name)

				arg_539_1.leftNameTxt_.text = var_542_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_15 = arg_539_1:GetWordFromCfg(1107403129)
				local var_542_16 = arg_539_1:FormatText(var_542_15.content)

				arg_539_1.text_.text = var_542_16

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_17 = 32
				local var_542_18 = utf8.len(var_542_16)
				local var_542_19 = var_542_17 <= 0 and var_542_13 or var_542_13 * (var_542_18 / var_542_17)

				if var_542_19 > 0 and var_542_13 < var_542_19 then
					arg_539_1.talkMaxDuration = var_542_19

					if var_542_19 + var_542_12 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_19 + var_542_12
					end
				end

				arg_539_1.text_.text = var_542_16
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403129", "story_v_side_new_1107403.awb") ~= 0 then
					local var_542_20 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403129", "story_v_side_new_1107403.awb") / 1000

					if var_542_20 + var_542_12 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_20 + var_542_12
					end

					if var_542_15.prefab_name ~= "" and arg_539_1.actors_[var_542_15.prefab_name] ~= nil then
						local var_542_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_15.prefab_name].transform, "story_v_side_new_1107403", "1107403129", "story_v_side_new_1107403.awb")

						arg_539_1:RecordAudio("1107403129", var_542_21)
						arg_539_1:RecordAudio("1107403129", var_542_21)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403129", "story_v_side_new_1107403.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403129", "story_v_side_new_1107403.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_22 = math.max(var_542_13, arg_539_1.talkMaxDuration)

			if var_542_12 <= arg_539_1.time_ and arg_539_1.time_ < var_542_12 + var_542_22 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_12) / var_542_22

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_12 + var_542_22 and arg_539_1.time_ < var_542_12 + var_542_22 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1107403130 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1107403130
		arg_543_1.duration_ = 3.23

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1107403131(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0

			if var_546_0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_0 + arg_546_0 then
				arg_543_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_546_1 = 0
			local var_546_2 = 0.45

			if var_546_1 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_3 = arg_543_1:FormatText(StoryNameCfg[380].name)

				arg_543_1.leftNameTxt_.text = var_546_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_4 = arg_543_1:GetWordFromCfg(1107403130)
				local var_546_5 = arg_543_1:FormatText(var_546_4.content)

				arg_543_1.text_.text = var_546_5

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_6 = 18
				local var_546_7 = utf8.len(var_546_5)
				local var_546_8 = var_546_6 <= 0 and var_546_2 or var_546_2 * (var_546_7 / var_546_6)

				if var_546_8 > 0 and var_546_2 < var_546_8 then
					arg_543_1.talkMaxDuration = var_546_8

					if var_546_8 + var_546_1 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_8 + var_546_1
					end
				end

				arg_543_1.text_.text = var_546_5
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403130", "story_v_side_new_1107403.awb") ~= 0 then
					local var_546_9 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403130", "story_v_side_new_1107403.awb") / 1000

					if var_546_9 + var_546_1 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_9 + var_546_1
					end

					if var_546_4.prefab_name ~= "" and arg_543_1.actors_[var_546_4.prefab_name] ~= nil then
						local var_546_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_4.prefab_name].transform, "story_v_side_new_1107403", "1107403130", "story_v_side_new_1107403.awb")

						arg_543_1:RecordAudio("1107403130", var_546_10)
						arg_543_1:RecordAudio("1107403130", var_546_10)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403130", "story_v_side_new_1107403.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403130", "story_v_side_new_1107403.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_11 = math.max(var_546_2, arg_543_1.talkMaxDuration)

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_11 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_1) / var_546_11

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_1 + var_546_11 and arg_543_1.time_ < var_546_1 + var_546_11 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play1107403131 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1107403131
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1107403132(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = arg_547_1.actors_["10044ui_story"]
			local var_550_1 = 0

			if var_550_1 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.characterEffect10044ui_story == nil then
				arg_547_1.var_.characterEffect10044ui_story = var_550_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_2 = 0.1

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_2 and not isNil(var_550_0) then
				local var_550_3 = (arg_547_1.time_ - var_550_1) / var_550_2

				if arg_547_1.var_.characterEffect10044ui_story and not isNil(var_550_0) then
					local var_550_4 = Mathf.Lerp(0, 0.5, var_550_3)

					arg_547_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_547_1.var_.characterEffect10044ui_story.fillRatio = var_550_4
				end
			end

			if arg_547_1.time_ >= var_550_1 + var_550_2 and arg_547_1.time_ < var_550_1 + var_550_2 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.characterEffect10044ui_story then
				local var_550_5 = 0.5

				arg_547_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_547_1.var_.characterEffect10044ui_story.fillRatio = var_550_5
			end

			local var_550_6 = 0
			local var_550_7 = 0.575

			if var_550_6 < arg_547_1.time_ and arg_547_1.time_ <= var_550_6 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, false)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_8 = arg_547_1:GetWordFromCfg(1107403131)
				local var_550_9 = arg_547_1:FormatText(var_550_8.content)

				arg_547_1.text_.text = var_550_9

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_10 = 23
				local var_550_11 = utf8.len(var_550_9)
				local var_550_12 = var_550_10 <= 0 and var_550_7 or var_550_7 * (var_550_11 / var_550_10)

				if var_550_12 > 0 and var_550_7 < var_550_12 then
					arg_547_1.talkMaxDuration = var_550_12

					if var_550_12 + var_550_6 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_12 + var_550_6
					end
				end

				arg_547_1.text_.text = var_550_9
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_13 = math.max(var_550_7, arg_547_1.talkMaxDuration)

			if var_550_6 <= arg_547_1.time_ and arg_547_1.time_ < var_550_6 + var_550_13 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_6) / var_550_13

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_6 + var_550_13 and arg_547_1.time_ < var_550_6 + var_550_13 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play1107403132 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1107403132
		arg_551_1.duration_ = 3.3

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1107403133(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = arg_551_1.actors_["10044ui_story"]
			local var_554_1 = 0

			if var_554_1 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 and not isNil(var_554_0) and arg_551_1.var_.characterEffect10044ui_story == nil then
				arg_551_1.var_.characterEffect10044ui_story = var_554_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_2 = 0.1

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_2 and not isNil(var_554_0) then
				local var_554_3 = (arg_551_1.time_ - var_554_1) / var_554_2

				if arg_551_1.var_.characterEffect10044ui_story and not isNil(var_554_0) then
					arg_551_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_551_1.time_ >= var_554_1 + var_554_2 and arg_551_1.time_ < var_554_1 + var_554_2 + arg_554_0 and not isNil(var_554_0) and arg_551_1.var_.characterEffect10044ui_story then
				arg_551_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_554_4 = 0
			local var_554_5 = 0.35

			if var_554_4 < arg_551_1.time_ and arg_551_1.time_ <= var_554_4 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_6 = arg_551_1:FormatText(StoryNameCfg[380].name)

				arg_551_1.leftNameTxt_.text = var_554_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_7 = arg_551_1:GetWordFromCfg(1107403132)
				local var_554_8 = arg_551_1:FormatText(var_554_7.content)

				arg_551_1.text_.text = var_554_8

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_9 = 14
				local var_554_10 = utf8.len(var_554_8)
				local var_554_11 = var_554_9 <= 0 and var_554_5 or var_554_5 * (var_554_10 / var_554_9)

				if var_554_11 > 0 and var_554_5 < var_554_11 then
					arg_551_1.talkMaxDuration = var_554_11

					if var_554_11 + var_554_4 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_11 + var_554_4
					end
				end

				arg_551_1.text_.text = var_554_8
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403132", "story_v_side_new_1107403.awb") ~= 0 then
					local var_554_12 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403132", "story_v_side_new_1107403.awb") / 1000

					if var_554_12 + var_554_4 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_12 + var_554_4
					end

					if var_554_7.prefab_name ~= "" and arg_551_1.actors_[var_554_7.prefab_name] ~= nil then
						local var_554_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_7.prefab_name].transform, "story_v_side_new_1107403", "1107403132", "story_v_side_new_1107403.awb")

						arg_551_1:RecordAudio("1107403132", var_554_13)
						arg_551_1:RecordAudio("1107403132", var_554_13)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403132", "story_v_side_new_1107403.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403132", "story_v_side_new_1107403.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_14 = math.max(var_554_5, arg_551_1.talkMaxDuration)

			if var_554_4 <= arg_551_1.time_ and arg_551_1.time_ < var_554_4 + var_554_14 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_4) / var_554_14

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_4 + var_554_14 and arg_551_1.time_ < var_554_4 + var_554_14 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play1107403133 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1107403133
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1107403134(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = arg_555_1.actors_["10044ui_story"].transform
			local var_558_1 = 0

			if var_558_1 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 then
				arg_555_1.var_.moveOldPos10044ui_story = var_558_0.localPosition
			end

			local var_558_2 = 0.001

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_2 then
				local var_558_3 = (arg_555_1.time_ - var_558_1) / var_558_2
				local var_558_4 = Vector3.New(0, 100, 0)

				var_558_0.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos10044ui_story, var_558_4, var_558_3)

				local var_558_5 = manager.ui.mainCamera.transform.position - var_558_0.position

				var_558_0.forward = Vector3.New(var_558_5.x, var_558_5.y, var_558_5.z)

				local var_558_6 = var_558_0.localEulerAngles

				var_558_6.z = 0
				var_558_6.x = 0
				var_558_0.localEulerAngles = var_558_6
			end

			if arg_555_1.time_ >= var_558_1 + var_558_2 and arg_555_1.time_ < var_558_1 + var_558_2 + arg_558_0 then
				var_558_0.localPosition = Vector3.New(0, 100, 0)

				local var_558_7 = manager.ui.mainCamera.transform.position - var_558_0.position

				var_558_0.forward = Vector3.New(var_558_7.x, var_558_7.y, var_558_7.z)

				local var_558_8 = var_558_0.localEulerAngles

				var_558_8.z = 0
				var_558_8.x = 0
				var_558_0.localEulerAngles = var_558_8
			end

			local var_558_9 = arg_555_1.actors_["1074ui_story"].transform
			local var_558_10 = 0

			if var_558_10 < arg_555_1.time_ and arg_555_1.time_ <= var_558_10 + arg_558_0 then
				arg_555_1.var_.moveOldPos1074ui_story = var_558_9.localPosition

				local var_558_11 = "1074ui_story"

				arg_555_1:ShowWeapon(arg_555_1.var_[var_558_11 .. "Animator"].transform, false)
			end

			local var_558_12 = 0.001

			if var_558_10 <= arg_555_1.time_ and arg_555_1.time_ < var_558_10 + var_558_12 then
				local var_558_13 = (arg_555_1.time_ - var_558_10) / var_558_12
				local var_558_14 = Vector3.New(0, 100, 0)

				var_558_9.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos1074ui_story, var_558_14, var_558_13)

				local var_558_15 = manager.ui.mainCamera.transform.position - var_558_9.position

				var_558_9.forward = Vector3.New(var_558_15.x, var_558_15.y, var_558_15.z)

				local var_558_16 = var_558_9.localEulerAngles

				var_558_16.z = 0
				var_558_16.x = 0
				var_558_9.localEulerAngles = var_558_16
			end

			if arg_555_1.time_ >= var_558_10 + var_558_12 and arg_555_1.time_ < var_558_10 + var_558_12 + arg_558_0 then
				var_558_9.localPosition = Vector3.New(0, 100, 0)

				local var_558_17 = manager.ui.mainCamera.transform.position - var_558_9.position

				var_558_9.forward = Vector3.New(var_558_17.x, var_558_17.y, var_558_17.z)

				local var_558_18 = var_558_9.localEulerAngles

				var_558_18.z = 0
				var_558_18.x = 0
				var_558_9.localEulerAngles = var_558_18
			end

			local var_558_19 = 0
			local var_558_20 = 1.2

			if var_558_19 < arg_555_1.time_ and arg_555_1.time_ <= var_558_19 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_21 = arg_555_1:GetWordFromCfg(1107403133)
				local var_558_22 = arg_555_1:FormatText(var_558_21.content)

				arg_555_1.text_.text = var_558_22

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_23 = 48
				local var_558_24 = utf8.len(var_558_22)
				local var_558_25 = var_558_23 <= 0 and var_558_20 or var_558_20 * (var_558_24 / var_558_23)

				if var_558_25 > 0 and var_558_20 < var_558_25 then
					arg_555_1.talkMaxDuration = var_558_25

					if var_558_25 + var_558_19 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_25 + var_558_19
					end
				end

				arg_555_1.text_.text = var_558_22
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_26 = math.max(var_558_20, arg_555_1.talkMaxDuration)

			if var_558_19 <= arg_555_1.time_ and arg_555_1.time_ < var_558_19 + var_558_26 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_19) / var_558_26

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_19 + var_558_26 and arg_555_1.time_ < var_558_19 + var_558_26 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_555_1:InitPlayNodeList()
	end,
	Play1107403134 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1107403134
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1107403135(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0
			local var_562_1 = 0.925

			if var_562_0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, false)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_2 = arg_559_1:GetWordFromCfg(1107403134)
				local var_562_3 = arg_559_1:FormatText(var_562_2.content)

				arg_559_1.text_.text = var_562_3

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_4 = 37
				local var_562_5 = utf8.len(var_562_3)
				local var_562_6 = var_562_4 <= 0 and var_562_1 or var_562_1 * (var_562_5 / var_562_4)

				if var_562_6 > 0 and var_562_1 < var_562_6 then
					arg_559_1.talkMaxDuration = var_562_6

					if var_562_6 + var_562_0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_6 + var_562_0
					end
				end

				arg_559_1.text_.text = var_562_3
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_7 = math.max(var_562_1, arg_559_1.talkMaxDuration)

			if var_562_0 <= arg_559_1.time_ and arg_559_1.time_ < var_562_0 + var_562_7 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_0) / var_562_7

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_0 + var_562_7 and arg_559_1.time_ < var_562_0 + var_562_7 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play1107403135 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1107403135
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play1107403136(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = arg_563_1.actors_["1074ui_story"]
			local var_566_1 = 0

			if var_566_1 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.characterEffect1074ui_story == nil then
				arg_563_1.var_.characterEffect1074ui_story = var_566_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_2 = 0.1

			if var_566_1 <= arg_563_1.time_ and arg_563_1.time_ < var_566_1 + var_566_2 and not isNil(var_566_0) then
				local var_566_3 = (arg_563_1.time_ - var_566_1) / var_566_2

				if arg_563_1.var_.characterEffect1074ui_story and not isNil(var_566_0) then
					local var_566_4 = Mathf.Lerp(0, 0.5, var_566_3)

					arg_563_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_563_1.var_.characterEffect1074ui_story.fillRatio = var_566_4
				end
			end

			if arg_563_1.time_ >= var_566_1 + var_566_2 and arg_563_1.time_ < var_566_1 + var_566_2 + arg_566_0 and not isNil(var_566_0) and arg_563_1.var_.characterEffect1074ui_story then
				local var_566_5 = 0.5

				arg_563_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_563_1.var_.characterEffect1074ui_story.fillRatio = var_566_5
			end

			local var_566_6 = 0
			local var_566_7 = 0.775

			if var_566_6 < arg_563_1.time_ and arg_563_1.time_ <= var_566_6 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_8 = arg_563_1:FormatText(StoryNameCfg[7].name)

				arg_563_1.leftNameTxt_.text = var_566_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_9 = arg_563_1:GetWordFromCfg(1107403135)
				local var_566_10 = arg_563_1:FormatText(var_566_9.content)

				arg_563_1.text_.text = var_566_10

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_11 = 31
				local var_566_12 = utf8.len(var_566_10)
				local var_566_13 = var_566_11 <= 0 and var_566_7 or var_566_7 * (var_566_12 / var_566_11)

				if var_566_13 > 0 and var_566_7 < var_566_13 then
					arg_563_1.talkMaxDuration = var_566_13

					if var_566_13 + var_566_6 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_13 + var_566_6
					end
				end

				arg_563_1.text_.text = var_566_10
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)
				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_14 = math.max(var_566_7, arg_563_1.talkMaxDuration)

			if var_566_6 <= arg_563_1.time_ and arg_563_1.time_ < var_566_6 + var_566_14 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_6) / var_566_14

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_6 + var_566_14 and arg_563_1.time_ < var_566_6 + var_566_14 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play1107403136 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1107403136
		arg_567_1.duration_ = 2.17

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1107403137(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = arg_567_1.actors_["1074ui_story"].transform
			local var_570_1 = 0

			if var_570_1 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 then
				arg_567_1.var_.moveOldPos1074ui_story = var_570_0.localPosition
			end

			local var_570_2 = 0.001

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_2 then
				local var_570_3 = (arg_567_1.time_ - var_570_1) / var_570_2
				local var_570_4 = Vector3.New(0, -1.055, -6.12)

				var_570_0.localPosition = Vector3.Lerp(arg_567_1.var_.moveOldPos1074ui_story, var_570_4, var_570_3)

				local var_570_5 = manager.ui.mainCamera.transform.position - var_570_0.position

				var_570_0.forward = Vector3.New(var_570_5.x, var_570_5.y, var_570_5.z)

				local var_570_6 = var_570_0.localEulerAngles

				var_570_6.z = 0
				var_570_6.x = 0
				var_570_0.localEulerAngles = var_570_6
			end

			if arg_567_1.time_ >= var_570_1 + var_570_2 and arg_567_1.time_ < var_570_1 + var_570_2 + arg_570_0 then
				var_570_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_570_7 = manager.ui.mainCamera.transform.position - var_570_0.position

				var_570_0.forward = Vector3.New(var_570_7.x, var_570_7.y, var_570_7.z)

				local var_570_8 = var_570_0.localEulerAngles

				var_570_8.z = 0
				var_570_8.x = 0
				var_570_0.localEulerAngles = var_570_8
			end

			local var_570_9 = 0

			if var_570_9 < arg_567_1.time_ and arg_567_1.time_ <= var_570_9 + arg_570_0 then
				arg_567_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			local var_570_10 = 0

			if var_570_10 < arg_567_1.time_ and arg_567_1.time_ <= var_570_10 + arg_570_0 then
				arg_567_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_570_11 = arg_567_1.actors_["1074ui_story"]
			local var_570_12 = 0

			if var_570_12 < arg_567_1.time_ and arg_567_1.time_ <= var_570_12 + arg_570_0 and not isNil(var_570_11) and arg_567_1.var_.characterEffect1074ui_story == nil then
				arg_567_1.var_.characterEffect1074ui_story = var_570_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_13 = 0.1

			if var_570_12 <= arg_567_1.time_ and arg_567_1.time_ < var_570_12 + var_570_13 and not isNil(var_570_11) then
				local var_570_14 = (arg_567_1.time_ - var_570_12) / var_570_13

				if arg_567_1.var_.characterEffect1074ui_story and not isNil(var_570_11) then
					arg_567_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_567_1.time_ >= var_570_12 + var_570_13 and arg_567_1.time_ < var_570_12 + var_570_13 + arg_570_0 and not isNil(var_570_11) and arg_567_1.var_.characterEffect1074ui_story then
				arg_567_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_570_15 = 0
			local var_570_16 = 0.325

			if var_570_15 < arg_567_1.time_ and arg_567_1.time_ <= var_570_15 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_17 = arg_567_1:FormatText(StoryNameCfg[410].name)

				arg_567_1.leftNameTxt_.text = var_570_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_18 = arg_567_1:GetWordFromCfg(1107403136)
				local var_570_19 = arg_567_1:FormatText(var_570_18.content)

				arg_567_1.text_.text = var_570_19

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_20 = 13
				local var_570_21 = utf8.len(var_570_19)
				local var_570_22 = var_570_20 <= 0 and var_570_16 or var_570_16 * (var_570_21 / var_570_20)

				if var_570_22 > 0 and var_570_16 < var_570_22 then
					arg_567_1.talkMaxDuration = var_570_22

					if var_570_22 + var_570_15 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_22 + var_570_15
					end
				end

				arg_567_1.text_.text = var_570_19
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403136", "story_v_side_new_1107403.awb") ~= 0 then
					local var_570_23 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403136", "story_v_side_new_1107403.awb") / 1000

					if var_570_23 + var_570_15 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_23 + var_570_15
					end

					if var_570_18.prefab_name ~= "" and arg_567_1.actors_[var_570_18.prefab_name] ~= nil then
						local var_570_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_18.prefab_name].transform, "story_v_side_new_1107403", "1107403136", "story_v_side_new_1107403.awb")

						arg_567_1:RecordAudio("1107403136", var_570_24)
						arg_567_1:RecordAudio("1107403136", var_570_24)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403136", "story_v_side_new_1107403.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403136", "story_v_side_new_1107403.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_25 = math.max(var_570_16, arg_567_1.talkMaxDuration)

			if var_570_15 <= arg_567_1.time_ and arg_567_1.time_ < var_570_15 + var_570_25 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_15) / var_570_25

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_15 + var_570_25 and arg_567_1.time_ < var_570_15 + var_570_25 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_567_1:InitPlayNodeList()
	end,
	Play1107403137 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 1107403137
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play1107403138(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = arg_571_1.actors_["1074ui_story"]
			local var_574_1 = 0

			if var_574_1 < arg_571_1.time_ and arg_571_1.time_ <= var_574_1 + arg_574_0 and not isNil(var_574_0) and arg_571_1.var_.characterEffect1074ui_story == nil then
				arg_571_1.var_.characterEffect1074ui_story = var_574_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_2 = 0.1

			if var_574_1 <= arg_571_1.time_ and arg_571_1.time_ < var_574_1 + var_574_2 and not isNil(var_574_0) then
				local var_574_3 = (arg_571_1.time_ - var_574_1) / var_574_2

				if arg_571_1.var_.characterEffect1074ui_story and not isNil(var_574_0) then
					local var_574_4 = Mathf.Lerp(0, 0.5, var_574_3)

					arg_571_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_571_1.var_.characterEffect1074ui_story.fillRatio = var_574_4
				end
			end

			if arg_571_1.time_ >= var_574_1 + var_574_2 and arg_571_1.time_ < var_574_1 + var_574_2 + arg_574_0 and not isNil(var_574_0) and arg_571_1.var_.characterEffect1074ui_story then
				local var_574_5 = 0.5

				arg_571_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_571_1.var_.characterEffect1074ui_story.fillRatio = var_574_5
			end

			local var_574_6 = 0
			local var_574_7 = 0.95

			if var_574_6 < arg_571_1.time_ and arg_571_1.time_ <= var_574_6 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_8 = arg_571_1:FormatText(StoryNameCfg[7].name)

				arg_571_1.leftNameTxt_.text = var_574_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_9 = arg_571_1:GetWordFromCfg(1107403137)
				local var_574_10 = arg_571_1:FormatText(var_574_9.content)

				arg_571_1.text_.text = var_574_10

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_11 = 38
				local var_574_12 = utf8.len(var_574_10)
				local var_574_13 = var_574_11 <= 0 and var_574_7 or var_574_7 * (var_574_12 / var_574_11)

				if var_574_13 > 0 and var_574_7 < var_574_13 then
					arg_571_1.talkMaxDuration = var_574_13

					if var_574_13 + var_574_6 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_13 + var_574_6
					end
				end

				arg_571_1.text_.text = var_574_10
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_14 = math.max(var_574_7, arg_571_1.talkMaxDuration)

			if var_574_6 <= arg_571_1.time_ and arg_571_1.time_ < var_574_6 + var_574_14 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_6) / var_574_14

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_6 + var_574_14 and arg_571_1.time_ < var_574_6 + var_574_14 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play1107403138 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1107403138
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1107403139(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0
			local var_578_1 = 0.275

			if var_578_0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_2 = arg_575_1:FormatText(StoryNameCfg[7].name)

				arg_575_1.leftNameTxt_.text = var_578_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, true)
				arg_575_1.iconController_:SetSelectedState("hero")

				arg_575_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_575_1.callingController_:SetSelectedState("normal")

				arg_575_1.keyicon_.color = Color.New(1, 1, 1)
				arg_575_1.icon_.color = Color.New(1, 1, 1)

				local var_578_3 = arg_575_1:GetWordFromCfg(1107403138)
				local var_578_4 = arg_575_1:FormatText(var_578_3.content)

				arg_575_1.text_.text = var_578_4

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_5 = 11
				local var_578_6 = utf8.len(var_578_4)
				local var_578_7 = var_578_5 <= 0 and var_578_1 or var_578_1 * (var_578_6 / var_578_5)

				if var_578_7 > 0 and var_578_1 < var_578_7 then
					arg_575_1.talkMaxDuration = var_578_7

					if var_578_7 + var_578_0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_7 + var_578_0
					end
				end

				arg_575_1.text_.text = var_578_4
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_8 = math.max(var_578_1, arg_575_1.talkMaxDuration)

			if var_578_0 <= arg_575_1.time_ and arg_575_1.time_ < var_578_0 + var_578_8 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_0) / var_578_8

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_0 + var_578_8 and arg_575_1.time_ < var_578_0 + var_578_8 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play1107403139 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1107403139
		arg_579_1.duration_ = 5.3

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1107403140(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = arg_579_1.actors_["1074ui_story"]
			local var_582_1 = 0

			if var_582_1 < arg_579_1.time_ and arg_579_1.time_ <= var_582_1 + arg_582_0 and not isNil(var_582_0) and arg_579_1.var_.characterEffect1074ui_story == nil then
				arg_579_1.var_.characterEffect1074ui_story = var_582_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_2 = 0.1

			if var_582_1 <= arg_579_1.time_ and arg_579_1.time_ < var_582_1 + var_582_2 and not isNil(var_582_0) then
				local var_582_3 = (arg_579_1.time_ - var_582_1) / var_582_2

				if arg_579_1.var_.characterEffect1074ui_story and not isNil(var_582_0) then
					arg_579_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_579_1.time_ >= var_582_1 + var_582_2 and arg_579_1.time_ < var_582_1 + var_582_2 + arg_582_0 and not isNil(var_582_0) and arg_579_1.var_.characterEffect1074ui_story then
				arg_579_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_582_4 = 0

			if var_582_4 < arg_579_1.time_ and arg_579_1.time_ <= var_582_4 + arg_582_0 then
				arg_579_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_2")
			end

			local var_582_5 = 0
			local var_582_6 = 0.575

			if var_582_5 < arg_579_1.time_ and arg_579_1.time_ <= var_582_5 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				local var_582_7 = arg_579_1:FormatText(StoryNameCfg[410].name)

				arg_579_1.leftNameTxt_.text = var_582_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_8 = arg_579_1:GetWordFromCfg(1107403139)
				local var_582_9 = arg_579_1:FormatText(var_582_8.content)

				arg_579_1.text_.text = var_582_9

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_10 = 23
				local var_582_11 = utf8.len(var_582_9)
				local var_582_12 = var_582_10 <= 0 and var_582_6 or var_582_6 * (var_582_11 / var_582_10)

				if var_582_12 > 0 and var_582_6 < var_582_12 then
					arg_579_1.talkMaxDuration = var_582_12

					if var_582_12 + var_582_5 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_12 + var_582_5
					end
				end

				arg_579_1.text_.text = var_582_9
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403139", "story_v_side_new_1107403.awb") ~= 0 then
					local var_582_13 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403139", "story_v_side_new_1107403.awb") / 1000

					if var_582_13 + var_582_5 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_13 + var_582_5
					end

					if var_582_8.prefab_name ~= "" and arg_579_1.actors_[var_582_8.prefab_name] ~= nil then
						local var_582_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_8.prefab_name].transform, "story_v_side_new_1107403", "1107403139", "story_v_side_new_1107403.awb")

						arg_579_1:RecordAudio("1107403139", var_582_14)
						arg_579_1:RecordAudio("1107403139", var_582_14)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403139", "story_v_side_new_1107403.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403139", "story_v_side_new_1107403.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_15 = math.max(var_582_6, arg_579_1.talkMaxDuration)

			if var_582_5 <= arg_579_1.time_ and arg_579_1.time_ < var_582_5 + var_582_15 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_5) / var_582_15

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_5 + var_582_15 and arg_579_1.time_ < var_582_5 + var_582_15 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1107403140 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1107403140
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1107403141(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = arg_583_1.actors_["1074ui_story"]
			local var_586_1 = 0

			if var_586_1 < arg_583_1.time_ and arg_583_1.time_ <= var_586_1 + arg_586_0 and not isNil(var_586_0) and arg_583_1.var_.characterEffect1074ui_story == nil then
				arg_583_1.var_.characterEffect1074ui_story = var_586_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_2 = 0.1

			if var_586_1 <= arg_583_1.time_ and arg_583_1.time_ < var_586_1 + var_586_2 and not isNil(var_586_0) then
				local var_586_3 = (arg_583_1.time_ - var_586_1) / var_586_2

				if arg_583_1.var_.characterEffect1074ui_story and not isNil(var_586_0) then
					local var_586_4 = Mathf.Lerp(0, 0.5, var_586_3)

					arg_583_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_583_1.var_.characterEffect1074ui_story.fillRatio = var_586_4
				end
			end

			if arg_583_1.time_ >= var_586_1 + var_586_2 and arg_583_1.time_ < var_586_1 + var_586_2 + arg_586_0 and not isNil(var_586_0) and arg_583_1.var_.characterEffect1074ui_story then
				local var_586_5 = 0.5

				arg_583_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_583_1.var_.characterEffect1074ui_story.fillRatio = var_586_5
			end

			local var_586_6 = 0
			local var_586_7 = 1

			if var_586_6 < arg_583_1.time_ and arg_583_1.time_ <= var_586_6 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				local var_586_8 = arg_583_1:FormatText(StoryNameCfg[7].name)

				arg_583_1.leftNameTxt_.text = var_586_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, true)
				arg_583_1.iconController_:SetSelectedState("hero")

				arg_583_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_583_1.callingController_:SetSelectedState("normal")

				arg_583_1.keyicon_.color = Color.New(1, 1, 1)
				arg_583_1.icon_.color = Color.New(1, 1, 1)

				local var_586_9 = arg_583_1:GetWordFromCfg(1107403140)
				local var_586_10 = arg_583_1:FormatText(var_586_9.content)

				arg_583_1.text_.text = var_586_10

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_11 = 40
				local var_586_12 = utf8.len(var_586_10)
				local var_586_13 = var_586_11 <= 0 and var_586_7 or var_586_7 * (var_586_12 / var_586_11)

				if var_586_13 > 0 and var_586_7 < var_586_13 then
					arg_583_1.talkMaxDuration = var_586_13

					if var_586_13 + var_586_6 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_13 + var_586_6
					end
				end

				arg_583_1.text_.text = var_586_10
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_14 = math.max(var_586_7, arg_583_1.talkMaxDuration)

			if var_586_6 <= arg_583_1.time_ and arg_583_1.time_ < var_586_6 + var_586_14 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_6) / var_586_14

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_6 + var_586_14 and arg_583_1.time_ < var_586_6 + var_586_14 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1107403141 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1107403141
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1107403142(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = arg_587_1.actors_["1074ui_story"]
			local var_590_1 = 0

			if var_590_1 < arg_587_1.time_ and arg_587_1.time_ <= var_590_1 + arg_590_0 and not isNil(var_590_0) and arg_587_1.var_.characterEffect1074ui_story == nil then
				arg_587_1.var_.characterEffect1074ui_story = var_590_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_590_2 = 0.1

			if var_590_1 <= arg_587_1.time_ and arg_587_1.time_ < var_590_1 + var_590_2 and not isNil(var_590_0) then
				local var_590_3 = (arg_587_1.time_ - var_590_1) / var_590_2

				if arg_587_1.var_.characterEffect1074ui_story and not isNil(var_590_0) then
					local var_590_4 = Mathf.Lerp(0, 0.5, var_590_3)

					arg_587_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_587_1.var_.characterEffect1074ui_story.fillRatio = var_590_4
				end
			end

			if arg_587_1.time_ >= var_590_1 + var_590_2 and arg_587_1.time_ < var_590_1 + var_590_2 + arg_590_0 and not isNil(var_590_0) and arg_587_1.var_.characterEffect1074ui_story then
				local var_590_5 = 0.5

				arg_587_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_587_1.var_.characterEffect1074ui_story.fillRatio = var_590_5
			end

			local var_590_6 = 0
			local var_590_7 = 0.825

			if var_590_6 < arg_587_1.time_ and arg_587_1.time_ <= var_590_6 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				local var_590_8 = arg_587_1:FormatText(StoryNameCfg[7].name)

				arg_587_1.leftNameTxt_.text = var_590_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, true)
				arg_587_1.iconController_:SetSelectedState("hero")

				arg_587_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_587_1.callingController_:SetSelectedState("normal")

				arg_587_1.keyicon_.color = Color.New(1, 1, 1)
				arg_587_1.icon_.color = Color.New(1, 1, 1)

				local var_590_9 = arg_587_1:GetWordFromCfg(1107403141)
				local var_590_10 = arg_587_1:FormatText(var_590_9.content)

				arg_587_1.text_.text = var_590_10

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_11 = 33
				local var_590_12 = utf8.len(var_590_10)
				local var_590_13 = var_590_11 <= 0 and var_590_7 or var_590_7 * (var_590_12 / var_590_11)

				if var_590_13 > 0 and var_590_7 < var_590_13 then
					arg_587_1.talkMaxDuration = var_590_13

					if var_590_13 + var_590_6 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_13 + var_590_6
					end
				end

				arg_587_1.text_.text = var_590_10
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_14 = math.max(var_590_7, arg_587_1.talkMaxDuration)

			if var_590_6 <= arg_587_1.time_ and arg_587_1.time_ < var_590_6 + var_590_14 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_6) / var_590_14

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_6 + var_590_14 and arg_587_1.time_ < var_590_6 + var_590_14 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play1107403142 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1107403142
		arg_591_1.duration_ = 2.73

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1107403143(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = arg_591_1.actors_["1074ui_story"]
			local var_594_1 = 0

			if var_594_1 < arg_591_1.time_ and arg_591_1.time_ <= var_594_1 + arg_594_0 and not isNil(var_594_0) and arg_591_1.var_.characterEffect1074ui_story == nil then
				arg_591_1.var_.characterEffect1074ui_story = var_594_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_594_2 = 0.1

			if var_594_1 <= arg_591_1.time_ and arg_591_1.time_ < var_594_1 + var_594_2 and not isNil(var_594_0) then
				local var_594_3 = (arg_591_1.time_ - var_594_1) / var_594_2

				if arg_591_1.var_.characterEffect1074ui_story and not isNil(var_594_0) then
					arg_591_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_591_1.time_ >= var_594_1 + var_594_2 and arg_591_1.time_ < var_594_1 + var_594_2 + arg_594_0 and not isNil(var_594_0) and arg_591_1.var_.characterEffect1074ui_story then
				arg_591_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_594_4 = 0

			if var_594_4 < arg_591_1.time_ and arg_591_1.time_ <= var_594_4 + arg_594_0 then
				arg_591_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_1")
			end

			local var_594_5 = 0

			if var_594_5 < arg_591_1.time_ and arg_591_1.time_ <= var_594_5 + arg_594_0 then
				arg_591_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_594_6 = 0
			local var_594_7 = 0.35

			if var_594_6 < arg_591_1.time_ and arg_591_1.time_ <= var_594_6 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				local var_594_8 = arg_591_1:FormatText(StoryNameCfg[410].name)

				arg_591_1.leftNameTxt_.text = var_594_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_9 = arg_591_1:GetWordFromCfg(1107403142)
				local var_594_10 = arg_591_1:FormatText(var_594_9.content)

				arg_591_1.text_.text = var_594_10

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_11 = 14
				local var_594_12 = utf8.len(var_594_10)
				local var_594_13 = var_594_11 <= 0 and var_594_7 or var_594_7 * (var_594_12 / var_594_11)

				if var_594_13 > 0 and var_594_7 < var_594_13 then
					arg_591_1.talkMaxDuration = var_594_13

					if var_594_13 + var_594_6 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_13 + var_594_6
					end
				end

				arg_591_1.text_.text = var_594_10
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403142", "story_v_side_new_1107403.awb") ~= 0 then
					local var_594_14 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403142", "story_v_side_new_1107403.awb") / 1000

					if var_594_14 + var_594_6 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_14 + var_594_6
					end

					if var_594_9.prefab_name ~= "" and arg_591_1.actors_[var_594_9.prefab_name] ~= nil then
						local var_594_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_9.prefab_name].transform, "story_v_side_new_1107403", "1107403142", "story_v_side_new_1107403.awb")

						arg_591_1:RecordAudio("1107403142", var_594_15)
						arg_591_1:RecordAudio("1107403142", var_594_15)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403142", "story_v_side_new_1107403.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403142", "story_v_side_new_1107403.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_16 = math.max(var_594_7, arg_591_1.talkMaxDuration)

			if var_594_6 <= arg_591_1.time_ and arg_591_1.time_ < var_594_6 + var_594_16 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_6) / var_594_16

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_6 + var_594_16 and arg_591_1.time_ < var_594_6 + var_594_16 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1107403143 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1107403143
		arg_595_1.duration_ = 12.77

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1107403144(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0
			local var_598_1 = 1.475

			if var_598_0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				local var_598_2 = arg_595_1:FormatText(StoryNameCfg[410].name)

				arg_595_1.leftNameTxt_.text = var_598_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_3 = arg_595_1:GetWordFromCfg(1107403143)
				local var_598_4 = arg_595_1:FormatText(var_598_3.content)

				arg_595_1.text_.text = var_598_4

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_5 = 59
				local var_598_6 = utf8.len(var_598_4)
				local var_598_7 = var_598_5 <= 0 and var_598_1 or var_598_1 * (var_598_6 / var_598_5)

				if var_598_7 > 0 and var_598_1 < var_598_7 then
					arg_595_1.talkMaxDuration = var_598_7

					if var_598_7 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_7 + var_598_0
					end
				end

				arg_595_1.text_.text = var_598_4
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403143", "story_v_side_new_1107403.awb") ~= 0 then
					local var_598_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403143", "story_v_side_new_1107403.awb") / 1000

					if var_598_8 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_8 + var_598_0
					end

					if var_598_3.prefab_name ~= "" and arg_595_1.actors_[var_598_3.prefab_name] ~= nil then
						local var_598_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_3.prefab_name].transform, "story_v_side_new_1107403", "1107403143", "story_v_side_new_1107403.awb")

						arg_595_1:RecordAudio("1107403143", var_598_9)
						arg_595_1:RecordAudio("1107403143", var_598_9)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403143", "story_v_side_new_1107403.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403143", "story_v_side_new_1107403.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_10 = math.max(var_598_1, arg_595_1.talkMaxDuration)

			if var_598_0 <= arg_595_1.time_ and arg_595_1.time_ < var_598_0 + var_598_10 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_0) / var_598_10

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_0 + var_598_10 and arg_595_1.time_ < var_598_0 + var_598_10 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1107403144 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1107403144
		arg_599_1.duration_ = 8.37

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1107403145(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0
			local var_602_1 = 0.85

			if var_602_0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_2 = arg_599_1:FormatText(StoryNameCfg[410].name)

				arg_599_1.leftNameTxt_.text = var_602_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_3 = arg_599_1:GetWordFromCfg(1107403144)
				local var_602_4 = arg_599_1:FormatText(var_602_3.content)

				arg_599_1.text_.text = var_602_4

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_5 = 34
				local var_602_6 = utf8.len(var_602_4)
				local var_602_7 = var_602_5 <= 0 and var_602_1 or var_602_1 * (var_602_6 / var_602_5)

				if var_602_7 > 0 and var_602_1 < var_602_7 then
					arg_599_1.talkMaxDuration = var_602_7

					if var_602_7 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_7 + var_602_0
					end
				end

				arg_599_1.text_.text = var_602_4
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403144", "story_v_side_new_1107403.awb") ~= 0 then
					local var_602_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403144", "story_v_side_new_1107403.awb") / 1000

					if var_602_8 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_8 + var_602_0
					end

					if var_602_3.prefab_name ~= "" and arg_599_1.actors_[var_602_3.prefab_name] ~= nil then
						local var_602_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_3.prefab_name].transform, "story_v_side_new_1107403", "1107403144", "story_v_side_new_1107403.awb")

						arg_599_1:RecordAudio("1107403144", var_602_9)
						arg_599_1:RecordAudio("1107403144", var_602_9)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403144", "story_v_side_new_1107403.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403144", "story_v_side_new_1107403.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_10 = math.max(var_602_1, arg_599_1.talkMaxDuration)

			if var_602_0 <= arg_599_1.time_ and arg_599_1.time_ < var_602_0 + var_602_10 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_0) / var_602_10

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_0 + var_602_10 and arg_599_1.time_ < var_602_0 + var_602_10 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1107403145 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1107403145
		arg_603_1.duration_ = 1

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"

			SetActive(arg_603_1.choicesGo_, true)

			for iter_604_0, iter_604_1 in ipairs(arg_603_1.choices_) do
				local var_604_0 = iter_604_0 <= 2

				SetActive(iter_604_1.go, var_604_0)
			end

			arg_603_1.choices_[1].txt.text = arg_603_1:FormatText(StoryChoiceCfg[1022].name)
			arg_603_1.choices_[2].txt.text = arg_603_1:FormatText(StoryChoiceCfg[1023].name)
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1107403146(arg_603_1)
			end

			if arg_605_0 == 2 then
				arg_603_0:Play1107403148(arg_603_1)
			end

			arg_603_1:RecordChoiceLog(1107403145, 1022, 1023)
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = arg_603_1.actors_["1074ui_story"]
			local var_606_1 = 0

			if var_606_1 < arg_603_1.time_ and arg_603_1.time_ <= var_606_1 + arg_606_0 and not isNil(var_606_0) and arg_603_1.var_.characterEffect1074ui_story == nil then
				arg_603_1.var_.characterEffect1074ui_story = var_606_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_2 = 0.1

			if var_606_1 <= arg_603_1.time_ and arg_603_1.time_ < var_606_1 + var_606_2 and not isNil(var_606_0) then
				local var_606_3 = (arg_603_1.time_ - var_606_1) / var_606_2

				if arg_603_1.var_.characterEffect1074ui_story and not isNil(var_606_0) then
					local var_606_4 = Mathf.Lerp(0, 0.5, var_606_3)

					arg_603_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_603_1.var_.characterEffect1074ui_story.fillRatio = var_606_4
				end
			end

			if arg_603_1.time_ >= var_606_1 + var_606_2 and arg_603_1.time_ < var_606_1 + var_606_2 + arg_606_0 and not isNil(var_606_0) and arg_603_1.var_.characterEffect1074ui_story then
				local var_606_5 = 0.5

				arg_603_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_603_1.var_.characterEffect1074ui_story.fillRatio = var_606_5
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1107403146 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1107403146
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1107403147(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0
			local var_610_1 = 1.025

			if var_610_0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				local var_610_2 = arg_607_1:FormatText(StoryNameCfg[7].name)

				arg_607_1.leftNameTxt_.text = var_610_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_607_1.callingController_:SetSelectedState("normal")

				arg_607_1.keyicon_.color = Color.New(1, 1, 1)
				arg_607_1.icon_.color = Color.New(1, 1, 1)

				local var_610_3 = arg_607_1:GetWordFromCfg(1107403146)
				local var_610_4 = arg_607_1:FormatText(var_610_3.content)

				arg_607_1.text_.text = var_610_4

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_5 = 41
				local var_610_6 = utf8.len(var_610_4)
				local var_610_7 = var_610_5 <= 0 and var_610_1 or var_610_1 * (var_610_6 / var_610_5)

				if var_610_7 > 0 and var_610_1 < var_610_7 then
					arg_607_1.talkMaxDuration = var_610_7

					if var_610_7 + var_610_0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_7 + var_610_0
					end
				end

				arg_607_1.text_.text = var_610_4
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_8 = math.max(var_610_1, arg_607_1.talkMaxDuration)

			if var_610_0 <= arg_607_1.time_ and arg_607_1.time_ < var_610_0 + var_610_8 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_0) / var_610_8

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_0 + var_610_8 and arg_607_1.time_ < var_610_0 + var_610_8 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1107403147 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1107403147
		arg_611_1.duration_ = 12.87

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1107403150(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = arg_611_1.actors_["1074ui_story"]
			local var_614_1 = 0

			if var_614_1 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1074ui_story == nil then
				arg_611_1.var_.characterEffect1074ui_story = var_614_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_2 = 0.1

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_2 and not isNil(var_614_0) then
				local var_614_3 = (arg_611_1.time_ - var_614_1) / var_614_2

				if arg_611_1.var_.characterEffect1074ui_story and not isNil(var_614_0) then
					arg_611_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_611_1.time_ >= var_614_1 + var_614_2 and arg_611_1.time_ < var_614_1 + var_614_2 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1074ui_story then
				arg_611_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_614_4 = 0
			local var_614_5 = 1.075

			if var_614_4 < arg_611_1.time_ and arg_611_1.time_ <= var_614_4 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_6 = arg_611_1:FormatText(StoryNameCfg[410].name)

				arg_611_1.leftNameTxt_.text = var_614_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_7 = arg_611_1:GetWordFromCfg(1107403147)
				local var_614_8 = arg_611_1:FormatText(var_614_7.content)

				arg_611_1.text_.text = var_614_8

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_9 = 43
				local var_614_10 = utf8.len(var_614_8)
				local var_614_11 = var_614_9 <= 0 and var_614_5 or var_614_5 * (var_614_10 / var_614_9)

				if var_614_11 > 0 and var_614_5 < var_614_11 then
					arg_611_1.talkMaxDuration = var_614_11

					if var_614_11 + var_614_4 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_11 + var_614_4
					end
				end

				arg_611_1.text_.text = var_614_8
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403147", "story_v_side_new_1107403.awb") ~= 0 then
					local var_614_12 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403147", "story_v_side_new_1107403.awb") / 1000

					if var_614_12 + var_614_4 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_12 + var_614_4
					end

					if var_614_7.prefab_name ~= "" and arg_611_1.actors_[var_614_7.prefab_name] ~= nil then
						local var_614_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_7.prefab_name].transform, "story_v_side_new_1107403", "1107403147", "story_v_side_new_1107403.awb")

						arg_611_1:RecordAudio("1107403147", var_614_13)
						arg_611_1:RecordAudio("1107403147", var_614_13)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403147", "story_v_side_new_1107403.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403147", "story_v_side_new_1107403.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_14 = math.max(var_614_5, arg_611_1.talkMaxDuration)

			if var_614_4 <= arg_611_1.time_ and arg_611_1.time_ < var_614_4 + var_614_14 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_4) / var_614_14

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_4 + var_614_14 and arg_611_1.time_ < var_614_4 + var_614_14 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play1107403150 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1107403150
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1107403151(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = arg_615_1.actors_["1074ui_story"]
			local var_618_1 = 0

			if var_618_1 < arg_615_1.time_ and arg_615_1.time_ <= var_618_1 + arg_618_0 and not isNil(var_618_0) and arg_615_1.var_.characterEffect1074ui_story == nil then
				arg_615_1.var_.characterEffect1074ui_story = var_618_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_2 = 0.1

			if var_618_1 <= arg_615_1.time_ and arg_615_1.time_ < var_618_1 + var_618_2 and not isNil(var_618_0) then
				local var_618_3 = (arg_615_1.time_ - var_618_1) / var_618_2

				if arg_615_1.var_.characterEffect1074ui_story and not isNil(var_618_0) then
					local var_618_4 = Mathf.Lerp(0, 0.5, var_618_3)

					arg_615_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_615_1.var_.characterEffect1074ui_story.fillRatio = var_618_4
				end
			end

			if arg_615_1.time_ >= var_618_1 + var_618_2 and arg_615_1.time_ < var_618_1 + var_618_2 + arg_618_0 and not isNil(var_618_0) and arg_615_1.var_.characterEffect1074ui_story then
				local var_618_5 = 0.5

				arg_615_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_615_1.var_.characterEffect1074ui_story.fillRatio = var_618_5
			end

			local var_618_6 = 0
			local var_618_7 = 1

			if var_618_6 < arg_615_1.time_ and arg_615_1.time_ <= var_618_6 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, false)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_8 = arg_615_1:GetWordFromCfg(1107403150)
				local var_618_9 = arg_615_1:FormatText(var_618_8.content)

				arg_615_1.text_.text = var_618_9

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_10 = 40
				local var_618_11 = utf8.len(var_618_9)
				local var_618_12 = var_618_10 <= 0 and var_618_7 or var_618_7 * (var_618_11 / var_618_10)

				if var_618_12 > 0 and var_618_7 < var_618_12 then
					arg_615_1.talkMaxDuration = var_618_12

					if var_618_12 + var_618_6 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_12 + var_618_6
					end
				end

				arg_615_1.text_.text = var_618_9
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_13 = math.max(var_618_7, arg_615_1.talkMaxDuration)

			if var_618_6 <= arg_615_1.time_ and arg_615_1.time_ < var_618_6 + var_618_13 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_6) / var_618_13

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_6 + var_618_13 and arg_615_1.time_ < var_618_6 + var_618_13 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play1107403151 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1107403151
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1107403152(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = 0
			local var_622_1 = 0.725

			if var_622_0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_0 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				local var_622_2 = arg_619_1:FormatText(StoryNameCfg[7].name)

				arg_619_1.leftNameTxt_.text = var_622_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, true)
				arg_619_1.iconController_:SetSelectedState("hero")

				arg_619_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_619_1.callingController_:SetSelectedState("normal")

				arg_619_1.keyicon_.color = Color.New(1, 1, 1)
				arg_619_1.icon_.color = Color.New(1, 1, 1)

				local var_622_3 = arg_619_1:GetWordFromCfg(1107403151)
				local var_622_4 = arg_619_1:FormatText(var_622_3.content)

				arg_619_1.text_.text = var_622_4

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_5 = 29
				local var_622_6 = utf8.len(var_622_4)
				local var_622_7 = var_622_5 <= 0 and var_622_1 or var_622_1 * (var_622_6 / var_622_5)

				if var_622_7 > 0 and var_622_1 < var_622_7 then
					arg_619_1.talkMaxDuration = var_622_7

					if var_622_7 + var_622_0 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_7 + var_622_0
					end
				end

				arg_619_1.text_.text = var_622_4
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_8 = math.max(var_622_1, arg_619_1.talkMaxDuration)

			if var_622_0 <= arg_619_1.time_ and arg_619_1.time_ < var_622_0 + var_622_8 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_0) / var_622_8

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_0 + var_622_8 and arg_619_1.time_ < var_622_0 + var_622_8 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play1107403152 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1107403152
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1107403153(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = 0
			local var_626_1 = 1.05

			if var_626_0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_0 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				local var_626_2 = arg_623_1:FormatText(StoryNameCfg[7].name)

				arg_623_1.leftNameTxt_.text = var_626_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, true)
				arg_623_1.iconController_:SetSelectedState("hero")

				arg_623_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_623_1.callingController_:SetSelectedState("normal")

				arg_623_1.keyicon_.color = Color.New(1, 1, 1)
				arg_623_1.icon_.color = Color.New(1, 1, 1)

				local var_626_3 = arg_623_1:GetWordFromCfg(1107403152)
				local var_626_4 = arg_623_1:FormatText(var_626_3.content)

				arg_623_1.text_.text = var_626_4

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_5 = 42
				local var_626_6 = utf8.len(var_626_4)
				local var_626_7 = var_626_5 <= 0 and var_626_1 or var_626_1 * (var_626_6 / var_626_5)

				if var_626_7 > 0 and var_626_1 < var_626_7 then
					arg_623_1.talkMaxDuration = var_626_7

					if var_626_7 + var_626_0 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_7 + var_626_0
					end
				end

				arg_623_1.text_.text = var_626_4
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_8 = math.max(var_626_1, arg_623_1.talkMaxDuration)

			if var_626_0 <= arg_623_1.time_ and arg_623_1.time_ < var_626_0 + var_626_8 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_0) / var_626_8

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_0 + var_626_8 and arg_623_1.time_ < var_626_0 + var_626_8 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1107403153 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1107403153
		arg_627_1.duration_ = 5

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1107403154(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = 0
			local var_630_1 = 0.7

			if var_630_0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_0 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				local var_630_2 = arg_627_1:FormatText(StoryNameCfg[7].name)

				arg_627_1.leftNameTxt_.text = var_630_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_3 = arg_627_1:GetWordFromCfg(1107403153)
				local var_630_4 = arg_627_1:FormatText(var_630_3.content)

				arg_627_1.text_.text = var_630_4

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_5 = 28
				local var_630_6 = utf8.len(var_630_4)
				local var_630_7 = var_630_5 <= 0 and var_630_1 or var_630_1 * (var_630_6 / var_630_5)

				if var_630_7 > 0 and var_630_1 < var_630_7 then
					arg_627_1.talkMaxDuration = var_630_7

					if var_630_7 + var_630_0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_7 + var_630_0
					end
				end

				arg_627_1.text_.text = var_630_4
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)
				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_8 = math.max(var_630_1, arg_627_1.talkMaxDuration)

			if var_630_0 <= arg_627_1.time_ and arg_627_1.time_ < var_630_0 + var_630_8 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_0) / var_630_8

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_0 + var_630_8 and arg_627_1.time_ < var_630_0 + var_630_8 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play1107403154 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1107403154
		arg_631_1.duration_ = 1.37

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1107403155(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = arg_631_1.actors_["1074ui_story"]
			local var_634_1 = 0

			if var_634_1 < arg_631_1.time_ and arg_631_1.time_ <= var_634_1 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect1074ui_story == nil then
				arg_631_1.var_.characterEffect1074ui_story = var_634_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_2 = 0.1

			if var_634_1 <= arg_631_1.time_ and arg_631_1.time_ < var_634_1 + var_634_2 and not isNil(var_634_0) then
				local var_634_3 = (arg_631_1.time_ - var_634_1) / var_634_2

				if arg_631_1.var_.characterEffect1074ui_story and not isNil(var_634_0) then
					arg_631_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_631_1.time_ >= var_634_1 + var_634_2 and arg_631_1.time_ < var_634_1 + var_634_2 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect1074ui_story then
				arg_631_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_634_4 = 0
			local var_634_5 = 0.15

			if var_634_4 < arg_631_1.time_ and arg_631_1.time_ <= var_634_4 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				local var_634_6 = arg_631_1:FormatText(StoryNameCfg[410].name)

				arg_631_1.leftNameTxt_.text = var_634_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_7 = arg_631_1:GetWordFromCfg(1107403154)
				local var_634_8 = arg_631_1:FormatText(var_634_7.content)

				arg_631_1.text_.text = var_634_8

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_9 = 6
				local var_634_10 = utf8.len(var_634_8)
				local var_634_11 = var_634_9 <= 0 and var_634_5 or var_634_5 * (var_634_10 / var_634_9)

				if var_634_11 > 0 and var_634_5 < var_634_11 then
					arg_631_1.talkMaxDuration = var_634_11

					if var_634_11 + var_634_4 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_11 + var_634_4
					end
				end

				arg_631_1.text_.text = var_634_8
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403154", "story_v_side_new_1107403.awb") ~= 0 then
					local var_634_12 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403154", "story_v_side_new_1107403.awb") / 1000

					if var_634_12 + var_634_4 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_12 + var_634_4
					end

					if var_634_7.prefab_name ~= "" and arg_631_1.actors_[var_634_7.prefab_name] ~= nil then
						local var_634_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_7.prefab_name].transform, "story_v_side_new_1107403", "1107403154", "story_v_side_new_1107403.awb")

						arg_631_1:RecordAudio("1107403154", var_634_13)
						arg_631_1:RecordAudio("1107403154", var_634_13)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403154", "story_v_side_new_1107403.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403154", "story_v_side_new_1107403.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_14 = math.max(var_634_5, arg_631_1.talkMaxDuration)

			if var_634_4 <= arg_631_1.time_ and arg_631_1.time_ < var_634_4 + var_634_14 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_4) / var_634_14

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_4 + var_634_14 and arg_631_1.time_ < var_634_4 + var_634_14 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play1107403155 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1107403155
		arg_635_1.duration_ = 9.53

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1107403156(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = 0
			local var_638_1 = 1.05

			if var_638_0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_0 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				local var_638_2 = arg_635_1:FormatText(StoryNameCfg[410].name)

				arg_635_1.leftNameTxt_.text = var_638_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_3 = arg_635_1:GetWordFromCfg(1107403155)
				local var_638_4 = arg_635_1:FormatText(var_638_3.content)

				arg_635_1.text_.text = var_638_4

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_5 = 42
				local var_638_6 = utf8.len(var_638_4)
				local var_638_7 = var_638_5 <= 0 and var_638_1 or var_638_1 * (var_638_6 / var_638_5)

				if var_638_7 > 0 and var_638_1 < var_638_7 then
					arg_635_1.talkMaxDuration = var_638_7

					if var_638_7 + var_638_0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_7 + var_638_0
					end
				end

				arg_635_1.text_.text = var_638_4
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403155", "story_v_side_new_1107403.awb") ~= 0 then
					local var_638_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403155", "story_v_side_new_1107403.awb") / 1000

					if var_638_8 + var_638_0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_8 + var_638_0
					end

					if var_638_3.prefab_name ~= "" and arg_635_1.actors_[var_638_3.prefab_name] ~= nil then
						local var_638_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_3.prefab_name].transform, "story_v_side_new_1107403", "1107403155", "story_v_side_new_1107403.awb")

						arg_635_1:RecordAudio("1107403155", var_638_9)
						arg_635_1:RecordAudio("1107403155", var_638_9)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403155", "story_v_side_new_1107403.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403155", "story_v_side_new_1107403.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_10 = math.max(var_638_1, arg_635_1.talkMaxDuration)

			if var_638_0 <= arg_635_1.time_ and arg_635_1.time_ < var_638_0 + var_638_10 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_0) / var_638_10

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_0 + var_638_10 and arg_635_1.time_ < var_638_0 + var_638_10 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play1107403156 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1107403156
		arg_639_1.duration_ = 8.63

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1107403157(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = 0
			local var_642_1 = 0.825

			if var_642_0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_0 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				local var_642_2 = arg_639_1:FormatText(StoryNameCfg[410].name)

				arg_639_1.leftNameTxt_.text = var_642_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_3 = arg_639_1:GetWordFromCfg(1107403156)
				local var_642_4 = arg_639_1:FormatText(var_642_3.content)

				arg_639_1.text_.text = var_642_4

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_5 = 33
				local var_642_6 = utf8.len(var_642_4)
				local var_642_7 = var_642_5 <= 0 and var_642_1 or var_642_1 * (var_642_6 / var_642_5)

				if var_642_7 > 0 and var_642_1 < var_642_7 then
					arg_639_1.talkMaxDuration = var_642_7

					if var_642_7 + var_642_0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_7 + var_642_0
					end
				end

				arg_639_1.text_.text = var_642_4
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403156", "story_v_side_new_1107403.awb") ~= 0 then
					local var_642_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403156", "story_v_side_new_1107403.awb") / 1000

					if var_642_8 + var_642_0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_8 + var_642_0
					end

					if var_642_3.prefab_name ~= "" and arg_639_1.actors_[var_642_3.prefab_name] ~= nil then
						local var_642_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_3.prefab_name].transform, "story_v_side_new_1107403", "1107403156", "story_v_side_new_1107403.awb")

						arg_639_1:RecordAudio("1107403156", var_642_9)
						arg_639_1:RecordAudio("1107403156", var_642_9)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403156", "story_v_side_new_1107403.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403156", "story_v_side_new_1107403.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_10 = math.max(var_642_1, arg_639_1.talkMaxDuration)

			if var_642_0 <= arg_639_1.time_ and arg_639_1.time_ < var_642_0 + var_642_10 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_0) / var_642_10

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_0 + var_642_10 and arg_639_1.time_ < var_642_0 + var_642_10 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play1107403157 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1107403157
		arg_643_1.duration_ = 5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1107403158(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = arg_643_1.actors_["1074ui_story"]
			local var_646_1 = 0

			if var_646_1 < arg_643_1.time_ and arg_643_1.time_ <= var_646_1 + arg_646_0 and not isNil(var_646_0) and arg_643_1.var_.characterEffect1074ui_story == nil then
				arg_643_1.var_.characterEffect1074ui_story = var_646_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_2 = 0.1

			if var_646_1 <= arg_643_1.time_ and arg_643_1.time_ < var_646_1 + var_646_2 and not isNil(var_646_0) then
				local var_646_3 = (arg_643_1.time_ - var_646_1) / var_646_2

				if arg_643_1.var_.characterEffect1074ui_story and not isNil(var_646_0) then
					local var_646_4 = Mathf.Lerp(0, 0.5, var_646_3)

					arg_643_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_643_1.var_.characterEffect1074ui_story.fillRatio = var_646_4
				end
			end

			if arg_643_1.time_ >= var_646_1 + var_646_2 and arg_643_1.time_ < var_646_1 + var_646_2 + arg_646_0 and not isNil(var_646_0) and arg_643_1.var_.characterEffect1074ui_story then
				local var_646_5 = 0.5

				arg_643_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_643_1.var_.characterEffect1074ui_story.fillRatio = var_646_5
			end

			local var_646_6 = 0
			local var_646_7 = 0.3

			if var_646_6 < arg_643_1.time_ and arg_643_1.time_ <= var_646_6 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				local var_646_8 = arg_643_1:FormatText(StoryNameCfg[7].name)

				arg_643_1.leftNameTxt_.text = var_646_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, true)
				arg_643_1.iconController_:SetSelectedState("hero")

				arg_643_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_643_1.callingController_:SetSelectedState("normal")

				arg_643_1.keyicon_.color = Color.New(1, 1, 1)
				arg_643_1.icon_.color = Color.New(1, 1, 1)

				local var_646_9 = arg_643_1:GetWordFromCfg(1107403157)
				local var_646_10 = arg_643_1:FormatText(var_646_9.content)

				arg_643_1.text_.text = var_646_10

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_11 = 12
				local var_646_12 = utf8.len(var_646_10)
				local var_646_13 = var_646_11 <= 0 and var_646_7 or var_646_7 * (var_646_12 / var_646_11)

				if var_646_13 > 0 and var_646_7 < var_646_13 then
					arg_643_1.talkMaxDuration = var_646_13

					if var_646_13 + var_646_6 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_13 + var_646_6
					end
				end

				arg_643_1.text_.text = var_646_10
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_14 = math.max(var_646_7, arg_643_1.talkMaxDuration)

			if var_646_6 <= arg_643_1.time_ and arg_643_1.time_ < var_646_6 + var_646_14 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_6) / var_646_14

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_6 + var_646_14 and arg_643_1.time_ < var_646_6 + var_646_14 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play1107403158 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 1107403158
		arg_647_1.duration_ = 2

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play1107403159(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = arg_647_1.actors_["1074ui_story"]
			local var_650_1 = 0

			if var_650_1 < arg_647_1.time_ and arg_647_1.time_ <= var_650_1 + arg_650_0 and not isNil(var_650_0) and arg_647_1.var_.characterEffect1074ui_story == nil then
				arg_647_1.var_.characterEffect1074ui_story = var_650_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_650_2 = 0.1

			if var_650_1 <= arg_647_1.time_ and arg_647_1.time_ < var_650_1 + var_650_2 and not isNil(var_650_0) then
				local var_650_3 = (arg_647_1.time_ - var_650_1) / var_650_2

				if arg_647_1.var_.characterEffect1074ui_story and not isNil(var_650_0) then
					arg_647_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_647_1.time_ >= var_650_1 + var_650_2 and arg_647_1.time_ < var_650_1 + var_650_2 + arg_650_0 and not isNil(var_650_0) and arg_647_1.var_.characterEffect1074ui_story then
				arg_647_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_650_4 = 0

			if var_650_4 < arg_647_1.time_ and arg_647_1.time_ <= var_650_4 + arg_650_0 then
				arg_647_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action4_1")
			end

			local var_650_5 = 0
			local var_650_6 = 0.225

			if var_650_5 < arg_647_1.time_ and arg_647_1.time_ <= var_650_5 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				local var_650_7 = arg_647_1:FormatText(StoryNameCfg[410].name)

				arg_647_1.leftNameTxt_.text = var_650_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_8 = arg_647_1:GetWordFromCfg(1107403158)
				local var_650_9 = arg_647_1:FormatText(var_650_8.content)

				arg_647_1.text_.text = var_650_9

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_10 = 6
				local var_650_11 = utf8.len(var_650_9)
				local var_650_12 = var_650_10 <= 0 and var_650_6 or var_650_6 * (var_650_11 / var_650_10)

				if var_650_12 > 0 and var_650_6 < var_650_12 then
					arg_647_1.talkMaxDuration = var_650_12

					if var_650_12 + var_650_5 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_12 + var_650_5
					end
				end

				arg_647_1.text_.text = var_650_9
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403158", "story_v_side_new_1107403.awb") ~= 0 then
					local var_650_13 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403158", "story_v_side_new_1107403.awb") / 1000

					if var_650_13 + var_650_5 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_13 + var_650_5
					end

					if var_650_8.prefab_name ~= "" and arg_647_1.actors_[var_650_8.prefab_name] ~= nil then
						local var_650_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_8.prefab_name].transform, "story_v_side_new_1107403", "1107403158", "story_v_side_new_1107403.awb")

						arg_647_1:RecordAudio("1107403158", var_650_14)
						arg_647_1:RecordAudio("1107403158", var_650_14)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403158", "story_v_side_new_1107403.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403158", "story_v_side_new_1107403.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_15 = math.max(var_650_6, arg_647_1.talkMaxDuration)

			if var_650_5 <= arg_647_1.time_ and arg_647_1.time_ < var_650_5 + var_650_15 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_5) / var_650_15

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_5 + var_650_15 and arg_647_1.time_ < var_650_5 + var_650_15 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play1107403159 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 1107403159
		arg_651_1.duration_ = 4.1

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play1107403160(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = 0
			local var_654_1 = 0.35

			if var_654_0 < arg_651_1.time_ and arg_651_1.time_ <= var_654_0 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				local var_654_2 = arg_651_1:FormatText(StoryNameCfg[410].name)

				arg_651_1.leftNameTxt_.text = var_654_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_3 = arg_651_1:GetWordFromCfg(1107403159)
				local var_654_4 = arg_651_1:FormatText(var_654_3.content)

				arg_651_1.text_.text = var_654_4

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_5 = 14
				local var_654_6 = utf8.len(var_654_4)
				local var_654_7 = var_654_5 <= 0 and var_654_1 or var_654_1 * (var_654_6 / var_654_5)

				if var_654_7 > 0 and var_654_1 < var_654_7 then
					arg_651_1.talkMaxDuration = var_654_7

					if var_654_7 + var_654_0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_7 + var_654_0
					end
				end

				arg_651_1.text_.text = var_654_4
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403159", "story_v_side_new_1107403.awb") ~= 0 then
					local var_654_8 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403159", "story_v_side_new_1107403.awb") / 1000

					if var_654_8 + var_654_0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_8 + var_654_0
					end

					if var_654_3.prefab_name ~= "" and arg_651_1.actors_[var_654_3.prefab_name] ~= nil then
						local var_654_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_651_1.actors_[var_654_3.prefab_name].transform, "story_v_side_new_1107403", "1107403159", "story_v_side_new_1107403.awb")

						arg_651_1:RecordAudio("1107403159", var_654_9)
						arg_651_1:RecordAudio("1107403159", var_654_9)
					else
						arg_651_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403159", "story_v_side_new_1107403.awb")
					end

					arg_651_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403159", "story_v_side_new_1107403.awb")
				end

				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_10 = math.max(var_654_1, arg_651_1.talkMaxDuration)

			if var_654_0 <= arg_651_1.time_ and arg_651_1.time_ < var_654_0 + var_654_10 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_0) / var_654_10

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_0 + var_654_10 and arg_651_1.time_ < var_654_0 + var_654_10 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play1107403160 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 1107403160
		arg_655_1.duration_ = 5

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play1107403161(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			local var_658_0 = arg_655_1.actors_["1074ui_story"]
			local var_658_1 = 0

			if var_658_1 < arg_655_1.time_ and arg_655_1.time_ <= var_658_1 + arg_658_0 and not isNil(var_658_0) and arg_655_1.var_.characterEffect1074ui_story == nil then
				arg_655_1.var_.characterEffect1074ui_story = var_658_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_658_2 = 0.1

			if var_658_1 <= arg_655_1.time_ and arg_655_1.time_ < var_658_1 + var_658_2 and not isNil(var_658_0) then
				local var_658_3 = (arg_655_1.time_ - var_658_1) / var_658_2

				if arg_655_1.var_.characterEffect1074ui_story and not isNil(var_658_0) then
					local var_658_4 = Mathf.Lerp(0, 0.5, var_658_3)

					arg_655_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_655_1.var_.characterEffect1074ui_story.fillRatio = var_658_4
				end
			end

			if arg_655_1.time_ >= var_658_1 + var_658_2 and arg_655_1.time_ < var_658_1 + var_658_2 + arg_658_0 and not isNil(var_658_0) and arg_655_1.var_.characterEffect1074ui_story then
				local var_658_5 = 0.5

				arg_655_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_655_1.var_.characterEffect1074ui_story.fillRatio = var_658_5
			end

			local var_658_6 = 0
			local var_658_7 = 1.325

			if var_658_6 < arg_655_1.time_ and arg_655_1.time_ <= var_658_6 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, false)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_655_1.iconTrs_.gameObject, false)
				arg_655_1.callingController_:SetSelectedState("normal")

				local var_658_8 = arg_655_1:GetWordFromCfg(1107403160)
				local var_658_9 = arg_655_1:FormatText(var_658_8.content)

				arg_655_1.text_.text = var_658_9

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_10 = 53
				local var_658_11 = utf8.len(var_658_9)
				local var_658_12 = var_658_10 <= 0 and var_658_7 or var_658_7 * (var_658_11 / var_658_10)

				if var_658_12 > 0 and var_658_7 < var_658_12 then
					arg_655_1.talkMaxDuration = var_658_12

					if var_658_12 + var_658_6 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_12 + var_658_6
					end
				end

				arg_655_1.text_.text = var_658_9
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)
				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_13 = math.max(var_658_7, arg_655_1.talkMaxDuration)

			if var_658_6 <= arg_655_1.time_ and arg_655_1.time_ < var_658_6 + var_658_13 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_6) / var_658_13

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_6 + var_658_13 and arg_655_1.time_ < var_658_6 + var_658_13 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play1107403161 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 1107403161
		arg_659_1.duration_ = 5

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play1107403162(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = 0
			local var_662_1 = 0.1

			if var_662_0 < arg_659_1.time_ and arg_659_1.time_ <= var_662_0 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				local var_662_2 = arg_659_1:FormatText(StoryNameCfg[7].name)

				arg_659_1.leftNameTxt_.text = var_662_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, true)
				arg_659_1.iconController_:SetSelectedState("hero")

				arg_659_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_659_1.callingController_:SetSelectedState("normal")

				arg_659_1.keyicon_.color = Color.New(1, 1, 1)
				arg_659_1.icon_.color = Color.New(1, 1, 1)

				local var_662_3 = arg_659_1:GetWordFromCfg(1107403161)
				local var_662_4 = arg_659_1:FormatText(var_662_3.content)

				arg_659_1.text_.text = var_662_4

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_5 = 4
				local var_662_6 = utf8.len(var_662_4)
				local var_662_7 = var_662_5 <= 0 and var_662_1 or var_662_1 * (var_662_6 / var_662_5)

				if var_662_7 > 0 and var_662_1 < var_662_7 then
					arg_659_1.talkMaxDuration = var_662_7

					if var_662_7 + var_662_0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_7 + var_662_0
					end
				end

				arg_659_1.text_.text = var_662_4
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)
				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_8 = math.max(var_662_1, arg_659_1.talkMaxDuration)

			if var_662_0 <= arg_659_1.time_ and arg_659_1.time_ < var_662_0 + var_662_8 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_0) / var_662_8

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_0 + var_662_8 and arg_659_1.time_ < var_662_0 + var_662_8 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play1107403162 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 1107403162
		arg_663_1.duration_ = 5

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play1107403163(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = 0
			local var_666_1 = 0.975

			if var_666_0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_0 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				local var_666_2 = arg_663_1:FormatText(StoryNameCfg[7].name)

				arg_663_1.leftNameTxt_.text = var_666_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, true)
				arg_663_1.iconController_:SetSelectedState("hero")

				arg_663_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_663_1.callingController_:SetSelectedState("normal")

				arg_663_1.keyicon_.color = Color.New(1, 1, 1)
				arg_663_1.icon_.color = Color.New(1, 1, 1)

				local var_666_3 = arg_663_1:GetWordFromCfg(1107403162)
				local var_666_4 = arg_663_1:FormatText(var_666_3.content)

				arg_663_1.text_.text = var_666_4

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_5 = 39
				local var_666_6 = utf8.len(var_666_4)
				local var_666_7 = var_666_5 <= 0 and var_666_1 or var_666_1 * (var_666_6 / var_666_5)

				if var_666_7 > 0 and var_666_1 < var_666_7 then
					arg_663_1.talkMaxDuration = var_666_7

					if var_666_7 + var_666_0 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_7 + var_666_0
					end
				end

				arg_663_1.text_.text = var_666_4
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_8 = math.max(var_666_1, arg_663_1.talkMaxDuration)

			if var_666_0 <= arg_663_1.time_ and arg_663_1.time_ < var_666_0 + var_666_8 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_0) / var_666_8

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_0 + var_666_8 and arg_663_1.time_ < var_666_0 + var_666_8 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play1107403163 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 1107403163
		arg_667_1.duration_ = 5.37

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play1107403164(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = arg_667_1.actors_["1074ui_story"]
			local var_670_1 = 0

			if var_670_1 < arg_667_1.time_ and arg_667_1.time_ <= var_670_1 + arg_670_0 and not isNil(var_670_0) and arg_667_1.var_.characterEffect1074ui_story == nil then
				arg_667_1.var_.characterEffect1074ui_story = var_670_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_670_2 = 0.1

			if var_670_1 <= arg_667_1.time_ and arg_667_1.time_ < var_670_1 + var_670_2 and not isNil(var_670_0) then
				local var_670_3 = (arg_667_1.time_ - var_670_1) / var_670_2

				if arg_667_1.var_.characterEffect1074ui_story and not isNil(var_670_0) then
					arg_667_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_667_1.time_ >= var_670_1 + var_670_2 and arg_667_1.time_ < var_670_1 + var_670_2 + arg_670_0 and not isNil(var_670_0) and arg_667_1.var_.characterEffect1074ui_story then
				arg_667_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_670_4 = 0

			if var_670_4 < arg_667_1.time_ and arg_667_1.time_ <= var_670_4 + arg_670_0 then
				arg_667_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action4_2")
			end

			local var_670_5 = 0
			local var_670_6 = 0.375

			if var_670_5 < arg_667_1.time_ and arg_667_1.time_ <= var_670_5 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				local var_670_7 = arg_667_1:FormatText(StoryNameCfg[410].name)

				arg_667_1.leftNameTxt_.text = var_670_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_8 = arg_667_1:GetWordFromCfg(1107403163)
				local var_670_9 = arg_667_1:FormatText(var_670_8.content)

				arg_667_1.text_.text = var_670_9

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_10 = 15
				local var_670_11 = utf8.len(var_670_9)
				local var_670_12 = var_670_10 <= 0 and var_670_6 or var_670_6 * (var_670_11 / var_670_10)

				if var_670_12 > 0 and var_670_6 < var_670_12 then
					arg_667_1.talkMaxDuration = var_670_12

					if var_670_12 + var_670_5 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_12 + var_670_5
					end
				end

				arg_667_1.text_.text = var_670_9
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403163", "story_v_side_new_1107403.awb") ~= 0 then
					local var_670_13 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403163", "story_v_side_new_1107403.awb") / 1000

					if var_670_13 + var_670_5 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_13 + var_670_5
					end

					if var_670_8.prefab_name ~= "" and arg_667_1.actors_[var_670_8.prefab_name] ~= nil then
						local var_670_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_667_1.actors_[var_670_8.prefab_name].transform, "story_v_side_new_1107403", "1107403163", "story_v_side_new_1107403.awb")

						arg_667_1:RecordAudio("1107403163", var_670_14)
						arg_667_1:RecordAudio("1107403163", var_670_14)
					else
						arg_667_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403163", "story_v_side_new_1107403.awb")
					end

					arg_667_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403163", "story_v_side_new_1107403.awb")
				end

				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_15 = math.max(var_670_6, arg_667_1.talkMaxDuration)

			if var_670_5 <= arg_667_1.time_ and arg_667_1.time_ < var_670_5 + var_670_15 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_5) / var_670_15

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_5 + var_670_15 and arg_667_1.time_ < var_670_5 + var_670_15 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play1107403164 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 1107403164
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play1107403165(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = arg_671_1.actors_["1074ui_story"]
			local var_674_1 = 0

			if var_674_1 < arg_671_1.time_ and arg_671_1.time_ <= var_674_1 + arg_674_0 and not isNil(var_674_0) and arg_671_1.var_.characterEffect1074ui_story == nil then
				arg_671_1.var_.characterEffect1074ui_story = var_674_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_674_2 = 0.1

			if var_674_1 <= arg_671_1.time_ and arg_671_1.time_ < var_674_1 + var_674_2 and not isNil(var_674_0) then
				local var_674_3 = (arg_671_1.time_ - var_674_1) / var_674_2

				if arg_671_1.var_.characterEffect1074ui_story and not isNil(var_674_0) then
					local var_674_4 = Mathf.Lerp(0, 0.5, var_674_3)

					arg_671_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_671_1.var_.characterEffect1074ui_story.fillRatio = var_674_4
				end
			end

			if arg_671_1.time_ >= var_674_1 + var_674_2 and arg_671_1.time_ < var_674_1 + var_674_2 + arg_674_0 and not isNil(var_674_0) and arg_671_1.var_.characterEffect1074ui_story then
				local var_674_5 = 0.5

				arg_671_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_671_1.var_.characterEffect1074ui_story.fillRatio = var_674_5
			end

			local var_674_6 = 0
			local var_674_7 = 0.1

			if var_674_6 < arg_671_1.time_ and arg_671_1.time_ <= var_674_6 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				local var_674_8 = arg_671_1:FormatText(StoryNameCfg[7].name)

				arg_671_1.leftNameTxt_.text = var_674_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, true)
				arg_671_1.iconController_:SetSelectedState("hero")

				arg_671_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_671_1.callingController_:SetSelectedState("normal")

				arg_671_1.keyicon_.color = Color.New(1, 1, 1)
				arg_671_1.icon_.color = Color.New(1, 1, 1)

				local var_674_9 = arg_671_1:GetWordFromCfg(1107403164)
				local var_674_10 = arg_671_1:FormatText(var_674_9.content)

				arg_671_1.text_.text = var_674_10

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_11 = 4
				local var_674_12 = utf8.len(var_674_10)
				local var_674_13 = var_674_11 <= 0 and var_674_7 or var_674_7 * (var_674_12 / var_674_11)

				if var_674_13 > 0 and var_674_7 < var_674_13 then
					arg_671_1.talkMaxDuration = var_674_13

					if var_674_13 + var_674_6 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_13 + var_674_6
					end
				end

				arg_671_1.text_.text = var_674_10
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_14 = math.max(var_674_7, arg_671_1.talkMaxDuration)

			if var_674_6 <= arg_671_1.time_ and arg_671_1.time_ < var_674_6 + var_674_14 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_6) / var_674_14

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_6 + var_674_14 and arg_671_1.time_ < var_674_6 + var_674_14 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play1107403165 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 1107403165
		arg_675_1.duration_ = 5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play1107403166(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = arg_675_1.actors_["1074ui_story"].transform
			local var_678_1 = 0

			if var_678_1 < arg_675_1.time_ and arg_675_1.time_ <= var_678_1 + arg_678_0 then
				arg_675_1.var_.moveOldPos1074ui_story = var_678_0.localPosition

				local var_678_2 = "1074ui_story"

				arg_675_1:ShowWeapon(arg_675_1.var_[var_678_2 .. "Animator"].transform, false)
			end

			local var_678_3 = 0.001

			if var_678_1 <= arg_675_1.time_ and arg_675_1.time_ < var_678_1 + var_678_3 then
				local var_678_4 = (arg_675_1.time_ - var_678_1) / var_678_3
				local var_678_5 = Vector3.New(0, 100, 0)

				var_678_0.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPos1074ui_story, var_678_5, var_678_4)

				local var_678_6 = manager.ui.mainCamera.transform.position - var_678_0.position

				var_678_0.forward = Vector3.New(var_678_6.x, var_678_6.y, var_678_6.z)

				local var_678_7 = var_678_0.localEulerAngles

				var_678_7.z = 0
				var_678_7.x = 0
				var_678_0.localEulerAngles = var_678_7
			end

			if arg_675_1.time_ >= var_678_1 + var_678_3 and arg_675_1.time_ < var_678_1 + var_678_3 + arg_678_0 then
				var_678_0.localPosition = Vector3.New(0, 100, 0)

				local var_678_8 = manager.ui.mainCamera.transform.position - var_678_0.position

				var_678_0.forward = Vector3.New(var_678_8.x, var_678_8.y, var_678_8.z)

				local var_678_9 = var_678_0.localEulerAngles

				var_678_9.z = 0
				var_678_9.x = 0
				var_678_0.localEulerAngles = var_678_9
			end

			local var_678_10 = 0
			local var_678_11 = 1.2

			if var_678_10 < arg_675_1.time_ and arg_675_1.time_ <= var_678_10 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, false)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_12 = arg_675_1:GetWordFromCfg(1107403165)
				local var_678_13 = arg_675_1:FormatText(var_678_12.content)

				arg_675_1.text_.text = var_678_13

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_14 = 48
				local var_678_15 = utf8.len(var_678_13)
				local var_678_16 = var_678_14 <= 0 and var_678_11 or var_678_11 * (var_678_15 / var_678_14)

				if var_678_16 > 0 and var_678_11 < var_678_16 then
					arg_675_1.talkMaxDuration = var_678_16

					if var_678_16 + var_678_10 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_16 + var_678_10
					end
				end

				arg_675_1.text_.text = var_678_13
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)
				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_17 = math.max(var_678_11, arg_675_1.talkMaxDuration)

			if var_678_10 <= arg_675_1.time_ and arg_675_1.time_ < var_678_10 + var_678_17 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_10) / var_678_17

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_10 + var_678_17 and arg_675_1.time_ < var_678_10 + var_678_17 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_675_1:InitPlayNodeList()
	end,
	Play1107403166 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 1107403166
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play1107403167(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = 0
			local var_682_1 = 1.075

			if var_682_0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_0 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, false)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_2 = arg_679_1:GetWordFromCfg(1107403166)
				local var_682_3 = arg_679_1:FormatText(var_682_2.content)

				arg_679_1.text_.text = var_682_3

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_4 = 43
				local var_682_5 = utf8.len(var_682_3)
				local var_682_6 = var_682_4 <= 0 and var_682_1 or var_682_1 * (var_682_5 / var_682_4)

				if var_682_6 > 0 and var_682_1 < var_682_6 then
					arg_679_1.talkMaxDuration = var_682_6

					if var_682_6 + var_682_0 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_6 + var_682_0
					end
				end

				arg_679_1.text_.text = var_682_3
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_7 = math.max(var_682_1, arg_679_1.talkMaxDuration)

			if var_682_0 <= arg_679_1.time_ and arg_679_1.time_ < var_682_0 + var_682_7 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_0) / var_682_7

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_0 + var_682_7 and arg_679_1.time_ < var_682_0 + var_682_7 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play1107403167 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1107403167
		arg_683_1.duration_ = 3.77

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1107403168(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = arg_683_1.actors_["1074ui_story"].transform
			local var_686_1 = 0

			if var_686_1 < arg_683_1.time_ and arg_683_1.time_ <= var_686_1 + arg_686_0 then
				arg_683_1.var_.moveOldPos1074ui_story = var_686_0.localPosition

				local var_686_2 = "1074ui_story"

				arg_683_1:ShowWeapon(arg_683_1.var_[var_686_2 .. "Animator"].transform, false)
			end

			local var_686_3 = 0.001

			if var_686_1 <= arg_683_1.time_ and arg_683_1.time_ < var_686_1 + var_686_3 then
				local var_686_4 = (arg_683_1.time_ - var_686_1) / var_686_3
				local var_686_5 = Vector3.New(0, -1.055, -6.12)

				var_686_0.localPosition = Vector3.Lerp(arg_683_1.var_.moveOldPos1074ui_story, var_686_5, var_686_4)

				local var_686_6 = manager.ui.mainCamera.transform.position - var_686_0.position

				var_686_0.forward = Vector3.New(var_686_6.x, var_686_6.y, var_686_6.z)

				local var_686_7 = var_686_0.localEulerAngles

				var_686_7.z = 0
				var_686_7.x = 0
				var_686_0.localEulerAngles = var_686_7
			end

			if arg_683_1.time_ >= var_686_1 + var_686_3 and arg_683_1.time_ < var_686_1 + var_686_3 + arg_686_0 then
				var_686_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_686_8 = manager.ui.mainCamera.transform.position - var_686_0.position

				var_686_0.forward = Vector3.New(var_686_8.x, var_686_8.y, var_686_8.z)

				local var_686_9 = var_686_0.localEulerAngles

				var_686_9.z = 0
				var_686_9.x = 0
				var_686_0.localEulerAngles = var_686_9
			end

			local var_686_10 = 0

			if var_686_10 < arg_683_1.time_ and arg_683_1.time_ <= var_686_10 + arg_686_0 then
				arg_683_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_686_11 = arg_683_1.actors_["1074ui_story"]
			local var_686_12 = 0

			if var_686_12 < arg_683_1.time_ and arg_683_1.time_ <= var_686_12 + arg_686_0 and not isNil(var_686_11) and arg_683_1.var_.characterEffect1074ui_story == nil then
				arg_683_1.var_.characterEffect1074ui_story = var_686_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_686_13 = 0.1

			if var_686_12 <= arg_683_1.time_ and arg_683_1.time_ < var_686_12 + var_686_13 and not isNil(var_686_11) then
				local var_686_14 = (arg_683_1.time_ - var_686_12) / var_686_13

				if arg_683_1.var_.characterEffect1074ui_story and not isNil(var_686_11) then
					arg_683_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_683_1.time_ >= var_686_12 + var_686_13 and arg_683_1.time_ < var_686_12 + var_686_13 + arg_686_0 and not isNil(var_686_11) and arg_683_1.var_.characterEffect1074ui_story then
				arg_683_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_686_15 = 0
			local var_686_16 = 0.425

			if var_686_15 < arg_683_1.time_ and arg_683_1.time_ <= var_686_15 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				local var_686_17 = arg_683_1:FormatText(StoryNameCfg[410].name)

				arg_683_1.leftNameTxt_.text = var_686_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_18 = arg_683_1:GetWordFromCfg(1107403167)
				local var_686_19 = arg_683_1:FormatText(var_686_18.content)

				arg_683_1.text_.text = var_686_19

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_20 = 17
				local var_686_21 = utf8.len(var_686_19)
				local var_686_22 = var_686_20 <= 0 and var_686_16 or var_686_16 * (var_686_21 / var_686_20)

				if var_686_22 > 0 and var_686_16 < var_686_22 then
					arg_683_1.talkMaxDuration = var_686_22

					if var_686_22 + var_686_15 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_22 + var_686_15
					end
				end

				arg_683_1.text_.text = var_686_19
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403167", "story_v_side_new_1107403.awb") ~= 0 then
					local var_686_23 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403167", "story_v_side_new_1107403.awb") / 1000

					if var_686_23 + var_686_15 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_23 + var_686_15
					end

					if var_686_18.prefab_name ~= "" and arg_683_1.actors_[var_686_18.prefab_name] ~= nil then
						local var_686_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_683_1.actors_[var_686_18.prefab_name].transform, "story_v_side_new_1107403", "1107403167", "story_v_side_new_1107403.awb")

						arg_683_1:RecordAudio("1107403167", var_686_24)
						arg_683_1:RecordAudio("1107403167", var_686_24)
					else
						arg_683_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403167", "story_v_side_new_1107403.awb")
					end

					arg_683_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403167", "story_v_side_new_1107403.awb")
				end

				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_25 = math.max(var_686_16, arg_683_1.talkMaxDuration)

			if var_686_15 <= arg_683_1.time_ and arg_683_1.time_ < var_686_15 + var_686_25 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_15) / var_686_25

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_15 + var_686_25 and arg_683_1.time_ < var_686_15 + var_686_25 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_683_1:InitPlayNodeList()
	end,
	Play1107403168 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1107403168
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play1107403169(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = arg_687_1.actors_["1074ui_story"]
			local var_690_1 = 0

			if var_690_1 < arg_687_1.time_ and arg_687_1.time_ <= var_690_1 + arg_690_0 and not isNil(var_690_0) and arg_687_1.var_.characterEffect1074ui_story == nil then
				arg_687_1.var_.characterEffect1074ui_story = var_690_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_690_2 = 0.1

			if var_690_1 <= arg_687_1.time_ and arg_687_1.time_ < var_690_1 + var_690_2 and not isNil(var_690_0) then
				local var_690_3 = (arg_687_1.time_ - var_690_1) / var_690_2

				if arg_687_1.var_.characterEffect1074ui_story and not isNil(var_690_0) then
					local var_690_4 = Mathf.Lerp(0, 0.5, var_690_3)

					arg_687_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_687_1.var_.characterEffect1074ui_story.fillRatio = var_690_4
				end
			end

			if arg_687_1.time_ >= var_690_1 + var_690_2 and arg_687_1.time_ < var_690_1 + var_690_2 + arg_690_0 and not isNil(var_690_0) and arg_687_1.var_.characterEffect1074ui_story then
				local var_690_5 = 0.5

				arg_687_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_687_1.var_.characterEffect1074ui_story.fillRatio = var_690_5
			end

			local var_690_6 = 0
			local var_690_7 = 0.125

			if var_690_6 < arg_687_1.time_ and arg_687_1.time_ <= var_690_6 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				local var_690_8 = arg_687_1:FormatText(StoryNameCfg[7].name)

				arg_687_1.leftNameTxt_.text = var_690_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, true)
				arg_687_1.iconController_:SetSelectedState("hero")

				arg_687_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_687_1.callingController_:SetSelectedState("normal")

				arg_687_1.keyicon_.color = Color.New(1, 1, 1)
				arg_687_1.icon_.color = Color.New(1, 1, 1)

				local var_690_9 = arg_687_1:GetWordFromCfg(1107403168)
				local var_690_10 = arg_687_1:FormatText(var_690_9.content)

				arg_687_1.text_.text = var_690_10

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_11 = 5
				local var_690_12 = utf8.len(var_690_10)
				local var_690_13 = var_690_11 <= 0 and var_690_7 or var_690_7 * (var_690_12 / var_690_11)

				if var_690_13 > 0 and var_690_7 < var_690_13 then
					arg_687_1.talkMaxDuration = var_690_13

					if var_690_13 + var_690_6 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_13 + var_690_6
					end
				end

				arg_687_1.text_.text = var_690_10
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_14 = math.max(var_690_7, arg_687_1.talkMaxDuration)

			if var_690_6 <= arg_687_1.time_ and arg_687_1.time_ < var_690_6 + var_690_14 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_6) / var_690_14

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_6 + var_690_14 and arg_687_1.time_ < var_690_6 + var_690_14 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play1107403169 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1107403169
		arg_691_1.duration_ = 5.07

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1107403170(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = 0

			if var_694_0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_0 + arg_694_0 then
				arg_691_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action3_1")
			end

			local var_694_1 = arg_691_1.actors_["1074ui_story"]
			local var_694_2 = 0

			if var_694_2 < arg_691_1.time_ and arg_691_1.time_ <= var_694_2 + arg_694_0 and not isNil(var_694_1) and arg_691_1.var_.characterEffect1074ui_story == nil then
				arg_691_1.var_.characterEffect1074ui_story = var_694_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_694_3 = 0.1

			if var_694_2 <= arg_691_1.time_ and arg_691_1.time_ < var_694_2 + var_694_3 and not isNil(var_694_1) then
				local var_694_4 = (arg_691_1.time_ - var_694_2) / var_694_3

				if arg_691_1.var_.characterEffect1074ui_story and not isNil(var_694_1) then
					arg_691_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_691_1.time_ >= var_694_2 + var_694_3 and arg_691_1.time_ < var_694_2 + var_694_3 + arg_694_0 and not isNil(var_694_1) and arg_691_1.var_.characterEffect1074ui_story then
				arg_691_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_694_5 = 0
			local var_694_6 = 0.625

			if var_694_5 < arg_691_1.time_ and arg_691_1.time_ <= var_694_5 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				local var_694_7 = arg_691_1:FormatText(StoryNameCfg[410].name)

				arg_691_1.leftNameTxt_.text = var_694_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_8 = arg_691_1:GetWordFromCfg(1107403169)
				local var_694_9 = arg_691_1:FormatText(var_694_8.content)

				arg_691_1.text_.text = var_694_9

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_10 = 25
				local var_694_11 = utf8.len(var_694_9)
				local var_694_12 = var_694_10 <= 0 and var_694_6 or var_694_6 * (var_694_11 / var_694_10)

				if var_694_12 > 0 and var_694_6 < var_694_12 then
					arg_691_1.talkMaxDuration = var_694_12

					if var_694_12 + var_694_5 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_12 + var_694_5
					end
				end

				arg_691_1.text_.text = var_694_9
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403169", "story_v_side_new_1107403.awb") ~= 0 then
					local var_694_13 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403169", "story_v_side_new_1107403.awb") / 1000

					if var_694_13 + var_694_5 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_13 + var_694_5
					end

					if var_694_8.prefab_name ~= "" and arg_691_1.actors_[var_694_8.prefab_name] ~= nil then
						local var_694_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_8.prefab_name].transform, "story_v_side_new_1107403", "1107403169", "story_v_side_new_1107403.awb")

						arg_691_1:RecordAudio("1107403169", var_694_14)
						arg_691_1:RecordAudio("1107403169", var_694_14)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403169", "story_v_side_new_1107403.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403169", "story_v_side_new_1107403.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_15 = math.max(var_694_6, arg_691_1.talkMaxDuration)

			if var_694_5 <= arg_691_1.time_ and arg_691_1.time_ < var_694_5 + var_694_15 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_5) / var_694_15

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_5 + var_694_15 and arg_691_1.time_ < var_694_5 + var_694_15 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play1107403170 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 1107403170
		arg_695_1.duration_ = 5

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play1107403171(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = arg_695_1.actors_["1074ui_story"]
			local var_698_1 = 0

			if var_698_1 < arg_695_1.time_ and arg_695_1.time_ <= var_698_1 + arg_698_0 and not isNil(var_698_0) and arg_695_1.var_.characterEffect1074ui_story == nil then
				arg_695_1.var_.characterEffect1074ui_story = var_698_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_698_2 = 0.1

			if var_698_1 <= arg_695_1.time_ and arg_695_1.time_ < var_698_1 + var_698_2 and not isNil(var_698_0) then
				local var_698_3 = (arg_695_1.time_ - var_698_1) / var_698_2

				if arg_695_1.var_.characterEffect1074ui_story and not isNil(var_698_0) then
					local var_698_4 = Mathf.Lerp(0, 0.5, var_698_3)

					arg_695_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_695_1.var_.characterEffect1074ui_story.fillRatio = var_698_4
				end
			end

			if arg_695_1.time_ >= var_698_1 + var_698_2 and arg_695_1.time_ < var_698_1 + var_698_2 + arg_698_0 and not isNil(var_698_0) and arg_695_1.var_.characterEffect1074ui_story then
				local var_698_5 = 0.5

				arg_695_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_695_1.var_.characterEffect1074ui_story.fillRatio = var_698_5
			end

			local var_698_6 = 0
			local var_698_7 = 0.5

			if var_698_6 < arg_695_1.time_ and arg_695_1.time_ <= var_698_6 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				local var_698_8 = arg_695_1:FormatText(StoryNameCfg[7].name)

				arg_695_1.leftNameTxt_.text = var_698_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, true)
				arg_695_1.iconController_:SetSelectedState("hero")

				arg_695_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_695_1.callingController_:SetSelectedState("normal")

				arg_695_1.keyicon_.color = Color.New(1, 1, 1)
				arg_695_1.icon_.color = Color.New(1, 1, 1)

				local var_698_9 = arg_695_1:GetWordFromCfg(1107403170)
				local var_698_10 = arg_695_1:FormatText(var_698_9.content)

				arg_695_1.text_.text = var_698_10

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_11 = 20
				local var_698_12 = utf8.len(var_698_10)
				local var_698_13 = var_698_11 <= 0 and var_698_7 or var_698_7 * (var_698_12 / var_698_11)

				if var_698_13 > 0 and var_698_7 < var_698_13 then
					arg_695_1.talkMaxDuration = var_698_13

					if var_698_13 + var_698_6 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_13 + var_698_6
					end
				end

				arg_695_1.text_.text = var_698_10
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)
				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_14 = math.max(var_698_7, arg_695_1.talkMaxDuration)

			if var_698_6 <= arg_695_1.time_ and arg_695_1.time_ < var_698_6 + var_698_14 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_6) / var_698_14

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_6 + var_698_14 and arg_695_1.time_ < var_698_6 + var_698_14 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play1107403171 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 1107403171
		arg_699_1.duration_ = 2.83

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play1107403172(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = arg_699_1.actors_["1074ui_story"]
			local var_702_1 = 0

			if var_702_1 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 and not isNil(var_702_0) and arg_699_1.var_.characterEffect1074ui_story == nil then
				arg_699_1.var_.characterEffect1074ui_story = var_702_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_702_2 = 0.1

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_2 and not isNil(var_702_0) then
				local var_702_3 = (arg_699_1.time_ - var_702_1) / var_702_2

				if arg_699_1.var_.characterEffect1074ui_story and not isNil(var_702_0) then
					arg_699_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_699_1.time_ >= var_702_1 + var_702_2 and arg_699_1.time_ < var_702_1 + var_702_2 + arg_702_0 and not isNil(var_702_0) and arg_699_1.var_.characterEffect1074ui_story then
				arg_699_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_702_4 = 0
			local var_702_5 = 0.125

			if var_702_4 < arg_699_1.time_ and arg_699_1.time_ <= var_702_4 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				local var_702_6 = arg_699_1:FormatText(StoryNameCfg[410].name)

				arg_699_1.leftNameTxt_.text = var_702_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_7 = arg_699_1:GetWordFromCfg(1107403171)
				local var_702_8 = arg_699_1:FormatText(var_702_7.content)

				arg_699_1.text_.text = var_702_8

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_9 = 5
				local var_702_10 = utf8.len(var_702_8)
				local var_702_11 = var_702_9 <= 0 and var_702_5 or var_702_5 * (var_702_10 / var_702_9)

				if var_702_11 > 0 and var_702_5 < var_702_11 then
					arg_699_1.talkMaxDuration = var_702_11

					if var_702_11 + var_702_4 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_11 + var_702_4
					end
				end

				arg_699_1.text_.text = var_702_8
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403171", "story_v_side_new_1107403.awb") ~= 0 then
					local var_702_12 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403171", "story_v_side_new_1107403.awb") / 1000

					if var_702_12 + var_702_4 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_12 + var_702_4
					end

					if var_702_7.prefab_name ~= "" and arg_699_1.actors_[var_702_7.prefab_name] ~= nil then
						local var_702_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_7.prefab_name].transform, "story_v_side_new_1107403", "1107403171", "story_v_side_new_1107403.awb")

						arg_699_1:RecordAudio("1107403171", var_702_13)
						arg_699_1:RecordAudio("1107403171", var_702_13)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403171", "story_v_side_new_1107403.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403171", "story_v_side_new_1107403.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_14 = math.max(var_702_5, arg_699_1.talkMaxDuration)

			if var_702_4 <= arg_699_1.time_ and arg_699_1.time_ < var_702_4 + var_702_14 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_4) / var_702_14

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_4 + var_702_14 and arg_699_1.time_ < var_702_4 + var_702_14 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {}

		arg_699_1:InitPlayNodeList()
	end,
	Play1107403172 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 1107403172
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
			arg_703_1.auto_ = false
		end

		function arg_703_1.playNext_(arg_705_0)
			arg_703_1.onStoryFinished_()
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = arg_703_1.actors_["1074ui_story"]
			local var_706_1 = 0

			if var_706_1 < arg_703_1.time_ and arg_703_1.time_ <= var_706_1 + arg_706_0 and not isNil(var_706_0) and arg_703_1.var_.characterEffect1074ui_story == nil then
				arg_703_1.var_.characterEffect1074ui_story = var_706_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_2 = 0.1

			if var_706_1 <= arg_703_1.time_ and arg_703_1.time_ < var_706_1 + var_706_2 and not isNil(var_706_0) then
				local var_706_3 = (arg_703_1.time_ - var_706_1) / var_706_2

				if arg_703_1.var_.characterEffect1074ui_story and not isNil(var_706_0) then
					local var_706_4 = Mathf.Lerp(0, 0.5, var_706_3)

					arg_703_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_703_1.var_.characterEffect1074ui_story.fillRatio = var_706_4
				end
			end

			if arg_703_1.time_ >= var_706_1 + var_706_2 and arg_703_1.time_ < var_706_1 + var_706_2 + arg_706_0 and not isNil(var_706_0) and arg_703_1.var_.characterEffect1074ui_story then
				local var_706_5 = 0.5

				arg_703_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_703_1.var_.characterEffect1074ui_story.fillRatio = var_706_5
			end

			local var_706_6 = 0
			local var_706_7 = 0.5

			if var_706_6 < arg_703_1.time_ and arg_703_1.time_ <= var_706_6 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				local var_706_8 = arg_703_1:FormatText(StoryNameCfg[7].name)

				arg_703_1.leftNameTxt_.text = var_706_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, true)
				arg_703_1.iconController_:SetSelectedState("hero")

				arg_703_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_703_1.callingController_:SetSelectedState("normal")

				arg_703_1.keyicon_.color = Color.New(1, 1, 1)
				arg_703_1.icon_.color = Color.New(1, 1, 1)

				local var_706_9 = arg_703_1:GetWordFromCfg(1107403172)
				local var_706_10 = arg_703_1:FormatText(var_706_9.content)

				arg_703_1.text_.text = var_706_10

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_11 = 20
				local var_706_12 = utf8.len(var_706_10)
				local var_706_13 = var_706_11 <= 0 and var_706_7 or var_706_7 * (var_706_12 / var_706_11)

				if var_706_13 > 0 and var_706_7 < var_706_13 then
					arg_703_1.talkMaxDuration = var_706_13

					if var_706_13 + var_706_6 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_13 + var_706_6
					end
				end

				arg_703_1.text_.text = var_706_10
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_14 = math.max(var_706_7, arg_703_1.talkMaxDuration)

			if var_706_6 <= arg_703_1.time_ and arg_703_1.time_ < var_706_6 + var_706_14 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_6) / var_706_14

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_6 + var_706_14 and arg_703_1.time_ < var_706_6 + var_706_14 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play1107403148 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 1107403148
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play1107403149(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = arg_707_1.actors_["1074ui_story"]
			local var_710_1 = 0

			if var_710_1 < arg_707_1.time_ and arg_707_1.time_ <= var_710_1 + arg_710_0 and not isNil(var_710_0) and arg_707_1.var_.characterEffect1074ui_story == nil then
				arg_707_1.var_.characterEffect1074ui_story = var_710_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_710_2 = 0.1

			if var_710_1 <= arg_707_1.time_ and arg_707_1.time_ < var_710_1 + var_710_2 and not isNil(var_710_0) then
				local var_710_3 = (arg_707_1.time_ - var_710_1) / var_710_2

				if arg_707_1.var_.characterEffect1074ui_story and not isNil(var_710_0) then
					local var_710_4 = Mathf.Lerp(0, 0.5, var_710_3)

					arg_707_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_707_1.var_.characterEffect1074ui_story.fillRatio = var_710_4
				end
			end

			if arg_707_1.time_ >= var_710_1 + var_710_2 and arg_707_1.time_ < var_710_1 + var_710_2 + arg_710_0 and not isNil(var_710_0) and arg_707_1.var_.characterEffect1074ui_story then
				local var_710_5 = 0.5

				arg_707_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_707_1.var_.characterEffect1074ui_story.fillRatio = var_710_5
			end

			local var_710_6 = 0
			local var_710_7 = 1

			if var_710_6 < arg_707_1.time_ and arg_707_1.time_ <= var_710_6 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				local var_710_8 = arg_707_1:FormatText(StoryNameCfg[7].name)

				arg_707_1.leftNameTxt_.text = var_710_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, true)
				arg_707_1.iconController_:SetSelectedState("hero")

				arg_707_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_707_1.callingController_:SetSelectedState("normal")

				arg_707_1.keyicon_.color = Color.New(1, 1, 1)
				arg_707_1.icon_.color = Color.New(1, 1, 1)

				local var_710_9 = arg_707_1:GetWordFromCfg(1107403148)
				local var_710_10 = arg_707_1:FormatText(var_710_9.content)

				arg_707_1.text_.text = var_710_10

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_11 = 40
				local var_710_12 = utf8.len(var_710_10)
				local var_710_13 = var_710_11 <= 0 and var_710_7 or var_710_7 * (var_710_12 / var_710_11)

				if var_710_13 > 0 and var_710_7 < var_710_13 then
					arg_707_1.talkMaxDuration = var_710_13

					if var_710_13 + var_710_6 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_13 + var_710_6
					end
				end

				arg_707_1.text_.text = var_710_10
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_14 = math.max(var_710_7, arg_707_1.talkMaxDuration)

			if var_710_6 <= arg_707_1.time_ and arg_707_1.time_ < var_710_6 + var_710_14 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_6) / var_710_14

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_6 + var_710_14 and arg_707_1.time_ < var_710_6 + var_710_14 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play1107403149 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 1107403149
		arg_711_1.duration_ = 6.87

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play1107403150(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = arg_711_1.actors_["1074ui_story"]
			local var_714_1 = 0

			if var_714_1 < arg_711_1.time_ and arg_711_1.time_ <= var_714_1 + arg_714_0 and not isNil(var_714_0) and arg_711_1.var_.characterEffect1074ui_story == nil then
				arg_711_1.var_.characterEffect1074ui_story = var_714_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_714_2 = 0.1

			if var_714_1 <= arg_711_1.time_ and arg_711_1.time_ < var_714_1 + var_714_2 and not isNil(var_714_0) then
				local var_714_3 = (arg_711_1.time_ - var_714_1) / var_714_2

				if arg_711_1.var_.characterEffect1074ui_story and not isNil(var_714_0) then
					arg_711_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_711_1.time_ >= var_714_1 + var_714_2 and arg_711_1.time_ < var_714_1 + var_714_2 + arg_714_0 and not isNil(var_714_0) and arg_711_1.var_.characterEffect1074ui_story then
				arg_711_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_714_4 = 0

			if var_714_4 < arg_711_1.time_ and arg_711_1.time_ <= var_714_4 + arg_714_0 then
				arg_711_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_2")
			end

			local var_714_5 = 0
			local var_714_6 = 0.5

			if var_714_5 < arg_711_1.time_ and arg_711_1.time_ <= var_714_5 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				local var_714_7 = arg_711_1:FormatText(StoryNameCfg[410].name)

				arg_711_1.leftNameTxt_.text = var_714_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_8 = arg_711_1:GetWordFromCfg(1107403149)
				local var_714_9 = arg_711_1:FormatText(var_714_8.content)

				arg_711_1.text_.text = var_714_9

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_10 = 20
				local var_714_11 = utf8.len(var_714_9)
				local var_714_12 = var_714_10 <= 0 and var_714_6 or var_714_6 * (var_714_11 / var_714_10)

				if var_714_12 > 0 and var_714_6 < var_714_12 then
					arg_711_1.talkMaxDuration = var_714_12

					if var_714_12 + var_714_5 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_12 + var_714_5
					end
				end

				arg_711_1.text_.text = var_714_9
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403149", "story_v_side_new_1107403.awb") ~= 0 then
					local var_714_13 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403149", "story_v_side_new_1107403.awb") / 1000

					if var_714_13 + var_714_5 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_13 + var_714_5
					end

					if var_714_8.prefab_name ~= "" and arg_711_1.actors_[var_714_8.prefab_name] ~= nil then
						local var_714_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_711_1.actors_[var_714_8.prefab_name].transform, "story_v_side_new_1107403", "1107403149", "story_v_side_new_1107403.awb")

						arg_711_1:RecordAudio("1107403149", var_714_14)
						arg_711_1:RecordAudio("1107403149", var_714_14)
					else
						arg_711_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403149", "story_v_side_new_1107403.awb")
					end

					arg_711_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403149", "story_v_side_new_1107403.awb")
				end

				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_15 = math.max(var_714_6, arg_711_1.talkMaxDuration)

			if var_714_5 <= arg_711_1.time_ and arg_711_1.time_ < var_714_5 + var_714_15 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_5) / var_714_15

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_5 + var_714_15 and arg_711_1.time_ < var_714_5 + var_714_15 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play1107403048 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 1107403048
		arg_715_1.duration_ = 2.3

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play1107403049(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = arg_715_1.actors_["1074ui_story"]
			local var_718_1 = 0

			if var_718_1 < arg_715_1.time_ and arg_715_1.time_ <= var_718_1 + arg_718_0 and not isNil(var_718_0) and arg_715_1.var_.characterEffect1074ui_story == nil then
				arg_715_1.var_.characterEffect1074ui_story = var_718_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_2 = 0.1

			if var_718_1 <= arg_715_1.time_ and arg_715_1.time_ < var_718_1 + var_718_2 and not isNil(var_718_0) then
				local var_718_3 = (arg_715_1.time_ - var_718_1) / var_718_2

				if arg_715_1.var_.characterEffect1074ui_story and not isNil(var_718_0) then
					arg_715_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_715_1.time_ >= var_718_1 + var_718_2 and arg_715_1.time_ < var_718_1 + var_718_2 + arg_718_0 and not isNil(var_718_0) and arg_715_1.var_.characterEffect1074ui_story then
				arg_715_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_718_4 = "1074ui_story"

			if arg_715_1.actors_[var_718_4] == nil then
				local var_718_5 = Asset.Load("Char/" .. "1074ui_story")

				if not isNil(var_718_5) then
					local var_718_6 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_715_1.stage_.transform)

					var_718_6.name = var_718_4
					var_718_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_715_1.actors_[var_718_4] = var_718_6

					local var_718_7 = var_718_6:GetComponentInChildren(typeof(CharacterEffect))

					var_718_7.enabled = true

					local var_718_8 = GameObjectTools.GetOrAddComponent(var_718_6, typeof(DynamicBoneHelper))

					if var_718_8 then
						var_718_8:EnableDynamicBone(false)
					end

					arg_715_1:ShowWeapon(var_718_7.transform, false)

					arg_715_1.var_[var_718_4 .. "Animator"] = var_718_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_715_1.var_[var_718_4 .. "Animator"].applyRootMotion = true
					arg_715_1.var_[var_718_4 .. "LipSync"] = var_718_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_718_9 = 0

			if var_718_9 < arg_715_1.time_ and arg_715_1.time_ <= var_718_9 + arg_718_0 then
				arg_715_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_718_10 = arg_715_1.actors_["1074ui_story"].transform
			local var_718_11 = 0

			if var_718_11 < arg_715_1.time_ and arg_715_1.time_ <= var_718_11 + arg_718_0 then
				arg_715_1.var_.moveOldPos1074ui_story = var_718_10.localPosition

				local var_718_12 = "1074ui_story"

				arg_715_1:ShowWeapon(arg_715_1.var_[var_718_12 .. "Animator"].transform, false)
			end

			local var_718_13 = 0.001

			if var_718_11 <= arg_715_1.time_ and arg_715_1.time_ < var_718_11 + var_718_13 then
				local var_718_14 = (arg_715_1.time_ - var_718_11) / var_718_13
				local var_718_15 = Vector3.New(0, -1.055, -6.12)

				var_718_10.localPosition = Vector3.Lerp(arg_715_1.var_.moveOldPos1074ui_story, var_718_15, var_718_14)

				local var_718_16 = manager.ui.mainCamera.transform.position - var_718_10.position

				var_718_10.forward = Vector3.New(var_718_16.x, var_718_16.y, var_718_16.z)

				local var_718_17 = var_718_10.localEulerAngles

				var_718_17.z = 0
				var_718_17.x = 0
				var_718_10.localEulerAngles = var_718_17
			end

			if arg_715_1.time_ >= var_718_11 + var_718_13 and arg_715_1.time_ < var_718_11 + var_718_13 + arg_718_0 then
				var_718_10.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_718_18 = manager.ui.mainCamera.transform.position - var_718_10.position

				var_718_10.forward = Vector3.New(var_718_18.x, var_718_18.y, var_718_18.z)

				local var_718_19 = var_718_10.localEulerAngles

				var_718_19.z = 0
				var_718_19.x = 0
				var_718_10.localEulerAngles = var_718_19
			end

			local var_718_20 = 0
			local var_718_21 = 0.25

			if var_718_20 < arg_715_1.time_ and arg_715_1.time_ <= var_718_20 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				local var_718_22 = arg_715_1:FormatText(StoryNameCfg[410].name)

				arg_715_1.leftNameTxt_.text = var_718_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_23 = arg_715_1:GetWordFromCfg(1107403048)
				local var_718_24 = arg_715_1:FormatText(var_718_23.content)

				arg_715_1.text_.text = var_718_24

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_25 = 10
				local var_718_26 = utf8.len(var_718_24)
				local var_718_27 = var_718_25 <= 0 and var_718_21 or var_718_21 * (var_718_26 / var_718_25)

				if var_718_27 > 0 and var_718_21 < var_718_27 then
					arg_715_1.talkMaxDuration = var_718_27

					if var_718_27 + var_718_20 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_27 + var_718_20
					end
				end

				arg_715_1.text_.text = var_718_24
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403048", "story_v_side_new_1107403.awb") ~= 0 then
					local var_718_28 = manager.audio:GetVoiceLength("story_v_side_new_1107403", "1107403048", "story_v_side_new_1107403.awb") / 1000

					if var_718_28 + var_718_20 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_28 + var_718_20
					end

					if var_718_23.prefab_name ~= "" and arg_715_1.actors_[var_718_23.prefab_name] ~= nil then
						local var_718_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_715_1.actors_[var_718_23.prefab_name].transform, "story_v_side_new_1107403", "1107403048", "story_v_side_new_1107403.awb")

						arg_715_1:RecordAudio("1107403048", var_718_29)
						arg_715_1:RecordAudio("1107403048", var_718_29)
					else
						arg_715_1:AudioAction("play", "voice", "story_v_side_new_1107403", "1107403048", "story_v_side_new_1107403.awb")
					end

					arg_715_1:RecordHistoryTalkVoice("story_v_side_new_1107403", "1107403048", "story_v_side_new_1107403.awb")
				end

				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_30 = math.max(var_718_21, arg_715_1.talkMaxDuration)

			if var_718_20 <= arg_715_1.time_ and arg_715_1.time_ < var_718_20 + var_718_30 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_20) / var_718_30

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_20 + var_718_30 and arg_715_1.time_ < var_718_20 + var_718_30 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_715_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST45",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST47",
		"TextureConfig/Background/J03f",
		"TextureConfig/Background/J03g",
		"TextureConfig/Background/J10b"
	},
	voices = {
		"story_v_side_new_1107403.awb"
	}
}
