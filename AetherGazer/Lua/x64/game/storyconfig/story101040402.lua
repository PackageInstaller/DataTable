return {
	Play104042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104042001
		arg_1_1.duration_ = 4.67

		local var_1_0 = {
			ja = 4.566,
			ko = 4.066,
			zh = 4.166,
			en = 4.666
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
				arg_1_0:Play104042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			local var_4_6 = "1084ui_story"

			if arg_1_1.actors_[var_4_6] == nil then
				local var_4_7 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_4_7) then
					local var_4_8 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

					var_4_8.name = var_4_6
					var_4_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_6] = var_4_8

					local var_4_9 = var_4_8:GetComponentInChildren(typeof(CharacterEffect))

					var_4_9.enabled = true

					local var_4_10 = GameObjectTools.GetOrAddComponent(var_4_8, typeof(DynamicBoneHelper))

					if var_4_10 then
						var_4_10:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_9.transform, false)

					arg_1_1.var_[var_4_6 .. "Animator"] = var_4_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_6 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_6 .. "LipSync"] = var_4_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_11 = arg_1_1.actors_["1084ui_story"]
			local var_4_12 = 2

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 and not isNil(var_4_11) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_13 = 0.1

			if var_4_12 <= arg_1_1.time_ and arg_1_1.time_ < var_4_12 + var_4_13 and not isNil(var_4_11) then
				local var_4_14 = (arg_1_1.time_ - var_4_12) / var_4_13

				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_11) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_12 + var_4_13 and arg_1_1.time_ < var_4_12 + var_4_13 + arg_4_0 and not isNil(var_4_11) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_15 = "S0403"

			if arg_1_1.bgs_[var_4_15] == nil then
				local var_4_16 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_16:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_15)
				var_4_16.name = var_4_15
				var_4_16.transform.parent = arg_1_1.stage_.transform
				var_4_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_15] = var_4_16
			end

			local var_4_17 = arg_1_1.bgs_.S0403
			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				local var_4_19 = var_4_17:GetComponent("SpriteRenderer")

				if var_4_19 then
					arg_1_1.var_.alphaOldValueS0403 = var_4_19.color.a
					arg_1_1.var_.alphaMatValueS0403 = var_4_19
				end

				arg_1_1.var_.alphaOldValueS0403 = 0
			end

			local var_4_20 = 1.5

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_20 then
				local var_4_21 = (arg_1_1.time_ - var_4_18) / var_4_20
				local var_4_22 = Mathf.Lerp(arg_1_1.var_.alphaOldValueS0403, 1, var_4_21)

				if arg_1_1.var_.alphaMatValueS0403 then
					local var_4_23 = arg_1_1.var_.alphaMatValueS0403.color

					var_4_23.a = var_4_22
					arg_1_1.var_.alphaMatValueS0403.color = var_4_23
				end
			end

			if arg_1_1.time_ >= var_4_18 + var_4_20 and arg_1_1.time_ < var_4_18 + var_4_20 + arg_4_0 and arg_1_1.var_.alphaMatValueS0403 then
				local var_4_24 = arg_1_1.var_.alphaMatValueS0403
				local var_4_25 = var_4_24.color

				var_4_25.a = 1
				var_4_24.color = var_4_25
			end

			local var_4_26 = 0

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_27 = manager.ui.mainCamera.transform.localPosition
				local var_4_28 = Vector3.New(0, 0, 10) + Vector3.New(var_4_27.x, var_4_27.y, 0)
				local var_4_29 = arg_1_1.bgs_.S0403

				var_4_29.transform.localPosition = var_4_28
				var_4_29.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_30 = var_4_29:GetComponent("SpriteRenderer")

				if var_4_30 and var_4_30.sprite then
					local var_4_31 = (var_4_29.transform.localPosition - var_4_27).z
					local var_4_32 = manager.ui.mainCameraCom_
					local var_4_33 = 2 * var_4_31 * Mathf.Tan(var_4_32.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_34 = var_4_33 * var_4_32.aspect
					local var_4_35 = var_4_30.sprite.bounds.size.x
					local var_4_36 = var_4_30.sprite.bounds.size.y
					local var_4_37 = var_4_34 / var_4_35
					local var_4_38 = var_4_33 / var_4_36
					local var_4_39 = var_4_38 < var_4_37 and var_4_37 or var_4_38

					var_4_29.transform.localScale = Vector3.New(var_4_39, var_4_39, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0403" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_40 = 0

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_41 = 2

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_42 = 2
			local var_4_43 = 0.175

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_44 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_44:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_45 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_46 = arg_1_1:GetWordFromCfg(104042001)
				local var_4_47 = arg_1_1:FormatText(var_4_46.content)

				arg_1_1.text_.text = var_4_47

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_48 = 7
				local var_4_49 = utf8.len(var_4_47)
				local var_4_50 = var_4_48 <= 0 and var_4_43 or var_4_43 * (var_4_49 / var_4_48)

				if var_4_50 > 0 and var_4_43 < var_4_50 then
					arg_1_1.talkMaxDuration = var_4_50
					var_4_42 = var_4_42 + 0.3

					if var_4_50 + var_4_42 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_50 + var_4_42
					end
				end

				arg_1_1.text_.text = var_4_47
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042001", "story_v_out_104042.awb") ~= 0 then
					local var_4_51 = manager.audio:GetVoiceLength("story_v_out_104042", "104042001", "story_v_out_104042.awb") / 1000

					if var_4_51 + var_4_42 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_51 + var_4_42
					end

					if var_4_46.prefab_name ~= "" and arg_1_1.actors_[var_4_46.prefab_name] ~= nil then
						local var_4_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_46.prefab_name].transform, "story_v_out_104042", "104042001", "story_v_out_104042.awb")

						arg_1_1:RecordAudio("104042001", var_4_52)
						arg_1_1:RecordAudio("104042001", var_4_52)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_104042", "104042001", "story_v_out_104042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_104042", "104042001", "story_v_out_104042.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_53 = var_4_42 + 0.3
			local var_4_54 = math.max(var_4_43, arg_1_1.talkMaxDuration)

			if var_4_53 <= arg_1_1.time_ and arg_1_1.time_ < var_4_53 + var_4_54 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_53) / var_4_54

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_53 + var_4_54 and arg_1_1.time_ < var_4_53 + var_4_54 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play104042002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104042002
		arg_8_1.duration_ = 4.63

		local var_8_0 = {
			ja = 3.733,
			ko = 4.633,
			zh = 4.1,
			en = 3.7
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play104042003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1084ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.1

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1084ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1084ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1084ui_story.fillRatio = var_11_5
			end

			local var_11_6 = 0
			local var_11_7 = 0.225

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_8 = arg_8_1:FormatText(StoryNameCfg[36].name)

				arg_8_1.leftNameTxt_.text = var_11_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_9 = arg_8_1:GetWordFromCfg(104042002)
				local var_11_10 = arg_8_1:FormatText(var_11_9.content)

				arg_8_1.text_.text = var_11_10

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_11 = 9
				local var_11_12 = utf8.len(var_11_10)
				local var_11_13 = var_11_11 <= 0 and var_11_7 or var_11_7 * (var_11_12 / var_11_11)

				if var_11_13 > 0 and var_11_7 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_6
					end
				end

				arg_8_1.text_.text = var_11_10
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042002", "story_v_out_104042.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_104042", "104042002", "story_v_out_104042.awb") / 1000

					if var_11_14 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_6
					end

					if var_11_9.prefab_name ~= "" and arg_8_1.actors_[var_11_9.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_9.prefab_name].transform, "story_v_out_104042", "104042002", "story_v_out_104042.awb")

						arg_8_1:RecordAudio("104042002", var_11_15)
						arg_8_1:RecordAudio("104042002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104042", "104042002", "story_v_out_104042.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104042", "104042002", "story_v_out_104042.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_7, arg_8_1.talkMaxDuration)

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_6) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_6 + var_11_16 and arg_8_1.time_ < var_11_6 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play104042003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104042003
		arg_12_1.duration_ = 1.83

		local var_12_0 = {
			ja = 1.833,
			ko = 1.2,
			zh = 1,
			en = 1.233
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
				arg_12_0:Play104042004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1019ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["1019ui_story"]
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1019ui_story == nil then
				arg_12_1.var_.characterEffect1019ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 and not isNil(var_15_5) then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7

				if arg_12_1.var_.characterEffect1019ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1019ui_story then
				arg_12_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_15_9 = 0
			local var_15_10 = 0.1

			if var_15_9 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_11 = arg_12_1:FormatText(StoryNameCfg[13].name)

				arg_12_1.leftNameTxt_.text = var_15_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_12 = arg_12_1:GetWordFromCfg(104042003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_14 = 4
				local var_15_15 = utf8.len(var_15_13)
				local var_15_16 = var_15_14 <= 0 and var_15_10 or var_15_10 * (var_15_15 / var_15_14)

				if var_15_16 > 0 and var_15_10 < var_15_16 then
					arg_12_1.talkMaxDuration = var_15_16

					if var_15_16 + var_15_9 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_9
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042003", "story_v_out_104042.awb") ~= 0 then
					local var_15_17 = manager.audio:GetVoiceLength("story_v_out_104042", "104042003", "story_v_out_104042.awb") / 1000

					if var_15_17 + var_15_9 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_17 + var_15_9
					end

					if var_15_12.prefab_name ~= "" and arg_12_1.actors_[var_15_12.prefab_name] ~= nil then
						local var_15_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_12.prefab_name].transform, "story_v_out_104042", "104042003", "story_v_out_104042.awb")

						arg_12_1:RecordAudio("104042003", var_15_18)
						arg_12_1:RecordAudio("104042003", var_15_18)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104042", "104042003", "story_v_out_104042.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104042", "104042003", "story_v_out_104042.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_19 = math.max(var_15_10, arg_12_1.talkMaxDuration)

			if var_15_9 <= arg_12_1.time_ and arg_12_1.time_ < var_15_9 + var_15_19 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_9) / var_15_19

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_9 + var_15_19 and arg_12_1.time_ < var_15_9 + var_15_19 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play104042004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104042004
		arg_16_1.duration_ = 4.93

		local var_16_0 = {
			ja = 4.466,
			ko = 3.466,
			zh = 4.1,
			en = 4.933
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
				arg_16_0:Play104042005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1019ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1019ui_story and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1019ui_story.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1019ui_story then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1019ui_story.fillRatio = var_19_5
			end

			local var_19_6 = 0
			local var_19_7 = 0.475

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_8 = arg_16_1:FormatText(StoryNameCfg[6].name)

				arg_16_1.leftNameTxt_.text = var_19_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_9 = arg_16_1:GetWordFromCfg(104042004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 19
				local var_19_12 = utf8.len(var_19_10)
				local var_19_13 = var_19_11 <= 0 and var_19_7 or var_19_7 * (var_19_12 / var_19_11)

				if var_19_13 > 0 and var_19_7 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_10
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042004", "story_v_out_104042.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_104042", "104042004", "story_v_out_104042.awb") / 1000

					if var_19_14 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_6
					end

					if var_19_9.prefab_name ~= "" and arg_16_1.actors_[var_19_9.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_9.prefab_name].transform, "story_v_out_104042", "104042004", "story_v_out_104042.awb")

						arg_16_1:RecordAudio("104042004", var_19_15)
						arg_16_1:RecordAudio("104042004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104042", "104042004", "story_v_out_104042.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104042", "104042004", "story_v_out_104042.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_16 and arg_16_1.time_ < var_19_6 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play104042005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104042005
		arg_20_1.duration_ = 4.63

		local var_20_0 = {
			ja = 2.233,
			ko = 3.1,
			zh = 3.233,
			en = 4.633
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
				arg_20_0:Play104042006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.425

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[6].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(104042005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042005", "story_v_out_104042.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_104042", "104042005", "story_v_out_104042.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_104042", "104042005", "story_v_out_104042.awb")

						arg_20_1:RecordAudio("104042005", var_23_9)
						arg_20_1:RecordAudio("104042005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104042", "104042005", "story_v_out_104042.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104042", "104042005", "story_v_out_104042.awb")
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
	Play104042006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104042006
		arg_24_1.duration_ = 3.87

		local var_24_0 = {
			ja = 3.866,
			ko = 3.666,
			zh = 2.966,
			en = 3.333
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
				arg_24_0:Play104042007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.2

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[31].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(104042006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042006", "story_v_out_104042.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_104042", "104042006", "story_v_out_104042.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_104042", "104042006", "story_v_out_104042.awb")

						arg_24_1:RecordAudio("104042006", var_27_9)
						arg_24_1:RecordAudio("104042006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_104042", "104042006", "story_v_out_104042.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_104042", "104042006", "story_v_out_104042.awb")
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
	Play104042007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104042007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play104042008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.775

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_2 = arg_28_1:GetWordFromCfg(104042007)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 31
				local var_31_5 = utf8.len(var_31_3)
				local var_31_6 = var_31_4 <= 0 and var_31_1 or var_31_1 * (var_31_5 / var_31_4)

				if var_31_6 > 0 and var_31_1 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_7 and arg_28_1.time_ < var_31_0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play104042008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104042008
		arg_32_1.duration_ = 3.17

		local var_32_0 = {
			ja = 2.2,
			ko = 2.533,
			zh = 2.233,
			en = 3.166
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
				arg_32_0:Play104042009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.225

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[37].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(104042008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 9
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042008", "story_v_out_104042.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_104042", "104042008", "story_v_out_104042.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_104042", "104042008", "story_v_out_104042.awb")

						arg_32_1:RecordAudio("104042008", var_35_9)
						arg_32_1:RecordAudio("104042008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104042", "104042008", "story_v_out_104042.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104042", "104042008", "story_v_out_104042.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play104042009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104042009
		arg_36_1.duration_ = 2.73

		local var_36_0 = {
			ja = 2.3,
			ko = 2.733,
			zh = 2.6,
			en = 2.566
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
				arg_36_0:Play104042010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.25

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[6].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(104042009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042009", "story_v_out_104042.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_104042", "104042009", "story_v_out_104042.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_104042", "104042009", "story_v_out_104042.awb")

						arg_36_1:RecordAudio("104042009", var_39_9)
						arg_36_1:RecordAudio("104042009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104042", "104042009", "story_v_out_104042.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104042", "104042009", "story_v_out_104042.awb")
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
	Play104042010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104042010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play104042011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 1

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				local var_43_2 = "play"
				local var_43_3 = "effect"

				arg_40_1:AudioAction(var_43_2, var_43_3, "se_story_4", "se_story_4_cutchain", "")
			end

			local var_43_4 = 0
			local var_43_5 = 0.575

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(104042010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_8 = 23
				local var_43_9 = utf8.len(var_43_7)
				local var_43_10 = var_43_8 <= 0 and var_43_5 or var_43_5 * (var_43_9 / var_43_8)

				if var_43_10 > 0 and var_43_5 < var_43_10 then
					arg_40_1.talkMaxDuration = var_43_10

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_11 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_11 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_11

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_11 and arg_40_1.time_ < var_43_4 + var_43_11 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play104042011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104042011
		arg_44_1.duration_ = 3.73

		local var_44_0 = {
			ja = 3.566,
			ko = 3.733,
			zh = 3.666,
			en = 3.3
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
				arg_44_0:Play104042012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1084ui_story"]
			local var_47_1 = 2

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.bgs_.S0403
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				local var_47_6 = var_47_4:GetComponent("SpriteRenderer")

				if var_47_6 then
					arg_44_1.var_.alphaOldValueS0403 = var_47_6.color.a
					arg_44_1.var_.alphaMatValueS0403 = var_47_6
				end

				arg_44_1.var_.alphaOldValueS0403 = 1
			end

			local var_47_7 = 1.5

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_7 then
				local var_47_8 = (arg_44_1.time_ - var_47_5) / var_47_7
				local var_47_9 = Mathf.Lerp(arg_44_1.var_.alphaOldValueS0403, 0, var_47_8)

				if arg_44_1.var_.alphaMatValueS0403 then
					local var_47_10 = arg_44_1.var_.alphaMatValueS0403.color

					var_47_10.a = var_47_9
					arg_44_1.var_.alphaMatValueS0403.color = var_47_10
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_7 and arg_44_1.time_ < var_47_5 + var_47_7 + arg_47_0 and arg_44_1.var_.alphaMatValueS0403 then
				local var_47_11 = arg_44_1.var_.alphaMatValueS0403
				local var_47_12 = var_47_11.color

				var_47_12.a = 0
				var_47_11.color = var_47_12
			end

			local var_47_13 = arg_44_1.bgs_.S0403.transform
			local var_47_14 = 1.5

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1.var_.moveOldPosS0403 = var_47_13.localPosition
			end

			local var_47_15 = 0.001

			if var_47_14 <= arg_44_1.time_ and arg_44_1.time_ < var_47_14 + var_47_15 then
				local var_47_16 = (arg_44_1.time_ - var_47_14) / var_47_15
				local var_47_17 = Vector3.New(0, -100, 10)

				var_47_13.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPosS0403, var_47_17, var_47_16)
			end

			if arg_44_1.time_ >= var_47_14 + var_47_15 and arg_44_1.time_ < var_47_14 + var_47_15 + arg_47_0 then
				var_47_13.localPosition = Vector3.New(0, -100, 10)
			end

			local var_47_18 = "B04b"

			if arg_44_1.bgs_[var_47_18] == nil then
				local var_47_19 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_47_18)
				var_47_19.name = var_47_18
				var_47_19.transform.parent = arg_44_1.stage_.transform
				var_47_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_[var_47_18] = var_47_19
			end

			local var_47_20 = arg_44_1.bgs_.B04b
			local var_47_21 = 1.5

			if var_47_21 < arg_44_1.time_ and arg_44_1.time_ <= var_47_21 + arg_47_0 then
				local var_47_22 = var_47_20:GetComponent("SpriteRenderer")

				if var_47_22 then
					arg_44_1.var_.alphaOldValueB04b = var_47_22.color.a
					arg_44_1.var_.alphaMatValueB04b = var_47_22
				end

				arg_44_1.var_.alphaOldValueB04b = 0
			end

			local var_47_23 = 1.5

			if var_47_21 <= arg_44_1.time_ and arg_44_1.time_ < var_47_21 + var_47_23 then
				local var_47_24 = (arg_44_1.time_ - var_47_21) / var_47_23
				local var_47_25 = Mathf.Lerp(arg_44_1.var_.alphaOldValueB04b, 1, var_47_24)

				if arg_44_1.var_.alphaMatValueB04b then
					local var_47_26 = arg_44_1.var_.alphaMatValueB04b.color

					var_47_26.a = var_47_25
					arg_44_1.var_.alphaMatValueB04b.color = var_47_26
				end
			end

			if arg_44_1.time_ >= var_47_21 + var_47_23 and arg_44_1.time_ < var_47_21 + var_47_23 + arg_47_0 and arg_44_1.var_.alphaMatValueB04b then
				local var_47_27 = arg_44_1.var_.alphaMatValueB04b
				local var_47_28 = var_47_27.color

				var_47_28.a = 1
				var_47_27.color = var_47_28
			end

			local var_47_29 = 1.5

			if var_47_29 < arg_44_1.time_ and arg_44_1.time_ <= var_47_29 + arg_47_0 then
				local var_47_30 = manager.ui.mainCamera.transform.localPosition
				local var_47_31 = Vector3.New(0, 0, 10) + Vector3.New(var_47_30.x, var_47_30.y, 0)
				local var_47_32 = arg_44_1.bgs_.B04b

				var_47_32.transform.localPosition = var_47_31
				var_47_32.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_33 = var_47_32:GetComponent("SpriteRenderer")

				if var_47_33 and var_47_33.sprite then
					local var_47_34 = (var_47_32.transform.localPosition - var_47_30).z
					local var_47_35 = manager.ui.mainCameraCom_
					local var_47_36 = 2 * var_47_34 * Mathf.Tan(var_47_35.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_47_37 = var_47_36 * var_47_35.aspect
					local var_47_38 = var_47_33.sprite.bounds.size.x
					local var_47_39 = var_47_33.sprite.bounds.size.y
					local var_47_40 = var_47_37 / var_47_38
					local var_47_41 = var_47_36 / var_47_39
					local var_47_42 = var_47_41 < var_47_40 and var_47_40 or var_47_41

					var_47_32.transform.localScale = Vector3.New(var_47_42, var_47_42, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "B04b" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_43 = arg_44_1.actors_["1084ui_story"].transform
			local var_47_44 = 1.79999995231628

			if var_47_44 < arg_44_1.time_ and arg_44_1.time_ <= var_47_44 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_43.localPosition
			end

			local var_47_45 = 0.001

			if var_47_44 <= arg_44_1.time_ and arg_44_1.time_ < var_47_44 + var_47_45 then
				local var_47_46 = (arg_44_1.time_ - var_47_44) / var_47_45
				local var_47_47 = Vector3.New(-0.7, -0.97, -6)

				var_47_43.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, var_47_47, var_47_46)

				local var_47_48 = manager.ui.mainCamera.transform.position - var_47_43.position

				var_47_43.forward = Vector3.New(var_47_48.x, var_47_48.y, var_47_48.z)

				local var_47_49 = var_47_43.localEulerAngles

				var_47_49.z = 0
				var_47_49.x = 0
				var_47_43.localEulerAngles = var_47_49
			end

			if arg_44_1.time_ >= var_47_44 + var_47_45 and arg_44_1.time_ < var_47_44 + var_47_45 + arg_47_0 then
				var_47_43.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_47_50 = manager.ui.mainCamera.transform.position - var_47_43.position

				var_47_43.forward = Vector3.New(var_47_50.x, var_47_50.y, var_47_50.z)

				local var_47_51 = var_47_43.localEulerAngles

				var_47_51.z = 0
				var_47_51.x = 0
				var_47_43.localEulerAngles = var_47_51
			end

			local var_47_52 = 0

			if var_47_52 < arg_44_1.time_ and arg_44_1.time_ <= var_47_52 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_47_53 = 0

			if var_47_53 < arg_44_1.time_ and arg_44_1.time_ <= var_47_53 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			local var_47_54 = 2

			if arg_44_1.time_ >= var_47_53 + var_47_54 and arg_44_1.time_ < var_47_53 + var_47_54 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			local var_47_55 = 0

			if var_47_55 < arg_44_1.time_ and arg_44_1.time_ <= var_47_55 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_56 = 2
			local var_47_57 = 0.175

			if var_47_56 < arg_44_1.time_ and arg_44_1.time_ <= var_47_56 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_58 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_58:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_59 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_60 = arg_44_1:GetWordFromCfg(104042011)
				local var_47_61 = arg_44_1:FormatText(var_47_60.content)

				arg_44_1.text_.text = var_47_61

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_62 = 7
				local var_47_63 = utf8.len(var_47_61)
				local var_47_64 = var_47_62 <= 0 and var_47_57 or var_47_57 * (var_47_63 / var_47_62)

				if var_47_64 > 0 and var_47_57 < var_47_64 then
					arg_44_1.talkMaxDuration = var_47_64
					var_47_56 = var_47_56 + 0.3

					if var_47_64 + var_47_56 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_64 + var_47_56
					end
				end

				arg_44_1.text_.text = var_47_61
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042011", "story_v_out_104042.awb") ~= 0 then
					local var_47_65 = manager.audio:GetVoiceLength("story_v_out_104042", "104042011", "story_v_out_104042.awb") / 1000

					if var_47_65 + var_47_56 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_65 + var_47_56
					end

					if var_47_60.prefab_name ~= "" and arg_44_1.actors_[var_47_60.prefab_name] ~= nil then
						local var_47_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_60.prefab_name].transform, "story_v_out_104042", "104042011", "story_v_out_104042.awb")

						arg_44_1:RecordAudio("104042011", var_47_66)
						arg_44_1:RecordAudio("104042011", var_47_66)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_104042", "104042011", "story_v_out_104042.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_104042", "104042011", "story_v_out_104042.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_67 = var_47_56 + 0.3
			local var_47_68 = math.max(var_47_57, arg_44_1.talkMaxDuration)

			if var_47_67 <= arg_44_1.time_ and arg_44_1.time_ < var_47_67 + var_47_68 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_67) / var_47_68

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_67 + var_47_68 and arg_44_1.time_ < var_47_67 + var_47_68 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0403",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play104042012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 104042012
		arg_50_1.duration_ = 11.73

		local var_50_0 = {
			ja = 6.1,
			ko = 9.5,
			zh = 11.733,
			en = 7.366
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
				arg_50_0:Play104042013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = "10001_tpose"

			if arg_50_1.actors_[var_53_0] == nil then
				local var_53_1 = Asset.Load("Char/" .. "10001_tpose")

				if not isNil(var_53_1) then
					local var_53_2 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_50_1.stage_.transform)

					var_53_2.name = var_53_0
					var_53_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_50_1.actors_[var_53_0] = var_53_2

					local var_53_3 = var_53_2:GetComponentInChildren(typeof(CharacterEffect))

					var_53_3.enabled = true

					local var_53_4 = GameObjectTools.GetOrAddComponent(var_53_2, typeof(DynamicBoneHelper))

					if var_53_4 then
						var_53_4:EnableDynamicBone(false)
					end

					arg_50_1:ShowWeapon(var_53_3.transform, false)

					arg_50_1.var_[var_53_0 .. "Animator"] = var_53_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_50_1.var_[var_53_0 .. "Animator"].applyRootMotion = true
					arg_50_1.var_[var_53_0 .. "LipSync"] = var_53_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_53_5 = arg_50_1.actors_["10001_tpose"]
			local var_53_6 = 0

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 and not isNil(var_53_5) and arg_50_1.var_.characterEffect10001_tpose == nil then
				arg_50_1.var_.characterEffect10001_tpose = var_53_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_7 = 0.1

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_7 and not isNil(var_53_5) then
				local var_53_8 = (arg_50_1.time_ - var_53_6) / var_53_7

				if arg_50_1.var_.characterEffect10001_tpose and not isNil(var_53_5) then
					arg_50_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_6 + var_53_7 and arg_50_1.time_ < var_53_6 + var_53_7 + arg_53_0 and not isNil(var_53_5) and arg_50_1.var_.characterEffect10001_tpose then
				arg_50_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_53_9 = arg_50_1.actors_["1084ui_story"]
			local var_53_10 = 0

			if var_53_10 < arg_50_1.time_ and arg_50_1.time_ <= var_53_10 + arg_53_0 and not isNil(var_53_9) and arg_50_1.var_.characterEffect1084ui_story == nil then
				arg_50_1.var_.characterEffect1084ui_story = var_53_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_11 = 0.1

			if var_53_10 <= arg_50_1.time_ and arg_50_1.time_ < var_53_10 + var_53_11 and not isNil(var_53_9) then
				local var_53_12 = (arg_50_1.time_ - var_53_10) / var_53_11

				if arg_50_1.var_.characterEffect1084ui_story and not isNil(var_53_9) then
					local var_53_13 = Mathf.Lerp(0, 0.5, var_53_12)

					arg_50_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1084ui_story.fillRatio = var_53_13
				end
			end

			if arg_50_1.time_ >= var_53_10 + var_53_11 and arg_50_1.time_ < var_53_10 + var_53_11 + arg_53_0 and not isNil(var_53_9) and arg_50_1.var_.characterEffect1084ui_story then
				local var_53_14 = 0.5

				arg_50_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1084ui_story.fillRatio = var_53_14
			end

			local var_53_15 = arg_50_1.actors_["10001_tpose"].transform
			local var_53_16 = 0

			if var_53_16 < arg_50_1.time_ and arg_50_1.time_ <= var_53_16 + arg_53_0 then
				arg_50_1.var_.moveOldPos10001_tpose = var_53_15.localPosition

				local var_53_17 = GameObjectTools.GetOrAddComponent(var_53_15.gameObject, typeof(DynamicBoneHelper))

				if var_53_17 then
					var_53_17:EnableDynamicBone(false)
				end
			end

			local var_53_18 = 0.001

			if var_53_16 <= arg_50_1.time_ and arg_50_1.time_ < var_53_16 + var_53_18 then
				local var_53_19 = (arg_50_1.time_ - var_53_16) / var_53_18
				local var_53_20 = Vector3.New(0.7, -1.23, -5.8)

				var_53_15.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10001_tpose, var_53_20, var_53_19)

				local var_53_21 = manager.ui.mainCamera.transform.position - var_53_15.position

				var_53_15.forward = Vector3.New(var_53_21.x, var_53_21.y, var_53_21.z)

				local var_53_22 = var_53_15.localEulerAngles

				var_53_22.z = 0
				var_53_22.x = 0
				var_53_15.localEulerAngles = var_53_22
			end

			if arg_50_1.time_ >= var_53_16 + var_53_18 and arg_50_1.time_ < var_53_16 + var_53_18 + arg_53_0 then
				var_53_15.localPosition = Vector3.New(0.7, -1.23, -5.8)

				local var_53_23 = manager.ui.mainCamera.transform.position - var_53_15.position

				var_53_15.forward = Vector3.New(var_53_23.x, var_53_23.y, var_53_23.z)

				local var_53_24 = var_53_15.localEulerAngles

				var_53_24.z = 0
				var_53_24.x = 0
				var_53_15.localEulerAngles = var_53_24

				local var_53_25 = GameObjectTools.GetOrAddComponent(var_53_15.gameObject, typeof(DynamicBoneHelper))

				if var_53_25 then
					var_53_25:EnableDynamicBone(true)
				end
			end

			local var_53_26 = 0

			if var_53_26 < arg_50_1.time_ and arg_50_1.time_ <= var_53_26 + arg_53_0 then
				arg_50_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			local var_53_27 = 0

			if var_53_27 < arg_50_1.time_ and arg_50_1.time_ <= var_53_27 + arg_53_0 then
				arg_50_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_53_28 = 0
			local var_53_29 = 0.6

			if var_53_28 < arg_50_1.time_ and arg_50_1.time_ <= var_53_28 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_30 = arg_50_1:FormatText(StoryNameCfg[31].name)

				arg_50_1.leftNameTxt_.text = var_53_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_31 = arg_50_1:GetWordFromCfg(104042012)
				local var_53_32 = arg_50_1:FormatText(var_53_31.content)

				arg_50_1.text_.text = var_53_32

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_33 = 23
				local var_53_34 = utf8.len(var_53_32)
				local var_53_35 = var_53_33 <= 0 and var_53_29 or var_53_29 * (var_53_34 / var_53_33)

				if var_53_35 > 0 and var_53_29 < var_53_35 then
					arg_50_1.talkMaxDuration = var_53_35

					if var_53_35 + var_53_28 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_35 + var_53_28
					end
				end

				arg_50_1.text_.text = var_53_32
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042012", "story_v_out_104042.awb") ~= 0 then
					local var_53_36 = manager.audio:GetVoiceLength("story_v_out_104042", "104042012", "story_v_out_104042.awb") / 1000

					if var_53_36 + var_53_28 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_36 + var_53_28
					end

					if var_53_31.prefab_name ~= "" and arg_50_1.actors_[var_53_31.prefab_name] ~= nil then
						local var_53_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_31.prefab_name].transform, "story_v_out_104042", "104042012", "story_v_out_104042.awb")

						arg_50_1:RecordAudio("104042012", var_53_37)
						arg_50_1:RecordAudio("104042012", var_53_37)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_104042", "104042012", "story_v_out_104042.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_104042", "104042012", "story_v_out_104042.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_38 = math.max(var_53_29, arg_50_1.talkMaxDuration)

			if var_53_28 <= arg_50_1.time_ and arg_50_1.time_ < var_53_28 + var_53_38 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_28) / var_53_38

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_28 + var_53_38 and arg_50_1.time_ < var_53_28 + var_53_38 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play104042013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 104042013
		arg_54_1.duration_ = 5.1

		local var_54_0 = {
			ja = 4.033,
			ko = 3.833,
			zh = 5.1,
			en = 2.7
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play104042014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_2")
			end

			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_57_2 = 0
			local var_57_3 = 0.325

			if var_57_2 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_4 = arg_54_1:FormatText(StoryNameCfg[31].name)

				arg_54_1.leftNameTxt_.text = var_57_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_5 = arg_54_1:GetWordFromCfg(104042013)
				local var_57_6 = arg_54_1:FormatText(var_57_5.content)

				arg_54_1.text_.text = var_57_6

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_7 = 11
				local var_57_8 = utf8.len(var_57_6)
				local var_57_9 = var_57_7 <= 0 and var_57_3 or var_57_3 * (var_57_8 / var_57_7)

				if var_57_9 > 0 and var_57_3 < var_57_9 then
					arg_54_1.talkMaxDuration = var_57_9

					if var_57_9 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_9 + var_57_2
					end
				end

				arg_54_1.text_.text = var_57_6
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042013", "story_v_out_104042.awb") ~= 0 then
					local var_57_10 = manager.audio:GetVoiceLength("story_v_out_104042", "104042013", "story_v_out_104042.awb") / 1000

					if var_57_10 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_2
					end

					if var_57_5.prefab_name ~= "" and arg_54_1.actors_[var_57_5.prefab_name] ~= nil then
						local var_57_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_5.prefab_name].transform, "story_v_out_104042", "104042013", "story_v_out_104042.awb")

						arg_54_1:RecordAudio("104042013", var_57_11)
						arg_54_1:RecordAudio("104042013", var_57_11)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_104042", "104042013", "story_v_out_104042.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_104042", "104042013", "story_v_out_104042.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_12 = math.max(var_57_3, arg_54_1.talkMaxDuration)

			if var_57_2 <= arg_54_1.time_ and arg_54_1.time_ < var_57_2 + var_57_12 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_2) / var_57_12

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_2 + var_57_12 and arg_54_1.time_ < var_57_2 + var_57_12 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play104042014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 104042014
		arg_58_1.duration_ = 2.67

		local var_58_0 = {
			ja = 2.666,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play104042015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = "1036ui_story"

			if arg_58_1.actors_[var_61_0] == nil then
				local var_61_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_61_1) then
					local var_61_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_58_1.stage_.transform)

					var_61_2.name = var_61_0
					var_61_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_58_1.actors_[var_61_0] = var_61_2

					local var_61_3 = var_61_2:GetComponentInChildren(typeof(CharacterEffect))

					var_61_3.enabled = true

					local var_61_4 = GameObjectTools.GetOrAddComponent(var_61_2, typeof(DynamicBoneHelper))

					if var_61_4 then
						var_61_4:EnableDynamicBone(false)
					end

					arg_58_1:ShowWeapon(var_61_3.transform, false)

					arg_58_1.var_[var_61_0 .. "Animator"] = var_61_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_58_1.var_[var_61_0 .. "Animator"].applyRootMotion = true
					arg_58_1.var_[var_61_0 .. "LipSync"] = var_61_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_61_5 = arg_58_1.actors_["1036ui_story"]
			local var_61_6 = 0

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 and not isNil(var_61_5) and arg_58_1.var_.characterEffect1036ui_story == nil then
				arg_58_1.var_.characterEffect1036ui_story = var_61_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_7 = 0.1

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_7 and not isNil(var_61_5) then
				local var_61_8 = (arg_58_1.time_ - var_61_6) / var_61_7

				if arg_58_1.var_.characterEffect1036ui_story and not isNil(var_61_5) then
					arg_58_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_6 + var_61_7 and arg_58_1.time_ < var_61_6 + var_61_7 + arg_61_0 and not isNil(var_61_5) and arg_58_1.var_.characterEffect1036ui_story then
				arg_58_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_61_9 = arg_58_1.actors_["10001_tpose"]
			local var_61_10 = 0

			if var_61_10 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 and not isNil(var_61_9) and arg_58_1.var_.characterEffect10001_tpose == nil then
				arg_58_1.var_.characterEffect10001_tpose = var_61_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_11 = 0.1

			if var_61_10 <= arg_58_1.time_ and arg_58_1.time_ < var_61_10 + var_61_11 and not isNil(var_61_9) then
				local var_61_12 = (arg_58_1.time_ - var_61_10) / var_61_11

				if arg_58_1.var_.characterEffect10001_tpose and not isNil(var_61_9) then
					local var_61_13 = Mathf.Lerp(0, 0.5, var_61_12)

					arg_58_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_58_1.var_.characterEffect10001_tpose.fillRatio = var_61_13
				end
			end

			if arg_58_1.time_ >= var_61_10 + var_61_11 and arg_58_1.time_ < var_61_10 + var_61_11 + arg_61_0 and not isNil(var_61_9) and arg_58_1.var_.characterEffect10001_tpose then
				local var_61_14 = 0.5

				arg_58_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_58_1.var_.characterEffect10001_tpose.fillRatio = var_61_14
			end

			local var_61_15 = arg_58_1.actors_["1084ui_story"].transform
			local var_61_16 = 0

			if var_61_16 < arg_58_1.time_ and arg_58_1.time_ <= var_61_16 + arg_61_0 then
				arg_58_1.var_.moveOldPos1084ui_story = var_61_15.localPosition
			end

			local var_61_17 = 0.001

			if var_61_16 <= arg_58_1.time_ and arg_58_1.time_ < var_61_16 + var_61_17 then
				local var_61_18 = (arg_58_1.time_ - var_61_16) / var_61_17
				local var_61_19 = Vector3.New(0, 100, 0)

				var_61_15.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1084ui_story, var_61_19, var_61_18)

				local var_61_20 = manager.ui.mainCamera.transform.position - var_61_15.position

				var_61_15.forward = Vector3.New(var_61_20.x, var_61_20.y, var_61_20.z)

				local var_61_21 = var_61_15.localEulerAngles

				var_61_21.z = 0
				var_61_21.x = 0
				var_61_15.localEulerAngles = var_61_21
			end

			if arg_58_1.time_ >= var_61_16 + var_61_17 and arg_58_1.time_ < var_61_16 + var_61_17 + arg_61_0 then
				var_61_15.localPosition = Vector3.New(0, 100, 0)

				local var_61_22 = manager.ui.mainCamera.transform.position - var_61_15.position

				var_61_15.forward = Vector3.New(var_61_22.x, var_61_22.y, var_61_22.z)

				local var_61_23 = var_61_15.localEulerAngles

				var_61_23.z = 0
				var_61_23.x = 0
				var_61_15.localEulerAngles = var_61_23
			end

			local var_61_24 = arg_58_1.actors_["1036ui_story"].transform
			local var_61_25 = 0

			if var_61_25 < arg_58_1.time_ and arg_58_1.time_ <= var_61_25 + arg_61_0 then
				arg_58_1.var_.moveOldPos1036ui_story = var_61_24.localPosition
			end

			local var_61_26 = 0.001

			if var_61_25 <= arg_58_1.time_ and arg_58_1.time_ < var_61_25 + var_61_26 then
				local var_61_27 = (arg_58_1.time_ - var_61_25) / var_61_26
				local var_61_28 = Vector3.New(-0.7, -1.09, -5.78)

				var_61_24.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1036ui_story, var_61_28, var_61_27)

				local var_61_29 = manager.ui.mainCamera.transform.position - var_61_24.position

				var_61_24.forward = Vector3.New(var_61_29.x, var_61_29.y, var_61_29.z)

				local var_61_30 = var_61_24.localEulerAngles

				var_61_30.z = 0
				var_61_30.x = 0
				var_61_24.localEulerAngles = var_61_30
			end

			if arg_58_1.time_ >= var_61_25 + var_61_26 and arg_58_1.time_ < var_61_25 + var_61_26 + arg_61_0 then
				var_61_24.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_61_31 = manager.ui.mainCamera.transform.position - var_61_24.position

				var_61_24.forward = Vector3.New(var_61_31.x, var_61_31.y, var_61_31.z)

				local var_61_32 = var_61_24.localEulerAngles

				var_61_32.z = 0
				var_61_32.x = 0
				var_61_24.localEulerAngles = var_61_32
			end

			local var_61_33 = 0

			if var_61_33 < arg_58_1.time_ and arg_58_1.time_ <= var_61_33 + arg_61_0 then
				arg_58_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			local var_61_34 = 0

			if var_61_34 < arg_58_1.time_ and arg_58_1.time_ <= var_61_34 + arg_61_0 then
				arg_58_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_61_35 = 0
			local var_61_36 = 0.225

			if var_61_35 < arg_58_1.time_ and arg_58_1.time_ <= var_61_35 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_37 = arg_58_1:FormatText(StoryNameCfg[5].name)

				arg_58_1.leftNameTxt_.text = var_61_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_38 = arg_58_1:GetWordFromCfg(104042014)
				local var_61_39 = arg_58_1:FormatText(var_61_38.content)

				arg_58_1.text_.text = var_61_39

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_40 = 9
				local var_61_41 = utf8.len(var_61_39)
				local var_61_42 = var_61_40 <= 0 and var_61_36 or var_61_36 * (var_61_41 / var_61_40)

				if var_61_42 > 0 and var_61_36 < var_61_42 then
					arg_58_1.talkMaxDuration = var_61_42

					if var_61_42 + var_61_35 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_42 + var_61_35
					end
				end

				arg_58_1.text_.text = var_61_39
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042014", "story_v_out_104042.awb") ~= 0 then
					local var_61_43 = manager.audio:GetVoiceLength("story_v_out_104042", "104042014", "story_v_out_104042.awb") / 1000

					if var_61_43 + var_61_35 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_43 + var_61_35
					end

					if var_61_38.prefab_name ~= "" and arg_58_1.actors_[var_61_38.prefab_name] ~= nil then
						local var_61_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_38.prefab_name].transform, "story_v_out_104042", "104042014", "story_v_out_104042.awb")

						arg_58_1:RecordAudio("104042014", var_61_44)
						arg_58_1:RecordAudio("104042014", var_61_44)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_104042", "104042014", "story_v_out_104042.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_104042", "104042014", "story_v_out_104042.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_45 = math.max(var_61_36, arg_58_1.talkMaxDuration)

			if var_61_35 <= arg_58_1.time_ and arg_58_1.time_ < var_61_35 + var_61_45 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_35) / var_61_45

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_35 + var_61_45 and arg_58_1.time_ < var_61_35 + var_61_45 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play104042015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 104042015
		arg_62_1.duration_ = 3.93

		local var_62_0 = {
			ja = 3.933,
			ko = 2.933,
			zh = 2.533,
			en = 2.766
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
				arg_62_0:Play104042016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1019ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1019ui_story == nil then
				arg_62_1.var_.characterEffect1019ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.1

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1019ui_story and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1019ui_story then
				arg_62_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_65_4 = arg_62_1.actors_["1036ui_story"]
			local var_65_5 = 0

			if var_65_5 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect1036ui_story == nil then
				arg_62_1.var_.characterEffect1036ui_story = var_65_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_6 = 0.1

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_6 and not isNil(var_65_4) then
				local var_65_7 = (arg_62_1.time_ - var_65_5) / var_65_6

				if arg_62_1.var_.characterEffect1036ui_story and not isNil(var_65_4) then
					local var_65_8 = Mathf.Lerp(0, 0.5, var_65_7)

					arg_62_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1036ui_story.fillRatio = var_65_8
				end
			end

			if arg_62_1.time_ >= var_65_5 + var_65_6 and arg_62_1.time_ < var_65_5 + var_65_6 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect1036ui_story then
				local var_65_9 = 0.5

				arg_62_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1036ui_story.fillRatio = var_65_9
			end

			local var_65_10 = arg_62_1.actors_["1036ui_story"].transform
			local var_65_11 = 0

			if var_65_11 < arg_62_1.time_ and arg_62_1.time_ <= var_65_11 + arg_65_0 then
				arg_62_1.var_.moveOldPos1036ui_story = var_65_10.localPosition
			end

			local var_65_12 = 0.001

			if var_65_11 <= arg_62_1.time_ and arg_62_1.time_ < var_65_11 + var_65_12 then
				local var_65_13 = (arg_62_1.time_ - var_65_11) / var_65_12
				local var_65_14 = Vector3.New(0, 100, 0)

				var_65_10.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1036ui_story, var_65_14, var_65_13)

				local var_65_15 = manager.ui.mainCamera.transform.position - var_65_10.position

				var_65_10.forward = Vector3.New(var_65_15.x, var_65_15.y, var_65_15.z)

				local var_65_16 = var_65_10.localEulerAngles

				var_65_16.z = 0
				var_65_16.x = 0
				var_65_10.localEulerAngles = var_65_16
			end

			if arg_62_1.time_ >= var_65_11 + var_65_12 and arg_62_1.time_ < var_65_11 + var_65_12 + arg_65_0 then
				var_65_10.localPosition = Vector3.New(0, 100, 0)

				local var_65_17 = manager.ui.mainCamera.transform.position - var_65_10.position

				var_65_10.forward = Vector3.New(var_65_17.x, var_65_17.y, var_65_17.z)

				local var_65_18 = var_65_10.localEulerAngles

				var_65_18.z = 0
				var_65_18.x = 0
				var_65_10.localEulerAngles = var_65_18
			end

			local var_65_19 = arg_62_1.actors_["1019ui_story"].transform
			local var_65_20 = 0

			if var_65_20 < arg_62_1.time_ and arg_62_1.time_ <= var_65_20 + arg_65_0 then
				arg_62_1.var_.moveOldPos1019ui_story = var_65_19.localPosition
			end

			local var_65_21 = 0.001

			if var_65_20 <= arg_62_1.time_ and arg_62_1.time_ < var_65_20 + var_65_21 then
				local var_65_22 = (arg_62_1.time_ - var_65_20) / var_65_21
				local var_65_23 = Vector3.New(-0.7, -1.08, -5.9)

				var_65_19.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1019ui_story, var_65_23, var_65_22)

				local var_65_24 = manager.ui.mainCamera.transform.position - var_65_19.position

				var_65_19.forward = Vector3.New(var_65_24.x, var_65_24.y, var_65_24.z)

				local var_65_25 = var_65_19.localEulerAngles

				var_65_25.z = 0
				var_65_25.x = 0
				var_65_19.localEulerAngles = var_65_25
			end

			if arg_62_1.time_ >= var_65_20 + var_65_21 and arg_62_1.time_ < var_65_20 + var_65_21 + arg_65_0 then
				var_65_19.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_65_26 = manager.ui.mainCamera.transform.position - var_65_19.position

				var_65_19.forward = Vector3.New(var_65_26.x, var_65_26.y, var_65_26.z)

				local var_65_27 = var_65_19.localEulerAngles

				var_65_27.z = 0
				var_65_27.x = 0
				var_65_19.localEulerAngles = var_65_27
			end

			local var_65_28 = 0

			if var_65_28 < arg_62_1.time_ and arg_62_1.time_ <= var_65_28 + arg_65_0 then
				arg_62_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_65_29 = 0

			if var_65_29 < arg_62_1.time_ and arg_62_1.time_ <= var_65_29 + arg_65_0 then
				arg_62_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_65_30 = 0
			local var_65_31 = 0.325

			if var_65_30 < arg_62_1.time_ and arg_62_1.time_ <= var_65_30 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_32 = arg_62_1:FormatText(StoryNameCfg[13].name)

				arg_62_1.leftNameTxt_.text = var_65_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_33 = arg_62_1:GetWordFromCfg(104042015)
				local var_65_34 = arg_62_1:FormatText(var_65_33.content)

				arg_62_1.text_.text = var_65_34

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_35 = 13
				local var_65_36 = utf8.len(var_65_34)
				local var_65_37 = var_65_35 <= 0 and var_65_31 or var_65_31 * (var_65_36 / var_65_35)

				if var_65_37 > 0 and var_65_31 < var_65_37 then
					arg_62_1.talkMaxDuration = var_65_37

					if var_65_37 + var_65_30 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_37 + var_65_30
					end
				end

				arg_62_1.text_.text = var_65_34
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042015", "story_v_out_104042.awb") ~= 0 then
					local var_65_38 = manager.audio:GetVoiceLength("story_v_out_104042", "104042015", "story_v_out_104042.awb") / 1000

					if var_65_38 + var_65_30 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_38 + var_65_30
					end

					if var_65_33.prefab_name ~= "" and arg_62_1.actors_[var_65_33.prefab_name] ~= nil then
						local var_65_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_33.prefab_name].transform, "story_v_out_104042", "104042015", "story_v_out_104042.awb")

						arg_62_1:RecordAudio("104042015", var_65_39)
						arg_62_1:RecordAudio("104042015", var_65_39)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_104042", "104042015", "story_v_out_104042.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_104042", "104042015", "story_v_out_104042.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_40 = math.max(var_65_31, arg_62_1.talkMaxDuration)

			if var_65_30 <= arg_62_1.time_ and arg_62_1.time_ < var_65_30 + var_65_40 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_30) / var_65_40

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_30 + var_65_40 and arg_62_1.time_ < var_65_30 + var_65_40 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play104042016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 104042016
		arg_66_1.duration_ = 5.67

		local var_66_0 = {
			ja = 3.866,
			ko = 3.633,
			zh = 5.666,
			en = 4.2
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
				arg_66_0:Play104042017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10001_tpose"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10001_tpose == nil then
				arg_66_1.var_.characterEffect10001_tpose = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.1

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect10001_tpose and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect10001_tpose then
				arg_66_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_69_4 = arg_66_1.actors_["1019ui_story"]
			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect1019ui_story == nil then
				arg_66_1.var_.characterEffect1019ui_story = var_69_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_6 = 0.1

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_6 and not isNil(var_69_4) then
				local var_69_7 = (arg_66_1.time_ - var_69_5) / var_69_6

				if arg_66_1.var_.characterEffect1019ui_story and not isNil(var_69_4) then
					local var_69_8 = Mathf.Lerp(0, 0.5, var_69_7)

					arg_66_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1019ui_story.fillRatio = var_69_8
				end
			end

			if arg_66_1.time_ >= var_69_5 + var_69_6 and arg_66_1.time_ < var_69_5 + var_69_6 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect1019ui_story then
				local var_69_9 = 0.5

				arg_66_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1019ui_story.fillRatio = var_69_9
			end

			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			local var_69_11 = 0

			if var_69_11 < arg_66_1.time_ and arg_66_1.time_ <= var_69_11 + arg_69_0 then
				arg_66_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_69_12 = 0
			local var_69_13 = 0.4

			if var_69_12 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_14 = arg_66_1:FormatText(StoryNameCfg[31].name)

				arg_66_1.leftNameTxt_.text = var_69_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_15 = arg_66_1:GetWordFromCfg(104042016)
				local var_69_16 = arg_66_1:FormatText(var_69_15.content)

				arg_66_1.text_.text = var_69_16

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_17 = 16
				local var_69_18 = utf8.len(var_69_16)
				local var_69_19 = var_69_17 <= 0 and var_69_13 or var_69_13 * (var_69_18 / var_69_17)

				if var_69_19 > 0 and var_69_13 < var_69_19 then
					arg_66_1.talkMaxDuration = var_69_19

					if var_69_19 + var_69_12 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_19 + var_69_12
					end
				end

				arg_66_1.text_.text = var_69_16
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042016", "story_v_out_104042.awb") ~= 0 then
					local var_69_20 = manager.audio:GetVoiceLength("story_v_out_104042", "104042016", "story_v_out_104042.awb") / 1000

					if var_69_20 + var_69_12 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_20 + var_69_12
					end

					if var_69_15.prefab_name ~= "" and arg_66_1.actors_[var_69_15.prefab_name] ~= nil then
						local var_69_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_15.prefab_name].transform, "story_v_out_104042", "104042016", "story_v_out_104042.awb")

						arg_66_1:RecordAudio("104042016", var_69_21)
						arg_66_1:RecordAudio("104042016", var_69_21)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_104042", "104042016", "story_v_out_104042.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_104042", "104042016", "story_v_out_104042.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_22 = math.max(var_69_13, arg_66_1.talkMaxDuration)

			if var_69_12 <= arg_66_1.time_ and arg_66_1.time_ < var_69_12 + var_69_22 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_12) / var_69_22

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_12 + var_69_22 and arg_66_1.time_ < var_69_12 + var_69_22 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play104042017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 104042017
		arg_70_1.duration_ = 2.37

		local var_70_0 = {
			ja = 2.366,
			ko = 1.633,
			zh = 2,
			en = 1.9
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
				arg_70_0:Play104042018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10001_tpose"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10001_tpose == nil then
				arg_70_1.var_.characterEffect10001_tpose = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.1

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect10001_tpose and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_70_1.var_.characterEffect10001_tpose.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10001_tpose then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_70_1.var_.characterEffect10001_tpose.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 0.2

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_8 = arg_70_1:FormatText(StoryNameCfg[5].name)

				arg_70_1.leftNameTxt_.text = var_73_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_9 = arg_70_1:GetWordFromCfg(104042017)
				local var_73_10 = arg_70_1:FormatText(var_73_9.content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 8
				local var_73_12 = utf8.len(var_73_10)
				local var_73_13 = var_73_11 <= 0 and var_73_7 or var_73_7 * (var_73_12 / var_73_11)

				if var_73_13 > 0 and var_73_7 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_10
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042017", "story_v_out_104042.awb") ~= 0 then
					local var_73_14 = manager.audio:GetVoiceLength("story_v_out_104042", "104042017", "story_v_out_104042.awb") / 1000

					if var_73_14 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_14 + var_73_6
					end

					if var_73_9.prefab_name ~= "" and arg_70_1.actors_[var_73_9.prefab_name] ~= nil then
						local var_73_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_9.prefab_name].transform, "story_v_out_104042", "104042017", "story_v_out_104042.awb")

						arg_70_1:RecordAudio("104042017", var_73_15)
						arg_70_1:RecordAudio("104042017", var_73_15)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_104042", "104042017", "story_v_out_104042.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_104042", "104042017", "story_v_out_104042.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_16 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_16 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_16

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_16 and arg_70_1.time_ < var_73_6 + var_73_16 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play104042018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 104042018
		arg_74_1.duration_ = 7.17

		local var_74_0 = {
			ja = 4.7,
			ko = 5.766,
			zh = 7.166,
			en = 5.5
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play104042019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["10001_tpose"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect10001_tpose == nil then
				arg_74_1.var_.characterEffect10001_tpose = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.1

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect10001_tpose and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect10001_tpose then
				arg_74_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_77_4 = 0

			if var_77_4 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action445")
			end

			local var_77_5 = 0

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 then
				arg_74_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_77_6 = 0
			local var_77_7 = 0.75

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_8 = arg_74_1:FormatText(StoryNameCfg[31].name)

				arg_74_1.leftNameTxt_.text = var_77_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_9 = arg_74_1:GetWordFromCfg(104042018)
				local var_77_10 = arg_74_1:FormatText(var_77_9.content)

				arg_74_1.text_.text = var_77_10

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_11 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042018", "story_v_out_104042.awb") ~= 0 then
					local var_77_14 = manager.audio:GetVoiceLength("story_v_out_104042", "104042018", "story_v_out_104042.awb") / 1000

					if var_77_14 + var_77_6 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_14 + var_77_6
					end

					if var_77_9.prefab_name ~= "" and arg_74_1.actors_[var_77_9.prefab_name] ~= nil then
						local var_77_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_9.prefab_name].transform, "story_v_out_104042", "104042018", "story_v_out_104042.awb")

						arg_74_1:RecordAudio("104042018", var_77_15)
						arg_74_1:RecordAudio("104042018", var_77_15)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_104042", "104042018", "story_v_out_104042.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_104042", "104042018", "story_v_out_104042.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_16 = math.max(var_77_7, arg_74_1.talkMaxDuration)

			if var_77_6 <= arg_74_1.time_ and arg_74_1.time_ < var_77_6 + var_77_16 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_6) / var_77_16

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_6 + var_77_16 and arg_74_1.time_ < var_77_6 + var_77_16 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play104042019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 104042019
		arg_78_1.duration_ = 6.47

		local var_78_0 = {
			ja = 6.466,
			ko = 3.8,
			zh = 4.166,
			en = 4.166
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
				arg_78_0:Play104042020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1019ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1019ui_story == nil then
				arg_78_1.var_.characterEffect1019ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.1

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1019ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1019ui_story then
				arg_78_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_81_4 = arg_78_1.actors_["10001_tpose"]
			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect10001_tpose == nil then
				arg_78_1.var_.characterEffect10001_tpose = var_81_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_6 = 0.1

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_6 and not isNil(var_81_4) then
				local var_81_7 = (arg_78_1.time_ - var_81_5) / var_81_6

				if arg_78_1.var_.characterEffect10001_tpose and not isNil(var_81_4) then
					local var_81_8 = Mathf.Lerp(0, 0.5, var_81_7)

					arg_78_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_78_1.var_.characterEffect10001_tpose.fillRatio = var_81_8
				end
			end

			if arg_78_1.time_ >= var_81_5 + var_81_6 and arg_78_1.time_ < var_81_5 + var_81_6 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect10001_tpose then
				local var_81_9 = 0.5

				arg_78_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_78_1.var_.characterEffect10001_tpose.fillRatio = var_81_9
			end

			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_81_11 = 0

			if var_81_11 < arg_78_1.time_ and arg_78_1.time_ <= var_81_11 + arg_81_0 then
				arg_78_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_81_12 = 0
			local var_81_13 = 0.625

			if var_81_12 < arg_78_1.time_ and arg_78_1.time_ <= var_81_12 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_14 = arg_78_1:FormatText(StoryNameCfg[13].name)

				arg_78_1.leftNameTxt_.text = var_81_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_15 = arg_78_1:GetWordFromCfg(104042019)
				local var_81_16 = arg_78_1:FormatText(var_81_15.content)

				arg_78_1.text_.text = var_81_16

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_17 = 25
				local var_81_18 = utf8.len(var_81_16)
				local var_81_19 = var_81_17 <= 0 and var_81_13 or var_81_13 * (var_81_18 / var_81_17)

				if var_81_19 > 0 and var_81_13 < var_81_19 then
					arg_78_1.talkMaxDuration = var_81_19

					if var_81_19 + var_81_12 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_19 + var_81_12
					end
				end

				arg_78_1.text_.text = var_81_16
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042019", "story_v_out_104042.awb") ~= 0 then
					local var_81_20 = manager.audio:GetVoiceLength("story_v_out_104042", "104042019", "story_v_out_104042.awb") / 1000

					if var_81_20 + var_81_12 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_20 + var_81_12
					end

					if var_81_15.prefab_name ~= "" and arg_78_1.actors_[var_81_15.prefab_name] ~= nil then
						local var_81_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_15.prefab_name].transform, "story_v_out_104042", "104042019", "story_v_out_104042.awb")

						arg_78_1:RecordAudio("104042019", var_81_21)
						arg_78_1:RecordAudio("104042019", var_81_21)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_104042", "104042019", "story_v_out_104042.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_104042", "104042019", "story_v_out_104042.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_22 = math.max(var_81_13, arg_78_1.talkMaxDuration)

			if var_81_12 <= arg_78_1.time_ and arg_78_1.time_ < var_81_12 + var_81_22 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_12) / var_81_22

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_12 + var_81_22 and arg_78_1.time_ < var_81_12 + var_81_22 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play104042020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 104042020
		arg_82_1.duration_ = 5.07

		local var_82_0 = {
			ja = 5.066,
			ko = 2.733,
			zh = 3.7,
			en = 2.4
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play104042021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10001_tpose"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10001_tpose == nil then
				arg_82_1.var_.characterEffect10001_tpose = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.1

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect10001_tpose and not isNil(var_85_0) then
					arg_82_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10001_tpose then
				arg_82_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_85_4 = arg_82_1.actors_["1019ui_story"]
			local var_85_5 = 0

			if var_85_5 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect1019ui_story == nil then
				arg_82_1.var_.characterEffect1019ui_story = var_85_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_6 = 0.1

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_6 and not isNil(var_85_4) then
				local var_85_7 = (arg_82_1.time_ - var_85_5) / var_85_6

				if arg_82_1.var_.characterEffect1019ui_story and not isNil(var_85_4) then
					local var_85_8 = Mathf.Lerp(0, 0.5, var_85_7)

					arg_82_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1019ui_story.fillRatio = var_85_8
				end
			end

			if arg_82_1.time_ >= var_85_5 + var_85_6 and arg_82_1.time_ < var_85_5 + var_85_6 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect1019ui_story then
				local var_85_9 = 0.5

				arg_82_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1019ui_story.fillRatio = var_85_9
			end

			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action5_2")
			end

			local var_85_11 = 0

			if var_85_11 < arg_82_1.time_ and arg_82_1.time_ <= var_85_11 + arg_85_0 then
				arg_82_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_85_12 = 0
			local var_85_13 = 0.25

			if var_85_12 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_14 = arg_82_1:FormatText(StoryNameCfg[31].name)

				arg_82_1.leftNameTxt_.text = var_85_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_15 = arg_82_1:GetWordFromCfg(104042020)
				local var_85_16 = arg_82_1:FormatText(var_85_15.content)

				arg_82_1.text_.text = var_85_16

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_17 = 10
				local var_85_18 = utf8.len(var_85_16)
				local var_85_19 = var_85_17 <= 0 and var_85_13 or var_85_13 * (var_85_18 / var_85_17)

				if var_85_19 > 0 and var_85_13 < var_85_19 then
					arg_82_1.talkMaxDuration = var_85_19

					if var_85_19 + var_85_12 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_19 + var_85_12
					end
				end

				arg_82_1.text_.text = var_85_16
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042020", "story_v_out_104042.awb") ~= 0 then
					local var_85_20 = manager.audio:GetVoiceLength("story_v_out_104042", "104042020", "story_v_out_104042.awb") / 1000

					if var_85_20 + var_85_12 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_20 + var_85_12
					end

					if var_85_15.prefab_name ~= "" and arg_82_1.actors_[var_85_15.prefab_name] ~= nil then
						local var_85_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_15.prefab_name].transform, "story_v_out_104042", "104042020", "story_v_out_104042.awb")

						arg_82_1:RecordAudio("104042020", var_85_21)
						arg_82_1:RecordAudio("104042020", var_85_21)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_104042", "104042020", "story_v_out_104042.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_104042", "104042020", "story_v_out_104042.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_22 = math.max(var_85_13, arg_82_1.talkMaxDuration)

			if var_85_12 <= arg_82_1.time_ and arg_82_1.time_ < var_85_12 + var_85_22 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_12) / var_85_22

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_12 + var_85_22 and arg_82_1.time_ < var_85_12 + var_85_22 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play104042021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 104042021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play104042022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10001_tpose"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10001_tpose == nil then
				arg_86_1.var_.characterEffect10001_tpose = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.1

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect10001_tpose and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_86_1.var_.characterEffect10001_tpose.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10001_tpose then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_86_1.var_.characterEffect10001_tpose.fillRatio = var_89_5
			end

			local var_89_6 = arg_86_1.actors_["10001_tpose"].transform
			local var_89_7 = 0

			if var_89_7 < arg_86_1.time_ and arg_86_1.time_ <= var_89_7 + arg_89_0 then
				arg_86_1.var_.moveOldPos10001_tpose = var_89_6.localPosition

				local var_89_8 = GameObjectTools.GetOrAddComponent(var_89_6.gameObject, typeof(DynamicBoneHelper))

				if var_89_8 then
					var_89_8:EnableDynamicBone(false)
				end
			end

			local var_89_9 = 0.001

			if var_89_7 <= arg_86_1.time_ and arg_86_1.time_ < var_89_7 + var_89_9 then
				local var_89_10 = (arg_86_1.time_ - var_89_7) / var_89_9
				local var_89_11 = Vector3.New(0, 100, 0)

				var_89_6.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10001_tpose, var_89_11, var_89_10)

				local var_89_12 = manager.ui.mainCamera.transform.position - var_89_6.position

				var_89_6.forward = Vector3.New(var_89_12.x, var_89_12.y, var_89_12.z)

				local var_89_13 = var_89_6.localEulerAngles

				var_89_13.z = 0
				var_89_13.x = 0
				var_89_6.localEulerAngles = var_89_13
			end

			if arg_86_1.time_ >= var_89_7 + var_89_9 and arg_86_1.time_ < var_89_7 + var_89_9 + arg_89_0 then
				var_89_6.localPosition = Vector3.New(0, 100, 0)

				local var_89_14 = manager.ui.mainCamera.transform.position - var_89_6.position

				var_89_6.forward = Vector3.New(var_89_14.x, var_89_14.y, var_89_14.z)

				local var_89_15 = var_89_6.localEulerAngles

				var_89_15.z = 0
				var_89_15.x = 0
				var_89_6.localEulerAngles = var_89_15

				local var_89_16 = GameObjectTools.GetOrAddComponent(var_89_6.gameObject, typeof(DynamicBoneHelper))

				if var_89_16 then
					var_89_16:EnableDynamicBone(true)
				end
			end

			local var_89_17 = arg_86_1.actors_["1019ui_story"].transform
			local var_89_18 = 0

			if var_89_18 < arg_86_1.time_ and arg_86_1.time_ <= var_89_18 + arg_89_0 then
				arg_86_1.var_.moveOldPos1019ui_story = var_89_17.localPosition
			end

			local var_89_19 = 0.001

			if var_89_18 <= arg_86_1.time_ and arg_86_1.time_ < var_89_18 + var_89_19 then
				local var_89_20 = (arg_86_1.time_ - var_89_18) / var_89_19
				local var_89_21 = Vector3.New(0, 100, 0)

				var_89_17.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1019ui_story, var_89_21, var_89_20)

				local var_89_22 = manager.ui.mainCamera.transform.position - var_89_17.position

				var_89_17.forward = Vector3.New(var_89_22.x, var_89_22.y, var_89_22.z)

				local var_89_23 = var_89_17.localEulerAngles

				var_89_23.z = 0
				var_89_23.x = 0
				var_89_17.localEulerAngles = var_89_23
			end

			if arg_86_1.time_ >= var_89_18 + var_89_19 and arg_86_1.time_ < var_89_18 + var_89_19 + arg_89_0 then
				var_89_17.localPosition = Vector3.New(0, 100, 0)

				local var_89_24 = manager.ui.mainCamera.transform.position - var_89_17.position

				var_89_17.forward = Vector3.New(var_89_24.x, var_89_24.y, var_89_24.z)

				local var_89_25 = var_89_17.localEulerAngles

				var_89_25.z = 0
				var_89_25.x = 0
				var_89_17.localEulerAngles = var_89_25
			end

			local var_89_26 = 0
			local var_89_27 = 1.05

			if var_89_26 < arg_86_1.time_ and arg_86_1.time_ <= var_89_26 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_28 = arg_86_1:GetWordFromCfg(104042021)
				local var_89_29 = arg_86_1:FormatText(var_89_28.content)

				arg_86_1.text_.text = var_89_29

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_30 = 42
				local var_89_31 = utf8.len(var_89_29)
				local var_89_32 = var_89_30 <= 0 and var_89_27 or var_89_27 * (var_89_31 / var_89_30)

				if var_89_32 > 0 and var_89_27 < var_89_32 then
					arg_86_1.talkMaxDuration = var_89_32

					if var_89_32 + var_89_26 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_32 + var_89_26
					end
				end

				arg_86_1.text_.text = var_89_29
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_33 = math.max(var_89_27, arg_86_1.talkMaxDuration)

			if var_89_26 <= arg_86_1.time_ and arg_86_1.time_ < var_89_26 + var_89_33 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_26) / var_89_33

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_26 + var_89_33 and arg_86_1.time_ < var_89_26 + var_89_33 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play104042022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 104042022
		arg_90_1.duration_ = 8.4

		local var_90_0 = {
			ja = 8.4,
			ko = 6.833,
			zh = 5.4,
			en = 6.3
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play104042023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1036ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1036ui_story == nil then
				arg_90_1.var_.characterEffect1036ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.1

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1036ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1036ui_story then
				arg_90_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_93_4 = 0

			if var_93_4 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_93_5 = arg_90_1.actors_["1036ui_story"].transform
			local var_93_6 = 0

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.var_.moveOldPos1036ui_story = var_93_5.localPosition
			end

			local var_93_7 = 0.001

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_7 then
				local var_93_8 = (arg_90_1.time_ - var_93_6) / var_93_7
				local var_93_9 = Vector3.New(-0.7, -1.09, -5.78)

				var_93_5.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1036ui_story, var_93_9, var_93_8)

				local var_93_10 = manager.ui.mainCamera.transform.position - var_93_5.position

				var_93_5.forward = Vector3.New(var_93_10.x, var_93_10.y, var_93_10.z)

				local var_93_11 = var_93_5.localEulerAngles

				var_93_11.z = 0
				var_93_11.x = 0
				var_93_5.localEulerAngles = var_93_11
			end

			if arg_90_1.time_ >= var_93_6 + var_93_7 and arg_90_1.time_ < var_93_6 + var_93_7 + arg_93_0 then
				var_93_5.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_93_12 = manager.ui.mainCamera.transform.position - var_93_5.position

				var_93_5.forward = Vector3.New(var_93_12.x, var_93_12.y, var_93_12.z)

				local var_93_13 = var_93_5.localEulerAngles

				var_93_13.z = 0
				var_93_13.x = 0
				var_93_5.localEulerAngles = var_93_13
			end

			local var_93_14 = 0

			if var_93_14 < arg_90_1.time_ and arg_90_1.time_ <= var_93_14 + arg_93_0 then
				arg_90_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_93_15 = 0
			local var_93_16 = 0.825

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_17 = arg_90_1:FormatText(StoryNameCfg[5].name)

				arg_90_1.leftNameTxt_.text = var_93_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_18 = arg_90_1:GetWordFromCfg(104042022)
				local var_93_19 = arg_90_1:FormatText(var_93_18.content)

				arg_90_1.text_.text = var_93_19

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_20 = 32
				local var_93_21 = utf8.len(var_93_19)
				local var_93_22 = var_93_20 <= 0 and var_93_16 or var_93_16 * (var_93_21 / var_93_20)

				if var_93_22 > 0 and var_93_16 < var_93_22 then
					arg_90_1.talkMaxDuration = var_93_22

					if var_93_22 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_22 + var_93_15
					end
				end

				arg_90_1.text_.text = var_93_19
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042022", "story_v_out_104042.awb") ~= 0 then
					local var_93_23 = manager.audio:GetVoiceLength("story_v_out_104042", "104042022", "story_v_out_104042.awb") / 1000

					if var_93_23 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_23 + var_93_15
					end

					if var_93_18.prefab_name ~= "" and arg_90_1.actors_[var_93_18.prefab_name] ~= nil then
						local var_93_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_18.prefab_name].transform, "story_v_out_104042", "104042022", "story_v_out_104042.awb")

						arg_90_1:RecordAudio("104042022", var_93_24)
						arg_90_1:RecordAudio("104042022", var_93_24)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_104042", "104042022", "story_v_out_104042.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_104042", "104042022", "story_v_out_104042.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_25 = math.max(var_93_16, arg_90_1.talkMaxDuration)

			if var_93_15 <= arg_90_1.time_ and arg_90_1.time_ < var_93_15 + var_93_25 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_15) / var_93_25

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_15 + var_93_25 and arg_90_1.time_ < var_93_15 + var_93_25 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play104042023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 104042023
		arg_94_1.duration_ = 10.93

		local var_94_0 = {
			ja = 10.933,
			ko = 7.7,
			zh = 7.7,
			en = 6.3
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play104042024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["10001_tpose"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10001_tpose == nil then
				arg_94_1.var_.characterEffect10001_tpose = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.1

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect10001_tpose and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10001_tpose then
				arg_94_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_97_4 = arg_94_1.actors_["1036ui_story"]
			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect1036ui_story == nil then
				arg_94_1.var_.characterEffect1036ui_story = var_97_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.1

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 and not isNil(var_97_4) then
				local var_97_7 = (arg_94_1.time_ - var_97_5) / var_97_6

				if arg_94_1.var_.characterEffect1036ui_story and not isNil(var_97_4) then
					local var_97_8 = Mathf.Lerp(0, 0.5, var_97_7)

					arg_94_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1036ui_story.fillRatio = var_97_8
				end
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect1036ui_story then
				local var_97_9 = 0.5

				arg_94_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1036ui_story.fillRatio = var_97_9
			end

			local var_97_10 = arg_94_1.actors_["10001_tpose"].transform
			local var_97_11 = 0

			if var_97_11 < arg_94_1.time_ and arg_94_1.time_ <= var_97_11 + arg_97_0 then
				arg_94_1.var_.moveOldPos10001_tpose = var_97_10.localPosition

				local var_97_12 = GameObjectTools.GetOrAddComponent(var_97_10.gameObject, typeof(DynamicBoneHelper))

				if var_97_12 then
					var_97_12:EnableDynamicBone(false)
				end
			end

			local var_97_13 = 0.001

			if var_97_11 <= arg_94_1.time_ and arg_94_1.time_ < var_97_11 + var_97_13 then
				local var_97_14 = (arg_94_1.time_ - var_97_11) / var_97_13
				local var_97_15 = Vector3.New(0.7, -1.23, -5.8)

				var_97_10.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos10001_tpose, var_97_15, var_97_14)

				local var_97_16 = manager.ui.mainCamera.transform.position - var_97_10.position

				var_97_10.forward = Vector3.New(var_97_16.x, var_97_16.y, var_97_16.z)

				local var_97_17 = var_97_10.localEulerAngles

				var_97_17.z = 0
				var_97_17.x = 0
				var_97_10.localEulerAngles = var_97_17
			end

			if arg_94_1.time_ >= var_97_11 + var_97_13 and arg_94_1.time_ < var_97_11 + var_97_13 + arg_97_0 then
				var_97_10.localPosition = Vector3.New(0.7, -1.23, -5.8)

				local var_97_18 = manager.ui.mainCamera.transform.position - var_97_10.position

				var_97_10.forward = Vector3.New(var_97_18.x, var_97_18.y, var_97_18.z)

				local var_97_19 = var_97_10.localEulerAngles

				var_97_19.z = 0
				var_97_19.x = 0
				var_97_10.localEulerAngles = var_97_19

				local var_97_20 = GameObjectTools.GetOrAddComponent(var_97_10.gameObject, typeof(DynamicBoneHelper))

				if var_97_20 then
					var_97_20:EnableDynamicBone(true)
				end
			end

			local var_97_21 = 0

			if var_97_21 < arg_94_1.time_ and arg_94_1.time_ <= var_97_21 + arg_97_0 then
				arg_94_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action2_1")
			end

			local var_97_22 = 0

			if var_97_22 < arg_94_1.time_ and arg_94_1.time_ <= var_97_22 + arg_97_0 then
				arg_94_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_97_23 = 0
			local var_97_24 = 0.925

			if var_97_23 < arg_94_1.time_ and arg_94_1.time_ <= var_97_23 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_25 = arg_94_1:FormatText(StoryNameCfg[31].name)

				arg_94_1.leftNameTxt_.text = var_97_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_26 = arg_94_1:GetWordFromCfg(104042023)
				local var_97_27 = arg_94_1:FormatText(var_97_26.content)

				arg_94_1.text_.text = var_97_27

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_28 = 36
				local var_97_29 = utf8.len(var_97_27)
				local var_97_30 = var_97_28 <= 0 and var_97_24 or var_97_24 * (var_97_29 / var_97_28)

				if var_97_30 > 0 and var_97_24 < var_97_30 then
					arg_94_1.talkMaxDuration = var_97_30

					if var_97_30 + var_97_23 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_30 + var_97_23
					end
				end

				arg_94_1.text_.text = var_97_27
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042023", "story_v_out_104042.awb") ~= 0 then
					local var_97_31 = manager.audio:GetVoiceLength("story_v_out_104042", "104042023", "story_v_out_104042.awb") / 1000

					if var_97_31 + var_97_23 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_31 + var_97_23
					end

					if var_97_26.prefab_name ~= "" and arg_94_1.actors_[var_97_26.prefab_name] ~= nil then
						local var_97_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_26.prefab_name].transform, "story_v_out_104042", "104042023", "story_v_out_104042.awb")

						arg_94_1:RecordAudio("104042023", var_97_32)
						arg_94_1:RecordAudio("104042023", var_97_32)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_104042", "104042023", "story_v_out_104042.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_104042", "104042023", "story_v_out_104042.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_33 = math.max(var_97_24, arg_94_1.talkMaxDuration)

			if var_97_23 <= arg_94_1.time_ and arg_94_1.time_ < var_97_23 + var_97_33 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_23) / var_97_33

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_23 + var_97_33 and arg_94_1.time_ < var_97_23 + var_97_33 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play104042024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 104042024
		arg_98_1.duration_ = 3.2

		local var_98_0 = {
			ja = 3.2,
			ko = 2.566,
			zh = 2.433,
			en = 2
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play104042025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1019ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1019ui_story == nil then
				arg_98_1.var_.characterEffect1019ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.1

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1019ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1019ui_story then
				arg_98_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_101_4 = arg_98_1.actors_["10001_tpose"]
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect10001_tpose == nil then
				arg_98_1.var_.characterEffect10001_tpose = var_101_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.1

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 and not isNil(var_101_4) then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6

				if arg_98_1.var_.characterEffect10001_tpose and not isNil(var_101_4) then
					local var_101_8 = Mathf.Lerp(0, 0.5, var_101_7)

					arg_98_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_98_1.var_.characterEffect10001_tpose.fillRatio = var_101_8
				end
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect10001_tpose then
				local var_101_9 = 0.5

				arg_98_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_98_1.var_.characterEffect10001_tpose.fillRatio = var_101_9
			end

			local var_101_10 = arg_98_1.actors_["1036ui_story"].transform
			local var_101_11 = 0

			if var_101_11 < arg_98_1.time_ and arg_98_1.time_ <= var_101_11 + arg_101_0 then
				arg_98_1.var_.moveOldPos1036ui_story = var_101_10.localPosition
			end

			local var_101_12 = 0.001

			if var_101_11 <= arg_98_1.time_ and arg_98_1.time_ < var_101_11 + var_101_12 then
				local var_101_13 = (arg_98_1.time_ - var_101_11) / var_101_12
				local var_101_14 = Vector3.New(0, 100, 0)

				var_101_10.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1036ui_story, var_101_14, var_101_13)

				local var_101_15 = manager.ui.mainCamera.transform.position - var_101_10.position

				var_101_10.forward = Vector3.New(var_101_15.x, var_101_15.y, var_101_15.z)

				local var_101_16 = var_101_10.localEulerAngles

				var_101_16.z = 0
				var_101_16.x = 0
				var_101_10.localEulerAngles = var_101_16
			end

			if arg_98_1.time_ >= var_101_11 + var_101_12 and arg_98_1.time_ < var_101_11 + var_101_12 + arg_101_0 then
				var_101_10.localPosition = Vector3.New(0, 100, 0)

				local var_101_17 = manager.ui.mainCamera.transform.position - var_101_10.position

				var_101_10.forward = Vector3.New(var_101_17.x, var_101_17.y, var_101_17.z)

				local var_101_18 = var_101_10.localEulerAngles

				var_101_18.z = 0
				var_101_18.x = 0
				var_101_10.localEulerAngles = var_101_18
			end

			local var_101_19 = arg_98_1.actors_["1019ui_story"].transform
			local var_101_20 = 0

			if var_101_20 < arg_98_1.time_ and arg_98_1.time_ <= var_101_20 + arg_101_0 then
				arg_98_1.var_.moveOldPos1019ui_story = var_101_19.localPosition
			end

			local var_101_21 = 0.001

			if var_101_20 <= arg_98_1.time_ and arg_98_1.time_ < var_101_20 + var_101_21 then
				local var_101_22 = (arg_98_1.time_ - var_101_20) / var_101_21
				local var_101_23 = Vector3.New(-0.7, -1.08, -5.9)

				var_101_19.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1019ui_story, var_101_23, var_101_22)

				local var_101_24 = manager.ui.mainCamera.transform.position - var_101_19.position

				var_101_19.forward = Vector3.New(var_101_24.x, var_101_24.y, var_101_24.z)

				local var_101_25 = var_101_19.localEulerAngles

				var_101_25.z = 0
				var_101_25.x = 0
				var_101_19.localEulerAngles = var_101_25
			end

			if arg_98_1.time_ >= var_101_20 + var_101_21 and arg_98_1.time_ < var_101_20 + var_101_21 + arg_101_0 then
				var_101_19.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_101_26 = manager.ui.mainCamera.transform.position - var_101_19.position

				var_101_19.forward = Vector3.New(var_101_26.x, var_101_26.y, var_101_26.z)

				local var_101_27 = var_101_19.localEulerAngles

				var_101_27.z = 0
				var_101_27.x = 0
				var_101_19.localEulerAngles = var_101_27
			end

			local var_101_28 = 0

			if var_101_28 < arg_98_1.time_ and arg_98_1.time_ <= var_101_28 + arg_101_0 then
				arg_98_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_101_29 = 0

			if var_101_29 < arg_98_1.time_ and arg_98_1.time_ <= var_101_29 + arg_101_0 then
				arg_98_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_101_30 = 0
			local var_101_31 = 0.325

			if var_101_30 < arg_98_1.time_ and arg_98_1.time_ <= var_101_30 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_32 = arg_98_1:FormatText(StoryNameCfg[13].name)

				arg_98_1.leftNameTxt_.text = var_101_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_33 = arg_98_1:GetWordFromCfg(104042024)
				local var_101_34 = arg_98_1:FormatText(var_101_33.content)

				arg_98_1.text_.text = var_101_34

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_35 = 13
				local var_101_36 = utf8.len(var_101_34)
				local var_101_37 = var_101_35 <= 0 and var_101_31 or var_101_31 * (var_101_36 / var_101_35)

				if var_101_37 > 0 and var_101_31 < var_101_37 then
					arg_98_1.talkMaxDuration = var_101_37

					if var_101_37 + var_101_30 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_37 + var_101_30
					end
				end

				arg_98_1.text_.text = var_101_34
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042024", "story_v_out_104042.awb") ~= 0 then
					local var_101_38 = manager.audio:GetVoiceLength("story_v_out_104042", "104042024", "story_v_out_104042.awb") / 1000

					if var_101_38 + var_101_30 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_38 + var_101_30
					end

					if var_101_33.prefab_name ~= "" and arg_98_1.actors_[var_101_33.prefab_name] ~= nil then
						local var_101_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_33.prefab_name].transform, "story_v_out_104042", "104042024", "story_v_out_104042.awb")

						arg_98_1:RecordAudio("104042024", var_101_39)
						arg_98_1:RecordAudio("104042024", var_101_39)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_104042", "104042024", "story_v_out_104042.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_104042", "104042024", "story_v_out_104042.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_40 = math.max(var_101_31, arg_98_1.talkMaxDuration)

			if var_101_30 <= arg_98_1.time_ and arg_98_1.time_ < var_101_30 + var_101_40 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_30) / var_101_40

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_30 + var_101_40 and arg_98_1.time_ < var_101_30 + var_101_40 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play104042025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 104042025
		arg_102_1.duration_ = 12.87

		local var_102_0 = {
			ja = 12.866,
			ko = 10.933,
			zh = 9.4,
			en = 10.1
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play104042026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["10001_tpose"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect10001_tpose == nil then
				arg_102_1.var_.characterEffect10001_tpose = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.1

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect10001_tpose and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect10001_tpose then
				arg_102_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_105_4 = arg_102_1.actors_["1019ui_story"]
			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect1019ui_story == nil then
				arg_102_1.var_.characterEffect1019ui_story = var_105_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_6 = 0.1

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_6 and not isNil(var_105_4) then
				local var_105_7 = (arg_102_1.time_ - var_105_5) / var_105_6

				if arg_102_1.var_.characterEffect1019ui_story and not isNil(var_105_4) then
					local var_105_8 = Mathf.Lerp(0, 0.5, var_105_7)

					arg_102_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1019ui_story.fillRatio = var_105_8
				end
			end

			if arg_102_1.time_ >= var_105_5 + var_105_6 and arg_102_1.time_ < var_105_5 + var_105_6 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect1019ui_story then
				local var_105_9 = 0.5

				arg_102_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1019ui_story.fillRatio = var_105_9
			end

			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action425")
			end

			local var_105_11 = 0

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 then
				arg_102_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_105_12 = 0
			local var_105_13 = 1.2

			if var_105_12 < arg_102_1.time_ and arg_102_1.time_ <= var_105_12 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_14 = arg_102_1:FormatText(StoryNameCfg[31].name)

				arg_102_1.leftNameTxt_.text = var_105_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_15 = arg_102_1:GetWordFromCfg(104042025)
				local var_105_16 = arg_102_1:FormatText(var_105_15.content)

				arg_102_1.text_.text = var_105_16

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_17 = 48
				local var_105_18 = utf8.len(var_105_16)
				local var_105_19 = var_105_17 <= 0 and var_105_13 or var_105_13 * (var_105_18 / var_105_17)

				if var_105_19 > 0 and var_105_13 < var_105_19 then
					arg_102_1.talkMaxDuration = var_105_19

					if var_105_19 + var_105_12 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_19 + var_105_12
					end
				end

				arg_102_1.text_.text = var_105_16
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042025", "story_v_out_104042.awb") ~= 0 then
					local var_105_20 = manager.audio:GetVoiceLength("story_v_out_104042", "104042025", "story_v_out_104042.awb") / 1000

					if var_105_20 + var_105_12 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_20 + var_105_12
					end

					if var_105_15.prefab_name ~= "" and arg_102_1.actors_[var_105_15.prefab_name] ~= nil then
						local var_105_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_15.prefab_name].transform, "story_v_out_104042", "104042025", "story_v_out_104042.awb")

						arg_102_1:RecordAudio("104042025", var_105_21)
						arg_102_1:RecordAudio("104042025", var_105_21)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_104042", "104042025", "story_v_out_104042.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_104042", "104042025", "story_v_out_104042.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_22 = math.max(var_105_13, arg_102_1.talkMaxDuration)

			if var_105_12 <= arg_102_1.time_ and arg_102_1.time_ < var_105_12 + var_105_22 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_12) / var_105_22

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_12 + var_105_22 and arg_102_1.time_ < var_105_12 + var_105_22 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play104042026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 104042026
		arg_106_1.duration_ = 4.53

		local var_106_0 = {
			ja = 4.533,
			ko = 4.066,
			zh = 3.8,
			en = 2.9
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play104042027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action453")
			end

			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_109_2 = 0
			local var_109_3 = 0.5

			if var_109_2 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_4 = arg_106_1:FormatText(StoryNameCfg[31].name)

				arg_106_1.leftNameTxt_.text = var_109_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_5 = arg_106_1:GetWordFromCfg(104042026)
				local var_109_6 = arg_106_1:FormatText(var_109_5.content)

				arg_106_1.text_.text = var_109_6

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 20
				local var_109_8 = utf8.len(var_109_6)
				local var_109_9 = var_109_7 <= 0 and var_109_3 or var_109_3 * (var_109_8 / var_109_7)

				if var_109_9 > 0 and var_109_3 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_2
					end
				end

				arg_106_1.text_.text = var_109_6
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042026", "story_v_out_104042.awb") ~= 0 then
					local var_109_10 = manager.audio:GetVoiceLength("story_v_out_104042", "104042026", "story_v_out_104042.awb") / 1000

					if var_109_10 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_2
					end

					if var_109_5.prefab_name ~= "" and arg_106_1.actors_[var_109_5.prefab_name] ~= nil then
						local var_109_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_5.prefab_name].transform, "story_v_out_104042", "104042026", "story_v_out_104042.awb")

						arg_106_1:RecordAudio("104042026", var_109_11)
						arg_106_1:RecordAudio("104042026", var_109_11)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_104042", "104042026", "story_v_out_104042.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_104042", "104042026", "story_v_out_104042.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_12 = math.max(var_109_3, arg_106_1.talkMaxDuration)

			if var_109_2 <= arg_106_1.time_ and arg_106_1.time_ < var_109_2 + var_109_12 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_2) / var_109_12

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_2 + var_109_12 and arg_106_1.time_ < var_109_2 + var_109_12 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play104042027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 104042027
		arg_110_1.duration_ = 8.27

		local var_110_0 = {
			ja = 8.266,
			ko = 5.3,
			zh = 5.1,
			en = 6.766
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play104042028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1019ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1019ui_story == nil then
				arg_110_1.var_.characterEffect1019ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.1

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1019ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1019ui_story then
				arg_110_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_113_4 = arg_110_1.actors_["10001_tpose"]
			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect10001_tpose == nil then
				arg_110_1.var_.characterEffect10001_tpose = var_113_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_6 = 0.1

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 and not isNil(var_113_4) then
				local var_113_7 = (arg_110_1.time_ - var_113_5) / var_113_6

				if arg_110_1.var_.characterEffect10001_tpose and not isNil(var_113_4) then
					local var_113_8 = Mathf.Lerp(0, 0.5, var_113_7)

					arg_110_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_110_1.var_.characterEffect10001_tpose.fillRatio = var_113_8
				end
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect10001_tpose then
				local var_113_9 = 0.5

				arg_110_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_110_1.var_.characterEffect10001_tpose.fillRatio = var_113_9
			end

			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_113_11 = 0

			if var_113_11 < arg_110_1.time_ and arg_110_1.time_ <= var_113_11 + arg_113_0 then
				arg_110_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_113_12 = 0
			local var_113_13 = 0.675

			if var_113_12 < arg_110_1.time_ and arg_110_1.time_ <= var_113_12 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_14 = arg_110_1:FormatText(StoryNameCfg[13].name)

				arg_110_1.leftNameTxt_.text = var_113_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_15 = arg_110_1:GetWordFromCfg(104042027)
				local var_113_16 = arg_110_1:FormatText(var_113_15.content)

				arg_110_1.text_.text = var_113_16

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_17 = 27
				local var_113_18 = utf8.len(var_113_16)
				local var_113_19 = var_113_17 <= 0 and var_113_13 or var_113_13 * (var_113_18 / var_113_17)

				if var_113_19 > 0 and var_113_13 < var_113_19 then
					arg_110_1.talkMaxDuration = var_113_19

					if var_113_19 + var_113_12 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_19 + var_113_12
					end
				end

				arg_110_1.text_.text = var_113_16
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042027", "story_v_out_104042.awb") ~= 0 then
					local var_113_20 = manager.audio:GetVoiceLength("story_v_out_104042", "104042027", "story_v_out_104042.awb") / 1000

					if var_113_20 + var_113_12 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_20 + var_113_12
					end

					if var_113_15.prefab_name ~= "" and arg_110_1.actors_[var_113_15.prefab_name] ~= nil then
						local var_113_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_15.prefab_name].transform, "story_v_out_104042", "104042027", "story_v_out_104042.awb")

						arg_110_1:RecordAudio("104042027", var_113_21)
						arg_110_1:RecordAudio("104042027", var_113_21)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_104042", "104042027", "story_v_out_104042.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_104042", "104042027", "story_v_out_104042.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_22 = math.max(var_113_13, arg_110_1.talkMaxDuration)

			if var_113_12 <= arg_110_1.time_ and arg_110_1.time_ < var_113_12 + var_113_22 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_12) / var_113_22

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_12 + var_113_22 and arg_110_1.time_ < var_113_12 + var_113_22 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play104042028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 104042028
		arg_114_1.duration_ = 2

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play104042029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["10001_tpose"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect10001_tpose == nil then
				arg_114_1.var_.characterEffect10001_tpose = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.1

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect10001_tpose and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect10001_tpose then
				arg_114_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_117_4 = arg_114_1.actors_["1019ui_story"]
			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1019ui_story == nil then
				arg_114_1.var_.characterEffect1019ui_story = var_117_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.1

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 and not isNil(var_117_4) then
				local var_117_7 = (arg_114_1.time_ - var_117_5) / var_117_6

				if arg_114_1.var_.characterEffect1019ui_story and not isNil(var_117_4) then
					local var_117_8 = Mathf.Lerp(0, 0.5, var_117_7)

					arg_114_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1019ui_story.fillRatio = var_117_8
				end
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1019ui_story then
				local var_117_9 = 0.5

				arg_114_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1019ui_story.fillRatio = var_117_9
			end

			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action435")
			end

			local var_117_11 = 0

			if var_117_11 < arg_114_1.time_ and arg_114_1.time_ <= var_117_11 + arg_117_0 then
				arg_114_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_117_12 = 0
			local var_117_13 = 0.15

			if var_117_12 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_14 = arg_114_1:FormatText(StoryNameCfg[31].name)

				arg_114_1.leftNameTxt_.text = var_117_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_15 = arg_114_1:GetWordFromCfg(104042028)
				local var_117_16 = arg_114_1:FormatText(var_117_15.content)

				arg_114_1.text_.text = var_117_16

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_17 = 6
				local var_117_18 = utf8.len(var_117_16)
				local var_117_19 = var_117_17 <= 0 and var_117_13 or var_117_13 * (var_117_18 / var_117_17)

				if var_117_19 > 0 and var_117_13 < var_117_19 then
					arg_114_1.talkMaxDuration = var_117_19

					if var_117_19 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_19 + var_117_12
					end
				end

				arg_114_1.text_.text = var_117_16
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042028", "story_v_out_104042.awb") ~= 0 then
					local var_117_20 = manager.audio:GetVoiceLength("story_v_out_104042", "104042028", "story_v_out_104042.awb") / 1000

					if var_117_20 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_20 + var_117_12
					end

					if var_117_15.prefab_name ~= "" and arg_114_1.actors_[var_117_15.prefab_name] ~= nil then
						local var_117_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_15.prefab_name].transform, "story_v_out_104042", "104042028", "story_v_out_104042.awb")

						arg_114_1:RecordAudio("104042028", var_117_21)
						arg_114_1:RecordAudio("104042028", var_117_21)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_104042", "104042028", "story_v_out_104042.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_104042", "104042028", "story_v_out_104042.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_22 = math.max(var_117_13, arg_114_1.talkMaxDuration)

			if var_117_12 <= arg_114_1.time_ and arg_114_1.time_ < var_117_12 + var_117_22 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_12) / var_117_22

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_12 + var_117_22 and arg_114_1.time_ < var_117_12 + var_117_22 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play104042029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 104042029
		arg_118_1.duration_ = 5.53

		local var_118_0 = {
			ja = 5.533,
			ko = 3.933,
			zh = 3.366,
			en = 2.3
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play104042030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1019ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1019ui_story == nil then
				arg_118_1.var_.characterEffect1019ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.1

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1019ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1019ui_story then
				arg_118_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_121_4 = arg_118_1.actors_["10001_tpose"]
			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect10001_tpose == nil then
				arg_118_1.var_.characterEffect10001_tpose = var_121_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.1

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 and not isNil(var_121_4) then
				local var_121_7 = (arg_118_1.time_ - var_121_5) / var_121_6

				if arg_118_1.var_.characterEffect10001_tpose and not isNil(var_121_4) then
					local var_121_8 = Mathf.Lerp(0, 0.5, var_121_7)

					arg_118_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_118_1.var_.characterEffect10001_tpose.fillRatio = var_121_8
				end
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect10001_tpose then
				local var_121_9 = 0.5

				arg_118_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_118_1.var_.characterEffect10001_tpose.fillRatio = var_121_9
			end

			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_121_11 = 0
			local var_121_12 = 0.4

			if var_121_11 < arg_118_1.time_ and arg_118_1.time_ <= var_121_11 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_13 = arg_118_1:FormatText(StoryNameCfg[13].name)

				arg_118_1.leftNameTxt_.text = var_121_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_14 = arg_118_1:GetWordFromCfg(104042029)
				local var_121_15 = arg_118_1:FormatText(var_121_14.content)

				arg_118_1.text_.text = var_121_15

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_16 = 16
				local var_121_17 = utf8.len(var_121_15)
				local var_121_18 = var_121_16 <= 0 and var_121_12 or var_121_12 * (var_121_17 / var_121_16)

				if var_121_18 > 0 and var_121_12 < var_121_18 then
					arg_118_1.talkMaxDuration = var_121_18

					if var_121_18 + var_121_11 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_18 + var_121_11
					end
				end

				arg_118_1.text_.text = var_121_15
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042029", "story_v_out_104042.awb") ~= 0 then
					local var_121_19 = manager.audio:GetVoiceLength("story_v_out_104042", "104042029", "story_v_out_104042.awb") / 1000

					if var_121_19 + var_121_11 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_19 + var_121_11
					end

					if var_121_14.prefab_name ~= "" and arg_118_1.actors_[var_121_14.prefab_name] ~= nil then
						local var_121_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_14.prefab_name].transform, "story_v_out_104042", "104042029", "story_v_out_104042.awb")

						arg_118_1:RecordAudio("104042029", var_121_20)
						arg_118_1:RecordAudio("104042029", var_121_20)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_104042", "104042029", "story_v_out_104042.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_104042", "104042029", "story_v_out_104042.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_21 = math.max(var_121_12, arg_118_1.talkMaxDuration)

			if var_121_11 <= arg_118_1.time_ and arg_118_1.time_ < var_121_11 + var_121_21 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_11) / var_121_21

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_11 + var_121_21 and arg_118_1.time_ < var_121_11 + var_121_21 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play104042030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 104042030
		arg_122_1.duration_ = 5.8

		local var_122_0 = {
			ja = 5.266,
			ko = 5.8,
			zh = 5.3,
			en = 3.5
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play104042031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["10001_tpose"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect10001_tpose == nil then
				arg_122_1.var_.characterEffect10001_tpose = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.1

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect10001_tpose and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect10001_tpose then
				arg_122_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_125_4 = arg_122_1.actors_["1019ui_story"]
			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1019ui_story == nil then
				arg_122_1.var_.characterEffect1019ui_story = var_125_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_6 = 0.1

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_6 and not isNil(var_125_4) then
				local var_125_7 = (arg_122_1.time_ - var_125_5) / var_125_6

				if arg_122_1.var_.characterEffect1019ui_story and not isNil(var_125_4) then
					local var_125_8 = Mathf.Lerp(0, 0.5, var_125_7)

					arg_122_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1019ui_story.fillRatio = var_125_8
				end
			end

			if arg_122_1.time_ >= var_125_5 + var_125_6 and arg_122_1.time_ < var_125_5 + var_125_6 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1019ui_story then
				local var_125_9 = 0.5

				arg_122_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1019ui_story.fillRatio = var_125_9
			end

			local var_125_10 = 0

			if var_125_10 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 then
				arg_122_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action453")
			end

			local var_125_11 = 0

			if var_125_11 < arg_122_1.time_ and arg_122_1.time_ <= var_125_11 + arg_125_0 then
				arg_122_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_125_12 = 0
			local var_125_13 = 0.45

			if var_125_12 < arg_122_1.time_ and arg_122_1.time_ <= var_125_12 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_14 = arg_122_1:FormatText(StoryNameCfg[31].name)

				arg_122_1.leftNameTxt_.text = var_125_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_15 = arg_122_1:GetWordFromCfg(104042030)
				local var_125_16 = arg_122_1:FormatText(var_125_15.content)

				arg_122_1.text_.text = var_125_16

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_17 = 18
				local var_125_18 = utf8.len(var_125_16)
				local var_125_19 = var_125_17 <= 0 and var_125_13 or var_125_13 * (var_125_18 / var_125_17)

				if var_125_19 > 0 and var_125_13 < var_125_19 then
					arg_122_1.talkMaxDuration = var_125_19

					if var_125_19 + var_125_12 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_19 + var_125_12
					end
				end

				arg_122_1.text_.text = var_125_16
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042030", "story_v_out_104042.awb") ~= 0 then
					local var_125_20 = manager.audio:GetVoiceLength("story_v_out_104042", "104042030", "story_v_out_104042.awb") / 1000

					if var_125_20 + var_125_12 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_20 + var_125_12
					end

					if var_125_15.prefab_name ~= "" and arg_122_1.actors_[var_125_15.prefab_name] ~= nil then
						local var_125_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_15.prefab_name].transform, "story_v_out_104042", "104042030", "story_v_out_104042.awb")

						arg_122_1:RecordAudio("104042030", var_125_21)
						arg_122_1:RecordAudio("104042030", var_125_21)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_104042", "104042030", "story_v_out_104042.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_104042", "104042030", "story_v_out_104042.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_22 = math.max(var_125_13, arg_122_1.talkMaxDuration)

			if var_125_12 <= arg_122_1.time_ and arg_122_1.time_ < var_125_12 + var_125_22 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_12) / var_125_22

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_12 + var_125_22 and arg_122_1.time_ < var_125_12 + var_125_22 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play104042031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 104042031
		arg_126_1.duration_ = 6.2

		local var_126_0 = {
			ja = 6.2,
			ko = 4.2,
			zh = 2.833,
			en = 3.566
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
				arg_126_0:Play104042032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1036ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1036ui_story == nil then
				arg_126_1.var_.characterEffect1036ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.1

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1036ui_story and not isNil(var_129_0) then
					arg_126_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1036ui_story then
				arg_126_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_129_4 = arg_126_1.actors_["10001_tpose"]
			local var_129_5 = 0

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect10001_tpose == nil then
				arg_126_1.var_.characterEffect10001_tpose = var_129_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_6 = 0.1

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_6 and not isNil(var_129_4) then
				local var_129_7 = (arg_126_1.time_ - var_129_5) / var_129_6

				if arg_126_1.var_.characterEffect10001_tpose and not isNil(var_129_4) then
					local var_129_8 = Mathf.Lerp(0, 0.5, var_129_7)

					arg_126_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_126_1.var_.characterEffect10001_tpose.fillRatio = var_129_8
				end
			end

			if arg_126_1.time_ >= var_129_5 + var_129_6 and arg_126_1.time_ < var_129_5 + var_129_6 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect10001_tpose then
				local var_129_9 = 0.5

				arg_126_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_126_1.var_.characterEffect10001_tpose.fillRatio = var_129_9
			end

			local var_129_10 = arg_126_1.actors_["10001_tpose"].transform
			local var_129_11 = 0

			if var_129_11 < arg_126_1.time_ and arg_126_1.time_ <= var_129_11 + arg_129_0 then
				arg_126_1.var_.moveOldPos10001_tpose = var_129_10.localPosition

				local var_129_12 = GameObjectTools.GetOrAddComponent(var_129_10.gameObject, typeof(DynamicBoneHelper))

				if var_129_12 then
					var_129_12:EnableDynamicBone(false)
				end
			end

			local var_129_13 = 0.001

			if var_129_11 <= arg_126_1.time_ and arg_126_1.time_ < var_129_11 + var_129_13 then
				local var_129_14 = (arg_126_1.time_ - var_129_11) / var_129_13
				local var_129_15 = Vector3.New(0, 100, 0)

				var_129_10.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10001_tpose, var_129_15, var_129_14)

				local var_129_16 = manager.ui.mainCamera.transform.position - var_129_10.position

				var_129_10.forward = Vector3.New(var_129_16.x, var_129_16.y, var_129_16.z)

				local var_129_17 = var_129_10.localEulerAngles

				var_129_17.z = 0
				var_129_17.x = 0
				var_129_10.localEulerAngles = var_129_17
			end

			if arg_126_1.time_ >= var_129_11 + var_129_13 and arg_126_1.time_ < var_129_11 + var_129_13 + arg_129_0 then
				var_129_10.localPosition = Vector3.New(0, 100, 0)

				local var_129_18 = manager.ui.mainCamera.transform.position - var_129_10.position

				var_129_10.forward = Vector3.New(var_129_18.x, var_129_18.y, var_129_18.z)

				local var_129_19 = var_129_10.localEulerAngles

				var_129_19.z = 0
				var_129_19.x = 0
				var_129_10.localEulerAngles = var_129_19

				local var_129_20 = GameObjectTools.GetOrAddComponent(var_129_10.gameObject, typeof(DynamicBoneHelper))

				if var_129_20 then
					var_129_20:EnableDynamicBone(true)
				end
			end

			local var_129_21 = 0

			if var_129_21 < arg_126_1.time_ and arg_126_1.time_ <= var_129_21 + arg_129_0 then
				arg_126_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_129_22 = arg_126_1.actors_["1036ui_story"].transform
			local var_129_23 = 0

			if var_129_23 < arg_126_1.time_ and arg_126_1.time_ <= var_129_23 + arg_129_0 then
				arg_126_1.var_.moveOldPos1036ui_story = var_129_22.localPosition
			end

			local var_129_24 = 0.001

			if var_129_23 <= arg_126_1.time_ and arg_126_1.time_ < var_129_23 + var_129_24 then
				local var_129_25 = (arg_126_1.time_ - var_129_23) / var_129_24
				local var_129_26 = Vector3.New(0.7, -1.09, -5.78)

				var_129_22.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1036ui_story, var_129_26, var_129_25)

				local var_129_27 = manager.ui.mainCamera.transform.position - var_129_22.position

				var_129_22.forward = Vector3.New(var_129_27.x, var_129_27.y, var_129_27.z)

				local var_129_28 = var_129_22.localEulerAngles

				var_129_28.z = 0
				var_129_28.x = 0
				var_129_22.localEulerAngles = var_129_28
			end

			if arg_126_1.time_ >= var_129_23 + var_129_24 and arg_126_1.time_ < var_129_23 + var_129_24 + arg_129_0 then
				var_129_22.localPosition = Vector3.New(0.7, -1.09, -5.78)

				local var_129_29 = manager.ui.mainCamera.transform.position - var_129_22.position

				var_129_22.forward = Vector3.New(var_129_29.x, var_129_29.y, var_129_29.z)

				local var_129_30 = var_129_22.localEulerAngles

				var_129_30.z = 0
				var_129_30.x = 0
				var_129_22.localEulerAngles = var_129_30
			end

			local var_129_31 = 0

			if var_129_31 < arg_126_1.time_ and arg_126_1.time_ <= var_129_31 + arg_129_0 then
				arg_126_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_129_32 = 0
			local var_129_33 = 0.35

			if var_129_32 < arg_126_1.time_ and arg_126_1.time_ <= var_129_32 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_34 = arg_126_1:FormatText(StoryNameCfg[5].name)

				arg_126_1.leftNameTxt_.text = var_129_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_35 = arg_126_1:GetWordFromCfg(104042031)
				local var_129_36 = arg_126_1:FormatText(var_129_35.content)

				arg_126_1.text_.text = var_129_36

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_37 = 14
				local var_129_38 = utf8.len(var_129_36)
				local var_129_39 = var_129_37 <= 0 and var_129_33 or var_129_33 * (var_129_38 / var_129_37)

				if var_129_39 > 0 and var_129_33 < var_129_39 then
					arg_126_1.talkMaxDuration = var_129_39

					if var_129_39 + var_129_32 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_39 + var_129_32
					end
				end

				arg_126_1.text_.text = var_129_36
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042031", "story_v_out_104042.awb") ~= 0 then
					local var_129_40 = manager.audio:GetVoiceLength("story_v_out_104042", "104042031", "story_v_out_104042.awb") / 1000

					if var_129_40 + var_129_32 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_40 + var_129_32
					end

					if var_129_35.prefab_name ~= "" and arg_126_1.actors_[var_129_35.prefab_name] ~= nil then
						local var_129_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_35.prefab_name].transform, "story_v_out_104042", "104042031", "story_v_out_104042.awb")

						arg_126_1:RecordAudio("104042031", var_129_41)
						arg_126_1:RecordAudio("104042031", var_129_41)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_104042", "104042031", "story_v_out_104042.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_104042", "104042031", "story_v_out_104042.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_42 = math.max(var_129_33, arg_126_1.talkMaxDuration)

			if var_129_32 <= arg_126_1.time_ and arg_126_1.time_ < var_129_32 + var_129_42 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_32) / var_129_42

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_32 + var_129_42 and arg_126_1.time_ < var_129_32 + var_129_42 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play104042032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 104042032
		arg_130_1.duration_ = 11.77

		local var_130_0 = {
			ja = 11.766,
			ko = 8.566,
			zh = 9.133,
			en = 9.133
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play104042033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1019ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1019ui_story == nil then
				arg_130_1.var_.characterEffect1019ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.1

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect1019ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1019ui_story then
				arg_130_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_133_4 = arg_130_1.actors_["1036ui_story"]
			local var_133_5 = 0

			if var_133_5 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect1036ui_story == nil then
				arg_130_1.var_.characterEffect1036ui_story = var_133_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_6 = 0.1

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_6 and not isNil(var_133_4) then
				local var_133_7 = (arg_130_1.time_ - var_133_5) / var_133_6

				if arg_130_1.var_.characterEffect1036ui_story and not isNil(var_133_4) then
					local var_133_8 = Mathf.Lerp(0, 0.5, var_133_7)

					arg_130_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1036ui_story.fillRatio = var_133_8
				end
			end

			if arg_130_1.time_ >= var_133_5 + var_133_6 and arg_130_1.time_ < var_133_5 + var_133_6 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect1036ui_story then
				local var_133_9 = 0.5

				arg_130_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1036ui_story.fillRatio = var_133_9
			end

			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 then
				arg_130_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_133_11 = 0
			local var_133_12 = 1.075

			if var_133_11 < arg_130_1.time_ and arg_130_1.time_ <= var_133_11 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_13 = arg_130_1:FormatText(StoryNameCfg[13].name)

				arg_130_1.leftNameTxt_.text = var_133_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_14 = arg_130_1:GetWordFromCfg(104042032)
				local var_133_15 = arg_130_1:FormatText(var_133_14.content)

				arg_130_1.text_.text = var_133_15

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_16 = 43
				local var_133_17 = utf8.len(var_133_15)
				local var_133_18 = var_133_16 <= 0 and var_133_12 or var_133_12 * (var_133_17 / var_133_16)

				if var_133_18 > 0 and var_133_12 < var_133_18 then
					arg_130_1.talkMaxDuration = var_133_18

					if var_133_18 + var_133_11 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_18 + var_133_11
					end
				end

				arg_130_1.text_.text = var_133_15
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042032", "story_v_out_104042.awb") ~= 0 then
					local var_133_19 = manager.audio:GetVoiceLength("story_v_out_104042", "104042032", "story_v_out_104042.awb") / 1000

					if var_133_19 + var_133_11 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_19 + var_133_11
					end

					if var_133_14.prefab_name ~= "" and arg_130_1.actors_[var_133_14.prefab_name] ~= nil then
						local var_133_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_14.prefab_name].transform, "story_v_out_104042", "104042032", "story_v_out_104042.awb")

						arg_130_1:RecordAudio("104042032", var_133_20)
						arg_130_1:RecordAudio("104042032", var_133_20)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_104042", "104042032", "story_v_out_104042.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_104042", "104042032", "story_v_out_104042.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_21 = math.max(var_133_12, arg_130_1.talkMaxDuration)

			if var_133_11 <= arg_130_1.time_ and arg_130_1.time_ < var_133_11 + var_133_21 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_11) / var_133_21

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_11 + var_133_21 and arg_130_1.time_ < var_133_11 + var_133_21 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play104042033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 104042033
		arg_134_1.duration_ = 4.27

		local var_134_0 = {
			ja = 4.266,
			ko = 2.6,
			zh = 4.266,
			en = 2.933
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play104042034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_137_1 = 0
			local var_137_2 = 0.55

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_3 = arg_134_1:FormatText(StoryNameCfg[13].name)

				arg_134_1.leftNameTxt_.text = var_137_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_4 = arg_134_1:GetWordFromCfg(104042033)
				local var_137_5 = arg_134_1:FormatText(var_137_4.content)

				arg_134_1.text_.text = var_137_5

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_6 = 22
				local var_137_7 = utf8.len(var_137_5)
				local var_137_8 = var_137_6 <= 0 and var_137_2 or var_137_2 * (var_137_7 / var_137_6)

				if var_137_8 > 0 and var_137_2 < var_137_8 then
					arg_134_1.talkMaxDuration = var_137_8

					if var_137_8 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_1
					end
				end

				arg_134_1.text_.text = var_137_5
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042033", "story_v_out_104042.awb") ~= 0 then
					local var_137_9 = manager.audio:GetVoiceLength("story_v_out_104042", "104042033", "story_v_out_104042.awb") / 1000

					if var_137_9 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_1
					end

					if var_137_4.prefab_name ~= "" and arg_134_1.actors_[var_137_4.prefab_name] ~= nil then
						local var_137_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_4.prefab_name].transform, "story_v_out_104042", "104042033", "story_v_out_104042.awb")

						arg_134_1:RecordAudio("104042033", var_137_10)
						arg_134_1:RecordAudio("104042033", var_137_10)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_104042", "104042033", "story_v_out_104042.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_104042", "104042033", "story_v_out_104042.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_11 = math.max(var_137_2, arg_134_1.talkMaxDuration)

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_11 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_1) / var_137_11

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_1 + var_137_11 and arg_134_1.time_ < var_137_1 + var_137_11 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play104042034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 104042034
		arg_138_1.duration_ = 8.13

		local var_138_0 = {
			ja = 8.1,
			ko = 7.333,
			zh = 7.8,
			en = 8.133
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
				arg_138_0:Play104042035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["10001_tpose"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect10001_tpose == nil then
				arg_138_1.var_.characterEffect10001_tpose = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.1

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect10001_tpose and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect10001_tpose then
				arg_138_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_141_4 = arg_138_1.actors_["1019ui_story"]
			local var_141_5 = 0

			if var_141_5 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect1019ui_story == nil then
				arg_138_1.var_.characterEffect1019ui_story = var_141_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_6 = 0.1

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_6 and not isNil(var_141_4) then
				local var_141_7 = (arg_138_1.time_ - var_141_5) / var_141_6

				if arg_138_1.var_.characterEffect1019ui_story and not isNil(var_141_4) then
					local var_141_8 = Mathf.Lerp(0, 0.5, var_141_7)

					arg_138_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1019ui_story.fillRatio = var_141_8
				end
			end

			if arg_138_1.time_ >= var_141_5 + var_141_6 and arg_138_1.time_ < var_141_5 + var_141_6 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect1019ui_story then
				local var_141_9 = 0.5

				arg_138_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1019ui_story.fillRatio = var_141_9
			end

			local var_141_10 = arg_138_1.actors_["1019ui_story"].transform
			local var_141_11 = 0

			if var_141_11 < arg_138_1.time_ and arg_138_1.time_ <= var_141_11 + arg_141_0 then
				arg_138_1.var_.moveOldPos1019ui_story = var_141_10.localPosition
			end

			local var_141_12 = 0.001

			if var_141_11 <= arg_138_1.time_ and arg_138_1.time_ < var_141_11 + var_141_12 then
				local var_141_13 = (arg_138_1.time_ - var_141_11) / var_141_12
				local var_141_14 = Vector3.New(0, 100, 0)

				var_141_10.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1019ui_story, var_141_14, var_141_13)

				local var_141_15 = manager.ui.mainCamera.transform.position - var_141_10.position

				var_141_10.forward = Vector3.New(var_141_15.x, var_141_15.y, var_141_15.z)

				local var_141_16 = var_141_10.localEulerAngles

				var_141_16.z = 0
				var_141_16.x = 0
				var_141_10.localEulerAngles = var_141_16
			end

			if arg_138_1.time_ >= var_141_11 + var_141_12 and arg_138_1.time_ < var_141_11 + var_141_12 + arg_141_0 then
				var_141_10.localPosition = Vector3.New(0, 100, 0)

				local var_141_17 = manager.ui.mainCamera.transform.position - var_141_10.position

				var_141_10.forward = Vector3.New(var_141_17.x, var_141_17.y, var_141_17.z)

				local var_141_18 = var_141_10.localEulerAngles

				var_141_18.z = 0
				var_141_18.x = 0
				var_141_10.localEulerAngles = var_141_18
			end

			local var_141_19 = arg_138_1.actors_["1036ui_story"].transform
			local var_141_20 = 0

			if var_141_20 < arg_138_1.time_ and arg_138_1.time_ <= var_141_20 + arg_141_0 then
				arg_138_1.var_.moveOldPos1036ui_story = var_141_19.localPosition
			end

			local var_141_21 = 0.001

			if var_141_20 <= arg_138_1.time_ and arg_138_1.time_ < var_141_20 + var_141_21 then
				local var_141_22 = (arg_138_1.time_ - var_141_20) / var_141_21
				local var_141_23 = Vector3.New(0, 100, 0)

				var_141_19.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1036ui_story, var_141_23, var_141_22)

				local var_141_24 = manager.ui.mainCamera.transform.position - var_141_19.position

				var_141_19.forward = Vector3.New(var_141_24.x, var_141_24.y, var_141_24.z)

				local var_141_25 = var_141_19.localEulerAngles

				var_141_25.z = 0
				var_141_25.x = 0
				var_141_19.localEulerAngles = var_141_25
			end

			if arg_138_1.time_ >= var_141_20 + var_141_21 and arg_138_1.time_ < var_141_20 + var_141_21 + arg_141_0 then
				var_141_19.localPosition = Vector3.New(0, 100, 0)

				local var_141_26 = manager.ui.mainCamera.transform.position - var_141_19.position

				var_141_19.forward = Vector3.New(var_141_26.x, var_141_26.y, var_141_26.z)

				local var_141_27 = var_141_19.localEulerAngles

				var_141_27.z = 0
				var_141_27.x = 0
				var_141_19.localEulerAngles = var_141_27
			end

			local var_141_28 = arg_138_1.actors_["10001_tpose"].transform
			local var_141_29 = 0

			if var_141_29 < arg_138_1.time_ and arg_138_1.time_ <= var_141_29 + arg_141_0 then
				arg_138_1.var_.moveOldPos10001_tpose = var_141_28.localPosition

				local var_141_30 = GameObjectTools.GetOrAddComponent(var_141_28.gameObject, typeof(DynamicBoneHelper))

				if var_141_30 then
					var_141_30:EnableDynamicBone(false)
				end
			end

			local var_141_31 = 0.001

			if var_141_29 <= arg_138_1.time_ and arg_138_1.time_ < var_141_29 + var_141_31 then
				local var_141_32 = (arg_138_1.time_ - var_141_29) / var_141_31
				local var_141_33 = Vector3.New(0, -1.23, -5.8)

				var_141_28.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10001_tpose, var_141_33, var_141_32)

				local var_141_34 = manager.ui.mainCamera.transform.position - var_141_28.position

				var_141_28.forward = Vector3.New(var_141_34.x, var_141_34.y, var_141_34.z)

				local var_141_35 = var_141_28.localEulerAngles

				var_141_35.z = 0
				var_141_35.x = 0
				var_141_28.localEulerAngles = var_141_35
			end

			if arg_138_1.time_ >= var_141_29 + var_141_31 and arg_138_1.time_ < var_141_29 + var_141_31 + arg_141_0 then
				var_141_28.localPosition = Vector3.New(0, -1.23, -5.8)

				local var_141_36 = manager.ui.mainCamera.transform.position - var_141_28.position

				var_141_28.forward = Vector3.New(var_141_36.x, var_141_36.y, var_141_36.z)

				local var_141_37 = var_141_28.localEulerAngles

				var_141_37.z = 0
				var_141_37.x = 0
				var_141_28.localEulerAngles = var_141_37

				local var_141_38 = GameObjectTools.GetOrAddComponent(var_141_28.gameObject, typeof(DynamicBoneHelper))

				if var_141_38 then
					var_141_38:EnableDynamicBone(true)
				end
			end

			local var_141_39 = 0

			if var_141_39 < arg_138_1.time_ and arg_138_1.time_ <= var_141_39 + arg_141_0 then
				arg_138_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			local var_141_40 = 0

			if var_141_40 < arg_138_1.time_ and arg_138_1.time_ <= var_141_40 + arg_141_0 then
				arg_138_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_141_41 = 0
			local var_141_42 = 0.925

			if var_141_41 < arg_138_1.time_ and arg_138_1.time_ <= var_141_41 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_43 = arg_138_1:FormatText(StoryNameCfg[31].name)

				arg_138_1.leftNameTxt_.text = var_141_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_44 = arg_138_1:GetWordFromCfg(104042034)
				local var_141_45 = arg_138_1:FormatText(var_141_44.content)

				arg_138_1.text_.text = var_141_45

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_46 = 37
				local var_141_47 = utf8.len(var_141_45)
				local var_141_48 = var_141_46 <= 0 and var_141_42 or var_141_42 * (var_141_47 / var_141_46)

				if var_141_48 > 0 and var_141_42 < var_141_48 then
					arg_138_1.talkMaxDuration = var_141_48

					if var_141_48 + var_141_41 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_48 + var_141_41
					end
				end

				arg_138_1.text_.text = var_141_45
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042034", "story_v_out_104042.awb") ~= 0 then
					local var_141_49 = manager.audio:GetVoiceLength("story_v_out_104042", "104042034", "story_v_out_104042.awb") / 1000

					if var_141_49 + var_141_41 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_49 + var_141_41
					end

					if var_141_44.prefab_name ~= "" and arg_138_1.actors_[var_141_44.prefab_name] ~= nil then
						local var_141_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_44.prefab_name].transform, "story_v_out_104042", "104042034", "story_v_out_104042.awb")

						arg_138_1:RecordAudio("104042034", var_141_50)
						arg_138_1:RecordAudio("104042034", var_141_50)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_104042", "104042034", "story_v_out_104042.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_104042", "104042034", "story_v_out_104042.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_51 = math.max(var_141_42, arg_138_1.talkMaxDuration)

			if var_141_41 <= arg_138_1.time_ and arg_138_1.time_ < var_141_41 + var_141_51 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_41) / var_141_51

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_41 + var_141_51 and arg_138_1.time_ < var_141_41 + var_141_51 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play104042035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 104042035
		arg_142_1.duration_ = 2.63

		local var_142_0 = {
			ja = 2.633,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_142_0:Play104042036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1019ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1019ui_story == nil then
				arg_142_1.var_.characterEffect1019ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.1

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1019ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1019ui_story then
				arg_142_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_145_4 = arg_142_1.actors_["10001_tpose"]
			local var_145_5 = 0

			if var_145_5 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 and not isNil(var_145_4) and arg_142_1.var_.characterEffect10001_tpose == nil then
				arg_142_1.var_.characterEffect10001_tpose = var_145_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_6 = 0.1

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_6 and not isNil(var_145_4) then
				local var_145_7 = (arg_142_1.time_ - var_145_5) / var_145_6

				if arg_142_1.var_.characterEffect10001_tpose and not isNil(var_145_4) then
					local var_145_8 = Mathf.Lerp(0, 0.5, var_145_7)

					arg_142_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_142_1.var_.characterEffect10001_tpose.fillRatio = var_145_8
				end
			end

			if arg_142_1.time_ >= var_145_5 + var_145_6 and arg_142_1.time_ < var_145_5 + var_145_6 + arg_145_0 and not isNil(var_145_4) and arg_142_1.var_.characterEffect10001_tpose then
				local var_145_9 = 0.5

				arg_142_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_142_1.var_.characterEffect10001_tpose.fillRatio = var_145_9
			end

			local var_145_10 = arg_142_1.actors_["10001_tpose"].transform
			local var_145_11 = 0

			if var_145_11 < arg_142_1.time_ and arg_142_1.time_ <= var_145_11 + arg_145_0 then
				arg_142_1.var_.moveOldPos10001_tpose = var_145_10.localPosition

				local var_145_12 = GameObjectTools.GetOrAddComponent(var_145_10.gameObject, typeof(DynamicBoneHelper))

				if var_145_12 then
					var_145_12:EnableDynamicBone(false)
				end
			end

			local var_145_13 = 0.001

			if var_145_11 <= arg_142_1.time_ and arg_142_1.time_ < var_145_11 + var_145_13 then
				local var_145_14 = (arg_142_1.time_ - var_145_11) / var_145_13
				local var_145_15 = Vector3.New(0, 100, 0)

				var_145_10.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10001_tpose, var_145_15, var_145_14)

				local var_145_16 = manager.ui.mainCamera.transform.position - var_145_10.position

				var_145_10.forward = Vector3.New(var_145_16.x, var_145_16.y, var_145_16.z)

				local var_145_17 = var_145_10.localEulerAngles

				var_145_17.z = 0
				var_145_17.x = 0
				var_145_10.localEulerAngles = var_145_17
			end

			if arg_142_1.time_ >= var_145_11 + var_145_13 and arg_142_1.time_ < var_145_11 + var_145_13 + arg_145_0 then
				var_145_10.localPosition = Vector3.New(0, 100, 0)

				local var_145_18 = manager.ui.mainCamera.transform.position - var_145_10.position

				var_145_10.forward = Vector3.New(var_145_18.x, var_145_18.y, var_145_18.z)

				local var_145_19 = var_145_10.localEulerAngles

				var_145_19.z = 0
				var_145_19.x = 0
				var_145_10.localEulerAngles = var_145_19

				local var_145_20 = GameObjectTools.GetOrAddComponent(var_145_10.gameObject, typeof(DynamicBoneHelper))

				if var_145_20 then
					var_145_20:EnableDynamicBone(true)
				end
			end

			local var_145_21 = arg_142_1.actors_["1019ui_story"].transform
			local var_145_22 = 0

			if var_145_22 < arg_142_1.time_ and arg_142_1.time_ <= var_145_22 + arg_145_0 then
				arg_142_1.var_.moveOldPos1019ui_story = var_145_21.localPosition
			end

			local var_145_23 = 0.001

			if var_145_22 <= arg_142_1.time_ and arg_142_1.time_ < var_145_22 + var_145_23 then
				local var_145_24 = (arg_142_1.time_ - var_145_22) / var_145_23
				local var_145_25 = Vector3.New(-0.7, -1.08, -5.9)

				var_145_21.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1019ui_story, var_145_25, var_145_24)

				local var_145_26 = manager.ui.mainCamera.transform.position - var_145_21.position

				var_145_21.forward = Vector3.New(var_145_26.x, var_145_26.y, var_145_26.z)

				local var_145_27 = var_145_21.localEulerAngles

				var_145_27.z = 0
				var_145_27.x = 0
				var_145_21.localEulerAngles = var_145_27
			end

			if arg_142_1.time_ >= var_145_22 + var_145_23 and arg_142_1.time_ < var_145_22 + var_145_23 + arg_145_0 then
				var_145_21.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_145_28 = manager.ui.mainCamera.transform.position - var_145_21.position

				var_145_21.forward = Vector3.New(var_145_28.x, var_145_28.y, var_145_28.z)

				local var_145_29 = var_145_21.localEulerAngles

				var_145_29.z = 0
				var_145_29.x = 0
				var_145_21.localEulerAngles = var_145_29
			end

			local var_145_30 = 0

			if var_145_30 < arg_142_1.time_ and arg_142_1.time_ <= var_145_30 + arg_145_0 then
				arg_142_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_145_31 = 0

			if var_145_31 < arg_142_1.time_ and arg_142_1.time_ <= var_145_31 + arg_145_0 then
				arg_142_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_145_32 = 0
			local var_145_33 = 0.125

			if var_145_32 < arg_142_1.time_ and arg_142_1.time_ <= var_145_32 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_34 = arg_142_1:FormatText(StoryNameCfg[13].name)

				arg_142_1.leftNameTxt_.text = var_145_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_35 = arg_142_1:GetWordFromCfg(104042035)
				local var_145_36 = arg_142_1:FormatText(var_145_35.content)

				arg_142_1.text_.text = var_145_36

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_37 = 5
				local var_145_38 = utf8.len(var_145_36)
				local var_145_39 = var_145_37 <= 0 and var_145_33 or var_145_33 * (var_145_38 / var_145_37)

				if var_145_39 > 0 and var_145_33 < var_145_39 then
					arg_142_1.talkMaxDuration = var_145_39

					if var_145_39 + var_145_32 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_39 + var_145_32
					end
				end

				arg_142_1.text_.text = var_145_36
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042035", "story_v_out_104042.awb") ~= 0 then
					local var_145_40 = manager.audio:GetVoiceLength("story_v_out_104042", "104042035", "story_v_out_104042.awb") / 1000

					if var_145_40 + var_145_32 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_40 + var_145_32
					end

					if var_145_35.prefab_name ~= "" and arg_142_1.actors_[var_145_35.prefab_name] ~= nil then
						local var_145_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_35.prefab_name].transform, "story_v_out_104042", "104042035", "story_v_out_104042.awb")

						arg_142_1:RecordAudio("104042035", var_145_41)
						arg_142_1:RecordAudio("104042035", var_145_41)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_104042", "104042035", "story_v_out_104042.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_104042", "104042035", "story_v_out_104042.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_42 = math.max(var_145_33, arg_142_1.talkMaxDuration)

			if var_145_32 <= arg_142_1.time_ and arg_142_1.time_ < var_145_32 + var_145_42 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_32) / var_145_42

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_32 + var_145_42 and arg_142_1.time_ < var_145_32 + var_145_42 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play104042036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 104042036
		arg_146_1.duration_ = 5.43

		local var_146_0 = {
			ja = 5.433,
			ko = 4.366,
			zh = 4.4,
			en = 4.233
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
				arg_146_0:Play104042037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1084ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1084ui_story == nil then
				arg_146_1.var_.characterEffect1084ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.1

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1084ui_story and not isNil(var_149_0) then
					arg_146_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1084ui_story then
				arg_146_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_149_4 = arg_146_1.actors_["1019ui_story"]
			local var_149_5 = 0

			if var_149_5 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 and not isNil(var_149_4) and arg_146_1.var_.characterEffect1019ui_story == nil then
				arg_146_1.var_.characterEffect1019ui_story = var_149_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_6 = 0.1

			if var_149_5 <= arg_146_1.time_ and arg_146_1.time_ < var_149_5 + var_149_6 and not isNil(var_149_4) then
				local var_149_7 = (arg_146_1.time_ - var_149_5) / var_149_6

				if arg_146_1.var_.characterEffect1019ui_story and not isNil(var_149_4) then
					local var_149_8 = Mathf.Lerp(0, 0.5, var_149_7)

					arg_146_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1019ui_story.fillRatio = var_149_8
				end
			end

			if arg_146_1.time_ >= var_149_5 + var_149_6 and arg_146_1.time_ < var_149_5 + var_149_6 + arg_149_0 and not isNil(var_149_4) and arg_146_1.var_.characterEffect1019ui_story then
				local var_149_9 = 0.5

				arg_146_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1019ui_story.fillRatio = var_149_9
			end

			local var_149_10 = arg_146_1.actors_["1084ui_story"].transform
			local var_149_11 = 0

			if var_149_11 < arg_146_1.time_ and arg_146_1.time_ <= var_149_11 + arg_149_0 then
				arg_146_1.var_.moveOldPos1084ui_story = var_149_10.localPosition
			end

			local var_149_12 = 0.001

			if var_149_11 <= arg_146_1.time_ and arg_146_1.time_ < var_149_11 + var_149_12 then
				local var_149_13 = (arg_146_1.time_ - var_149_11) / var_149_12
				local var_149_14 = Vector3.New(0.7, -0.97, -6)

				var_149_10.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1084ui_story, var_149_14, var_149_13)

				local var_149_15 = manager.ui.mainCamera.transform.position - var_149_10.position

				var_149_10.forward = Vector3.New(var_149_15.x, var_149_15.y, var_149_15.z)

				local var_149_16 = var_149_10.localEulerAngles

				var_149_16.z = 0
				var_149_16.x = 0
				var_149_10.localEulerAngles = var_149_16
			end

			if arg_146_1.time_ >= var_149_11 + var_149_12 and arg_146_1.time_ < var_149_11 + var_149_12 + arg_149_0 then
				var_149_10.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_149_17 = manager.ui.mainCamera.transform.position - var_149_10.position

				var_149_10.forward = Vector3.New(var_149_17.x, var_149_17.y, var_149_17.z)

				local var_149_18 = var_149_10.localEulerAngles

				var_149_18.z = 0
				var_149_18.x = 0
				var_149_10.localEulerAngles = var_149_18
			end

			local var_149_19 = 0

			if var_149_19 < arg_146_1.time_ and arg_146_1.time_ <= var_149_19 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_149_20 = 0

			if var_149_20 < arg_146_1.time_ and arg_146_1.time_ <= var_149_20 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_149_21 = 0
			local var_149_22 = 0.475

			if var_149_21 < arg_146_1.time_ and arg_146_1.time_ <= var_149_21 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_23 = arg_146_1:FormatText(StoryNameCfg[6].name)

				arg_146_1.leftNameTxt_.text = var_149_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_24 = arg_146_1:GetWordFromCfg(104042036)
				local var_149_25 = arg_146_1:FormatText(var_149_24.content)

				arg_146_1.text_.text = var_149_25

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_26 = 19
				local var_149_27 = utf8.len(var_149_25)
				local var_149_28 = var_149_26 <= 0 and var_149_22 or var_149_22 * (var_149_27 / var_149_26)

				if var_149_28 > 0 and var_149_22 < var_149_28 then
					arg_146_1.talkMaxDuration = var_149_28

					if var_149_28 + var_149_21 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_28 + var_149_21
					end
				end

				arg_146_1.text_.text = var_149_25
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042036", "story_v_out_104042.awb") ~= 0 then
					local var_149_29 = manager.audio:GetVoiceLength("story_v_out_104042", "104042036", "story_v_out_104042.awb") / 1000

					if var_149_29 + var_149_21 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_29 + var_149_21
					end

					if var_149_24.prefab_name ~= "" and arg_146_1.actors_[var_149_24.prefab_name] ~= nil then
						local var_149_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_24.prefab_name].transform, "story_v_out_104042", "104042036", "story_v_out_104042.awb")

						arg_146_1:RecordAudio("104042036", var_149_30)
						arg_146_1:RecordAudio("104042036", var_149_30)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_104042", "104042036", "story_v_out_104042.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_104042", "104042036", "story_v_out_104042.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_31 = math.max(var_149_22, arg_146_1.talkMaxDuration)

			if var_149_21 <= arg_146_1.time_ and arg_146_1.time_ < var_149_21 + var_149_31 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_21) / var_149_31

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_21 + var_149_31 and arg_146_1.time_ < var_149_21 + var_149_31 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play104042037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 104042037
		arg_150_1.duration_ = 4.4

		local var_150_0 = {
			ja = 4.4,
			ko = 3.033,
			zh = 3.8,
			en = 3.866
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play104042038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["10001_tpose"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect10001_tpose == nil then
				arg_150_1.var_.characterEffect10001_tpose = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.1

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect10001_tpose and not isNil(var_153_0) then
					arg_150_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect10001_tpose then
				arg_150_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_153_4 = arg_150_1.actors_["1084ui_story"]
			local var_153_5 = 0

			if var_153_5 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect1084ui_story == nil then
				arg_150_1.var_.characterEffect1084ui_story = var_153_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_6 = 0.1

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_6 and not isNil(var_153_4) then
				local var_153_7 = (arg_150_1.time_ - var_153_5) / var_153_6

				if arg_150_1.var_.characterEffect1084ui_story and not isNil(var_153_4) then
					local var_153_8 = Mathf.Lerp(0, 0.5, var_153_7)

					arg_150_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1084ui_story.fillRatio = var_153_8
				end
			end

			if arg_150_1.time_ >= var_153_5 + var_153_6 and arg_150_1.time_ < var_153_5 + var_153_6 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect1084ui_story then
				local var_153_9 = 0.5

				arg_150_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1084ui_story.fillRatio = var_153_9
			end

			local var_153_10 = arg_150_1.actors_["1084ui_story"].transform
			local var_153_11 = 0

			if var_153_11 < arg_150_1.time_ and arg_150_1.time_ <= var_153_11 + arg_153_0 then
				arg_150_1.var_.moveOldPos1084ui_story = var_153_10.localPosition
			end

			local var_153_12 = 0.001

			if var_153_11 <= arg_150_1.time_ and arg_150_1.time_ < var_153_11 + var_153_12 then
				local var_153_13 = (arg_150_1.time_ - var_153_11) / var_153_12
				local var_153_14 = Vector3.New(0, 100, 0)

				var_153_10.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1084ui_story, var_153_14, var_153_13)

				local var_153_15 = manager.ui.mainCamera.transform.position - var_153_10.position

				var_153_10.forward = Vector3.New(var_153_15.x, var_153_15.y, var_153_15.z)

				local var_153_16 = var_153_10.localEulerAngles

				var_153_16.z = 0
				var_153_16.x = 0
				var_153_10.localEulerAngles = var_153_16
			end

			if arg_150_1.time_ >= var_153_11 + var_153_12 and arg_150_1.time_ < var_153_11 + var_153_12 + arg_153_0 then
				var_153_10.localPosition = Vector3.New(0, 100, 0)

				local var_153_17 = manager.ui.mainCamera.transform.position - var_153_10.position

				var_153_10.forward = Vector3.New(var_153_17.x, var_153_17.y, var_153_17.z)

				local var_153_18 = var_153_10.localEulerAngles

				var_153_18.z = 0
				var_153_18.x = 0
				var_153_10.localEulerAngles = var_153_18
			end

			local var_153_19 = arg_150_1.actors_["1019ui_story"].transform
			local var_153_20 = 0

			if var_153_20 < arg_150_1.time_ and arg_150_1.time_ <= var_153_20 + arg_153_0 then
				arg_150_1.var_.moveOldPos1019ui_story = var_153_19.localPosition
			end

			local var_153_21 = 0.001

			if var_153_20 <= arg_150_1.time_ and arg_150_1.time_ < var_153_20 + var_153_21 then
				local var_153_22 = (arg_150_1.time_ - var_153_20) / var_153_21
				local var_153_23 = Vector3.New(0, 100, 0)

				var_153_19.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1019ui_story, var_153_23, var_153_22)

				local var_153_24 = manager.ui.mainCamera.transform.position - var_153_19.position

				var_153_19.forward = Vector3.New(var_153_24.x, var_153_24.y, var_153_24.z)

				local var_153_25 = var_153_19.localEulerAngles

				var_153_25.z = 0
				var_153_25.x = 0
				var_153_19.localEulerAngles = var_153_25
			end

			if arg_150_1.time_ >= var_153_20 + var_153_21 and arg_150_1.time_ < var_153_20 + var_153_21 + arg_153_0 then
				var_153_19.localPosition = Vector3.New(0, 100, 0)

				local var_153_26 = manager.ui.mainCamera.transform.position - var_153_19.position

				var_153_19.forward = Vector3.New(var_153_26.x, var_153_26.y, var_153_26.z)

				local var_153_27 = var_153_19.localEulerAngles

				var_153_27.z = 0
				var_153_27.x = 0
				var_153_19.localEulerAngles = var_153_27
			end

			local var_153_28 = arg_150_1.actors_["10001_tpose"].transform
			local var_153_29 = 0

			if var_153_29 < arg_150_1.time_ and arg_150_1.time_ <= var_153_29 + arg_153_0 then
				arg_150_1.var_.moveOldPos10001_tpose = var_153_28.localPosition

				local var_153_30 = GameObjectTools.GetOrAddComponent(var_153_28.gameObject, typeof(DynamicBoneHelper))

				if var_153_30 then
					var_153_30:EnableDynamicBone(false)
				end
			end

			local var_153_31 = 0.001

			if var_153_29 <= arg_150_1.time_ and arg_150_1.time_ < var_153_29 + var_153_31 then
				local var_153_32 = (arg_150_1.time_ - var_153_29) / var_153_31
				local var_153_33 = Vector3.New(0, -1.23, -5.8)

				var_153_28.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10001_tpose, var_153_33, var_153_32)

				local var_153_34 = manager.ui.mainCamera.transform.position - var_153_28.position

				var_153_28.forward = Vector3.New(var_153_34.x, var_153_34.y, var_153_34.z)

				local var_153_35 = var_153_28.localEulerAngles

				var_153_35.z = 0
				var_153_35.x = 0
				var_153_28.localEulerAngles = var_153_35
			end

			if arg_150_1.time_ >= var_153_29 + var_153_31 and arg_150_1.time_ < var_153_29 + var_153_31 + arg_153_0 then
				var_153_28.localPosition = Vector3.New(0, -1.23, -5.8)

				local var_153_36 = manager.ui.mainCamera.transform.position - var_153_28.position

				var_153_28.forward = Vector3.New(var_153_36.x, var_153_36.y, var_153_36.z)

				local var_153_37 = var_153_28.localEulerAngles

				var_153_37.z = 0
				var_153_37.x = 0
				var_153_28.localEulerAngles = var_153_37

				local var_153_38 = GameObjectTools.GetOrAddComponent(var_153_28.gameObject, typeof(DynamicBoneHelper))

				if var_153_38 then
					var_153_38:EnableDynamicBone(true)
				end
			end

			local var_153_39 = 0

			if var_153_39 < arg_150_1.time_ and arg_150_1.time_ <= var_153_39 + arg_153_0 then
				arg_150_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action3_1")
			end

			local var_153_40 = 0

			if var_153_40 < arg_150_1.time_ and arg_150_1.time_ <= var_153_40 + arg_153_0 then
				arg_150_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_153_41 = 0
			local var_153_42 = 0.35

			if var_153_41 < arg_150_1.time_ and arg_150_1.time_ <= var_153_41 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_43 = arg_150_1:FormatText(StoryNameCfg[31].name)

				arg_150_1.leftNameTxt_.text = var_153_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_44 = arg_150_1:GetWordFromCfg(104042037)
				local var_153_45 = arg_150_1:FormatText(var_153_44.content)

				arg_150_1.text_.text = var_153_45

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_46 = 14
				local var_153_47 = utf8.len(var_153_45)
				local var_153_48 = var_153_46 <= 0 and var_153_42 or var_153_42 * (var_153_47 / var_153_46)

				if var_153_48 > 0 and var_153_42 < var_153_48 then
					arg_150_1.talkMaxDuration = var_153_48

					if var_153_48 + var_153_41 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_48 + var_153_41
					end
				end

				arg_150_1.text_.text = var_153_45
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042037", "story_v_out_104042.awb") ~= 0 then
					local var_153_49 = manager.audio:GetVoiceLength("story_v_out_104042", "104042037", "story_v_out_104042.awb") / 1000

					if var_153_49 + var_153_41 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_49 + var_153_41
					end

					if var_153_44.prefab_name ~= "" and arg_150_1.actors_[var_153_44.prefab_name] ~= nil then
						local var_153_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_44.prefab_name].transform, "story_v_out_104042", "104042037", "story_v_out_104042.awb")

						arg_150_1:RecordAudio("104042037", var_153_50)
						arg_150_1:RecordAudio("104042037", var_153_50)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_104042", "104042037", "story_v_out_104042.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_104042", "104042037", "story_v_out_104042.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_51 = math.max(var_153_42, arg_150_1.talkMaxDuration)

			if var_153_41 <= arg_150_1.time_ and arg_150_1.time_ < var_153_41 + var_153_51 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_41) / var_153_51

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_41 + var_153_51 and arg_150_1.time_ < var_153_41 + var_153_51 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play104042038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 104042038
		arg_154_1.duration_ = 7.97

		local var_154_0 = {
			ja = 7.966,
			ko = 3.3,
			zh = 4.033,
			en = 4.766
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
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play104042039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = "1011ui_story"

			if arg_154_1.actors_[var_157_0] == nil then
				local var_157_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_157_1) then
					local var_157_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_154_1.stage_.transform)

					var_157_2.name = var_157_0
					var_157_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_154_1.actors_[var_157_0] = var_157_2

					local var_157_3 = var_157_2:GetComponentInChildren(typeof(CharacterEffect))

					var_157_3.enabled = true

					local var_157_4 = GameObjectTools.GetOrAddComponent(var_157_2, typeof(DynamicBoneHelper))

					if var_157_4 then
						var_157_4:EnableDynamicBone(false)
					end

					arg_154_1:ShowWeapon(var_157_3.transform, false)

					arg_154_1.var_[var_157_0 .. "Animator"] = var_157_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_154_1.var_[var_157_0 .. "Animator"].applyRootMotion = true
					arg_154_1.var_[var_157_0 .. "LipSync"] = var_157_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_157_5 = arg_154_1.actors_["1011ui_story"]
			local var_157_6 = 0

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 and not isNil(var_157_5) and arg_154_1.var_.characterEffect1011ui_story == nil then
				arg_154_1.var_.characterEffect1011ui_story = var_157_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_7 = 0.1

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_7 and not isNil(var_157_5) then
				local var_157_8 = (arg_154_1.time_ - var_157_6) / var_157_7

				if arg_154_1.var_.characterEffect1011ui_story and not isNil(var_157_5) then
					arg_154_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_6 + var_157_7 and arg_154_1.time_ < var_157_6 + var_157_7 + arg_157_0 and not isNil(var_157_5) and arg_154_1.var_.characterEffect1011ui_story then
				arg_154_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_157_9 = arg_154_1.actors_["10001_tpose"]
			local var_157_10 = 0

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect10001_tpose == nil then
				arg_154_1.var_.characterEffect10001_tpose = var_157_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_11 = 0.1

			if var_157_10 <= arg_154_1.time_ and arg_154_1.time_ < var_157_10 + var_157_11 and not isNil(var_157_9) then
				local var_157_12 = (arg_154_1.time_ - var_157_10) / var_157_11

				if arg_154_1.var_.characterEffect10001_tpose and not isNil(var_157_9) then
					local var_157_13 = Mathf.Lerp(0, 0.5, var_157_12)

					arg_154_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_154_1.var_.characterEffect10001_tpose.fillRatio = var_157_13
				end
			end

			if arg_154_1.time_ >= var_157_10 + var_157_11 and arg_154_1.time_ < var_157_10 + var_157_11 + arg_157_0 and not isNil(var_157_9) and arg_154_1.var_.characterEffect10001_tpose then
				local var_157_14 = 0.5

				arg_154_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_154_1.var_.characterEffect10001_tpose.fillRatio = var_157_14
			end

			local var_157_15 = arg_154_1.actors_["10001_tpose"].transform
			local var_157_16 = 0

			if var_157_16 < arg_154_1.time_ and arg_154_1.time_ <= var_157_16 + arg_157_0 then
				arg_154_1.var_.moveOldPos10001_tpose = var_157_15.localPosition

				local var_157_17 = GameObjectTools.GetOrAddComponent(var_157_15.gameObject, typeof(DynamicBoneHelper))

				if var_157_17 then
					var_157_17:EnableDynamicBone(false)
				end
			end

			local var_157_18 = 0.001

			if var_157_16 <= arg_154_1.time_ and arg_154_1.time_ < var_157_16 + var_157_18 then
				local var_157_19 = (arg_154_1.time_ - var_157_16) / var_157_18
				local var_157_20 = Vector3.New(0, 100, 0)

				var_157_15.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10001_tpose, var_157_20, var_157_19)

				local var_157_21 = manager.ui.mainCamera.transform.position - var_157_15.position

				var_157_15.forward = Vector3.New(var_157_21.x, var_157_21.y, var_157_21.z)

				local var_157_22 = var_157_15.localEulerAngles

				var_157_22.z = 0
				var_157_22.x = 0
				var_157_15.localEulerAngles = var_157_22
			end

			if arg_154_1.time_ >= var_157_16 + var_157_18 and arg_154_1.time_ < var_157_16 + var_157_18 + arg_157_0 then
				var_157_15.localPosition = Vector3.New(0, 100, 0)

				local var_157_23 = manager.ui.mainCamera.transform.position - var_157_15.position

				var_157_15.forward = Vector3.New(var_157_23.x, var_157_23.y, var_157_23.z)

				local var_157_24 = var_157_15.localEulerAngles

				var_157_24.z = 0
				var_157_24.x = 0
				var_157_15.localEulerAngles = var_157_24

				local var_157_25 = GameObjectTools.GetOrAddComponent(var_157_15.gameObject, typeof(DynamicBoneHelper))

				if var_157_25 then
					var_157_25:EnableDynamicBone(true)
				end
			end

			local var_157_26 = arg_154_1.actors_["1011ui_story"].transform
			local var_157_27 = 0

			if var_157_27 < arg_154_1.time_ and arg_154_1.time_ <= var_157_27 + arg_157_0 then
				arg_154_1.var_.moveOldPos1011ui_story = var_157_26.localPosition
			end

			local var_157_28 = 0.001

			if var_157_27 <= arg_154_1.time_ and arg_154_1.time_ < var_157_27 + var_157_28 then
				local var_157_29 = (arg_154_1.time_ - var_157_27) / var_157_28
				local var_157_30 = Vector3.New(-0.7, -0.71, -6)

				var_157_26.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1011ui_story, var_157_30, var_157_29)

				local var_157_31 = manager.ui.mainCamera.transform.position - var_157_26.position

				var_157_26.forward = Vector3.New(var_157_31.x, var_157_31.y, var_157_31.z)

				local var_157_32 = var_157_26.localEulerAngles

				var_157_32.z = 0
				var_157_32.x = 0
				var_157_26.localEulerAngles = var_157_32
			end

			if arg_154_1.time_ >= var_157_27 + var_157_28 and arg_154_1.time_ < var_157_27 + var_157_28 + arg_157_0 then
				var_157_26.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_157_33 = manager.ui.mainCamera.transform.position - var_157_26.position

				var_157_26.forward = Vector3.New(var_157_33.x, var_157_33.y, var_157_33.z)

				local var_157_34 = var_157_26.localEulerAngles

				var_157_34.z = 0
				var_157_34.x = 0
				var_157_26.localEulerAngles = var_157_34
			end

			local var_157_35 = 0

			if var_157_35 < arg_154_1.time_ and arg_154_1.time_ <= var_157_35 + arg_157_0 then
				arg_154_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_157_36 = 0

			if var_157_36 < arg_154_1.time_ and arg_154_1.time_ <= var_157_36 + arg_157_0 then
				arg_154_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_157_37 = 0
			local var_157_38 = 0.4

			if var_157_37 < arg_154_1.time_ and arg_154_1.time_ <= var_157_37 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_39 = arg_154_1:FormatText(StoryNameCfg[37].name)

				arg_154_1.leftNameTxt_.text = var_157_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_40 = arg_154_1:GetWordFromCfg(104042038)
				local var_157_41 = arg_154_1:FormatText(var_157_40.content)

				arg_154_1.text_.text = var_157_41

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_42 = 16
				local var_157_43 = utf8.len(var_157_41)
				local var_157_44 = var_157_42 <= 0 and var_157_38 or var_157_38 * (var_157_43 / var_157_42)

				if var_157_44 > 0 and var_157_38 < var_157_44 then
					arg_154_1.talkMaxDuration = var_157_44

					if var_157_44 + var_157_37 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_44 + var_157_37
					end
				end

				arg_154_1.text_.text = var_157_41
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042038", "story_v_out_104042.awb") ~= 0 then
					local var_157_45 = manager.audio:GetVoiceLength("story_v_out_104042", "104042038", "story_v_out_104042.awb") / 1000

					if var_157_45 + var_157_37 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_45 + var_157_37
					end

					if var_157_40.prefab_name ~= "" and arg_154_1.actors_[var_157_40.prefab_name] ~= nil then
						local var_157_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_40.prefab_name].transform, "story_v_out_104042", "104042038", "story_v_out_104042.awb")

						arg_154_1:RecordAudio("104042038", var_157_46)
						arg_154_1:RecordAudio("104042038", var_157_46)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_104042", "104042038", "story_v_out_104042.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_104042", "104042038", "story_v_out_104042.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_47 = math.max(var_157_38, arg_154_1.talkMaxDuration)

			if var_157_37 <= arg_154_1.time_ and arg_154_1.time_ < var_157_37 + var_157_47 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_37) / var_157_47

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_37 + var_157_47 and arg_154_1.time_ < var_157_37 + var_157_47 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play104042039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 104042039
		arg_158_1.duration_ = 5.97

		local var_158_0 = {
			ja = 5.966,
			ko = 3.866,
			zh = 4.4,
			en = 4.666
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play104042040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1084ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1084ui_story == nil then
				arg_158_1.var_.characterEffect1084ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.1

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect1084ui_story and not isNil(var_161_0) then
					arg_158_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1084ui_story then
				arg_158_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_161_4 = arg_158_1.actors_["1011ui_story"]
			local var_161_5 = 0

			if var_161_5 < arg_158_1.time_ and arg_158_1.time_ <= var_161_5 + arg_161_0 and not isNil(var_161_4) and arg_158_1.var_.characterEffect1011ui_story == nil then
				arg_158_1.var_.characterEffect1011ui_story = var_161_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_6 = 0.1

			if var_161_5 <= arg_158_1.time_ and arg_158_1.time_ < var_161_5 + var_161_6 and not isNil(var_161_4) then
				local var_161_7 = (arg_158_1.time_ - var_161_5) / var_161_6

				if arg_158_1.var_.characterEffect1011ui_story and not isNil(var_161_4) then
					local var_161_8 = Mathf.Lerp(0, 0.5, var_161_7)

					arg_158_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1011ui_story.fillRatio = var_161_8
				end
			end

			if arg_158_1.time_ >= var_161_5 + var_161_6 and arg_158_1.time_ < var_161_5 + var_161_6 + arg_161_0 and not isNil(var_161_4) and arg_158_1.var_.characterEffect1011ui_story then
				local var_161_9 = 0.5

				arg_158_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1011ui_story.fillRatio = var_161_9
			end

			local var_161_10 = arg_158_1.actors_["1084ui_story"].transform
			local var_161_11 = 0

			if var_161_11 < arg_158_1.time_ and arg_158_1.time_ <= var_161_11 + arg_161_0 then
				arg_158_1.var_.moveOldPos1084ui_story = var_161_10.localPosition
			end

			local var_161_12 = 0.001

			if var_161_11 <= arg_158_1.time_ and arg_158_1.time_ < var_161_11 + var_161_12 then
				local var_161_13 = (arg_158_1.time_ - var_161_11) / var_161_12
				local var_161_14 = Vector3.New(0.7, -0.97, -6)

				var_161_10.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1084ui_story, var_161_14, var_161_13)

				local var_161_15 = manager.ui.mainCamera.transform.position - var_161_10.position

				var_161_10.forward = Vector3.New(var_161_15.x, var_161_15.y, var_161_15.z)

				local var_161_16 = var_161_10.localEulerAngles

				var_161_16.z = 0
				var_161_16.x = 0
				var_161_10.localEulerAngles = var_161_16
			end

			if arg_158_1.time_ >= var_161_11 + var_161_12 and arg_158_1.time_ < var_161_11 + var_161_12 + arg_161_0 then
				var_161_10.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_161_17 = manager.ui.mainCamera.transform.position - var_161_10.position

				var_161_10.forward = Vector3.New(var_161_17.x, var_161_17.y, var_161_17.z)

				local var_161_18 = var_161_10.localEulerAngles

				var_161_18.z = 0
				var_161_18.x = 0
				var_161_10.localEulerAngles = var_161_18
			end

			local var_161_19 = 0

			if var_161_19 < arg_158_1.time_ and arg_158_1.time_ <= var_161_19 + arg_161_0 then
				arg_158_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_161_20 = 0

			if var_161_20 < arg_158_1.time_ and arg_158_1.time_ <= var_161_20 + arg_161_0 then
				arg_158_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_161_21 = 0
			local var_161_22 = 0.575

			if var_161_21 < arg_158_1.time_ and arg_158_1.time_ <= var_161_21 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_23 = arg_158_1:FormatText(StoryNameCfg[6].name)

				arg_158_1.leftNameTxt_.text = var_161_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_24 = arg_158_1:GetWordFromCfg(104042039)
				local var_161_25 = arg_158_1:FormatText(var_161_24.content)

				arg_158_1.text_.text = var_161_25

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_26 = 23
				local var_161_27 = utf8.len(var_161_25)
				local var_161_28 = var_161_26 <= 0 and var_161_22 or var_161_22 * (var_161_27 / var_161_26)

				if var_161_28 > 0 and var_161_22 < var_161_28 then
					arg_158_1.talkMaxDuration = var_161_28

					if var_161_28 + var_161_21 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_28 + var_161_21
					end
				end

				arg_158_1.text_.text = var_161_25
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042039", "story_v_out_104042.awb") ~= 0 then
					local var_161_29 = manager.audio:GetVoiceLength("story_v_out_104042", "104042039", "story_v_out_104042.awb") / 1000

					if var_161_29 + var_161_21 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_29 + var_161_21
					end

					if var_161_24.prefab_name ~= "" and arg_158_1.actors_[var_161_24.prefab_name] ~= nil then
						local var_161_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_24.prefab_name].transform, "story_v_out_104042", "104042039", "story_v_out_104042.awb")

						arg_158_1:RecordAudio("104042039", var_161_30)
						arg_158_1:RecordAudio("104042039", var_161_30)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_104042", "104042039", "story_v_out_104042.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_104042", "104042039", "story_v_out_104042.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_31 = math.max(var_161_22, arg_158_1.talkMaxDuration)

			if var_161_21 <= arg_158_1.time_ and arg_158_1.time_ < var_161_21 + var_161_31 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_21) / var_161_31

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_21 + var_161_31 and arg_158_1.time_ < var_161_21 + var_161_31 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play104042040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 104042040
		arg_162_1.duration_ = 11.23

		local var_162_0 = {
			ja = 11.233,
			ko = 5.666,
			zh = 7.233,
			en = 5.7
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
			arg_162_1.auto_ = false
		end

		function arg_162_1.playNext_(arg_164_0)
			arg_162_1.onStoryFinished_()
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1011ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1011ui_story == nil then
				arg_162_1.var_.characterEffect1011ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.1

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1011ui_story and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1011ui_story then
				arg_162_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_165_4 = arg_162_1.actors_["1084ui_story"]
			local var_165_5 = 0

			if var_165_5 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 and not isNil(var_165_4) and arg_162_1.var_.characterEffect1084ui_story == nil then
				arg_162_1.var_.characterEffect1084ui_story = var_165_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_6 = 0.1

			if var_165_5 <= arg_162_1.time_ and arg_162_1.time_ < var_165_5 + var_165_6 and not isNil(var_165_4) then
				local var_165_7 = (arg_162_1.time_ - var_165_5) / var_165_6

				if arg_162_1.var_.characterEffect1084ui_story and not isNil(var_165_4) then
					local var_165_8 = Mathf.Lerp(0, 0.5, var_165_7)

					arg_162_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1084ui_story.fillRatio = var_165_8
				end
			end

			if arg_162_1.time_ >= var_165_5 + var_165_6 and arg_162_1.time_ < var_165_5 + var_165_6 + arg_165_0 and not isNil(var_165_4) and arg_162_1.var_.characterEffect1084ui_story then
				local var_165_9 = 0.5

				arg_162_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1084ui_story.fillRatio = var_165_9
			end

			local var_165_10 = 0

			if var_165_10 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 then
				arg_162_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_165_11 = 0
			local var_165_12 = 0.55

			if var_165_11 < arg_162_1.time_ and arg_162_1.time_ <= var_165_11 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_13 = arg_162_1:FormatText(StoryNameCfg[37].name)

				arg_162_1.leftNameTxt_.text = var_165_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_14 = arg_162_1:GetWordFromCfg(104042040)
				local var_165_15 = arg_162_1:FormatText(var_165_14.content)

				arg_162_1.text_.text = var_165_15

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_16 = 22
				local var_165_17 = utf8.len(var_165_15)
				local var_165_18 = var_165_16 <= 0 and var_165_12 or var_165_12 * (var_165_17 / var_165_16)

				if var_165_18 > 0 and var_165_12 < var_165_18 then
					arg_162_1.talkMaxDuration = var_165_18

					if var_165_18 + var_165_11 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_18 + var_165_11
					end
				end

				arg_162_1.text_.text = var_165_15
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104042", "104042040", "story_v_out_104042.awb") ~= 0 then
					local var_165_19 = manager.audio:GetVoiceLength("story_v_out_104042", "104042040", "story_v_out_104042.awb") / 1000

					if var_165_19 + var_165_11 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_19 + var_165_11
					end

					if var_165_14.prefab_name ~= "" and arg_162_1.actors_[var_165_14.prefab_name] ~= nil then
						local var_165_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_14.prefab_name].transform, "story_v_out_104042", "104042040", "story_v_out_104042.awb")

						arg_162_1:RecordAudio("104042040", var_165_20)
						arg_162_1:RecordAudio("104042040", var_165_20)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_104042", "104042040", "story_v_out_104042.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_104042", "104042040", "story_v_out_104042.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_21 = math.max(var_165_12, arg_162_1.talkMaxDuration)

			if var_165_11 <= arg_162_1.time_ and arg_162_1.time_ < var_165_11 + var_165_21 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_11) / var_165_21

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_11 + var_165_21 and arg_162_1.time_ < var_165_11 + var_165_21 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0403",
		"TextureConfig/Background/B04b"
	},
	voices = {
		"story_v_out_104042.awb"
	}
}
